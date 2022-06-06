unit UtechkiZaPeriodDModule;

interface

uses
  SysUtils, Classes, IBQuery, IBDatabase, DB, IBCustomDataSet, RxMemDS, DMMain,
  IBSQL, Controls, OperAttFormUnit, FR_Class, FR_DSet, FR_DBSet;

type
  TActionName=(anCreate, anDelete);

  Tdm_UtechkiZaPeriod = class(TDataModule)
    dset: TIBDataSet;
    tran: TIBTransaction;
    tran_view: TIBTransaction;
    md_res: TRxMemoryData;
    sql_view: TIBSQL;
    md_resid: TIntegerField;
    md_resdt_in: TDateTimeField;
    md_resid_revs: TIntegerField;
    md_resrevs: TStringField;
    md_resadres: TStringField;
    md_respromyv: TFloatField;
    md_resoporozhn: TFloatField;
    md_respovrezhd: TFloatField;
    md_ressum_poteri: TFloatField;
    md_resmain_gr: TIntegerField;
    md_resnomer: TIntegerField;
    frReport: TfrReport;
    frDS_res: TfrDBDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    F_TMPView_name: string;
    F_IsTMPView_exists: boolean;
    function Get_CreateView_sql: string;
    function CreateTMPView_name: string;
    procedure PrepareResMD;
    procedure DoWith_TMPView(action: TActionName);
  private
    F_Dt_beg: TDate;
    F_Dt_end: TDate;
    F_OperAtt: TOperAtt;
    function getPoteriPromyv(AMatPipe:string;dt:TDateTime;diam:integer):double;
    function PoteriOporzhn( ADiam:integer;  AProtyazh: double): double;
    function PoteriPovrezhd(ADateBegin: TDateTime; ADateEnd: TDateTime;  ASpeedLeak: double): double;
  public
    property Dt_beg: TDate read F_Dt_beg write F_Dt_beg;
    property Dt_end: TDate read F_Dt_end write F_Dt_end;
    property OperAtt: TOperAtt read F_OperAtt write F_OperAtt;

    procedure PrepareDset;
  end;


implementation

{$R *.dfm}

uses ServiceFuncUnit,QShevels,DateUtils,HelpFunctions;

{ Tdm_UtechkiZaPeriod }

function Tdm_UtechkiZaPeriod.CreateTMPView_name: string;
  procedure DelAllChar(c: char; var s: string);
  var
    p: integer;
  begin
   p:=pos(c, s);
   if p>0 then
   begin
      Delete(s, p, 1);
      DelAllChar(c, s);
   end;
  end;
var
  s, dt, tm: string;
begin
  dt:=DateToStr(date);
  DelAllChar('.', dt);

  tm:=TimeToStr(time);
  DelAllChar(':', tm);

  Result:='TMP2_'+IntToStr(Random(10))+'_'+dt+tm;
end;

procedure Tdm_UtechkiZaPeriod.DoWith_TMPView(action: TActionName);
var
  exec_sql: string;
begin
  if tran_view.InTransaction then tran_view.Rollback;
  tran_view.StartTransaction;
  try
    case action of
      anCreate: exec_sql:=Get_CreateView_sql;
      anDelete: exec_sql:='DROP VIEW '+F_TMPView_name;
    end;

    IBExecSQL(sql_view, exec_sql);
    tran_view.Commit;
    F_IsTMPView_exists:=(action=anCreate);
  except
    on E: Exception do
    begin
      tran_view.Rollback;
      raise Exception.Create(E.Message+'(Tdm_UtechkiZaPeriod.DoWith_TMPView)')
    end;
  end;
end;

procedure Tdm_UtechkiZaPeriod.PrepareDset;
begin
  if F_IsTMPView_exists then DoWith_TMPView(anDelete);
  DoWith_TMPView(anCreate);

  if tran.InTransaction then tran.Rollback;
  tran.StartTransaction;
  try
    PrepareResMD;
    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      raise Exception.Create(E.Message+'(Tdm_UtechkiZaPeriod.PrepareDset)');
    end;
  end;
