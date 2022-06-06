unit SvodPlanWorksOpt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, StdCtrls, Buttons, ComCtrls, Mask, ToolEdit,
  ExtCtrls,frmLANG,cntsLANG;

type
  Tfrm_SvodPlanWorkOpt = class(Tfrm_BaseOption)
    Label1: TLabel;
    Bevel1: TBevel;
    dp_Date: TDateEdit;
    dp_Time: TDateTimePicker;
    btn_revs: TBitBtn;
    Bevel2: TBevel;
    gb_Attach: TGroupBox;
    chb_Voda: TCheckBox;
    chb_Kanal: TCheckBox;
    chb_ObjVod: TCheckBox;
    btn_ok: TBitBtn;
    btn_cancel: TBitBtn;
    chb_ObjKan: TCheckBox;
    cb_otl: TCheckBox;
    procedure btn_revsClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure btn_cancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chb_VodaClick(Sender: TObject);
  private
    { Private declarations }
    F_RevsID,F_RevsName:string;
    f_attachesID:string;
  public
    { Public declarations }
    property RevsName: string read F_RevsName;
    property RevsID: string read F_RevsID;
    property  attachesID:string read f_attachesID; 
  end;

var
  frm_SvodPlanWorkOpt: Tfrm_SvodPlanWorkOpt;

implementation

{$R *.dfm}
uses Selform, ServiceFuncUnit;

procedure Tfrm_SvodPlanWorkOpt.btn_revsClick(Sender: TObject);
var
  sel_frm: TSelectForm;
begin
  sel_frm:=TSelectForm.Create(self);
  sel_frm.Query.SQL.Text:='select id code,name_r pole1 from s_revs where (id>0) and del=''-''';
  sel_frm.ShowModal;
  F_RevsID:=sel_frm.Temp_Code;
  F_RevsName:=sel_frm.SelText;

end;

procedure Tfrm_SvodPlanWorkOpt.btn_okClick(Sender: TObject);
var count:integer;
begin
  inherited;
 if (dp_Date.Date=0) or (not IsDateCorrect(dp_Date.Text)) then
  begin
    Application.MessageBox('Дата не введена или введена неверно. Попробуйте еще раз.',
                            'Диспетчер АВР', MB_OK+MB_ICONWARNING);
    exit;
  end;
  f_attachesID:='';
  if chb_Voda.Checked then
    f_attachesID:=f_attachesID+',1';
  if chb_Kanal.Checked then
    f_attachesID:=f_attachesID+',2';
  if chb_ObjVod.Checked then
     f_attachesID:=f_attachesID+',4';
  if chb_objKan.Checked then
   f_attachesID:=f_attachesID+',5';
  if length(f_attachesID)=8 then
    f_attachesID:='';
  if f_attachesID>'' then  begin
    delete(f_attachesID,1,1);
    f_attachesID:='('+f_attachesID+')';
  end;

  ModalResult:=mrOK;
end;

procedure Tfrm_SvodPlanWorkOpt.btn_cancelClick(Sender: TObject);
begin
  inherited;
Close();
end;

procedure Tfrm_SvodPlanWorkOpt.FormShow(Sender: TObject);
begin
  inherited;
  btn_revs.Caption:=TrLangMSG(msgREVS);
end;

procedure Tfrm_SvodPlanWorkOpt.chb_VodaClick(Sender: TObject);
var i, count:integer;
name:string;
begin
  inherited;
count:=0;
for i:=0 to gb_Attach.ControlCount-1 do
    if gb_Attach.Controls[i] is TCheckbox then
      if (gb_Attach.Controls[i] as TCheckbox).Checked  then
         count:=count+1;
if count=0 then
  (Sender as TCheckbox).Checked := true;

end;

end.
