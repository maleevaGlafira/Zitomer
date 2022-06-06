unit NGRaskopDM;

interface

uses
  SysUtils, Classes, DMMain, DB, IBCustomDataSet, IBDatabase, IBSQL, avartype;

type
  TRaskopField = ( rfUlKod, rfUl1, rfUl2, rfHouse, rfMest );

  TFindIncorrectFieldEvent = procedure ( _ErrMsg: string; _IncorrectField: TRaskopField ) of object;

  TRaskopEditMode = ( remEditAll, remEditOne );

  TRaskopRec=record
    AdresRec: TAdresRec;
    id_mest: integer;
    Peredano: string;
    dt_act: TDateTime;
    id_bract: integer;
    NeedWorks: string;
  end;

  Tdm_NGRaskop = class(TDataModule)
    tran_Raskop: TIBTransaction;
    dset_Raskop: TIBDataSet;
    dset_RaskopID: TIntegerField;
    dset_RaskopID_ZAVIN: TIntegerField;
    dset_RaskopID_ZAVOUT: TIntegerField;
    dset_RaskopID_UL1: TIntegerField;
    dset_RaskopID_UL2: TIBStringField;
    dset_RaskopUL_KOD: TIntegerField;
    dset_RaskopDOP_ADR: TIBStringField;
    dset_RaskopID_DOPADRES: TIntegerField;
    dset_RaskopPEREDANO: TIBStringField;
    dset_RaskopDT_ACT: TDateTimeField;
    dset_RaskopID_BRACT: TIntegerField;
    dset_RaskopNEEDWORKS: TIBStringField;
    dset_S_Ulic1: TIBDataSet;
    dset_S_Ulic2: TIBDataSet;
    dset_tadr: TIBDataSet;
    tran_Spr: TIBTransaction;
    dset_S_Ulic1ID: TIntegerField;
    dset_S_Ulic1NAME_R: TIBStringField;
    dset_S_Ulic1DEL: TIBStringField;
    dset_S_Ulic2ID: TIntegerField;
    dset_S_Ulic2NAME_R: TIBStringField;
    dset_S_Ulic2DEL: TIBStringField;
    dset_tadrID: TIntegerField;
    dset_tadrNAME_R: TIBStringField;
    dset_S_DopAdres: TIBDataSet;
    dset_S_DopAdresID: TIntegerField;
    dset_S_DopAdresNAME_R: TIBStringField;
    dset_S_DopAdresDEL: TIBStringField;
    dset_S_Brig_Act: TIBDataSet;
    dset_S_Brig_ActID: TIntegerField;
    dset_S_Brig_ActNAME_R: TIBStringField;
    dset_S_Brig_ActDEL: TIBStringField;
    dset_GetMaxRaskopID: TIBDataSet;
    sql_tmp: TIBSQL;
    tran_tmp: TIBTransaction;
    dset_Raskopclc_RASKOP_INFO: TStringField;
    dset_RaskopADRES: TIBStringField;
    dset_RaskopID_MEST: TIntegerField;
    dset_RaskopMEST: TIBStringField;
    dset_S_Mest: TIBDataSet;
    dset_S_MestID: TIntegerField;
    dset_S_MestNAME_R: TIBStringField;
    dset_S_MestDEL: TIBStringField;
    dset_RaskopID_BRBLAG: TIntegerField;
    dset_RaskopR_LEN: TIBBCDField;
    dset_RaskopR_WID: TIBBCDField;
    dset_RaskopR_DEP: TIBBCDField;
    dset_RaskopR_OGRAGD: TIBStringField;
    dset_S_Ogragd: TIBDataSet;
    IntegerField1: TIntegerField;
    IBStringField1: TIBStringField;
    IBStringField2: TIBStringField;
    dset_RaskopPLANDATEEXCAV: TDateTimeField;
    dset_RaskopDATEORG: TDateTimeField;
    dset_RaskopDATECLOSEDDOCUMENT: TDateTimeField;
    dset_s_orgRoad: TIBDataSet;
    dset_s_balancekeeper: TIBDataSet;
    dset_s_balancekeeperID: TIntegerField;
    dset_s_balancekeeperNAME: TIBStringField;
    dset_s_balancekeeperDEL: TIBStringField;
    dset_s_orgRoadID: TIntegerField;
    dset_s_orgRoadNAME: TIBStringField;
    dset_s_orgRoadDEL: TIBStringField;
    dset_RaskopID_BALANCEKEPPER: TIntegerField;
    dset_RaskopID_ORGROAD: TIntegerField;
    dset_RaskopNUMBERROAD: TIBStringField;
    dset_RaskopNUMBERCHEB: TIBStringField;
    dset_RaskopDT_CHEB: TDateTimeField;
    dset_RaskopDT_DOWNASFALT: TDateTimeField;
    dset_RaskopDT_UPASFALT: TDateTimeField;
    dset_RaskopDT_PLAN_SAND: TDateTimeField;
    dset_id_rayon: TIBDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure dset_RaskopAfterOpen(DataSet: TDataSet);
    procedure dset_RaskopAfterInsert(DataSet: TDataSet);
    procedure dset_RaskopAfterEdit(DataSet: TDataSet);
    procedure dset_RaskopAfterPost(DataSet: TDataSet);
    procedure dset_RaskopAfterDelete(DataSet: TDataSet);
    procedure DataModuleDestroy(Sender: TObject);
    procedure SprFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure dset_RaskopAfterCancel(DataSet: TDataSet);
    procedure dset_RaskopAfterScroll(DataSet: TDataSet);
    procedure dset_RaskopID_UL2GetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure dset_RaskopBeforePost(DataSet: TDataSet);
    procedure dset_RaskopBeforeInsert(DataSet: TDataSet);
    procedure dset_RaskopBeforeDelete(DataSet: TDataSet);
    procedure dset_RaskopCalcFields(DataSet: TDataSet);
    procedure dset_RaskopFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
  private
    F_ZavID: integer;
    F_ZavNum: string;
    F_ZavDT_IN: string;
    F_EditOneRaskopID: integer;
    F_DefaultActiveRaskopID: integer;
    F_IsReadOnly: boolean;
    F_IsInternalMode: boolean;
    F_IsNeedReopenAfterPost: boolean;
    F_RaskopEditMode: TRaskopEditMode;
    F_DefaultAdres: TAdresRec;
    F_SprList: TList;
    procedure OpenRaskop;
    procedure OpenSpr;
    procedure FillSprList;
    procedure SetSprFiltered( _IsFiltered: boolean );
    procedure AbortDataSet;
  private
    F_OnAfterRaskopOpen: TDataSetNotifyEvent;
    F_OnAfterRaskopScroll: TDataSetNotifyEvent;
    F_OnFindIncorrectField: TFindIncorrectFieldEvent;
    F_OnBeforeDataSetAbort: TDataSetNotifyEvent;
    F_OnAfterRaskopPost: TDataSetNotifyEvent;
    F_CloseZavDateTime:TDateTime;
    f_rayon:integer;
  public
    {Поля для ввода перед стартом транзакции}
    property ZavID: integer read F_ZavID write F_ZavID;
    property ZavNum: string read F_ZavNum write F_ZavNum;
    property ZavDT_IN: string read F_ZavDT_IN write F_ZavDT_IN;
    property EditOneRaskopID: integer read F_EditOneRaskopID write F_EditOneRaskopID;
    property IsReadOnly: boolean read F_IsReadOnly write F_IsReadOnly;
    property RaskopEditMode: TRaskopEditMode read F_RaskopEditMode write F_RaskopEditMode;
    property DefaultAdres: TAdresRec read F_DefaultAdres write F_DefaultAdres;
    property DefaultActiveRaskopID: integer read F_DefaultActiveRaskopID
      write F_DefaultActiveRaskopID;
    property OnAfterRaskopOpen: TDataSetNotifyEvent read F_OnAfterRaskopOpen
      write F_OnAfterRaskopOpen;
    property OnAfterRaskopScroll: TDataSetNotifyEvent read F_OnAfterRaskopScroll
      write F_OnAfterRaskopScroll;
    property OnFindIncorrectField: TFindIncorrectFieldEvent read F_OnFindIncorrectField
      write F_OnFindIncorrectField;
    property OnBeforeDataSetAbort: TDataSetNotifyEvent read F_OnBeforeDataSetAbort
      write F_OnBeforeDataSetAbort;
    property OnAfterRaskopPost: TDataSetNotifyEvent read F_OnAfterRaskopPost
      write F_OnAfterRaskopPost;
    property CloseZavDateTime:TDateTime read F_CloseZavDateTime write F_CloseZavDateTime;
    {/Поля для ввода перед стартом транзакции}
  public
    {После старта транзакции}
    function IsFieldsValueCorrect( var _ErrMsg: string; var _IncorrectField: TRaskopField ): boolean;
    function IsCanEditCurrentRaskop: boolean;
    function IsCanDelCurrentRaskop: boolean;
    function IsCanRestoreCurrentRaskop: boolean;
    function IsCanAddNewRaskop: boolean;
    function IsCurrentRaskopIsEditOne: boolean;
    function IsCurrentRaskopRestored: boolean;
    function GetCurrentRaskopID: integer;
    function GetCurrentMestID: integer;
    procedure SetActiveRaskop( _RaskopID: integer );
    procedure SetIsVisibleRestoredRaskop( _IsVisible: boolean );
    procedure CopyRaskop;
    procedure RestoreRaskop;
    {/После старта транзакции}
  public
    procedure StartTran;
    procedure CommitTran;
    procedure RollbackTran;
  public
    procedure DeleteRaskop( _RaskopID: integer );
    property Rayon :integer write F_rayon;
  private
      procedure getRayonFromZav();
      procedure setIdZav(id:integer);
  end;

