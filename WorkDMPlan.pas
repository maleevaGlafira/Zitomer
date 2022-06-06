unit WorkDMPlan;

interface


uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WorkDM, IBSQL, DB, IBCustomDataSet, IBDatabase;

type
  Tdm_Work_Plan = class(Tdm_Work)
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function GetCurrentRaskopID: integer; overload;
    procedure SetCurrentRaskopID( _RaskopID: integer ); overload;
    procedure SetCurrentRaskopToNULL;   overload;
  end;

  const tableName = 'works_plan';
var
  dm_Work_Plan: Tdm_Work_Plan;

implementation

{$R *.dfm}

procedure Tdm_Work_Plan.DataModuleCreate(Sender: TObject);
begin
  inherited;
f_TableName:=tableName;
Raskop.Free;
Raskop:=nil;

end;

//В планируемых работах в раскопках еичего не делаем

function Tdm_Work_Plan.GetCurrentRaskopID: integer;
begin
 result:=0;
end;

procedure Tdm_Work_Plan.SetCurrentRaskopID( _RaskopID: integer );
begin
end;

procedure Tdm_Work_Plan.SetCurrentRaskopToNULL;
begin
end;

end.
