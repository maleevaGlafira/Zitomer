unit nastr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls, Buttons, ColorGrd, inifiles, frmLANG, cntsLANG,
  Spin;

type
  TNastrF = class(TFormLang)
    Nastr_pc: TPageControl;
    General_pg: TTabSheet;
    Color_pg: TTabSheet;
    MainFPlacement_chb: TCheckBox;
    Lb_mess: TLabel;
    Lb_vid: TLabel;
    Lb_err: TLabel;
    ClGr: TColorGrid;
    LB_vib: TListBox;
    CB_Sam: TComboBox;
    BB_Def: TBitBtn;
    Panel1: TPanel;
    BtOk: TBitBtn;
    BtCancel: TBitBtn;
    GroupBox1: TGroupBox;
    RB_langUA: TRadioButton;
    RB_langRU: TRadioButton;
    edPRNpath: TEdit;
    lbPRN: TLabel;
    spe_days: TSpinEdit;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ClGrChange(Sender: TObject);
    procedure LB_vibClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Lb_messClick(Sender: TObject);
    procedure Lb_vidClick(Sender: TObject);
    procedure Lb_errClick(Sender: TObject);
    procedure CB_SamClick(Sender: TObject);
    procedure BB_DefClick(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure BtOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtCancelClick(Sender: TObject);
    procedure spe_daysChange(Sender: TObject);

  private
    CurUserSect :string;
    function SaveGeneralInfo(mIni :TIniFile) :boolean;
    function SaveColors(mIni :TIniFile) :boolean;
    function ReadGeneralInfo(mIni :TIniFile) :boolean;

  public
    function ReadAllData :boolean;
    function SaveAllData :boolean;
    procedure ReadColor(Fore,Back:TColor);
    procedure UstColor(Fore,Back:TControl);
    procedure Translate;override;
  end;


  TFControl = class(TControl)
  public
    property Font;
    property Color;
  end;

var
  NastrF: TNastrF;

Procedure GetLastUsedLanguage;
Procedure SetLastUsedLanguage;

implementation
  uses main, avartype;

  const
   DefaultUserSect ='Default';
   MainFPlacement = 'MainFPlacement';
   RB_lang='Language';
   PRNpath='Printer';
   CheckDays = 'CheckDays';

{$R *.DFM}
//*******************************************************************
procedure TNastrF.FormCreate(Sender: TObject);
begin
 FormShow(self);
  //FormColor:=Self;
{ds  Lb_Vib.ItemIndex:=0;
  UstColors(Self);
  Lb_Vid.Font.Color:=MessCol;
  Lb_Err.Font.Color:=ErrCol;
  ReadColor(BgCol,TextCol);}
end;

//*******************************************************************
procedure TNastrF.ClGrChange(Sender: TObject);
begin
 if Lb_Vib.ItemIndex=0 then
  begin
    UstColor(Lb_mess,{FormColor}self);
    UstColor(BtOk,{FormColor}self);
    UstColor(BtCancel,{FormColor}self);
  end
 else if LB_Vib.ItemIndex=1 then
  begin
    UstColor(Lb_vid,{FormColor}self);
  end
 else if LB_Vib.ItemIndex=2 then
  begin
    UstColor(Lb_err,self);
  end
 else if LB_Vib.ItemIndex=3 then
  begin
    UstColor(Cb_Sam,Cb_Sam);
    UstColor(LB_Vib,LB_Vib);
  end;
end;

//*******************************************************************
procedure TNastrF.ReadColor(Fore,Back:TColor);
begin
  ClGr.OnChange:=NIL;
  ClGr.BackgroundIndex:=ClGr.ColorToIndex(Back);
  ClGr.ForegroundIndex:=ClGr.ColorToIndex(Fore);
  ClGr.OnChange:=ClGrChange;
end;

//*******************************************************************
procedure TNastrF.UstColor(Fore,Back:TControl);    //tform tlabel
begin
      TFControl(Back).Color:=ClGr.BackgroundColor;

      TFControl(Fore).Font.Color:=ClGr.ForegroundColor;

end;

//*******************************************************************
procedure TNastrF.LB_vibClick(Sender: TObject);
begin
 if Lb_Vib.ItemIndex=0 then
  begin
    ReadColor(Lb_mess.Font.Color,{FormColor}self.Color);
  end
 else if LB_Vib.ItemIndex=1 then
  begin
    ReadColor(Lb_vid.Font.Color,{FormColor}self.Color);
  end
 else if LB_Vib.ItemIndex=2 then
  begin
    ReadColor(Lb_err.Font.Color,self.Color);
  end
 else if LB_Vib.ItemIndex=3 then
  begin
    ReadColor(Cb_Sam.Font.Color,Cb_Sam.Color);
  end;
end;

//*******************************************************************
procedure TNastrF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  Action:=caFree;
end;

//*******************************************************************
procedure TNastrF.Lb_messClick(Sender: TObject);
begin
  Lb_Vib.ItemIndex:=0;
  LB_vibClick(Self);
end;

//*******************************************************************
procedure TNastrF.Lb_vidClick(Sender: TObject);
begin
  Lb_Vib.ItemIndex:=1;
  LB_vibClick(Self);
end;

//*******************************************************************
procedure TNastrF.Lb_errClick(Sender: TObject);
begin
  Lb_Vib.ItemIndex:=2;
  LB_vibClick(Self);
end;

//*******************************************************************
procedure TNastrF.CB_SamClick(Sender: TObject);
begin
  Lb_Vib.ItemIndex:=3;
  LB_vibClick(Self);
end;

//*******************************************************************
procedure TNastrF.BB_DefClick(Sender: TObject);
var
 mIni:TIniFile;
// Sect:string;
begin
  mIni:=TIniFile.Create(FullPathIniFlParams{FullPathIniFlAvar});
 // Sect:='Default';
  TextCol:=mIni.ReadInteger(DefaultUserSect,'TextCol',-2147483640);
  MessCol:=mIni.ReadInteger(DefaultUserSect,'MessCol',16711680);
  ErrCol:=mIni.ReadInteger(DefaultUserSect,'ErrCol',255);
  BGCol:=mIni.ReadInteger(DefaultUserSect,'BackGrCol',clBtnFace);
  VvodCol:=mIni.ReadInteger(DefaultUserSect,'VvodCol',-2147483640);
  VvodBgCol:=mIni.ReadInteger(DefaultUserSect,'VvodBgCol',clWindow);
  mIni.Free;
  Lb_Vib.ItemIndex:=0;
  UstColors(Self);
  Lb_Vid.Font.Color:=MessCol;
  Lb_Err.Font.Color:=ErrCol;
  ReadColor(BgCol,TextCol);
end;

//*******************************************************************
procedure TNastrF.Panel1Click(Sender: TObject);
begin

end;

//*******************************************************************
function TNastrF.SaveGeneralInfo(mIni :TIniFile) :boolean;
var s:string;
begin
 try
  mIni.WriteBool(CurUserSect,MainFPlacement, MainFPlacement_chb.Checked);

  if RB_langUA.Checked then s:='UA' else s:='RU';
  mIni.WriteString(CurUserSect,RB_lang,s);
  mIni.WriteString(CurUserSect,PRNpath,edPRNpath.text);
  mIni.WriteString(CurUserSect,CheckDays,spe_days.Text);
  days:=spe_days.Value;
  result:=true;
 except
  result:=false;
 end;
end;

//*******************************************************************
function TNastrF.SaveColors(mIni :TIniFile) :boolean;
begin
  // Colors
  try
    //Sect:=IntToStr(CodUser);
    //mIni:=TIniFile.Create(CurrentDir+'\avar.ini');
    mIni.WriteInteger(CurUserSect,'TextCol',LB_mess.Font.Color);
    mIni.WriteInteger(CurUserSect,'MessCol',LB_vid.Font.Color);
    mIni.WriteInteger(CurUserSect,'ErrCol',LB_Err.Font.Color);
    mIni.WriteInteger(CurUserSect,'BackGrCol',{FormColor}self.Color);
    mIni.WriteInteger(CurUserSect,'VvodCol',CB_Sam.Font.Color);
    mIni.WriteInteger(CurUserSect,'VvodBgCol',CB_Sam.Color);

    mIni.WriteInteger(DefaultUserSect,'TextCol',-2147483640);
    mIni.WriteInteger(DefaultUserSect,'MessCol',16711680);
    mIni.WriteInteger(DefaultUserSect,'ErrCol',255);
    mIni.WriteInteger(DefaultUserSect,'BackGrCol',clBtnFace);
    mIni.WriteInteger(DefaultUserSect,'VvodCol',-2147483640);
    mIni.WriteInteger(DefaultUserSect,'VvodBgCol',clWindow);

  //  mIni.Free;
    TextCol:=LB_mess.Font.Color;
    MessCol:=LB_vid.Font.Color;
    ErrCol:=LB_Err.Font.Color;
    BGCol:={FormColor}self.Color;
    VvodCol:=CB_Sam.Font.Color;
    VvodBgCol:=CB_Sam.Color;
    result:=true;
  except
   result:=false;
  end;
end;

//*******************************************************************
procedure TNastrF.BtOkClick(Sender: TObject);
begin
 SaveAllData;
end;

//*******************************************************************
function TNastrF.ReadGeneralInfo(mIni :TIniFile) :boolean;
var s:string;
begin
 try
  result:=true;
  MainFPlacement_chb.Checked:=mIni.ReadBool(CurUserSect, MainFPlacement, false);

  s:=mIni.ReadString(CurUserSect,RB_lang,'UA');
  if s='UA'
  then RB_langUA.Checked:=true
  else RB_langRU.Checked:=true;
  edPRNpath.text:=mIni.ReadString(CurUserSect,PRNpath,'PRN');
  days := mIni.ReadInteger(CurUserSect,Checkdays,0);
  spe_days.Value:=days;
 except
  result:=false;
 end;
end;

//*******************************************************************
function TNastrF.ReadAllData :boolean;
var
 ifl :TIniFile;
begin
 ifl:=TIniFile.Create(FullPathIniFlParams{FullPathIniFlAvar});
 try
  CurUserSect:=IntToStr(CodUser);
  result:=ReadGeneralInfo(ifl);
  UstColors(Self);
  Lb_Vid.Font.Color:=MessCol;
  Lb_Err.Font.Color:=ErrCol;
  ReadColor(BgCol,TextCol);
 finally
  ifl.Free;
 end;
end;

//*******************************************************************
function TNastrF.SaveAllData :boolean;
var
 ifl :TIniFile;
begin
 ifl:=TIniFile.Create(FullPathIniFlParams{FullPathIniFlAvar});
 try
  CurUserSect:=IntToStr(CodUser);
  result:=SaveGeneralInfo(ifl);
  SaveColors(ifl);
 finally
  ifl.Free;
  Close;
 end;
end;

//*******************************************************************
procedure TNastrF.FormShow(Sender: TObject);
begin
 CurUserSect:=IntToStr(CodUser);
 Lb_Vib.ItemIndex:=0;
 ReadAllData;
end;

//*******************************************************************
procedure TNastrF.BtCancelClick(Sender: TObject);
begin
 Close;
end;

//*******************************************************************
procedure TNastrF.Translate;
begin
  inherited;
  Caption:=TrLangMSG(msgNastrojka);
  General_pg.Caption:=TrLangMSG(msgCommon);
  MainFPlacement_chb.Caption:=TrLangMSG(msgSaveMainForm);
  GroupBox1.Caption:=TrLangMSG(msgLang);
  lbPRN.Caption:=TrLangMSG(msgPRN);
  RB_langUA.Caption:=TrLangMSG(msgLangUA);
  RB_langRU.Caption:=TrLangMSG(msgLangRU);
  Color_pg.Caption:=TrLangMSG(msgColor);
  Lb_mess.Caption:=TrLangMSG(msgThis)+' '+ansilowercase(TrLangMSG(msgThisMsg));
  Lb_vid.Caption:=TrLangMSG(msgThis)+' '+ansilowercase(TrLangMSG(msgThisBoldMsg));
  Lb_err.Caption:=TrLangMSG(msgThis)+' '+ansilowercase(TrLangMSG(msgThisMsgError));
  BB_Def.Caption:=TrLangMSG(msgDefault);
  BtOk.Caption:=TrLangMSG(msgApply);
  BtCancel.Caption:=TrLangMSG(msgCancel);
  LB_vib.Items[0]:=TrLangMSG(msgThisMsg);
  LB_vib.Items[1]:=TrLangMSG(msgThisBoldMsg);
  LB_vib.Items[2]:=TrLangMSG(msgThisMsgError);
  LB_vib.Items[3]:=TrLangMSG(msgFieldEdit);
  CB_Sam.Text:=TrLangMSG(msgThis)+' '+ansilowercase(TrLangMSG(msgFieldEdit));
  CB_Sam.Items[0]:=TrLangMSG(msgChoose)+' 1';
  CB_Sam.Items[1]:=TrLangMSG(msgChoose)+' 2';
  CB_Sam.Items[2]:=TrLangMSG(msgChoose)+' 3';
end;

Procedure GetLastUsedLanguage;
var ifl :TIniFile;
    s:string;
begin
 ifl:=TIniFile.Create(FullPathIniFlParams{FullPathIniFlAvar});
 try
  s:=ifl.ReadString('0',RB_lang,'');
  if s<>''
  then begin
    if s='UA'
    then LANG:=ltUA
    else LANG:=ltRU

  end;
   days:=ifl.ReadInteger('0',CheckDays,0);
 finally
  ifl.Free;
 end;
end;

Procedure SetLastUsedLanguage;
var ifl :TIniFile;
    s:string;
begin
 ifl:=TIniFile.Create(FullPathIniFlParams{FullPathIniFlAvar});
 try
  if LANG=ltUA then s:='UA' else s:='RU';
  ifl.WriteString('0',RB_lang,s);
  ifl.WriteString('0',checkdays,IntToStr(days));
 finally
  ifl.Free;
 end;
end;

procedure TNastrF.spe_daysChange(Sender: TObject);
begin
  inherited;
if spe_days.Value<0 then
   spe_days.Value:=0;
end;



initialization
 NastrF:=nil;

end.
