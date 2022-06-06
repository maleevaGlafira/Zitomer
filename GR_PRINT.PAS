unit gr_print;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, fd_grf, Printers, StdCtrls, Spin, Buttons, ExtDlgs;

type
  TFormGPrint = class(TForm)
    Im_Print: TImage;
    GrB_Upr: TGroupBox;
    Label9: TLabel;
    Label2: TLabel;
    SpE_Xots: TSpinEdit;
    SpE_YOts: TSpinEdit;
    SpE_Scl: TSpinEdit;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    BB_Close: TBitBtn;
    BB_Save: TBitBtn;
    PicDlg: TSavePictureDialog;
    BB_Print: TBitBtn;
    BB_Setup: TBitBtn;
    PrSetupD: TPrinterSetupDialog;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpE_SclChange(Sender: TObject);
    procedure SpE_XotsChange(Sender: TObject);
    procedure BB_CloseClick(Sender: TObject);
    procedure BB_SaveClick(Sender: TObject);
    procedure BB_PrintClick(Sender: TObject);
    procedure BB_SetupClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    PrHres,PrVres,PrColors,PrPlanes:SmallInt;
    hs_pageDef,vs_pageDef:double;
    cdWidth,cdHeight,cdrWidth,cdrHeight:double;
    oldMono:boolean;
    procedure Redraw(xWidth,yHeight:double;Xot,Yot:integer);
    procedure ClearIm;
  end;
const
  INCH:double = 25.4;       { дюйм }
var
  FormGPrint: TFormGPrint;

implementation

{$R *.DFM}

procedure TFormGPrint.FormActivate(Sender: TObject);
var tt_str:string;
    Kfx,Kfy:double;
begin
  FormGPrint:=Self;
  FormGPrint.Height:=441;
  FormGPrint.Width:=682;
  Im_Print.Height:=400;
  Im_Print.Picture.Bitmap.Height:=400;
  Im_Print.Width:=400;
  Im_Print.Picture.Bitmap.Width:=400;

  GrB_Upr.Left:=412;
  FormGPrint.Update;
  oldMono:=GrafFForm.DBChartFed1.Monochrome;
              PrHres:=GetDeviceCaps(Printer.Handle,LogPixelsX);
              PrVres:=GetDeviceCaps(Printer.Handle,LogPixelsY);
              PrColors:=GetDeviceCaps(Printer.Handle,BITSPIXEL);
              PrPlanes:=GetDeviceCaps(Printer.Handle,PLANES);
              if (PrColors=1) and (PrPlanes=1) then
                begin
                 //ChBBl_Wt.Checked:=true;
                 //ChBBl_Wt.Enabled:=false; tprinter
                end;
              if Printer.PrinterIndex<0 then
                 Label9.Caption:={Label9.Caption+}'по умолчанию:'
              else
                 Label9.Caption:={Label9.Caption+}Printer.Printers.Strings[Printer.PrinterIndex];

              if (PrColors=1) and (PrPlanes=1) then
                 tt_str:='2'
              else if (PrColors>1) then
                 str(2 shl (PrColors-1),tt_str)
              else if (PrColors=1)and (PrPlanes>1) then
                 str(2 shl PrPlanes,tt_str);

              Label2.Caption:=IntToStr(PrHRes)+'x'+IntToStr(PrVRes)+
                                    'dpi,'+tt_str+'цв.';
              hs_pageDef:=0.001*INCH*Printer.PageWidth/PrHres;
              vs_pageDef:=0.001*INCH*Printer.PageHeight/PrVres;
              str(hs_pageDef:5:3,tt_str);
              Label2.Caption:=Label2.Caption+tt_str+'x';
              str(vs_pageDef:5:3,tt_str);
              Label2.Caption:=Label2.Caption+tt_str;


  Kfx:=hs_pageDef/vs_pageDef;
  if Kfx<1 then
     Im_Print.Width:=Round(Im_Print.Width*Kfx)
  else
     Im_Print.Height:=Round(Im_Print.Height/Kfx);

  GrB_Upr.Left:=Im_Print.Left+Im_Print.Width+4;
  FormGPrint.Width:=Im_Print.Width+GrB_Upr.Width+20;
  if Im_Print.Height<GrB_Upr.Height then
     FormGPrint.Height:=GrB_Upr.Height+43;

  Kfx:=GrafFForm.DBChartFed1.ChartWidth/Im_Print.Width;
  Kfy:=GrafFForm.DBChartFed1.ChartHeight/Im_Print.Height;

  if Kfx>Kfy then
    begin
     cdWidth:=hs_pageDef;
     cdHeight:=hs_pageDef*
           GrafFForm.DBChartFed1.ChartHeight/GrafFForm.DBChartFed1.ChartWidth;
    end
  else
    begin
     cdHeight:=vs_pageDef;
     cdWidth:=vs_pageDef*
           GrafFForm.DBChartFed1.ChartWidth/GrafFForm.DBChartFed1.ChartHeight;
    end;

  SpE_SclChange(Self);
