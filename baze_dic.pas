unit baze_dic;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBCtrls, Grids, DBGrids, ExtCtrls, StdCtrls, Buttons, db, Placemnt, Menus,
  dbtables, RXDBCtrl, frmLANG, cntsLANG, variants;

type
  TBazeDicF = class(TFormLang)
    Panel1: TPanel;
    FindFd_pm: TPopupMenu;
    DataGrid_dgr: TRxDBGrid;
    Panel2: TPanel;
    BRefr: TSpeedButton;
    DBNav_dn: TDBNavigator;
    BDel: TSpeedButton;
    BNew: TSpeedButton;
    BHide: TSpeedButton;
    Bevel2: TBevel;
    BAutoRefr: TSpeedButton;
    BPrint: TSpeedButton;
    Finish_bv: TBevel;
    BExit: TSpeedButton;
    Panel3: TPanel;
    Label4: TLabel;
    Find_ed: TEdit;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    FormPlacement2: TFormPlacement;
//    procedure Find_sbClick(Sender: TObject);
    procedure Find_edChange(Sender: TObject);
    procedure DataGrid_dgrKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BExitClick(Sender: TObject);
    procedure DataGrid_dgrDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure BNewClick(Sender: TObject);
    procedure BDelClick(Sender: TObject);
    procedure BRefrClick(Sender: TObject);
    procedure Find_edKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure BAutoRefrClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBNav_dnClick(Sender: TObject; Button: TNavigateBtn);
    procedure BPrintClick(Sender: TObject);
    procedure BHideClick(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N4Click(Sender: TObject);

  private
    UseInsertTriger :boolean;
    NeedRefresh :boolean;
    DefFindTitleFtColor :TColor;
    FListFindFields :TStringList;
    FCurFindField :string;
    FAutoRefrDic :boolean;
    FRead_Only :boolean;
    function GetMI(Name_fd :string) :TMenuItem;
    procedure FindPMenuClick(Sender: TObject);
    procedure DicQrBeforePost(DataSet: TDataSet);
    procedure DicQrAfterPost(DataSet: TDataSet);
    procedure onDicStateChange(Sender: TObject);
    procedure FillFindPMenu(FieldList :TStringlist);
    function TitleFromDBGr(fd_name :string) :TColumnTitle;
    procedure SetListFindFields(fd_l :TStringList);
    procedure SetCurFindField(fd1 :string);
    procedure SetAutoRefrDic(fl :boolean);
    procedure SetRead_Only(fl :boolean);
    function GetMaxDicID :integer;

  protected
    CurDataSet :TDataSet;
    Table_Name :string;
    Key_Field :string;
    BazeFindStr :string;
    BazeCaption :string;
    DefWarnDelStr :string; // строка-запрос перед удалением записи
    WarnDelStrMultiSel :string;
    FindTitleFtColor :TColor;
    FNumbFindInField :integer;
    NotEmptyFields :array of string;
    UniqFields :array of string;
    procedure RefreshCaption;
    procedure CtrlState;virtual;
    procedure RefrData;

  public
    NewIDStorProcName :string;
    constructor CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);virtual;
    destructor Destroy;override;
    function onBeforeDel(var CanConfirm :boolean; var WarnDelStr :string) :boolean;virtual;
    procedure onAfterDel;virtual;
    function TestInpData :boolean;virtual;
    procedure Translate;override;

    property ListFindFields :TStringList read FListFindFields write SetListFindFields;
    property CurFindField :string read FCurFindField write SetCurFindField;
    property AutoRefrDic :boolean read FAutoRefrDic write SetAutoRefrDic;
    property Read_Only :boolean read FRead_Only write SetRead_Only;
   // property ShowDefEmptyValue :boolean read FShowDefEmptyValue write SetShowDefEmptyValue;
  end;


implementation
  uses main, avartype, datam, fresult, support;

