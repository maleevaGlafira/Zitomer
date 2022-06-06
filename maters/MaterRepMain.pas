unit MaterRepMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Grids,  ReadDataExel,
  MatersMastersDMoule, DBGridEh, DB, DBCtrls, RxLookup, Mask, ToolEdit,
  Buttons, CurrEdit, RXSpin, AddReportMatOutForm, AddMaterToMaterRepForm;

{const Error_FileNotFound='Файл не знайдено!!';






const Err_InputStartDate  = 'Треба ввести дату початку пошуку!';
const Err_StartMoreEndDate = 'Дата початку більше за дату кінця !';

const mes_OpenReport='Завантажте або відкрийте матеріальний звіт';
const mes_SelBrig = 'Оберіть бригадира';
const mes_SaveCloseReport = 'Збережіть або закрийте матріальний звіт';


const mes_depfound = 'Пошук виконано';

const maked_deps = 'Виїзди ви-ні %s з %s по %s';
const mes_ChangedMakes = 'Зміни збережено!!';
const mesAddMater = 'Додавання  матеріала';

const quesIsDeleteMaterFromDep = 'Видалити матеріал "%s" з виїзду?';
const questIsDelMaterRepoordAllData = 'Звіт  вже  є у базі. Видалити усі дані звіту та зберегти новий?';
const mesCancelUser = 'Відмінено користувачем';
const mesReposrtIsSave = 'Звіт збережено';
const mesToGoToMater = 'Для пошуку  матеріала у звіті натисніть двічі';

const main_Caption = 'Розподіл матреріалів зі звіту';
const ReportWord = 'Звіт';

const OrderWord = 'Наряд';
const DepWord = '№ В-ду';
const DataWord = 'Дата';
const AdresWord = 'Адреса';

 const cap_brig = 'Бригад';
 const cap_depscaption='Виїзди';
 const cap_OpenFile='Завантажити';
 const cap_Savereport='Зберегти відкритий звіт';
 const cap_openFromBase='Відкрити звіт';
 const cap_close_report='Закрити звіт';
const cap_depaddinfo='Додаткова інформація виїзду';
 const cap_used_maters='Використані матеріали';
 const cap_addmater='Додати';
 const  cap_change='Змінити';
const cap_delete='Видалити';
 const cap_close='Вихід';
 const cap_material='Матеріал';
 const cap_left='Залиш.';
 const cap_used='Використовується';
 const cacp_SearchDep = 'Пошук виїздів';
 const  cap_MaterReportCap = 'Матеріальний звіт';
const   cap_searchdeps = '';
 cap_dep = 'Виїзд';  }


