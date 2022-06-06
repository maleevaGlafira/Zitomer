unit DelBWorkForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons,frmLANG;

type
  Tfrm_DelBWork = class(TFormLang)
    Label1: TLabel;
    chb_DelAssignedWorks: TCheckBox;
    chb_DelAssignedMats: TCheckBox;
    Bevel1: TBevel;
    btn_Yes: TBitBtn;
    btn_no: TBitBtn;
    procedure btn_noClick(Sender: TObject);
    procedure btn_YesClick(Sender: TObject);
  private
    F_IsDelAssignedWorks,
    F_IsDelAssignedMats: boolean;
  public
    property IsDelAssignedWorks: boolean read F_IsDelAssignedWorks;
    property IsDelAssignedMats: boolean read F_IsDelAssignedMats;
    procedure Translate;override;
  end;


implementation

{$R *.dfm}
 uses cntsLANG;
procedure Tfrm_DelBWork.Translate;
begin
  self.Caption:=TrLangMSG(msgDelBwork);
  Label1.Caption:=TrLangMSG(msgConfirmDelBwork);
  chb_DelAssignedWorks.Caption:=TrLangMSG(msgDelWorksAssigned);
  chb_DelAssignedMats.Caption:=TrLangMSG(msgDelMaterAssigned);
  btn_Yes.Caption:=TrLangMSG(msgYes);
  btn_no.Caption:=TrLangMSG(msgNo);



end;

procedure Tfrm_DelBWork.btn_noClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_DelBWork.btn_YesClick(Sender: TObject);
begin
  F_IsDelAssignedWorks := chb_DelAssignedWorks.Checked;
  F_IsDelAssignedMats := chb_DelAssignedMats.Checked;

  ModalResult := mrOk;
end;

end.
