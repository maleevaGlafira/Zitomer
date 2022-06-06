unit Zast;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Animate, GIFCtrl, ExtCtrls, frmLANG, cntsLANG;

type
  TFormZast = class(TFormLang)
    Panel1: TPanel;
    Timer1: TTimer;
    Image1: TImage;
    load_tm: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure load_tmTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Translate;override;
  end;

var
  FormZast: TFormZast;

implementation

{$R *.DFM}

procedure TFormZast.Timer1Timer(Sender: TObject);
begin
 Timer1.Enabled:=false;
end;

procedure TFormZast.load_tmTimer(Sender: TObject);
begin
 Caption:=Caption+' .';
end;

procedure TFormZast.Translate;
begin
  inherited;
  Caption:=TrLangMSG(msgLoadProgram)+' . . .'
end;

end.
