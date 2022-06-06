unit BackUpUnit;

interface
uses Classes,SysUtils,Windows,ShellApi,Forms,StrUtils,MyConsoleUnit;

const
  BACKUP_DIR_NAME='!backup';

type

  TMyBackUp=class
    private
      FTargetFile:string;
      FTargetDir:string;
      FBackUpFile,FBackUpDir:string;
      FCurrentDir:string;
      FTempPath:string;
      FRarFileName:string;
      FMyConsole:TMyConsole;
      FBackupsList:TStringList;
      procedure SetFTargetFile(value:string);
      function GenUniqueName:string;
      procedure RarExtract;
      procedure CreateBackUpDir;
      function GetFBackupsList:TStrings;
    protected
      function GetFreeDiskSpace:cardinal;
      function GetTargetFileSize:cardinal;
      function GetBackupFileSize:cardinal;
      procedure ExtractRes(ResType,ResName,ResNewName:String);
      function TempPath():string;
      function RunExe(fn,params:string):integer;
    public
      constructor Create;
      destructor Destroy;override;
      //
      procedure BackUpNow;
      procedure RestoreNow(_backupFileName:string);
      procedure LoadBackupsList;
      //
      function GetPathOfAliasIB(_alias:string):string;
      //
      property TargetFile:string read FTargetFile write SetFTargetFile;
      property BackUpFile:string read FBackUpFile;
      property TargetDir:string read FTargetDir;
      property FreeDiskSpace:cardinal read GetFreeDiskSpace;
      property TargetFileSize:cardinal read GetTargetFileSize;
      property BackupFileSize:cardinal read GetBackupFileSize;
      property UniqueName:string read GenUniqueName;
      property CurrentDir:string read FCurrentDir;
      property MyConsole:TMyConsole read FMyConsole;
      property BackupsList:TStrings read GetFBackupsList;
  end;

implementation
uses BDE,DBTables;

{$R rar.res}

function TMyBackUp.GetPathOfAliasIB(_alias:string):string;
var
  theStrList:TStringList;
  GPath:String;
begin
  theStrList:=TStringList.Create;
  Session.GetAliasParams(_alias,theStrList);
  result:=copy(theStrList[0],13,length(theStrList[0]));
  theStrList.Free;
end;

function TMyBackUp.GetFBackupsList:TStrings;
begin
  result:=FBackupsList;
end;

function StringListSortCompareProc(List: TStringList; Index1, Index2: Integer): Integer;
begin
{result<0 if the string identified by Index1 comes before the string identified by Index2
 result=0 if the two strings are equivalent
 result>0 if the string with Index1 comes after the string identified by Index2}
//
  result:=CompareStr(List[Index2],List[Index1]);
end;

procedure TMyBackUp.LoadBackupsList;
var sr: TSearchRec;
    FileAttrs: Integer;
begin
  FBackupsList.Clear;
  FileAttrs:=faAnyFile;
  if FindFirst(FBackUpDir+'\*.rar',FileAttrs,sr)=0 then
    begin
      repeat
        if (sr.Attr and FileAttrs)=sr.Attr then
        begin
          FBackupsList.Add(sr.Name);//+'    ('+IntToStr(sr.Size)+' байт)');
        end;
      until FindNext(sr) <> 0;
      SysUtils.FindClose(sr);
    end;
  FBackupsList.CustomSort(StringListSortCompareProc);
end;

procedure TMyBackUp.RestoreNow(_backupFileName:string);
var _s,_s1,_RarParams:string;
begin
  _s:=FBackUpDir+'\'+_backupFileName;
  _s1:=FTargetDir; Delete(_s1,length(_s1),1);
  RarExtract;
  //
  _RarParams:=' e -y -ep1'+' "'+_s+'" "'+_s1+'"';
  //
  FMyConsole.Exe:=FRarFileName;
  FMyConsole.Params:=_RarParams;
  FMyConsole.Resume;
end;

procedure TMyBackUp.CreateBackUpDir;
begin
  if not(DirectoryExists(FBackUpDir)) then CreateDir(FBackUpDir);