end;

procedure TFormGPrint.Redraw(xWidth,yHeight:double;Xot,Yot:integer);
var tt_str:string;
    ix1,ix2,iy1,iy2:integer;
    iXot,iYot,iWidth,iHeight:double;
begin

  str(xWidth:5:3,tt_str);
  Label1.Caption:='% Размер:'+tt_str;
  str(yHeight:5:3,tt_str);
  Label1.Caption:=Label1.Caption+'x'+tt_str+'m.';

  iXot:=(Xot*Im_Print.Width/hs_pageDef)/1000;
  iYot:=(Yot*Im_Print.Height/vs_pageDef)/1000;
  iWidth:=xWidth*Im_Print.Width/hs_pageDef;
  iHeight:=yHeight*Im_Print.Height/vs_pageDef;
  ClearIm;
  ix1:=round(iXot);                              // tbitmap
  iy1:=round(iYot);
  ix2:=round(iWidth+iXot);
  iy2:=round(iHeight+iYot);
  GrafFForm.DBChartFed1.PrintPartialCanvas(Im_Print.Canvas,Rect(ix1,iy1,ix2,iy2));
end;

procedure TFormGPrint.ClearIm;
begin
  Im_Print.Canvas.Brush.Style:=bsSolid;
  Im_Print.Canvas.Brush.Color:=clWhite;
  Im_Print.Canvas.FillRect(Rect(0,0,Im_Print.Width,Im_Print.Height));
end;
procedure TFormGPrint.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  GrafFForm.DBChartFed1.Monochrome:=oldMono;
  Action:=caFree;
end;

procedure TFormGPrint.SpE_SclChange(Sender: TObject);
begin
  cdrWidth:=cdWidth*SpE_Scl.Value/100;
  cdrHeight:=cdHeight*SpE_Scl.Value/100;
  SpE_Xots.MaxValue:=round((hs_pageDef-cdrWidth)*1000);
  SpE_Yots.MaxValue:=round((vs_pageDef-cdrHeight)*1000);
  if SpE_Xots.Value>SpE_Xots.MaxValue then
    begin
     SpE_Xots.OnChange:=NIL;
     SpE_Xots.Value:=SpE_Xots.MaxValue;
     SpE_Xots.OnChange:=SpE_XotsChange;
    end;
  if SpE_Yots.Value>SpE_Yots.MaxValue then
    begin
     SpE_Yots.OnChange:=NIL;
     SpE_Yots.Value:=SpE_Xots.MaxValue;
     SpE_Yots.OnChange:=SpE_XotsChange;
    end;
  Redraw(cdrWidth,cdrHeight,SpE_Xots.Value,SpE_Yots.Value);
end;

procedure TFormGPrint.SpE_XotsChange(Sender: TObject);
begin
  Redraw(cdrWidth,cdrHeight,SpE_Xots.Value,SpE_Yots.Value);
end;

procedure TFormGPrint.BB_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFormGPrint.BB_SaveClick(Sender: TObject);
var tt_path:string;
begin
 PicDlg.Execute;
 tt_path:=UpperCase(ExtractFileExt(PicDlg.FileName));
 if tt_path='.BMP' then
   GrafFForm.DBChartFed1.SaveToBitmapFile(PicDlg.FileName)
 else if tt_path='.WMF' then
   GrafFForm.DBChartFed1.SaveToMetafile(PicDlg.FileName)
 else if tt_path='.EMF' then
   GrafFForm.DBChartFed1.SaveToMetafileEnh(PicDlg.FileName);
end;

procedure TFormGPrint.BB_PrintClick(Sender: TObject);
var ix1,ix2,iy1,iy2:integer;
    iXot,iYot,iWidth,iHeight:double;
begin
  iXot:=(SpE_Xots.Value*Printer.PageWidth/hs_pageDef)/1000;
  iYot:=(SpE_Yots.Value*Printer.PageHeight/vs_pageDef)/1000;
  iWidth:=cdrWidth*Printer.PageWidth/hs_pageDef;
  iHeight:=cdrHeight*Printer.PageHeight/vs_pageDef;
  //ClearIm;
  ix1:=round(iXot);                              // tbitmap
  iy1:=round(iYot);
  ix2:=round(iWidth+iXot);
  iy2:=round(iHeight+iYot);
  Printer.BeginDoc;
  GrafFForm.DBChartFed1.PrintPartialCanvas(Printer.Canvas,Rect(ix1,iy1,ix2,iy2));
  Printer.EndDoc;
end;

procedure TFormGPrint.BB_SetupClick(Sender: TObject);
begin
 PrSetupD.Execute;
 FormActivate(Self);
end;


end.
