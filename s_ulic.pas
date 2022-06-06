unit s_ulic;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  baze_dic, Menus, Placemnt, Grids, DBGrids, RXDBCtrl, DBCtrls, StdCtrls,
  Buttons, ExtCtrls, RxLookup, db, frmLANG, cntsLANG;

type
  Ts_ulicF = class(TBazeDicF)
    ExtPMenu_pm: TPopupMenu;
    N1_mi: TMenuItem;
    procedure S_Place_lcbClick(Sender: TObject);
    procedure S_Place_lcbKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DataGrid_dgrDblClick(Sender: TObject);
    procedure N1_miClick(Sender: TObject);
    procedure DataGrid_dgrMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DBNav_dnBeforeAction(Sender: TObject; Button: TNavigateBtn);
  public
    constructor CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);override;
    destructor Destroy;override;
    procedure Translate;override;
  end;

var
  s_ulicF: Ts_ulicF;

implementation

uses datam, main;

{$R *.DFM}
//*******************************************************************
constructor Ts_ulicF.CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);
var
 fdl :TStringList;
begin
 inherited CreateDic(AOwner, TbName,KeyFd, DSur);
 if not DM1.S_Place_q.Active then DM1.S_Place_q.Open;
{ NewIDStorProcName:='NEWID_s_ulic';
 Table_Name:='s_ulic';}
 fdl:=TStringList.Create;
 fdl.Add('Name_r');
 ListFindFields:=fdl;
 CurFindField:='Name_r';
 fdl.Free;
 SetLength(NotEmptyFields, 1);
 NotEmptyFields[0]:='Name_r';
 SetLength(UniqFields, 3);
 UniqFields[0]:='Name_r';
 UniqFields[1]:='id_vidul';
 UniqFields[2]:='id_rayon';
end;

//*******************************************************************
destructor Ts_ulicF.Destroy;
begin
 inherited;
 s_ulicF:=nil;
end;

//*******************************************************************
procedure Ts_ulicF.S_Place_lcbClick(Sender: TObject);
begin
 CurDataSet.filtered:=false;
 CurDataSet.Filter:='ID_VIDUL = '+DM1.S_Place_q.FieldbyName('ID').asString;
 CurDataSet.filtered:=true;
 Caption:=BazeCaption;
end;

//*******************************************************************
procedure Ts_ulicF.S_Place_lcbKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
end;

//*******************************************************************
procedure Ts_ulicF.DataGrid_dgrDblClick(Sender: TObject);
begin
 inherited;
end;

//*******************************************************************
procedure Ts_ulicF.N1_miClick(Sender: TObject);
begin
 inherited;
 FormMain.N5Click(self);
end;

//*******************************************************************
procedure Ts_ulicF.DataGrid_dgrMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
 pt :TPoint;
begin
 inherited;
 if (Button = mbRight)and(DataGrid_dgr.SelectedField = dm1.S_ulic_qlist_place)
    then begin
          pt.X:=X; pt.Y:=Y;
          pt:=ClientToScreen(pt);
          ExtPMenu_pm.Popup(pt.X, pt.Y+(Height - ClientHeight));
         end;
end;

//*******************************************************************
procedure Ts_ulicF.DBNav_dnBeforeAction(Sender: TObject;
  Button: TNavigateBtn);
begin
  inherited;
//
end;

procedure Ts_ulicF.Translate;
begin
  inherited;
  Caption:=TrLangMSG(msgSpravochOne)+' '+ansilowercase(TrLangMSG(msgNameStreets));
  DataGrid_dgr.Columns[0].Title.Caption:=TrLangMSG(msgTitle);
  N1_mi.Caption :=TrLangMSG(msgShow)+' '+ansilowercase(TrLangMSG(msgSpravochOne))+' '+
                  ansilowercase(TrLangMSG(msgTypeStreets));
end;

end.
