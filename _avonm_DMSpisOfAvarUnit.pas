unit _avonm_DMSpisOfAvarUnit;

interface

uses
  SysUtils, Classes, DB, DBTables, SendMessToAvarOnMap,AvarOnMapConst,DateUtils,Variants,_avonm_DopFuncsUnit,
  _avonm_DMParentUnit;

type

  TDM_GateSpisOfAvar = class(TDM_AvarParent)
  private
    { Private declarations }
    FOnReceivedSpisAvar:TNotifyEvent;
    FSnapShotIDAvarAndAddrFromDataSetEvent:TSnapShotIDAvarAndAddrFromDataSetEvent;
    procedure ReceiveMassivIDAvarAndType;
    procedure SetFSnapShotIDAvarAndAddrFromDataSetEvent(value:TSnapShotIDAvarAndAddrFromDataSetEvent);
    procedure SetRECEIVE_TYPES(value:boolean);
    function GetRECEIVE_TYPES:boolean;
  protected
  public
 		constructor Create;
		destructor Destroy; override;
		{ Public declarations }
    procedure Razmetit;
    procedure SendSpisOfAvarToAvarOnMap;
    procedure ReConnectEventsToManager; override;
    //
    property RECEIVE_TYPES:boolean read GetRECEIVE_TYPES write SetRECEIVE_TYPES;
    //property OnReceivedScreenShot:TNotifyEvent read FOnReceivedScreenShot write SetFOnReceivedScreenShot;
    property OnSnapShotIDAvarAndAddrFromDataSetEvent:TSnapShotIDAvarAndAddrFromDataSetEvent read FSnapShotIDAvarAndAddrFromDataSetEvent write SetFSnapShotIDAvarAndAddrFromDataSetEvent;
    property OnReceivedSpisAvar:TNotifyEvent read FOnReceivedSpisAvar write FOnReceivedSpisAvar;
  end;

var
  DM_GateSpisOfAvar: TDM_GateSpisOfAvar;

implementation

{procedure TDM_GateSpisOfAvar.SetFOnReceivedScreenShot(value:TNotifyEvent);
begin
  FOnReceivedScreenShot:=value;
  ManageAvarOnMap.OnScreenShot:=value;
end;}

procedure TDM_GateSpisOfAvar.ReConnectEventsToManager;
begin
  ManageAvarOnMap.ProcReceiveMassivIDAvarAndType:=ReceiveMassivIDAvarAndType;
  ManageAvarOnMap.OnServerAsk:=AskInfo;
end;

function TDM_GateSpisOfAvar.GetRECEIVE_TYPES:boolean;
begin
  result:=ManageAvarOnMap.RECEIVE_TYPES;
end;

procedure TDM_GateSpisOfAvar.SetRECEIVE_TYPES(value:boolean);
begin
  ManageAvarOnMap.RECEIVE_TYPES:=value;
end;

procedure TDM_GateSpisOfAvar.SetFSnapShotIDAvarAndAddrFromDataSetEvent(value:TSnapShotIDAvarAndAddrFromDataSetEvent);
begin
  FSnapShotIDAvarAndAddrFromDataSetEvent:=value;
  ManageAvarOnMap.OnSnapShotIDAvarAndAddrFromDataSetEvent:=value;
end;

procedure TDM_GateSpisOfAvar.Razmetit;
var i:integer;
  _res:string;
begin
  {Разметим аварии}
  if MAP_IS_WORK then
  begin
    ManageAvarOnMap.SnapShotIDAvarAndAddrFromDataSet(_res);
    ManageAvarOnMap.SendDataType:=sdtSendMassivID;
    ManageAvarOnMap.idsForSend.ListOfIDToSend:=_res;
    ManageAvarOnMap.SendData;
  end;
end;

procedure TDM_GateSpisOfAvar.ReceiveMassivIDAvarAndType;
begin
  ManageAvarOnMap.RECEIVE_TYPES:=TRUE;
  if Assigned(FOnReceivedSpisAvar) then FOnReceivedSpisAvar(self); 
end;

procedure TDM_GateSpisOfAvar.SendSpisOfAvarToAvarOnMap;
var _res:string;
begin
  if MAP_IS_WORK then
  begin
    ManageAvarOnMap.RECEIVE_TYPES:=FALSE; //пришли айди аварий и типы
    ManageAvarOnMap.SnapShotIDAvarAndAddrFromDataSet(_res);
    ManageAvarOnMap.SendDataType:=sdtSendMassivIDWithoutRazmetka;
    ManageAvarOnMap.idsForSend.ListOfIDToSend:=_res;
    ManageAvarOnMap.SendData;
  end;
end;

////

constructor TDM_GateSpisOfAvar.Create;
begin
	inherited;
  if MAP_IS_WORK then
  begin
    ManageAvarOnMap.RECEIVE_TYPES:=FALSE; //пришли айди аварий и типы
    ReConnectEventsToManager;
  end;
end;

destructor TDM_GateSpisOfAvar.Destroy;
begin
  if MAP_IS_WORK then
  begin
     FOnReceivedSpisAvar:=nil;
     ManageAvarOnMap.OnSnapShotIDAvarAndAddrFromDataSetEvent:=nil;
     ManageAvarOnMap.OnServerAsk:=nil;
     ManageAvarOnMap.OnScreenShot:=nil;
     ManageAvarOnMap.ProcReceiveMassivIDAvarAndType:=nil;
     ManageAvarOnMap.CANCEL_sdtSendMassivID;
     ManageAvarOnMap.Hide;
  end;
	inherited;
end;

end.
