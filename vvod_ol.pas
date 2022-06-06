unit vvod_ol;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, RxStrUtils,
  RXLookup, Db, DBTables, StdCtrls, Buttons, DBCtrls, ExtCtrls, frmLANG, cntsLANG,
  Variants,OperAttFormUnit, DMAvrImage, DMMain;

const
    VIB_CANSEL=0;
    VIB_OK=1;
    VIB_DBLCLK=1;
    WK_ABORT=0;
    WK_CONT=1;
    WK_CLOSE=2;


type
  prVibor = function (whatVib:integer;ss:string):integer;
  TFormVvod = class(TOperAttForm)
    Qry_Sour: TQuery;
    DS_Sour: TDataSource;
    Panel1: TPanel;
    DBLL_Vvod: TRxDBLookupList;
    BB_Ok: TBitBtn;
    BB_ESC: TBitBtn;
    Find_ed: TEdit;
    Bevel1: TBevel;
    BShowonMap: TSpeedButton;
    Qry_SourTrimVVod: TStringField;
    Qry_SourVvod: TStringField;
    Qry_SourId: TIntegerField;
    Qry_SourUL1: TStringField;
    Qry_SourID_UL2: TStringField;
    Qry_SourKOD_UL: TIntegerField;
    Qry_SourDOP_ADR: TStringField;
    Qry_SourDT_IN: TDateTimeField;
    Qry_Find: TQuery;
    Qry_FindID: TIntegerField;
    BB_DeleteAll: TBitBtn;
    Qry_tmp: TQuery;
    Qry_SourID_DOPADRES: TIntegerField;
    Qry_SourID_OBJECT: TIntegerField;
    Qry_SourImgCount: TStringField;
    Qry_Souris_otl: TIntegerField;
    Qry_Sourc_is_otl: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBLL_VvodKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BB_OkClick(Sender: TObject);
    procedure BB_ESCClick(Sender: TObject);
    procedure DBLL_VvodDblClick(Sender: TObject);
    procedure Find_edChange(Sender: TObject);
    procedure Find_edKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BShowonMapClick(Sender: TObject);
    procedure Qry_SourCalcFields(DataSet: TDataSet);
    procedure BB_DeleteAllClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure ObrabWK(vid:integer);
    function FindStrInSpis(value:string):integer;
  public
    FZakr:boolean;
    FDop_where:string;
    FIsCanDeleteAll: boolean;
    { Public declarations }
    procedure Translate;override;
  end;

//function VvodOl(Ow:TComponent):string;
function tut_Vibor(vib:integer;id:string):integer;
function VvodOl(Ow:TComponent;FontSize:integer;dbName,fCap,sSQL,_dop_where,sFind:string;
         _OperAttr:TOperAtt; Zakr:boolean; userVibor:prVibor; isCanDeleteAll: boolean=false):string;



var
  FormVvod: TFormVvod;
  Ret:string;
  FSize:integer;
  SelectSQL,bFind,dbAlias:string;
  ProcVibor:prVibor;

implementation
   uses  StrUtils, zav, main, datam, ServiceFuncUnit;

{$R *.DFM}

function TFormVvod.FindStrInSpis(value:string):integer;
var _dt_in:TDateTime;
  _nomer:integer;
  v1,v2:Variant;
  s:string;
begin
  result:=-1;
  try
    Screen.Cursor:=crHourGlass;
  with Qry_Find do
    begin
      Close;
      if FZakr then s:='from zavjav z' else s:='from nzavjav z';
      SQL.Text:='select z.id '#13+
        s+#13+
        ' left join s_ulic on z.id_ul1=s_ulic.id '#13+
        'where '+FDop_where+' '#13+
        ' and ( (dt_in=:dt_in) or (nomer=:nomer) or (dop_adr like UPPER(:dop_adr)) or '#13+
        ' (s_ulic.name_r like UPPER(:ul1)) ) '#13+
        'order by fyear desc,nomer desc';
      if TryStrToDateTime(value,_dt_in) then v1:=_dt_in else v1:=NULL;
      if TryStrToInt(value,_nomer) then v2:=_nomer else v2:=NULL;
      ParamByName('dt_in').Value:=v1;
      ParamByName('nomer').Value:=v2;
      ParamByName('ul1').AsString:=AnsiUpperCase('%'+value+'%');
      ParamByName('dop_adr').AsString:=AnsiUpperCase('%'+value+'%');
      Open;
      result:=FieldByName('id').AsInteger;
    end;
  finally
    Qry_Find.Close;
    Screen.Cursor:=crDefault;
  end;
