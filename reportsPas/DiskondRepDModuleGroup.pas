unit DiskondRepDModuleGroup;

interface

uses
 Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class,DMmain, FR_DSet, FR_DBSet, DB,
  RxMemDS, IBCustomDataSet, IBDatabase,OperAttFormUnit,Math;

type
  Tdm_DiskondRepGroup = class(Tdm_NGReportBase)
    rmmain: TRxMemoryData;
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
    rmmainkodPerv: TStringField;
    rmmainkod06: TStringField;
    rmmainkod07: TStringField;
    rmmainkod08: TStringField;
    rmmainkod09: TStringField;
    rmmainkod10: TStringField;
    rmmainlongminute: TStringField;
    rmmainNOMER_DISCON: TIntegerField;
    dset_main: TIBDataSet;
    dset_kod: TIBDataSet;
    frDBDataSet1: TfrDBDataSet;
    tran: TIBTransaction;
    rmmainrevs: TStringField;
    rmmainsetlers: TStringField;
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
    f_days:integer;
    F_maxmin:integer;
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
    property TypeDiscon :integer write F_type;// 2 - закрытые 1 - незакрытые  0 - все
    property addkod: boolean write f_addkod;
    property listkod:Tstringlist read f_listkod;
    property days:integer write f_days;
    property maxmin:integer write F_maxmin;
  end;
const main_sql='select r.id_z id_zav , r.dt_z dt_zav,'+
               '  r.adres_z adres1, r.nomer_discon NOMER_DISCON,'+
               ' r.rayon region, r.revs, r.setlers, r.nomer_zav nomer1, ' +
               ' r.list_adres, r.kod kodPerv, '+
               ' r.dt_discon dttm_discon,  r.dt_con dttm_con ,'+
               ' r.tzav, r.sod, r.diam, r.matpipe, r.mest ' +
               ' from rep_discon13Group(:dt_begin, :dt_end,:attach) r    '+
              ' where 1=1 %s '+
                  '     order by 3,2 ';

var
  dm_DiskondRepGroup: Tdm_DiskondRepGroup;

implementation

{$R *.dfm}
uses HelpFunctions;

procedure Tdm_DiskondRepGroup.fillMainrm;

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
var l:real;
begin
  {l:=(countdays()*24);
  l:=l*60;}
  l:= countMinutesbetween();
  result:=FormatFloat('#.##',l);
end;


function addComent():string;
begin
 result:='';
 if not dset_main.FieldByName('revs').IsNull then
  if dset_main.FieldByName('revs').asstring<>'' then
  result:=result+trim(dset_main.FieldByName('revs').AsString)+'; '+#13;
 if not dset_main.FieldByName('tzav').IsNull then
  if dset_main.FieldByName('tzav').asstring<>'' then
   result:=result+trim(dset_main.FieldByName('tzav').AsString)+'; '+#13;
 if not dset_main.FieldByName('sod').IsNull then
  if dset_main.FieldByName('sod').asstring<>'<пусто>' then
   result:=result+trim(dset_main.FieldByName('sod').AsString)+'; ';

 if not dset_main.FieldByName('matpipe').IsNull then
  if trim(dset_main.FieldByName('matpipe').asstring)<>'' then
   result:=result+trim(dset_main.FieldByName('matpipe').AsString)+'; '+#13;
 if not dset_main.FieldByName('diam').IsNull then
   if  dset_main.FieldByName('diam').asinteger>0 then
   result:=result+trim(dset_main.FieldByName('diam').AsString)+'мм; '+#13;
 if not dset_main.FieldByName('mest').IsNull then
    if dset_main.FieldByName('mest').asstring<>'' then
   result:=result+trim(dset_main.FieldByName('mest').AsString)+';';


end;

