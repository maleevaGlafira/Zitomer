unit BWorkDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseNarDetailDM, IBDatabase, DB, IBCustomDataSet;

type
  TBWorksField = ( bwfNull, bwfBWork );

  Tdm_BWork = class(Tdm_BaseNarDetail)
    dset_BWork: TIBDataSet;
    dset_S_BWork: TIBDataSet;
    dset_BWorkID: TIntegerField;
    dset_BWorkID_ZAV: TIntegerField;
    dset_BWorkID_NAR: TIntegerField;
    dset_BWorkID_BWORK: TIntegerField;
    dset_S_BWorkID: TIntegerField;
    dset_S_BWorkNAME_R: TIBStringField;
    dset_S_BWorkDEL: TIBStringField;
    dset_BWorklp_BWork: TStringField;
    procedure dset_BWorkAfterPost(DataSet: TDataSet);
    procedure dset_BWorkAfterInsert(DataSet: TDataSet);
    procedure dset_BWorkAfterEdit(DataSet: TDataSet);
    procedure dset_BWorkAfterCancel(DataSet: TDataSet);
    procedure dset_BWorkAfterScroll(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private
    F_OnBWorkAfterScroll: TDataSetNotifyEvent;

    procedure FillSprList; override;


  protected
      f_tableName:String;
      F_IsObjZav: boolean;
     F_IdObjObor: integer;
      procedure SetSQL(); virtual;
      procedure setTableName();

  public
    property IdObjObor: integer write F_IdObjObor;
    property IsObjZav: boolean write F_IsObjZav;
    property OnBWorkAfterScroll: TDataSetNotifyEvent read F_OnBWorkAfterScroll
      write F_OnBWorkAfterScroll;
    procedure OpenDset; override;
    function IsInputValuesCorrect( var _ErrMsg: string; var _ErrFieldOrd: integer ): boolean; override;
    function GetCurrentBWorkID: integer;
    function GetID_IN_BWORKS: integer;
    function AppendBWork( _BWorkID: integer ): integer;
  end;

const tableName ='bworks ';


implementation

{$R *.dfm}

{ Tdm_BWork }
uses  cntsLANG,frmLANG;

procedure Tdm_BWork.FillSprList;
begin
  F_SprList.Add( dset_S_BWork );
end;

procedure Tdm_BWork.OpenDset;
begin
  SetSQL;

  OpenSpr;
  //
  with dset_BWork do
  begin
    Close;
    ParamByName( 'pZavID' ).AsInteger := F_ZavID;
    ParamByName( 'pNarID' ).AsInteger := F_NarID;
    Open;
  end;
end;

procedure Tdm_BWork.dset_BWorkAfterPost(DataSet: TDataSet);
begin
  tran_Main.CommitRetaining;
  dset_BWork.Refresh;
  SetSprFiltered( false );
end;

procedure Tdm_BWork.dset_BWorkAfterInsert(DataSet: TDataSet);
begin
  SetSprFiltered( true );
  //
  dset_BWork.FieldByName( 'id_zav' ).AsInteger := F_ZavID;
  dset_BWork.FieldByName( 'id_nar' ).AsInteger := F_NarID;
end;

procedure Tdm_BWork.dset_BWorkAfterEdit(DataSet: TDataSet);
begin
  SetSprFiltered( true );
end;

procedure Tdm_BWork.dset_BWorkAfterCancel(DataSet: TDataSet);
begin
  SetSprFiltered( false );
  dset_BWork.Refresh;
end;

function Tdm_BWork.IsInputValuesCorrect(var _ErrMsg: string;
  var _ErrFieldOrd: integer): boolean;
//
  procedure _Error( _Msg: string; _Field: TBWorksField );
  begin
    _ErrMsg := _Msg;
    _ErrFieldOrd := Ord( _Field );
  end;
begin
  Result := false;
  _ErrMsg := '';
  _ErrFieldOrd := Ord( bwfNull );

  if ( dset_BWork.FieldByName( 'id_bwork' ).IsNull ) or
    ( dset_BWork.FieldByName( 'id_bwork' ).AsInteger = -1 ) then
  begin
    _Error( TrLangMSG(msgNotFieldValue)+' "'+TrLangMSG(msgComplitWork)+'" ',//'Не задано поле "Сложная работа"',
            bwfBWork );
    exit;
  end;

  Result := true;
end;

function Tdm_BWork.GetCurrentBWorkID: integer;
begin
  Result := dset_BWork.FieldByName( 'ID_BWORK' ).AsInteger;
end;

function Tdm_BWork.GetID_IN_BWORKS: integer;
begin
  Result := dset_BWork.FieldByName( 'ID' ).AsInteger;
end;

procedure Tdm_BWork.dset_BWorkAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if Assigned( F_OnBWorkAfterScroll ) then
    F_OnBWorkAfterScroll( DataSet );
end;

function Tdm_BWork.AppendBWork(_BWorkID: integer): integer;
begin
  dset_BWork.Append;
  dset_BWork.FieldByName( 'id_bwork' ).AsInteger := _BWorkID;
  dset_BWork.Post;

  Result := dset_BWork.FieldByName( 'id' ).AsInteger;
end;


// 03.03.2010 by Vadim
procedure Tdm_BWork.SetSQL;
var _SQL, _addSQL: string;

   function GetIdObjOborSTR: string;
     begin
         if F_IdObjObor > 0 then
           Result := ' and ( w.id_objobor = '+ inttostr( F_IdObjObor )+ ')'
           else
           Result := ' and ( (w.id_objobor = -1) or (w.id_objobor is null)) ';
     end;

begin
setTableName();

 if F_IsObjZav then
    _addSQL := ' and bw.id in (select distinct w.bworks_id from works w '+
              ' where ( w.id_zav = :pZavID ) and  ( w.id_nar = :pNarID ) '+
              GetIdObjOborSTR + ' and ( w.bworks_id is not null ))'
  else
     _addSQL := '';

     _SQL := ' select bw.id, bw.id_zav, bw.id_nar, bw.id_bwork '+
    'from bworks bw '+
    'left join s_bwork sbw on sbw.id = bw.id_bwork '+
    'where ( bw.id_zav = :pZavID ) and '+
    '( bw.id_nar = :pNarID ) '+ _addSQL +
    'order by sbw.name_r ';

    dset_BWork.SelectSQL.Text := _SQL;

end;


procedure Tdm_BWork.setTableName;
begin
  dset_BWork.SelectSQL.Text:=format( dset_BWork.SelectSQL.Text,[f_tableName]);
  dset_BWork.InsertSQL.Text:=format( dset_BWork.InsertSQL.Text,[f_tableName]);
  dset_BWork.ModifySQL.Text:=format( dset_BWork.ModifySQL.Text,[f_tableName]);
  dset_BWork.DeleteSQL.Text:=format( dset_BWork.DeleteSQL.Text,[f_tableName]);
  dset_BWork.RefreshSQL.Text:=format( dset_BWork.RefreshSQL.Text,[f_tableName]); 
end;




procedure Tdm_BWork.DataModuleCreate(Sender: TObject);
begin
  inherited;
f_tableName:=tableName;
end;

end.
