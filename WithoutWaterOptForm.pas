unit WithoutWaterOptForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, StdCtrls, Mask, ToolEdit, Buttons;

type
  Tfrm_WithoutWaterOpt = class(Tfrm_BaseOption)
    bb_Ok: TBitBtn;
    bb_exit: TBitBtn;
    dp_Date1: TDateEdit;
    dp_Date2: TDateEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure bb_OkClick(Sender: TObject);
    procedure bb_exitClick(Sender: TObject);
  private
  public
    constructor Create(AOwner: TComponent; Title: string);
  end;

implementation

{$R *.dfm}

uses ServiceFuncUnit;

constructor Tfrm_WithoutWaterOpt.Create(AOwner: TComponent; Title: string);
begin
  inherited Create(AOwner);
  Caption:=Title;
end;

procedure Tfrm_WithoutWaterOpt.bb_OkClick(Sender: TObject);
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

procedure Tfrm_WithoutWaterOpt.bb_exitClick(Sender: TObject);
begin
  Close;
end;

end.
