unit BaseOptionItemSelWithSaveForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionItemSelForm, StdCtrls, Buttons, BaseItemSelecterFrame,
  CookiesUnit;

type
  Tfrm_BaseOptionItemSelWithSave = class(Tfrm_BaseOptionItemSel)
    btn_save: TBitBtn;
    mem_Info: TMemo;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_saveClick(Sender: TObject);
  protected
    F_SaveFrameList: TList; //список фреймов, настройки которых надо сохранять
    F_ReportClassName: string;
    F_CookieItems: TCookieItems;
    procedure FillSaveFrameList; virtual;
    procedure ShowSelInfo; virtual;
    procedure BeforeSelHandler(Sender: TObject);
    procedure AfterSelHandler(Sender: TObject);
    procedure LoadCookies;
    procedure SetDefaultItemsIDToFrame( _frame: Tframe_BaseItemSelecter );
  public
    constructor Create(AOwner: TComponent; ACaption, AReportClassName: string);
  end;


implementation

{$R *.dfm}

{ Tfrm_BaseOptionItemSelWithSave }

procedure Tfrm_BaseOptionItemSelWithSave.FillSaveFrameList;
begin
//
end;

procedure Tfrm_BaseOptionItemSelWithSave.ShowSelInfo;
var
  i: integer;
  _frame: Tframe_BaseItemSelecter;
begin
  mem_Info.Clear;

  for i:=0 to F_ItemSelecterFrameList.Count-1 do
  begin
    _frame := Tframe_BaseItemSelecter( F_ItemSelecterFrameList.Items[i] );

    mem_Info.Lines.Add( Format( '%s: %s;',
      [ _frame.FieldName, _frame.ItemSelecter.SelItemList.ItemsName ] ) );

    mem_Info.Lines.Add( ' ' );
  end;
end;

procedure Tfrm_BaseOptionItemSelWithSave.FormShow(Sender: TObject);
begin
  inherited;
  ShowSelInfo;
end;

procedure Tfrm_BaseOptionItemSelWithSave.FormCreate(Sender: TObject);
var
  i: integer;
  _frame: Tframe_BaseItemSelecter;
begin
  inherited;
  F_SaveFrameList := TList.Create;

  FillSaveFrameList;
  LoadCookies;

  for i:=0 to F_SaveFrameList.Count-1 do
  begin
    _frame := Tframe_BaseItemSelecter(F_SaveFrameList.Items[i] );
    _frame.OnBeforeSel := BeforeSelHandler;
    SetDefaultItemsIDToFrame( _frame );
  end;

  for i:=0 to F_ItemSelecterFrameList.Count-1 do
    Tframe_BaseItemSelecter( F_ItemSelecterFrameList.Items[i] ).OnAfterSel := AfterSelHandler;
end;

procedure Tfrm_BaseOptionItemSelWithSave.AfterSelHandler(Sender: TObject);
begin
  ShowSelInfo;
end;

constructor Tfrm_BaseOptionItemSelWithSave.Create(AOwner: TComponent;
  ACaption, AReportClassName: string);
begin
  F_ReportClassName := AReportClassName;
  inherited Create( AOwner );
  Caption := ACaption;
end;

procedure Tfrm_BaseOptionItemSelWithSave.FormDestroy(Sender: TObject);
begin
  inherited;
  F_SaveFrameList.Free;
  F_CookieItems.Free;
end;

procedure Tfrm_BaseOptionItemSelWithSave.BeforeSelHandler(Sender: TObject);
begin
  if ( Sender is Tframe_BaseItemSelecter ) then
    SetDefaultItemsIDToFrame( Sender as Tframe_BaseItemSelecter );
end;

procedure Tfrm_BaseOptionItemSelWithSave.btn_saveClick(Sender: TObject);
var
  i: integer;
  _frame: Tframe_BaseItemSelecter;
begin
  for i:=0 to F_SaveFrameList.Count-1 do
  begin
    _frame := Tframe_BaseItemSelecter(F_SaveFrameList.Items[i] );

    //if trim( _frame.ItemSelecter.SelItemList.ItemsID ) <> '' then
    F_CookieItems.ValueByName[ _frame.Name ] := _frame.ItemSelecter.SelItemList.ItemsID;
  end;
  GlobalCookies.Save( F_CookieItems );
  MessageBox( handle, 'Настройки для этой ведомости успешно сохранены.', 'Диспетчер АВР', MB_ICONINFORMATION );
end;

procedure Tfrm_BaseOptionItemSelWithSave.LoadCookies;
var
  i: integer;
begin
  F_CookieItems := TCookieItems.Create;
  F_CookieItems.Name := F_ReportClassName;
  for i:=0 to F_SaveFrameList.Count-1 do
    F_CookieItems.Add( Tframe_BaseItemSelecter(F_SaveFrameList.Items[i] ).Name );
  GlobalCookies.Load( F_CookieItems );
end;

procedure Tfrm_BaseOptionItemSelWithSave.SetDefaultItemsIDToFrame(
  _frame: Tframe_BaseItemSelecter);
begin
  _frame.ItemSelecter.DefaultItemsID := trim( F_CookieItems.ValueByName[ _frame.Name ] );
end;

end.
