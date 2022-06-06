unit WorkForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WorkDM, DB, ComCtrls, ExtCtrls, Grids, DBGridEh, StdCtrls,
  Buttons, WorkContainerDM, MaterDM, BWorkDM, BaseWorkAndMatDM,frmLANG;

type
  TDsetAction = (daInsert, daEdit);
  TActiveTab = (atWork, atMater);

  Tfrm_Work = class(TFormLang)
    ds_Works: TDataSource;
    pnl_BWork: TPanel;
    pnl_Work: TPanel;
    pnl_Bottom: TPanel;
    pnl_BWorkBtns: TPanel;
    pnl_WorkBtns: TPanel;
    pnl_View: TPanel;
    pc_Details: TPageControl;
    ts_Work: TTabSheet;
    dbg_Works: TDBGridEh;
    btn_AddDetails: TBitBtn;
    btn_EditDetails: TBitBtn;
    btn_DelDetails: TBitBtn;
    BitBtn4: TBitBtn;
    ds_Mater: TDataSource;
    dbg_Mater: TDBGridEh;
    dbg_BWork: TDBGridEh;
    btn_FastAdd: TBitBtn;
    btn_AddBWork: TBitBtn;
    btn_EditBWork: TBitBtn;
    btn_DelBWork: TBitBtn;
    ds_BWork: TDataSource;
    rg_View: TRadioGroup;
    pnl_RecalcTZ: TPanel;
    btn_RecalcTZ: TBitBtn;
    l_ObjOborName: TLabel;
    pnl_materold: TPanel;
    procedure btn_AddDetailsClick(Sender: TObject);
    procedure btn_EditDetailsClick(Sender: TObject);
    procedure btn_DelDetailsClick(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_AddBWorkClick(Sender: TObject);
    procedure btn_EditBWorkClick(Sender: TObject);
    procedure btn_DelBWorkClick(Sender: TObject);
    procedure rg_ViewClick(Sender: TObject);
    procedure pc_DetailsChange(Sender: TObject);
    procedure btn_FastAddClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbg_BWorkDblClick(Sender: TObject);
    procedure dbg_WorksDblClick(Sender: TObject);
    procedure dbg_MaterDblClick(Sender: TObject);
    procedure dbg_WorksKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbg_BWorkKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btn_RecalcTZClick(Sender: TObject);
  private
    procedure BWorkAfterScrollHandler(DataSet: TDataSet);
  private
    F_WorkContainer: Tdm_WorkContainer;
    procedure ChangeWork( _DsetAction: TDsetAction );
    procedure ChangeMater( _DsetAction: TDsetAction );
    procedure EditBWork;
    procedure AddBWork;
    procedure DelBWork;
    procedure AttachToDsets;
    function GetActiveTab: TActiveTab;
    function GetShowMode: TShowMode;
    procedure Refilter;
    procedure BuildCtrlsEneble;
   private
    F_Caption:string;
  public
    constructor Create( AOwner: TComponent; AWorkContainer: Tdm_WorkContainer);
    procedure Translate;override;
    property pCaption:string write F_Caption;
  end;

implementation

{$R *.dfm}

uses EditWorkForm, EditMaterForm, EditBWorkForm, AddBWorkForm, DelBWorkForm,
      FastAddWorkForm, NGRaskopDM, AvrDBConst, cntsLANG;

{ Tfrm_Work }

procedure Tfrm_Work.Translate;
begin
if F_Caption='' then
 self.Caption:=TrLangMSG(msgJobsAndMat)
else
 self.Caption:=F_Caption;
btn_AddBWork.Caption:=TrLangMSG(msgAdd);
btn_EditBWork.Caption:=TrLangMSG(msgEdit);
btn_DelBWork.Caption:=TrLangMSG(msgDelete);
btn_AddDetails.Caption:=TrLangMSG(msgAdd);
btn_EditDetails.Caption:=TrLangMSG(msgEdit);
btn_DelDetails.Caption:=TrLangMSG(msgDelete);
btn_FastAdd.Caption:=TrLangMSG(msgFastAdd);
BitBtn4.Caption:=TrLangMSG(msgExit);
dbg_BWork.Columns[0].Title.Caption:=TrLangMSG(msgComplitWork);
rg_View.Caption:=TrLangMSG(msgShow);
rg_View.Items[0]:=TrLangMSG(msgAllRecords);
rg_View.Items[1]:=TrLangMSG(msgConectCompWork);
rg_View.Items[2]:=TrLangMSG(msgFreeRecords);
ts_work.Caption:=TrLangMSG(msgWorkMany);
btn_RecalcTZ.Caption:=TrLangMSG(msgRecalcTZ);
//ts_mat.Caption:=TrLangMSG(msgMaterMany);

dbg_Works.Columns[0].Title.Caption:=TrLangMSG(msgWorkOne);
dbg_Works.Columns[1].Title.Caption:=TrLangMSG(msgSpotPlace);
dbg_Works.Columns[2].Title.Caption:=TrLangMSG(msgKillClog);
dbg_Works.Columns[3].Title.Caption:=TrLangMSG(msgPump);
dbg_Works.Columns[4].Title.Caption:=TrLangMSG(msgPes);
dbg_Works.Columns[5].Title.Caption:=TrLangMSG(msgDiam);
dbg_Works.Columns[6].Title.Caption:=TrLangMSG(msgCountBig);
dbg_Works.Columns[7].Title.Caption:=TrLangMSG(msgLaborInput)+'||'+TrLangMSG(msgLaborInput)+' '+TrLangMSG(msgOnQuantity);
dbg_Works.Columns[8].Title.Caption:=TrLangMSG(msgLaborInput)+'||'+TrLangMSG(msgQuantityItems);
dbg_Works.Columns[9].Title.Caption:=TrLangMSG(msgLaborInput)+'||'+TrLangMSG(msgCommonTZ);

dbg_Mater.Columns[0].Title.Caption:=TrLangMSG(msgMaterOne);
dbg_Mater.Columns[1].Title.Caption:=TrLangMSG(msgDiam);
dbg_Mater.Columns[2].Title.Caption:=TrLangMSG(msgCountBig);
end;

procedure Tfrm_Work.AttachToDsets;
begin
  ds_Works.DataSet := F_WorkContainer.Work.dset_Works;
  ds_Mater.DataSet := F_WorkContainer.Mater.dset_Mater;
  ds_BWork.DataSet := F_WorkContainer.BWork.dset_BWork;
  //
  F_WorkContainer.BWork.OnBWorkAfterScroll := BWorkAfterScrollHandler;
end;

procedure Tfrm_Work.ChangeWork(_DsetAction: TDsetAction);
var
  _frm: Tfrm_EditWork;
  _work: Tdm_Work;
  _CurWorkTypeID: integer;
begin
  if F_WorkContainer.IsReadOnly then exit;

  _work := F_WorkContainer.Work;

  _frm := Tfrm_EditWork.Create( nil, _work );
  try
    _frm.ds_main.DataSet := _work.dset_Works;
    _frm.ds_place.DataSet := _work.dset_S_Place;

    _frm.ds_work.DataSet := _work.dset_S_WorkDetail;

    _frm.ds_killclog.DataSet := _work.dset_S_KillClog;
    _frm.ds_pump.DataSet := _work.dset_S_Pump;
    _frm.ds_pes.DataSet := _work.dset_S_Pes;
    _frm.ds_diam.DataSet := _work.dset_S_Diam;
    if  _work.Raskop<>nil then
    _frm.ds_Raskop.DataSet := _work.Raskop.dset_Raskop;


    if _DsetAction = daInsert then
      _work.dset_Works.Append
    else
      _work.dset_Works.Edit;
    if _work.Raskop<>nil then begin
    _work.Raskop.ZavID := _work.ZavID;
    _work.Raskop.EditOneRaskopID := _work.GetCurrentRaskopID;
    _work.Raskop.IsReadOnly := not( rsRASK in RightsSet );
    _work.Raskop.RaskopEditMode := remEditOne;
    _work.Raskop.StartTran;
    end;
    try
      if _frm.ShowModal = mrOk then
      begin
        _CurWorkTypeID := _work.GetCurrentWorkTypeID;

        if ( _CurWorkTypeID = Ord( tsc_swt_RASKOPKA ) ) or
          ( _CurWorkTypeID = Ord( tsc_swt_BLAGOUSTR ) )
        then
        begin
          if  _work.Raskop<>nil then
          begin
          if ( _CurWorkTypeID = Ord( tsc_swt_RASKOPKA ) ) then
            _work.SetCurrentRaskopID( _work.Raskop.EditOneRaskopID )
          else
          if ( _CurWorkTypeID = Ord( tsc_swt_BLAGOUSTR ) ) then
            _work.SetCurrentRaskopID( _work.Raskop.GetCurrentRaskopID );

          _work.Raskop.CommitTran;
         end;
        end else
        begin
          _work.SetCurrentRaskopToNULL;
          if  _work.Raskop<>nil then
          _work.Raskop.RollbackTran;
        end;

        _work.dset_Works.Post;
      end else
      begin
        _work.dset_Works.Cancel;
        if  _work.Raskop<>nil then
        _work.Raskop.RollbackTran;
      end;
    except
      on E: Exception do
      begin
       if  _work.Raskop<>nil then
        _work.Raskop.RollbackTran;
        E.Message := E.Message + '(Tfrm_Work.ChangeWork(_DsetAction: TDsetAction))';
        raise;
      end;
    end;
  finally
    _frm.Free;
  end;
end;

procedure Tfrm_Work.btn_AddDetailsClick(Sender: TObject);
begin
  if GetActiveTab = atWork then
    ChangeWork( daInsert )
  else
    ChangeMater( daInsert );
end;

procedure Tfrm_Work.btn_EditDetailsClick(Sender: TObject);
begin
  if GetActiveTab = atWork then
    ChangeWork( daEdit )
  else
    ChangeMater( daEdit );
end;

procedure Tfrm_Work.btn_DelDetailsClick(Sender: TObject);
var
  _RaskopID: integer;
begin
  if F_WorkContainer.IsReadOnly then exit;

  if MessageDlg (TrLangMSG(msgDeleteRecord),mtConfirmation,
    [mbYes, mbNo], 0 ) = mrYes then
  begin
    if GetActiveTab = atWork then
    begin
      if F_WorkContainer.Work.GetCurrentWorkTypeID = Ord( tsc_swt_RASKOPKA ) then
      begin
        if MessageDlg(TrLangMSG(msgConfirmDepWorkExcav), mtConfirmation,
           [mbYes, mbNo], 0) =mrYes
        then
        begin
          _RaskopID := F_WorkContainer.Work.dset_Works.FieldByName( 'ID_RASKOP' ).AsInteger;
          F_WorkContainer.Work.dset_Works.Delete;
          F_WorkContainer.Work.CommitTran;
          F_WorkContainer.Work.Raskop.DeleteRaskop( _RaskopID );
          F_WorkContainer.Work.StartTran;
          F_WorkCOntainer.Work.OpenDset;
        end;
      end else
        F_WorkContainer.Work.dset_Works.Delete;
    end else
      F_WorkContainer.Mater.dset_Mater.Delete;
  end;
end;

procedure Tfrm_Work.BitBtn4Click(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_Work.FormCreate(Sender: TObject);
begin
  AttachToDsets;
end;

constructor Tfrm_Work.Create(AOwner: TComponent;
  AWorkContainer: Tdm_WorkContainer);
begin
  inherited Create( AOwner );
  F_WorkContainer := AWorkContainer;
end;

procedure Tfrm_Work.ChangeMater(_DsetAction: TDsetAction);
var
  _frm: Tfrm_EditMater;
  _mater: Tdm_Mater;
begin
  if F_WorkContainer.IsReadOnly then exit;

  _mater := F_WorkContainer.Mater;

  _frm := Tfrm_EditMater.Create( nil, _mater );
  try
    _frm.ds_Main.DataSet := _mater.dset_Mater;
    _frm.ds_S_Mat.DataSet := _mater.dset_S_Mat;
    _frm.ds_S_Diam.DataSet := _mater.dset_S_Diam;

    if _DsetAction = daInsert then
      _mater.dset_Mater.Append
    else
      _mater.dset_Mater.Edit;

    if _frm.ShowModal = mrOk then
      _mater.dset_Mater.Post
    else
      _mater.dset_Mater.Cancel;

  finally
    _frm.Free;
  end;
end;

function Tfrm_Work.GetActiveTab: TActiveTab;
begin
  case pc_Details.ActivePage.Tag of
    1: Result := atWork;
    2: Result := atMater;
  end;
end;

procedure Tfrm_Work.btn_AddBWorkClick(Sender: TObject);
begin
  AddBWork;
end;

procedure Tfrm_Work.btn_EditBWorkClick(Sender: TObject);
begin
  EditBWork;
end;

procedure Tfrm_Work.btn_DelBWorkClick(Sender: TObject);
begin
  DelBWork;
end;

procedure Tfrm_Work.EditBWork;
var
  _frm: Tfrm_EditBWork;
  _bwork: Tdm_BWork;
  _work: Tdm_Work;
  _mater: Tdm_Mater;
  _ID_IN_BWORKS, _BWorkID: integer;
begin
  if F_WorkContainer.IsReadOnly then exit;

  _bwork := F_WorkContainer.BWork;
  _work := F_WorkContainer.Work;
  _mater := F_WorkContainer.Mater;

  _frm := Tfrm_EditBWork.Create( nil, _bwork );
  try
    _frm.ds_Main.DataSet := _bwork.dset_BWork;
    _frm.ds_S_BWork.DataSet := _bwork.dset_S_BWork;

    _bwork.dset_BWork.Edit;

    if _frm.ShowModal = mrOk then
    begin
      _bwork.dset_BWork.Post;

      _ID_IN_BWORKS := _bwork.GetID_IN_BWORKS;
      _BWorkID := _bwork.GetCurrentBWorkID;

      {Подработы}
      if _frm.DelWorksAssignedWithOldValue then
        _work.DelWorksAssignedWith_ID_IN_BWORKS( _ID_IN_BWORKS )
      else
        _work.ResetWorksAttachAssignedWith_ID_IN_BWORKS( _ID_IN_BWORKS );

      if _frm.AddWorksAssignedWithNewValue then
        _work.AddWorksAssignedWithBWork( _BWorkID, _ID_IN_BWORKS );

      _work.OpenDset;
      {/Подработы}

      {Материалы}
      if _frm.DelMatsAssignedWithOldValue then
        _mater.DelMatsAssignedWith_ID_IN_BWORKS( _ID_IN_BWORKS )
      else
        _mater.ResetMatsAttachAssignedWith_ID_IN_BWORKS( _ID_IN_BWORKS );

      if _frm.AddMatsAssignedWithNewValue then
        _mater.AddMatsAssignedWithBWork( _BWorkID, _ID_IN_BWORKS );

      _mater.OpenDset;
      {/Материалы}
    end else
      _bwork.dset_BWork.Cancel;

  finally
    _frm.Free;
  end;
end;

procedure Tfrm_Work.AddBWork;
var
  _frm: Tfrm_AddBWork;
  _bwork: Tdm_BWork;
  _work: Tdm_Work;
  _mater: Tdm_Mater;
  _BWorkID, _ID_IN_BWORKS: integer;
begin
  if F_WorkContainer.IsReadOnly then exit;

  _bwork := F_WorkContainer.BWork;
  _work := F_WorkContainer.Work;
  _mater := F_WorkContainer.Mater;

  _frm := Tfrm_AddBWork.Create( nil, _bwork );
  try
    _frm.ds_Main.DataSet := _bwork.dset_BWork;
    _frm.ds_S_BWork.DataSet := _bwork.dset_S_BWork;

    _bwork.dset_BWork.Append;

    if _frm.ShowModal = mrOk then
    begin
      _bwork.dset_BWork.Post;

      _BWorkID := _bwork.GetCurrentBWorkID;
      _ID_IN_BWORKS := _bwork.GetID_IN_BWORKS;

      if _frm.IsAddAssignedWorks then
      begin
        _work.AddWorksAssignedWithBWork( _BWorkID, _ID_IN_BWORKS );
        _work.OpenDset;
      end;

      if _frm.IsAddAssignedMats then
      begin
        _mater.AddMatsAssignedWithBWork( _BWorkID, _ID_IN_BWORKS );
        _mater.OpenDset;
      end;

    end else
      _bwork.dset_BWork.Cancel;

  finally
    _frm.Free;
  end;
end;

procedure Tfrm_Work.DelBWork;
var
  _frm: Tfrm_DelBWork;
  _work: Tdm_Work;
  _mater: Tdm_Mater;
  _ID_IN_BWORKS: integer;
begin
  if F_WorkContainer.IsReadOnly then exit;

  _work := F_WorkContainer.Work;
  _mater := F_WorkContainer.Mater;

  _frm := Tfrm_DelBWork.Create( nil );
  try
    if _frm.ShowModal = mrOk then
    begin
      _ID_IN_BWORKS := F_WorkContainer.BWork.GetID_IN_BWORKS;

      F_WorkContainer.BWork.dset_BWork.Delete;

      {Подработы}
      if _frm.IsDelAssignedWorks then
        _work.DelWorksAssignedWith_ID_IN_BWORKS( _ID_IN_BWORKS )
      else
        _work.ResetWorksAttachAssignedWith_ID_IN_BWORKS( _ID_IN_BWORKS );

      _work.OpenDset;
      {/Подработы}

      {Материалы}
      if _frm.IsDelAssignedMats then
        _mater.DelMatsAssignedWith_ID_IN_BWORKS( _ID_IN_BWORKS )
      else
        _mater.ResetMatsAttachAssignedWith_ID_IN_BWORKS( _ID_IN_BWORKS );

      _mater.OpenDset;
      {/Материалы}
    end;
  finally
    _frm.Free;
  end;
end;

procedure Tfrm_Work.rg_ViewClick(Sender: TObject);
begin
  Refilter;
end;

procedure Tfrm_Work.Refilter;
var
  _dm: Tdm_BaseWorkAndMat;
begin
  if GetActiveTab = atWork then _dm := F_WorkContainer.Work
  else _dm := F_WorkContainer.Mater;
  //
  _dm.ShowMode := GetShowMode;
  _dm.Current_ID_IN_BWORKS := F_WorkContainer.BWork.GetID_IN_BWORKS;
  _dm.Refilter;
end;

function Tfrm_Work.GetShowMode: TShowMode;
begin
  case rg_View.ItemIndex of
    0: Result := smAll;
    1: Result := smAttached;
    2: Result := smFree;
  end;
end;

procedure Tfrm_Work.BWorkAfterScrollHandler(DataSet: TDataSet);
begin
  if ( GetShowMode = smAttached ) and (Visible) then
    Refilter;
end;

procedure Tfrm_Work.pc_DetailsChange(Sender: TObject);
begin
  rg_View.ItemIndex := 0;
  Refilter;
end;

procedure Tfrm_Work.btn_FastAddClick(Sender: TObject);
var
  _frm: Tfrm_FastAddWork;
  _bwork: Tdm_BWork;
  _work: Tdm_Work;
  _mater: Tdm_Mater;
  _BWorkID, _ID_IN_BWORKS: integer;
begin
  _frm := Tfrm_FastAddWork.Create( nil );
  try
    _frm.FillFastAddDset;

    if _frm.ShowModal = mrOk then
    begin
      _bwork := F_WorkContainer.BWork;
      _work := F_WorkContainer.Work;
      _mater := F_WorkContainer.Mater;

      with _frm do
      begin
        mt_FastAdd.First;
        while not mt_FastAdd.Eof do
        begin
          if mt_FastAdd.FieldByName( 'is_add_bwork' ).AsBoolean then
          begin
            _BWorkID := mt_FastAdd.FieldByName( 'id_bwork' ).AsInteger;
            _ID_IN_BWORKS := _bwork.AppendBWork( _BWorkID );

            if mt_FastAdd.FieldByName( 'is_add_work' ).AsBoolean then
            begin
              _work.AddWorksAssignedWithBWork( _BWorkID, _ID_IN_BWORKS );
              _work.OpenDset;
            end;

            if mt_FastAdd.FieldByName( 'is_add_mater' ).AsBoolean then
            begin
              _mater.AddMatsAssignedWithBWork( _BWorkID, _ID_IN_BWORKS );
              _mater.OpenDset;
            end;
          end;
          mt_FastAdd.Next;
        end; //end while
      end; //end with
    end; //end _frm.ShowModal
  finally
    _frm.Free;
  end;
end;

procedure Tfrm_Work.BuildCtrlsEneble;
var
  _en: boolean;
begin
  _en := not F_WorkContainer.IsReadOnly;

  btn_AddBWork.Enabled := _en;
  btn_EditBWork.Enabled := _en;
  btn_DelBWork.Enabled := _en;

  btn_AddDetails.Enabled := _en;
  btn_EditDetails.Enabled := _en;
  btn_DelDetails.Enabled := _en;

  btn_RecalcTZ.Enabled := _en;

  btn_FastAdd.Enabled := _en;
end;

procedure Tfrm_Work.FormShow(Sender: TObject);
begin
//  l_ObjOborName.Caption :=
  BuildCtrlsEneble;
end;

procedure Tfrm_Work.dbg_BWorkDblClick(Sender: TObject);
begin
  EditBWork;
end;

procedure Tfrm_Work.dbg_WorksDblClick(Sender: TObject);
begin
  ChangeWork( daEdit );
end;

procedure Tfrm_Work.dbg_MaterDblClick(Sender: TObject);
begin
  ChangeMater( daEdit );
end;

procedure Tfrm_Work.dbg_WorksKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN: btn_EditDetailsClick( nil );
    VK_DELETE: btn_DelDetailsClick( nil );
  end;
end;

procedure Tfrm_Work.dbg_BWorkKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN: EditBWork;
    VK_DELETE: DelBWork;
  end;
end;

procedure Tfrm_Work.btn_RecalcTZClick(Sender: TObject);
var
  _ErrMsg: string;
begin
  if not F_WorkContainer.IsReadOnly then
    if not F_WorkContainer.Work.RecalcAll_TZ( _ErrMsg ) then
      MessageDlg(_ErrMsg, mtError, [mbOk], 0);

end;

end.
