unit s_sod;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  baze_dic, Menus, Placemnt, Grids, DBGrids, RXDBCtrl, DBCtrls, StdCtrls,
  Buttons, ExtCtrls, db, RxLookup, frmLANG, cntsLANG;

type
  TS_SodF = class(TBazeDicF)
    S_Sah_lcb: TRxDBLookupCombo;
    procedure S_Sah_lcbCloseUp(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure S_Sah_lcbKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure N1_miClick(Sender: TObject);
    procedure DataGrid_dgrMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  public
    function TestInpData :boolean;override;
    function onBeforeDel(var CanConfirm :boolean; var WarnDelStr :string) :boolean;override;
    constructor CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);override;
    destructor Destroy;override;
    procedure Translate;override;
  end;

var
  S_SodF: TS_SodF;

implementation

uses datam, main;

{$R *.DFM}
//*******************************************************************
constructor TS_SodF.CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);
var
 fdl :TStringList;
begin
 inherited CreateDic(AOwner, TbName,KeyFd, DSur);
 Self.Constraints.MinWidth:=Self.Constraints.MinWidth + S_Sah_lcb.Width+
  110;
 if not DM1.S_Sah_q.Active then DM1.S_Sah_q.Open;
 if not DM1.S_Zayavl_q.Active then DM1.S_Zayavl_q.Open;
 if not DM1.S_FullPlace_q.Active then DM1.S_Place_q.Open;
 if not DM1.S_Fulltzav_q.Active then DM1.S_Fulltzav_q.Open;

 if DM1.s_obortypeglob_q.Active then DM1.s_obortypeglob_q.Close;

  dm1.s_obortypeglob_q.SQL.Text :=
   ' SELECT s.id, s.Name_r,  s.del'+
   ' FROM s_obortypeglob s '+
   ' WHERE s.del  = ''-'' '+
   ' ORDER BY s.Name_r ';
  DM1.s_obortypeglob_q.Open;
 
{ NewIDStorProcName:='NEWID_S_SOD';
 Table_Name:='S_SOD';}
 fdl:=TStringList.Create;
 fdl.Add('Name_r');
 ListFindFields:=fdl;
 CurFindField:='Name_r';
 fdl.Free;
 SetLength(NotEmptyFields, 1);
 NotEmptyFields[0]:='Name_r';
 SetLength(UniqFields, 3);
 UniqFields[0]:='Name_r';
 UniqFields[1]:='ftype';
 UniqFields[2]:='place_type';
end;

//*******************************************************************
destructor TS_SodF.Destroy;
begin
 inherited;
 S_SodF:=nil;
end;

//*******************************************************************
function TS_SodF.TestInpData :boolean;
begin
 result:=inherited TestInpData;
end;

//*******************************************************************
function TS_SodF.onBeforeDel(var CanConfirm :boolean; var WarnDelStr :string) :boolean;
begin
 result:=inherited onBeforeDel(CanConfirm, WarnDelStr);
 WarnDelStr:=TrLangMSG(msgDelete)+' "'+CurDataSet.FieldByName('Name_r').asString+'" ?';
end;

//*******************************************************************
procedure TS_SodF.S_Sah_lcbCloseUp(Sender: TObject);
begin
 CurDataSet.filtered:=false;
 CurDataSet.Filter:='SAH = '+DM1.S_Sah_q.FieldbyName('ID').asString;
 CurDataSet.filtered:=true;
 Caption:=BazeCaption;
end;

//*******************************************************************
procedure TS_SodF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
{ CurDataSet.filtered:=false;
 CurDataSet.Filter:='';}
 inherited;
end;

//*******************************************************************
procedure TS_SodF.S_Sah_lcbKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key in [VK_DELETE, VK_BACK] then
   begin
    S_Sah_lcb.DisplayValue:='';
    CurDataSet.filtered:=false;
    CurDataSet.Filter:='';
    RefreshCaption;
   end
    else inherited;
end;

//*******************************************************************
procedure TS_SodF.N1_miClick(Sender: TObject);
begin
end;

//*******************************************************************
procedure TS_SodF.DataGrid_dgrMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
end;

//*******************************************************************
procedure TS_SodF.Translate;
begin
  inherited;
  Caption:=TrLangMSG(msgSpravochOne)+' '+ansilowercase(TrLangMSG(msgSoderzZajav));
  DataGrid_dgr.Columns[0].Title.Caption:=TrLangMSG(msgDesign);
  //DataGrid_dgr.Columns[1].Title.Caption:=TrLangMSG(msgCategory);
  DataGrid_dgr.Columns[2].Title.Caption:=TrLangMSG(msgSpotPlace);
  DataGrid_dgr.Columns[3].Title.Caption:=TrLangMSG(msgPrinad) ;
  S_Sah_lcb.Hint :=TrLangMSG(msgFilterCategory);
end;

end.
