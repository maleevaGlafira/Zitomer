unit SendMessToAvarOnMap;
interface
uses ShellApi,Windows,Messages,SysUtils,Forms,AvarOnMapConst,
Controls,ExtCtrls,Classes,TlHelp32,Grids,StrUtils,DB,RxQuery;

type
  TidsForSend=class
    private
      FDataLength:integer;
      FListOfIDToSend:string;//список айди для посылки. Первое число - год (4 цифры).
                             // Потом через точку запятой начинается список айди через
                             // запятую
      //
      procedure SetFDataLength(value:integer);
      function GetFData(const ind: integer): integer;
      procedure SetFData(const ind,value: integer);
      //
      procedure SetFListOfIDToSend(value:string);
    protected
      FidsData:pointer;//TShowAvars; {В нулевом элементе записано айди типа передаваемых данных.
                         //В первом элементе записано количество элементов}
    public
      constructor Create;
      destructor Destroy; override;
      property DirectSetData:pointer read FidsData write FidsData;
      property DataLength:integer read FDataLength write SetFDataLength;
      property Data[const ind: integer]: integer read GetFData write SetFData; //нумерация с нуля
      //
      property ListOfIDToSend:string read FListOfIDToSend write SetFListOfIDToSend;
  end;

  TProcReceiveMassivIDAvarAndType=procedure of object;
  TScreenShotEvent = procedure(Sender: TObject; _ssr:TScreenShotResult;_favr:TFindAvarResult) of object;
  TSnapShotIDAvarAndAddrFromDataSetEvent = procedure(Sender: TObject; _first:boolean; var _EOF:boolean; var _Attach:TAttach; var _num:integer;
          var _addr:string; var _year:integer) of object;

  TManageAvarOnMap=class
    private
      FData:TSendAvar;
      FAntenForm:TForm;
      pFData:^TSendAvar;
      FSendDataType:TSendDataType;
      FidsForSend:TidsForSend; //список айди для посылки
      FReceiveMasIDAvarAndType:TidsForSend;
      FAvarOnMapHandle:longint;
      FpParentForm:^TWinControl;
      FOldWndMethod:TWndMethod; // Оконная процедура формы FParentForm
      FIsServerConnectOK:boolean;
      WaitServerTimer:TTimer; //таймер, который проверят, когда запустится сервер
      WaitServerCloseTimer:TTimer; //таймер, который проверят, когда сервера не станет
      FOnConnectServer,FOnDisconnectServer,FOnServerAsk:TNotifyEvent;
      FPathToAvarOnMap:string;
      FLastFindAvarResult:TFindAvarResult;
      //
      FAskInfoType:TAskInfoType;
      FAskInfoByID:TAskInfoByID;
      FAskInfoByDateTime:TAskInfoByDateTime;
      FProcReceiveMassivIDAvarAndType:TProcReceiveMassivIDAvarAndType;
      FMapScreenShot:TMapScreenShot;
      FSnapShotIDAvarAndAddrFromDataSetEvent:TSnapShotIDAvarAndAddrFromDataSetEvent;
      //
      {флаг того, что при случае, надо сделать скриншот карты}
      FTakeSnapShotIfFindOnMapOK:boolean;
      //
      FOnScreenShot:TScreenShotEvent;
      FScreenshot_Width,FScreenshot_Height:integer;
      FScreenshot_EasyMode:boolean;
      FScreenshot_FileName:string;
      FScreenShotResult:TScreenShotResult;
      FRECEIVE_TYPES:boolean;
      //
      function FindAvarOnMapWindow:longint;
        {подменяем оконную процедуру родительской формы}
        procedure MyWndMethod (var Message: TMessage);
      procedure SetFpParentForm(value:pointer);
      procedure WaitServerTimerTimer(Sender: TObject);
      procedure WaitServerCloseTimerTimer(Sender: TObject);
      //
      procedure SetFData_addr(value:string);
      function GetFData_addr:string;
      procedure SetFData_Rayon(value:string);
      function GetFData_Rayon:string;
      procedure SetFData_XarPovrezhd(value:string);
      function GetFData_XarPovrezhd:string;
      procedure SetFData_MestoPovrezhd(value:string);
      function GetFData_MestoPovrezhd:string;     
      //
        function ProcessExists(const FileName: string): THandle;
        procedure KillProcess(hProcess:cardinal);
        function GetFIsServerYetRun:boolean;
        procedure ParseWMCopyData(_LParam:Longint);
      procedure SetStrValue(var _value:string; _target:PChar; var _length:integer);
      procedure FillReceiveMassivIDAvarAndType(pData:pointer; lData:integer);
    protected
      property pParentForm:pointer write SetFpParentForm;
    public
      //
      constructor Create;
      destructor Destroy; override;
      //
      procedure Run;
      procedure Stop;
      procedure Hide;
      procedure Show;
      procedure CANCEL_sdtSendMassivID;
      procedure SendData;
      procedure Connect;
      procedure KirdikProcessam;
      procedure SnapShotIDAvarAndAddrFromDataSet(var _res:string);
      procedure SendAvarInfo(_go:integer; num_avar:integer; time_avar:double;
      rayon,addr_avar,xar_povrezhd,mesto_povrezhd:string; diam:longint; time_avar_end:double;
      _scale:integer;_create_avar,only_scale:integer; _Attach:TAttach; _HideMainForm:integer);
      function ConvertAttachToMAPAttach(_operAtt:integer):TAttach;
      //
      function GetTypeByIDAvar(_id_avar:integer):TTypeOfAvar;
      procedure TakeScreenShot(_easy_mode:boolean; _width,_height:integer; _fn:string);
      {насильно снять скриншот с мапы}
      procedure SendTakeScreenShot(easy_mode:boolean; _width,_height:integer; _fn:string; _force:integer);
      //***********************************
      property OnConnectServer:TNotifyEvent read FOnConnectServer write FOnConnectServer;
      property OnDisconnectServer:TNotifyEvent read FOnDisconnectServer write FOnDisconnectServer;
      property OnServerAsk:TNotifyEvent read FOnServerAsk write FOnServerAsk;
      //
      property OnScreenShot:TScreenShotEvent read FOnScreenShot write FOnScreenShot;
      //
      property IsServerConnectOK:boolean read FIsServerConnectOK;
      property IsServerYetRun:boolean read GetFIsServerYetRun;
      property GoToIDatServer:integer read fdata.Go write fdata.Go;
      //
      //поля для передачи информации об аварии
      property AvarID:integer read FData.ID_Avar write FData.ID_Avar;
      property AvarTime:double read FData.time write FData.time;
      property AvarRayon:string read GetFData_Rayon write SetFData_Rayon;
      property AvarAddr:string read GetFData_addr write SetFData_addr;
      property AvarXarPovrezhd:string read GetFData_XarPovrezhd write SetFData_XarPovrezhd;
      property AvarMestoPovrezhd:string read GetFData_MestoPovrezhd write SetFData_MestoPovrezhd;      
      property AvarDiam:longint read FData.diam write FData.diam;
      property AvarTimeEnd:double read FData.time_end write FData.time_end;
      property GoScale:integer read FData.Scale write FData.Scale;
      property CreateAvar:integer read FData.Create write FData.Create;
      property OnlyScale:integer read FData.OnlyScale write FData.OnlyScale;
      property Attach:TAttach read FData.Attach write FData.Attach;
      property HideMainForm:integer read FData.HideMainForm write FData.HideMainForm;
      //
      //
      property PathToAvarOnMap:string read FPathToAvarOnMap write FPathToAvarOnMap;
      property SendDataType:TSendDataType read FSendDataType write FSendDataType;
      property idsForSend:TidsForSend read FidsForSend write FidsForSend;
      //
      property AskInfoType:TAskInfoType read FAskInfoType write FAskInfoType;
      property AskInfoByID:TAskInfoByID read FAskInfoByID write FAskInfoByID;
      property AskInfoByDateTime:TAskInfoByDateTime read FAskInfoByDateTime write FAskInfoByDateTime;
      //
      property ProcReceiveMassivIDAvarAndType:TProcReceiveMassivIDAvarAndType write FProcReceiveMassivIDAvarAndType;
      property ReceiveMasIDAvarAndType:TidsForSend read FReceiveMasIDAvarAndType write FReceiveMasIDAvarAndType;
      property TakeSnapShotIfFindOnMapOK:boolean read FTakeSnapShotIfFindOnMapOK write FTakeSnapShotIfFindOnMapOK;
      property Screenshot_EasyMode:boolean read FScreenshot_EasyMode write FScreenshot_EasyMode;
      property Screenshot_Width:integer read FScreenshot_Width write FScreenshot_Width;
      property Screenshot_Height:integer read FScreenshot_Height write FScreenshot_Height;
      property Screenshot_FileName:string read FScreenshot_FileName write FScreenshot_FileName;
      property RECEIVE_TYPES:boolean read FRECEIVE_TYPES write FRECEIVE_TYPES;
      property OnSnapShotIDAvarAndAddrFromDataSetEvent:TSnapShotIDAvarAndAddrFromDataSetEvent read FSnapShotIDAvarAndAddrFromDataSetEvent write FSnapShotIDAvarAndAddrFromDataSetEvent;
    end;

