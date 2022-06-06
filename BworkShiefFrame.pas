unit BworkShiefFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ComCtrls, Grids, DBGridEh, BworkShiefDM, DB, Buttons,
  frmLANG, cntsLANG;

type
  TGetIntValueProc = procedure ( var Value: integer ) of object;

  Tframe_BworkShief = class(TFrame)
    gb_Detail: TGroupBox;
    pc_Detail: TPageControl;
    ts_Works: TTabSheet;
    ts_Maters: TTabSheet;
    dbg_Works: TDBGridEh;
    ds_Works: TDataSource;
    sb_Add: TSpeedButton;
    sb_Del: TSpeedButton;
    ds_Maters: TDataSource;
    dbg_Maters: TDBGridEh;
    procedure pc_DetailChange(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure sb_AddClick(Sender: TObject);
    procedure sb_DelClick(Sender: TObject);
  private
    F_DM: Tdm_BworkShief;
    F_GetCurrentBworkID: TGetIntValueProc;
    F_IsReadOnly: boolean;
    procedure SetIsReadOnly(const Value: boolean);
    procedure AttachDsets;
    function GetActiveTab: TDetailTab;
    function GetCurBW_ID: integer;
    procedure SetCurrentBworkID( const Value: integer );
    procedure AddWork;
    procedure AddMater;
  public
    constructor Create( AOwner: TComponent); override;
    property GetCurrentBworkID: TGetIntValueProc read F_GetCurrentBworkID
      write F_GetCurrentBworkID;
    property CurrentBworkID: integer write SetCurrentBworkID;
    property IsReadOnly: boolean read F_IsReadOnly write SetIsReadOnly;
    procedure EnableBtns( _val: boolean );
    procedure Translate();
  end;

implementation

{$R *.dfm}

uses AddWorkToBworkForm, AddMaterToBworkForm;

{ Tframe_BworkShief }

procedure Tframe_BworkShief.Translate();
begin
 gb_Detail.Caption:=TrLangMSG(msgConnectBWork);//Привязка
  pc_Detail.Pages[0].Caption:=TrLangMSG(msgWorkMany);
  pc_Detail.Pages[1].Caption:=TrLangMSG(msgMaterMany);
  dbg_Works.Columns[0].Title.Caption:=TrLangMSG(msgWorkOne);
  dbg_Works.Columns[1].Title.Caption:=TrLangMSG(msgODDSIZE);
  dbg_Works.Columns[2].Title.Caption:=TrLangMSG(msgSpotPlace);
  dbg_Works.Columns[3].Title.Caption:=TrLangMSG(msgDiam);
  dbg_Maters.Columns[0].Title.Caption:=TrLangMSG(msgMaterOne);
  dbg_Maters.Columns[1].Title.Caption:=TrLangMSG(msgDiam);
end;

procedure Tframe_BworkShief.AttachDsets;
begin
  ds_Works.DataSet := F_DM.mt_BworkWorks;
  ds_Maters.DataSet := F_DM.mt_BworkMaters;
end;

constructor Tframe_BworkShief.Create(AOwner: TComponent);
begin
  inherited Create( AOwner );
  F_DM := Tdm_BworkShief.Create( self );

  AttachDsets;
end;

function Tframe_BworkShief.GetActiveTab: TDetailTab;
begin
  case pc_Detail.ActivePage.Tag of
    1: Result := dtWork;
    2: Result := dtMater;
  end;
end;

function Tframe_BworkShief.GetCurBW_ID: integer;
begin
  if Assigned( F_GetCurrentBworkID ) then
    F_GetCurrentBworkID( Result );
end;

procedure Tframe_BworkShief.pc_DetailChange(Sender: TObject);
begin
  SetCurrentBworkID( GetCurBW_ID );
end;

procedure Tframe_BworkShief.SetCurrentBworkID(const Value: integer);
begin
  F_DM.BworkID := Value;
  F_DM.FillDetailTab( GetActiveTab );
end;

procedure Tframe_BworkShief.btn_AddClick(Sender: TObject);
begin
  if GetActiveTab = dtWork then
    AddWork
  else
    AddMater;
end;

procedure Tframe_BworkShief.AddWork;
var
  _frm: Tfrm_AddWorkToBwork;
begin
  if F_IsReadOnly then exit;
  //
  _frm := Tfrm_AddWorkToBwork.Create( nil );
  try
    if _frm.ShowModal = mrOk then
      F_DM.AddWorkToBwork( _frm.WorkID, _frm.DiamID );
  finally
    _frm.Free;
  end;
end;

procedure Tframe_BworkShief.AddMater;
var
  _frm: Tfrm_AddMaterToBwork;
begin
  if F_IsReadOnly then exit;
  //
  _frm := Tfrm_AddMaterToBwork.Create( nil );
  try
    if _frm.ShowModal = mrOk then
      F_DM.AddMaterToBwork( _frm.MaterID, _frm.DiamID );
  finally
    _frm.Free;
  end;
end;

procedure Tframe_BworkShief.sb_AddClick(Sender: TObject);
begin
  if GetActiveTab = dtWork then
    AddWork
  else
    AddMater;
end;

procedure Tframe_BworkShief.sb_DelClick(Sender: TObject);
begin
  if Application.MessageBox( 'Вы уверены, что хотите удалить привязку?',
    'Внимание', MB_YESNO + MB_ICONQUESTION ) = ID_YES then
  begin
    F_DM.DelCurRec( GetActiveTab );
  end;
end;

procedure Tframe_BworkShief.SetIsReadOnly(const Value: boolean);
begin
  F_IsReadOnly := Value;
  EnableBtns( not F_IsReadOnly );
end;

procedure Tframe_BworkShief.EnableBtns(_val: boolean);
begin
  if F_IsReadOnly then _val := false;

  sb_Add.Enabled := _val;
  sb_Del.Enabled := _val;
end;

end.
