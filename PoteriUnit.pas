unit PoteriUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FRMLANG, StdCtrls, Buttons, ExtCtrls, RXSpin, ComCtrls, RxLookup,
  DB, DBTables, IBCustomDataSet, IBQuery, Main, Math, TypInfo, Mask,
  ToolEdit,QShevelevUnit,ServiceFuncUnit;

const MonthsFullName: array [1..12] of string=('января','февраля','марта',
  'апреля','мая','июня','июля','августа','сентября','октября','ноября','декабря');
    
type

  TDiamSqEvent=(tdseNull,tdseDiam,tdseSquare);
  TXarPovr=(txpNull,txpSvisch,txpTreschina,txpTor);

  TPoteriForm = class(TFormLang)
    BB_Exit: TBitBtn;
    seGLZ: TRxSpinEdit;
    sePress: TRxSpinEdit;
    seSpeedLeak: TRxSpinEdit;
    XarPovrMemo: TMemo;
    Bevel1: TBevel;
    Label2: TLabel;
    SE_Protyazh: TRxSpinEdit;
    Bevel3: TBevel;
    Label8: TLabel;
    DBL_OpDiam: TRxDBLookupCombo;
    DS_diam: TDataSource;
    Qry_diam: TQuery;
    Qry_tmp: TQuery;
    SB_Print: TSpeedButton;
    Bevel15: TBevel;
    Label7: TLabel;
    E_PostuplDateTime: TEdit;
    Bevel6: TBevel;
    Label9: TLabel;
    Bevel16: TBevel;
    Label30: TLabel;
    Bevel17: TBevel;
    Label32: TLabel;
    Bevel7: TBevel;
    Label34: TLabel;
    Bevel8: TBevel;
    Label36: TLabel;
    Bevel11: TBevel;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    Bevel4: TBevel;
    Label11: TLabel;
    SE_Clor: TRxSpinEdit;
    Bevel5: TBevel;
    Label13: TLabel;
    TE_Contact: TDateTimePicker;
    Bevel12: TBevel;
    Label3: TLabel;
    Bevel9: TBevel;
    Label15: TLabel;
    TE_Promivka: TDateTimePicker;
    DE_ActDate: TDateEdit;
    E_DiamPovr: TEdit;
    Bevel10: TBevel;
    Label4: TLabel;
    DE_EndDate: TDateEdit;
    TE_EndTime: TDateTimePicker;
    Button1: TButton;
    bvXAR_POVR: TBevel;
    cmbXarPovr: TComboBox;
    Label6: TLabel;
    eSquare: TEdit;
    pDock: TPanel;
    pTor: TPanel;
    Bevel20: TBevel;
    Label16: TLabel;
    Bevel21: TBevel;
    Label17: TLabel;
    Bevel22: TBevel;
    Label18: TLabel;
    seTorVneshnDiam: TRxSpinEdit;
    seTorVnutrDiam: TRxSpinEdit;
    seTorUgol: TComboBox;
    pSvisch: TPanel;
    Bevel14: TBevel;
    Label10: TLabel;
    seDiamLeak: TRxSpinEdit;
    pTreschina: TPanel;
    Bevel18: TBevel;
    Label12: TLabel;
    Bevel19: TBevel;
    Label14: TLabel;
    seTRESCH_DLINA: TRxSpinEdit;
    seTRESCH_SHIRINA: TRxSpinEdit;
    procedure BB_ExitClick(Sender: TObject);
    procedure seGLZChange(Sender: TObject);
    procedure seSpeedLeakChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure XarPovrMemoChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SB_PrintClick(Sender: TObject);
    procedure E_FirstViezdChange(Sender: TObject);
    procedure seDiamLeakChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure cmbXarPovrChange(Sender: TObject);
    procedure DE_EndDateChange(Sender: TObject);
  private
    { Private declarations }
    FStreet:string;
    FID_Zav:integer; //айди заявки
    FseGLZ_Value,FseSpeedLeak_Value,FseSquareLeak_Value,
      FsePress_Value:double;
    FExDoClalcLeak,FExDBL_raonChange:TNotifyEvent;
    //
    FseDiamLeak_Value:integer;
    //
    FOp_Protyazh,FCl_Doza,FCl_Contact_Time,
      FCl_Promiv_Time,FCl_Pressure:double;
    FUtoch_Xar_Povr:string;
    //FOp_Id_Diam:integer;
    //FOp_Diam:string;
    //
    FMemoChanged:boolean;
    //
    FOpDiam_Povrezhd:string;
    //
    FReadOnly:boolean;
    FActDate,FPostuplDateTime:TDateTime;
    FEndDate,FEndTime:string;
    FID_OpDiam_Povrezhd:integer;
    FMatPipe:string;
    FDiamSqEvent:TDiamSqEvent;
    //
    FXAR_MESTA_POVR:TXarPovr;
    FTRESCH_DLINA, FSVISCH_DIAM, FTRESCH_SHIRINA,
      FTOR_VNESHN_DIAM, FTOR_VNUTR_DIAM, FTOR_UGOL:integer;
    //
    FIsNeedRecalcLeak: boolean;
    //
    procedure _DoCalcLeak(Sender: TObject);
    procedure UpdateValues;
    procedure VisualChangeXarPovr;
    procedure UpdateXarPovrCombo;
    procedure SetFsePress_Value(value:double);
    procedure SetFseSquareLeak_Value(value:double);
    procedure SetFseDiamLeak_Value(value:integer);
    procedure SetFseSpeedLeak_Value(value:double);
    procedure SetFseGLZ_Value(value:double);
    //
    procedure SetFUtoch_Xar_Povr(value:string);
    procedure SetFOp_Protyazh(value:double);
    procedure SetFID_OpDiam_Povrezhd(value:integer);
    //procedure SetFOp_Id_Diam(value:integer);
    procedure SetFCl_Doza(value:double);
    procedure SetFCl_Contact_Time(value:double);
    procedure SetFCl_Promiv_Time(value:double);
    procedure SetFCl_Pressure(value:double);
    function CountUtechka(_square,_pressure,_glubina:double):double;
    function Hours(fulltime:TDateTime):double;
    function CheckFill:boolean;
    procedure FillEndDateTime;
    procedure SetFPostuplDateTime(value:TDateTime);
    procedure SetFActDate(value:TDateTime);
    function GetPoteriPromyv:double;
    procedure SetFDiam_Povrezhd(value:string);
    procedure SetDiamSquare(_who_event:TDiamSqEvent);
    procedure SetFEndDate(value:string);
    procedure SetFEndTime(value:string);
    procedure SetXAR_MESTA_POVR(value: TXarPovr);
    procedure SetSVISCH_DIAM(value: integer);
    procedure SetTRESCH_DLINA(value: integer);
    procedure SetTRESCH_SHIRINA(value: integer);
    procedure SetTOR_VNESHN_DIAM(value: integer);
    procedure SetTOR_VNUTR_DIAM(value: integer);
    procedure SetTOR_UGOL(value: integer);
  public
    constructor Create(AOwner:TComponent; _ReadOnly:boolean); reintroduce;
    { Public declarations }
    property ExDoClalcLeak:TNotifyEvent read FExDoClalcLeak write FExDoClalcLeak;
    property ExDBL_raonChange:TNotifyEvent read FExDBL_raonChange write FExDBL_raonChange;
    //
    property sePress_Value:double read FsePress_Value write SetFsePress_Value; // давление
    property seDiamLeak_Value:integer read FseDiamLeak_Value write SetFseDiamLeak_Value; // диаметр свища, мм
    property seSquareLeak_Value:double read FseSquareLeak_Value write SetFseSquareLeak_Value; // площадь свища, см2
    property seSpeedLeak_Value:double read FseSpeedLeak_Value write SetFseSpeedLeak_Value; // утечка
    property seGLZ_Value:double read FseGLZ_Value write SetFseGLZ_Value; // глубина заложения
    //
    property Utoch_Xar_Povr:string read FUtoch_Xar_Povr write SetFUtoch_Xar_Povr; // уточнения характера повреждения
    property Op_Protyazh:double read FOp_Protyazh write SetFOp_Protyazh; // протяженность опорожненного участка
    //property Op_Id_Diam:integer read FOp_Id_Diam write SetFOp_Id_Diam; // айди диаметра участка
    property Cl_Doza:double read FCl_Doza write SetFCl_Doza; // доза хлора
    property Cl_Contact_Time:double read FCl_Contact_Time write SetFCl_Contact_Time; // время контакта (хлорирования)
    property Cl_Promiv_Time:double read FCl_Promiv_Time write SetFCl_Promiv_Time; // время промывки
    property Cl_Pressure:double read FCl_Pressure write SetFCl_Pressure; // давление промывки
    //
    property ID_Zav:integer read FID_Zav write FID_Zav;
    property ID_OpDiam_Povrezhd:integer read FID_OpDiam_Povrezhd write SetFID_OpDiam_Povrezhd; // айди диаметра участка опорожнения
    property OpDiam_Povrezhd:string read FOpDiam_Povrezhd write FOpDiam_Povrezhd; // диаметр участка опорожнения
    property Diam_Povrezhd:string write SetFDiam_Povrezhd; // диаметр трубы на которой повредилось
    property PostuplDateTime:TDateTime read FPostuplDateTime write SetFPostuplDateTime; // датавремя поступления заявки (берется из датывремения создания заявки)
    property Street:string read FStreet write FStreet; // адрес
    //
    property ActDate:TDateTime read FActDate write SetFActDate; //дата формирования акта
    property EndDate:string read FEndDate write SetFEndDate; //дата время окончания работ
    property EndTime:string read FEndTime write SetFEndTime; //дата время окончания работ
    property MatPipe:string write FMatPipe;

    property XAR_MESTA_POVR:TXarPovr read FXAR_MESTA_POVR write SetXAR_MESTA_POVR;
    property SVISCH_DIAM: integer read FSVISCH_DIAM write SetSVISCH_DIAM;
    property TRESCH_DLINA: integer read FTRESCH_DLINA write SetTRESCH_DLINA;
    property TRESCH_SHIRINA: integer read FTRESCH_SHIRINA write SetTRESCH_SHIRINA;
    property TOR_VNESHN_DIAM: integer read FTOR_VNESHN_DIAM write SetTOR_VNESHN_DIAM;
    property TOR_VNUTR_DIAM: integer read FTOR_VNUTR_DIAM write SetTOR_VNUTR_DIAM;
    property TOR_UGOL: integer read FTOR_UGOL write SetTOR_UGOL;
    procedure Translate;override;
  end;

