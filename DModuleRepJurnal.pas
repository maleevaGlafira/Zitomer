unit DModuleRepJurnal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class, DB, RxMemDS, IBCustomDataSet,
  FR_DSet, FR_DBSet,OperAttFormUnit, IBDatabase,DMmain;

type
  Tdm_RepJurnal = class(Tdm_NGReportBase)
    dset: TIBDataSet;
    dset_mech: TIBDataSet;
    rm_execute: TRxMemoryData;
    rm_executeid_zav: TIntegerField;
    rm_executeid_nar: TIntegerField;
    rm_executenumber: TIntegerField;
    rm_executedateOpen: TDateTimeField;
    rm_executedt_in: TDateTimeField;
    rm_executedt_out: TDateTimeField;
    rm_executediam: TIntegerField;
    rm_executenameBrig: TStringField;
    rm_executedolgBrig: TStringField;
    rm_executemechanism: TStringField;
    rm_executenote: TStringField;
    rm_executedateclosed: TDateTimeField;
    rm_executenomer_dateOpen: TStringField;
    rm_executedateExecute: TStringField;
    rm_executeBrig: TStringField;
    rm_accept: TRxMemoryData;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    IntegerField3: TIntegerField;
    DateTimeField1: TDateTimeField;
    DateTimeField2: TDateTimeField;
    DateTimeField3: TDateTimeField;
    IntegerField4: TIntegerField;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    StringField4: TStringField;
    DateTimeField4: TDateTimeField;
    StringField5: TStringField;
    StringField6: TStringField;
    StringField7: TStringField;
    rm_finished: TRxMemoryData;
    IntegerField5: TIntegerField;
    IntegerField6: TIntegerField;
    IntegerField7: TIntegerField;
    DateTimeField5: TDateTimeField;
    DateTimeField6: TDateTimeField;
    DateTimeField7: TDateTimeField;
    IntegerField8: TIntegerField;
    StringField8: TStringField;
    StringField9: TStringField;
    StringField10: TStringField;
    StringField11: TStringField;
    DateTimeField8: TDateTimeField;
    StringField12: TStringField;
    StringField13: TStringField;
    StringField14: TStringField;
    rm_executedateClosedString: TStringField;
    frDBDataSet1: TfrDBDataSet;
    frDBDataSet2: TfrDBDataSet;
    frDBDataSet3: TfrDBDataSet;
    rm_executeadress: TStringField;
    rm_acceptadress: TStringField;
    rm_finishedadress: TStringField;
    rm_finisheddateClosedString: TStringField;
    rm_acceptdateClosedString: TStringField;
    IBTransaction1: TIBTransaction;
  private
    { Private declarations }
    F_idRev:integer;
    f_idrevs:string;
    F_dat:tDateTime;
    F_isOtl:boolean;

    f_aliens:string;
    f_attach:integer;
    sql:string;
    StrAttach,strrev,strArachRev:string;
    procedure setExecute(FeildsSQL:string;order:string;addtable:boolean);
    procedure setAccept(FeildsSQL:string;order:string;addtable:boolean);
    procedure setFinished(FeildsSQL:string;order:string;addtable:boolean);
    function setCondTime(formatString:string):string;
    procedure preparedate();
    procedure setAttachREv();
    procedure FielData(rmem:TRxMemoryData );
    function getMech():string;
  public
    { Public declarations }
    property  idrevs:string write f_idrevs;
    property idRev:integer write F_idRev;
    property dat:tDateTime write F_dat;
    property isOtl:boolean write F_isOtl;
    property attach:integer write F_attach;

    function count():integer;
    function prepareDsets():boolean;
    property aliens: string write f_aliens;
  end;

const sel_fields_sql= 'select z.id id_zav, n.id id_nar, '+
                 ' (select adres from get_zav_adres(z.id)) adres,'+ //*Адрес*/
                 ' z.id_revs id_rev, '+
                 ' z.nomer,  '+///*Номер*/
                 ' z.dt_in dateOpen, '+  //*дата откр.*/
                 '  n.dt_in,n.dt_out, '+//*Выполнение*/
                 ' (select  sd.diam from  s_diam sd where sd.id=z.id_diam) diam, '+ //*diametr*/
                 '  sb.name_r nameBrig, sb.dolgn dolgBrig,  '+//*responsible for the work*/
                 '   n.dop_inf note, '+ //*note*/
                 '  z.dt_out dateclosed, '+ //*dateclosed*/
                 '  ''%s'' tablename, '+
                 ' z.id_alien,  (select name_r from s_revs ssr where ssr.id=z.id_revs) name_rev '+
                 ' from %s z join %s n on n.id_zav=z.id '+
                 ' join s_brig SB ON SB.id=N.id_brig  '+
                 ' where ';