var MAP_IS_WORK:boolean;
    ManageAvarOnMap:TManageAvarOnMap;

implementation

uses DateUtils;

{TidsForSend}

procedure TidsForSend.SetFListOfIDToSend(value:string);
  //
  function GetFullIDFromStr(s:PChar):integer;
  var _Attach:TAttach;
    _OrdNum:integer;
    _DateOrd:TDate;
  begin
    if StrToInt(s[0])=1 then _Attach:=tatKanal else _Attach:=tatVoda;
    _OrdNum:=StrToInt(Copy(s,8,(POS('>',s)-1)-7));
    _DateOrd:=StrToDate('01.01.'+Copy(s,3,4));    
    result:=EncodeID(_Attach,_OrdNum,_DateOrd);
  end;
  //
  function GetAddrFromStr(s:PChar):string;
  var i,l:integer;
  begin
    i:=POS('>',s);
    i:=i+1;
    l:=length(s);
    result:=Copy(s,i,l-i+1);
  end;
  //
  function CountDataItems(var value:string):integer;
  var i,k,l1:integer;
  begin
    k:=0;
    l1:=Length(FListOfIDToSend);
    for i:=1 to l1 do if (FListOfIDToSend[i]='@') then inc(k);
    //if k<>0 then inc(k);
    result:=k;
  end;
