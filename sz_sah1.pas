unit sz_sah1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, sz_sah, DB, DBTables, frm_dat, StdCtrls, RxLookup, Buttons,
  ExtCtrls;

type
  TFormSah1 = class(TFormSah)
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Translate;override;
  end;

implementation
uses frmLANG,cntsLANG;

{$R *.dfm}

procedure TFormSah1.Translate;
begin
  inherited;
  Caption:=TrLangMSG(msgVedLikvidirPovrForRange);
end;

end.
