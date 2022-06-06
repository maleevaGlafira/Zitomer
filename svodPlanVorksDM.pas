unit svodPlanVorksDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class, DMmain, DB, RxMemDS, FR_DSet,
  FR_DBSet, IBCustomDataSet, IBDatabase;

type
  Tdm_SvodPlanWorks = class(Tdm_NGReportBase)
    rm_result: TRxMemoryData;
    dset: TIBDataSet;
    frDBDataSet1: TfrDBDataSet;
    dset_works: TIBDataSet;
    dset_obor: TIBDataSet;
    rm_resultid_attach: TIntegerField;
    rm_resultid_revs: TIntegerField;
    rm_resultattach: TStringField;
    rm_resultrev: TStringField;
    rm_resultnomer: TIntegerField;
    rm_resultbrig: TStringField;
    rm_resultdt_dep: TStringField;
    rm_resultdt_out: TStringField;
    rm_resultplanobors: TStringField;
    rm_resultadres: TStringField;
    rm_resultmest: TStringField;
    rm_resultworks_plan: TStringField;
    rm_resultaddition: TStringField;
    rm_resultid: TIntegerField;
    IBTransaction1: TIBTransaction;
    rm_resultNUMBERT: TIntegerField;
  private
    { Private declarations }
    F_DT:TDateTime;
    F_Attaches:string;
    F_revs:string;
    F_otl:boolean;
   function prepareMainSql():string;
   function addOtl():string;
  public
    { Public declarations }
    property DT:TDateTime write F_DT ;
    property Attaches:string write F_Attaches ;
    property revs:string write  F_revs ;
    function prepareDsets():boolean;
    property otl:boolean read F_otl write f_otl;


  end;

const mainSQL='select  z.id_attach, '+
              ' z.id, n.id nar_id, z.id_revs, ssr.name_r rev,z.nomer, n.id_brig, sb.name_r brig,  n.dt_dep,n.dt_out,z.id_mest, sp.name_r mest, '+
              ' (select adres from get_adres(z.id_ul1,z.id_ul2,z.kod_ul,z.dop_adr,z.id_dopadres)) adres ,'+
              ' n.numteam NUMBERT '+
              ' from  narad n '+
              ' join zavjav z on z.id= n.id_zav '+
              ' left join s_brig sb on sb.id=n.id_brig '+
              ' join s_mest sp on sp.id= z.id_mest '+
              ' join s_revs ssr on ssr.id=z.id_revs '+
              ' where (z.delz = 0 %s) and n.dt_dep>:dt and n.dt_dep<:dt+1 '+
               ' %s %s '+
              ' union '+
              ' select  z.id_attach, '+
              ' z.id, n.id nar_id, z.id_revs, ssr.name_r rev, z.nomer, n.id_brig, sb.name_r brig,  n.dt_dep, n.dt_out,z.id_mest, sp.name_r mest, '+
              ' (select adres from get_adres(z.id_ul1,z.id_ul2,z.kod_ul,z.dop_adr,z.id_dopadres)) adres,'+
              '   n.numteam NUMBERT' +
              ' from  nnarad n '+
              ' join nzavjav z on z.id= n.id_zav '+
              ' left join s_brig sb on sb.id=n.id_brig '+
              ' join s_mest sp on sp.id= z.id_mest '+
              ' join s_revs ssr on ssr.id=z.id_revs '+
              ' where (z.delz = 0 %s) and  n.dt_dep>:dt and n.dt_dep<:dt+1 '+
              ' %s %s '+
              ' order by  1,4 ';

var
  dm_SvodPlanWorks: Tdm_SvodPlanWorks;

implementation

{$R *.dfm}

function Tdm_SvodPlanWorks.addOtl: string;
begin
if not F_otl then
 result:=' and (z.is_otl<>1 or z.is_otl is  null )'
 else
 result:='';
end;

function Tdm_SvodPlanWorks.prepareDsets:boolean;
 var works_plan, planobors:String;
 function setAttach(id_attach:integer):String;
 begin
   result:='';
   case id_attach of

      1: result := 'ВОДОПРОВОД';
      2: result := ' КАНАЛИЗАЦИЯ ';

      4: result := ' ОБЪЕКТЫ ВОДОПРОВОДА';
      5: result := ' ОБЪЕКТЫ КАНАЛИЗАЦИИ';
   end;

 end;




 function prepareList(dset_works:TIBDataSet;id_nar:integer):string;
 begin
 result:='';
  if  dset_works.Active then dset_works.Close;
  dset_works.ParamByName('id').AsInteger:=id_nar;
  dset_works.Open;
  dset_works.First;

  while not dset_works.Eof do
  begin
   result:=result+';'+#13+trim(dset_works.fieldbyname('name_r').AsString);
   dset_works.Next;
  end;
  if result<>'' then
   delete(result,1,2);

 end;

 function prepareRow():boolean;
 var i:integer;
 begin
  i:=0;
  while dset.FindField(rm_result.Fields[i].FieldName)<>nil do
  begin
    rm_result.Fields[i].AsString:='';
    if dset.FieldByName(rm_result.Fields[i].FieldName).DataType = ftDateTime then
       if not dset.FieldByName(rm_result.Fields[i].FieldName).IsNull then
         rm_result.Fields[i].AsString:=dateTimeToStr(dset.FieldByName(rm_result.Fields[i].FieldName).AsDateTime)
       else
         rm_result.Fields[i].AsString:=''
    else
      if not dset.FieldByName(rm_result.Fields[i].FieldName).IsNull then
       if trim(dset.FieldByName(rm_result.Fields[i].FieldName).AsString)<>'<пусто>' then
          rm_result.Fields[i].AsString:=trim(dset.FieldByName(rm_result.Fields[i].FieldName).AsString);
    i:=i+1;
  end;
  rm_result.FieldByName('attach').AsString:=setAttach(rm_result.FieldByName('id_attach').AsInteger);
  rm_result.FieldByName('NUMBERT').AsInteger:=dset.fieldbyname('NUMBERT').AsInteger;
  rm_result.FieldByName('works_plan').AsString:=works_plan;
  rm_result.FieldByName('planobors').AsString:=planobors;


  result:=true;

 end;


begin
result:=false;
try
  if rm_result.Active then rm_result.Close;
  rm_result.Open;
  if dset.Active then
    dset.Close;
  dset.SelectSQL.Text:=prepareMainSql();
  dset.ParamByName('dt').AsDateTime:=F_DT;
  dset.Open;
  dset.First;

  while  not dset.Eof do begin
     works_plan:=prepareList(dset_works,dset.fieldbyname('nar_id').AsInteger); //сначала выясним есть ли планируемые работы или обурудование а поом добавим в сводку
     planobors:=prepareList(dset_obor,dset.fieldbyname('nar_id').AsInteger);
     if (trim(works_plan)<>'' )or (trim(planobors)<>'') then
     begin
       rm_result.Append;
       prepareRow();
       rm_result.Post;
     end;
    dset.Next;
  end;
  result:=true;

except on e:exception do
begin
  result:=false;
end;
END;

end;





function Tdm_SvodPlanWorks.prepareMainSql:string;
var rev,attach:string;
begin
result:='';
if F_revs<>'' then
 rev:='and z.id_revs in '+F_revs
else
 rev :='';
if F_Attaches<>'' then
  attach:=' and z.id_attach in '+F_Attaches
else
  attach:='';
result:=format(mainSQL,[addOtl(),rev, attach,addOtl(), rev,attach]);

end;

end.

