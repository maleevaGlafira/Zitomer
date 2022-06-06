unit fresult;

interface

{$I !map_define.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Grids, DBGrids, RXDBCtrl, StdCtrls, Buttons, Aligrid, Spin,
  ComCtrls, Menus, ExtCtrls, RXCtrls, frmLANG, cntsLANG, variants,
  OperAttFormUnit
  {$IFDEF MAP}
  ,ServiceFuncUnit,SendMessToAvarOnMap,_avonm_DMSpisOfAvarUnit,
  _avonm_DopFuncsUnit,DateUtils,AvarOnMapConst
  {$ENDIF};

const
    V_NONE=0;
    V_NCOL=0;
    V_NROW=0;



type
  prVibor = function (ID,Col:integer; var ss:string):integer;
  TFormResult = class(TFormLang)
    Qry_tmp: TQuery;
    Qry_ul1: TQuery;
    Qry_ul2: TQuery;
    PoM_Sort: TPopupMenu;
    Tm: TTimer;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    Label1: TLabel;
    SpEd_Font: TSpinEdit;
    StrGr_res: TStringAlignGrid;
    ChLB_Pol: TRxCheckListBox;
    Panel2: TPanel;
    BB_Graf: TBitBtn;
    BB_zav: TBitBtn;
    BB_Print: TBitBtn;
    BB_Excel: TBitBtn;
    BB_Close: TBitBtn;
    Lb_count: TLabel;
    Lb_Select: TLabel;
    BB_Clear: TBitBtn;
    StaticText1: TStaticText;
    PrBar: TProgressBar;
    TopLabel: TScrollBox;
    Lb_usl: TLabel;
    bbMap: TBitBtn;
    P_Wait: TPanel;
    An_Wait: TAnimate;
    Qry_DopAdres: TQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BB_ClearClick(Sender: TObject);
    procedure StrGr_resKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StrGr_resMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpEd_FontChange(Sender: TObject);
    procedure BB_CloseClick(Sender: TObject);
    procedure PoM_SortPopup(Sender: TObject);
    procedure TmTimer(Sender: TObject);
    procedure ChLB_PolClick(Sender: TObject);
    procedure BB_zavClick(Sender: TObject);
    procedure BB_PrintClick(Sender: TObject);
    procedure StrGr_resDblClick(Sender: TObject);
    procedure BB_ExcelClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Lb_ColsClick(Sender: TObject);
    procedure StatusBar1DrawPanel(StatusBar: TStatusBar;
      Panel: TStatusPanel; const Rect: TRect);
    procedure bbMapClick(Sender: TObject);
    procedure Qry_tmpCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    isEmpty: boolean;
    tutTitles,tutFields:TstringList;
    ResAlias,ResSQL:string;
    NumFields,TekInMas,tutAdr, tutnum:integer;
    isSort:boolean;
    isDoRecCount: boolean;
    isGroupSelect :boolean; // признак групповой выборки(группировка по заявкам и т.п.)
    isFillGrid :boolean; // признак заполнения StringGrid
    FShowProgress :boolean;
    {@@@@@@@@@@@@@@@ !!! MAP !!! @@@@@@@@@@@@@@@}
    {$IFDEF MAP}
    FMapIncrem:integer;
    FNotLockMapView:boolean;
    function AddField(_DataSet:TDataSet; const AFieldName:string;
      AFieldClass:TFieldClass; ASize:Word;  _Calculated:boolean=FALSE):TField;
    procedure AddMapViewField(_DataSet:TDataSet);
    procedure StartWait(_caption:string);
    procedure StopWait;
    procedure CalcTypeOfAvarField;
    procedure OnSnapShotIDAvarAndAddrFromDataSetEvent(Sender: TObject; _first:boolean; var _EOF:boolean;
      var _Attach:TAttach; var _num:integer; var _addr:string; var _year:integer);
    procedure OnReceivedSpisAvar(Sender:TObject);
    procedure OnAskWorkFields(Sender:TObject);
    procedure OnFindWorkFields(Sender:TObject; _Attach:TAttach; _nomer,_year:integer);
    function GetAddress:string;
    {$ENDIF}
    {/@}
    procedure SetShowProgress(fl :boolean);  
  public
    { Public declarations }
    exit_fl :boolean;
    XLApp: Variant;
    NumCols:integer;
    isIdView:boolean;
    nar:boolean;
    number:boolean;
    constructor ResCreate(AOwner: TComponent; _NotLockMapView:boolean;
          alName,fCaption,CapUsl,tSQL:string;nTitles:TStringList;
          Adr:integer;UserVibor:prVibor;Sort:boolean;
          {ds}GroupSelect :boolean=false; FillGrid :boolean=true; DoRecCount: boolean=true;n:boolean=false;
          Cols:integer=0;num:integer=-1);overload;
    constructor ResCreateEmpty(AOwner: TComponent);overload;
    function id2Adr(id_cod,id_ul1:integer;id_ul2:string; id_dopadres:integer =-1; id_rayon:integer=-1):string;
    procedure Upd_cols;
    procedure Save2HTML(fname:string);
    procedure UpdAll;
    procedure Translate;override;
    property ShowProgress :boolean read FShowProgress write SetShowProgress;
  end;


function tutVibor(ID,Col:integer; var ss:string):integer;

var
 // FormResult: TFormResult;
  ProcVibor:prVibor;

implementation
 uses strtool,zav,prosm,main,ComObj, XLConst,OpSqlex, avartype,spreadsh,
  datam, FormZavFactory;
{$R *.DFM}

{$IFDEF MAP}

function TFormResult.GetAddress:string;
begin
  {
  with Qry_Tmp do
    begin
      result:=trim(DM1.Gen_Addr(FieldByName('vidul').AsString,FieldByName('ul1').AsString,
                  FieldByName('ul2').AsString,FieldByName('kod_ul').AsString,''));
    end;
  }  
end;

procedure TFormResult.OnFindWorkFields(Sender:TObject; _Attach:TAttach; _nomer,_year:integer);
var _ok:boolean;
  _id_attach:integer;
begin
  if (MAP_IS_WORK and FNotLockMapView) then
    begin
      with Qry_Tmp do
        begin
          DisableControls;
          //
          if _Attach=tatKanal then _id_attach:=2 else _id_attach:=1; 
          if not((FieldByName('narjad_nom').AsInteger=_nomer) and
            (YearOf(FieldByName('year_soob').AsInteger)=_year)
            and (FieldByName('id_attach').AsInteger=_id_attach))
              then  _ok:=Qry_Tmp.Locate('id_attach;narjad_nom;year_soob',VarArrayOf([_id_attach,_nomer,_year]),[])
              else _ok:=true;
          if _ok then
            begin
                ManaGeAvarOnMap.SendAvarInfo(0,
                  //номер наряда
                  FieldByName('narjad_nom').AsInteger,
                  //дата и время наряда
                  FieldByName('data_soob').AsDateTime,
                  //район
                  trim(FieldByName('rayon').AsString),
                  //адрес
                  GetAddress(),
                  //характер повреждения
                  Trim(FieldByName('xar_povr').AsString),
                  //место повреждения
                  Trim(FieldByName('mesto_name').AsString),
                  //диаметр
                  FieldByName('diam_diam').AsInteger,
                  //дата окончания
                  FieldByName('data_end').AsDateTime,
                 {Scale}0,{CreateAvar}1,{OnlyScale}0,
                 ManaGeAvarOnMap.ConvertAttachToMAPAttach(FieldByName('attach').AsInteger-1),
                 {HideMainForm}0);
            end
              else
            begin
                ManaGeAvarOnMap.SendAvarInfo(0,
                  //номер наряда
                  0,
                  //дата и время наряда
                  0,
                  //район
                   '?',
                   //адрес
                   '?',
                   //характер повреждения
                   '?',
                   //место повреждения
                   '?',
                   //диаметр
                   0,
                   //дата окончания
                   0,
                 {Scale}0,{CreateAvar}1,{OnlyScale}0,
                 ManaGeAvarOnMap.ConvertAttachToMAPAttach(0),
                 {HideMainForm}0);
            end;                 
      end;
    end;
end;

procedure TFormResult.OnAskWorkFields(Sender:TObject);
begin
  if (MAP_IS_WORK and FNotLockMapView) then
    begin
       with Qry_Tmp do
        begin
          DM_GateSpisOfAvar.Nomer:=FieldByName('narjad_nom').AsInteger;
          DM_GateSpisOfAvar.Year:=YearOf(FieldByName('data_soob').AsDateTime);
          DM_GateSpisOfAvar.Dt_in:=FieldByName('data_soob').AsDateTime;
          DM_GateSpisOfAvar.Dt_out:=FieldByName('data_end').AsDateTime;
          DM_GateSpisOfAvar.Rayon:=trim(FieldByName('rayon').AsString);
          DM_GateSpisOfAvar.Address:=GetAddress();
          DM_GateSpisOfAvar.Xar_povr:=Trim(FieldByName('xar_povr').AsString);
          DM_GateSpisOfAvar.Mesto_povr:=Trim(FieldByName('mesto_name').AsString);
          DM_GateSpisOfAvar.Diam:=FieldByName('diam_diam').AsInteger;
          DM_GateSpisOfAvar.Attach:=ManaGeAvarOnMap.ConvertAttachToMAPAttach(FieldByName('attach').AsInteger-1);
      end;
    end;
end;

procedure TFormResult.OnSnapShotIDAvarAndAddrFromDataSetEvent(Sender: TObject; _first:boolean; var _EOF:boolean;
  var _Attach:TAttach; var _num:integer; var _addr:string; var _year:integer);
begin
  with Qry_Tmp do
    begin
      if _first then First else Next;
      _EOF:=EOF;
      if not(_EOF) then
        begin
          _num:=FieldByName('narjad_nom').AsInteger;
          _addr:=GetAddress();
          _year:=YearOf(FieldByName('data_soob').AsDateTime);
          if FieldByName('id_attach').AsInteger=2 then _attach:=tatKanal else _attach:=tatVoda;
        end;
    end;
end;

procedure TFormResult.OnReceivedSpisAvar(Sender:TObject);
begin
  DM_GateSpisOfAvar.RECEIVE_TYPES:=TRUE;
  if not(Qry_Tmp.FieldByName('MAP_VIEW').Visible)
      then Qry_Tmp.FieldByName('MAP_VIEW').Visible:=TRUE;
  {StrGr_res.
  if not (StrGr_res.Columns[0].Visible) then StrGr_res.Columns[0].Visible:=TRUE;}
  //Qry_Tmp.Refresh;
  bbMap.Enabled:=TRUE;
end;

procedure TFormResult.CalcTypeOfAvarField;
var _nom_narjad,_year_narjad:integer;
  _attach_narjad:TAttach;
begin
  if (MAP_IS_WORK and FNotLockMapView) and (DM_GateSpisOfAvar.RECEIVE_TYPES) then
  begin
    _nom_narjad:=Qry_tmp.FieldByName('NARJAD_NOM').AsInteger;
    _year_narjad:=Qry_tmp.FieldByName('YEAR_SOOB').AsInteger;
    if Qry_tmp.FieldByName('ID_ATTACH').AsInteger=2 then _attach_narjad:=tatKanal
      else _attach_narjad:=tatVoda;  
    Qry_Tmp.FieldByName('MAP_VIEW').AsString:=GetTextTypeOfAvar(_attach_narjad,_nom_narjad,_year_narjad);
  end;
end;

procedure TFormResult.StartWait(_caption:string);
begin
  Screen.Cursor:=crHourGlass;
  P_Wait.Caption:=_caption;
  P_Wait.Show;
  An_Wait.Active:=true;
  Application.ProcessMessages;
end;

procedure TFormResult.StopWait;
begin
  Screen.Cursor:=crDefault;
  P_Wait.Hide;
  An_Wait.Active:=false;
  Application.ProcessMessages;
end;

procedure TFormResult.AddMapViewField(_DataSet:TDataSet);
var i:integer;
begin
  if (MAP_IS_WORK and FNotLockMapView) then
  begin
    _DataSet.Active:=FALSE;
    for i:=0 to _DataSet.FieldDefs.Count-1 do
      AddField(_DataSet, _DataSet.FieldDefs[i].Name, _DataSet.FieldDefs[i].FieldClass, _DataSet.FieldDefs[i].Size);
    AddField(_DataSet,'MAP_VIEW',TStringField,20,TRUE);
    _DataSet.Active:=TRUE;
  end;
end;

{@@@@@@@@@@@@@@@ !!! MAP !!! @@@@@@@@@@@@@@@}
function TFormResult.AddField(_DataSet:TDataSet; const AFieldName:string;
  AFieldClass:TFieldClass; ASize:Word; _Calculated:boolean):TField;
begin
  Result:=_DataSet.FindField(AFieldName); // Field may already exists!
  if Result<>nil then Exit;
  {if AFieldClass=nil then
  begin
    DBErrorFmt(SUnknownFieldType,[AFieldName]);
  end;}
  Result:=AFieldClass.Create(Owner);
  with Result do
  try
    FieldName:=AFieldName;
    if (Result is TStringField) or (Result is TBCDField) or (Result is TBlobField) or
      (Result is TBytesField) or (Result is TVarBytesField) then
    begin
      Size:=ASize;
    end;
    Calculated:=_Calculated;
    DataSet:=_Dataset;
    Name:=_DataSet.Name+AFieldName;
  except
    Free; // We must release allocated memory on error!
    raise;
  end;
end;
{/@}

{$ENDIF}

constructor TFormResult.ResCreate(AOwner: TComponent; _NotLockMapView:boolean;
          alName,fCaption,CapUsl,tSQL:string;nTitles:TStringList;
          Adr:integer;UserVibor:prVibor;Sort:boolean;
          {ds}GroupSelect :boolean=false; FillGrid :boolean=true; DoRecCount: boolean=true;n:boolean=false;
          Cols:integer=0;num:integer=-1);
var i,k:integer;
begin
  isEmpty:=false;
  //MAP_IS_WORK:=TRUE;
  {$IFDEF MAP}
  {@@@@@@@@@@@@@@@ !!! MAP !!! @@@@@@@@@@@@@@@}
  FNotLockMapView:=_NotLockMapView;
  if (MAP_IS_WORK and FNotLockMapView) then FMapIncrem:=1 else FMapIncrem:=0;
  {/@}
  {$ENDIF}
  //
  if Assigned(UserVibor) then
    ProcVibor:=UserVibor
  else
    ProcVibor:=tutVibor;

