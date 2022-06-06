unit FormOborIB;

interface

uses
  Windows, Messages,
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FRMLANG, BaseGridFrame, OborFrameIB, StdCtrls, Buttons, ComCtrls,db,
  RxLookup, IBCustomDataSet;

type
  TActionType=(atAppend, atEdit, atDelete, atPost, atCancel);

  Tfrm_OborIB = class(TFormLang)
    frame_Obor: Tframe_Obor;
    btn_Append: TBitBtn;
    btn_Edit: TBitBtn;
    btn_Delete: TBitBtn;
    btn_Post: TBitBtn;
    btn_Cancel: TBitBtn;
    btn_exit: TBitBtn;
    StatusBar: TStatusBar;
    btn_CopyPlan: TBitBtn;
    procedure btn_exitClick(Sender: TObject);
    procedure btn_AppendClick(Sender: TObject);
    procedure btn_EditClick(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure btn_PostClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_CopyPlanClick(Sender: TObject);
  private
    { Private declarations }
    F_IsReadOnly:boolean;
    F_idZav: integer;
    F_idNar: integer;
    procedure DoAction(ActionType: TActionType);
    procedure ShowFormCaption();
    procedure OnActivateFieldsPnl(Value: boolean);
    procedure OnChangeProcessStatus(Text: string);
    procedure PageControlChanging(Sender: TObject;  var AllowChange: Boolean);
    procedure EnableBtns;
  public
    { Public declarations }
    property IsReadOnly:boolean write F_IsReadOnly;
    constructor Create(AOwner: TComponent; _idZav,
     _idNar: integer; AIsReadOnly: boolean);
      procedure Translate;override;
  end;

var
  frm_OborIB: Tfrm_OborIB;

implementation

{$R *.dfm}
uses cntsLANG;

constructor Tfrm_OborIB.Create(AOwner: TComponent; _idZav,
  _idNar: integer; AIsReadOnly: boolean);
begin
  inherited Create(AOwner);
  F_idZav:=_idZav;
  F_idNar:=_idNar;
  F_IsReadOnly:=AIsReadOnly;
//  F_IsLockProcessStatus:=false;
  /////////////////
  ////////////////
  ////////////////

end;

procedure Tfrm_OborIB.Translate;
begin
   
     frame_Obor.Label1.Caption:=TrLangMSG(msgMechan);
     frame_Obor.Label2.Caption:=TrLangMSG(msgWorkTime);
     frame_Obor.DBGrid.Columns[0].Title.caption:=TrLangMSG(msgMechan);
     frame_Obor.DBGrid.Columns[1].Title.caption:=TrLangMSG(msgWorkTime);
     btn_Append.Caption:=TrLangMSG(msgAdd);
     btn_Edit.Caption:=TrLangMSG(msgEdit);
     btn_Delete.Caption:=TrLangMSG(msgDelete);
     btn_Post.Caption:=TrLangMSG(msgSave);
     btn_Cancel.Caption:=TrLangMSG(msgCancel);
     btn_exit.Caption:=TrLangMSG(msgExit);
     btn_CopyPlan.Caption:=TrLangMSG(msgCopyPlan);

end;


procedure Tfrm_OborIB.btn_exitClick(Sender: TObject);
begin
  inherited;
   Close;
end;

procedure Tfrm_OborIB.DoAction(ActionType: TActionType);
begin
 if Assigned(frame_Obor) then
  begin
    case ActionType of
      atAppend: frame_Obor.Append;
      atEdit: frame_Obor.Edit;
      atDelete: frame_Obor.Delete;
      atPost: frame_Obor.Post;
      atCancel: frame_Obor.Cancel;
    end;
  end;
  EnableBtns;
end;


procedure Tfrm_OborIB.EnableBtns;
  procedure EnBtns(EnAppend, EnEdit, EnDelete, EnPost, EnCancel,ECopyPlan: boolean);
  begin
    btn_Append.Enabled:=EnAppend;
    btn_Edit.Enabled:=EnEdit;
    btn_Delete.Enabled:=EnDelete;
    btn_Post.Enabled:=EnPost;
    btn_Cancel.Enabled:=EnCancel;
    btn_CopyPlan.Enabled:=ECopyPlan;

  end;
begin
  if Assigned(frame_Obor) and (not F_IsReadOnly) then
  begin
    case frame_Obor.dset_Main.State of
      dsBrowse: EnBtns(true, true, true, false, false,true);
      dsEdit, dsInsert: EnBtns(false, false, false, true, true,false);
      else EnBtns(false, false, false, false, false,false);
    end;
  end else EnBtns(false, false, false, false, false,false);
end;

procedure Tfrm_OborIB.btn_AppendClick(Sender: TObject);
begin
  inherited;
 DoAction(atAppend);
end;



procedure Tfrm_OborIB.btn_EditClick(Sender: TObject);
begin
  inherited;
  DoAction(atEdit);
end;

procedure Tfrm_OborIB.btn_DeleteClick(Sender: TObject);
begin
  inherited;
  DoAction(atDelete);
  ShowFormCaption;
end;



procedure Tfrm_OborIB.btn_PostClick(Sender: TObject);
begin
  inherited;
   DoAction(atPost);
   ShowFormCaption;
end;

procedure Tfrm_OborIB.btn_CancelClick(Sender: TObject);
begin
  inherited;
  DoAction(atCancel);
end;

procedure Tfrm_OborIB.ShowFormCaption();
begin
 caption:=TrLangMSG(msgMechan);
 frame_Obor.DBGrid.Columns[0].Title.Caption:=TrLangMSG(msgMechan);
end;

procedure Tfrm_OborIB.OnActivateFieldsPnl(Value: boolean);
var
  i: integer;
  frame: Tframe_Obor;
begin
  if Value and Assigned(frame_Obor) then
  begin
    frame_obor.pnl_Fields.Visible:=true;
    for i:=0 to frame_Obor.pnl_Fields.ControlCount-1 do
      if (frame_Obor.pnl_Fields.Controls[i] is TRxDBLookupCombo) then
      begin
        (frame_Obor.pnl_Fields.Controls[i] as TRxDBLookupCombo).SetFocus;
        break;
      end;

  end
  else
   frame_obor.pnl_Fields.Visible:=false;
end;

procedure Tfrm_OborIB.OnChangeProcessStatus(Text: string);
begin
 // if not F_IsLockProcessStatus then
    StatusBar.SimpleText:=Text;
end;


procedure Tfrm_OborIB.FormShow(Sender: TObject);
begin
  inherited;
//for i:=0 to ComponentCount-1 do
 //   if (Components[i] is Tframe_WorkAndMaterBaseGrid_vds) then
    begin
      frame_Obor.idZav:=F_idZav;
       frame_Obor.idNar:=F_idNar;
      frame_Obor.OnChangeProcessStatus:=OnChangeProcessStatus;
      frame_Obor.OnActivateFieldsPanel:=OnActivateFieldsPnl;
      frame_Obor.Start;
    end;
    EnableBtns;
    ShowFormCaption;
end;

procedure Tfrm_OborIB.PageControlChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  inherited;
 if Assigned(frame_Obor) then
  begin
    if frame_Obor.dset_Main.State in [dsInsert, dsEdit] then
    begin
      AllowChange:=false;
      OnChangeProcessStatus(TrLangMSG(msgChangeNoSave));
    end else AllowChange:=true;
  end else AllowChange:=true;
end;

procedure Tfrm_OborIB.FormDestroy(Sender: TObject);
begin
  inherited;
frame_obor.Stop;
end;

procedure Tfrm_OborIB.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
if Key=VK_RETURN then
  begin
    if (Sender is TRxDBLookupCombo) then
    begin
      if not (Sender as TRxDBLookupCombo).IsDropDown then
        SelectNext(ActiveControl, true, true);
    end else SelectNext(ActiveControl, true, true);
  end;
end;

procedure Tfrm_OborIB.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
 if Assigned(Frame_obor) then
  begin
    if Frame_obor.dset_Main.State in [dsEdit, dsInsert] then
    begin
       case MessageDlg(TrLangMSG(msgExitWithSaveREC),mtConfirmation, [mbYes, mbNo], 0) of
          mrNo: if not Frame_obor.Post then Action:=caNone;
          mrYes: Frame_obor.Cancel;
          else Action:=caNone;
       end; //end case
    end;
  end;
end;

procedure Tfrm_OborIB.btn_CopyPlanClick(Sender: TObject);
begin
  inherited;
 Frame_obor.CopyFromPlan;
end;

end.


