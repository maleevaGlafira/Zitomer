unit CookiesUnit;

interface

uses SysUtils, UniDataExchUnit, DataExchInterfacesUnit, Classes;

type

  TSetOfByte = set of byte;

  TCookieItems = class
  private
    FName: string;
    FStrList: TStringList;
    function GetValueByName( _name: string ): string;
    procedure SetValueByName( _name: string; _value: string );
  protected
  public
    constructor Create;
    destructor Destroy; override;
    //
    procedure Add( _name: string );
    function ConvertValueToSetOfByte( _value: string ): TSetOfByte;
    function ConvertSetOfByteToValue( _sob: TSetOfByte ): string;    
    //
    property Name: string read FName write FName;
    property NameAndValueList: TStringList read FStrList;
    property ValueByName[_name: string]: string read GetValueByName write SetValueByName;
  end;

  TCookies = class
  private
    FFileName: string;
    FCurrDir: string;
  protected
  public
    constructor Create;
    destructor Destroy; override;
    //
    procedure Save( _items: TCookieItems );
    procedure Load( _items: TCookieItems );
  end;

var
  GlobalCookies: TCookies;

implementation

{ TCookieItems }

function TCookieItems.ConvertSetOfByteToValue( _sob: TSetOfByte ): string;
var
  _i, _l: integer;
  _s: string;
  _b: byte;
begin
  result := '';
  try
    for _i := 0 to 255 do
    begin
      if _i in _sob then
      begin
        if result<>'' then result := result + ', ' + IntToStr(_i)
          else result := result + IntToStr(_i);
      end;
    end;
  except
    result := '';
  end;
end;

function TCookieItems.ConvertValueToSetOfByte( _value: string ): TSetOfByte;
var
  _i, _l: integer;
  _s: string;
  _b: byte;
begin
  result := [];
  try
    _value := trim(_value);
    _s := '';
    _l := length(_value);
    for _i := 1 to _l do
    begin
      if (_value[_i]=',') or (_i=_l) then
      begin
        if (_i=_l) then _s := _s + _value[_i];
        _b := StrToInt(_s);
        result := result + [_b];
        _s := '';
      end else _s := _s + _value[_i];
    end;
  except
    result := [];
  end;    
end;

procedure TCookieItems.SetValueByName( _name: string; _value: string );
begin
  if (_value='') then _value := ' '; 
    FStrList.Values[_name] := _value;
end;

function TCookieItems.GetValueByName( _name: string ): string;
begin
  result := FStrList.Values[_name];
end;

procedure TCookieItems.Add( _name: string );
begin
  FStrList.Add( _name + '=' + ' ' );
end;

constructor TCookieItems.Create;
begin
  FName := '';
  FStrList := TStringList.Create;
end;

destructor TCookieItems.Destroy;
begin
  FStrList.Free;
  inherited;
end;

{ TCookies }

procedure TCookies.Load( _items: TCookieItems );
var
  _t: TUniDataExch;
  _vp: TNameValuePair;
  _enum: IEnumerator;
  _da: IDataAccess;
  _param: string;
  _i: integer;
begin
  _param := _items.Name;
  _t := TUniDataExch.Create;
  _da := _t;
  _enum := _t.Buf;
  try
    _da.SetFileName(FFileName);
    for _i := 0 to _items.NameAndValueList.Count-1 do
    begin
      _vp.name := _items.NameAndValueList.Names[_i]; _vp.value := _items.NameAndValueList.Values[_vp.name];
      _enum.Add( _vp );
    end;
    _da.Read( _param, _enum );
    _enum.First;
    while not _enum.EOF do
    begin
      _vp := _enum.GetNameValuePair();
      _items.SetValueByName(_vp.name, _vp.value);
      _enum.Next;
    end;
    _enum := nil;
    _da := nil;
  except
    on E:Exception do
      raise Exception.Create('Ошибка при чтении из файла кукисов '#13 + FFileName +#13 +
        ' для программы "Диспетчер АВР"' + #13 + E.Message);
  end;
end;

procedure TCookies.Save( _items: TCookieItems );
var
  _t: TUniDataExch;
  _vp: TNameValuePair;
  _enum: IEnumerator;
  _da: IDataAccess;
  _i: integer;
  _param: string;
begin
  _param := _items.Name;
  _t := TUniDataExch.Create;
  _da := _t;
  _enum := _t.Buf;
  try
    _da.SetFileName(FFileName);
    _enum.Clear;
    //
    for _i := 0 to  _items.NameAndValueList.Count-1 do
    begin
      _vp.name := _items.NameAndValueList.Names[_i]; _vp.value := _items.NameAndValueList.Values[_vp.name]; _enum.Add(_vp);
    end;
    //
    _da.Write(_enum, _param);
    _da := nil;
    _enum := nil;
  except
    on E:Exception do
      raise Exception.Create('Ошибка при сохранении в файл кукисов '#13 + FFileName +#13 +
        ' для программы "Диспетчер АВР"' + #13 + E.Message);
  end;    
end;

constructor TCookies.Create;
begin
  FCurrDir := ExtractFilePath(ParamStr(0));
  FFileName := FCurrDir + 'cookies.xml';
end;

destructor TCookies.Destroy;
begin
  //
  inherited;
end;

initialization

  GlobalCookies := TCookies.Create;

finalization

    GlobalCookies.Free;

end.
