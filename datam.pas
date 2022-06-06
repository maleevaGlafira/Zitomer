unit datam;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables,s_dolgn, avartype, IBCustomDataSet, IBDatabase
  , DbiProcs, DBiTypes,dmmain;

type

  TDM1 = class(TDataModule)
    S_Diam_q: TQuery;
    S_Diam_sur: TDataSource;
    Db_Avar: TDatabase;
    S_Brig_q: TQuery;
    S_Brig_sur: TDataSource;
    tempQr_q: TQuery;
    S_Alien_q: TQuery;
    S_Alien_sur: TDataSource;
    S_Damg_q: TQuery;
    S_Damg_sur: TDataSource;
    S_Brig_upd: TUpdateSQL;
    S_Alien_upd: TUpdateSQL;
    S_Damg_upd: TUpdateSQL;
    S_Sod_q: TQuery;
    S_Sod_sur: TDataSource;
    S_Sod_upd: TUpdateSQL;
    S_Sod_qID: TIntegerField;
    S_Sod_qNAME_R: TStringField;
    S_Sod_qTYPE: TIntegerField;
    S_Sod_qSAH: TIntegerField;
    S_Sod_qNAME_R_1: TStringField;
    S_Sah_q: TQuery;
    S_Sah_sur: TDataSource;
    S_Sah_upd: TUpdateSQL;
    S_Sod_qList_SAH: TStringField;
    S_Revs_q: TQuery;
    S_Revs_sur: TDataSource;
    S_Revs_upd: TUpdateSQL;
    S_Work_q: TQuery;
    S_Work_sur: TDataSource;
    S_Work_upd: TUpdateSQL;
    S_Work_qID: TIntegerField;
    S_Work_qNAME_R: TStringField;
    S_Work_qED_IZM: TStringField;
    S_Work_qTYPE: TIntegerField;
    S_Work_qPLACE: TStringField;
    S_Place_q: TQuery;
    S_Place_sur: TDataSource;
    S_Place_upd: TUpdateSQL;
    S_Work_qList_Place: TStringField;
    S_mat_q: TQuery;
    S_mat_sur: TDataSource;
    S_mat_upd: TUpdateSQL;
    S_runw_q: TQuery;
    S_runw_sur: TDataSource;
    S_runw_upd: TUpdateSQL;
    S_Diam_upd: TUpdateSQL;
    S_Mest_q: TQuery;
    S_Mest_sur: TDataSource;
    S_Mest_upd: TUpdateSQL;
    S_zav_q: TQuery;
    S_zav_sur: TDataSource;
    S_zav_upd: TUpdateSQL;
    S_Obor_sur: TDataSource;
    S_Obor_upd: TUpdateSQL;
    S_tzav_q: TQuery;
    S_tzav_sur: TDataSource;
    S_tzav_upd: TUpdateSQL;
    TBL_const_q: TQuery;
    TBL_const_sur: TDataSource;
    S_Sod_qDIAMPRESENT: TIntegerField;
    S_Sod_qListDIAMPRESENT: TStringField;
    S_mat_qID: TIntegerField;
    S_mat_qNAME_R: TStringField;
    S_mat_qED_IZM: TStringField;
    S_mat_qDIAMPRESENT: TIntegerField;
    S_mat_qListDIAMPRESENT: TStringField;
    TableLog_q: TQuery;
    TableLog_sur: TDataSource;
    TableLog_upd: TUpdateSQL;
    Users_q: TQuery;
    Users_sur: TDataSource;
    s_rayons_q: TQuery;
    s_rayons_sur: TDataSource;
    s_rayons_upd: TUpdateSQL;
    s_vidul_q: TQuery;
    s_vidul_sur: TDataSource;
    s_vidul_upd: TUpdateSQL;
    s_ulic_q: TQuery;
    s_ulic_qid: TIntegerField;
    s_ulic_qname_r: TStringField;
    s_ulic_qlist_place: TStringField;
    s_ulic_sur: TDataSource;
    s_ulic_upd: TUpdateSQL;
    s_ulic_qDEL: TStringField;
    S_Sod_qDEL: TStringField;
    S_Work_qDEL: TStringField;
    S_mat_qDEL: TStringField;
    s_ulic_qID_VIDUL: TIntegerField;
    s_ulic_qVIDNAME_R: TStringField;
    TableLog_qID: TIntegerField;
    TableLog_qTYPE: TIntegerField;
    TableLog_qIDOBJ: TIntegerField;
    TableLog_qUSER_NAME: TStringField;
    TableLog_qOLD_VALUE: TStringField;
    TableLog_qNEW_VALUE: TStringField;
    TableLog_qDATE_CHANGE: TDateTimeField;
    TableLog_qDEL: TStringField;
    S_Sod_qlistTYPE: TStringField;
    s_leak_q: TQuery;
    s_leak_sur: TDataSource;
    s_leak_upd: TUpdateSQL;
    s_clog_q: TQuery;
    s_clog_sur: TDataSource;
    s_clog_upd: TUpdateSQL;
    s_fill_q: TQuery;
    s_fill_sur: TDataSource;
    s_fill_upd: TUpdateSQL;
    s_net_q: TQuery;
    s_net_sur: TDataSource;
    s_net_upd: TUpdateSQL;
    s_local_q: TQuery;
    s_local_sur: TDataSource;
    s_local_upd: TUpdateSQL;
    s_killclog_q: TQuery;
    s_killclog_sur: TDataSource;
    s_killclog_upd: TUpdateSQL;
    s_pump_q: TQuery;
    s_pump_sur: TDataSource;
    s_pump_upd: TUpdateSQL;
    s_pes_q: TQuery;
    s_pes_sur: TDataSource;
    s_pes_upd: TUpdateSQL;
    s_owner_q: TQuery;
    s_owner_sur: TDataSource;
    s_owner_upd: TUpdateSQL;
    s_comment_q: TQuery;
    s_comment_sur: TDataSource;
    s_comment_upd: TUpdateSQL;
    s_matpipe: TQuery;
    s_matpipe_upd: TUpdateSQL;
    ds_matpipe: TDataSource;
    S_Obor_q: TQuery;
    StringField1: TStringField;
    StringField2: TStringField;
    IntegerField1: TIntegerField;
    StringField3: TStringField;
    S_Damg_qID: TIntegerField;
    S_Damg_qNAME_R: TStringField;
    S_Damg_qDEL: TStringField;
    S_Damg_qPLACE_TYPE: TIntegerField;
    S_Damg_qPLACE: TStringField;
    S_Damg_qlist_PLACE: TStringField;
    s_zayavl_q: TQuery;
    IntegerField2: TIntegerField;
    StringField4: TStringField;
    s_zayavl_sur: TDataSource;
    s_zayavl_upd: TUpdateSQL;
    S_Sod_qSZ_ID: TIntegerField;
    S_Sod_qlistZAYAVL: TStringField;
    S_Sod_qPLACE_TYPE: TIntegerField;
    S_Sod_qlistPLACE: TStringField;
    S_Sod_qZAYAVL: TIntegerField;
    S_Fulltzav_q: TQuery;
    S_FullPlace_q: TQuery;
    s_remont_q: TQuery;
    s_remont_sur: TDataSource;
    s_remont_upd: TUpdateSQL;
    s_owner_type: TQuery;
    s_owner_qID: TIntegerField;
    s_owner_qNAME_R: TStringField;
    s_owner_qOWNER_TYPE: TSmallintField;
    s_owner_qFOR_VEDOM: TStringField;
    s_owner_qDEL: TStringField;
    s_owner_qlist_OWNER_TYPE: TStringField;
    tmp_Qry_ul: TQuery;
    S_Mest_qID: TIntegerField;
    S_Mest_qNAME_R: TStringField;
    S_Mest_qVOSST_POKRYT: TStringField;
    S_Mest_qDEL: TStringField;
    S_PlanObor_q: TQuery;
    S_PlanObor_upd: TUpdateSQL;
    s_PlanObor_sur: TDataSource;
    S_PlanObor_qID: TIntegerField;
    S_PlanObor_qNAME_R: TStringField;
    S_PlanObor_qDEL: TStringField;
    s_vrk_q: TQuery;
    s_vrk_sur: TDataSource;
    s_vrk_upd: TUpdateSQL;
    s_vrk_qID: TIntegerField;
    s_vrk_qID_ULIC: TIntegerField;
    s_vrk_qID_TVRK: TIntegerField;
    s_vrk_qOPLACHENO: TIntegerField;
    s_vrk_qDEL: TStringField;
    s_yesno_q: TQuery;
    s_yesno_qID: TIntegerField;
    s_yesno_qNAME_R: TStringField;
    s_tvrk_q: TQuery;
    s_tvrk_qID: TIntegerField;
    s_tvrk_qNAME_R: TStringField;
    s_vrk_qlistULIC: TStringField;
    s_vrk_qlistTVRK: TStringField;
    s_vrk_qlistOPLACHENO: TStringField;
    s_vrk_qNUM_DOM: TStringField;
    s_vrk_qULIC: TStringField;
    s_ulic_qUL_VIDUL: TStringField;
    s_dopadres_q: TQuery;
    s_dopadres_sur: TDataSource;
    s_dopadres_upd: TUpdateSQL;
    tmp_Qry_DopAdr: TQuery;
    S_Obor_qNAME_R_AND_FIO: TStringField;
    s_MestType_q: TQuery;
    s_MestType_qID: TIntegerField;
    s_MestType_qNAME_R: TStringField;
    s_trudozatrat_q: TQuery;
    s_trudozatrat_qID: TIntegerField;
    s_trudozatrat_qID_WORK: TIntegerField;
    s_trudozatrat_qTZ_SUMMER: TBCDField;
    s_trudozatrat_qTZ_WINTER: TBCDField;
    s_trudozatrat_qID_DIAM: TIntegerField;
    s_trudozatrat_qKOL_ED: TBCDField;
    s_trudozatrat_qID_MESTTYPE: TIntegerField;
    s_trudozatrat_qDEL: TStringField;
    s_trudozatrat_upd: TUpdateSQL;
    s_trudozatrat_sur: TDataSource;
    S_Work_qFULL_NAME: TStringField;
    s_trudozatrat_qlp_WORK: TStringField;
    s_trudozatrat_qlp_MESTTYPE: TStringField;
    s_AllDiam_q: TQuery;
    s_trudozatrat_qlp_DIAM: TStringField;
    s_AllDiam_qID: TIntegerField;
    s_AllDiam_qDIAM: TIntegerField;
    s_AllDiam_qDEL: TStringField;
    s_AllDiam_qclc_Diam: TStringField;
    s_bwork_q: TQuery;
    s_bwork_upd: TUpdateSQL;
    s_bwork_sur: TDataSource;
    s_bwork_qID: TIntegerField;
    s_bwork_qNAME_R: TStringField;
    s_bwork_qDEL: TStringField;
    tmp_qry_Object: TQuery;
    s_instrum_q: TQuery;
    s_instrum_sur: TDataSource;
    s_instrum_upd: TUpdateSQL;
    s_object_q: TQuery;
    s_object_upd: TUpdateSQL;
    s_object_sur: TDataSource;
    qry_ObjAtt: TQuery;
    qry_ObjAttID: TIntegerField;
    qry_ObjAttNAME_R: TStringField;
    s_object_qID: TIntegerField;
    s_object_qNAME_R: TStringField;
    s_object_qID_ATTACH: TIntegerField;
    s_object_qDEL: TStringField;
    s_object_qlp_ATTACH: TStringField;
    s_objobor_q: TQuery;
    s_objobor_upd: TUpdateSQL;
    s_objobor_sur: TDataSource;
    s_objobor_qID: TIntegerField;
    s_objobor_qNAME_R: TStringField;
    s_objobor_qID_OBJECT: TIntegerField;
    s_objobor_qDEL: TStringField;
    tmp_qry_Attach: TQuery;
    s_remont_type_q: TQuery;
    s_remont_type_qID: TIntegerField;
    s_remont_type_qNAME_R: TStringField;
    s_remont_qID: TIntegerField;
    s_remont_qNAME_R: TStringField;
    s_remont_qID_REMONT_TYPE: TIntegerField;
    s_remont_qDEL: TStringField;
    s_remont_qlp_REMONT_TYPE: TStringField;
    s_work_type_q: TQuery;
    s_work_type_qID: TIntegerField;
    s_work_type_qNAME_R: TStringField;
    S_Work_qID_WORK_TYPE: TIntegerField;
    S_Work_qlist_WORK_TYPE: TStringField;
    s_work_mest_q: TQuery;
    s_work_mest_qID: TIntegerField;
    s_work_mest_qID_WORK: TIntegerField;
    s_work_mest_qID_MEST: TIntegerField;
    s_work_mest_qDEL: TStringField;
    s_work_mest_upd: TUpdateSQL;
    s_work_mest_sur: TDataSource;
    s_work_mest_qlist_MEST: TStringField;
    s_BlagWork_q: TQuery;
    s_BlagWork_qID: TIntegerField;
    s_BlagWork_qFULL_NAME: TStringField;
    s_work_mest_qlistWORK: TStringField;
    s_vrk_qN_VRK: TStringField;
    s_ogragd_q: TQuery;
    s_ogragd_sur: TDataSource;
    s_ogragd_upd: TUpdateSQL;
    s_obortype_q: TQuery;
    s_obortype_sur: TDataSource;
    s_obortype_upd: TUpdateSQL;
    s_obortypegroup_q: TQuery;
    s_obortypegroup_sur: TDataSource;
    s_obortypegroup_upd: TUpdateSQL;
    s_obortype_qID: TIntegerField;
    s_obortype_qNAME_R: TStringField;
    s_obortype_qDIFFER: TIntegerField;
    s_obortype_qDEL: TStringField;
    s_obortype_qlook_differ: TStringField;
    s_obortypegroup_qID: TIntegerField;
    s_obortypegroup_qOBORTYPE: TIntegerField;
    s_obortypegroup_qDETAIL: TIntegerField;
    s_obortypegroup_qDEL: TStringField;
    s_obortypegroup_qlook_obortype: TStringField;
    s_obortype_look: TQuery;
    IntegerField3: TIntegerField;
    StringField5: TStringField;
    IntegerField4: TIntegerField;
    StringField6: TStringField;
    StringField7: TStringField;
    S_Sod_qID_OBORTYPE: TIntegerField;
    S_Sod_qlook_obortype: TStringField;
    S_Work_qID_OBORTYPE: TIntegerField;
    s_soorug_q: TQuery;
    s_soorug_sur: TDataSource;
    s_soorug_upd: TUpdateSQL;
    s_soorug_qID: TIntegerField;
    s_soorug_qNAME_R: TStringField;
    s_soorug_qID_OBJECT: TIntegerField;
    s_soorug_qDEL: TStringField;
    s_soorug_qlook_object: TStringField;
    s_objobor_qID_OBORTYPE: TIntegerField;
    s_objobor_qID_SOORUG: TIntegerField;
    s_objobor_qID_DIAM: TIntegerField;
    s_objobor_qlook_obortype: TStringField;
    s_objobor_qlook_soorug: TStringField;
    s_objobor_qlook_diam: TIntegerField;
    s_object_qID_REVS: TSmallintField;
    s_object_qlook_revs: TStringField;
    s_obortypeglob_q: TQuery;
    s_obortypeglob_sur: TDataSource;
    s_obortypeglob_upd: TUpdateSQL;
    s_obortype_qID_OBORTYPEGLOB: TIntegerField;
    s_obortype_qlook_obortypeglobal: TStringField;
    s_objobor_qDIFFER: TIntegerField;
    s_obortype_lookup: TQuery;
    IntegerField5: TIntegerField;
    StringField8: TStringField;
    IntegerField6: TIntegerField;
    StringField9: TStringField;
    StringField10: TStringField;
    s_soorug_lookup: TQuery;
    IntegerField7: TIntegerField;
    StringField11: TStringField;
    IntegerField8: TIntegerField;
    StringField12: TStringField;
    StringField13: TStringField;
    S_OTGlob_fields_q: TQuery;
    S_OTGlob_fields_sur: TDataSource;
    S_OTGlob_fields_upd: TUpdateSQL;
    S_OT_Params_q: TQuery;
    S_OT_Params_sur: TDataSource;
    S_OT_Params_upd: TUpdateSQL;
    S_OTGlob_fields_qID: TIntegerField;
    S_OTGlob_fields_qID_OTG: TIntegerField;
    S_OTGlob_fields_qNAME_R: TStringField;
    S_OTGlob_fields_qMEASURE: TStringField;
    S_OTGlob_fields_qDEL: TStringField;
    s_objobor_qID_PARENT: TIntegerField;
    s_objobor_qSOORUG: TStringField;
    s_objobor_qINVENTAR: TStringField;
    s_obortypeglob_look: TQuery;
    s_obortypeglob_lookID: TIntegerField;
    s_obortypeglob_lookNAME_R: TStringField;
    s_obortypeglob_lookDEL: TStringField;
    S_Work_qlook_obortypeglob: TStringField;
    s_object_lookup: TQuery;
    IntegerField9: TIntegerField;
    StringField14: TStringField;
    IntegerField10: TIntegerField;
    StringField15: TStringField;
    StringField16: TStringField;
    SmallintField1: TSmallintField;
    StringField17: TStringField;
    IBTransaction1: TIBTransaction;
    ibds_soorug: TIBDataSet;
    ibds_soorugID: TIntegerField;
    ibds_soorugNAME_R: TIBStringField;
    ibds_soorugID_OBJECT: TIntegerField;
    ibds_soorugDEL: TIBStringField;
    ibds_soorugNAME_O: TIBStringField;
    ibds_sooruglook_object: TStringField;
    ibdset_tmp: TIBDataSet;
    qry_ObjAtt12: TQuery;
    IntegerField11: TIntegerField;
    StringField18: TStringField;
    s_ulic_qID_RAYON: TIntegerField;
    s_ulic_qRAYON: TStringField;
    s_ulic_qList_Rayon: TStringField;
    s_mat_column: TQuery;
    IntegerField12: TIntegerField;
    StringField19: TStringField;
    StringField20: TStringField;
    IntegerField13: TIntegerField;
    StringField21: TStringField;
    StringField22: TStringField;
    s_mat_column_sur: TDataSource;
    s_mat_column_upd: TUpdateSQL;
   // procedure S_Brig_qBeforePost(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure s_AllDiam_qCalcFields(DataSet: TDataSet);
    procedure ibds_soorugAfterEdit(DataSet: TDataSet);
    procedure Db_AvarAfterConnect(Sender: TObject);
  private
    { Private declarations }
     function GetPathFromAlias: string;
  public
    { Public declarations }
    function KillPusto(value:string):string;
    function GetUlByID(_ul2:integer):string;
    function GetDopAdrByID(_id_dopadr:integer):string;
    function GetObjectName( _ObjectID: integer ): string;
    function Gen_Addr(_vidul,_ul1,_ul2,_nom_dom,_kod_ul,_dopadr,_dopadr_mest:string):string; overload;
    function Gen_Addr(_vidul,_ul1,_ul2,_kod_ul,_dopadr,_id_dopadr:string):string; overload;
    function GetDataBasePath: string;
    function GetZavAttach(ZavID: integer): integer; 
  end;

