unit EditBWorkForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RxLookup, DB, Buttons, ExtCtrls, BWorkDM,frmLANG;

type
  Tfrm_EditBWork = class(TFormLang)
    Bevel1: TBevel;
    btn_ok: TBitBtn;
    btn_exit: TBitBtn;
    ds_S_BWork: TDataSource;
    ds_Main: TDataSource;
    dbl_BWork: TRxDBLookupCombo;
    Label1: TLabel;
    gb_Work: TGroupBox;
    gb_Mater: TGroupBox;
    chb_DelWorksAssignedWithOldValue: TCheckBox;
    chb_AddWorksAssignedWithNewValue: TCheckBox;
    chb_DelMatsAssignedWithOldValue: TCheckBox;
    chb_AddMatsAssignedWithNewValue: TCheckBox;
    procedure btn_exitClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
  private
    F_BWork: Tdm_BWork;
    //
    F_DelWorksAssignedWithOldValue,
    F_AddWorksAssignedWithNewValue: boolean;
    //
    F_DelMatsAssignedWithOldValue,
    F_AddMatsAssignedWithNewValue: boolean;
  public
    property DelWorksAssignedWithOldValue: boolean read F_DelWorksAssignedWithOldValue;
    property AddWorksAssignedWithNewValue: boolean read F_AddWorksAssignedWithNewValue;
    property DelMatsAssignedWithOldValue: boolean read F_DelMatsAssignedWithOldValue;
    property AddMatsAssignedWithNewValue: boolean read F_AddMatsAssignedWithNewValue;
    constructor Create( AOwner: TComponent; ABWork: Tdm_BWork);
    procedure Translate;override;
  end;


implementation

{$R *.dfm}
uses cntsLANG;
procedure Tfrm_EditBWork.Translate;
begin
self.Caption:=TrLangMSG(msgEditBWork);
Label1.Caption:=TrLangMSG(msgComplitWork);
chb_DelWorksAssignedWithOldValue.Caption:=TrLangMSG(msgDelWorkForOld);
chb_AddWorksAssignedWithNewValue.Caption:=TrLangMSG(msgAddWorkForNew);
chb_DelMatsAssignedWithOldValue.Caption:=TrLangMSG(msgDelMaterForOld);
chb_AddMatsAssignedWithNewValue.Caption:=TrLangMSG(msgAddMaterForNew);
btn_ok.Caption:=TrLangMSG(msgApply);
btn_exit.Caption:=TrLangMSG(msgCancel);
end;

procedure Tfrm_EditBWork.btn_exitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_EditBWork.btn_okClick(Sender: TObject);
var
  _ErrMsg: string;
  _ErrFieldOrd: integer;
begin
  if not F_BWork.IsInputValuesCorrect( _ErrMsg, _ErrFieldOrd ) then
  begin
    case _ErrFieldOrd of
      Ord( bwfBWork ): dbl_bwork.SetFocus;
    end;
    //
    MessageDlg(_ErrMsg,mtwarning,[mbok], 0);
    //Application.MessageBox( PChar( _ErrMsg ), 'Внимание', MB_OK + MB_ICONWARNING );
  end else
  begin
    F_DelWorksAssignedWithOldValue := chb_DelWorksAssignedWithOldValue.Checked;
    F_AddWorksAssignedWithNewValue := chb_AddWorksAssignedWithNewValue.Checked;
    F_DelMatsAssignedWithOldValue := chb_DelMatsAssignedWithOldValue.Checked;
    F_AddMatsAssignedWithNewValue := chb_AddMatsAssignedWithNewValue.Checked;
    //
    ModalResult := mrOk;
  end;
end;

constructor Tfrm_EditBWork.Create(AOwner: TComponent; ABWork: Tdm_BWork);
begin
  inherited Create( AOwner );
  F_BWork := ABWork;
end;

end.
