unit Zav_DMUnit;

interface

uses
  SysUtils, Classes, DB, DBTables,Math,Windows,ServiceFuncUnit,
  Variants,avartype, OperAttFormUnit, IBDatabase, IBCustomDataSet, IBQuery, DMMain;

type
  TDM_Zavv = class(TDataModule)
    Qry_LastViezdCloseDate: TQuery;
    s_matpipe: TQuery;
    DS_zav: TDataSource;
    Qry_zav: TQuery;
    Qry_Zajav: TQuery;
    DS_ul2: TDataSource;
    Qry_ul2: TQuery;
    DS_ul1: TDataSource;
    Qry_ul1: TQuery;
    DS_tzav: TDataSource;
    Qry_tzav: TQuery;
    Qry_tmp2: TQuery;
    Qry_tmp: TQuery;
    DS_sod: TDataSource;
    Qry_sod: TQuery;
    DS_raon: TDataSource;
    Qry_Raon: TQuery;
    DS_place: TDataSource;
    Qry_place: TQuery;
    DS_owner: TDataSource;
    Qry_owner: TQuery;
    DS_mest: TDataSource;
    Qry_mest: TQuery;
    DS_diamZ: TDataSource;
    Qry_diamZ: TQuery;
    DS_Damg: TDataSource;
    Qry_Damg: TQuery;
    DS_comment: TDataSource;
    Qry_comment: TQuery;
    Qry_Brig1: TQuery;
    DS_Brig: TDataSource;
    Qry_Brig: TQuery;
    ds_matpipe: TDataSource;
    Qry_Map: TQuery;
    Qry_sdal: TQuery;
    ds_sdal: TDataSource;
    Qry_poluch: TQuery;
    ds_poluch: TDataSource;
    Qry_revs: TQuery;
    ds_revs: TDataSource;
    qry_vrk: TQuery;
    ds_vrk: TDataSource;
    qry_DopAdres: TQuery;
    ds_DopAdres: TDataSource;
    ds_Object: TDataSource;
    qry_Object: TQuery;
    ds_soorug: TDataSource;
    qry_soorug: TQuery;
    IBQ_tmp: TIBQuery;
    IBTransaction1: TIBTransaction;
    Qry_podpor: TQuery;
    ds_podpor: TDataSource;
    qry_settlers: TQuery;
    ds_settlers: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
    function NNarCount(ZavCode:integer):integer;
    function NZadvCount(alias:string; ZavCode:integer):integer;
    function NZadvWithoutRemontCount(ZavCode: integer): integer;
    function GetMaxDateTimeViezd(id_zav:integer):TDateTime;
    function GetAvrImageCount(id_zav: integer): integer;
    procedure provNewYear;
    procedure SyncDamg;
    procedure ZakrNeispZnach(_ZavCode:integer; var _FltDel:boolean);
    procedure SaveDelZayavStatus(_ZavCode:integer;  _edDopInfText:string; isClosed:boolean; DelStatus:integer);
    function GetZavAttach(id_zav: integer): TOperAtt;
    function NWWATERCount(ZavCode:integer):integer;
    function getidwwater(ZavCode:integer):integer;
    function setwwaterid(ZavCode:integer;Wwaterid:integer; isclosed:boolean):boolean;
    function getadresssent(ZavCode:integer):string;
    function getNumberLinkOrder(ZavCode:integer):string;
    function setFilterStreetByRegion():boolean;
    function ConfirmStreet(name:string):boolean;
    function ConfirmStreet2(name:string):boolean;
  end;

var DM_Zavv:TDM_Zavv;

implementation

uses main;

{$R *.dfm}


procedure TDM_Zavv.SaveDelZayavStatus(_ZavCode:integer; _edDopInfText:string; isClosed:boolean; DelStatus:integer);
var s:string;
begin
  if isClosed then s:='zavjav' else s:='nzavjav';
  MyExecSQL(Qry_Tmp,'UPDATE '+s+' SET delz='+IntToStr(DelStatus)+
  ', DOP_INF="'+SubstKav(_edDopInfText)+'" WHERE (id='+IntToStr(_ZavCode)+')');
  MyExecSQL(Qry_Tmp,'COMMIT');
