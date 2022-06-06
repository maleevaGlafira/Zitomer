unit BaseOptionItemSelForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, BaseItemSelecterFrame, StdCtrls, Buttons;

type
  Tfrm_BaseOptionItemSel = class(Tfrm_BaseOption)
    btn_ok: TBitBtn;
    btn_close: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure btn_closeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  protected
    F_ItemSelecterFrameList: TList;
    procedure AddItemSelecterFrames( _WinCtrl: TWinControl );
  public
    procedure ResetAllItemSelecters;
  end;

implementation

{$R *.dfm}

{ Tfrm_BaseOptionItemSel }

procedure Tfrm_BaseOptionItemSel.ResetAllItemSelecters;
var
  i: integer;
begin
  for i := 0 to F_ItemSelecterFrameList.Count - 1 do
    Tframe_BaseItemSelecter( F_ItemSelecterFrameList.Items[i] ).ItemSelecter.Reset;
end;

procedure Tfrm_BaseOptionItemSel.FormShow(Sender: TObject);
begin
  inherited;
  ResetAllItemSelecters;
end;

procedure Tfrm_BaseOptionItemSel.btn_closeClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure Tfrm_BaseOptionItemSel.FormCreate(Sender: TObject);
begin
  inherited;
  F_ItemSelecterFrameList := TList.Create;
  AddItemSelecterFrames( self );
end;

procedure Tfrm_BaseOptionItemSel.FormDestroy(Sender: TObject);
begin
  inherited;
  F_ItemSelecterFrameList.Free;
end;

procedure Tfrm_BaseOptionItemSel.AddItemSelecterFrames(
  _WinCtrl: TWinControl);
var
  i: integer;
begin
  for i := 0 to _WinCtrl.ControlCount - 1 do
  begin
    if _WinCtrl.Controls[i] is Tframe_BaseItemSelecter then
      F_ItemSelecterFrameList.Add( _WinCtrl.Controls[i] )
    else
    if _WinCtrl.Controls[i] is TWinControl then
      AddItemSelecterFrames( _WinCtrl.Controls[i] as TWinControl );
  end;
end;

end.
