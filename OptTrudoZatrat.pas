unit OptTrudoZatrat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, ExtCtrls, StdCtrls,
  Buttons, SelDatePeriodFrame, RxLookup, DB, DMMain, IBCustomDataSet,
  IBDatabase;

type
  Tfrm_OptTrudoZatrat = class(Tfrm_BaseOption)
    frame_Dates: Tframe_SelDatePeriod;
    btn_ok: TBitBtn;
    btn_exit: TBitBtn;
    Bevel1: TBevel;
    dbl_Region: TRxDBLookupCombo;
    Label1: TLabel;
    ds_RegAttach: TDataSource;
    dset_Revs: TIBDataSet;
    tran: TIBTransaction;
    procedure btn_exitClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
  public
    function GetRegionID: integer;
    function GetRegionName: string;
  end;


implementation

{$R *.dfm}

uses HelpFunctions;

procedure Tfrm_OptTrudoZatrat.btn_exitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_OptTrudoZatrat.btn_okClick(Sender: TObject);
begin
  if frame_Dates.IsDatesCorrect then
    if HelpFunctions.IsDBLEmpty( dbl_Region ) then
      Application.MessageBox( 'Выберите участок!', 'Внимание', MB_OK + MB_ICONWARNING )
    else
      ModalResult := mrOk;
end;

function Tfrm_OptTrudoZatrat.GetRegionID: integer;
begin
  Result := dset_revs.FieldByName( 'id' ).AsInteger;
end;

function Tfrm_OptTrudoZatrat.GetRegionName: string;
begin
  Result := dset_revs.FieldByName( 'name_r' ).AsString;
end;

procedure Tfrm_OptTrudoZatrat.FormCreate(Sender: TObject);
begin
  inherited;
  tran.StartTransaction;
  dset_revs.Open;
end;

procedure Tfrm_OptTrudoZatrat.FormDestroy(Sender: TObject);
begin
  inherited;
  tran.Commit;
end;

end.
