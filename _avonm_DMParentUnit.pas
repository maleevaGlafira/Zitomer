unit _avonm_DMParentUnit;

interface

uses
  SysUtils, Classes,DB,Forms,Controls,AvarOnMapConst,SendMessToAvarOnMap,Windows,Messages,
    _avonm_DopFuncsUnit;

type

  TWorkFields=record
    nomer, year:integer;
    dt_in,dt_out:TDateTime;
    rayon,address,xar_povr,mesto_povr:string;
    diam:integer;
    attach:TAttach;
  end;

  TNotifyFindWorkFieldsEvent=procedure (Sender:TObject; _Attach:TAttach; _nomer,_year:integer) of object;

  TDM_AvarParent = class
  private
    { Private declarations }
  protected
    FWorkFields:TWorkFields;
    FOnReceivedScreenShot,FOnAskWorkFields:TNotifyEvent;
    FOnFindWorkFields:TNotifyFindWorkFieldsEvent;
    FSCREENSHOT_PATH_1,FSCREENSHOT_PATH_2:string;
    FScreenShotCounter:integer;
    FNeedOfCountScreenShot:integer;
    procedure AskInfo(Sender: TObject); virtual;
    procedure OnScreenShot(Sender:TObject; _ssr:TScreenShotResult;_favr:TFindAvarResult);
    procedure AskInfoAboutCurrentAvar;
  public
    destructor Destroy; override;
    //
    function PrintReport(_scale:integer=1000):boolean;
    procedure SendCurrAvarToMap(CreateAvar:integer; OnlyScale:integer; HideMainForm:integer;_scale:integer);
    procedure ReConnectEventsToManager; virtual; abstract;
    //
    property Nomer:integer read FWorkFields.Nomer write FWorkFields.Nomer;
    property Year:integer read FWorkFields.Year write FWorkFields.Year;
    property Dt_in:TDateTime read FWorkFields.dt_in write FWorkFields.dt_in;
    property Dt_out:TDateTime read FWorkFields.dt_out write FWorkFields.dt_out;
    property Rayon:string read FWorkFields.rayon write FWorkFields.rayon;
    property Address:string read FWorkFields.address write FWorkFields.address;
    property Xar_povr:string read FWorkFields.xar_povr write FWorkFields.xar_povr;
    property Mesto_povr:string read FWorkFields.mesto_povr write FWorkFields.mesto_povr;
    property Diam:integer read FWorkFields.diam write FWorkFields.diam;
    property Attach:TAttach read FWorkFields.attach write FWorkFields.attach;
    property SCREENSHOT_PATH_1:string read FSCREENSHOT_PATH_1 write FSCREENSHOT_PATH_1;
    property SCREENSHOT_PATH_2:string read FSCREENSHOT_PATH_2 write FSCREENSHOT_PATH_2;
    {сколько уже скриншотов снято}
    property ScreenShotCounter:integer read FScreenShotCounter write FScreenShotCounter;
    {сколько всего надо сделать скриншотов (1 или 2)}
    property NeedOfCountScreenShot:integer read FNeedOfCountScreenShot write FNeedOfCountScreenShot;
    //
    property OnReceivedScreenShot:TNotifyEvent read FOnReceivedScreenShot write FOnReceivedScreenShot;
    property OnAskWorkFields:TNotifyEvent read FOnAskWorkFields write FOnAskWorkFields;
    property OnFindWorkFields:TNotifyFindWorkFieldsEvent read FOnFindWorkFields write FOnFindWorkFields;
  end;

var
  DM_AvarParent: TDM_AvarParent;

implementation

destructor TDM_AvarParent.Destroy;
begin
    FOnReceivedScreenShot:=nil;
    FOnAskWorkFields:=nil;
    FOnFindWorkFields:=nil;
end;

procedure TDM_AvarParent.SendCurrAvarToMap(CreateAvar:integer; OnlyScale:integer; HideMainForm:integer;_scale:integer);
var _d:integer;
    _t1,_t2:TDateTime;
begin
  if MAP_IS_WORK then
  begin
    if Assigned(FOnAskWorkFields) then FOnAskWorkFields(self);
    ManageAvarOnMap.SendAvarInfo(1,
      //номер наряда
      FWorkFields.nomer,
      //дата и время наряда
      FWorkFields.dt_in,
      //район
      FWorkFields.rayon,
      //адрес
      FWorkFields.address,
      //характер повреждения
      FWorkFields.xar_povr,
      //место повреждения
      FWorkFields.mesto_povr,
      //диаметр
      FWorkFields.diam,
      //дата окончания
      FWorkFields.dt_out,
      _scale,CreateAvar,OnlyScale,FWorkFields.Attach,HideMainForm);
  end
  else
    Application.MessageBox('Карта не запущена!','Диспетчер АВР',MB_ICONWARNING or MB_OK);
end;

