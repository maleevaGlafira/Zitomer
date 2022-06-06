unit S_OborType;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  baze_dic, Menus, Placemnt, Grids, DBGrids, RXDBCtrl, DBCtrls, StdCtrls,
  Buttons, ExtCtrls, db, frmLANG, cntsLANG, IBDatabase, IBSQL,
  IBCustomDataSet, DMMain, IBScript, ValEdit, IBQuery;

type
  TS_OborTypeF = class(TBazeDicF)
    bb_Sostav: TBitBtn;
    dset_OborGroup: TIBDataSet;
    IBSQL: TIBSQL;
    tran: TIBTransaction;
    ds_OborGroup: TDataSource;
    dset_OborGroupID: TIntegerField;
    dset_OborGroupOBORTYPE: TIntegerField;
    dset_OborGroupDETAIL: TIntegerField;
    dset_OborGroupDEL: TIBStringField;
    dset_OborGrouplook_obortype: TStringField;
    Panel4: TPanel;
    p_Group: TPanel;
    GroupGrid: TRxDBGrid;
    Panel5: TPanel;
    sb_Add: TSpeedButton;
    sb_Del: TSpeedButton;
    sb_Post: TSpeedButton;
    sb_cancel: TSpeedButton;
    dbn_Group: TDBNavigator;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    p_Params: TPanel;
    Panel6: TPanel;
    dbg_Params: TRxDBGrid;
    dset_OborTypeParams: TIBDataSet;
    ds_OborTypeParams: TDataSource;
    dset_OborTypeParamsID: TIntegerField;
    dset_OborTypeParamsNAME_R: TIBStringField;
    dset_OborTypeParamsP_VALUE: TIBStringField;
    dset_OborTypeParamsMEASURE: TIBStringField;
    dset_OborTypeParamsID_OBORTYPE: TIntegerField;
    dset_OborTypeParamsID_FIELD: TIntegerField;
    dset_OborTypeParamsSOF_ID: TIntegerField;
    bb_OK: TBitBtn;
    bb_Cancel: TBitBtn;
    IBScript: TIBScript;
    ValueListEditor: TValueListEditor;
    Splitter3: TSplitter;
    dset_ParamLook: TIBDataSet;
    ds_ParamLook: TDataSource;
    dset_ParamLookP_PARAM: TIBStringField;
    dset_ParamLookP_VALUE: TIBStringField;
    dset_tmp: TIBQuery;
    btn_del: TBitBtn;
    btn_Edit: TBitBtn;
    tran_exec: TIBTransaction;
    procedure bb_SostavClick(Sender: TObject);
    procedure MyChangeSizeForm(_vis: boolean);
    procedure sb_AddClick(Sender: TObject);
    procedure sb_DelClick(Sender: TObject);
    procedure sb_PostClick(Sender: TObject);
    procedure sb_cancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dset_OborGroupBeforePost(DataSet: TDataSet);
    procedure DBNav_dnClick(Sender: TObject; Button: TNavigateBtn);
    procedure dset_OborTypeParamsBeforePost(DataSet: TDataSet);
    procedure bb_OKClick(Sender: TObject);
    procedure bb_CancelClick(Sender: TObject);
    procedure dset_OborTypeParamsBeforeEdit(DataSet: TDataSet);
    procedure dset_OborTypeParamsAfterInsert(DataSet: TDataSet);
    procedure dset_OborGroupAfterScroll(DataSet: TDataSet);
    procedure btn_delClick(Sender: TObject);
    procedure btn_EditClick(Sender: TObject);
  private
    { Private declarations }
    InsertList, UpdateList: TStringList;
    F_CurrentOborTypeID: integer;
    F_OldAfterScroll,
    F_OldAfterPost,
    F_OldBeforePost,
    F_OldAfterCancel,
    F_OldAfterInsert: TDataSetNotifyEvent;
    isEdited : boolean;
    procedure NewAfterScroll(DataSet: TDataSet);
    procedure NewAfterPost(DataSet: TDataSet);
    procedure NewBeforePost(DataSet: TDataSet);
    procedure NewAfterCancel(DataSet: TDataSet);
    procedure NewAfterInsert(DataSet: TDataSet);
    function GetCurrentOborTypeID: integer ;
    procedure InitFrame;
    procedure EnableBtns( bValue: boolean );
    function IsSostObor: boolean;
    procedure FillOborTypeParams;
    procedure InsertOrUpdateParams;
    procedure ChangeStatus(value: boolean);
  public
    { Public declarations }
    constructor CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);override;
    destructor Destroy;override;
    procedure Translate;override;    
  end;

