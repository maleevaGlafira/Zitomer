unit SvodVedOtlNar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SvodVed2OptForm, StdCtrls, Buttons, Mask, ToolEdit, ComCtrls,
  ExtCtrls;

type
  Tfrm_SvodVedOtlNar = class(Tfrm_SvodVed2Opt)
    Label2: TLabel;
    dp_StartDate: TDateEdit;
    dp_enddate: TDateEdit;
    dt_startdate: TDateTimePicker;
    dt_enddate: TDateTimePicker;
    Label3: TLabel;
    rg_typeZav: TRadioGroup;
    procedure btn_okClick(Sender: TObject);
  private
    function GetZavTypeNames: string; override;
  public
  end;


implementation

{$R *.dfm}
uses ServiceFuncUnit;

{ Tfrm_SvodVed2Opt1 }

function Tfrm_SvodVedOtlNar.GetZavTypeNames: string;
begin
  Result := 'Чужие';
end;

procedure Tfrm_SvodVedOtlNar.btn_okClick(Sender: TObject);
var dt_start, dt_end:TdateTime;
begin
 dt_start:=dp_StartDate.Date+frac(dt_startdate.DateTime);
 dt_end :=dp_endDate.Date+frac(dt_enddate.DateTime);
 // inherited;
 if (dp_StartDate.Date=0) or (not IsDateCorrect(dp_StartDate.Text)) then
  begin
    Application.MessageBox('Дата не введена или введена неверно. Попробуйте еще раз.',
                            'Диспетчер АВР', MB_OK+MB_ICONWARNING);
    exit;
  end;
  if (dp_enddate.Date=0) or (not IsDateCorrect(dp_enddate.Text)) then
  begin
    Application.MessageBox('Дата не введена или введена неверно. Попробуйте еще раз.',
                            'Диспетчер АВР', MB_OK+MB_ICONWARNING);
    exit;
  end;
  if dt_start>Now()+1 then begin
    Application.MessageBox('Дата начала больше текущей даты. Попробуйте еще раз.',
                            'Диспетчер АВР', MB_OK+MB_ICONWARNING);
    exit;
  end;

  if dt_end>Now()+1 then begin
    Application.MessageBox('Дата окончания больше текущей даты. Попробуйте еще раз.',
                            'Диспетчер АВР', MB_OK+MB_ICONWARNING);
    exit;
  end;

  if dt_end<dt_start then begin
    Application.MessageBox('Дата окончания больше даты начала. Попробуйте еще раз.',
                            'Диспетчер АВР', MB_OK+MB_ICONWARNING);
    exit;
  end;

  ModalResult:=mrOk;
end;

end.