var
  PoteriForm: TPoteriForm;

implementation
uses reports_unit,DateUtils, DM_VedomPublicUnit,cntsLANG;

{$R *.dfm}

procedure TPoteriForm.Translate;
begin
   self.Caption:=TrLangMSG(msgLosses);
   bb_exit.Caption:='&'+TrLangMSG(msgExit);
   bb_exit.Hint:=TrLangMSG(msgCloseWindow);
   GroupBox1.Caption:=TrLangMSG( msgClorDisconPart);
   Label7.Caption:=TrLangMSG(msgDateAkt);
   Label9.Caption:=TrLangMSG(msgDateReciveOrder);
   Label30.Caption:=TrLangMSG( msgDepthPutM);
   Label32.Caption:=TrLangMSG(msgPressAtm);
   Label32.Caption:=TrLangMSG( msgSquareSvich);   //Площадь свища, мм2
   Label32.Caption:=TrLangMSG( mshLeakSpeed );//Утечка, м3/ч
   Label1.Caption:=TrLangMSG(msgDamgeCharacterIs);//Уточнение характера повреждения
   Label3.Caption:=TrLangMSG(msgendWork);//Дата и время окончания работ
   Label15.Caption:=TrLangMSG(msgDoFlashing); //Промывка производилась, ч
   Label4.Caption:=TrLangMSG(msgDiamDamage); //Диаметр участка повреждения, мм
   Label6.Caption:=TrLangMSG(msgCharLeak);//Характер места утечки
   Label11.Caption:=TrLangMSG(msgClorDoz );//Доза хлора, мг/л
   Label13.Caption:=TrLangMSG(msgTimeContact);//Время контакта, ч
   Label16.Caption:=TrLangMSG(msgExternalDiam);//Внешний диаметр, мм
   Label17.Caption:=TrLangMSG(msgInteriorDiam);//Внутренний диаметр, мм
   Label18.Caption:=TrLangMSG(msgConer);//Угол, град
   Label10.Caption:=TrLangMSG(msgDiamSvich);//Диаметр свища, мм
   Label12.Caption:=TrLangMSG(msgCrackLength);//Длина трещины, мм
   Label14.Caption:=TrLangMSG(msgCrackWidth);//Ширина трещины, мм
   Label2.Caption:=TrLangMSG( msgLengthEmpty);//Протяженность опорожненного участка водопровода, м
   Label8.Caption:=TrLangMSG( msgDiamEmpty);//Диаметр участка опорожнения, мм
   Label36.Caption:=TrLangMSG( mshLeakSpeed );//Утечка, м3/ч