{$R *.DFM}
//*******************************************************************
constructor TBazeDicF.CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);
begin
 inherited Create(AOwner);
 UseInsertTriger:=true;
 //FormPlacement1.IniFileName:=FullPathIniFlParams;
 BazeCaption:=Caption;
 NewIDStorProcName:='';
 BazeFindStr:=TrLangMSG(msgSearchOfField);
 FCurFindField:='';
 FNumbFindInField:=0;
 DefWarnDelStr:=TrLangMSG(msgDeleteRecord);
 NeedRefresh:=false;
 FindTitleFtColor:=clBlue;
 FListFindFields:=TStringList.Create;
// ListFindFields:=TStringList.Create;

{ DataGrid_dgr.Height:=Panel1.Height - DataGrid_dgr.Top - BRefr.Height - 12;
 Bevel1.Top:=DataGrid_dgr.Top + DataGrid_dgr.Height +2;
 BRefr.Top:=Bevel1.Top + 4;}
 Find_ed.Anchors:=[akLeft,akTop,akRight];
 DataGrid_dgr.Anchors:=[akLeft,akTop,akRight,akBottom];
//uo Bevel1.Anchors:=[akLeft,akRight,akBottom];
//uo Bevel2.Anchors:=[akLeft,akBottom];
 Finish_bv.Anchors:=[akLeft,akBottom];
 BRefr.Anchors:=[akLeft,akBottom];
 DBNav_dn.Anchors:=[akLeft,akBottom];
 BDel.Anchors:=[akLeft,akBottom];
 BNew.Anchors:=[akLeft,akBottom];
 BHide.Anchors:=[akLeft,akBottom];
 BAutoRefr.Anchors:=[akLeft,akBottom];
 BPrint.Anchors:=[akLeft,akBottom];
 BExit.Anchors:=[akRight,akBottom];

 BorderStyle:=bsSizeable;

 Self.Constraints.MinHeight:=150;
 Self.Constraints.MinWidth:=Finish_bv.Left + BExit.Width + 2;
 AutoRefrDic:=false;
 try
   DataGrid_dgr.DataSource:=Dsur;
   CurDataSet:=DataGrid_dgr.DataSource.DataSet;
//   TQuery(CurDataSet).UpdateObject:=UpdateQ_upd;
   //UpdateQ_upd.DataSet:=TQUery(CurDataSet);
   if assigned(DataGrid_dgr.DataSource)
      then DBNav_dn.DataSource:=DataGrid_dgr.DataSource;
   if not CurDataSet.Active then CurDataSet.Open;
   Table_Name:=TbName;//'';
   Key_Field:=KeyFd;  //CurDataSet.Fields[0].DisplayName;
   NewIDStorProcName:=AnsiUpperCase('NEWID_'+TbName);
   CurDataSet.BeforePost:=DicQrBeforePost;
   CurDataSet.AfterPost:=DicQrAfterPost;
 //  CurDataSet.AfterDelete:=DicQrAfterPost;
   DataGrid_dgr.DataSource.onStateChange:=onDicStateChange;
   RefreshCaption;
 except
  // внештатная ситуация, поскольку CurDataSet должен быть уже определен и активен
 end;
 Read_Only:=not FormMain.CanEdidDic;
 CtrlState;
end;

//*******************************************************************
destructor TBazeDicF.Destroy;
begin
 try
  if assigned(CurDataSet) then
    begin
     CurDataSet.BeforePost:=nil;
     CurDataSet.AfterPost:=nil;
     CurDataSet.AfterDelete:=nil;
    end;
  if assigned(DataGrid_dgr.DataSource)
    then DataGrid_dgr.DataSource.onStateChange:=nil;
   FListFindFields.Free;
 except
 end;
 inherited;
end;

//*******************************************************************
procedure TBazeDicF.SetCurFindField(fd1 :string);
var
 mi :TMenuItem;
 ct :TColumnTitle;
begin
 mi:=GetMI(fd1);
 if not assigned(mi) then exit;
 if FCurFindField <> '' then
   begin
    GetMI(FCurFindField).Checked:=false;
    TitleFromDBGr(FCurFindField).Font.Color:=DefFindTitleFtColor;
   end;
 ct:=TitleFromDBGr(fd1);
 DefFindTitleFtColor:=ct.Font.Color;
 ct.Font.color:=FindTitleFtColor;
 mi.Checked:=true;
 {if not (fd1.DataType in [ftString, ftSmallint, ftInteger, ftWord, ftBoolean,
            ftFloat, ftCurrency, ftDate, ftTime, ftDateTime,
            ftAutoInc,ftFixedChar, ftWideString, ftLargeint, ftVariant]) then exit;}
 FCurFindField:=fd1;
 Find_ed.Hint:=BazeFindStr+'"'+ct.Caption+'"';
 Find_edChange(self);