var
  dm_NGRaskop: Tdm_NGRaskop;

implementation

{$R *.dfm}

uses HelpFunctions , cntsLANG,frmLANG;

procedure Tdm_NGRaskop.CommitTran;
begin
  tran_Raskop.Commit;
  tran_Spr.Commit;
end;

procedure Tdm_NGRaskop.DataModuleCreate(Sender: TObject);
begin
  F_ZavID := -1;
  F_EditOneRaskopID := -1;
  F_IsReadOnly := false;
  F_IsInternalMode := false;
  F_IsNeedReopenAfterPost := false;
  F_RaskopEditMode := remEditAll;
  F_DefaultActiveRaskopID := -1;

  F_DefaultAdres.kod_ul := 0;
  F_DefaultAdres.id_ul1 := -1;
  F_DefaultAdres.id_ul2 := '';
  F_DefaultAdres.dop_adr := '';
  F_DefaultAdres.id_DopAdres := -1;

  F_SprList := TList.Create;
  FillSprList;

  SetIsVisibleRestoredRaskop( true );
end;

procedure Tdm_NGRaskop.RollbackTran;
begin
  if tran_Raskop.InTransaction then tran_Raskop.Rollback;
  if tran_Spr.InTransaction then tran_Spr.Rollback;
end;

procedure Tdm_NGRaskop.StartTran;
begin
  if tran_Raskop.InTransaction then tran_Raskop.Rollback;
  tran_Raskop.StartTransaction;

  if tran_Spr.InTransaction then tran_Spr.Rollback;
  tran_Spr.StartTransaction;

  OpenSpr;
  OpenRaskop;