cons_maxNar = 'and n.id=(select max(nnn.id) from %s nnn where z.id=nnn.id_zav)';
sel_mech = 'select    rtrim(so.name_r)||'' ''||rtrim(so.fio)  name_r  '+
           ' from obors ob,s_obor so where ob.id_nar=:id_nar  and so.id=ob.id_obor';

order = ' order by 4,3';
cond_alien= 'and id_alien in (%s)';
var
  dm_RepJurnal: Tdm_RepJurnal;

implementation

{$R *.dfm}
uses Math,ShiftDmodule,HelpFunctions;

function Tdm_RepJurnal.count():integer;
begin
 result:=0;
end;

function Tdm_RepJurnal.prepareDsets():boolean;
begin
 result:=false;
 setAttachREv();
 preparedate();

 try
   setExecute(sel_fields_sql,order,true);
   FielData(rm_execute);
   setaccept(sel_fields_sql,order,true);
   FielData(rm_accept);
   setFinished(sel_fields_sql,order,true);
   FielData(rm_finished);
   result:=true;
 except on e:exception do
  result:=false;
 end;
end;

procedure Tdm_RepJurnal.preparedate();
begin
 f_dat:=floor(F_dat)+StrToDateTime(StrShiftTimeBegin);
end;


function Tdm_RepJurnal.setCondTime(formatString:string):string;

begin
 result:=format(formatString,[FormatDateTime('dd.mm.yyyy hh:mm',F_dat),
                                     FormatDateTime('dd.mm.yyyy hh:mm',F_dat+1)]);
 if strArachRev<>'' then result:=strArachRev+' and ' +result;
end;

procedure Tdm_RepJurnal.setAttachREv();
var strisOrl:string;
begin
 if not f_isOtl then
  strisOrl :=' (is_otl<>1 or is_otl is null ) and'
 else
  strisOrl:='';
 case f_attach of
  1:StrAttach:=' (z.id_attach in (1,3,4))';
  2:StrAttach:=' (z.id_attach in (2,5))';
  end;
  StrAttach:=strisOrl+StrAttach;
  if f_idREvs<>'' then
   strrev:=Format('id_revs in (%s) ',[f_idrevs])
  else
    strrev:='';
  if (strAttach<>'') and  (strrev<>'') then
    strArachRev:= strAttach+ ' and '+ strrev
   else  if (strAttach<>'') then
           strArachRev:= strAttach
         else if strrev<>'' then
           strArachRev:= strAttach;
end;

procedure Tdm_RepJurnal.setExecute(FeildsSQL:string;order:string;addtable:boolean);
var
     sCond:string;
begin

  sCond:=setCondTime('(n.dt_out>=''%s'' and n.dt_out<''%s'')');
  if f_aliens<>'' then
    sCond:=sCond+ format(cond_alien,[f_aliens]);
  if addtable then
  sql:=format(FeildsSql +sCond ,['nz','nzavjav','nnarad'])+' union '+

        format(FeildsSql +sCond ,['z','zavjav','narad'])+order
  else
    sql:=format(FeildsSql +sCond ,['nzavjav','nnarad'])+' union '+
        format(FeildsSql +sCond ,['zavjav','narad']);

end;


procedure Tdm_RepJurnal.setaccept(FeildsSQL:string;order:string;addtable:boolean);
var
     sCond:string;
begin

  sCond:=setCondTime('(z.dt_in>=''%s'' and n.dt_in<''%s'')');
   if f_aliens<>'' then
    sCond:=sCond+ format(cond_alien,[f_aliens]);

  if addtable then
    sql:=format(FeildsSql +sCond+cons_maxNar ,['nz','nzavjav','nnarad','nnarad'])+
       'union '+
        format(FeildsSQL +sCond+cons_maxNar ,['z','zavjav','narad','narad'])+order
  else
  sql:=format(FeildsSql +sCond+cons_maxNar ,['nzavjav','nnarad','nnarad'])+' union '+
        format(FeildsSQL +sCond+cons_maxNar ,['zavjav','narad','narad']);
end;

procedure Tdm_RepJurnal.setFinished(FeildsSQL:string;order:string;addtable:boolean);
var
     snCond,sCond:string;
