unit Vxod;
//{$DEFINE  debug}
interface

uses
  Windows, Db, DBTables, StdCtrls, Buttons, ComCtrls, Controls, RXCtrls,
  Classes, ExtCtrls,Forms,SysUtils, frmLANG, cntsLANG,ver;
type
  TZastFrm = class(TFormLang)
    pnBottom: TPanel;
    RxLabel1: TRxLabel;
    RxLabel2: TRxLabel;
    Animate: TAnimate;
    Panel1: TPanel;
    edPassword: TEdit;
    Panel2: TPanel;
    BtExit: TBitBtn;
    Qry_user: TQuery;
    RxLabel3: TRxLabel;
    BtOk: TBitBtn;
    EdUserName: TEdit;
    lUserName: TRxLabel;
    lPassword: TRxLabel;
    RxLabel4: TRxLabel;
    cb_byname: TCheckBox;
    CBox_names: TComboBox;
    procedure btOKClick(Sender: TObject);
    procedure BtExitClick(Sender: TObject);
    procedure edUserNameEnter(Sender: TObject);
    procedure edPasswordEnter(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure EditChange(Sender: TObject);
    procedure edPasswordKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdUserNameKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure CBox_namesChange(Sender: TObject);
    procedure cb_bynameClick(Sender: TObject);

  protected
    procedure CtrlState;

  private
    procedure ProvPass(us:string;pas:string);
  public
    procedure Translate;override;
  end;

const CyrLayout = $4190419;
      LatLayout = $4090409;

var
  ZastFrm: TZastFrm;

implementation
  uses main,dialogs,inifiles, datam, avartype, dmmain;

{$R *.DFM}
//----------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////
//--------------------------------------------------------------------------------//
procedure TZastFrm.CtrlState;
begin
 BtOk.Enabled:=(Trim(edPassword.Text) <> '')and(Trim(edUserName.Text) <> '');
end;

//*******************************************************************

procedure DefineRights(_RightsSet:TRightsSet);
begin
  // Проверка WRITE
  RightsSet:=_RightsSet;
  //
  FormMain.Dic_mi.Enabled:=rsZAV in RightsSet;
  FormMain.NewZav_mi.Enabled:=rsZAV in RightsSet; // новая заявка (меню)
  FormMain.SI_new.Enabled:=rsZAV in RightsSet; // новая заявка (toolbutton)
  // Проверка SPRAV
  FormMain.CanEdidDic:=rsSPRAV in RightsSet;
  FormMain.S_Brig_mi.Enabled:=FormMain.CanEdidDic;
  // Проверка ADMIN
  FormMain.AdminRight:=rsADMIN in RightsSet;
  FormMain.CanShift := rsZAV in RightsSet; //редактировать смену
end;

function ParseRightsStr(value:string):TRightsSet;
begin
  result:=[];
  if Pos('READ',value)>0 then result:=result+[rsREAD];  
  if Pos('ZAV',value)>0 then result:=result+[rsZAV];
  if Pos('SPRAV',value)>0 then result:=result+[rsSPRAV];
  if Pos('RASK',value)>0 then result:=result+[rsRASK];
  if Pos('ZADV',value)>0 then result:=result+[rsZADV];
  if Pos('NARAD',value)>0 then result:=result+[rsNARAD];
  if Pos('POTER',value)>0 then result:=result+[rsPOTER];
  if Pos('DEL',value)>0 then result:=result+[rsDELZAV];
  if Pos('ADMIN',value)>0 then result:=result+[rsADMIN];
  if Pos('WWATER',value)>0 then result:=result+[rsWWATER];
end;

procedure TZastFrm.btOKClick(Sender: TObject);
var i:integer;
begin
 try
   with DM1 do
    begin
     if CodUser > -1 then FormMain.setFormPlacement;
     BtOk.Enabled:=false;
     BtExit.Enabled:=false;
     if (edPassword.Text='')or(edUserName.Text='') then
       exit;
      Animate.Show;
      Animate.Active:=True;
      Animate.BringToFront;
      {FormMain.}DB_Avar.LoginPrompt:=False;
      {FormMain.}DB_Avar.Connected:=False;
      {FormMain.}Db_Avar.Params.Clear;
      {FormMain.}Db_Avar.Params.Add(Format('USER NAME=%s',['UserRO']));
      {FormMain.}Db_Avar.Params.Add(Format('PASSWORD=%s',['ROS_USER']));
      {FormMain.}Db_Avar.Connected:=true;
      Qry_user.Open;
      if (Trim(edUserName.Text)='') or (Trim(edPassword.Text)='')
        then begin
          exit;
        end;
      NameUser:=AnsiUpperCase(Trim(edUserName.Text));
      Qry_user.Last;
      Qry_user.First;
      if Qry_user.Locate('NAME_R',NameUser,[]) then
        begin
          TekUser:=Qry_user.FieldByName('UID').asString;
          CodUser:=Qry_user.FieldByName('ID').asInteger;
          DefineRights(ParseRightsStr(Qry_user.FieldByName('PRAVA').asString));
        end
           else TekUser:=''{NameUser};

      Qry_user.Close;
      if AnsiUpperCase(NameUser) = 'SYSDBA' then
        begin
         TekUser:=NameUser;
         NameUser:=TrLangMSG(msgAdmin);
         CodUser:=0;
         //
         DefineRights(ParseRightsStr('READ;ZAV;RASK;ZADV;NARAD;POTER;SPRAV;DELZAV;ADMIN;WWATER'));
         ProvPass(NameUser,edPassword.Text);
        end;
      {FormMain.}Db_Avar.Connected:=false;
     try
      {FormMain.}Db_Avar.Params.Clear;
      {FormMain.}Db_Avar.Params.Add(Format('USER NAME=%s',[TekUser]));
      {FormMain.}Db_Avar.Params.Add(Format('PASSWORD=%s',[Trim(edPassword.Text)]));
      try
        {FormMain.}Db_Avar.Connected:=true;
        DM_Main.ConnectToDB(TekUser, Trim(edPassword.Text));
        DM_Main.ConnectToDB_AvrImage(TekUser, Trim(edPassword.Text));
        
      except
        on E: Exception do
        begin
          MessageDlg( TrLangMSG(msgWrongPasswd) + '(' + E.Message + ')',
                              mtError, [mbYes], 0);
        end;
      end;
     finally
      Animate.Active:=False;
      Animate.Hide;
     end;
      if {FormMain.}Db_Avar.Connected then
        begin
         ZastFrm.Close;
         ModalResult:=mrOk;
         FormMain.getFormPlacement;
         ActivateKeyboardLayout(CyrLayout,0);
        end;
    end; // with
  finally
   BtExit.Enabled:=true;
  end; 
end;

//----------------------------------------------------------------------------------
procedure TZastFrm.BtExitClick(Sender: TObject);
begin
 ZastFrm.Close;
{ FormMain.visible:=false;
 Application.Terminate;
 exit;}
end;
//----------------------------------------------------------------------------------
procedure TZastFrm.edUserNameEnter(Sender: TObject);
begin
//  if btOk.Enabled then
  ActivateKeyboardLayout(CyrLayout,0);
end;
//----------------------------------------------------------------------------------
procedure TZastFrm.ProvPass(us:string;pas:string);
var i,j,len1,len2:integer;
    tt_str:string;
    mIni:TIniFile;
    fl:boolean;
begin
   tt_str:='';
   fl:=true;
   len1:=length(us);
   len2:=length(pas);
   i:=1;
   if pas[1]='~' then
     begin
      pas:=copy(pas,2,1000);
      len2:=length(pas);
      mIni:=TIniFile.Create(FullPathIniFlAvar{CurrentDir+'\avar.ini'});
      us:=copy(mIni.ReadString('Default','ColorIniStr','1234567890'),4,1000);
      mIni.Free;
      fl:=false;
      len1:=length(us);
     end;
   for j:=1 to len2 do
    begin
      tt_str:=tt_str+chr(ord(us[i]) xor ord(pas[j]));
      inc(i);
      if i>len1 then
        i:=1;
    end;
  if fl then
   begin
     mIni:=TIniFile.Create(FullPathIniFlAvar{CurrentDir+'\avar.ini'});
     mIni.WriteString('Default','ColorIniStr','q#1'+tt_str);
     mIni.Free;
   end
  else
   edPassword.Text:=tt_str;
end;
//----------------------------------------------------------------------------------
procedure TZastFrm.edPasswordEnter(Sender: TObject);
begin
//  if btOk.Enabled then
 ActivateKeyboardLayout(LatLayout,0);
end;
//----------------------------------------------------------------------------------
procedure TZastFrm.FormActivate(Sender: TObject);
begin
    RXLabel3.Caption:=TrLangMSG(msgClientServer)
end;

procedure TZastFrm.FormCreate(Sender: TObject);
begin
{$ifdef debug}
  EdUserName.text:='SYSDBA';
  EdPassword.text:='masterkey';
{$endif}

 ZastFrm:=Self;
 CtrlState;
 RxLabel4.Caption:=TempVersion;
end;

procedure TZastFrm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = #13 then
  begin
   if edPassword.Text='' then ActiveControl:=edPassword
      else if edUserName.Text='' then ActiveControl:=edUserName
              else if BtOk.enabled then ActiveControl:=BtOk;
   Key := #0;
  end;
end;

//*******************************************************************
procedure TZastFrm.EditChange(Sender: TObject);
begin
 CtrlState;
end;

//*******************************************************************
procedure TZastFrm.edPasswordKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (key = VK_RETURN)and(BtOK.Enabled)
    then btOKClick(self);   


 end;

procedure TZastFrm.Translate;
begin
  inherited;
  Caption:=TrLangMSG(msgRunIdentUser);
  RxLabel1.Caption:=TrLangMSG(msgKiev);
  RxLabel2.Caption:=TrLangMSG(msgMashineVxod);
  lUserName.Caption:=TrLangMSG(msgNameUser);
  BtExit.Caption:=TrLangMSG(msgExit);
end;

procedure TZastFrm.EdUserNameKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (key = VK_RETURN)and(BtOK.Enabled)
    then btOKClick(self);
end;

procedure TZastFrm.FormShow(Sender: TObject);
var  mIni:TIniFile;
user,pass:String;
items:TStringList;
i:integer;
begin
  inherited;
  mIni:=TIniFile.Create(FullPathIniFlAvar{CurrentDir+'\avar.ini'});
  user:= mIni.ReadString('Vxod', 'User','User');
  pass:= mIni.ReadString('Vxod', 'Pass','Pass');
  mIni.Free;
  items:=TStringList.Create;
  try
    if  DM_Main.getNames(items, user, pass) then
     begin
       for i:=0 to items.Count-1 do
         CBox_names.Items.Add(trim(items[i]));
       if items.Count>0 then
       begin
        CBox_names.ItemIndex:=0;
        EdUserName.Text:=CBox_names.Text;
       end;
     end;
  finally
    items.Free;
  end;
end;

procedure TZastFrm.CBox_namesChange(Sender: TObject);
begin
  inherited;
  EdUserName.Text:=CBox_names.Text;
end;

procedure TZastFrm.cb_bynameClick(Sender: TObject);
begin
  inherited;
  CBox_names.Visible:= not cb_byname.Checked;
  EdUserName.Visible:= cb_byname.Checked;
end;

end.