end;

procedure TFormVvod.FormCreate(Sender: TObject);
//var i,dl:integer;
//    tt_str:string;
//    res:TSize;
begin
  inherited;
  OperAttFormFill(sender);
{$ifdef nmap}
  BShowonMap.Visible:=False;
{$endif}
 DBLL_Vvod.Anchors:=[akLeft,akTop,akRight,akBottom];
 Bevel1.Anchors:=[akLeft,akRight,akBottom];
 BB_Ok.Anchors:=[akRight,akBottom];
 BB_ESC.Anchors:=[akRight,akBottom];
 Borderstyle:=bsSizeable;

  Ret:='';
//ds  DbLL_Vvod.Font.Size:=FSize;
  Qry_Sour.SQL.Clear;
  Qry_Sour.DataBaseName:=dbAlias;
  //SelectSQL:='select name_r vvod,id from s_vidul order by name_r';
  Qry_Sour.SQL.Add(SelectSQL);
  Qry_Sour.Open;
{ds  i:=Qry_Sour.RecordCount;

  if i<14 then
   begin
     DbLL_Vvod.RowCount:=Qry_Sour.RecordCount;
     BB_OK.Top:=DbLL_Vvod.Height+8;
     BB_ESC.Top:=DbLL_Vvod.Height+8;
     Self.Height:=DbLL_Vvod.Height+75;
   end;
  dl:=Qry_Sour.FieldByName('Vvod').DisplayWidth;
  tt_str:=MakeStr('А',dl);
  Res.cX := 0;
  Res.cY := 0;
  GetTextExtentPoint(GetDC(DbLL_Vvod.Handle),PChar(tt_str),Length(Tt_str), Res);
  Self.Width:=Res.cX+12;
  DbLL_Vvod.Width:=Res.cX;
  }
  if bFind<>'' then
    Qry_Sour.Locate('ID',bFind,[]);
  DbLL_Vvod.DisplayValue:=Qry_Sour.FieldByName('TrimVVOD').asString;
//  DbLL_Vvod.DisplayValue:=Qry_Sour.FieldByName('VVOD').asString;
end;

procedure TFormVvod.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Qry_Sour.Close;
  Action:=caFree;
end;

procedure TFormVvod.DBLL_VvodKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=VK_RETURN) then   //and (not (ssCtrl in shift))then
   begin
     BB_OkClick(Self);
   end
  else if (key=VK_ESCAPE) then
   begin
     BB_ESCClick(Self);
   end
end;

function VvodOl(Ow:TComponent;FontSize:integer;dbName,fCap,sSQL,_dop_where,sFind:string;
_OperAttr:TOperAtt; Zakr:boolean; userVibor:prVibor; isCanDeleteAll: boolean=false):string;
var ff:TFormVvod;
begin
  //
  if Assigned(UserVibor) then
    ProcVibor:=UserVibor
  else
    ProcVibor:=tut_Vibor;
  dbAlias:=dbName;
  bFind:=sFind;
  SelectSQL:=sSQL;
  ff:=TFormVvod.Create(Ow);
  ff.Caption:=fCap;
  ff.OperAttFormFill(nil);
  if _OperAttr=toaNull then ff.OperateAttach:=_OperAttr;
  ff.FZakr:=Zakr;
  ff.FDop_where:=_dop_where;
  ff.FIsCanDeleteAll:=isCanDeleteAll;
//ds  ff.DbLL_Vvod.Font.Size:=FontSize;
  ff.ShowModal;
  Result:=Ret;
end;

function tut_Vibor(vib:integer;id:string):integer;
begin
   Result:=WK_ABORT;Ret:='';
   if (vib=VIB_OK) or (vib=VIB_DBLCLK) then
    begin
      Result:=WK_CLOSE;
    end;
