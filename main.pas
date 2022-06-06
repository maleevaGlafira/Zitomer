unit main;

interface

{$I !map_define.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Menus, Db, ComCtrls, ExtCtrls, RXClock, StdCtrls,Stat, SpeedBar,
  Mask, CurrEdit, ToolEdit, Appex, ToolWin, ImgList, Placemnt, OleServer,
  {atm_TLB,} frmLANG,cntsLANG,consts, constsUA, LocalDT,BackUpRestoreForm,
  AppErrUnit,
  {$IFDEF MAP} SendMessToAvarOnMap, AvarOnMapConst,{$ENDIF}
  VedomsUnit, OperAttFormUnit,ServiceFuncUnit, AvrAdminManagerUnit;

type
  TFormMain = class(TAppErrForm)
    MainMenu1: TMainMenu;
    Dic_mi: TMenuItem;
    S_Brig_mi: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    S_Place_mi: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    NewZav_mi: TMenuItem;
    N23: TMenuItem;
    N24: TMenuItem;
    N25: TMenuItem;
    N26: TMenuItem;
    Qry_tmp: TQuery;
    N27: TMenuItem;
    N28: TMenuItem;
    Users_mi: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    S_sah_mi: TMenuItem;
    N33: TMenuItem;
    N34: TMenuItem;
    old_SpeedBar1: TSpeedBar;
    SS_zav: TSpeedbarSection;
    SS_Ved: TSpeedbarSection;
    old_SI_nzper: TSpeedItem;
    old_SI_fprois: TSpeedItem;
    old_SI_univ: TSpeedItem;
    old_SI_zak: TSpeedItem;
    old_SI_nzak: TSpeedItem;
    old_SI_Proiz: TSpeedItem;
    old_SI_new: TSpeedItem;
    SpeedbarSection1: TSpeedbarSection;
    old_SI_exit: TSpeedItem;
    old_SI_newus: TSpeedItem;
    Qry_tmp2: TQuery;
    N35: TMenuItem;
    N36: TMenuItem;
    N37: TMenuItem;
    N38: TMenuItem;
    new1: TMenuItem;
    Qry_tmp3: TQuery;
    N29: TMenuItem;
    CompareRefer_mi: TMenuItem;
    ImageList1: TImageList;
    CoolBar1: TCoolBar;
    SpeedBar1: TToolBar;
    SI_new: TToolButton;
    SI_nzak: TToolButton;
    SI_nzper: TToolButton;
    SI_fprois: TToolButton;
    SI_newus: TToolButton;
    SI_exit: TToolButton;
    SI_zak: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    SI_Proiz: TToolButton;
    SBM: TStatusBar;
    Button_pic: TImageList;
    N14: TMenuItem;
    rep2: TMenuItem;
    N31: TMenuItem;
    N41: TMenuItem;
    N39: TMenuItem;
    FormPlacement1: TFormPlacement;
    N40: TMenuItem;
    Nastr_mi: TMenuItem;
    TableLog_mi: TMenuItem;
    Map_mi: TMenuItem;
    DateTimeStorage1: TDateTimeStorage;
    N1: TMenuItem;
    N2: TMenuItem;
    N5: TMenuItem;
    DictNotHide: TMenuItem;
    N22: TMenuItem;
    N42: TMenuItem;
    N43: TMenuItem;
    N44: TMenuItem;
    N45: TMenuItem;
    N46: TMenuItem;
    N47: TMenuItem;
    N48: TMenuItem;
    N30: TMenuItem;
    tbPrint: TToolButton;
    N49: TMenuItem;
    N50: TMenuItem;
    ToolButton1: TToolButton;
    N51: TMenuItem;
    N52: TMenuItem;
    N53: TMenuItem;
    ToolButton2: TToolButton;
    pmChoiceAtt: TPopupMenu;
    MI4: TMenuItem;
    MI5: TMenuItem;
    N54: TMenuItem;
    N55: TMenuItem;
    N56: TMenuItem;
    N57: TMenuItem;
    Backup_mi: TMenuItem;
    Restore_mi: TMenuItem;
    N60: TMenuItem;
    N59: TMenuItem;
    N61: TMenuItem;
    N63: TMenuItem;
    N64: TMenuItem;
    N310: TMenuItem;
    N410: TMenuItem;
    N411: TMenuItem;
    N65: TMenuItem;
    N66: TMenuItem;
    N80: TMenuItem;
    TB_DelZajav: TToolButton;
    N62: TMenuItem;
    N67: TMenuItem;
    N71: TMenuItem;
    N68: TMenuItem;
    N69: TMenuItem;
    L_MapConnect: TLabel;
    N81: TMenuItem;
    N91: TMenuItem;
    N131: TMenuItem;
    N58: TMenuItem;
    N70: TMenuItem;
    N72: TMenuItem;
    N73: TMenuItem;
    N74: TMenuItem;
    N210: TMenuItem;
    N75: TMenuItem;
    N76: TMenuItem;
    N77: TMenuItem;
    N211: TMenuItem;
    mi_s_trudozatrat: TMenuItem;
    mi_S_BWork: TMenuItem;
    mi_RepTZ: TMenuItem;
    pmChoiceAllAtt: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    N78: TMenuItem;
    N79: TMenuItem;
    mi_s_instrum: TMenuItem;
    mi_s_object: TMenuItem;
    mi_S_ObjObor: TMenuItem;
    mi_RepMatUse: TMenuItem;
    mi_SvodkaSes: TMenuItem;
    N82: TMenuItem;
    miOtlRep: TMenuItem;
    mi_S_OGRAGD: TMenuItem;
    mi_S_OBORTYPE: TMenuItem;
    mi_S_SOORUG: TMenuItem;
    mi_S_OBORTYPEGLOB: TMenuItem;
    mi_SvodVed3: TMenuItem;
    mi_Windows: TMenuItem;
    N212: TMenuItem;
    N83: TMenuItem;
    Qry_tmp4: TQuery;
    N84: TMenuItem;
    N85: TMenuItem;
    N86: TMenuItem;
    N87: TMenuItem;
    StatusBar: TStatusBar;
    N88: TMenuItem;
    N132: TMenuItem;
    nRepExcavNotFinished: TMenuItem;
    nRepExcavNotFinished2: TMenuItem;
    N89: TMenuItem;
    N133: TMenuItem;
    NROpenShiftDeps: TMenuItem;
    tb_openshiftdeps: TToolButton;
    NMMaters: TMenuItem;
    NMMaterToBrig: TMenuItem;
    N32: TMenuItem;
    procedure S_Brig_miClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure S_Place_miClick(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure N16Click(Sender: TObject);
    procedure N17Click(Sender: TObject);
    procedure N18Click(Sender: TObject);
    procedure N19Click(Sender: TObject);
    procedure N21Click(Sender: TObject);
    procedure NewZav_miClick(Sender: TObject);
    procedure N23Click(Sender: TObject);
    procedure N24Click(Sender: TObject);
    procedure N26Click(Sender: TObject);
    procedure N27Click(Sender: TObject);
    procedure N28Click(Sender: TObject);
//    procedure N29Click(Sender: TObject);
    procedure Users_miClick(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N20Click(Sender: TObject);
    procedure N33Click(Sender: TObject);
    procedure N34Click(Sender: TObject);
    procedure old_SI_newClick(Sender: TObject);
    procedure old_SI_zakClick(Sender: TObject);
    procedure old_SI_nzakClick(Sender: TObject);
    procedure old_SI_ProizClick(Sender: TObject);
    procedure old_SI_nzperClick(Sender: TObject);
    procedure old_SI_fproisClick(Sender: TObject);
    procedure old_SI_newusClick(Sender: TObject);
    procedure old_SI_exitClick(Sender: TObject);
    procedure N35Click(Sender: TObject);
    procedure N37Click(Sender: TObject);
    procedure N38Click(Sender: TObject);
    procedure new1Click(Sender: TObject);
    procedure CompareRefer_miClick(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure rep2Click(Sender: TObject);
    procedure N31Click(Sender: TObject);
    procedure N41Click(Sender: TObject);
    procedure Nastr_miClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TableLog_miClick(Sender: TObject);
    procedure atmInterf1ShowPassprt(Sender: TObject; z_id: Integer);
    procedure Map_miClick(Sender: TObject);
    procedure atmInterf1GetSQLQuery(Sender: TObject;
      var FileName: OleVariant);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure DictNotHideClick(Sender: TObject);
    procedure N22Click(Sender: TObject);
    procedure N42Click(Sender: TObject);
    procedure N43Click(Sender: TObject);
    procedure N44Click(Sender: TObject);
    procedure N45Click(Sender: TObject);
    procedure N46Click(Sender: TObject);
    procedure N47Click(Sender: TObject);
    procedure N48Click(Sender: TObject);
    procedure N30Click(Sender: TObject);
    procedure N50Click(Sender: TObject);
    procedure N51Click(Sender: TObject);
    procedure N52Click(Sender: TObject);
    procedure N53Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure SelectedClick(Sender:TObject);
    procedure N54Click(Sender: TObject);
    procedure N55Click(Sender: TObject);
    procedure N56Click(Sender: TObject);
    procedure N57Click(Sender: TObject);
    procedure Backup_miClick(Sender: TObject);
    procedure Restore_miClick(Sender: TObject);
    procedure N59Click(Sender: TObject);
    procedure N63Click(Sender: TObject);
    procedure N64Click(Sender: TObject);
    procedure N310Click(Sender: TObject);
    procedure N410Click(Sender: TObject);
    procedure N411Click(Sender: TObject);
    procedure N66Click(Sender: TObject);
    procedure N65Click(Sender: TObject);
    procedure N80Click(Sender: TObject);
    procedure MI4Click(Sender: TObject);
    procedure MI5Click(Sender: TObject);
    procedure N62Click(Sender: TObject);
    procedure TB_DelZajavClick(Sender: TObject);
    procedure N67Click(Sender: TObject);
    procedure N71Click(Sender: TObject);
    procedure N69Click(Sender: TObject);
    procedure N81Click(Sender: TObject);
    procedure N91Click(Sender: TObject);
    procedure N131Click(Sender: TObject);
    procedure N58Click(Sender: TObject);
    procedure N70Click(Sender: TObject);
    procedure N72Click(Sender: TObject);
    procedure N73Click(Sender: TObject);
    procedure N74Click(Sender: TObject);
    procedure N210Click(Sender: TObject);
    procedure N75Click(Sender: TObject);
    procedure N76Click(Sender: TObject);
    procedure N77Click(Sender: TObject);
    procedure N211Click(Sender: TObject);
    procedure mi_s_trudozatratClick(Sender: TObject);
    procedure mi_S_BWorkClick(Sender: TObject);
    procedure mi_RepTZClick(Sender: TObject);
    procedure N78Click(Sender: TObject);
    procedure N79Click(Sender: TObject);
    procedure mi_s_instrumClick(Sender: TObject);
    procedure mi_s_objectClick(Sender: TObject);
    procedure mi_S_ObjOborClick(Sender: TObject);
    procedure mi_RepMatUseClick(Sender: TObject);
    procedure mi_SvodkaSesClick(Sender: TObject);
    procedure N82Click(Sender: TObject);
    procedure miOtlRepClick(Sender: TObject);
    procedure mi_S_OGRAGDClick(Sender: TObject);
    procedure mi_S_OBORTYPEClick(Sender: TObject);
    procedure mi_S_SOORUGClick(Sender: TObject);
    procedure mi_S_OBORTYPEGLOBClick(Sender: TObject);
    procedure mi_SvodVed3Click(Sender: TObject);
    procedure N212Click(Sender: TObject);
    procedure N83Click(Sender: TObject);
    procedure N84Click(Sender: TObject);
    procedure N86Click(Sender: TObject);
    procedure N87Click(Sender: TObject);
    procedure N88Click(Sender: TObject);
    procedure N132Click(Sender: TObject);
    procedure nRepExcavNotFinishedClick(Sender: TObject);
    procedure nRepExcavNotFinished2Click(Sender: TObject);
    procedure N89Click(Sender: TObject);
    procedure N133Click(Sender: TObject);
    procedure NROpenShiftDepsClick(Sender: TObject);
    procedure tb_openshiftdepsClick(Sender: TObject);
    procedure NMMaterToBrigClick(Sender: TObject);
    procedure N32Click(Sender: TObject);

  private
    F_CanShift:boolean;
    FCanEdidDic :boolean;
    FWorkCtrlEnabled :boolean;
    F_VVod_CLOSED: boolean;
    F_term:boolean;
    StrAttach:string;
    ne_mi14,ne_mi15,ne_mi72: TNotifyEvent;
    ne_mi_ObjVoda, ne_mi_ObjKanal: TNotifyEvent;
    procedure SetWorkCtrlEnabled(fl :boolean);
    procedure SetCanEdidDic(fl :boolean);
    procedure AddMenu(MenIt:TMenuItem);
    procedure AddMenuForAllAtt(MenuIt: TMenuItem);
    procedure NN_vedoms_click(Sender: TObject; _vedForm:TVedForm);
    procedure MI4_OnClick(ne:TNotifyEvent);
    procedure MI5_OnClick(ne:TNotifyEvent);
    procedure M72_OnClick(ne:TNotifyEvent);
    procedure SmartPopup(ne:TNotifyEvent; tb:TToolButton);
    procedure SmartPopupForAllAtt(ne:TNotifyEvent; tb:TToolButton);
    procedure OnEndLoadAvrAdmin;
    {$IFDEF MAP}
    procedure OnConnectServer(Sender: TObject);
    {$ENDIF}
  public
//    St:TFormStatus;
    Cl_l,Cl_t:integer;
    AdminRight :boolean;
    OperAtt:TOperAtt; //принадлежностьл вода либо канализация
    procedure BConnect(isAllOk:boolean; CanTerminate :boolean=true);
    procedure setFormPlacement;
    procedure getFormPlacement;
    procedure Translate;override;


    property WorkCtrlEnabled :boolean read FWorkCtrlEnabled write SetWorkCtrlEnabled;
    // закрыта ли руками форма FormVvod - by Vadim 05.02.2009 
    property VVod_CLOSED: boolean read F_VVod_CLOSED write F_VVod_CLOSED;
    // Возможность редактирования справочников
    property CanEdidDic :boolean read FCanEdidDic write SetCanEdidDic; // ds
    property CanShift:boolean read F_CanShift write F_CanShift;

    private
      procedure SetHift();
      procedure AddMenuShift(MenuIt: TMenuItem);
  end;

function NN(id,col:integer;var ss:string):integer;
function NN1(id,col:integer;var ss:string):integer;
function NN2(id,col:integer;var ss:string):integer;
function NN3(id,col:integer;var ss:string):integer;
function NN4(id,col:integer;var ss:string):integer;
//function NN5(id,col:integer;var ss:string):integer;
//function NN6(id,col:integer;var ss:string):integer;
function NN7(id,col:integer;var ss:string):integer;
function NN8(id,col:integer;var ss:string):integer;
function NN9(id,col:integer;var ss:string):integer;
function NNSznar(id,col:integer;var ss:string):integer;
//
function ProvDate(date1,date2:TDateTime;time1,time2:string;date1InSmen:boolean=false):boolean;
procedure UstColors(AOwner: TComponent);
procedure ButVis(AOwner: TComponent;vis:boolean);
function Word2Tabl(ss:string;nomerMas,dlin:integer):string;
procedure TekMas20;
function FormatMemo(ss:string;dlin:integer):string;
function FindInSL(ss:string;SL:TStringList;cnt:integer):integer;
procedure InsertInSL(ss:string;var SL:TStringList;mxcnt:integer);
procedure ChangInEdit(var Ed:TCustomEdit;mxcnt:integer);
procedure AutoVvodOn(ed:TCustomEdit);
procedure AutoVvodOff(ed:TCustomEdit);
function MyNPos(const C: string; S: string; N: Integer): Integer;


const CyrLayout = $4190419;
      LatLayout = $4090409;

var
  FormMain: TFormMain;
  St:TFormStatus;
  TekUser,NameUser,CurrentDir,TekRevs:String;
  CodUser,cn,old_cn,old_cnN,old_Res,old_ResR,old_id,cnN,old_ResN,old_ResNR,old_idN,cn1,tekWord,tekWord2:integer;
  fl,fl2,fl3,LockForDel,StorProc:boolean;
  old_revs:string;
  old_rayon:string;
  TextCol,MessCol,ErrCol,BgCol,VvodCol,VvodBgCol:Tcolor;
  CloseStatus,ZavToCopy,ResColCount:integer;
  MTekWord:array [0..50] of integer;
  TekFl:array [0..50] of boolean;
  SL_DopInf:TStringList;
  isAutoVvod:boolean;
  sentlog:boolean;    //отсілка на сервер http

 NewUrl:string;//='http://infoxvod.com.ua/avr-exchange.php?ent=repair&action=add';
 AddUrl:string;//='http://infoxvod.com.ua/avr-exchange.php?ent=stoplist&action=upd';

 DelUrl:string;//='http://infoxvod.com.ua/avr-exchange.php?ent=stoplist&action=del';

  GL_Count :integer; // ds

  max_narnomer:integer;

implementation
  uses ver,sprav,zav,vvod_ol,adm,strtool,sz_nzav,vxod,
  {v_color,}inifiles,rxlookup,spin,RxDBCtrl,
  buttons,sz_sah,sz_sah1, fresult,pro_zav,an_kvart,an_street,sz_prois2, comp_zv,
  Zast, s_dolgn, avartype, s_alien, s_damg, s_sod, s_sah, s_revs,
  s_work, s_place, s_mat, s_runw, s_mest, s_diam, s_obor, s_zav, s_tzav,
  rep1, rep2, rep3, rep4, nastr, logform, s_rayons, s_ulic, s_vidul,
  s_leak, s_clog,s_fill, s_net, s_local, s_killclog, s_pump, s_pes, s_Owner,
  fReport, s_Comment, peoples, AN_DIAGR, Ras_Q, SpreadSh, OborsSh,
  OpSQLEx, s_remont, S_MatPipeFUnit, datam, VedManagerUnit, s_planobor,
  s_vrk, ReportManager, NGReportManager, S_DopAdres, s_trudozatrat, S_BWork,
  FormZavFactory, S_Instrum, s_object, S_ObjObor, s_work_mest, s_Ogragd, S_OborType
  ,S_Soorug, S_OborTypeGlob, S_OTGlob_fieldsUnit, SzNarForm,
  ShiftForm, ShiftDmodule,MaterRepMain, RepMaterMakerForm;
{$R *.DFM}


procedure TFormMain.S_Brig_miClick(Sender: TObject);
//var SpForm:TFormSprav;
//    sTit,sField:TstringList;
begin
 // Справочник должностных лиц
 Screen.Cursor:=crHourGlass;
 if not assigned(S_BrigF) then
   S_BrigF:=TS_BrigF.CreateDic(application, 'S_BRIG','ID',DM1.S_Brig_sur);
 Screen.Cursor:=crDefault;
 ShowDicForm(TForm(S_BrigF));

{  sTit:=TStringList.Create;
  sField:=TStringList.Create;
  sTit.Clear;sTit.Add('Фамилия');sTit.Add('Должность');
  sField.Clear;sField.Add('NAME_R');sField.Add('DOLGN');
  sTit.Add('CONDITION');
  sField.Add(' ;WHERE ID>0; ');
  SpForm:=TFormSprav.Create(Self);
  SpForm:=TFormSprav.SpravCreate(N2,'DBN_AVAR','s_brig',
  'Справочник должностных лиц',sTit,sField);
  SpForm.ShowModal;}
end;

procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
var mIni:TIniFile;
begin
  if NastrF.MainFPlacement_chb.Checked then // ds
     setFormPlacement;
  //
  mIni:=TIniFile.Create(FullPathIniFlAvar{CurrentDir+'\avar.ini'});
  mIni.WriteBool('Setup','Clock',N21.Checked);
  mIni.WriteBool('Setup','StoredProc',StorProc);
  mIni.WriteBool('Setup','AutoVvod',isAutoVvod);
  mIni.WriteBool('Setup','SystemTimeFlag',not MyNowFlag);
  mIni.WriteString('Setup','LastSystemTime',DateTimeToStr(LastMyNow));
  //
  if assigned(St) then
   begin
    mIni.WriteInteger('Setup','Left',St.Left);
    mIni.WriteInteger('Setup','Top',St.Top);
   end;
  mIni.Free;
  DM1.Db_Avar.Connected:=false;
  SL_DopInf.Free;
  //
  {$IFDEF MAP}
  If MAP_IS_WORK then
  begin
    ManageAvarOnMap.Stop;
    ManageAvarOnMap.Destroy;
  end;
  {$ENDIF}
  //
end;

procedure TFormMain.BConnect(isAllOk:boolean; CanTerminate :boolean=true);  //tparam
var Vx:TZastFrm;
    mIni:TIniFile;
    Sect:string;
begin
 F_term:=false;
 with DM1 do
  begin
    RightsSet:=[];
    DB_Avar.Connected:=false;
    if isAllOk then
      begin
       Vx:=TZastFrm.Create(Self);
       if (Vx.ShowModal <> mrOK)and(CanTerminate) then
         begin
          F_term:=true;
          Application.Terminate;
          exit;
         end; // if Vx.ModalResult <> mrOK ...
      end;

    if not DB_Avar.Connected then
      begin
       { N3.Enabled:=false;
        N25.Enabled:=false;
        N1.Enabled:=false;
        N4.Enabled:=false;
        N36.Enabled:=false;}
        //SpeedBar1.Enabled:=false;
        MessageDlg(TrLangMSG(msgErrorServer),
                            mtError, [mbYes], 0);
      end;

    WorkCtrlEnabled:=DM1.DB_Avar.Connected; // ds

   { if TekUser<>'SYSDBA' then
       Users_mi.Enabled:=false
    else}
    Users_mi.Visible:=(AnsiUpperCase(TekUser) = 'SYSDBA')or(AdminRight); // ds
    N30.Visible:=Users_mi.Visible;
    //
    Backup_mi.Visible:=Users_mi.Visible;
    Restore_mi.Visible:=Users_mi.Visible;
    Restore_mi.Visible:=Users_mi.Visible;
    //
    TableLog_mi.Visible:=Users_mi.Visible;

    Sect:=IntToStr(CodUser);
    mIni:=TIniFile.Create(FullPathIniFlAvar{CurrentDir+'\avar.ini'});
    if not mIni.SectionExists(Sect) then
       Sect:='Default';
    TextCol:=mIni.ReadInteger(Sect,'TextCol',-2147483640);
    MessCol:=mIni.ReadInteger(Sect,'MessCol',16711680);
    ErrCol:=mIni.ReadInteger(Sect,'ErrCol',255);
    BGCol:=mIni.ReadInteger(Sect,'BackGrCol',clBtnFace);
    VvodCol:=mIni.ReadInteger(Sect,'VvodCol',-2147483640);
    VvodBgCol:=mIni.ReadInteger(Sect,'VvodBgCol',clWindow);
    N21.Checked:=mIni.ReadBool('Setup','Clock',true);
    StorProc:=mIni.ReadBool('Setup','StoredProc',false);
    Cl_l:=mIni.ReadInteger('Setup','Left',0);
    Cl_t:=mIni.ReadInteger('Setup','Top',0);
    isAutoVvod:=mIni.ReadBool('Setup','AutoVvod',true);
    UseSecInDate:=mIni.ReadBool('Setup',IdentUseSecInDate,true);
    RaonChar:=mIni.ReadString('Setup','RaonChar','A')[1];
    MyNowFlag:=not mIni.ReadBool('Setup','SystemTimeFlag',true);
    LastMyNow:=StrToDateTime(mIni.ReadString('Setup','LastSystemTime',DateTimeToStr(now)));
    sentlog:=mIni.ReadBool('SentHttp','sentlog',true);
    NewUrl:=mIni.ReadString('SentHttp','NewUrl','http://infoxvod.com.ua/avr-exchange.php?ent=repair&action=add');
    AddUrl:=mIni.ReadString('SentHttp','AddUrl','http://infoxvod.com.ua/avr-exchange.php?ent=stoplist&action=upd');

 DelUrl:=mIni.ReadString('SentHttp','DelUrl','http://infoxvod.com.ua/avr-exchange.php?ent=stoplist&action=del');
    N63.Checked:=not MyNowFlag;
    N35.Checked:=isAutoVvod;
    //
    TB_DelZajav.Visible:=rsDELZAV in RightsSet;
    N62.Visible:=rsDELZAV in RightsSet;
    //
    mIni.Free;

    //ds
    try
      TBL_Const_q.Open;
      S_Brig_q.Open;
      S_Alien_q.Open;
      S_Damg_q.Open;
      S_Sod_q.Open;
      S_Sah_q.Open;
      qry_ObjAtt12.Open;
    except
      //MessageDlg('',mtError,[mbYes],0);
    end;
  end; // with DM1
end;


procedure TFormMain.FormCreate(Sender: TObject);  //tparam
var lang,rasd,fdate:string;
    buff: array [0..19] of char;
    res:boolean;
begin
  {$IFDEF MAP}
  SCREENSHOT_PATH:=ExtractFilePath(Application.ExeName)+'AvarOnMap\temp\1.bmp';
  {$ENDIF}
  FormPlacement1.IniFileName:=FullPathIniFlParams;
  LockForDel:=FALSE;
  GL_Count:=-1; // ds
  AdminRight:=false; // ds
  ResColCount:=0;
  isTest:=false;
  if paramCount>0 then
     begin
      lang:=upper(paramStr(1));
      if lang='TEST' then
         isTest:=true;
     end;
  TekRevs:='-1';
  StorProc:=false;
  FormMain:=Self;
  SL_DopInf:=TStringList.Create;
  isAutoVvod:=true;
  CurrentDir:=GetCurrentDir;
  //RGAppError.ErrorLog:=CurrentDir+'\working.log';
  RGAppError.UserName:='Not Defined';
  //application.OnException := appErr.WriteException;
   res:=true;
   GetLocaleInfo(LOCALE_SYSTEM_DEFAULT,LOCALE_SENGLANGUAGE,buff,20);
   lang:=buff;
   GetLocaleInfo(LOCALE_SYSTEM_DEFAULT,LOCALE_SDATE,buff,20);
   rasd:=buff;
   GetLocaleInfo(LOCALE_SYSTEM_DEFAULT,LOCALE_SSHORTDATE,buff,20);
   fdate:=buff;
   if not((lang='Russian') or (lang='Ukrainian'))then
      begin
          //AppException1.SaveErrString('Bad language driver - '+lang);
          MessageDlg(TrLangMSG(msgErrorCountry)+lang+'!',mtError,
                      [mbYes], 0);
          res:=false;
         end;
{uo формат будет всегда правильным dd.mm.yy  т.к. use vglib.DateTimeFormat
   if rasd<>'.' then
      begin
          //AppException1.SaveErrString('Bad SDATE - '+rasd);
          MessageDlg('Неправильный разделитель даты!',mtError,
                      [mbYes], 0);
          res:=false;
         end;
   if fdate<>'dd.MM.yy' then
      begin
          //AppException1.SaveErrString('Bad date format - '+fdate);
          MessageDlg('Неправильный формат даты: '+fdate+'!',mtError,
                      [mbYes], 0);
          res:=false;
         end;
}
  while FormZast.Timer1.Enabled do application.ProcessMessages;
  FormZast.Free;
  FormZast:=nil;

  BConnect(res);

  WorkCtrlEnabled:=true;
  ActivateKeyboardLayout(CyrLayout,0);
  St:=TFormStatus.Create(FormMain);
  St.Left:=cl_l;
  St.Top:=cl_t;

  if N21.Checked then
    St.Show
  else
    St.Hide;
  CloseStatus:=0;
  ZavToCopy:=0;
  RGAppError.UserName:=NameUser;
  if isTest then
     RGAppError.SaveErrString('Testing mode...');

  AddMenuForAllAtt(NewZav_mi);
  AddMenuForAllAtt(N23);
  AddMenuForAllAtt(N24);
  AddMenuForAllAtt(N52);
  AddMenu(N55);
  AddMenu(N54);
//  AddMenu(N32); 
  AddMenu(N26);
  AddMenu(N27);
  AddMenu(N28);
  AddMenu(N14);
  AddMenu(N31);
  AddMenu(N41);
  AddMenu(rep2);
  AddMenu(N51);
  AddMenu(N56);
  AddMenu(N57);
  AddMenu(N65);
  AddMenu(N66);
  AddMenu(N131);
  AddMenu(N64);
  AddMenu(N71);
  AddMenu(N310);
  AddMenu(N410);
  AddMenu(N411);
  AddMenuForAllAtt(N62);
  AddMenu(N67);
  AddMenu(N81);
  AddMenu(N91);
//  AddMenu(N73);
  AddMenu(N74);
  AddMenu(N76);
  AddMenu(N77);
  AddMenu( mi_RepTZ );
  //AddMenu(N210);
  //
  AddMenu(N83);
  Addmenu(N86); //сводка отключений
//  Addmenu(N87);//пересменка

//  N83.Items[2].Visible:=false;
   Addmenu(N88);
   Addmenu(N132);

   AddMenu(nRepExcavNotFinished2);
   AddMenu(N89);//Ведомость восстановления раскопок
   AddMenu(N133);
  {$IFDEF MAP}
     if FileExists(ExtractFilePath(Application.ExeName)+'AvarOnMap\AvarOnMap.exe') then
      N68.Visible:=True else N68.Visible:=FALSE; 
  {$ELSE}
     N68.Visible:=FALSE;
  {$ENDIF}
end;

procedure TFormMain.N6Click(Sender: TObject);
//var SpForm:TFormSprav;
//    sTit,sField:TstringList;
begin
 // Справочник РЭВСов
 Screen.Cursor:=crHourGlass;
 if not assigned(S_RevsF) then
   S_RevsF:=TS_RevsF.CreateDic(application,'S_REVS','ID', DM1.S_Revs_sur);
 Screen.Cursor:=crDefault;
 ShowDicForm(TForm(S_RevsF));

{  sTit:=TStringList.Create;
  sField:=TStringList.Create;
  sTit.Clear;sTit.Add('РЭВС');
  sField.Clear;sField.Add('NAME_R');
  sTit.Add('CONDITION');
  sField.Add(' ;WHERE ID>0; ');
  SpForm:=TFormSprav.SpravCreate(N6,'DBN_AVAR','s_revs',
  'Справочник РЭВСов',sTit,sField);
  SpForm.ShowModal;}
end;

procedure TFormMain.N7Click(Sender: TObject);
//var SpForm:TFormSprav;
//    sTit,sField:TstringList;
//    tt_str:string;
begin
 // Справочник выполняемых работ
 Screen.Cursor:=crHourGlass;
 if not assigned(S_WorkF) then
   S_WorkF:=TS_WorkF.CreateDic(application,'S_WORK', 'ID',DM1.S_Work_sur);
 Screen.Cursor:=crDefault;
 ShowDicForm(TForm(S_WorkF));

(*  sTit:=TStringList.Create;
  sField:=TStringList.Create;
  sTit.Clear;sTit.Add('Работа');sTit.Add('Ед.измер');
  sField.Clear;sField.Add('NAME_R');sField.Add('ED_IZM');
  {sTit.Add('CONDITION');
  sField.Add(' ;WHERE ID>0; ');
  SpForm:=TFormSprav.SpravCreate(N7,'DBN_AVAR','s_work',
  'Справочник выполняемых работ',sTit,sField);
  SpForm.ShowModal;}

  tt_str:=VvodOl(Self,10,'DBN_AVAR','Выбор места повреждения',
       'select name_r||"                  " vvod,id from s_place where id>0 order by name_r','1',NIL);
  if tt_str<>'' then
      begin

       sTit.Add('CONDITION');
       sField.Add(',FTYPE;WHERE ID>0 AND FTYPE='+tt_str+
           ';,'+tt_str);
       MyOpenSQL(Qry_tmp,'select * from s_place where id='+tt_str);
       tt_str:=Qry_tmp.FieldByName('NAME_R').asString;
       Qry_tmp.Close;
       SpForm:=TFormSprav.SpravCreate(N7,'DBN_AVAR','s_work',
        'Справочник выполняемых работ',sTit,sField);
       SpForm.ShowModal;

      end;
      *)
end;

procedure TFormMain.N8Click(Sender: TObject);
//var SpForm:TFormSprav;
//    sTit,sField:TstringList;
begin
 // Справочник материалов
 Screen.Cursor:=crHourGlass;
 if not assigned(S_MatF) then
   S_MatF:=TS_MatF.CreateDic(application, 'S_MAT', 'ID',DM1.S_Mat_sur);
 Screen.Cursor:=crDefault;
 ShowDicForm(TForm(S_MatF));

{  sTit:=TStringList.Create;
  sField:=TStringList.Create;
  sTit.Clear;sTit.Add('Материал');sTit.Add('Ед.измер');
  sField.Clear;sField.Add('NAME_R');sField.Add('ED_IZM');
  sTit.Add('CONDITION');
  sField.Add(' ;WHERE ID>0; ');
  SpForm:=TFormSprav.SpravCreate(N8,'DBN_AVAR','s_mat',
  'Справочник материалов',sTit,sField);
  SpForm.ShowModal;}
end;

procedure TFormMain.N10Click(Sender: TObject);
begin
  Close;
end;

procedure TFormMain.N11Click(Sender: TObject);
//var SpForm:TFormSprav;
//    sTit,sField:TstringList;
begin
 // Справочник выполняющих работы
 Screen.Cursor:=crHourGlass;
 if not assigned(S_RunwF) then
   S_RunwF:=TS_RunwF.CreateDic(application, 'S_RUNW', 'ID',DM1.S_Runw_sur);
 Screen.Cursor:=crDefault;
 ShowDicForm(TForm(S_RunwF));

{  sTit:=TStringList.Create;
  sField:=TStringList.Create;
  sTit.Clear;sTit.Add('Выполн.работу');
  sField.Clear;sField.Add('NAME_R');
  sTit.Add('CONDITION');
  sField.Add(' ;WHERE ID>0; ');
  SpForm:=TFormSprav.SpravCreate(N11,'DBN_AVAR','s_runw',
  'Справочник выполняющих работы',sTit,sField);
  SpForm.ShowModal;}
end;

procedure TFormMain.N12Click(Sender: TObject);
//var SpForm:TFormSprav;
//    sTit,sField:TstringList;
begin
 // Справочник диаметров
 Screen.Cursor:=crHourGlass;
 if not assigned(S_DiamF) then
   S_DiamF:=TS_DiamF.CreateDic(application, 'S_DIAM', 'ID',DM1.S_Diam_sur);
 Screen.Cursor:=crDefault;
 ShowDicForm(TForm(S_DiamF));

{  sTit:=TStringList.Create;
  sField:=TStringList.Create;
  sTit.Clear;sTit.Add('Диаметр');
  sField.Clear;sField.Add('DIAM');
  sTit.Add('CONDITION');
  sField.Add(' ;WHERE ID>0; ');
  SpForm:=TFormSprav.SpravCreate(N12,'DBN_AVAR','s_diam',
  'Справочник диаметров',sTit,sField);
  SpForm.ShowModal;}
end;

procedure TFormMain.N13Click(Sender: TObject);
//var SpForm:TFormSprav;
//    sTit,sField:TstringList;
begin
 // Справочник местности повреждения
 Screen.Cursor:=crHourGlass;
 if not assigned(S_MestF) then
   S_MestF:=TS_MestF.CreateDic(application, 'S_MEST', 'ID',DM1.S_Mest_sur);
 Screen.Cursor:=crDefault;
 ShowDicForm(TForm(S_MestF));

{  sTit:=TStringList.Create;
  sField:=TStringList.Create;
  sTit.Clear;sTit.Add('Местность');
  sField.Clear;sField.Add('NAME_R');
  sTit.Add('CONDITION');
  sField.Add(' ;WHERE ID>0; ');
  SpForm:=TFormSprav.SpravCreate(N13,'DBN_AVAR','s_mest',
  'Справочник местности повреждения',sTit,sField);
  SpForm.ShowModal;}
end;

procedure TFormMain.S_Place_miClick(Sender: TObject);
//var SpForm:TFormSprav;
//    sTit,sField:TstringList;
begin
 // Справочник места повреждения
 Screen.Cursor:=crHourGlass;
 if not assigned(S_PlaceF) then
   S_PlaceF:=TS_PlaceF.CreateDic(application, 'S_PLACE', 'ID',DM1.S_Place_sur);
 Screen.Cursor:=crDefault;
 ShowDicForm(TForm(S_PlaceF));

{  sTit:=TStringList.Create;
  sField:=TStringList.Create;
  sTit.Clear;sTit.Add('Место');
  sField.Clear;sField.Add('NAME_R');
  sTit.Add('CONDITION');
  sField.Add(' ;WHERE ID>0; ');
  SpForm:=TFormSprav.SpravCreate(N14,'DBN_AVAR','s_place',
  'Справочник места повреждения',sTit,sField);
  SpForm.ShowModal;}
end;

procedure TFormMain.N15Click(Sender: TObject);
//var SpForm:TFormSprav;
//    sTit,sField:TstringList;
begin
 // Справочник заявителей
 Screen.Cursor:=crHourGlass;
 if not assigned(S_ZavF) then
   S_zavF:=TS_zavF.CreateDic(application, 'S_ZAV', 'ID',DM1.S_zav_sur);
 Screen.Cursor:=crDefault;
 ShowDicForm(TForm(S_zavF));

{  sTit:=TStringList.Create;
  sField:=TStringList.Create;
  sTit.Clear;sTit.Add('Заявитель');
  sField.Clear;sField.Add('NAME_R');
  sTit.Add('CONDITION');
  sField.Add(' ;WHERE ID>0; ');
  SpForm:=TFormSprav.SpravCreate(N15,'DBN_AVAR','s_zav',
  'Справочник заявителей',sTit,sField);
  SpForm.ShowModal;}
end;

procedure TFormMain.N16Click(Sender: TObject);
//var SpForm:TFormSprav;
//    sTit,sField:TstringList;
//    tt_str:string;
begin
 // Справочник содержания заявок
{nut a Screen.Cursor:=crHourGlass;
 if not assigned(S_CommentF) then
   S_CommentF:=TS_CommentF.CreateDic(application, 'S_Comment', 'ID',DM1.S_Comment_sur);
 Screen.Cursor:=crDefault;
 ShowDicForm(TForm(S_CommentF));
}
 // Справочник содержания заявок
 Screen.Cursor:=crHourGlass;
 if not assigned(S_SodF) then
   S_SodF:=TS_SodF.CreateDic(application, 'S_SOD', 'ID',DM1.S_Sod_sur);
 Screen.Cursor:=crDefault;
 ShowDicForm(TForm(S_SodF));

{uo
 // Справочник содержания заявок
 Screen.Cursor:=crHourGlass;
 if not assigned(S_SodF) then
   S_SodF:=TS_SodF.CreateDic(application, 'S_SOD', 'ID',DM1.S_Sod_sur);
 Screen.Cursor:=crDefault;
 ShowDicForm(TForm(S_SodF));
}

(*  sTit:=TStringList.Create;
  sField:=TStringList.Create;
  sTit.Clear;sTit.Add('Содержание');
  sField.Clear;sField.Add('NAME_R');
  tt_str:=VvodOl(Self,10,'DBN_AVAR','Выбор типа заявки',
       'select name_r||"                      " vvod,id from s_tzav where id>0 order by name_r','1',NIL);
  if tt_str<>'' then
      begin

       sTit.Add('CONDITION');
       sField.Add(',FTYPE,SAH;WHERE ID>0 AND FTYPE='+tt_str+
           ';,'+tt_str+',-1');
       MyOpenSQL(Qry_tmp,'select * from s_tzav where id='+tt_str);
       tt_str:=Qry_tmp.FieldByName('NAME_R').asString;
       Qry_tmp.Close;
       SpForm:=TFormSprav.SpravCreate(N16,'DBN_AVAR','s_sod',
       'Справочник содержания заявок -'+tt_str,sTit,sField);
       SpForm.ShowModal;
      end;
      *)
end;

procedure TFormMain.N17Click(Sender: TObject);
//var SpForm:TFormSprav;
//    sTit,sField:TstringList;
begin
 // Справочник механизмов
 Screen.Cursor:=crHourGlass;
 if not assigned(S_OborF) then
   S_OborF:=TS_OborF.CreateDic(application, 'S_OBOR', 'ID',DM1.S_Obor_sur);
 Screen.Cursor:=crDefault;
 ShowDicForm(TForm(S_OborF));

{  sTit:=TStringList.Create;
  sField:=TStringList.Create;
  sTit.Clear;sTit.Add('Механизмы');sTit.Add('Номер');
  sField.Clear;sField.Add('NAME_R');sField.Add('NOMER');
  sTit.Add('CONDITION');
  sField.Add(' ;WHERE ID>0; ');
  SpForm:=TFormSprav.SpravCreate(N17,'DBN_AVAR','s_obor',
  'Справочник механизмов',sTit,sField);
  SpForm.ShowModal;}
end;

procedure TFormMain.N18Click(Sender: TObject);
//var SpForm:TFormSprav;
//    sTit,sField:TstringList;
begin
 // Справочник повреждений
 Screen.Cursor:=crHourGlass;
 if not assigned(S_DamgF) then
   S_DamgF:=TS_DamgF.CreateDic(application, 'S_DAMG', 'ID',DM1.S_Damg_sur);
 Screen.Cursor:=crDefault;
 ShowDicForm(TForm(S_DamgF));

{  sTit:=TStringList.Create;
  sField:=TStringList.Create;
  sTit.Clear;sTit.Add('Повреждение');
  sField.Clear;sField.Add('NAME_R');
  sTit.Add('CONDITION');
  sField.Add(' ;WHERE ID>0; ');
  SpForm:=TFormSprav.SpravCreate(N18,'DBN_AVAR','s_damg',
  'Справочник повреждений',sTit,sField);
  SpForm.ShowModal;}
end;

procedure TFormMain.N19Click(Sender: TObject);
//var SpForm:TFormSprav;
//    sTit,sField:TstringList;
begin
 // Справочник типов заявок
 Screen.Cursor:=crHourGlass;
 if not assigned(S_TZavF) then
   S_TZavF:=TS_TZavF.CreateDic(application, 'S_TZAV', 'ID',DM1.S_Tzav_sur);
 Screen.Cursor:=crDefault;
 ShowDicForm(TForm(S_TZavF));

{  sTit:=TStringList.Create;
  sField:=TStringList.Create;
  sTit.Clear;sTit.Add('Тип заявки');
  sTit.Add('Выезд');
  sField.Clear;sField.Add('NAME_R');
  sField.Add('ISVIEZD');
  sTit.Add('CONDITION');
  sField.Add(' ;WHERE ID>0; ');
  SpForm:=TFormSprav.SpravCreate(N19,'DBN_AVAR','s_tzav',
  'Справочник типов заявок',sTit,sField);
  SpForm.ShowModal;}
end;

procedure TFormMain.N21Click(Sender: TObject);
begin
  if N21.Checked then
   begin
    N21.Checked:=false;
    //St.Free;
   end
  else
   begin
    N21.Checked:=true;
    {St:=TFormStatus.Create(FormMain);
    St.Left:=cl_l;
    St.Top:=cl_t;
    St.Show;}
   end;

  St.Visible:=N21.Checked;
end;

procedure TFormMain.NewZav_miClick(Sender: TObject);
var ZvForm:TFormZav;
begin
  {
  OperAtt:=OperAttDetectFromMenuItem(Sender);
    repeat
     if CloseStatus=2 then
       ZvForm:=TFormZav.ZavCreate(Self,tfmZayavCopy,ZavToCopy)
     else
       ZvForm:=TFormZav.ZavCreate(Self,tfmZayavNew,0);
      ZvForm.ShowModal;
    until CloseStatus=0;
   }

  OperAtt:=OperAttDetectFromMenuItem(Sender);
  if dm_Shift.isNeedChangeShift(OperAtt) then
  begin
     Application.MessageBox(PChar(TrLangMSG(msgDoChangeSmen)),
     PChar(TrLangMSG(msgError)),MB_OK+MB_ICONWARNING);
  end
  else
  begin
    repeat
     if CloseStatus=2 then
       ZvForm:=TFormZav_ZavCreate(Self,tfmZayavCopy,ZavToCopy)
     else
       ZvForm:=TFormZav_ZavCreate(Self,tfmZayavNew,0);
      ZvForm.ShowModal;
    until CloseStatus=0;
   end;
end;

procedure TFormMain.N23Click(Sender: TObject);
var ZvForm:TFormZav;
    tt_str:string;
  //  pZvForm:^TFormZav;
    _dop_where:string;
begin
   OperAtt:=OperAttDetectFromMenuItem(sender);
   _dop_where:=' (delz=0) and (id_attach='+IntToStr(Ord(OperAtt))+') and (id_alien<>4) ';
repeat
   tt_str:=VvodOl(Self,10,'DBN_AVAR',TrLangMSG(msgSelNoCloseZajav),
       'select cast(nomer as char(6)) '+
       //||"    "||cast(dt_in as char(20)) '
       ' vvod, '+
       'z.id as id, '+
       '(select rtrim(u.name_r)||" "||rtrim(v.name_r) '+
       ' from s_ulic u,s_vidul v '+
       ' where (u.del in (''-'',''d'')) and (u.id_vidul>-2) and (u.id_vidul=v.id) '+
       '  and (u.id=z.id_ul1)) as ul1, '+
       ' id_ul2, kod_ul, dop_adr,dt_in,id_dopadres,id_object, is_otl '+
       'from nzavjav z '+
       //
       'where '+_dop_where+
       'order by fyear desc,nomer desc',_dop_where,
       '1',OperAtt,FALSE,NIL);

  if tt_str<>'' then
      begin
          F_VVod_CLOSED := FALSE;
          ZvForm:=TFormZav_ZavCreate(Self,tfmZayavAfterInsert,StrToInt(tt_str));
          ZvForm.ShowModal;
          ZvForm.Free;
          ZvForm:=nil;
          if CloseStatus<>0 then
             repeat
               if CloseStatus=2 then
                 ZvForm:=TFormZav_ZavCreate(Self,tfmZayavCopy,ZavToCopy)
               else
                 ZvForm:=TFormZav_ZavCreate(Self,tfmZayavNew,0);
               ZvForm.ShowModal;
               ZvForm.Free;
               ZvForm:=nil;
             until CloseStatus=0;
      end else F_VVod_CLOSED:= TRUE;
until F_VVod_CLOSED;
end;

procedure TFormMain.N24Click(Sender: TObject);
var ZvForm:TFormZav;
    tt_str,_dop_where:string;
begin
 OperAtt:=OperAttDetectFromMenuItem(sender);
 _dop_where:=' (delz=0) and dt_in>"'+DateToStr(Date-1180)+'"  and id_attach='+IntToStr(ord(OperAtt));
repeat
   tt_str:=VvodOl(Self,10,'DBN_AVAR',TrLangMSG(msgSelCloseZajav),
       //
       'select cast(nomer as char(6)) vvod, '+
       'z.id as id, '+
       '(select rtrim(u.name_r)||" "||rtrim(v.name_r) '+
       ' from s_ulic u,s_vidul v '+
       ' where (u.del in (''-'',''d'')) and (u.id_vidul>-2) and (u.id_vidul=v.id) '+
       '  and (u.id=z.id_ul1)) as ul1, '+
       ' id_ul2, kod_ul, dop_adr,dt_in,id_dopadres,id_object , is_otl '+
       'from zavjav z '+
       //
       'where '+_dop_where+' order by fyear desc,nomer desc',_dop_where,
        '1',OperAtt, TRUE,NIL);

  if tt_str<>'' then
      begin
          ZvForm:=TFormZav_ZavCreate(Self,tfmZayavAfterInsert,StrToInt(tt_str));
          OperAtt:=ZvForm.OperateAttach;
          ZvForm.ShowModal;
          F_VVod_CLOSED := False;
          if CloseStatus<>0 then
             repeat
               if CloseStatus=2 then
                 ZvForm:=TFormZav_ZavCreate(Self,tfmZayavCopy,ZavToCopy)
               else
                 ZvForm:=TFormZav_ZavCreate(Self,tfmZayavNew,0);
               ZvForm.ShowModal;
             until CloseStatus=0;
      end
      else F_VVod_CLOSED:= TRUE;
until F_VVod_CLOSED;
end;

procedure TFormMain.N26Click(Sender: TObject);
var FRes:TFormSZ_Nzav;
begin
  if not (Sender=nil) then
  begin
    if not (Sender is TMenuItem) then exit;
    case (Sender as TMenuItem).Tag of
      1: OperAtt := toaVoda;
      2: OperAtt := toaKanal;
      3: OperAtt := toaVRK;
      4: OperAtt := toaObjVoda;
      5: OperAtt := toaObjKanal;
      else
      OperAtt:=toaVoda;
    end;
  end;
  FRes:=TFormSZ_Nzav.SZ_NzavCreate(Self,1);
  with Fres do
  begin
    OperateAttach:=OperAtt;
    case OperAtt of
      toaVoda: Caption:=Caption+' ВОДОПРОВІД ';
      toaKanal: Caption:=Caption+' ВОДОВІДВЕДЕННЯ ';
      toaVRK: Caption:=Caption+' ВРК';
      toaObjVoda: Caption := Caption + ' ОБ''ЕКТИ ВОДОПРОВОДу';
      toaObjKanal: Caption := Caption + ' ОБ''ЕКТи КАНАЛІЗАЦІЇ';
    end;
  end;
   Fres.ShowModal;
end;

function NN(id,col:integer;var ss:string):integer;
var //tt_str:string;
    iii:integer;
//    d:string;
begin
  Result:=1;
  if id<>old_id then
    begin
      MyOpenSQL(FormMain.Qry_tmp,'select distinct s.name_r from works w,s_work s '+
                       'where w.id_zav='+inttostr(id)+' and w.id_work=s.id order by w.id');
      old_id:=id;
      fl:=true;
      TekFl[1]:=true;
      TekFl[0]:=true;
    end;

     if col=7 then
      begin
       if fl then
         begin
           fl:=false;
           MyOpenSQL(FormMain.Qry_tmp2,
           'select count(id) mm from raskop '+
                       'where id_zavin='+inttostr(id));
           iii:=FormMain.Qry_tmp2.FieldByName('MM').asinteger;
           FormMain.Qry_tmp2.Close;
           if iii>0 then
             begin
//              ss:='¦LT¦+¦L=+('+inttostr(iii)+')';
                ss:='РАСКОПАНО('+inttostr(iii)+')';
              MyOpenSQL(FormMain.Qry_tmp2,
               'select count(id) mm from raskop '+
                         'where id_zavout='+inttostr(id));
              iii:=FormMain.Qry_tmp2.FieldByName('MM').asInteger;
              FormMain.Qry_tmp2.Close;
              if iii>0 then
                 begin
                   ss:=ss+'-'+TrLangMSG(msgDigger)+'('+inttostr(iii)+')';
                 end;
             end
           else
             begin
               if FormMain.Qry_tmp.EOF then
                 ss:=''
               else
                 ss:=FormMain.Qry_tmp.FieldByName('NAME_R').asString;
               FormMain.Qry_tmp.Next;
             end;
         end
       else
         begin
           if FormMain.Qry_tmp.EOF then
             ss:=''
           else
             ss:=Strip('B',' ',FormMain.Qry_tmp.FieldByName('NAME_R').asString);

           FormMain.Qry_tmp.Next;
         end;
      end
     else if (col=6) then
      begin
          MyOpenSQL(FormMain.Qry_tmp2,
          'select id,nomer,dop_inf from nnarad where id_zav='
          +inttostr(id)+' order by nomer');
          if not FormMain.Qry_tmp2.eof then
            begin
               FormMain.Qry_tmp2.Last;
               while not FormMain.Qry_tmp2.bof do
                begin
                  if strip('A',' ',FormMain.Qry_tmp2.FieldByName('DOP_INF').asString)<>'' then
                   begin
                    ss:=FormMain.Qry_tmp2.FieldByName('DOP_INF').asString;
                    FormMain.Qry_tmp2.First;
                   end;
                   FormMain.Qry_tmp2.Prior;
                end;
            end;
          ss:=RepChar(#13,' ',strip('A',#10,ss));
          ss:=Word2Tabl(ss,0,23)
      end
     else if (col=2)  then
      begin
        ss:=Word2Tabl(ss,1,150);
      end
     else if id=old_res then
       ss:=''
     else if col=1 then
       ss:=strip('A',' ',ss)
     else if col=5 then
       begin
         if ss='0' then
            ss:='';
       end;

     if col=0
     then ss:=copy(ss,1,length(ss)-3); // без секунд
     if col=3
     then ss:=copy(ss,1,5); // только 5 знаков
     if col=4
     then begin
       ss:=copy(ss,1,25); // 25 знаков
     end;

     if (not FormMain.Qry_tmp.EOF) or TekFl[0] or TekFl[1] then
       Result:=1
     else if col=8 then
       begin
         Result:=0;
         TekWord:=1;
         TekWord2:=1;
         MTekWord[1]:=1;
         MTekWord[0]:=1;
       end;

     if col=8 then
       old_res:=id;

end;

function NN9(id,col:integer;var ss:string):integer;
begin
  if (col=3)
  then begin
    ss:=copy(ss,1,55);
  end;
  Result:=0;
end;


function NN1(id,col:integer;var ss:string):integer;
var tt_str:string;
begin
  Result:=1;
  if id<>old_id then
    begin
      if not Write_All_Works
      then MyOpenSQL(FormMain.Qry_tmp,'select distinct s.name_r from works w,s_work s '+
                             'where w.id_zav='+inttostr(id)+' and w.id_work=s.id order by w.id')
      else MyOpenSQL(FormMain.Qry_tmp,'select s.name_r from works w,s_work s '+
                       'where w.id_zav='+inttostr(id)+' and w.id_work=s.id order by w.id_nar,w.id');
      TekFl[0]:=true;
      TekFl[1]:=true;
      TekFl[2]:=true;
      old_id:=id;
    end;

     if col=6 then
      begin
       if FormMain.Qry_tmp.EOF then
         ss:=''
       else
         ss:=FormMain.Qry_tmp.FieldByName('NAME_R').asString;
       FormMain.Qry_tmp.Next;
      end
     else if col=3 then
      begin
          ss:=RepChar(#13,' ',strip('A',#10,ss));
          tt_str:=ss;
          ss:=ExtractLineFix(TekWord,25,ss);
          inc(TekWord);
          if ExtractLineFix(TekWord,25,tt_str) ='' then
            begin
             fl:=false;
           //  TekWord:=1;
            end
          else
             fl:=true;
       {tt_str:=ss;
       ss:=ExtractWordsx_(TekWord,1,ss,#13#10' .',false);
       inc(TekWord);
       if ExtractWordsx_(TekWord,1,tt_str,#13#10' .',false)='' then
         begin
          fl:=false;
          TekWord:=1;
         end
       else
          fl:=true;}
      end
     else if (col=0)  then
      begin
        ss:=Word2Tabl(ss,0,20);
      end
     else if (col=1)  then
      begin
        ss:=Word2Tabl(ss,1,20);
      end
     else if (col=7)  then
      begin
        ss:=Word2Tabl(ss,2,20);
      end

     else if id=old_res then
       ss:='';
{
     else if col=0 then
       ss:=strip('A',' ',ss);
}
     if (col=5)
     then ss:=copy(ss,1,length(ss)-3); // без секунд

     if (not FormMain.Qry_tmp.EOF) or fl
        or TekFl[0] or TekFl[1]or TekFl[2] then
       Result:=1
     else if col=8 then
      begin
       Result:=0;
       TekWord:=1;
       MTekWord[0]:=1;
       MTekWord[1]:=1;
       MTekWord[2]:=1;
      end;
     if col=8 then
       old_res:=id;

(*  if id<>old_id then
    begin
      old_id:=id;
    end;

     if col=6 then
      begin
       MyOpenSQL(FormMain.Qry_tmp,'select distinct s.name_r from works w,s_work s '+
                'where w.id_zav='+inttostr(id)+' and w.id_work=s.id order by w.id');
       ss:='';
       while not FormMain.Qry_tmp.EOF do
        begin
         ss:=ss+' '+FormMain.Qry_tmp.FieldByName('NAME_R').asString;
         FormMain.Qry_tmp.Next;
        end;
       ss:=FormatMemo(ss,23);
      end
     else if col=5 then
      begin
        ss:=FormatMemo(ss,23);
      end
     else if id=old_res then
       ss:=''
     else if col=0 then
       ss:=strip('A',' ',ss);


     Result:=0;
     if col=8 then
       old_res:=id;*)
end;

{function NN1(id,col:integer;var ss:string):integer;
var tt_str:string;
begin
  Result:=1;
  if id<>old_id then
    begin
      if not Write_All_Works
      then MyOpenSQL(FormMain.Qry_tmp,'select distinct s.name_r from works w,s_work s '+
                             'where w.id_zav='+inttostr(id)+' and w.id_work=s.id order by w.id')
      else MyOpenSQL(FormMain.Qry_tmp,'select s.name_r from works w,s_work s '+
                       'where w.id_zav='+inttostr(id)+' and w.id_work=s.id order by w.id_nar,w.id');
      TekFl[0]:=true;
      TekFl[1]:=true;
      old_id:=id;
    end;

     if col=4 then
      begin
       if FormMain.Qry_tmp.EOF then
         ss:=''
       else
         ss:=FormMain.Qry_tmp.FieldByName('NAME_R').asString;
       FormMain.Qry_tmp.Next;
      end
     else if col=3 then
      begin
          ss:=RepChar(#13,' ',strip('A',#10,ss));
          tt_str:=ss;
          ss:=ExtractLineFix(TekWord,25,ss);
          inc(TekWord);
          if ExtractLineFix(TekWord,25,tt_str) ='' then
            begin
             fl:=false;
           //  TekWord:=1;
            end
          else
             fl:=true;
      end
     else if (col=0)  then
      begin
        ss:=Word2Tabl(ss,0,20);
      end
     else if (col=1)  then
      begin
        ss:=Word2Tabl(ss,1,20);
      end

     else if id=old_res then
       ss:='';
     if (col=5)
     then ss:=copy(ss,1,length(ss)-3); // без секунд

     if (not FormMain.Qry_tmp.EOF) or fl
        or TekFl[0] or TekFl[1] then
       Result:=1
     else if col=8 then
      begin
       Result:=0;
       TekWord:=1;
       MTekWord[0]:=1;
       MTekWord[1]:=1;
      end;
     if col=6 then
       old_res:=id;

end;
}


procedure TFormMain.N27Click(Sender: TObject);
var FRes:TFormSZ_Nzav;
begin
  FRes:=TFormSZ_Nzav.SZ_NzavCreate(Self,2);
  OperAtt:=FRes.OperAttFormFill(sender);
  Fres.ShowModal;
end;

procedure TFormMain.N28Click(Sender: TObject);
var FRes:TFormSZ_Nzav;
begin
  FRes:=TFormSZ_Nzav.SZ_NzavCreate(Self,3);
  OperAtt:=FRes.OperAttFormFill(sender);
  Fres.ShowModal;
end;

function NN2(id,col:integer;var ss:string):integer;
begin
  Result:=1;
  if id<>old_id then
    begin
      if not Write_All_Works
      then MyOpenSQL(FormMain.Qry_tmp,'select distinct s.name_r from works w,s_work s '+
                             'where w.id_zav='+inttostr(id)+' and w.id_work=s.id order by w.id')
      else MyOpenSQL(FormMain.Qry_tmp,'select s.name_r from works w,s_work s '+
                       'where w.id_zav='+inttostr(id)+' and w.id_work=s.id order by w.id_nar,w.id');
      MyOpenSQL(FormMain.Qry_tmp2,
               'select distinct s.name_r||" "||s.ed_izm||" "||cast(m.kol_mat as char(10)) name_r from maters m,s_mat s '+
                                'where m.id_zav='+inttostr(id)+' and m.id_mat=s.id order by m.id');
      old_id:=id;
      TekFl[3]:=true;
      TekFl[2]:=true;
      TekFl[1]:=true;
      TekFl[0]:=true;

      //old_id:=id;
    end;

     if col=6 then
      begin
       if FormMain.Qry_tmp.EOF then
         ss:=''
       else
         ss:=FormMain.Qry_tmp.FieldByName('NAME_R').asString;
       FormMain.Qry_tmp.Next;
      end
     else if col=5 then
      begin
         if FormMain.Qry_tmp2.EOF then
           ss:=''
         else
           ss:=Strip('B',' ',FormMain.Qry_tmp2.FieldByName('NAME_R').asString);
         FormMain.Qry_tmp2.Next;
      end
    else if col=2 then
     begin
          ss:=Word2Tabl(ss,0,20);
     end
    else if col=3 then
     begin
          ss:=Word2Tabl(ss,2,20);
     end
    else if col=8 then
     begin
          ss:=Word2Tabl(ss,3,12);
     end
    else if col=7 then
     begin
            MyOpenSQL(FormMain.Qry_tmp3,
            'select id,nomer,dop_inf from narad where id_zav='
            +inttostr(id)+' order by nomer');
            if not FormMain.Qry_tmp3.eof then
              begin
                 FormMain.Qry_tmp3.Last;
                 while not FormMain.Qry_tmp3.bof do
                  begin
                    if strip('A',' ',FormMain.Qry_tmp3.FieldByName('DOP_INF').asString)<>'' then
                     begin
                      ss:=FormMain.Qry_tmp3.FieldByName('DOP_INF').asString;
                      FormMain.Qry_tmp3.First;
                     end;
                     FormMain.Qry_tmp3.Prior;
                  end;
              end;
          ss:=RepChar(#13,' ',strip('A',#10,ss));
          ss:=Word2Tabl(ss,1,23);
     end
{     else if col=2 then
      begin
       tt_str:=ss;
       ss:=ExtractWordsx_(TekWord,1,ss,#13#10,false);
       inc(TekWord);
       if ExtractWordsx_(TekWord,1,tt_str,#13#10,false)='' then
         begin
          fl:=false;
          TekWord:=1;
         end
       else
          fl:=true;
      end}
     else if id=old_res then
       ss:=''
     else if col=2 then
       ss:=strip('A',' ',ss);

     if (not FormMain.Qry_tmp.EOF) or TekFl[0] or TekFl[1] or
        TekFl[2] or TekFl[3] or
        (not FormMain.Qry_tmp2.EOF) then
       Result:=1
     else if col=9 then
       begin
         Result:=0;
         TekWord:=1;
         MTekWord[0]:=1;
         TekWord2:=1;
         MTekWord[1]:=1;
         MTekWord[2]:=1;
         MTekWord[3]:=1;
       end;

     if col=9 then
         old_res:=id;

end;

function NN3(id,col:integer;var ss:string):integer;
begin
    if col=0 then
       ss:=strip('A',' ',ss);
    Result:=0;
end;

{procedure TFormMain.N29Click(Sender: TObject);
var FProusv:Tsz_proisv;
begin
     FProusv:=Tsz_proisv.Create(Self);
     FProusv.ShowModal;
end;}

function ProvDate(date1,date2:TDateTime;time1,time2:string;date1InSmen:boolean):boolean;
var h1,h2,m1,m2,s1,s2:integer;
    th,tm,ts,tms:word;
    seg,seg_next:TDateTime;
    fl:boolean;

begin
 Result:=false;
 h1:=strtointdef(copy(time1,1,2),-1);
 m1:=strtointdef(copy(time1,4,2),-1);

 h2:=strtointdef(copy(time2,1,2),-1);
 m2:=strtointdef(copy(time2,4,2),-1);

 s1:=strtointdef(copy(time1,7,2),-1);
 s2:=strtointdef(copy(time2,7,2),-1);

 if (date1<date2) or (date2=0) then
    Result:=true
 else if date1=date2 then
   begin
     if h1<h2 then
        Result:=true
     else if h1=h2 then
        begin
          if m1<m2 then
             Result:=true
          else if m1=m2 then
           result:=(s1<=s2);  
        end;
   end;

 if not Result then
    MessageDlg(TrLangMSG(msgDataEndLTBegin),mtError, [mbYes], 0);
 if Result then
   begin
      seg:=Now;
	  
      if date1InSmen then seg_next:=Date()+1.3333 //Дата выезда по завьтрашнюю смену
        else seg_next:=seg; // 8:000
      Result:=false;
      DecodeTime(seg_next,th,tm,ts,tms);
      if date1<int(seg_next) then
         Result:=true
      else if date1=int(seg_next) then
        begin
           if (h1<th) or ((h1=th) and (m1<=tm)) then
              Result:=true;
        end;
      DecodeTime(seg,th,tm,ts,tms);
      fl:=false;
      if date2<int(seg) then
         fl:=true
      else if date2=int(seg) then
        begin
           if (h2<th) or ((h2=th) and (m2<=tm)) then
              fl:=true;
        end;

      Result:=Result and fl;
      if not Result then
         MessageDlg(TrLangMSG(msgDataTimeGRTemp),mtError, [mbYes], 0);
   end;
end;

procedure TFormMain.Users_miClick(Sender: TObject);
var
  //Admm:TFormAdm;
  _AvrAdminManager: TAvrAdminManager;
begin
//   Admm:=TFormAdm.Create(Self);
//   Admm.ShowModal;
  inherited;
  Enabled := false;
  _AvrAdminManager := TAvrAdminManager.Create('AVARZHYTOMYR', 'masterkey');
  try
    Screen.Cursor := crSQLWait;
    _AvrAdminManager.OnEndLoad := OnEndLoadAvrAdmin;
    _AvrAdminManager.Show;
  finally
    Enabled := true;
    Screen.Cursor := crDefault;
    _AvrAdminManager.Free;
  end;
end;

procedure TFormMain.N20Click(Sender: TObject);
var
 i :integer;
begin
 for i:=0 to application.ComponentCount-1 do
  if (application.Components[i] is TForm)and
     (application.Components[i].name <> 'FormMain')and
     (application.Components[i].name <> 'ZastFrm')
     then TForm(application.Components[i]).close;

 BConnect(true, false);
 {28.09.2004}
 Width:=Screen.Width;
 Height:=Screen.Height;
 ShowWindow(handle,SW_MAXIMIZE);
 {/28.09.2004}
end;

procedure UstColors(AOwner: TComponent);
var OwnerForm:TForm;
    i{,j}:integer;
begin
 OwnerForm:=TForm(AOwner);
 OwnerForm.Color:=BgCol;
 OwnerForm.Font.Color:=TextCol;
 for i:=0 to OwnerForm.ControlCount-1 do
   begin
     if OwnerForm.Controls[i] is TLabel then
        TLabel(OwnerForm.Controls[i]).Font.Color:=TextCol
     else if OwnerForm.Controls[i] is TCheckBox then
        TCheckBox(OwnerForm.Controls[i]).Font.Color:=TextCol
     else if OwnerForm.Controls[i] is TBitBtn then
        TBitBtn(OwnerForm.Controls[i]).Font.Color:=TextCol
     else if OwnerForm.Controls[i] is TRadioButton then
        TRadioButton(OwnerForm.Controls[i]).Font.Color:=TextCol
     else if OwnerForm.Controls[i] is TEdit then
        begin
          TEdit(OwnerForm.Controls[i]).Font.Color:=VvodCol;
          TEdit(OwnerForm.Controls[i]).Color:=VvodBGCol;
        end
     else if OwnerForm.Controls[i] is TSpinEdit then
        begin
          TSpinEdit(OwnerForm.Controls[i]).Font.Color:=VvodCol;
          TSpinEdit(OwnerForm.Controls[i]).Color:=VvodBGCol;
        end
     else if OwnerForm.Controls[i] is TComboBox then
        begin
          TComboBox(OwnerForm.Controls[i]).Font.Color:=VvodCol;
          TComboBox(OwnerForm.Controls[i]).Color:=VvodBGCol;
        end
     else if OwnerForm.Controls[i] is TDateEdit then
        begin
          TDateEdit(OwnerForm.Controls[i]).Font.Color:=VvodCol;
          TDateEdit(OwnerForm.Controls[i]).Color:=VvodBGCol;
        end
     else if OwnerForm.Controls[i] is TRxDBGrid then
        begin
          TRxDBGrid(OwnerForm.Controls[i]).Font.Color:=VvodCol;
          TRxDBGrid(OwnerForm.Controls[i]).Color:=VvodBGCol;
        end
     else if OwnerForm.Controls[i] is TDateTimePicker then
        begin
          TDateTimePicker(OwnerForm.Controls[i]).Font.Color:=VvodCol;
          TDateTimePicker(OwnerForm.Controls[i]).Color:=VvodBGCol;
        end
     else if OwnerForm.Controls[i] is TMaskEdit then
        begin
          TMaskEdit(OwnerForm.Controls[i]).Font.Color:=VvodCol;
          TMaskEdit(OwnerForm.Controls[i]).Color:=VvodBGCol;
        end
     else if OwnerForm.Controls[i] is TRichEdit then
        begin
          TRichEdit(OwnerForm.Controls[i]).Font.Color:=VvodCol;
          TRichEdit(OwnerForm.Controls[i]).Color:=VvodBGCol;
        end
     else if OwnerForm.Controls[i] is TMemo then
        begin
          TMemo(OwnerForm.Controls[i]).Font.Color:=VvodCol;
          TMemo(OwnerForm.Controls[i]).Color:=VvodBGCol;
        end
     else if OwnerForm.Controls[i] is TListBox then
        begin
          TListBox(OwnerForm.Controls[i]).Font.Color:=VvodCol;
          TListBox(OwnerForm.Controls[i]).Color:=VvodBGCol;
        end
     else if OwnerForm.Controls[i] is TRxDBLookupCombo then
       begin
        TRxDBLookupCombo(OwnerForm.Controls[i]).Font.Color:=VvodCol;
        TRxDBLookupCombo(OwnerForm.Controls[i]).Color:=VvodBgCol;
       end
     else if OwnerForm.Controls[i] is TGroupBox then
        begin
          UstColors(TGroupBox(OwnerForm.Controls[i]));
        end
     else if OwnerForm.Controls[i] is TPanel then
        begin
          UstColors(TPanel(OwnerForm.Controls[i]));
        end;
   end;
end;

function NN4(id,col:integer;var ss:string):integer;
//var i:integer;
var
  StrAttach4:string;
begin
   StrAttach4:=' and (z.id_attach='+IntToStr(ord(FormMain.OperAtt))+')';
    if col=0 then
     begin
       ss:=strip('A','-',ss);
       MyOpenSQL(FormMain.Qry_tmp,'select * from s_revs where id='+ss);
       TekRevs:=ss;
       ss:=FormMain.Qry_tmp.FieldByName('NAME_R').asString;
       FormMain.Qry_tmp.Close;
     end
    else if col=1 then
     begin
       FormSah.Frm_Dt.min_dt:='dt_in';
       FormSah.Frm_Dt.max_dt:='dt_in';
       MyOpenSQL(FormMain.Qry_tmp,'select count(id) mm from zavjav z where (delz=0 and (is_otl is null or is_otl<>1))  and id_revs='
                                  +TekRevs+StrAttach4+FormSah.Frm_Dt.SQLStr);
       ss:=FormMain.Qry_tmp.FieldByName('MM').asString;
       FormSah.Frm_Dt.min_dt:='dt_in';
       FormSah.Frm_Dt.max_dt:='dt_in';
       MyOpenSQL(FormMain.Qry_tmp,'select count(id) mm from nzavjav z where (delz=0 and (is_otl is null or is_otl<>1) ) and id_revs='
                                   +TekRevs+StrAttach4+FormSah.Frm_Dt.SQLStr);
       ss:=inttostr(strtointdef(ss,0)+strtointdef(FormMain.Qry_tmp.FieldByName('MM').asString,0));
       cn1:=strtointdef(ss,0);
       FormMain.Qry_tmp.Close;
     end
    else if col=2 then
     begin
       if GL_Count > 0 then // ds
          ss:=FloatToStrF(cn1*100/GL_Count,ffGeneral,3,2)
       else if cn<>0 then
              ss:=inttostr((cn1*100) div cn)
             else
               ss:='0';
     end
    else if (col=3) or (col=5) or (col=7){ or (col=9)} then
     begin
       FormSah.Frm_Dt.min_dt:='dt_in';
       FormSah.Frm_Dt.max_dt:='dt_in';
       MyOpenSQL(FormMain.Qry_tmp,'select count(id) mm from zavjav z where (delz=0 and (is_otl is null or is_otl<>1) ) and id_revs='+TekRevs+StrAttach4+
       FormSah.Frm_Dt.SQLStr+ ' and id_tzav'+ss);
       ss:=FormMain.Qry_tmp.FieldByName('MM').asString;
       FormMain.Qry_tmp.Close;
       if col=3 then
         old_id:=old_id+strtointdef(ss,0)
       else if col=5 then
         old_res:=old_res+strtointdef(ss,0)
       else if col=7 then
         old_resR:=old_resR+strtointdef(ss,0)
       else
         old_cn:=old_cn+strtointdef(ss,0);
     end
    else if (col=4) or (col=6) or (col=8) or (col=10) then
     begin
       FormSah.Frm_Dt.min_dt:='dt_in';
       FormSah.Frm_Dt.max_dt:='dt_in';
       MyOpenSQL(FormMain.Qry_tmp,'select count(id) mm from nzavjav z where (delz=0 and (is_otl is null or is_otl<>1) ) and id_revs='+TekRevs+StrAttach4+
       FormSah.Frm_Dt.SQLStr+ ' and id_tzav'+ss);
       ss:=FormMain.Qry_tmp.FieldByName('MM').asString;
       FormMain.Qry_tmp.Close;
       if col=4 then
         old_idN:=old_idN+strtointdef(ss,0)
       else if col=6 then
         old_resN:=old_resN+strtointdef(ss,0)
       else if col=8 then
         old_resNR:=old_resNR+strtointdef(ss,0)
       else
         old_cnN:=old_cnN+strtointdef(ss,0);
     end;
    Result:=0;
end;

procedure ButVis(AOwner: TComponent;vis:boolean);
var OwnerForm:TForm;
    i:integer;
begin
 OwnerForm:=TForm(AOwner);
 for i:=0 to OwnerForm.ControlCount-1 do
   begin
     if OwnerForm.Controls[i] is TBitBtn then
      begin
        if TBitBtn(OwnerForm.Controls[i]).Tag<>555 then
          TBitBtn(OwnerForm.Controls[i]).Visible:=vis;
      end;
   end;
end;

procedure TFormMain.N33Click(Sender: TObject);
//var SpForm:TFormSprav;
//    sTit,sField:TstringList;
begin
 // Справочник чужих заявок
 Screen.Cursor:=crHourGlass;
 if not assigned(S_AlienF) then
   S_AlienF:=TS_AlienF.CreateDic(application, 'S_ALIEN', 'ID',DM1.S_Alien_sur);
 Screen.Cursor:=crDefault;
 ShowDicForm(TForm(S_AlienF));

{  sTit:=TStringList.Create;
  sField:=TStringList.Create;
  sTit.Clear;sTit.Add('Колонка');
  sField.Clear;sField.Add('NAME_R');
  sTit.Add('CONDITION');
  sField.Add(' ;WHERE ID>0; ');
  SpForm:=TFormSprav.SpravCreate(N33,'DBN_AVAR','s_alien',
  'Справочник чужих заявок',sTit,sField);
  SpForm.ShowModal;}
end;
(*
function NN5(id,col:integer;var ss:string):integer;
//var i:integer;
begin
    if col=0 then
     begin
       ss:=strip('A','-',ss);
       MyOpenSQL(FormMain.Qry_tmp,'select * from s_revs where id='+ss);
       TekRevs:=ss;
       ss:=FormMain.Qry_tmp.FieldByName('NAME_R').asString;
       FormMain.Qry_tmp.Close;
     end
    else if col=1 then
     begin
       MyOpenSQL(FormMain.Qry_tmp,'select sum(m.kol_mat) mm from maters m,zavjav z where '
       +'m.id_mat='+FormSah.Qry_mat.FieldByName('ID').asString+
       ' and m.id_zav=z.id and z.dt_in >="'+FormSah.DE_in.Text+' '+Time2str(FormSah.TE_in.Time)+
               '" and dt_in<="'+FormSah.DE_out.Text+' '+Time2str(FormSah.TE_out.Time)+
       '" and z.id_to=-'+TekRevs);
       ss:=inttostr(FormMain.Qry_tmp.FieldByName('MM').asInteger);
       cn1:=strtointdef(ss,0);
       FormMain.Qry_tmp.Close;
     end
    else if col=2 then
     begin
       if cn<>0 then
         ss:=inttostr((cn1*100) div cn)
       else
         ss:='0';
     end;
    Result:=0;
end;

function NN6(id,col:integer;var ss:string):integer;
//var i:integer;
begin
    if col=0 then
     begin
       ss:=strip('A','-',ss);
       MyOpenSQL(FormMain.Qry_tmp,'select * from s_diam where id='+ss);
       TekRevs:=ss;
       ss:=FormMain.Qry_tmp.FieldByName('DIAM').asString;
       FormMain.Qry_tmp.Close;
     end
    else if col=1 then
     begin
       MyOpenSQL(FormMain.Qry_tmp,'select sum(m.kol_mat) mm from maters m,zavjav z where m.id_diam='+TekRevs+
       ' and m.id_mat='+FormSah.Qry_mat.FieldByName('ID').asString+
       ' and m.id_zav=z.id and z.dt_in >="'+FormSah.DE_in.Text+' '+Time2str(FormSah.TE_in.Time)+
       '" and z.dt_in<="'+FormSah.DE_out.Text+' '+Time2str(FormSah.TE_out.Time)+
       '"');
       ss:=inttostr(FormMain.Qry_tmp.FieldByName('MM').asInteger);
       cn1:=strtointdef(ss,0);
       FormMain.Qry_tmp.Close;
     end
    else if col=2 then
     begin
       if cn<>0 then
         ss:=inttostr((cn1*100) div cn)
       else
         ss:='0';
     end;
    Result:=0;
end;
  *)
function NN7(id,col:integer;var ss:string):integer;
//var i:integer;
begin
    if col=0 then
     begin
       MyOpenSQL(FormSah.Qry_tmp,'select * from s_revs where id>0 order by name_r');
       cn1:=0;
       inc(old_id);
     end
    else if col={FormResult.StrGr_res.}ResColCount-2 then
     begin
       ss:=inttostr(cn1);
       //FormSah.mm_revs[old_id]:=FormSah.mm_revs[old_id]+cn1;}
       inc(old_id);
     end
    else
     begin
       MyOpenSQL(FormMain.Qry_tmp,'select count(id) mm from zavjav z where (delz=0) and id_revs='+
       FormSah.Qry_tmp.FieldByName('ID').asString+
       ' and id_sod='+inttostr(id)+FormSah.frm_dt.sqlstr);
//       {' and dt_in >="'+FormSah.DE_in.Text+' '+Time2str(FormSah.TE_in.Time)+
  //             '" and dt_in<="'+FormSah.DE_out.Text+' '+Time2str(FormSah.TE_out.Time)+
    //           '"}{' and '+FormSah.tt_ras+' exists (select * from works where id_zav=z.id and id_work=206)'});
       if FormMain.Qry_tmp.FieldByName('MM').asInteger>0 then
          ss:=FormMain.Qry_tmp.FieldByName('MM').asString
       else
          ss:='';
       //FormSah.mm_revs[old_id]:=FormSah.mm_revs[old_id]+FormMain.Qry_tmp.FieldByName('MM').asInteger;
       cn1:=cn1+FormMain.Qry_tmp.FieldByName('MM').asInteger;
       FormMain.Qry_tmp.Close;
       inc(old_id);
       FormSah.Qry_tmp.Next;
     end;
    Result:=0;
end;


procedure TekMas20;
var i:integer;
begin
  for i:=0 to 50 do
    begin
      MTekWord[i]:=1;
      TekFl[i]:=false;
    end;
end;

function Word2Tabl(ss:string;nomerMas,dlin:integer):string;
var ret:string;
begin
    ret:=ExtractLineFix(MTekWord[nomerMas],dlin,ss);
    inc(MTekWord[nomerMas]);
    if not TekFl[nomerMas] then
        ret:='';
    if ExtractLineFix(MTekWord[nomerMas],dlin,ss) ='' then
       TekFl[nomerMas]:=false
    else
       TekFl[nomerMas]:=true;
   Result:=ret;
end;

function FormatMemo(ss:string;dlin:integer):string;
var ret,tt:string;
    nomer:integer;
begin
    ss:=RepChar(#13,' ',strip('A',#10,ss));
    ret:='';nomer:=1;tt:='';
    repeat
      tt:=ExtractLineFix(nomer,dlin,ss);
      if tt<>'' then
        ret:=ret+tt+#13#10;
      inc(nomer);
    until tt='';
   Result:=ret;
end;

procedure TFormMain.N34Click(Sender: TObject);
var PrVib:TProizZForm;
    ZvForm:TFormZav;
begin
{
  if not (Sender=nil) then
  begin
    if not (Sender is TMenuItem) then exit;
    OperAtt:=(Sender as TMenuItem).Tag;
  end;
  if not OperAtt in [1,2] then OperAtt:=1;
}
   PrVib:=TProizZForm.Create(Self);
   CloseStatus:=0;
   PrVib.ShowModal;
         if CloseStatus<>0 then
          begin
               repeat
                 if CloseStatus=2 then
                   ZvForm:=TFormZav_ZavCreate(Self,tfmZayavCopy,ZavToCopy)
                 else
                   ZvForm:=TFormZav_ZavCreate(Self,tfmZayavNew,0);
                 ZvForm.ShowModal;
               until CloseStatus=0;
          end;
end;

procedure TFormMain.old_SI_newClick(Sender: TObject);
begin
  SmartPopupForAllAtt(NewZav_miClick,SI_new);
end;

procedure TFormMain.old_SI_zakClick(Sender: TObject);
begin
 //SmartPopup(N24Click,SI_zak);
 SmartPopupForAllAtt(N24Click,SI_zak);
end;

procedure TFormMain.old_SI_nzakClick(Sender: TObject);
begin
  //SmartPopup(N23Click,SI_nzak);
  SmartPopupForAllAtt( N23Click, SI_nzak );
end;

procedure TFormMain.old_SI_ProizClick(Sender: TObject);
begin
  N34Click(Self);
end;

procedure TFormMain.old_SI_nzperClick(Sender: TObject);
begin
  SmartPopup(N26Click,SI_nzper);
end;

procedure TFormMain.old_SI_fproisClick(Sender: TObject);
begin
//  N29Click(Self);
  new1Click(Self)
end;

procedure TFormMain.old_SI_newusClick(Sender: TObject);
begin
  N20Click(Self);
end;

procedure TFormMain.old_SI_exitClick(Sender: TObject);
begin
NROpenShiftDepsClick(Self);
//  N10Click
end;

function FindInSL(ss:string;SL:TStringList;cnt:integer):integer;
var i:integer;
begin
   Result:=-1;
   ss:=upper(ss);
   if cnt>SL.Count-1 then
      cnt:=SL.Count-1;
   for i:=0 to cnt do
     begin
       if (ss<>'') and (upper(first(length(ss),SL.Strings[i]))=ss) then
          begin
             Result:=i;
             break;
          end;
     end;

end;

procedure InsertInSL(ss:string;var SL:TStringList;mxcnt:integer);
var i:integer;
begin
  if isAutoVvod and (length(ss)>5) then
   begin
    i:=FindInSl(ss,SL,mxcnt-1);
    if i>=0 then
      SL.Exchange(0,i)
    else
      SL.Insert(0,ss);
    while mxcnt<SL.Count do
      begin
        SL.Delete(SL.Count-1);
      end;
   end;
end;

procedure ChangInEdit(var Ed:TCustomEdit;mxcnt:integer);
var num,old_cur,s_beg,s_end:integer;   // tnotifyevent

    tt_str:string;
begin
 if isAutoVvod then
  begin
   old_cur:=Ed.SelStart;
   s_beg:=Ed.SelStart;
   while s_beg>1 do
     begin
          if copy(Ed.Text,s_beg,1)=#10 then
           begin
            inc(s_beg,1);
            break;
           end;
          dec(s_beg);
     end;
   tt_str:=copy(Ed.Text,s_beg,33000);
   s_end:=pos(#13,tt_str);
   if s_end=0 then
         s_end:=33000;

   Ed.SelStart:=s_beg-1;
   Ed.SelLength:=s_end-s_beg;
   tt_str:=Ed.SelText;
   num:=FindInSL(tt_str,SL_DopInf,mxcnt);
   if num>=0 then
    begin
      Ed.SelText:=SL_DopInf.Strings[num];
      Ed.SelStart:=old_cur;
      Ed.SelLength:=Length(SL_DopInf.Strings[num])-Length(tt_str);
    end
   else
    begin
      Ed.SelStart:=old_cur;
      Ed.SelLength:=0;
    end;
   Ed.Modified:=false;
  end;

end;

procedure AutoVvodOn(ed:TCustomEdit);
begin
    isAutoVvod:=true;
    ChangInEdit(Ed,100);
end;

procedure AutoVvodOff(ed:TCustomEdit);
begin
    isAutoVvod:=false;
    Ed.SelLength:=0;
end;


{

       if FormMain.Qry_tmp.EOF and fl2 then
         begin
          fl2:=false;
          MyOpenSQL(FormMain.Qry_tmp2,
           'select count(id) mm from raskop '+
                       'where id_zavin='+inttostr(id));
           iii:=FormMain.Qry_tmp2.FieldByName('MM').asinteger;
           FormMain.Qry_tmp2.Close;
           if iii>0 then
             begin
              ss:='РАСКОПАНО('+inttostr(iii)+')';
              MyOpenSQL(FormMain.Qry_tmp2,
               'select count(id) mm from raskop '+
                         'where id_zavin='+inttostr(id));
              iii:=FormMain.Qry_tmp2.FieldByName('MM').asInteger;
              FormMain.Qry_tmp2.Close;
              if iii>0 then
                 begin
                   ss:=ss+'-ЗАКОПАНО('+inttostr(iii)+')';
                 end;
             end
           else
             ss:='';
         end;
}

procedure TFormMain.N35Click(Sender: TObject);
begin
  isAutoVvod:=not isAutoVvod;
  N35.Checked:=isAutoVvod;
end;

procedure TFormMain.N37Click(Sender: TObject);
var AnKvart:TAnFormKvart;
begin
  AnKvart:=TAnFormKvart.Create(Self);
  AnKvart.ShowModal;
end;

function MyNPos(const C: string; S: string; N: Integer): Integer;
var
  I, P, K: Integer;
begin
  Result := 0;
  K := 0;
  for I := 1 to N do begin
    P := Pos(C, S);
    Inc(K, P);
    if {(I = N) and} (P > 0) then begin
      Result := K;
      //Exit;
    end;
    if P > 0 then Delete(S, 1, P)
    else Exit;
  end;
end;

procedure TFormMain.N38Click(Sender: TObject);
var AnUl:TAnFormStreet;
begin
  AnUl:=TAnFormStreet.Create(Self);
  AnUl.ShowModal;
end;

function NN8(id,col:integer;var ss:string):integer;
var id_dmg:integer;
begin
  if col=1 then
   begin
     if StorProc then
       with AnFormStreet.FrmDt_ul do
        begin
           MyOpenSQL(FormMain.Qry_tmp,'select my_count mm from '+
           'cnt_damg2ul('+inttostr(id)+',"'+ss+'","'+DE_in.Text+' '+Time2Str(TE_in.Time)+
            '","'+DE_out.Text+' '+Time2Str(TE_out.Time)+'")');
        end // if StorProc ...
     else begin
       id_dmg:=strtointdef(copy(ss,pos('#',ss)+1,10),0);
       MyOpenSQL(FormMain.Qry_tmp,'select count(id) mm from zavjav '+
                   'where (delz=0) and id_ul1='+inttostr(id)
                    +' and id_damg='+inttostr(id_dmg)
                    +' and kod_ul=0 and id_ul2="'+PadLeft(ss,8,' ')+'" '+{'and '+}
                    AnFormStreet.FrmDt_Ul.SQLStr);
(*       MyOpenSQL(FormMain.Qry_tmp,'select count(id) mm from zavjav '+
                   'where id_ul1='+inttostr(id)
                    +' and kod_ul=0 and id_ul2="'+PadLeft(ss,8,' ')+'" '+{'and '+}
                    AnFormStreet.FrmDt_Ul.SQLStr);
  *)   end;
     ss:=FormMain.Qry_tmp.FieldByName('MM').asString;
     FormMain.Qry_tmp.Close;
   end; // if col=1 ...
   // else if col = 2{повреждение(коррозия, расстройство стыков ...)} then

  Result:=0;
end;

procedure TFormMain.new1Click(Sender: TObject);
var FProusv:TSz_proizv2;
begin
 FProusv:=TSz_proizv2.Create(Self);
 FProusv.ShowModal;
end;

procedure TFormMain.CompareRefer_miClick(Sender: TObject);
begin
 if not assigned(CompZReferF)
   then CompZReferF:=TCompZReferF.Create(application);             
 CompZReferF.Show;
 if CompZReferF.WindowState = wsMinimized
    then CompZReferF.WindowState:=wsNormal;
 SetForegroundWindow(CompZReferF.Handle);
end;

//*******************************************************************
procedure TFormMain.SetWorkCtrlEnabled(fl :boolean);
begin
 // меню
 N3.Enabled:=fl;
 N25.Enabled:=fl;
 Dic_mi.Enabled:=fl;
 N4.Enabled:=fl;
 N36.Enabled:=fl;
 // toolbar
 if not fl then SI_new.Enabled:=false;
 SI_zak.Enabled:=fl;
 SI_nzak.Enabled:=fl;
 SI_Proiz.Enabled:=fl;
 SI_nzper.Enabled:=fl;
 SI_fprois.Enabled:=fl;
// SI_univ.Enabled:=fl;

 ToolButton2.Enabled:=fl;
end;

//*******************************************************************
procedure TFormMain.SetCanEdidDic(fl :boolean);
begin
 FCanEdidDic:=fl;
end;

//*******************************************************************
procedure TFormMain.N14Click(Sender: TObject);
begin
  if not assigned(Rep1F) then
   Rep1F:=TRep1F.Create(application);
  OperAtt:=Rep1F.OperAttFormFill(sender);
  ShowDicForm(TForm(Rep1F), false);
end;

//*******************************************************************
procedure TFormMain.rep2Click(Sender: TObject);
begin
  if not assigned(Rep2F) then
   Rep2F:=TRepMatF.Create(application);
  OperAtt:=Rep2F.OperAttFormFill(sender);
  ShowDicForm(TForm(Rep2F), false);
end;

//*******************************************************************
procedure TFormMain.N31Click(Sender: TObject);
begin
 if not assigned(Rep3F) then
   Rep3F:=TRep3F.Create(application);
 OperAtt:=Rep3F.OperAttFormFill(sender);
 ShowDicForm(TForm(Rep3F), false);
end;

//*******************************************************************
procedure TFormMain.N41Click(Sender: TObject);
begin
 if not assigned(Rep4F) then
   Rep4F:=TRep4F.Create(application);
 OperAtt:=Rep4F.OperAttFormFill(sender);
 ShowDicForm(TForm(Rep4F), false);
end;

//*******************************************************************
procedure TFormMain.Nastr_miClick(Sender: TObject);
begin
 NastrF.Translate;
 ShowDicForm(NastrF);
 if NastrF.RB_langUA.Checked
 then LANG:=ltUA else LANG:=ltRU;
 Translate;
 SetFocus
end;

//*******************************************************************
procedure TFormMain.FormShow(Sender: TObject);
begin
{ if not assigned(NastrF) then
   NastrF:=TNastrF.Create(application);}
  if not F_term then
  begin
    SetHift();
    AddMenuShift(N87);
  end;  
end;

//*******************************************************************
procedure TFormMain.getFormPlacement;
begin
 NastrF.ReadAllData;

 if NastrF.RB_langUA.Checked
 then LANG:=ltUA else LANG:=ltRU;
 Translate;

 if NastrF.MainFPlacement_chb.Checked
    then begin
          FormPlacement1.IniFileName:=FullPathIniFlParams;
          FormPlacement1.IniSection:=IntToStr(CodUser);
          FormPlacement1.RestoreFormPlacement
         end
   else begin
         Top:=0;
         Left:=0;
         Width:=Screen.Width;
         ClientHeight:=SBM.Height + CoolBar1.Height;
        end;
 { Constraints.MinHeight:=Height; // ds
  Constraints.MaxHeight:=Constraints.MinHeight; // ds}
end;

//*******************************************************************
procedure TFormMain.setFormPlacement;
begin
 NastrF.ReadAllData;
 if NastrF.MainFPlacement_chb.Checked
    then begin
           FormPlacement1.IniFileName:=FullPathIniFlParams;
           FormPlacement1.IniSection:=IntToStr(CodUser);
           FormPlacement1.SaveFormPlacement;
         end;
        
end;

//*******************************************************************
procedure TFormMain.TableLog_miClick(Sender: TObject);
begin
 // История изменений
 Screen.Cursor:=crHourGlass;
 if not assigned(TableLogF) then
   TableLogF:=TTableLogF.CreateDic(application, 'TableLog','ID',DM1.TableLog_sur);
 Screen.Cursor:=crDefault;
 ShowDicForm(TForm(TableLogF));
end;

//*******************************************************************
procedure TFormMain.atmInterf1ShowPassprt(Sender: TObject; z_id: Integer);
var
 ZvForm :TFormZav;
begin
   ZvForm:=TFormZav_ZavCreate(Self,tfmZayavAfterInsert,z_id);
   ZvForm.ShowModal;
   ZvForm.Free;
end;

//*******************************************************************
procedure TFormMain.Map_miClick(Sender: TObject);
begin
{ if not isMapConnected then
    begin
     atmInterf1.Connect;
     isMapConnected:=true;
     Map_mi.caption:=TrLangMSG(msgDelMap);
    end
      else begin
            isMapConnected:=false;
            atmInterf1.Disconnect;
            Map_mi.caption:=TrLangMSG(msgAddMap);
           end;}
end;

//*******************************************************************
procedure TFormMain.atmInterf1GetSQLQuery(Sender: TObject;
                                    var FileName: OleVariant);
 var
   FProusv:TSz_proizv2;
begin
 FProusv:=TSz_proizv2.Create(Self);
 FProusv.out_file:=FileName;
 FProusv.ShowModal;
 FProusv.Free;
end;

//*******************************************************************
procedure TFormMain.N1Click(Sender: TObject);
begin
 // Справочник Административных районов
 Screen.Cursor:=crHourGlass;
 if not assigned(S_RayonsF) then
   S_RayonsF:=TS_RayonsF.CreateDic(application,'S_RAYON','ID', DM1.S_Rayons_sur);
 Screen.Cursor:=crDefault;
 ShowDicForm(TForm(S_RayonsF));
end;

procedure TFormMain.N2Click(Sender: TObject);
begin
 // Справочник улиц
 Screen.Cursor:=crHourGlass;
 if not assigned(S_UlicF) then
   S_UlicF:=TS_ulicF.CreateDic(application,'S_ULIC', 'ID',DM1.S_Ulic_sur);
 Screen.Cursor:=crDefault;
 ShowDicForm(TForm(S_ulicF));
end;

procedure TFormMain.N5Click(Sender: TObject);
begin
 // Справочник видов улиц
 Screen.Cursor:=crHourGlass;
 if not assigned(S_vidulF) then
   S_vidulF:=TS_vidulF.CreateDic(application,'S_vidul','ID', DM1.S_vidul_sur);
 Screen.Cursor:=crDefault;
 ShowDicForm(TForm(S_vidulF));
end;

procedure TFormMain.DictNotHideClick(Sender: TObject);
begin
  inherited;
  DictNotHide.checked:=not DictNotHide.checked
end;

procedure TFormMain.N42Click(Sender: TObject);
begin
  inherited;
   // Справочник видов течи
   Screen.Cursor:=crHourGlass;
   if not assigned(S_LeakF) then
     S_LeakF:=TS_LeakF.CreateDic(application,'S_Leak','ID', DM1.S_Leak_sur);
   Screen.Cursor:=crDefault;
   ShowDicForm(TForm(S_LeakF));
end;

procedure TFormMain.N43Click(Sender: TObject);
begin
  inherited;
   // Справочник видов засора
   Screen.Cursor:=crHourGlass;
   if not assigned(S_ClogF) then
     S_ClogF:=TS_ClogF.CreateDic(application,'S_Clog','ID', DM1.S_Clog_sur);
   Screen.Cursor:=crDefault;
   ShowDicForm(TForm(S_ClogF));
end;

procedure TFormMain.N22Click(Sender: TObject);
begin
  inherited;
   // Справочник видов засыпки
   Screen.Cursor:=crHourGlass;
   if not assigned(S_FillF) then
     S_FillF:=TS_FillF.CreateDic(application,'S_Fill','ID', DM1.S_Fill_sur);
   Screen.Cursor:=crDefault;
   ShowDicForm(TForm(S_FillF));
end;

procedure TFormMain.N44Click(Sender: TObject);
begin
  inherited;
   // Справочник видов сети
   Screen.Cursor:=crHourGlass;
   if not assigned(S_NetF) then
     S_NetF:=TS_NetF.CreateDic(application,'S_Net','ID', DM1.S_Net_sur);
   Screen.Cursor:=crDefault;
   ShowDicForm(TForm(S_NetF));
end;

procedure TFormMain.N45Click(Sender: TObject);
begin
  inherited;
   // Справочник Мер локализации аварий
   Screen.Cursor:=crHourGlass;
   if not assigned(S_LocalF) then
     S_LocalF:=TS_LocalF.CreateDic(application,'S_Local','ID', DM1.S_Local_sur);
   Screen.Cursor:=crDefault;
   ShowDicForm(TForm(S_LocalF));
end;

procedure TFormMain.N46Click(Sender: TObject);
begin
  inherited;
   // Справочник видов ликвидации засора
   Screen.Cursor:=crHourGlass;
   if not assigned(S_KillClogF) then
     S_KillClogF:=TS_KillClogF.CreateDic(application,'S_KillClog','ID', DM1.S_KillClog_sur);
   Screen.Cursor:=crDefault;
   ShowDicForm(TForm(S_KillClogF));
end;

procedure TFormMain.N47Click(Sender: TObject);
begin
  inherited;
   // Справочник Методов откачки
   Screen.Cursor:=crHourGlass;
   if not assigned(S_PumpF) then
     S_PumpF:=TS_PumpF.CreateDic(application,'S_Pump','ID', DM1.S_Pump_sur);
   Screen.Cursor:=crDefault;
   ShowDicForm(TForm(S_PumpF));
end;

procedure TFormMain.N48Click(Sender: TObject);
begin
  inherited;
   // Справочник Использования ПЭС
   Screen.Cursor:=crHourGlass;
   if not assigned(S_PESF) then
     S_PESF:=TS_PESF.CreateDic(application,'S_PES','ID', DM1.S_PES_sur);
   Screen.Cursor:=crDefault;
   ShowDicForm(TForm(S_PESF));
end;

procedure TFormMain.N30Click(Sender: TObject);
begin
  inherited;
   // Справочник Принадлежности заявки
   Screen.Cursor:=crHourGlass;
   if not assigned(S_OwnerF) then
     S_OwnerF:=TS_OwnerF.CreateDic(application,'S_Owner','ID', DM1.S_Owner_sur);
   Screen.Cursor:=crDefault;
   ShowDicForm(TForm(S_OwnerF));
end;

procedure TFormMain.N50Click(Sender: TObject);
begin
  inherited;
  frmReport:=TfrmReport.Create(self);
  frmReport.showmodal;
  frmReport.free
end;

procedure TFormMain.Translate;
var i:integer;
    cc:TMsgDlgType;
    cb:TMsgDlgBtn;
begin
  inherited;
  Users_mi.caption:=TrLangMSG(msgUsers);
  N3.caption:=TrLangMSG(msgOrders);
  N9.caption:=TrLangMSG(msgExit);
  FormMain.Caption:=TrLangMSG(msgCapMainForm);
  SS_Ved.Caption:=TrLangMSG(msgVedom);
  SpeedbarSection1.Caption:=TrLangMSG(msgExit);
  old_SI_new.Caption:=TrLangMSG(msgNewZajav);
  old_SI_new.Hint:=TrLangMSG(msgNewZajav)+'|';
  old_SI_zak.Caption:=TrLangMSG(msgClosed)+' '+TrLangMSG(msgOrders);
  old_SI_zak.Hint:=TrLangMSG(msgClosed)+' '+TrLangMSG(msgOrders)+'|';
  old_SI_nzak.Caption:=TrLangMSG(msgNotClosed)+' '+TrLangMSG(msgOrders);
  old_SI_nzak.Hint:=TrLangMSG(msgNotClosed)+' '+TrLangMSG(msgOrders)+'|';
  old_SI_Proiz.Caption:=TrLangMSG(msgSelOfYearAndNum);
  old_SI_Proiz.Hint:=TrLangMSG(msgSelOfYearAndNum)+'|';
  old_SI_nzper.Caption:=TrLangMSG(msgVedNoCloseZajav);
  old_SI_nzper.Hint:=TrLangMSG(msgVedNoCloseZajav)+'|';
  old_SI_fprois.Caption:=TrLangMSG(msgProizSearch);
  old_SI_fprois.Hint:=TrLangMSG(msgProizSearch)+'|';
  //old_SI_univ.Caption:=TrLangMSG(msgUniverSpravka);
  //old_SI_univ.Hint:=TrLangMSG(msgUniverSpravka)+'|';
  old_SI_newus.Caption:=TrLangMSG(msgNewUser);
  old_SI_newus.Hint:=TrLangMSG(msgNewUser);
  old_SI_exit.Caption:=TrLangMSG(msgExit);
  old_SI_exit.Hint:=TrLangMSG(msgExit)+'|';
  SI_new.Hint:=TrLangMSG(msgNewZajav)+'|';
  SI_zak.Hint:=TrLangMSG(msgClosed)+' '+TrLangMSG(msgOrders);
  SI_nzak.Hint:=TrLangMSG(msgNotClosed)+' '+TrLangMSG(msgOrders);
  SI_Proiz.Hint:=TrLangMSG(msgSelOfYearAndNum);
  SI_nzper.Hint:=TrLangMSG(msgVedNoCloseZajav);
  SI_fprois.Hint:=TrLangMSG(msgProizSearch);
  //SI_univ.Hint:=TrLangMSG(msgUniverSpravka);
  SI_newus.Hint:=TrLangMSG(msgNewUser);
  tb_openshiftdeps.Hint:=TrLangMSG(msgExit);
  ToolButton2.Hint:=TrLangMSG(msgOrderNaVi);
  TB_DelZajav.Hint:=TrLangMSG(msgDeletingOrder);
  SBM.panels[0].text:=TrLangMSG(msgVersion)+' '+TempVersion;
  NewZav_mi.Caption:=TrLangMSG(msgNewZajav);
  N23.Caption:=TrLangMSG(msgNotClosed)+' '+TrLangMSG(msgOrders);
  N24.Caption:=TrLangMSG(msgClosed)+' '+TrLangMSG(msgOrders);
  N34.Caption:=TrLangMSG(msgSelOfYearAndNum);
  N52.Caption:= TrLangMSG(msgOrderNaVi);
  N62.Caption:= TrLangMSG(msgDeletingOrder);

  N25.Caption:=TrLangMSG(msgVedom);
  N26.Caption:='<< '+ TrLangMSG(msgVedNoCloseZajav)+ ' >>';
  N27.Caption:='<< '+ TrLangMSG(msgVedZajav)+' за '+ansilowercase(TrLangMSG(msgRange))+ ' >>';
  N28.Caption:=TrLangMSG(msgVedLikvidirPovr);
  new1.Caption:=TrLangMSG(msgProizSearch)+' (H)';
//  N32.Caption:=TrLangMSG(msgUniverSpravka);
  CompareRefer_mi.Caption:=TrLangMSG(msgSravnitSpravka);
  N36.Caption:=TrLangMSG(msgAnaliz);
  N37.Caption:=TrLangMSG(msgVedAnalizPovr)+' за квартал';
  N38.Caption:=TrLangMSG(msgAnalizPovrUlic);
  N54.Caption:=TrLangMSG(msgVedDamageKv);
  Dic_mi.Caption:=TrLangMSG(msgSpravoch);
  S_Brig_mi.Caption:=TrLangMSG(msgDolzLic);
  N6.Caption:=TrLangMSG(msgREVS);
  N1.Caption:=TrLangMSG(msgRAYONS);
  N2.Caption:=TrLangMSG(msgNameStreets);
  N4.Caption:=TrLangMSG(msgService);
  N5.Caption:=TrLangMSG(msgTypeStreets);
  N59.Caption:=TrLangMSG(msgREMONT);
  N80.Caption:=TrLangMSG(msgMaterTrub);
  N7.Caption:=TrLangMSG(msgWorks);
  N8.Caption:=TrLangMSG(msgMaters);
  N11.Caption:=TrLangMSG(msgDoWorks);
  N12.Caption:=TrLangMSG(msgDiams);
  N13.Caption:=TrLangMSG(msgMestnostPovr);
  S_Place_mi.Caption:=TrLangMSG(msgMestPovr);
  N15.Caption:=TrLangMSG(msgZajavitels);
  N16.Caption:=TrLangMSG(msgSoderzZajav);
  N17.Caption:=TrLangMSG(msgMechaniz);
//  N18.Caption:=TrLangMSG(msgPovrezd);
  N18.Caption:=TrLangMSG(msgPovrezd);
  N19.Caption:=TrLangMSG(msgTypeZajav);
  N30.Caption:=TrLangMSG(msgTypeOwner);
  S_sah_mi.Caption:=TrLangMSG(msgTypesColSHACH);
  TableLog_mi.Caption:=TrLangMSG(msgHistoryChanges);
  Nastr_mi.Caption:=TrLangMSG(msgNastrojka)+' ...';
  Map_mi.Caption:=TrLangMSG(msgAddMap);
  DictNotHide.Caption:=TrLangMSG(msgDictAll);
  N21.Caption:=TrLangMSG(msgClock);
  N35.Caption:=TrLangMSG(msgAutoVVod);
  N20.Caption:=TrLangMSG(msgOpenOtherName);
  N50.Caption:=TrLangMSG(msgVedom);
  tbPrint.hint:=TrLangMSG(msgVedom);
  N10.Caption:=TrLangMSG(msgExitProg);
  N42.Caption:=TrLangMSG(msgTypeLeak);
  N43.Caption:=TrLangMSG(msgTypeClog);
  N22.Caption:=TrLangMSG(msgTypeFill);
  N44.Caption:=TrLangMSG(msgTypeNet);
  N45.Caption:=TrLangMSG(msgTypeLocal);
  N46.Caption:=TrLangMSG(msgTypeKillClog);
  N47.Caption:=TrLangMSG(msgTypePump);
  N48.Caption:=TrLangMSG(msgTypePES);

  N51.Caption:='<< '+ TrLangMSG(msgVedLikvidirPovrForRange) + ' >>';
  N55.Caption:=TrLangMSG(msgAnalLeak);//Анализ утечек
  N57.Caption:=TrLangMSG(msgAnalisWorkEquip);
  N58.Caption:=TrLangMSG(msgPlanMechaniz);
  N70.Caption:=TrLangMSG(msgVRK);
  N75.Caption:=TrLangMSG(msgDopAdresov);
  N82.Caption:=TrLangMSG(msgAddMustBlagWork);
  mi_s_trudozatrat.Caption:=TrLangMSG(msgTrudozatrat);
  mi_S_BWork.Caption:=TrLangMSG(msgBWork);
  mi_s_instrum.Caption:=TrLangMSG(msgInstruments);
  mi_s_object.Caption:=TrLangMSG(msgObjects);
  mi_S_ObjObor.Caption:=TrLangMSG(msgEquipObjects);
  mi_S_OGRAGD.Caption:=TrLangMSG(msgFances);
  mi_S_OBORTYPEGLOB.Caption:=TrLangMSG(msgCommonTypEquip);
  mi_S_OBORTYPE.Caption:=TrLangMSG(msgTypEquip);
  mi_S_SOORUG.Caption:=TrLangMSG(msgConstructions);
  Backup_mi.Caption:=TrLangMSG(msgArhiv);
  Restore_mi.Caption:=TrLangMSG(msqRestore);
  mi_Windows.Caption:=TrLangMSG(msqWindows);
  N87.Caption:=TrLangMSG(msqInpuSmen);
  N63.caption:=TrLangMSG(msgSysClock);
  //-------------------Сводки
  N212.Caption:=TrLangMSG(msgSConsolidStateTitle);
  N77.Caption:=TrLangMSG(msgStateLeaksTitle);
  N76.Caption:=TrLangMSG(msgStateAddMoreCountTitle);  //Поиск адресов больше определенного кол-ва
  N83.Caption:=TrLangMSG(mcsVedNarPeriod);//Ведомость этапов за период
  N81.Caption :=TrLangMSG(msgForm)+'7 '+TrLangMSG(msgViborPoUl);// Форма 7 - Выбор всех нарядов по улице
  N88.Caption:=TrLangMSG(msgDaylyLogTitle);//Суточный журнал



  if LANG=ltUA
  then begin
//    ButtonCaptions[mbNo]:=@SMsgDlgYes;
    DateTimeStorage1.LongMonthNames.CommaText:='Січень,Лютий,Березень,Квітень,Травень,Червень,Липень,Серпень,Вересень,Жовтень,Листопад,Грудень';
    DateTimeStorage1.ShortMonthNames.CommaText:='Січ,Лют,Бер,Кві,Тра,Чер,Лип,Сер,Вер,Жов,Лис,Гру';
    DateTimeStorage1.LongDayNames.CommaText:='неділя,понеділок,вівторок,середа,четвер,п''ятниця,субота';
    DateTimeStorage1.ShortDayNames.CommaText:='Нд,Пн,Вв,Ср,Чт,Пт,Сб';
  end
  else begin
    DateTimeStorage1.LongMonthNames.CommaText:='Январь,Февраль,Март,Апрель,Май,Июнь,Июль,Август,Сентябрь,Октябрь,Ноябрь,Декабрь';
    DateTimeStorage1.ShortMonthNames.CommaText:='янв,фев,мар,апр,май,июн,июл,авг,сен,окт,ноя,дек';
    DateTimeStorage1.LongDayNames.CommaText:='воскресенье,понедельник,вторник,среда,четверг,пятница,суббота';
    DateTimeStorage1.ShortDayNames.CommaText:='Вс,Пн,Вт,Ср,Чт,Пт,Сб';
  end;
  for i:=1 to 12 do LongMonthNames[i]:=DateTimeStorage1.LongMonthNames[i-1];
  for i:=1 to 12 do ShortMonthNames[i]:=DateTimeStorage1.ShortMonthNames[i-1];
  for i:=1 to 7 do LongDayNames[i]:=DateTimeStorage1.LongDayNames[i-1];
  for i:=1 to 7 do ShortDayNames[i]:=DateTimeStorage1.ShortDayNames[i-1];
  // Системные диалоги
  for cc:=Low(Captions) to High(Captions) do
    if LANG=ltRU
    then Captions[cc]:=CaptionsRU[cc]
    else Captions[cc]:=CaptionsUA[cc];
  for cb:=Low(ButtonCaptions) to High(ButtonCaptions) do
    if LANG=ltRU
    then ButtonCaptions[cb]:=ButtonCaptionsRU[cb]
    else ButtonCaptions[cb]:=ButtonCaptionsUA[cb];
end;

procedure TFormMain.N51Click(Sender: TObject);
var SpForm1:TFormSah1;
begin
  SpForm1:=TFormSah1.Create(Self);
  OperAtt:=SpForm1.OperAttFormFill(sender);
  SpForm1.ShowModal;
end;

procedure TFormMain.N52Click(Sender: TObject);
var ZvForm:TFormZav;
    tt_str,_dop_where:string;
begin
  OperAtt:=OperAttDetectFromMenuItem(sender);
  _dop_where:=' (delz=0) and (z.id_alien=4) and (id_attach='+IntToStr(Ord(OperAtt))+') ';
  repeat
   tt_str:=VvodOl(Self,10,'DBN_AVAR',TrLangMSG(msgSelPredvZajav),
      ////
       'select cast(nomer as char(6)) '+
       ' vvod, '+
       'z.id as id, '+
       '(select rtrim(u.name_r)||" "||rtrim(v.name_r) '+
       ' from s_ulic u,s_vidul v '+
       ' where (u.del in (''-'',''d'')) and (u.id_vidul>-2) and (u.id_vidul=v.id) '+
       '  and (u.id=z.id_ul1)) as ul1, '+
       ' id_ul2, kod_ul, dop_adr,dt_in,id_dopadres,id_object, is_otl '+
       'from nzavjav z '+
       ' where '+_dop_where+' order by z.fyear desc,z.dt_in desc',_dop_where,'1',OperAtt, FALSE, NIL);

  if tt_str<>'' then
      begin
         F_VVod_CLOSED := FALSE;
         ZvForm:=TFormZav_ZavCreate(Self,tfmZayavAfterInsert,StrToInt(tt_str));
         OperAtt:=ZvForm.OperateAttach;
    //     pZvForm:=@ZvForm;
         ZvForm.ShowModal;
         if CloseStatus<>0 then
             repeat
               if CloseStatus=2 then
                 ZvForm:=TFormZav_ZavCreate(Self,tfmZayavCopy,ZavToCopy)
               else
                 ZvForm:=TFormZav_ZavCreate(Self,tfmZayavNew,0);
               ZvForm.ShowModal;
             until CloseStatus=0;
      end else F_VVod_CLOSED :=TRUE;
 until F_VVod_CLOSED;
end;

procedure TFormMain.N53Click(Sender: TObject);
begin
  fmBrig:=TfmBrig.fCreate(nil,0);
  fmBrig.ShowModal;
  fmBrig.Free;
end;

procedure TFormMain.ToolButton2Click(Sender: TObject);
begin
  //SmartPopup(N52Click,ToolButton2);
  SmartPopupForAllAtt(N52Click,ToolButton2);
end;

procedure TFormMain.AddMenu(MenIt:TMenuItem);
var
  mi:TMenuItem;
  mi1:TMenuItem;
  mi2:TMenuItem;
begin
  mi:=TMenuItem.Create(MenIt);
  MI.Name:=MenIt.Name+'_1';
  MI.Tag:=1;
  MI.Caption:=TrLangMSG(msgWaterPipe);
  MI.OnClick:=MenIt.OnClick;
  MenIt.Add(MI);

  mi1:=TMenuItem.Create(MenIt);
  MI1.Name:=MenIt.Name+'_2';
  MI1.Tag:=2;
  MI1.Caption:=TrLangMSG(msgWaterPipe);//'Канализация';
  MI1.OnClick:=MenIt.OnClick;
  MenIt.Add(MI1);
  //В Одессе нет заявок ВРК
  {mi2:=TMenuItem.Create(MenIt);
  MI2.Name:=MenIt.Name+'_3';
  MI2.Tag:=3;
  MI2.Caption:='Заявки ВРК';
  MI2.OnClick:=MenIt.OnClick;
  MenIt.Add(MI2);}

  MenIt.OnClick:=nil;
end;

procedure TFormMain.SelectedClick(Sender:TObject);
begin
  if not (Sender is TMenuItem) then exit;
  OperAtt:=TOperAtt((Sender as TMenuItem).Tag);
  ((Sender as TMenuItem).Parent as TMenuItem).OnClick(Sender);
end;

procedure TFormMain.N54Click(Sender: TObject);
 var An_DIAG : TQueryForm;
begin
  An_DIAG:=TQueryForm.Create(Self);
  OperAtt:=An_DIAG.OperAttFormFill(sender);
  An_DIAG.ShowModal;
end;

procedure TFormMain.N55Click(Sender: TObject);
var
  fmRas_Q : TfmRas_Q;
begin
  fmRas_Q:=TfmRas_Q.Create(Self);
  OperAtt:=fmRas_Q.OperAttFormFill(sender);
  fmRas_Q.ShowModal;
//  fmRas_Q.Free;
end;



procedure TFormMain.N56Click(Sender: TObject);
 var SprShead : TfmSpreadSh;
begin
  SprShead:=TfmSpreadSh.Create(Self);
  OperAtt:=SprShead.OperAttFormFill(sender);
  SprShead.ShowModal;
end;

procedure TFormMain.N57Click(Sender: TObject);
 var OborSheet : TfmOborsSh;
begin
  OborSheet:=TfmOborsSh.Create(Self);
  OperAtt:=OborSheet.OperAttFormFill(sender);
  OborSheet.ShowModal;
end;

procedure TFormMain.Backup_miClick(Sender: TObject);
begin
  inherited;
  //
	try
    {FormAdm.Db_isc.Close;
    FormAdm.Check.Close;
    FormAdm.DataBase1.Close;
    FormOpSQL.Db_ESC.Close;}
    //DM1.Db_Avar.Close;
    //
    BRForm:=TBRForm.Create(nil,tamBackup,'AVARODESSA');
    BRForm.ShowModal;
  finally
    FreeAndNil(BRForm);
    //
    {FormAdm.Db_isc.Open;
    FormAdm.Check.Open;
    FormAdm.DataBase1.Open;
    FormOpSQL.Db_ESC.Open;}
    //DM1.Db_Avar.Open;
  end;
end;

procedure TFormMain.Restore_miClick(Sender: TObject);
begin
  inherited;
  	try
    DM1.Db_Avar.Close;
    BRForm:=TBRForm.Create(nil,tamRestore,'AVARODESSA');
    BRForm.ShowModal;
  finally
    FreeAndNil(BRForm);
    DM1.Db_Avar.Open;
  end;
end;

procedure TFormMain.N59Click(Sender: TObject);
begin
  inherited;
 // Справочник Выполнение ремонта
 Screen.Cursor:=crHourGlass;
 S_RemontF:=TS_RemontF.CreateDic(application,'S_REMONT','ID', DM1.S_Remont_sur);
 Screen.Cursor:=crDefault;
 ShowDicForm(TForm(S_RemontF));
end;

procedure TFormMain.NN_vedoms_click(Sender: TObject; _vedForm:TVedForm);
begin
  inherited;
  try
    VedomsForm:=TVedomsForm.SZ_VedomsCreate(Self,1,_vedForm);
    OperAtt:=VedomsForm.OperAttFormFill(sender);
    DM_VedManager.OperateAttach:=OperAtt;
    VedomsForm.ShowModal;
  finally
    VedomsForm.Free;
  end;     
end;

procedure TFormMain.N63Click(Sender: TObject);
begin
  inherited;
  MyNowFlag:=not MyNowFlag;
  N63.Checked:=not MyNowFlag;
end;

procedure TFormMain.N64Click(Sender: TObject);
begin
  inherited;
  NN_vedoms_click(Sender,tvfUstran);
end;

procedure TFormMain.N310Click(Sender: TObject);
begin
  inherited;
  NN_vedoms_click(Sender,tvfAbon);
end;

procedure TFormMain.N410Click(Sender: TObject);
begin
  inherited;
  NN_vedoms_click(Sender,tvfKolvo);
end;

procedure TFormMain.N411Click(Sender: TObject);
begin
  inherited;
  NN_vedoms_click(Sender,tvfVipoln);
end;

procedure TFormMain.N66Click(Sender: TObject);
begin
  inherited;
  NN_vedoms_click(Sender,tvfUtech_Other);
end;

procedure TFormMain.N65Click(Sender: TObject);
begin
  inherited;
  NN_vedoms_click(Sender,tvfUtech_Vodopr);
end;

procedure TFormMain.N80Click(Sender: TObject);
begin
  inherited;
 // Справочник материалов
 Screen.Cursor:=crHourGlass;
 if not assigned(S_MatPipeF) then
   S_MatPipeF:=TS_MatPipeF.CreateDic(application, 'S_MATPIPE', 'ID',DM1.DS_MatPipe);
 Screen.Cursor:=crDefault;
 ShowDicForm(TForm(S_MatPipeF));
end;

procedure TFormMain.MI4_OnClick(ne:TNotifyEvent);
begin
  ne_mi14:=ne;
end;                

procedure TFormMain.MI5_OnClick(ne:TNotifyEvent);
begin
  ne_mi15:=ne;
end;

procedure TFormMain.SmartPopup(ne:TNotifyEvent; tb:TToolButton);
var
  glPoint:TPoint;
begin
  if not Assigned(pmChoiceAtt) then
    pmChoiceAtt:=TPopupMenu.Create(Self);
  glPoint:=tb.ClientToScreen( Point(tb.Left,tb.Top));
  MI4_OnClick(ne);
  MI5_OnClick(ne);
  M72_OnClick(ne);
  pmChoiceAtt.Popup(glPoint.x div 2 +30,glPoint.y);
end;

procedure TFormMain.MI4Click(Sender: TObject);
begin
  inherited;
  LastMenuItemSender_Tag:=(Sender as TMenuItem).Tag;
  ne_mi14(sender);
end;

procedure TFormMain.MI5Click(Sender: TObject);
begin
  inherited;
  LastMenuItemSender_Tag:=(Sender as TMenuItem).Tag;
  ne_mi15(sender);
end;

procedure TFormMain.N62Click(Sender: TObject);
var ZvForm:TFormZav;
    tt_str,_dop_where:string;
begin
  inherited;
  {Заявки на удаление}
  OperAtt:=OperAttDetectFromMenuItem(sender);
  _dop_where:='(delz=1) and (id_attach='+IntToStr(Ord(OperAtt))+') ';
  repeat
   tt_str:=VvodOl(Self,10,'DBN_AVAR',TrLangMSG(msgDelZajav),
      ////
       'select cast(nomer as char(6)) '+
       ' vvod, '+
       'z.id as id, '+
       '(select rtrim(u.name_r)||" "||rtrim(v.name_r) '+
       ' from s_ulic u,s_vidul v '+
       ' where (u.del in (''-'',''d'')) and (u.id_vidul>-2) and (u.id_vidul=v.id) '+
       '  and (u.id=z.id_ul1)) as ul1, '+
       ' id_ul2, kod_ul, dop_adr,dt_in, z.fyear, z.dt_in,id_dopadres,id_object, is_otl '+
       'from nzavjav z '+
       ' where (delz=1) and (id_attach='+IntToStr(Ord(OperAtt))+') '+
         ' union '+
       'select cast(nomer as char(6)) '+
       ' vvod, '+
       'z.id as id, '+
       '(select rtrim(u.name_r)||" "||rtrim(v.name_r) '+
       ' from s_ulic u,s_vidul v '+
       ' where (u.del in (''-'',''d'')) and (u.id_vidul>-2) and (u.id_vidul=v.id) '+
       '  and (u.id=z.id_ul1)) as ul1, '+
       ' id_ul2, kod_ul, dop_adr,dt_in, z.fyear, z.dt_in,id_dopadres,id_object, is_otl '+
       'from zavjav z '+
       ' where '+_dop_where+
          ' order by 8 desc,9 desc ',_dop_where,
       '1',OperAtt, FALSE, NIL, (rsADMIN in RightsSet));

  if tt_str<>'' then
      begin
         F_VVod_CLOSED := FALSE;
         LockForDel:=TRUE;
         ZvForm:=TFormZav_ZavCreate(Self,tfmZayavAfterInsert,StrToInt(tt_str));
         OperAtt:=ZvForm.OperateAttach;
    //     pZvForm:=@ZvForm;
         ZvForm.ShowModal;
         if CloseStatus<>0 then
             repeat
               if CloseStatus=2 then
                 ZvForm:=TFormZav_ZavCreate(Self,tfmZayavCopy,ZavToCopy)
               else
                 ZvForm:=TFormZav_ZavCreate(Self,tfmZayavNew,0);
               ZvForm.ShowModal;
             until CloseStatus=0;
         LockForDel:=FALSE;
      end else F_VVod_CLOSED := TRUE;

 until F_VVod_CLOSED;
end;

procedure TFormMain.TB_DelZajavClick(Sender: TObject);
begin
  inherited;
  SmartPopupForAllAtt(N62Click,TB_DelZajav);
end;

procedure TFormMain.N67Click(Sender: TObject);
begin
  inherited;
  NN_vedoms_click(Sender,tvfDelZayav);
end;

procedure TFormMain.N71Click(Sender: TObject);
begin
  inherited;
  NN_vedoms_click(Sender,tvfUstran_vod);
end;

{$IFDEF MAP}
procedure TFormMain.OnConnectServer(Sender: TObject);
begin
  L_MapConnect.Show;
  N68.Enabled:=false;
  FormMain.Enabled:=TRUE;
  MAP_IS_WORK:=True;
end;
{$ENDIF}

procedure TFormMain.N69Click(Sender: TObject);
begin
  inherited;
  {$IFDEF MAP}
    Try
      if not MAP_IS_WORK  then
      begin
        if not Assigned(ManageAvarOnMap) then
          ManageAvarOnMap:=TManageAvarOnMap.Create;
          ManageAvarOnMap.Run;
          //FormMain.Enabled:=FALSE;
          N69.Enabled:=FALSE;
          ManageAvarOnMap.OnConnectServer:=OnConnectServer;
      end;
    except
    on e :exception do
    begin
      ShowMessage(e.Message);
      MAP_IS_WORK:=False;
      N68.Enabled:=TRUE;
    end
    end;
  {$ENDIF}
end;

procedure TFormMain.N81Click(Sender: TObject);
begin
  inherited;
//Выбор всех заявок по улице
  NN_vedoms_click(Sender,tvfViborPoUl);
end;

procedure TFormMain.N91Click(Sender: TObject);
begin
  inherited;
  NN_vedoms_click(Sender,tvfPostupAbon);
end;

procedure TFormMain.N131Click(Sender: TObject);
begin
  inherited;
  NN_vedoms_click(Sender,tvfUtech_Vodomer);
end;

procedure TFormMain.N58Click(Sender: TObject);
begin
 Screen.Cursor:=crHourGlass;
 if not assigned(S_PlanOborF) then
   S_PlanOborF:=TS_PlanOborF.CreateDic(application, 'S_PLANOBOR', 'ID',DM1.S_PlanObor_sur);
 Screen.Cursor:=crDefault;
 ShowDicForm(TForm(S_PlanOborF));
end;

procedure TFormMain.OnEndLoadAvrAdmin;
begin
  Screen.Cursor := crDefault;
end;

procedure TFormMain.N70Click(Sender: TObject);
begin
  inherited;
  Screen.Cursor:=crHourGlass;
  if not assigned(S_VRK_F) then
    S_VRK_F:=TS_VRK_F.CreateDic(application,'VRK','ID', DM1.S_VRK_sur);
  Screen.Cursor:=crDefault;
  ShowDicForm(TForm(S_VRK_F));
end;

procedure TFormMain.N72Click(Sender: TObject);
begin
  inherited;
  LastMenuItemSender_Tag:=(Sender as TMenuItem).Tag;
  ne_mi72(sender);
end;

procedure TFormMain.M72_OnClick(ne: TNotifyEvent);
begin
  ne_mi72:=ne;
end;

procedure TFormMain.N73Click(Sender: TObject);
var
  DMRep: TDM_ReportManager;
begin
//  OperAtt:=OperAttDetectFromMenuItem(Sender); // - выбираем ВСЁ

  OperAtt:=toaVoda;// - выбираем ВСЁ by Vadim 13.02.2009

  DMRep:=TDM_ReportManager.Create(nil);
  try
    DMRep.ShowReport(rnZavWithImage);
  finally
    DMRep.Free;
  end;
end;

procedure TFormMain.N74Click(Sender: TObject);
var
  rep_man: TNGReportManager;
begin
  OperAtt:=OperAttDetectFromMenuItem(Sender);

  rep_man:=TNGReportManager.Create;
  try
    rep_man.ShowReport(rnWWater);
  finally
    rep_man.Free;
  end;
end;

procedure TFormMain.N210Click(Sender: TObject);
var
  rep_man: TNGReportManager;
begin
  OperAtt:=OperAttDetectFromMenuItem(Sender);

  rep_man:=TNGReportManager.Create;
  try
    rep_man.ShowReport(rnSvodVed2);
  finally
    rep_man.Free;
  end;
end;

procedure TFormMain.N75Click(Sender: TObject);
begin
 Screen.Cursor:=crHourGlass;
 if not assigned(S_DopAdresF) then
   S_DopAdresF:=TS_DopAdresF.CreateDic(application, 'S_DopAdres', 'ID', DM1.S_DopAdres_sur);
 Screen.Cursor:=crDefault;
 ShowDicForm(TForm(S_DopAdresF));
end;

procedure TFormMain.N76Click(Sender: TObject);
var
  rep_man: TNGReportManager;
begin
  OperAtt:=OperAttDetectFromMenuItem(Sender);

  rep_man:=TNGReportManager.Create;
  try
    rep_man.ShowReport(rnSearchAdres);
  finally
    rep_man.Free;
  end;
end;

procedure TFormMain.N77Click(Sender: TObject);
var
  rep_man: TNGReportManager;
begin
  OperAtt:=OperAttDetectFromMenuItem(Sender);

  rep_man:=TNGReportManager.Create;
  try
    rep_man.ShowReport(rnUtechkiZaPeriod);
  finally
    rep_man.Free;
  end;
end;

procedure TFormMain.N211Click(Sender: TObject);
var
  rep_man: TNGReportManager;
begin
  OperAtt:=OperAttDetectFromMenuItem(Sender);

  rep_man:=TNGReportManager.Create;
  try
    rep_man.ShowReport(rnSvodVed2Alien);
  finally
    rep_man.Free;
  end;
end;

procedure TFormMain.mi_s_trudozatratClick(Sender: TObject);
begin
 // Справочник трудозатрат
 Screen.Cursor:=crHourGlass;
 if not Assigned( S_TrudozatratF ) then
   S_TrudozatratF := TS_TrudozatratF.CreateDic( Application,'S_Trudozatrat', 'ID', DM1.S_trudozatrat_sur);
 Screen.Cursor:=crDefault;
 ShowDicForm( TForm( S_TrudozatratF ) );
end;

procedure TFormMain.mi_S_BWorkClick(Sender: TObject);
begin
 // Справочник больших работ
 Screen.Cursor:=crHourGlass;
 if not Assigned( S_BWorkF ) then
   S_BWorkF := TS_BWorkF.CreateDic( Application,'S_BWORK', 'ID', DM1.s_bwork_sur );
 Screen.Cursor:=crDefault;
 ShowDicForm( TForm( S_BWorkF ) );
end;

procedure TFormMain.mi_RepTZClick(Sender: TObject);
var
  rep_man: TNGReportManager;
begin
  OperAtt:=OperAttDetectFromMenuItem(Sender);

  rep_man:=TNGReportManager.Create;
  try
    rep_man.ShowReport( rnTrudoZatrat );
  finally
    rep_man.Free;
  end;
end;

procedure TFormMain.SmartPopupForAllAtt(ne: TNotifyEvent; tb: TToolButton);
var
  glPoint:TPoint;
begin
  if not Assigned(pmChoiceAllAtt) then
    pmChoiceAllAtt:=TPopupMenu.Create(Self);
  glPoint:=tb.ClientToScreen( Point(tb.Left,tb.Top));
  MI4_OnClick(ne);
  MI5_OnClick(ne);
  M72_OnClick(ne);

  ne_mi_ObjVoda := ne;
  ne_mi_ObjKanal := ne;

  pmChoiceAllAtt.Popup(glPoint.x div 2 +30,glPoint.y);
end;

procedure TFormMain.N78Click(Sender: TObject);
begin
  inherited;
  LastMenuItemSender_Tag:=(Sender as TMenuItem).Tag;
  ne_mi_ObjVoda(Sender);
end;

procedure TFormMain.N79Click(Sender: TObject);
begin
  inherited;
  LastMenuItemSender_Tag:=(Sender as TMenuItem).Tag;
  ne_mi_ObjKanal(Sender);
end;

procedure TFormMain.AddMenuForAllAtt(MenuIt: TMenuItem);
  procedure _Add( _OperAtt: TOperAtt; _Caption: string );
  var
    _mi: TMenuItem;
  begin
    _mi := TMenuItem.Create( MenuIt );
    _mi.Name := MenuIt.Name + '_' + IntToStr( Ord( _OperAtt ) );
    _mi.Tag := Ord( _OperAtt );
    _mi.Caption := _Caption;
    _mi.OnClick := MenuIt.OnClick;
    MenuIt.Add( _mi );
  end;
begin
  _Add( toaVoda,     TrLangMSG(msgWaterPipe){'Водопровод'} );
  _Add( toaKanal,    TrLangMSG(msgSeverage){'Канализация'} );
  //_Add( toaVRK,      'Заявки ВРК' );       в Одессе нет таких заявок
 // _Add( toaObjVoda,  TrLangMSG(msgWaterObjects){'Объекты водопровода'} );
 // _Add( toaObjKanal, TrLangMSG(msgSeverageObjects){'Объекты канализации' });

  MenuIt.OnClick:=nil;
end;

procedure TFormMain.mi_s_instrumClick(Sender: TObject);
begin
 // Справочник инструментов
 Screen.Cursor := crHourGlass;
 if not Assigned( S_InstrumF ) then
   S_InstrumF := TS_InstrumF.CreateDic( Application,'s_instrum','ID', DM1.s_instrum_sur);
 Screen.Cursor := crDefault;
 ShowDicForm( TForm( S_InstrumF ) );
end;

procedure TFormMain.mi_s_objectClick(Sender: TObject);
begin
 // Справочник объектов
 Screen.Cursor := crHourGlass;
 if not Assigned( S_ObjectF ) then
   S_ObjectF := TS_ObjectF.CreateDic( Application, 's_object','ID', DM1.s_object_sur);
 Screen.Cursor := crDefault;
 ShowDicForm( TForm( S_ObjectF ) );
end;

procedure TFormMain.mi_S_ObjOborClick(Sender: TObject);
var _count : integer;
begin
 // Справочник оборудования объектов
 Screen.Cursor := crHourGlass;

 dm1.s_object_q.Open;
// dm1.s_object_q.Last;
// dm1.s_object_q.First;
 _count := dm1.s_object_q.RecordCount;
 dm1.s_object_q.Close;
 if _count > 0 then
 begin
    if not Assigned( S_ObjOborF ) then
      S_ObjOborF := TS_ObjOborF.CreateDic( Application, 's_ObjObor','ID', DM1.s_ObjObor_sur);
    Screen.Cursor := crDefault;
    ShowDicForm( TForm( S_ObjOborF ) );
 end else
    MessageDlg('Для того щоб коректуати  даний довідник необхідно , ' + #13 +
        'щоб довідник об''єктів містив який небудь запис',mtInformation, [mbOk], 0);

end;

procedure TFormMain.mi_RepMatUseClick(Sender: TObject);
var
  _RepMan: TNGReportManager;
begin
  OperAtt:=OperAttDetectFromMenuItem(Sender);

  _RepMan:=TNGReportManager.Create;
  try
    _RepMan.ShowReport( rnMatUse );
  finally
    _RepMan.Free;
  end;
end;

procedure TFormMain.mi_SvodkaSesClick(Sender: TObject);
var
  _RepMan: TNGReportManager;
begin
  _RepMan:=TNGReportManager.Create;
  try
    _RepMan.ShowReport( rnSvodkaSES );
  finally
    _RepMan.Free;
  end;
end;

procedure TFormMain.N82Click(Sender: TObject);
begin
  inherited;
 Screen.Cursor := crHourGlass;
 if not assigned( S_Work_MestF ) then
   S_Work_MestF := TS_Work_MestF.CreateDic( application,'S_WORK_MEST', 'ID',DM1.S_Work_Mest_sur );
 Screen.Cursor := crDefault;
 ShowDicForm( TForm( S_Work_MestF ) );
end;

procedure TFormMain.miOtlRepClick(Sender: TObject);
var
  _RepMan: TNGReportManager;
begin
  _RepMan:=TNGReportManager.Create;
  try
    _RepMan.ShowReport( rnOtlRep );
  finally
    _RepMan.Free;
  end;
end;

procedure TFormMain.mi_S_OGRAGDClick(Sender: TObject);
begin
  inherited;
   // Справочник ограждений
   Screen.Cursor:=crHourGlass;
   if not assigned(S_OgragdF) then
     S_OgragdF:=TS_OgragdF.CreateDic(application,'S_OGRAGD','ID', DM1.s_ogragd_sur);
   Screen.Cursor:=crDefault;
   ShowDicForm(TForm(S_OgragdF));
end;

procedure TFormMain.mi_S_OBORTYPEClick(Sender: TObject);
begin
  inherited;
  // Справочник Типов оборудования
   Screen.Cursor:=crHourGlass;
   if not assigned(S_OborTypeF) then
     S_OborTypeF:=TS_OborTypeF.CreateDic(application,'S_OborType','ID', DM1.S_OborType_sur);
   Screen.Cursor:=crDefault;
   ShowDicForm(TForm(S_OborTypeF), false);
end;

procedure TFormMain.mi_S_SOORUGClick(Sender: TObject);
var _mi: TMenuItem;
    _ne: TNotifyEvent;
begin
  inherited;
//  // Справочник Сооружений
   Screen.Cursor:=crHourGlass;
   if not assigned(S_SoorugF) then
   begin

     S_SoorugF:=TS_SoorugF.CreateDic(FormMain,'S_Soorug','ID', DM1.S_Soorug_sur);
//     _mi := TMenuItem.Create(MainMenu1);
//     _mi.Caption := 'Справочник Сооружений';
//     _mi.OnClick := mi_S_SOORUGClick;
   //  mi_Windows.Items[].Add(_mi);
//     mi_Windows.Visible := true;
   end;
   Screen.Cursor:=crDefault;
   ShowDicForm(TForm(S_SoorugF), false);
end;

procedure TFormMain.mi_S_OBORTYPEGLOBClick(Sender: TObject);
begin
  inherited;
// Справочник Обобщённых типов оборудования
   Screen.Cursor:=crHourGlass;
   if not assigned(S_OborTypeGlobF) then
     S_OborTypeGlobF:=TS_OborTypeGlobF.CreateDic(application,'S_OborTypeGlob','ID', DM1.S_OborTypeGlob_sur);
   Screen.Cursor:=crDefault;
   ShowDicForm(TForm(S_OborTypeGlobF));
end;

procedure TFormMain.mi_SvodVed3Click(Sender: TObject);
var
  rep_man: TNGReportManager;
begin
  OperAtt:=OperAttDetectFromMenuItem(Sender);

  rep_man:=TNGReportManager.Create;
  try
    rep_man.ShowReport(rnSvodVed3);
  finally
    rep_man.Free;
  end;

end;

procedure TFormMain.N212Click(Sender: TObject);
var
  rep_man: TNGReportManager;
begin
  OperAtt:=OperAttDetectFromMenuItem(Sender);

  rep_man:=TNGReportManager.Create;
  try
    rep_man.ShowReport(rnSvodVed21);
  finally
    rep_man.Free;
  end;

//
end;

procedure TFormMain.N83Click(Sender: TObject);
var FOpt:Tfrm_sz_nar;
begin
  inherited;
   FOpt:=Tfrm_sz_nar.Create(Self);
   OperAtt:=FOpt.OperAttFormFill(sender);
  FOpt.ShowModal;
//
end;

function NNSznar(id,col:integer;var ss:string):integer;
function is_allTek:boolean;
 var i:integer;
begin
Result:=true;
 for i:=0 to 10 do
  if  TekFl[i] then Result:=false;
end;
begin
//
Result:=1;
  if id<>old_id then
  begin
  MyOpenSQL(formmain.Qry_tmp,Format('select max(n1.nomer) from narad n1,narad n'+
                                    ' where n1.id_zav= n.id_zav and n.id=%d'
                             ,[id]));

  formmain.Qry_tmp.First;
  max_narnomer:=formmain.Qry_tmp.Fields[0].AsInteger;
 { formmain.Qry_tmp.Next;
  if max_narnomer<formmain.Qry_tmp.Fields[0].AsInteger then
     max_narnomer:=formmain.Qry_tmp.Fields[0].AsInteger;}
  formmain.Qry_tmp.Close;

  formmain.Qry_tmp.SQL.Text:= 'select s.name_r from works w,s_work s'+
                       ' where w.id_nar=:id_nar and w.id_work=s.id order by w.id_nar,w.id';
  formmain.Qry_tmp.ParamByName('id_nar').AsInteger:=id;
  formmain.Qry_tmp.Open;

  formmain.Qry_tmp2.SQL.Text:='select distinct rtrim(s.name_r)||'' ''||rtrim(s.ed_izm)||'' ''||cast(m.kol_mat as char(6)) name_r from maters m,s_mat s'+
                               ' where m.id_nar=:id_nar and m.id_mat=s.id order by m.id';
  formmain.Qry_tmp2.ParamByName('id_nar').AsInteger:=id;
  formmain.Qry_tmp2.Open;

  formmain.Qry_tmp3.SQL.Text:='select    rtrim(so.name_r)||'' ''||rtrim(so.fio)  name_r from obors ob,s_obor so where ob.id_nar=:id_nar  and so.id=ob.id_obor';
  formmain.Qry_tmp3.ParamByName('id_nar').AsInteger:=id;
  formmain.Qry_tmp3.Open;

      old_id:=id;
      TekFl[8]:=true ;
      TekFl[7]:=true ;
      TekFl[6]:=true ;
      TekFl[5]:=true;
      TekFl[4]:=true;
      TekFl[3]:=true;
      TekFl[2]:=true;
      TekFl[1]:=true;
      TekFl[0]:=true;
  end;
case col of
  7,9: if   old_res=id  then ss:='';
  1: ss:=Word2Tabl(ss,7,20);
  2: ss:=Word2Tabl(ss,0,20);
  3: ss:=Word2Tabl(ss,2,20);
  4: ss:=Word2Tabl(ss,0,20);
  5: begin
     MyOpenSQL(FormMain.Qry_tmp4, 'select dt_in,dt_out from narad where id='+inttOStr(id));
     if   FormMain.Qry_tmp4.IsEmpty then
      MyOpenSQL(FormMain.Qry_tmp4, 'select dt_in,dt_out from nnarad where id='+inttOStr(id));

       ss:=FormMain.Qry_tmp4.Fields[0].AsString+' '+ FormMain.Qry_tmp4.Fields[1].AsString;
      ss:=RepChar(#13,' ',strip('A',#10,ss));

     { case  MTekWord[1] of
      1: ss:=DateToStr(FormMain.Qry_tmp4.fieldbyname('dt_dep').AsDateTime);
      2: ss:=TimeToStr(FormMain.Qry_tmp4.fieldbyname('dt_dep').AsDateTime);
      3: ss:=DateToStr(FormMain.Qry_tmp4.fieldbyname('dt_out').AsDateTime);
      4: begin ss:=TimeToStr(FormMain.Qry_tmp4.fieldbyname('dt_out').AsDateTime);
          TekFl[1]:=False;
         end ;

       end;
        inc(MTekWord[1],1); }
       ss:=Word2Tabl(ss,1,23);
     end;
  6: if old_res=id then
       ss:=''
     else
         if StrToInt(ss)<max_narnomer then
            max_narnomer:=-1;
  8: ss:=Word2Tabl(ss,6,30);
  10: begin
      if   formmain.Qry_tmp3.Eof then  begin
         ss:='';
         TekFl[8]:=false ;
      end
      else
      begin
       ss:=formmain.Qry_tmp3.FieldByName('name_r').AsString;
       ss:=Word2Tabl(ss,8,23);

      if not TekFl[8] then begin
            TekFl[8]:=true;
             MTekWord[8]:=1;
         formmain.Qry_tmp3.Next;
      end ;
      if   formmain.Qry_tmp3.Eof then
                  TekFl[8]:=false ;

      end
     end;
  11: begin
      if   formmain.Qry_tmp.Eof then
         ss:=''
      else
       ss:=formmain.Qry_tmp.FieldByName('name_r').AsString;
      formmain.Qry_tmp.Next;
     end;
  12: ss:=Word2Tabl(ss,3,20);
  13: begin
       if   formmain.Qry_tmp2.Eof then
         ss:=''
       else
         ss:=formmain.Qry_tmp2.FieldByName('name_r').AsString;
       formmain.Qry_tmp2.Next;
      end;
  14:ss:=Word2Tabl(ss,4,30);
  15:
      if max_narnomer>0 then
     { case  MTekWord[5] of
        1:ss:=DateToStr(StrToDateTime(ss));
        2: begin ss:=TimeToStr(StrToDateTime(ss)); TekFl[5]:=false; end
       end;
       inc(MTekWord[5],1);
      end  }
       ss:=Word2Tabl(ss,5,20)
      else
      begin
       TekFl[5]:=false;
       ss:='';
      end;


end;



  if (not FormMain.Qry_tmp.EOF) or (not is_allTek) or
        (not FormMain.Qry_tmp2.EOF)or
         (not FormMain.Qry_tmp3.EOF) then
       Result:=1
     else if col=16 then
       begin
         Result:=0;
         TekWord:=1;
         MTekWord[0]:=1;
         TekWord2:=1;
         MTekWord[1]:=1;
         MTekWord[2]:=1;
         MTekWord[3]:=1;
         MTekWord[4]:=1;
         MTekWord[5]:=1;
         MTekWord[6]:=1;
         MTekWord[7]:=1;
         MTekWord[8]:=1;


       end;

     if col=15 then
         old_res:=id;


end;


procedure TFormMain.N84Click(Sender: TObject);
var
  rep_man: TNGReportManager;
begin
  OperAtt:=OperAttDetectFromMenuItem(Sender);

  rep_man:=TNGReportManager.Create;
  try
    rep_man.ShowReport(rnSvodPlanWorks);
  finally
    rep_man.Free;
  end;
end;

procedure TFormMain.N86Click(Sender: TObject);
var
  rep_man: TNGReportManager;
begin
  OperAtt:=OperAttDetectFromMenuItem(Sender);

  rep_man:=TNGReportManager.Create;
  try
    rep_man.ShowReport(rnDiskonSvod);
  finally
    rep_man.Free;
  end;

end;

procedure TFormMain.N87Click(Sender: TObject);
var shiftForm:Tfrm_shift;
    nums:string;
    dateS:Tdate;
    id_shift:integer;
begin
  inherited;
//теперь смена зависит от s_revs и имееи собственное имя

//  OperAtt:=OperAttDetectFromMenuItem(Sender);
  id_shift:=(Sender as TMenuItem).Tag;
  if  not dm_Shift.perMitDoChangeShift(id_shift,nums,dateS) then
  begin
    Application.MessageBox(PChar(Format(TrLangMSG(msgCloseNar),[nums]) ),
    PChar(TrLangMSG(msgChangeSmenDeny)),MB_OK+MB_ICONWARNING);
  end
  else
  begin
      shiftForm:=Tfrm_shift.Create(Self);
      try
        shiftForm.OperateAttach:=OperAtt;
        shiftForm.id_shift:=id_shift;
        shiftForm.Name:= (Sender as TMenuItem).Caption;
        shiftForm.ShowModal;
      finally
       shiftForm.Free;
      end;
  end;
  SetHift();
end;

procedure TFormMain.SetHift;
var num_Shift:integer;
    dat:TDate;
    list:TList;
    i:integer;
    item: PShiftName;
    textShift:string;

    procedure AddPanel(status:TStatusBar;text:string);
    var  panel:TStatusPanel;
    begin
      panel:= TStatusPanel.Create(Status.Panels);
      panel.Text:=text;
      panel.Width:=length(text)*5;

    end;
begin
  list:=dm_shift.getAllShiftName;
  for i:=0 to list.Count-1 do
  begin
    item:=list[i];
    if StatusBar.Panels.Count<=i+1 then
    begin
      AddPanel(StatusBar,item^.name);
      StatusBar.Panels[i+1].Width:=length(text)*10;
   end;

    dm_Shift.getShiiftNumber(item^.id,num_shift,dat);
    textShift:=TrLangMSG(msgShift);
    textShift:=Format('%s №%d %s %s',[TrLangMSG(msgShift),num_shift,DateToStr(dat),StrShiftTimeBegin]);
    if SBM.Panels.Count<=i+1 then
       begin
        AddPanel(SBM,textShift);

       end
    else
       SBM.Panels[i+1].Text:=textShift;
    SBM.Panels[i+1].Width:=StatusBar.Panels[i+1].Width;   
  end;

end;

procedure TFormMain.AddMenuShift(MenuIt: TMenuItem);
var list:TList;
    item:PShiftName;
    i:integer;
 procedure _Add( id_shift: integer; _Caption: string );
  var
    _mi: TMenuItem;
  begin
    _mi := TMenuItem.Create( MenuIt );
    _mi.Name := MenuIt.Name + '_' + IntToStr(id_shift );
    _mi.Tag := id_shift;
    _mi.Caption := _Caption;
    _mi.OnClick := MenuIt.OnClick;
    MenuIt.Add( _mi );
  end;
begin
 list:=dm_shift.getAllShiftName;
 for i:=0 to list.Count-1 do
 begin
   item:=list[i];
   _Add(item^.id,item^.name);

 end;
 list.Free;
 MenuIt.OnClick:=nil;
end;

procedure TFormMain.N88Click(Sender: TObject);
var  rep_man: TNGReportManager;
begin
  inherited;
 
  OperAtt:=OperAttDetectFromMenuItem(Sender);
  rep_man:=TNGReportManager.Create;
  try
    rep_man.ShowReport(rnRepJurnal);
  finally
    rep_man.Free;
  end;
end;

procedure TFormMain.N132Click(Sender: TObject);
var
  rep_man: TNGReportManager;
begin
  OperAtt:=OperAttDetectFromMenuItem(Sender);

  rep_man:=TNGReportManager.Create;
  try
    rep_man.ShowReport(rnDiskonForm13);
  finally
    rep_man.Free;
  end;
end;

procedure TFormMain.nRepExcavNotFinishedClick(Sender: TObject);
var
  rep_man: TNGReportManager;
begin
  OperAtt:=OperAttDetectFromMenuItem(Sender);

  rep_man:=TNGReportManager.Create;
  try
    rep_man.ShowReport(rnRepExcavNotFinished);
  finally
    rep_man.Free;
  end;

end;



procedure TFormMain.nRepExcavNotFinished2Click(Sender: TObject);
var
  rep_man: TNGReportManager;
begin
  OperAtt:=OperAttDetectFromMenuItem(Sender);

  rep_man:=TNGReportManager.Create;
  try
    rep_man.ShowReport(rnRepExcavNotFinished2);
  finally
    rep_man.Free;
  end;

end;

procedure TFormMain.N89Click(Sender: TObject);
var
  rep_man: TNGReportManager;
begin
  inherited;
   OperAtt:=OperAttDetectFromMenuItem(Sender);

  rep_man:=TNGReportManager.Create;
  try
    rep_man.ShowReport(rnRepCloseExcavd);
  finally
    rep_man.Free;
  end;
end;

procedure TFormMain.N133Click(Sender: TObject);
var
  rep_man: TNGReportManager;
begin
  OperAtt:=OperAttDetectFromMenuItem(Sender);

  rep_man:=TNGReportManager.Create;
  try
    rep_man.ShowReport(rnDiskonForm13Group);
  finally
    rep_man.Free;
  end;

end;

procedure TFormMain.NROpenShiftDepsClick(Sender: TObject);
var
  rep_man: TNGReportManager;
begin
//  OperAtt:=OperAttDetectFromMenuItem(Sender);

  rep_man:=TNGReportManager.Create;
  try
    rep_man.ShowReport(rnOpenDisconShift);
  finally
    rep_man.Free;
  end;
end;

procedure TFormMain.tb_openshiftdepsClick(Sender: TObject);
begin
  inherited;
N10Click(Self);
end;

procedure TFormMain.NMMaterToBrigClick(Sender: TObject);
var frm:Tfrm_materstobrig;
begin
  inherited;
  frm:=Tfrm_materstobrig.Create(self);
  try
  frm.setIdBrig(CodUser);
   frm.ShowModal;
  finally
   frm.Free
  end;
end;

procedure TFormMain.N32Click(Sender: TObject);
var frm:Tfrm_RepMaterMaker;
begin
  inherited;
  frm:=Tfrm_RepMaterMaker.Create(self);
  try
//  frm.setIdBrig(CodUser);
   frm.ShowModal;
  finally
   frm.Free
  end;

end;
//  SmartPopup(N32Click,SI_univ); шахматка бістрая кнопка не используется
//Универсальная справка
{ var SpForm:TFormSah;
SpForm:=TFormSah.Create(Self);
  OperAtt:=SpForm.OperAttFormFill(sender);
  SpForm.ShowModal;}


  {
  S_sah_miClick
   // Справочник колонок шахматки
 Screen.Cursor:=crHourGlass;
 if not assigned(S_SahF) then
   S_SahF:=TS_SahF.CreateDic(application, 'S_SAH', 'ID',DM1.S_Sah_sur);
 Screen.Cursor:=crDefault;
 ShowDicForm(TForm(S_SahF));}
end.

