unit AvrPatchUnit;

interface

uses Windows, SysUtils, Forms;

const
  LOG_FILE='AvrPatch.log'; 

type
  TExecuteScriptProc=function (Alias: PChar; ScriptFile: PChar): integer;
  TAvrPatch=class
  private
    F_ExecuteScriptProc: TExecuteScriptProc;
    F_LibraryHandle: THandle;
    F_Alias: string;
    F_ScriptFile: string;
    F_LogFile: string;
    procedure WriteToLog(s: string);
  public
    constructor Create(Alias: string; ScriptFile: string);
    destructor Destroy; override;
    procedure Execute;
  end;

implementation

uses PatchWaitForm;

{ TAvrPatch }

constructor TAvrPatch.Create(Alias: string; ScriptFile: string);
begin
  inherited Create;
  F_Alias:=Alias;
  F_ScriptFile:=ScriptFile;
  F_LogFile:=ExtractFilePath(ParamStr(0))+LOG_FILE;
  F_LibraryHandle := LoadLibrary(PChar(ExtractFilePath(ParamStr(0)) + 'AvrScript.dll'));
  F_ExecuteScriptProc := GetProcAddress(F_LibraryHandle, 'ExecuteScript');
  if not Assigned(F_ExecuteScriptProc)then
    MessageBox(0, 'Ошибка загрузки AvrScript.dll', '', MB_OK or MB_ICONWARNING);
end;

destructor TAvrPatch.Destroy;
begin
  if F_LibraryHandle>0 then FreeLibrary(F_LibraryHandle);
  inherited Destroy;
end;

procedure TAvrPatch.Execute;
var
  WaitFrm: Tfrm_PatchWait;
  IsExecute: integer;
begin
  WaitFrm:=Tfrm_PatchWait.Create(nil);
  try
    WaitFrm.Show;
    IsExecute:=F_ExecuteScriptProc(PChar(F_Alias), PChar(F_ScriptFile));
    WaitFrm.Close;
  finally
    WaitFrm.Free;
  end;

  if IsExecute=0 then
  begin
    WriteToLog(ExtractFileName(F_ScriptFile));
    Application.MessageBox('Патч выполнен успешно', 'Диспетчер АВР', MB_OK+MB_ICONWARNING);
  end else
  begin
    Application.MessageBox('Ошибка выполнения патча', 'Диспетчер АВР', MB_OK+MB_ICONERROR);
    Application.Terminate;
  end;
end;

procedure TAvrPatch.WriteToLog(s: string);
var
  f: TextFile;
begin
  AssignFile(f, F_LogFile);
  try
    if not FileExists(F_LogFile) then
      Rewrite(f)
    else
      Append(f);
    writeln(f, DateTimeToStr(Now)+'  '+s);
  finally
    CloseFile(f);
  end;
end;

end.