var
  DM1: TDM1;

implementation

{$R *.DFM}

function TDM1.KillPusto(value:string):string;
  procedure DelStr(substr:string; var str:string);
  var i,k,l:integer;
    s:string;
  begin
    l:=length(substr);
    i:=Pos(str,substr);
    while i>0 do
      begin
        Delete(str,i,l);
        i:=Pos(str,substr);
      end;
  end;
begin
  DelStr('<пусто>',value);
  DelStr('< пусто >',value);
  result:=value;
end;

function TDM1.GetUlByID(_ul2:integer):string;
begin
  with tmp_Qry_Ul do
    begin
      Close;
      ParamByName('id_ul').AsInteger:=_ul2;
      Open;
      result:=FieldByName('name_ul').AsString;
      Close;
    end;
end;

procedure TDM1.DataModuleCreate(Sender: TObject);
begin
 try
  Db_Avar.LoginPrompt:=false;
 except
   Db_Avar.Connected:=false;
   raise;
 end;

 //IBDatabase1.DatabaseName := GetPathFromAlias;

end;


function TDM1.GetPathFromAlias;
var
  MyAliasPath: string;
  ParamsList: TStringList;
const

  AliasName = 'AVARZHYTOMYR';


begin
  ParamsList := TStringList.Create;

try
  with Session do
  begin
    Session.GetAliasNames(ParamsList);
    Session.GetAliasParams(AliasName, ParamsList);
    MyAliasPath := Copy(ParamsList[0], 13, 50) + '';
  end;
