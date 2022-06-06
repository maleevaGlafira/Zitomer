unit RaskopForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGRaskopDM, RaskopFrame, StdCtrls, Buttons, WorksInfoFrame, cntsLANG,
  OperAttFormUnit, DB,frmLANG;

type
  Tfrm_Raskop = class(TFormLang)
    btn_Post: TBitBtn;
    btn_Delete: TBitBtn;
    frame_Raskop: Tframe_Raskop;
    btn_Exit: TBitBtn;
    btn_Narad: TBitBtn;
    btn_Restore: TBitBtn;
    lbl_Restored: TLabel;
    frame_WorksInfo: Tframe_WorksInfo;
    btn_Act: TBitBtn;
    procedure btn_PostClick(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_NaradClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_RestoreClick(Sender: TObject);
    procedure btn_ActClick(Sender: TObject);
  private
    F_Raskop: Tdm_NGRaskop;
    F_IsZavClose: boolean;
    F_OperAtt: TOperAtt;
    F_MestTypeID: integer;
    F_rayon:integer;
    procedure OnChangeEnabledBtnsHandler(_EnabledBtns: TEnabledBtns);
    procedure OnShowRaskopInfoHandler( _RaskopInfo: string );
    procedure BuildEnabledForRestoreBtn;
  public
    constructor Create( AOwner: TComponent; ARaskop: Tdm_NGRaskop; AIsZavClose: boolean;
      AOperAtt: TOperAtt );
    property MestTypeID: integer read F_MestTypeID write F_MestTypeID;
    procedure Translate;override;
    property Rayon:integer write  f_rayon;

  end;

implementation

{$R *.dfm}

uses narad, reports_unit;

{ Tfrm_Raskop }

constructor Tfrm_Raskop.Create(AOwner: TComponent; ARaskop: Tdm_NGRaskop;
  AIsZavClose: boolean; AOperAtt: TOperAtt );
begin
  inherited Create( AOwner );
  F_Raskop := ARaskop;
  F_IsZavClose := AIsZavClose;
  F_OperAtt := AOperAtt;
  F_MestTypeID := -1;

  frame_Raskop.Raskop := F_Raskop;
  frame_Raskop.IsShowTabs := true;
  frame_Raskop.OnChangeEnabledBtns := OnChangeEnabledBtnsHandler;
  frame_Raskop.OnShowRaskopInfo := OnShowRaskopInfoHandler;
  frame_Raskop.Init;
end;

procedure Tfrm_Raskop.Translate;
begin
 //gb_Adres msgAddrRaskop
 self.Caption:=TrLangMSG(msgDigWorks);
 frame_Raskop.Translate();
 frame_WorksInfo.Label1.Caption:=TrLangMSG(msgNeedDoBlag);
 btn_Narad.Caption:=TrLangMSG(msgWent);
btn_Restore.Caption:=TrLangMSG( msgRecover);// Восстановить
///btn_Act//Акт
lbl_Restored.Caption:=TrLangMSG(msgRecovered); //Восстановлено
btn_Post.Caption:=TrLangMSG(msgSave);
btn_Delete.Caption:=TrLangMSG(msgDelete);
btn_Exit.Caption:=TrLangMSG(msgExit);


end;

procedure Tfrm_Raskop.btn_PostClick(Sender: TObject);
begin
  frame_Raskop.PostRaskop;
end;

procedure Tfrm_Raskop.btn_DeleteClick(Sender: TObject);
begin
  frame_Raskop.DeleteRaskop;
end;

procedure Tfrm_Raskop.OnChangeEnabledBtnsHandler(
  _EnabledBtns: TEnabledBtns);
begin
//  btn_Add.Enabled := _EnabledBtns.EnabledAdd;
//  btn_Copy.Enabled := _EnabledBtns.EnabledAdd;
  btn_Post.Enabled := _EnabledBtns.EnabledPost;
  btn_Delete.Enabled := _EnabledBtns.EnabledDelete;

  BuildEnabledForRestoreBtn;
end;

procedure Tfrm_Raskop.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if frame_Raskop.IsInsertOrEditMode then
  begin
    if //Application.MessageBox( 'Сохранить внесенные изменения?', 'Внимание',
      //MB_YESNO + MB_ICONQUESTION ) = ID_YES
      MessageDlg(TrLangMSG(msgSaveChanges),mtConfirmation,[mbYes,mbNo],0)= ID_YES
    then
      frame_Raskop.PostRaskop
    else
      frame_Raskop.CancelRaskop;

    CanClose := not frame_Raskop.IsInsertOrEditMode;
  end;
end;

procedure Tfrm_Raskop.OnShowRaskopInfoHandler(_RaskopInfo: string);
begin
  if trim( _RaskopInfo ) <> '' then
    Caption := TrLangMSG(msgDigWorks)+' - ' + _RaskopInfo;

  frame_WorksInfo.FillWorksInfo( F_Raskop.GetCurrentRaskopID, F_Raskop.GetCurrentMestID );
  BuildEnabledForRestoreBtn;
end;

procedure Tfrm_Raskop.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_Raskop.btn_NaradClick(Sender: TObject);
var
  _NaradMode, _RaskopID: integer;
  _NarForm: TFormNarad;
begin
  _RaskopID := F_Raskop.GetCurrentRaskopID;
  if _RaskopID < 1  then exit;
  if F_Raskop.dset_Raskop.State in [dsInsert, dsEdit] then
  begin
  MessageDlg(TrLangMSG(msgNeedSaveChanges),mtInformation, [mbOk], 0);
   { Application.MessageBox( 'Прежде сохраните внесенные изменения!',
      'Внимание', MB_OK + MB_ICONWARNING );}
    if btn_Post.Enabled then btn_Post.SetFocus;
    exit;
  end;


  try
    Hide;
    //
    F_Raskop.CommitTran; //Переоткрываем датасет раскопок, т.к. могли добавить новые раскопки

    if F_IsZavClose then _NaradMode := 0
    else _NaradMode := 1;

    _NarForm := TFormNarad.NarCreate( Self, _NaradMode, F_Raskop.ZavID,
      not( rsNARAD in RightsSet ), F_OperAtt);
    try
      _NarForm.DefaultActiveRaskopID := _RaskopID;
      _NarForm.MestTypeID := F_MestTypeID;
      _NarForm.ShowModal;
    finally
      _NarForm.Free;
    end;

    F_Raskop.DefaultActiveRaskopID := _RaskopID;
    F_Raskop.StartTran;
  finally
    Show;
  end;
{
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


  if isClosed then
    NarForm:=TFormNarad.NarCreate(Self,0,ZavCode,not(rsNARAD in RightsSet), ZavAttach)
  else
    NarForm:=TFormNarad.NarCreate(Self,1,ZavCode,not(rsNARAD in RightsSet), ZavAttach);

  InitNarForm( NarForm );

  ButVis(FormZav,false);
  visible:=false;
  NarForm.Caption:=NarForm.Caption+'     Заявка № '+Lb_NZav.Caption+'    '+Label13.Caption+'  '+DE_in.Text+'  '+copy(Time2Str(TE_in.DateTime),1,5);
  NarForm.ShowModal;
  if NarForm.SaveFlag then isSave(tcsNoChanged);
  NarForm.Free;
}
end;

procedure Tfrm_Raskop.FormCreate(Sender: TObject);
var  _RaskopID: integer;
begin
  F_Raskop.StartTran;

  _RaskopID := F_Raskop.GetCurrentRaskopID;
 // if _RaskopID < 1  then btn_Act.Enabled := false ;

end;

procedure Tfrm_Raskop.FormDestroy(Sender: TObject);
begin
  F_Raskop.CommitTran;
end;

procedure Tfrm_Raskop.BuildEnabledForRestoreBtn;
begin
{
  btn_Restore.Enabled := ( frame_WorksInfo.mt_NeedWorks.RecordCount < 1 ) and
    ( F_Raskop.IsCanRestoreCurrentRaskop );
}
  btn_Restore.Enabled := ( frame_WorksInfo.IsCanRestore ) and
    ( F_Raskop.IsCanRestoreCurrentRaskop );
  //
  if not F_Raskop.IsCurrentRaskopRestored then
  begin
    btn_Restore.Visible := true;
    lbl_Restored.Visible := false;
  end else
  begin
    btn_Restore.Visible := false;
    lbl_Restored.Visible := true;
  end;
end;

procedure Tfrm_Raskop.btn_RestoreClick(Sender: TObject);
begin
  F_Raskop.RestoreRaskop;
end;

procedure Tfrm_Raskop.btn_ActClick(Sender: TObject);

  function GetAdrRask : string;
   var ul1, dop: string;
       tadr: integer;
  begin
     tadr := frame_Raskop.dbl_tadr.KeyValue;
     ul1 := frame_Raskop.dbl_S_Ulic1.Text;
     dop := trim(frame_Raskop.ed_Dop_Adr.Text);
     if dop <> '' then dop := ' , ('+ dop + ')';
     case tadr of
       0 : result := ul1 +' , д.' + trim(frame_Raskop.ed_HouseNum.Text) + dop;
       1 : result := ul1 + ' / ' + trim(frame_Raskop.dbl_S_Ulic2.Text) + dop;
       2 : result := ul1 + ', мест.: ' + trim(frame_Raskop.dbl_S_DopAdres.Text) + dop;
      end;
  end;


  function KillSkob(_text: string): string;
   var i, p1, p2: integer;
  begin
         //
    p1 := pos( '[' , _text);
    While p1 > 0 do
    begin
     p1 := pos( '[' , _text);
     p2 := pos( ']' , _text);

     delete(_text, p1, p2-p1 + 1 );
    end;
    result := _text;
  end;



var sBRACT,sBRBLAG,sADRES, sNOMER, sOGRAGD, sNeedWork, sAddWork,
      sLEN, sWID, sDEP, sDTZAV, sDTTM :string;
    _RaskopID : integer;
begin
  inherited;
  _RaskopID := F_Raskop.GetCurrentRaskopID;
  if _RaskopID < 1  then exit;
  if F_Raskop.dset_Raskop.State in [dsInsert, dsEdit] then
  begin
    MessageDlg(TrLangMSG(msgNeedSaveChanges),mtInformation, [mbOk], 0);
    {Application.MessageBox( 'Прежде сохраните внесенные изменения!',
      'Внимание', MB_OK + MB_ICONWARNING );}
    if btn_Post.Enabled then btn_Post.SetFocus;
    exit;
  end;

  try
    DM_Reports:=TDM_Reports.Create(nil,trtActRask);
  except
    on E:Exception do
      begin
       MessageDlg('Tfrm_Raskop.btn_ActClick'+#13+E.Message,mtError, [mbOk], 0);
   {     MessageBox(handle,PChar('Tfrm_Raskop.btn_ActClick'#13+
          E.Message),'Диспетчер АВР', MB_OK or MB_ICONWARNING);}
        DM_Reports.Free;
        Exit;
      end;
  end;


 with frame_Raskop do
  begin
  sBRACT := dbl_S_Brig_Act.Text;
  sBRBLAG := dbl_S_Brig_Blag.Text;
  sADRES := GetAdrRask; 
  sNOMER := F_Raskop.ZavNum;
  sOGRAGD := mem_Ogragd.Text;
  sAddWork := mem_NeedWorks.Text;
  sLEN := ne_Len.Text;
  sWID := ne_Wid.Text;
  sDEP := ne_Dep.Text;
  sDTZAV := F_Raskop.ZavDT_IN;
  sDTTM := de_Dt_Act.EditText + ' / ' + te_Dt_Act.Text;
  if sDTTM = '  .  .     /   :  :  ' then sDTTM := '';
  end;
  sNeedWork := frame_WorksInfo.mem_NeedWorks.Text;
  try
      with DM_Reports.ActRaskRep do
      begin
        VarValue['BR_ACT']:=KillSkob( sBRACT);
        VarValue['BRBLAG']:=KillSkob( sBRBLAG);
        VarValue['ADRES']:= sADRES;
        VarValue['NOMER']:= sNOMER;
        VarValue['OGRAGD']:= sOGRAGD;
        VarValue['NeedWork']:= KillSkob(sNeedWork);
        VarValue['AddWork']:= sAddWork;
        VarValue['LEN']:= sLEN;
        VarValue['WID']:= sWID;
        VarValue['DEP']:= sDEP;
        VarValue['DTZAV']:= sDTZAV;
        VarValue['DTTM']:= sDTTM;
        //

        Execute;
      end;
  finally
    DM_Reports.Free;
  end;
end;

end.