end;
procedure TFormVvod.BB_OkClick(Sender: TObject);
var rr:integer;
begin
  rr:=ProcVibor(VIB_OK,Qry_Sour.FieldByName('ID').asString);
  ObrabWK(rr);
end;

procedure TFormVvod.BB_ESCClick(Sender: TObject);
var rr:integer;
begin
  rr:=ProcVibor(VIB_CANSEL,Qry_Sour.FieldByName('ID').asString);
  ObrabWK(rr);
end;

procedure TFormVvod.ObrabWK(vid:integer);
begin
  Ret:='';
  if vid=WK_CLOSE then
   begin
    Ret:=Qry_Sour.FieldByName('ID').asString;
    Close;
   end
  else if vid=WK_ABORT then
   Close;
end;

procedure TFormVvod.DBLL_VvodDblClick(Sender: TObject);
var rr:integer;
begin
  rr:=ProcVibor(VIB_DBLCLK,Qry_Sour.FieldByName('ID').asString);
  ObrabWK(rr);
end;

//*******************************************************************
procedure TFormVvod.Find_edChange(Sender: TObject);
begin
 if Qry_Sour.Locate('id', FindStrInSpis(Find_ed.Text), [loCaseInsensitive,loPartialKey])
    then DbLL_Vvod.DisplayValue:=Qry_Sour.FieldByName('TrimVVOD').asString;
// if Qry_Sour.Locate('Vvod', Find_ed.Text, [loCaseInsensitive,loPartialKey])
//    then DbLL_Vvod.DisplayValue:=Qry_Sour.FieldByName('VVOD').asString;
end;

//*******************************************************************
procedure TFormVvod.Find_edKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (Key = VK_DOWN)or(Key = VK_UP)
    then DBLL_Vvod.SetFocus;
end;

//*******************************************************************
procedure TFormVvod.BShowonMapClick(Sender: TObject);
begin
{ if Qry_Sour.FieldByName('ID').asString <> '' then
    FormMain.atmInterf1.EditMark(Qry_Sour.FieldByName('ID').asInteger);}
{ ZvForm:=TFormZav.ZavCreate(Self,1,Qry_Sour.FieldByName('ID').asInteger);
 ZvForm.ShowModal;}
end;

//*******************************************************************
procedure TFormVvod.Translate;
begin
  inherited;
  Caption:=TrLangMSG(msgChoose);
  BShowonMap.Hint:=TrLangMSG(msgShowOnMap);
  BB_Ok.Caption:=TrLangMSG(msgApply);
  BB_ESC.Caption:=TrLangMSG(msgCancel);
  BB_DeleteAll.Caption:=TrLangMSG(msgCearList);
end;

procedure TFormVvod.Qry_SourCalcFields(DataSet: TDataSet);
var
  s,s1: string;
  _d, _idzav, _count, _is_otl: integer;
  _adr, _scount, _s_is_otl: string;
  //_DmImage : TDM_AvrImage;
begin
  inherited;
  //s:=DelSpace1(Dataset.fieldByName('vvod').asString);
  s:=Trim(Dataset.fieldByName('vvod').asString);
  _d:=5-length(s);
  if _d>0 then
    begin
      case _d of
        1: s:=s+' ';
        2: s:=s+'  ';
        3: s:=s+'   ';
        4: s:=s+'    ';
        5: s:=s+'     ';
      end;
    end;
  s1:=Dataset.fieldByName('dt_in').asString;
  if length(s1)<19 then s1:=s1+' ';

  if OperateAttach in [ toaObjVoda, toaObjKanal ] then
    _adr := DM1.GetObjectName( DataSet.FieldByName( 'id_object' ).AsInteger )
  else
    _adr := DM1.Gen_Addr( '', Dataset.fieldByName( 'ul1' ).asString,
              Dataset.fieldByName( 'id_ul2' ).asString, Dataset.fieldByName( 'kod_ul' ).asString,
              Dataset.fieldByName( 'dop_adr' ).asString, DataSet.FieldByName( 'id_dopadres' ).asString );

 // Dataset.fieldByName('trimvvod').asString := s + '   ' + s1 + '   ' + _adr;

  //здесь будет проверяться отложена ли заявка by Vadim 26.02.2009
  if  Dataset.fieldByName('is_otl').AsInteger = 1 then _s_is_otl := ' отл. ' else
             _s_is_otl := '     ';

  //здесь будет проверяться наличие картинок для заявок by Vadim 12.02.2009
   _idzav := Dataset.fieldByName('id').AsInteger;
   DM_Main.ds_count.SelectSQL.Text := 'select count(id_zav) from avr_image where id_zav ='+ inttostr(_idzav) ;
   DM_Main.ds_count.Open;
   _count := DM_Main.ds_count.fieldByName('Count').AsInteger;
   if _count > 0 then
       _scount := inttostr(_count)
        else _scount := ' ';
