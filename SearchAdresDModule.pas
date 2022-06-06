unit SearchAdresDModule;

interface

uses
  SysUtils, Classes, Controls, IBSQL, IBDatabase, DMMain, OperAttFormUnit,
  DB, DBTables, RxMemDS, IBCustomDataSet, FR_Class, FR_DSet, FR_DBSet;

type
  TActionName=(anCreate, anDelete);

  Tdm_SearchAdres = class(TDataModule)
    IBSQL: TIBSQL;
    tran: TIBTransaction;
    tran_view: TIBTransaction;
    md_res: TRxMemoryData;
    md_resadres: TStringField;
    md_resdmg_count: TIntegerField;
    dset: TIBDataSet;
    dset_adres: TIBDataSet;
    md_resid_group: TIntegerField;
    md_bygroup: TRxMemoryData;
    md_bygroupid: TIntegerField;
    md_bygroupdt_in: TDateTimeField;
    md_bygroupnomer: TIntegerField;
    md_bygrouprevs: TStringField;
    md_bygroupadres: TStringField;
    md_bygroupplace: TStringField;
    md_bygroupdiam: TIntegerField;
    md_resid_ul1: TIntegerField;
    md_resid_ul2: TStringField;
    md_reskod_ul: TIntegerField;
    md_resid_dopadr: TIntegerField;
    frReport: TfrReport;
    frDS_res: TfrDBDataSet;
    frREportDoch: TfrReport;
    frDBDataSet_doch: TfrDBDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    F_Dt_beg: TDate;
    F_Dt_end: TDate;
    F_RevsID: string;
    F_PlaceID: string;
    F_DiamID: string;
    F_DmgCount: integer;
    F_OperAtt: TOperAtt;
    F_IsDescSort: boolean;
  private
    F_TMP_View_name: string;
    F_IsTMPView_Exists: boolean;
    procedure DoWith_TMP_View(action: TActionName);
    function Create_TMP_View_name: string;
    function get_create_view_sql: string;
    procedure PrepareResMemData;
    procedure PrepareByGroupMemData(id_group: integer);
    function get_adres(id_ul1: integer; id_ul2: string;
        kod_ul: integer; dop_adr: string; id_dopadr: integer): string;
    procedure get_adrcomp_by_group(id_group: integer; var id_ul1: integer;
        var id_ul2: string; var kod_ul, id_dopadr: integer);
  public
    property Dt_beg: TDate write F_Dt_beg;
    property Dt_end: TDate write F_Dt_end;
    property RevsID: string write F_RevsID;
    property PlaceID: string write F_PlaceID;
    property DiamID: string write F_DiamID;
    property DmgCount: integer write F_DmgCount;
    property OperAtt: TOperAtt write F_OperAtt;
    property IsDescSort: boolean write F_IsDescSort;
    procedure PrepareDset;
    procedure PrepareDsetByGroup(id_group: integer);
  end;

var
  dm_SearchAdres: Tdm_SearchAdres;

implementation

{$R *.dfm}

uses ServiceFuncUnit;

{ Tdm_SearchAdres }

function Tdm_SearchAdres.Create_TMP_View_name: string;
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

  Result:='TMP_'+IntToStr(Random(10))+'_'+dt+tm;
end;

procedure Tdm_SearchAdres.DoWith_TMP_View(action: TActionName);
var
  tr: TIBTransaction;
  exec_sql: string;
begin
  tr:=IBSQL.Transaction;
  if tr.InTransaction then tr.Rollback;
  tr.StartTransaction;
  try
    case action of
      anCreate: exec_sql:=get_create_view_sql;
      anDelete: exec_sql:='DROP VIEW '+F_TMP_View_name;
    end;

    IBExecSQL(IBSQL, exec_sql);

    tr.Commit;
    F_IsTMPView_Exists:=(action=anCreate);
  except
    on E: Exception do
    begin
      tr.Rollback;
      raise Exception.Create(E.Message+' (Tdm_SearchAdres.DoWith_TMP_View');
    end;
  end;
end;

