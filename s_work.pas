unit s_work;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  baze_dic, Menus, Placemnt, Grids, DBGrids, RXDBCtrl, DBCtrls, StdCtrls,
  Buttons, ExtCtrls, RxLookup, db, frmLANG, cntsLANG;

type
  TS_WorkF = class(TBazeDicF)
    ExtPMenu_pm: TPopupMenu;
    N1_mi: TMenuItem;
    S_Place_lcb: TRxDBLookupCombo;
    procedure S_Place_lcbClick(Sender: TObject);
    procedure S_Place_lcbKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DataGrid_dgrDblClick(Sender: TObject);
    procedure N1_miClick(Sender: TObject);
    procedure DataGrid_dgrMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  public
    constructor CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);override;
    destructor Destroy;override;
    procedure Translate;override;
  end;

var
  S_WorkF: TS_WorkF;

implementation

uses datam, main;

{$R *.DFM}
//*******************************************************************
constructor TS_WorkF.CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);
var
 fdl :TStringList;
begin
 inherited CreateDic(AOwner, TbName,KeyFd, DSur);
 Self.Constraints.MinWidth:=Self.Constraints.MinWidth + S_Place_lcb.Width;
 if not DM1.S_Place_q.Active then DM1.S_Place_q.Open;
 DM1.s_work_type_q.Close; DM1.s_work_type_q.Open;

 if DM1.s_obortypeglob_look.Active then DM1.s_obortypeglob_look.Close;
 DM1.s_obortypeglob_look.SQL.Text := ' SELECT s.id, s.Name_r, s.del '+
       ' FROM s_obortypeglob s '+
       ' WHERE s.id > 0    '+
       ' ORDER BY s.Name_r ';

 DM1.s_obortypeglob_look.Open;

{ NewIDStorProcName:='NEWID_S_WORK';
 Table_Name:='S_WORK';}
 fdl:=TStringList.Create;
 fdl.Add('Name_r');
 ListFindFields:=fdl;
 CurFindField:='Name_r';
 fdl.Free;
 SetLength(NotEmptyFields, 2);
 NotEmptyFields[0]:='Name_r';
 NotEmptyFields[1]:='list_PLACE';
 SetLength(UniqFields, 2);
 UniqFields[0]:='Name_r';
 UniqFields[1]:='ftype';
end;

//*******************************************************************
destructor TS_WorkF.Destroy;
begin
 inherited;
 S_WorkF:=nil;
end;

//*******************************************************************
procedure TS_WorkF.S_Place_lcbClick(Sender: TObject);
begin
 CurDataSet.filtered:=false;
 CurDataSet.Filter:='FTYPE = '+DM1.S_Place_q.FieldbyName('ID').asString;
 CurDataSet.filtered:=true;
 Caption:=BazeCaption;
end;

//*******************************************************************
procedure TS_WorkF.S_Place_lcbKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key in [VK_DELETE, VK_BACK] then
   begin
    S_Place_lcb.DisplayValue:='';
    CurDataSet.filtered:=false;
    CurDataSet.Filter:='';
    RefreshCaption;
   end
    else inherited;
end;

//*******************************************************************
procedure TS_WorkF.DataGrid_dgrDblClick(Sender: TObject);
begin
 inherited;
end;

//*******************************************************************
procedure TS_WorkF.N1_miClick(Sender: TObject);
begin
 inherited;
 FormMain.S_Place_miClick(self);
end;

//*******************************************************************
procedure TS_WorkF.DataGrid_dgrMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
 pt :TPoint;
begin
 inherited;
 if (Button = mbRight)and(DataGrid_dgr.SelectedField = dm1.S_Work_qList_Place)
    then begin
          pt.X:=X; pt.Y:=Y;
          pt:=ClientToScreen(pt);
          ExtPMenu_pm.Popup(pt.X, pt.Y+(Height - ClientHeight));
         end;
end;

//*******************************************************************
procedure TS_WorkF.Translate;
begin
  inherited;
  Caption:=TrLangMSG(msgSpravochOne)+' '+ansilowercase(TrLangMSG(msgWorks));
  DataGrid_dgr.Columns[0].Title.Caption:=TrLangMSG(msgTitle);
  DataGrid_dgr.Columns[1].Title.Caption:=TrLangMSG(msgODDSIZE);
  DataGrid_dgr.Columns[2].Title.Caption:=TrLangMSG(msgSpotPlace);
  DataGrid_dgr.Columns[3].Title.Caption:=TrLangMSG(msgTypeWork);
  DataGrid_dgr.Columns[4].Title.Caption:=TrLangMSG(msgCommonTypEquipOne);

  S_place_lcb.Hint :=TrLangMSG(msgFilterCategory);
  N1_mi.Caption :=TrLangMSG(msgShow)+' '+ansilowercase(TrLangMSG(msgSpravochOne))+' '+
                  ansilowercase(TrLangMSG(msgMestPovr));
end;

end.
