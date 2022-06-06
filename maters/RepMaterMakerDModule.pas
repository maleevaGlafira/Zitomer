unit RepMaterMakerDModule;
{из отчета длругого мастера вписываем ему в колонку}
interface

uses
  SysUtils, Classes, DMmain, IBDatabase, DB, IBCustomDataSet, kbmMemTable,  Grids, Aligrid,
  Math;

type
  Tdm_RepMaterMaker = class(TDataModule)
    tran_s: TIBTransaction;
    tran_main: TIBTransaction;
    dset_brigs: TIBDataSet;
    dset_brigsID: TIntegerField;
    dset_brigsCONCATENATION: TIBStringField;
    dset_brigsNAME_R: TIBStringField;
    dset_reports_out: TIBDataSet;
    dset_reports_outID: TIntegerField;
    dset_reports_outFK_ID_BRIG: TIntegerField;
    dset_reports_outNUM_YEAR: TSmallintField;
    dset_reports_outNUM_MONTH: TSmallintField;
    dset_reports_outshow_title: TStringField;
    dset_deps: TIBDataSet;
    mem_deps: TkbmMemTable;
    mem_depsidn: TIntegerField;
    mem_depsidz: TIntegerField;
    mem_depsdt: TStringField;
    mem_depsaddress: TStringField;
    mem_depsnomer: TStringField;
    mem_depsdop_inf: TStringField;
    mem_depsnnomwe: TIntegerField;
    mem_depsid_attach: TIntegerField;
    mem_depsn_col: TStringField;
    mem_depsis_mater: TBooleanField;
    dset_reportmats: TIBDataSet;
    dset_tmp: TIBDataSet;
    mem_maters: TkbmMemTable;
    mem_matersREPORT_MATS2id: TIntegerField;
    mem_materskod: TStringField;
    mem_matersname: TStringField;
    mem_matersid_MATREPORTS: TIntegerField;
    mem_matersid_brig: TIntegerField;
    mem_matersbrig_name: TStringField;
    mem_matersall_q: TFloatField;
    mem_matersis_storage: TBooleanField;
    mem_matersid_s_mat2: TIntegerField;
    mem_matersunits: TStringField;
    mem_matersprice: TFloatField;
    mem_report: TkbmMemTable;
    mem_reportreport_mats2id: TIntegerField;
    mem_reportcol_num: TIntegerField;
    mem_reportval: TStringField;
    mem_reportcol_brigid: TIntegerField;
    mem_reportrow_num: TIntegerField;
    mem_reportcol_span: TIntegerField;
    mem_reportrow_span: TIntegerField;
    mem_reportqval: TFloatField;
    dset_reports_outmonth: TStringField;
    mem_reportcol_matercol: TIntegerField;
    mem_matersid_matercol: TIntegerField;
    mem_matersmatercol_name: TStringField;
    procedure dset_reports_outCalcFields(DataSet: TDataSet);
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    F_id_brig:integer;
    F_id_out_report:integer;

    F_id_materreport:integer; {if materreport  на 1 мес€ц раньше входной отчет остатков}
    title_col, max_mater_col, max_dep_col:integer;
    procedure StartGetData();

   function OpenReport():boolean;
   function setIdMaterReport():boolean;{поиск отчета человека мес€ц -1}
   function getOurMaterName():boolean;{список материалов из отчета остатков}
   function getOtherBrigsMaters():boolean;{список материалов из материалов использованн≥х бригадиром  ищ остатков других бридиров}
   function getMaterName(sql:string):boolean;
   function PrepareGreed(Grid:TStringAlignGrid):string;
   function CalcTotal():string;
   procedure addCellConstVal(col:integer;val:string; row:integer=0; col_span:integer=1;row_span:integer=1);
   procedure addCellDataVal(col:integer;val:string; row:integer;report_mats2id:integer;qval:real=0);
  public
    { Public declarations }
    function OpenDsets:string;
     procedure sertBrigId(id:integer);
     function searchDeps():string;
     procedure closemems();
     procedure Close();
     procedure setNumbers();
     function doReport(Grid:TStringAlignGrid):string;
     function MakeInputMaterPart():string;//формируем вход€щие материал≥ столбик сназваний материалов и что откуда пришло с именами бриглиров
     function MakeUseMaterPart():string; //формируем  использование материалов по адресам
  end;

