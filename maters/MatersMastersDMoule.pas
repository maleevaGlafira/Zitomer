unit MatersMastersDMoule;

interface

uses
  SysUtils, Classes, DB, kbmMemTable, IBDatabase, IBCustomDataSet, IBSQL, DMmain;

const show_mat = '';

type
  TFloatProcedure=  procedure(val:real) of object;
  TStringProcedure = procedure (val:string) of object;
  Tdm_MatersMasters = class(TDataModule)
    mem_main: TkbmMemTable;
    mem_mainnum_year: TIntegerField;
    mem_mainnum_month: TIntegerField;
    mem_mainkod: TStringField;
    mem_mainname: TStringField;
    mem_mainUnits: TStringField;
    mem_mainprice: TFloatField;
    mem_mainleft: TFloatField;
    dset_reports: TIBDataSet;
    dset_brigs: TIBDataSet;
    tran_main: TIBTransaction;
    dset_report_mats2: TIBDataSet;
    tran_s: TIBTransaction;
    dset_brigsID: TIntegerField;
    dset_brigsCONCATENATION: TIBStringField;
    dset_reportsID: TIntegerField;
    dset_reportsFK_ID_BRIG: TIntegerField;
    dset_reportsNUM_YEAR: TSmallintField;
    dset_reportsNUM_MONTH: TSmallintField;
    dset_report_mats2ID: TIntegerField;
    dset_report_mats2FK_ID_REPORT: TIntegerField;
    dset_report_mats2FK_ID_MATER: TIntegerField;
    dset_report_mats2ALL_Q: TIBBCDField;
    dset_report_mats2LEFT_Q: TIBBCDField;
    mem_mainid: TIntegerField;
    mem_maininfo: TMemoField;
    dset_brigsNAME_R: TIBStringField;
    dset_reportsFILENAME: TIBStringField;
    tran_delete: TIBTransaction;
    IBSQL_delete: TIBSQL;
    IBSQL_add_row: TIBSQL;
    dset_report_mats2NAME_R: TIBStringField;
    dset_report_mats2KOD: TIBStringField;
    dset_reportsshow_title: TStringField;
    dset_report_mats2UNITS: TIBStringField;
    dset_report_mats2PRICE: TIBBCDField;
    dset_deps: TIBDataSet;
    mem_deps: TkbmMemTable;
    mem_depsidn: TIntegerField;
    mem_depsidz: TIntegerField;
    mem_depsdt: TStringField;
    mem_depsaddress: TStringField;
    mem_depsnomer: TStringField;
    mem_depsdop_inf: TStringField;
    mem_depsnnomwe: TIntegerField;
    dep_depmater: TIBDataSet;
    mem_depmaters: TkbmMemTable;
    IntegerField1: TIntegerField;
    StringField3: TStringField;
    mem_depmaterskod: TStringField;
    mem_depmatersid_mater: TIntegerField;
    mem_depmatersname: TStringField;
    mem_depmatersall_q: TFloatField;
    tran_deps: TIBTransaction;
    ibs_addmater: TIBSQL;
    mem_depmatersid_report_mater: TIntegerField;
    mem_depmatersid: TIntegerField;
    mem_depmatersid_zav: TIntegerField;
    mem_mainall_q: TFloatField;
    mem_depmatersprice: TFloatField;
    mem_depmatersunits: TStringField;
    mem_depmatersreport_name: TStringField;
    mem_materdep: TkbmMemTable;
    mem_materdepid_mater: TIntegerField;
    mem_materdepidn: TIntegerField;
    mem_materdepnomer: TStringField;
    mem_materdepnnomer: TStringField;
    mem_materdepaddress: TStringField;
    mem_materdepstartdt: TDateTimeField;
    mem_materdependdate: TDateTimeField;
    mem_materdepshowdate: TStringField;
    dset_materdep: TIBDataSet;
    mem_depsid_attach: TIntegerField;
    dset_brigs2: TIBDataSet;
    IntegerField2: TIntegerField;
    IBStringField1: TIBStringField;
    IBStringField2: TIBStringField;
    dset_out_reports: TIBDataSet;
    tran_out_reports: TIBTransaction;
    dset_out_reportsID: TIntegerField;
    dset_out_reportsFK_ID_BRIG: TIntegerField;
    dset_out_reportsNUM_YEAR: TSmallintField;
    dset_out_reportsNUM_MONTH: TSmallintField;
    dset_out_reportsshow_title: TStringField;
    mem_depmatersreport_our_name: TStringField;
    mem_depmatersis_his: TBooleanField;
    mem_depmatersFK_ID_REPORT: TIntegerField;
    mem_mainis_storage: TBooleanField;
    dset_report_mats2IS_STORAGE: TSmallintField;
    dset_s_mat2: TIBDataSet;
    dset_s_mat2ID: TIntegerField;
    dset_s_mat2KOD: TIBStringField;
    dset_s_mat2NAME_R: TIBStringField;
    dset_s_mat2UNITS: TIBStringField;
    dset_s_mat2PRICE: TIBBCDField;
    tran_s_mat2: TIBTransaction;
    mem_mainfk_column: TIntegerField;
    dset_S_MAT2_COUMN: TIBDataSet;
    dset_S_MAT2_COUMNID: TIntegerField;
    dset_S_MAT2_COUMNNAME_R: TIBStringField;
    dset_S_MAT2_COUMNDEL: TIBStringField;
    dset_report_mats2FK_COLUMN: TIntegerField;
    dset_report_mats2NAME_COL: TIBStringField;
    mem_mainname_col: TStringField;
    procedure DataModuleDestroy(Sender: TObject);
    procedure dset_reportsCalcFields(DataSet: TDataSet);
    procedure mem_depsAfterScroll(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure mem_mainAfterScroll(DataSet: TDataSet);
    procedure dset_brigs2AfterScroll(DataSet: TDataSet);
    procedure dset_out_reportsCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
     F_year, F_month:integer;
     F_id_brig, f_id_brig_dep:integer;
     id_report:integer;
     f_word_month:string;
     f_brigname:string;
     f_filename:string;
     F_SetCurrentDepMater: TFloatProcedure;
     F_AfterScrolDep:TStringProcedure;
     f_id_report_out:integer;
     function SaveRow(id_report:integer):boolean;
     function SaveReportTitle():integer;
     function ReopenTran:boolean;
     procedure setReport(id:integer);
     function  ReopenSavedReport():string;
     procedure addDepMater(id_dep:integer);
     procedure ScrollDepMater();
     procedure setDepToMater(id_mater:integer);

  public
    { Public declarations }


    function getDataFromList(list:TStringList):string;
    procedure  StartGetData;
    procedure CloseData;
 //   function OpenBD(db_name, db_user, db_pass:string):boolean;
    function  OpenDsets():string;
    function SaveReport(num_year, num_month:integer; filename:string):string; //врзвращет строку ошибки усли не получилось сохрнить
    function IsReportInBase(num_year, num_month:integer):boolean;
    procedure sertBrigId(id:integer);
    procedure setBrigOutId(id:integer);
    property year:integer read f_year write F_year ;
    property month:integer read F_month write F_month;
    property filename:string read f_filename write f_filename ;
    function deleteReportData(id_report:integer):string;
    function deleteCurrentReport():string;
    function  deleteAllReports(num_year,num_month:integer):string;
    function OpenReport(id_op_rep:integer):string;
    property CurrentReportId :integer read id_report ;
    function searchDeps(start_dt, end_dt:TDateTime):string;
    procedure CloseDeps();
    function startaddMater():boolean;
    function saveMaterQ(id_repmater, id_dep:integer; new_val:real):string;
    function getDepMaters():string;
    property SetCurrentDepMater: TFloatProcedure write F_SetCurrentDepMater;
    procedure SetCurrentMaterFromDepMater();
    property  AfterScrolDep :  TStringProcedure write F_AfterScrolDep;
    procedure SetCuurentMaterDep();
    procedure IsCanOutReportInBase(num_month, num_year:integer; var  result:boolean);
    function AddOutReport(num_month, num_year:integer):string;
    procedure RecalcMemDepMater();
    function addmatertoStorage(kod, name, units:string; price, all_q:real; fk_column:integer):string;
  end;

function getFloat(s:string):real;

var
  dm_MatersMasters: Tdm_MatersMasters;

implementation

{$R *.dfm}
uses variants,ExelError, ConstRepMater;



procedure Tdm_MatersMasters.DataModuleDestroy(Sender: TObject);
begin

 CloseData;
 if dset_reports.Active then
    dset_reports.Close;
 if dset_brigs.Active then
     dset_brigs.Close;

 if dset_brigs2.Active then
    dset_brigs2.Close;
 if dset_S_MAT2_COUMN.Active then
  dset_S_MAT2_COUMN.Close;  
 if dset_s_mat2.Active then
    dset_s_mat2.Close;
 if tran_s_mat2.Active then
   tran_s_mat2.Commit;
 if tran_s.Active then
   tran_s.Commit;
 if tran_main.Active then
   tran_main.Commit;
 if tran_delete.Active then
 tran_delete.Commit;
if tran_deps.Active then
   tran_deps.Commit;
if tran_out_reports.Active then
  tran_out_reports.Commit; 
{ if db_main.Connected then
   db_main.Connected:=false;
   }
end;


procedure  Tdm_MatersMasters.StartGetData;
begin
  if mem_main.Active then
     mem_main.Close;
  if mem_materdep.Active then
     mem_materdep.Close;
  mem_main.Open;
  mem_materdep.Open;

end;

procedure  Tdm_MatersMasters.CloseData;
begin
if mem_main.Active then
 mem_main.close;
{if mem_depmaters.Active then
  mem_depmaters.Close;
if mem_deps.Active then
 mem_deps.Close;
if dset_report_mats2.Active then
   dset_report_mats2.Close;}
if mem_materdep.Active then
     mem_materdep.Close;
end;

function Tdm_MatersMasters.ReopenTran:boolean;
begin
try
 if tran_main.Active then
   tran_main.Commit;
 tran_main.StartTransaction;
 dset_reports.Open;


{ if f_id_brig_dep>0 then
  setBrigOutId(f_id_brig_dep);}

 dset_s_mat2.Open;



// dset_report_mats2.Open;
 result:=true;
except on e:exception do
  begin

   result:=false;
  end;
end;
end;

function Tdm_MatersMasters.SaveReport(num_year, num_month:integer;filename:string):string;

begin
id_report:=-1;
F_month:=num_month;
F_year:=num_year;
F_filename:=filename;
if not mem_main.Active then
 result:=Err_nothingSave
 else
 begin
{  if  not db_main.Connected then
   result:=Err_connected
  else}
   begin
    result:='';
    mem_main.First;
    if  not  ReopenTran() then  result:=Err_Saving+' tran!!'
    else
      try
        id_report:=SaveReportTitle();
        if id_report<0 then
          result:=Err_SavereportTitle
        else
        begin
         setReport(id_report);
         while  not mem_main.Eof do
         begin
          if not SaveRow(id_report) then
          begin
           result:=Err_SaveRowToBase+' код='+mem_main.fieldbyname('kod').AsString;

           break;
          end;
          mem_main.Next;

         end;
        end;
        if result='' then
        begin
         tran_main.Commit;
         ReopenTran();
        result:=ReopenSavedReport();
        end
        else
         tran_main.Rollback;

      except on e:exception do
      begin

       tran_main.Rollback;
       result:=Err_SaveRowToBase;
      end;
    end;

   end;
 end;
end;

function Tdm_MatersMasters.SaveReportTitle():integer;
begin

  try
    dset_reports.Append;
    dset_reports.FieldByName('fk_id_brig').AsInteger:=F_id_brig;
    dset_reports.FieldByName('num_year').AsInteger:=f_year;
    dset_reports.FieldByName('num_month').AsInteger:=f_month;
    dset_reports.FieldByName('filename').AsString:=f_filename;
    dset_reports.Post;
    result:=dset_reports.fieldbyname('id').AsInteger;

  except on e:exception do
   result:=-1;
  end;
end;

function Tdm_MatersMasters.SaveRow(id_report:integer):boolean;

var kod,name_r, units:string;
price, all_q:real;
is_storage:boolean;
fk_column:integer;



begin

 kod:=mem_main.fieldbyname('kod').AsString;
 units:=mem_main.fieldbyname('units').AsString;
 name_r:=mem_main.fieldbyname('name').AsString;
 price:=mem_main.fieldbyname('price').asfloat;
 all_q:=mem_main.fieldbyname('left').asfloat;
 is_storage:=mem_main.fieldbyname('is_storage').AsBoolean;
 fk_column:=mem_main.fieldbyname('fk_column').AsInteger;
 if  all_q>0 then
 try
    IBSQL_add_row.ParamByName('fk_id_report').AsInteger:=id_report;
    IBSQL_add_row.ParamByName('name_r').AsString:=name_r;
    IBSQL_add_row.ParamByName('kod').AsString:=kod;
    IBSQL_add_row.ParamByName('units').AsString:=units;
    IBSQL_add_row.ParamByName('price').AsFloat:=price;
    IBSQL_add_row.ParamByName('all_q').AsFloat:=all_q;
    IBSQL_add_row.ParamByName('fk_column').AsFloat:=fk_column;
    if is_storage then
      IBSQL_add_row.ParamByName('is_storage').AsInteger:=1
    else
     IBSQL_add_row.ParamByName('is_storage').IsNull:=true;

    IBSQL_add_row.ExecQuery;
    result:=true;

//   dset_add_row.Close;

 except on e:exception do
 begin
  result:=false;
 end;
 end
 else result:=true;


end;


function Tdm_MatersMasters.getDataFromList(list:TStringList):string;
begin
try
mem_main.Append;
mem_main.FieldByName('kod').AsString:=list[0];
mem_main.FieldByName('name').AsString:=list[1];
mem_main.FieldByName('Units').AsString:=list[2];
mem_main.FieldByName('price').AsFloat:=getFloat(list[3]);
mem_main.FieldByName('left').AsFloat:=getFloat(list[4]);
mem_main.FieldByName('all_q').AsFloat:=getFloat(list[4]);
mem_main.FieldByName('info').AsString:='';
mem_main.FieldByName('is_storage').AsBoolean:=false;
mem_main.FieldByName('fk_column').AsInteger:=0;
mem_main.FieldByName('name_col').AsString:='';

mem_main.Post;
 result:='';
except on e:exception do
begin
 result:=e.Message;
end;
end;



end;



{function Tdm_MatersMasters.OpenBD(db_name, db_user, db_pass:string):boolean;
begin
 if db_main.Connected then
   db_main.Connected:=false;
  db_main.DatabaseName:=db_name;
  db_main.Params.clear;
  db_main.Params.Add('user_name='+trim(db_user));
  db_main.Params.Add('password='+trim(db_pass));
  db_main.Params.Add('lc_ctype=WIN1251');
  try
   db_main.Connected:=true;
   result:=true;
  except on e:exception do
  begin
    result:=false;
  end;
  end;
 end;
}

function getFloat(s:string):real;
begin
if trim(s)='' then result:=0
else
begin
 result:=StrToFloat(s);
 result:=round(result*1000)/1000;
end;
end;



function  Tdm_MatersMasters.OpenDsets():string;
begin
 try
  dset_brigs.Open;
  dset_brigs2.Open;
  dset_S_MAT2_COUMN.Open;
  dset_s_mat2.Open;
  dset_reports.Open;



//  dset_report_mats2.Open;
 except on e:exception do
 begin
   result:=Err_openDsets+' ' +e.Message;
 end;
 end;

end;

procedure Tdm_MatersMasters.sertBrigId(id:integer);
begin
if dset_brigs.Active then
if dset_brigs.Locate('id', vararrayof([id]),[]) then
begin
  F_id_brig:=id;
  f_brigname:=dset_brigs.fieldbyname('name_r').AsString;
  if  dset_reports.Active then
 dset_reports.Close;
 dset_reports.ParamByName('id_brig').AsInteger:=F_id_brig;
 dset_reports.Open;

end;
end;

procedure Tdm_MatersMasters.setReport(id:integer);
begin
 id_report:=id;
 if dset_reports.Active then
  if dset_reports.Locate('id', vararrayof([id]),[]) then
   begin
    F_year:=dset_reports.fieldbyname('NUM_YEAR').AsInteger;
    f_month:=dset_reports.fieldbyname('NUM_Month').AsInteger;
    f_filename:=dset_reports.fieldbyname('filename').AsString;
   end;
 if tran_main.Active then
  begin
   if dset_report_mats2.Active then
     dset_report_mats2.Close;
   dset_report_mats2.ParamByName('id_report').AsInteger:=id;
   dset_report_mats2.Open;
  end;
end;

function Tdm_MatersMasters.IsReportInBase(num_year, num_month:integer):boolean;
begin
 result:=false;
  if dset_reports.Locate('fk_id_brig;num_year;num_month', vararrayof([F_id_brig,num_year, num_month]),[]) then
  begin
    id_report:=dset_reports.fieldbyname('id').asinteger;
    result:=true;

  end;
end;

function Tdm_MatersMasters.deleteReportData(id_report:integer):string;
begin
  tran_delete.StartTransaction;
  result:='';
  try
     IBSQL_delete.SQL.Text:=format('delete from REPORT_MATS2 where fk_id_report=%d',[id_report]);
     IBSQL_delete.ExecQuery;
     IBSQL_delete.SQL.Text:=format('delete from matreports where id=%d',[id_report]);
     IBSQL_delete.ExecQuery;
     tran_delete.Commit;
     reopentran();
  except on e:exception
  do  begin
    result:=Err_Delete_Report;
    tran_delete.Rollback;
  end
  end;

end;

function Tdm_MatersMasters.deleteCurrentReport():string;
begin
result:='';
 if id_report>0 then
  result:= deleteReportData(id_report);
end;

function  Tdm_MatersMasters.deleteAllReports(num_year, num_month:integer):string;
begin
result:='';
while  (IsReportInBase(num_year, num_month)) and (result='') do
result:=deleteCurrentReport();
end;



function Tdm_MatersMasters.OpenReport(id_op_rep:integer):string;

var isadd:boolean;
function getRowDataFromDset(dset:TDataset):boolean;
begin
try
 mem_main.Append;
 mem_main.FieldByName('id').AsInteger:=dset.fieldbyname('id').asinteger;
 mem_main.FieldByName('kod').Asstring:=dset.fieldbyname('kod').asString;
 mem_main.FieldByName('name').Asstring:=dset.fieldbyname('name_r').asString;
 mem_main.FieldByName('units').Asstring:=dset.fieldbyname('units').asString;
 mem_main.FieldByName('price').Asfloat:=dset.fieldbyname('price').Asfloat;
 mem_main.FieldByName('all_q').Asfloat:=dset.fieldbyname('all_q').Asfloat;
 mem_main.FieldByName('left').Asfloat:=dset.fieldbyname('left_q').Asfloat;
 mem_main.FieldByName('is_storage').AsBoolean:=(dset.fieldbyname('is_storage').AsInteger=1);
 mem_main.FieldByName('fk_column').AsInteger:=dset.fieldbyname('fk_column').asinteger;
 mem_main.FieldByName('name_col').AsString:=dset.fieldbyname('name_col').asstring;
 setDepToMater(mem_main.FieldByName('id').AsInteger);
 mem_main.Post;
 result:=true;
except on e:exception do
begin
  result:=false;
end
end;
end;

begin
 result:='';
 if  dset_reports.Locate('id',vararrayof([id_op_rep]),[]) then
 begin
  setReport(id_op_rep);
  dset_report_mats2.First;
 if   mem_main.Active then
  mem_main.Close;
  mem_main.Open;
if mem_materdep.Active then
  mem_materdep.Close;
 mem_materdep.Open;
  isadd:=true;
 while (not  dset_report_mats2.Eof) and (isadd) do begin
  isadd:=getRowDataFromDset(dset_report_mats2);
   dset_report_mats2.Next;
 end;
 RecalcMemDepMater();
  if not isadd then
   result:=Err_OpenReport
 end
 else
 begin
  result:=Err_NoReport;
 end
end;

procedure Tdm_MatersMasters.dset_reportsCalcFields(DataSet: TDataSet);
begin
 DataSet.FieldByName('show_title').AsString:=DataSet.fieldbyname('num_year').AsString+
 ' '+monthes_ua[DataSet.fieldbyname('num_month').Asinteger];
end;

function  Tdm_MatersMasters.ReopenSavedReport():string;
begin
sertBrigId(F_id_brig);
 result:=OpenReport(id_report);
end;

function Tdm_MatersMasters.searchDeps(start_dt, end_dt:TDateTime):string;
const sel_deps = 'select n.id nid,n.nomer nnomer, z.id zid, z.nomer,extract(year FROM z.dt_in) as zyear,n.dt_in, n.dt_out ,n.dop_inf, (select adres from get_adres(z.id_ul1, z.id_ul2,z.kod_ul,z.dop_adr, z.id_dopadres)) address , z.id_attach'+
 ' from narad n join zavjav z on z.id = n.id_zav '+
'  where n.id_brig = %d and n.dt_in>''%s'' and n.dt_in<=''%s''+1 '+
' union '+
' select n.id,n.nomer nnomer, z.id, z.nomer,extract(year FROM z.dt_in) as zyear, n.dt_in, n.dt_out,  n.dop_inf, (select adres from get_adres(z.id_ul1, z.id_ul2,z.kod_ul,z.dop_adr, z.id_dopadres)) address , z.id_attach'+
' from nnarad n join nzavjav z on z.id = n.id_zav '+
' where n.id_brig = %d and n.dt_in>''%s'' and n.dt_in<=''%s''+1 '+
' order by 5,4,1';

procedure AddDepRow();
begin
 mem_deps.Append;
 mem_deps.FieldByName('idn').AsInteger:=dset_deps.fieldbyname('nid').AsInteger;
 mem_deps.FieldByName('idz').AsInteger:=dset_deps.fieldbyname('zid').AsInteger;
 mem_deps.FieldByName('nomer').asString:=dset_deps.fieldbyname('nomer').AsString
 +'  '+dset_deps.fieldbyname('zyear').AsString;
 mem_deps.FieldByName('dt').asString:=dset_deps.fieldbyname('dt_in').AsString;
 if not dset_deps.fieldbyname('dt_out').IsNull then
  mem_deps.FieldByName('dt').asString:=mem_deps.FieldByName('dt').asString+'--'+dset_deps.fieldbyname('dt_out').AsString;
 mem_deps.FieldByName('address').AsString:=dset_deps.fieldbyname('address').AsString;
 mem_deps.FieldByName('dop_inf').AsString:=dset_deps.fieldbyname('dop_inf').AsString;
 mem_deps.FieldByName('nnomer').AsInteger:=dset_deps.fieldbyname('nnomer').AsInteger;
 mem_deps.FieldByName('id_attach').AsInteger:=dset_deps.fieldbyname('id_attach').AsInteger;
 


 mem_deps.Post;
 addDepMater( mem_deps.FieldByName('idn').AsInteger);
end;
begin
F_id_brig_dep:=dset_brigs2.fieldbyname('id').AsInteger;
F_id_report_out:=dset_out_reports.fieldbyname('id').AsInteger;
 result:='';
 if F_id_brig_dep<=0 then
  result:=M_SetBrig
 else
 begin
   if dset_deps.Active then
     dset_deps.Close;
   if mem_deps.Active then
     mem_deps.Close;
   if mem_depmaters.Active then
     mem_depmaters.Close;

   mem_deps.Open;
   mem_depmaters.Open;
   dset_deps.SelectSQL.Text:=format(sel_deps,[F_id_brig_dep, dateTimeTostr(start_dt), dateTimeTostr(end_dt),
                                             F_id_brig_dep, dateTimeTostr(start_dt), dateTimeTostr(end_dt)]);
    try
     dset_deps.Open;
     try
       dset_deps.First;
       while not dset_deps.Eof do
       begin
          AddDepRow();
         dset_deps.Next;
       end;
     mem_deps.First;
     finally
      dset_deps.Close;
     end;
    except on e:exception do
    begin
     result:=Err_OpenDeps;
    end;
    end;
 end;

end;

procedure Tdm_MatersMasters.CloseDeps;
begin
  if mem_depmaters.Active then
    mem_depmaters.Close;
end;

procedure Tdm_MatersMasters.addDepMater(id_dep:integer);
const seldeps = 'select mr.NUM_YEAR, mr.num_month,m.id mid, rm.id rmid,  m.id_nar, m.kol_mat,m.id_zav, '+
                 ' sm.id,  sm.name_r, sm.kod, sm.price, sm.units, our.num_year out_num_year, our.num_month out_num_month, our.FK_ID_BRIG , '+
                 ' mr.id  FK_ID_REPORT, sb.name_r brigname ' +
                 ' from maters m join REPORT_MATS2 rm on rm.id=m.id_mat  '+
                 ' join MATREPORTS mr on mr.id = rm.FK_ID_REPORT '+
                 'join s_mat2 sm on sm.id = rm.FK_ID_MATER'+
                 ' left join OUT_MATERREPORTS our on our.id = m.FK_ID_OUT_MATERREPORT '+
                 'left join s_brig  sb on mr.FK_ID_BRIG = sb.id '+
' where m.id_nar= %d  order by 1,2, 10';
begin
dep_depmater.SelectSQL.Text:=format( seldeps,[id_dep]);

try
if mem_depmaters.Active then
begin
 dep_depmater.Open;
 dep_depmater.First;
 while not dep_depmater.Eof do
 begin
 if not mem_depmaters.Locate('id',vararrayof([dep_depmater.fieldbyname('mid').AsInteger]),[]) then
   mem_depmaters.Append
 else
  mem_depmaters.Edit;
 mem_depmaters.FieldByName('idn').AsInteger:=id_dep;
 mem_depmaters.FieldByName('kod').AsString:=dep_depmater.fieldbyname('kod').AsString;
 mem_depmaters.FieldByName('id_repmater').AsInteger:=dep_depmater.fieldbyname('rmid').AsInteger;
 mem_depmaters.FieldByName('id').AsInteger:=dep_depmater.fieldbyname('mid').AsInteger;
 mem_depmaters.FieldByName('id_zav').AsInteger:=dep_depmater.fieldbyname('id_zav').AsInteger;

 mem_depmaters.FieldByName('name').AsString:=dep_depmater.fieldbyname('name_r').AsString;
 mem_depmaters.FieldByName('price').AsFloat:=dep_depmater.fieldbyname('price').AsFloat;
 mem_depmaters.FieldByName('all_q').AsString:=format('%*.*f',[8,3,dep_depmater.fieldbyname('kol_mat').AsFloat]);
 mem_depmaters.FieldByName('units').AsString:=dep_depmater.fieldbyname('units').AsString;
  mem_depmaters.FieldByName('FK_ID_REPORT').AsInteger:= dep_depmater.fieldbyname('FK_ID_REPORT').AsInteger;
 mem_depmaters.FieldByName('report_name').AsString:=dep_depmater.fieldbyname('num_year').AsString+
 ' '+monthes_ua[dep_depmater.fieldbyname('num_month').Asinteger];
 if not(dep_depmater.fieldbyname('out_num_year').IsNull or dep_depmater.fieldbyname('out_num_year').IsNull)  then
  mem_depmaters.FieldByName('report_out_name').AsString:=dep_depmater.fieldbyname('out_num_year').AsString+
 ' '+monthes_ua[dep_depmater.fieldbyname('out_num_month').Asinteger];
 if  not dep_depmater.fieldbyname('brigname').IsNull then
  mem_depmaters.FieldByName('report_name').AsString:=mem_depmaters.FieldByName('report_name').AsString+#13+
   dep_depmater.fieldbyname('brigname').AsString;
 if (not dep_depmater.fieldbyname('FK_ID_report').IsNull) and (mem_main.Active) then
  mem_depmaters.FieldByName('is_his').AsBoolean:= dep_depmater.fieldbyname('FK_ID_report').AsInteger = dset_reports.FieldByName('id').AsInteger
 else
  mem_depmaters.FieldByName('is_his').AsBoolean:=false;
 mem_depmaters.Post;
 dep_depmater.Next;
 end;
 dep_depmater.close;

end;



finally
 if dep_depmater.Active then
 dep_depmater.Close;
end;
end;

function Tdm_MatersMasters.startaddMater():boolean;
var id_dep, id_mater:integer;
begin
if (mem_deps.Active) and (mem_main.Active)     and (mem_depmaters.Active) and (dset_out_reports.Active) then
begin
id_dep:=mem_deps.fieldbyname('idn').AsInteger;
id_mater:=mem_main.fieldbyname('id').AsInteger;
result:=mem_depmaters.Locate('idn;id_repmater', vararrayof([id_dep, id_mater]),[]);
end
else
result:=false;
end;

function Tdm_MatersMasters.saveMaterQ(id_repmater, id_dep:integer;new_val:real):string;
var old_val, new_left, old_left:real;
    max_val:real;
    old_id_m, id_n :integer;
    id_zav:integer;
    id_mater:integer;
    id_rep_out:integer;
const add_mattertodep = 'insert into maters( ID_MAT, ID_NAR, ID_ZAV, KOL_MAT, FK_ID_OUT_MATERREPORT) values (%d, %d , %d, %s, %d) ';
const upd_mat = 'update maters set KOL_MAT = %s where id = %d';  {id_repmater}
const del_mat = 'delete from  maters where id = %d';             {id_mater}
const upd_s_mat2 ='update report_mat2 set letf = %s where id=%d' ;   {mem_main id_reportmater}
  function check():string;
  begin
  result:='';
    if not (mem_deps.Locate('idn', vararrayof([id_dep]),[]) and  mem_main.Locate('id', vararrayof([id_repmater]),[])) then
     begin
      result:=err_searchMatDep;

     end;
  end;

  procedure initData();
  begin
     id_n:=mem_deps.fieldbyname('idn').AsInteger;
     id_zav:=mem_deps.fieldbyname('idz').AsInteger;
     old_left:=mem_main.fieldbyname('left').AsFloat;
     id_mater:=0;
     old_val:=0;
     id_rep_out:=dset_out_reports.fieldbyname('id').AsInteger;

     if  startaddMater() then
      begin
       old_val:=mem_depmaters.fieldbyname('all_q').AsFloat;
       id_mater:=mem_depmaters.fieldbyname('id').asinteger;
      end;
      max_val:=old_left+old_val;
  end;

  procedure calcnewleft();
  begin
      new_left:=old_left + old_val-new_val  ;
      if (new_left<0) and (new_left>-1) then
         new_left:=0;
  end;
 function doAddMater():boolean;
 begin
  result:=false;
  if (new_val>0) and (old_val=0)  then
  begin
   ibs_addmater.SQL.Text:=format(add_mattertodep,[id_repmater, id_dep,id_zav, FloatToStr(new_val), id_rep_out]);
  end
  else
  if (new_val=0) and (id_mater>0) and  (old_val>0) then
   ibs_addmater.SQL.Text:=format(del_mat,[id_mater])
   else
  if  new_val<>old_val then    begin
    ibs_addmater.SQL.Text:=format(upd_mat,[floatToStr(new_val),id_mater]);
  end;
  if ibs_addmater.SQL.Text<> '' then
   ibs_addmater.ExecQuery;
  result:=true;
  tran_deps.Commit;
 end;

  procedure  setMemsData();
  begin
  if id_mater=0 then
  begin
   addDepMater(id_n);
  end
  else
  begin
    if new_val>0 then
    begin
    mem_depmaters.Edit;
    mem_depmaters.FieldByName('all_q').AsFloat:=new_val;
    mem_depmaters.Post;
    end
    else
     mem_depmaters.Delete;

  end;
  mem_main.Edit;
  mem_main.FieldByName('left').AsFloat:=new_left;
  mem_main.Post;


  end;



begin

result:=check() ;
if result<>'' then
 exit;
try
initdata();
calcnewleft();
if new_val>max_val then
begin
 result:=err_notallowedAddMoreVal;
 exit;
end;
tran_deps.StartTransaction;
try
  if doAddMater() then
    setMemsData();

 // id_mat:=mem_depmaters.FieldByName('id_mater').AsInteger
except on e:exception do
begin
 result:=err_savemater;
 tran_deps.Rollback;

end;
end
except
 result:=err_savemater;
end;
end;

function Tdm_MatersMasters.getDepMaters():string;
var id_dep:integer;
begin
 result:='';
 if mem_deps.Active then
 begin
   id_dep:= mem_deps.fieldbyname('idn').AsInteger;
   if mem_depmaters.Active then
    begin
      if mem_depmaters.Locate('idn',vararrayof([id_dep]),[]) then
      begin
         while (mem_depmaters.FieldByName('idn').AsInteger=id_dep) and (not mem_depmaters.Eof) do
         begin
          result:=result+#13+
                  format('%s %s - %f',[mem_depmaters.FieldByName('kod').AsString,
                                 mem_depmaters.FieldByName('name').AsString,
                                 mem_depmaters.FieldByName('all_q').AsFloat]);
          mem_depmaters.Next;
         end;
         delete(result,1,1);
      end;

    end;
 end;
end;

procedure Tdm_MatersMasters.mem_depsAfterScroll(DataSet: TDataSet);
var id_dep:integer;

begin
 if mem_depmaters.Active then
 begin
  mem_depmaters.Filtered:=false;
  id_dep:=mem_deps.fieldbyname('idn').AsInteger;
  mem_depmaters.Filter:='idn= '+intToStr(id_dep);
  mem_depmaters.Filtered:=true;
  ScrollDepMater();

 end;

end;

procedure Tdm_MatersMasters.ScrollDepMater();
var id_dep, id_mater:integer;
val:real;
begin
val:=0;
if mem_deps.Active and mem_main.Active and  mem_depmaters.Active then
begin
 id_dep:=mem_deps.fieldbyname('idn').AsInteger;
 id_mater:=mem_main.fieldbyname('id').AsInteger;
 if mem_depmaters.fieldbyname('id_repmater').AsInteger<>id_mater then
 begin
   if  mem_depmaters.Locate('id_repmater;idn', vararrayof([id_mater, id_dep]),[]) then
    val:=mem_depmaters.fieldbyname('all_q').AsFloat;
 end
 else val:=mem_depmaters.fieldbyname('all_q').AsFloat;
 if assigned(F_SetCurrentDepMater) then
     F_SetCurrentDepMater(val);
 if assigned(F_AfterScrolDep) then
  F_AfterScrolDep(mem_deps.fieldbyname('dop_inf').AsString);
end;


end;

procedure Tdm_MatersMasters.DataModuleCreate(Sender: TObject);
begin
F_SetCurrentDepMater:=nil;
f_id_brig_dep:=-1;
end;

procedure Tdm_MatersMasters.mem_mainAfterScroll(DataSet: TDataSet);
begin
  ScrollDepMater();
  SetCuurentMaterDep();
end;

procedure Tdm_MatersMasters.SetCurrentMaterFromDepMater();
var id_mater:integer;
begin
if mem_main.Active then
begin
 if mem_depmaters.fieldbyname('id_repmater').AsInteger<>
   mem_main.fieldbyname('id').AsInteger then
   begin
 id_mater:= mem_depmaters.fieldbyname('id_repmater').AsInteger;
 mem_main.Locate('id',vararrayof([id_mater]),[]);
 end;
end;
end;

procedure Tdm_MatersMasters.setDepToMater(id_mater:integer);
const sql_dpemater ='select z.id,  z.nomer,  '+
' extract(year FROM z.dt_in) as zyear,   n.id idn, n.nomer nnomer, n.dt_in, n.dt_out, '+
' (select adres from get_adres(z.id_ul1, z.id_ul2,z.kod_ul,z.dop_adr, z.id_dopadres)) address, z.id_attach '+
' from maters m '+
' join narad n on m.id_nar = n.id '+
' join   zavjav z on z.id = n.id_zav '+
'  where m.id_mat=:id_mater '+

' order by 4' ;
begin
if  mem_materdep.Active then
begin
  dset_materdep.SelectSQL.Text:=sql_dpemater;
  dset_materdep.ParamByName('id_mater').AsInteger:= id_mater;
  //dset_materdep.ParamByName('id_brig').AsInteger:=F_id_brig;
  try
     dset_materdep.Open;

     try
          dset_materdep.First;
          while not  dset_materdep.Eof do
          begin
            mem_materdep.Append;
            mem_materdep.FieldByName('id_mater').AsInteger:=id_mater;
            mem_materdep.FieldByName('idn').AsInteger:=dset_materdep.fieldbyname('idn').AsInteger;
            mem_materdep.FieldByName('nomer').AsString:=dset_materdep.fieldbyname('nomer').AsString;
            mem_materdep.FieldByName('nomer').AsString:=mem_materdep.FieldByName('nomer').AsString+
             dset_materdep.fieldbyname('zyear').AsString;
            mem_materdep.FieldByName('nnomer').AsString:=dset_materdep.fieldbyname('nnomer').AsString;
            mem_materdep.FieldByName('address').AsString:=dset_materdep.fieldbyname('address').AsString;
            mem_materdep.FieldByName('startdt').AsDateTime:=dset_materdep.fieldbyname('dt_in').AsDateTime;
            mem_materdep.FieldByName('enddate').AsDateTime:=dset_materdep.fieldbyname('dt_out').AsDateTime;
            if not  dset_materdep.fieldbyname('dt_in').IsNull then
             mem_materdep.FieldByName('showdate').AsString:=dset_materdep.fieldbyname('dt_in').AsString;
            if  not  dset_materdep.fieldbyname('dt_out').IsNull then
             mem_materdep.FieldByName('showdate').AsString:=mem_materdep.FieldByName('showdate').AsString+ '-- '+
               dset_materdep.fieldbyname('dt_out').AsString;
            mem_materdep.Post;
            dset_materdep.Next;
          end;
     finally
     dset_materdep.Close;
     end;

  except

  end;
end;


end;

procedure Tdm_MatersMasters.SetCuurentMaterDep();
var id_mater:integer;
begin
if mem_materdep.Active then
begin
 id_mater:=mem_main.fieldbyname('id').AsInteger;
 if id_mater>0 then
 begin
 mem_materdep.Filtered:=false;
 mem_materdep.Filter:='id_mater = '+ mem_main.fieldbyname('id').AsString;
 mem_materdep.Filtered:=true;
 end;
end;
end;



procedure Tdm_MatersMasters.setBrigOutId(id:integer);
begin


  if dset_brigs2.Active then
  begin
    if dset_brigs2.fieldbyname('id').AsInteger<>id then
     dset_brigs2.Locate('id', vararrayof([id]),[]);
     if  dset_out_reports.Active then
         dset_out_reports.Close;
      dset_out_reports.ParamByName('id_brig').AsInteger:=id;
      dset_out_reports.Open;
      if f_id_report_out>0 then
      if not  dset_out_reports.Locate('id', vararrayof([f_id_report_out]),[]) then
       dset_out_reports.First;


  end;
end;

procedure Tdm_MatersMasters.dset_brigs2AfterScroll(DataSet: TDataSet);
begin
 f_id_brig_dep:=dset_brigs2.fieldbyname('id').AsInteger;
 setBrigOutId(dset_brigs2.fieldbyname('id').AsInteger);
end;

procedure Tdm_MatersMasters.IsCanOutReportInBase(num_month, num_year:integer; var result:boolean);
begin
  result:=false;
  if  dset_out_reports.Active then
   result:=not  dset_out_reports.Locate('num_month;num_year', vararrayof([num_month, num_year]),[]);
end;

function Tdm_MatersMasters.AddOutReport(num_month, num_year:integer):string;
var f_out_brig, id:integer;
begin
if not  tran_out_reports.Active then
 tran_out_reports.StartTransaction;
  f_out_brig:=dset_brigs2.fieldbyname('id').AsInteger;
   try
    dset_out_reports.Append;
    dset_out_reports.FieldByName('fk_id_brig').AsInteger:=f_out_brig;
    dset_out_reports.FieldByName('num_year').AsInteger:=num_year;
    dset_out_reports.FieldByName('num_month').AsInteger:=num_month;

    dset_out_reports.Post;
    id:=dset_out_reports.fieldbyname('id').AsInteger;
    tran_out_reports.Commit;
    tran_out_reports.StartTransaction;
    dset_out_reports.ParamByName('id_brig').AsInteger:=f_out_brig;
    dset_out_reports.Open;
    dset_out_reports.Locate('id', vararrayof([id]),[]);
    result:='';
  except on e:exception do
   result:=e.Message;
  end;
end;

procedure Tdm_MatersMasters.dset_out_reportsCalcFields(DataSet: TDataSet);
begin
 if (dset_out_reports.FieldByName('num_month').asinteger>0) and (dset_out_reports.FieldByName('num_year').AsInteger>0) then

  dset_out_reports.FieldByName('show_title').AsString:=dset_out_reports.FieldByName('num_year').AsString+' '+
  monthes_ua[dset_out_reports.FieldByName('num_month').asinteger]
  else
   dset_out_reports.FieldByName('show_title').AsString:='';
end;

procedure Tdm_MatersMasters.RecalcMemDepMater();
var id_rep:integer;
begin

 id_rep:=dset_reports.FieldByName('id').AsInteger;


 if mem_depmaters.Active then
 begin
  mem_depmaters.Filtered:=false;
  mem_depmaters.First;
  while not  mem_depmaters.Eof do
  begin
    mem_depmaters.Edit;
    if mem_main.Active then
     mem_depmaters.FieldByName('is_his').AsBoolean:= mem_depmaters.fieldbyname('FK_ID_report').AsInteger = id_rep
    else
     mem_depmaters.FieldByName('is_his').AsBoolean:=false;
    mem_depmaters.Post;
    mem_depmaters.Next;
  end;
   mem_depmaters.Filtered:=true;
 end;
end;

{Добавление метериала в матеоиальній отчет
Уникальность модно добавить
 код
 имя материала
 со склада
 номер колонки }
function Tdm_MatersMasters.addmatertoStorage(kod, name, units:string; price, all_q:real; fk_column:integer):string;
begin

 if mem_main.Active then
 begin
   if mem_main.Locate('kod;is_storage;fk_column', vararrayof([kod,1,fk_column]),[]) then
    result:=errMaterKodAllreadyInReport
   else
     begin
       mem_main.Last;
       mem_main.Append;
       mem_main.FieldByName('kod').AsString:=kod;
       mem_main.FieldByName('name').AsString:=name;
       mem_main.FieldByName('Units').AsString:=units;
       mem_main.FieldByName('price').AsFloat:=price;
       mem_main.FieldByName('all_q').AsFloat:=all_q;
       mem_main.FieldByName('is_storage').Asboolean:=true;
       mem_main.FieldByName('left').AsFloat:=all_q;
       mem_main.FieldByName('fk_column').AsInteger:=fk_column;
       mem_main.Post;
       if  saveRow(id_report) then
        begin
         tran_main.Commit;
         ReopenTran();
         result:=ReopenSavedReport();
         dset_s_mat2.Close;
         dset_s_mat2.Open;
         if result='' then
          mem_main.Locate('kod;is_storage', vararrayof([kod,true]),[])
        end
        else
        begin
         tran_main.Rollback;
         result:=Err_Saving;
        end
     end ;
 end
 else
  result:=errReportNotopen;
end;




end.


