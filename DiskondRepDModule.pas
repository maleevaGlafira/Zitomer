unit DiskondRepDModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class,DMmain, FR_DSet, FR_DBSet, DB,
  RxMemDS, IBCustomDataSet, IBDatabase,OperAttFormUnit,Math;

type
  Tdm_DiskondRep = class(Tdm_NGReportBase)
    rmmain: TRxMemoryData;
    frDBDataSet1: TfrDBDataSet;
    tran: TIBTransaction;
    dset_main: TIBDataSet;
    rmmainid_wwater: TIntegerField;
    rmmainid_rayon: TIntegerField;
    rmmainregion: TStringField;
    rmmainid: TIntegerField;
    rmmainstreet_disc: TStringField;
    rmmainadress_disc: TStringField;
    rmmaindt_discon: TDateField;
    rmmaintm_discon: TTimeField;
    rmmaindt_con: TDateField;
    rmmaintm_con: TTimeField;
    rmmainhours_water: TFloatField;
    rmmainnomer1: TIntegerField;
    rmmainadres1: TStringField;
    rmmaindt_zav: TStringField;
    rmmaindt_in: TStringField;
    rmmaincoment: TStringField;
    rmmainminute_water: TFloatField;
    rmmaindttm_con: TStringField;
    rmmaindttm_discon: TStringField;
    rmmainempty: TStringField;
    dset_kod: TIBDataSet;
    rmmainkodPerv: TStringField;
    rmmainkod06: TStringField;
    rmmainkod07: TStringField;
    rmmainkod08: TStringField;
    rmmainkod09: TStringField;
    rmmainkod10: TStringField;
    rmmainlongminute: TStringField;
    rmmainNOMER_DISCON: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    F_dt_begin:TDateTime;
    F_dt_end:TDateTime;
    F_operAttach:TOperAtt;
    F_RevsID:string;
    F_type:integer;
    f_addkod:boolean;
    isadded:boolean;
    F_listkod:Tstringlist;
    F_streetDisconID :string;
    F_streetOrderID :string;
    function prepareSQL:boolean;
    procedure fillMainrm();
    procedure addColumn();
  public
    { Public declarations }
    function Preparedsets:boolean;
    property dt_begin :TDateTime read F_dt_begin write F_dt_begin ;
    property dt_end :TDateTime read F_dt_end write F_dt_end ;
    property operAttach:TOperAtt write F_operAttach;
    property revsID:string write F_RevsID;
    property StreetDisconID :string write F_streetDisconID;

    property StreetOrderID :string write F_streetOrderID;

    property TypeDiscon :integer write F_type;// 2 - закрытые 1 - незакрытые  0 - все
    property addkod: boolean write f_addkod;
    property listkod:Tstringlist read f_listkod;


  end;