var
  S_OborTypeF: TS_OborTypeF;

implementation

uses datam, avartype;

{$R *.dfm}
constructor TS_OborTypeF.CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);
var
 fdl :TStringList;
begin
 if DM1.s_obortypeglob_q.Active then DM1.s_obortypeglob_q.Close;

  dm1.s_obortypeglob_q.SQL.Text :=
   ' SELECT s.id, s.Name_r,  s.del'+
   ' FROM s_obortypeglob s '+
   ' ORDER BY s.Name_r ';
  DM1.s_obortypeglob_q.Open;

 inherited CreateDic(AOwner, TbName,KeyFd, DSur);
 if not DM1.S_YesNo_q.Active then DM1.S_YesNo_q.Open;




 DM1.s_obortype_look.SQL.Text := ' SELECT s.id, s.Name_r,  s.differ,s.del '+
       ' FROM s_obortype s '+
       ' WHERE s.id > 0    '+
       ' and s.id <> :aid'+
       ' ORDER BY s.Name_r ';

 DM1.s_obortype_look.ParamByName('aid').DataType := ftInteger;
 DM1.s_obortype_look.ParamByName('aid').ParamType := ptInput;

{ NewIDStorProcName:='NEWID_S_REVS';
 Table_Name:='S_REVS';}
 fdl:=TStringList.Create;
 fdl.Add('Name_r');
 ListFindFields:=fdl;
 CurFindField:='Name_r';
 fdl.Free;

 SetLength(NotEmptyFields, 1);
 NotEmptyFields[0]:='Name_r';
 SetLength(UniqFields, 2);
 UniqFields[0]:='Name_r';
 UniqFields[1]:='id_obortypeglob';



 F_OldAfterScroll := CurDataSet.AfterScroll;
 CurDataSet.AfterScroll := NewAfterScroll;
 F_OldAfterPost := CurDataSet.AfterPost;
 CurDataSet.AfterPost := NewAfterPost;

 F_OldBeforePost := CurDataSet.BeforePost;
 CurDataSet.BeforePost := NewBeforePost;

 F_OldAfterCancel := CurDataSet.AfterCancel;
 CurDataSet.AfterCancel := NewAfterCancel;
 F_OldAfterInsert := CurDataSet.AfterInsert;
 CurDataSet.AfterInsert := NewAfterInsert;
 //
 InitFrame;
 ChangeStatus(false);

// if not DM1.s_obortypegroup_q.Active then DM1.s_obortypegroup_q.Open;

end;


//*******************************************************************
destructor TS_OborTypeF.Destroy;
begin
 try
  if tran.InTransaction then tran.Commit;
 except
   on E: Exception do
    begin
      tran.Rollback;
      E.Message := E.Message + '(TS_OborTypeF.Destroy)';
      raise;
    end;  
 end;

 CurDataSet.AfterScroll := F_OldAfterScroll;
 inherited;
 S_OborTypeF:=nil;
end;

Function TS_OborTypeF.GetCurrentOborTypeID;
begin
  if CurDataSet.Active then
    Result := CurDataSet.FieldByName( 'ID' ).AsInteger
    else
    Result := 0;
end;


procedure TS_OborTypeF.Translate;
begin
  inherited;
  Caption:= TrLangMSG(msgSpravochOne)+' '+TrLangMSG(msgTypEquip);
  Label4.Caption:=TrLangMSG(msgSearch);
  BRefr.Hint:=TrLangMSG(msgRefresh);//Обновить
  BDel.Hint:=TrLangMSG(msgDelete)+'(Ctrl + D)';// Удалить
  BNew.Hint:=TrLangMSG(msgAdd)+ '(Ctrl + N) ';// Добавить
  BHide.Hint:=TrLangMSG(msgHideShow);//  Видимость/Невидимость
  BAutoRefr.Hint:=TrLangMSG(msgAutoRefresh);
  BPrint.Hint:=TrLangMSG(msgPrint);
  BExit.Hint:=TrLangMSG(msgExit);
