unit SelectItemForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, IBCustomDataSet, DMMain, StdCtrls, CheckLst, Buttons,
  RxLookup, IBDatabase, ItemSelecterDModule;

type
  TWordCase=(wcDefault, wcUpper, wcLower, wcName);

  Tfrm_SelectItem = class(TForm)
    chlb_Items: TCheckListBox;
    btn_Ok: TBitBtn;
    btn_exit: TBitBtn;
    RxDBLookupCombo1: TRxDBLookupCombo;
    ds_Items: TDataSource;
    procedure btn_exitClick(Sender: TObject);
    procedure RxDBLookupCombo1Change(Sender: TObject);
    procedure btn_OkClick(Sender: TObject);
    procedure chlb_ItemsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    F_IsChanged: boolean;
  public
    function IsHasChecked: boolean;
    property IsChanged: boolean read F_IsChanged;
    constructor Create(ACaption: string);
  end;

implementation

{$R *.dfm}

procedure Tfrm_SelectItem.btn_exitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_SelectItem.RxDBLookupCombo1Change(Sender: TObject);
begin
  chlb_Items.ItemIndex := ds_Items.DataSet.RecNo-1;
end;

procedure Tfrm_SelectItem.btn_OkClick(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

function Tfrm_SelectItem.IsHasChecked: boolean;
var
  i: integer;
begin
  Result := false;
  for i:=0 to chlb_Items.Count-1 do
    if chlb_Items.Checked[i] then
    begin
      Result := true;
      break;
    end;
end;

constructor Tfrm_SelectItem.Create(ACaption: string);
begin
  inherited Create(nil);
  if trim( ACaption ) <> '' then
    Caption := ACaption;
end;

procedure Tfrm_SelectItem.chlb_ItemsClick(Sender: TObject);
begin
  F_IsChanged := true;
end;

procedure Tfrm_SelectItem.FormShow(Sender: TObject);
begin
  F_IsChanged := false;
end;

end.
