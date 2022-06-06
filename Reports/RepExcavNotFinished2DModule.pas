unit RepExcavNotFinished2DModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class, FR_DSet, FR_DBSet,
  IBCustomDataSet, IBDatabase, DB, RxMemDS;
const    ID_WRODZAS=529;
         ID_WORKPLAN=155;
         ID_WORKCHEB=87;
         ID_WORKASF=127;
         DTIMEFORMAT='dd.mm.yyyy hh:mm';
         DATEFORMAT='dd.mm.yyyy';
         RUSSTATE_ASF='Асфальт';
         RUSSTATE_CHEB='Щебень';
         RUSSTATE_PLAN='Планировано';
         RUSSTATE_ZAS='Засыпано';
         RUSSTATE_EXC='Раскопано';
         rusconstants :array [1..5] of string = (RUSSTATE_ASF, RUSSTATE_CHEB,
                                                RUSSTATE_PLAN,RUSSTATE_ZAS,
                                                 RUSSTATE_EXC);

type
  Tdm_RepExcavNotFinished2 = class(Tdm_NGReportBase)
    rm_main: TRxMemoryData;
    rm_mainid_zav: TIntegerField;
    rm_mainid_ras: TIntegerField;
    rm_mainnomer: TIntegerField;
    rm_mainadres: TStringField;
    rm_maindt_out: TStringField;
    rm_maindt_excav: TStringField;
    rm_mainmes: TStringField;
    rm_mainplandateexcav: TStringField;
    rm_maindt_zasexcav: TStringField;
    rm_maindt_planexcav: TStringField;
    rm_maindateorg: TStringField;
    rm_maindt_cheb: TStringField;
    rm_maindt_asf: TStringField;
    rm_maindatecloseddocument: TStringField;
    rm_mainadd_inf: TStringField;
    rm_mainnotfinished: TStringField;
    rm_mainstate: TStringField;
    rm_maintodo: TIntegerField;
    tran: TIBTransaction;
    dset: TIBDataSet;
    dset_revs: TIBDataSet;
    frDBDmain: TfrDBDataSet;
    rm_maindt_zav_in: TStringField;
   private
    { Private declarations }
    f_dtstart, f_dtend:TDateTime;
    F_revs:string;
    f_strstart,f_strEnd:string;
    F_mainSql:string;
    f_strcurdt,f_strcurdate:string;
    f_id_att:integer;
    procedure prepareDates();
    procedure prepareSql(id_rev:integer);
    function getOneRegiom(id_rev:integer):boolean;
    function OpenRegions():boolean;
    function getcurdatetine():boolean;
  public
    { Public declarations }
    function preparedset:boolean;
    property  dtstart:TDateTime read f_dtstart write f_dtstart;
    property dtend:TdateTime read f_dtend write f_dtend;
    property  revs:string read  F_revs write  F_revs;
    property strstart:string read f_strstart;
    property  strEnd:string read f_strEnd;
    property id_att:integer read f_id_att write f_id_att;
    property strcurdt:string read f_strcurdt;
    property strcurdate:string read f_strcurdate;
    procedure sortOn(fields:String);

  end;

const sel_rev = 'select id, name_r from s_revs where id in (%s)';
      sel_allrev='select id, name_r from s_revs where id>0';
      sel_main ='select id_zav ,'+
                ' id_r , nomer , dt_zav_in , '+
                ' adres, '+
                ' dt_zav_out , dt_excav , '+
                ' mes , '+
                ' plandateexcav ,  dt_zasexcav , dt_planexcav , dateorg ,'+
                ' dt_cheb ,        dt_asf ,      datecloseddocument , '+
                ' add_inf  '+
                ' from get_NonFinishedExcav (''%s'', ''%s'', %d,%d,%d,%d,%d,1,%d)'+
                ' where  dt_zasexcav is null and dt_planexcav is null and  dt_cheb is  null and dt_asf is null '+
                ' order by dt_zav_in ';

var
  dm_RepExcavNotFinished2: Tdm_RepExcavNotFinished2;

implementation

{$R *.dfm}
uses HelpFunctions,Math;

function Tdm_RepExcavNotFinished2.getOneRegiom(id_rev:integer):boolean;
 function getstate():string;
 begin
  if   not dset.FieldByName('dt_asf').IsNull then
   result:=rusconstants[1]
  else
   if not dset.FieldByName('dt_cheb').IsNull then
    result:=rusconstants[2]
  else
   if not dset.FieldByName('dt_planexcav').IsNull then
    result:=rusconstants[3]
  else
   if not dset.FieldByName('dt_zasexcav').IsNull then
    result:=rusconstants[4]
   else
     result:=rusconstants[5];

 end;