type
TStatusReport  = (Rempty, Rloaded, Ropened , Rsaved);
TStatusDeps = (DepsEmpty,DepsOpened,AddMater);
  Tfrm_materstobrig = class(TForm)
    OpenDialog1: TOpenDialog;
    btn_openFile: TButton;
    Panel1: TPanel;
    StatusBar1: TStatusBar;
    DataSource1: TDataSource;
    DBGridEh_Report: TDBGridEh;
    ds_brigs: TDataSource;
    btn_SavedReport: TButton;
    btn_openFromBase: TButton;
    btn_close_report: TButton;
    lbl_report_title: TLabel;
    ds_reports: TDataSource;
    pnl_report: TPanel;
    Panel3: TPanel;
    btn_searchdeps: TButton;
    pnl_deps: TPanel;
    lbl_titledeps: TLabel;
    DBGridEh1: TDBGridEh;
    lbl_depscaption: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ds_deps: TDataSource;
    btn_add: TSpeedButton;
    btn_minus: TSpeedButton;
    mem_titleadd: TMemo;
    pnl_addmater: TPanel;
    btn_savemater: TBitBtn;
    bb_canceladd: TBitBtn;
    mem_depinfo: TMemo;
    ds_depmaters: TDataSource;
    DBGrid_depmatrers: TDBGridEh;
    lbl_used_maters: TLabel;
    lbl_depaddinfo: TLabel;
    lbl_numdep: TLabel;
    Lbl_order: TLabel;
    lbl_numorder: TLabel;
    lbl_dep_date: TLabel;
    lbl_dep_address: TLabel;
    lbl_matprice: TLabel;
    lbl_left: TLabel;
    lbl_left_q: TLabel;
    lbl_units: TLabel;
    lbl_used: TLabel;
    gb_departure: TGroupBox;
    gb_material: TGroupBox;
    sp_removeall: TSpeedButton;
    Panel2: TPanel;
    btn_addmater: TBitBtn;
    btn_change: TBitBtn;
    btn_delete: TBitBtn;
    lbl_kod: TLabel;
    lbl_MaterReportCap: TLabel;
    lbl_brigcap: TLabel;
    sp_addall: TSpeedButton;
    RxLbBrigs: TRxDBLookupCombo;
    rxdbReports: TRxDBLookupCombo;
    de_start: TDateEdit;
    de_end: TDateEdit;
    bb_close: TBitBtn;
    pnl_actions: TPanel;
    lbl_mat_name: TMemo;
    ce_matquan: TRxSpinEdit;
    lbl_report_cap: TLabel;
    lb_brig2: TLabel;
    RxDBL_brigs2: TRxDBLookupCombo;
    ds_brigs2: TDataSource;
    lbl_repp: TLabel;
    RxDBLreports_out: TRxDBLookupCombo;
    ds_repsout: TDataSource;
    Button1: TButton;
    btn_closedeps: TButton;
    gb_out_repcap: TGroupBox;
    lbl_brigname: TLabel;
    lbl_year: TLabel;
    lbl_month: TLabel;
    tbn_addmatertorep: TBitBtn;
    procedure btn_openFileClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RxLbBrigsChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_SavedReportClick(Sender: TObject);
    procedure btn_close_reportClick(Sender: TObject);
    procedure btn_openFromBaseClick(Sender: TObject);
    procedure btn_searchdepsClick(Sender: TObject);
    procedure bb_canceladdClick(Sender: TObject);
    procedure ce_matquanChange(Sender: TObject);
    procedure btn_minusClick(Sender: TObject);
    procedure btn_addClick(Sender: TObject);
    procedure btn_savematerClick(Sender: TObject);
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure btn_addmaterClick(Sender: TObject);
    procedure btn_changeClick(Sender: TObject);
    procedure btn_deleteClick(Sender: TObject);
    procedure DBGrid_depmatrersEnter(Sender: TObject);
    procedure sp_removeallClick(Sender: TObject);
    procedure sp_addallClick(Sender: TObject);
    procedure DBGrid_depmatrersDblClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btn_closedepsClick(Sender: TObject);
    procedure ce_matquanKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tbn_addmatertorepClick(Sender: TObject);
  private
    { Private declarations }
    start_table_row,title_row:integer;
    col_name,col_kod, col_units, col_price,col_left:integer; //омера колонок
    col_nums : array[ 1..5] of integer;
    num_year, num_month, year_row:integer;
    F_name:String;
    Excel : Variant;
    WorkSheet : Variant;
    f_error:String;
    F_neemListCount, F_needWorkBoks:integer;
    last_grid_row:integer;
    dm_MasterMaters: Tdm_MatersMasters;
    report_status :TStatusReport;
    deps_status:TStatusDeps;
    f_isreportInbase:boolean;
    old_materq:real;
    cul_left:real;
    cur_brig_id:integer;
    frmAddReportOut:Tfrm_AddReportMatOut;
    frm_addmform:Tfrm_AddMaterToMaterRep;

    procedure setReportStatus(status:TStatusReport);
    procedure setDepsStatus(dep_status:TStatusDeps);
    procedure StausSinchR();
    procedure setBottomText(s:string);
    procedure setCaptios();
    procedure SetReportTitle(f_name:string; r_year:integer; month:integer);
    procedure setOldMaterq(q:real);
    procedure PrepareddMater(num_dep:integer; num_order:string;datedep:string; addres:string;
                kod,mat_name:string; units,price:string;val,left:real  );
    procedure StartCorrectMater();
    procedure SaveMaterVal(new_val:real);
    procedure EnabledBottombutons(val:real);
    procedure DepsAfterScrol(val:string);


  public
    { Public declarations }
    procedure setIdBrig(id:integer);


  end;

var
  frm_materstobrig: Tfrm_materstobrig;




implementation