  ResAlias:=alName;
  isIdView:=false;
  tutAdr:=Adr;
  tutnum:=num;
  tutTitles:=TStringList.Create;
  tutTitles.Clear;
  tutTitles.AddStrings(nTitles);
  {$IFDEF MAP}
  {@@@@@@@@@@@@@@@ !!! MAP !!! @@@@@@@@@@@@@@@}
  if (MAP_IS_WORK and FNotLockMapView) then tutTitles.Insert(0,'Вид на карте');
  {/@}
  {$ENDIF} 
  tutFields:=TStringList.Create;
  NumFields:=nTitles.Count-1;
  ResSQL:=tSQL;
  ///
  isSort:=Sort;
  isDoRecCount:=DoRecCount;
  isGroupSelect:=GroupSelect;
  isFillGrid:=FillGrid;
  nar:=n;

  inherited Create(AOwner);
  if Cols>0 then NumCols:=Cols;
  Self.Caption:=fCaption+' - '+TrLangMSG(msgCount)+': '+inttostr(NumCols);
  Self.Lb_usl.Caption:=CapUsl;
//  if FormResult.Lb_usl.W
end;



procedure TFormResult.FormCreate(Sender: TObject);  //между назв таблици и алиасом 1 пробел

function GetFirstAlias(s_SQL:string):string;
var p,c,f,pw:integer;

begin
c:=0;
f:=0;
result:='';
 p:=Pos('FROM',AnsiUpperCase(s_SQL));
 pw:=Pos('WHERE',AnsiUpperCase(s_SQL));
 p:=p+4;
 while (S_SQL[p]<>',') and (p<pw) do
 begin
   if (f=2) and (s_SQL[p]<>' ')  then
    c:=c+1 ;
   if (f=2) and (s_SQL[p]=' ')
    then
      Break;
   if (s_SQL[p]=' ') and(s_SQL[p-1]<>' ')  then
    f:=f+1;
    p:=p+1;
 end;
 result:=copy(s_SQL,p-c,c);
 if result<>'' then result:=result+'.';
end;
var i,ii,j,i1,i2,j1{,vRes}:integer;
    tt_str,tt_str2,tt_str3:string;
    tt_Menu:TMenuItem;
    MyButtons:TMsgDlgButtons;
    tk:longword;
    tk_razn:double;
    str:string;
begin
 //
  {@@@@@@@@@@@@@@@ !!! MAP !!! @@@@@@@@@@@@@@@}
  bbMap.Visible:=(MAP_IS_WORK and FNotLockMapView);