end;

procedure TPoteriForm.SetFEndDate(value:string);
begin
  if value<>'' then
    begin
      FEndDate:=value;
      DE_EndDate.Date:=StrToDate(value);
      DE_EndDate.Text:=FEndDate;
    end
      else
    begin
      FEndDate:='';
      DE_EndDate.Date:=0;
      DE_EndDate.Text:='';
    end;
end;

procedure TPoteriForm.SetFEndTime(value:string);
begin
  if value<>'' then
    begin
      TE_EndTime.Time:=StrToTime(value);
      FEndTime:=value;
    end
      else
    begin
      FEndTime:='';
      TE_EndTime.Time:=0;
    end;
end;

procedure TPoteriForm.SetFDiam_Povrezhd(value:string);
begin
  E_DiamPovr.Text:=value;
end;

function TPoteriForm.GetPoteriPromyv:double;
var _QShevelev:TQShevelev;
  _diamPovr:integer;
begin
  result:=0;
  try
    _QShevelev:=TQShevelev.Create;
    _QShevelev.MatPipeStr:=FMatPipe;
    try
      _diamPovr:=StrToInt(FOpDiam_Povrezhd);
    except
      _diamPovr:=0;
    end;
    result:=_QShevelev.GetQinM3(TE_Promivka.Time,_diamPovr);
    if result<=-1
      then result:=0; 
  finally
    _QShevelev.Free;
  end;