var i,l1,k,j:integer;
    pch:array [1..255] of char;
    _SendMassivID:TSendMassivID;
    _pSendMassivID:pointer;
    _szof:integer;
    s:string;
begin
  {Пример:
  value='1:2004:1028>ул. Мироносицкая, 1@2004:5103>ул. Кузнечная,4@0:2004:7116:0>ул. Кузнечная, 5@'}
  value:=trim(value);
  if (value<>'') then
    begin
      _szof:=sizeof(TSendMassivID); //длина в байтах
      FListOfIDToSend:=value;
      // псевдомассив с данными у нас типа integer, поэтому делим на 4 и узнаем
      // количество элементов в массиве, и умножаем на количество данных типа TSendMassivID
      DataLength:=CountDataItems(value)*(_szof div 4);
      // DataLength - это какого размера нужен массив с элементов типа integer
      l1:=Length(FListOfIDToSend);
      //
      k:=1;
      j:=8; //смещение в массиве (в байтах). Нахера - не помню.
      repeat
        {ищем, где заканчивается блок с информацией об аварии}
        i:=PosEx('@',FListOfIDToSend,k);
        if i=0 then i:=l1+1;
        {копируем этот блок в во временный символьный массивчик. И уже с ним будем работать}
        StrLCopy(@pch[1],@FListOfIDToSend[k],i-k);
        {ставим нулевой завершитель - задаем длину строки. Гы-гы}
        pch[i-k+1]:=#0;
        {а сейчас получим конечный айди по набору принадлежность:год:номер (1:2004:1028) }
        _SendMassivID.ID_AVAR:=GetFullIDFromStr(@pch[1]);
        s:=GetAddrFromStr(@pch[1]);
        ZeroMemory(@_SendMassivID.ADDR,64);
         StrCopy(_SendMassivID.ADDR,PChar(s));
         _pSendMassivID:=pointer(integer(FidsData)+j);
         TSendMassivID(_pSendMassivID^):=_SendMassivID;
        j:=j+_szof;
        k:=i+1;
      until (k>l1);
    end
      else DataLength:=0;       
end;

function TidsForSend.GetFData(const ind: integer): integer;
begin
  result:=integer(pointer(integer(FidsData)+(ind+2)*sizeof(integer))^);
end;

procedure TidsForSend.SetFData(const ind,value: integer);
begin
  integer(pointer(integer(FidsData)+(ind+2)*sizeof(integer))^):=value;  
