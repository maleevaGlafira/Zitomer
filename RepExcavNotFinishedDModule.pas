unit RepExcavNotFinished2DModule;
{дни если дата снятия ДБГУ есть то разницу межде датой рас и этой датой иначе разницу между тек датой и датой раскопки }
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class,DmMain, DB, IBCustomDataSet,
  IBDatabase, RxMemDS, FR_DSet, FR_DBSet;
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
  Tdm_RepExcavNotFinished = class(Tdm_NGReportBase)
    rm_main: TRxMemoryData;
    tran: TIBTransaction;
    dset: TIBDataSet;
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
    dset_revs: TIBDataSet;
    rm_mainnotfinished: TStringField;
    frDBDmain: TfrDBDataSet;
    rm_maindt_zav_in: TDateTimeField;
    rm_mainstate: TStringField;
    rm_maintodo: TIntegerField;
  private
    { Private declarations }
    f_dtstart, f_dtend:TDateTime;
    F_revs:string;
    f_strstart,f_strEnd:string;
    F_mainSql:string;
    procedure prepareDates();
    procedure prepareSql(id_rev:integer);
    function getOneRegiom(id_rev:integer):boolean;
    function OpenRegions():boolean;

  public
    { Public declarations }
    function preparedset:boolean;
    property  dtstart:TDateTime read f_dtstart write f_dtstart;
    property dtend:TdateTime read f_dtend write f_dtend;
    property  revs:string read  F_revs write  F_revs;


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
                ' from get_NonFinishedExcav (''%s'', ''%s'', %d,%d,%d,%d,%d)'+
                ' order by dt_zav_in ';


var
  dm_RepExcavNotFinished: Tdm_RepExcavNotFinished;

implementation

{$R *.dfm}

{ Tdm_RepExcavNotFinished }
uses HelpFunctions,Math;

function Tdm_RepExcavNotFinished.getOneRegiom(id_rev:integer):boolean;
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
     rm_main.FieldByName('dt_planexcav').asstring:=StringFromDateTime(dset.fieldbyname('dt_planexcav').AsDateTime,DTIMEFORMAT);
     rm_main.FieldByName('plandateexcav').asstring:=StringFromDateTime(dset.fieldbyname('plandateexcav').AsDateTime,DATEFORMAT);
     rm_main.FieldByName('dateorg').asstring:=StringFromDateTime(dset.fieldbyname('dateorg').AsDateTime,DATEFORMAT);
     rm_main.FieldByName('dt_cheb').asstring:=StringFromDateTime(dset.fieldbyname('dt_cheb').AsDateTime,DTIMEFORMAT);
     rm_main.FieldByName('dt_asf').asstring:=StringFromDateTime(dset.fieldbyname('dt_asf').AsDateTime,DTIMEFORMAT);
     rm_main.FieldByName('datecloseddocument').asstring:=StringFromDateTime(dset.fieldbyname('datecloseddocument').AsDateTime,DATEFORMAT);
     if not dset.fieldbyname('datecloseddocument').IsNull then
      if not dset.fieldbyname('plandateexcav').IsNull then
       if dset.fieldbyname('plandateexcav').AsDateTime>0 then
         rm_main.FieldByName('notfinished').AsString:=IntToStr(Floor(dset.fieldbyname('plandateexcav').AsDateTime-Date()));
     {дни если дата снятия ДБГУ есть то разницу межде датой рас и этой датой иначе разницу между тек датой и датой раскопки }
     rm_main.FieldByName('todo').AsInteger:=Floor(Date()-dset.fieldbyname('dt_excav').AsDateTime);
     if not dset.fieldbyname('datecloseddocument').IsNull then
      if dset.fieldbyname('datecloseddocument').AsDateTime>0 then
       rm_main.FieldByName('todo').AsInteger:=Floor(dset.fieldbyname('datecloseddocument').AsDateTime-floor(dset.fieldbyname('dt_excav').AsDateTime));

     rm_main.FieldByName('add_inf').AsString:=dset.fieldbyname('add_inf').AsString;
     rm_main.FieldByName('state').AsString:=getstate();
     rm_main.Post;
     dset.Next;
   end;
   result:=true;
 except   on e:exception do
  result:=false;
 end;


end;

procedure Tdm_RepExcavNotFinished.prepareDates;
begin
 ///f_strstart,f_strEnd:string;
//    f_dtstart, f_dtend:TDateTime;
  f_strstart:=FormatDateTime('dd.mm.yyyy',f_dtstart);
  f_strEnd:=FormatDateTime('dd.mm.yyyy',f_dtend);
end;

function Tdm_RepExcavNotFinished.preparedset: boolean;
begin

  result:=false;
   prepareDates();
  if OpenRegions then
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
     result:=true;
  end;

end;

procedure Tdm_RepExcavNotFinished.prepareSql(id_rev:integer);
begin
 F_mainSql:=format(sel_main,[f_strstart,f_strEnd,id_rev, ID_WRODZAS,
                            ID_WORKPLAN,ID_WORKCHEB,  ID_WORKASF]);

end;


function Tdm_RepExcavNotFinished.OpenRegions():boolean;
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

end.