end;

procedure TPoteriForm.SetFActDate(value:TDateTime);
begin
  FActDate:=value;
  DE_ActDate.Date:=value;
  DE_ActDate.Text:=DateToStr(value);
end;

procedure TPoteriForm.SetFPostuplDateTime(value:TDateTime);
begin
  FPostuplDateTime:=value;
  E_PostuplDateTime.Text:=DateTimeToStr(value);  
end;

procedure TPoteriForm.FillEndDateTime;
var _min_viezd,_max_viezd:integer;
  _min_date,_max_date:TDateTime;
  _EndDate,_EndTime:string;
begin
  if FEndDate='' then
    begin
      DM_VedomPublic.CalcNomerViezd(FID_zav,_min_viezd,_max_viezd,_min_date,_max_date);
      {if _min_viezd<>0 then E_FirstViezd.Text:=IntToStr(_min_viezd);
      if _max_viezd<>0 then E_LastViezd.Text:=IntToStr(_max_viezd);
      if _min_date>1 then FFirstViezd_Time:=TimeToStr(_min_date);
      if _min_date>1 then FFirstViezd_Date:=DateToStr(_min_date);
      if _max_date>1 then FLastViezd_Time:=TimeToStr(_max_date);
      if _max_date>1 then FLastViezd_Date:=DateToStr(_max_date);}
      if _max_date>1 then _EndDate:=DateToStr(_max_date) else _EndDate:='';
      if _max_date>1 then _EndTime:=MyTimeToStr(_max_date) else _EndTime:='';
      //
      if _EndDate<>'' then
        begin
          DE_EndDate.Date:=StrToDate(_EndDate);
          DE_EndDate.Text:=_EndDate;
        end
          else
        begin
          DE_EndDate.Date:=0;
          DE_EndDate.Text:='';
        end;
      if _EndTime<>'' then
        begin
          TE_EndTime.Time:=StrToTime(_EndTime);
        end
          else
        begin
          TE_EndTime.Time:=0;
        end;
    end;        
end;