//   Dataset.fieldByName('ImgCount').asString := _scount;
   DM_Main.ds_count.Close;
 { try
   _idzav := Dataset.fieldByName('id').AsInteger;
   _DmImage := TDM_AvrImage.CreateNew(nil, 0);
   _DmImage.dset_tmp.SelectSQL.Text := 'select count(id_zav) from avr_image where id_zav ='+ inttostr(_idzav) ;
   _DmImage.dset_tmp.Open;
   _count := _DmImage.dset_tmp.fieldByName('Count').AsInteger;
   if _count > 0 then
     Dataset.fieldByName('ImgCount').asString := inttostr(_count)
     else Dataset.fieldByName('ImgCount').asString := ' ';
  finally
    _DmImage.dset_tmp.Close;
    _DmImage := nil;
    _DmImage.Free;
  end;
  }

  Dataset.fieldByName('trimvvod').asString := s + '   ' + s1 + '   '+ _scount + '  ' + _s_is_otl + '  ' +'   ' + _adr;

end;

procedure TFormVvod.BB_DeleteAllClick(Sender: TObject);
var
  ID_List: string;
begin
  if not FIsCanDeleteAll then exit;

  
  if //Application.MessageBox('Вы уверены, что хотите очистить список нарядов?',
     //                     'Диспетчер АВР', MB_YESNO+MB_ICONWARNING)
     MessageDlg(TrLangMSG(msgCongirmCLearList),
                            mtConfirmation, [mbYes,mbNo], 0)=IDYES then
  begin
    ID_List:='';
    Qry_Sour.EnableControls;
    Qry_Sour.First;
    while not Qry_Sour.Eof do
    begin
      ID_List:=ID_List+Qry_Sour.FieldByName('ID').AsString+',';
      Qry_Sour.Next;
    end;
    delete(ID_List, length(ID_List), 1);

    if ID_List<>'' then
    begin
      Qry_Sour.Close;
      Qry_Find.Close;

      ID_List:='('+ID_List+')';
      MyExecSQL(Qry_tmp, 'delete from zavjav where id in'+ID_List);
      MyExecSQL(Qry_tmp, 'delete from nzavjav where id in'+ID_List);
      MyExecSQL(Qry_tmp, 'delete from narad where id_zav in'+ID_List);
      MyExecSQL(Qry_tmp, 'delete from nnarad where id_zav in'+ID_List);
      MyExecSQL(Qry_tmp, 'delete from maters where id_zav in'+ID_List);
      MyExecSQL(Qry_tmp, 'delete from obors where id_zav in'+ID_List);
      MyExecSQL(Qry_tmp, 'delete from works where id_zav in'+ID_List);
      MyExecSQL(Qry_tmp, 'delete from zadv where id_zavin in'+ID_List);
      MyExecSQL(Qry_tmp, 'delete from raskop where id_zavin in'+ID_List);
      MyExecSQL(Qry_tmp, 'delete from wwater where id_zav in'+ID_List);
      MyExecSQL(Qry_tmp, 'delete from bworks where id_zav in'+ID_List);
      MyExecSQL(Qry_tmp, 'delete from instrum where id_zav in'+ID_List);
      MyExecSQL(Qry_tmp, 'delete from objobor where id_zav in'+ID_List);
      MyExecSQL(Qry_tmp, 'delete from ord_people where id_zav in'+ID_List);
      MyExecSQL(Qry_tmp, 'delete from planobors where id_zav in'+ID_List);
    end;
  end;
end;

procedure TFormVvod.FormShow(Sender: TObject);
begin
  inherited;
  BB_DeleteAll.Visible:=FIsCanDeleteAll;
end;

end.