end;

//*******************************************************************
procedure TBazeDicF.SetAutoRefrDic(fl :boolean);
begin
 BAutoRefr.Down:=fl;
 FAutoRefrDic:=fl;
end;

//*******************************************************************
procedure TBazeDicF.SetRead_Only(fl :boolean);
begin
 DBNav_dn.Enabled:=not fl;
 BDel.Enabled:=not fl;
 BNew.Enabled:=not fl;
 BHide.Enabled:=not fl;
 BAutoRefr.Enabled:=not fl;
 BHide.Enabled:=not fl;
 if fl then DataGrid_dgr.Options:=DataGrid_dgr.Options - [dgEditing]
       else DataGrid_dgr.Options:=DataGrid_dgr.Options + [dgEditing];
 FRead_Only:=fl;
end;

//*******************************************************************
procedure TBazeDicF.Find_edChange(Sender: TObject);
var
 per_i,kod1 :integer;
 per_d :double;
 t_fd :TField;
begin
 if Assigned(CurDataSet) then
   try
    t_fd:=CurDataSet.FindField(CurFindField);
    if not assigned(t_fd) then exit;
    case t_fd.DataType of
     ftSmallint, ftInteger, ftWord, ftAutoInc, ftLargeint :
               begin
                 Val(Find_ed.Text, per_i, kod1);
                 if kod1 <> 0 then exit;
               end;
     ftFloat :begin
               Val(Find_ed.Text, per_d, kod1);
               if kod1 <> 0 then exit;
              end;

     ftString, ftFixedChar, ftWideString, ftVariant :
               if Trim(Find_ed.Text) = '' then exit;
       end; // case
       if not CurDataSet.Locate(CurFindField, Find_ed.Text, [loPartialKey])
     // почему-то отказывается работать loCaseInsensitive
       then CurDataSet.Locate(CurFindField, AnsiUpperCase(Find_ed.Text), [loPartialKey]);
   except // if Assigned(FdDataSet) ...
   end;
end;

//*******************************************************************
procedure TBazeDicF.DataGrid_dgrKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (Shift = [ssCtrl])and(key = VK_DELETE)
     then Key:=0
     else self.FormKeyDown(Sender, Key, Shift);
end;

//*******************************************************************
procedure TBazeDicF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if (CurDataSet.State in [dsInsert, dsEdit]) then
    
    if MessageBoxEx(self.handle,PChar(TrLangMSG(msgSaveChanges)),
            PChar(TrLangMSG(msgConfirm)),MB_YESNO + MB_ICONQUESTION, LANG_Ukrainian) = IDYES
        then CurDataSet.Post
        else
          if  TQuery(CurDataSet).CachedUpdates then TQuery(CurDataSet).CancelUpdates
                else  TQuery(CurDataSet).Cancel;
 // снимаем фильтр
 CurDataSet.filtered:=false;
 CurDataSet.Filter:='';
 Action:=caFree;
end;

//*******************************************************************
procedure TBazeDicF.BExitClick(Sender: TObject);
begin
 Close;
end;

//*******************************************************************
procedure TBazeDicF.RefreshCaption;
begin
 Caption:=BazeCaption;
 if (assigned(CurDataSet))and(CurDataSet.Active)
    then  Caption:=Caption + ' - '+TrLangMSG(msgCount)+' :'+IntToStr(CurDataSet.RecorDCount);
end;

//*******************************************************************
procedure TBazeDicF.BNewClick(Sender: TObject);
begin
 AddNewRec(CurDataSet, DataGrid_dgr);
end;

//*******************************************************************
procedure TBazeDicF.BDelClick(Sender: TObject);
var
 i :integer;
 confirm_f :boolean;
 WnDelStr :string;