finally
  ParamsList.Free;
end;

  result := MyAliasPath;
end;


function TDM1.Gen_Addr(_vidul,_ul1,_ul2,_nom_dom,_kod_ul,_dopadr,_dopadr_mest:string):string;
var _kod_ul_int:integer;
begin
  result:='';
  if _kod_ul='' then _kod_ul:='2';
  try
    _kod_ul_int:=StrToInt(_kod_ul);  except    _kod_ul_int:=2;  end;
  //
  _ul1:=trim(_ul1);  _ul2:=trim(_ul2);
   if _vidul<>'' then _vidul:=trim(_vidul)+' ';
   if (POS('<пусто>',_ul1)>0) then _ul1:='';  _dopadr:=trim(_dopadr);
  //  //_kod_ul=2 - местность// od_ul=1 - перекресток


  case _kod_ul_int of
  0:
    begin
      if (POS('<пусто>',_nom_dom)>0) then _nom_dom:='';
      if (_ul1<>'') or (_nom_dom<>'') then result:=_vidul+' '+_ul1+','+_nom_dom;
    end;
  1:
    begin
      if (POS('<пусто>',_ul2)>0) then _ul2:='';
      if (_ul1<>'') and (_ul2<>'') then result:=_vidul+' '+_ul1+' / '+_ul2;
    end;
  2:
    begin
      result:='Мест.:'+_vidul+_ul1;
      if (_dopadr_mest<>'') and (POS('<пусто>', AnsiLowerCase(_dopadr_mest))=0) then
      begin
        if _ul1<>'' then
          result:=result+';';
        result:=result+trim(_dopadr_mest);
      end;
    end;
  end;    
  if _dopadr<>'' then result:=result+' ('+_dopadr+')';
  result:=KillPusto(result);