  if isEmpty then exit;
  {$IFDEF MAP}
  if (MAP_IS_WORK and FNotLockMapView) then
    begin
      if (MAP_IS_WORK and FNotLockMapView) then
        begin
          bbMap.Show;
          bbMap.Enabled:=FALSE;
        end;
      //    RECEIVE_TYPES:=FALSE; //пришли айди аварий и типы
      DM_GateSpisOfAvar:=TDM_GateSpisOfAvar.Create;
      DM_GateSpisOfAvar.OnAskWorkFields:=OnAskWorkFields;
      DM_GateSpisOfAvar.OnFindWorkFields:=OnFindWorkFields;
      DM_GateSpisOfAvar.OnReceivedSpisAvar:=OnReceivedSpisAvar;
      DM_GateSpisOfAvar.OnSnapShotIDAvarAndAddrFromDataSetEvent:=OnSnapShotIDAvarAndAddrFromDataSetEvent;
    end;
  {$ENDIF}
  {/@}
 Lb_usl.Anchors:=[akLeft,akTop,akRight,akBottom];
 Label1.Anchors:=[akTop,akRight];
 SpEd_Font.Anchors:=[akTop,akRight];
 StrGr_res.Anchors:=[akLeft,akTop,akRight,akBottom];
 StaticText1.Anchors:=[akTop,akRight];
 ChLB_Pol.Anchors:=[akTop,akRight,akBottom];
 Panel2.Anchors:=[akRight,akBottom];
 BorderStyle:=bsSizeable;

