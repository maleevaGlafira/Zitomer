unit WorkContainerPlanDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WorkContainerDM,BWorkPlanDM, MaterPLanDM, WorkDMPlan;

type
  Tdm_WorkContainerPlan = class(Tdm_WorkContainer)
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  protected

  end;

var
  dm_WorkContainerPlan: Tdm_WorkContainerPlan;

implementation

{$R *.dfm}

procedure Tdm_WorkContainerPlan.DataModuleCreate(Sender: TObject);
begin
 // inherited;
  F_Work :=  Tdm_Work_Plan.Create( nil );
  F_Mater := Tdm_MaterPlan.Create( nil );
  F_BWork := Tdm_BWorkPlan.Create( nil );
end;

end.
