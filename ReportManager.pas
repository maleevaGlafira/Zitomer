unit ReportManager;

interface

uses
  SysUtils, Classes, FR_Class, IBDatabase, DB, IBCustomDataSet, DMMain,
  ProgressForm, CustomReport, IB_Reports, FR_DSet, FR_DBSet, IBSQL;

type
  TReportName=(rnZavWithImage);

  TDM_ReportManager = class(TDataModule)
    frReport: TfrReport;
    dset_tmp1: TIBDataSet;
    Transac: TIBTransaction;
    dset_tmp2: TIBDataSet;
    dset_tmp3: TIBDataSet;
    pind_Load: TProgressIndicator;
    frDBDataSet1: TfrDBDataSet;
    IBSQL: TIBSQL;
    Tran_IBSQL: TIBTransaction;
    dset_AvrImage: TIBDataSet;
    transac_AvrImage: TIBTransaction;
  private
    F_Report: TCustomReport;
    function CreateReport(AReportName: TReportName): TCustomReport;
  public
    procedure ShowReport(AReportName: TReportName);
  end;

implementation

{$R *.dfm}

{ TDM_ReportManager }

function TDM_ReportManager.CreateReport(
  AReportName: TReportName): TCustomReport;
begin
  case AReportName of
    rnZavWithImage: Result:=TZavWithImage.Create; //Ведомость заявок с изображениями
  end; //end case
end;

procedure TDM_ReportManager.ShowReport(AReportName: TReportName);
var
  IsExecuteOk: boolean;
begin
  F_Report:=CreateReport(AReportName);

  try
    {Инициализация}
    F_Report.Dset[0]:=dset_tmp1;
    F_Report.Dset[1]:=dset_tmp2;
    F_Report.Dset[2]:=dset_tmp3;
    F_Report.AvrImageDset:=dset_AvrImage;
    F_Report.IBSQL:=IBSQL;
    F_Report.Report:=frReport;
    F_Report.ProgressIndic:=pind_Load;
    {/Инициализация}

    repeat
      if Transac.InTransaction then
        Transac.Rollback;
      Transac.StartTransaction;
      try
        IsExecuteOk:=F_Report.Execute;
      finally
        Transac.Commit;
      end;
    until not IsExecuteOk;

  finally
    F_Report.Free;
  end;
end;

end.
