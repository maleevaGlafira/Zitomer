unit SvodWorkPlanOpt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, StdCtrls, Buttons, ComCtrls, Mask, ToolEdit,
  ExtCtrls;

type
  Tfrm_PlanWorkOpt = class(Tfrm_BaseOption)
    Bevel1: TBevel;
    Label1: TLabel;
    dp_Date: TDateEdit;
    dp_Time: TDateTimePicker;
    btn_revs: TBitBtn;
    gb_Attach: TGroupBox;
    chb_Voda: TCheckBox;
    chb_Kanal: TCheckBox;
    chb_ObjVod: TCheckBox;
    btn_ok: TBitBtn;
    btn_cancel: TBitBtn;
    Bevel2: TBevel;
    chb_ObjKan: TCheckBox;
    procedure btn_revsClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure btn_cancelClick(Sender: TObject);
  private
    { Private declarations }
    F_RevsName, F_RevsID:string;
  public
    { Public declarations }
    property  RevsName:string read f_RevsName;
    property  RevsID:string read f_RevsID;
  end;

var
  frm_PlanWorkOpt: Tfrm_PlanWorkOpt;

implementation

{$R *.dfm}
uses Selform, ServiceFuncUnit;

procedure Tfrm_PlanWorkOpt.btn_revsClick(Sender: TObject);
var
  sel_frm: TSelectForm;
begin
  sel_frm:=TSelectForm.Create(self);
  sel_frm.Query.SQL.Text:='select id code,name_r pole1 from s_revs where (id>0) and del=''-''';
  sel_frm.ShowModal;
  F_RevsID:=sel_frm.Temp_Code;
  F_RevsName:=sel_frm.SelText;
end;


procedure Tfrm_PlanWorkOpt.btn_okClick(Sender: TObject);
begin
if (dp_Date.Date=0) or (not IsDateCorrect(dp_Date.Text)) then
  begin
    Application.MessageBox('Дата не введена или введена неверно. Попробуйте еще раз.',
                            'Диспетчер АВР', MB_OK+MB_ICONWARNING);
    exit;
  end;

  ModalResult:=mrOK;
end;



procedure Tfrm_PlanWorkOpt.btn_cancelClick(Sender: TObject);
begin
  inherited;
Close;
end;

end.
