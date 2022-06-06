unit MyConsoleUnit;

interface
uses Classes,Windows,StrUtils,SyncObjs,Forms;

type
  TMyConsole=class(TThread)
    private
      FCriticalSection:TCriticalSection;
      FConsole:TStringList;
      FCallBackConsole,FOnEndProcess:TNotifyEvent;
      FExe,FParams:string;
      FhReadPipe,FhProcess,FhThread:THandle;
      FInProcess:boolean;
      function GetFConsole:TStrings;
    protected
      procedure ClearConsole;
      procedure CallBackConsoleNow;
      procedure CallBackEndProcess;
      function Zaboy(var _s:string):integer;
      procedure Kill10(var _s:string);
      //
      procedure Execute; override;
      function Run(_cmd:string):boolean;
      procedure Go;
    public
      constructor Create;
      destructor Destroy; override;
      //
      procedure StopProcess;
      //
      property Console:TStrings read GetFConsole;
      property Exe:string read FExe write FExe;
      property Params:string read FParams write FParams;
      property InProcess:boolean read FInProcess;
      //
      property OnCallBackConsole:TNotifyEvent read FCallBackConsole write FCallBackConsole;
      property OnEndProcess:TNotifyEvent read FOnEndProcess write FOnEndProcess;
  end;

implementation

procedure TMyConsole.StopProcess;
begin
  if FhProcess>0 then
    begin
      TerminateProcess(FhProcess,0);
      sleep(500);
    end;
  Terminate;
end;

procedure TMyConsole.Go;
begin
  Run(FExe+' '+FParams);
end;

procedure TMyConsole.Execute;
begin
  while not(Terminated) do Go;
end;

procedure TMyConsole.Kill10(var _s:string);
var i:integer;
begin
  i:=PosEx(#10,_s);
  while i>0 do
  begin
    Delete(_s,i,1);
    i:=PosEx(#8,_s,i);
  end;
end;

function TMyConsole.Zaboy(var _s:string):integer;
var i:integer;
begin
  result:=0;
  i:=PosEx(#8,_s);
  while i>0 do
  begin
    if i<>1 then
      begin
        Delete(_s,i-1,2);
        i:=PosEx(#8,_s,i-1);
        result:=1;
      end
        else
      begin
        i:=0;
        result:=2;
      end;
  end;
end;

procedure TMyConsole.ClearConsole;
begin
  FConsole.Clear;
  Synchronize(CallBackConsoleNow);
end;

procedure TMyConsole.CallBackConsoleNow;
begin
  if Assigned(FCallBackConsole) and not(Terminated) then FCallBackConsole(self);
end;

function TMyConsole.GetFConsole:TStrings;
begin
  result:=FConsole;
end;

function TMyConsole.Run(_cmd:string):boolean;
const nBytesRead=1024;
var
  StartupInfo:TStartupInfo;
  ProcessInfo:TProcessInformation;
  SecAttrs:TSecurityAttributes;
  inBuffer:array[0..nBytesRead] of char;
  hWritePipe:THandle;
  nBytesReadReal:cardinal;
  _s,_s1:string;
  kkk:longint;
  _continue_str:boolean;
  _process_ok:boolean;
begin
  FCriticalSection.Enter;
  try
    FInProcess:=TRUE;
    result:=true;
    FhReadPipe:=0; FhProcess:=0; FhThread:=0;
    ZeroMemory(@StartupInfo, SizeOf(StartupInfo));
    ZeroMemory(@SecAttrs, SizeOf(SecAttrs));
    SecAttrs.nLength := SizeOf(SecAttrs);
    SecAttrs.bInheritHandle := True;
    SecAttrs.lpSecurityDescriptor := nil;
    if not CreatePipe(FhReadPipe, hWritePipe, @SecAttrs, 0) then exit;
    StartupInfo.cb := SizeOf(StartupInfo);
    StartupInfo.dwFlags := STARTF_USESTDHANDLES;
    StartupInfo.wShowWindow := SW_HIDE;
    StartupInfo.hStdOutput := hWritePipe;
    _process_ok:=CreateProcess(nil, PChar(_cmd), nil, nil, True,CREATE_NO_WINDOW, nil, nil, StartupInfo, ProcessInfo);
  finally
    FCriticalSection.Leave;
  end;
  //
  if _process_ok then
  begin
    FCriticalSection.Enter;
    try
      CloseHandle(hWritePipe);
      FhProcess:=ProcessInfo.hProcess;
      FhThread:=ProcessInfo.hThread;
    finally
      FCriticalSection.Leave;
    end;
    ////////////////////////////////////////////////////////////////////////////
      ClearConsole; _s1:=''; _continue_str:=false;
      while (ReadFile(FhReadPipe,inBuffer,nBytesRead,nBytesReadReal,nil)) and not(Terminated) do
        begin
          FCriticalSection.Enter;
          try
            inBuffer[nBytesReadReal]:=#0;
            OEMToChar(PAnsiChar(@inBuffer[0]),PAnsiChar(@inBuffer[0]));
            _s:=inBuffer;
            Kill10(_s);
            kkk:=PosEx(#13,_s);
            while kkk>0 do
              begin
                _s1:=_s1+Copy(_s,1,kkk-1);
                Delete(_s,1,kkk);
                Kill10(_s);
                if (_continue_str) then FConsole[FConsole.Count-1]:=_s1 else FConsole.Add(_s1);
                Synchronize(CallBackConsoleNow);
                _s1:='';
                _continue_str:=FALSE;
                //
                kkk:=PosEx(#13,_s);
              end;
            _s1:=_s1+_s;
            if Zaboy(_s1)=1 then
              begin
                if (_continue_str) then FConsole[FConsole.Count-1]:=_s1  else FConsole.Add(_s1);
                Synchronize(CallBackConsoleNow);
                _continue_str:=TRUE;
              end;
          finally
            FCriticalSection.Leave;
          end;
       end; {while (ReadFile}
    ////////////////////////////////////////////////////////////////////////////
    //
    FCriticalSection.Enter;
    try
      CloseHandle(ProcessInfo.hProcess);
      CloseHandle(ProcessInfo.hThread);
    finally
      FCriticalSection.Leave;
    end;
    //
  end {if _process_ok}
    else result:=FALSE;
  //
  FCriticalSection.Enter;
  try
    CloseHandle(FhReadPipe);
    FhReadPipe:=0; FhProcess:=0; FhThread:=0;
    FInProcess:=FALSE;
  finally
    FCriticalSection.Leave;
  end;
  //
  Synchronize(CallBackEndProcess);
  Suspend;
end;

procedure TMyConsole.CallBackEndProcess;
begin
  if Assigned(FOnEndProcess) then FOnEndProcess(self);
end;

constructor TMyConsole.Create;
begin
  FhReadPipe:=0; FhProcess:=0; FhThread:=0;
  FCriticalSection:=TCriticalSection.Create;
  FConsole:=TStringList.Create;
  FreeOnTerminate:=false;
  inherited Create(true);
end;

destructor TMyConsole.Destroy;
begin
  if not(Terminated) then Terminate;
  FConsole.Free;
  FCriticalSection.Free;
  inherited;
end;

end.
