unit adm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, RXLookup, Db, DBTables, Buttons, sfexec, ExtCtrls, frmLANG, cntsLANG,
  ServiceFuncUnit;

type
  TFormAdm = class(TFormLang)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Lb_us: TLabel;
    DBL_brig: TRxDBLookupCombo;
    Ed_uid: TEdit;
    GrB_prava: TGroupBox;
    ChB_read: TCheckBox;
    ChB_Sprav: TCheckBox;
    GrB_Pass: TGroupBox;
    Ed_pas1: TEdit;
    Ed_pas2: TEdit;
    BB_Close: TBitBtn;
    BB_Save: TBitBtn;
    Ed_adm: TEdit;
    Qry_brig: TQuery;
    DS_brig: TDataSource;
    Exec: TsfAppExec;
    Qry_tmp: TQuery;
    Db_isc: TDatabase;
    Qry_isc: TQuery;
    Bevel1: TBevel;
    Pn_stat: TPanel;
    Lb_izm: TLabel;
    Admin_chb: TCheckBox;
    Check: TDatabase;
    Database1: TDatabase;
    ProcQueryTmp: TQuery;
    Qry_isc2: TQuery;
    ChB_WriteZav: TCheckBox;
    ChB_WriteRask: TCheckBox;
    ChB_WriteZadv: TCheckBox;
    ChB_WriteNarad: TCheckBox;
    ChB_WritePoter: TCheckBox;
    ChB_Del: TCheckBox;
    ChB_wwater: TCheckBox;
    procedure DBL_brigChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Ed_uidChange(Sender: TObject);
    procedure DBL_brigClick(Sender: TObject);
    procedure BB_SaveClick(Sender: TObject);
    procedure Ed_admEnter(Sender: TObject);
    procedure ChB_readClick(Sender: TObject);
    procedure DBL_brigEnter(Sender: TObject);
    procedure Admin_chbClick(Sender: TObject);
    procedure BB_CloseClick(Sender: TObject);
  private
    isChange:boolean;
    old_uid:string;
    procedure CtrlState;
    Procedure CheckUser;
  public
    procedure ElemChange(isCh:boolean);
    procedure Up_Rec;
    procedure Translate;override;
  end;

const //ReadOnlyUser='ELLA';
      CyrLayout = $4190419;
      LatLayout = $4090409;
      MasBazDl  = 49;
      MasBaz:array [1..MasBazDl] of string =
                 ('TABLELOG','MATERS','NARAD' ,'NNARAD' ,'NZAVJAV','OBORS' ,'ZAVJAV',
                  'RASKOP','WWATER','PLANOBORS',
                  '!S_BRIG','!S_DAMG' ,'!S_DIAM' ,'!S_MAT' ,'!S_MEST',
                  '!S_OBOR','S_ORG' ,'!S_PLACE','!S_RAYON','!S_PAD','!S_WELL',
                  '!S_SOD' ,'!S_TZAV','!S_ULIC' ,'!S_VIDUL','!S_WORK','!S_ZAV',
                  'TADR'  ,'WORKS' ,'ZADV','!S_SAH','!S_ALIEN','!S_ATTACH',
                  '!TBL_CONST','!S_KILLCLOG',
                  '!S_OWNER','!S_TEAM','!S_MATPIPE','!S_BOLT','ORD_PEOPLE',
                  '!S_ZAYAVL','!S_REMONT', '!S_OWNER_TYPE',
                  '!S_FILL','!S_LOCAL','!S_PES','!S_PUMP','!S_COMMENT','!S_PLANOBOR');

    {30.07.2004}
    Procs:array [1..5] of string =('CNT_DAMG2UL','COUNT_DAMG','MEXAN','S_WORK_NAME_AND_ED_IZM_PROC','GET_ADRES');
    {/30.07.2004}
var
  FormAdm: TFormAdm;

implementation
   uses strtool,inifiles,main,avartype;
{$R *.DFM}

