unit atm_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : $Revision: 1.1 $
// File generated on 30.08.2001 13:41:52 from Type Library described below.

// *************************************************************************//
// NOTE:                                                                      
// Items guarded by $IFDEF_LIVE_SERVER_AT_DESIGN_TIME are used by properties  
// which return objects that may need to be explicitly created via a function 
// call prior to any access via the property. These items have been disabled  
// in order to prevent accidental use from within the object inspector. You   
// may enable them by defining LIVE_SERVER_AT_DESIGN_TIME or by selectively   
// removing them from the $IFDEF blocks. However, such items must still be    
// programmatically created via a method of the appropriate CoClass before    
// they can be used.                                                          
// ************************************************************************ //
// Type Lib: D:\Work\Avar\Proj_new\atm.tlb (1)
// IID\LCID: {16A84F64-63B2-4BA7-9A60-D3B6C1ACE993}\0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINNT\System32\stdole2.tlb)
//   (2) v4.0 StdVCL, (C:\WINNT\System32\STDVCL40.DLL)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
interface

uses Windows, ActiveX, Classes, Graphics, OleServer, OleCtrls, StdVCL;

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  atmMajorVersion = 1;
  atmMinorVersion = 0;

  LIBID_atm: TGUID = '{16A84F64-63B2-4BA7-9A60-D3B6C1ACE993}';

  IID_IMapBack: TGUID = '{A1ECBFF2-3E7E-421E-9CCD-8EB275166107}';
  CLASS_MapBack: TGUID = '{5A619E2C-D1C9-4643-8D22-AC39DBAE2F1A}';
  IID_IatmInterf: TGUID = '{B7824182-A614-4631-A70B-A56106D36ACB}';
  DIID_IatmInterfEvents: TGUID = '{0E20717A-7DD4-4967-A5D9-9C052BC3F96D}';
  CLASS_atmInterf: TGUID = '{3626068D-13E3-40BA-9488-04ED388F4DF3}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum MarkTypeResult
type
  MarkTypeResult = TOleEnum;
const
  NoMarked = $FFFFFFFF;
  MarkedPrew = $00000000;
  MarkedLinked = $00000001;
  MarkedClosed = $00000002;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IMapBack = interface;
  IMapBackDisp = dispinterface;
  IatmInterf = interface;
  IatmInterfDisp = dispinterface;
  IatmInterfEvents = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  MapBack = IMapBack;
  atmInterf = IatmInterf;


// *********************************************************************//
// Interface: IMapBack
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A1ECBFF2-3E7E-421E-9CCD-8EB275166107}
// *********************************************************************//
  IMapBack = interface(IDispatch)
    ['{A1ECBFF2-3E7E-421E-9CCD-8EB275166107}']
    function  Telnet(ParIn: OleVariant): OleVariant; safecall;
  end;

// *********************************************************************//
// DispIntf:  IMapBackDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A1ECBFF2-3E7E-421E-9CCD-8EB275166107}
// *********************************************************************//
  IMapBackDisp = dispinterface
    ['{A1ECBFF2-3E7E-421E-9CCD-8EB275166107}']
    function  Telnet(ParIn: OleVariant): OleVariant; dispid 1;
  end;

// *********************************************************************//
// Interface: IatmInterf
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B7824182-A614-4631-A70B-A56106D36ACB}
// *********************************************************************//
  IatmInterf = interface(IDispatch)
    ['{B7824182-A614-4631-A70B-A56106D36ACB}']
    procedure EditMark(z_id: Integer); safecall;
    function  IsMarkedEx(r_id: Integer; out m_id: Integer; out m_type: MarkTypeResult; 
                         out w_id: Integer; out w_type: Integer): MarkTypeResult; safecall;
    function  IsMarked(r_id: Integer): MarkTypeResult; safecall;
    procedure CloseRequest(z_id: Integer); safecall;
    procedure CheckCloseAll; safecall;
    procedure ClearShow; safecall;
    procedure ShowMark(r_id: Integer); safecall;
  end;

