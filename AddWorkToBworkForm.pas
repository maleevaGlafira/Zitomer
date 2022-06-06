unit AddWorkToBworkForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RxLookup, StdCtrls, Buttons, DB, ExtCtrls, IBCustomDataSet,
  IBDatabase;

type
  Tfrm_AddWorkToBwork = class(TForm)
    dbl_Place: TRxDBLookupCombo;
    dbl_Work: TRxDBLookupCombo;
    dbl_Diam: TRxDBLookupCombo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    btn_ok: TBitBtn;
    btn_exit: TBitBtn;
    Bevel1: TBevel;
    dset_s_place: TIBDataSet;
    dset_s_placeID: TIntegerField;
    dset_s_placeNAME_R: TIBStringField;
    dset_s_work: TIBDataSet;
    dset_s_workID: TIntegerField;
    dset_s_workNAME_R: TIBStringField;
    dset_s_diam: TIBDataSet;
    dset_s_diamID: TIntegerField;
    dset_s_diamDIAM: TIntegerField;
    dset_s_diamname_r: TStringField;
    ds_s_place: TDataSource;
    ds_s_work: TDataSource;
    ds_s_diam: TDataSource;
    tran_Spr: TIBTransaction;
    procedure dset_s_diamCalcFields(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_exitClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
  private
    function GetWorkID: integer;
    function GetDiamID: integer;
  public
    property WorkID: integer read GetWorkID;
    property DiamID: integer read GetDiamID;
  end;


implementation

{$R *.dfm}

uses HelpFunctions;

procedure Tfrm_AddWorkToBwork.dset_s_diamCalcFields(DataSet: TDataSet);
begin
  with DataSet do
  begin
    if FieldByName( 'id' ).AsInteger = -1 then
      FieldByName( 'name_r' ).AsString := '<нет>'
    else
      FieldByName( 'name_r' ).AsString := FieldByName( 'diam' ).AsString;
  end;
end;

procedure Tfrm_AddWorkToBwork.FormCreate(Sender: TObject);
begin
  tran_spr.StartTransaction;

  dset_s_place.Open;
  dset_s_work.Open;
  dset_s_diam.Open;

  ResetDBL( dbl_Place);
  ResetDBL( dbl_Work);
  ResetDBL( dbl_Diam);
end;

procedure Tfrm_AddWorkToBwork.FormDestroy(Sender: TObject);
begin
  if tran_spr.InTransaction then
    tran_spr.Commit;
end;

function Tfrm_AddWorkToBwork.GetDiamID: integer;
begin
  if not IsDBLEmpty( dbl_Diam ) then
    Result := dset_s_diam.FieldByName( 'id' ).AsInteger
  else
    Result := -1;
end;

function Tfrm_AddWorkToBwork.GetWorkID: integer;
begin
  Result := dset_s_work.FieldByName( 'id' ).AsInteger;
end;

procedure Tfrm_AddWorkToBwork.btn_exitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_AddWorkToBwork.btn_okClick(Sender: TObject);
  procedure _Show( _msg: string );
  begin
    Application.MessageBox( PChar( _msg ), 'Внимание', MB_OK + MB_ICONERROR );
  end;
begin
  if IsDBLEmpty( dbl_place ) then
  begin
    dbl_place.SetFocus;
    _Show( 'Введите "Место"!' );
    exit;
  end;

  if IsDBLEmpty( dbl_work ) then
  begin
    dbl_work.SetFocus;
    _Show( 'Введите "Работа"!' );
    exit;
  end;

  ModalResult := mrOk;
end;

end.
