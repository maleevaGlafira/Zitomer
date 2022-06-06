unit PatchWaitForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls;

type
  Tfrm_PatchWait = class(TForm)
    Animate1: TAnimate;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_PatchWait: Tfrm_PatchWait;

implementation

{$R *.dfm}

procedure Tfrm_PatchWait.FormShow(Sender: TObject);
begin
  Animate1.Active:=true;
end;

end.