{$R *.dfm}
uses ComObj,ReadMasterMaters,ExelError, dmMain, ConstRepMater, Math;



procedure Tfrm_materstobrig.setCaptios();
begin
 Caption:=main_Caption;
 DBGridEh_Report.Columns[1].Title.Caption:=NameWord;
 DBGridEh_Report.Columns[2].Title.Caption:=UnitWord;
 DBGridEh_Report.Columns[3].Title.Caption:=PriceWord;
 DBGridEh_Report.Columns[4].Title.Caption:=Cap_left;
 DBGridEh_Report.Columns[5].Title.Caption:=Cap_all_q;
 DBGridEh_Report.Columns[6].Title.Caption:=Cap_isstore;
 DBGridEh_Report.Columns[7].Title.Caption:=capColumn;

 lbl_MaterReportCap.Caption:=cap_MaterReportCap;

 DBGrid_depmatrers.Columns[0].Title.Caption:=StartTableWord;
 DBGrid_depmatrers.Columns[1].Title.Caption:=NameWord;
 DBGrid_depmatrers.Columns[2].Title.Caption:=Cap_all_q;
 DBGrid_depmatrers.Columns[3].Title.Caption:=PriceWord;
 DBGrid_depmatrers.Columns[4].Title.Caption:=UnitWord;
 DBGrid_depmatrers.Columns[5].Title.Caption:=ReportWord;

 DBGridEh1.Columns[0].Title.Caption:=OrderWord;
 DBGridEh1.Columns[1].Title.Caption:=DepWord;
 DBGridEh1.Columns[2].Title.Caption:=DataWord;
 DBGridEh1.Columns[3].Title.Caption:=AdresWord;

 lbl_brigcap.Caption  :=cap_brig;
 lb_brig2.Caption:=cap_brig;
 lbl_depscaption.Caption:=cap_depscaption;
 btn_openFile.Caption:=cap_OpenFile;
 btn_SavedReport.Caption:=cap_Savereport;
 btn_openFromBase.Caption:=cap_openFromBase;
 btn_close_report.Caption:=cap_close_report;
 btn_closedeps.Caption:=cap_close_deps;
 lbl_depaddinfo.Caption:=cap_depaddinfo;
 lbl_used_maters.Caption:=cap_used_maters;
 btn_addmater.Caption:=cap_addmater;
 btn_change.Caption:=cap_change;
 btn_delete.Caption:=cap_delete;
 bb_close.Caption:=cap_close;
 tbn_addmatertorep.Caption := capAddmater;

 gb_departure.Caption:=cap_dep;
 gb_material.Caption:=cap_material;
 gb_out_repcap.Caption:=ReportWord;
 
 lbl_left.Caption:=cap_left;
 lbl_used.Caption:=cap_used;
 btn_searchdeps.Caption:=cacp_SearchDep;
 lbl_repp.Caption
end;



procedure Tfrm_materstobrig.FormCreate(Sender: TObject);
var s:string;
begin
setCaptios();
dm_MasterMaters:=Tdm_MatersMasters.Create(self);
dm_MasterMaters.SetCurrentDepMater:=EnabledBottombutons;
dm_MasterMaters.AfterScrolDep:=DepsAfterScrol;
frmAddReportOut:=Tfrm_AddReportMatOut.Create(self);
frmAddReportOut.f_funcheck:=dm_MatersMasters.IsCanOutReportInBase;
begin
 s:=dm_MasterMaters.OpenDsets;
 if s<>'' then
   Statusbar1.Panels[0].Text:=s;

end;
frm_addmform:=Tfrm_AddMaterToMaterRep.Create(self);
frm_addmform.ds_s_mat2.DataSet:=dm_MasterMaters.dset_s_mat2;
frm_addmform.ds_s_mat2column.DataSet:=dm_MasterMaters.dset_S_MAT2_COUMN;
end;



procedure Tfrm_materstobrig.FormDestroy(Sender: TObject);
begin
frm_addmform.Free;
frmAddReportOut.Free;
dm_MasterMaters.Free;
end;

procedure Tfrm_materstobrig.RxLbBrigsChange(Sender: TObject);
var id:integer;
begin
 id:=RxLbBrigs.KeyValue;
 dm_MasterMaters.sertBrigId(id);
{ RxDBL_brigs2.DisplayValue:=RxDBL_brigs2.LookupSource.DataSet.fieldbyname(RxDBL_brigs2.LookupDisplay).AsString;}
end;