 PrBar.parent:=StatusBar1;
 TekInMas:=0;
 MyButtons:=[mbYes, mbNo];
 Qry_tmp.DatabaseName:=ResAlias;
 Qry_ul1.DatabaseName:=ResAlias;
 Qry_ul2.DatabaseName:=ResAlias;
 Qry_DopAdres.DatabaseName:=ResAlias;
 SpEd_Font.OnChange:=NIL;
 SpEd_Font.Value:=StrGr_Res.Font.Size;
 SpEd_Font.OnChange:=SpEd_FontChange;
 //FormResult:=Self;
 inc(NumFields); //это для учета ID
 {$IFDEF MAP}
 {@@@@@@@@@@@@@@@ !!! MAP !!! @@@@@@@@@@@@@@@}
 if (MAP_IS_WORK and FNotLockMapView) then inc(numFields);
 {/@}
 {$ENDIF}
 StrGr_Res.ColCount:=NumFields+1;
 if isGroupSelect then StrGr_Res.ColCount:=StrGr_Res.ColCount-1; // ds
 StrGr_Res.FixedRows:=1;
 StrGr_Res.RowCount:=2;
 StrGr_Res.RowHeights[0]:=20;
 StrGr_Res.RowHeights[1]:=20;
 //
 //
 for i:=0 to NumFields do
  begin
   if (isGroupSelect)and(i=NumFields) then break; // ds
   StrGr_Res.ColWidths[i]:=100;
   if i=NumFields then
    begin
     StrGr_Res.Cells[i,0]:='ID';
     TutFields.Add('ID');
    end // if i=NumFields ...
     else begin
           StrGr_Res.Cells[i,0]:=tutTitles.Strings[i];
           ChLB_Pol.Items.Add(tutTitles.Strings[i]);
           if isSort then
            begin
              tt_Menu:=NewItem(TrLangMSG(msgSortField)+': '+Upper(tutTitles.Strings[i]),
                      0,false,true,PoM_SortPopup,0,'Popup'+inttostr(i));
              PoM_Sort.Items.Add(tt_Menu);
            end; // if isSort ...
            {$IFDEF MAP}
            {@@@@@@@@@@@@@@@ !!! MAP !!! @@@@@@@@@@@@@@@}
            if ((MAP_IS_WORK and FNotLockMapView)) and (i=0) then TutFields.Add('MAP_VIEW')
              else TutFields.Add('POLE'+inttostr(i-FMapIncrem));
            {/@}
            {$ENDIF}
          end; // if i=NumFields ... else
  end; // for i:=0 to NumFields
 //
 BB_zav.Visible:=(not isGroupSelect);
 if not isFillGrid then exit; // ds

 NumCols:=0;//1;
 if isDoRecCount then
 begin
 i2:=1;
 j:=Pos('union',ResSQL);
 if j<=0 then
  begin
   i2:=0;
   j:=10000;
  end; // if j<=0 ...
 for i1:=0 to i2 do
  begin
   if i1=0 then
      tt_str2:=copy(ResSQL,0,j-1)
   else
      tt_str2:=copy(ResSQL,j+6,10000);
   j1:=Pos('order by',tt_str2);
   if j1>0 then
      tt_str2:=copy(tt_str2,0,j1-1);

   j1:=Pos(' exists ',tt_str2);
   if j1>0 then
      tt_str3:=copy(tt_str2,0,j1-1)
   else
      tt_str3:=tt_str2;