var adres:string;
field:TField;
shortkod:string;
begin
  rmmain.FieldByName('id').AsInteger:=dset_main.fieldbyname('id_zav').AsInteger;
  rmmain.FieldByName('nomer1').AsInteger:=dset_main.fieldbyname('nomer1').AsInteger;
  rmmain.FieldByName('region').AsString:=dset_main.fieldbyname('region').AsString;
  rmmain.FieldByName('revs').AsString:=dset_main.fieldbyname('revs').AsString;
  rmmain.FieldByName('setlers').AsString:=dset_main.fieldbyname('setlers').AsString;


 // rmmain.FieldByName('id_wwater').AsInteger:=dset_main.fieldbyname('id_wwater').AsInteger;


  rmmain.FieldByName('adress_disc').AsString:=ReplaceChar(dset_main.fieldbyname('list_adres').AsString, '#', #13);

  rmmain.FieldByName('dt_discon').AsDateTime:=dset_main.fieldbyname('dttm_discon').AsDateTime;
  rmmain.FieldByName('tm_discon').AsDateTime:=dset_main.fieldbyname('dttm_discon').AsDateTime;
  if not dset_main.FieldByName('dttm_con').IsNull then
  begin
      rmmain.FieldByName('dt_con').AsDateTime:=dset_main.fieldbyname('dttm_con').AsDateTime;
      rmmain.FieldByName('tm_con').AsDateTime:=dset_main.fieldbyname('dttm_con').AsDateTime;
  end;

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

  shortkod:=copy(rmmain.FieldByName('kodPerv').AsString,1,2);
  if rmmain.FindField('kod'+shortkod)<> nil then
     rmmain.FieldByName('kod'+shortkod).asstring:='+';
  if not dset_main.fieldbyname('NOMER_DISCON').IsNull then
   rmmain.FieldByName('NOMER_DISCON').AsInteger:=dset_main.fieldbyname('NOMER_DISCON').AsInteger;
  rmmain.FieldByName('longminute').asstring:= lonminuter();
  rmmain.FieldByName('coment').AsString:=addComent();

end;

function Tdm_DiskondRepGroup.Preparedsets: boolean;
var str  :string;
id :integer;
nomer:integer;
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

function Tdm_DiskondRepGroup.prepareSQL: boolean;
function prepareRevs():string;
begin
 if  F_RevsID<>'' then
   result:='  and id_revs  in '+F_RevsID+' '
 else
   result:='';
end;
function prepereType():string;
begin
 case F_type of
  0 : result:='';
  1 : result := ' and  dt_con is null ';
  2 :result := ' and  dt_con is not null';
 end;
end;

function preparedays():string;
begin
result:='';
 if f_maxmin>0 then
 begin
  if F_maxmin=1 then
   result:=Format('and r.dt_con-r.dt_discon<%d',[f_days]);
  if F_maxmin=2 then
    result:=Format('and r.dt_con-r.dt_discon>%d',[f_days])
 end
end;

var revs ,sQL_typ:string;
begin
try
    revs:= prepareRevs();
   sQL_typ:=prepereType();

   if dset_main.Active then
      dset_main.Close;

     dset_main.SelectSQL.Text:=format(main_SQL,[revs + Sql_typ+preparedays() ,revs + Sql_typ+preparedays(),'9,4']) ;


    dset_main.ParamByName('dt_begin').asstring:=DateTimeToStr(f_dt_begin);
    dset_main.ParamByName('dt_end').asstring:=DateTimeToStr(f_dt_end);
    dset_main.ParamByName('attach').AsInteger:=ord(F_operAttach);
    result:=true;
    dset_main.Open;
except
   result:=false;
end
end;



procedure Tdm_DiskondRepGroup.addColumn();
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




procedure Tdm_DiskondRepGroup.DataModuleCreate(Sender: TObject);
begin
  inherited;
  f_addkod:=false;
  isadded:=false;

end;

procedure Tdm_DiskondRepGroup.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  if F_listkod<>nil then
   F_listkod.Free;

end;

end.
