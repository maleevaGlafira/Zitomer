unit s_mat;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  baze_dic, Menus, Placemnt, Grids, DBGrids, RXDBCtrl, DBCtrls, StdCtrls,
  Buttons, ExtCtrls, db, frmLANG, cntsLANG;

type
  TS_MatF = class(TBazeDicF)
  public
    constructor CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);override;
    destructor Destroy;override;
    procedure Translate;override;
  end;

var
  S_MatF: TS_MatF;

implementation

{$R *.DFM}
//*******************************************************************
constructor TS_MatF.CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);
var
 fdl :TStringList;
begin
 inherited CreateDic(AOwner, TbName,KeyFd, DSur);
{ NewIDStorProcName:='NEWID_S_MAT';
 Table_Name:='S_MAT';}
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
destructor TS_MatF.Destroy;
begin
 inherited;
 S_MatF:=nil;
end;

//*******************************************************************
procedure TS_MatF.Translate;
begin
  inherited;
  Caption:=TrLangMSG(msgSpravochOne)+' '+ansilowercase(TrLangMSG(msgMaters));
  DataGrid_dgr.Columns[0].Title.Caption:=TrLangMSG(msgTitle);
  DataGrid_dgr.Columns[1].Title.Caption:=TrLangMSG(msgODDSIZE);
  DataGrid_dgr.Columns[2].Title.Caption:=TrLangMSG(msgDiam);
end;

end.