end;

procedure Tdm_NGRaskop.dset_RaskopAfterOpen(DataSet: TDataSet);
begin
  dset_Raskop.Last;

  if F_RaskopEditMode = remEditOne then
  begin
    if not dset_Raskop.Locate( 'ID', F_EditOneRaskopID, [] ) then
      if not dset_Raskop.Locate( 'ID', F_DefaultActiveRaskopID, [] ) then
        dset_Raskop.Last;
  end else
  begin
    if not dset_Raskop.Locate( 'ID', F_DefaultActiveRaskopID, [] ) then
      dset_Raskop.Last;
  end;

  if Assigned( F_OnAfterRaskopOpen ) then
    F_OnAfterRaskopOpen( DataSet );
end;

function Tdm_NGRaskop.IsFieldsValueCorrect(var _ErrMsg: string; var _IncorrectField: TRaskopField): boolean;
  procedure _Error( _Msg: string; _Field: TRaskopField);
  begin
    _ErrMsg := _Msg;
    _IncorrectField := _Field;
  end;
begin
  Result := false;
  _ErrMsg := '';

  if dset_Raskop.FieldByName( 'UL_KOD' ).IsNull then
  begin
    _Error( TrLangMSG(msgNeedTadr){'Введите тип адреса!'}, rfUlKod );
    exit;
  end;

  if ( dset_Raskop.FieldByName( 'UL_KOD' ).AsInteger in [0,1] ) and
    ( dset_Raskop.FieldByName( 'ID_UL1' ).AsInteger < 1 )
  then
  begin
    _Error( TrLangMSG(msgNeedStreet){'Введите наименование улицы!'}, rfUl1 );
    exit;
  end;

  case dset_Raskop.FieldByName( 'UL_KOD' ).AsInteger of
    0: //Улица, номер дома
      if trim( dset_Raskop.FieldByName( 'ID_UL2' ).AsString ) = '' then
      begin
        _Error( TrLangMSG(msgNeedHouse){'Введите номер дома!'}, rfHouse );
        exit;
      end;
    1: //Перекресток
      if StrToInt( trim( dset_Raskop.FieldByName( 'ID_UL2' ).AsString ) ) < 1 then
      begin
        _Error(TrLangMSG(msgNeedStreet2) {'Введите наименование улицы №2!'}, rfUl2 );
        exit;
      end;
  end;

  if dset_Raskop.FieldByName( 'ID_MEST' ).AsInteger < 1 then
  begin
    _Error( TrLangMSG( msgNeedPlace){'Введите местность повреждения!'}, rfMest );
    exit;
  end;

  Result := true;
