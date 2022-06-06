unit DataExchFileUnit;

interface

uses DataExchInterfacesUnit, DataExchItemUnit, SimpleXML, SysUtils;

type

  TDataExchAccessFile = class (TInterfacedObject)
  protected
    FFileName: string;
    function FileNameGenerator(): string;
  end;

  TDataExchAccess_XML = class(TDataExchAccessFile, IDataAccess)
  private
  protected
  public
    procedure Write(_data: IEnumerator; _elemName:string ='');
    procedure Read( _elemName:string; _data: IEnumerator );
    procedure SetFileName(_filename: string);
  end;

implementation

{ TDataExchAccessFile }

function TDataExchAccessFile.FileNameGenerator(): string;
begin
  result := 'dt_' + DateToStr(Date);
end;

{ TDataExchAccess_XML }

procedure TDataExchAccess_XML.SetFileName(_filename: string);
begin
  FFileName := _filename;
end;

procedure TDataExchAccess_XML.Write(_data: IEnumerator; _elemName:string ='');
var
  aDoc: IXmlDocument;
  anElem: IXmlNode;
  _dt: string;
begin
  aDoc := CreateXmlDocument('xml');
  if FileExists(FFileName) then aDoc.Load(FFileName);
  {так как нужна информаци€ за день, всегда сама€ последн€€}
  if _elemName='' then _dt := FileNameGenerator() else _dt := _elemName;  
  anElem := aDoc.DocumentElement.SelectSingleNode(_dt);
  if not Assigned(anElem)
  then anElem := aDoc.DocumentElement.AppendElement(_dt);
  try
  _data.First;
  while not _data.EOF do
  begin
    anElem.SetAttr(_data.GetNameValuePair().name, _data.GetNameValuePair().value);
    _data.Next;
  end;
  finally
    aDoc.Save(FFileName);
    anElem := nil;
    aDoc := nil;
  end;
end;

procedure TDataExchAccess_XML.Read( _elemName:string; _data: IEnumerator );
var
  aDoc: IXmlDocument;
  anElem: IXmlNode;
  _dt: string;
  _vp: TNameValuePair;
begin
  aDoc := CreateXmlDocument('xml');
  try
    if FileExists(FFileName) then
    begin
      aDoc.Load(FFileName);
      {так как нужна информаци€ за день, всегда сама€ последн€€}
      if _elemName='' then _dt := FileNameGenerator() else _dt := _elemName;
      anElem := aDoc.DocumentElement.SelectSingleNode(_dt);
      if not Assigned(anElem) then anElem := aDoc.DocumentElement.AppendElement(_dt);
      _data.First;
      while not _data.EOF do
      begin
        _vp := _data.GetNameValuePair();
        _vp.value := anElem.GetAttr( _vp.name, 'none_attr' );
        if (_vp.value<>'none_attr') then _data.SetValue( _vp.value );
        _data.Next;
      end;
    end;
  finally
    anElem := nil;
    aDoc := nil;
  end;    
end;

end.
