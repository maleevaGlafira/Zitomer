unit AddMaterToBworkForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DB, IBCustomDataSet, RxLookup, ExtCtrls, DMMain,
  IBDatabase;

type
  Tfrm_AddMaterToBwork = class(TForm)
    dbl_Mater: TRxDBLookupCombo;
    dbl_Diam: TRxDBLookupCombo;
    dset_s_mat: TIBDataSet;
    dset_s_diam: TIBDataSet;
    ds_s_mat: TDataSource;
    ds_s_diam: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Bevel1: TBevel;
    tran_spr: TIBTransaction;
    dset_s_matID: TIntegerField;
    dset_s_matNAME_R: TIBStringField;
    dset_s_diamID: TIntegerField;
    dset_s_diamDIAM: TIntegerField;
    dset_s_diamname_r: TStringField;
    procedure BitBtn2Click(Sender: TObject);
    procedure dset_s_diamCalcFields(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    function GetMaterID: integer;
    function GetDiamID: integer;
  public
    property MaterID: integer read GetMaterID;
    property DiamID: integer read GetDiamID;
  end;

implementation

{$R *.dfm}

uses HelpFunctions;

procedure Tfrm_AddMaterToBwork.BitBtn2Click(Sender: TObject);
begin
  Close;
end;

function Tfrm_AddMaterToBwork.GetDiamID: integer;
begin
  if not IsDBLEmpty( dbl_Diam ) then
    Result := dset_s_diam.FieldByName( 'id' ).AsInteger
  else
    Result := -1;
end;

function Tfrm_AddMaterToBwork.GetMaterID: integer;
begin
  Result := dset_s_mat.FieldByName( 'id' ).AsInteger;
end;

procedure Tfrm_AddMaterToBwork.dset_s_diamCalcFields(DataSet: TDataSet);
begin
  with DataSet do
  begin
    if FieldByName( 'id' ).AsInteger = -1 then
      FieldByName( 'name_r' ).AsString := '<нет>'
    else
      FieldByName( 'name_r' ).AsString := FieldByName( 'diam' ).AsString;
  end;
end;

procedure Tfrm_AddMaterToBwork.FormCreate(Sender: TObject);
begin
  tran_spr.StartTransaction;

  dset_s_mat.Open;
  dset_s_diam.Open;

  ResetDBL( dbl_mater);
  ResetDBL( dbl_Diam);
end;

procedure Tfrm_AddMaterToBwork.FormDestroy(Sender: TObject);
begin
  if tran_spr.InTransaction then
    tran_spr.Commit;
end;

procedure Tfrm_AddMaterToBwork.BitBtn1Click(Sender: TObject);
  procedure _Show( _msg: string );
  begin
    Application.MessageBox( PChar( _msg ), 'Внимание', MB_OK + MB_ICONERROR );
  end;
begin
  if IsDBLEmpty( dbl_mater ) then
  begin
    dbl_mater.SetFocus;
    _Show( 'Введите "Материал"!' );
    exit;
  end;

  ModalResult := mrOk;
end;

end.