procedure TPoteriForm.SetFID_OpDiam_Povrezhd(value:integer);
begin
  Dbl_OpDiam.LookupSource.DataSet.Locate('ID',value,[]);
  Dbl_OpDiam.Value:=Dbl_OpDiam.LookupSource.DataSet.FieldByName('ID').AsString;
  if Dbl_OpDiam.LookupSource.DataSet.FieldByName('ID').AsInteger>0 then
    FOpDiam_Povrezhd:=Dbl_OpDiam.LookupSource.DataSet.FieldByName('DIAM_STR').AsString
      else FOpDiam_Povrezhd:='0';
end;

constructor TPoteriForm.Create(AOwner:TComponent; _ReadOnly:boolean);
begin
  FReadOnly:=_ReadOnly;
  inherited Create(AOwner);
end;

function TPoteriForm.Hours(fulltime:TDateTime):double;
begin
  result:=Trunc(fulltime)*24+HourOf(fulltime)+MinuteOf(fulltime)/60+SecondOf(fulltime)/3600;
end;

function TPoteriForm.CountUtechka(_square,_pressure,_glubina:double):double;
begin
  result:=0.62*3600*(_square/10000)*sqrt(20*Max((10*_pressure-_glubina),0));
end;

procedure TPoteriForm.SetFUtoch_Xar_Povr(value:string);
begin
  XarPovrMemo.Text:=value;
end;

procedure TPoteriForm.SetFOp_Protyazh(value:double);
begin
  SE_Protyazh.Value:=value;
end;

{procedure TPoteriForm.SetFOp_Id_Diam(value:integer);
begin
  Dbl_Diam.LookupSource.DataSet.Locate('ID',value,[]);
  Dbl_Diam.Value:=Dbl_Diam.LookupSource.DataSet.FieldByName('ID').AsString;
  if Dbl_Diam.LookupSource.DataSet.FieldByName('ID').AsInteger>0 then
    FOp_Diam:=Dbl_Diam.LookupSource.DataSet.FieldByName('DIAM_STR').AsString
      else FOp_Diam:='0';
end;}

procedure TPoteriForm.SetFCl_Doza(value:double);
begin
  SE_Clor.Value:=value;
end;

procedure TPoteriForm.SetFCl_Contact_Time(value:double);
begin
  TE_Contact.DateTime:=value;
end;

procedure TPoteriForm.SetFCl_Promiv_Time(value:double);
begin
  TE_Promivka.DateTime:=value;
end;

procedure TPoteriForm.SetFCl_Pressure(value:double);
begin
end;
    
procedure TPoteriForm.SetFsePress_Value(value:double);
begin
  sePress.Value:=value;
end;

procedure TPoteriForm.SetFseSpeedLeak_Value(value:double);
begin
  seSpeedLeak.Value:=value;
end;

procedure TPoteriForm.SetFseGLZ_Value(value:double);
begin
  seGLZ.Value:=value;
end;

procedure TPoteriForm.UpdateValues;
begin
  FsePress_Value:=sePress.Value;
  FseSpeedLeak_Value:=seSpeedLeak.Value;
  FseGLZ_Value:=seGLZ.Value;
  //
  FUtoch_Xar_Povr:=XarPovrMemo.Text;
  FOp_Protyazh:=SE_Protyazh.Value;
  FID_OpDiam_Povrezhd:=Dbl_OpDiam.LookupSource.DataSet.FieldByName('ID').AsInteger;
  FOpDiam_Povrezhd:=Dbl_OpDiam.LookupSource.DataSet.FieldByName('DIAM_STR').AsString;
  FCl_Doza:=SE_Clor.Value;
  FCl_Contact_Time:=TE_Contact.DateTime;
  FCl_Promiv_Time:=TE_Promivka.DateTime;
  FActDate:=DE_ActDate.Date;
  if DE_EndDate.Text<>'  .  .    ' then FEndDate:=DateToStr(DE_EndDate.Date)
    else FEndDate:='';
  FEndTime:=MyTimeToStr(TE_EndTime.Time);
end;

procedure TPoteriForm.BB_ExitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TPoteriForm.seGLZChange(Sender: TObject);
begin
  inherited;
  CheckFill;
  UpdateValues;
  _DoCalcLeak( Sender );