end;

function TDM1.Gen_Addr(_vidul,_ul1,_ul2,_kod_ul,_dopadr,_id_dopadr:string):string;
var _kod_ul_int:integer;
begin
  result:='';
   if (POS('<пусто>',_ul1)>0) then _ul1:='';  _dopadr:=trim(_dopadr);
  if _kod_ul='' then _kod_ul:='2';
  try
    _kod_ul_int:=StrToInt(_kod_ul);  except    _kod_ul_int:=2;  end;
  //
  _ul1:=trim(_ul1);  _ul2:=trim(_ul2);
   if _vidul<>'' then _vidul:=trim(_vidul)+' ';
   if _id_dopadr='' then _id_dopadr:='-1';
  //  //_kod_ul=2 - местность// od_ul=1 - перекресток
  //
  case _kod_ul_int of
  0:
    begin
      if (POS('<пусто>',_ul2)>0) then _ul2:='';
      if (_ul1<>'') or (_ul2<>'') then result:=_vidul+_ul1+','+_ul2;
    end;
  1:
    begin
      if (POS('<пусто>',_ul2)>0) then _ul2:='';
      if (_ul1<>'') and (_ul2<>'') then result:=_vidul+_ul1+' / '+GetUlByID(StrToInt(_ul2))
    end;
  2:
    begin
      result:='Мест.:'+_vidul+_ul1;
      if (_id_dopadr<>'-1') and (_id_dopadr<>'') then
      begin
        if _ul1<>'' then
          result:=result+';';
        result:=result+GetDopAdrByID(StrToInt(_id_dopadr));
      end;
    end;
  end;
  if _dopadr<>'' then result:=result+' ('+_dopadr+')';
  result:=KillPusto(result);
