unit bazerep;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons,frmLANG,cntsLANG;

type
  TBazeRepQY_F = class(TFormLang)
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Bevel1: TBevel;
    Quarte_cb: TComboBox;
    Year_cb: TComboBox;
    BtOk: TBitBtn;
    BitBtn1: TBitBtn;
    Period_rg: TRadioGroup;
    Vidrep_rg: TRadioGroup;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Translate;override;
  end;

var
  BazeRepQY_F: TBazeRepQY_F;

implementation

{$R *.DFM}

procedure TBazeRepQY_F.Translate;
begin
  inherited;
  Label3.Caption:=TrLangMSG(msgYear);
  BtOk.Caption:=TrLangMSG(msgApply);
  BitBtn1.Caption:=TrLangMSG(msgExit);
  Period_rg.Caption:=' '+TrLangMSG(msgRange)+' ';
  Period_rg.Items.strings[1]:=TrLangMSG(msgYear);
  Vidrep_rg.Items.commatext:=TrLangMSG(msgDiam)+','+TrLangMSG(msgREV);
end;

end.