end;

procedure Tdm_NGRaskop.dset_RaskopAfterInsert(DataSet: TDataSet);
begin
  SetSprFiltered( true );

  F_IsInternalMode := true;
  try
    dset_Raskop.FieldByName( 'ID_ZAVIN' ).AsInteger := F_ZavID;
    dset_Raskop.FieldByName( 'ID_ZAVOUT' ).AsInteger := 0;  //важно
    dset_Raskop.FieldByName( 'ID_BRACT' ).AsInteger := -1;

    dset_Raskop.FieldByName( 'UL_KOD' ).AsInteger := F_DefaultAdres.kod_ul;
    dset_Raskop.FieldByName( 'ID_UL1' ).AsInteger := F_DefaultAdres.id_ul1;
    dset_Raskop.FieldByName( 'ID_UL2' ).AsString := trim( F_DefaultAdres.id_ul2 );
    dset_Raskop.FieldByName( 'DOP_ADR' ).AsString := trim( F_DefaultAdres.dop_adr );
    dset_Raskop.FieldByName( 'ID_DOPADRES' ).AsInteger := F_DefaultAdres.id_DopAdres;
  finally
    F_IsInternalMode := false;
  end;

  F_IsNeedReopenAfterPost := true;
end;

procedure Tdm_NGRaskop.dset_RaskopAfterEdit(DataSet: TDataSet);
begin
  SetSprFiltered( true );
  F_IsNeedReopenAfterPost := false;
end;

procedure Tdm_NGRaskop.dset_RaskopAfterPost(DataSet: TDataSet);
begin
  SetSprFiltered( false );

  //tran_Raskop.CommitRetaining;

  if F_IsNeedReopenAfterPost then
    OpenRaskop
  else
    dset_Raskop.Refresh;

  if ( F_RaskopEditMode = remEditOne ) and ( F_EditOneRaskopID = -1 ) then
  begin
    dset_GetMaxRaskopID.Close;
    dset_GetMaxRaskopID.ParamByName( 'pZavID' ).AsInteger := F_ZavID;
    dset_GetMaxRaskopID.Open;
    if not dset_GetMaxRaskopID.IsEmpty then
      F_EditOneRaskopID := dset_GetMaxRaskopID.FieldByName( 'MAX_ID' ).AsInteger;
    dset_GetMaxRaskopID.Close;
  end;

  if Assigned( F_OnAfterRaskopPost ) then
    F_OnAfterRaskopPost( DataSet );
end;

procedure Tdm_NGRaskop.OpenRaskop;
begin
  dset_Raskop.Close;
  dset_Raskop.ParamByName( 'pZavID' ).AsInteger := F_ZavID;
  dset_Raskop.Open;
end;

procedure Tdm_NGRaskop.dset_RaskopAfterDelete(DataSet: TDataSet);
begin
  //tran_Raskop.CommitRetaining;
  OpenRaskop;