   j1:=Pos(' in ',tt_str3);
   if j1>0 then
      tt_str3:=copy(tt_str3,0,j1-1);

   str:=GetFirstAlias(tt_str2);

   ii:=MyNPos('FROM',{ResSQL}AnsiUpperCase(tt_str3),10000);
   i:=ii;
   tt_str:='select count( distinct '+str+'id) mm '+copy(tt_str2,i,10000);
   tk:=GetTickCount;
   MyOpenSQL(Qry_tmp,tt_str);
//   OpenSQLEx(Self,Qry_tmp,FormMain.Db_Avar.AliasName,tt_str);
   NumCols:=NumCols+Qry_tmp.FieldByName('MM').asInteger;
   Qry_tmp.Close;
   tk_razn:=(GetTickCount-tk)/1000;
   Lb_count.Caption:=FloatToStrF(tk_razn,ffFixed,3,3);
   Lb_count.Update;
  end; // for i1:=0 to i2 do ...
 end; //if is doRecCount
{ ds if NumCols>200 then
    MyButtons:=[mbNo];}

 if isDoRecCount then
 begin
 if (NumCols>0)and(MessageDlg(format(TrLangMSG(msgFound),[NumCols]),
                   mtConfirmation, MyButtons, 0) = mrYes) then
   begin
    exit_fl:=false;
    UpdAll;
    Hide;
   end
    else begin
          if NumCols=0 then
              MessageDlg(TrLangMSG(msgNotFound), mtInformation, [mbYes], 0);
          Tm.Enabled:=true;
          exit_fl:=true;
         end;
 end else
 begin
    exit_fl:=false;
    UpdAll;
    Hide;
 end;
end;

procedure TFormResult.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {$IFDEF MAP}
  if (MAP_IS_WORK and FNotLockMapView) then
  begin
    DM_GateSpisOfAvar.Free;
  end;
  {$ENDIF}
  //
  Qry_tmp.Close;
  Qry_ul1.Close;
  Qry_ul2.Close;
  Qry_DopAdres.Close;
  Action:=caFree;
end;

procedure TFormResult.BB_ClearClick(Sender: TObject);
var i:integer;
begin
   for i:=0 to StrGr_Res.ColCount-1 do
     begin
        StrGr_Res.ResetColorRow(i);
     end;
end;

function TFormResult.id2Adr(id_cod,id_ul1:integer;id_ul2:string;
                  id_dopadres:integer =-1; id_rayon:integer=-1):string;
  var tt_str,ul2, dop_adr:string;
begin
   tt_str:='';
   if id_ul2='' then
     id_ul2:='';
   if Qry_Ul1.Locate('ID',id_ul1,[]) then
    begin
      tt_str:=Qry_Ul1.FieldByName('NAME_R').asString;
      if tt_str<>'' then
        tt_str:=Strip('B',' ',tt_str);
    end
   else
     tt_str:='';

   ul2:='';
   if id_ul2<>'' then
     ul2:=Strip('B',' ',id_ul2);

   if id_cod=0 then
    begin
      tt_str:=tt_str+','+ul2;
    end
   else if id_cod=1 then
    begin
      if not Qry_Ul2.Locate('ID',ul2,[]) then
         Qry_Ul2.First;
   //   if Qry_Ul2['NAME_R']<>'' then
        tt_str:=tt_str+' > '+ //trim(Qry_Ul2['NAME_R']);
        Strip('B',' ',Qry_Ul2.FieldByName('NAME_R').asString);
    end
   else if id_cod=2 then
    begin
      tt_str:='Мест:'+tt_str;
      if Qry_DopAdres.Locate('ID', id_dopadres, []) then
        tt_str:=tt_str+';'+Qry_DopAdres.FieldByName('name_r').AsString;
    end;
 
  dop_adr:=trim(Qry_tmp.FieldByName('DOP_ADR').asString);
  if dop_adr<>'' then dop_adr:=' ('+dop_adr+')';
  Result:=tt_str+dop_adr;

  if id_rayon >= 0 then
     Result:=Format('%s %s р-н',[Result,getRayonName(id_rayon)]);
end;

procedure TFormResult.StrGr_resKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (Key=32) or ((Key=40) and  (ssShift in Shift)) then
    begin
      if (StrGr_Res.Cells[NumFields,StrGr_Res.Row]='') or (StrGr_Res.ColorRow[StrGr_Res.Row]=clYellow) then
        StrGr_Res.ResetColorRow(StrGr_Res.Row)
      else
        StrGr_Res.ColorRow[StrGr_Res.Row]:=clYellow;