//  bb_Sostav.Caption



  DataGrid_dgr.Columns[0].Title.Caption:= TrLangMSG(msgDesign);
  DataGrid_dgr.Columns[1].Title.Caption:= TrLangMSG(msgDesign);
  DataGrid_dgr.Columns[2].Title.Caption:= TrLangMSG(msgDesign);


end;

procedure TS_OborTypeF.FillOborTypeParams;
   begin
      if dset_OborTypeParams.Active then dset_OborTypeParams.Close;
      dset_OborTypeParams.ParamByName('pid').AsInteger := F_CurrentOborTypeID;
      dset_OborTypeParams.Open;
   end;


procedure TS_OborTypeF.InitFrame;
  procedure FillOborGroupe;
   begin

      GroupGrid.Visible := true;
      dbn_Group.Enabled := true;
      ValueListEditor.Visible := true;

      if dset_OborGroup.Active then dset_OborGroup.Close;
      if DM1.s_obortype_look.Active then DM1.s_obortype_look.Close;

      dset_OborGroup.ParamByName('obortype').AsInteger := F_CurrentOborTypeID;
      DM1.s_obortype_look.ParamByName('aid').AsInteger := F_CurrentOborTypeID;
      dset_OborGroup.Open;
      DM1.s_obortype_look.Open;
   end;

begin
  try
    F_CurrentOborTypeID := GetCurrentOborTypeID;
    if ( dset_OborGroup.State = dsEdit) or (dset_OborGroup.State = dsInsert) then
        dset_OborGroup.Cancel;

    if tran.InTransaction then tran.Commit;

    tran.StartTransaction;

    if IsSostObor then FillOborGroupe
    else
    begin
     GroupGrid.Visible := false;
     dbn_Group.Enabled := false;
     ValueListEditor.Visible := false;
    end;
    FillOborTypeParams;
  except
    on E: Exception do
    begin
      tran.Rollback;
      E.Message := E.Message + '(TS_OborTypeF.InitFrame)';
      raise;
    end;
  end; //except

end;

function TS_OborTypeF.IsSostObor: boolean;
begin
  //
   if CurDataSet.Active then
    Result := (CurDataSet.FieldByName( 'DIFFER' ).AsInteger = 1);
end;

procedure TS_OborTypeF.NewAfterScroll(DataSet: TDataSet);
begin
  if Assigned( F_OldAfterScroll ) then
    F_OldAfterScroll( DataSet );


  if (isEdited or (dset_OborTypeParams.State in [dsInsert, dsEdit])) then
   if MessageDlg('Сохраниить изменения в параметрах?',mtConfirmation, [mbYes, mbNo], 0 ) = mrYes
    then InsertOrUpdateParams;


  InitFrame;
//  if Visible then
//    F_CurrentOborTypeID := CurDataSet.FieldByName( 'ID' ).AsInteger;
end;


procedure TS_OborTypeF.bb_SostavClick(Sender: TObject);
begin
  inherited;
//
 p_Group.Visible := not p_Group.Visible;
 MyChangeSizeForm( p_Group.Visible );
end;


procedure TS_OborTypeF.MyChangeSizeForm(_vis: boolean);
begin
   //
   if _vis then
    begin
      DataGrid_dgr.Align := alTop;
      DataGrid_dgr.Height := DataGrid_dgr.Height div 2;
      Panel2.Align:= alTop;
    end
    else
    begin
      DataGrid_dgr.Align := alClient;
      Panel2.Align:= alBottom;
    end;
end;

procedure TS_OborTypeF.sb_AddClick(Sender: TObject);
begin
  inherited;
  DM1.s_obortypegroup_q.Insert;
  DM1.s_obortypegroup_q.FieldByName('obortype').AsInteger :=
                      DM1.s_obortype_q.FieldByName('id').AsInteger;
  sb_Add.Enabled:= false;
  sb_Del.Enabled:= false;
  sb_Post.Enabled := true;
  sb_cancel.Enabled := true;
