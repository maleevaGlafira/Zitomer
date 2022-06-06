unit OptDiscon13Group;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DiskonOptForm, StdCtrls, ExtCtrls, Buttons, frm_dat, Spin,
  BaseItemSelecterFrame, SelStreetFrame;

type
  Tfrm_OptDiscon13Group = class(Tfrm_DiskonOpt)
    gb_withouwater: TGroupBox;
    rg_wthoutwater: TRadioGroup;
    spe_withoutwater: TSpinEdit;
    procedure rg_wthoutwaterClick(Sender: TObject);
  private
    { Private declarations }
    function  getdays():integer;
    function  getmaxmin():integer;
  public
    { Public declarations }
    property days:integer read getdays;
    property maxmin:integer read getmaxmin;
  end;

var
  frm_OptDiscon13Group: Tfrm_OptDiscon13Group;

implementation

{$R *.dfm}

procedure Tfrm_OptDiscon13Group.rg_wthoutwaterClick(Sender: TObject);
begin
  inherited;
    spe_withoutwater.Enabled:=( rg_wthoutwater.ItemIndex>0);

end;

function  Tfrm_OptDiscon13Group.getdays():integer;
begin
 if  rg_wthoutwater.ItemIndex>0 then
  result:= spe_withoutwater.Value
 else
   result:=-1;
end;

function  Tfrm_OptDiscon13Group.getmaxmin():integer;
 begin
 result:=rg_wthoutwater.ItemIndex;
 end;

end.
