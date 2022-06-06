unit SvodkaSESOptForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionItemSelWithSaveForm, StdCtrls, Buttons, ComCtrls,
  SelDatePeriodFrame, BaseItemSelecterFrame, SelTZavFrame, SelPlaceFrame,
  SelSodFrame, BaseSingleItemSelectFrame, SelSingleBrigFrame, ExtCtrls,
  SelOwnerFrame, Mask, DB, DBCtrls, kbmMemTable, RxLookup, Grids, DBGrids;

type
  TMyGetSavesListEvent=procedure of object;

  Tfrm_SvodkaSESOpt = class(Tfrm_BaseOptionItemSelWithSave)
    frame_SelDates: Tframe_SelDatePeriod;
    gb_Opt: TGroupBox;
    pg_Option: TPageControl;
    ts_Voda: TTabSheet;
    frame_SelTZav_voda: Tframe_SelTZav;
    frame_SelPlace_voda: Tframe_SelPlace;
    frame_SelSod_voda: Tframe_SelSod;
    ts_Kanal: TTabSheet;
    frame_SelTZav_kanal: Tframe_SelTZav;
    frame_SelPlace_kanal: Tframe_SelPlace;
    frame_SelSod_kanal: Tframe_SelSod;
    gb_DispInfo: TGroupBox;
    frame_SelSdalBrig: Tframe_SelSingleBrig;
    ed_Prinyal: TEdit;
    Label2: TLabel;
    frame_SelSvodkaDate: Tframe_SelDatePeriod;
    chb_IsReCreate: TCheckBox;
    Bevel1: TBevel;
    Bevel2: TBevel;
    frame_SelOwner_voda: Tframe_SelOwner;
    frame_SelOwner_kanal: Tframe_SelOwner;
    pnl_Attach: TPanel;
    chb_Voda: TCheckBox;
    chb_Kanal: TCheckBox;
    me_Time: TMaskEdit;
    Label1: TLabel;
    ds_Saves: TDataSource;
    dset_MTSaves: TkbmMemTable;
    dset_MTSavesID: TIntegerField;
    dset_MTSavesDT: TDateTimeField;
    dblb_Saves: TDBGrid;
    dset_MTSavesAtt: TStringField;
    dset_MTSavesAttID: TIntegerField;
    cbh_VRK: TCheckBox;
    procedure btn_okClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chb_IsReCreateClick(Sender: TObject);
    procedure chb_VodaClick(Sender: TObject);
    procedure chb_KanalClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbh_VRKClick(Sender: TObject);
    procedure frame_SelOwner_kanalbtn_SelItemClick(Sender: TObject);
  private
    F_SvodDateTime: TDateTime;
    F_SvodAttID : integer;
    SetNEGetSavesList : TMyGetSavesListEvent;
    procedure FillSaveFrameList; override;
    procedure ShowSelInfo; override;
    procedure SetIsShowAddOpt(const Value: boolean);
  public
    function GetSdal: string;
    function GetPrinyal: string;
    function IsReCreate: boolean;
    function IsVodaConsid: boolean;
    function IsKanalConsid: boolean;
    function IsVRKConsid: boolean;

    property IsShowAddOpt: boolean write SetIsShowAddOpt;
    property SvodDateTime: TDateTime read F_SvodDateTime;
    property SvodAttID: integer read F_SvodAttID;
    property NEGetSavesList: TMyGetSavesListEvent read SetNEGetSavesList write SetNEGetSavesList;
  end;


implementation

{$R *.dfm}

uses ServiceFuncUnit;

{ Tfrm_SvodkaSESOpt }

procedure Tfrm_SvodkaSESOpt.FillSaveFrameList;
begin
  F_SaveFrameList.Add( frame_SelOwner_voda );
  F_SaveFrameList.Add( frame_SelTZav_voda );
  F_SaveFrameList.Add( frame_SelPlace_voda );
  F_SaveFrameList.Add( frame_SelSod_voda );
  //
  F_SaveFrameList.Add( frame_SelOwner_kanal );
  F_SaveFrameList.Add( frame_SelTZav_kanal );
  F_SaveFrameList.Add( frame_SelPlace_kanal );
  F_SaveFrameList.Add( frame_SelSod_kanal );
  //
///  F_SaveFrameList.Add( frame_SelOwner_VRK );
//  F_SaveFrameList.Add( frame_SelTZav_VRK );
 // F_SaveFrameList.Add( frame_SelPlace_VRK );
 // F_SaveFrameList.Add( frame_SelSod_VRK );
end;

procedure Tfrm_SvodkaSESOpt.ShowSelInfo;
  procedure _ShowInfo( _frame: Tframe_BaseItemSelecter; _AddName: string );
  begin
    mem_Info.Lines.Add( Format( '%s (%s):',
      [ AnsiUpperCase( _frame.FieldName ), _AddName ] ) );
    mem_Info.Lines.Add( _frame.ItemSelecter.SelItemList.ItemsName + ';' );

    mem_Info.Lines.Add( ' ' );
  end;
const
  VODA = 'ВОДОПРОВОД';
  KANAL = 'КАНАЛИЗАЦИЯ';
  VRK = 'ВРК';
