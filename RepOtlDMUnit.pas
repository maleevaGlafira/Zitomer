unit RepOtlDMUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SvodVed2DModule, FR_DSet, FR_DBSet, DB, RxMemDS, IBDatabase,
  IBCustomDataSet, FR_Class, OperAttFormUnit;

type
  Tdm_OtlReport = class(Tdm_SvodVed2)
    md_reslinkedzav: TStringField;
    MD_RESGROUP: TRxMemoryData;
    MD_RESGROUPID: TIntegerField;
    MD_RESGROUPnomer: TIntegerField;
    MD_RESGROUPrev: TStringField;
    MD_RESGROUPattach: TStringField;
    md_resall: TRxMemoryData;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    IntegerField2: TIntegerField;
    IntegerField3: TIntegerField;
    DateTimeField1: TDateTimeField;
    IntegerField4: TIntegerField;
    IntegerField5: TIntegerField;
    StringField2: TStringField;
    StringField3: TStringField;
    StringField4: TStringField;
    StringField5: TStringField;
    StringField6: TStringField;
    StringField7: TStringField;
    StringField8: TStringField;
    StringField9: TStringField;
    StringField10: TStringField;
    DateTimeField2: TDateTimeField;
    StringField11: TStringField;
    md_resallid_link: TIntegerField;
    md_resallnomer_link: TIntegerField;
    md_resallrevs_link: TStringField;
    md_resallattach_link: TStringField;
    md_resallsod_link: TStringField;
    md_resalldt_out_link: TDateTimeField;
    MD_RESGROUPadres: TStringField;
    MD_RESGROUPsod: TStringField;
    MD_RESGROUPdt_in: TDateTimeField;
    md_reslist_zav: TStringField;
    md_reslist_count: TIntegerField;
    md_resinvers_Count: TIntegerField;
    md_resinvers_nomer: TIntegerField;
    md_resinvers_dt_in: TFloatField;
    md_resinvers_adres: TStringField;
    md_resinvers_dt_out: TDateTimeField;
    procedure DataModuleCreate(Sender: TObject);
    procedure md_resCalcFields(DataSet: TDataSet);

  private
    { Private declarations }
    F_dtBegin,F_dtEnd:TDateTime;
    F_typZav:integer; // 0 - все 1- закрытые 2 - незакрытые
    F_sortField:string;
    F_upDesr:integer ;//1 - up -1 -desc
     procedure InitSEL_ZAV; override;
     procedure FILL(OperAtt: TOperAtt);
     procedure append_otl(OperAtt: TOperAtt);
     procedure insert_base_field(zav_type_name: string; dset_src, dset_des: TDataSet);
     function get_primech(id_zav: integer): string;
     procedure calcinverField();
  public
    { Public declarations }
    procedure PrepareDset;
    function preparebygroup(id_zav:integer):boolean;
    property dtBegin:TDateTime write F_dtBegin ;
    property dtEnd:TDateTime write F_dtEnd ;
    procedure sorted(FieldName:string);
    property  typZav:integer read F_typZav write F_typZav; // 0 - все 1- закрытые 2 - незакрытые

  end;

var
  dm_OtlReport: Tdm_OtlReport;

implementation

{$R *.dfm}

uses ServiceFuncUnit;

var
  ARR_COM_FIELD: array[0..9] of string=
    ('id','nomer','dt_in','id_attach','id_revs','revs','attach','adres','wwater_list','dt_out');

procedure Tdm_OtlReport.InitSEL_ZAV;
var
  revs_cond: string;