procedure TFormAdm.DBL_brigChange(Sender: TObject);
begin
   Ed_uid.Text:=Qry_Brig.FieldByName('UID').asString;
   Ed_pas1.Text:='';
   Ed_pas2.Text:='';
   old_uid:=Ed_uid.Text;
   ChB_Read.Checked:=(pos('READ',Qry_Brig.FieldByName('PRAVA').asString)>0);
   ChB_Sprav.Checked:=(pos('SPRAV',Qry_Brig.FieldByName('PRAVA').asString)>0);
   ChB_WriteZav.Checked:=(pos('ZAV',Qry_Brig.FieldByName('PRAVA').asString)>0);
   ChB_WriteRask.Checked:=(pos('RASK',Qry_Brig.FieldByName('PRAVA').asString)>0);
   ChB_WriteZadv.Checked:=(pos('ZADV',Qry_Brig.FieldByName('PRAVA').asString)>0);
   ChB_WritePoter.Checked:=(pos('POTER',Qry_Brig.FieldByName('PRAVA').asString)>0);
   ChB_WWater.Checked:=(pos('WWATER',Qry_Brig.FieldByName('PRAVA').asString)>0);
   ChB_WriteNarad.Checked:=(pos('NARAD',Qry_Brig.FieldByName('PRAVA').asString)>0);
   ChB_Del.Checked:=(pos('DELZAV',Qry_Brig.FieldByName('PRAVA').asString)>0);
   Admin_chb.Checked:=(pos('ADMIN',Qry_Brig.FieldByName('PRAVA').asString) > 0);
   ElemChange(false);
end;

procedure TFormAdm.FormCreate(Sender: TObject);
begin
 old_uid:='';
 isChange:=false;
 Qry_brig.Open;
 Up_Rec;
 ElemChange(false);
 CtrlState; // ds
end;

procedure TFormAdm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   try
   ActivateKeyboardLayout(CyrLayout,0);
   Qry_brig.Close;
   except
   end;
   Action:=caFree;
end;

procedure TFormAdm.Ed_uidChange(Sender: TObject);
begin
  ElemChange(true);
end;

procedure TFormAdm.ElemChange(isCh:boolean);
begin
 if isCh then
  begin
   Lb_izm.Caption:=TrLangMSG(msgChangeNoSave);
   isChange:=true;
  //ds BB_Save.Enabled:=true;
  end
 else
  begin
   Lb_izm.Caption:='';
   isChange:=false;
  //ds BB_Save.Enabled:=false;
  end;
 CtrlState; // ds
end;