end;


function TDM1.GetDataBasePath: string;
var
  ls:TStringList;
begin
  ls:=TStringList.Create;
  try
    Session.GetAliasParams(Db_Avar.AliasName,ls);
    result:=copy(ls[0],13,length(ls[0]));
  finally
    ls.Free;
  end;
end;



function TDM1.GetDopAdrByID(_id_dopadr: integer): string;
begin
  with tmp_Qry_DopAdr do
  begin
    Close;
    ParamByName('pID').AsInteger:=_id_dopadr;
    Open;
    Result:=tmp_Qry_DopAdr.FieldByName('name_r').AsString;
    Close;
  end;
end;

procedure TDM1.s_AllDiam_qCalcFields(DataSet: TDataSet);
begin
  with DataSet do
  begin
    if FieldByName( 'id' ).AsInteger = -1 then
      FieldByName( 'clc_Diam' ).AsString := '<нет>'
    else
      FieldByName( 'clc_Diam' ).AsString := FieldByName( 'diam' ).AsString;
  end;
end;

function TDM1.GetObjectName(_ObjectID: integer): string;
begin
  with tmp_Qry_Object do
  begin
    Close;
    ParamByName('pID').AsInteger := _ObjectID;
    Open;
    Result := tmp_Qry_Object.FieldByName( 'name_r' ).AsString;
    Close;
  end;
