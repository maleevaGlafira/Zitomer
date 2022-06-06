unit zav;
//Участок убирать нельзя смены по учаткам
//TekAlien - Если больше 0 то заявка чужая не работает!!! id_alien = из списка owner
interface
{$I !map_define.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, RXLookup, DBTables, ExtCtrls, Buttons, Mask, ToolEdit, Math,
  ComCtrls, Menus,prosm2, frmLANG, cntsLANG, variants, RXSpin,RxStrUtils,
  StrUtils,reports_unit,StackUnit,datam,OperAttFormUnit,ServiceFuncUnit,
  {$IFDEF MAP} SendMessToAvarOnMap, AvarOnMapConst, _avonm_DMAvarUnit, {$ENDIF}
  Zav_DMUnit, DBCtrls,DateUtils,Report_Zayav_Unit, NGReports, narad,
  GeoCoordUnit, RXCtrls;

const
  LeakConst=0.868;
  DEL_STATUS_KEYWORD=' наряд';
  Id_revs_voda=11;
  Id_revs_kan=14;

type
  TChangeStatus=(tcsNoChanged,tcsWasChanged);

  TAddrRecord = record
   type_addr :integer;
   baze_street :string;
   cross_street :string;
   house_numb :string;
   dop_addr :string;
  end; // record

  TFormZav = class(TOperAttForm)
    Panel1: TPanel;
    Label7: TLabel;
    Label9: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Lb_disIn: TLabel;
    Lb_disOut: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Lb_2Alien: TLabel;
    DBL_zav: TRxDBLookupCombo;
    Ed_dopinfORG: TEdit;
    DBL_tzav: TRxDBLookupCombo;
    ChB_viezd: TCheckBox;
    GrB_adres: TGroupBox;
    Label12: TLabel;
    Lb_NmUl: TLabel;
    Lb_Ndom: TLabel;
    CB_tAdr: TComboBox;
    DBL_ul1: TRxDBLookupCombo;
    Ed_ndom: TEdit;
    DBL_ul2: TRxDBLookupCombo;
    Ed_dopAdr: TEdit;
    GrB_damg: TGroupBox;
    Label4: TLabel;
    BB_Save: TBitBtn;
    DE_in: TDateEdit;
    DE_out: TDateEdit;
    BB_Exit: TBitBtn;
    BB_zadv: TBitBtn;
    BB_Narad: TBitBtn;
    BB_Ras: TBitBtn;
    TE_In: TDateTimePicker;
    TE_Out: TDateTimePicker;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    Excel1: TMenuItem;
    PopAutoVvod: TPopupMenu;
    N2: TMenuItem;
    N3: TMenuItem;
    Pn_stat: TPanel;
    Lb_stat: TLabel;
    Lb_save: TLabel;
    Panel2: TPanel;
    Lb_Nomer: TLabel;
    Lb_Nzav: TStaticText;
    Panel3: TPanel;
    BB_Print: TBitBtn;
    BB_Excel: TBitBtn;
    BB_NewZ: TBitBtn;
    BB_CopyNew: TBitBtn;
    BShowonMap: TSpeedButton;
    SpeedButton1: TSpeedButton;
    BB_Clzav: TBitBtn;
    Label1: TLabel;
    DBL_Raon: TRxDBLookupCombo;
    Label3: TLabel;
    DBL_damg: TRxDBLookupCombo;
    StaticText1: TStaticText;
    cbAttach: TComboBox;
    Label2: TLabel;
    Label6: TLabel;
    DBL_matpipe: TRxDBLookupCombo;
    Diam_lb: TLabel;
    DBL_Diam: TRxDBLookupCombo;
    edDop_inf: TMemo;
    Label20: TLabel;
    DBL_Mest: TRxDBLookupCombo;
    Label19: TLabel;
    pmChoiceAtt_Zav: TPopupMenu;
    N4: TMenuItem;
    N5: TMenuItem;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Label22: TLabel;
    Ed_dopinfNAM: TEdit;
    Label23: TLabel;
    Ed_dopinfTEL: TEdit;
    Bevel4: TBevel;
    Label28: TLabel;
    Label25: TLabel;
    DBL_owner: TRxDBLookupCombo;
    DBL_WhatMatter: TRxDBLookupCombo;
    SpB_Alien: TSpeedButton;
    ChB_Cont: TCheckBox;
    DBLC_brig: TRxDBLookupCombo;
    Bevel5: TBevel;
    Bevel1: TBevel;
    Label5: TLabel;
    DBL_place: TRxDBLookupCombo;
    Label27: TLabel;
    DBL_sod: TRxDBLookupCombo;
    BB_Poteri: TBitBtn;
    lb_Bevel: TBevel;
    Lb_Alien: TLabel;
    CB_DelZayav: TCheckBox;
    bbMap: TBitBtn;
    DBL_Sdal: TRxDBLookupCombo;
    Label10: TLabel;
    DE_Poluch: TDateEdit;
    TE_Poluch: TDateTimePicker;
    DBL_BrPoluch: TRxDBLookupCombo;
    Label11: TLabel;
    BB_Image: TBitBtn;
    DBL_Revs: TRxDBLookupCombo;
    Label17: TLabel;
    pnl_VRK : TPanel;
    Label18: TLabel;
    DBL_vrk: TRxDBLookupCombo;
    N6: TMenuItem;
    dbl_DopAdres: TRxDBLookupCombo;
    pm_Print: TPopupMenu;
    mi_PrintZav: TMenuItem;
    mi_EkonomPokaz: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    bt_COORD: TButton;
    Frm_GEOCOORD1: TFrm_GEOCOORD;
    L_Coord: TLabel;
    PCoord: TPanel;
    Label8: TLabel;
    Label24: TLabel;
    Label32: TLabel;
    Label34: TLabel;
    se_XF: TRxSpinEdit;
    se_XD: TRxSpinEdit;
    se_YF: TRxSpinEdit;
    se_YD: TRxSpinEdit;
    RxLabel1: TRxLabel;
    cb_OTL: TCheckBox;
    pnl_podpor: TPanel;
    Lbl_podpor: TLabel;
    dbl_podpor: TRxDBLookupCombo;
    dbl_settlers: TRxDBLookupCombo;
    Label_settler: TLabel;
    BB_WithoutWater: TBitBtn;
    btn_linkOtlZav: TButton;
    Label21: TLabel;
    sp_intime_out: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CB_tAdrChange(Sender: TObject);
    procedure BB_SaveClick(Sender: TObject);
    procedure DBL_RaonChange(Sender: TObject);
    procedure DBL_Raon2Change(Sender: TObject);   //только для райна

