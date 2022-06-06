unit AvarOnMapConst;

interface
uses Messages,Controls,DateUtils,Windows,ExtCtrls;

var SCREENSHOT_PATH:string;
  SCREENSHOT_WIDTH, SCREENSHOT_HEIGHT:integer;

const
  AVARONMAP_SHOW=WM_USER+110;
  AVARONMAP_HIDE=WM_USER+111;
  AVARONMAP_CLOSE=WM_USER+112; //������ ������ ���� ������, ������ �������
  AVARONMAP_CLIENT_CONNECT=WM_USER+113; //������ �������� ������� ���� �����
  AVARONMAP_SERVER_OK_CONNECT=WM_USER+114; //������ ������������, ��� ������ ���������
  AVARONMAP_SERVER_CLOSE=WM_USER+115; //������ ������������, ��� ��� ����
  //
  AVARONMAP_SERVER_ASK_AVARINFO=WM_USER+116; //������ ����� �� ������� ���� �� ������
  AVARONMAP_SERVER_ASK_BY_DATETIME_RANGE=WM_USER+117; //������ ����� ����� ���� �� ���������� �������
  AVARONMAP_SERVER_ASK_STRINGGRID=WM_USER+118; //������ ����� ����������
  AVARONMAP_CANCEL_sdtSendMassivID=WM_USER+119; //�������� ������, ���������� sdtSendMassivID
  AVARONMAP_SERVER_FIND_AVAR_OK=WM_USER+120; //������ ������������, ��� ������� ������� �� ��������� ������
  AVARONMAP_SERVER_TAKED_SCREENSHOT=WM_USER+121; //������ ������������, ��� ����� ��������, � ��������� ��������, ��������� ������
  ///////////////////////////////////////



type
  {$ALIGN OFF}

  TAttach=(tatNull,tatVoda,tatKanal); // �������������� ������ - ���� ��� �����������

  pTCopyDataStruct=^TCopyDataStruct;
  
  TFindAvarResult=(farNull,farFindAvar,farFindAddr);
  TScreenShotResult=(ssrNull,ssrOK);

  TTypeOfAvar=(toaNull,toaAll,toaBezAddr,toaPredv,toaRazm);
  //TTypeOfAvar=(toaNull,toaAll,toaPredvar,toaNerazm,toaRazm);
  
  TAskInfoType=(aitNull,aitAskAvarInfoByID,aitAskAvarInfoByDateTime,aitSendMassivIDAvarAndType);

  TSendMassivIDAvarAndType=record
    id_avar:integer;
    type_of_avar:integer;
  end;

  TAskInfoByID=record
    aitID:TAskInfoType;
    avar_id:integer;
  end;

  TAskInfoByDateTime=record
    aitID:TAskInfoType;
    begin_time,end_time:TDateTime;
  end;
  {sdtNoMoreSendMassivID - ��� ��������� �������� ������, ������� �������}
  TSendDataType=(sdtNull,sdtSendAvar,sdtShowAvars,sdtRazmetkaMassivaID,sdtStringGrid,
                 sdtSendMassivID,sdtSendMassivIDWithoutRazmetka,
                 sdtMapScreenShot); //���� ���� ������������ ������
                 
  TMapScreenShot=record
    sdtID: TSendDataType;
    easy_mode:integer; 
    filename:array [0..255] of char; //���� � ��� �����
    width,height:integer; //������ � ��������
    force:integer; {1 - ����� ��������  � ����� ������, �������� �� ��, ��� ������ ����� ���� �� ������� ����� ����}
  end;

  TSendAvar=record
    sdtID: TSendDataType;
    go:integer; //1 - ��� ��������� ����������, ������ ����� ������ � ����� ������
    create:integer; //1 - ���� ����, ��� ���� ���������� ������� ������, ���� �� �������� � ������
    addr:array [0..127] of char; //�����
    addr_length:longint; //����� ������
    rayon:array [0..127] of char; //�����
    rayon_length:longint; //����� ������
    xar_povrezhd:array [0..127] of char; //�������� �����������
    xar_povrezhd_length:longint; //����� ��������� �����������
    mesto_povrezhd:array [0..127] of char; //����� �����������
    mesto_povrezhd_length:longint; //����� ����� �����������
    diam:longint; //������� �����������
    time, //���� �����������
    time_end:double; //���� ���������
    id_avar:longint;
    scale:integer; //�������, � ������� ��������
    HideMainForm:integer; // 1 - �������� ������� �����
    OnlyScale:integer;//��� ������������ ���������!
    Attach:TAttach;
  end;

  TSendMassivID=record
    ID_AVAR:integer;
    ADDR:array [0..63] of char; //� ������� �������� ����� �����
  end;
  pTSendMassivID=^TSendMassivID;

 {TShowAvars = ��������� � ����. � ������� �������� ���������� ���� ���� ������������ ������.
  � ������ �������� ���������� ���������� ��������� � �������,
  ��� ����� �������� ��������}
  TShowAvars=pointer;
  TReceiveAvars=TShowAvars;
  TReceiveIntegerMassiv=TReceiveAvars;
  {$ALIGN ON}

  TManipulateId=class
    private
      fOrdNum:integer;
      fId:integer;
      fDateOrd:TDate;
      fYear:byte;
      fAttach:TAttach;
      Function MEncodeID:integer;
      Function MDecodeOrdNum:integer;
      Function MDecodeOrdAttach:TAttach;
      procedure SetOrdNum(value:integer);
      procedure SetId(value:integer);
      procedure SetDateOrd(value:TDate);
    public
      constructor Create;
      destructor Destroy; override;
      //
      property OrdNum:integer read fOrdNum write SetOrdNum;
      property ID:integer read fId write SetId;
      property DateOrd:TDate read fDateOrd write SetDateOrd;
      property Attach:TAttach read fAttach write fAttach;
    end;

    TMySendMessage=class
    private
      FSendMessageTimer:TTimer;
      FhWnd: HWND; FMsg: UINT; FwParam: WPARAM; FlParam: LPARAM;
      FSM:boolean;
      procedure SendMessageTimerOnTimer(Sender:TObject);
    protected
    public
      FCDS:TCopyDataStruct;
      constructor Create;
      destructor Destroy; override;
      procedure FSendMessage(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM);
      procedure FPostMessage(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM);
    end;

