unit ZavWithImageOptForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, StdCtrls, Buttons, Mask, ToolEdit;

type
  Tfrm_ZavWithImageOpt = class(Tfrm_BaseOption)
    dp_Date1: TDateEdit;
    dp_Date2: TDateEdit;
    btn_ok: TBitBtn;
    btn_exit: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    procedure btn_okClick(Sender: TObject);
    procedure btn_exitClick(Sender: TObject);
  private
  public
    constructor Create(AOwner: TComponent; Title: string);
  end;

var
  frm_ZavWithImageOpt: Tfrm_ZavWithImageOpt;

implementation

{$R *.dfm}

uses ServiceFuncUnit;


constructor Tfrm_ZavWithImageOpt.Create(AOwner: TComponent; Title: string);
begin
  inherited Create(AOwner);
  Caption:=Title;
end;

procedure Tfrm_ZavWithImageOpt.btn_okClick(Sender: TObject);
begin
  if (dp_Date1.Date=0) or (not IsDateCorrect(dp_Date1.Text)) then
  begin
    Application.MessageBox('Дата начала не указана или введена не верно.',
                            'Диспетчер АВР', MB_OK+MB_ICONWARNING);
    exit;
  end;

  if dp_Date2.Date=0 then dp_date2.Date:=date;

  if not IsDateCorrect(dp_Date2.Text) then
  begin
    Application.MessageBox('Дата окончания введена не верно.',
                            'Диспетчер АВР', MB_OK+MB_ICONWARNING);
    exit;
  end;

  ModalResult:=mrOk;
end;

procedure Tfrm_ZavWithImageOpt.btn_exitClick(Sender: TObject);
begin
  Close;
end;

end.