procedure Tfrm_materstobrig.FormShow(Sender: TObject);
begin
top:=60;
left:=10;
 setReportStatus(Rempty);
 setDepsStatus(DepsEmpty);
 RxDBL_brigs2.DisplayValue:=RxDBL_brigs2.LookupSource.DataSet.FieldByName(RxDBL_brigs2.LookupDisplay).AsString;

end;

procedure Tfrm_materstobrig.setIdBrig(id:integer);
begin
 cur_brig_id:=id;
 RxLbBrigs.LookupSource.DataSet.Locate('id', vararrayof([id]),[]);
 RxLbBrigs.DisplayValue:=RxLbBrigs.LookupSource.DataSet.fieldbyname(RxLbBrigs.LookupDisplay).asstring;

end;

procedure Tfrm_materstobrig.setBottomText(s:string);
begin
 Statusbar1.Panels[0].Text:=s;
end;

procedure Tfrm_materstobrig.btn_openFileClick(Sender: TObject);
var readerExel:TreadMasterMaters;
begin
DecimalSeparator:=',';
F_error:='';
if RxLbBrigs.KeyValue>0 then
if OpenDialog1.Execute then
begin
   F_name:=OpenDialog1.FileName;
   dm_MasterMaters.StartGetData;
   readerExel:=TreadMasterMaters.Create(f_name,dm_MasterMaters.getDataFromList);
   try
    if  readerExel.doRead() then
    begin
     num_year:=readerExel.n_year;
     num_month:=readerExel.n_month;
     setReportStatus(Rloaded);
     SetReportTitle(F_name,readerExel.n_year,readerExel.n_month );
    end
    else StatusBar1.Panels[0].Text:=readerExel.error
   finally
     readerExel.Free;
   end;
  end 
  
end;


procedure Tfrm_materstobrig.setReportStatus(status:TStatusReport);
begin
report_status:=status;
 case report_status of
   Rempty:begin
          if cur_brig_id=0 then
             setBottomText(mes_SelBrig)
          else
           setBottomText(mes_OpenReport);
             RxLbBrigs.Enabled:=true;
             rxdbReports.Enabled:=true;
             btn_openFile.Enabled:=true;
             btn_SavedReport.Enabled:=false;
             btn_openFromBase.Enabled:=true;
             f_isreportInbase:=false;
             btn_close_report.Enabled:=false;
             pnl_report.Caption:='';
             lbl_report_title.Caption:='';
             pnl_addmater.Visible:=false;
             pnl_actions.Visible:=true;
             tbn_addmatertorep.Visible:=false;
             {pnl_deps.Visible:=false;
             de_start.Enabled:=false;
             de_end.Enabled:=false;
             RxDBL_brigs2.Enabled:=false;
             btn_searchdeps.Enabled:=false;

             lbl_titledeps.Caption:='';

             btn_addmater.Visible:=false;
             btn_change.Visible:=false;
             btn_delete.Visible:=false;}
         end;
   Rloaded:begin
            RxLbBrigs.Enabled:=false;
             rxdbReports.Enabled:=false;
            btn_SavedReport.Enabled:=true;
            btn_close_report.Enabled:=true;
            btn_openFromBase.Enabled:=false;
            { pnl_deps.Visible:=false;
             de_start.Enabled:=false;
             de_end.Enabled:=false;
             RxDBL_brigs2.Enabled:=false;
             btn_searchdeps.Enabled:=false;
             }
            setBottomText(mes_SaveCloseReport);
            pnl_addmater.Visible:=false;
            DBGridEh_Report.Enabled:=true;
            lbl_titledeps.Caption:='';

            pnl_actions.Visible:=true;
            tbn_addmatertorep.Visible:=false;

          end;
   Ropened:begin
            RxLbBrigs.Enabled:=false;
             rxdbReports.Enabled:=false;
            btn_SavedReport.Enabled:=false;
            btn_close_report.Enabled:=true;
            btn_openFromBase.Enabled:=false;
            btn_openFile.Enabled:=false;
            DBGridEh_Report.Enabled:=true;
            tbn_addmatertorep.Visible:=true;
         //   setBottomText('Отчет открыт из базы ');
           { pnl_deps.Visible:=true;
            de_start.Enabled:=true;
            de_end.Enabled:=true;
            RxDBL_brigs2.Enabled:=true;
            btn_searchdeps.Enabled:=true;
            pnl_addmater.Visible:=false;

            lbl_titledeps.Caption:='';}
            pnl_actions.Visible:=true;
          end;
     end;
     StausSinchR();
