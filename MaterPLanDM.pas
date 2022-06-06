unit MaterPLanDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MaterDM, IBSQL, IBCustomDataSet, DB, IBDatabase;

type
  Tdm_MaterPlan = class(Tdm_Mater)
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const tableName='maters_plan';  

var
  dm_MaterPlan: Tdm_MaterPlan;

implementation

{$R *.dfm}

procedure Tdm_MaterPlan.DataModuleCreate(Sender: TObject);
begin

  inherited;
  f_tableName:=tablename;
end;

end.
