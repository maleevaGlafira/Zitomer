unit UtechkiZaPeriodOptForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, ExtCtrls, StdCtrls, Buttons, Mask, ToolEdit;

type
  Tfrm_UtechkiZaPeriodOpt = class(Tfrm_BaseOption)
    dp_Date1: TDateEdit;
    dp_Date2: TDateEdit;
    Label1: TLabel;
    Label2: TLabel;
    btn_ok: TBitBtn;
    btn_exit: TBitBtn;
    Bevel1: TBevel;
    procedure btn_exitClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
  private
    F_Dt_beg: TDate;
    F_Dt_end: TDate;
  public
    property Dt_beg: TDate read F_Dt_beg;
    property Dt_end: TDate read F_Dt_end;
    constructor Create(AOwner: TComponent; Title: string);
  end;


implementation

{$R *.dfm}

procedure Tfrm_UtechkiZaPeriodOpt.btn_exitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_UtechkiZaPeriodOpt.btn_okClick(Sender: TObject);
begin
  if dp_Date1.Date=0 then
  begin
    Application.MessageBox('Введите дату начала периода.',
                             'Диспетчер АВР', MB_OK+MB_ICONWARNING);
    exit;
  end;

  if dp_Date2.Date=0 then dp_Date2.Date:=Date;

  if dp_Date1.Date>dp_Date2.Date then
  begin
    Application.MessageBox('Дата начала периода не может быть меньше даты окончания',
                              'Диспетчер АВР', MB_OK+MB_ICONWARNING);
    exit;
  end;

  F_Dt_beg:=dp_Date1.Date;
  F_Dt_end:=dp_Date2.Date;
  ModalResult:=mrOk;
end;

constructor Tfrm_UtechkiZaPeriodOpt.Create(AOwner: TComponent;
  Title: string);
begin
  inherited Create(AOwner);
  Caption:=Title;
end;

end.