end;

function TDM1.GetZavAttach(ZavID: integer): integer;
begin
  with tmp_qry_Attach do
  begin
    Close;
    ParamByName( 'pZavID' ).AsInteger := ZavID;
    Open;
    Result := FieldByName( 'id_attach' ).AsInteger;
    Close;
  end;
end;

procedure TDM1.ibds_soorugAfterEdit(DataSet: TDataSet);
var _m : integer;

  function CheckForObjObors(_id : integer): boolean;
  var _SQL : string;
  begin
     //
     if ibdset_tmp.Active then ibdset_tmp.Close;
     _SQL := ' select count(*) from s_objobor '+
             ' where id_soorug = '+ inttostr(_id) ;
     ibdset_tmp.SelectSQL.Text := _SQL;        
     ibdset_tmp.Open;        
     result := (ibdset_tmp.FieldByName('COUNT').AsInteger > 0);
     ibdset_tmp.Close;         
  end;

begin
//
  if CheckForObjObors(DataSet.FieldByName('ID').AsInteger) then
     begin
        if MessageDlg('На этом сооружении этого объекта есть оборудование! Изменить?',
                mtConfirmation, [mbYes, mbNo], 0)=mrNo then DataSet.Cancel;
     end;
end;

procedure TDM1.Db_AvarAfterConnect(Sender: TObject);
begin
{IBDatabase1
user_name=sysdba
password=masterkey
lc_ctype=WIN1251}
end;

end.