end;

procedure TidsForSend.SetFDataLength(value:integer);
begin
  FreeMem(FidsData,FDataLength*sizeof(integer));
  FidsData:=nil;
  //
  FDataLength:=value;
  GetMem(FidsData,(FDataLength+2)*sizeof(integer));
  integer(pointer(integer(FidsData)+1*sizeof(integer))^):=FDataLength;
end;

constructor TidsForSend.Create;
begin
  FidsData:=nil;
  FDataLength:=0;
end;

destructor TidsForSend.Destroy;
begin
  FreeMem(FidsData,(FDataLength+2)*sizeof(integer));
  FidsData:=nil;
//
  inherited Destroy;
end;

{TManageAvarOnMap}

function TManageAvarOnMap.ConvertAttachToMAPAttach(_operAtt:integer):TAttach;
begin
  case _operAtt of
    {toaVoda}0: result:=tatVoda;
    {toaKanal}1: result:=tatKanal;
    else
      result:=tatVoda;
  end;
end;

procedure TManageAvarOnMap.TakeScreenShot(_easy_mode:boolean; _width,_height:integer; _fn:string);
begin
  TakeSnapShotIfFindOnMapOK:=TRUE;
  Screenshot_EasyMode:=_easy_mode;
  Screenshot_Width:=_width;
  Screenshot_Height:=_height;
  Screenshot_FileName:=_fn;
end;

procedure TManageAvarOnMap.SendTakeScreenShot(easy_mode:boolean; _width,_height:integer; _fn:string; _force:integer);
begin
  _fn:=trim(_fn);
  Windows.ZeroMemory(@FMapScreenShot.filename,256);
  Windows.CopyMemory(@FMapScreenShot.filename,@_fn[1],length(_fn));
  if easy_mode then FMapScreenShot.easy_mode:=1 else FMapScreenShot.easy_mode:=0; 
  FMapScreenShot.width:=_width;
  FMapScreenShot.height:=_height;
  //
  FMapScreenShot.sdtID:=sdtMapScreenShot;
  FMapScreenShot.force:=_force;
  FSendDataType:=sdtMapScreenShot;
  SendData;  
end;

function TManageAvarOnMap.GetTypeByIDAvar(_id_avar:integer):TTypeOfAvar;
//
{_num_of_elem - нумерация рекордов от 0..N-1}
function EqLessMore(_num_of_elem,_ask_id_avar:integer):integer;
var _v, _szof:integer;
begin
  result:=0;
  _szof:=sizeof(TSendMassivIDAvarAndType);
  //
  {так как в рекорде TSendMassivIDAvarAndType поле id_avar первое,
  т.е. занимает первые 4 байта, то спроецируем как интежер первый элемент}
  _v:=FReceiveMasIDAvarAndType.Data[_num_of_elem*(_szof div 4)];
  if _ask_id_avar<_v then result:=1
    else if _ask_id_avar>_v then result:=2;
end;
//
var _i,_l,_szof,_st,
  _j_min,_j_max,_mid,_r:integer;
  _ok:boolean;
begin
  result:=toaNull;
  if FReceiveMasIDAvarAndType.DataLength>0 then
    begin
      _szof:=sizeof(TSendMassivIDAvarAndType);
      {сколько рекордов получили}
      _l:=FReceiveMasIDAvarAndType.DataLength div (_szof div 4);
      //
      _st:=(_szof div 4);
      ////////////////////////////////////////////////////////////
      {Надо б бинарным поиском пошукать}
      _ok:=FALSE;
      {Сначала надо взять весь отрезок, т.е. от 0-ого рекорда, до последнего N-1}
      _j_min:=0;
      _j_max:=_l-1;
      //
       _r:=FReceiveMasIDAvarAndType.Data[_j_max*(_szof div 4)];
       if (_r=_id_avar) then _mid:=_j_max
        else
          begin
            _r:=FReceiveMasIDAvarAndType.Data[_j_min*(_szof div 4)];
            if (_r=_id_avar) then _mid:=_j_min;
          end;
       //   
       if (_r<>_id_avar) then
        begin
         repeat
          {середина отрезка}
          _mid:=_j_min+((_j_max-_j_min) div 2);
          {если _r:=0, то у рекорда под номеров _mid, _id_avar=id_avar;
          если _r:=1, то у рекорда под номеров _mid, _id_avar<id_avar;
          если _r:=2, то у рекорда под номеров _mid, _id_avar>id_avar;}
          _r:=EqLessMore(_mid,_id_avar);
          case _r of
            0: _ok:=TRUE;
            1: _j_max:=_mid;
            2: _j_min:=_mid;
          end;
         until ((_ok) or (_j_max-_j_min<2));
         _r:=FReceiveMasIDAvarAndType.Data[_mid*(_szof div 4)];
        end;
        //
         if _r<>_id_avar then result:=toaNull
          else
        {так как поле type_of_avar это вторые 4 байта в рекорде, то так и читаем :)}
          result:=TTypeOfAvar(FReceiveMasIDAvarAndType.Data[_mid*(_szof div 4)+1]);
      ////////////////////////////////////////////////////////////
    end;
