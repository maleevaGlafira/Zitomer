unit CustomReport;

interface

uses Windows, IBCustomDataSet, ProgressForm, FR_Class, FR_DSet, BaseResultForm,
      BaseOptionForm, aligrid, Forms, Controls, SysUtils, IBSQL;

const
  IB_REP_DIR_NAME='ib_reports';

type
  TCustomReport=class
  protected
    F_Name: string;
    F_ReportFileName: string;
    F_Dset: array [0..2] of TIBDataSet;
    F_AvrImageDset: TIBDataSet;
    F_IBSQL: TIBSQL;
    F_ProgressIndic: TProgressIndicator;
    F_Report: TfrReport;
    F_OptionForm: Tfrm_BaseOption;
    F_ResultForm: Tfrm_BaseResult;

    procedure SetDset(Index: integer; val: TIBDataSet);
    function LoadReportFile: boolean;
    function ShowReport: boolean; 
  protected
    function ShowOptionForm: boolean; virtual;
  protected
    procedure InitFields; virtual;
    procedure CreateForms; virtual;
    procedure PrepareResultFormHeader; virtual;
    procedure PrepareResultFormGrid; virtual;
    procedure PrepareResultFormBtns; virtual;
    procedure PrepareFastReport; virtual;
  public
    property Dset[Index: integer]: TIBDataSet write SetDset;
    property AvrImageDset: TIBDataSet write F_AvrImageDset;
    property IBSQL: TIBSQL write F_IBSQL;
    property Report: TfrReport write F_Report;
    property ProgressIndic: TProgressIndicator write F_ProgressIndic;
    constructor Create;
    destructor Destroy; override;
  public
    function Execute: boolean; virtual;
  end;


implementation

uses BaseFrPreviewForm;

constructor TCustomReport.Create;
begin
  inherited Create;

  InitFields;
  CreateForms;
end;

function TCustomReport.Execute: boolean;
begin
end;


procedure TCustomReport.SetDset(Index: integer; val: TIBDataSet);
begin
  F_Dset[Index]:=val;
end;

destructor TCustomReport.Destroy;
begin
  F_OptionForm.Free;
  F_ResultForm.Free;

  inherited Destroy;
end;

procedure TCustomReport.PrepareResultFormBtns;
begin
end;

procedure TCustomReport.PrepareResultFormGrid;
begin
end;

procedure TCustomReport.PrepareResultFormHeader;
begin
end;

procedure TCustomReport.PrepareFastReport;
begin
end;

procedure TCustomReport.CreateForms;
begin
end;

function TCustomReport.ShowOptionForm: boolean;
begin
  if F_OptionForm.ShowModal=mrOk then
    Result:=true
  else
    Result:=false;
end;

function TCustomReport.LoadReportFile: boolean;
var
  FullReportFileName: string;
begin
  FullReportFileName:=ExtractFilePath(ParamStr(0))+IB_REP_DIR_NAME+'\'+F_ReportFileName;
  Result:=F_Report.LoadFromFile(FullReportFileName);
  if not Result then
    Application.MessageBox(PChar('Не могу загрузить файл '+FullReportFileName),
              'Диспетчер АВР', MB_OK+MB_ICONWARNING);
end;

procedure TCustomReport.InitFields;
begin
end;

function TCustomReport.ShowReport: boolean;
var
  frm_FrPreview: Tfrm_BaseFrPreview;
begin
  F_Report.PrepareReport;
  F_Report.ShowPreparedReport;
  if Assigned(F_Report.Preview) and (F_Report.Preview.Owner is Tfrm_BaseFrPreview) then
    (F_Report.Preview.Owner as Tfrm_BaseFrPreview).ShowModal;
end;

end.