      if (Key=32) and (StrGr_Res.Row<StrGr_Res.RowCount-1) then
         StrGr_Res.Row:=StrGr_Res.Row+1;
    end;
end;

procedure TFormResult.StrGr_resMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
      if Button = mbLeft then
    begin
      if (StrGr_Res.Cells[NumFields,StrGr_Res.Row]='') or (StrGr_Res.ColorRow[StrGr_Res.Row]=clYellow) then
        StrGr_Res.ResetColorRow(StrGr_Res.Row)
      else
        StrGr_Res.ColorRow[StrGr_Res.Row]:=clYellow;
    end;
end;

procedure TFormResult.SpEd_FontChange(Sender: TObject);
begin
 StrGr_Res.Font.Size:=SpEd_Font.Value;
 Upd_cols;
 {
 StrGr_Res.AdjustColWidths;
 StrGr_Res.AdjustRowHeights;
 StrGr_Res.colwidths[NumFields]:=2;}
end;

procedure TFormResult.BB_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFormResult.PoM_SortPopup(Sender: TObject);
var aa:integer;
begin
    aa:=TMenuItem(Sender).MenuIndex;
    StrGr_res.SortColumn(aa,true);
    Upd_Cols;
end;


procedure TFormResult.TmTimer(Sender: TObject);
begin
   Close;
end;

function tutVibor(ID,Col:integer; var ss:string):integer;
begin
  //ss:='';
  Result:=V_NONE;
end;

procedure TFormResult.Upd_cols;
var aa,i:integer;
begin
  StrGr_Res.AdjustColWidths;
  StrGr_Res.AdjustRowHeights;
  aa:=ChLB_Pol.Items.Count-1;
  for i:=0 to aa do
    begin
     if not ChLB_Pol.Checked[i] then
         StrGr_Res.colwidths[i]:=0;//ds 1;
    end;
  if not isIdView then
    StrGr_Res.colwidths[NumFields]:=2;
end;

procedure TFormResult.ChLB_PolClick(Sender: TObject);
begin
  Upd_cols;
end;

procedure TFormResult.BB_zavClick(Sender: TObject);
var ZvForm:TFormZav;
begin
  LastMenuItemSender_Tag := dm1.GetZavAttach( StrToInt(StrGr_Res.Cells[StrGr_Res.ColCount-1,StrGr_Res.Row]) );
  ZvForm:=TFormZav_ZavCreate(Self,tfmZayavAfterInsert,StrToInt(StrGr_Res.Cells[StrGr_Res.ColCount-1,StrGr_Res.Row]));
  try
    ZvForm.ShowModal;
     if CloseStatus<>0 then
         repeat
           if CloseStatus=2 then
             ZvForm:=TFormZav_ZavCreate(Self,tfmZayavCopy,ZavToCopy)
           else
             ZvForm:=TFormZav_ZavCreate(Self,tfmZayavNew,0);

           ZvForm.ShowModal;
         until CloseStatus=0;
   finally
    //ZvForm.Free;
    //ZvForm.Close;
    //
    {$IFDEF MAP}
    if (MAP_IS_WORK) then
      begin
        DM_GateSpisOfAvar.ReConnectEventsToManager;
      end;  
    {$ENDIF}
   end;
  //             tstringgrid
{uo
  StrGr_Res.RowCount:=2;
  if isFillGrid then UpdAll;
}
end;

procedure TFormResult.BB_PrintClick(Sender: TObject);
var pp:TProsmForm;
begin
  pp:=TProsmForm.ProsmCreate(Self,Self);
  pp.ShowModal;
end;

procedure TFormResult.Save2HTML(fname:string);
var tt:TMemorystream;
    aaa,bbb:string;
begin
  aaa:='<HTML><HEAD><TITLE>Результат запроса</TITLE></HEAD><BODY BGCOLOR=SILVER>'#13#10+
       '<P><LEFT><FONT COLOR="BLUE">'+LB_Usl.Caption+'</FONT></LEFT>'#13#10;
  bbb:='</BODY></HTML>';
  tt:=TMemorystream.Create;
  tt.Position:=0;
  tt.Write(aaa[1],Length(aaa));
  StrGr_Res.Contents2HTML(tt);
  tt.Position:= tt.Size;
  tt.Write(bbb[1],Length(bbb));
  tt.SaveToFile(fname);
  tt.Destroy;
end;

procedure TFormResult.StrGr_resDblClick(Sender: TObject);
begin
  if BB_zav.Visible then
    BB_zavClick(Self);
end;

procedure TFormResult.BB_ExcelClick(Sender: TObject);
const MasBuk: array [1..26] of string =
             ('A','B','C','D','E','F','G','H','I','J',
              'K','L','N','M','O','P','Q','R','S','T',
              'U','V','W','X','Y','Z');

var Sheet: Variant;
    i,j,jj,XlCols:integer;
    tt_str:string;
    fl_vs:boolean;
    k :integer;
begin
 if VarIsEmpty(XLApp) then
  begin
    fl_vs:=true;
    XlCols:=0;
    BB_Excel.Font.Style:=[fsBold];
    XLApp:= CreateOleObject('Excel.Application');
    XLApp.Visible := True;
    XLApp.Workbooks.Add(xlWBatWorkSheet);
    XLApp.Workbooks[1].WorkSheets[1].Name :=TrLangMSG(msgVedomOne);
    Sheet := XLApp.Workbooks[1].WorkSheets[TrLangMSG(msgVedomOne)];
    jj:=0;
    for j:=0 to NumFields-1 do
    if StrGr_Res.colwidths[j]>2 then
     begin
      inc(XlCols);
      inc(jj);
      for i:=0 to StrGr_Res.RowCount-1 do
        begin
         Sheet.Cells[i+2,jj].HorizontalAlignment:=$FFFFEFDD; // выравнивание по левому краю
         Sheet.Cells[i+2,jj].NumberFormat:='@'; // текстовое поле
         Sheet.Cells[i+2,jj]:=StrGr_Res.Cells[j,i];
         if IsThereITOGO(StrGr_Res.Cells[j,i]) {uo pos('ИТОГО',StrGr_Res.Cells[j,i])>0}
         then fl_vs:=false;

         if i=0 then
           begin
             Sheet.Cells[i+2,jj].Font.Bold := True;
             Sheet.Cells[i+2,jj].Font.Size := SpEd_Font.Value+2;
           end
         else
           Sheet.Cells[i+2,jj].Font.Size := SpEd_Font.Value;

