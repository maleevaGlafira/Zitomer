unit MaterDM;

interface

uses
  SysUtils, Classes, BaseNarDetailDM, IBDatabase, DB, IBCustomDataSet,
  IBSQL, BaseWorkAndMatDM;

type
  TMatersField = (mfNull, mfMater);

  Tdm_Mater = class(Tdm_BaseWorkAndMat)
    dset_Mater: TIBDataSet;
    dset_MaterID: TIntegerField;
    dset_MaterID_ZAV: TIntegerField;
    dset_MaterID_NAR: TIntegerField;
    dset_MaterID_MAT: TIntegerField;
    dset_MaterKOL_MAT: TFloatField;
    dset_MaterID_DIAM: TIntegerField;
    dset_S_Mat: TIBDataSet;
    dset_S_Diam: TIBDataSet;
    dset_S_MatID: TIntegerField;
    dset_S_MatNAME_R: TIBStringField;
    dset_S_MatED_IZM: TIBStringField;
    dset_S_MatDEL: TIBStringField;
    dset_S_DiamID: TIntegerField;
    dset_S_DiamDIAM: TIntegerField;
    dset_S_DiamDEL: TIBStringField;
    dset_S_Matclc_FullName: TStringField;
    dset_S_Diamclc_Diam: TStringField;
    dset_Materlp_Mat: TStringField;
    dset_Materlp_Diam: TStringField;
    dset_tmp: TIBDataSet;
    sql_InsertMater: TIBSQL;
    IBSQL: TIBSQL;
    dset_MaterBWORKS_ID: TIntegerField;
    procedure dset_S_MatCalcFields(DataSet: TDataSet);
    procedure dset_S_DiamCalcFields(DataSet: TDataSet);
    procedure dset_MaterAfterPost(DataSet: TDataSet);
    procedure dset_MaterAfterInsert(DataSet: TDataSet);
    procedure dset_MaterAfterEdit(DataSet: TDataSet);
    procedure dset_MaterAfterCancel(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure FillSprList; override;
    procedure  setSQL();
  public
    procedure OpenDset; override;
    function IsInputValuesCorrect( var _ErrMsg: string; var _ErrFieldOrd: integer ): boolean; override;
    procedure Refilter; override;
  public
    procedure AddMatsAssignedWithBWork( _BWorkID, ID_IN_BWORKS: integer );
    procedure ResetMatsAttachAssignedWith_ID_IN_BWORKS( ID_IN_BWORKS: integer );
    procedure DelMatsAssignedWith_ID_IN_BWORKS( ID_IN_BWORKS: integer );
  protected
  f_tableName:string;
  end;
const tableName='maters';

implementation

{$R *.dfm}

uses HelpFunctions,frmLANG,cntsLANG;

procedure Tdm_Mater.dset_S_MatCalcFields(DataSet: TDataSet);
var
  _name, _ed_izm: string;
begin
  with DataSet do
  begin
    _name := trim( FieldByName( 'name_r' ).AsString );
    _ed_izm := trim( FieldByName( 'ed_izm' ).AsString );
    if _ed_izm <> '' then
      _name := _name + ' (' + _ed_izm + ')';

    FieldByName( 'clc_FullName' ).AsString := _name;
  end;
end;

procedure Tdm_Mater.dset_S_DiamCalcFields(DataSet: TDataSet);
var
  _diam: integer;
begin
  with DataSet do
  begin
    _diam := FieldByName( 'diam' ).AsInteger;
    if _diam > 0 then
      FieldByName( 'clc_Diam' ).AsString := IntToStr( _diam );
  end;
end;

procedure Tdm_Mater.dset_MaterAfterPost(DataSet: TDataSet);
begin
  tran_Main.CommitRetaining;
  dset_Mater.Refresh;
  SetSprFiltered( false );
end;

procedure Tdm_Mater.dset_MaterAfterInsert(DataSet: TDataSet);
begin
  SetSprFiltered( true );
  //
  dset_Mater.FieldByName( 'id_zav' ).AsInteger := F_ZavID;
  dset_Mater.FieldByName( 'id_nar' ).AsInteger := F_NarID;
  dset_Mater.FieldByName( 'id_diam' ).AsInteger := -1;
  dset_Mater.FieldByName( 'kol_mat' ).AsFloat := 1;
end;

procedure Tdm_Mater.dset_MaterAfterEdit(DataSet: TDataSet);
begin
  SetSprFiltered( true );
end;

procedure Tdm_Mater.dset_MaterAfterCancel(DataSet: TDataSet);
begin
  SetSprFiltered( false );
  dset_Mater.Refresh;
end;

procedure Tdm_Mater.OpenDset;
begin
  setSQL();
  OpenSpr;
  //
  with dset_Mater do
  begin
    Close;
    ParamByName( 'pZavID' ).AsInteger := F_ZavID;
    ParamByName( 'pNarID' ).AsInteger := F_NarID;
    Open;
  end;
end;

function Tdm_Mater.IsInputValuesCorrect(var _ErrMsg: string;
  var _ErrFieldOrd: integer): boolean;
//
  procedure _Error( _Msg: string; _Field: TMatersField );
  begin
    _ErrMsg := _Msg;
    _ErrFieldOrd := Ord( _Field );
  end;
begin
  Result := false;
  _ErrMsg := '';
  _ErrFieldOrd := Ord( mfNull );

  if ( dset_Mater.FieldByName( 'id_mat' ).IsNull ) or
    ( dset_Mater.FieldByName( 'id_mat' ).AsInteger = -1 ) then
  begin
    _Error( TrLangMSG(msgNotFieldValue)+' "'+TrLangMSG(msgMaterOne)+'" ',//'Не задано поле "Материал"',
            mfMater );
    exit;
  end;

  Result := true;
end;

procedure Tdm_Mater.FillSprList;
begin
  F_SprList.Add( dset_S_Mat );
  F_SprList.Add( dset_S_Diam );
end;

procedure Tdm_Mater.AddMatsAssignedWithBWork(_BWorkID,
  ID_IN_BWORKS: integer);
begin
  MyOpenIBDS( dset_tmp,
    ' select bwm.id_mater, bwm.id_diam' +
    ' from  s_bwork_mater bwm' +
    ' where bwm.id_bwork = ' + IntToStr( _BWorkID ) );

  dset_tmp.First;
  while not dset_tmp.Eof do
  begin
    sql_InsertMater.Close;
    sql_InsertMater.ParamByName( 'id_zav' ).AsInteger := F_ZavID;
    sql_InsertMater.ParamByName( 'id_nar' ).AsInteger := F_NarID;
    sql_InsertMater.ParamByName( 'id_mat' ).AsInteger := dset_tmp.FieldByName( 'id_mater' ).AsInteger;
    sql_InsertMater.ParamByName( 'kol_mat' ).AsFloat := 1;
    sql_InsertMater.ParamByName( 'id_diam' ).AsInteger := dset_tmp.FieldByName( 'id_diam' ).AsInteger;
    sql_InsertMater.ParamByName( 'bworks_id' ).AsInteger := ID_IN_BWORKS;
    sql_InsertMater.ExecQuery;

    dset_tmp.Next;
  end;
  dset_tmp.Close;

  tran_Main.CommitRetaining;
end;

procedure Tdm_Mater.ResetMatsAttachAssignedWith_ID_IN_BWORKS(
  ID_IN_BWORKS: integer);
begin
  MyExecIBSQL( IBSQL,
    format(' update %s set' +
    ' bworks_id = null' +
    ' where bworks_id = ' + IntToStr( ID_IN_BWORKS ),[F_tableName]) );

  tran_Main.CommitRetaining;
end;

procedure Tdm_Mater.DelMatsAssignedWith_ID_IN_BWORKS(
  ID_IN_BWORKS: integer);
begin
  MyExecIBSQL( IBSQL,
    Format(' delete from %s' +
    ' where bworks_id = ' + IntToStr( ID_IN_BWORKS ),[F_tableName]) );

  tran_Main.CommitRetaining;
end;

procedure Tdm_Mater.Refilter;
begin
  dset_Mater.DisableControls;
  try
    dset_Mater.Filtered := false;
    dset_Mater.Filtered := true;
  finally
    dset_Mater.EnableControls;
  end;
end;

procedure  Tdm_Mater.setSQL();
begin
dset_mater.SelectSQL.Text:=Format(dset_mater.SelectSQL.Text,[f_tableName]);
dset_Mater.ModifySQL.Text:=Format(dset_Mater.ModifySQL.Text,[f_tableName]);
dset_Mater.InsertSQL.Text:=Format(dset_Mater.InsertSQL.Text,[f_tableName]);
dset_mater.RefreshSQL.Text:=Format(dset_Mater.RefreshSQL.Text,[f_tableName]);
dset_mater.DeleteSQL.Text:=Format(dset_Mater.DeleteSQL.Text,[f_tableName]);
sql_InsertMater.SQL.Text:=Format(sql_InsertMater.SQL.Text,[f_tableName]);
end;

procedure Tdm_Mater.DataModuleCreate(Sender: TObject);
begin

  inherited;
  f_tableName:=tablename;

end;

end.
