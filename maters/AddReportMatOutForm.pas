unit AddReportMatOutForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FRMLANG, StdCtrls, Buttons, ExelError;

type
  TfunCheck  = procedure (num_month, num_year:integer; var  result:boolean) of object;
  Tfrm_AddReportMatOut = class(TFormLang)
    lbl_brigname: TLabel;
    lbl_brigcap: TLabel;
    lbl_month: TLabel;
    lbl_year: TLabel;
    cb_month: TComboBox;
    cb_year: TComboBox;
    btn_Save: TBitBtn;
    btn_exit: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_exitClick(Sender: TObject);
  private
    { Private declarations }
    F_id_brig:integer;
    F_brigname:string;

    function getnumnonth:integer;
    function getnumyear:integer;
  public
    { Public declarations }
     f_funcheck:TfunCheck;
    property  id_brig:integer write   F_id_brig;
    property  brigname:string write  F_brigname;

    procedure Translate;override;
    property nummonth:integer read getnumnonth;
    property numyear:integer read getnumyear;

  end;

var
  frm_AddReportMatOut: Tfrm_AddReportMatOut;

implementation

{$R *.dfm}
uses HelpFunctions, cntsLANG;
const errnotFunction = 'Не визначена функція!!';

procedure Tfrm_AddReportMatOut.FormCreate(Sender: TObject);
var i, j:integer;
begin
  inherited;
  f_funcheck:=nil;
  F_id_brig:=-1;
  F_brigname:='';
  for i:=1 to 12 do
  begin
   cb_month.Items.Add(monthes_ua[i]);
  end;
  i:=GetYear(Date());
  for j:=0 to 10 do
    cb_year.Items.Add(InttoStr(i-j));


end;

procedure Tfrm_AddReportMatOut.Translate;
begin
  Caption:=msgAddMaterReport ;
  lbl_brigcap.Caption:=TrLangMSG(msgBrigorMaster);
  lbl_year.Caption:=TrLangMSG(msgYear);
  lbl_month.Caption:=TrLangMSG(msgMonth);
  btn_Save.Caption:=TrLangMSG(msgSave);
  btn_exit.Caption:=TrLangMSG(msgExit);



end ;

procedure Tfrm_AddReportMatOut.FormShow(Sender: TObject);
begin
  inherited;
  lbl_brigname.Caption:=F_brigname;
  cb_year.ItemIndex:=0;
  cb_month.ItemIndex:=0;
end;

procedure Tfrm_AddReportMatOut.btn_SaveClick(Sender: TObject);
var nyear, nmonth:integer;
result:boolean;
begin
  inherited;
nyear:=StrToInt(cb_year.Text);
nmonth:=cb_month.ItemIndex+1;
result:=false;
if  assigned(f_funcheck)
then
begin
   f_funcheck(nmonth, nyear, result);
  if  result then
   modalresult:=mrOK
  else
   Application.MessageBox(PChar(Err_MaterreportAlreadyExist),
     PChar(TrLangMSG(msgError)),MB_OK+MB_ICONWARNING)
end
else
   Application.MessageBox(PChar(errnotFunction),
     PChar(TrLangMSG(msgError)),MB_OK+MB_ICONWARNING);
end;

procedure Tfrm_AddReportMatOut.btn_exitClick(Sender: TObject);
begin
  inherited;
ModalResult:=mrCancel;
  Close();
end;

function Tfrm_AddReportMatOut.getnumnonth:integer;
begin
 result:=cb_month.ItemIndex+1;
end;

function Tfrm_AddReportMatOut.getnumyear:integer;
begin
result:=StrToInt(cb_year.Text);
end;

end.