end;

procedure TPoteriForm.seSpeedLeakChange(Sender: TObject);
begin
  inherited;
  UpdateValues;
  if Assigned(FExDBL_raonChange) then
    FExDBL_raonChange(Sender);
end;

procedure TPoteriForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  UpdateValues;
  Qry_diam.Close;
end;

procedure TPoteriForm.FormCreate(Sender: TObject);
var i:integer;
  PropInfo: PPropInfo;
begin
  inherited;
  FIsNeedRecalcLeak := false;
  //
  FDiamSqEvent:=tdseNull;
  Qry_diam.Open;
  FMemoChanged:=false;
  if FReadOnly then
    begin
      for i:=0 to ComponentCount-1 do
        begin
          PropInfo:=GetPropInfo(Components[i],'ReadOnly');
          if PropInfo <> nil then SetOrdProp(Components[i], PropInfo, ord(true))
            else if (Components[i] is TDateTimePicker) then
              (Components[i] as TDateTimePicker).Enabled:=FALSE;
        end;
    end;
end;

procedure TPoteriForm.XarPovrMemoChange(Sender: TObject);
begin
  inherited;
  if (Assigned(FExDBL_raonChange)) then
    begin
      if not(FMemoChanged) then
        begin
          UpdateValues;
          if Assigned(FExDBL_raonChange) then FExDBL_raonChange(Sender);
        end;
      FMemoChanged:=true;
    end;      
end;

procedure TPoteriForm.FormShow(Sender: TObject);
var _tn:TNotifyEvent;
begin
  inherited;
  _tn:=FExDBL_raonChange;
  FIsNeedRecalcLeak := false;
  try
    FExDBL_raonChange:=nil;
    FillEndDateTime;
    CheckFill;
    //
    seGLZChange(self);
  finally
    FExDBL_raonChange:=_tn;
    FIsNeedRecalcLeak := true;
  end;
end;

function TPoteriForm.CheckFill:boolean;
begin
  result:=(DE_EndDate.Date>1) and (trim(DBL_OpDiam.Text)<>'');
//  SB_Print.Enabled:=result;         
end;
                        
procedure TPoteriForm.SB_PrintClick(Sender: TObject);
var s,s1,s2:string;
  _poteri_promyv,_poteri_oporozhn,_poteri_povrezhd:double;