end;

procedure Tdm_NGRaskop.DataModuleDestroy(Sender: TObject);
var
  _IsErr: boolean;
begin
  F_SprList.Free;

  _IsErr := false;
  if tran_Raskop.InTransaction then
  begin
    tran_Raskop.Rollback;
    _IsErr := true;
  end;
  if tran_Spr.InTransaction then
  begin
    tran_Spr.Rollback;
    _IsErr := true;
  end;
  if _IsErr then
    raise Exception.Create( TrLangMSG( msgNeedPlace)+' Tdm_NGRaskop.DataModuleDestroy '{'Имеется активная транзакция ( Tdm_NGRaskop.DataModuleDestroy )'} );
end;

procedure Tdm_NGRaskop.FillSprList;
begin
  F_SprList.Add( dset_tadr );
  F_SprList.Add( dset_S_Ulic1 );
  F_SprList.Add( dset_S_Ulic2 );
  F_SprList.Add( dset_S_DopAdres );
  F_SprList.Add( dset_S_Brig_Act );
  F_SprList.Add( dset_S_Mest );
  F_SprList.Add( dset_S_Ogragd );

  F_SprList.Add( dset_s_orgRoad);
  F_SprList.Add( dset_s_balancekeeper);
  if F_rayon>0 then
  begin
    dset_S_Ulic1.Filter:='ID_RAYON='+intToStr(F_rayon)+' or id=-1' ;
    dset_S_Ulic2.Filter:='ID_RAYON='+intToStr(F_rayon)+' or id=-1' ;
  end;


end;

procedure Tdm_NGRaskop.OpenSpr;
var
  i: integer;
  _dset: TDataSet;
begin
  for i:=0 to F_SprList.Count-1 do
  begin
    _dset := TDataSet( F_SprList.Items[ i ] );
    _dset.Close;
    _dset.Open;
  end;
end;

procedure Tdm_NGRaskop.SetSprFiltered(_IsFiltered: boolean);
var
  i: integer;
begin
  for i:=0 to F_SprList.Count-1 do
    TDataSet( F_SprList.Items[ i ] ).Filtered := _IsFiltered;
end;

procedure Tdm_NGRaskop.dset_RaskopAfterCancel(DataSet: TDataSet);
begin
  SetSprFiltered( false );
end;

procedure Tdm_NGRaskop.SprFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  if Assigned( DataSet.FindField( 'del' ) ) then
    Accept := ( trim( DataSet.FieldByName( 'del' ).AsString ) = '-' );
end;

procedure Tdm_NGRaskop.dset_RaskopAfterScroll(DataSet: TDataSet);
begin
  if Assigned( F_OnAfterRaskopScroll ) then
    F_OnAfterRaskopScroll( DataSet );
end;

function Tdm_NGRaskop.IsCanEditCurrentRaskop: boolean;
begin
  Result := ( ( dset_Raskop.RecordCount > 0 ) or ( dset_Raskop.State = dsInsert )) and
    ( not F_IsReadOnly );

  if not( dset_Raskop.State in [dsInsert, dsEdit] ) then
    Result := Result and ( not IsCurrentRaskopRestored );

  if F_RaskopEditMode = remEditOne then
    Result := Result and ( ( dset_Raskop.FieldByName( 'ID' ).AsInteger = F_EditOneRaskopID )
      or ( dset_Raskop.State = dsInsert ) );
end;

procedure Tdm_NGRaskop.dset_RaskopID_UL2GetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  Text := trim( Sender.AsString );
end;

procedure Tdm_NGRaskop.dset_RaskopBeforePost(DataSet: TDataSet);
var
  _ErrMsg: string;
  _IncorrectField: TRaskopField;
begin
  if IsCanEditCurrentRaskop then
  begin
    if not IsFieldsValueCorrect( _ErrMsg, _IncorrectField ) then
    begin
      if Assigned( F_OnFindIncorrectField ) then
        F_OnFindIncorrectField( _ErrMsg, _IncorrectField );

      AbortDataSet;
    end;
  end else AbortDataSet;
end;

procedure Tdm_NGRaskop.dset_RaskopBeforeInsert(DataSet: TDataSet);
begin
  if F_IsReadOnly then AbortDataSet;
end;