begin

 snCond:=Format('z.dt_in<''%s'' ',[FormatDateTime('dd.mm.yyyy hh:mm',F_dat+1)]);
  sCond:=Format('z.dt_in<''%s'' and (z.dt_out>''%s'' or z.dt_out is null  )',
                [FormatDateTime('dd.mm.yyyy hh:mm',F_dat+1),

                FormatDateTime('dd.mm.yyyy hh:mm',F_dat+1)]);
  sCond:=sCond+ ' and '+strArachRev;
  snCond:=snCond+ ' and '+strArachRev;
   if f_aliens<>'' then
   begin
    sCond:=sCond+ format(cond_alien,[f_aliens]);
    snCond:=snCond + format(cond_alien,[f_aliens]);
   end;

  if addtable then
   sql:=format(FeildsSql +snCond+cons_maxNar ,['nz','nzavjav','nnarad','nnarad'])+' union '+
        format(FeildsSql +sCond+cons_maxNar ,['z','zavjav','narad','narad'])+order
  else
  sql:=format(FeildsSql +snCond+cons_maxNar ,['nzavjav','nnarad','nnarad'])+' union '+
        format(FeildsSql +sCond+cons_maxNar ,['zavjav','narad','narad']);

end;

function Tdm_RepJurnal.getMech():string;
begin
 result:='';
 dset_mech.ParamByName('id_nar').AsInteger:=dset.fieldbyname('id_nar').AsInteger;
 dset_mech.Open;
 dset_mech.First;
 while not  dset_mech.Eof do
 begin
  result:=result+'; '+dset_mech.fieldbyname('name_r').AsString;
  dset_mech.Next;
 end;
 if result<>'' then
  delete(result,1,2);
 dset_mech.Close;
end;

procedure Tdm_RepJurnal.FielData(rmem:TRxMemoryData );
begin
 if rmem.Active then
  begin
   rmem.EmptyTable;
   rmem.Close;
  end;
  rmem.Open;
  MyOpenIbDS(dset,sql);
  dset.First;
  while not  dset.Eof do
  begin
    rmem.Append;

    rmem.FieldByName('id_zav').AsInteger:=dset.fieldbyname('id_zav').AsInteger;
    rmem.FieldByName('id_nar').AsInteger:=dset.fieldbyname('id_nar').AsInteger;
    rmem.FieldByName('adress').AsString:=dset.fieldbyname('adres').AsString;

    rmem.FieldByName('number').AsInteger:=dset.fieldbyname('nomer').AsInteger;
    rmem.FieldByName('dateOpen').AsDateTime:=dset.fieldbyname('dateOpen').AsDateTime;
    rmem.FieldByName('dt_in').AsDateTime:=dset.fieldbyname('dt_in').AsDateTime;
    rmem.FieldByName('dt_out').AsDateTime:=dset.fieldbyname('dt_out').AsDateTime;
    rmem.FieldByName('diam').AsInteger:=dset.fieldbyname('diam').AsInteger;
    rmem.FieldByName('nameBrig').asString:=dset.fieldbyname('nameBrig').asString;
    rmem.FieldByName('dolgBrig').asString:=dset.fieldbyname('dolgBrig').asString;
    rmem.FieldByName('note').asString:=dset.fieldbyname('note').asString;
    rmem.FieldByName('dateClosed').AsDateTime:=dset.fieldbyname('dateClosed').asdateTime;
     if dset.FieldByName('tablename').Asstring='nz' then
      rmem.FieldByName('dateClosedString').AsString:=  ''
    else
      rmem.FieldByName('dateClosedString').asstring:=FormatDatetime('dd.mm.yyyy hh:mm',rmem.FieldByName('dateClosed').AsDateTime);
    rmem.FieldByName('nomer_dateOpen').AsString:=rmem.FieldByName('number').AsString+#13 +
                                            formatdateTime('dd.mm.yyyy hh:mm',dset.fieldbyname('dateOpen').AsDateTime);
    rmem.FieldByName('Brig').AsString:=rmem.FieldByName('nameBrig').asString+' ' +dset.fieldbyname('dolgBrig').asString;

    if rmem.FieldByName('dt_out').AsDateTime>0 then
      rmem.FieldByName('dateExecute').AsString:=formatdateTime('dd.mm.yyyy hh:mm',dset.fieldbyname('dt_in').AsDateTime)+'-'+#13+
                                                formatdateTime('dd.mm.yyyy hh:mm',dset.fieldbyname('dt_out').AsDateTime)
    else
     rmem.FieldByName('dateExecute').AsString:=formatdateTime('dd.mm.yyyy hh:mm',dset.fieldbyname('dt_in').AsDateTime)+'-';
    rmem.FieldByName('name_rev').AsString:=dset.fieldbyname('name_rev').AsString;
    rmem.FieldByName('id_rev').AsInteger:=dset.fieldbyname('id_rev').AsInteger;
    rmem.FieldByName('mechanism').AsString:=getMech();
    rmem.Post;
    dset.Next;
  end;
end;



end.