end;

procedure TS_OborTypeF.sb_DelClick(Sender: TObject);
begin
  inherited;
  DM1.s_obortypegroup_q.Delete;
end;

procedure TS_OborTypeF.sb_PostClick(Sender: TObject);
begin
  inherited;
  dset_OborGroup.Post;

  sb_Post.Enabled := false;
  sb_Add.Enabled:= true;
  sb_Del.Enabled:= true;

end;

procedure TS_OborTypeF.sb_cancelClick(Sender: TObject);
begin
  inherited;
  DM1.s_obortypegroup_q.Cancel;
  sb_cancel.Enabled := false;
  sb_Add.Enabled:= true;
  sb_Del.Enabled:= true;

end;

procedure TS_OborTypeF.FormShow(Sender: TObject);
begin
  inherited;
//  F_CurrentOborTypeID := CurDataSet.FieldByName( 'ID' ).AsInteger;
end;

procedure TS_OborTypeF.NewAfterPost(DataSet: TDataSet);
begin
  if Assigned( F_OldAfterPost ) then
    F_OldAfterPost( DataSet );

 SaveChangesQuery(DM1.s_obortypegroup_q);

  if Visible then
   EnableBtns( true );
end;


procedure TS_OborTypeF.NewBeforePost(DataSet: TDataSet);
begin
  if Assigned( F_OldBeforePost ) then
    F_OldBeforePost( DataSet );

//  if ( dset_OborGroup.State = dsEdit) or (dset_OborGroup.State = dsInsert) then
//    dset_OborGroup.FieldByName('OBORTYPE').AsInteger := F_CurrentOborTypeID;

end;


procedure TS_OborTypeF.NewAfterCancel(DataSet: TDataSet);
begin
  if Assigned( F_OldAfterCancel ) then
    F_OldAfterCancel( DataSet );

  if Visible then
   EnableBtns( true );
end;

procedure TS_OborTypeF.NewAfterInsert(DataSet: TDataSet);
begin
  if Assigned( F_OldAfterInsert ) then
    F_OldAfterInsert( DataSet );

  if Visible then
   EnableBtns( false );
end;



procedure TS_OborTypeF.EnableBtns( bValue: boolean );
begin
   //
   dbn_Group.Enabled := bValue;
   GroupGrid.Enabled := bValue;
end;

procedure TS_OborTypeF.dset_OborGroupBeforePost(DataSet: TDataSet);
begin
  inherited;
  //
  if ( dset_OborGroup.State = dsEdit) or (dset_OborGroup.State = dsInsert) then
    dset_OborGroup.FieldByName('OBORTYPE').AsInteger := F_CurrentOborTypeID;

end;

procedure TS_OborTypeF.dset_OborTypeParamsBeforePost(DataSet: TDataSet);
begin
  inherited;
  if ( dset_OborTypeParams.State = dsEdit) or (dset_OborTypeParams.State = dsInsert) then
   begin
    dset_OborTypeParams.FieldByName('ID_OBORTYPE').AsInteger := F_CurrentOborTypeID;
//    dset_OborTypeParams.FieldByName('ID_FIELD').AsInteger := F_CurrentOborTypeID;
   end;
end;

procedure TS_OborTypeF.DBNav_dnClick(Sender: TObject;
  Button: TNavigateBtn);
begin
  inherited;
  InitFrame;
end;


procedure TS_OborTypeF.bb_OKClick(Sender: TObject);
begin
  inherited;

    InsertOrUpdateParams;

  dset_OborTypeParams.Close;
  dset_OborTypeParams.Open;

 ChangeStatus(false);
end;