procedure Tdm_NGRaskop.dset_RaskopBeforeDelete(DataSet: TDataSet);
begin
   if not IsCanDelCurrentRaskop then AbortDataSet;
end;

procedure Tdm_NGRaskop.AbortDataSet;
begin
  if Assigned( F_OnBeforeDataSetAbort ) then
    F_OnBeforeDataSetAbort( dset_Raskop );
  Abort;
end;

function Tdm_NGRaskop.IsCanAddNewRaskop: boolean;
begin
  Result := ( not F_IsReadOnly ) and not( dset_Raskop.State in [dsInsert, dsEdit] );

  if F_RaskopEditMode = remEditOne then
    Result := Result and ( F_EditOneRaskopID = -1 );
end;

function Tdm_NGRaskop.IsCurrentRaskopIsEditOne: boolean;
begin
  Result := ( F_RaskopEditMode = remEditOne ) and
    ( F_EditOneRaskopID = dset_Raskop.FieldByName( 'ID' ).AsInteger );
end;

procedure Tdm_NGRaskop.DeleteRaskop(_RaskopID: integer);
begin
  if tran_tmp.InTransaction then tran_tmp.Rollback;
  tran_tmp.StartTransaction;
  try
    HelpFunctions.MyExecIBSQL( sql_tmp,
      'delete from RASKOP where ID = ' + IntToStr( _RaskopID ) );

    tran_tmp.Commit;
  except
    on E: Exception do
    begin
      tran_tmp.Rollback;
      E.Message := E.Message + '(Tdm_NGRaskop.DeleteRaskop(_RaskopID: integer))';
      raise;
    end;
  end;
end;