function TDM_AvarParent.PrintReport(_scale:integer=1000):boolean;
var _w,_h:integer;
  _fn:string;
  _easy_mode:boolean;
  _only_scale:integer;
begin
  result:=TRUE;
  if Assigned(FOnAskWorkFields) then FOnAskWorkFields(self);  
  SCREENSHOT_PATH_1:=ExtractFileDir(ParamStr(0))+'\Temp\pics\'+
    IntToStr(FWorkFields.nomer)+'_'+
    FormatDateTime('yyyy',FWorkFields.dt_in)+'.bmp';
  SCREENSHOT_PATH_2:=ExtractFileDir(ParamStr(0))+'\Temp\pics\'+
    IntToStr(FWorkFields.nomer)+'_'+
    FormatDateTime('yyyy',FWorkFields.dt_in)+'_more.bmp';
  //
  if ScreenShotCounter=0 then
    begin
      _easy_mode:=FALSE;
      _only_scale:=0;
      SCREENSHOT_PATH:=SCREENSHOT_PATH_1
    end
  else
    begin
      _easy_mode:=TRUE;
      _only_scale:=1;
      SCREENSHOT_PATH:=SCREENSHOT_PATH_2;
    end;
  //
  _w:=SCREENSHOT_WIDTH;
  _h:=SCREENSHOT_HEIGHT;
  _fn:=SCREENSHOT_PATH;
    if MAP_IS_WORK then
    begin
      Screen.Cursor:=crHourGlass;
      Application.ProcessMessages;
        ManageAvarOnMap.TakeScreenShot(_easy_mode,_w,_h,_fn);
        SendCurrAvarToMap(0,_only_scale,1,_scale);
    end
      else
    begin
      SaveEmptyPic(_w,_h,_fn);
      result:=FALSE;
    end;
end;

procedure TDM_AvarParent.AskInfo(Sender: TObject);
var NumOrder, YearOrder:integer;
  AttachOrder:TAttach;
  function _AskInfoAboutCurrentAvar:boolean;
  begin
      result:=FALSE;
      if (EncodeId(FWorkFields.Attach,FWorkFields.nomer,FWorkFields.dt_in)=ManageAvarOnMap.AskInfoByID.avar_id) or (Sender=nil) then
      begin
        result:=TRUE;
        AskInfoAboutCurrentAvar;
      end;
  end;
begin
  if Assigned(FOnAskWorkFields) then FOnAskWorkFields(self);
  case ManageAvarOnMap.AskInfoType of
    aitAskAvarInfoByID:
    begin
      if not _AskInfoAboutCurrentAvar() then
        begin
          NumOrder:=DecodeOrdNum(ManaGeAvarOnMap.AskInfoByID.avar_id);
          YearOrder:=DecodeOrdYear(ManaGeAvarOnMap.AskInfoByID.avar_id);
          AttachOrder:=DecodeOrdAttach(ManaGeAvarOnMap.AskInfoByID.avar_id);
          if Assigned(FOnFindWorkFields) then FOnFindWorkFields(self,AttachOrder,NumOrder,YearOrder);
        end;
    end;
  end;
end;

procedure TDM_AvarParent.AskInfoAboutCurrentAvar;
  begin
    ManageAvarOnMap.SendAvarInfo(0,
      //номер наряда
      FWorkFields.nomer,
      //дата и время наряда
      FWorkFields.dt_in,
      //район
      FWorkFields.rayon,
      //адрес
      FWorkFields.address,
      //характер повреждения
      FWorkFields.xar_povr,
      //место повреждения
      FWorkFields.mesto_povr,
      //диаметр
      FWorkFields.diam,
      //дата окончания
      FWorkFields.dt_out,
      0,1{CreateAvar},0{OnlyScale},FWorkFields.Attach,0{HidaMainForm});
  end;

procedure TDM_AvarParent.OnScreenShot(Sender:TObject; _ssr:TScreenShotResult;_favr:TFindAvarResult);
var s,s1:string;
begin
  s:=''; s1:='';
  case _favr of
    farNull: s:='Ни авария, ни адрес не найдены.';
    farFindAvar: s:='Такая авария найдена.';
    farFindAddr: s:='Такой адрес найден.';
  end;
  case _ssr of
    ssrNull: s1:='Скриншот не сделан.';
    ssrOk: s1:='Скриншот сделан.';
  end;
  {-------  Если скриншот успешно снялся -------}
  //MessageBox(handle,PChar(s+s1),'Диспетчер АВР',MB_OK);
  inc(FScreenShotCounter);
  if (NeedOfCountScreenShot>ScreenShotCounter) then PrintReport(2000) else Screen.Cursor:=crDefault;
  if (NeedOfCountScreenShot<=ScreenShotCounter) and (_ssr<>ssrNull) and Assigned(FOnReceivedScreenShot) then FOnReceivedScreenShot(self);
end;

end.