end;

procedure Tdm_UtechkiZaPeriod.PrepareResMD;
var
  i: integer;
  PROMYV,OPOROZHN,POVREZHD :double;
begin
  md_res.Close;
  md_res.Open;

  IBOpenSQL(dset,
    ' select ID, NOMER, DT_IN, ID_REVS, REVS, ADRES,'+
    'matpipe, cl_promiv_time,diam,op_protyazh,poterde_end,poterq '+
    {(select name_r from s_matpipe where id=z.id_c),'+
    '             z.cl_promiv_time,'+
    '          (select diam from s_diam where id=z.op_id_diam)
    }
    {POTERIOPORZHN1((select diam from s_diam where id=z.op_id_diam),'+
    '                 z.op_protyazh) Oporozhn
    }
    {poterde_end ,'+
     'z.q poterq
    }
    {' PROMYV, OPOROZHN, POVREZHD, PROMYV+OPOROZHN+POVREZHD as SUM_POTERI'+}
    ' from '+F_TMPView_name+

    ' order by REVS, DT_IN  ');

  while not dset.Eof do
  begin
    PROMYV :=getPoteriPromyv(dset.fieldbyname('matpipe').AsString,dset.fieldbyname('cl_promiv_time').AsDateTime,dset.fieldbyname('diam').AsInteger);
    OPOROZHN:=PoteriOporzhn(dset.fieldbyname('diam').AsInteger,
                           dset.fieldbyname('op_protyazh').AsFloat);
    POVREZHD:=PoteriPovrezhd(dset.fieldbyname('dt_in').AsDateTime,
                             dset.fieldbyname('poterde_end').AsDateTime,
                             dset.fieldbyname('poterq').AsFloat);


    if (PROMYV>0)or(OPOROZHN>0)or(POVREZHD>0) then
    begin
    md_res.Append;
    md_res.FieldByName('main_gr').AsInteger:=1;
    for i:=0 to 5 do
      md_res.FieldByName(dset.Fields[i].FieldName).Value:=dset.Fields[i].Value;
    md_res.FieldByName('promyv').AsFloat:=PROMYV;
    md_res.FieldByName('oporozhn').AsFloat:=OPOROZHN;
    md_res.FieldByName('povrezhd').AsFloat:=POVREZHD;
    md_res.FieldByName('sum_poteri').AsFloat:=POVREZHD+OPOROZHN+PROMYV;
    md_res.FieldByName('main_gr').AsInteger:=1;


    md_res.Post;
    end;
    dset.Next;
  end;
end;

procedure Tdm_UtechkiZaPeriod.DataModuleCreate(Sender: TObject);
begin
  F_TMPView_name:=CreateTMPView_name;
  F_IsTMPView_exists:=false;
end;

procedure Tdm_UtechkiZaPeriod.DataModuleDestroy(Sender: TObject);
begin
  if F_IsTMPView_exists then DoWith_TMPView(anDelete);
end;

function Tdm_UtechkiZaPeriod.Get_CreateView_sql: string;
var
  cond_attach, cond_date: string;
begin
  cond_attach:=' and (z.id_attach='+IntToStr(ord(F_OperAtt))+')';
  cond_date:=' and (z.dt_in>'''+DateToStr(F_Dt_beg)+''') and (z.dt_in<='''+DateToStr(F_Dt_end+1)+''')';

  Result:=
    ' CREATE VIEW '+F_TMPView_name+'('+
    '     ID,'+
    '     NOMER,'+
    '     DT_IN,'+
    '     ID_REVS,'+
    '     REVS,'+
    '     ADRES,'+
    '     matpipe,'+
    '     cl_promiv_time, '+
    '     diam,'+
    '     op_protyazh,'+
    '     poterde_end,'+
    '     poterq '+
   { '     PROMYV,'+
    '     OPOROZHN,'+
    '     POVREZHD)'+}
    ' ) AS'+
    ' select z.id, z.nomer, z.dt_in, id_revs,'+
    ' (select name_r from s_revs where id=z.id_revs) revs,'+
    ' (select adres from get_adres(z.id_ul1, z.id_ul2, z.kod_ul, z.dop_adr, z.id_dopadres)) adres,'+

    ' (select name_r from s_matpipe where id=z.id_matpipe) matpipe,'+
     ' z.cl_promiv_time ,'+
     ' (select diam from s_diam where id=z.op_id_diam) diam, '+
     '  z.op_protyazh ,     '+
     '(select dt_end from get_utechenddate(z.id) ) poterde_end ,'+
     'z.q poterq '+

   { ' POTERIPROMYV1((select name_r from s_matpipe where id=z.id_matpipe),'+
    '             z.cl_promiv_time,'+
    '          (select diam from s_diam where id=z.op_id_diam)) Promyv,'+
    ' POTERIOPORZHN1((select diam from s_diam where id=z.op_id_diam),'+
    '                 z.op_protyazh) Oporozhn,'+
    ' POTERIPOVREZHD1(z.dt_in, (select dt_end from get_utechenddate(z.id)), z.q) Povrezhd'+
    }' from nzavjav z'+
    ' where (delz=0  and (is_otl is null or is_otl<>1 ))'+cond_attach+cond_date+
      ' union all'+
    ' select z.id, z.nomer, z.dt_in, id_revs,'+
    ' (select name_r from s_revs where id=z.id_revs) revs,'+
    ' (select adres from get_adres(z.id_ul1, z.id_ul2, z.kod_ul, z.dop_adr, z.id_dopadres)) adres,'+

      ' (select name_r from s_matpipe where id=z.id_matpipe) matpipe,'+
     ' z.cl_promiv_time ,'+
     ' (select diam from s_diam where id=z.op_id_diam) diam, '+
     '  z.op_protyazh ,     '+
     '(select dt_end from get_utechenddate(z.id) ) poterde_end ,'+
     'z.q poterq '+

{    ' POTERIPROMYV1((select name_r from s_matpipe where id=z.id_matpipe),'+
    '             z.cl_promiv_time,'+
    '          (select diam from s_diam where id=z.op_id_diam)) Promyv,'+
    ' POTERIOPORZHN1((select diam from s_diam where id=z.op_id_diam),'+
    '                 z.op_protyazh) Oporozhn,'+
    ' POTERIPOVREZHD1(z.dt_in, (select dt_end from get_utechenddate(z.id)), z.q) Povrezhd'+
    }' from zavjav z'+
    ' where delz=0 and (is_otl is null or is_otl<>1 ) '+cond_attach+cond_date+';';
end;

function Tdm_UtechkiZaPeriod.getPoteriPromyv(AMatPipe:string;dt:TDateTime;diam:integer):double;
var
  _QShevelev:TQShevelev;
begin
  result:=0;

  _QShevelev:=TQShevelev.Create;
  try
    _QShevelev.MatPipeStr:=AMatPipe;
    result:=_QShevelev.GetQinM3(dt,Diam);
    if result<=-1 then result:=0;
  finally
    _QShevelev.Free;
  end;

end;

function Tdm_UtechkiZaPeriod.PoteriOporzhn( ADiam:integer;  AProtyazh: double): double;
begin
  Result:=pi*sqr(ADiam/2/1000)*AProtyazh;
end;

function Tdm_UtechkiZaPeriod.PoteriPovrezhd(ADateBegin: TDateTime; ADateEnd: TDateTime;  ASpeedLeak: double): double;
  function Hours(fulltime:TDateTime):double;
  begin
    result:=Trunc(fulltime)*24+HourOf(fulltime)+MinuteOf(fulltime)/60+SecondOf(fulltime)/3600;
  end;

begin
  if ADateEnd=0 then ADateEnd:=Now(); 
  Result:=ASpeedLeak*Hours(ADateEnd-ADateBegin);
end;



end.
