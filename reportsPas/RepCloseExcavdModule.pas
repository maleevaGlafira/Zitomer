unit RepCloseExcavdModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class,DMmain, DB, FR_DSet, FR_DBSet,
  RxMemDS, IBCustomDataSet, IBDatabase;

const
       DTIMEFORMAT='dd.mm.yyyy hh:mm';
         DATEFORMAT='dd.mm.yyyy';

type
  Tdm_RepCloseExcav = class(Tdm_NGReportBase)
    tran: TIBTransaction;
    dset: TIBDataSet;
    dset_regions: TIBDataSet;
    rm_main: TRxMemoryData;
    frDBDataSet1: TfrDBDataSet;
    rm_mainzavnumber: TIntegerField;
    rm_mainzavyear: TIntegerField;
    rm_mainexcavAdress: TStringField;
    rm_mainAbout: TStringField;
    rm_maindiam: TIntegerField;
    rm_mainworks: TStringField;
    rm_maindt_closeZav: TDateTimeField;
    rm_maindt_zav: TDateTimeField;
    rm_maindtStartExcav: TDateTimeField;
    rm_maindt_plan_sand: TDateTimeField;
    rm_maindateorg: TDateField;
    rm_mainnumberroad: TStringField;
    rm_maindt_cheb: TDateField;
    rm_mainnumbercheb: TStringField;
    rm_maindt_downasfalt: TDateField;
    rm_maindt_upasfalt: TDateField;
    rm_maindatecloseddocument: TDateField;
    rm_mainworksList: TStringField;
    rm_mainmest: TStringField;
    rm_mainid_rayon: TIntegerField;
    rm_mainid_mest: TIntegerField;
    rm_mainid_zav: TIntegerField;
    rm_mainnumberyear: TStringField;
    rm_mainforGroup: TSmallintField;
  private
    { Private declarations }
    S_mainSQL, SCondRevs, sCondMest, sCondAttach:string;
    f_revsid,F_revnames:string;
    F_mestid, F_mestNames:string;
    F_startDate,F_endDate :TDate;
    F_SstartDate,F_SendDate:string;
    f_id_att:integer;

    procedure PrePareCond();
    function PrePareSQL(Closed:boolean):string;
    function filldset(sql:string):boolean;
  public
    { Public declarations }
    property  revsid:string write  f_revsid  ;
    property revnames:string write F_revnames  ;
    property  mestid:string write F_mestid   ;
    property  mestNames:string write F_mestNames ;
    property  startDate:TDate write F_startDate  ;
    property  endDate:TDate write F_endDate  ;
    property id_att:integer read f_id_att write f_id_att;
    function prePareDsets:boolean;
  end;
const sqlMain = 'select nz.id id_zav,nz.nomer, nz.dt_in dt_zav, '+
                ' ( select adres from '+
                '     get_adres(r.id_ul1, r.id_ul2,'+
                '     r.ul_kod, r.dop_adr, r.id_dopadres ) ) ADRES,'+
                '    ss.name_r about,'+
                '    sd.diam diam,'+
                '    nz.dt_out dtOutZav,'+
                '    n.dt_in dtStartExcav,'+
                '    r.dt_plan_sand,'+
                '    r.dateorg,'+
                '    r.numberroad,'+
                '    r.dt_cheb, r.numbercheb,'+
                '        r.dt_downasfalt, r.dt_upasfalt,'+
                '    r.datecloseddocument,'+
                '    (select  list(distinct trim(ssw.name_r),''; '' ) from works ww , s_work ssw where ssw.id=ww.id_work AND ww.id_zav=nz.id)  worksList,'+
                '     nz.id_rayon, sm.id, sm.name_r mest,  nz.id_revs,  %d closed'+
                '  from %snarad n'+
                ' join works w on w.id_nar=n.id'+
                ' join s_work sw on sw.id=w.id_work and sw.id_work_type=1'+
                ' join %szavjav nz on nz.id = n.id_zav'+
                ' join raskop r on w.id_raskop =  r.id'+
                ' join s_sod ss on ss.id=nz.id_sod'+
                ' join s_diam sd on sd.id=nz.id_diam'+
                ' join s_mest sm on sm.id=r.id_mest'+
                ' where  n.dt_in >=''%s'' and n.dt_in<''%s''';
                cond_rayon = ' and  nz.id_rayon in (%s)';
                cond_mest = ' and r.id_mest in (%s) ';


var
  dm_RepCloseExcav: Tdm_RepCloseExcav;

implementation

{$R *.dfm}

{ Tdm_RepCloseExcav }

