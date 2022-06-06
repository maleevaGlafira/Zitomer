unit Report_ActRask_Unit;

interface
uses Report_Parent_Unit,FR_Class;

type
  TActRaskRep=class(TParentRep)
  private
  public
    constructor Create(_work_report:TfrReport; _fn:string);
    destructor Destroy; override;
  end;

implementation

constructor TActRaskRep.Create(_work_report:TfrReport; _fn:string);
begin
  inherited Create(_work_report,_fn);
  AddNameAndValue('BR_ACT');
  AddNameAndValue('BRBLAG');
  AddNameAndValue('ADRES');
  AddNameAndValue('NOMER');
  AddNameAndValue('OGRAGD');
  AddNameAndValue('NeedWork');
  AddNameAndValue('AddWork');
  AddNameAndValue('LEN');
  AddNameAndValue('WID');
  AddNameAndValue('DEP');
  AddNameAndValue('DTZAV');
  AddNameAndValue('DTTM');  
end;

destructor TActRaskRep.Destroy;
begin
  inherited;
end;

end.