    procedure BB_ExitClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BB_ClzavClick(Sender: TObject);
    procedure BB_zadvClick(Sender: TObject);
    procedure BB_NaradClick(Sender: TObject);
    procedure ChB_AlienClick(Sender: TObject);
    procedure SpB_AlienClick(Sender: TObject);
    procedure ChB_ContClick(Sender: TObject);
    procedure SpB_RoOClick(Sender: TObject);
    procedure SpB_2AlienClick(Sender: TObject);
    procedure ChB_viezdClick(Sender: TObject);
    procedure DBL_ul1Change(Sender: TObject);
    procedure BB_RasClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBL_tzavChange(Sender: TObject);
    procedure BB_PrintClick(Sender: TObject);
    procedure BB_NewZClick(Sender: TObject);
    procedure BB_CopyNewClick(Sender: TObject);
    procedure DBL_RaonKeyPress(Sender: TObject; var Key: Char);
    procedure N1Click(Sender: TObject);
    procedure Excel1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Mmm_dopinfChange(Sender: TObject);
    procedure Ed_dopinfORGChange(Sender: TObject);
    procedure Ed_dopinfORGExit(Sender: TObject);
    procedure Ed_dopinfORGKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure Mmm_dopinfExit(Sender: TObject);
    procedure Ed_ndomChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Ed_dopinfTELExit(Sender: TObject);
    procedure HidePrior(st:boolean);
    procedure cbAttachChange(Sender: TObject);
    procedure NewZav(Sender: TObject);
    procedure CopyToNew(Sender: TObject);
    procedure DBL_placeChange(Sender: TObject);
    procedure BB_PoteriClick(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure CB_DelZayavClick(Sender: TObject);
    procedure CB_DelZayavKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CB_DelZayavMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure edDop_infKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edDop_infKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure bbMapClick(Sender: TObject);
    procedure bbPrintOrdClick(Sender: TObject);
    procedure BB_WithoutWaterClick(Sender: TObject);
    procedure DE_inChange(Sender: TObject);
    procedure BB_ImageClick(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure mi_PrintZavClick(Sender: TObject);
    procedure mi_EkonomPokazClick(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure bt_COORDClick(Sender: TObject);
    procedure Panel4Click(Sender: TObject);
    procedure Frm_GEOCOORD1BitBtn1Click(Sender: TObject);
    procedure P_Coord_Fill;
    procedure D_Coord_Fill;
    procedure cb_OTLKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cb_OTLMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure cb_OTLClick(Sender: TObject);
    procedure btn_linkOtlZavClick(Sender: TObject);
    procedure sp_intime_outClick(Sender: TObject);
  protected
    FDopInfCaretPos:TPoint;
    FNNarCount:integer;
    FNWWater:integer;
    FUpdateZavFlag:boolean;
    seGLZ_Value,seSpeedLeak_Value,sePress_Value,seSquareLeak_Value:double;
    FXAR_MESTA_POVR, FTRESCH_DLINA, FSVISCH_DIAM, FTRESCH_SHIRINA,
      FTOR_VNESHN_DIAM, FTOR_VNUTR_DIAM, FTOR_UGOL:integer;

    FormMode:TFormMode;
    ZavCode:Integer;
    ZavAttach:TOperAtt;
    isIzm,isToRevs:boolean;
    TekAlien,OldAlien,Int_to,OldInt_to:integer;
    org1_name,org1_tf,org1_Fam:string;
    org2_name,org2_tf,org2_Fam:string;
    FDiam_Present :boolean;
    OldAddr{, NewAddr} :TAddrRecord;
    FActDate:TDateTime;
    //
    FOp_Protyazh,FCl_Doza,FCl_Contact_Time,
      FCl_Promiv_Time,FCl_Pressure:double;
    FUtoch_Xar_Povr:string;
    FOp_Id_Diam:integer;
    FOp_Diam:string;
    FLockChangeNotify:boolean;
    ne_mi14,ne_mi15,ne_mi72,
    ne_mi_ObjVoda, ne_mi_ObjKanal: TNotifyEvent;
    FWasLoadState:boolean;
    FParentGaveStack, FDelStatusWasChanged, FOtlStatusWasChanged:boolean;
    FLastFirstStrOfDopInf:string;
    FPoteriEndDateTime:TDateTime;
    F_SCREENSHOT_PATH_1: string;
    F_SCREENSHOT_PATH_2: string;
    F_NeedOfCountScreenShot: byte;
    //////////////////////////////////////////
    procedure DoCalcLeak(Sender: TObject);
    procedure SetDiam_Present(fl :boolean);
    procedure CheckAddrChange;
    procedure BB_clzav_Enabled(value:boolean);
    procedure BB_Narad_enabled(value:boolean);
    procedure BB_Save_Enabled(value:boolean);
    procedure fromPoteriForm;
    procedure toPoteriForm;
    //function GenAddr(_ul1,_ul2:TRxDBLookupCombo;_house,_dopadr:TEdit):string; overload;
    procedure OldPrint;
    procedure NewPrint; virtual;
    //
    procedure SaveState;
    procedure LoadState;
    procedure InitFills;
    procedure EnabledControlsDependsFromOwner;
    procedure SetCaptionDisOutNameUser;
    procedure SetCaptionStatusCloseOrNoOfZayav;
    procedure SetCaptionDTInAndNZavAndBrigInAndOwner;
    procedure ShowBrigOnControl;
    procedure ShowAlienInfo;
    procedure ExportInfoToPoteriForm;
    procedure ShowDopInf;
    procedure SetCaptionAttach;
    procedure SetCaptionDamgAndInfo;
    procedure SetCaptionZayavitelInfo;
    procedure SetCaptionViezdZadvRaskopNarad;
    procedure FindIDZavInTabl;
    procedure SetCaptionUl;
    procedure SetDatasetOfControls;
    procedure SetCaptionSdalPoluchInfo;
    //
    procedure SmartPopup(ne:TNotifyEvent; tb:TBitBtn);
    procedure MI4_OnClick(ne:TNotifyEvent);
    procedure MI5_OnClick(ne:TNotifyEvent);
    procedure M72_OnClick(ne:TNotifyEvent);
    function GetZayavDelStatus:boolean;
    function ConvertCheckedToZayavDelStatus:integer;
    function Detect_FirstStrOfDopInfOnDelStatus:boolean;
    function Add_FirstStrOfDopInfOnDelStatus:boolean;
    function Delete_FirstStrOfDopInfOnDelStatus:boolean;
    function PrepareDopInfBeforeSave:string;
    function NotifyAboutFirstViezd:boolean;
    procedure SavePoteriForClosedZav;
    procedure PrintEkonomPokaz;
    {$IFDEF MAP}
    procedure OnReceivedScreenShot(Sender:TObject);
    procedure OnAskWorkFields(Sender:TObject);
    procedure OnFindWorkFields(Sender:TObject; _Attach:TAttach; _nomer,_year:integer);
    {$ENDIF}
  protected
    procedure ShowRevsRaonUlic; virtual;
    procedure LightNeedFields; virtual;
    procedure DisplayValuesFromDB; virtual;
    function GetAdresForPrint: string; virtual;
    procedure InitCbAttach; virtual;
  private
    F_NSec: real;
    F_ESec: real;

  public
    // координаты в секундах
    property NSec: real read F_NSec write F_NSec;
    property ESec: real read F_ESec write F_ESec;
  
    function CheckFill(toClose:boolean):boolean; virtual;
    procedure isVvod(st:boolean); virtual;
    procedure InitNarForm( _NarForm: TFormNarad ); virtual;
    function GetMestTypeID: integer;
  public
    FDM_Zav:TDM_Zavv;
    FltDel:boolean; // с каким FormMode была создана форма, то и применять Filter
    FMemReadOnly:boolean;
    XLApp: Variant;
    PrF2:TProsmForm2;
    isInExcel,isSel:boolean;
    OldFirstLine:string;
    isClosed: boolean;
    constructor ZavCreate(AOwner: TComponent; Mode:TFormMode; zCod:integer);
    procedure UpdateZav;
    procedure isSave(st:TChangeStatus);
    procedure ZapAlien(isAl:boolean;TekAlien:integer);
    procedure SaveAlien(isDel:boolean;Old_nn:integer;
                             t_nm,t_tf,t_fa:string;
                             var Tek_nn:integer);
    procedure ChngAlien(isVis,isAl:boolean);
    procedure ZapRevs2;
    procedure isZavClose;
 //   procedure UpdateSod;
    procedure MyProsmClose(Sender: TObject; var Action: TCloseAction);
    procedure Text2Zav;
    procedure ViewButPr;
    procedure Translate;override;
    //
    property Diam_Present :boolean read FDiam_Present write SetDiam_Present;
    procedure UpdateComents();
  end;

function FormZav:TFormZav;

  {FormMode,ZavCode:Integer;
  isClosed,isIzm:boolean;}

//ds  function Time2Str(InTime:TDateTime):string;
//ds  function Time2DateTime(InDate:TDateTime;Hour,Min:Word):TDateTime;
//ds  function Date2Year(InDate:TDateTime):Word;
//ds  function STime2DateTime(InDate:TDateTime;InTime:String):TDateTime;
{
var
  ZavAttach:integer;
}

implementation
 uses main,strtool,cl_zadv,sporg,obor,fresult,ComObj, XLConst,
      avartype,support, VedManagerUnit, DM_VedomPublicUnit,
      WithOutWaterUnit, AvrImageViewForm, DMAvrImage, PoteriUnit,
      NGRaskopDM, RaskopForm,NewDisconnections,ShiftDmodule,
      {testSetJson2,} DMmain,
      OtlNaradListForm,HelpFunctionsSentDiscon;
{$R *.DFM}

var
  FCountZav:integer=0;
  FArrZavForm:array[1..16] of TFormZav;

{$I zav-print.inc}
{$I zav-formState.inc}
{$I zav-poteri.inc}
{$I zav-formZavStorage.inc}
{$I zav-addrfunc.inc}
{$I zav-init.inc}

function TFormZav.NotifyAboutFirstViezd:boolean;
begin
  result:=FALSE;
  if (not(FDM_Zav.Qry_owner.FieldByName('OWNER_TYPE').asInteger in [3,4]{предварительная,ложная})) and (FNNarCount=0)
    and (Lb_Nzav.Caption<>'Нов') and not(isClosed)
   then
    begin
      MessageBox(handle,PChar(TrLangMSG(msgFillFirstNar)),//'Заполните первичный выезд!'),
            PChar(TrLangMSG(msgCapMainForm)), MB_OK or MB_ICONWARNING);
      result:=TRUE;
    end;
end;

procedure TFormZav.LightNeedFields;
var _cl:TColor;
begin
  if (not isClosed) and (not (not (rsZAV in RightsSet))) then
    begin
      _cl:=clYellow;
      DE_In.Color:=_cl;
      TE_In.Color:=_cl;
      //DBL_Raon.Color:=_cl;
      DBL_Revs.Color:=_cl; //нет участков!!!
      DBL_Raon.Color:=_cl;
  //    dbl_settlers.Color:=_cl;  //Glasha
      case CB_tAdr.ItemIndex of
        0: begin DBL_Ul1.Color:=_cl; end;
        1: begin DBL_Ul1.Color:=_cl; DBL_Ul2.Color:=_cl; end;
        2: begin DBL_Ul1.Color:=clWhite; end;
      end;
      DBL_Owner.Color:=_cl;
      DBL_WhatMatter.Color:=_cl;
      ED_Ndom.Color:=_cl;
      if FDM_Zav.Qry_owner.Active then
        begin
          if not (FDM_Zav.Qry_owner.FieldByName('OWNER_TYPE').asInteger in [2{,1}{id=1,6,7,8,2,5,9}]) then
            begin
              _cl:=clWhite;
            end;
          //{все завяки закрыты}(NNarCount()>=0) and
          {местность} DBL_Mest.Color:=_cl;
          {тип заявки} DBL_tzav.Color:=_cl;
 //         {характер повреждения}DBL_sod.Color:=_cl;
          {место повреждения} DBL_Place.Color:=_cl;
          {диаметр} //DBL_Diam.Color:=_cl;
          {материал трубы} //DBL_Matpipe.Color:=_cl;
        end;
    end;
end;

procedure TFormZav.BB_Save_Enabled(value:boolean);
begin
  BB_Save.Enabled:=value;
//  cb_OTL.Enabled:=value; // by Vadim 26.02.2009
  if value then isSave(tcsWasChanged)
    else isSave(tcsNoChanged);
end;

procedure TFormZav.BB_Narad_enabled(value:boolean);
begin
  if ((Lb_Nzav.Caption<>TrLangMSG(msgNewM)) and value) or not value then //Новій
    begin
      ChB_viezd.Checked:=value;
    end;
//  BB_Narad.enabled:=value;
end;

constructor TFormZav.ZavCreate(AOwner: TComponent; Mode:TFormMode; zCod:integer);
begin
  FormMode:=Mode;
  ZavCode:=zCod;
  CloseStatus:=0;
  if FormMode<>tfmZayavCopy then
    ZavToCopy:=0;
  FParentGaveStack:=(FormMode=tfmZayavCopy);
  inherited Create(AOwner);
   {01.10.2004}
   Top:=0;
   Left:=(screen.width-width) div 2;
   {/01.10.2004}
//   BB_NewZ.Enabled:=UserRights.Write;
//   BB_CopyNew.Enabled:=UserRights.Write;
end;

procedure TFormZav.FormCreate(Sender: TObject);
var _FormMode:TFormMode;
begin
  inherited;
  //
  FMemReadOnly:=(not (rsZAV in RightsSet));
  if LockForDel then
    RightsSet:=RightsSet-[rsZAV];
  //
  FDelStatusWasChanged:=FALSE;
  FOtlStatusWasChanged:=FALSE;
  FDM_Zav:=TDM_Zavv.Create(nil);
  SetDatasetOfControls;
  FWasLoadState:=FALSE;
  FLockChangeNotify:=FALSE;
  //

  if FormMode=tfmZayavAfterInsert then OperateAttach:=FDM_Zav.GetZavAttach(ZavCode)
  else
  begin
    OperateAttach:=OperAttFormFill(nil);
    if not( OperateAttach in [ toaVoda, toaKanal, toaVRK, toaObjVoda, toaObjKanal ] ) then
      OperateAttach:=toaVoda;
  end;
  ZavAttach:=OperateAttach;


  {********}
  FltDel:=FormMode in [tfmZayavNew,tfmZayavCopy]; // только для новых и для копий
  FDM_Zav.ZakrNeispZnach(ZavCode,FltDel);
  //
  InitFills;
  UpdateZav;
  //
  isSave(tcsNoChanged);
  isZavClose;
  //
    if FormMode = tfmZayavNew{новая}
      then
        begin
          DBL_Diam.ResetField;
          FDM_Zav.Qry_owner.Locate('OWNER_TYPE',3{id=4},[]);
          DBL_owner.Value:=FDM_Zav.Qry_owner.FieldByName('name_r').AsString;
          
          FDM_Zav.setFilterStreetByRegion();
        end  
      else begin
           // FillChar(NewAddr, sizeof(TAddrRecord), 0);
            OldAddr.type_addr:=CB_tAdr.ItemIndex;
            OldAddr.baze_street:=DBL_ul1.text;
            OldAddr.cross_street:=DBL_ul2.text;
            OldAddr.house_numb:=Ed_ndom.text;
            OldAddr.dop_addr:=Ed_dopAdr.text;
           end;
  ////
  LightNeedFields;
  ////
  if FormMode=tfmZayavCopy then
    begin
      LoadState;
      FormMode:=tfmZayavNew;
    end;

 {$IFDEF MAP}
  if MAP_IS_WORK then
  begin
    bbMap.Visible:=True;
    DM_GateAvar:=TDM_GateAvar.Create;
    DM_GateAvar.OnReceivedScreenShot:=OnReceivedScreenShot;
    DM_GateAvar.OnAskWorkFields:=OnAskWorkFields;
    DM_GateAvar.OnFindWorkFields:=OnFindWorkFields;
  end
    else
  begin
    bbMap.Hide;
  end;
{$ELSE}
  bbMap.Hide;
{$ENDIF}

end;

procedure TFormZav.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if (ZavCode>0) and (FDelStatusWasChanged)and (FOtlStatusWasChanged)
                and ((not (not (rsZAV in RightsSet))) or (LockForDel)) then
  FDM_Zav.SaveDelZayavStatus(ZavCode,edDop_inf.Text,IsClosed,ConvertCheckedToZayavDelStatus);
 //
  if CloseStatus=2 then
    begin
      CreateStack;
      SaveState;
    end
      else
    begin
      if FParentGaveStack then FreeStack;
    end;  
 // сбросить будет работать только на один наряд
 FormMain.DictNotHide.checked:=false;

    FDM_Zav.Qry_poluch.Close;
    FDM_Zav.Qry_sdal.Close;
    FDM_Zav.Qry_Raon.Close;
    FDM_Zav.Qry_revs.Close;
    FDM_Zav.Qry_owner.Close;
    FDM_Zav.Qry_Damg.Close;
    FDM_Zav.S_MatPipe.Close;
    FDM_Zav.Qry_Mest.Close;
    FDM_Zav.Qry_Place.Close;
    FDM_Zav.Qry_DiamZ.Close;
    FDM_Zav.Qry_zav.Close;
    FDM_Zav.Qry_comment.Close;
    FDM_Zav.Qry_tzav.Close;
    FDM_Zav.Qry_sod.Close;
    FDM_Zav.Qry_vrk.Close;
    FDM_Zav.Qry_ul1.Close;
    FDM_Zav.Qry_ul2.Close;
    FDM_Zav.qry_DopAdres.Close;
    FDM_Zav.qry_Object.Close;
    FDM_Zav.qry_soorug.Close;

    FDM_Zav.Qry_Brig.Close;
//Nut Anton
    FDM_Zav.Qry_Brig1.Close;
//Nut Anton
  {Podpor}
    FDM_Zav.Qry_podpor.Close;
   {settlers}
    FDM_Zav.qry_settlers.Close;

    SL_DopInf.SaveToFile(CurrentDir+'\dop_inf.txt');
    PopFormZav;
    FDM_Zav.Free;
    FDM_Zav:=nil;
    if FMemReadOnly
      then RightsSet:=RightsSet-[rsZAV]
      else RightsSet:=RightsSet+[rsZAV];
    ///
     {$IFDEF MAP}
     if MAP_IS_WORK then
       begin
         ManageAvarOnMap.OnServerAsk:=nil;
         ManageAvarOnMap.OnScreenShot:=nil;
         ManageAvarOnMap.Hide;
         DM_GateAvar.Free;
       end;
    {$ENDIF}
    ///
    Application.ProcessMessages;
    Action:=caFree;
end;


procedure TFormZav.CB_tAdrChange(Sender: TObject);
begin
  SetCaptionUl;
  DBL_raonChange(nil);
end;


procedure TFormZav.BB_SaveClick(Sender: TObject);
var tt_str,tt_str2,tt_sttr2,tt_str3, tt_otl:string;
    {id_adr,}id_zav:string;
    id_cod,col_adr:integer;
    FRes:TFormResult;
    sTit:TstringList;
    s:string;
    i:integer;
begin
    col_adr:=0;
    {1}try

    if cb_OTL.Checked then
          tt_otl := '1'
       else
          tt_otl := '0';

{
     if (CB_tAdr.ItemIndex=0) and (strip('A',' ',Ed_Ndom.Text)='') then
       begin
         MessageDlg(TrLangMSG(msgNoNomDom),mtError, [mbOk], 0);
         exit;
       end;
}

     if trunc(DE_In.Date)+Frac(TE_in.Time)>now
     then begin
         MessageDlg(TrLangMSG(msgDataTimeGRTemp),mtError, [mbOk], 0);
         TE_In.SetFocus;
         exit;
     end;
//  Закоментировано 20210607 не проверять смену
 {   if (FormMode=tfmZayavNew)  then
    begin
      if not (dm_Shift.datInCurShiftRevs(FDM_Zav.Qry_Revs.FieldByName('ID').AsInteger, trunc(DE_In.Date)+Frac(TE_in.Time))) then
      begin
       MessageDlg(TrLangMSG(msgDatZavEndInCurShift),mtError, [mbOk], 0);
         TE_in.SetFocus;
         exit;
      end;
    end;
    }

   // тут будут дюймы с футами сохраняться by Vadim 11.02.2009
   // , т.к. координаты пошли лесом, то поля NSec и ESec теперь не в секундах, а в дюймах
   // 1F = 12D
    F_NSec := (se_XF.AsInteger * 12) + (se_XD.Value);
    F_ESec := (se_YF.AsInteger * 12) + (se_YD.Value);

  tt_str2:='select count(id) mm from nzavjav where (delz=0) and id_ul1='+
           FDM_Zav.Qry_ul1.FieldByName('ID').asString;
  tt_sttr2:='select count(id) mm from zavjav where (delz=0) and id_ul1='
            + FDM_Zav.Qry_ul1.FieldByName('ID').asString+
            ' and DT_out > current_timestamp - '+IntToStr(days);
  tt_str3:='';

  if FormMode=tfmZayavNew then
     tt_str:=TrLangMSG(msgSaveNewZajav)
  else
     begin
       tt_str3:=' and id<>'+inttostr(ZavCode);
       tt_str:=TrLangMSG(msgSaveChanges)
     end;

  if FDM_Zav.Qry_owner.FieldByName('OWNER_TYPE').asInteger<>3 then
    tt_str3:=tt_str3+' and id_attach='+IntToStr(Ord(ZavAttach));

  tt_str2:=tt_str2+tt_str3;
  tt_sttr2:=tt_sttr2+tt_str3;


  if (GrB_adres.Visible) and (FormMode=tfmZayavNew) then
  begin
  { 2}try
      MyOpenSQL(FDM_Zav.Qry_tmp,tt_str2);
      col_adr:=FDM_Zav.Qry_tmp.FieldByName('MM').asInteger;

      MyOpenSQL(FDM_Zav.Qry_tmp,tt_sttr2);
      col_adr:=col_adr+FDM_Zav.Qry_tmp.FieldByName('MM').asInteger;
      FDM_Zav.Qry_tmp.Close;
    except
      on E:Exception do ShowErr(handle,'TFormZav.BB_SaveClick :: 2',E);
    end;

    if Col_adr>0 then
       begin
          if MessageDlg(inttostr(col_adr)+TrLangMSG(msgSameZajav),
                      mtInformation, [mbYes, mbNo], 0) = mrYes then
            begin

              {3}try
                sTit:=TStringList.Create;
                sTit.Clear;
                sTit.Add('Дата');
                sTit.Add('Номер');sTit.Add(TrLangMSG(msgAddr));
                STit.Add(TrLangMSG(msgDateClose));
                keybd_event(VK_RETURN,0,0,0);






                FRes:=TFormResult.ResCreate(Self,false,'dbn_avar','Результат',
                   TrLangMSG(msgSameZajavList)+FDM_Zav.Qry_ul1.FieldByName('NAME_R').asString,
                  'select z.id,z.id_ul1,z.id_ul2,z.kod_ul,z.dop_adr,z.dt_in pole0,'+
                  'cast(z.nomer as char(8))||"/"||cast(z.fyear as char(8)) pole1,'+
                  ' null pole3 '+
                  ' from nzavjav z '+
                  'where (delz=0) and id_ul1='+FDM_Zav.Qry_ul1.FieldByName('ID').asString+
                  tt_str3+
                  ' union '+
                  'select z.id,z.id_ul1,z.id_ul2,z.kod_ul,z.dop_adr,z.dt_in pole0,'+
                  'cast(z.nomer as char(8))||"/"||cast(z.fyear as char(8)) pole1,'+
                  ' z.dt_out pole3 '+
                  ' from zavjav z '+
                  'where (delz=0) and id_ul1='+FDM_Zav.Qry_ul1.FieldByName('ID').asString+
                  ' and  DT_out > current_timestamp - '+IntToStr(days) +
                  tt_str3+
                  ' order by 6,7'
                  ,sTit,2,NIL,false);
                Fres.ShowModal;
                sTit.Free;
              except
                on E:Exception do ShowErr(handle,'TFormZav.BB_SaveClick :: 3',E);
              end;
            end;
      end;
  end;


  if (FOp_Id_Diam<1) then FOp_Id_Diam:=FDM_Zav.Qry_diamZ.FieldByName('ID').AsInteger;
  if MessageDlg(tt_str,mtConfirmation, [mbNo,mbYes], 0) = mrYes then
    begin
          {4}try
            SaveAlien(not(FDM_Zav.Qry_owner.FieldByName('OWNER_TYPE').asInteger in [1{id=2,5}]),OldAlien,
                      org1_name,org1_tf,org1_fam,TekAlien);
            SaveAlien(isToRevs,OldInt_to,
                      org2_name,org2_tf,org2_fam,Int_to);
          except
            on E:Exception do ShowErr(handle,'TFormZav.BB_SaveClick :: 4',E);
          end;
          {}
          if FormMode=tfmZayavNew then
           begin
            FDM_Zav.ProvNewYear;
            /////////////////
              {5}try
                tt_str:='insert into nzavjav('+
                'XAR_MESTA_POVR, SVISCH_DIAM, TRESCH_DLINA, TRESCH_SHIRINA, ' +
                'TOR_VNESHN_DIAM, TOR_VNUTR_DIAM, TOR_UGOL, ' +
                'PoteriEndDateTime,ActDate,DELZ,Op_Protyazh,Cl_Doza,Cl_Contact_Time,Cl_Promiv_Time,Cl_Pressure,'+
                'Utoch_Xar_Povr,Op_Id_Diam,'+
                'fyear,charnum,id_disin,dt_in,id_disout,dt_out,id_rayon,id_revs,id_settler, '+
                'alien,id_ul1,id_ul2,kod_ul,dop_adr,id_damg,id_comment,id_place,id_mest,'+
                'id_matpipe,id_diam,id_zav,dop_zav,dop_inf,id_tzav,id_sod,id_vrk,is_go,cont,id_alien,id_attach,'+
                'dt_poluch,id_brpoluch,id_brsdal,id_dopadres,id_object, xfeet, yfeet, is_otl, id_soorug '+ //nsec, esec '+
                ',id_podpor ) values('+
                IntToStr(FXAR_MESTA_POVR) +','+ IntToStr(FSVISCH_DIAM) +','+
                IntToStr(FTRESCH_DLINA) +','+ IntToStr(FTRESCH_SHIRINA) +','+
                IntToStr(FTOR_VNESHN_DIAM) +','+ IntToStr(FTOR_VNUTR_DIAM) +','+ IntToStr(FTOR_UGOL) +','+
                '"'+DateTimeToStr(FPoteriEndDateTime)+'",'+
                '"'+DateTimeToStr(FActDate)+'",'+
                IntToStr(ConvertCheckedToZayavDelStatus)+','+
                MyFloatToStr(FOp_Protyazh)+','+MyFloatToStr(FCl_Doza)+',"'+DE_IN.Text+' '+Time2Str(FCl_Contact_Time)+'",'+
                '"'+DE_IN.Text+' '+Time2Str(FCl_Promiv_Time)+'",'+MyFloatToStr(FCl_Pressure)+','+
                QuotedStr(FUtoch_Xar_Povr)+','+
                IntToStr(FOp_Id_Diam)+','+
                IntToStr(Date2Year(DE_In.Date))+',"'+RaonChar+'",'+IntToStr(CodUser)+',"'+
                DE_In.Text+' '+Time2Str(TE_in.Time)+'",-1,NULL,'+
                FDM_Zav.Qry_Raon.FieldByName('ID').asString+','+
                FDM_Zav.Qry_Revs.FieldByName('ID').asString+','+
                FDM_Zav.qry_settlers.FieldByName('ID').AsString+','+
                inttostr(TekAlien)+','+
                FDM_Zav.Qry_Ul1.FieldByName('ID').asString+',"'; //+
                    //
                    if CB_tAdr.ItemIndex=1 then
                     begin
                       tt_str:=tt_str+FDM_Zav.Qry_Ul2.FieldByName('ID').asString+'",1,"';
                     end
                    else if CB_tAdr.ItemIndex=2 then
                     begin
                       tt_str:=tt_str+'0",2,"';
                     end
                    else
                     begin
                       tt_str:=tt_str+Strip('A','"',Ed_Ndom.Text)+'",0,"';
                     end;
                    //
                {6}try
                  tt_str:=tt_str+
                  {28.09.2004}
                  SubstKav(Ed_DopAdr.Text)+'",'+
                    //Ed_DopAdr.Text+'",'+
                  {/28.09.2004}
                  inttostr(strtointdef(FDM_Zav.Qry_Damg.FieldByName('ID').asString,-1))+','+
                  inttostr(strtointdef(FDM_Zav.Qry_comment.FieldByName('ID').asString,-1))+','+
                  FDM_Zav.Qry_Place.FieldByName('ID').asString+','+
                  inttostr(strtointdef(FDM_Zav.Qry_Mest.FieldByName('ID').asString,-1))+','+
                  DBL_MatPipe.LookupSource.DataSet.FieldByName('ID').AsString+','+
                  IntToStr(GetDiamIDFromDLCB(DBL_Diam.Visible, DBL_Diam))+','+
                  FDM_Zav.Qry_Zav.FieldByName('ID').asString+',"'+
                  '","'+'",'+
                  inttostr(strtointdef(FDM_Zav.Qry_tzav.FieldByName('ID').asString,-1))+','+
                  '-1,'+//inttostr(strtointdef(FDM_Zav.Qry_sod.FieldByName('ID').asString,-1))+','+
                  '-1,';
                  //inttostr(strtointdef(FDM_Zav.Qry_vrk.FieldByName('ID').asString,-1))+',';
                except
                  on E:Exception do ShowErr(handle,'TFormZav.BB_SaveClick :: 6',E);
                end;
                    if ChB_viezd.Checked then
                      tt_str:=tt_str+'1'
                    else
                      tt_str:=tt_str+'0';
                if ChB_Cont.Checked then
                  tt_str:=tt_str+','+FDM_Zav.Qry_Brig.FieldByName('ID').asString
                else
                  tt_str:=tt_str+',0';
                    {7}try
                      tt_str:=tt_str+','+inttostr(strtointdef(FDM_Zav.Qry_owner.FieldByName('ID').asString,-1));
                      tt_str:=tt_str+','+IntToStr(Integer(cbAttach.Items.Objects[cbAttach.ItemIndex]));
                      if DE_Poluch.Date=0 then
                        tt_str:=tt_str+',null'
                      else
                        tt_str:=tt_str+',"'+DE_Poluch.Text+' '+Time2Str(TE_Poluch.Time)+'"';
                      tt_str:=tt_str+','+IntToStr(StrToIntDef(FDM_Zav.Qry_poluch.FieldByName('ID').AsString,-1))+
                              ','+IntToStr(StrToIntDef(FDM_Zav.Qry_sdal.FieldByName('ID').asString,-1));
                      if CB_tAdr.ItemIndex=2  then
                        tt_str:=tt_str+','+FDM_Zav.qry_DopAdres.FieldByName('ID').AsString
                      else
                        tt_str:=tt_str+',-1';

                      if not FDM_Zav.qry_Object.FieldByName( 'id' ).IsNull then
                        tt_str := tt_str + ',' + FDM_Zav.qry_Object.FieldByName( 'id' ).AsString
                      else
                        tt_str := tt_str + ',null';

                       // здесь добавим координаты в секундах by Vadim 09.02.2009
                      tt_str := tt_str + ',' + myfloattostr(F_NSec) + ',' + myfloattostr(F_ESec);

                      // здесь будет галка "отложенные" by Vadim 16.02.2009
                      tt_str := tt_str + ',' + tt_otl;

                      if (FDM_Zav.qry_Soorug.Active) and (not FDM_Zav.qry_Soorug.FieldByName( 'id' ).IsNull) then
                        tt_str := tt_str + ',' + FDM_Zav.qry_Soorug.FieldByName( 'id' ).AsString
                      else
                        tt_str := tt_str + ',null';

                      tt_str:=tt_str+', '+ inttostr(strtointdef(FDM_Zav.Qry_podpor.FieldByName('ID').asString,-1));
                      tt_str:=tt_str+')';

                    except
                      on E:Exception do ShowErr(handle,'TFormZav.BB_SaveClick :: 7',E);
                    end;
                  MyExecSQL(FDM_Zav.Qry_zajav,tt_str);
                      tt_str:='select id,nomer from nzavjav where (delz=0) and id=('+ //select max(nomer) from nzavjav)
                      'select max(id) from nzavjav where (delz=0) and id_disin='+IntToStr(CodUser)+
                              ' and dt_in="'+DE_In.Text+' '+Time2Str(TE_in.Time)+'") order by 1 desc';
                  MyOpenSQL(FDM_Zav.Qry_zajav,tt_str);
                id_zav:=FDM_Zav.Qry_zajav.FieldByName('NOMER').asString;
                id_cod:=FDM_Zav.Qry_zajav.FieldByName('ID').asInteger;
                FDM_Zav.Qry_zajav.Close;
                MyExecSQL(FDM_Zav.Qry_zajav,'COMMIT');
              /////////////////
  {
              if id_zav<>Lb_Nzav.caption
              then MessageDlg(TrLangMSG(msgZajavSetNom)+id_zav,mtInformation,[mbOk],0);
  }
              {8}try
                FormMode:=tfmZayavAfterInsert;
                ZavCode:=id_cod;
                //
                if FWasLoadState then
                  begin
                    FWasLoadState:=FALSE;
                 //   CurrentStack.LoadPervViezd(ZavCode);// в любом случае не копируем выезд
                    FNNarCount:=FDM_Zav.NNarCount(ZavCode);
                    FNWWATER:=FDM_Zav.NWWATERCount(ZavCode);
                  end;
              except
                on E:Exception do ShowErr(handle,'TFormZav.BB_SaveClick :: 8',E);
              end;
              //
              {9}try
                Text2Zav;
              except
                on E:Exception do ShowErr(handle,'TFormZav.BB_SaveClick :: 9',E);
              end;
              {10}try
                UpdateZav;
              except
                on E:Exception do ShowErr(handle,'TFormZav.BB_SaveClick :: 10',E);
              end;
            except
              on E:Exception do ShowErr(handle,'TFormZav.BB_SaveClick :: 5',E);
            end;
           end
          else
           begin
             {11}try
                 if Trim(Lb_Nzav.Caption)='' then
                   FDM_Zav.ProvNewYear;
                 tt_str:='update nzavjav set ';

                tt_str:=tt_str+
                'XAR_MESTA_POVR=' + IntToStr(FXAR_MESTA_POVR) +', '+
                'SVISCH_DIAM=' + IntToStr(FSVISCH_DIAM) +','+
                'TRESCH_DLINA=' + IntToStr(FTRESCH_DLINA) +','+
                'TRESCH_SHIRINA=' + IntToStr(FTRESCH_SHIRINA) +','+
                'TOR_VNESHN_DIAM=' + IntToStr(FTOR_VNESHN_DIAM) +','+
                'TOR_VNUTR_DIAM=' + IntToStr(FTOR_VNUTR_DIAM) +','+
                'TOR_UGOL=' + IntToStr(FTOR_UGOL) +','+
                'PoteriEndDateTime="'+DateTimeToStr(FPoteriEndDateTime)+'"'+
                ',ACTDATE="'+DateTimeToStr(FActDate)+'"'+
                ',DELZ='+IntToStr(ConvertCheckedToZayavDelStatus)+
                ',dt_in="'+DE_in.Text+' '+Time2Str(TE_in.Time)+'"'+
                ',Op_Protyazh='+MyFloatToStr(FOp_Protyazh)+
                ',Cl_Doza='+MyFloatToStr(FCl_Doza)+
                ',Cl_Contact_Time="'+DE_in.Text+' '+Time2Str(FCl_Contact_Time)+'"'+
                ',Cl_Promiv_Time="'+DE_in.Text+' '+Time2Str(FCl_Promiv_Time)+'"'+
                ',Cl_Pressure='+MyFloatToStr(FCl_Pressure)+
               { ',Utoch_Xar_Povr='+QuotedStr(FUtoch_Xar_Povr)+}
                ',Op_Id_Diam='+IntToStr(FOp_Id_Diam)+
                ',fyear='+IntToStr(Date2Year(DE_In.Date))+
                //',dt_out="'+DE_out.Text+' '+Time2Str(TE_out.Time)+'"'+
                ',dt_out="'+IsDateTimeCorrect(DE_out.Text+' '+Time2Str(TE_out.Time), DE_in.Text+' '+Time2Str(TE_in.Time))+'"'+
                ',id_rayon='+FDM_Zav.Qry_Raon.FieldByName('ID').asString+
                ',id_revs='+FDM_Zav.Qry_Revs.FieldByName('ID').asString+
                ',id_settler= '+FDM_Zav.qry_settlers.fieldByName('ID').AsString+
                ',id_attach='+IntToStr(Integer(cbAttach.Items.Objects[cbAttach.ItemIndex]))+
                ',alien='+inttostr(TekAlien)+
                ',id_damg='+inttostr(strtointdef(FDM_Zav.Qry_Damg.FieldByName('ID').asString,-1))+
                ',id_place='+FDM_Zav.Qry_Place.FieldByName('ID').asString+
                ',id_matpipe='+FDM_Zav.s_matpipe.FieldByName('ID').asString+
                ', pressure='+ReplaceStr(MyFloatToStr(sePress_Value),',','.')+
                ',square='+ReplaceStr(MyFloatToStr(seSquareLeak_Value),',','.')+
                ',q='+ReplaceStr(MyFloatToStr(seSpeedLeak_Value),',','.')+
                ',glz='+ReplaceStr(MyFloatToStr(seGLZ_Value),',','.')+
                ',id_comment='+FDM_Zav.Qry_comment.FieldByName('ID').asString+
                ', id_mest='+inttostr(strtointdef(FDM_Zav.Qry_Mest.FieldByName('ID').asString,-1))+

                ', id_diam='+IntToStr(GetDiamIDFromDLCB(DBL_Diam.Visible, DBL_Diam))+

                ', id_zav='+FDM_Zav.Qry_Zav.FieldByName('ID').asString+
                {01.10.2004}

                ', id_tzav='+inttostr(strtointdef(FDM_Zav.Qry_tzav.FieldByName('ID').asString,-1))+
                {/01.10.2004}
                ', id_sod=-1'+//+inttostr(strtointdef(FDM_Zav.Qry_sod.FieldByName('ID').asString,-1))+
                ', id_vrk='+inttostr(strtointdef(FDM_Zav.Qry_vrk.FieldByName('ID').asString,-1))+
                ', id_alien='+inttostr(strtointdef(FDM_Zav.Qry_owner.FieldByName('ID').asString,-1))+' '+
               ',id_ul1='+FDM_Zav.Qry_Ul1.FieldByName('ID').asString+',';
            except
              on E:Exception do ShowErr(handle,'TFormZav.BB_SaveClick :: 11',E);
            end;
            //
            if CB_tAdr.ItemIndex=1 then
             begin
               tt_str:=tt_str+'id_ul2="'+FDM_Zav.Qry_Ul2.FieldByName('ID').asString+'",kod_ul=1,';
             end
            else if CB_tAdr.ItemIndex=2 then
             begin
               tt_str:=tt_str+'id_ul2="0",kod_ul=2,';
             end
            else
             begin
               tt_str:=tt_str+'id_ul2="'+Strip('A','"',Ed_Ndom.Text)+'",kod_ul=0,';
             end; //!!16.2012
             //
            if ChB_Cont.Checked then
              tt_str:=tt_str+'cont='+FDM_Zav.Qry_Brig.FieldByName('ID').asString+','
            else
              tt_str:=tt_str+'cont=0,';

            if ChB_viezd.Checked then
              tt_str:=tt_str+'is_go=1,'
            else
              tt_str:=tt_str+'is_go=0,';

            if DE_Poluch.Date=0 then
              tt_str:=tt_str+'DT_Poluch=null,'
            else
              tt_str:=tt_str+'DT_Poluch="'+DE_Poluch.Text+' '+Time2Str(TE_Poluch.Time)+'",';
            tt_str:=tt_str+'ID_BrPoluch='+FDM_Zav.Qry_poluch.FieldByName('ID').AsString+
                    ',ID_BrSdal='+FDM_Zav.Qry_sdal.FieldByName('ID').AsString+',';
            if CB_tAdr.ItemIndex=2 then
              tt_str:=tt_str+'id_DopAdres='+FDM_Zav.qry_DopAdres.FieldByName('ID').AsString
            else
              tt_str:=tt_str+'id_DopAdres=-1';


            if not FDM_Zav.qry_Object.FieldByName( 'id' ).IsNull then
              tt_str := tt_str + ',id_object=' + FDM_Zav.qry_Object.FieldByName( 'id' ).AsString
            else
              tt_str := tt_str + ',id_object=null';

            // здесь добавим координаты в секундах (уже не в секундах, а в футах и дюймах) by Vadim 09.02.2009
//            tt_str := tt_str  + ', NSEC=' + myfloattostr(F_NSec) + ', ESEC=' + myfloattostr(F_ESec);
            tt_str := tt_str  + ', XFEET=' + myfloattostr(F_NSec) + ', YFEET=' + myfloattostr(F_ESec);
            tt_str := tt_str  + ', IS_OTL=' + tt_otl;

            if (FDM_Zav.qry_Soorug.Active) and (not FDM_Zav.qry_Soorug.FieldByName( 'id' ).IsNull) then
              tt_str := tt_str + ',id_soorug=' + FDM_Zav.qry_Soorug.FieldByName( 'id' ).AsString
            else
              tt_str := tt_str + ',id_soorug=null';

    {Podpor}

            tt_str:=tt_str+',id_podpor='+ inttostr(strtointdef(FDM_Zav.Qry_podpor.FieldByName('ID').asString,-1));

            tt_str:=tt_str+' where id='+inttostr(ZavCode);

            MyExecSQL(FDM_Zav.Qry_zajav,tt_str);
            {12}try
              Text2Zav;
            except
              on E:Exception do ShowErr(handle,'TFormZav.BB_SaveClick :: 12',E);
            end;
            MyExecSQL(FDM_Zav.Qry_zajav,'COMMIT');
            {13}try
              CheckAddrChange; // стукачек
              UpdateZav;
            except
              on E:Exception do ShowErr(handle,'TFormZav.BB_SaveClick :: 13',E);
            end;
           end;
        {14}try
          isSave(tcsNoChanged);
        except
          on E:Exception do ShowErr(handle,'TFormZav.BB_SaveClick :: 14',E);
        end;
       {15}try
          isZavClose;
        except
          on E:Exception do ShowErr(handle,'TFormZav.BB_SaveClick :: 15',E);
        end;
    end;
    //
    if not((not (rsZAV in RightsSet))) and (FDM_Zav.Qry_owner.FieldByName('OWNER_TYPE').asInteger<>3{id=4 - предварительные})
      then BB_Narad.Enabled:=true;
  except
    on E:Exception do ShowErr(handle,'TFormZav.BB_SaveClick :: 1',E);
  end;
end;

procedure TFormZav.UpdateZav;
var oldAV:boolean;
begin
  {1}try
    FUpdateZavFlag:=TRUE;
    try
      FLockChangeNotify:=TRUE;
      oldAV:=isAutoVvod;
      isAutoVvod:=false;
      Lb_DisIn.Caption:=trim(NameUser)+' ';
      Lb_DisOut.Caption:='';
      Lb_stat.Caption:=TrLangMSG(msgNewM)+' наряд';
      {что-то с чужими связано, похоже...}
      isToRevs:=true;
      //
        FindIDZavInTabl;
        SetCaptionStatusCloseOrNoOfZayav;
        SetCaptionAttach;
        SetCaptionDTInAndNZavAndBrigInAndOwner;
        SetCaptionDisOutNameUser;
        EnabledControlsDependsFromOwner;
        ShowAlienInfo;
        ShowBrigOnControl;
        ShowRevsRaonUlic;
        ShowDopInf;
        SetCaptionDamgAndInfo;
        SetCaptionZayavitelInfo;
        SetCaptionViezdZadvRaskopNarad;
        SetCaptionSdalPoluchInfo;
        DisplayValuesFromDB;
        ExportInfoToPoteriForm;

        //  !!!!! тут надо добавить заполнение координат из базы by Vadim
       // F_NSec := FDM_Zav.Qry_zajav.FieldByName('nsec').AsFloat;
       // F_ESec := FDM_Zav.Qry_zajav.FieldByName('esec').AsFloat;
        F_NSec := FDM_Zav.Qry_zajav.FieldByName('xfeet').AsFloat;
        F_ESec := FDM_Zav.Qry_zajav.FieldByName('yfeet').AsFloat;
        if FDM_Zav.Qry_zajav.FieldByName('is_otl').AsInteger  = 1 then
          cb_otl.Checked := true
          else cb_otl.Checked := false;

        //P_Coord_Fill;  - это пошло лесом тоже
        D_Coord_Fill;
        FDM_Zav.Qry_zajav.Close;
        isAutoVvod:=oldAV;



      isVvod(true); {раздизейблить все контролы}
    finally
      FUpdateZavFlag:=FALSE;
      FLockChangeNotify:=FALSE;
    end;
  except
    on E:Exception do ShowErr(handle,'TFormZav.UpdateZav :: 1',E);
  end;
end;

procedure TFormZav.DisplayValuesFromDB;
begin
  if FormMode=tfmZayavAfterInsert then
    begin
      DBL_BrPoluch.DisplayValue:=FDM_Zav.Qry_Poluch.FieldByName('NAME_R').AsString;
      DBL_Sdal.DisplayValue:=FDM_Zav.Qry_sdal.FieldByName('NAME_R').AsString;
      DBL_Damg.DisplayValue:=FDM_Zav.Qry_Damg.FieldByName('NAME_R').asString;
      DBL_Place.DisplayValue:=FDM_Zav.Qry_Place.FieldByName('NAME_R').asString;
      DBL_matpipe.DisplayValue:=FDM_Zav.s_matpipe.FieldByName('NAME_R').asString;
      DBL_Diam.DisplayValue:=FDM_Zav.Qry_DiamZ.FieldByName('DIAM').asString;
      DBL_Zav.DisplayValue:=FDM_Zav.Qry_Zav.FieldByName('NAME_R').asString;
      DBL_WhatMatter.DisplayValue:=FDM_Zav.Qry_comment.FieldByName('NAME_R').asString;
//      DBL_Sod.DisplayValue:=FDM_Zav.Qry_sod.FieldByName('NAME_R').asString;
      DBL_vrk.DisplayValue:=FDM_Zav.Qry_vrk.FieldByName('NAME_R').asString;
      DBL_Mest.DisplayValue:=FDM_Zav.Qry_mest.FieldByName('NAME_R').asString;
      DBL_tZav.DisplayValue:=FDM_Zav.Qry_tZav.FieldByName('NAME_R').asString;
      {if FormMode<>tfmZayavNew then
        begin}
     {     if not FDM_Zav.Qry_Sod.Locate('ID',strtointdef(FDM_Zav.Qry_zajav.FieldByName('ID_SOD').asString,-1),[]) then
                FDM_Zav.Qry_Sod.First;}
        {end;}
      //
//      DBL_Sod.DisplayValue:=FDM_Zav.Qry_Sod.FieldByName('NAME_R').asString;
      DBL_vrk.DisplayValue:=FDM_Zav.Qry_vrk.FieldByName('NAME_R').asString;
      DBL_ul1.DisplayValue:=FDM_Zav.Qry_ul1.FieldByName('NAME_R').asString;
      DBL_Raon.DisplayValue:=FDM_Zav.Qry_Raon.FieldByName('NAME_R').asString;
      DBL_Revs.DisplayValue:=FDM_Zav.Qry_Revs.FieldByName('NAME_R').asString;
      Dbl_settlers.DisplayValue:=FDM_Zav.Qry_settlers.FieldByName('NAME_S').asString;
      if not FDM_Zav.Qry_ul1.Locate('ID',FDM_Zav.Qry_zajav.FieldByName('ID_UL1').asInteger,[]) then FDM_Zav.Qry_ul1.First;
      DBL_ul1.DisplayValue:=FDM_Zav.Qry_ul1.FieldByName('NAME_R').asString;
      {Podpor}
      dbl_podpor.DisplayValue:=FDM_Zav.Qry_podpor.Fieldbyname('name').AsString;

      CB_DelZayav.Checked:=GetZayavDelStatus;
      //
      DE_Out.Enabled:=false;
      TE_Out.Enabled:=false;
      sp_intime_out.Enabled:=false;

    end;
end;

procedure TFormZav.DBL_RaonChange(Sender: TObject);
begin
 if not FLockChangeNotify then
  begin
      if not(FUpdateZavFlag) then
      begin
        isSave(tcsWasChanged);
        isZavClose;
      end;
  end;

end;

procedure TFormZav.DBL_Raon2Change(Sender: TObject);
begin
  DBL_RaonChange(Sender);
  if not  FDM_Zav.setFilterStreetByRegion() then
   MessageDlg(TrLangMSG(msgErrorSetFStreetFilter),mtError, [mbOk], 1 );
  DBL_ul1.DisplayValue:=FDM_Zav.Qry_ul1.FieldByName('NAME_R').asString;
end;


procedure TFormZav.isSave(st:TChangeStatus);
begin
 if st=tcsNoChanged then isIzm:=false else isIzm:=true;
 if st=tcsNoChanged then
  begin
    Lb_save.Font.Color:=TextCol;
    Lb_save.Caption:=TrLangMSG(msgNoChange);
  end
 else
  begin
    Lb_save.Font.Color:=ErrCol;
    Lb_save.Caption:=TrLangMSG(msgChangeNoSave);
  end;
end;

procedure TFormZav.BB_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TFormZav.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 CanClose:=true;
 if (isIzm) and (rsZAV in RightsSet) then
  begin
    if MessageDlg(AnsiUpperCase(TrLangMSG(msgChangeNoSave))+' '+TrLangMSG(msgExitWithSave),
                  mtConfirmation, [mbYes, mbNo], 0) = mrNo then
       CanClose:=false;
  end
    else
  begin
    CanClose:=not NotifyAboutFirstViezd;
  end;
end;

procedure TFormZav.BB_ClzavClick(Sender: TObject);
begin
   if BB_Save.Enabled then BB_Save.Click;
   if BB_Save.Enabled then exit;

 {  if cb_OTL.Checked then //by Vadim 26.02.2009
      begin
        MessageDlg('Заявку закрыть нельзя, так как она ОТЛОЖЕНА',mtWarning, [mbOk], 0);
        exit;
      end;
  }
   if (FDM_Zav.Qry_owner.FieldByName('ID').asInteger=4)
    then
      begin
        //'Наряд закрыть нельзя, так как его тип "НА ВЫЯСНЕНИИ"'
        MessageDlg(PChar(TrLangMSG(msgWarnDisableOrderType)),mtWarning, [mbOk], 0);
        exit;
      end;
   if trunc(DE_out.Date)+Frac(TE_out.Time)>now
   then begin
       MessageDlg(TrLangMSG(msgDataTimeGRTemp),mtError, [mbOk], 0);
       TE_out.SetFocus;
       exit;
   end;

   if trunc(DE_out.Date)+Frac(TE_out.Time)<FDM_Zav.GetMaxDateTimeViezd(ZavCode) then
    begin
      //Наряд закрыть нельзя, дата закрытия последнего выезда больше даты закрытия наряда!
        MessageDlg(TrLangMSG(msgWarnDisableCloseOrder)+' '+TrLangMSG(msgWarnByNarDate),mtWarning, [mbOk], 0);
        TE_out.SetFocus;
        exit;
    end;
    //  Закоментировано 20210607 не проверять смену
{   if not(dm_Shift.datInCurShiftRevs(FDM_Zav.Qry_Revs.FieldByName('ID').AsInteger,trunc(DE_out.Date)+Frac(TE_out.Time))) then
   begin

      MessageDlg(TrLangMSG(msgDatZavInCurShift),mtError, [mbOk], 0);
       TE_out.SetFocus;
      exit;
   end;
}
   if trunc(DE_in.Date)+Frac(TE_in.Time)>trunc(DE_out.Date)+Frac(TE_out.Time)
   then begin
       MessageDlg(TrLangMSG(msgDataTimeLTin),mtError, [mbOk], 0);
       TE_out.SetFocus;
       exit;
   end;

   if {(NNarCount>0) or} (FDM_Zav.Qry_owner.FieldByName('OWNER_TYPE').asInteger in [1{id=2,5}]) or true
      {(MessageDlg(TrLangMSG(msgZajavWithoutCloseWent)+TrLangMSG(msgCloseZajav), mtConfirmation, [mbYes,mbNo], 0)=mrYes)}
   then begin
     if FDM_Zav.NZadvCount('zadv',ZavCode)>0 then
      begin
        if MessageDlg(TrLangMSG(msgZajavWithOpenZadv),mtConfirmation, [mbYes, mbNo], 0) = mrNo then
          begin
            exit;
          end;
     end;
     if FDM_Zav.NZadvCount('raskop',ZavCode)>0 then
      begin
        if MessageDlg(TrLangMSG(msgZajavWithOpenRaskop),mtConfirmation, [mbYes, mbNo], 0) = mrNo then
          begin
            exit;
          end;
     end;

     if FDM_ZAV.NWWATERCount(ZavCode)>0 then
     begin
       if MessageDlg(TrLangMSG(msgZAjavWithoutWWater),mtConfirmation, [mbYes, mbNo], 0) = mrNo then
          begin
            exit;
          end;
     end;

     if GrB_adres.Visible and (FDM_Zav.Qry_Owner.FieldByName('OWNER_TYPE').asInteger<>3{id=4})and(FDM_Zav.Qry_DiamZ.FieldByName('ID').asInteger=-1)and DBL_diam.visible  and (FDM_Zav.Qry_owner.FieldByName('OWNER_TYPE').AsInteger in [2{id=1,6,7,8,9}]) then
      begin
        if MessageDlg(TrLangMSG(msgZajavWithoutDiam),mtConfirmation, [mbYes, mbNo], 0) = mrNo then
          begin
            exit;
          end;
     end;
     TE_Out.Enabled:=true;
     DE_Out.Enabled:=true;
     if MessageDlg(TrLangMSG(msgCloseZajav),mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        begin
           MyExecSQL(FDM_Zav.Qry_zajav,
                     'insert into zavjav select * from nzavjav where id='+
                     IntToStr(ZavCode));
           MyExecSQL(FDM_Zav.Qry_zajav,
                     'update zavjav set dt_out="'+DE_Out.Text+' '+Time2Str(TE_Out.Time)+'",id_disout='+
                     inttostr(CodUser)+' where id='+IntToStr(ZavCode));
           MyExecSQL(FDM_Zav.Qry_zajav,'delete from nzavjav where id='+IntToStr(ZavCode));
           MyExecSQL(FDM_Zav.Qry_tmp,
                     'insert into narad select * from nnarad where id_zav='+
                     IntToStr(ZavCode));
           MyExecSQL(FDM_Zav.Qry_tmp,'delete from nnarad where id_zav='+IntToStr(ZavCode));
           MyExecSQL(FDM_Zav.Qry_zajav,'commit');
           UpdateZav;
           isZavClose;
        end;
  end // if (NNarCount>0) or ChB_Alien.Checked ...
end;

procedure TFormZav.isVvod(st:boolean);
begin
 if (not (rsZAV in RightsSet)) then st:=false;
     DBL_Raon.Enabled:=st;
    // DBL_Revs.Enabled:=st;
     //
     {30.07.2004}
     {DE_in.Enabled:=st;
     TE_in.Enabled:=FormMode in [0,3]; //uo false;//ds st;}
     DE_in.Enabled:=st{TRUE};
     TE_in.Enabled:=st{TRUE};
     {/30.07.2004}
     //
     DE_Out.Enabled:=st;
     TE_Out.Enabled:=st;
     CB_tAdr.Enabled:=st;
     DBL_WhatMatter.Enabled:=st;
     DBL_Ul1.Enabled:=st;
     DBL_ul2.Enabled:=st;
     Ed_ndom.Enabled:=st;
     Ed_dopAdr.Enabled:=st;
     DBL_damg.Enabled:=st;
     DBL_place.Enabled:=st;
     DBL_matpipe.Enabled:=st;
     DBL_mest.Enabled:=st;
     DBL_diam.Enabled:=st;
     DBL_vrk.Enabled:=st;
     DBL_zav.Enabled:=st;
     Ed_dopinfORG.Enabled:=st;
     Ed_dopinfNAM.Enabled:=st;
//     Ed_dopinfACUP.Enabled:=st;
     Ed_dopinfTEL.Enabled:=st;
//     Ed_desshit.Enabled:=st;
//     Ed_dessan.Enabled:=st;
     edDop_inf.Enabled:=st or LockForDel;
     DBL_tzav.Enabled:=st;
//     DBL_sod.Enabled:=st;
//     Ed_2revs.Enabled:=st;
     ChB_viezd.Enabled:=st;
     //BB_ClZav.Enabled:=st;
     BB_Save_Enabled(st);
     DBL_owner.Enabled:=st;
     DBL_Sdal.Enabled:=st;
     DBL_BrPoluch.Enabled:=st;
     DE_Poluch.Enabled:=st;
     TE_POluch.Enabled:=st;
     ChB_Cont.Enabled:=st;
     {BB_NewZ.Enabled:=st;
     BB_CopyNew.Enabled:=st;}
//     DBL_sod.Enabled:=st;
//     DBL_clog.Enabled:=st;
//     DBL_fill.Enabled:=st;

{POdpor}
    dbl_podpor.Enabled:=st;
 {settler}
     dbl_settlers.Enabled:=st;
     cbAttach.Enabled := st and ( (Lb_Nzav.Caption = TrLangMSG(msgNewM)) or (Lb_Nzav.Caption='') );
end;

procedure TFormZav.BB_zadvClick(Sender: TObject);
var ZadvForm:TFormClZadv;
begin
 if FDM_Zav.NNarCount(ZavCode)=0 then
   MessageDlg(TrLangMSG(msgZajavWithoutWent), mtError,[mbOk], 0)
 else
   begin
    if isClosed then
      ZadvForm:=TFormClZadv.ZadvCreate(Self,0,ZavCode,0,'zadv',ZavAttach,not(rsZADV in RightsSet),FALSE)
    else
      ZadvForm:=TFormClZadv.ZadvCreate(Self,1,ZavCode,0,'zadv',ZavAttach,not(rsZADV in RightsSet),FALSE);
    ZadvForm.F_rayon:=FDM_Zav.Qry_Raon.FieldByName('id').asInteger;
    ButVis(FormZav,false);
    ZadvForm.ShowModal;
    ButVis(FormZav,true);
      if FDM_Zav.NZadvCount('zadv',ZavCode)>0 then
        begin
          BB_Zadv.Font.Color:=ErrCol;
          {30.09.2004}
            //BB_clzav_Enabled(FALSE);
            BB_clzav_Enabled(TRUE);
          {/30.09.2004}
        end
      else
        begin
          BB_Zadv.Font.Color:=TextCol;
          {30.09.2004}
            BB_clzav_Enabled(TRUE);
          {/30.09.2004}
        end;
   end;
  //uo Пропадает список???
  FDM_Zav.Qry_diamZ.close; FDM_Zav.Qry_diamZ.open;
  FDM_Zav.Qry_damg.close; FDM_Zav.Qry_damg.open;
  FDM_Zav.Qry_mest.close; FDM_Zav.Qry_mest.open;
  FDM_Zav.Qry_place.close; FDM_Zav.Qry_place.open;
  //
  IsZavClose;
end;

procedure TFormZav.BB_NaradClick(Sender: TObject);
var NarForm:TFormNarad;
  _dt1:TDateTime;
begin
  if isClosed then
    NarForm:=TFormNarad.NarCreate(Self,0,ZavCode,not(rsNARAD in RightsSet), ZavAttach)//
  else
    NarForm:=TFormNarad.NarCreate(Self,1,ZavCode,not(rsNARAD in RightsSet), ZavAttach);

  InitNarForm( NarForm );

  ButVis(FormZav,false);
  //visible:=false;
  NarForm.Caption:=NarForm.Caption+'     Наряд № '+Lb_NZav.Caption+'    '+Label13.Caption+'  '+DE_in.Text+'  '+copy(Time2Str(TE_in.DateTime),1,5);
  NarForm.ShowModal;
  if NarForm.SaveFlag then isSave(tcsWasChanged) ;
  //else
  //isSave(tcsNoChanged);
  NarForm.Free;
  //
  FNNarCount:=FDM_Zav.NNarCount(ZavCode);
  //
 // visible:=true;
  ButVis(FormZav,true);
  {
  if FDM_Zav.NNarCount(ZavCode)<0 then
      BB_Narad.Font.Color:=ErrCol
  else
      BB_Narad.Font.Color:=TextCol;
  }

  isZavClose;
  //uo Пропадает список???
  FDM_Zav.Qry_diamZ.close; FDM_Zav.Qry_diamZ.open;
  FDM_Zav.Qry_damg.close; FDM_Zav.Qry_damg.open;
  FDM_Zav.Qry_mest.close; FDM_Zav.Qry_mest.open;
  FDM_Zav.Qry_place.close; FDM_Zav.Qry_place.open;
  //
  if (BB_ClZav.Enabled) and not(isClosed) then
    begin
      _dt1:=FDM_Zav.GetMaxDateTimeViezd(ZavCode);
      if _dt1>0 then
        begin
          DE_Out.OnChange:=nil; DE_Out.Date:=_dt1; DE_Out.OnChange:=DBL_raonChange;
          TE_Out.OnChange:=nil; TE_Out.Time:=_dt1; TE_Out.OnChange:=DBL_raonChange;
        end;
    end;      
end;

procedure TFormZav.ChB_AlienClick(Sender: TObject);
begin
  {[2,5] -чужая}
  ChngAlien(FDM_Zav.Qry_owner.FieldByName('OWNER_TYPE').asInteger in [1{id=2,5}],true);
  try
    if not(FDM_Zav.Qry_owner.FieldByName('OWNER_TYPE').asInteger in [1{id=2,5}]) then
     begin
       TekAlien:=-1;
       Lb_Alien.Caption:='';
       org1_name:='';
       org1_tf:='';
       org1_fam:='';
     end;
  except
    on E:Exception do ShowErr(handle,'TFormZav.ChB_AlienClick :: 1',E);
  end;
  //
  try
    if (FDM_Zav.Qry_owner.FieldByName('OWNER_TYPE').asInteger in [1{id=2,5}]) and (TekAlien<=0) then
      begin
        try
          SpB_AlienClick(Self);
          TekAlien:=-1;
        except
          on E:Exception do ShowErr(handle,'TFormZav.ChB_AlienClick :: 2',E);
         end;
       end;
  except
    on E:Exception do ShowErr(handle,'TFormZav.ChB_AlienClick :: 3',E);
  end;
  //
  GrB_damg.Enabled:=TRUE;
  try
    case FDM_Zav.Qry_owner.FieldByName('OWNER_TYPE').asInteger of
      //своя
      2{id=1,6,7,8,9}:
        begin
          try
            HidePrior(True);
          except
            on E:Exception do ShowErr(handle,'TFormZav.ChB_AlienClick :: 4',E);
          end;
        end;  
      //чужая
      1{id=2,5}:
        begin
          try
            HidePrior(True);
          except
            on E:Exception do ShowErr(handle,'TFormZav.ChB_AlienClick :: 5',E);
          end;
        end;
      //ложная
      4{id=3}:
        begin
            try
              HidePrior(False);
            except
              on E:Exception do ShowErr(handle,'TFormZav.ChB_AlienClick :: 6',E);
            end;
              try
                BB_clzav_Enabled(TRUE);
              except
                on E:Exception do ShowErr(handle,'TFormZav.ChB_AlienClick :: 7',E);
              end;
            try
              BB_Narad_enabled(True);
            except
              on E:Exception do ShowErr(handle,'TFormZav.ChB_AlienClick :: 8',E);
            end;
        end;
      //предварительно
      3{id=4}:
        begin
          GrB_damg.Enabled:=False;
          try
            HidePrior(False);
           except
            on E:Exception do ShowErr(handle,'TFormZav.ChB_AlienClick :: 9',E);
          end;
        end;
    end;
  except on E:Exception do ShowErr(handle,'TFormZav.ChB_AlienClick :: 10',E);
  end;
  //
  try
    DBL_raonChange(Self);
  except on E:Exception do ShowErr(handle,'TFormZav.ChB_AlienClick :: 11',E);
  end;
  //
  try
  //DBL_RegionChange(Self);
    LightNeedFields;
  except on E:Exception do ShowErr(handle,'TFormZav.ChB_AlienClick :: 12',E);
  end;
end;

procedure TFormZav.SpB_AlienClick(Sender: TObject);
begin
  if Vvod_Org(Self,org1_name,org1_tf,org1_fam) then
      begin DBL_raonChange(Self); {DBL_RegionChange(Self);} end;
  Lb_Alien.Caption:=org1_name+',тф.'+org1_tf+','+org1_fam;
end;

procedure TFormZav.ZapAlien(isAl:boolean;TekAlien:integer);
begin
  if TekAlien>0 then
    begin
     MyOpenSQL(FDM_Zav.Qry_tmp,'select * from s_org where id='+inttostr(TekAlien));
     if isAl then
      begin
        org1_name:=FDM_Zav.Qry_tmp.FieldByName('NAME_R').asString;
        org1_tf:=FDM_Zav.Qry_tmp.FieldByName('TF').asString;
        org1_fam:=FDM_Zav.Qry_tmp.FieldByName('FAMIL').asString;
        Lb_Alien.Caption:=org1_name+',тф.'+org1_tf+','+org1_fam;
      end
     else
      begin
        org2_name:=FDM_Zav.Qry_tmp.FieldByName('NAME_R').asString;
        org2_tf:=FDM_Zav.Qry_tmp.FieldByName('TF').asString;
        org2_fam:=FDM_Zav.Qry_tmp.FieldByName('FAMIL').asString;
        Lb_2Alien.Caption:=org2_name+',тф.'+org2_tf+','+org2_fam;
      end;
     FDM_Zav.Qry_tmp.Close;
    end
  else
    begin
      if isAl then
        begin
         Lb_Alien.Caption:='';
         org1_name:='';
         org1_tf:='';
         org1_fam:='';
        end
      else
        begin
         Lb_2Alien.Caption:='';
         org2_name:='';
         org2_tf:='';
         org2_fam:='';
        end;

    end;
  ChngAlien(FDM_Zav.Qry_owner.FieldByName('OWNER_TYPE').asInteger in [1{id=2,5}],true);
end;

procedure TFormZav.SaveAlien(isDel:boolean;Old_nn:integer;
                             t_nm,t_tf,t_fa:string;
                             var Tek_nn:integer);
var tAl:integer;
begin
  if isDel then
   begin
     if (Tek_nn>0) or (Old_nn>0) then
      begin
       if Tek_nn>0 then
          tAl:=Tek_nn
       else
          tAl:=Old_nn;
       MyExecSQL(FDM_Zav.Qry_tmp,'delete from s_org where id='+inttostr(TAl));
       MyExecSQL(FDM_Zav.Qry_tmp,'COMMIT');
       if Tek_nn<>-1 then Tek_nn:=0;
      end;
   end
  else
    begin
      if Tek_nn>0 then
       begin
{
         MyExecSQL(Qry_tmp,'update s_org set name_r="'+t_nm+
         '",tf="'+t_tf+'",famil="'+t_Fa+
         '" where id='+inttostr(Tek_nn));
}
         MyExecSQL(FDM_Zav.Qry_tmp,'update s_org set name_r='+RxStrUtils.QuotedString(t_nm,'''')+
         ',tf='+RxStrUtils.QuotedString(t_tf,'''')+',famil='+RxStrUtils.QuotedString(t_Fa,'''')+
         ' where id='+inttostr(Tek_nn));

       end
     else
       begin
{
         MyExecSQL(Qry_tmp,'insert into s_org(name_r,tf,famil) values("'+
         t_Nm+'","'+t_tf+'","'+t_Fa+
         '")');
}
         MyExecSQL(FDM_Zav.Qry_tmp,'insert into s_org(name_r,tf,famil) values('+
         RxStrUtils.QuotedString(t_nm,'''')+','+RxStrUtils.QuotedString(t_tf,'''')+','
         +RxStrUtils.QuotedString(t_Fa,'''')+')');
         MyOpenSQL(FDM_Zav.Qry_tmp,'select GEN_ID(GEN_S_ORG,0) /*max(id)*/ mm  from s_org');
         Tek_nn:=FDM_Zav.Qry_tmp.FieldByName('MM').asInteger;
         FDM_Zav.Qry_tmp.Close;
       end;
       MyExecSQL(FDM_Zav.Qry_tmp,'COMMIT');
    end;
end;

procedure TFormZav.ChngAlien(isVis,isAl:boolean);
begin
 if isAl then
  begin
     SpB_Alien.Enabled:=isVis and (not isClosed) and (not (not (rsZAV in RightsSet)));
     SpB_Alien.Visible:=isVis;
     Lb_Alien.Enabled:=isVis;
     LB_Alien.Visible:=isVis;
     //GrB_damg.Enabled:=not(Qry_owner.FieldByName('ID').asInteger in [2,5]);
     //GrB_damg.Visible:=GrB_damg.Enabled;
     lb_Bevel.Visible:=isVis;
     SpB_Alien.Visible:=isVis;
  end;
end;

procedure TFormZav.ChB_ContClick(Sender: TObject);
begin
   if ChB_Cont.Checked then
      ChB_Cont.Font.Color:=MessCol
   else
      ChB_Cont.Font.Color:=TextCol;
   if isClosed then
      DBLC_Brig.Enabled:=false
   else
      DBLC_Brig.Enabled:=ChB_Cont.Checked;

   DBLC_Brig.Visible:=ChB_Cont.Checked;
   DBL_raonChange(Self);
   //DBL_RegionChange(Self);
end;

procedure TFormZav.SpB_RoOClick(Sender: TObject);
begin
  isToRevs:= not isToRevs;
  ZapRevs2;
  //ChngAlien(ChB_Alien.Checked,true);
  if not isToRevs then
   begin
     Lb_2Alien.Caption:='';
     org2_name:='';
     org2_tf:='';
     org2_fam:='';
   end;
  if ( not isToRevs) and (Int_to<=0) then
     begin
       SpB_2AlienClick(Self);
       //TekAlien:=-1;
     end;
  DBL_raonChange(Self);
  //DBL_RegionChange(Self);
end;

procedure TFormZav.ZapRevs2;
begin
  if isToRevs then
   begin
    LB_2Alien.Visible:=false;
//uo    DBL_Revs2.Visible:=true;
//uo    Ed_2Revs.Visible:=true;
   end
  else
   begin
//    if ReadOnly or isClosed then
//      SpB_2Alien.Enabled:=false
//    else
//      SpB_2Alien.Enabled:=true;
    LB_2Alien.Visible:=true;
   end;
end;

procedure TFormZav.SpB_2AlienClick(Sender: TObject);
begin
  if  Vvod_Org(Self,org2_name,org2_tf,org2_fam) then
    begin DBL_raonChange(Self); {DBL_RegionChange(Self);} end;
  Lb_2Alien.Caption:=org2_name+',тф.'+org2_tf+','+org2_fam;
end;

procedure TFormZav.isZavClose;
begin
  {1}try
    {2}try
      if (FDM_Zav.Qry_owner.FieldByName('OWNER_TYPE').asInteger=4{id=3}) or
        (CheckFill(true)) and ((FDM_Zav.NNarCount(ZavCode)>0)  and (FDM_Zav.NWWATERCount(ZavCode)=0)
           and (FDM_Zav.Qry_tzav.FieldByName('ISVIEZD').asInteger>=0{-1}))
        and (FDM_Zav.NZadvWithoutRemontCount(ZavCode)<=0) //(FDM_Zav.NZadvCount('zadv',ZavCode)<=0)
//        and (FDM_Zav.NZadvCount('raskop', ZavCode)<=0)
        //and (FDM_Zav.NZasipRaskopCount(ZavCode)<=0)
        then BB_clzav_Enabled(TRUE)
        else BB_clzav_Enabled(FALSE);
      except
        on E:Exception do ShowErr(handle,'TFormZav.isZavClose :: 2',E);
      end;
    DE_out.enabled:=BB_Clzav.Enabled;
    TE_out.enabled:=BB_Clzav.Enabled;

    DE_out.visible:=BB_Clzav.Enabled or isClosed;
    TE_out.visible:=BB_Clzav.Enabled or isClosed;
    sp_intime_out.visible:=TE_out.visible;
    sp_intime_out.Enabled:=TE_out.Enabled;
    label14.visible:=BB_Clzav.Enabled or isClosed;
    label16.visible:=BB_Clzav.Enabled or isClosed;
    lb_disout.visible:=BB_Clzav.Enabled or isClosed;
    BB_Save_Enabled(CheckFill(false{true})and(Lb_save.Font.Color=ErrCol));
    BShowonMap.Enabled:=(Zavcode > 0);
  except
    on E:Exception do ShowErr(handle,'TFormZav.isZavClose :: 1',E);
  end;
end;

function TFormZav.CheckFill(toClose:boolean):boolean;
var res1,_a,_b:boolean;
begin
    {1}try
      {Обязательные параметры  для своей (водпровод. Водомерн., водпров,
      на списание.): *Район, *о чем заявлено,
      *вид заявки, *адрес, *тип заявки, *характер повреждения,
      *место повреждения. Тип повреждения(в жопу его), *диаметр.
      *Местность. Закрытые выезды.}
      Result:=false;
      Res1:=false;
      if (CB_tAdr.ItemIndex=0) and (trim(Ed_Ndom.Text)<>'') then
        _b:=TRUE else _b:=FALSE;
      if (CB_tAdr.ItemIndex=1) then
          _a:=(FDM_Zav.Qry_ul2.FieldByName('ID').asInteger>0) else _a:=FALSE;
       if (not isClosed) and (not (not (rsZAV in RightsSet))) and
         (Strip('A','. ',DE_in.Text)<>'') and
         (TE_in.Time<>0) and
         //{район}(FDM_Zav.Qry_raon.FieldByName('ID').asInteger>0) and
          {цех} (FDM_Zav.Qry_revs.FieldByName('ID').asInteger>0) and
          {улица}(
           ((FDM_Zav.Qry_ul1.FieldByName('ID').asInteger>0) and (CB_tAdr.ItemIndex=0) and _b) or
           ((FDM_Zav.Qry_ul1.FieldByName('ID').asInteger>0) and
              _a and (CB_tAdr.ItemIndex=1)) or
            (CB_tAdr.ItemIndex=2)
           )
           and
         {вид заявки}(FDM_Zav.Qry_owner.FieldByName('ID').asInteger>0) and
         {о чем заявлено}(FDM_Zav.Qry_comment.FieldByName('ID').asInteger>0)
          then begin
             if (FDM_Zav.Qry_owner.FieldByName('OWNER_TYPE').asInteger=3{id=4}) {если "на выяснении"}
             then Res1:=(true)
             else Res1:=(false or (ZavCode>0)) and ((FNNarCount<>0) or
              ((FDM_Zav.Qry_owner.FieldByName('OWNER_TYPE').asInteger=4{id=3 - ложные}))) or
              (Lb_Nzav.Caption='Новый');
             if (not(Res1){ and (BB_Narad.Font.Color<>ErrCol)  })then
             begin
                BB_Narad.Font.Color:=clGreen
             end else
             begin
                if {FDM_Zav.NNarCount(ZavCode)<0} FNNarCount<0 then BB_Narad.Font.Color:=ErrCol
                else BB_Narad.Font.Color:=TextCol;
                
             end;
          end;

      if (not isClosed) and toClose and res1 and not(FDM_Zav.Qry_owner.FieldByName('OWNER_TYPE').asInteger in [1{id=2,5}]) then
        begin
        if {(not isIzm)and}
          ((Strip('A','. ',DE_out.Text)<>'') and (TE_out.Time<>0) and (DE_out.Visible))
            or not(DE_out.Visible)
           then begin
             case FDM_Zav.Qry_owner.FieldByName('OWNER_TYPE').asInteger of
               3{id=4}:Result:=false{true};
               4{id=3}:Result:=true;
               2,1{1,6,7,8,2,5,9}:begin
                     if {все завяки закрыты}{(NNarCount()>=0) and}
                        {местность} (FDM_Zav.Qry_mest.FieldByName('ID').asInteger>0) and
                        {тип заявки}(FDM_Zav.Qry_tzav.FieldByName('ID').asInteger>0) and
                       // {характер повреждения}(FDM_Zav.Qry_sod.FieldByName('ID').asInteger>0) and
                        {место повреждения}(FDM_Zav.Qry_place.FieldByName('ID').asInteger>0)
                        {материал трубы} //(FDM_Zav.s_matpipe.FieldByName('ID').AsInteger>0) and
                        {диаметр} //(FDM_Zav.Qry_diamZ.FieldByName('ID').AsInteger>0)
                     then Result:=true
                     else Result:=false;
                   end
             end;
          end
        end
      else
        Result:=res1;
  except
    on E:Exception do ShowErr(handle,'TFormZav.CheckFill :: 1',E);
  end;
end;

procedure TFormZav.ChB_viezdClick(Sender: TObject);
begin
  if (not ChB_viezd.Checked) and (FDM_Zav.NNarCount(ZavCode)>0) then
    begin
      ChB_viezd.Checked:=true;
    end;
  BB_Narad.Enabled:=ChB_viezd.Checked;
  DBL_raonChange(Self);
end;

procedure TFormZav.DBL_ul1Change(Sender: TObject);
begin
  if FormMode=tfmZayavNew then
    Ed_dopAdr.Text:=FDM_Zav.Qry_ul1.FieldByName('ORINT').asString;
  DBL_raonChange(Self);

  if not FDM_Zav.ConfirmStreet(DBL_ul1.DisplayValue) then
     DBL_ul1.DisplayValue:='';
end;

procedure TFormZav.BB_RasClick(Sender: TObject);
var
  ZadvForm:TFormClZadv;

  _Raskop: Tdm_NGRaskop;
  _frm: Tfrm_Raskop;
begin
  if FDM_Zav.NNarCount( ZavCode ) = 0 then
    MessageDlg( TrLangMSG( msgZajavWithoutWent ), mtError, [mbOk], 0)
  else
  begin
    _Raskop := Tdm_NGRaskop.Create( nil );
    try
      _Raskop.ZavID := ZavCode;
      _Raskop.ZavNum := lb_nzav.Caption;
      _Raskop.ZavDT_IN := DE_in.Text;
      _Raskop.RaskopEditMode := remEditAll;
      _Raskop.IsReadOnly := not( rsRASK in RightsSet );
      _Raskop.CloseZavDateTime:=frac(DE_Out.Date)+trunc(TE_out.Time);

      _frm := Tfrm_Raskop.Create( nil, _Raskop, isClosed, ZavAttach );
      try
        _frm.MestTypeID := GetMestTypeID;
        _frm.ShowModal;
      finally
        _frm.Free;
      end;
    finally
      _Raskop.Free;
    end;

    if FDM_Zav.NZadvCount( 'raskop',ZavCode ) > 0 then
      BB_Ras.Font.Color := ErrCol
    else
      BB_Ras.Font.Color := TextCol;
  end;
  IsZavClose;





(*
 if FDM_Zav.NNarCount(ZavCode)=0 then
   MessageDlg(TrLangMSG(msgZajavWithoutWent), mtError,[mbOk], 0)
 else
   begin
    //
    if isClosed then
      ZadvForm:=TFormClZadv.ZadvCreate(Self,0,ZavCode,0,'raskop',ZavAttach,
        not(rsRASK in RightsSet),
        DBL_Mest.LookupSource.DataSet.FieldByName('VOSST_POKRYT').AsString='ВОССТ.')
    else
      ZadvForm:=TFormClZadv.ZadvCreate(Self,1,ZavCode,0,'raskop',ZavAttach,
        not(rsRASK in RightsSet),
        DBL_Mest.LookupSource.DataSet.FieldByName('VOSST_POKRYT').AsString='ВОССТ.');
    //ZadvForm.OperAtt := ZavAttach;
    //ZadvForm.MestTypeID := GetMestTypeID;

    ButVis(FormZav,false);
    ZadvForm.ShowModal;
    ButVis(FormZav,true);
      if FDM_Zav.NZadvCount('raskop',ZavCode)>0 then
        BB_Ras.Font.Color:=ErrCol
      else
        BB_Ras.Font.Color:=TextCol;
   end;
  //uo Пропадает список???
  FDM_Zav.Qry_diamZ.close; FDM_Zav.Qry_diamZ.open;
  FDM_Zav.Qry_damg.close; FDM_Zav.Qry_damg.open;
  FDM_Zav.Qry_mest.close; FDM_Zav.Qry_mest.open;
  FDM_Zav.Qry_place.close; FDM_Zav.Qry_place.open;
  //
  IsZavClose;
*)
end;

{procedure TFormZav.UpdateSod;
var s,s1, s2:string;
begin
 case ZavAttach of
  toaVoda,toaObjVoda:s2:=' and ZAYAVL = 1 ';
  toaKanal,toaObjKanal: s2:= 'and ZAYAVL = 2 ';
 end;
 s:=FDM_Zav.Qry_tzav.FieldByName('ID').asString;
 s1:=FDM_Zav.Qry_place.FieldByName('ID').asString;
 if (s<>'') then begin if s<>'-1' then s:=' and (ftype='+s+') ' else s:=''; end;
 if (s1<>'') then begin if s1<>'-1' then s1:=' and (place_type='+s1+') ' else s1:=''; end;
 MyOpenSQL(FDM_Zav.Qry_sod,'select id,name_r, diampresent from s_sod'+
 ' where (del in (''-'',''d'')) and ((id=-1) or ((id>-1) '+
 s+s1+s2+')) '+' order by name_r');
 if FltDel and not FormMain.DictNotHide.checked
 then SetFilterDelete(FDM_Zav.Qry_sod,true)
end;
}
procedure TFormZav.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var n:string;
begin
  case Key of
   VK_DOWN:begin
      if FormZav.Components[FormZav.ActiveControl.ComponentIndex].ClassName='TRxDBLookupCombo' then
        begin
         if TRxDBLookupCombo(FormZav.Components[FormZav.ActiveControl.ComponentIndex]).LookupSource.DataSet.FieldByName('ID').asInteger=-1 then
          begin
            if TRxDBLookupCombo(FormZav.Components[FormZav.ActiveControl.ComponentIndex])=DBL_Diam
            then n:='diam'
            else n:='name_r';
            TRxDBLookupCombo(FormZav.Components[FormZav.ActiveControl.ComponentIndex]).LookupSource.DataSet.Next;
            TRxDBLookupCombo(FormZav.Components[FormZav.ActiveControl.ComponentIndex]).DisplayValue:=TRxDBLookupCombo(FormZav.Components[FormZav.ActiveControl.ComponentIndex]).LookupSource.DataSet.FieldByName(n).asString;
          end;
        end;
   end;
   vk_F2:begin
     {FormMain.DictNotHide.checked:=true;
     SetFilterDelete(Qry_raon,false);
     SetFilterDelete(Qry_owner,false);
     SetFilterDelete(Qry_Brig,false);
     SetFilterDelete(Qry_ul1,false);
     SetFilterDelete(Qry_ul2,false);
     SetFilterDelete(Qry_zav,false);
     SetFilterDelete(Qry_comment,false);
     SetFilterDelete(Qry_tzav,false);
     SetFilterDelete(Qry_place,false);
     SetFilterDelete(Qry_damg,false);
     SetFilterDelete(Qry_mest,false);
     SetFilterDelete(Qry_sod,false);
     SetFilterDelete(Qry_DiamZ,false);
     UpdateZav;}
   end;
  end;
end;

procedure TFormZav.DBL_tzavChange(Sender: TObject);
begin
  // UpdateSod;
   DBL_raonChange(Self);
end;

procedure TFormZav.BB_PrintClick(Sender: TObject);
begin
  //OldPrint;
  //NewPrint;
  bbPrintOrdClick(nil);
end;

procedure TFormZav.BB_NewZClick(Sender: TObject);
begin
  SmartPopup(NewZav,BB_NewZ);
end;

procedure TFormZav.BB_CopyNewClick(Sender: TObject);
begin
  SmartPopup(CopyToNew,BB_CopyNew);
end;

procedure TFormZav.DBL_RaonKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    SelectNext(Sender as TWinControl, True, True );
    Key := #0;
  end;
end;

procedure TFormZav.N1Click(Sender: TObject);
begin
  isInExcel:=false;
  ViewButPr;
end;

procedure TFormZav.Excel1Click(Sender: TObject);
begin
  isInExcel:=true;
  ViewButPr;
end;

procedure TFormZav.ViewButPr;
begin
  BB_Print.Enabled:=not isInExcel;
  BB_Print.Visible:=not isInExcel;
  BB_Excel.Enabled:=isInExcel;
  BB_Excel.Visible:=isInExcel;
end;


procedure TFormZav.MyProsmClose(Sender: TObject; var Action: TCloseAction);
begin
  FormDestroy(FormZav);
  PrF2.FormClose(Sender,Action);
end;


procedure TFormZav.FormDestroy(Sender: TObject);
begin
  if not VarIsEmpty(XLApp) then begin
    XLApp.DisplayAlerts := False;  // Discard unsaved files....
    XLApp.Quit;
    XLApp:=UnAssigned;
  end;

end;

function TFormZav.PrepareDopInfBeforeSave:string;
begin
  result:=edDop_inf.text;
  {edDop_inf.OnChange:=nil;
 if (FormMode<>tfmZayavNew) and (OldFirstLine<>edDop_inf.text) then
   begin}
{    edDop_inf.text:=OldFirstLine;
    if MM_dopinf.SelStart<=length(MM_dopinf.Lines.Strings[0])+1 then
       begin
         MM_dopinf.Lines.Add('');
         MM_dopinf.SelStart:=length(MM_dopinf.Lines.Strings[0])+2;
       end;
}   {end
 else
   begin
    if isSel then
       isSel:=false
    else
       ChangInEdit(TCustomEdit(edDop_inf),100);
   end;
 edDop_inf.OnChange:=Mmm_dopinfChange;}
// InsertInSL(result,SL_DopInf,100);
end;

procedure TFormZav.Mmm_dopinfChange(Sender: TObject);
begin
  edDop_inf.OnChange:=nil;
  if (FDopInfCaretPos.Y=0) and (edDop_inf.Lines.Count>0) and (CB_DelZayav.Checked) then
  begin
    edDop_inf.Lines[0]:=FLastFirstStrOfDopInf;
  end;
 edDop_inf.OnChange:=Mmm_dopinfChange;
 //
 DBL_raonChange(Self);
 //DBL_RegionChange(Self);
end;

procedure TFormZav.Text2Zav;
var tt:longword;
begin
  tt:=0;
  if isTest then
    tt:=GetTickCount;
  MyOpenSQL(FDM_Zav.Qry_tmp2,'select * from nzavjav where id='+inttostr(ZavCode));
  FDM_Zav.Qry_tmp2.Edit;
 FDM_Zav.Qry_tmp2.FieldByName('DOP_ADR').asString:=Ed_DopAdr.Text;
  FDM_Zav.Qry_tmp2.FieldByName('DOP_ZAV').asString:=Ed_DopInfORG.Text+' & '+Ed_DopInfNAM.Text+' & '+Ed_DopInfTEL.Text;
  FDM_Zav.Qry_tmp2.FieldByName('DOP_INF').asString:=edDop_inf.Text;
  FDM_Zav.Qry_tmp2.Post;
  if FDM_Zav.Qry_tmp2.UpdatesPending then
    begin
     FDM_Zav.Qry_tmp2.ApplyUpdates;
     FDM_Zav.Qry_tmp2.CommitUpdates;
    end;
  FDM_Zav.Qry_tmp2.Close;
  if isTest then
    FormMain.RGAppError.SaveErrString('Saving texts to zav..'#13#10'Time: '+
     inttostr(GetTickCount-tt));
end;

procedure TFormZav.Ed_dopinfORGChange(Sender: TObject);
begin
  Ed_dopInfORG.OnChange:=NIL;
//uo  ChangInEdit(TCustomEdit(Sender),100);
  Ed_dopInfORG.OnChange:=Ed_dopinfORGChange;
  DBL_RaonChange(Self);
  //DBL_RegionChange(Self);
end;

procedure TFormZav.Ed_dopinfORGExit(Sender: TObject);
begin
 InsertInSL(TCustomEdit(Sender).text,SL_DopInf,100);
end;

procedure TFormZav.Ed_dopinfORGKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
      if (Sender.ClassName='TEdit') or (Sender.ClassName='TMemo') then
        begin
          if (Key = VK_ESCAPE) then
           begin
            AutoVvodOff(TCustomEdit(Sender));
           end
          else if (Key = VK_DELETE) then
           begin
            TCustomEdit(Sender).ClearSelection;
           end
          else if (Sender.ClassName='TMemo') and
                  (TCustomEdit(Sender).SelLength>0) then
            isSel:=true;
        end;
end;

procedure TFormZav.N2Click(Sender: TObject);
begin
  AutoVvodOn(TCustomEdit(PopAutoVvod.PopUpComponent));
end;

procedure TFormZav.N3Click(Sender: TObject);
begin
  AutoVvodOff(TCustomEdit(PopAutoVvod.PopUpComponent));
end;

procedure TFormZav.Mmm_dopinfExit(Sender: TObject);
begin
 InsertInSL(edDop_inf.text,SL_DopInf,100);
end;


//*******************************************************************
procedure TFormZav.SetDiam_Present(fl :boolean);
begin
 fl:=true; //uo
 Diam_lb.Visible:=fl;
 DBL_Diam.Visible:=fl;
 FDiam_Present:=fl;
end;

procedure TFormZav.FormShow(Sender: TObject);
var tt_Date:TDateTime;
begin
  inherited;
  top:=0;
  UpdateComents;
end;

procedure TFormZav.Ed_dopinfTELExit(Sender: TObject);
VAR tel:string;
begin
  tel:=Ed_dopinfTEL.text;
  if (length(tel)=7)and(inttostr(strtointdef(tel,-1))=tel)
  then begin
    tel:=format('т.%s-%s-%s',[copy(tel,1,3),copy(tel,4,2),copy(tel,6,2)]);
    Ed_dopinfTEL.text:=tel
  end;
  InsertInSL(TCustomEdit(Sender).text,SL_DopInf,100);
end;

//*******************************************************************
procedure TFormZav.Translate;
var s:string;
begin
  inherited;
  Label1.Caption:=TrLangMSG(msgRAYON);
  Label7.Caption:=TrLangMSG(msgZajavitelOne);
  //Label8.Caption:=TrLangMSG(msgDopInfoShort);
  Label10.Caption:=TrLangMSG(msgConfirmPerson);
  Label13.Caption:=TrLangMSG(msgVidOpenZadv);
  Label14.Caption:=TrLangMSG(msgVidCloseZadv);
  //SpB_RoO.Caption:=TrLangMSG(msgREV);
  BShowonMap.Hint:=TrLangMSG(msgTieOnMap);
  SpeedButton1.Hint:=TrLangMSG(msgShowOnMap);
  ChB_viezd.Caption:=TrLangMSG(msgWentOne);
  GrB_adres.Caption:=' '+TrLangMSG(msgAddr)+' '+ansilowercase(TrLangMSG(msgCrashes))+' ';
  GrB_damg.Caption:=' '+TrLangMSG(msgInfoAboutCrash)+' ';
  Label3.Caption:=TrLangMSG(msgFIO);
  Label5.Caption:=TrLangMSG(msgDmgPlace);

  s:=TrLangMSG(msgDiam);
  Insert(' ',s,5);
  Diam_lb.Caption:=s;
  Label4.Caption:=TrLangMSG(msgPlace);
  BB_Save.Hint:=TrLangMSG(msgSaveChangedInfo);
  BB_Save.Caption:='&'+TrLangMSG(msgSave);
  BB_Exit.Hint:=TrLangMSG(msgCloseWindow);
  BB_Exit.Caption:='&'+TrLangMSG(msgExit);
  BB_zadv.Hint:=TrLangMSG(msgCloseZadv);
  BB_zadv.Caption:='&'+TrLangMSG(msgZadvs);
  BB_Narad.Hint:=TrLangMSG(msgWent)+'наряда';
  BB_Narad.Caption:=TrLangMSG(msgWent); {'В&ыезды'}
  BB_Ras.Hint:=TrLangMSG(msgDigWorks
  );
  BB_Ras.Caption:='&'+TrLangMSG(msgDigWorks);
  BB_Clzav.Hint:=ansilowercase(TrLangMSG(msgClose))+' наряд';
  BB_Clzav.Caption:=TrLangMSG(msgClose);{ 'З&акрыть'}
  BB_Print.Hint:=TrLangMSG(msgPrint)+' наряда';
  BB_Excel.Hint:=TrLangMSG(msgPrint)+' в Excel';
  BB_NewZ.Hint:=TrLangMSG(msgNewM)+' наряд';
  BB_CopyNew.Hint:=TrLangMSG(msgCopyZajav);
  BB_Poteri.Caption:=TrLangMSG(msgLosses);
  btn_linkOtlZav.Caption:=TrLangMSG(msgConnectToDeferred);
  BB_WithoutWater.Caption:=TrLangMSG(msgWithoutWater);
  BB_Image.Caption:=TrLangMSG(msgImage);
  cb_OTL.Caption:=TrLangMSG(msgOtl);
  Lb_save.Caption:=TrLangMSG(msgNoChange);
  N1.Caption:=TrLangMSG(msgPrint)+' на принтер';
  Excel1.Caption:=TrLangMSG(msgPrint)+' в Excel';
  N2.Caption:=TrLangMSG(msgAutoVVod)+' '+TrLangMSG(msgON);
  N3.Caption:=TrLangMSG(msgAutoVVod)+' '+TrLangMSG(msgOFF);
  //CBAlien.caption:=TrLangMSG(msgAlien)+' заявка';
  Label2.Caption:=TrLangMSG(msgPrinad);
  Label19.Caption:=TrLangMSG(msgPlace)+' '+lower(TrLangMSG(msgCrashes));
  Label6.Caption:=TrLangMSG(msgMaterOne)+' '+TrLangMSG(msgTrubi);
  //Label26.Caption:=TrLangMSG(msgContext);
  Label17.Caption:=TrLangMSG(msgREV);
  Label18.Caption:=TrLangMSG(msgTypeFillOne);
  Label20.Caption:=TrLangMSG(msgDopInfo);
  //Label21.Caption:=TrLangMSG(msgPlaceSAN);
  Label22.Caption:=TrLangMSG(msgSurname);
  //Label24.Caption:=TrLangMSG(msgAccup);
  Label3.Caption:=TrLangMSG(msgDesign);
  Ed_dopAdr.hint:=TrLangMSG(msgDopInfo);
  Label27.Caption:=TrLangMSG(msgTypeCrash);
  CB_DelZayav.Caption:=TrLangMSG(msgToDel);
  Label_settler.Caption:=TrLangMSG(msgSetlers);
  Label28.Caption:=TrLangMSG(msgAbout);
  Label25.Caption:=TrLangMSG(msgOrdertype);
  ChB_Cont.Caption:=  TrLangMSG(msgCbIsControl);
  Lb_NmUl.Caption:=TrLangMSG(msgStreet);
  Lb_Ndom.Caption:=TrLangMSG(msgNumDom);
  Label11.Caption:=TrLangMSG(msgGetFromDisp);
  Label9.Caption:=TrLangMSG(msgOrdertyptype);
  RxLabel1.Caption:= TrLangMSG(msgCordinates);
  Ed_dopinfNAM.hint:=TrLangMSG(msgSurname)+' '+TrLangMSG(msgAccup);
//  DBL_sod.Hint:=TrLangMSG(msgOrderContenr);
  Lb_Nomer.Caption:=TrLangMSG(msgOrdersNumber);
  Label10.Caption:=TrLangMSG(msgConfirmBrig);

  N4.Caption:=TrLangMSG(msgWaterPipe);
  N5.Caption:=TrLangMSG(msgSeverage);




end;

{задизейблить/раздизейблить низ формы}
procedure TFormZav.HidePrior(st:boolean);
var _st:boolean;
begin
  BB_NewZ.Enabled:=(rsZAV in RightsSet);// not(ReadOnly);
  BB_CopyNew.Enabled:=(rsZAV in RightsSet);
  if (not IsClosed) then
    begin
      _st:=st and (rsZAV in RightsSet);
      DBL_damg.enabled:=_st;
      DBL_place.enabled:=_st;
      DBL_matpipe.enabled:=_st;
      DBL_diam.enabled:=_st;
      DBL_Mest.Enabled:=_st;


      {seSpeedLeak.enabled:=st;
      seSquareLeak.enabled:=st;
      sePress.enabled:=st;
      seGLZ.enabled:=st;}
      BB_Poteri.enabled:=st;

      BB_Narad_enabled(st);
      BB_zadv.enabled:=st;
      BB_ras.enabled:=st;
      BB_Image.Enabled:=st;
      BB_WithoutWater.Enabled:=st;
      BB_clzav_Enabled(_st);

//      DBL_sod.enabled:=_st;
      DBL_vrk.Enabled:=_st;
      DBL_tzav.enabled:=_st;

      btn_linkOtlZav.Enabled:=_st;
  end;
end;


procedure TFormZav.cbAttachChange(Sender: TObject);
begin
  ZavAttach := TOperAtt( Integer( cbAttach.Items.Objects[ cbAttach.ItemIndex ] ) );
  DBL_raonChange( Sender );
  UpdateComents;
end;

procedure TFormZav.NewZav(Sender: TObject);
begin
  if not (Sender is TmenuItem) then exit;
  if isIzm then
     BB_SaveClick(Self);
  CloseStatus:=1;
  BB_ExitClick(Self);
end;

procedure TFormZav.CopyToNew(Sender: TObject);
begin
  if not (Sender is TmenuItem) then exit;

  FormMain.OperAtt := TOperAtt( (Sender as TMenuItem).Tag );

  if Lb_Nzav.Font.Color=ErrCol // новая заявка
  then begin
    BB_CopyNew.enabled:=false;
    exit;
  end;
  if isIzm then
    BB_SaveClick(Self);
  CloseStatus:=2;
  ZavToCopy:=ZavCode;
  BB_ExitClick(Self);
end;

{30.09.2004}
procedure TFormZav.BB_clzav_Enabled(value:boolean);
begin
  if
    (FDM_Zav.Qry_owner.FieldByName('OWNER_TYPE').asInteger in [4,1])
    and (FormMode<>tfmZayavCopy) and (Lb_Nzav.Caption<>'Новый')
    then
      begin
        BB_clzav.Enabled:=value
      end
    else
      begin
        if (FDM_Zav.Qry_owner.FieldByName('OWNER_TYPE').asInteger in [2])
            and (FormMode<>tfmZayavCopy)
          then BB_clzav.Enabled:=value else
          BB_clzav.Enabled:=FALSE;
      end;
  if (BB_clzav.Enabled) and (isClosed) then
    BB_clzav.Enabled:=FALSE;      
end;
{/30.09.2004}

procedure TFormZav.DBL_placeChange(Sender: TObject);
begin
  inherited;
  FDM_Zav.SyncDamg;
//  UpdateSod;
  DBL_raonChange(self);
end;

{function TFormZav.GenAddr(_ul1,_ul2:TRxDBLookupCombo;_house,_dopadr:TEdit):string;
begin
  result:='';
  if _ul1.Visible then result:=result+_ul1.Text;
  if (_ul1.Visible) and not(_ul2.Visible) then
    begin  if _house.Visible then result:=result+','+_house.Text; end
      else if _ul2.Visible then result:=result+' / '+_ul2.Text;
  if _dopadr.Text<>'' then result:=result+' ('+_dopadr.Text+')';
end;}

procedure TFormZav.BB_PoteriClick(Sender: TObject);
begin
  inherited;
  PoteriForm:=TPoteriForm.Create(nil,not(rsPOTER in RightsSet));
  try
    PoteriForm.ID_Zav:=ZavCode;
    toPoteriForm;
    PoteriForm.ExDoClalcLeak:=DoCalcLeak;
    PoteriForm.ExDBL_raonChange:=DBL_raonChange;
    if sender<>nil then PoteriForm.ShowModal;
    fromPoteriForm;
    //
    SavePoteriForClosedZav; //только для закрытых нарядов
  finally
    FreeAndNil(PoteriForm);
  end;
end;

procedure TFormZav.N4Click(Sender: TObject);
begin
  inherited;
  LastMenuItemSender_Tag:=(Sender as TMenuItem).Tag;
  ne_mi14(sender);
end;

procedure TFormZav.N5Click(Sender: TObject);
begin
  inherited;
  LastMenuItemSender_Tag:=(Sender as TMenuItem).Tag;
  ne_mi15(sender);
end;

procedure TFormZav.SmartPopup(ne:TNotifyEvent; tb:TBitBtn);
var
  glPoint:TPoint;
begin
  if not Assigned(pmChoiceAtt_Zav) then
    pmChoiceAtt_Zav:=TPopupMenu.Create(Self);
  glPoint:=tb.ClientToScreen(Point(tb.Left,tb.Top));
  MI4_OnClick(ne);
  MI5_OnClick(ne);
  M72_OnClick(ne);

  ne_mi_ObjVoda := ne;
  ne_mi_ObjKanal := ne;

  pmChoiceAtt_Zav.Popup(glPoint.x-30,glPoint.y);
  tb.PopupMenu:=nil;
end;

procedure TFormZav.MI4_OnClick(ne:TNotifyEvent);
begin
  ne_mi14:=ne;
end;

procedure TFormZav.MI5_OnClick(ne:TNotifyEvent);
begin
  ne_mi15:=ne;
end;

procedure TFormZav.M72_OnClick(ne: TNotifyEvent);
begin
  ne_mi72:=ne;
end;

procedure TFormZav.SetDatasetOfControls;
var i,k:integer;
  s:string;
  _ds:TDataSource;
begin
  for i:=0 to ComponentCount-1 do
    begin
      if Components[i].ClassName ='TRxDBLookupCombo' then
        begin
          s:=(((Components[i] as TRxDBLookupCombo).LookupSource) as TDataSource).Name;
          _ds:=nil;
          _ds:=FDM_Zav.FindComponent(s) as TDataSource;
          (Components[i] as TRxDBLookupCombo).LookupSource:=_ds;
        end;
    end;  
end;

procedure TFormZav.CB_DelZayavClick(Sender: TObject);
begin
  inherited;
  if not FDelStatusWasChanged then FDelStatusWasChanged:=TRUE;
  {if not FLockChangeNotify then
  begin
      if not(FUpdateZavFlag) then
      begin
        isSave(tcsWasChanged);
        isZavClose;
      end;
  end;}
end;


procedure TFormZav.CB_DelZayavKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var s:string;
begin
///убрать из нарядов на удаление'
  if CB_DelZayav.Checked then s:=TrLangMSg(msgRemoveFdelOrder)
    else s:=TrLangMSG(msgaddTodelOrder);//'поместить на удаление';
  if MessageBox(handle,PChar('наряд '+s+'?'),
  PChar(TrLangMSG(msgCapMainForm)),MB_OKCANCEL or MB_ICONINFORMATION)=ID_CANCEL
    then Key:=0;
  inherited;
end;



function TFormZav.Detect_FirstStrOfDopInfOnDelStatus:boolean;
begin
  result:=false;
  if edDop_Inf.Lines.Count>0 then
    begin
      if Pos(DEL_STATUS_KEYWORD,edDop_Inf.Lines[0])>0 then result:=true;
    end;
end;

function TFormZav.Add_FirstStrOfDopInfOnDelStatus:boolean;
begin
  result:=false;
  if not Detect_FirstStrOfDopInfOnDelStatus then
    begin
      result:=true;
      edDop_Inf.Lines.Insert(0,DEL_STATUS_KEYWORD+TRLangMSG(msgIsAddToDelete)+' '// поставлена на удаление '
        +DateTimeToStr(now)+' диспетчером '+NameUser+' >');
      FLastFirstStrOfDopInf:=edDop_inf.Lines[0]
    end
      else
    begin      
      Delete_FirstStrOfDopInfOnDelStatus;
      Add_FirstStrOfDopInfOnDelStatus;
    end;      
end;

function TFormZav.Delete_FirstStrOfDopInfOnDelStatus:boolean;
begin
  result:=false;
  edDop_inf.OnChange:=nil;
  if Detect_FirstStrOfDopInfOnDelStatus then
    begin
      result:=true;
      edDop_Inf.Lines.Delete(0);
    end;
  edDop_inf.OnChange:=Mmm_dopinfChange;
end;

procedure TFormZav.CB_DelZayavMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var s,s1:string;
  _let_change:boolean;
begin
  inherited;
  _let_change:=FALSE;
  if CB_DelZayav.Checked then s:=TRLangMSG(msgRemoveFdelOrder)//'убрать из нарядов на удаление'
    else s:=TRLangMSG(msgaddTodelOrder);//'поместить на удаление';
      if MessageBox(handle,PChar('Наряд '+s+'?'),PChar(TRLangMsg(msgCapMainForm)),MB_OKCANCEL or MB_ICONINFORMATION)=ID_CANCEL
    then abort
    else
      begin
        if not CB_DelZayav.Checked then
          begin
            if (Trim(edDop_Inf.Text)<>'') then
              begin
                _let_change:=TRUE;
                Add_FirstStrOfDopInfOnDelStatus;
              end
              else
                begin
                  //Дополнительная информация не заполнена!
                  //'Заполните ее причиной постановки на удаление'
                  MessageBox(handle,PChar(TrLangMSG(msgDopInfo)+''+TrLangMSG(msgNotFill)+#13+
                    TrLangMSG(msgAddResonDel)),PChar(TRLangMsg(msgCapMainForm)),MB_OK or MB_ICONINFORMATION);
                  edDop_Inf.Enabled:=TRUE;
                  edDop_Inf.SetFocus;
                end;
          end
            else
          begin
            _let_change:=true;
            Delete_FirstStrOfDopInfOnDelStatus;
          end;            
      end;
  if _let_change then CB_DelZayav.Checked:=not CB_DelZayav.Checked;
end;

procedure TFormZav.edDop_infKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  
begin
  inherited;
  if (Key=13) then
    begin
      if (FDopInfCaretPos.Y=0) and (edDop_inf.Lines.Count>0) and (CB_DelZayav.Checked) then
        begin
          edDop_inf.Lines.Delete(1);
        end;
    end;
end;

procedure TFormZav.edDop_infKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  FDopInfCaretPos:=edDop_Inf.CaretPos;
  inherited;
end;

procedure TFormZav.bbMapClick(Sender: TObject);
begin
  inherited;
  {$IFDEF MAP}
    if MAP_IS_WORK then
    begin
      //DM_GateAvar.Attach:=ManaGeAvarOnMap.ConvertAttachToMAPAttach(integer(ZavAttach));
      DM_GateAvar.SendCurrAvarToMap({CreateAvar}1,{OnlyScale}0,{HideMainForm}0,{Scale}1000);
      ManageAvarOnMap.Show;
    end
    else
      Application.MessageBox('Карта не запущена!!!','Внимание!',MB_ICONWARNING+MB_OK);
  {$ENDIF}
end;

procedure TFormZav.bbPrintOrdClick(Sender: TObject);
var _w,_h:integer;
  _fn:string;
  F_DM_AvrImage: TDM_AvrImage;
begin
  inherited;
  SCREENSHOT_WIDTH:=1020;
  SCREENSHOT_HEIGHT:=672;
  {$IFDEF MAP}
    if MAP_IS_WORK then
      begin
        try
          //SBar.Panels[0].Text:='Поиск аварии на карте и получение изображения...';
          Application.ProcessMessages;
          try
            if MessageBox(handle,'Сформировать дополнительный фрагмент карты'+#13+
              'с местностью, где произошла авария?','Диспетчер АВР', MB_OK or MB_YESNO or MB_ICONQUESTION)=ID_YES then
                DM_GateAvar.NeedOfCountScreenShot:=2 else DM_GateAvar.NeedOfCountScreenShot:=1;
            DM_GateAvar.ScreenShotCounter:=0;
            if not(DM_GateAvar.PrintReport) then
              begin
                 NewPrint;
              end;
          except
          end;
        finally
          //
        end;
      end
        else
      begin
          // здесь  будет как и в 

        F_DM_AvrImage:=TDM_AvrImage.Create(self, ZavCode);
        try
         if F_DM_AvrImage.FileList.Count>0 then
          begin
            F_SCREENSHOT_PATH_1 := F_DM_AvrImage.FileList[0];
            if F_DM_AvrImage.FileList.Count>1 then
              begin
                F_SCREENSHOT_PATH_2 := F_DM_AvrImage.FileList[1];
                F_NeedOfCountScreenShot := 2;
               end
              else
                begin
                  F_SCREENSHOT_PATH_2 := '';
                  F_NeedOfCountScreenShot := 1;
                 end;
           end;
          NewPrint;

        finally
          F_DM_AvrImage.Free;
        end;
      end;
  {$ELSE}
    SCREENSHOT_PATH:=ExtractFileDir(ParamStr(0))+'\Temp\pics\'+edNom.Text+'_'+FormatDateTime('yyyy',edData.Date)+'.bmp';
    _w:=SCREENSHOT_WIDTH;
    _h:=SCREENSHOT_HEIGHT;
    _fn:=SCREENSHOT_PATH;
    SaveEmptyPic(_w,_h,_fn);
      NewPrint;
  {$ENDIF}
end;

{$IFDEF MAP}

procedure TFormZav.OnFindWorkFields(Sender:TObject; _Attach:TAttach; _nomer,_year:integer);
  //
  function GetZavjavTableName(_id_attach,_nomer:integer; var _zav_table_name:string; var _id:integer):boolean;
  var _tbl:string;
    begin
      result:=FALSE;
      _tbl:='';
      MyOpenSQL(FDM_Zav.Qry_Map,'select id from nzavjav where (nomer='+IntToStr(_nomer)+') and (id_attach='+IntToStr(_id_attach)+')');
      if (FDM_Zav.Qry_Map.eof) then
      begin
        FDM_Zav.Qry_Map.Close;
        MyOpenSQL(FDM_Zav.Qry_Map,'select id from zavjav where (nomer='+IntToStr(_nomer)+') and (id_attach='+IntToStr(_id_attach)+')');
        FDM_Zav.Qry_Map.Open;
        if not(FDM_Zav.Qry_Map.eof) then _tbl:='zavjav';
      end else _tbl:='nzavjav';
      _zav_table_name:=_tbl;
      if (_tbl<>'') then
        begin
          result:=true;
          _id:=FDM_Zav.Qry_Map.Fields[0].AsInteger;
        end;
      FDM_Zav.Qry_Map.Close;
    end;
    //
var _tbl:string;
  _id,_id_attach:integer;
begin
  if MAP_IS_WORK then
    begin
      Screen.Cursor:=crHourGlass;
      try
        {Попробуем найти завяку либо в закрытых, либо в открытых}
        //
        if _Attach=tatKanal then _id_attach:=2 else _id_attach:=1; 
        if not GetZavjavTableName(_id_attach,_nomer,_tbl,_id) then exit;
      //
      with FDM_Zav.Qry_Map do
      begin
        Close;
        SQL.Clear;
        SQL.Text:=
          ' select '+MAP_SELECT_SQL+
          ' from '+_tbl+' z '+
          ' where (z.id='+IntToStr(_id)+') and (z.id_attach='+IntToStr(_id_attach)+')';
        Open;
        First;
        if not Eof then
          begin
              ManaGeAvarOnMap.SendAvarInfo(0,
              //номер наряда
              FieldByName('narjad_nom').AsInteger,
              //дата и время наряда
              FieldByName('data_soob').AsDateTime,
              //район
               FieldByName('rayon').AsString,
               //адрес
               trim(DM1.Gen_Addr(FieldByName('vidul').AsString,FieldByName('ul1').AsString,
                FieldByName('ul2').AsString,FieldByName('kod_ul').AsString,'','')),
               //характер повреждения
               Trim(FieldByName('xar_povr').AsString),
               //место повреждения
               Trim(FieldByName('mesto_name').AsString),
               //диаметр
               FieldByName('diam_diam').AsInteger,
               //дата окончания
               FieldByName('data_end').AsDateTime,
               {Scale}0,{CreateAvar}1,{OnlyScale}0,
                ManaGeAvarOnMap.ConvertAttachToMAPAttach(FieldByName('id_attach').AsInteger),{HideMainForm}0);
          end
            else
              ManaGeAvarOnMap.SendAvarInfo(0,
                //номер наряда
                0,
                //дата и время наряда
                0,
                //район
                 '',
                 //адрес
                 '?',
                 //характер повреждения
                 '?',
                 //место повреждения
                 '?',
                 //диаметр
                 0,
                 //дата окончания
                 0,
               {Scale}0,{CreateAvar}1,{OnlyScale}0,
               ManaGeAvarOnMap.ConvertAttachToMAPAttach(integer(ZavAttach)),{HideMainForm}0);
          Close;
      end;
      finally
        FDM_Zav.Qry_Map.Close;
        Screen.Cursor:=crDefault;
      end;
    end;
end;

procedure TFormZav.OnAskWorkFields(Sender:TObject);
var _d:integer;
    _t1,_t2:TDateTime;
    _nomer:integer;
    _ZavAttach:TOperAtt;
begin
  if MAP_IS_WORK then
    begin
      if trim(DBL_Diam.Text)<>'' then _d:=StrToInt(DBL_Diam.Text)
        else _d:=0;
      if (trim(DE_In.Text)<>'') and (trim(DE_In.Text)<>':') then _t1:=StrToDateTime(DE_in.Text+' '+Time2Str(TE_in.Time))
        else _t1:=0;
      if (trim(DE_Out.Text)<>'') and (trim(DE_Out.Text)<>':') then _t2:=StrToDateTime(DE_out.Text+' '+Time2Str(TE_out.Time))
        else _t2:=0;
      //
      if lb_nzav.Caption<>TrLangMSG(msgNewM) then
        _nomer:=(StrToInt(lb_nzav.Caption)) else _nomer:=-1;
      DM_GateAvar.Nomer:=_nomer;
      DM_GateAvar.Year:=YearOf(_t1);
      DM_GateAvar.Dt_in:=(_t1);
      DM_GateAvar.Dt_out:=(_t2);
      DM_GateAvar.Rayon:=trim(DBL_Raon.Text);
      DM_GateAvar.Address:=trim(FDM_Zav.Qry_Ul1.FieldByName('v_name_r').AsString+' '+trim(FDM_Zav.Qry_Ul1.FieldByName('u_name_r').AsString));
      if CB_tAdr.ItemIndex=0 then DM_GateAvar.Address:=DM_GateAvar.Address+', '+trim(Ed_ndom.Text);
      //DM_GateAvar.Xar_povr:=Trim(DBL_sod.Text);
      DM_GateAvar.Mesto_povr:=Trim(DBL_place.Text);
      DM_GateAvar.Diam:=_d;
      //
      _ZavAttach := TOperAtt( Integer( cbAttach.Items.Objects[ cbAttach.ItemIndex ] ) );
      DM_GateAvar.Attach:=ManaGeAvarOnMap.ConvertAttachToMAPAttach(integer(_ZavAttach));
      //
    end;
end;

procedure TFormZav.OnReceivedScreenShot(Sender:TObject);
begin
  Screen.Cursor:=crDefault;
  //MessageBox(handle,'Скриншот карты сделан успешно','Диспетчер АВР',MB_OK or MB_ICONINFORMATION);
  NewPrint;
end;
{$ENDIF}

procedure TFormZav.BB_WithoutWaterClick(Sender: TObject);

var
 // WWatForm: TWithoutWaterForm;
 frm_newDiscon: Tfrm_DisconNew;
  IsReadOnly: boolean;
//  var sentserv:TSentToServ;
procedure sent() ;
//var  i:integer;
begin
  frm_newDiscon.dset_main.First;
  while not frm_newDiscon.dset_main.Eof do
  begin
    if frm_newDiscon.dset_main.FieldByName('modifi').AsInteger=1 then
    begin
     FDM_Zav.setwwaterid(ZavCode,frm_newDiscon.dset_main.FieldByName('id').AsInteger,isClosed);
     break;
    end;
  end;
end;

begin
  IsReadOnly:=not(rsZAV in RightsSet) or isClosed;
  frm_newDiscon:= Tfrm_DisconNew.Create(self, ZavCode,IsReadOnly);
  try
   // WWatForm.ID_zav:=ZavCode;
    frm_newDiscon.DateShift:=Date(); //!!даиа смены не ясно
    //отсылка на сервер http - некуда
   // sentserv:=nil;
   { if DM_main.connectHttp then
    begin
      sentserv:=TSentToServ.create(DM_main.http,ZavCode,DE_in.Date,ord(ZavAttach),FDM_Zav.getadresssent(zavcode),sentlog,
                                  calcIdKod(FDM_Zav,ZavCode,ord(ZavAttach)));
      frm_newDiscon.sentserv:=sentserv;
    end;}
    frm_newDiscon.region:=FDM_Zav.Qry_Raon.FieldByName('id').asInteger;
    frm_newDiscon.ShowModal;
    {if  sentserv<>nil then
    begin
    if FDM_Zav.getidwwater(Zavcode)=0 then
       if sentserv.SentHead then
        FDM_Zav.setwwaterid(zavcode,1,isclosed);
    sentserv.SentAdd;
    sentserv.SentDel;
    end;}
    //sent();
  finally
    FreeAndNil(frm_newDiscon);
   // FreeAndNil(sentserv);
  end;
  if (FDM_Zav.NWWATERCount(ZavCode)>0) then
    BB_WithoutWater.Font.Color:=ErrCol
   else
     BB_WithoutWater.Font.Color:=TextCol;
   isZavClose();  
end;


procedure TFormZav.DoCalcLeak(Sender: TObject);
begin
  fromPoteriForm;
  seSpeedLeak_Value:=0.6*3600*(seSquareLeak_Value/10000)*sqrt(20*Max((9.81*sePress_Value-seGLZ_Value),0));
  PoteriForm.seSpeedLeak_Value:=seSpeedLeak_Value;
  if (sender<>nil) then DBL_raonChange(Sender);
end;

procedure TFormZav.DE_inChange(Sender: TObject);
begin
  try
    StrToDate(DE_Out.Text);
  except
    DE_Out.Text:=DE_In.Text;
  end;
  DBL_raonChange(Sender);
end;

procedure TFormZav.BB_ImageClick(Sender: TObject);
var
  AvrImg: Tfrm_AvrImageView;
  IsReadOnly: boolean;
begin
  IsReadOnly:=not(rsZAV in RightsSet) or isClosed;
  AvrImg:=Tfrm_AvrImageView.Create(self, ZavCode, IsReadOnly);
  try
    AvrImg.ShowModal;
{
    if FDM_Zav.GetAvrImageCount(ZavCode)>0 then
      BB_Image.Font.Color:=ErrCol
    else
      BB_Image.Font.Color:=TextCol;
}
  finally
    AvrImg.Free;
  end;
end;

procedure TFormZav.N6Click(Sender: TObject);
begin
  inherited;
  LastMenuItemSender_Tag:=(Sender as TMenuItem).Tag;
  ne_mi72(sender);
end;

procedure TFormZav.mi_PrintZavClick(Sender: TObject);
begin
  bbPrintOrdClick(nil);
end;

procedure TFormZav.mi_EkonomPokazClick(Sender: TObject);
begin
  PrintEkonomPokaz;
end;

procedure TFormZav.N7Click(Sender: TObject);
begin
  inherited;
  LastMenuItemSender_Tag:=(Sender as TMenuItem).Tag;
  ne_mi_ObjVoda( Sender );
end;

procedure TFormZav.N8Click(Sender: TObject);
begin
  inherited;
  LastMenuItemSender_Tag:=(Sender as TMenuItem).Tag;
  ne_mi_ObjKanal( Sender );
end;

procedure TFormZav.InitNarForm( _NarForm: TFormNarad );
var
  _adr: TAdresRec;
begin
  _NarForm.MestTypeID := GetMestTypeID;

  _adr.kod_ul := CB_tAdr.ItemIndex;
  _adr.id_ul1 := FDM_Zav.Qry_Ul1.FieldByName( 'ID' ).AsInteger;
  _adr.dop_adr := Strip('A','"',Ed_dopAdr.Text);
  if CB_tAdr.ItemIndex = 0 then
    _adr.id_ul2 := Strip('A','"',Ed_Ndom.Text)
  else if CB_tAdr.ItemIndex = 1 then
    _adr.id_ul2 := FDM_Zav.Qry_Ul2.FieldByName('ID').asString;
  if CB_tAdr.ItemIndex=2 then
    _adr.id_DopAdres := FDM_Zav.qry_DopAdres.FieldByName('ID').AsInteger
  else
    _adr.id_DopAdres := -1;
  _NarForm.DefaultAdres := _adr;
end;

function TFormZav.GetMestTypeID: integer;
begin
  {Задаем тип местности.
  Значения которые подсовываю соотвествуют соот. значениям
  из справочника S_MestType.
  Сделано все каряво, т.к. изначально кому-то было
  в лом создать справочник типов местности. Потом как
  будет время, нужно ОБЯЗАТЕЛЬНО сделать по-человечески}
  if DBL_Mest.LookupSource.DataSet.FieldByName('VOSST_POKRYT').AsString='ВІДНОВЛ' then
    Result := 1   //сооствет. "ВОССТ."
  else
  if DBL_Mest.LookupSource.DataSet.FieldByName('VOSST_POKRYT').AsString='НЕВІДНОВЛ' then
    Result := 2  //сооствет. "НЕВОССТ."
  else
    Result := -1;
end;

procedure TFormZav.bt_COORDClick(Sender: TObject);
var
  _min, _deg: integer;
  _sec : real;
begin
  inherited;
//
  Frm_GEOCOORD1.SecToMinDeg(F_NSec, _Deg,  _min, _sec);
  Frm_GEOCOORD1.se_Deg_N.AsInteger := _deg;
  Frm_GEOCOORD1.se_Min_N.AsInteger := _min;
  Frm_GEOCOORD1.se_Sec_N.Value := _sec;

  Frm_GEOCOORD1.SecToMinDeg(F_ESec, _Deg,  _min, _sec);
  Frm_GEOCOORD1.se_Deg_E.AsInteger := _deg;
  Frm_GEOCOORD1.se_Min_E.AsInteger := _min;
  Frm_GEOCOORD1.se_Sec_E.Value := _sec;

  //PCoord.Visible := false;
  //Frm_GEOCOORD1.Visible := true;
 { with Frm_GEOCOORD1 do
  begin
    se_Deg_N.Enabled := true;
    se_Min_N.Enabled := true;
    se_Sec_N.Enabled := true;
    se_Deg_E.Enabled := true;
    se_Min_E.Enabled := true;
    se_Sec_E.Enabled := true;

  end;
  }
end;

procedure TFormZav.Panel4Click(Sender: TObject);
begin
  inherited;
//
end;

procedure TFormZav.Frm_GEOCOORD1BitBtn1Click(Sender: TObject);
var ii: integer;
begin
 inherited;
    //
    P_Coord_Fill;
end;

procedure TFormZav.D_Coord_Fill;
begin
 //
 se_XF.AsInteger := trunc(F_NSec) div 12;
 se_XD.Value := F_NSec - (se_XF.AsInteger * 12);

 se_YF.AsInteger := trunc(F_ESec) div 12;
 se_YD.Value := F_ESec - (se_YF.AsInteger * 12);

end;


procedure TFormZav.P_Coord_Fill;
begin
  if Frm_GEOCOORD1.AllCHECKED then
   begin
    with Frm_GEOCOORD1 do
     begin
       geosecN := AllToSec(se_Deg_N.AsInteger, se_Min_N.AsInteger, se_Sec_N.Value);
       geosecE := AllToSec(se_Deg_E.AsInteger, se_Min_E.AsInteger, se_Sec_E.Value);
     end;
      F_NSec := Frm_GEOCOORD1.geosecN;
      F_ESec := Frm_GEOCOORD1.geosecE;
    // Frm_GEOCOORD1.Enabled := false;
   {   with Frm_GEOCOORD1 do
      begin
        se_Deg_N.Enabled := false;
        se_Min_N.Enabled := false;
        se_Sec_N.Enabled := false;
        se_Deg_E.Enabled := false;
        se_Min_E.Enabled := false;
        se_Sec_E.Enabled := false;

      end;
    }

   end;
end;

procedure TFormZav.cb_OTLKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var s:string;
begin
if CB_OTL.Checked then s:=TrLangMSG(msgRemoveFOtlNar)//'убрать из отложенных нарядов'
    else s:=TrLangMSG(msgAddOtlNar);    //'отложить';
if MessageBox(handle,PChar('Наряд '+s+'?'),PChar(TrLangMSG(msgCapMainForm)),MB_OKCANCEL or MB_ICONINFORMATION)=ID_CANCEL
   then Key:=0;
  inherited;
end;


procedure TFormZav.cb_OTLMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var s,s1:string;
  _let_change:boolean;
begin
  inherited;
  _let_change:=FALSE;
  //убрать из отложенных нарядов
  if CB_OTL.Checked then s:=TrLangMSG(msgRemoveFOtlNar)
    else s:=TrLangMSG(msgAddOtlNar);    //отложить
  if MessageBox(handle,PChar('наряд '+s+'?'),PChar(TrLangMSG(msgCapMainForm)),MB_OKCANCEL or MB_ICONINFORMATION)=ID_CANCEL
    then abort  else
    begin
    CB_OTL.Checked:=not CB_OTL.Checked;
    DBL_raonChange(Self);
    end;
    {
      begin
        if not CB_OTL.Checked then
          _let_change:=TRUE
            else
            _let_change:=true;
      end;
  if _let_change then CB_OTL.Checked:=not CB_OTL.Checked;}
end;

procedure TFormZav.cb_OTLClick(Sender: TObject);
begin
  inherited;
  if not FOtlStatusWasChanged then FOtlStatusWasChanged:=TRUE;
end;

procedure TFormZav.UpdateComents();
 var s:string;
begin
 case ZavAttach of
  toaVoda,toaObjVoda : s:=' and (zayavl=1) ';
  toaKanal, toaObjKanal: s:=' and (zayavl=2) ';
  else s:=' and (zayavl=1) ';
 end;
 MyOpenSQL(FDM_Zav.Qry_comment,'select min(id) id ,name_r , ID_OBORTYPEGLOB '+
                                ' from s_sod '+
                                ' where (del in (''-'',''d''))  '+
                                 s+
                                ' group by 2,3 order by name_r ');
 if FltDel and not FormMain.DictNotHide.checked
  then SetFilterDelete(FDM_Zav.Qry_comment,true)

end;




procedure TFormZav.btn_linkOtlZavClick(Sender: TObject);
var frm_otl:Tfrm_OtlNaradList;
begin
  inherited;
   if ZavCode>0 then
   begin
   frm_otl:=Tfrm_OtlNaradList.Create(self, ZavCode, ord(ZavAttach));
   try
    frm_otl.id_zav:=ZavCode;
    frm_otl.id_atttach:=ord(ZavAttach);
    frm_otl.namefiltr:=GetAttachName(ZavAttach);
    frm_otl.ShowModal;
    if frm_otl.oltNarNumber<>'' then
     btn_linkOtlZav.Caption:=TrLangMSG(msgConectWith)+frm_otl.oltNarNumber //'Связан с №'
    else
      btn_linkOtlZav.Caption:=TrLangMSG(msgConnectToDeferred); //'Связать с  отложенным';
   finally
     frm_otl.Free;
   end;
   end;

end;

{
Характер 
повреждения
  DBL_sodChange
  UpdateSod;
  DBL_raonChange(Self);
}

procedure TFormZav.sp_intime_outClick(Sender: TObject);
var dt:TDateTime;
begin
  inherited;
  dt:=myNow;
  DE_out.Date:=dt;
  TE_out.Time:=strtodatetime(datetimetostr(dt,'dd.mm.yyyy hh:mm:00'));

end;

end.