//
function DecodeOrdNum(id:integer):integer;
function DecodeOrdYear(id:integer):integer;
function DecodeOrdAttach(id:integer):TAttach;
function EncodeId(_Attach:TAttach; _OrdNum:integer; _DateOrd:TDateTime):integer;overload;
function EncodeId(_Attach:TAttach; _OrdNum:integer; _year:byte):integer;overload;
//
function ReceiveIntegerMassiv(_source:TReceiveIntegerMassiv):TReceiveIntegerMassiv;
//
procedure SetVIntMas(_p:pointer; _ind:integer; value:integer);
function GetVIntMas(_p:pointer; _ind:integer):integer;
//
//
var MySendMessage:TMySendMessage;

implementation

{TMySendMessage}
procedure TMySendMessage.SendMessageTimerOnTimer(Sender:TObject);
begin
  FSendMessageTimer.Enabled:=FALSE;
  try
    if FSM then
      SendMessage(FhWnd,FMsg,FwParam,FlParam)
      else PostMessage(FhWnd,FMsg,FwParam,FlParam);
  finally
    FSendMessageTimer.Enabled:=FALSE;
  end;
end;

destructor TMySendMessage.Destroy;
begin
  FSendMessageTimer.Enabled:=FALSE;
  FSendMessageTimer.Free;
  inherited;
end;

constructor TMySendMessage.Create;
begin
  FSendMessageTimer:=TTimer.Create(nil);
  FSendMessageTimer.Enabled:=FALSE;
  FSendMessageTimer.Interval:=1;
  FSendMessageTimer.OnTimer:=SendMessageTimerOnTimer;
end;

procedure TMySendMessage.FSendMessage(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM);
begin
  if FSendMessageTimer<>nil then
    begin
      FhWnd:=hWnd; FMsg:=Msg; FwParam:=wParam; FlParam:=lParam;
      FSM:=TRUE;
      //FSendMessageTimer.Enabled:=TRUE;
          if FSM then
      SendMessage(FhWnd,FMsg,FwParam,FlParam)
      else PostMessage(FhWnd,FMsg,FwParam,FlParam);
    end;
end;

procedure TMySendMessage.FPostMessage(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM);
begin
  if FSendMessageTimer<>nil then
    begin
      FhWnd:=hWnd; FMsg:=Msg; FwParam:=wParam; FlParam:=lParam;
      FSM:=FALSE;
      //FSendMessageTimer.Enabled:=TRUE;
          if FSM then
      SendMessage(FhWnd,FMsg,FwParam,FlParam)
      else PostMessage(FhWnd,FMsg,FwParam,FlParam);
    end;
