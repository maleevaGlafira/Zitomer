unit Report_Act_Unit;

interface
uses Report_Parent_Unit,FR_Class;

type
  TActRep=class(TParentRep)
  private
  public
    constructor Create(_work_report:TfrReport; _fn:string);
    destructor Destroy; override;
  end;

implementation

constructor TActRep.Create(_work_report:TfrReport; _fn:string);
begin
  inherited Create(_work_report,_fn);
  AddNameAndValue('actday');
  AddNameAndValue('actmonth');
  AddNameAndValue('actyear');
  AddNameAndValue('diam1');
  AddNameAndValue('street');
  AddNameAndValue('day1');
  AddNameAndValue('month1');
  AddNameAndValue('year1');
  AddNameAndValue('hour1');
  AddNameAndValue('day2');
  AddNameAndValue('month2');
  AddNameAndValue('year2');
  AddNameAndValue('xarpovr');
  AddNameAndValue('povrpressure');
  AddNameAndValue('protyazhoporozhn');
  AddNameAndValue('povr_pressure');
  AddNameAndValue('protyazh_oporozhn');
  AddNameAndValue('work_end_time');
  AddNameAndValue('work_end_day');
  AddNameAndValue('work_end_month');
  AddNameAndValue('work_end_year');
  AddNameAndValue('doza_clor');
  AddNameAndValue('contact_time');
  AddNameAndValue('promyv_time');
  AddNameAndValue('poteri_promyv');
  AddNameAndValue('poteri_oporozhn');
  AddNameAndValue('poteri_povrezhd');
  AddNameAndValue('poteri_obschie');
  AddNameAndValue('nach_otdel');
  AddNameAndValue('nach_obj');
  AddNameAndValue('proizvod_rabot');
end;

destructor TActRep.Destroy;
begin
  inherited;
end;

end.
