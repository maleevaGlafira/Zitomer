unit AddMaterToMaterRepForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls, RXSpin, Mask, DB,
  RxLookup;

type
  Tfrm_AddMaterToMaterRep = class(TForm)
    me_kod: TMaskEdit;
    Label1: TLabel;
    lbl_name: TLabel;
    lbl_units: TLabel;
    ed_units: TEdit;
    Lbl_price: TLabel;
    lbl_q: TLabel;
    spe_price: TRxSpinEdit;
    spe_kol: TRxSpinEdit;
    mem_name: TMemo;
    pnl_controls: TPanel;
    StatusBar1: TStatusBar;
    btn_add: TBitBtn;
    btn_cancel: TBitBtn;
    ds_s_mat2: TDataSource;
    ds_matermater: TDataSource;
    RxLbMaterColumn: TRxDBLookupCombo;
    lbl_columnname: TLabel;
    ds_s_mat2column: TDataSource;
    procedure btn_cancelClick(Sender: TObject);
    procedure btn_addClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure me_kodExit(Sender: TObject);
  private
    { Private declarations }
    f_frombase:boolean;
    function ckeskData():boolean;
    procedure setBottumText(text:string);
    procedure translate();
    function getKod:string;
    function getName:string;
    function getUnits:string;
    function getPrice:real;
    function getQun:real;
    function getFkColumn:integer;

    procedure setKod(val:string);
    procedure setNameR(val:string);
    procedure setUnits(val:string);
    procedure setPrice(val:real);
    procedure setQun(val:real);
    procedure setFkColunm(id:integer);

    procedure setValuesFromBase();

  public
    { Public declarations }
    procedure Clear();
    property kod:string read getKod write setKod;
    property MName:string read getName write setNameR;
    property Units:string read getUnits write setUnits;
    property Price:real read getPrice write setPrice;
    property Quon:real read getQun write setQun;
    property FKColumn:integer read getFkColumn write setFkColunm;
  end;

var
  frm_AddMaterToMaterRep: Tfrm_AddMaterToMaterRep;

implementation

{$R *.dfm}
uses ExelError, ConstRepMater;

procedure Tfrm_AddMaterToMaterRep.setBottumText(text:string);
begin
 self.StatusBar1.Panels[0].Text:=text;
end;

procedure Tfrm_AddMaterToMaterRep.translate();
begin
lbl_name.Caption:=NameWord;
lbl_units.Caption:=UnitWord;
Lbl_price.Caption:=PriceWord;
lbl_q.Caption:=LeftWord;
btn_add.Caption:=cap_addmater;
btn_cancel.Caption:=capCancel;
Caption:=capAddmater;
lbl_columnname.Caption:=capColumn;
end;

function Tfrm_AddMaterToMaterRep.ckeskData():boolean;
var new_price, old_price:real;
r1,r2,r3:boolean;
begin
result:=false;
 if length(trim(mem_name.Lines.Text))<3 then
 begin
  setBottumText(errShortName);
  mem_name.SetFocus;
  exit;
 end;
 if  trim(ed_units.Text)='' then
 begin
   setBottumText(errEmptyUnits);
   ed_units.SetFocus;
  exit;
 end;
 if spe_price.Value<=0 then
 begin
  setBottumText(errPrice);
  spe_price.SetFocus;
  exit;
 end;
 if spe_kol.Value <=0 then
 begin
  setBottumText(errQuon);
  spe_kol.SetFocus;
  exit;
 end;
 if f_frombase then
 begin
    new_price:=spe_price.Value;
    old_price:=ds_s_mat2.DataSet.fieldbyname('price').AsFloat;
    r1:=trim(mem_name.Lines.Text)<> ds_s_mat2.DataSet.fieldbyname('name_r').asstring;
    r2:=trim(ed_units.Text)<> ds_s_mat2.DataSet.fieldbyname('units').asstring;
    r3:=new_price<>old_price;


    if (r1) or (r2) or (r3){(mem_name.Lines.Text<> ds_s_mat2.DataSet.fieldbyname('name_r').asstring)
     or
      (trim(ed_units.Text)<> ds_s_mat2.DataSet.fieldbyname('units').asstring)
     or
      (spe_price.Value<> ds_s_mat2.DataSet.fieldbyname('price').AsFloat) }then
      begin
         if MessageDlg(mesIsShureCorrectMaters+me_kod.text,mtConfirmation,
           [mbYes, mbNo],0) <> mrYes
          then
          begin
          if MessageDlg(mesISSetValuesFromBase,mtConfirmation,
           [mbYes, mbNo],0) = mrYes then
            setValuesFromBase();
           result:=false;
           setBottumText(mescanceluser);
           exit;
         end

      end
 end;
 result:=true;