const main_sql='select w.id id_wwater,'+
                      ' su.name_r as street_disc, '+
                      ' w.house as hous_discon, '+
                      ' w.dttm_discon, w.dttm_con, '+
                      ' coalesce(w.comment,'''') dopinf, '+
                      ' z.nomer  nomer1, '+
                      ' (select ADRES from get_adres(z.id_ul1, z.id_ul2,z.kod_ul,z.dop_adr,z.id_dopadres))  adres1, '+
                      ' z.id_rayon id_rayon, '+
                      ' sr.name_r as region, '+
                      ' z.dt_in dt_zav, z.id id_zav,'+
                      ' w.NOMER_DISCON ,'+
                      ' (select trim(kod)  from S_PERERV sper where sper.prev_id=w.fk_discon_perv_id) kodPerv ,'+
                      ' w.addcoments, '+
                      ' (select sr.name_r rev from s_revs sr where sr.id=z.id_revs) rev, '+
                      ' (select ss.name_r from s_tzav ss where ss.id=z.id_tzav) tzav, '+
                      ' (select sd.name_r from s_sod sd where sd.id=z.id_sod) sod, '+
                      ' (select sm.name_r from s_matpipe sm where  sm.id=z.id_matpipe) matpipe,'+
                      ' (select sdi.diam from s_diam sdi where (sdi.id=z.id_diam) ) diam,'+
                      ' (select sme.name_r from s_mest sme where sme.id=z.id_mest ) mest '+
                  ' from wwater w join s_ulic su on su.id=w.id_ul '+
                  '   join zavjav z on z.id=w.id_zav '+
                  '  join s_rayon sr on sr.id=z.id_rayon '+
                 //'  join raskop rr on rr.id_zavin=z.id '+
                  ' where  w.dttm_discon<:dt_end   '+
                  '  and( w.dttm_con>:dt_begin or (w.dttm_con is null)) '+
                  ' and z.id_attach = :attach and (z.delz=0 and z.is_otl=0) ' +
                  '  %s %s %s '+
               ' union '+
               ' select w.id, '+
                      ' su.name_r as street_disc, '+
                      ' w.house as hous_discon, '+
                      ' w.dttm_discon, '+
                      ' w.dttm_con, '+
                      ' w.comment  dopinf, '+
                      ' z.nomer  nomer2, '+
                      ' (select ADRES from get_adres(z.id_ul1, z.id_ul2,z.kod_ul,z.dop_adr,z.id_dopadres) ) adres2, '+
                      ' z.id_rayon, sr.name_r as region, '+
                      ' z.dt_in, z.id ,'+
                      ' w.NOMER_DISCON ,'+
                      ' (select trim(kod) from S_PERERV sper where sper.prev_id=w.fk_discon_perv_id) kodPerv ,'+
                      '  w.addcoments ,' +
                      ' (select sr.name_r rev from s_revs sr where sr.id=z.id_revs) rev, '+
                      ' (select ss.name_r from s_tzav ss where ss.id=z.id_tzav) tzav, '+
                      ' (select sd.name_r from s_sod sd where sd.id=z.id_sod) sod, '+
                      ' (select sm.name_r from s_matpipe sm where  sm.id=z.id_matpipe) matpipe,'+
                      ' (select sdi.diam from s_diam sdi where (sdi.id=z.id_diam) ) diam,'+
                      ' (select sme.name_r from s_mest sme where sme.id=z.id_mest ) mest '+
                  ' from wwater w join s_ulic su on su.id=w.id_ul '+
                  '   join nzavjav z on z.id=w.id_zav'+
                  '   join s_rayon sr on sr.id=z.id_rayon '+
                 // '  join raskop rr on rr.id_zavin=z.id '+
                  ' where  w.dttm_discon<:dt_end   '+
                  '  and( w.dttm_con>:dt_begin or (w.dttm_con is null)) '+
                  ' and z.id_attach = :attach and (z.delz=0 and z.is_otl=0) '+
                  '   %s  %s %s'+
                  '     order by %s ';     //11,12,13

var
  dm_DiskondRep: Tdm_DiskondRep;


implementation

{$R *.dfm}

{ Tdm_DiskondRep }

procedure Tdm_DiskondRep.fillMainrm;

function countdays():real;
var beg_dt, en_dt:TDateTime;
    r:real;
begin
  beg_dt:=dset_main.FieldByName('dttm_discon').AsDateTime;

  if beg_dt<F_dt_begin then
     beg_dt:=F_dt_begin;
  if not dset_main.FieldByName('dttm_con').IsNull then
    if  dset_main.FieldByName('dttm_con').AsDateTime<f_dt_end then
     en_dt:=dset_main.FieldByName('dttm_con').AsDateTime
    else
      en_dt:=f_dt_end
  else
   en_dt:=f_dt_end;
     r:=en_dt-beg_dt;
   result:=r;


end;


function countHoursbetween():real;
var beg_dt, en_dt:TDateTime;
    r:real;
begin

   result:=countdays()*24;
end;

function countMinutesbetween():real;
begin
 result:=countHoursbetween()*60;
end;

function lonminuter:string;
var l:longint;
begin
  l:=floor(countdays()*24);
  l:=l*60;
  result:=FormatFloat('#.##',l);
end;

function addComent():string;
begin
 result:='';
 if not dset_main.FieldByName('rev').IsNull then
  if trim(dset_main.FieldByName('rev').asstring)<>' ' then
  result:=result+trim(dset_main.FieldByName('rev').AsString)+'; ';
 if not dset_main.FieldByName('tzav').IsNull then
  if trim(dset_main.FieldByName('tzav').asstring)<>' ' then
   result:=result+trim(dset_main.FieldByName('tzav').AsString)+'; ';
 if not dset_main.FieldByName('sod').IsNull then
  if trim(dset_main.FieldByName('sod').asstring)<>'<пусто>' then
   result:=result+trim(dset_main.FieldByName('sod').AsString)+'; ';

 if not dset_main.FieldByName('matpipe').IsNull then
  if trim(dset_main.FieldByName('matpipe').asstring)<>' ' then
   result:=result+trim(dset_main.FieldByName('matpipe').AsString)+'; ';
 if not dset_main.FieldByName('diam').IsNull then
   if  dset_main.FieldByName('diam').asinteger>0 then
   result:=result+trim(dset_main.FieldByName('diam').AsString)+'мм; ';
 if not dset_main.FieldByName('mest').IsNull then
    if trim(dset_main.FieldByName('mest').asstring)<>' ' then
   result:=result+trim(dset_main.FieldByName('mest').AsString)+';';


end;

var adres:string;
field:TField;
begin
  rmmain.FieldByName('id').AsInteger:=dset_main.fieldbyname('id_zav').AsInteger;

  rmmain.FieldByName('id_wwater').AsInteger:=dset_main.fieldbyname('id_wwater').AsInteger;
  rmmain.FieldByName('id_rayon').AsInteger:=dset_main.fieldbyname('id_rayon').AsInteger;
  rmmain.FieldByName('region').AsString:=trim(dset_main.fieldbyname('region').AsString);
  if rmmain.FieldByName('id_rayon').AsInteger = -1 then
    rmmain.FieldByName('region').AsString := 'Район не указан';
  adres:=trim(dset_main.fieldbyname('street_disc').AsString)+'.,'+trim(dset_main.fieldbyname('hous_discon').AsString);
  adres:=adres+' '+trim(dset_main.fieldbyname('dopinf').AsString);
  rmmain.FieldByName('coment').AsString:=addComent();//trim(dset_main.fieldbyname('addcoments').AsString);

  rmmain.FieldByName('adress_disc').AsString:=adres;

  rmmain.FieldByName('dt_discon').AsDateTime:=dset_main.fieldbyname('dttm_discon').AsDateTime;
  rmmain.FieldByName('tm_discon').AsDateTime:=dset_main.fieldbyname('dttm_discon').AsDateTime;
  if not dset_main.FieldByName('dttm_con').IsNull then
  begin
      rmmain.FieldByName('dt_con').AsDateTime:=dset_main.fieldbyname('dttm_con').AsDateTime;
      rmmain.FieldByName('tm_con').AsDateTime:=dset_main.fieldbyname('dttm_con').AsDateTime;
  end;
  rmmain.FieldByName('nomer1').AsInteger:=dset_main.fieldbyname('nomer1').AsInteger;
  rmmain.FieldByName('adres1').AsString:=dset_main.fieldbyname('adres1').AsString;
  rmmain.FieldByName('dt_zav').AsString:=formatdatetime('dd.mm.yyyy',dset_main.fieldbyname('dt_zav').AsDateTime);
  rmmain.FieldByName('hours_water').AsFloat:= countHoursbetween();
  rmmain.FieldByName('minute_water').AsFloat:= countMinutesbetween();
  rmmain.FieldByName('dt_in').AsFloat:= countHoursbetween();
  rmmain.fieldbyname('dttm_discon').AsString:='';
  if dset_main.FieldByName('dttm_discon').AsDateTime>0 then
  begin
   rmmain.fieldbyname('dttm_discon').AsString:=formatDateTime('dd.mm.yyyy hh:mm',dset_main.FieldByName('dttm_discon').AsDateTime);
  end;
  rmmain.fieldbyname('dttm_con').AsString:='';
  if dset_main.FieldByName('dttm_con').AsDateTime>0 then
  begin
   rmmain.fieldbyname('dttm_con').AsString:=formatDateTime('dd.mm.yyyy hh:mm',dset_main.FieldByName('dttm_con').AsDateTime);
  end;
  rmmain.FieldByName('kodPerv').AsString:=dset_main.fieldbyname('kodPerv').AsString;


  if rmmain.FindField('kod'+rmmain.FieldByName('kodPerv').AsString)<> nil then
     rmmain.FieldByName('kod'+rmmain.FieldByName('kodPerv').AsString).asstring:='+';
    rmmain.FieldByName('longminute').asstring:= lonminuter();


end;

function Tdm_DiskondRep.Preparedsets: boolean;
var str  :string;
begin
  str:=dateTimeToStr(F_dt_begin);
   str:=dateTimeToStr(F_dt_end);
    str:=str+';';
  result:=false;

  if rmmain.Active then
    rmmain.Close;
  addColumn();
  rmmain.Open;

  try
  if prepareSQL() then
    begin
      dset_main.First;
      while  not dset_main.Eof do
      begin
       rmmain.Append;
       fillMainrm();
       rmmain.Post;
       dset_main.Next;
      end;
     result:=true;
    end
   else
   result:=false;
  except
  result:=false;
  end;

end;

function Tdm_DiskondRep.prepareSQL: boolean;
function prepareRevs():string;
begin
 if  F_RevsID<>'' then
   result:='  and z.id_revs  in '+F_RevsID+' ' 
 else
   result:='';
end;
function prepareStreetDiscon():string;
begin
  if F_streetDisconID<>'' then
   result:=' and  w.id_ul in ('+F_streetDisconID+') '
  else result:='';
end;
function prepareStreetOrder():string;
begin
  if F_streetOrderID<>'' then
   result:=' and z.id_ul1 in ('+F_streetOrderID+') '
  else result:='';
end;
function prepereType():string;
begin
 case F_type of
  0 : result:='';
  1 : result := ' and  DTTM_CON is null ';
  2 :result := ' and  DTTM_CON is not null';
 end;
end;
var revs ,sQL_typ,streetOrders,streetDiscon:string;
begin
try
    revs:= prepareRevs();
    streetOrders:= prepareStreetOrder;
    streetDiscon:=  prepareStreetDiscon;
   sQL_typ:=prepereType();

   if dset_main.Active then
      dset_main.Close;

     dset_main.SelectSQL.Text:=format(main_SQL,[revs + Sql_typ,streetOrders,streetDiscon ,revs + Sql_typ,streetOrders,streetDiscon,'9,4']) ;


    dset_main.ParamByName('dt_begin').asstring:=DateTimeToStr(f_dt_begin);
    dset_main.ParamByName('dt_end').asstring:=DateTimeToStr(f_dt_end);
    dset_main.ParamByName('attach').AsInteger:=ord(F_operAttach);
    result:=true;
    dset_main.Open;
except
   result:=false;
end
end;

procedure Tdm_DiskondRep.DataModuleCreate(Sender: TObject);
begin
  inherited;
f_addkod:=false;
  isadded:=false;
end;

procedure Tdm_DiskondRep.addColumn();
procedure addFieldtoMain(fieldname:string);
var field:tField;
begin
 if rmmain.FindField(fieldname)=nil then
  begin
   field:=tStringField.Create(rmmain);
   field.FieldName:=fieldname;
   field.Name:='rmmain'+fieldname;
   field.DataSet:=rmmain;
   field.Index:=rmmain.Fields.Count;
   field.Size:=2;
   field.FieldKind:=fkData;
   rmmain.Fields.Add(field);
  end;
  field.free;
end;


begin

  if (not isadded) and (f_addkod) then
  begin
  if F_listkod=nil then
  F_listkod:=tStringList.Create;
   if not dset_kod.Active then dset_kod.Open;
   dset_kod.First;
   while not  dset_kod.Eof do
   begin
    //addFieldtoMain('kod'+dset_kod.fieldbyname('kod').AsString);
    F_listkod.Add(dset_kod.fieldbyname('kod').AsString);
    dset_kod.Next;
   end;

  isadded:=true;
  end;
end;

procedure Tdm_DiskondRep.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  if F_listkod<>nil then
   F_listkod.Free;
end;

end.
