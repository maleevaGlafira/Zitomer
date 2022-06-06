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
    rnWWater:           Result := TWWater.Create;               //Сводка абонентов без воды
    rnSvodVed2:         Result := TSvodVed2.Create;             //Сводная ведомость №2
    rnSvodVed21:        Result := TSvodVed21.Create;            //Сводная ведомость №2_1
    rnSvodVed3:         Result := TSvodVed3.Create;             //Сводная ведомость №3
    rnSvodVed2Alien:    Result := TSvodVed2Alien.Create;        //Сводная ведомость №2(чужие)
    rnSearchAdres:      Result := TSearchAdres.Create;          //Поиск адресов больше определенного кол-ва
    rnUtechkiZaPeriod:  Result := TUtechkiZaPeriod.Create;      //Сводка утечек за период
    rnTrudoZatrat:      Result := TTrudoZatrat.Create;          //Сводка трудозатрат
    rnMatUse:           Result := TMatUse.Create;               //Сводка использованных материалов
    rnSvodkaSES:        Result := TSvodkaSES.Create;            //Сводка в СЭС
    rnOtlRep:           Result := TOtlRep.Create;               //Сводка отложенных
    rnSvodPlanWorks:    REsult := TSvodPlanWorks.Create;        //Перечень запланированных работ
    rnDiskonSvod:       Result := TDiskonSvod.Create;           //Сводка отлючений за период
    rnRepJurnal:        Result := TRepJurnal.Create;            //Суточный журнал
    rnDiskonForm13:     result := TDiskonForm13.Create;         //Отключения Ф№13 НКРЕП
    rnRepExcavNotFinished: result := TRepExcavNotFinished.Create; //Сводка благоустройства мест разрытий
    rnRepExcavNotFinished2: result := TRepExcavNotFinished2.Create; //Сводная ведомость после ликвидации повреждений
    rnRepCloseExcavd: result:=TRepCloseExcavd.Create;//'Ведомость восстановления раскопок '
    rnDiskonForm13Group :result:=TDiskonForm13Group.Create; //
    rnOpenDisconShift :result:=TOpenDisconShift.Create;//Звіть наряди з незакритимивиїздами
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