uses HelpFunctions;
function Tdm_RepCloseExcav.filldset(sql:string): boolean;
begin
// result:=false;
   try
    MyOpenIBDs(dset, sql);
    dset.First;
    if F_IsStopProgress then result:=false
    else
    begin

    while not dset.Eof do
    begin
     rm_main.Append;
     rm_main.FieldByName('zavnumber').AsInteger:=dset.fieldbyname('nomer').AsInteger;
     rm_main.FieldByName('zavyear').AsInteger:=GetYear(dset.fieldbyname('dt_zav').AsDateTime);
     rm_main.FieldByName('dt_zav').AsDateTime:=dset.fieldbyname('dt_zav').AsDateTime;
     rm_main.FieldByName('excavAdress').AsString:=dset.fieldbyname('ADRES').AsString;
     rm_main.FieldByName('About').AsString:=dset.fieldbyname('about').AsString;
     if pos('пусто>',rm_main.FieldByName('About').AsString)>0 then
      rm_main.FieldByName('About').AsString:='';
     rm_main.FieldByName('diam').AsInteger:=dset.fieldbyname('diam').AsInteger;
     rm_main.FieldByName('worksList').AsString:=dset.fieldbyname('worksList').AsString;
     if dset.FieldByName('closed').AsInteger=1 then
       rm_main.FieldByName('dtOutZav').AsDateTime:=dset.fieldbyname('dtOutZav').AsDateTime
     else
      rm_main.FieldByName('dtOutZav').AsDateTime:=0;
     rm_main.FieldByName('dtStartExcav').AsDateTime:=dset.fieldbyname('dtStartExcav').AsDateTime;
     rm_main.FieldByName('dt_plan_sand').AsDateTime:=dset.fieldbyname('dt_plan_sand').AsDateTime;
     rm_main.FieldByName('dateorg').AsDateTime:=dset.fieldbyname('dateorg').AsDateTime;
     rm_main.FieldByName('numberroad').AsString:=dset.fieldbyname('numberroad').AsString;
     rm_main.FieldByName('dt_cheb').AsDateTime:=dset.fieldbyname('dt_cheb').AsDateTime;
     rm_main.FieldByName('numbercheb').AsString:=dset.fieldbyname('numbercheb').AsString;
     rm_main.FieldByName('dt_downasfalt').AsDateTime:=dset.fieldbyname('dt_downasfalt').AsDateTime;
     rm_main.FieldByName('dt_upasfalt').AsDateTime:=dset.fieldbyname('dt_upasfalt').AsDateTime;
     rm_main.FieldByName('datecloseddocument').AsDateTime:=dset.fieldbyname('datecloseddocument').AsDateTime;
     rm_main.FieldByName('mest').AsString:=dset.fieldbyname('mest').AsString;
     rm_main.FieldByName('id_rev').AsInteger:=dset.fieldbyname('id_revs').AsInteger;
     rm_main.FieldByName('id_zav').AsInteger:=dset.fieldbyname('id_zav').AsInteger;
     rm_main.FieldByName('numberyear').AsString:=format('%d / %d',[dset.fieldbyname('nomer').AsInteger,rm_main.FieldByName('zavyear').AsInteger]);
    rm_main.FieldByName('forGroup').AsInteger:=1;
     rm_main.Post;
     dset.Next;
       if F_IsStopProgress then begin result:=false; exit; end;

    end;
    dset.Close;
    end;
    result:=true;
   except
    result:=false;
   end;
end;

procedure Tdm_RepCloseExcav.PrePareCond;
begin
 F_SstartDate:=FormatDateTime(DATEFORMAT, F_startDate);
 F_SendDate:=FormatDateTime(DATEFORMAT, F_endDate+1);
 if F_id_att = 1 then
  sCondAttach := 'and nz.id_attach in (1,4)'
 else
 if  F_id_att = 2 then
  sCondAttach := 'and nz.id_attach in (2,5)'
 else
  sCondAttach:='';
 if f_revsid<>'' then SCondRevs := format(cond_rayon, [f_revsid])
 else
  SCondRevs:='';
 if F_mestid<>'' then sCondMest := format(cond_mest,[F_mestid])
 else
  sCondMest:='';
end;

function Tdm_RepCloseExcav.prePareDsets: boolean;
var sql:string;
begin
 result:=false;
 PrePareCond();

 if rm_main.Active then
  rm_main.Close;
 rm_main.Open;
 sql:=PrePareSQL(false);
 if   filldset(sql) then
 begin
  sql:=PrePareSQL(true);
  result:= filldset(sql);
   rm_main.SortOnFields('id_rev;dt_zav');
 end

end;

function Tdm_RepCloseExcav.PrePareSQL(Closed: boolean): string;
begin
  if  Closed then result:=Format(sqlMain,[1,'','',F_SstartDate,F_SendDate])
  else result:=Format(sqlMain,[0,'n','n',F_SstartDate,F_SendDate]);
  result:=result+ sCondAttach+ SCondRevs +sCondMest;
end;

end.