begin
 with DM1 do
  begin
   if (CurDataSet.EOF)and(assigned(CurDataSet.FindField(Key_Field)))
      then if CurDataSet.FieldByName(Key_Field).asstring = '' then exit;
   if not onBeforeDel(confirm_f, WnDelStr) then exit;
//   if not Db_Avar.InTransaction then Db_Avar.StartTransaction;
    try
     if DataGrid_dgr.SelectedRows.Count > 1 then
       begin
        if MessageDlg(TrLangMSG(msgDeleteMore)+' ('+TrLangMSG(msgCount)+' :'+
             IntToStr(DataGrid_dgr.SelectedRows.Count)+') ?',
                            mtConfirmation, [mbYes,mbNo], 0)
         {MessageBoxEx(self.handle,PChar(TrLangMSG(msgDeleteMore)+' ('+TrLangMSG(msgCount)+' :'+
             IntToStr(DataGrid_dgr.SelectedRows.Count)+') ?'),
            PChar(TrLangMSG(msgConfirm)),MB_YESNO + MB_ICONQUESTION, LANG_Ukrainian)} <> IDYES then exit;
        for i:=0 to DataGrid_dgr.SelectedRows.Count-1 do
          begin
           CurDataSet.GotoBookmark(pointer(DataGrid_dgr.SelectedRows.Items[i]));
           DelRec(self.handle, CurDataSet, '', false);
          end; // for
       end // if DataGrid_dgr.SelectedRows.Count > 1 ...
         else DelRec(self.handle, CurDataSet, WnDelStr, confirm_f);
   // Db_Avar.Commit;
    SaveChangesQuery(TQuery(CurDataSet));
    onAfterDel;
   except
    TQuery(CurDataSet).CancelUpdates;
  //  Db_Avar.Rollback;
   end;
 end; // with
end;

//*******************************************************************
function TBazeDicF.onBeforeDel(var CanConfirm :boolean; var WarnDelStr :string) :boolean;
begin
 CanConfirm:=true;
 WarnDelStr:=DefWarnDelStr;
 result:=true;
end;

//*******************************************************************
procedure TBazeDicF.onAfterDel;
begin
 RefreshCaption;
end;

//*******************************************************************
function TBazeDicF.TestInpData :boolean;
var
 i :integer;
 fd1 :TField;
 s1, str1,cap1 :string;
begin
 result:=true;

 if CurDataSet.FieldByName('del').AsString='d' then exit; // закрыть можно, открыть нельзя

 for i:=low(NotEmptyFields) to high(NotEmptyFields) do
   begin
    result:=(not Empty_ValueInCt(CurDataSet.FieldByName(NotEmptyFields[i]), self.handle,
           'Необходимо ввести '+TitleFromDBGr(NotEmptyFields[i]).Caption));
    if not result then exit;
   end;

 if Table_Name = '' then exit;
 str1:='';
 cap1:='';
 for i:=low(UniqFields) to high(UniqFields) do
   begin
    fd1:=CurDataSet.FieldByName(UniqFields[i]);
    if fd1.DataType in [ftSmallint, ftInteger, ftWord, ftAutoInc, ftLargeint]
       then s1:=fd1.asString
       else begin
         s1:=InSTRValue(AnsiUpperCase(fd1.asString));
         cap1:=cap1+' '+CurDataSet.FieldByName(UniqFields[i]).asString;
       end;
    if (trim(s1) <> '') then
      begin
       if (str1<>'') then str1:=str1+'and';
        str1:=str1+Format('(upper(%s) = %s)and(%s <> %s)', [fd1.DisplayName, s1,
                  CurDataSet.FieldByName(Key_Field).DisplayName, IntToStr(CurDataSet.FieldByName(Key_Field).asInteger)]);
       end;           
   end;
  if str1<>''
  then begin
    result:= Uniq_Value(Format('SELECT * FROM %s WHERE del=''-'' and %s', [Table_Name, str1]),
               DataGrid_dgr, Self.Handle,
               trim(cap1)+TrLangMSG(msgExistError));
    if not result then exit;
  end
end;

//*******************************************************************
procedure TBazeDicF.FillFindPMenu(FieldList :TStringlist);
var
 mi :TMenuItem;
 i :integer;
 fd1 :TField;
