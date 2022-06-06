unit DelFilesAfterExitUnit;

interface
uses Classes,Windows,SysUtils;

type
 TDelFilesAfterExit=class
  private
    FItems:TStringList;
    function GetItems:TStrings;
  protected
  public
    constructor Create;
    destructor Destroy; override;
    //
    procedure DeleteFiles;
    function GetCurrDir:string;
    //
    property Items:TStrings read GetItems;
 end;

var DelFilesAfterExit:TDelFilesAfterExit;

implementation

function TDelFilesAfterExit.GetCurrDir:string;
begin
  result:=ExtractFilePath(ParamStr(0));
end;

procedure TDelFilesAfterExit.DeleteFiles;
var i:integer;
begin
  for i:=0 to FItems.Count-1 do DeleteFile(FItems[i]);
end;

function TDelFilesAfterExit.GetItems:TStrings;
begin
  result:=FItems;
end;

constructor TDelFilesAfterExit.Create;
begin
  FItems:=TStringList.Create;
end;

destructor TDelFilesAfterExit.Destroy;
begin
  FItems.Free;
  inherited;
end;

end.