        end;
      Sheet.Columns[jj].AutoFit;
      Sheet.Columns[jj].Borders[xlEdgeLeft].LineStyle := xlContinuous;
      Sheet.Columns[jj].Borders[xlEdgeRight].LineStyle := xlContinuous;
     end;
    Sheet.Rows[2].Borders[xlEdgeTop].LineStyle := xlContinuous;
    Sheet.Rows[2].Borders[xlEdgeBottom].LineStyle := xlContinuous;
    Sheet.Rows[StrGr_Res.RowCount+1].Borders[xlEdgeBottom].LineStyle := xlContinuous;

    for i:=2 to StrGr_Res.RowCount+1 do
     begin
       tt_str:=Sheet.Cells[i+1,1].Value;
       if tt_str<>'' then
          Sheet.Rows[i+1].Borders[xlEdgeTop].LineStyle := xlContinuous;
     end;

    if XlCols <= 26
       then Sheet.Range['A1:'+MasBuk[XlCols]+'1'].Merge
       else begin
             k:=trunc(XlCols/26);
             Sheet.Range[Format('A1:%s%s1', [MasBuk[k], MasBuk[XlCols -k*26]])].Merge;
            end;


    Sheet.Cells[1,1].Font.Bold := True;
    Sheet.Cells[1,1].Font.Size := SpEd_Font.Value+2;
    Sheet.Cells[1,1]:=Lb_usl.Caption;
    Sheet.Rows[1].Borders.LineStyle := xlNone;
    Sheet.Rows[1].WrapText := true;
    if fl_vs then
      begin
        Sheet.Cells[StrGr_Res.RowCount+2,1]:=TrLangMSG(msgAllCount)+' :'+inttostr(NumCols);
        Sheet.Rows[StrGr_Res.RowCount+2].Borders.LineStyle := xlNone;
      end;
    Sheet.Cells[StrGr_Res.RowCount+3,1]:=TrLangMSG(msgCreate)+' :'+DateToStr(Now)+' '+TimeToStr(Now);
    Sheet.Rows[StrGr_Res.RowCount+3].Borders.LineStyle := xlNone;

//    Sheet.Cells[StrGr_Res.RowCount+3,1]:='Создано :'+DateToStr(Now)+' '+TimeToStr(Now);
//    Sheet.Rows[StrGr_Res.RowCount+3].Borders.LineStyle := xlNone;
  end
 else
  begin
    XLApp.DisplayAlerts := False;  // Discard unsaved files....
    XLApp.Quit;
    XlApp:=UnAssigned;
    BB_Excel.Font.Style:=[];
  end;
end;

procedure TFormResult.FormDestroy(Sender: TObject);
begin
 GL_Count:=-1; // ds

  if not VarIsEmpty(XLApp) then begin
    XLApp.DisplayAlerts := False;  // Discard unsaved files....
    XLApp.Quit;
    XLApp:=UnAssigned;
  end;
end;

procedure TFormResult.UpdAll;
var
 vRes,j:integer;
 tt_str:string;
 tk:longword;
 tk_razn:double;
 id_rn, id_da :integer;
 number,new_number:integer;
begin
     number:=0;
     new_number:=1;
     vRes:=0;
     Qry_ul1.Open;
     Qry_ul2.Open;
     Qry_DopAdres.Open;
     tk:=GetTickCount;
     Qry_tmp.Close;
     MyOpenSQL(Qry_tmp,ResSQL);
     {$IFDEF MAP}
     ////////////////////////////////////////////////////////
     {@@@@@@@@@@@@@@@ !!! MAP !!! @@@@@@@@@@@@@@@}
      if (MAP_IS_WORK and FNotLockMapView) then
        begin
          StartWait('Получаем информацию о разметке...');
          try
            AddMapViewField(Qry_Tmp);
            DM_GateSpisOfAvar.SendSpisOfAvarToAvarOnMap;
            repeat
              Application.ProcessMessages;
            until DM_GateSpisOfAvar.RECEIVE_TYPES;
          finally
            StopWait;
          end;  
        end;  
      {/@}
     ///////////////////////////////////////////////////////
     {$ENDIF}
     //
    // OpenSQLEx(Self,Qry_tmp,FormMain.Db_Avar.AliasName,ResSQL);
     tk_razn:=(GetTickCount-tk)/1000;
     Lb_Select.Caption:=FloatToStrF(tk_razn,ffFixed,3,3);
     Lb_Select.Update;
     PrBar.Position:=0;
     PrBar.Max:=NumCols +10;
     ShowProgress:=true; // ds
     //PrBar.Visible:=true;
     Show;
     Update;
     Qry_tmp.First;
     while not Qry_tmp.EOF do
       begin
       {$IFDEF MAP}
       {@@@@@@@@@@@@@@@ !!! MAP !!! @@@@@@@@@@@@@@@}
        if (MAP_IS_WORK and FNotLockMapView) then
          begin
            tt_str:=Qry_tmp.FieldByName(tutFields.Strings[0]).asString;
            StrGr_Res.Cells[0,StrGr_Res.RowCount-1]:=Trim(tt_str);
          end;
        {/@}
        {$ENDIF}          
        for j:=FMapIncrem to NumFields do
          begin
            if (j-FMapIncrem)=tutAdr then
               begin
               tt_str:='';
                if assigned(Qry_tmp.FindField('ID_RAYON'))
                   then id_rn:=Qry_tmp.FieldByName('ID_RAYON').asInteger
                   else id_rn:=-1;
                if assigned(Qry_tmp.FindField('ID_DOPADRES'))
                   then id_da:=Qry_tmp.FieldByName('ID_DOPADRES').asInteger
                   else id_da:=-1;
               if Qry_tmp.FieldList.IndexOf('soorug')>-1 then
                 if (not Qry_tmp.FieldByName('soorug').IsNull )and
                 (Qry_tmp.FieldByName('id_soorug').AsInteger>-1) then
                    tt_str:=Trim(Qry_tmp.FieldByName('soorug').AsString);
               if  Qry_tmp.FieldList.IndexOf('object')>-1 then
                    if not Qry_tmp.FieldByName('object').IsNull and
                        (Qry_tmp.FieldByName('id_object').AsInteger>-1) then
                        tt_str:=Trim(Qry_tmp.FieldByName('object').AsString)+','+tt_str;