// *********************************************************************//
// DispIntf:  IatmInterfDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B7824182-A614-4631-A70B-A56106D36ACB}
// *********************************************************************//
  IatmInterfDisp = dispinterface
    ['{B7824182-A614-4631-A70B-A56106D36ACB}']
    procedure EditMark(z_id: Integer); dispid 1;
    function  IsMarkedEx(r_id: Integer; out m_id: Integer; out m_type: MarkTypeResult; 
                         out w_id: Integer; out w_type: Integer): MarkTypeResult; dispid 2;
    function  IsMarked(r_id: Integer): MarkTypeResult; dispid 3;
    procedure CloseRequest(z_id: Integer); dispid 4;
    procedure CheckCloseAll; dispid 5;
    procedure ClearShow; dispid 6;
    procedure ShowMark(r_id: Integer); dispid 7;
  end;

// *********************************************************************//
// DispIntf:  IatmInterfEvents
// Flags:     (4096) Dispatchable
// GUID:      {0E20717A-7DD4-4967-A5D9-9C052BC3F96D}
// *********************************************************************//
  IatmInterfEvents = dispinterface
    ['{0E20717A-7DD4-4967-A5D9-9C052BC3F96D}']
    procedure OnShowPassprt(z_id: Integer); dispid 1;
  end;

// *********************************************************************//
// The Class CoMapBack provides a Create and CreateRemote method to          
// create instances of the default interface IMapBack exposed by              
// the CoClass MapBack. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoMapBack = class
    class function Create: IMapBack;
    class function CreateRemote(const MachineName: string): IMapBack;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TMapBack
// Help String      : MapBack Object
// Default Interface: IMapBack
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TMapBackProperties= class;
{$ENDIF}
  TMapBack = class(TOleServer)
  private
    FIntf:        IMapBack;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TMapBackProperties;
    function      GetServerProperties: TMapBackProperties;
{$ENDIF}
    function      GetDefaultInterface: IMapBack;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IMapBack);
    procedure Disconnect; override;
    function  Telnet(ParIn: OleVariant): OleVariant;
    property  DefaultInterface: IMapBack read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TMapBackProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TMapBack
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TMapBackProperties = class(TPersistent)
  private
    FServer:    TMapBack;
    function    GetDefaultInterface: IMapBack;
    constructor Create(AServer: TMapBack);
  protected
  public
    property DefaultInterface: IMapBack read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoatmInterf provides a Create and CreateRemote method to          
// create instances of the default interface IatmInterf exposed by              
// the CoClass atmInterf. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoatmInterf = class
    class function Create: IatmInterf;
    class function CreateRemote(const MachineName: string): IatmInterf;
  end;

  TatmInterfOnShowPassprt = procedure(Sender: TObject; z_id: Integer) of object;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TatmInterf
// Help String      : atmInterf Object
// Default Interface: IatmInterf
// Def. Intf. DISP? : No
// Event   Interface: IatmInterfEvents
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TatmInterfProperties= class;
{$ENDIF}
  TatmInterf = class(TOleServer)
  private
    FOnShowPassprt: TatmInterfOnShowPassprt;
    FIntf:        IatmInterf;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TatmInterfProperties;
    function      GetServerProperties: TatmInterfProperties;
{$ENDIF}
    function      GetDefaultInterface: IatmInterf;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IatmInterf);
    procedure Disconnect; override;
    procedure EditMark(z_id: Integer);
    function  IsMarkedEx(r_id: Integer; out m_id: Integer; out m_type: MarkTypeResult; 
                         out w_id: Integer; out w_type: Integer): MarkTypeResult;
    function  IsMarked(r_id: Integer): MarkTypeResult;
    procedure CloseRequest(z_id: Integer);
    procedure CheckCloseAll;
    procedure ClearShow;
    procedure ShowMark(r_id: Integer);
    property  DefaultInterface: IatmInterf read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TatmInterfProperties read GetServerProperties;
{$ENDIF}
    property OnShowPassprt: TatmInterfOnShowPassprt read FOnShowPassprt write FOnShowPassprt;
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TatmInterf
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TatmInterfProperties = class(TPersistent)
  private
    FServer:    TatmInterf;
    function    GetDefaultInterface: IatmInterf;
    constructor Create(AServer: TatmInterf);
  protected
  public
    property DefaultInterface: IatmInterf read GetDefaultInterface;
  published
  end;
{$ENDIF}


