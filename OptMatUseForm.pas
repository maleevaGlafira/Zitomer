unit OptMatUseForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, ItemSelecter, BaseOptionItemSelForm, StdCtrls,
  Buttons, SelDatePeriodFrame, BaseItemSelecterFrame, SelAttachFrame,
  SelRevsFrame, SelMatFrame, ExtCtrls;

type
  Tfrm_OptMatUse = class(Tfrm_BaseOptionItemSel)
    frame_SelAttach: Tframe_SelAttach;
    frame_Dates: Tframe_SelDatePeriod;
    frame_SelMat: Tframe_SelMat;
    Bevel1: TBevel;
    procedure btn_okClick(Sender: TObject);
  private
  public
  end;


implementation

{$R *.dfm}

procedure Tfrm_OptMatUse.btn_okClick(Sender: TObject);
begin
  inherited;
  if frame_Dates.IsDatesCorrect then
    ModalResult := mrOk;
end;

end.
