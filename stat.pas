unit stat;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, RXClock, RXCtrls;

type
  TFormStatus = class(TForm)
    Pn: TPanel;
    Clock: TRxClock;
    Lb_ln: TRxLabel;
    Tm: TTimer;
    Lb_dt: TRxLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TmTimer(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    dx,dy,l,t:integer;
    isLeft:boolean;
  end;

var
  FormStatus: TFormStatus;

implementation

{$R *.DFM}

procedure TFormStatus.FormCreate(Sender: TObject);
var sw,sh:integer;
    dw,dh:double;
begin
  Left:=0;
  Top:=0;
  FormStatus:=Self;
//  Lb_dt.Caption:=DateToStr(now);
  isLeft:=false;
  dx:=0;dy:=0;
  sw:=Screen.Width;
  sh:=Screen.Height;
  dw:=Sw/1024;
  dh:=sh/768;
  if dw<1 then
    begin
  //    Lb_Dt.Font.Size:=6;
      Lb_Ln.Font.Size:=6;
    end;
  Clock.Height:=round(Clock.Height*dh);
  Clock.Width:=round(Clock.Width*dw);
  //Pn.Height:=round(Pn.Height*dh);
  Pn.Width:=round(Pn.Width*dw);
  Lb_Ln.Top:=Clock.Top+Clock.Height;
//  Lb_Dt.Top:=Clock.Top+Clock.Height;
  Pn.Height:=Clock.Height+Lb_Ln.Height+10;
end;

procedure TFormStatus.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TFormStatus.TmTimer(Sender: TObject);
//var keybl:integer;
begin
 try
  { keybl:=GetKeyboardLayout(0);
   if keybl=$4090409 then
     lb_Ln.Caption:='ËÀÒ '+DateToStr(now)
   else if keybl=$4190419 then
     lb_Ln.Caption:='ÐÓÑ '+DateToStr(now)
   else if keybl=$4220422 then
     lb_Ln.Caption:='ÓÊÐ '+DateToStr(now);}
 except
 end;    
end;

procedure TFormStatus.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
 var Mc,MSCc:TPoint;
begin
  if (ssLeft in Shift) then
    begin
       if isLeft then
        begin
          MC.x:=X;
          MC.y:=Y;
          MSCc:=TControl(Sender).ClientToScreen(Mc);
          Mc:=FormStatus.ScreenToClient(MSCc);
          Self.Left:=l+Mc.x-dx;
          Self.Top:=t+Mc.y-dy;
        end
       else
        begin
          MC.x:=X;
          MC.y:=Y;
          MSCc:=TControl(Sender).ClientToScreen(Mc);
          Mc:=FormStatus.ScreenToClient(MSCc);
          dx:=Mc.x;
          dy:=Mc.y;
          isLeft:=true;
          l:=Self.Left;
          t:=Self.Top
        end;
    end
  else
    isLeft:=false;
end;

end.
