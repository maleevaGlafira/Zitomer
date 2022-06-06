unit ObjOborUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DMMain, DB, IBCustomDataSet, IBDatabase, DBCtrls,
  Grids, DBGridEh, StdCtrls, Buttons, DBGrids, RXDBCtrl;

type
  TObjOborForm = class(TForm)
    Panel1: TPanel;
    IBTran: TIBTransaction;
    dset_LookObjObor: TIBDataSet;
    dbg_objoborzav: TDBGridEh;
    ds_ObjOborZav: TDataSource;
    dset_ObjOborZav: TIBDataSet;
    dset_ObjOborZavID: TIntegerField;
    dset_ObjOborZavID_ZAV: TIntegerField;
    dset_ObjOborZavID_OBJOBOR: TIntegerField;
    dset_ObjOborZavNAME_R: TIBStringField;
    dset_ObjOborZavlook_objobor: TStringField;
    Panel2: TPanel;
    dbn_ObjOborZav: TDBNavigator;
    BB_Save: TBitBtn;
    Splitter1: TSplitter;
    Pnl_Type: TPanel;
    GroupGrid: TRxDBGrid;
    Panel4: TPanel;
    Label1: TLabel;
    Lbl_Type: TLabel;
    dset_OborGroup: TIBDataSet;
    dset_OborGroupID: TIntegerField;
    dset_OborGroupOBORTYPE: TIntegerField;
    dset_OborGroupDETAIL: TIntegerField;
    dset_OborGroupDEL: TIBStringField;
    ds_OborGroup: TDataSource;
    tran: TIBTransaction;
    dset_ObjOborZavID_OBORTYPE: TIntegerField;
    dset_ObjOborZavNAME_TYPE: TIBStringField;
    dset_ObjOborZavDIFFER: TIntegerField;
    dset_OborGroupNAME_TYPE: TIBStringField;
    dset_ObjOborZavINVENTAR: TIBStringField;
    procedure BB_SaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dset_ObjOborZavAfterPost(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure dset_ObjOborZavBeforePost(DataSet: TDataSet);
    procedure NewAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    F_Saved: boolean;
    F_isClosed : boolean;
    F_IdZav: integer;
    F_IdObj: integer;
    F_IdSoorug: integer;
    F_CurrentOborTypeID: integer;
    procedure InitDsets;
    procedure TranCom;
    procedure InitFrame;
    function IsSostObor: boolean;
    Function GetCurrentOborTypeID: integer;

  public
    { Public declarations }
    property IdZav: integer write F_IdZav;
    property IdObj: integer write F_IdObj;
    property IdSoorug: integer write F_IdSoorug;
    property isClosed: boolean write F_isClosed;
  end;

var
  ObjOborForm: TObjOborForm;

implementation


{$R *.dfm}

procedure TObjOborForm.BB_SaveClick(Sender: TObject);
begin
//
 TranCom;
 InitDsets;
end;

procedure TObjOborForm.FormCreate(Sender: TObject);
begin
//
    F_Saved := true;
    BB_Save.Enabled := false;
end;

procedure TObjOborForm.dset_ObjOborZavAfterPost(DataSet: TDataSet);
begin
//
  BB_Save.Enabled := true;
  f_saved := false;
end;

procedure TObjOborForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
//

  if (not F_Saved) then
  begin
   if MessageDlg('Сохранить изменения?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then TranCom
    else
      begin
        if dset_ObjOborZav.State <> dsBrowse then dset_ObjOborZav.Cancel;
        if IBTran.InTransaction then IBTran.Rollback;
      end;
   end;
end;

procedure TObjOborForm.FormShow(Sender: TObject);
begin
//
 if  F_IdZav > 0 then  InitDsets;
 InitFrame;
 panel1.Enabled := not F_isClosed;
 panel2.Enabled := not F_isClosed;
end;

procedure TObjOborForm.InitDsets;
begin
   //
    dset_LookObjObor.ParamByName('pIdObj').AsInteger := F_IdObj;
    dset_LookObjObor.ParamByName('pIdSoorug').AsInteger := F_IdSoorug;
    dset_ObjOborZav.ParamByName('pIdZav').AsInteger := F_IdZav;
    dset_ObjOborZav.ParamByName('pIdObj').AsInteger := F_IdObj;
    dset_ObjOborZav.ParamByName('pIdSoorug').AsInteger := F_IdSoorug;

    dset_LookObjObor.Open;
    if dset_LookObjObor.RecordCount >0 then  dset_ObjOborZav.Open;
    BB_Save.Enabled := false;
end;

procedure TObjOborForm.TranCom;
begin
    //
 try
   if dset_ObjOborZav.State <> dsBrowse then dset_ObjOborZav.Post;
   if IBTran.InTransaction then IBTran.Commit;
   F_Saved := true;

  except
   if dset_ObjOborZav.State <> dsBrowse then dset_ObjOborZav.Cancel;
   if IBTran.InTransaction then IBTran.Rollback;
  end;

end;

procedure TObjOborForm.dset_ObjOborZavBeforePost(DataSet: TDataSet);
begin
 if dset_ObjOborZav.FieldByName('id_objobor').AsInteger <= 0 then
    begin
     dset_ObjOborZav.Cancel;
     dset_ObjOborZav.Edit;
    end;

   dset_ObjOborZav.FieldByName('id_zav').AsInteger := F_IdZav;
end;



procedure TObjOborForm.NewAfterScroll(DataSet: TDataSet);
begin
  InitFrame;
end;

procedure TObjOborForm.InitFrame;
  procedure FillOborGroupe;
   begin

      GroupGrid.Visible := true;

      if dset_OborGroup.Active then dset_OborGroup.Close;
      dset_OborGroup.ParamByName('obortype').AsInteger := F_CurrentOborTypeID;
      dset_OborGroup.Open;
   end;


begin
  try
    F_CurrentOborTypeID := GetCurrentOborTypeID;
    Lbl_Type.Caption := dset_ObjOborZav.FieldByName('NAME_TYPE').AsString;

{    if ( dset_OborGroup.State = dsEdit) or (dset_OborGroup.State = dsInsert) then
        dset_OborGroup.Cancel;
 }
//    if tran.InTransaction then tran.Commit;

//    tran.StartTransaction;

    if IsSostObor then FillOborGroupe
    else
    begin
     GroupGrid.Visible := false;
    end;

  except
    on E: Exception do
    begin
  //    tran.Rollback;
      E.Message := E.Message + '(TS_OborTypeF.InitFrame)';
      raise;
    end;
  end; //except

end;


function TObjOborForm.IsSostObor: boolean;
begin
  //
   if dset_ObjOborZav.Active then
    Result := (dset_ObjOborZav.FieldByName( 'DIFFER' ).AsInteger = 1);
end;

Function TObjOborForm.GetCurrentOborTypeID;
begin
  if dset_ObjOborZav.Active then
    Result := dset_ObjOborZav.FieldByName( 'ID_OBORTYPE' ).AsInteger
    else
    Result := 0;
end;


end.
