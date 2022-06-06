unit WorkContainerDM;

interface

uses
  SysUtils, Classes, WorkDM, MaterDM, BWorkDM,WorkDMPlan,MaterPlanDm, BWorkPlanDM;

type
  Tdm_WorkContainer = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);   overload;
    procedure DataModuleDestroy(Sender: TObject);

    protected
    F_Work: Tdm_Work;
    F_Mater: Tdm_Mater;
    F_BWork: Tdm_BWork;
    private
    F_IsReadOnly: boolean;
    F_IsObjZav: boolean;
    F_IdObjObor: integer;

    procedure SetZavID( const Value: integer );
    procedure SetNarID( const Value: integer );
    procedure SetIsReadOnly( const Value: boolean );
    procedure SetIsObjZav( const Value: boolean );
    procedure SetIdObjObor( const Value: integer );

  public


    property Work: Tdm_Work read F_Work write F_Work;
    property Mater: Tdm_Mater read F_Mater write F_Mater;
    property BWork: Tdm_BWork read F_BWork write F_BWork;
    property ZavID: integer write SetZavID;
    property NarID: integer write SetNarID;
    property IdObjObor: integer read F_IdObjObor write SetIdObjObor;
    property IsReadOnly: boolean read F_IsReadOnly write SetIsReadOnly;
    property IsObjZav: boolean read F_IsObjZav write SetIsObjZav;
    procedure StartTran;
    procedure CommitTran;
    procedure RollbackTran;
    procedure OpenDset;
  end;


implementation

{$R *.dfm}

procedure Tdm_WorkContainer.CommitTran;
begin
  F_Work.CommitTran;
  F_Mater.CommitTran;
  F_BWork.CommitTran;
end;

procedure Tdm_WorkContainer.DataModuleCreate(Sender: TObject);
begin
  F_IsReadOnly := false;

  F_Work := Tdm_Work.Create( nil );
  F_Mater := Tdm_Mater.Create( nil );
  F_BWork := Tdm_BWork.Create( nil );
end;



procedure Tdm_WorkContainer.DataModuleDestroy(Sender: TObject);
begin
  F_Work.Free;
  F_Mater.Free;
  F_BWork.Free;
end;

procedure Tdm_WorkContainer.OpenDset;
begin
  F_Work.OpenDset;
  F_Mater.OpenDset;
  F_BWork.OpenDset;
end;

procedure Tdm_WorkContainer.RollbackTran;
begin
  F_Work.RollbackTran;
  F_Mater.RollbackTran;
  F_BWork.RollbackTran;
end;

procedure Tdm_WorkContainer.SetIsReadOnly(const Value: boolean);
begin
  F_IsReadOnly := Value;

  F_BWork.IsReadOnly := F_IsReadOnly;
  F_Work.IsReadOnly := F_IsReadOnly;
  F_Mater.IsReadOnly := F_IsReadOnly;
end;

procedure Tdm_WorkContainer.SetNarID(const Value: integer);
begin
  F_Work.NarID := Value;
  F_Mater.NarID := Value;
  F_BWork.NarID := Value;
end;

procedure Tdm_WorkContainer.SetZavID(const Value: integer);
begin
  F_Work.ZavID := Value;
  F_Mater.ZavID := Value;
  F_BWork.ZavID := Value;
end;

procedure Tdm_WorkContainer.StartTran;
begin
  F_Work.StartTran;
  F_Mater.StartTran;
  F_BWork.StartTran;
end;

procedure Tdm_WorkContainer.SetIsObjZav(const Value: boolean);
begin
  F_Work.IsObjZav := Value;
  F_BWork.IsObjZav := Value;
end;

procedure Tdm_WorkContainer.SetIdObjObor(const Value: integer);
begin
  F_Work.IdObjObor := Value;
  F_BWork.IdObjObor := Value; 

end;


end.
