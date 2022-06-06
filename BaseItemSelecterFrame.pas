unit BaseItemSelecterFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ItemSelecter, StdCtrls, Buttons;

type
  Tframe_BaseItemSelecter = class(TFrame)
    btn_SelItem: TBitBtn;
    procedure btn_SelItemClick(Sender: TObject);
  protected
    F_ItemSelecter: TItemSelecter;
    F_FieldName: string;
    F_OnAfterSel,
    F_OnBeforeSel: TNotifyEvent;
    OldBtnClick: TNotifyEvent;
    procedure NewBtnClick(Sender: TObject);
    procedure Init; virtual; abstract;
  public
    property ItemSelecter: TItemSelecter read F_ItemSelecter
      write F_ItemSelecter;
    property FieldName: string read F_FieldName write F_FieldName;
    property OnAfterSel: TNotifyEvent read F_OnAfterSel write F_OnAfterSel;
    property OnBeforeSel: TNotifyEvent read F_OnBeforeSel write F_OnBeforeSel;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

{$R *.dfm}

constructor Tframe_BaseItemSelecter.Create(AOwner: TComponent);
begin
  inherited Create( AOwner );
  F_ItemSelecter := TItemSelecter.Create;
  OldBtnClick := btn_SelItem.OnClick;
  btn_SelItem.OnClick := NewBtnClick;
  //
  Init;
end;


destructor Tframe_BaseItemSelecter.Destroy;
begin
  F_ItemSelecter.Free;
  inherited Destroy;
end;

procedure Tframe_BaseItemSelecter.btn_SelItemClick(Sender: TObject);
begin
  F_ItemSelecter.ShowSelectForm;
end;

procedure Tframe_BaseItemSelecter.NewBtnClick(Sender: TObject);
begin
  if Assigned( F_OnBeforeSel ) then F_OnBeforeSel( self );
  if Assigned( OldBtnClick ) then OldBtnClick( Sender );
  if Assigned( F_OnAfterSel ) then F_OnAfterSel( self );
end;

end.