begin
 FindFd_pm.Items.Clear;
 try
  if (not assigned(FieldList))or(FieldList.Count = 0) then exit;
  for i:=0 to FieldList.Count-1 do
   begin
    fd1:=CurDataSet.FindField(FieldList.Strings[i]);
    if not assigned(fd1) then exit;
     if fd1.DataType in [ftString, ftSmallint, ftInteger,
              ftWord, ftBoolean, ftFloat, ftCurrency, ftDate, ftTime, ftDateTime,
              ftAutoInc,ftFixedChar, ftWideString, ftLargeint] then
       begin
        mi:=TMenuItem.Create(self);
        mi.Caption:=TitleFromDBGr(FieldList.Strings[i]).Caption;
        mi.Hint:=FieldList.Strings[i];
        mi.OnClick:=FindPMenuClick;
        if mi.Caption <> ''
           then FindFd_pm.Items.Add(mi)
           else mi.Free;
       end; // for
   end;
  except
  end;
end;

//*******************************************************************
function TBazeDicF.TitleFromDBGr(fd_name :string) :TColumnTitle;
var
 i :integer;
begin
 result:=nil;
 for i:=0 to DataGrid_dgr.Columns.Count-1 do
   if AnsiUpperCase(DataGrid_dgr.Columns[i].FieldName) =
      AnsiUpperCase(fd_name)  then
    begin
     result:=DataGrid_dgr.Columns[i].Title;
     exit;
    end;
end;

//*******************************************************************
function TBazeDicF.GetMI(Name_fd :string) :TMenuItem;
var
 i :integer;
begin
 result:=nil;
 // поскольку в данном меню вложенность отсутствует, то рекурсия не используетcя
 for i:=0 to FindFd_pm.Items.Count-1 do
  if FindFd_pm.Items.Items[i].Hint = Name_fd then
    begin
     result:=FindFd_pm.Items.Items[i];
     exit;
    end;
end;

//*******************************************************************
procedure TBazeDicF.FindPMenuClick(Sender: TObject);
begin
 CurFindField:=TMenuItem(Sender).Hint;
end;

//*******************************************************************
procedure TBazeDicF.RefrData;
var
 bk :TBookmark;
 _id :integer;
begin
 NeedRefresh:=false;
 if (CurDataSet.Active) then
   begin
    bk:=nil; _id:=unAssigned;
    if assigned(CurDataSet.FindField(Key_Field))
       then begin
             _id:=CurDataSet.FieldByName(Key_Field).asInteger;
             if (UseInsertTriger)and(_id = 0){новая запись} then _id:=GetMaxDicID;
            end
       else bk:=CurDataSet.GetBookmark;
    CurDataSet.Close;
    CurDataSet.Open;
    try
     if CurDataSet.EOF then exit;
     if assigned(bk) then
       begin
         CurDataSet.GotoBookmark(bk);
         CurDataSet.FreeBookmark(bk);
       end // if (not CurDataSet.EOF)and(assigned(bk)) ...
         else CurDataSet.Locate(Key_Field, _id, []);
    except
    end;
   end; // if CurDataSet.Active ...
 CtrlState;
end;

//*******************************************************************
procedure TBazeDicF.CtrlState;
begin
 if CurDataSet.Active then
  begin
   if not Read_Only then
    begin
     ButCtrlState(CurDataSet, BNew, BDel, BHide, DataGrid_dgr);
     BRefr.Enabled:=BDel.Enabled;//not (CurDataSet.State in [dsInsert, dsEdit]);
    end
     else BRefr.Enabled:=(CurDataSet.RecordCount > 0);
  end // if CurDataSet.Active ...
   else begin
         BRefr.Enabled:=false;
         BNew.Enabled:=false;
         BDel.Enabled:=false;
         BHide.Enabled:=false;
        end;
end;

//*******************************************************************
procedure TBazeDicF.BRefrClick(Sender: TObject);
begin
 RefrData;
end;

//*******************************************************************
procedure TBazeDicF.Find_edKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (Key = VK_DOWN)or(Key = VK_UP)
    then DataGrid_dgr.SetFocus
    else self.FormKeyDown(Sender, Key, Shift);