procedure Tdm_NGRaskop.dset_RaskopCalcFields(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName( 'clc_RASKOP_INFO' ).AsString := trim( FieldByName( 'ADRES' ).AsString ) +
      ' :: ' + trim( FieldByName( 'MEST' ).AsString );
  end;
end;

function Tdm_NGRaskop.GetCurrentRaskopID: integer;
begin
  if dset_Raskop.Active and not dset_Raskop.IsEmpty then
    Result := dset_Raskop.FieldByName( 'ID' ).AsInteger
  else
    Result := -1;
end;

procedure Tdm_NGRaskop.CopyRaskop;
var
  _buff: TRaskopRec;
begin
  if ( not dset_Raskop.IsEmpty ) and  not( dset_Raskop.State in [dsInsert, dsEdit] ) then
  begin
    _buff.AdresRec.kod_ul := dset_Raskop.FieldByName( 'UL_KOD' ).AsInteger;
    _buff.AdresRec.id_ul1 := dset_Raskop.FieldByName( 'ID_UL1' ).AsInteger;
    _buff.AdresRec.id_ul2 := dset_Raskop.FieldByName( 'ID_UL2' ).AsString;
    _buff.AdresRec.dop_adr := dset_Raskop.FieldByName( 'DOP_ADR' ).AsString;
    _buff.AdresRec.id_DopAdres := dset_Raskop.FieldByName( 'ID_DOPADRES' ).AsInteger;
    _buff.id_mest := dset_Raskop.FieldByName( 'ID_MEST' ).AsInteger;
    _buff.Peredano := dset_Raskop.FieldByName( 'PEREDANO' ).AsString;
    _buff.dt_act := dset_Raskop.FieldByName( 'DT_ACT' ).AsDateTime;
    _buff.id_bract := dset_Raskop.FieldByName( 'ID_BRACT' ).AsInteger;
    _buff.NeedWorks := dset_Raskop.FieldByName( 'NEEDWORKS' ).AsString;


    dset_Raskop.Append;

    dset_Raskop.FieldByName( 'UL_KOD' ).AsInteger := _buff.AdresRec.kod_ul;
    dset_Raskop.FieldByName( 'ID_UL1' ).AsInteger := _buff.AdresRec.id_ul1;
    dset_Raskop.FieldByName( 'ID_UL2' ).AsString := _buff.AdresRec.id_ul2;
    dset_Raskop.FieldByName( 'DOP_ADR' ).AsString := _buff.AdresRec.dop_adr;
    dset_Raskop.FieldByName( 'ID_DOPADRES' ).AsInteger := _buff.AdresRec.id_DopAdres;
    dset_Raskop.FieldByName( 'ID_MEST' ).AsInteger := _buff.id_mest;
    dset_Raskop.FieldByName( 'PEREDANO' ).AsString := _buff.Peredano;
    dset_Raskop.FieldByName( 'DT_ACT' ).AsDateTime := _buff.dt_act;
    dset_Raskop.FieldByName( 'ID_BRACT' ).AsInteger := _buff.id_bract;
    dset_Raskop.FieldByName( 'NEEDWORKS' ).AsString := _buff.NeedWorks;
  end;
end;

procedure Tdm_NGRaskop.SetActiveRaskop(_RaskopID: integer);
begin
  if not dset_Raskop.Locate( 'ID', _RaskopID, [] ) then
    dset_Raskop.Last;
end;

function Tdm_NGRaskop.GetCurrentMestID: integer;
begin
  if dset_Raskop.Active and not dset_Raskop.IsEmpty then
    Result := dset_Raskop.FieldByName( 'ID_MEST' ).AsInteger
  else
    Result := -1;
end;

procedure Tdm_NGRaskop.RestoreRaskop;
var
  _ErrMsg: string;
  _IncorrectField: TRaskopField;
begin
  if ( dset_Raskop.State <> dsInsert ) and (not dset_Raskop.IsEmpty ) then
  begin
    if not IsFieldsValueCorrect( _ErrMsg, _IncorrectField ) then
    begin
      if Assigned( F_OnFindIncorrectField ) then
        F_OnFindIncorrectField( _ErrMsg, _IncorrectField );
    end else
    begin
      if dset_Raskop.State <> dsEdit then dset_Raskop.Edit;
      dset_Raskop.FieldByName( 'ID_ZAVOUT' ).AsInteger := F_ZavID;
      dset_Raskop.Post;
    end;
  end;
end;

function Tdm_NGRaskop.IsCanRestoreCurrentRaskop: boolean;
begin
  Result := ( dset_Raskop.RecordCount > 0 ) and not( dset_Raskop.State in [dsEdit, dsInsert] ) and
    ( not F_IsReadOnly ) and ( not IsCurrentRaskopRestored ) ;
end;

function Tdm_NGRaskop.IsCurrentRaskopRestored: boolean;
begin
  Result := ( dset_Raskop.Active ) and ( not dset_Raskop.IsEmpty ) and
    ( dset_Raskop.FieldByName( 'ID_ZAVOUT' ).AsInteger > 0  );
end;

procedure Tdm_NGRaskop.SetIsVisibleRestoredRaskop(_IsVisible: boolean);
begin
  dset_Raskop.Filtered := not _IsVisible;
end;

procedure Tdm_NGRaskop.dset_RaskopFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept := ( dset_Raskop.FieldByName( 'ID_ZAVOUT' ).AsInteger < 1 );
end;

function Tdm_NGRaskop.IsCanDelCurrentRaskop: boolean;
begin
  Result := ( dset_Raskop.RecordCount > 0 ) and ( not F_IsReadOnly );
{
  if not( dset_Raskop.State in [dsInsert, dsEdit] ) then
    Result := Result and ( not IsCurrentRaskopRestored );
}
end;

procedure Tdm_NGRaskop.getRayonFromZav();
begin
    dset_id_rayon.SelectSQL.Text:='select z.id_rayon from nzavjav  z where id='+IntToStr(F_ZavID);
    dset_id_rayon.Open;
    if dset_id_rayon.IsEmpty then
    begin
      dset_id_rayon.close;
      dset_id_rayon.SelectSQL.Text:='select z.id_rayon from zavjav  z where id='+IntToStr(F_ZavID);
     dset_id_rayon.Open;
    end;
    dset_id_rayon.First;
    F_rayon:= dset_id_rayon.fieldbyname('id_rayon').AsInteger;
    if F_rayon>0 then
    begin
      dset_S_Ulic1.Filter:='ID_RAYON='+intToStr(F_rayon)+' or id=-1' ;
      dset_S_Ulic2.Filter:='ID_RAYON='+intToStr(F_rayon)+' or id=-1' ;
   end;
end;

procedure Tdm_NGRaskop.setIdZav(id:integer);
begin
 F_ZavID:=id;
 getRayonFromZav();
end;

end.