begin
 if F_RevsID<>'' then
    revs_cond:=' and z.id_revs in'+F_RevsID
 else
    revs_cond:='';

 {F_SEL_ZAV:=
    ' select z.id, z.nomer, z.dt_in, z.id_attach, z.id_revs,' +
    ' sr.name_r revs, att.name_r attach,' +
    ' (select adres from get_adres(z.id_ul1,z.id_ul2,z.kod_ul,z.dop_adr,z.id_dopadres)) adres,' +
    ' rtrim(ss.name_r)||"("||rtrim(st.name_r)||","||rtrim(sp.name_r)||")" as sod,' +
    ' (select wwater_list from get_wwater_list( z.id ) ) wwater_list' +
    ' from nzavjav z'+//    ' from %s z'+
    ' left join s_revs sr on ( sr.id = z.id_revs )' +
    ' left join s_attach att on ( att.id = z.id_attach )' +
    ' left join s_sod ss on ( ss.id = z.id_sod )' +
    ' left join s_tzav st on (st.id = ss.ftype)' +
    ' left join s_place sp on (sp.id = ss.place_type)' +
    ' left join s_owner so on ( so.id = z.id_alien )' +
    ' where (delz=0) and (z.is_otl = 1) '+
    revs_cond +
    ' order by sr.name_r, z.dt_in';
  }
 F_SEL_ZAV:=
    ' select z.id, z.nomer, z.dt_in, z.id_attach, z.id_revs,' +
    ' sr.name_r revs, att.name_r attach,%s dt_out,' +
    ' (select adres from get_adres(z.id_ul1,z.id_ul2,z.kod_ul,z.dop_adr,z.id_dopadres)) adres,' +
    ' rtrim(ss.name_r)||"("||rtrim(st.name_r)||","||rtrim(sp.name_r)||")" as sod,' +
    ' (select wwater_list from get_wwater_list( z.id ) ) wwater_list,' +
    ' (select list(zz.nomer,'',  '') from linkotlorder lo join   nzavjav zz on zz.id=lo.id_zavjav  where lo.id_otlzavjav=z.id ) zav_list,'+
    ' (select list(zz.nomer,'',  '' ) from linkotlorder lo join   zavjav zz on zz.id=lo.id_zavjav  where lo.id_otlzavjav=z.id ) zav_listclose,' +
    ' (select count(*) from linkotlorder lo join   nzavjav zz on zz.id=lo.id_zavjav  where lo.id_otlzavjav=z.id ) count_list,'+
    ' (select count(*) from linkotlorder lo join   zavjav zz on zz.id=lo.id_zavjav  where lo.id_otlzavjav=z.id ) count_listclose' +
    ' from %s z'+
    ' left join s_revs sr on ( sr.id = z.id_revs )' +
    ' left join s_attach att on ( att.id = z.id_attach )' +
    ' left join s_sod ss on ( ss.id = z.id_sod )' +
    ' left join s_tzav st on (st.id = ss.ftype)' +
    ' left join s_place sp on (sp.id = ss.place_type)' +
    ' left join s_owner so on ( so.id = z.id_alien )' +
    ' where (delz=0) and (z.id_attach = %d) %s '+
    revs_cond +
    ' order by sr.name_r, z.dt_in';


end;


procedure Tdm_OtlReport.PrepareDset;
begin
  if md_res.Active then md_res.Close;
  md_res.Open;
  if tran.InTransaction then
    tran.Rollback;
  tran.StartTransaction;
  try
    InitSEL_ZAV;

    if F_IsVoda then FILL(toaVoda);
    if F_IsKanal then FILL(toaKanal);
    if F_IsVrk then FILL(toaVRK);

    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      raise Exception.Create(E.Message+'(PrepareDset)');
    end;
  end;
end;

procedure Tdm_OtlReport.FILL(OperAtt: TOperAtt);
begin
  append_otl(OperAtt); //отложенные
end;


procedure Tdm_OtlReport.append_otl(OperAtt: TOperAtt);
    procedure addDataFromDset();
    begin
      while not dset_tmp.Eof do
    begin
      md_res.Append;
      insert_base_field('ОТЛОЖЕННЫЕ', dset_tmp, md_res);
      calcinverField();
      md_res.Post;
    dset_tmp.Next;
  end;
    end;
var
  cond, _sql: string;
begin
  cond:=cond + ' and (z.is_otl=1)';
  cond:=cond + Format(' and z.dt_in between ''%s'' and ''%s'' ',
              [dateTimeToStr(F_dtbegin),dateTimeToStr(F_dtend)]);

 // MyOpenIBDS(dset_tmp, F_SEL_ZAV);
 if F_typZav in [0,1] then begin //все незакрытые
  _sql := Format(F_SEL_ZAV, ['null','nzavjav', ord(OperAtt), cond]);
   MyOpenIBDS(dset_tmp, _sql);
  addDataFromDset();
 end;
 if F_typZav in [0,2] then begin //все закрытые
   _sql := Format(F_SEL_ZAV, ['z.dt_out','zavjav', ord(OperAtt), cond]);
   MyOpenIBDS(dset_tmp, _sql);
   addDataFromDset();
 end;
 md_res.SortOnFields('revs;dt_in');



end;


procedure Tdm_OtlReport.insert_base_field(zav_type_name: string; dset_src, dset_des: TDataSet);
var
  i: integer;
begin
  dset_des.FieldByName('main_gr').AsInteger:=0;
  dset_des.FieldByName('zav_type_name').AsString:=zav_type_name;
  dset_des.FieldByName('sod').AsString:=DeletePusto(dset_src.FieldByName('sod').AsString);

  for i:=low(ARR_COM_FIELD) to high(ARR_COM_FIELD) do
    dset_des.FieldByName(ARR_COM_FIELD[i]).Value:=dset_src.FieldByName(ARR_COM_FIELD[i]).Value;
  dset_des.FieldByName('list_zav').AsString:=dset_src.FieldByName('zav_list').AsString+
  ' '+dset_src.FieldByName('zav_listclose').AsString;
  dset_des.FieldByName('primech').AsString:=get_primech(dset_src.FieldByName('id').AsInteger);
  dset_des.FieldByName('list_count').AsInteger:=dset_src.fieldbyname('count_listclose').AsInteger+
                                                dset_src.fieldbyname('count_list').AsInteger;

end;


function Tdm_OtlReport.get_primech(id_zav: integer): string;
const
  SEL_NAR=' select dt_in, dop_inf from %s'+
          ' where id_zav=%d'+
          ' order by dt_in';