end;

{Закрыть не используемые значения}
procedure TDM_Zavv.ZakrNeispZnach(_ZavCode:integer; var _FltDel:boolean);
begin
 if not _FltDel
 then begin
    MyOpenSQL(Qry_zajav,'select count(*) C from nzavjav where (delz=0) and id='+IntToStr(_ZavCode));
    Qry_zajav.Open;
    _FltDel:=Qry_zajav.fields[0].AsInteger=1;  // только для незакрытых
    Qry_zajav.Close;
 end else _FltDel:=TRUE;

 if _FltDel and not FormMain.DictNotHide.checked
 then begin
   SetFilterDelete(Qry_raon,true);
   SetFilterDelete(Qry_revs, true);
   SetFilterDelete(Qry_owner,true);
   SetFilterDelete(Qry_Brig,true);
//Nut Anton
   SetFilterDelete(Qry_Brig1,False);
//Nut Anton
   SetFilterDelete(Qry_ul1,true);
   SetFilterDelete(Qry_ul2,true);
   SetFilterDelete(Qry_DopAdres,true);
   SetFilterDelete(Qry_zav,true);
   SetFilterDelete(Qry_comment,true);
   SetFilterDelete(Qry_tzav,true);
   SetFilterDelete(Qry_place,true);
   SetFilterDelete(Qry_damg,true);
   SetFilterDelete(s_matpipe,true);
   SetFilterDelete(Qry_mest,true);
   SetFilterDelete(Qry_sod,true);
   SetFilterDelete(Qry_vrk,true);
   SetFilterDelete(Qry_DiamZ,true);
   SetFilterDelete(Qry_sdal, true);
   SetFilterDelete(Qry_object, true);
   SetFilterDelete(Qry_soorug, true);
   SetFilterDelete(Qry_podpor, true);
   SetFilterDelete(Qry_settlers, true);

 end;
end;

procedure TDM_Zavv.SyncDamg;
var _id:integer;
begin
  inherited;
  with Qry_Damg do
    begin
      Close;
      if Qry_Place.FieldByName('ID').Value=NULL then _id:=0
        else _id:=Qry_Place.FieldByName('ID').AsInteger;
      ParamByName('PLACE_TYPE').AsInteger:=_id;
      Open;
    end;
end;

function TDM_Zavv.NNarCount(ZavCode:integer):integer;
var all_nar,all_nnar:integer;
begin
   if ZavCode>0 then
    begin
     MyOpenSQL(Qry_tmp,'select count(id) mm from nnarad where id_zav='+
                 IntToStr(ZavCode)+' and dt_out is not NULL');
     if Qry_tmp['MM']=NULL then
       all_nar:=0
     else
       all_nar:=Qry_tmp['MM'];

     MyOpenSQL(Qry_tmp,'select count(id) mm from nnarad where id_zav='+
                 IntToStr(ZavCode)+' and dt_out is NULL');
     if Qry_tmp['MM']=NULL then
       all_nnar:=0
     else
       all_nnar:=Qry_tmp['MM'];

     MyOpenSQL(Qry_tmp,'select count(id) mm from narad where id_zav='+IntToStr(ZavCode));
     if Qry_tmp['MM']=NULL then
       Result:=0
     else
       Result:=Qry_tmp['MM'];

     Qry_tmp.Close;

     if (all_nar=0) and (Result=0) and (all_nnar=0) then
       Result:=0
     else if (all_nnar>0) and (Result=0) then
       Result:=-all_nnar
     else if (all_nar>0) and (Result=0)then
       Result:=all_nar;
  end
    else result:=0;
end;

function TDM_Zavv.NZadvCount(alias:string; ZavCode:integer):integer;
begin
   MyOpenSQL(Qry_tmp,'select count(id) mm from '+alias+' where id_zavin='+IntToStr(ZavCode)+
                    ' and id_zavout=0');
     Result:=Qry_tmp.FieldByName('MM').asInteger;
   Qry_tmp.Close;
