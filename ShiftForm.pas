unit ShiftForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OperAttFormUnit, StdCtrls, Buttons, Mask, ToolEdit, Spin,DMmain,
  IBDatabase, IBSQL, DB, IBCustomDataSet,avartype,cntsLANG;

type
  Tfrm_shift = class(TOperAttForm)
    sp_shiftnum: TSpinEdit;
    dt_shift: TDateEdit;
    btn_Ok: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    dset: TIBDataSet;
    IBSQL_sh: TIBSQL;
    tran: TIBTransaction;
    BitBtn1: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure btn_OkClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    oldShift:integer;
    typ:string;
    F_shiftNum:integer;
    F_ShiftDate:TDate;
    F_Name:string;
    F_id_shift:integer;
  public
    { Public declarations }
    property Name:string write F_Name;
    property  id_shift:integer write F_id_shift;
    procedure Translate;override;
  end;

const countSmen=4;

var
  frm_shift: Tfrm_shift;

implementation
uses  frmLANG, ShiftDmodule;

{$R *.dfm}
procedure Tfrm_shift.Translate;
begin
  Caption:=TrLangMSG(msqInpuSmen);
  Label1.Caption:=TrLangMSG(msgSgiftNumber);
  Label2.Caption:=TrLangMSG(msgShiftDate);//Дата смены
  btn_Ok.Caption:=TrLangMSG(msgApply); //Принять
  BitBtn1.Caption:=TrLangMSG(msgCancel);// Отменить
end;

procedure Tfrm_shift.FormShow(Sender: TObject);
  var nsmen:integer;
begin
  inherited;
  Caption:=TrLangMSG(msgShift)+' '+F_Name;//'Смена '

 { case OperateAttach of
   toaVoda,toaObjVoda : typ:='V';
    toaKanal,toaObjKanal : typ:='K';
    else typ :='V';
  end;}
  dset.ParamByName('id').AsInteger:=F_id_shift;
  dset.Open;
  F_shiftNum:=dset.fieldbyname('SHIFTNUMBER').AsInteger;
  F_shiftDate:=dset.fieldbyname('SHIFTDATE').asDateTime;
  nsmen:=F_shiftNum;
  oldShift:=F_shiftNum;
  if (dm_Shift.isNeedChangeShift(OperateAttach,F_id_shift)) then
   begin

   nsmen:=F_shiftNum+1;
     if countSmen< nsmen then
       nsmen:=1;
    end
  else
  nsmen:=dset.fieldbyname('SHIFTNUMBER').AsInteger;
  dt_shift.Date:= date();
  sp_shiftnum.Value:=nsmen;
end;


procedure Tfrm_shift.btn_OkClick(Sender: TObject);
begin
  inherited;
if sp_shiftnum.Value<>oldshift then
try
      if dt_shift.Date<=0 then
      begin
         dt_shift.Date:=dm_main.getTime;
         exit;
      end;

      if tran.InTransaction then tran.Rollback;
      tran.StartTransaction;
      IBSQL_sh.SQL.Text:=
      format('update SERVANTTABLE set shiftnumber=%d, shiftdate = ''%s'' where  id=%d ',
      [sp_shiftnum.Value,DateTimeToStr(dt_shift.Date),F_id_shift]);
      IBSQL_sh.ExecQuery;
      tran.Commit;
except
on e:exception   do
       MessageBoxEx(application.handle,
         pchar('  '+TrLangMSG(msgErrorExecQuery)),
         pchar(TrLangMSG(msgError)), MB_OK+MB_ICONERROR+MB_SETFOREGROUND,$0419);
end;
end;

procedure Tfrm_shift.BitBtn1Click(Sender: TObject);
begin
  inherited;

modalresult:=mrCancel;
end;

procedure Tfrm_shift.FormCreate(Sender: TObject);
begin
  inherited;
  sp_shiftnum.MinValue:=1;
  sp_shiftnum.MaxValue:=countSmen;
end;

end.