begin
  inherited;
  try
    DM_Reports:=TDM_Reports.Create(nil,trtAct);
  except
    on E:Exception do
      begin
        MessageDlg('TPoteriForm.SB_PrintClick'#13+ E.Message,mtError, [mbOk], 0);
  {      MessageBox(handle,PChar('TPoteriForm.SB_PrintClick'#13+
          E.Message),'Диспетчер АВР', MB_OK or MB_ICONWARNING);}
        DM_Reports.Free;
        Exit;
      end;  
  end;
  try
      with DM_Reports.ActRep do
      begin
        VarValue['actday']:=IntToStr(DayOf(FActDate));
        VarValue['actmonth']:=MonthsFullName[MonthOf(FActDate)];
        VarValue['actyear']:=IntToStr(YearOf(FActDate));
        VarValue['diam1']:=trim(E_DiamPovr.Text);
        VarValue['street']:=FStreet;//'ул. Ленина, 57';
        //VarValue['day1']:='21';
        //VarValue['month1']:='04';
        //VarValue['year1']:='2005';
        VarValue['hour1']:=MyTimeToStr(FPostuplDateTime);
        VarValue['day2']:=IntToStr(DayOf(FPostuplDateTime));
        VarValue['month2']:=MonthsFullName[MonthOf(FPostuplDateTime)];
        VarValue['year2']:=IntToStr(YearOf(FPostuplDateTime));
        //
        s:=XarPovrMemo.Text;
        LeftSpaces(40,s);
        VarValue['xarpovr']:=s;
        //
        VarValue['povrpressure']:=sePress.Text;
        VarValue['protyazhoporozhn']:=SE_Protyazh.Text;
        if FEndTime<>'' then VarValue['work_end_time']:=FEndTime;
        if FEndDate<>'' then
          begin
            VarValue['work_end_day']:=IntToStr(DayOf(StrToDate(FEndDate)));
            VarValue['work_end_month']:=MonthsFullName[MonthOf(StrToDate(FEndDate))];
            VarValue['work_end_year']:=IntToStr(YearOf(StrToDate(FEndDate)));
          end;            
        VarValue['doza_clor']:=SE_Clor.Text;
        VarValue['contact_time']:=MyTimeToStr(TE_Contact.Time);
        VarValue['promyv_time']:=MyTimeToStr(TE_Promivka.Time);
        //
        {Потери в результате промывки}
        _poteri_promyv:=GetPoteriPromyv;
        VarValue['poteri_promyv']:=FormatFloat('####0.0##',_poteri_promyv);
        //
        {потери в результате опорожнения}
        _poteri_oporozhn:=pi*sqr((StrToFloat(DBL_OpDiam.Text))/2/1000)*SE_Protyazh.Value;
        VarValue['poteri_oporozhn']:=FormatFloat('####0.0##',_poteri_oporozhn);
        //
        {потери в результате повреждения}
        _poteri_povrezhd:=0;
        if (FEndTime<>'') and (FEndDate<>'') then
            begin
              _poteri_povrezhd:=seSpeedLeak.Value*Hours(StrToDateTime(FEndDate+' '+FEndTime)-FPostuplDateTime);
              VarValue['poteri_povrezhd']:=FormatFloat('####0.0##',_poteri_povrezhd);
            end;                
        //
        VarValue['poteri_obschie']:=FormatFloat('#####0.0##',(_poteri_promyv+_poteri_oporozhn+_poteri_povrezhd));
        //VarValue['nach_otdel']:='Мармазякин Владилен Залипунович';
        //VarValue['nach_obj']:='Зубоскалин Лев Давыдович';
        //VarValue['proizvod_rabot']:='Мартин Лютер Кинг';
        //
        Execute;
      end;
  finally
    DM_Reports.Free;
  end;
end;

procedure TPoteriForm.E_FirstViezdChange(Sender: TObject);
begin
  inherited;
  CheckFill;
end;

procedure TPoteriForm.seDiamLeakChange(Sender: TObject);
begin
  inherited;
  FDiamSqEvent:=tdseDiam;
  SetDiamSquare(FDiamSqEvent);
  _DoCalcLeak( Sender );
end;

procedure TPoteriForm.SetFseSquareLeak_Value(value:double);
begin
  //eSquareLeak.Value:=value*100; //см2 -> мм2
  eSquare.Text:=FormatFloat('###0.0#####',FseSquareLeak_Value*100);
end;

procedure TPoteriForm.SetFseDiamLeak_Value(value:integer);
begin
  seDiamLeak.Value:=value; // мм
end;

procedure TPoteriForm.SetDiamSquare(_who_event:TDiamSqEvent);
begin
  case _who_event of
    tdseDiam:
      begin
        case FXAR_MESTA_POVR of
          txpNull:
            begin
              FseSquareLeak_Value:=0;
            end;
          txpSvisch:
            begin
              FSVISCH_DIAM:=seDiamLeak.AsInteger;
              FseSquareLeak_Value:=sqr((FSVISCH_DIAM/2)/10)*pi; //см2
              //
              //seSquareLeak.OnChange:=nil;
              //meSquare.Text:=FloatToStr(FseSquareLeak_Value*100);
              //seSquareLeak.OnChange:=seSquareLeakChange;
            end;
          txpTreschina:
            begin
              FTRESCH_DLINA := seTRESCH_DLINA.AsInteger;
              FTRESCH_SHIRINA := seTRESCH_SHIRINA.AsInteger;
              FseSquareLeak_Value:=(FTRESCH_DLINA*FTRESCH_SHIRINA)/100; //см2
            end;
          txpTor:
            begin
              FTOR_VNESHN_DIAM := seTorVneshnDiam.AsInteger;
              FTOR_VNUTR_DIAM := seTorVnutrDiam.AsInteger;
              seTorUgol.ItemIndex := seTorUgol.ItemIndex;
              seTorUgol.Update;
              FTOR_UGOL := StrToInt(seTorUgol.Items[seTorUgol.ItemIndex]);
              FseSquareLeak_Value := (sqr((FTOR_VNESHN_DIAM/2)/10)*pi -
                sqr((FTOR_VNUTR_DIAM/2)/10)*pi) * (FTOR_UGOL/360);
            end;
        end;
        eSquare.Text:=FormatFloat('###0.0#####',FseSquareLeak_Value*100);


      end;
    tdseSquare:
      begin
          {}
      end;
  end;
  FDiamSqEvent:=tdseNull;  
end;

procedure TPoteriForm.Button1Click(Sender: TObject);
var _QShevelev:TQShevelev;
begin
  inherited;
  ///
{    try
    _QShevelev:=TQShevelev.Create;
    _QShevelev.MatPipeStr:='СТАЛЬ';
    //result:=_QShevelev.GetQinM3(TE_Promivka.Time,_diamPovr);
    //
    _QShevelev.PrintShevelevGraph;
  finally
    _QShevelev.Free;
  end;}
end;

procedure TPoteriForm.SetXAR_MESTA_POVR(value: TXarPovr);
begin
  FXAR_MESTA_POVR := value;
  UpdateXarPovrCombo;
end;


procedure TPoteriForm.VisualChangeXarPovr;
var i:integer;
  _p:TPanel;
begin
  for i :=0 to ComponentCount - 1 do
  begin
    if (Components[i] is TPanel) and (Components[i].Tag<>0) then
    begin
      _p := Components[i] as TPanel;
      _p.Left := 1;
      _p.Top := 1;
      _p.Hide;
    end;
  end;
  case FXAR_MESTA_POVR of
    txpNull:;
    txpSvisch: pSvisch.Show;
    txpTreschina: pTreschina.Show;
    txpTor: pTor.Show;
  end;
  FDiamSqEvent:=tdseDiam;
  SetDiamSquare(FDiamSqEvent);
end;

procedure TPoteriForm.UpdateXarPovrCombo;
begin
  cmbXarPovr.ItemIndex := integer(FXAR_MESTA_POVR);
  cmbXarPovr.Update;
  VisualChangeXarPovr;
end;


procedure TPoteriForm.SetSVISCH_DIAM(value: integer);
begin
  FSVISCH_DIAM := value;
  seDiamLeak.Value := value;  
end;

procedure TPoteriForm.SetTRESCH_DLINA(value: integer);
begin
  FTRESCH_DLINA := value;
  seTRESCH_DLINA.Value := value;
end;

procedure TPoteriForm.SetTRESCH_SHIRINA(value: integer);
begin
  FTRESCH_SHIRINA := value;
  seTRESCH_SHIRINA.Value := value;
end;

procedure TPoteriForm.SetTOR_VNESHN_DIAM(value: integer);
begin
  FTOR_VNESHN_DIAM := value;
  seTorVneshnDiam.AsInteger := value;
end;

procedure TPoteriForm.SetTOR_VNUTR_DIAM(value: integer);
begin
  FTOR_VNUTR_DIAM := value;
  seTorVnutrDiam.AsInteger := value;
end;

procedure TPoteriForm.SetTOR_UGOL(value: integer);
var
  i: integer;
begin
  FTOR_UGOL := value;
  i := seTorUgol.Items.IndexOf(IntToStr(value));
  if i=-1 then i := 0;
  seTorUgol.ItemIndex := i;
  seTorUgol.Update;
end;

procedure TPoteriForm.cmbXarPovrChange(Sender: TObject);
begin
  inherited;
  FXAR_MESTA_POVR := TXarPovr(cmbXarPovr.ItemIndex);
  VisualChangeXarPovr;
  if Assigned(FExDBL_raonChange) then FExDBL_raonChange(nil);
end;

procedure TPoteriForm.DE_EndDateChange(Sender: TObject);
begin
  inherited;
  CheckFill;
  UpdateValues;
  if Assigned(FExDBL_raonChange) then FExDBL_raonChange(nil);
end;

procedure TPoteriForm._DoCalcLeak(Sender: TObject);
begin
  if FIsNeedRecalcLeak and Assigned(FExDoClalcLeak) then
  begin
    if Assigned(FExDBL_raonChange) then  FExDoClalcLeak(Sender)
      else FExDoClalcLeak(nil);
  end;
end;

end.