end;

procedure TManageAvarOnMap.FillReceiveMassivIDAvarAndType(pData:pointer; lData:integer);
var _l:integer;
begin
  _l:=integer(pointer(integer(pData)+1*sizeof(integer))^);
  FReceiveMasIDAvarAndType.DataLength:=_l;
  Windows.CopyMemory(FReceiveMasIDAvarAndType.DirectSetData,pData,lData);
  //
  if Assigned(FProcReceiveMassivIDAvarAndType) then FProcReceiveMassivIDAvarAndType;
end;

procedure TManageAvarOnMap.SendAvarInfo(_go:integer; num_avar:integer; time_avar:double;
      rayon,addr_avar,xar_povrezhd,mesto_povrezhd:string; diam:longint; time_avar_end:double;
      _scale:integer;_create_avar,only_scale:integer; _Attach:TAttach; _HideMainForm:integer);
begin
  AvarID:=EncodeId(_Attach,num_avar,time_avar);
  AvarTime:=time_avar;
  AvarRayon:=rayon;
  AvarAddr:=addr_avar;
  AvarXarPovrezhd:=xar_povrezhd;
  AvarMestoPovrezhd:=mesto_povrezhd;
  AvarDiam:=diam;
  AvarTimeEnd:=time_avar_end;
  GoScale:=_scale;
  CreateAvar:=_create_avar;
  HideMainForm:=_HideMainForm;
  OnlyScale:=only_scale;
  Attach:=_Attach;
  //
  GoToIDatServer:=_go;
  SendDataType:=sdtSendAvar;
  SendData;
end;

procedure TManageAvarOnMap.SnapShotIDAvarAndAddrFromDataSet(var _res:string);
var _addr,_s:string;
  _num,_year:integer;
  _EOF:boolean;
  _Attach:TAttach;
begin
  if Assigned(FSnapShotIDAvarAndAddrFromDataSetEvent) then
    begin
      _res:='';
      FSnapShotIDAvarAndAddrFromDataSetEvent(self,true,_EOF,_Attach,_num,_addr,_year);
      while not(_EOF) do
        begin
          _s:='0';
          if _Attach<>tatVoda then _s:='1';
          if _num>0 then _res:=_res+_s+':'+IntToStr(_year)+':'+IntToStr(_num)+'>'+_addr+'@';
          FSnapShotIDAvarAndAddrFromDataSetEvent(self,false,_EOF,_Attach,_num,_addr,_year);
        end;
      end;
end;

procedure TManageAvarOnMap.SetStrValue(var _value:string; _target:PChar; var _length:integer);
var l:integer;
begin
  l:=Length(_value);
  if l>256 then l:=256;
  Windows.CopyMemory(_target,@_value[1],l);
  _length:=l;
end;  

procedure TManageAvarOnMap.SetFData_Rayon(value:string);
begin
  SetStrValue(value,@FData.rayon,FData.rayon_length);
end;

function TManageAvarOnMap.GetFData_Rayon:string;
begin
  result:=string(fdata.rayon);
end;

procedure TManageAvarOnMap.SetFData_XarPovrezhd(value:string);
begin
  SetStrValue(value,@FData.xar_povrezhd,FData.xar_povrezhd_length);
end;

function TManageAvarOnMap.GetFData_XarPovrezhd:string;
begin
  result:=string(fdata.xar_povrezhd);
end;

procedure TManageAvarOnMap.SetFData_MestoPovrezhd(value:string);
begin
  SetStrValue(value,@FData.mesto_povrezhd,FData.mesto_povrezhd_length);
end;

