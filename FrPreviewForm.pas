unit FrPreviewForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, FR_View, StdCtrls, Buttons,
  FR_Class, frOLEExl, frRtfExp;

type
  Tfrm_FrPreview = class(TForm)
    pnl_Btns: TPanel;
    frPreview: TfrPreview;
    sb_Print: TSpeedButton;
    sb_Excel: TSpeedButton;
    sb_exit: TSpeedButton;
    frOLEExcelExport: TfrOLEExcelExport;
    dlg_SaveExcel: TSaveDialog;
    frRtfAdvExport: TfrRtfAdvExport;
    sb_Word: TSpeedButton;
    dlg_SaveWord: TSaveDialog;
    procedure sb_PrintClick(Sender: TObject);
    procedure sb_ExcelClick(Sender: TObject);
    procedure sb_exitClick(Sender: TObject);
    procedure sb_WordClick(Sender: TObject);
  private
    frReport: TfrReport;
  public
    constructor Create(AOwner: TComponent; frRep: TfrReport);
  end;


implementation

{$R *.dfm}

procedure Tfrm_FrPreview.sb_PrintClick(Sender: TObject);
begin
  frPreview.Print;
end;

procedure Tfrm_FrPreview.sb_ExcelClick(Sender: TObject);
begin
  if not dlg_SaveExcel.Execute then exit;
  frReport.ExportTo(frOLEExcelExport, dlg_SaveExcel.FileName);
  Application.MessageBox('Отчет сохранен в формате XLS',
                          'Диспетчер АВР', MB_OK+MB_ICONINFORMATION);
end;

constructor Tfrm_FrPreview.Create(AOwner: TComponent; frRep: TfrReport);
begin
  inherited Create(AOwner);
  frReport:=frRep;
end;

procedure Tfrm_FrPreview.sb_exitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_FrPreview.sb_WordClick(Sender: TObject);
begin
  if not dlg_SaveWord.Execute then exit;
  frReport.ExportTo(self.frRtfAdvExport, dlg_SaveWord.FileName+'.rtf');
  Application.MessageBox('Отчет сохранен в формате RFT',
                          'Диспетчер АВР', MB_OK+MB_ICONINFORMATION);
end;

end.