var
  dm_RepMaterMaker: Tdm_RepMaterMaker;

implementation

{$R *.dfm}
  uses ExelError, Variants, ConstRepMater;
procedure Tdm_RepMaterMaker.StartGetData();
begin
   tran_s.StartTransaction;
   tran_main.StartTransaction;
end;

function Tdm_RepMaterMaker.OpenDsets:string;
begin
 try
  dset_brigs.Open;
  result:='';
 except
  result:=Err_openDsets;
 end;
end;

procedure Tdm_RepMaterMaker.closemems();
begin
 if mem_deps.active then
    mem_deps.Close;
  if mem_maters.Active then
   mem_maters.Close;
  if mem_report.Active then
   mem_report.Close;
end;

procedure Tdm_RepMaterMaker.Close;
begin

  if dset_reports_out.Active then
    dset_reports_out.Close;
  if dset_brigs.Active then
    dset_brigs.Close;
  if tran_main.Active then
    tran_main.Commit;
  if tran_s.Active then
    tran_s.Commit;
end;

procedure Tdm_RepMaterMaker.sertBrigId(id:integer);
begin
if dset_brigs.Active then
if dset_brigs.Locate('id', vararrayof([id]),[]) then
begin
  F_id_brig:=id;



 if dset_reports_out.Active then
   dset_reports_out.Close;
 dset_reports_out.ParamByName('id_brig').AsInteger:=F_id_brig;
 dset_reports_out.Open;
 dset_reports_out.First;
end;
end;


procedure Tdm_RepMaterMaker.dset_reports_outCalcFields(DataSet: TDataSet);
begin
if DataSet.fieldbyname('num_month').Asinteger>0 then 
begin
  DataSet.FieldByName('show_title').AsString:=DataSet.fieldbyname('num_year').AsString+
 ' '+monthes_ua[DataSet.fieldbyname('num_month').Asinteger];
  DataSet.fieldbyname('month').AsString:=monthes_ua[DataSet.fieldbyname('num_month').Asinteger];
 end
 else
  DataSet.FieldByName('show_title').AsString:=DataSet.fieldbyname('num_year').AsString;

end;

function Tdm_RepMaterMaker.searchDeps():string;
const sel_deps = 'select distinct z.id zid, z.nomer,extract(year FROM z.dt_in) as zyear,z.dt_in,z.dt_out, (select adres from get_adres(z.id_ul1, z.id_ul2,z.kod_ul,z.dop_adr, z.id_dopadres)) address , z.id_attach,'+
 'm.id id_mater '+
 ' from narad n join zavjav z on z.id = n.id_zav '+
 ' left  join maters m on m.id_nar=n.id'+
' where n.id_brig = %d and m.fk_id_out_materreport=%d '+
' union '+
' select distinct  z.id, z.nomer,extract(year FROM z.dt_in) as zyear, z.dt_in,z.dt_out   , (select adres from get_adres(z.id_ul1, z.id_ul2,z.kod_ul,z.dop_adr, z.id_dopadres)) address , z.id_attach,'+
' m.id id_mater '+
' from nnarad n join nzavjav z on z.id = n.id_zav '+
 ' left  join maters m on m.id_nar=n.id'+
' where n.id_brig = %d and m.fk_id_out_materreport=%d '+
' order by 3,2,1';
var old_id:integer;

procedure AddDepRow();
begin
 mem_deps.Append;
 old_id:=dset_deps.fieldbyname('zid').AsInteger;

 mem_deps.FieldByName('idz').AsInteger:=dset_deps.fieldbyname('zid').AsInteger;
 mem_deps.FieldByName('nomer').asString:=dset_deps.fieldbyname('nomer').AsString
 +'  '+dset_deps.fieldbyname('zyear').AsString;
 mem_deps.FieldByName('dt').asString:=dset_deps.fieldbyname('dt_in').AsString;
 if not dset_deps.fieldbyname('dt_out').IsNull then
  mem_deps.FieldByName('dt').asString:=mem_deps.FieldByName('dt').asString+'--'+dset_deps.fieldbyname('dt_out').AsString;
 mem_deps.FieldByName('address').AsString:=dset_deps.fieldbyname('address').AsString;

 
 mem_deps.FieldByName('id_attach').AsInteger:=dset_deps.fieldbyname('id_attach').AsInteger;
 mem_deps.FieldByName('is_mater').AsBoolean:=not  dset_deps.fieldbyname('id_mater').IsNull;
 mem_deps.Post;