function TManageAvarOnMap.GetFData_MestoPovrezhd:string;
begin
  result:=string(fdata.mesto_povrezhd);
end;

procedure TManageAvarOnMap.ParseWMCopyData(_LParam:Longint);
var cds:^TCopyDataStruct;
    _ait:TAskInfoType;
begin
  cds:=Pointer(_LParam);
  _ait:=TAskInfoType(cds.lpData^);
  FAskInfoType:=_ait;
  case _ait of
      aitAskAvarInfoByID:
        begin
          FAskInfoByID:=TAskInfoByID(cds.lpData^);
        end;
      aitAskAvarInfoByDateTime:
        begin
          FAskInfoByDateTime:=TAskInfoByDateTime(cds.lpData^);
        end;
      aitSendMassivIDAvarAndType:
        begin
          FillReceiveMassivIDAvarAndType(cds.lpData,cds.cbData);
        end;
    end;
  if @FOnServerAsk<>nil then FOnServerAsk(self);
end;

function TManageAvarOnMap.GetFIsServerYetRun:boolean;
begin
  if ProcessExists('AvarOnMap.exe')<>0 then  result:=TRUE
    else result:=FALSE;
end;

procedure TManageAvarOnMap.KirdikProcessam;
var
   h: THandle;
begin
 h:=ProcessExists('AvarOnMap.exe');
  if h<>0 then
    begin
      KillProcess(h);
    end;
  //
   h:=ProcessExists('Map.exe');
  if h<>0 then
    begin
      KillProcess(h);
    end;
  //
{  h:=ProcessExists('WaterPasp.exe');
  if h<>0 then
    begin
      KillProcess(h);
    end;}
end;

function TManageAvarOnMap.ProcessExists(const FileName: string): THandle;
var
 h: THandle;
 pe: PROCESSENTRY32;
 s:string;
begin
 Result := 0;
 h := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
 if h <> -1 then
 try
   pe.dwSize := SizeOf(pe);
   if Process32First(h, pe) then
   repeat
     s:=ExtractFileName(pe.szExeFile);
     if StrIComp(PChar(s), PChar(FileName)) = 0 then
     begin
       Result := OpenProcess(PROCESS_ALL_ACCESS, true, pe.th32ProcessID);
       Break;
     end;
   until not Process32Next(h,pe);
 finally
   CloseHandle(h);
 end;
end;

procedure TManageAvarOnMap.KillProcess(hProcess:cardinal);
var codepr:cardinal;
begin
  GetExitCodeProcess(hProcess,codepr);
  TerminateProcess(hProcess,codepr);
end;

function TManageAvarOnMap.GetFData_addr:string;
begin
  result:=string(fdata.addr);
end;

procedure TManageAvarOnMap.SetFData_addr(value:string);
var l:integer;
begin
  l:=Length(value);
  if l>256 then l:=256;
  Windows.CopyMemory(@FData.addr,@value[1],l);
  fdata.addr_length:=l;
end;

procedure TManageAvarOnMap.WaitServerTimerTimer(Sender: TObject);
begin
  FAvarOnMapHandle:=FindAvarOnMapWindow;
  if FAvarOnMapHandle<>0 then
    begin
      if Assigned(FpParentForm) then
      begin
        Connect;
      end;
      if FIsServerConnectOK or (not Assigned(FpParentForm)) then WaitServerTimer.Enabled:=FALSE;
    end;
end;

procedure TManageAvarOnMap.WaitServerCloseTimerTimer(Sender: TObject);
begin
  if (ProcessExists('AvarOnMap.exe')=0)
  //and (ProcessExists('Map.exe')=0){ and
  // (ProcessExists('WaterPasp.exe')=0)}
  then
    begin
      WaitServerCloseTimer.Enabled:=FALSE;
      Screen.Cursor:=crDefault;
      if @FOnDisconnectServer<>nil then FOnDisconnectServer(self);
    end;
end;

procedure TManageAvarOnMap.SetFpParentForm(value:pointer);
begin
  if FpParentForm<>nil then (FpParentForm^).WindowProc:=FOldWndMethod;
  FpParentForm:=value;
  FOldWndMethod:=(FpParentForm^).WindowProc;
  (FpParentForm^).WindowProc:=MyWndMethod;
end;

