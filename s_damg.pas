unit s_damg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  baze_dic, DBTables, Menus, Placemnt, Grids, DBGrids, RXDBCtrl, DBCtrls,
  StdCtrls, Buttons, ExtCtrls, db, frmLANG, cntsLANG, RxLookup;

type
  TS_DamgF = class(TBazeDicF)
    S_Place_lcb: TRxDBLookupCombo;
    procedure S_Place_lcbClick(Sender: TObject);
    procedure S_Place_lcbCloseUp(Sender: TObject);
    procedure S_Place_lcbKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  public
    function TestInpData :boolean;override;
    function onBeforeDel(var CanConfirm :boolean; var WarnDelStr :string) :boolean;override;
    constructor CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);override;
    destructor Destroy;override;
    procedure Translate;override;
  end;

var
  S_DamgF: TS_DamgF;

implementation

uses datam;

{$R *.DFM}
//*******************************************************************
constructor TS_DamgF.CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);
var
 fdl :TStringList;
begin
 inherited CreateDic(AOwner, TbName,KeyFd, DSur);
 Self.Constraints.MinWidth:=Self.Constraints.MinWidth + S_Place_lcb.Width+
  BExit.Width;
 if not DM1.S_Place_q.Active then DM1.S_Place_q.Open;
{ NewIDStorProcName:='NEWID_S_DAMG';
 Table_Name:='S_DAMG';}
 fdl:=TStringList.Create;
 fdl.Add('Name_r');
 ListFindFields:=fdl;
 CurFindField:='Name_r';
 fdl.Free;
 SetLength(NotEmptyFields, 1);
 NotEmptyFields[0]:='Name_r';
 SetLength(UniqFields, 1);
 UniqFields[0]:='Name_r';
end;

//*******************************************************************
destructor TS_DamgF.Destroy;
begin
 inherited;
 S_DamgF:=nil
end;

//*******************************************************************
function TS_DamgF.TestInpData :boolean;
begin
 result:=inherited TestInpData;
end;

//*******************************************************************
function TS_DamgF.onBeforeDel(var CanConfirm :boolean; var WarnDelStr :string) :boolean;
begin
 result:=inherited onBeforeDel(CanConfirm, WarnDelStr);
 WarnDelStr:=TrLangMSG(msgDelete)+' "'+CurDataSet.FieldByName('Name_r').asString+'" ?';
end;

//*******************************************************************
procedure TS_DamgF.Translate;
begin
  inherited;
  Caption:=TrLangMSG(msgSpravochOne)+' '+ansilowercase(TrLangMSG(msgPovrezd));
//  Caption:=TrLangMSG(msgSpravochOne)+' '+ansilowercase(TrLangMSG(msgTypeZajav));
  DataGrid_dgr.Columns[0].Title.Caption:=TrLangMSG(msgDesign);
end;

procedure TS_DamgF.S_Place_lcbClick(Sender: TObject);
begin
  inherited;
  CurDataSet.filtered:=false;
  CurDataSet.Filter:='PLACE_TYPE = '+DM1.S_Place_q.FieldbyName('ID').asString;
  CurDataSet.filtered:=true;
  Caption:=BazeCaption;
end;

procedure TS_DamgF.S_Place_lcbCloseUp(Sender: TObject);
begin
  inherited;
 CurDataSet.filtered:=false;
 CurDataSet.Filter:='PLACE_TYPE = '+DM1.S_Place_q.FieldbyName('ID').asString;
 CurDataSet.filtered:=true;
 Caption:=BazeCaption;
end;

procedure TS_DamgF.S_Place_lcbKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
 if Key in [VK_DELETE, VK_BACK] then
   begin
    S_Place_lcb.DisplayValue:='';
    CurDataSet.filtered:=false;
    CurDataSet.Filter:='';
    RefreshCaption;
   end
    else inherited;
end;

end.