end;

procedure Tfrm_AddMaterToMaterRep.btn_cancelClick(Sender: TObject);
begin
Close();
end;

procedure Tfrm_AddMaterToMaterRep.btn_addClick(Sender: TObject);
begin
if  ckeskData() then
begin
   modalResult:=mrOk;
   
end;
end;

procedure Tfrm_AddMaterToMaterRep.FormShow(Sender: TObject);
begin
  translate();
end;

function  Tfrm_AddMaterToMaterRep.getKod:string;
begin
 result:=me_kod.Text;
end;

procedure Tfrm_AddMaterToMaterRep.setKod(val:string);
begin
me_kod.Text:=val;
end;

function Tfrm_AddMaterToMaterRep.getName:string;
begin
 result:=trim(mem_name.Lines.Text);
end;

procedure Tfrm_AddMaterToMaterRep.setNameR(val:string);
begin
 mem_name.Lines.Text:=trim(val);
end;

function Tfrm_AddMaterToMaterRep.getUnits:string;
begin
 result:= trim(ed_units.Text);
end;

procedure Tfrm_AddMaterToMaterRep.setUnits(val:string);
begin
 ed_units.Text:=val;
end;

function Tfrm_AddMaterToMaterRep.getPrice:real;
begin
 result:=spe_price.Value;
end;

procedure Tfrm_AddMaterToMaterRep.setPrice(val:real);
begin
 spe_price.Value:=val;
end;


function  Tfrm_AddMaterToMaterRep.getQun:real;
begin
 result:=spe_kol.Value;
end;

procedure Tfrm_AddMaterToMaterRep.setQun(val:real);
begin
spe_kol.Value:=val;
end;

procedure Tfrm_AddMaterToMaterRep.Clear();
begin
me_kod.Text:='';
mem_name.Lines.Text:='';
ed_units.Text:='';
spe_price.Value:=0;
spe_kol.Value:=0;
f_frombase:=false;
end;


procedure Tfrm_AddMaterToMaterRep.me_kodExit(Sender: TObject);
begin
if me_kod.Text<>'' then
begin
  f_frombase:=false;
  if ds_s_mat2.DataSet<> nil then
  if  ds_s_mat2.DataSet.Active then
  begin
   if ds_s_mat2.DataSet.Locate('kod', vararrayof([me_kod.Text]),[]) then
   begin
      f_frombase:=true;
      setValuesFromBase();

   end;
  end;
end;
end;

procedure Tfrm_AddMaterToMaterRep.setValuesFromBase();
var id_column:integer;
begin

 if f_frombase then
  if  ds_s_mat2.DataSet.Locate('kod', vararrayof([me_kod.Text]),[]) then
  begin
      mem_name.Lines.Text:=  ds_s_mat2.DataSet.fieldbyname('name_r').asstring;
      ed_units.Text:=  ds_s_mat2.DataSet.fieldbyname('units').asstring;
      spe_price.Value :=  ds_s_mat2.DataSet.fieldbyname('price').AsFloat;
//      id_column:=ds_s_mat2.DataSet.fieldbyname('fk_column').AsInteger;
//      if id_column<=0 then id_column:=-1;
//      RxLbMaterColumn.LookupSource.DataSet.Locate('id', vararrayof([id_column]),[]);
  end
end;

procedure Tfrm_AddMaterToMaterRep.setFkColunm(id:integer);
begin
 if id<=0 then id:=-1;
      RxLbMaterColumn.LookupSource.DataSet.Locate('id', vararrayof([id]),[]);
end;

function Tfrm_AddMaterToMaterRep.getFkColumn:integer;
begin
 result:=RxLbMaterColumn.LookupSource.DataSet.fieldbyname('id').AsInteger;
end;

end.
