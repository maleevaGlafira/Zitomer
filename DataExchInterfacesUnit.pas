unit DataExchInterfacesUnit;

interface

type

  TNameValuePair = record
    name: string;
    value: string;
  end;

  IEnumerator = interface
    procedure First;
    procedure Last;
    procedure Next;
    procedure Prior;
    function EOF: boolean;
    function BOF: boolean;
    function Add(_value: TNameValuePair): integer;
    procedure Clear;
    function GetNameValuePair(): TNameValuePair;
    procedure SetValue( _value: string );    
  end;

  IDataAccess = interface
    procedure SetFileName(_filename: string);
    procedure Write(_data: IEnumerator; _elemName:string ='');
    procedure Read( _elemName:string; _data: IEnumerator );
  end;

implementation

end.