end;
begin
 result:='';
 if F_id_brig<=0 then
  result:=M_SetBrig
 else
 begin
   F_id_out_report:= dset_reports_out.fieldbyname('id').AsInteger;

   if F_id_out_report<0 then
   begin
     result:=mes_SelReport;
   end
   else
   begin
   if dset_deps.Active then
     dset_deps.Close;
   if mem_deps.Active then
     mem_deps.Close;


   mem_deps.Open;

   dset_deps.SelectSQL.Text:=format(sel_deps,[F_id_brig, F_id_out_report,
                                              F_id_brig, F_id_out_report]);
    try
     dset_deps.Open;
     try
       dset_deps.First;
       old_id:=-1;
       while not dset_deps.Eof do
       begin
         if dset_deps.fieldbyname('zid').AsInteger<>old_id then
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

end;


procedure Tdm_RepMaterMaker.DataModuleDestroy(Sender: TObject);
begin
closemems;
close;
end;

procedure Tdm_RepMaterMaker.DataModuleCreate(Sender: TObject);
begin
StartGetData();
end;

procedure Tdm_RepMaterMaker.setNumbers();
var i:integer;
s:string;
bm:Pointer;
begin
  bm:=mem_deps.GetBookmark;
  i:=1;
  if mem_deps.Active then
  begin
  mem_deps.First;

  while not mem_deps.Eof do
  begin
   if mem_deps.FieldByName('is_mater').AsBoolean  then
   begin
   s:=IntTOStr(i);
   if (mem_deps.FieldByName('n_col').AsString='') or (mem_deps.FieldByName('n_col').AsString=s) then
   begin
     mem_deps.Edit;
     if length(s)=1 then s:=' '+s;
     mem_deps.FieldByName('n_col').AsString:=s;

     i:=i+1;
     mem_deps.Post;
   end;
   end;
   mem_deps.Next;
  end;
  end;

  mem_deps.GotoBookmark(bm);
  mem_deps.SortOn('n_col',[]);
end;
{====Do report====}
function Tdm_RepMaterMaker.PrepareGreed(Grid:TStringAlignGrid):string;
var row, col, i, len:integer;
val:string;
function valtos(v:real):string;
var calc, cv :real;
f:integer;
begin
cv:=(v+0.00001)*100;
f:=floor(cv);
calc:=v*100-f;
 if v=floor(v) then
  result:= format('%.0f',[v])
 else
 if (calc>0.1)  then
  result:=format('%.3f',[v])
 else
  result:=format('%.2f',[v]);



end;

procedure setcolwidth();
var i:integer;
begin
for i:=3 to grid.ColCount-1 do
 grid.ColWidths[i]:=45;
end;
begin
  result:='';
 if mem_report.Active then
 begin
  try
   mem_report.SortOn('row_num;col_num',[]);
   mem_report.last;

   grid.FixedRows:=3;
   grid.ColWidths[0]:=140;
   grid.ColWidths[1]:=240;
   grid.ColWidths[2]:=50;
   grid.RowCount:= mem_report.fieldbyname('row_num').AsInteger+1;
   grid.ColCount:=10;


   mem_report.first;
   while not mem_report.Eof do
   begin
    row:=mem_report.fieldbyname('row_num').AsInteger;
    col:=mem_report.fieldbyname('col_num').AsInteger;
    if mem_report.fieldbyname('qval').AsFloat>0 then
     val:=valtos(mem_report.fieldbyname('qval').AsFloat)
    else
      val:=TRIM(mem_report.fieldbyname('val').AsString);
    len:=10*(length(val)+2);
    if grid.ColCount<col+1 then
      grid.ColCount:=col+1;
    if grid.ColWidths[col]<len then
      grid.ColWidths[col]:=len;
    grid.Cells[col, row]:=val;
   
    mem_report.Next;
   end;
    setcolwidth();
  except on e:exception do
  result:='error make greed'
  end;
  end;
  {try
    mem_report.Last;
    grid.RowCount:= mem_report.RecordCount+2;
    grid.ColCount:= mem_report.Fields.Count+2;
    mem_report.First;
    row:=1;


    grid.ColWidths[0]:=20;
    for i:=1 to  mem_report.Fields.Count do
    begin
      grid.Cells[i,0]:=mem_report.Fields[i-1].FieldName;
      if mem_report.Fields[i-1].Size=0 then
        grid.ColWidths[i]:=12
      else
      if mem_report.Fields[i-1].Size<40 then
       grid.ColWidths[i]:=mem_report.Fields[i-1].Size*9
      else
       grid.ColWidths[i]:=40*9
    end;

    while not mem_report.Eof do
    begin
      grid.Cells[0,row]:=intTostr(row);
      for i:=1 to  mem_report.Fields.Count do
       begin
         grid.Cells[i,row]:=trim(mem_report.Fields[i-1].AsString);
         if  grid.ColWidths[i]< grid.Canvas.TextWidth(grid.Cells[i,row]) then
             grid.ColWidths[i]:=grid.Canvas.TextWidth(grid.Cells[i,row])+10;
       end;
      row:=row+1;
      mem_report.Next;
    end
   except on e:exception do
     result:='error make greed'
   end
 end; }