end;

{/TMySendMessage}

procedure SetVIntMas(_p:pointer; _ind:integer; value:integer);
begin
  integer(pointer(integer(_p)+_ind*sizeof(integer))^):=value;
end;

function GetVIntMas(_p:pointer;_ind:integer):integer;
begin
  if _p<>nil then 
    result:=integer(pointer(integer(_p)+_ind*sizeof(integer))^)
  else result:=-1;  
end;

function ReceiveIntegerMassiv(_source:TReceiveIntegerMassiv):TReceiveIntegerMassiv;
var el_size,l:integer;
    pp:pointer;
    _target:TReceiveIntegerMassiv;
begin
  _target:=nil;
  //
  el_size:=sizeOf(integer);
  pp:=pointer(integer(_source)+(1*el_size));
  l:=integer(pp^);
    if l>0 then
      begin
          //
          {0-�� ������� ��� ��� ������ (��������: sdtSendMassivID);
           1-�� ������� ��� ���������� ������������� ��������� ������ � �������;
           2-�� ���� � �� ����� - ��� � ���� ������������� ������}
          GetMem(_target,(l+2)*sizeof(integer));
          CopyMemory(_target,_source,(l+2)*el_size);
          result:=_target;
      end else result:=nil;
end;

////////////////////////////////////////////
function DecodeOrdYear(id:integer):integer;
begin
  result:=1899+(id shr 24);
end;

function DecodeOrdNum(id:integer):integer;
begin
  Result:=(Id and $00FFFFFF) shr 1;
end;

function DecodeOrdAttach(id:integer):TAttach;
begin
  if (Id and 1)=1 then result:=tatKanal else result:=tatVoda;
end;

function EncodeId(_Attach:TAttach; _OrdNum:integer; _DateOrd:TDateTime):integer;
var _year:byte;
begin
  result:=0;
  {integer - 4 ����� (24 ����)}
  {������� ���� -  ���-1899. �.�. ������������ ��� ���������� �2154}
  _year:=Byte(YearOf(_DateOrd)-1899);
  result:=EncodeId(_Attach,_OrdNum,_year);
end;

function EncodeId(_Attach:TAttach; _OrdNum:integer; _year:byte):integer;
var _bit_attach:byte;
begin
  {������� �� 24 ���� ����� - ������� ������� ���� - �����}
  Result:=(_year shl 24);
  {�������� 3 �����. ������� ��}
  Result:=Result and $FF000000;
  {23 ���� ������� �� ����� ������ � ���� ����, ��� ���������� 8388608=2^23 ��������}
  _OrdNum:=(_OrdNum shl 1) and $00FFFFFF;
  Result:=Result or _OrdNum;
  {�������� ������� ��� ��������������� ������. 0 - ����, 1 - �����������}
  _bit_attach:=0;
  if _Attach=tatKanal then _bit_attach:=1;
  Result:=Result or _bit_attach;
end;
///////////////////////////////////////////////////////

//  TManipulateId

Function TManipulateId.MEncodeID:integer;
begin
  Result:=EncodeId(fAttach,fOrdNum,fyear);
end;

Function TManipulateId.MDecodeOrdAttach:TAttach;
begin
  DecodeOrdAttach(fid);
end;

Function TManipulateId.MDecodeOrdNum:integer;
begin
  DecodeOrdNum(fid);
end;

procedure TManipulateId.SetOrdNum(value:integer);
begin
  fOrdNum:=value;
  fId:=MEncodeID;
end;

procedure TManipulateId.SetId(value:integer);
begin
  fId:=value;
  fOrdNum:=MDecodeOrdNum;
  fAttach:=MDecodeOrdAttach;
end;

procedure TManipulateId.SetDateOrd(value:TDate);
begin
  fDateOrd:=Value;
  fyear:=Byte(YearOf(fDateOrd)-1899);
end;

constructor TManipulateId.Create;
begin
  fOrdNum:=0;
  fId:=0;
  fDateOrd:=0;
  fYear:=0;
end;

destructor TManipulateId.Destroy;
begin
  inherited;
  //
end;

initialization

  SCREENSHOT_WIDTH:=700;
  SCREENSHOT_HEIGHT:=425;
  
end.
