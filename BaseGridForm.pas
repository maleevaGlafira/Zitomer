unit BaseGridForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  IBDatabase, StdCtrls, Buttons, ExtCtrls, Grids,
  DBGrids, DB, IBCustomDataSet, Mask, DBCtrls, RxLookup, ToolEdit,
  RXDBCtrl, DBCtrlsEh, ComCtrls, SecurityBaseForm,DMmain,frmLANG, cntsLANG;


type
  Tfrm_BaseGrid = class(Tfrm_SecurityBase)
    Tr_main: TIBTransaction;
    Tr_Voc: TIBTransaction;
    dset_HouseType: TIBDataSet;
    dset_Street: TIBDataSet;
    dset_Street2: TIBDataSet;
    dset_main: TIBDataSet;
    ds_HouseType: TDataSource;
    ds_Street: TDataSource;
    ds_Street2: TDataSource;
    pnl_Top: TPanel;
    pnl_Adres: TGroupBox;
    pnl_Bottom: TPanel;
    btn_Insert: TBitBtn;
    btn_Delete: TBitBtn;
    btn_Edit: TBitBtn;
    btn_Post: TBitBtn;
    btn_Cancel: TBitBtn;
    btn_Exit: TBitBtn;
    ds_Main: TDataSource;
    dbl_HouseType: TRxDBLookupCombo;
    dbl_Street: TRxDBLookupCombo;
    dbl_Street2: TRxDBLookupCombo;
    ed_AddAdres: TDBEdit;
    ed_HouseNum: TDBEdit;
    lbl_HouseType: TLabel;
    lbl_Street: TLabel;
    lbl_AddAdres: TLabel;
    lbl_HouseNum: TLabel;
    lbl_Street2: TLabel;
    dbg_Main: TDBGrid;
    sb_ProcessStatus: TStatusBar;
    dset_StreetID: TIntegerField;
    dset_StreetNAME_R: TIBStringField;
    dset_StreetORINT: TIBStringField;
    dset_Street2ID: TIntegerField;
    dset_Street2NAME_R: TIBStringField;
    dset_Street2ORINT: TIBStringField;
    dset_StreetDEL: TIBStringField;
    dset_Street2DEL: TIBStringField;
    procedure CtrlsChange(Sender: TObject);
    procedure dset_mainAfterScroll(DataSet: TDataSet);
    procedure EntryEnter(Sender: TObject);
    procedure TextFieldEnter(Sender: TObject);
    procedure EntryExit(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_DeleteClick(Sender: TObject);
    procedure btn_EditClick(Sender: TObject);
    procedure btn_PostClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure btn_InsertClick(Sender: TObject);virtual;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure VocFilterRecord(DataSet: TDataSet; var Accept: Boolean);
  protected

    F_OrderID: integer;
    F_ReadOnly: boolean;
    F_CtrlsChange: boolean;
    F_IsLockProcessStatus: boolean;
    F_VocDsetList: TList;
    F_RegionID: integer;

    F_IsDeleted:boolean;
    F_Saved:boolean;

    procedure HouseTypeChange;
    procedure EnableChngBtns;
    function SaveData: boolean;
    procedure OpenVocDataset;
    procedure ShowDeletedRowInVoc(value: boolean);

    function IsCanEditCurrentRec: boolean; virtual;
    procedure InitVocDsetList; virtual;
    procedure OpenMainDataset;virtual;
    procedure EnableCtrls(value: boolean); virtual;
    function IsDateCorrect: boolean; virtual;
    function IsDataFieldsCorrect: boolean; virtual;
  protected
    procedure SetProcessStatus(const value: string);
    property ProcessStatus: string write SetProcessStatus;
  public
    constructor Create(AOwner: TComponent; A_OrderID: integer; A_ReadOnly: boolean=false); overload;
    constructor Create(AOWner: TComponent; A_ReadOnly: boolean=false); overload;
    property region: integer write F_RegionID;
  end;


implementation

{$R *.dfm}

uses HelpFunctions;

{ Tfrm_BaseGrid }
const sel_streetSQL='select u.id id, rtrim(u.name_r)||" "||rtrim(v.name_r) as name_r,u.orint,del  , id_rayon '+
                 'from s_ulic u,s_vidul v'+
' where %s u.del in (''-'',''d'') and (u.id_vidul=v.id) '+
'  or ((u.id_vidul=-1) and (u.id_vidul=v.id))  '+
' order by u.name_r';
const reg_cond= '  (id_Rayon=%d or id=-1) and';


constructor Tfrm_BaseGrid.Create(AOwner: TComponent; A_OrderID: integer;   A_ReadOnly: boolean=false);
begin
  inherited Create(AOwner);
  F_OrderID:=A_OrderID;
  F_CtrlsChange:=false;

      F_ReadOnly:=A_ReadOnly;
      F_IsLockProcessStatus:=false;


end;

procedure Tfrm_BaseGrid.CtrlsChange(Sender: TObject);
begin
  if (Sender is TRxDBLookupcombo) then
  begin
    if (Sender as TRxDBLookupcombo).Tag=111 then //dbl_HouseType
    begin
      case dset_HouseType.FieldByName('ID').AsInteger of
        0: dset_Main.FieldByName('HouseNum').AsString:='';
        1: dset_Main.FieldByName('HouseNum').AsString:='-1';
      end;
      HouseTypeChange;
    end;

    if (Sender as TRxDBLookupcombo).Tag=222 then //dbl_Street2
    begin
      if (dset_HouseType.FieldByName('ID').AsInteger=1) and
          ((dset_Main.State=dsEdit) or (dset_Main.State=dsInsert)) then
        dset_Main.FieldByName('HouseNum').AsString:=dset_Street2.FieldByName('ID').AsString;
    end;
  end;

  F_CtrlsChange:=true;
end;

procedure Tfrm_BaseGrid.HouseTypeChange;
begin
  case dset_HouseType.FieldByName('ID').AsInteger of
    0: //Улица, № дома
      begin
        lbl_HouseNum.Visible:=true;
        lbl_Street2.Visible:=false;
        ed_HouseNum.Visible:=true;
        dbl_Street2.Visible:=false;

        ed_HouseNum.DataSource:=ds_Main;
      end;
    1: //Пересечение улиц
      begin
        lbl_HouseNum.Visible:=false;
        lbl_Street2.Visible:=true;
        ed_HouseNum.Visible:=false;
        dbl_Street2.Visible:=true;

        ed_HouseNum.DataSource:=nil;
        if trim(dset_Main.FieldByName('HouseNum').AsString) <> '' then
        FixDBLValue(StrToInt(trim(dset_Main.FieldByName('HouseNum').AsString)), dbl_Street2);
      end;
    2: //Местность
      begin
        lbl_HouseNum.Visible:=false;
        lbl_Street2.Visible:=false;
        ed_HouseNum.Visible:=false;
        dbl_Street2.Visible:=false;

        ed_HouseNum.DataSource:=nil;
      end;
    end; //end case
end;

procedure Tfrm_BaseGrid.dset_mainAfterScroll(DataSet: TDataSet);
begin
  HouseTypeChange;
  F_CtrlsChange:=false;
  EnableChngBtns;
end;

procedure Tfrm_BaseGrid.EntryEnter(Sender: TObject);
begin
  if Sender is TRXDBLookupCombo then
    (Sender as TRXDBLookupCombo).color := clLime else
  if Sender is TDBEdit then
    (Sender as TDBEdit).Color :=  clLime else
  if Sender is TDBDateEdit then
    (Sender as TDBDateEdit).Color := clLime else
  if Sender is TDBDateTimeEditEh then
    (Sender as TDBDateTimeEditEh).Color := clLime else
  if (Sender is TDBNumberEditEh) then
    (Sender as TDBNumberEditEh).Color := clLime;
 if (Sender is TDateEdit) then
  (Sender as TDateEdit).Color := clLime;
 if (Sender is TEdit) then
  (Sender as TEdit).Color := clLime;

end;

procedure Tfrm_BaseGrid.EntryExit(Sender: TObject);
begin
  if Sender is TRXDBLookupCombo then
    (Sender as TRXDBLookupCombo).color := clWindow else
  if Sender is TDBEdit then
    (Sender as TDBEdit).Color :=  clWindow else
  if Sender is TDBDateEdit then
    (Sender as TDBDateEdit).Color := clWindow else
  if Sender is TDBDateTimeEditEh then
    (Sender as TDBDateTimeEditEh).Color := clWindow else
  if (Sender is TDBNumberEditEh) then
    (Sender as TDBNumberEditEh).Color := clWindow;
  if (Sender is TDateEdit) then
  (Sender as TDateEdit).Color := clWindow;
 if (Sender is TEdit) then
  (Sender as TEdit).Color := clWindow;
end;

procedure Tfrm_BaseGrid.btn_ExitClick(Sender: TObject);
begin
  Close;
end;



procedure Tfrm_BaseGrid.EnableCtrls(value: boolean);
begin
  dbl_HouseType.Enabled:=value;
  ed_AddAdres.Enabled:=value;
  dbl_Street.Enabled:=value;
  dbl_Street2.Enabled:=value;
  ed_houseNum.Enabled:=value;
  btn_Post.Enabled:=value;
  btn_Cancel.Enabled:=value;
end;

procedure Tfrm_BaseGrid.EnableChngBtns;
  procedure EnableBtns(Ins, Ed, Del: boolean);
  begin
    btn_Insert.Enabled:=Ins;
    btn_Edit.Enabled:=Ed;
    btn_Delete.Enabled:=Del;
  end;
begin
  if F_ReadOnly then
  begin
    EnableBtns(false, false, false);
  end else
  begin
    if (dset_Main.State in [dsEdit, dsInsert]) then
    begin
      EnableBtns(false, false, false);
    end else
    begin
      if IsCanEditCurrentRec then
        EnableBtns(true, true, true)
      else
        EnableBtns(true, false, false);
    end;
  end;
end;

procedure Tfrm_BaseGrid.FormShow(Sender: TObject);
begin
  if Tr_Voc.InTransaction then
    Tr_Voc.Rollback;
  Tr_Voc.StartTransaction;

  if Tr_Main.InTransaction then
    Tr_Main.Rollback;
  Tr_Main.StartTransaction;

  InitVocDsetList;
  OpenVocDataset;
  OpenMainDataset;

  EnableCtrls(false);
  EnableChngBtns;
end;

procedure Tfrm_BaseGrid.btn_InsertClick(Sender: TObject);
begin
  dset_HouseType.First;
  dset_Main.Insert;
  HouseTypeChange;
  EnableCtrls(true);
  EnableChngBtns;
  dbg_Main.Enabled:=false;
  ShowDeletedRowInVoc(false);
end;

procedure Tfrm_BaseGrid.OpenVocDataset;
var
  i: integer;
begin
  for i:=0 to F_VocDsetList.Count-1 do
    TIBDataSet(F_VocDsetList.Items[i]).Open;
end;

procedure Tfrm_BaseGrid.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if not(dset_Main.Eof and dset_Main.Bof) and not F_ReadOnly then
  begin
    if F_CtrlsChange and ( dset_main.State in ([dsEdit, dsInsert]) ) then
    begin
      case MessageDlg(AnsiUpperCase(TrLangMSG(msgChangeNoSave))+' '+TrLangMSG(msgSaveChanges),
                  mtConfirmation, [mbYes, mbNo], 0)  of
        mrYes:
          if not SaveData then
          begin
            Action:=caNone;
            exit;
          end;
          
       mrNo:;
      else
        begin
          Action:=caNone;
          exit;
        end;
      end; //end case
    end;
  end;

  Action:=caFree;

  dset_Main.Close;

  if Tr_Main.InTransaction then
    Tr_Main.Rollback;

  if tr_Voc.InTransaction then
    Tr_Voc.Commit;
end;

function Tfrm_BaseGrid.SaveData: boolean;
var
  BMark: string;
begin
  Result:=false;

  if (not IsDateCorrect) or (not IsDataFieldsCorrect) or (not F_CtrlsChange) then exit;

  try
   if (dset_Main.State <> dsBrowse) then
    dset_Main.Post;
  except
    on E:Exception do
    begin
     // Application.MessageBox(PChar(E.Message), PChar(TrLangMSG(msgKiev)), MB_OK+MB_ICONERROR);
       MessageDlg(E.Message,mtError, [mbOk], 1);
      Tr_Main.RollbackRetaining;
      dset_Main.Close;
      dset_Main.Open;
      //Raise;
      exit;
    end;
  end;

  Tr_Main.CommitRetaining;

  BMark:=dset_Main.Bookmark;
  dset_Main.Close;
  dset_Main.Open;
  dset_Main.Bookmark:=BMark;

  F_CtrlsChange:=false;

  Result:=true;
end;

procedure Tfrm_BaseGrid.btn_DeleteClick(Sender: TObject);
begin
  if dset_Main.Bof and dset_Main.Eof then exit;
  {
  if MessageDlg('Удалить запись?',
                mtConfirmation, [mbYes, mbNo], 0)=mrYes then
  }
  F_IsDeleted:=false;

  if MessageDlg(TrLangMSG(msgDeleteRecord), mtConfirmation, [mbYes, mbNo], 0)
{  Application.MessageBox('Удалить запись?', PChar(TrLangMSG(msgKiev)), MB_YESNO+MB_ICONQUESTION)}=IDYES then
    begin
      
    dset_Main.Delete;
    EnableCtrls(false);
    Tr_Main.CommitRetaining;
    F_IsDeleted:=true;
  end;
end;

procedure Tfrm_BaseGrid.btn_EditClick(Sender: TObject);
begin
  if dset_Main.Eof and dset_Main.Bof then exit;

  dset_Main.Edit;
  EnableCtrls(true);
  EnableChngBtns;
  dbg_Main.Enabled:=false;
  ShowDeletedRowInVoc(false);
end;

procedure Tfrm_BaseGrid.btn_PostClick(Sender: TObject);
begin
  F_Saved:= SaveData;
  if F_Saved then
  begin
    EnableCtrls(false);
    EnableChngBtns;
    ShowDeletedRowInVoc(true);
    SetProcessStatus('');
  end;
  dbg_Main.Enabled:=true;
end;

procedure Tfrm_BaseGrid.btn_CancelClick(Sender: TObject);
begin
  dset_Main.Cancel;
  EnableCtrls(false);
  EnableChngBtns;
  dbg_Main.Enabled:=true;
  ShowDeletedRowInVoc(true);
  SetProcessStatus('');
end;

function Tfrm_BaseGrid.IsDataFieldsCorrect: boolean;
begin
  Result:=true;
end;

function Tfrm_BaseGrid.IsDateCorrect: boolean;
begin
  Result:=true;
end;

procedure Tfrm_BaseGrid.OpenMainDataset;
begin
  dset_Main.ParamByName('pOrderID').AsInteger:=F_OrderID;
  dset_Main.Open;
end;

constructor Tfrm_BaseGrid.Create(AOWner: TComponent; A_ReadOnly: boolean);
begin
  Create(AOwner, -1,  A_ReadOnly);
end;

procedure Tfrm_BaseGrid.SetProcessStatus(const value: string);
begin
  if not F_IsLockProcessStatus then
    sb_ProcessStatus.SimpleText:=value;
end;

procedure Tfrm_BaseGrid.TextFieldEnter(Sender: TObject);
begin
  EntryEnter(Sender);
  if Sender is TDBEdit then
    (Sender as TDBEdit).Text:=trim((Sender as TDBEdit).Text);
end;

procedure Tfrm_BaseGrid.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_RETURN then
  begin
    if (Sender is TRxDBLookupCombo) then
    begin
      if not (Sender as TRxDBLookupCombo).IsDropDown then
        SelectNext(ActiveControl, true, true);
    end else SelectNext(ActiveControl, true, true);
  end;
end;

procedure Tfrm_BaseGrid.FormCreate(Sender: TObject);
begin
  inherited;
  F_VocDsetList:=TList.Create;
end;

procedure Tfrm_BaseGrid.FormDestroy(Sender: TObject);
begin
  inherited;
  F_VocDsetList.Free;
end;

procedure Tfrm_BaseGrid.InitVocDsetList;
var str:string;
begin
  if F_RegionID>0 then
  begin
   str:=Format(reg_cond,[F_RegionID]);
    dset_street.SelectSQL.Text:=format(sel_streetSQL,[str]);
    dset_street2.SelectSQL.Text:=format(sel_streetSQL,[str]);
  // dset_street.SelectSQL.Text:= dset_street.SelectSQL.Text+' and ID_RAYON='+intToStr(F_RegionID)+' or id=-1';
    dset_street.Filter:='ID_RAYON='+intToStr(F_RegionID)+' or id=-1';
   dset_street.Filtered:=true;
 //dset_street2.SelectSQL.Text:= dset_street2.SelectSQL.Text+' and ID_RAYON='+intToStr(F_RegionID)+' or id=-1';
   dset_street2.Filter:='ID_RAYON='+intToStr(F_RegionID)+' or id=-1';
   dset_street2.Filtered:=true;
  end;
  F_VocDsetList.Add(dset_HouseType);
  F_VocDsetList.Add(dset_Street);
  F_VocDsetList.Add(dset_Street2);

end;

procedure Tfrm_BaseGrid.ShowDeletedRowInVoc(value: boolean);
var
  i: integer;
begin
  for i:=0 to F_VocDsetList.Count-1 do
  begin
    TIBDataSet(F_VocDsetList.Items[i]).Close;
    TIBDataSet(F_VocDsetList.Items[i]).Filtered:=not value;
    TIBDataSet(F_VocDsetList.Items[i]).Open;
   end
end;

procedure Tfrm_BaseGrid.VocFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  if DataSet.FieldByName('del').IsNull then
    Accept:=true
  else
    Accept:=true;
end;

function Tfrm_BaseGrid.IsCanEditCurrentRec: boolean;
begin
  Result:=true;
end;

end.