end;


function Tdm_RepMaterMaker.doReport(Grid:TStringAlignGrid):string;
var month, year:integer;
begin
try
 month:=dset_reports_out.fieldbyname('num_month').AsInteger;
  year:=dset_reports_out.fieldbyname('num_year').AsInteger;
  if mem_maters.Active then
   mem_maters.Close;
 if not setIdMaterReport() then
    result:=Format(errNotInputMaterreport+'%d %s  %s', [year ,monthes_ua[month],dset_brigs.FieldByName('NAME_R').AsString ])
 else
  if not getOurMaterName() then
   result:=errgetReportMaterData
  else
   if not getOtherBrigsMaters() then
     result:=errgetReportMaterData
   else
    if MakeInputMaterPart()<>'' then
     result:= errsgetReportMaterExel
    else
     if MakeUseMaterPart()<>'' then
      result:= errsgetReportMaterExel
     else
     begin
       CalcTotal();
       result:=PrepareGreed(Grid);
     end;

except
 result:=err_FoundData;
end;

end;

{==get materreports id month year -1}
function Tdm_RepMaterMaker.setIdMaterReport():boolean;
var month, year:integer;
begin
 result:=false;
 F_id_materreport:=-1;
 try
  month:=dset_reports_out.fieldbyname('num_month').AsInteger;
  year:=dset_reports_out.fieldbyname('num_year').AsInteger;
  if month=1 then
  begin
     month:=12;
     year:=year-1;
  end
  else
    month:=month-1;

  dset_tmp.SelectSQL.Text:=format('select id from MATREPORTS where FK_ID_BRIG = %d and num_year=%d and num_month=%d',
   [F_id_brig,year, month] );
  dset_tmp.Open;
  try
    dset_tmp.First;
    if  dset_tmp.FieldByName('id').AsInteger>0 then
    begin
        F_id_materreport:=dset_tmp.FieldByName('id').AsInteger;
        result:=true;
    end;
  finally
   dset_tmp.Close;
  end;
  except on e:exception do
 begin
  result:=false;
 end;
 end;
end;


function Tdm_RepMaterMaker.OpenReport():boolean;

begin
result:=false;
try
except on e:exception  do
 result:=false;
end

end;

function Tdm_RepMaterMaker.getOurMaterName():boolean;
const sql = 'select rm.id  report_mats2id , sm.id smid,sm.kod, sm.name_r, sm.units, sm.price, rm.all_q, rm.is_storage, mr.id mrid ,'+
            ' sb.id id_brig, sb.name_r brig_name, rm.FK_COLUMN, scol.name_r matercol_name from '+
            'MATREPORTS mr  join report_mats2 rm on rm.fk_id_report=mr.id '+
            'join s_mat2 sm on sm.id = rm.fk_id_mater '+
            'join s_brig sb on sb.id= mr.fk_id_brig '+
            ' left join S_MAT2_COUMN scol on scol.id = rm.FK_COLUMN '+
            'where mr.id=%d';

begin
   mem_maters.Open;
   result:=getMaterName(format(sql,[F_id_materreport]));