end;

//*******************************************************************
procedure TBazeDicF.FormShow(Sender: TObject);
var
 l :TStringlist;
 i :integer;
begin
 if FindFd_pm.Items.Count = 0 then
  begin
   l:=TStringlist.Create;
   for i:=0 to DataGrid_dgr.FieldCount-1 do
    if assigned(DataGrid_dgr.Fields[i])
       then l.add(DataGrid_dgr.Fields[i].DisplayName);
   if l.count = 0 then exit;
   ListFindFields:=l;
   if (CurFindField <> '')and(ListFindFields.Count > 0)
      then CurFindField:=ListFindFields.Strings[0];
   l.Free;
  end;
end;

//*******************************************************************
procedure TBazeDicF.DicQrBeforePost(DataSet: TDataSet);
var
 n_id :integer;
begin
 if TestInpData then
   begin
    if CurDataSet.state = dsInsert then
     begin
      NeedRefresh:=UseInsertTriger;
      if not UseInsertTriger then
        begin
         n_id:=GetDicNewID(NewIDStorProcName);
         if n_id > 0 then CurDataSet.FieldByName(Key_Field).Value:=n_id
                     else begin
                           abort;
                           exit;
                          end;
        end; // if not UseInsertTriger ...
     end; // if S_Brig_q.state = dsInsert ...
   end // if DolgnFaceF.TestInpData ...
    else Abort;
end;

//*******************************************************************
procedure TBazeDicF.DicQrAfterPost(DataSet: TDataSet);
begin
 SaveChangesQuery(TQuery(DataSet));
 if (AutoRefrDic)or(NeedRefresh) then RefrData;
 RefreshCaption;
end;

//*******************************************************************
procedure TBazeDicF.onDicStateChange(Sender: TObject);
begin
 CtrlState;
end;

//*******************************************************************
procedure TBazeDicF.SetListFindFields(fd_l :TStringList);
begin
 FListFindFields.text:=fd_l.text;
 FillFindPMenu(FListFindFields);
end;

//*******************************************************************
procedure TBazeDicF.BAutoRefrClick(Sender: TObject);
begin
 AutoRefrDic:=BAutoRefr.Down;
end;

//*******************************************************************
procedure TBazeDicF.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Read_Only then exit;
 if (Shift = [ssCtrl]) then
   case Key of
     ord('N') :BNewClick(self);
     ord('D') :BDelClick(self);
    end // case
     else if (Key = VK_F2)and(CurDataSet.state in [dsInsert, dsEdit])
             then CurDataSet.Post;
end;

//*******************************************************************
function TBazeDicF.GetMaxDicID :integer;
begin
 result:=0;
 with DM1 do
  begin
   tempQr_q.SQL.Clear;
   if (key_field = '')or(Table_Name = '') then exit;
   tempQr_q.SQL.Add(Format('select max(%s) from %s',[key_field, Table_Name]));
   try
    tempQr_q.Open;
    result:=tempQr_q.Fields[0].asInteger;
   except
   end;
  end; // with
end;

//*******************************************************************
procedure TBazeDicF.DBNav_dnClick(Sender: TObject; Button: TNavigateBtn);
begin
 if Button = nbCancel then NeedRefresh:=false;
end;

//*******************************************************************
procedure TBazeDicF.BPrintClick(Sender: TObject);
var
 sTit :TstringList;
 FRes:TFormResult;
 top_label :string;
// sql_txt :string;
 i :integer;
