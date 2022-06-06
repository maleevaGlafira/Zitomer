unit BaseSingleItemSelectFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, MemTableFiller, StdCtrls, DB, kbmMemTable, RxLookup, ItemSelecter;

type
  Tframe_BaseSingleItemSelect = class(TFrame)
    dbl_Item: TRxDBLookupCombo;
    ds_MemTable: TDataSource;
    MemTable: TkbmMemTable;
    lbl_Caption: TLabel;
  private
    function GetResultSelItem: TSelItem;
  protected
    F_MemTableFiller: TMemTableFiller;
    F_FieldName: string;
    F_ResultSelItem: TSelItem;
    procedure Init; virtual; abstract;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property ResultSelItem: TSelItem read GetResultSelItem;
    function IsSelectItem: boolean;
  end;

implementation

{$R *.dfm}

{ Tframe_BaseSingleItemSelect }

constructor Tframe_BaseSingleItemSelect.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  F_MemTableFiller := TMemTableFiller.Create;
  F_MemTableFiller.ResMemTable := MemTable;
  F_ResultSelItem := TSelItem.Create;
  //
  Init;
  //
  if not MemTable.Locate( 'ItemID', -1, [] ) then MemTable.First;
  dbl_Item.DisplayValue := MemTable.FieldByName( 'ItemName' ).AsString;
end;

destructor Tframe_BaseSingleItemSelect.Destroy;
begin
  F_MemTableFiller.Free;
  F_ResultSelItem.Free;
  inherited Destroy;
end;

function Tframe_BaseSingleItemSelect.GetResultSelItem: TSelItem;
begin
  if ( MemTable.Active ) and ( not MemTable.IsEmpty ) then
  begin
    F_ResultSelItem.ID := MemTable.FieldByName( 'ItemID' ).AsInteger;
    F_ResultSelItem.Name := MemTable.FieldByName( 'ItemName' ).AsString;
  end;

  Result := F_ResultSelItem;
end;

function Tframe_BaseSingleItemSelect.IsSelectItem: boolean;
begin
  Result := not( MemTable.IsEmpty ) and ( MemTable.FieldByName( 'ItemID' ).AsInteger > 0 );
  if not Result then
    Application.MessageBox( PChar( 'Не заполнено поле "' + F_FieldName + '"' ),
      'Внимание', MB_OK + MB_ICONWARNING );
end;

end.