procedure TS_OborTypeF.InsertOrUpdateParams;
var id, id_obortype, id_field, p_value: string;
    _c: integer;
    _add: boolean;

   function orInsert: string;
   begin
     result := 'INSERT INTO S_OT_PARAMS (ID_OBORTYPE, ID_FIELD, P_VALUE) '+
        ' VALUES ( '+ id_obortype + ', '+ id_field + ', '''+ p_value +''');';
   end;

   function orUpdate: string;
   begin
    result :=' UPDATE S_OT_PARAMS SET '+
              ' ID_OBORTYPE = '+ id_obortype +
              ', ID_FIELD = '+ id_field +
              ', P_VALUE = '''+ p_value + '''' +
                ' WHERE (ID = '+ id +'); ';
   end;

begin
   //
   _c := 0;
   _add := true;

   //tran_exec.StartTransaction;

   dset_OborTypeParams.First;
   IBScript.Script.Clear;
   while not dset_OborTypeParams.Eof do
   begin

     id_obortype := dset_OborTypeParams.FieldByName('id_obortype').AsString;
     if trim(id_obortype) = '' then  _add := false; //id_obortype := 'null';
     id_field := dset_OborTypeParams.FieldByName('sof_id').AsString;
     if trim(id_field) = '' then _add := false;//id_field := 'null';
     p_value := trim(dset_OborTypeParams.FieldByName('p_value').AsString);

     if _add then
       if dset_OborTypeParams.FieldByName('id').IsNull then
        IBScript.Script.Add(orInsert)
        else
        begin
          id := dset_OborTypeParams.FieldByName('id').AsString;
          IBScript.Script.Add(orUpdate);
        end;

     dset_OborTypeParams.Next;
   end;
//   try
   IBScript.ExecuteScript;
  // tran_exec.Commit;
  // except

  //   tran_exec.Rollback;
  // end;

   ChangeStatus(false);
end;



procedure TS_OborTypeF.bb_CancelClick(Sender: TObject);
begin
  inherited;

  if dset_OborTypeParams.State in [dsInsert , dsEdit] then dset_OborTypeParams.Cancel;
  InitFrame;
  ChangeStatus(false);
end;

procedure TS_OborTypeF.dset_OborTypeParamsBeforeEdit(DataSet: TDataSet);
begin
  inherited;
  ChangeStatus(true);
end;

procedure TS_OborTypeF.ChangeStatus(value: boolean);
begin
  bb_OK.Enabled := value;
  bb_Cancel.Enabled := value;
  isEdited := value;
end;

procedure TS_OborTypeF.dset_OborTypeParamsAfterInsert(DataSet: TDataSet);
begin
  inherited;
  DataSet.Cancel;
end;

procedure TS_OborTypeF.dset_OborGroupAfterScroll(DataSet: TDataSet);
var _col : integer;

begin
  inherited;
//
 _col := ValueListEditor.RowCount;
  while _col > 2 do
  begin
   ValueListEditor.DeleteRow(_col-1);
    _col := _col - 1;
  end;
  ValueListEditor.Values[ValueListEditor.Keys[1]] := ' ';
  ValueListEditor.Keys[1] := ' ';


  if dset_ParamLook.Active then dset_ParamLook.Close;
  dset_ParamLook.ParamByName('pid').AsInteger := dset_OborGroup.FieldByName('detail').AsInteger;
  dset_ParamLook.Open;
  dset_ParamLook.First;
  ValueListEditor.Keys[1] := dset_ParamLook.FieldByName('p_param').AsString;
  ValueListEditor.Values[ValueListEditor.Keys[1]] := dset_ParamLook.FieldByName('p_value').AsString;
  dset_ParamLook.Next;
  while not dset_ParamLook.Eof do
  begin

    ValueListEditor.InsertRow( dset_ParamLook.FieldByName('p_param').AsString
                              ,dset_ParamLook.FieldByName('p_value').AsString, true );
    dset_ParamLook.Next;
  end;
end;

procedure TS_OborTypeF.btn_delClick(Sender: TObject);
begin
  inherited;
//
 if MessageDlg('Удалить значение параметра?',mtConfirmation, [mbYes, mbNo], 0 ) = mrYes
 then begin
  dset_OborTypeParams.Delete;
  dset_OborTypeParams.Close;
  dset_OborTypeParams.Open;
 end;
end;

procedure TS_OborTypeF.btn_EditClick(Sender: TObject);
begin
  inherited;
//
  dset_OborTypeParams.Edit;
end;

end.