procedure Register;

implementation

uses ComObj;

class function CoMapBack.Create: IMapBack;
begin
  Result := CreateComObject(CLASS_MapBack) as IMapBack;
end;

class function CoMapBack.CreateRemote(const MachineName: string): IMapBack;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_MapBack) as IMapBack;
end;

procedure TMapBack.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{5A619E2C-D1C9-4643-8D22-AC39DBAE2F1A}';
    IntfIID:   '{A1ECBFF2-3E7E-421E-9CCD-8EB275166107}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TMapBack.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IMapBack;
  end;
end;

procedure TMapBack.ConnectTo(svrIntf: IMapBack);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TMapBack.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TMapBack.GetDefaultInterface: IMapBack;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TMapBack.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TMapBackProperties.Create(Self);
{$ENDIF}
end;

destructor TMapBack.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TMapBack.GetServerProperties: TMapBackProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function  TMapBack.Telnet(ParIn: OleVariant): OleVariant;
begin
  Result := DefaultInterface.Telnet(ParIn);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TMapBackProperties.Create(AServer: TMapBack);
begin
  inherited Create;
  FServer := AServer;
end;

function TMapBackProperties.GetDefaultInterface: IMapBack;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoatmInterf.Create: IatmInterf;
begin
  Result := CreateComObject(CLASS_atmInterf) as IatmInterf;
end;

class function CoatmInterf.CreateRemote(const MachineName: string): IatmInterf;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_atmInterf) as IatmInterf;
end;

procedure TatmInterf.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{3626068D-13E3-40BA-9488-04ED388F4DF3}';
    IntfIID:   '{B7824182-A614-4631-A70B-A56106D36ACB}';
    EventIID:  '{0E20717A-7DD4-4967-A5D9-9C052BC3F96D}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TatmInterf.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as IatmInterf;
  end;
end;

procedure TatmInterf.ConnectTo(svrIntf: IatmInterf);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TatmInterf.DisConnect;
begin
  if Fintf <> nil then
  begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TatmInterf.GetDefaultInterface: IatmInterf;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TatmInterf.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TatmInterfProperties.Create(Self);
{$ENDIF}
end;

destructor TatmInterf.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TatmInterf.GetServerProperties: TatmInterfProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TatmInterf.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
   1: if Assigned(FOnShowPassprt) then
            FOnShowPassprt(Self, Params[0] {Integer});
  end; {case DispID}
end;

procedure TatmInterf.EditMark(z_id: Integer);
begin
  DefaultInterface.EditMark(z_id);
end;

function  TatmInterf.IsMarkedEx(r_id: Integer; out m_id: Integer; out m_type: MarkTypeResult; 
                                out w_id: Integer; out w_type: Integer): MarkTypeResult;
begin
  Result := DefaultInterface.IsMarkedEx(r_id, m_id, m_type, w_id, w_type);
end;

function  TatmInterf.IsMarked(r_id: Integer): MarkTypeResult;
begin
  Result := DefaultInterface.IsMarked(r_id);
end;

procedure TatmInterf.CloseRequest(z_id: Integer);
begin
  DefaultInterface.CloseRequest(z_id);
end;

procedure TatmInterf.CheckCloseAll;
begin
  DefaultInterface.CheckCloseAll;
end;

procedure TatmInterf.ClearShow;
begin
  DefaultInterface.ClearShow;
end;

procedure TatmInterf.ShowMark(r_id: Integer);
begin
  DefaultInterface.ShowMark(r_id);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TatmInterfProperties.Create(AServer: TatmInterf);
begin
  inherited Create;
  FServer := AServer;
end;

function TatmInterfProperties.GetDefaultInterface: IatmInterf;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

procedure Register;
begin
  RegisterComponents('Servers',[TMapBack, TatmInterf]);
end;

end.