procedure TManageAvarOnMap.MyWndMethod (var Message: TMessage);
begin
    case Message.Msg of
      AVARONMAP_SERVER_OK_CONNECT:
        begin
          FIsServerConnectOK:=TRUE;
          Screen.Cursor:=crDefault;
          if @FOnConnectServer<>nil then FOnConnectServer(self);
        end;
      AVARONMAP_SERVER_CLOSE:
        begin
          FIsServerConnectOK:=FALSE;
          Screen.Cursor:=crHourGlass;
          WaitServerCloseTimer.Enabled:=TRUE;
        end;
      WM_COPYDATA:
        begin
          ParseWMCopyData(Message.LParam);
        end;  
      AVARONMAP_SERVER_ASK_STRINGGRID:
        begin
          //сервер хочет информацию из стринггрида
          //
        end;
      AVARONMAP_SERVER_FIND_AVAR_OK:
        begin
          FLastFindAvarResult:=TFindAvarResult(Message.LParam);
          if (FTakeSnapShotIfFindOnMapOK) then
            begin
              FTakeSnapShotIfFindOnMapOK:=FALSE;
              SendTakeScreenShot(ScreenShot_EasyMode,Screenshot_Width,Screenshot_Height,Screenshot_FileName,0);
            end;
        end;
      AVARONMAP_SERVER_TAKED_SCREENSHOT:
        begin
         FScreenShotResult:=TScreenShotResult(Message.LParam); 
         if Assigned(FOnScreenShot) then FOnScreenShot(self, FScreenShotResult,FLastFindAvarResult);
        end;
    end;
    if @FOldWndMethod<>nil then FOldWndMethod(Message);
end;

function TManageAvarOnMap.FindAvarOnMapWindow:longint;
begin
  result:=FindWindow('TForm','TAvarOnMapForAvrForm');
end;

procedure TManageAvarOnMap.CANCEL_sdtSendMassivID;
begin
  MySendMessage.FPostMessage(FAvarOnMapHandle,AVARONMAP_CANCEL_sdtSendMassivID,0,0);
end;

procedure TManageAvarOnMap.Connect;
begin
  FAvarOnMapHandle:=FindAvarOnMapWindow;
  if FAvarOnMapHandle<>0 then
    MySendMessage.FPostMessage(FAvarOnMapHandle,AVARONMAP_CLIENT_CONNECT,FpParentForm^.Handle,0);
end;

procedure TManageAvarOnMap.Show;
begin
  MySendMessage.FPostMessage(FAvarOnMapHandle,AVARONMAP_SHOW,0,0);
end;

procedure TManageAvarOnMap.Hide;
begin
  MySendMessage.FPostMessage(FAvarOnMapHandle,AVARONMAP_HIDE,0,0);
end;

procedure TManageAvarOnMap.Stop;
begin
  MySendMessage.FPostMessage(FAvarOnMapHandle,AVARONMAP_CLOSE,0,0);
end;

procedure TManageAvarOnMap.Run;
var s:string;
begin
  if ProcessExists('AvarOnMap.EXE')=0 then
    begin
      s:=FPathToAvarOnMap;
      if ShellExecute(0,'open',PChar(s),'/hide',nil,SW_HIDE)<33
            then
              begin
                MessageBox(0,'Не могу запустить AvarOnMap.exe','Аварии на карте',mb_ok or MB_ICONWARNING);
              end
            else
              begin
                if Assigned(FpParentForm) then Screen.Cursor:=crHourGlass;
                WaitServerTimer.Enabled:=TRUE;
              end;
    end else begin
               if Assigned(FpParentForm) then
                 Connect;
              end;
end;

//
constructor TManageAvarOnMap.Create;
begin
 FOnScreenShot:=nil;
 FTakeSnapShotIfFindOnMapOK:=FALSE;
 MySendMessage:=TMySendMessage.Create;
 //
 FAntenForm:=TForm.Create(nil);
 FAntenForm.Hide;
 pParentForm:=@FAntenForm;
 //
 new(pFdata);
 FPathToAvarOnMap:=ExtractFilePath(Application.ExeName)+'AvarOnMap\AvarOnMap.exe';
 //
