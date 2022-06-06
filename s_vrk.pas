unit s_vrk;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, baze_dic, Placemnt, Menus, StdCtrls, DBCtrls, ExtCtrls, Buttons,
  Grids, DBGrids, RXDBCtrl, datam, DB, frmLANG, cntsLANG;

type
  TS_VRK_F = class(TBazeDicF)
  private
  public
     constructor CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);override;
     destructor Destroy; override;
     procedure Translate;override;
  end;

var
  S_VRK_F: TS_VRK_F;

implementation

{$R *.dfm}

{ TS_VRK_F }

constructor TS_VRK_F.CreateDic(AOwner: TComponent; TbName, KeyFd: string;
  Dsur: TDataSource);
var
 fdl: TStringList;
begin
 if not DM1.s_yesno_q.Active then DM1.s_yesno_q.Open;
 if not DM1.s_ulic_q.Active then DM1.s_ulic_q.Open;
 if not DM1.s_tvrk_q.Active then DM1.s_tvrk_q.Open;
 inherited CreateDic(AOwner, TbName,KeyFd, DSur);
 fdl:=TStringList.Create;
 fdl.Add('listULIC');
 ListFindFields:=fdl;
 CurFindField:='ULIC';
 fdl.Free;

// SetLength(NotEmptyFields, 1);
// NotEmptyFields[0]:='ID_ULIC';
// NotEmptyFields[0]:='NUM_DOM';
// NotEmptyFields[2]:='ID_TVRK';
// NotEmptyFields[3]:='OPLACHENO';

 //-- Гладков 15.09.2008
 SetLength(UniqFields, 4);
 //SetLength(UniqFields, 5);
 UniqFields[0]:='ID_ULIC';
 UniqFields[1]:='NUM_DOM';
 UniqFields[2]:='ID_TVRK';
 UniqFields[3]:='OPLACHENO';

 //UniqFields[4]:='N_VRK';//-- Гладков 15.09.2008
end;

destructor TS_VRK_F.Destroy;
begin
  inherited;
  S_VRK_F:=nil;
end;

procedure TS_VRK_F.Translate;
begin
  inherited;
  Caption:=TrLangMSG(msgSpravochOne)+' ВРК';
  DataGrid_dgr.Columns[0].Title.Caption:=TrLangMSG(msgStreet);
  DataGrid_dgr.Columns[1].Title.Caption:=TrLangMSG(msgNumDom);
//  DataGrid_dgr.Columns[2].Title.Caption:=TrLangMSG();
  DataGrid_dgr.Columns[3].Title.Caption:=TrLangMSG(msgIsPayed);
  //DataGrid_dgr.Columns[4].Title.Caption:=TrLangMSG();

end;

end.
