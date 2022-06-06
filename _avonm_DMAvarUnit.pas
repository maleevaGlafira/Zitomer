unit _avonm_DMAvarUnit;

interface

uses
  SysUtils, Classes, SendMessToAvarOnMap,AvarOnMapConst,_avonm_DopFuncsUnit,_avonm_DMParentUnit,
    Forms,Messages,Windows,Controls,Graphics;

type

	TDM_GateAvar = class(TDM_AvarParent)
  private
    { Private declarations }
  protected
  public
		constructor Create;
		destructor Destroy; override;
    //
    procedure ReConnectEventsToManager; override;
		procedure ShowMap;
  end;

var
  DM_GateAvar: TDM_GateAvar;

implementation

procedure TDM_GateAvar.ReConnectEventsToManager;
begin
  ManageAvarOnMap.OnServerAsk:=AskInfo;
  ManageAvarOnMap.OnScreenShot:=OnScreenShot;
end;

procedure TDM_GateAvar.ShowMap;
begin
  if MAP_IS_WORK then
  begin
    SendCurrAvarToMap(1{CreateAvar},0{OnlyScale},0{HideMainForm},1000{Scale});
    ManageAvarOnMap.Show;
  end
  else
    Application.MessageBox('Карта не запущена!','Диспетчер АВР',MB_ICONWARNING or MB_OK);
end;

////

constructor TDM_GateAvar.Create;
begin
	inherited;
  if MAP_IS_WORK then
  begin
    ReConnectEventsToManager;
  end;
end;

destructor TDM_GateAvar.Destroy;
begin
   if MAP_IS_WORK then
   begin
     ManageAvarOnMap.OnSnapShotIDAvarAndAddrFromDataSetEvent:=nil;
     ManageAvarOnMap.OnServerAsk:=nil;
     ManageAvarOnMap.OnScreenShot:=nil;
     ManageAvarOnMap.Hide;
   end;
	inherited;
end;

end.