procedure TFormAdm.DBL_brigClick(Sender: TObject);
begin
{  if isChange then
    if MessageDlg('?',
               mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin}

end;

procedure TFormAdm.BB_SaveClick(Sender: TObject);
var tt_str,tt_del,tt_rd,tt_wrt,tt_str2,gs_db,tt_adm,Ed_uid_Text:string;
    tt_adm_isc4:string;
    isOk:boolean;
    Reg,i,isExUs:integer;
    mIni:TIniFile;
    str1,passw :string; // ds
begin
  Db_isc.Connected:=false;
  gs_db:='';
  isExUs:=-1;
  mIni:=TIniFile.Create(FullPathIniFlAvar{CurrentDir+'\avar.ini'});
  gs_db:=mIni.ReadString('Setup','gsecDataBase','');
  // ds
  str1:=mIni.ReadString('Setup','IB_Bin', ExtractFilePath(gs_db)+'bin\');
  if str1[length(str1)] <> '\' then str1:=str1 + '\';
  Exec.ApplicationName:=str1 +'gsec.exe';
  // ds
  mIni.Free;
  if gs_db<>'' then
    begin
     {i:=-1;
     for j:=0 to Db_isc.Params.Count-1 do
       begin
         if First(11,Db_isc.Params.Strings[j])='SERVER NAME' then
            begin
              i:=j;
              break;
            end;
       end;}
     i:=Db_isc.Params.IndexOfName('SERVER NAME');
     if i>-1 then
       Db_isc.Params.Strings[i]:='SERVER NAME='+gs_db;

     i:=Db_isc.Params.IndexOfName('USER NAME');
     if i>-1 then
       Db_isc.Params.Strings[i]:='USER NAME='+TekUser;

     i:=Db_isc.Params.IndexOfName('PASSWORD');
     //Application.MessageBox(PChar('passw='+passw),'1');
     if i>-1 then
       begin
        if (FormMain.AdminRight)and(Trim(Ed_Adm.Text) = '')
           then passw:=DefAdmPassw
           else passw:=Ed_Adm.Text;
        Db_isc.Params.Strings[i]:='PASSWORD='+passw;
       end;
     try
       Db_isc.Connected:=true;
       Qry_isc.Open;
       if Qry_isc.Locate('USER_NAME',upper(old_uid),[]) then
          isExUs:=1
       else
          isExUs:=0;
       Qry_isc.Close;
//       Db_isc.Connected:=false;
     except
     end;
     gs_db:=' -database "'+gs_db+'" ';
    end;
  //
  isOk:=false;
  Reg:=0;
  Lb_Us.Caption:=inttostr(isExUs);
  //Application.MessageBox(PChar('passw='+passw),'3');
  if passw = ''{Ed_Adm.Text=''} then
    begin
     MessageDlg(TrLangMSG(msgPasswdAdminNoDefine),
                          mtError, [mbYes], 0);
     exit;
    end;
  tt_str:='';
  if ChB_Read.Checked then tt_str:='READ;';
  if ChB_WriteZav.Checked then tt_str:=tt_str+'ZAV;';
  if ChB_WriteRask.Checked then tt_str:=tt_str+'RASK;';
  if ChB_WriteZadv.Checked then tt_str:=tt_str+'ZADV;';
  if ChB_writePoter.Checked then tt_str:=tt_str+'POTER;';
  if ChB_WriteNarad.Checked then tt_str:=tt_str+'NARAD;';
  if ChB_Sprav.Checked then tt_str:=tt_str+'SPRAV;';
  if ChB_Del.Checked then tt_str:=tt_str+'DELZAV;';
  if Admin_chb.Checked then tt_str:=tt_str+'ADMIN;';
  if chb_wwater.Checked then tt_str:=tt_str+'WWATER';


  if Ed_uid.Text <> '' then
    begin
      if (Ed_pas1.Text<>Ed_pas2.Text) or (Ed_pas1.Text='') then
         begin
               MessageDlg(TrLangMSG(msgPasswdNoDefineOrConfirm),
                          mtError, [mbYes], 0);
           exit;
         end;
    end;

  if (old_uid<>Ed_uid.Text) then
   begin
    if (old_uid<>'') then
       begin
         if isExUs<>0 then
          begin
//             Exec.Parameters:=gs_db+'-user sysdba -password '+{Ed_adm.Text}passw+' -del '+
//                 old_uid;
             Exec.Parameters:=gs_db+'-user '+TekUser+' -password '+{Ed_adm.Text}passw+' -del '+
                 old_uid;
             Exec.Execute;
          end;
         Reg:=3;
         if (Exec.ExitCode=0) or (isExUs=0) then
          begin
            Qry_tmp.Close;
            Qry_tmp.SQL.Clear;
            Qry_tmp.SQL.Add('update s_brig set uid="",prava="" where id='+Qry_Brig.FieldByName('ID').asString);
            Qry_tmp.ExecSQL;
            Qry_tmp.SQL.Clear;
            Qry_tmp.SQL.Add('COMMIT');
            Qry_tmp.ExecSQL;
            isOk:=true;
          end;
       end;
    if (Exec.ExitCode=0) and (Ed_uid.Text<>'') then
      begin
//         Exec.Parameters:=gs_db+'-user sysdba -password '+{Ed_adm.Text}passw+' -add '+
//                     Ed_uid.Text+' -pw '+Ed_pas1.Text;
         Exec.Parameters:=gs_db+'-user '+TekUser+' -password '+{Ed_adm.Text}passw+' -add '+
                     Ed_uid.Text+' -pw '+Ed_pas1.Text;
         Exec.Execute;
         Reg:=1;
         if Exec.ExitCode=0 then
          begin
            Qry_tmp.Close;
            Qry_tmp.SQL.Clear;
            Qry_tmp.SQL.Add('update s_brig set uid="'+Ed_uid.Text+'",prava="'+
                            tt_str+'" where id='+Qry_Brig.FieldByName('ID').asString);
            Qry_tmp.ExecSQL;
            Qry_tmp.SQL.Clear;
            Qry_tmp.SQL.Add('COMMIT');
            Qry_tmp.ExecSQL;
            isOk:=true;
          end
         else
            isOk:=false;
      end;
   end
  else
   begin
    if  isExUs=1 then
      begin
//        Exec.Parameters:=gs_db+'-user sysdba -password '+{Ed_adm.Text}passw+' -mod '+
//                         Ed_uid.Text+' -pw '+Ed_pas1.Text;
        Exec.Parameters:=gs_db+'-user '+TekUser+' -password '+{Ed_adm.Text}passw+' -mod '+
                         Ed_uid.Text+' -pw '+Ed_pas1.Text;
      end
    else
      begin
//         Exec.Parameters:=gs_db+'-user sysdba -password '+{Ed_adm.Text}passw+' -add '+
//                     Ed_uid.Text+' -pw '+Ed_pas1.Text;
         Exec.Parameters:=gs_db+'-user '+TekUser+' -password '+{Ed_adm.Text}passw+' -add '+
                     Ed_uid.Text+' -pw '+Ed_pas1.Text;
      end;
    Exec.Execute;
    Reg:=2;
    if Exec.ExitCode=0 then
          begin
            Qry_tmp.Close;
            Qry_tmp.SQL.Clear;
            Qry_tmp.SQL.Add('update s_brig set uid="'+Ed_uid.Text+'",prava="'+
                            tt_str+'" where id='+Qry_Brig.FieldByName('ID').asString);
            Qry_tmp.ExecSQL;
            Qry_tmp.SQL.Clear;
            Qry_tmp.SQL.Add('COMMIT');
            Qry_tmp.ExecSQL;
            isOk:=true;
          end
         else
            isOk:=false;
   end;
   if isOk then
     begin
        tt_wrt:='grant select,insert,update,delete on ';
        tt_rd:='grant select on ';
        tt_del:='revoke all on ';
        tt_adm:=' WITH GRANT OPTION';
        tt_adm_isc4:='users ';
        if (Reg=3) or (Reg=2) then //удалить или модифицировать
          begin
            for i:=1 to MasBazDl do
             begin
              tt_str2:=Strip('A','!#',MasBaz[i]);
              Qry_tmp.SQL.Clear;
              Qry_tmp.SQL.Add(tt_del+tt_str2+' from '+old_uid);
              Qry_tmp.ExecSQL;
             end;
          end;

        if ((Reg=1) or (Reg=2)) and ChB_Read.Checked then //добавить или модифицировать
          begin
            Ed_uid_Text:=Ed_uid.Text;
            if Admin_chb.Checked then Ed_uid_Text:=Ed_uid_Text+tt_adm;
            MyExecSQL(Qry_tmp,tt_wrt+'TABLELOG'+' to '+Ed_uid_Text);
            MyExecSQL(Qry_tmp,tt_wrt+'TADR'+' to '+Ed_uid_Text);
            for i:=1 to MasBazDl do
              if pos('!',MasBaz[i])>0 then
                begin
                  tt_str2:=Strip('A','!#',MasBaz[i]);
                  if ChB_Sprav.Checked then
                    MyExecSQL(Qry_tmp,tt_wrt+tt_str2+' to '+Ed_uid_Text)
                  else
                    MyExecSQL(Qry_tmp,tt_rd+tt_str2+' to '+Ed_uid_Text);
                end; //end if pos

            if ChB_WriteZav.Checked then
              begin
                MyExecSQL(Qry_tmp,tt_wrt+'ZAVJAV to '+Ed_uid_Text);
                MyExecSQL(Qry_tmp,tt_wrt+'NZAVJAV to '+Ed_uid_Text);
                MyExecSQL(Qry_tmp,tt_wrt+'S_ORG to '+Ed_uid_Text);
              end
            else
              begin
                MyExecSQL(Qry_tmp,tt_rd+'ZAVJAV to '+Ed_uid_Text);
                MyExecSQL(Qry_tmp,tt_rd+'NZAVJAV to '+Ed_uid_Text);
                MyExecSQL(Qry_tmp,tt_rd+'S_ORG to '+Ed_uid_Text);
              end;



            if (ChB_WritePoter.Checked) and (not ChB_WriteZav.Checked) then
            MyExecSQL(Qry_tmp,'grant select, update (pressure, square, q, GLZ, Op_Protyazh, CL_Doza, '+
            'CL_Contact_Time, CL_Promiv_Time, CL_Pressure, Utoch_Xar_Povr, Op_Id_Diam) on NZAVJAV to '+Ed_uid_Text);

            if ChB_WriteRask.Checked then  MyExecSQL(Qry_tmp,tt_wrt+'RASKOP to '+Ed_uid_Text)
            else MyExecSQL(Qry_tmp,tt_rd+'RASKOP to '+Ed_uid_Text);

            if ChB_WriteZadv.Checked then MyExecSQL(Qry_tmp,tt_wrt+'ZADV to '+Ed_uid_Text)
            else MyExecSQL(Qry_tmp,tt_rd+'ZADV to '+Ed_uid_Text);

            if ChB_WWater.Checked then MyExecSQL(Qry_tmp,tt_wrt+'WWATER to '+Ed_uid_Text)
            else MyExecSQL(Qry_tmp,tt_rd+'WWATER to '+Ed_uid_Text);

            if ChB_WriteNarad.Checked then
              begin
                MyExecSQL(Qry_tmp,tt_wrt+'NARAD to '+Ed_uid_Text);
                MyExecSQL(Qry_tmp,tt_wrt+'NNARAD to '+Ed_uid_Text);
                MyExecSQL(Qry_tmp,tt_wrt+'ORD_PEOPLE to '+Ed_uid_Text);
                MyExecSQL(Qry_tmp,tt_wrt+'OBORS to '+Ed_uid_Text);
                MyExecSQL(Qry_tmp,tt_wrt+'WORKS to '+Ed_uid_Text);
                MyExecSQL(Qry_tmp,tt_wrt+'MATERS to '+Ed_uid_Text);
                MyExecSQL(Qry_tmp,tt_wrt+'PLANOBORS to '+Ed_uid_Text);
              end
            else
              begin
                MyExecSQL(Qry_tmp,tt_rd+'NARAD to '+Ed_uid_Text);
                MyExecSQL(Qry_tmp,tt_rd+'NNARAD to '+Ed_uid_Text);
                MyExecSQL(Qry_tmp,tt_rd+'ORD_PEOPLE to '+Ed_uid_Text);
                MyExecSQL(Qry_tmp,tt_rd+'OBORS to '+Ed_uid_Text);
                MyExecSQL(Qry_tmp,tt_rd+'WORKS to '+Ed_uid_Text);
                MyExecSQL(Qry_tmp,tt_rd+'MATERS to '+Ed_uid_Text);
                MyExecSQL(Qry_tmp,tt_rd+'PLANOBORS to '+Ed_uid_Text);
              end;
          end; // end if ((Reg=1) or (Reg=2))

       (* if ((Reg=1) or (Reg=2)) and ChB_Read.Checked then //добавить или модифицировать
          begin
                  Ed_uid_Text:=Ed_uid.Text;
                  if Admin_chb.Checked then Ed_uid_Text:=Ed_uid_Text+tt_adm;
                  for i:=1 to MasBazDl do
                    begin
                       Qry_tmp.SQL.Clear;
                       tt_str2:=Strip('A','!#',MasBaz[i]);
                       if pos('#',MasBaz[i])>0 then
                          Qry_tmp.SQL.Add(tt_rd+tt_str2+' to '+Ed_uid_Text)
                       else if pos('!',MasBaz[i])>0 then
                          begin
                            if ChB_Sprav.Checked then
                               Qry_tmp.SQL.Add(tt_wrt+tt_str2+' to '+Ed_uid_Text)
                            else
                               Qry_tmp.SQL.Add(tt_rd+tt_str2+' to '+Ed_uid_Text)
                          end
                       else
                          begin
                            if ChB_Write.Checked then
                               Qry_tmp.SQL.Add(tt_wrt+tt_str2+' to '+Ed_uid_Text)
                            else
                               Qry_tmp.SQL.Add(tt_rd+tt_str2+' to '+Ed_uid_Text)
                          end;
                       Qry_tmp.ExecSQL;
                    end;
          //
          end;  *)
         //
         {30.07.2004}
         {Установим права на исполнения для пользователя на процедуры:
         CNT_DAMG2UL,COUNT_DAMG,MEXAN}
         {30.09.2004 и процедуре S_WORK_NAME_AND_ED_IZM_PROC}
         for i:=1 to 5 do
          begin
             {Qry_tmp.SQL.Clear;
             Qry_tmp.SQL.Add('GRANT EXECUTE ON PROCEDURE '+Procs[i]+' TO '+Ed_uid.Text);
             Qry_tmp.ExecSQL;}
             ProcQueryTmp.SQL.Clear;
             ProcQueryTmp.SQL.Add('GRANT EXECUTE ON PROCEDURE '+Procs[i]+' TO '+Ed_uid.Text);
             ProcQueryTmp.ExecSQL;
           end;
           ProcQueryTmp.SQL.Clear;
           ProcQueryTmp.SQL.Add('COMMIT');
           ProcQueryTmp.ExecSQL;
         //А это от Антона
         {
          CountSpProc =1;
          SpProcBase:array [1..CountSpProc] of string =('twotimesrepeat');
          //
          tt_wrt:='grant select,insert,update,delete on ';
          ttsp_wrt:='grant execute on procedure ';
          tt_rd:='grant select on ';
          tt_del:='revoke all on ';
          ttsp_del:='revoke execute on procedure ';

          for i:=1 to CountSpProc do
          begin
            Qry_tmp.SQL.Clear;
            if ChB_Read.Checked then
              Qry_tmp.SQL.Add(ttsp_wrt+SpProcBase[i]+' to '+Ed_uid.Text)
            else
              Qry_tmp.SQL.Add(ttsp_del+SpProcBase[i]+' to '+Ed_uid.Text);
            Qry_tmp.ExecSQL;
          end;
         }
         {/30.07.2004}
         //
         Qry_tmp.SQL.Clear;
         Qry_tmp.SQL.Add('COMMIT');
         Qry_tmp.ExecSQL;
     end;
  if Admin_chb.Checked then
  begin
     Qry_isc2.SQL.Clear;
     Qry_isc2.SQL.Add(tt_wrt+tt_adm_isc4+'to '+Ed_uid.Text+tt_adm);
     Qry_isc2.ExecSQL;
     Qry_isc2.SQL.Clear;
     Qry_isc2.SQL.Add('COMMIT');
     Qry_isc2.ExecSQL;
  end
    else
  begin
     Qry_isc2.SQL.Clear;
     Qry_isc2.SQL.Add(tt_del+tt_adm_isc4+'from '+Ed_uid.Text);
     Qry_isc2.ExecSQL;
     Qry_isc2.SQL.Clear;
     Qry_isc2.SQL.Add('COMMIT');
     Qry_isc2.ExecSQL;
  end;
  Db_isc.Connected:=false;
  //messagedlg('3',mtInformation,[mbOK],0);
  CheckUser;
  Up_rec;
end;

Procedure TFormAdm.CheckUser;
begin
  try
    self.BringToFront;
    //
    Check.params.Values['USER NAME']:=Ed_uid.text;
    Check.params.values['PASSWORD']:=Ed_pas1.text;
    Check.connected:=true;
    Check.connected:=false;
    MessageBox(handle,'Пользоватеть получил доступ к базе!','АРМ Диспетчера АВР',
      MB_OK or MB_ICONINFORMATION);
    //messagedlg('Пользоватеть получил доступ к базе!',mtInformation,[mbOK],0);
  except
    MessageBox(handle,'Пользоватеть не получил доступ к базе! Попробуйте еще.','АРМ Диспетчера АВР',
      MB_OK or MB_ICONHAND);
    //messagedlg('Пользоватеть не получил доступ к базе! Попробуйте еще.',mtError,[mbOK],0);
  end;
  Check.connected:=false;
end;

procedure TFormAdm.Up_Rec;
//var tmp_id:integer;
begin
// tmp_id:=Qry_Brig.FieldByName('ID').asInteger;
 Qry_Brig.Close;
 Qry_Brig.Open;
{temp
 Qry_Brig.Locate('ID',tmp_id,[]);
 DBL_Brig.DisplayValue:=Qry_Brig.FieldByName('NAME_R').asString;
 }
 DBL_brigChange(Self);
end;

procedure TFormAdm.Ed_admEnter(Sender: TObject);
begin
  ActivateKeyboardLayout(LatLayout,0);             
end;

procedure TFormAdm.ChB_readClick(Sender: TObject);
begin
  if not ChB_Read.Checked then
    begin
      ChB_Sprav.Checked:=false;
      Admin_chb.Checked:=false;
      ChB_WriteZav.Checked:=false;
      ChB_WriteRask.Checked:=false;
      ChB_WriteZadv.Checked:=false;
      ChB_WriteNarad.Checked:=false;
      ChB_WritePoter.Checked:=false;
      ChB_Del.Checked:=false;
    end;
  //
  ChB_Sprav.Enabled:=ChB_Read.Checked;
  Admin_chb.Enabled:=ChB_Read.Checked;
  ChB_WriteZav.Enabled:=ChB_Read.Checked;
  ChB_WriteRask.Enabled:=ChB_Read.Checked;
  ChB_WriteZadv.Enabled:=ChB_Read.Checked;
  ChB_WriteNarad.Enabled:=ChB_Read.Checked;
  ChB_WritePoter.Enabled:=ChB_Read.Checked;
  ChB_WWater.Enabled:=ChB_Read.Checked;
  ChB_Del.Enabled:=ChB_Read.Checked;
  //
  CtrlState;
end;

procedure TFormAdm.DBL_brigEnter(Sender: TObject);
begin
  ActivateKeyboardLayout(CyrLayout,0);
end;

//*******************************************************************
procedure TFormAdm.CtrlState;
begin
 BB_Save.Enabled:=(ChB_read.Checked)and(DBL_brig.Text <> '')and
                  (Trim(Ed_uid.Text) <> '');
end;

//*******************************************************************
procedure TFormAdm.Admin_chbClick(Sender: TObject);
begin
 if Admin_chb.Checked then
   begin
     ChB_read.Checked:=true;
     ChB_Sprav.Checked:=true;
     ChB_WriteZav.Checked:=true;
     ChB_WriteRask.Checked:=true;
     ChB_WriteZadv.Checked:=true;
     ChB_WritePoter.Checked:=true;
     ChB_WWater.Checked:=true;
     ChB_WriteNarad.Checked:=true;
     ChB_Del.Checked:=true;
     //
     ChB_read.Enabled:=false;
     ChB_Sprav.Enabled:=false;
     ChB_WriteZav.Enabled:=false;
     ChB_WriteRask.Enabled:=false;
     ChB_WriteZadv.Enabled:=false;
     ChB_WritePoter.Enabled:=false;
     ChB_WWater.Enabled:=false;
     ChB_WriteNarad.Enabled:=false;
      ChB_Del.Enabled:=false;
   end
    else
   begin
     ChB_read.Enabled:=true;
     ChB_Sprav.Enabled:=true;
     ChB_WriteZav.Enabled:=true;
     ChB_WriteRask.Enabled:=true;
     ChB_WriteZadv.Enabled:=true;
     ChB_WritePoter.Enabled:=true;
     ChB_WWater.Enabled:=true;
     ChB_WriteNarad.Enabled:=true;
     ChB_Del.Enabled:=true;
   end;
 CtrlState;
end;

//*******************************************************************
procedure TFormAdm.Translate;
begin
  inherited;
  Caption:=TrLangMSG(msgUsers);
  Label1.Caption:=TrLangMSG(msgUserOne);
  Label2.Caption:=TrLangMSG(msgIdentUser);
  Label3.Caption:=TrLangMSG(msgPasswdAdmin);
  GrB_prava.Caption:=TrLangMSG(msgUserGrant);
  ChB_read.Caption:=TrLangMSG(msgRead);
  ChB_Sprav.Caption:=TrLangMSG(msgChangeSprav);
  ChB_WriteZav.Caption:=RightsAliases[rtZAV];
  ChB_WriteRask.Caption:=RightsAliases[rtRASK];
  ChB_WriteZadv.Caption:=RightsAliases[rtZADV];
  ChB_WriteNarad.Caption:=RightsAliases[rtNARAD];
  ChB_WritePoter.Caption:=RightsAliases[rtPOTER];
  ChB_Del.Caption:=RightsAliases[rtDELZAV];
  Admin_chb.Caption:=TrLangMSG(msgAdminJob);
  BB_Close.Caption:=TrLangMSG(msgClose);
  BB_Save.Caption:=TrLangMSG(msgSave);
end;

procedure TFormAdm.BB_CloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.