begin
 sTit:=TstringList.Create;
 for i:=0 to DataGrid_dgr.Columns.Count-1 do
   if  (DataGrid_dgr.Columns[i].Visible) then sTit.Add(DataGrid_dgr.Columns[i].Title.Caption);
 top_label:=BazeCaption;

 FRes:=TFormResult.ResCreate(Self,false,'dbn_avar','Результат',top_label,'',
           sTit,-1,nil,false, true{группировка}, false{не заполнять StringGrid});
 FRes.Show;
 with FRes do
  begin
   NumCols:=0;
   PrBar.Position:=0;
   PrBar.Max:=CurDataSet.RecordCount +10;
   ShowProgress:=true; // ds
   CurDataSet.DisableControls;
   try
     CurDataSet.First;
     while not CurDataSet.EOF do
      begin
       for i:=0 to DataGrid_dgr.Columns.Count-1 do
         StrGr_res.Cells[i,StrGr_res.RowCount-1]:=
            CurDataSet.FieldByName(DataGrid_dgr.Columns[i].FieldName).asString;
        CurDataSet.Next;
        StrGr_res.RowCount:=StrGr_res.RowCount+1;
        inc(FRes.NumCols);
        PrBar.Position:=PrBar.Position+1;
        StatusBar1.Repaint;
      end; // while

     FRes.Caption:=Format(TrLangMSG(msgCount)+': %d',[NumCols]);
     PrBar.Position:=PrBar.Max - 5;
     isIdView:=true;
     ChLB_Pol.ApplyState(cbChecked,false);
     Upd_Cols;
     PrBar.Position:=PrBar.Max;
     ShowProgress:=false; // ds
     StrGr_res.AdjustColWidths;
     StrGr_res.SetFocus;
   finally
     CurDataSet.EnableControls;
   end;
 end; // with
 sTit.Free;
end;

//*******************************************************************
procedure TBazeDicF.BHideClick(Sender: TObject);
begin
  DataGrid_dgr.DataSource.dataset.Edit;
  if DataGrid_dgr.DataSource.dataset.FieldByName('DEL').AsString='d'
  then DataGrid_dgr.DataSource.dataset.FieldByName('DEL').AsString:='-'
  else DataGrid_dgr.DataSource.dataset.FieldByName('DEL').AsString:='d';
  DataGrid_dgr.DataSource.dataset.Post;
end;

//*******************************************************************
procedure TBazeDicF.DataGrid_dgrDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if DataGrid_dgr.DataSource.dataset.FieldByName('DEL').AsString='d'
  then begin
    if(State=[])
    then begin
      DataGrid_dgr.Canvas.Font.Color:=clBlack;
      DataGrid_dgr.Canvas.brush.Color:=clYellow
    end;
    if(gdSelected in State)
    then begin
      DataGrid_dgr.Canvas.Font.Color:=clYellow;
    end;
  end;
  DataGrid_dgr.DefaultDrawColumnCell( Rect, DataCol,Column,State);
end;

procedure TBazeDicF.N3Click(Sender: TObject);
begin
  inherited;
  CurDataSet.Filter:='del=''-''';
  CurDataSet.Filtered:=true;
  N3.checked:=true;
  N2.checked:=false;
  N4.checked:=false;
end;

procedure TBazeDicF.N2Click(Sender: TObject);
begin
  inherited;
  CurDataSet.Filter:='';
  CurDataSet.Filtered:=false;
  N2.checked:=true;
  N3.checked:=false;
  N4.checked:=false;
end;

procedure TBazeDicF.N4Click(Sender: TObject);
begin
  inherited;
  CurDataSet.Filter:='del=''d''';
  CurDataSet.Filtered:=true;
  N4.checked:=true;
  N2.checked:=false;
  N3.checked:=false;
end;

procedure TBazeDicF.Translate;
begin
  inherited;
  BRefr.Hint:=TrLangMSG(msgRefresh);
  BDel.Hint:=TrLangMSG(msgDelete)+' (Ctrl + D)';
  BNew.Hint:=TrLangMSG(msgAdd)+' (Ctrl + N)';
  BHide.Hint:=TrLangMSG(msgHideShow);
  BAutoRefr.Hint:=TrLangMSG(msgAutoRefresh);
  BPrint.Hint:=TrLangMSG(msgPrint);
  BExit.Hint:=TrLangMSG(msgExit);
  DBNav_dn.Hints.commatext:=TrLangMSG(msgDBNavigatorHints);
  Label4.Caption:=TrLangMSG(msgSearch);
  N1.Caption:=TrLangMSG(msgSpravochOne);
  N2.Caption:=TrLangMSG(msgDictAll);
  N3.Caption:=TrLangMSG(msgDictShow);
  N4.Caption:=TrLangMSG(msgDictHide);
end;

end.