end;

procedure Tfrm_materstobrig.setDepsStatus(dep_status:TStatusDeps);
begin

  deps_status:=dep_status;
  case deps_status of
  DepsEmpty:begin
              pnl_deps.Visible:=false;
              de_start.Enabled:=true;
              de_end.Enabled:=true;
              RxDBL_brigs2.Enabled:=true;
              RxDBLreports_out.Enabled:=true;
              btn_closedeps.Enabled:=false;
              btn_searchdeps.Enabled:=true;
              Button1.Enabled:=true;
            end;
  DepsOpened:begin

             pnl_addmater.Visible:=false;
             Panel3.Enabled:=true;
             de_start.Enabled:=false;
             de_end.Enabled:=false;
             RxDBL_brigs2.Enabled:=false;
             RxDBLreports_out.Enabled:=false;
             Button1.Enabled:=false;


             DBGridEh1.Enabled:=true;

             pnl_actions.Visible:=true;
             btn_closedeps.Enabled:=true;
             pnl_deps.Visible:=true;

            end;
  AddMater:begin
             btn_close_report.Enabled:=false;
             Panel3.Enabled:=false;
             de_start.Enabled:=false;
             de_end.Enabled:=false;
             RxDBL_brigs2.Enabled:=false;
             btn_searchdeps.Enabled:=false;
             Button1.Enabled:=false;
             DBGridEh_Report.Enabled:=false;
             DBGridEh1.Enabled:=false;
             btn_addmater.Enabled:=false;
             btn_change.Enabled:=false;
             btn_delete.Enabled:=false;
             pnl_addmater.Visible:=true;
             setBottomText(mesAddMater);
             btn_closedeps.Enabled:=false;
             Button1.Enabled:=false;

           end;
 end;

 StausSinchR();

end;

procedure Tfrm_materstobrig.StausSinchR();
begin
 if (report_status=ROpened) and  (deps_status=DepsOpened) then
 begin
             btn_addmater.Visible:=true;
             btn_change.Visible:=true;
             btn_delete.Visible:=true;
 end
 else
  begin
     btn_addmater.Visible:=false;
     btn_change.Visible:=false;
      btn_delete.Visible:=false;
  end;

end;

procedure Tfrm_materstobrig.btn_SavedReportClick(Sender: TObject);
var ff_name:string;
issaved:boolean;
begin
issaved:=true;
ff_name:=ExtractFilename(F_name);
if dm_MasterMaters.IsReportInBase(num_year, num_month) then
begin
 issaved:=false;
 if  MessageDlg(questIsDelMaterRepoordAllData,mtConfirmation,
  [mbYes, mbNo],0) = mrYes then
  begin
   F_error:=dm_MasterMaters.deleteAllReports(num_year, num_month);
   issaved:=true;

 end
 else
  setBottomText(mesCancelUser);
end;
 if (F_error= '') and (issaved) then
 begin
 F_error:=dm_MasterMaters.SaveReport(num_year, num_month, ff_name);
 if F_error<>'' then
     StatusBar1.Panels[0].Text:=F_error
 else
 begin

 setReportStatus(Ropened);
 rxdbReports.KeyValue:=dm_MasterMaters.CurrentReportId;
 setBottomText(mesReposrtIsSave);
 end
 end;
 

end;



procedure Tfrm_materstobrig.btn_close_reportClick(Sender: TObject);
begin
  setReportStatus(Rempty);
  dm_MasterMaters.CloseData();
  mem_depinfo.Lines.Text:='';
end;



procedure Tfrm_materstobrig.btn_openFromBaseClick(Sender: TObject);
var text:string;
begin
if not rxdbReports.KeyValue<>null then
begin
 text:=dm_MasterMaters.OpenReport(rxdbReports.KeyValue);
 if text = '' then
 begin
  setBottomText(M_OpenSuccess) ;
  setReportStatus(Ropened);
  SetReportTitle(dm_MasterMaters.filename,dm_MasterMaters.year,dm_MasterMaters.month );
 end
 else
  setBottomText(text);