begin
  {Функция возвращает дополнительную инфу из последнего выезда}

  Result:='';
  MyOpenIBDS(dset_tmp3, Format(SEL_NAR, ['nnarad', id_zav]));
  if dset_tmp3.Eof then
    MyOpenIBDS(dset_tmp3, Format(SEL_NAR,['narad', id_zav]));
  if not dset_tmp3.Eof then
  begin
    dset_tmp3.Last;
    Result:=dset_tmp3.FieldByName('dop_inf').AsString;
  end;
end;

function Tdm_OtlReport.preparebygroup(id_zav: integer): boolean;
const sel_zavs = 'select z.id, z.nomer, sr.name_r revs,z.id_attach, '+
                 ' sa.name_r attach, '+
                 ' (select adres from get_adres(z.id_ul1, z.id_ul2,z.kod_ul, '+
                          'z.dop_adr,z.id_dopadres )) adres, '+
                 '  sd.name_r sod, z.dt_in '+
                 ' from zavjav z join linkotlorder lo on lo.id_zavjav=z.id '+
                 '  join s_revs sr on sr.id=z.id_revs '+
                 '  join s_attach sa on sa.id=z.id_attach '+
                 '   join s_sod sd on sd.id=z.id_sod '+
                 '   where  lo.id_otlzavjav=%d '+
                 ' union '+
                  'select z.id, z.nomer, sr.name_r rev, z.id_attach,'+
                 ' sa.name_r attach, '+
                 ' (select adres from get_adres(z.id_ul1, z.id_ul2,z.kod_ul, '+
                          'z.dop_adr,z.id_dopadres )) adres, '+
                 '  sd.name_r sod, z.dt_in '+
                 ' from nzavjav z join linkotlorder lo on lo.id_zavjav=z.id '+
                 '  join s_revs sr on sr.id=z.id_revs '+
                 '  join s_attach sa on sa.id=z.id_attach '+
                 '   join s_sod sd on sd.id=z.id_sod '+
                 '   where  lo.id_otlzavjav=%d '+
                 ' order by 5,6,8 ';


var table:string;
i:integer;
begin
 result:=false;
 if MD_RESGROUP.Active then
   MD_RESGROUP.Close;
 if dset_tmp.Active then dset_tmp.Close;
 dset_tmp.SelectSQL.Text:=Format(sel_zavs,[id_zav,id_zav]);
 dset_tmp.Open;
 dset_tmp.First;
 MD_RESGROUP.Open;
 while not dset_tmp.Eof do
 begin
  MD_RESGROUP.Append;
  for i:=0 to MD_RESGROUP.FieldCount-1 do
  begin
     MD_RESGROUP.Fields[i].AsString:=dset_tmp.fieldbyname(MD_RESGROUP.Fields[i].FieldName).AsString;
  if i=0 then
   MD_RESGROUP.Fields[i].AsInteger:=dset_tmp.fieldbyname(MD_RESGROUP.Fields[i].FieldName).AsInteger
  else if i=6 then
    MD_RESGROUP.Fields[i].AsDateTime:=dset_tmp.fieldbyname(MD_RESGROUP.Fields[i].FieldName).AsDateTime;
end;

  MD_RESGROUP.Post;
  dset_tmp.Next;
 end;
 result:=true;
end;

procedure Tdm_OtlReport.sorted(FieldName: string);
begin
{ F_sortField:string;
    F_upDesr:integer ;//1 - up -1 -desc}
if FieldName=F_sortField then
  F_upDesr:=F_upDesr*-1;
if  F_upDesr=1 then
  md_res.SortOnFields('main_gr;id_attach;'+FieldName)
else
   md_res.SortOnFields('main_gr;id_attach;invers_'+FieldName);
F_sortField:=FieldName;
end;

procedure Tdm_OtlReport.DataModuleCreate(Sender: TObject);
begin
  inherited;
F_upDesr:=1;
end;

procedure Tdm_OtlReport.md_resCalcFields(DataSet: TDataSet);
var i:integer;
    s:string;
    od:integer;
begin
  inherited;

end;

procedure Tdm_OtlReport.calcinverField();
var i, od:integer;
    s:string;
begin
s:='';
 if md_res.State in [dsInsert, dsEdit] then
 begin
  md_res.FieldByName('invers_list_count').AsInteger:=-1*md_res.FieldByName('list_count').AsInteger;
  md_res.FieldByName('invers_nomer').AsInteger:=-1*md_res.FieldByName('nomer').AsInteger;
  md_res.FieldByName('invers_dt_in').AsFloat:=-1*md_res.FieldByName('dt_in').AsFloat;
  md_res.FieldByName('invers_dt_out').AsFloat:=-1*md_res.FieldByName('dt_out').AsFloat;
  for i:=1 to length(md_res.FieldByName('adres').AsString) do
  begin
    od:=ord(md_res.FieldByName('adres').AsString[i]);
    s:=s+chr(255-od);
  end;
  md_res.FieldByName('invers_adres').AsString:=s;
 end;
end;

end.