begin
 result:=false;
 prepareSql(id_rev);
 try
   MyOpenIBDS(dset,F_mainSql);
   dset.First;
   while not dset.Eof do
   begin
     rm_main.Append;

     rm_main.FieldByName('id_zav').AsInteger:=dset.fieldbyname('id_zav').AsInteger;
     rm_main.FieldByName('id_ras').AsInteger:=dset.fieldbyname('id_r').AsInteger;
     rm_main.FieldByName('nomer').AsInteger:=dset.fieldbyname('nomer').AsInteger;
     rm_main.FieldByName('adres').AsString:=trim(dset.fieldbyname('adres').AsString);
     rm_main.FieldByName('dt_zav_in').asstring:=StringFromDateTime(dset.fieldbyname('dt_zav_in').AsDateTime,DTIMEFORMAT);
     rm_main.FieldByName('dt_zav_out').asstring:=StringFromDateTime(dset.fieldbyname('dt_zav_out').AsDateTime,DTIMEFORMAT);
     rm_main.FieldByName('dt_excav').asstring:=StringFromDateTime(dset.fieldbyname('dt_excav').AsDateTime,DTIMEFORMAT);
     rm_main.FieldByName('mes').AsString:=trim(dset.FieldbyName('mes').AsString);
     rm_main.FieldByName('dt_zasexcav').asstring:=StringFromDateTime(dset.fieldbyname('dt_zasexcav').AsDateTime,DTIMEFORMAT);
     if not dset.fieldbyname('datecloseddocument').IsNull then
      if not dset.fieldbyname('plandateexcav').IsNull then
       if dset.fieldbyname('plandateexcav').AsDateTime>0 then
         rm_main.FieldByName('notfinished').AsString:=IntToStr(Floor(dset.fieldbyname('plandateexcav').AsDateTime-Date()));
     {дни если дата снятия ДБГУ есть то разницу межде датой рас и этой датой иначе разницу между тек датой и датой раскопки }
     rm_main.FieldByName('todo').AsInteger:=Floor(Date()-dset.fieldbyname('dt_excav').AsDateTime);
     if not dset.fieldbyname('datecloseddocument').IsNull then
      if dset.fieldbyname('datecloseddocument').AsDateTime>0 then
       rm_main.FieldByName('todo').AsInteger:=Floor(dset.fieldbyname('datecloseddocument').AsDateTime-floor(dset.fieldbyname('dt_excav').AsDateTime));

     rm_main.FieldByName('add_inf').AsString:=ReplaceChar(dset.fieldbyname('add_inf').AsString,'#',#13);
     rm_main.FieldByName('state').AsString:=getstate();
     rm_main.Post;
     dset.Next;
   end;
   result:=true;
 except   on e:exception do
  result:=false;
 end;


end;

procedure Tdm_RepExcavNotFinished2.prepareDates;
begin
 ///f_strstart,f_strEnd:string;
//    f_dtstart, f_dtend:TDateTime;
  f_strstart:=FormatDateTime('dd.mm.yyyy',f_dtstart);
  f_strEnd:=FormatDateTime('dd.mm.yyyy',f_dtend+1);
end;

function Tdm_RepExcavNotFinished2.preparedset: boolean;
begin

  result:=false;
   prepareDates();

  if OpenRegions then
   if getcurdatetine then
  begin
     if rm_main.Active then rm_main.Close;
     rm_main.Open;
     dset_revs.First;
     while not dset_revs.Eof do
     begin
       if not getOneRegiom(dset_revs.fieldbyname('id').AsInteger) then
        begin
         result:=false;
         break;
        end;
       dset_revs.Next;
     end;
     sortOn('dt_zav_in');
     f_strEnd:=FormatDateTime('dd.mm.yyyy',f_dtend);
     result:=true;
  end;

end;

procedure Tdm_RepExcavNotFinished2.prepareSql(id_rev:integer);
begin
 F_mainSql:=format(sel_main,[f_strstart,f_strEnd,id_rev, ID_WRODZAS,
                            ID_WORKPLAN,ID_WORKCHEB,  ID_WORKASF,f_id_att]);

end;


function Tdm_RepExcavNotFinished2.OpenRegions():boolean;
begin
 if dset_revs.Active then dset_revs.Close;
 if F_revs='' then
  dset_revs.SelectSQL.Text:=Format(sel_allrev,[F_revs])
 else
   dset_revs.SelectSQL.Text:=Format(sel_rev,[F_revs]);
 try
   dset_revs.Open;
   result:=true;
  except
   on e:exception do
  begin
    result:=false;

  end;
 end;

end;

function Tdm_RepExcavNotFinished2.getcurdatetine():boolean;
begin
 result:=false;
 try
  MyOpenIBDS(dset,'select current_timestamp ct from rdb$database');
   dset.First;
   f_strcurdate:=StringFromDateTime(dset.fieldbyname('ct').AsDateTime,'dd.mm.yyyy hh:mm');
   f_strcurdt:=StringFromDateTime(dset.fieldbyname('ct').AsDateTime,'dd.mm.yyyy');
   result:=true;
 except
 end;
end;


procedure Tdm_RepExcavNotFinished2.sortOn(fields:String);
begin
 if rm_main.Active then
  rm_main.SortOnFields(fields);
end;


end.