end;
end;

procedure Tfrm_materstobrig.SetReportTitle(f_name:string; r_year:integer; month:integer);
begin
     lbl_report_title.Caption:='Файл  - '+F_name+#13+
     'рік - '+IntToStr(r_year)+'     '+
     'місяць - '+monthes_ua[month]+' Майстер - '+ds_brigs.DataSet.fieldbyname('name_r').AsString;

end;

procedure Tfrm_materstobrig.btn_searchdepsClick(Sender: TObject);
var dt1, dt2:TDateTime;
err:string;
begin
dt1:=de_start.Date;
dt2:=de_end.Date;
if dt2=0  then
begin
 de_end.Date:=Now();
 dt2:=Now();
end;

if dt1=0 then
begin
 de_start.SetFocus;
 setBottomText(Err_InputStartDate);
end
else
if dt1>dt2 then
begin
 de_start.SetFocus;
 setBottomText(Err_StartMoreEndDate);

end
else
if RxDBL_brigs2.LookupSource.DataSet.FieldByName('id').AsInteger<0 then
begin
  RxDBL_brigs2.SetFocus;
  setBottomText(mes_SelBrigDep);

end
else
 if RxDBLreports_out.LookupSource.DataSet.FieldByName('id').AsInteger<0 then
 begin
  RxDBLreports_out.SetFocus;
  setBottomText(mes_SelOutreport);

 end

else
begin
err:=dm_MasterMaters.searchDeps(dt1, dt2);
if err<>'' then
  setBottomText(err)
else
begin
  setBottomText(mes_depfound);
  setDepsStatus(DepsOpened);
  lbl_titledeps.Caption:=format(maked_deps,[RxLbBrigs.DisplayValue,dateToStr(dt1),dateToStr(dt2)]);
  dm_MasterMaters.mem_depsAfterScroll(ds_depmaters.DataSet);
end
end;

end;

procedure Tfrm_materstobrig.StartCorrectMater();
var
id_mater, id_dep,num_dep:integer;
kod,  name_mater, price,num_nar,dt_dep, units,addres:string;
all_q,q:double;
begin

name_mater:=DBGridEh_Report.DataSource.DataSet.fieldbyname('name').AsString;
price:=DBGridEh_Report.DataSource.DataSet.fieldbyname('price').AsString;
kod:=DBGridEh_Report.DataSource.DataSet.fieldbyname('kod').AsString;
num_nar:=DBGridEh1.DataSource.DataSet.fieldbyname('nomer').asstring;
num_dep:=DBGridEh1.DataSource.DataSet.fieldbyname('nnomer').AsInteger;
dt_dep:=trim(DBGridEh1.DataSource.DataSet.fieldbyname('dt').asstring);
addres:=DBGridEh1.DataSource.DataSet.fieldbyname('address').asstring;
units:=DBGridEh_Report.DataSource.DataSet.fieldbyname('Units').AsString;
if not dm_MasterMaters.startaddMater() then
 q:=0
else
  q:=dm_MasterMaters.mem_depmaters.fieldbyname('all_q').AsFloat;
setOldMaterq(q);

PrepareddMater(num_dep,num_nar,dt_dep,addres,kod,name_mater,units,price,
                q,DBGridEh_Report.DataSource.DataSet.fieldbyname('left').AsFloat);
setDepsStatus(AddMater);

end;

procedure Tfrm_materstobrig.bb_canceladdClick(Sender: TObject);
begin
   setDepsStatus(DepsOpened);
   setReportStatus(Ropened) ;
   EnabledBottombutons(old_materq);
end;

procedure Tfrm_materstobrig.ce_matquanChange(Sender: TObject);
var tr_position:integer;
begin
if   ce_matquan.Value<>old_materq then
 btn_savemater.Enabled:=true
else
 btn_savemater.Enabled:=false;
if ce_matquan.Value>ce_matquan.MaxValue then
   ce_matquan.Value:=ce_matquan.MaxValue;
 lbl_left_q.Caption:=format('%*.*f',[8,3,cul_left-ce_matquan.Value]);
