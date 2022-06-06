unit NGReportManager;

interface

uses NGBaseReport;

type
  TNGReportName=(rnWWater, rnSvodVed2, rnSvodVed21,rnSvodVed3, rnSvodVed2Alien, rnSearchAdres, rnUtechkiZaPeriod,
                  rnTrudoZatrat, rnMatUse, rnSvodkaSES, rnOtlRep,   rnSvodPlanWorks,
                  rnDiskonSvod,rnRepJurnal,rnDiskonForm13,
                  rnRepExcavNotFinished,rnRepExcavNotFinished2,
                  rnRepCloseExcavd,rnDiskonForm13Group,rnOpenDisconShift);

  TNGReportManager=class
  public
    function CreateReport(AReportName: TNGReportName): TNGBaseReport;
    procedure ShowReport(AReportName: TNGReportName);
  end;

implementation

uses NGReports,NGReports2015;

function TNGReportManager.CreateReport(
  AReportName: TNGReportName): TNGBaseReport;
begin
  case AReportName of
    rnWWater:           Result := TWWater.Create;               //������ ��������� ��� ����
    rnSvodVed2:         Result := TSvodVed2.Create;             //������� ��������� �2
    rnSvodVed21:        Result := TSvodVed21.Create;            //������� ��������� �2_1
    rnSvodVed3:         Result := TSvodVed3.Create;             //������� ��������� �3
    rnSvodVed2Alien:    Result := TSvodVed2Alien.Create;        //������� ��������� �2(�����)
    rnSearchAdres:      Result := TSearchAdres.Create;          //����� ������� ������ ������������� ���-��
    rnUtechkiZaPeriod:  Result := TUtechkiZaPeriod.Create;      //������ ������ �� ������
    rnTrudoZatrat:      Result := TTrudoZatrat.Create;          //������ �����������
    rnMatUse:           Result := TMatUse.Create;               //������ �������������� ����������
    rnSvodkaSES:        Result := TSvodkaSES.Create;            //������ � ���
    rnOtlRep:           Result := TOtlRep.Create;               //������ ����������
    rnSvodPlanWorks:    REsult := TSvodPlanWorks.Create;        //�������� ��������������� �����
    rnDiskonSvod:       Result := TDiskonSvod.Create;           //������ ��������� �� ������
    rnRepJurnal:        Result := TRepJurnal.Create;            //�������� ������
    rnDiskonForm13:     result := TDiskonForm13.Create;         //���������� Թ13 �����
    rnRepExcavNotFinished: result := TRepExcavNotFinished.Create; //������ ��������������� ���� ��������
    rnRepExcavNotFinished2: result := TRepExcavNotFinished2.Create; //������� ��������� ����� ���������� �����������
    rnRepCloseExcavd: result:=TRepCloseExcavd.Create;//'��������� �������������� �������� '
    rnDiskonForm13Group :result:=TDiskonForm13Group.Create; //
    rnOpenDisconShift :result:=TOpenDisconShift.Create;//���� ������ � ������������������
  end;
end;

procedure TNGReportManager.ShowReport(AReportName: TNGReportName);
var
  IsExecuteOk: boolean;
  report: TNGBaseReport;
begin
  report:=CreateReport(AReportName);
  try
    repeat
      IsExecuteOk:=report.Execute;
    until not IsExecuteOk;
  finally
    report.Free;
  end;
end;

end.