               if tt_str='' then
                tt_str:=Trim(
                          id2Adr(Qry_tmp.FieldByName('KOD_UL').asInteger,
                          Qry_tmp.FieldByName('ID_UL1').asInteger,
                          Qry_tmp.FieldByName('ID_UL2').asString,id_da,id_rn));

               end // if j=tutAdr ...
               else
               if (tutnum>=0) and  (j-FMapIncrem=tutnum)  then
               begin
               if (number<new_number)then begin
                 number:=number+1;
                tt_str:=InttoStr(number);
                end
                else
                   tt_str:='';

               end  //    if (tutnum>=0)...
                 else tt_str:=Qry_tmp.FieldByName(tutFields.Strings[j]).asString;
            //j-FMapIncrem это для того, чтобы ProcVibor считал порядок полей без учета map_view, т.е. по старинке
            if not nar then
            vRes:=ProcVibor(Qry_tmp.FieldByName('ID').asInteger,j-FMapIncrem,tt_str)
            else
             vRes:=ProcVibor(Qry_tmp.FieldByName('ID_nar').asInteger,j-FMapIncrem,tt_str);
             if (Qry_tmp.FieldByName(tutFields.Strings[NumFields]).AsString=Trim(StrGr_Res.Cells[NumFields,StrGr_Res.RowCount-2]))
                and (Trim(tt_str)=Trim(StrGr_Res.Cells[j,StrGr_Res.RowCount-2]))
                and (StrGr_Res.Cells[j,0]<>'Кол-во') then //2013 glasha для группировки
               StrGr_Res.Cells[j,StrGr_Res.RowCount-1]:=''
               else
              StrGr_Res.Cells[j,StrGr_Res.RowCount-1]:=Trim(tt_str);
          end; // for j:=0 to NumFields
        StrGr_Res.RowCount:=StrGr_Res.RowCount+1;
        if vRes=V_NONE then
          begin
           Qry_tmp.Next;
           new_number:=new_number+1;
           PrBar.Position:={Round((CurPosition/NumCols)*90);//}PrBar.Position+1;
           StatusBar1.Repaint;
          end;
       end;
   //PrBar.Visible:=false;
   StrGr_Res.RowCount:=StrGr_Res.RowCount-1;
   ChLB_Pol.ApplyState(cbChecked,false);
   if isSort then
     StrGr_res.SortColumn(0,true);
   PrBar.Position:=PrBar.Max - 5;
   Upd_Cols;
   PrBar.Position:=PrBar.Max;
   ShowProgress:=false; // ds
// FormResult.Hide;
end;

procedure TFormResult.Lb_ColsClick(Sender: TObject);
begin
  isIdView:=not isIdView;
  if isIdView then
    StrGr_Res.AdjustColWidth(StrGr_Res.ColCount-1)
  else
    StrGr_Res.colwidths[NumFields]:=2;
end;

//*******************************************************************
procedure TFormResult.SetShowProgress(fl :boolean);
begin
 FShowProgress:=fl;
 PrBar.Visible:=fl;
 PrBar.position:=0;
 if fl then StatusBar1.Panels[0].Style:=psOwnerDraw;
      { else begin
             StatusBar1.Panels[0].Style:=psText;
             CountElem:=GrList_lb.items.Count;
            end;}
 StatusBar1.Repaint;
end;

//*******************************************************************
procedure TFormResult.StatusBar1DrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
 PrBar.Parent:=StatusBar1;
 PrBar.BoundsRect:=Rect;
// PrBar.Position:=50;
end;

//*******************************************************************
procedure TFormResult.Translate;
begin
  inherited;
  Caption:=TrLangMSG(msgLoadResult);
  Label1.Caption:=TrLangMSG(msgSizeFont);
  BB_Print.Caption:=TrLangMSG(msgPrint);
  BB_Close.Caption:=TrLangMSG(msgExit);
  BB_Clear.Caption:=TrLangMSG(msgClear);
  StaticText1.Caption:=TrLangMSG(msgColumns);
end;



procedure TFormResult.bbMapClick(Sender: TObject);
begin
  inherited;
  {$IFDEF MAP}
    {Разметим аварии}
    if (MAP_IS_WORK and FNotLockMapView) then DM_GateSpisOfAvar.Razmetit;
  {$ENDIF}
end;

procedure TFormResult.Qry_tmpCalcFields(DataSet: TDataSet);
begin
  inherited;
  {@@@@@@@@@@@@@@@ !!! MAP !!! @@@@@@@@@@@@@@@}
  {$IFDEF MAP}
    if (MAP_IS_WORK and FNotLockMapView) then CalcTypeOfAvarField;
  {$ENDIF}
  {/@}    
end;

constructor TFormResult.ResCreateEmpty(AOwner: TComponent);
begin
   isEmpty:=true;
   inherited Create(AOwner);
end;

end.