tr_position:=round( cul_left/ce_matquan.Value*20);
end;

procedure Tfrm_materstobrig.setOldMaterq(q:real);
begin
  old_materq:=q;
  ce_matquan.Value:=q;

end;


procedure Tfrm_materstobrig.btn_minusClick(Sender: TObject);
begin
if ce_matquan.Value>=0.1 then
begin
   ce_matquan.Value:=ce_matquan.Value-0.1
 end
else
  ce_matquan.Value:=0;
end;

procedure Tfrm_materstobrig.btn_addClick(Sender: TObject);
begin
if ce_matquan.Value<ce_matquan.MaxValue then
   ce_matquan.Value:=ce_matquan.Value+0.1;
end;

procedure Tfrm_materstobrig.btn_savematerClick(Sender: TObject);
var
 new_val:real;
begin
  new_val:=ce_matquan.Value;
  SaveMaterVal(new_val);
end;

procedure Tfrm_materstobrig.SaveMaterVal(new_val:real);
var id_dep, id_repmater:integer;

begin
  DecimalSeparator:='.';
  id_dep:=DBGridEh1.DataSource.DataSet.fieldbyname('idn').AsInteger;
  id_repmater:=DBGridEh_Report.DataSource.DataSet.fieldbyname('id').AsInteger;
  f_error:=dm_MasterMaters.saveMaterQ(id_repmater, id_dep,new_val);
  if f_error<>'' then
  begin
   setbottomtext(F_error);
     EnabledBottombutons(new_val);
  end
  else
  begin
   setbottomtext(mes_ChangedMakes);

   setDepsStatus(depsOpened);
   setReportStatus(Ropened);
   mem_depinfo.Lines.Text:=DBGridEh1.DataSource.DataSet.FieldByName('dop_inf').AsString;
   EnabledBottombutons(new_val);
  end;

end;

procedure Tfrm_materstobrig.DBGridEh1CellClick(Column: TColumnEh);
begin
  DepsAfterScrol(DBGridEh1.DataSource.DataSet.FieldByName('dop_inf').AsString);
end;

procedure Tfrm_materstobrig.DepsAfterScrol(val:string);
begin
  mem_depinfo.Lines.Text:=DBGridEh1.DataSource.DataSet.FieldByName('dop_inf').AsString;
end;

procedure Tfrm_materstobrig.PrepareddMater(num_dep:integer; num_order:string;datedep:string; addres:string;
                kod,mat_name:string;units,price:string;val,left:real  );
begin
 mem_titleadd.Lines.Text:=mesAddMater;
 lbl_numdep.Caption:='№'+intTostr(num_dep);
 lbl_numorder.Caption:='№'+num_order;
 lbl_dep_date.Caption:=datedep;
 lbl_dep_address.Caption:=addres;
 lbl_mat_name.lines.Text:=mat_name;
 lbl_kod.Caption:=kod;
 lbl_matprice.Caption:=price+'грн' ;
 lbl_left_q.Caption:=Format('%*.*f',[8,3,left]);
  ce_matquan.MaxValue:=val+left;
 ce_matquan.Value:=val;
 cul_left:=val+left;
 lbl_units.caption:=units;
 lbl_brigname.Caption:= RxDBL_brigs2.DisplayValue;
 lbl_year.Caption:=RxDBLreports_out.LookupSource.DataSet.FieldByName('num_year').AsString;
 lbl_month.Caption:=monthes_ua[RxDBLreports_out.LookupSource.DataSet.FieldByName('num_month').AsInteger];
if units = 'шт'  then
 begin
   ce_matquan.Increment:=1;
   ce_matquan.Decimal:=0;
 end

 else
 begin
   ce_matquan.Increment:=0.001;
   ce_matquan.Decimal:=3;
 end;
end;


procedure Tfrm_materstobrig.btn_addmaterClick(Sender: TObject);
begin
  StartCorrectMater();
end;

procedure Tfrm_materstobrig.btn_changeClick(Sender: TObject);
begin
StartCorrectMater();
end;

procedure Tfrm_materstobrig.btn_deleteClick(Sender: TObject);
var matname:string;
begin
matname:=DBGridEh_Report.DataSource.DataSet.fieldbyname('name').AsString;

