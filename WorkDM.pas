unit WorkDM;

interface

uses
  SysUtils, Classes, DMMain, IBDatabase, DB, IBCustomDataSet, BaseNarDetailDM,
  IBSQL, BaseWorkAndMatDM, NGRaskopDM;
const tableName = 'works';

type
  TWorksField = ( wfNull, wfWork, wfPlace );

  TWorkKind = ( wkAll, wkOnlyBlag, wkNoBlag );

  Tdm_Work = class(Tdm_BaseWorkAndMat)
    dset_Works: TIBDataSet;
    dset_WorksID: TIntegerField;
    dset_WorksID_ZAV: TIntegerField;
    dset_WorksID_NAR: TIntegerField;
    dset_WorksID_WORK: TIntegerField;
    dset_WorksKOL_WORK: TFloatField;
    dset_WorksID_DIAM: TIntegerField;
    dset_WorksID_PLACE: TIntegerField;
    dset_WorksID_KILLCLOG: TIntegerField;
    dset_WorksID_PUMP: TIntegerField;
    dset_WorksID_PES: TIntegerField;
    dset_S_Work: TIBDataSet;
    dset_S_Place: TIBDataSet;
    dset_S_Diam: TIBDataSet;
    dset_S_KillClog: TIBDataSet;
    dset_S_Pump: TIBDataSet;
    dset_S_WorkID: TIntegerField;
    dset_S_WorkNAME_R: TIBStringField;
    dset_S_WorkED_IZM: TIBStringField;
    dset_S_WorkID_PLACE: TIntegerField;
    dset_S_WorkDEL: TIBStringField;
    dset_S_WorkclcFULL_NAME: TStringField;
    dset_WorkslpWORK: TStringField;
    dset_S_PlaceID: TIntegerField;
    dset_S_PlaceNAME_R: TIBStringField;
    dset_S_PlaceDEL: TIBStringField;
    dset_WorkslpPLACE: TStringField;
    dset_S_DiamID: TIntegerField;
    dset_S_DiamDIAM: TIntegerField;
    dset_S_DiamDEL: TIBStringField;
    dset_WorkslpDIAM: TIntegerField;
    dset_S_KillClogID: TIntegerField;
    dset_S_KillClogNAME_R: TIBStringField;
    dset_S_KillClogDEL: TIBStringField;
    dset_WorkslpKILLCLOG: TStringField;
    dset_WorkslpPUMP: TStringField;
    dset_S_Pes: TIBDataSet;
    dset_S_PumpID: TIntegerField;
    dset_S_PumpNAME_R: TIBStringField;
    dset_S_PumpDEL: TIBStringField;
    dset_S_PesID: TIntegerField;
    dset_S_PesNAME_R: TIBStringField;
    dset_S_PesDEL: TIBStringField;
    dset_WorkslpPES: TStringField;
    ds_Place: TDataSource;
    dset_S_WorkDetail: TIBDataSet;
    IntegerField1: TIntegerField;
    IBStringField1: TIBStringField;
    IBStringField2: TIBStringField;
    IntegerField2: TIntegerField;
    IBStringField3: TIBStringField;
    StringField1: TStringField;
    dset_WorksTZ_TRUDOZATRAT: TIBBCDField;
    dset_WorksTZ_KOL_ED: TIBBCDField;
    dset_WorksclcTRUDOZATRAT: TStringField;
    dset_SearchTZ: TIBDataSet;
    dset_SearchTZTZ_SUMMER: TIBBCDField;
    dset_SearchTZTZ_WINTER: TIBBCDField;
    dset_SearchTZKOL_ED: TIBBCDField;
    dset_WorksclcTOTAL_TZ: TStringField;
    dset_tmp: TIBDataSet;
    sql_InsertWork: TIBSQL;
    IBSQL: TIBSQL;
    dset_WorksBWORKS_ID: TIntegerField;
    dset_S_WorkID_WORK_TYPE: TIntegerField;
    dset_S_WorkDetailID_WORK_TYPE: TIntegerField;
    dset_GetWorkType: TIBDataSet;
    dset_WorksID_RASKOP: TIntegerField;
    procedure dset_WorksAfterInsert(DataSet: TDataSet);
    procedure dset_WorksAfterPost(DataSet: TDataSet);
    procedure dset_S_WorkCalcFields(DataSet: TDataSet);
    procedure dset_WorksAfterEdit(DataSet: TDataSet);
    procedure dset_WorksAfterCancel(DataSet: TDataSet);
    procedure dset_WorksCalcFields(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure dset_WorkslpDIAMGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure dset_WorksTZ_KOL_EDGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure DataModuleDestroy(Sender: TObject);
  private
    F_IsSummerPeriod: boolean;
    F_MestTypeID: integer;
    F_WorkKind: TWorkKind;
    F_Raskop: Tdm_NGRaskop;
    F_IsCanAddRaskop: boolean;
    F_IsObjZav: boolean;
    F_IdObjObor: integer;
    procedure SetWorkDate( Value: TDateTime );
  private
    procedure FillSprList; override;

    procedure SetSQL;


  public
    function IsInputValuesCorrect( var _ErrMsg: string; var _ErrFieldOrd: integer ): boolean; override;
    procedure OpenDset; override;
    procedure Refilter; override;
  public
    property WorkDate: TDateTime write SetWorkDate;
    property MestTypeID: integer read F_MestTypeID write F_MestTypeID;
    property WorkKind: TWorkKind read F_WorkKind write F_WorkKind;
    property IsObjZav: boolean write F_IsObjZav;
    property IdObjObor: integer write F_IdObjObor;
    property IsCanAddRaskop: boolean read F_IsCanAddRaskop write F_IsCanAddRaskop;
    property Raskop: Tdm_NGRaskop read F_Raskop write F_Raskop;
    procedure SetTrudozatratForCurrentRec;
    procedure AddWorksAssignedWithBWork( _BWorkID, ID_IN_BWORKS: integer );
    procedure ResetWorksAttachAssignedWith_ID_IN_BWORKS( ID_IN_BWORKS: integer );
    procedure DelWorksAssignedWith_ID_IN_BWORKS( ID_IN_BWORKS: integer );
    function RecalcAll_TZ( var _ErrMsg: string ): boolean;
    function GetCurrentWorkTypeID: integer;
    function GetCurrentRaskopID: integer;
    procedure SetCurrentRaskopID( _RaskopID: integer );
    procedure SetCurrentRaskopToNULL;
  private
      procedure setMaintableName;
  protected
   f_TableName:String;
  end;

implementation

{$R *.dfm}

uses HelpFunctions, cntsLANG,frmLANG;

{ Tdm_Work }

procedure Tdm_Work.OpenDset;
var
  _s: string;
begin
//SetSQL();

  if F_IsObjZav then SetSQL; // by Vadim 01.03.2010
   setMaintableName();
  dset_S_WorkDetail.Close;
  _s := dset_S_WorkDetail.SelectSQL.Text;
  if F_IsCanAddRaskop then
    _s := Format( _s, [ '' ] )
  else
    _s := Format( _s, [ ' and ( ( id_work_type <> 1 ) or ( id_work_type is null ) )' ] );
  dset_S_WorkDetail.SelectSQL.Text := _s;
  dset_S_WorkDetail.Open;

  OpenSpr;
  //
  with dset_Works do
  begin
    Close;
    ParamByName( 'pZavID' ).AsInteger := F_ZavID;
    ParamByName( 'pNarID' ).AsInteger := F_NarID;
    Open;
  end;
end;

procedure Tdm_Work.dset_WorksAfterInsert(DataSet: TDataSet);
begin
  SetSprFiltered( true );

  dset_Works.FieldByName( 'id_zav' ).AsInteger := F_ZavID;
  dset_Works.FieldByName( 'id_nar' ).AsInteger := F_NarID;
  dset_Works.FieldByName( 'kol_work' ).AsFloat := 1;
end;

procedure Tdm_Work.dset_WorksAfterPost(DataSet: TDataSet);
begin
  tran_Main.CommitRetaining;
  dset_Works.Refresh;
  SetSprFiltered( false );
end;

procedure Tdm_Work.dset_S_WorkCalcFields(DataSet: TDataSet);
var
  _ed_izm, _name: string;
begin
  with DataSet do
  begin
    _ed_izm := trim( FieldByName( 'ed_izm' ).AsString );
    _name := trim( FieldByName( 'name_r' ).AsString );
    if _ed_izm <> '' then
      _name := _name + ' (' + _ed_izm + ')';
    FieldByName( 'clcFULL_NAME' ).AsString := _name;
  end;
end;

procedure Tdm_Work.dset_WorksAfterEdit(DataSet: TDataSet);
begin
  SetSprFiltered( true );
end;

procedure Tdm_Work.dset_WorksAfterCancel(DataSet: TDataSet);
begin
  SetSprFiltered( false );
  dset_Works.Refresh;
end;

procedure Tdm_Work.dset_WorksCalcFields(DataSet: TDataSet);
begin
  with DataSet do
  begin
    if ( not FieldByName( 'TZ_TRUDOZATRAT' ).IsNull ) and  ( FieldByName( 'TZ_KOL_ED' ).AsFloat > 0 ) then
      FieldByName( 'clcTOTAL_TZ' ).AsString :=
          FormatFloat( '0.##',
            ( FieldByName( 'TZ_TRUDOZATRAT' ).AsFloat / FieldByName( 'TZ_KOL_ED' ).AsFloat ) * FieldByName( 'KOL_WORK' ).AsFloat );


    if State in [ dsInsert, dsEdit ] then
    begin
      if F_MestTypeID <> -1 then
      begin
        if not FieldByName( 'TZ_TRUDOZATRAT' ).IsNull then
          FieldByName( 'clcTRUDOZATRAT' ).AsString :=
            FormatFloat( '0.##', FieldByName( 'TZ_TRUDOZATRAT' ).AsFloat ) + ' чел/час на ' +
            FormatFloat( '0.##', FieldByName( 'TZ_KOL_ED' ).AsFloat ) + ' ед.'
        else
          FieldByName( 'clcTRUDOZATRAT' ).AsString :=TrLangMSG(msgNotDefined)// 'не заданы';
      end else
        FieldByName( 'clcTRUDOZATRAT' ).AsString := TrLangMSG(msgFormZavNoDmL)//'на форме нар€да не задана местность пов.';
    end;
  end;
end;

procedure Tdm_Work.SetTrudozatratForCurrentRec;
var
  _tz: double;
  _DiamID: integer;
begin
  if ( F_MestTypeID <> -1 ) and ( dset_Works.State in [ dsInsert, dsEdit ] ) then
  begin
    if dset_Works.FieldByName( 'id_diam' ).IsNull then
      _DiamID := -1
    else
      _DiamID := dset_Works.FieldByName( 'id_diam' ).AsInteger;

    dset_SearchTZ.Close;
    dset_SearchTZ.ParamByName( 'pWorkID' ).AsInteger := dset_Works.FieldByName( 'id_work' ).AsInteger;
    dset_SearchTZ.ParamByName( 'pDiamID' ).AsInteger := _DiamID;
    dset_SearchTZ.ParamByName( 'pMestTypeID' ).AsInteger := F_MestTypeID;
    dset_SearchTZ.Open;

    if not dset_SearchTZ.Eof then
    begin
      if F_IsSummerPeriod then
        _tz := dset_SearchTZ.FieldByName( 'tz_summer' ).AsFloat
      else
        _tz := dset_SearchTZ.FieldByName( 'tz_winter' ).AsFloat;

      dset_Works.FieldByName( 'tz_kol_ed' ).AsFloat := dset_SearchTZ.FieldByName( 'kol_ed' ).AsFloat;
      dset_Works.FieldByName( 'tz_trudozatrat' ).AsFloat := _tz;
    end else
    begin
      dset_Works.FieldByName( 'tz_kol_ed' ).Clear;
      dset_Works.FieldByName( 'tz_trudozatrat' ).Clear;
    end;
  end;
end;

procedure Tdm_Work.SetWorkDate(Value: TDateTime);
var
  _Year, _Month, _Day: Word;
  _BeginSummer, _EndSummer: TDateTime;
begin
  DecodeDate( Value, _Year, _Month, _Day );

  _BeginSummer := EncodeDate( _Year, 4, 15 );  // 15 апрел€
  _EndSummer := EncodeDate( _Year, 10, 15 );   // 15 окт€бр€

  F_IsSummerPeriod := ( ( Value >= _BeginSummer ) and ( Value < _EndSummer ) );
end;

function Tdm_Work.IsInputValuesCorrect(var _ErrMsg: string;
  var _ErrFieldOrd: integer): boolean;
//
  procedure _Error( _Msg: string; _Field: TWorksField );
  begin
    _ErrMsg := _Msg;
    _ErrFieldOrd := Ord( _Field );
  end;
begin
  Result := false;
  _ErrMsg := '';
  _ErrFieldOrd := Ord( wfNull );

  if ( dset_Works.FieldByName( 'id_place' ).IsNull ) or
    ( dset_Works.FieldByName( 'id_place' ).AsInteger = -1 ) then
  begin
    _Error( TrLangMSG(msgNotFieldValue)+' "'+TrLangMSG(msgSpotPlace)+'" ',//Ќе задано поле "ћесто"',
            wfPlace );
    exit;
  end;

  if ( dset_Works.FieldByName( 'id_work' ).IsNull ) or
    ( dset_Works.FieldByName( 'id_work' ).AsInteger = -1 ) then
  begin
    _Error(  TrLangMSG(msgNotFieldValue)+' "'+TrLangMSG(msgWorkOne)+'" ',//'Ќе задано поле "–абота"',
            wfWork );
    exit;
  end;

  Result := true;
end;

procedure Tdm_Work.FillSprList;
begin
  {Ќапон€ем список справочников}
  F_SprList.Add( dset_S_Work );
  F_SprList.Add( dset_S_Place );
  F_SprList.Add( dset_S_Diam );
  F_SprList.Add( dset_S_KillClog );
  F_SprList.Add( dset_S_Pump );
  F_SprList.Add( dset_S_Pes );
  {/Ќапон€ем список справочников}
end;

procedure Tdm_Work.AddWorksAssignedWithBWork(_BWorkID, ID_IN_BWORKS: integer);
begin
  MyOpenIBDS( dset_tmp,
    ' select bww.id_bwork, bww.id_work, bww.id_diam,' +
    ' st.tz_summer, st.tz_winter, st.kol_ed, sw.ftype id_place' +
    ' from s_bwork_work bww' +
    ' left join s_work sw on ( sw.id = bww.id_work )' +
    ' left join s_trudozatrat st' +
    ' on ( ( st.id_work = bww.id_work ) and' +
    '      ( st.id_diam = bww.id_diam ) and' +
    '      ( st.id_mesttype = ' + IntToStr( F_MestTypeID ) + ' )' +
    '    )' +
    ' where ( not( id_work_type in (1,2) ) or ( id_work_type is null ) )' +
    ' and ( bww.id_bwork = ' + IntToStr( _BWorkID ) + ' )' );

  dset_tmp.First;
  while not dset_tmp.Eof do
  begin
    sql_InsertWork.Close;
    sql_InsertWork.ParamByName( 'id_zav' ).AsInteger := F_ZavID;
    sql_InsertWork.ParamByName( 'id_nar' ).AsInteger := F_NarID;
    sql_InsertWork.ParamByName( 'id_work' ).AsInteger := dset_tmp.FieldByName( 'id_work' ).AsInteger;
    sql_InsertWork.ParamByName( 'kol_work' ).AsFloat := 1;
    sql_InsertWork.ParamByName( 'id_diam' ).AsInteger := dset_tmp.FieldByName( 'id_diam' ).AsInteger;
    sql_InsertWork.ParamByName( 'id_place' ).AsInteger := dset_tmp.FieldByName( 'id_place' ).AsInteger;

    if F_IsSummerPeriod then
      sql_InsertWork.ParamByName( 'tz_trudozatrat' ).AsFloat := dset_tmp.FieldByName( 'tz_summer' ).AsFloat
    else
      sql_InsertWork.ParamByName( 'tz_trudozatrat' ).AsFloat := dset_tmp.FieldByName( 'tz_winter' ).AsFloat;

    sql_InsertWork.ParamByName( 'tz_kol_ed' ).AsFloat := dset_tmp.FieldByName( 'kol_ed' ).AsFloat;
    sql_InsertWork.ParamByName( 'bworks_id' ).AsInteger := ID_IN_BWORKS;

    sql_InsertWork.ExecQuery;

    dset_tmp.Next;
  end;
  dset_tmp.Close;

  tran_Main.CommitRetaining;
end;

procedure Tdm_Work.DataModuleCreate(Sender: TObject);
begin
  inherited;
  f_tableName := tableName;
  F_MestTypeID := -1;
  F_WorkKind := wkAll;
  F_IsCanAddRaskop := true;
  F_Raskop := Tdm_NGRaskop.Create(nil);




end;

procedure Tdm_Work.ResetWorksAttachAssignedWith_ID_IN_BWORKS(
  ID_IN_BWORKS: integer);
begin
  MyExecIBSQL( IBSQL,
    format(' update %s set' +
    ' bworks_id = null' +
    ' where bworks_id = ' + IntToStr( ID_IN_BWORKS ),[f_tableName] ));

  tran_Main.CommitRetaining;
end;

procedure Tdm_Work.DelWorksAssignedWith_ID_IN_BWORKS(
  ID_IN_BWORKS: integer);
begin
  MyExecIBSQL( IBSQL,
    format(' delete from %s' +
    ' where bworks_id = ' + IntToStr( ID_IN_BWORKS ),[F_tableName]));

  tran_Main.CommitRetaining;
end;

procedure Tdm_Work.Refilter;
begin
  dset_Works.DisableControls;
  try
    dset_Works.Filtered := false;
    dset_Works.Filtered := true;
  finally
    dset_Works.EnableControls;
  end;
end;

function Tdm_Work.RecalcAll_TZ( var _ErrMsg: string ): boolean;
var
  _bmark: string;
begin
  if F_MestTypeID <> -1 then
  begin
    dset_Works.DisableControls;
    try
      _bmark := dset_Works.Bookmark;

      dset_Works.First;
      while not dset_Works.Eof do
      begin
        dset_Works.Edit;
        SetTrudozatratForCurrentRec;
        dset_Works.Post;

        dset_Works.Next;
      end;

      dset_Works.Bookmark := _bmark;
    finally
      dset_Works.EnableControls;
    end;
    Result := true;
  end else
  begin
    Result := false;
    _ErrMsg :=  TrLangMSG(msgImpossRecalcTZ)+' '+TrLangMSG(msgFormZavNoDmL);//'Ќевозможно пересчитать трудозатраты,' + #13 +
                //'т.к. на форме нар€да не задана местность повреждени€!';
  end;
end;

procedure Tdm_Work.dset_WorkslpDIAMGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  inherited;
  if Sender.AsString = '0' then
    Text := ''
  else
    Text := Sender.AsString;
end;

procedure Tdm_Work.dset_WorksTZ_KOL_EDGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  inherited;
  if Sender.AsFloat < 0.01 then
    Text := ''
  else
    Text := FormatFloat( '0.##', Sender.AsFloat )
end;

function Tdm_Work.GetCurrentWorkTypeID: integer;
begin
  Result := 0;

  dset_GetWorkType.Close;
  dset_GetWorkType.ParamByName( 'pWorkID' ).AsInteger :=
    dset_Works.FieldByName( 'ID_WORK' ).AsInteger;
  dset_GetWorkType.Open;

  if not dset_GetWorkType.IsEmpty then
    Result := dset_GetWorkType.FieldByName( 'ID_WORK_TYPE' ).AsInteger;

  dset_GetWorkType.Close;
end;

procedure Tdm_Work.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  F_Raskop.Free;
end;

function Tdm_Work.GetCurrentRaskopID: integer;
begin
  if ( dset_Works.Active ) and ( not dset_Works.IsEmpty ) and
    ( dset_Works.FieldByName( 'ID_RASKOP' ).AsInteger > 0 )
  then
    Result := dset_Works.FieldByName( 'ID_RASKOP' ).AsInteger
  else
    Result := -1;
end;

procedure Tdm_Work.SetCurrentRaskopID(_RaskopID: integer);
begin
  if dset_Works.State in [dsInsert, dsEdit] then
    dset_Works.FieldByName( 'ID_RASKOP' ).AsInteger := _RaskopID;
end;

procedure Tdm_Work.SetCurrentRaskopToNULL;
begin
  if dset_Works.State in [dsInsert, dsEdit] then
    dset_Works.FieldByName( 'ID_RASKOP' ).Clear;
end;

// 01.03.2010 by Vadim

procedure Tdm_Work.SetSQL;
var _selectSQL, _modifiSQL, _insertSQL1 , _insertSQL2 : string;

    procedure GetAddSQLObjObor;
    begin
      if (F_IdObjObor >0 ) then
        begin
        _selectSQL := ' and ( id_objobor = '+ inttostr(F_IdObjObor) +' ) ';
        _modifiSQL := ' ,id_objobor = '+ inttostr(F_IdObjObor) ;
        _insertSQL1 := ' , id_objobor ';
        _insertSQL2 := ' , '+ inttostr(F_IdObjObor);
        end
        else
        begin
         _selectSQL := ' and (( id_objobor = -1 ) or (id_objobor is null))';
        _modifiSQL := '';
        _insertSQL1 := '';
        _insertSQL2 := '';
        end;
    end;


begin
 GetAddSQLObjObor;

  dset_Works.SelectSQL.Text := 'select w.id, w.id_zav, w.id_nar, w.id_work, '+
    ' w.kol_work, w.id_diam, w.id_place, '+
    ' w.id_killclog, w.id_pump, w.id_pes, '+
    ' w.tz_trudozatrat, w.tz_kol_ed, '+
    ' w.bworks_id, w.id_raskop '+
    ' from %s w '+
    ' left join s_work sw on sw.id = w.id_work '+
    ' left join s_diam sd on sd.id = w.id_diam '+
    ' where ( id_zav = :pZavID ) and '+
    ' ( id_nar = :pNarID ) '+ _selectSQL +
    ' order by w.id' ;
  dset_Works.ModifySQL.Text := 'update %s set ' +
    ' id_zav = :id_zav, ' +
    ' id_nar = :id_nar, ' +
    ' id_work = :id_work, ' +
    ' kol_work = :kol_work, ' +
    ' id_diam = :id_diam, ' +
    ' id_place = :id_place, ' +
    ' id_killclog = :id_killclog, ' +
    ' id_pump = :id_pump, ' +
    ' id_pes = :id_pes, ' +
    ' tz_trudozatrat = :tz_trudozatrat, ' +
    ' tz_kol_ed = :tz_kol_ed, ' +
    ' id_raskop =:id_raskop ' + _modifiSQL +
    ' where id = :id ';

    dset_Works.InsertSQL.Text := 'insert into %s( '+
          ' id, id_zav, id_nar, id_work, '+
          ' kol_work, id_diam, id_place, '+
          ' id_killclog, id_pump, id_pes, '+
          ' tz_trudozatrat, tz_kol_ed, id_raskop '+ _insertSQL1 + ') '+
          ' values( '+
          ' :id, :id_zav, :id_nar, :id_work, '+
          ' :kol_work, :id_diam, :id_place, '+
          ' :id_killclog, :id_pump, :id_pes, '+
          ' :tz_trudozatrat, :tz_kol_ed, :id_raskop' + _insertSQL2 + ')';

   sql_InsertWork.SQL.Text := ' insert into %s( '+
    ' id_zav, id_nar, id_work, kol_work, id_diam, id_place, '+
    ' tz_trudozatrat, tz_kol_ed, bworks_id'+ _insertSQL1 + ') '+
    ' values( :id_zav, :id_nar, :id_work, :kol_work, :id_diam, :id_place, '+
    ' :tz_trudozatrat, :tz_kol_ed, :bworks_id'+ _insertSQL2 + ')';

   setMaintableName();

end;

//используетс€ дл€ работы с запланироваными работаем тогда данные нужно брать из works_Plzn
procedure Tdm_Work.setMaintableName();
begin
  dset_Works.SelectSQL.Text:=format(  dset_Works.SelectSQL.Text,[f_tablename]);
  dset_Works.ModifySQL.Text:=format( dset_Works.ModifySQL.Text,[f_tablename]);
  dset_Works.InsertSQL.Text:=format( dset_Works.InsertSQL.Text,[f_tablename]);
  sql_InsertWork.SQL.Text:=format( sql_InsertWork.SQL.Text,[f_tablename]);
  dset_Works.RefreshSQL.Text:=format( dset_Works.RefreshSQL.Text,[f_tablename]);
  dset_Works.DeleteSQL.Text:=format( dset_Works.DeleteSQL.Text,[f_tablename]);
end;

end.