end;

function Tdm_RepMaterMaker.getOtherBrigsMaters():boolean;
const sql='select distinct rm.id  report_mats2id , sm.id smid,sm.kod, sm.name_r, '+
          'sm.units, sm.price,  sum (m.kol_mat)  all_q, rm.is_storage, mr.id mrid , sb.id id_brig, sb.name_r brig_name, '+
          ' 0 FK_COLUMN, '''' matercol_name '+
          'from maters m  join report_mats2 rm on m.id_mat=rm.id '+
          'join MATREPORTS mr on rm.fk_id_report=mr.id '+
          'join s_mat2 sm on sm.id = rm.fk_id_mater '+
          'join s_brig sb on sb.id= mr.fk_id_brig '+
//          ' join S_MAT2_COUMN scol on scol.id = rm.FK_COLUMN '+
          'where m.fk_id_out_materreport=%d   and rm.fk_id_report<>%d '+
          'group by  1,2,3,4,5,6,8,9,10,11,12,13 order by sm.id ';
begin
 result:=getMaterName(format(sql,[F_id_out_report,F_id_materreport]));
end;

function Tdm_RepMaterMaker.getMaterName(sql:string):boolean;
  procedure  AddRow();
  begin
   mem_maters.Append;
   mem_maters.FieldByName('report_mats2id').AsInteger:=dset_tmp.fieldbyname('report_mats2id').AsInteger;
   mem_maters.FieldByName('id_s_mat2').AsInteger:=dset_tmp.fieldbyname('smid').AsInteger;
   mem_maters.FieldByName('kod').AsString:=dset_tmp.fieldbyname('kod').AsString;
   mem_maters.FieldByName('name').AsString:=dset_tmp.fieldbyname('name_r').AsString;
   mem_maters.FieldByName('id_MATREPORTS').AsInteger:=dset_tmp.fieldbyname('mrid').AsInteger;
   mem_maters.FieldByName('id_brig').AsInteger:=dset_tmp.fieldbyname('id_brig').AsInteger;
   mem_maters.FieldByName('brig_name').AsString:=dset_tmp.fieldbyname('brig_name').AsString;
   mem_maters.FieldByName('all_q').AsFloat:=dset_tmp.fieldbyname('all_q').AsFloat;
   mem_maters.FieldByName('is_storage').AsBoolean:=(dset_tmp.fieldbyname('is_storage').AsInteger=1);
   mem_maters.FieldByName('id_s_mat2').AsInteger:=dset_tmp.fieldbyname('smid').AsInteger;
   mem_maters.FieldByName('units').AsString:=dset_tmp.fieldbyname('units').AsString;
   mem_maters.FieldByName('price').AsFloat:=dset_tmp.fieldbyname('price').AsFloat;
  // if dset_tmp.FieldList.Find('id_matercol') <> nil then
  // begin
     mem_maters.FieldByName('id_matercol').AsInteger:=dset_tmp.fieldbyname('FK_COLUMN').AsInteger;
     mem_maters.FieldByName('matercol_name').AsString:=trim(dset_tmp.fieldbyname('matercol_name').AsString);
 //  end;

   mem_maters.Post;
  end;
begin
   dset_tmp.SelectSQL.Text:=sql;
   try
    dset_tmp.Open;

    try
      dset_tmp.First;
      if dset_tmp.FieldByName('report_mats2id').IsNull then
      begin
       result:=false;
      end
      else
      begin


        while not dset_tmp.Eof do
        begin
         AddRow();
         dset_tmp.Next;
        end;
        result:=true;
      end
     finally
      dset_tmp.Close;
     end
   except
    result:=false;
   end;
end;



procedure Tdm_RepMaterMaker.addCellConstVal(col:integer;val:string; row:integer=0; col_span:integer=1;row_span:integer=1);
begin
  mem_report.Append;
  mem_report.FieldByName('report_mats2id').AsInteger:=0;
  mem_report.FieldByName('row_num').AsInteger:=row;
  mem_report.FieldByName('col_num').AsInteger:=col;
  mem_report.FieldByName('val').AsString:=val;//StartTableWord;
  mem_report.FieldByName('col_span').AsInteger:=col_span;
  mem_report.FieldByName('row_span').AsInteger:=row_span;
  mem_report.post;
end;

procedure Tdm_RepMaterMaker.addCellDataVal(col:integer;val:string; row:integer;report_mats2id:integer;qval:real=0);
begin
  mem_report.Append;
  mem_report.FieldByName('report_mats2id').AsInteger:=report_mats2id;
  mem_report.FieldByName('row_num').AsInteger:=row;
  mem_report.FieldByName('col_num').AsInteger:=col;
  mem_report.FieldByName('val').AsString:=val;//StartTableWord;
  mem_report.FieldByName('qval').asfloat:=qval;
  mem_report.post;

end;

function Tdm_RepMaterMaker.MakeInputMaterPart():string;

var row, report_mats2id,  brig_col:integer;
val, v_sum:string;
sum, kol:real;

procedure addTytles();
var yearmonth:string;
begin
 yearmonth:=setFirstdtMonth(dset_reports_out.fieldbyname('num_month').AsInteger, dset_reports_out.fieldbyname('num_year').AsInteger)+'р.';
 addCellConstVal(0,StartTableWord,0,1,3);
 addCellConstVal(1,NameMsterLong,0,1,3);
 addCellConstVal(2,UnitWord,0,1,3);
 addCellConstVal(3,LastWork,0,2,1);        addCellConstVal(3,yearmonth,1,2,1);
addCellConstVal(5,InputWord,0,5,1);        addCellConstVal(5,FromStorage,1);
 addCellConstVal(6,IDROS,1);
 addCellConstVal(3,KIL,2);
 addCellConstVal(4,SUMM,2);
 addCellConstVal(5,KIL,2);
 addCellConstVal(6,KIL,2);



 end;

 procedure addnewBrig(id_brig:integer; brig_name:string;kol:real=0);
 begin
    mem_report.Append;
    mem_report.FieldByName('col_brigid').AsInteger:=id_brig;
    mem_report.FieldByName('val').AsString:=brig_name;
    mem_report.FieldByName('row_num').AsInteger:=1;
    mem_report.FieldByName('col_num').AsInteger:=title_col;

    title_col:=title_col+1;

    mem_report.Post;
   addCellConstVal( title_col-1,KIL,2);
 end ;

 procedure addnewMaterCol(id_colmat:integer; name:string; kol:real=0);
 begin
  mem_report.Append;
    mem_report.FieldByName('col_matercol').AsInteger:=id_colmat;
    mem_report.FieldByName('val').AsString:=name;
    mem_report.FieldByName('row_num').AsInteger:=1;
    mem_report.FieldByName('col_num').AsInteger:=title_col;

    title_col:=title_col+1;

    mem_report.Post;
   addCellConstVal( title_col-1,KIL,2);
 end;


 function seachbrig(id_brig:integer):integer;
 begin
  if mem_report.Locate('col_brigid;row_num', vararrayof([id_brig,1]),[]) then
   result:=mem_report.fieldbyname('col_num').AsInteger
  else
  result:=0;
 end;

  function seachmatercol(id_matercol:integer):integer;
 begin
   if id_matercol<=0 then
    result:=5
   else
    if mem_report.Locate('col_matercol;row_num', vararrayof([id_matercol,1]),[]) then
     result:=mem_report.fieldbyname('col_num').AsInteger
    else
     result:=0;
 end;



procedure setMaterName();
begin
  report_mats2id:=mem_maters.FieldByName('report_mats2id').AsInteger;
   addCellDataVal(0,mem_maters.fieldbyname('kod').AsString, row,report_mats2id);
   addCellDataVal(1,mem_maters.fieldbyname('name').AsString, row,report_mats2id);
   addCellDataVal(2,mem_maters.fieldbyname('units').AsString, row,report_mats2id);
end;
procedure CalcSumkol();
begin
 kol:=mem_maters.fieldbyname('all_q').asfloat;
   if kol>0 then
    begin
     val:=format('%f',[kol]);
     sum:=mem_maters.fieldbyname('all_q').asfloat*mem_maters.fieldbyname('price').asfloat;
     v_sum:=format('%.2f',[sum]);
    end;
end;

procedure setOurBrigVal();
var col_mater:integer;
begin
 if not mem_maters.fieldbyname('is_storage').AsBoolean then
     begin
       addCellDataVal(3,'', row,report_mats2id,kol);
       addCellDataVal(4,'', row,report_mats2id,sum);
     end
     else
     begin
      if mem_maters.FieldByName('id_matercol').AsInteger<=0 then
        addCellDataVal(5,'', row,report_mats2id, kol)
      else
      begin
       col_mater:=  seachmatercol(mem_maters.FieldByName('id_matercol').AsInteger);
       if col_mater=0 then
       begin
          addnewMaterCol(mem_maters.FieldByName('id_matercol').AsInteger,mem_maters.FieldByName('matercol_name').AsString);
          col_mater:=title_col-1;
       end;
       addCellDataVal(col_mater,'', row,report_mats2id, kol);

      end
     end;
end;

procedure setAnotherBrigVal();
begin
   brig_col:= seachbrig(mem_maters.fieldbyname('id_brig').AsInteger);
     if  brig_col=0 then
      begin
      addnewBrig(mem_maters.fieldbyname('id_brig').AsInteger,mem_maters.fieldbyname('brig_name').AsString );
       brig_col:=title_col-1;
      end ;
     addCellDataVal(brig_col,'',row,report_mats2id,kol);
end;

begin
 result:='';
 try
   if mem_report.Active then
    mem_report.Close;
   mem_report.Open;
   addTytles();
   mem_maters.SortOn('name',[]);
   mem_maters.First;
  row:=4;
  title_col:=7;
   while not mem_maters.Eof do
   begin
     setMaterName();
     CalcSumkol();
     if F_id_brig=mem_maters.fieldbyname('id_brig').AsInteger then
     begin
       setOurBrigVal();
     end
     else
     begin
          //  setAnotherBrigVal();
     end;
     row:=row+1;
     mem_maters.next;
   end;
   mem_maters.First;
   row:=4;
   while not mem_maters.Eof do
   begin
      CalcSumkol();
      if F_id_brig<>mem_maters.fieldbyname('id_brig').AsInteger then
       setAnotherBrigVal();
       row:=row+1;
     mem_maters.next;
   end;
   max_mater_col:=title_col;
except
    on e:exception do
 result:=e.Message;
end;


end;

function Tdm_RepMaterMaker.MakeUseMaterPart():string;
var id_zav:integer;

  id_mater:integer;
  kol:real;

procedure addTitles ;
var span_col:integer;
begin

 mem_deps.Last;
 span_col:=mem_deps.RecordCount+2;
 self.addCellConstVal(title_col,GetToUse,0,span_col);

end;
procedure addTytledep(id_zav:integer; num_col:string);
begin
  self.addCellConstVal(title_col,num_col,1);

end;



function setVaLMaterToReport(id_mater:integer;val:real):boolean;
var v:Variant;
  row_num:integer;
begin
 result:=false;
 v:=mem_report.Lookup('report_mats2id',vararrayof([id_mater]),'row_num');
 if  v<>null then
 begin
   row_num:=v;
   if row_num>0 then
   begin
    self.addCellDataVal(title_col,'',row_num,id_mater,val);
     result:=true;
   end
 end;
end;

function getUSedDepMater(id_zav:integer  ):boolean;
const sel_sql = 'select sum(m.kol_mat) kol_mat, m.id_mat from maters m join narad n on m.id_nar=n.id where m.id_zav=%d and n.id_brig=%d  and fk_id_out_materreport=%d'+
' group by 2 '+
' union '+
 'select sum(m.kol_mat), m.id_mat from maters m join nnarad n on m.id_nar=n.id  '+
 ' where m.id_zav=%d and n.id_brig=%d  and fk_id_out_materreport=%d  group by 2';
var id_mater:integer; kol:real;
begin
try
result:=false;
 dset_tmp.SelectSQL.Text:=format(sel_sql,[id_zav,F_id_brig,F_id_out_report,id_zav,F_id_brig,F_id_out_report]);
 dset_tmp.Open;
 try
   dset_tmp.First;
   while not  dset_tmp.Eof do
   begin
    kol:=dset_tmp.fieldbyname('kol_mat').AsFloat;
    if kol>0 then
    begin
      id_mater:=dset_tmp.fieldbyname('id_mat').AsInteger;

      if not  setVaLMaterToReport(id_mater, kol) then
       exit;
     end;
    dset_tmp.Next;
   end;
 finally
 dset_tmp.Close;
 end;
 result:=true;
 except on e:exception do
  result:=false;
 end;
end;

begin
 result:='';
 title_col:=max_mater_col+1;
 addTitles();
 if not mem_deps.Active then
 begin
   result:='Closed_Deps';
   exit;
 end;
 mem_deps.SortOn('n_col',[]);
 mem_deps.First;
 while not  mem_deps.Eof do
 begin
  id_zav:=mem_deps.fieldbyname('idz').AsInteger;
  addTytledep(id_zav,mem_deps.fieldbyname('n_col').AsString);
    if not   getUSedDepMater(id_zav) then
    begin
     result:='Error set depmaer used';
     exit;
     end;
   title_col:= title_col+1;
   mem_deps.Next;
 end;
 max_dep_col:=title_col;
end;



function Tdm_RepMaterMaker.CalcTotal():string;
procedure correctColSpapnGetMater();
begin
 if mem_report.Locate('row_num;col_num', vararrayof([0,5]),[]) then
  begin
   mem_report.Edit;
   mem_report.FieldByName('col_span').AsInteger:=max_mater_col-4;
   mem_report.Post;
  end
end;

procedure correctColSpapnUseMater();
begin
 if mem_report.Locate('row_num;col_num', vararrayof([0,max_mater_col+1]),[]) then
  begin
   mem_report.Edit;
   mem_report.FieldByName('col_span').AsInteger:=max_dep_col+5-max_mater_col;
  mem_report.Post;
  end
end;


function calcAllCols(row:integer; col_from, col_to, col_except:integer):real;
var  col:integer;
totalcol:real;
v:variant;
begin
     totalcol:=0;
     for col:=col_from to col_to do
     begin
     if  col<>col_except then
      begin
       v:=mem_report.Lookup('row_num;col_num',vararrayof([row,col]),'qval');
      if v<> null then
         totalcol:=totalcol+v;
      end;
     end;
     result:=totalcol;
end;




procedure caclTotal(report_id_mats2id:integer; price:real);
var  row :integer;
total_get, total_use, left, left_sum:real;
begin
 if mem_report.Locate('report_mats2id;col_num', vararrayof([report_id_mats2id,2]),[]) then
   begin
     row:=mem_report.fieldbyname('row_num').AsInteger;
     total_get:=calcAllCols(row,3,max_mater_col-1,4);
     if total_get>0 then
      self.addCellDataVal(max_mater_col,'',row,report_id_mats2id,total_get);
     total_use:=calcAllCols(row,max_mater_col+1,max_dep_col,0);
     if total_use>0 then
       self.addCellDataVal(max_dep_col+5,'',row,report_id_mats2id,total_use);
     left:=total_get-total_use;
     if left>0 then
      self.addCellDataVal(max_dep_col+6,'',row,report_id_mats2id,left)
      else
       self.addCellDataVal(max_dep_col+6,'0',row,report_id_mats2id,left);

   end;
end;

procedure setTitles();
var yearmonth:string;

begin
 yearmonth:=setFirstdtMonth(dset_reports_out.fieldbyname('num_month').AsInteger, dset_reports_out.fieldbyname('num_year').AsInteger)+'р.';
  self.addCellConstVal(max_mater_col,allWORD,1);
  self.addCellConstVal(max_dep_col+4,OtherWOrd,1);
  self.addCellConstVal(max_dep_col+5,allWORD,1);
  self.addCellConstVal(max_dep_col+6,LEFTWORD,0,2);
  self.addCellConstVal(max_dep_col+6,yearmonth,1,2);
  self.addCellConstVal(max_dep_col+6,KIL,2,2);
  self.addCellConstVal(max_dep_col+7,SUMM,2,2);
end;

begin

 if not mem_report.Active then
  begin
   result:='MemReport not active!!!';
   exit;
  end;
  mem_report.SortOn('row_num;col_num',[]);
  correctColSpapnGetMater();
  correctColSpapnUseMater();
  setTitles();


  mem_maters.First;
  while not  mem_maters.eof do
  begin

   caclTotal(mem_maters.FieldByName('REPORT_MATS2id').AsInteger,mem_maters.FieldByName('price' ).AsFloat);
   mem_maters.Next;
  end;

end;




end.