//  KirdikProcessam;
  //          
  FIsServerConnectOK:=FALSE;
  //
  WaitServerTimer:=TTimer.Create(nil);
  WaitServerTimer.Interval:=200;
  WaitServerTimer.OnTimer:=WaitServerTimerTimer;
  WaitServerTimer.Enabled:=FALSE;
  //
  WaitServerCloseTimer:=TTimer.Create(nil);
  WaitServerCloseTimer.Interval:=100;
  WaitServerCloseTimer.OnTimer:=WaitServerCloseTimerTimer;
  WaitServerCloseTimer.Enabled:=FALSE;
  //
  FidsForSend:=TidsForSend.Create;
  FReceiveMasIDAvarAndType:=TidsForSend.Create;
  //
  FMapScreenShot.sdtID:=sdtMapScreenShot;
  FMapScreenShot.filename:='c:\1.bmp';
  FMapScreenShot.width:=700;
  FMapScreenShot.height:=425;    
end;

procedure TManageAvarOnMap.SendData;
var
  p:pointer;
begin
  case FSendDataType of
    sdtSendAvar:
      begin
        pFdata^.sdtID:=sdtSendAvar;
        pFdata^.go:=fdata.go;
          pFdata^.addr:=fdata.addr;
          pFdata^.addr_length:=fdata.addr_length;
          pFdata^.addr[fdata.addr_length]:=#0;
          //
          pFdata^.rayon:=fdata.rayon;
          pFdata^.rayon_length:=fdata.rayon_length;
          pFdata^.rayon[fdata.rayon_length]:=#0;
          //
          pFdata^.xar_povrezhd:=fdata.xar_povrezhd;
          pFdata^.xar_povrezhd_length:=fdata.xar_povrezhd_length;
          pFdata^.xar_povrezhd[fdata.xar_povrezhd_length]:=#0;
          //
          pFdata^.mesto_povrezhd:=fdata.mesto_povrezhd;
          pFdata^.mesto_povrezhd_length:=fdata.mesto_povrezhd_length;
          pFdata^.mesto_povrezhd[fdata.mesto_povrezhd_length]:=#0;
          //
          pFdata^.scale:=fdata.scale;
          pFdata^.create:=fdata.create;
          pFdata^.OnlyScale:=fdata.OnlyScale;
          pFdata^.Attach:=fdata.Attach;
          pFdata^.HideMainForm:=fdata.HideMainForm;
          //
        pFdata^.id_avar:=fdata.id_avar;
        pFdata^.time:=fdata.time;
        pFdata^.time_end:=fdata.time_end;
        pFdata^.diam:=fdata.diam;
          MySendMessage.FCDS.cbData:=Sizeof(TSendAvar);
          MySendMessage.FCDS.lpData:=pFdata;
      end;
    sdtShowAvars:
      begin
        integer(idsForSend.FidsData^):=integer(sdtShowAvars);
        MySendMessage.FCDS.cbData:=(FidsForSend.DataLength+2)*sizeof(integer);
        MySendMessage.FCDS.lpData:=FidsForSend.FidsData;
      end;
    sdtRazmetkaMassivaID,sdtSendMassivID,sdtSendMassivIDWithoutRazmetka:
      begin
        integer(idsForSend.FidsData^):=integer(FSendDataType);
        MySendMessage.FCDS.cbData:=(FidsForSend.DataLength+2)*sizeof(integer);
        MySendMessage.FCDS.lpData:=FidsForSend.FidsData;
      end;
    sdtStringGrid:
      begin
        integer(idsForSend.FidsData^):=integer(sdtStringGrid);
        MySendMessage.FCDS.cbData:=(FidsForSend.DataLength+2)*sizeof(integer);
        MySendMessage.FCDS.lpData:=FidsForSend.FidsData;
      end;
    sdtMapScreenShot:
      begin
        MySendMessage.FCDS.cbData:=sizeOf(TMapScreenShot);
        MySendMessage.FCDS.lpData:=@FMapScreenShot;
      end;      
  end;
  //
  Application.ProcessMessages;
  if FAvarOnMapHandle<>0 then
    MySendMessage.FSendMessage(FAvarOnMapHandle,WM_COPYDATA,FpParentForm^.Handle,Integer(@MySendMessage.FCDS));
end;

destructor TManageAvarOnMap.Destroy;
begin
  MySendMessage.Free;
  FreeAndNil(FidsForSend);
  FreeAndNil(FAntenForm);
  dispose(pFdata);
  //
  FOnConnectServer:=nil;
  FOnDisconnectServer:=nil;
  FOnServerAsk:=nil;
  FSnapShotIDAvarAndAddrFromDataSetEvent:=nil;
  //
  inherited Destroy;
end;

end.
