unit BaseNarDetailDM;

interface

uses
  SysUtils, Classes, IBDatabase, DMMain, DB;

type
  TIsInputValuesCorrectFunc = function( var _ErrMsg: string; var _ErrFieldOrd: integer ): boolean of object;

  Tdm_BaseNarDetail = class(TDataModule)
    tran_Main: TIBTransaction;
    tran_Spr: TIBTransaction;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure SprFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
  protected
    F_ZavID,
    F_NarID: integer;
    F_SprList: TList;
    F_IsReadOnly: boolean;
    procedure SetSprFiltered( _IsFiltered: boolean );
    procedure OpenSpr;
  protected
    procedure FillSprList; virtual;
  public
    function IsInputValuesCorrect( var _ErrMsg: string; var _ErrFieldOrd: integer ): boolean; virtual;
    procedure OpenDset; virtual;
  public
    property ZavID: integer read F_ZavID write F_ZavID;
    property NarID: integer read F_NarID write F_NarID;
    property IsReadOnly: boolean read F_IsReadOnly write F_IsReadOnly;
    procedure StartTran;
    procedure CommitTran;
    procedure RollbackTran;
  end;


implementation

{$R *.dfm}

{ Tdm_BaseNarDetail }

procedure Tdm_BaseNarDetail.CommitTran;
begin
  tran_Main.Commit;
  tran_Spr.Commit;
end;

function Tdm_BaseNarDetail.IsInputValuesCorrect(var _ErrMsg: string;
  var _ErrFieldOrd: integer): boolean;
begin
  Result := true;
end;

procedure Tdm_BaseNarDetail.RollbackTran;
begin
  tran_Main.Rollback;
  tran_Spr.Rollback;
end;

procedure Tdm_BaseNarDetail.StartTran;
begin
  if tran_Main.InTransaction then tran_Main.Rollback;
  tran_Main.StartTransaction;

  if tran_Spr.InTransaction then tran_Spr.Rollback;
  tran_Spr.StartTransaction;
end;

procedure Tdm_BaseNarDetail.DataModuleDestroy(Sender: TObject);
  procedure _Err;
  begin
    raise Exception.Create( 'Имеется активная транзакция ( Tdm_BaseNarDetail.DataModuleDestroy )' );
  end;
begin
  F_SprList.Free;

  if tran_Main.InTransaction then
  begin
    tran_Main.Rollback;
    _Err;
  end;

  if tran_Spr.InTransaction then
  begin
    tran_Spr.Rollback;
    _Err;
  end;
end;

procedure Tdm_BaseNarDetail.DataModuleCreate(Sender: TObject);
begin
  F_SprList := TList.Create;
  FillSprList;
end;

procedure Tdm_BaseNarDetail.FillSprList;
begin
//
end;

procedure Tdm_BaseNarDetail.SprFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept := ( trim( DataSet.FieldByName( 'del' ).AsString ) = '-' );
end;

procedure Tdm_BaseNarDetail.SetSprFiltered(_IsFiltered: boolean);
var
  i: integer;
begin
  for i:=0 to F_SprList.Count-1 do
    TDataSet( F_SprList.Items[ i ] ).Filtered := _IsFiltered;
end;

procedure Tdm_BaseNarDetail.OpenDset;
begin
//
end;

procedure Tdm_BaseNarDetail.OpenSpr;
var
  i: integer;
  _dset: TDataSet;
begin
  for i:=0 to F_SprList.Count-1 do
  begin
    _dset := TDataSet( F_SprList.Items[ i ] );
    if not _dset.Active then _dset.Open;
  end;
end;

end.
