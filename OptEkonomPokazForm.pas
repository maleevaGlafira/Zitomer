unit OptEkonomPokazForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, StdCtrls, Buttons, ComCtrls, Mask, ToolEdit,
  dbcgrids, IBDatabase, DB, DMMain;

type
  TActiveTab = (atPeriod, atSearch);

  Tfrm_OptEkonomPokaz = class(Tfrm_BaseOption)
    btn_ok: TBitBtn;
    btn_exit: TBitBtn;
    chb_CalcTZ: TCheckBox;
    procedure btn_exitClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
  private
    function GetIsCalcTZ: boolean;
  public
    property IsCalcTZ: boolean read GetIsCalcTZ;
  end;

implementation

{$R *.dfm}

{ Tfrm_OptEkonomPokaz }

procedure Tfrm_OptEkonomPokaz.btn_exitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_OptEkonomPokaz.btn_okClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

function Tfrm_OptEkonomPokaz.GetIsCalcTZ: boolean;
begin
  Result := chb_CalcTZ.Checked;
end;

end.
