unit Report_Parent_Unit;

interface
uses Classes,FR_Class;

type
  TParentRep=class
  private
    function GetVarValue(VarName:string):string;
    procedure SetVarValue(VarName:string; value:string);
    function GetFVarNames(ind:integer):string;
    function GetCountVars:integer;
  protected
    FWorkReport:TfrReport;
    FVarNames,FVarValues:TStringList;
    procedure AddNameAndValue(_name:string; _value:string='');
  public
    constructor Create(_work_report:TfrReport; _fn:string);
    destructor Destroy; override;
    procedure Execute; virtual;
    //
    procedure WrapStr(src:string; break_len:integer; var trgt1,trgt2:string);
    procedure LeftSpaces(count_of_spaces:integer; var s:string);
    //
    property VarValue[VarName:string]:string read GetVarValue write SetVarValue;
    property VarNames[index:integer]:string read GetFVarNames;
    property CountVars:integer read GetCountVars;
  end;

implementation

procedure TParentRep.LeftSpaces(count_of_spaces:integer; var s:string);
var s1:string;
  i:integer;
begin
  s1:='';
  for i:=0 to count_of_spaces-1 do s1:=s1+' ';
  s:=s1+s;
end;

procedure TParentRep.WrapStr(src:string; break_len:integer; var trgt1,trgt2:string);
var _l,_k:integer;
begin
  _l:=length(src);
  if _l>break_len then
    begin
      _k:=break_len-1;
      while (src[_k]<>' ') and (_k<>1) do dec(_k);
      trgt1:=Copy(src,1,_k);
      trgt2:=Copy(src,_k+1,_l-_k);      
    end
      else
    begin
      trgt1:=src;
      trgt2:='';
    end;
end;

function TParentRep.GetCountVars:integer;
begin
  result:=FVarNames.Count;
end;

function TParentRep.GetFVarNames(ind:integer):string;
begin
  result:=FVarNames[ind];
end;

function TParentRep.GetVarValue(VarName:string):string;
var i:integer;
begin
  i:=FVarNames.IndexOf(varName);
  if i=-1 then result:='no var' else  result:=FVarValues[i];
end;

procedure TParentRep.SetVarValue(VarName:string; value:string);
  var i:integer;
begin
  i:=FVarNames.IndexOf(varName);
  if i<>-1 then FVarValues[i]:=value;
end;

procedure TParentRep.Execute;
var i:integer;
begin
  for i:=0 to FVarNames.Count-1 do frVariables[FVarNames[i]]:=FVarValues[i];
  FWorkReport.ShowReport;
end;

procedure TParentRep.AddNameAndValue(_name:string; _value:string='');
begin
  FVarNames.Add(_name);
  FVarValues.Add(_value);
end;

constructor TParentRep.Create(_work_report:TfrReport; _fn:string);
begin
  FWorkReport:=_work_report;
  FWorkReport.LoadFromFile(_fn);
  FVarNames:=TStringList.Create;
  FVarValues:=TStringList.Create;
end;

destructor TParentRep.Destroy;
begin
  FVarNames.Free;
  FVarValues.Free;
  inherited;
end;

end.