procedure Tdm_SearchAdres.PrepareDset;
begin
  if F_IsTMPView_Exists then DoWith_TMP_View(anDelete);
  DoWith_TMP_View(anCreate);

  if tran.InTransaction then tran.Rollback;
  tran.StartTransaction;
  try
    PrepareResMemData;
    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      raise Exception.Create(E.Message+' (Tdm_SearchAdres.PrepareDset)');
    end;
  end;
end;

procedure Tdm_SearchAdres.DataModuleCreate(Sender: TObject);
begin
  F_TMP_View_name:=Create_TMP_View_name;
  F_IsTMPView_Exists:=false;
end;

function Tdm_SearchAdres.get_create_view_sql: string;
var
  cond_attach, cond_date, cond_revs, cond_place, cond_diam: string;
begin
  cond_attach:=' and (id_attach='+IntToStr(ord(F_OperAtt))+')';
  cond_date:=' and (dt_in>'''+DateToStr(F_Dt_beg)+''') and (dt_in<='''+DateToStr(F_Dt_end+1)+''')';
  if trim(F_RevsID)<>'' then cond_revs:=' and (id_revs in'+F_RevsID+')'
  else cond_revs:='';
  if trim(F_PlaceID)<>'' then cond_place:=' and (id_place in'+F_PlaceID+')'
  else cond_place:='';
  if trim(F_DiamID)<>'' then cond_diam:=' and (id_diam in'+F_DiamID+')'
  else cond_diam:='';

  Result:=
    ' CREATE VIEW '+F_TMP_View_name+'('+
    '     ID,'+
    '     NOMER,'+
    '     DT_IN,'+
    '     ID_RAYON,'+
    '     ID_UL1,'+
    '     ID_UL2,'+
    '     KOD_UL,'+
    '     ID_PLACE,'+
    '     ID_DIAM,'+
    '     DOP_ADR,'+
    '     ID_REVS,'+
    '     ID_DOPADRES,'+
    '     IS_CLOSED)'+
    ' AS'+
    ' select'+
    '     ID,'+
    '     NOMER,'+
    '     DT_IN,'+
    '     ID_RAYON,'+
    '     ID_UL1,'+
    '     ID_UL2,'+
    '     KOD_UL,'+
    '     ID_PLACE,'+
    '     ID_DIAM,'+
    '     DOP_ADR,'+
    '     ID_REVS,'+
    '     ID_DOPADRES,'+
    '     0 IS_CLOSED'+
    ' from nzavjav'+
    ' where (delz=0 and (is_otl is null or is_otl<>1))'+
    cond_attach+
    cond_date+
    cond_revs+
    cond_place+
    cond_diam+
    ' union all'+
    ' select'+
    '     ID,'+
    '     NOMER,'+
    '     DT_IN,'+
    '     ID_RAYON,'+
    '     ID_UL1,'+
    '     ID_UL2,'+
    '     KOD_UL,'+
    '     ID_PLACE,'+
    '     ID_DIAM,'+
    '     DOP_ADR,'+
    '     ID_REVS,'+
    '     ID_DOPADRES,'+
    '     1 IS_CLOSED'+
    ' from zavjav'+
    ' where (delz=0 and (is_otl is null or is_otl<>1) )'+
    cond_attach+
    cond_date+
    cond_revs+
    cond_place+
    cond_diam;
end;

procedure Tdm_SearchAdres.PrepareResMemData;
var
  id_ul1, kod_ul, id_dopadr: integer;
  id_ul2, dop_adr: string;
  sort_type: string;
  id_group: integer;
begin
  md_res.Close;
  md_res.Open;

  if F_IsDescSort then sort_type:='desc'
  else sort_type:='asc';

  IBOpenSQL(dset,
    ' select count(*) DmgCount, su.name_r as ul1,'+
    ' z.id_ul1, z.id_ul2, z.kod_ul, z.id_dopadres'+
    ' from '+F_TMP_View_name+' z'+
    ' left join s_ulic su'+
    ' on su.id=z.id_ul1'+
    ' group by su.name_r, z.id_ul1, z.id_ul2, z.kod_ul, z.id_dopadres'+
    ' having count(*)>'+IntToStr(F_DmgCount)+
    ' order by 1 '+sort_type+', 2');

  id_group:=1;
  while not dset.Eof do
  begin
    id_ul1:=dset.FieldByName('id_ul1').AsInteger;
    id_ul2:=dset.FieldByName('id_ul2').AsString;
    kod_ul:=dset.FieldByName('kod_ul').AsInteger;
    id_dopadr:=dset.FieldByName('id_dopadres').AsInteger;
    dop_adr:='';

    md_res.Append;
    md_res.FieldByName('id_group').AsInteger:=id_group;
    md_res.FieldByName('adres').AsString:=get_adres(id_ul1, id_ul2, kod_ul, dop_adr, id_dopadr);
    md_res.FieldByName('dmg_count').AsInteger:=dset.FieldByName('DmgCount').AsInteger;
    md_res.FieldByName('id_ul1').AsInteger:=id_ul1;
    md_res.FieldByName('id_ul2').AsString:=id_ul2;
    md_res.FieldByName('kod_ul').AsInteger:=kod_ul;
    md_res.FieldByName('id_dopadr').AsInteger:=id_dopadr;
    md_res.Post;

    inc(id_group);
    dset.Next;
  end;
end;

function Tdm_SearchAdres.get_adres(id_ul1: integer; id_ul2: string;
  kod_ul: integer; dop_adr: string; id_dopadr: integer): string;
begin
  IBOpenSQL(dset_adres,
    Format('select adres from get_adres(%d, ''%s'', %d, ''%s'', %d)',
        [id_ul1, trim(id_ul2), kod_ul, trim(dop_adr), id_dopadr]));
  Result:=dset_adres.FieldByName('adres').AsString;
end;

procedure Tdm_SearchAdres.DataModuleDestroy(Sender: TObject);
begin
  if F_IsTMPView_Exists then DoWith_TMP_View(anDelete);
end;

procedure Tdm_SearchAdres.PrepareDsetByGroup(id_group: integer);
begin
  if tran.InTransaction then tran.Rollback;
  tran.StartTransaction;
  try
    PrepareByGroupMemData(id_group);
    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      raise Exception.Create(E.Message+' (Tdm_SearchAdres.PrepareDsetByGroup)');
    end;
  end;
end;

procedure Tdm_SearchAdres.PrepareByGroupMemData(id_group: integer);
var
  id_ul1, kod_ul, id_dopadr: integer;
  id_ul2: string;
  i: integer;
begin
  md_bygroup.Close;
  md_bygroup.Open;

  get_adrcomp_by_group(id_group, id_ul1, id_ul2, kod_ul, id_dopadr);

  IBOpenSQL(dset,
    ' select z.id, z.dt_in, z.nomer,'+
    ' (select name_r from s_revs where id=z.id_revs) revs,'+
    ' (select adres from get_adres(z.id_ul1, z.id_ul2, z.kod_ul, z.dop_adr, z.id_dopadres)) adres,'+
    ' (select name_r from s_place where id=z.id_place) place,'+
    ' (select diam from s_diam where id=z.id_diam) diam'+
    ' from '+F_TMP_View_name+' z'+
    ' where'+
    ' (z.id_ul1='+IntToStr(id_ul1)+')'+
    ' and (z.id_ul2='''+id_ul2+''')'+
    ' and (z.kod_ul='+IntToStr(kod_ul)+')'+
    ' and (z.id_dopadres='+IntToStr(id_dopadr)+')'+
    ' order by z.dt_in');
  while not dset.Eof do
  begin
    md_bygroup.Append;
    for i:=0 to md_bygroup.FieldCount-1 do
      md_bygroup.Fields[i].Value:=dset.FieldByName(md_bygroup.Fields[i].FieldName).Value;
    md_bygroup.Post;

    dset.Next;
  end;

end;

procedure Tdm_SearchAdres.get_adrcomp_by_group(id_group: integer;
  var id_ul1: integer; var id_ul2: string; var kod_ul, id_dopadr: integer);
begin
  md_res.Locate('id_group', id_group,[]);
  id_ul1:=md_res.FieldByName('id_ul1').AsInteger;
  id_ul2:=md_res.FieldByName('id_ul2').AsString;
  kod_ul:=md_res.FieldByName('kod_ul').AsInteger;
  id_dopadr:=md_res.FieldByName('id_dopadr').AsInteger;
end;

end.