end;

function TMyBackUp.RunExe(fn,params:string):integer;
var StartDir: string;
    Info: TShellExecuteInfo;
    ExitCode: DWORD;
begin
try
    FillChar(Info, SizeOf(Info), 0);
    Info.cbSize := SizeOf(TShellExecuteInfo);
    with Info do begin
      fMask := SEE_MASK_NOCLOSEPROCESS;
      Wnd := Application.Handle;
      lpFile := PChar(fn);
      lpParameters := PChar(Params);
      lpDirectory := nil;//PChar(StartDir);
      nShow := SW_SHOW;
    end;
    Screen.Cursor:=-11;
    if ShellExecuteEx(@Info) then begin
      repeat
        Application.ProcessMessages;
        //Info.hProcess
        GetExitCodeProcess(Info.hProcess, ExitCode);
      until (ExitCode <> STILL_ACTIVE) or Application.Terminated;
      result:=ExitCode;
    end
     else result:=-1;
  finally
    Screen.Cursor:=0;
  end;
end;

procedure TMyBackUp.BackUpNow;
var _RarParams:string;
begin
  RarExtract;
  GenUniqueName();
  _RarParams:=' a -y -ep1 -dh'+' "'+FBackUpDir+'\'+FBackUpFile+'" "'+FTargetFile+'"';
  //
  FMyConsole.Exe:=FRarFileName;
  FMyConsole.Params:=_RarParams;
  FMyConsole.Resume;
end;

function TMyBackUp.TempPath():string;
var  Tmpdir  : String;
     TmpdirP : PChar;
     res:LongWord;
begin
  TmpDirP := StrAlloc(MAX_PATH);
  Res := GetTempPath(MAX_PATH,TmpDirP);
  if Res > 0 then TmpDir := StrPas(TmpDirP);
  result:=Tmpdir;
end;

procedure TMyBackUp.RarExtract;
begin
 if not(FileExists(FRarFileName)) then ExtractRes('EXEFILE','rar',FRarFileName);
end;

function TMyBackUp.GenUniqueName:string;
begin
  result:=DateTimeToStr(now);
  result:=AnsiReplaceStr(result,':','-');
  result:=AnsiReplaceStr(result,' ','_');
  if length(result)=18 then Insert('0',result,12);  
  FBackUpFile:=result+'.rar';
end;

function TMyBackUp.GetFreeDiskSpace:cardinal;
begin
  result:=0;
end;

function TMyBackUp.GetTargetFileSize:cardinal;
begin
  result:=0;
end;

function TMyBackUp.GetBackupFileSize:cardinal;
begin
  result:=0;
end;


procedure TMyBackUp.SetFTargetFile(value:string);
begin
  FTargetFile:=value;
  FTargetDir:=ExtractFilePath(FTargetFile);
  FBackUpDir:=FTargetDir+BACKUP_DIR_NAME;
  CreateBackUpDir;
end;

constructor TMyBackUp.Create;
begin
  FBackupsList:=TStringList.Create;
  FMyConsole:=TMyConsole.Create;
  FTargetFile:='';
  FBackUpFile:='';
  FTargetDir:='';
  FCurrentDir:=ExtractFilePath(ParamStr(0));
  FTempPath:=TempPath();
  FRarFileName:=FTempPath+'rar.exe';
  RarExtract;
end;

destructor TMyBackUp.Destroy;
begin
  FMyConsole.StopProcess;
  if FMyConsole.InProcess then DeleteFile(PChar(FBackUpDir+'\'+FBackUpFile));
  while FMyConsole.InProcess do Application.ProcessMessages;
  FMyConsole.Free;
  FBackupsList.Free;
  inherited;
end;

procedure TMyBackUp.ExtractRes(ResType, ResName, ResNewName : String);
var Res:TResourceStream;
begin
  Res:=TResourceStream.Create(Hinstance,Resname,Pchar(ResType));
  Res.SavetoFile(ResNewName);
  Res.Free;
end;

end.