begin
  mem_Info.Clear;

  if chb_IsReCreate.Checked then
  begin
    if chb_Voda.Checked then
    begin
      _ShowInfo( frame_SelOwner_voda, VODA );
      _ShowInfo( frame_SelTZav_voda, VODA );
      _ShowInfo( frame_SelPlace_voda, VODA );
      _ShowInfo( frame_SelSod_voda, VODA );
    end;
    //
    if chb_Kanal.Checked then
    begin
      _ShowInfo( frame_SelOwner_kanal, KANAL );
      _ShowInfo( frame_SelTZav_kanal, KANAL );
      _ShowInfo( frame_SelPlace_kanal, KANAL );
      _ShowInfo( frame_SelSod_kanal, KANAL );
    end;
    //
   { if cbh_VRK.Checked then
    begin
     // _ShowInfo( frame_SelOwner_VRK, VRK );
      _ShowInfo( frame_SelTZav_VRK, VRK );
      _ShowInfo( frame_SelPlace_VRK, VRK );
      _ShowInfo( frame_SelSod_VRK, VRK );
    end;
    }
  end;
end;

procedure Tfrm_SvodkaSESOpt.btn_okClick(Sender: TObject);
begin
  if IsReCreate then
   begin
     try
      F_SvodDateTime := frame_SelSvodkaDate.de_Begin.Date + strtotime(me_Time.Text);
     except
      on E:Exception do
        begin
         ShowErr(handle,'Неправильно введено время, нажмите Esc для отмены изменений',E);
         exit;
        end; 
     end;
    if frame_SelDates.IsDatesCorrect then
      ModalResult := mrOk;
   end
  else
   begin
      ModalResult := mrOk;
      F_SvodDateTime := dset_MTSaves.FieldByName('DT').AsDateTime;
      F_SvodAttID := dset_MTSaves.FieldByName('AttID').AsInteger;
      dset_MTSaves.Close;
   end;
end;

function Tfrm_SvodkaSESOpt.GetPrinyal: string;
begin
  Result := ed_Prinyal.Text; 
end;

function Tfrm_SvodkaSESOpt.GetSdal: string;
begin
  Result := frame_SelSdalBrig.dbl_Item.Text;
end;

function Tfrm_SvodkaSESOpt.IsReCreate: boolean;
begin
  Result := chb_IsReCreate.Checked;
end;

procedure Tfrm_SvodkaSESOpt.FormCreate(Sender: TObject);
begin
  inherited;
  self.Width := 300;
  frame_SelSvodkaDate.BeginDate := Date;
end;

procedure Tfrm_SvodkaSESOpt.chb_IsReCreateClick(Sender: TObject);
var
  _vis: boolean;
begin
  _vis := chb_IsReCreate.Checked;

  frame_SelDates.Visible := _vis;
  gb_DispInfo.Visible := _vis;
  gb_Opt.Visible := _vis;
  btn_Save.Visible := _vis;
  Label1.Visible := _vis;
  me_Time.Visible := _vis;
  pnl_Attach.Visible := _vis;
  if _vis then
    begin
      pnl_Attach.Top := 153;
      dblb_Saves.Visible := false;
      if dset_MTSaves.Active then dset_MTSaves.Close;
    end
  else
    begin
      pnl_Attach.Top := 56;
      dblb_Saves.Left := 3;
      dblb_Saves.Visible := true;
  if Assigned(SetNEGetSavesList) then
    SetNEGetSavesList;
    end;
  ShowSelInfo;
end;

procedure Tfrm_SvodkaSESOpt.SetIsShowAddOpt(const Value: boolean);
begin
  chb_IsReCreate.Checked := Value;
  chb_IsReCreate.Visible := Value;
end;

procedure Tfrm_SvodkaSESOpt.chb_VodaClick(Sender: TObject);
begin
  inherited;
  ts_Voda.TabVisible := chb_Voda.Checked;
  ShowSelInfo;
  chb_IsReCreateClick(nil);
end;

procedure Tfrm_SvodkaSESOpt.chb_KanalClick(Sender: TObject);
begin
  inherited;
  ts_Kanal.TabVisible := chb_Kanal.Checked;
  ShowSelInfo;
  chb_IsReCreateClick(nil);
end;

function Tfrm_SvodkaSESOpt.IsKanalConsid: boolean;
begin
  Result := chb_Kanal.Checked;
end;

function Tfrm_SvodkaSESOpt.IsVodaConsid: boolean;
begin
  Result := chb_Voda.Checked;
end;

procedure Tfrm_SvodkaSESOpt.FormShow(Sender: TObject);
begin
  inherited;
  chb_IsReCreate.OnClick(nil);
end;

function Tfrm_SvodkaSESOpt.IsVRKConsid: boolean;
begin
 Result:=cbh_VRK.Checked;
end;

procedure Tfrm_SvodkaSESOpt.cbh_VRKClick(Sender: TObject);
begin
  inherited;
 // ts_VRK.TabVisible := chb_Kanal.Checked;
  ShowSelInfo;
  chb_IsReCreateClick(nil);
end;

procedure Tfrm_SvodkaSESOpt.frame_SelOwner_kanalbtn_SelItemClick(
  Sender: TObject);
begin
  inherited;
  frame_SelOwner_kanal.btn_SelItemClick(Sender);

end;

end.