with CreateMessageDialog(format(quesIsDeleteMaterFromDep,[matname]), mtConfirmation, [mbYes, mbNo]) do
begin
      try
        TButton(FindComponent('Yes')).Caption:= 'Так';
        TButton(FindComponent('No')).Caption:= 'Ні';
        ShowModal;
      finally
       if ModalResult =  mrYes then
         SaveMaterVal(0);
        end;
        Free;
      end;
end;

procedure Tfrm_materstobrig.EnabledBottombutons(val:real);
begin
  btn_addmater.Enabled:=false;
   btn_change.Enabled:=false;
   btn_delete.Enabled:=true;
  if RxDBLreports_out.LookupSource.DataSet.FieldByName('id').AsInteger>0 then
  if val=0 then
  begin
   btn_addmater.Enabled:=true;
   btn_change.Enabled:=false;
   btn_delete.Enabled:=false;
  end
  else
  begin
    btn_addmater.Enabled:=false;
   btn_change.Enabled:=true;
   btn_delete.Enabled:=true;
  end;

end;




procedure Tfrm_materstobrig.DBGrid_depmatrersEnter(Sender: TObject);
begin
setbottomtext(mesToGoToMater);
end;

procedure Tfrm_materstobrig.sp_removeallClick(Sender: TObject);
begin
ce_matquan.Value:=0;
end;

procedure Tfrm_materstobrig.sp_addallClick(Sender: TObject);
begin
ce_matquan.Value:=ce_matquan.MaxValue;
end;

procedure Tfrm_materstobrig.DBGrid_depmatrersDblClick(Sender: TObject);
begin
 dm_MasterMaters.SetCurrentMaterFromDepMater;
end;

procedure Tfrm_materstobrig.Button1Click(Sender: TObject);

var s:string;
begin

frmAddReportOut.id_brig:=RxDBL_brigs2.LookupSource.DataSet.fieldbyname('id').AsInteger;
frmAddReportOut.brigname:=RxDBL_brigs2.LookupSource.DataSet.fieldbyname('name_r').AsString;
frmAddReportOut.f_funcheck:=dm_MasterMaters.IsCanOutReportInBase;
if frmAddReportOut.ShowModal = mrOk then
begin
 s:= dm_MasterMaters.AddOutReport(frmAddReportOut.nummonth, frmAddReportOut.numyear);
 if s='' then
 begin
    RxDBLreports_out.DisplayValue:= RxDBLreports_out.LookupSource.DataSet.FieldByName(RxDBLreports_out.LookupDisplay).AsString;

 end
 else
 setBottomText('Сталася помилка звіт не додано!! '+s);
end;
end;


procedure Tfrm_materstobrig.btn_closedepsClick(Sender: TObject);
begin
  dm_MasterMaters.CloseDeps;
  setDepsStatus(DepsEmpty);
end;

procedure Tfrm_materstobrig.ce_matquanKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if  ce_matquan.Decimal=3  then
 if floor(ce_matquan.Value*1000)<ce_matquan.Value*1000 then
   ce_matquan.Value:=floor(ce_matquan.Value*1000)/1000;
end;

procedure Tfrm_materstobrig.tbn_addmatertorepClick(Sender: TObject);
var kod, name, units:string;
 price, all_q:real;
 s:string;
 mr:integer;
 fk_column:integer;
begin
 frm_addmform.Clear;
 mr:=frm_addmform.ShowModal;
 if mr = mrOk then
 begin
   kod:=frm_addmform.kod;
   name:=frm_addmform.MName;
   units:=frm_addmform.Units;
   price:=frm_addmform.Price;
   all_q:=frm_addmform.Quon;
   fk_column:=frm_addmform.FKColumn;
   s:= dm_MasterMaters.addmatertoStorage(kod, name, units,price, all_q,fk_column);
   rxdbReports.DisplayValue:=rxdbReports.LookupSource.DataSet.fieldbyname(rxdbReports.LookupDisplay).AsString;
   RxDBLreports_out.DisplayValue:=RxDBLreports_out.LookupSource.DataSet.fieldbyname(RxDBLreports_out.LookupDisplay).AsString;
   setBottomText(s);

 end;
end;

end.
