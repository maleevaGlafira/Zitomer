unit s_zav;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  baze_dic, Menus, Placemnt, Grids, DBGrids, RXDBCtrl, DBCtrls, StdCtrls,
  Buttons, ExtCtrls, db, frmLANG, cntsLANG;

type
  TS_ZavF = class(TBazeDicF)
  public
    constructor CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);override;
    destructor Destroy;override;
    procedure Translate;override;
  end;

var
  S_ZavF: TS_ZavF;

implementation

{$R *.DFM}
//*******************************************************************
constructor TS_ZavF.CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);
var
 fdl :TStringList;
begin
 inherited CreateDic(AOwner, TbName,KeyFd, DSur);
{ NewIDStorProcName:='NEWID_S_ZAV';
 Table_Name:='S_ZAV';}
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
destructor TS_ZavF.Destroy;
begin
 inherited;
 S_ZavF:=nil;
end;

//*******************************************************************
procedure TS_ZavF.Translate;
begin
  inherited;
  Caption:=TrLangMSG(msgSpravochOne)+' '+ansilowercase(TrLangMSG(msgZajavitels));
  DataGrid_dgr.Columns[0].Title.Caption:=TrLangMSG(msgZajavitelOne);
end;

end.
