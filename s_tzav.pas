unit s_tzav;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  baze_dic, Menus, Placemnt, Grids, DBGrids, RXDBCtrl, DBCtrls, StdCtrls,
  Buttons, ExtCtrls, db, frmLANG, cntsLANG;

type
  TS_TzavF = class(TBazeDicF)
    procedure BAutoRefrClick(Sender: TObject);
  public
    constructor CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);override;
    destructor Destroy;override;
    procedure Translate;override;
  end;

var
  S_TzavF: TS_TzavF;

implementation

{$R *.DFM}
//*******************************************************************
constructor TS_TzavF.CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);
var
 fdl :TStringList;
begin
 inherited CreateDic(AOwner, TbName,KeyFd, DSur);
 //BHide.enabled:=BDel.enabled;
{ NewIDStorProcName:='NEWID_S_TZAV';
 Table_Name:='S_TZAV';}
 fdl:=TStringList.Create;
 fdl.Add('Name_r');
 fdl.Add('ISVIEZD');
 ListFindFields:=fdl;
 CurFindField:='Name_r';
 fdl.Free;
 SetLength(NotEmptyFields, 1);
 NotEmptyFields[0]:='Name_r';
 SetLength(UniqFields, 1);
 UniqFields[0]:='Name_r';
end;

//*******************************************************************
destructor TS_TzavF.Destroy;
begin
 inherited;
 S_TzavF:=nil;
end;

//*******************************************************************
procedure TS_TzavF.Translate;
begin
  inherited;
  Caption:=TrLangMSG(msgSpravochOne)+' '+ansilowercase(TrLangMSG(msgTypeZajav));
  DataGrid_dgr.Columns[0].Title.Caption:=TrLangMSG(msgTitle);
  DataGrid_dgr.Columns[1].Title.Caption:=TrLangMSG(msgWentOne);
end;

procedure TS_TzavF.BAutoRefrClick(Sender: TObject);
begin
  inherited;
  //
end;

end.