end;

procedure TDM_Zavv.provNewYear;
var maxZ,maxNZ:TDateTime;
    TekYY,TekMon,TekDay,MaxYY:Word;
begin
   DecodeDate(Now,TekYY,TekMon,TekDay);
//   MyOpenSQL(Qry_tmp,'select max(dt_in) mm from zavjav where dt_in>"'+
//   DateToStr(Now-2)+'"');
   MyOpenSQL(Qry_tmp,'select max(dt_num) mm from zavjav where (delz=0)');
   maxZ:=Qry_tmp.FieldByName('MM').asDateTime;
   MyOpenSQL(Qry_tmp,'select max(dt_num) mm from nzavjav where (delz=0)');
   maxNZ:=Qry_tmp.FieldByName('MM').asDateTime;
   if maxNZ>MaxZ then
      MaxZ:=maxNz;
   Qry_tmp.Close;

   DecodeDate(maxZ,MaxYY,TekMon,TekDay);
   if TekYY>MaxYY then
   begin
     MyExecSQL(Qry_tmp,'set generator genn_nzavjav to 0');
     MyExecSQL(Qry_tmp,'set generator genn_nzavjav_kanal to 0');
   end;
end;

function TDM_Zavv.GetMaxDateTimeViezd(id_zav:integer):TDateTime;
var _dt1,_dt2,_dt3:TDateTime;
begin
  result:=0;
  try
    try
      with Qry_LastViezdCloseDate do
        begin
          Close;
          ParamByName('id_zav').Value:=id_zav;
          Open;
          _dt1:=FieldByName('max_dt_in').AsDateTime;
          _dt2:=FieldByName('max_dt_out').AsDateTime;
          _dt3:=FieldByName('max_dt_dep').AsDateTime;
          result:=max(max(_dt1,_dt2),_dt3);
        end;
    except
      on E:Exception do
        begin
          MessageBox(0,PChar('Ошибка открытия Qry_LastViezdCloseDate:'#13+E.Message),
            'Диспетчер АВР', MB_OK or MB_ICONWARNING);
        end;
    end;
  finally
    Qry_LastViezdCloseDate.Close;
  end;    
end;

function TDM_Zavv.NZadvWithoutRemontCount(ZavCode: integer): integer;
begin
   MyOpenSQL(Qry_tmp,'select count(id) mm from zadv where id_zavin='+IntToStr(ZavCode)+
                    ' and id_zavout=0 and (id_remont=-1 or id_remont is null)');
     Result:=Qry_tmp.FieldByName('MM').asInteger;
   Qry_tmp.Close;
end;

function TDM_Zavv.GetAvrImageCount(id_zav: integer): integer;
begin
  MyOpenSQL(Qry_tmp, 'select count(*) mm from avr_image where id_zav='+IntToStr(id_zav));
  Result:=Qry_tmp.FieldByName('mm').AsInteger;
  Qry_tmp.Close;
end;

function TDM_Zavv.GetZavAttach(id_zav: integer): TOperAtt;
begin
  Result:=toaVoda;

  MyOpenSQL(Qry_tmp, 'select id_attach from nzavjav where id='+IntToStr(id_zav));
  if Qry_tmp.Eof then
  begin
    MyOpenSQL(Qry_tmp, 'select id_attach from zavjav where id='+IntToStr(id_zav));
    if not Qry_tmp.Eof then
      Result:=TOperAtt(Qry_tmp.FieldByName('id_attach').AsInteger);
  end else
  begin
    Result:=TOperAtt(Qry_tmp.FieldByName('id_attach').AsInteger);
  end;
end;

function TDM_Zavv.NWWATERCount(ZavCode:integer):integer;
begin
   MyOpenSQL(Qry_tmp,'select count(id) mm from WWATER where ID_ZAV='+IntToStr(ZavCode)+
                    ' and DTTM_CON is null');
     Result:=Qry_tmp.FieldByName('MM').asInteger;
   Qry_tmp.Close;
end;




function TDM_Zavv.getidwwater(ZavCode: integer): integer;
begin
  MyOpenSQL(Qry_tmp,'select z.fk_wwater w1 from zavjav  z  where z.ID='+IntToStr(ZavCode));

  if   Qry_tmp.FieldByName('w1').IsNull then begin
    MyOpenSQL(Qry_tmp,'select z.fk_wwater w1 from nzavjav  z  where z.ID='+IntToStr(ZavCode));
    Result:=Qry_tmp.FieldByName('w1').asInteger
    end
  else
   Result:=Qry_tmp.FieldByName('w1').asInteger;
   Qry_tmp.Close;
end;

function TDM_Zavv.setwwaterid(ZavCode: integer;Wwaterid:integer;
  isclosed: boolean): boolean;
var s:string;
begin
result:=false;
if isclosed then
  s:='zavjav'
else
  s:='nzavjav';
    MyExecSQL(Qry_Tmp,'UPDATE '+s+' SET fk_wwater='+IntToStr(Wwaterid)+
  ' WHERE (id='+IntToStr(ZavCode)+')');

  MyExecSQL(Qry_Tmp,'COMMIT');
result:=true;
end;

function TDM_Zavv.getadresssent(ZavCode: integer): string;
begin
   MyOpenSQL(Qry_tmp,'select adres from  GET_ZAV_ADRES_sent('+IntToStr(ZavCode)+')');
   result:=Qry_tmp.fieldbyname('adres').AsString;
end;

function TDM_Zavv.getNumberLinkOrder(ZavCode:integer):string;
begin
 result:='';
   MyOpenSQL(Qry_tmp,' select z.nomer from nzavjav z join LINKOTLORDER li on li.ID_OTLZAVJAV=z.id ' +
                    ' where li.isactual  is not null and li.ID_ZAVJAV='+intToStr(zavCode));
   if  Qry_tmp.fieldbyname('nomer').IsNull then
       MyOpenSQL(Qry_tmp,' select z.nomer from zavjav z join LINKOTLORDER li on li.ID_OTLZAVJAV=z.id where li.isactual  is not null'+
        ' and li.ID_ZAVJAV='+intToStr(zavCode));
   result:=Qry_tmp.fieldbyname('nomer').AsString;

end;

function TDM_Zavv.setFilterStreetByRegion():boolean;
var id_region:integer;
begin
result:=false;
if Qry_Raon.Active then
begin
  id_region:=Qry_Raon.FieldByName('id').AsInteger;
  try
  if id_region>0 then
  begin
   qry_ul2.Filter:='ID_RAYON='+intToStr(id_region)+' or id=-1';
   qry_ul2.Filtered:=true;
   if  not qry_ul2.Active then
    qry_ul2.Open;
   qry_ul1.Filter:='ID_RAYON='+intToStr(id_region)+' or id=-1';
   qry_ul1.Filtered:=true;
   if  not qry_ul1.Active then
    qry_ul1.Open;
   result:=true;
  end
  else
  begin
    result:=true;
    qry_ul1.Filter:=' id=-1';
    qry_ul2.Filter:=' id=-1';
    qry_ul1.Filtered:=true;
    qry_ul2.Filtered:=true;
    qry_ul2.Close;
  end;
  except on e:exception  do
   result:=false;
  end;
end;


end;

function TDM_Zavv.ConfirmStreet(name:string):boolean;
var id_region:integer;
begin
 result:=false;
if Qry_Raon.Active then
begin
   id_region:=Qry_Raon.FieldByName('id').AsInteger;
   result:=Qry_ul1.Locate('name_r',name,[]);

 result:=(Qry_ul1.FieldByName('ID_RAYON').AsInteger= id_region);
 if not result then
   Qry_ul1.first;
end;
end;

function TDM_Zavv.ConfirmStreet2(name:string):boolean;
begin
   result:=Qry_ul2.Locate('name_r',VarArrayOf([name]),[loCaseInsensitive]);
end;

initialization
  DM_Zavv:=nil;
end.
