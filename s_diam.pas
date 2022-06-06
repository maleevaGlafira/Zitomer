unit s_diam;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  baze_dic, Menus, Placemnt, Grids, DBGrids, RXDBCtrl, DBCtrls, StdCtrls,
  Buttons, ExtCtrls, db, frmLANG, cntsLANG;

type
  TS_DiamF = class(TBazeDicF)
  public
    constructor CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);override;
    destructor Destroy;override;
    procedure Translate;override;
  end;

var
  S_DiamF: TS_DiamF;

implementation

{$R *.DFM}
//*******************************************************************
constructor TS_DiamF.CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);
var
 fdl :TStringList;
begin
 inherited CreateDic(AOwner, TbName,KeyFd, DSur);
{ NewIDStorProcName:='NEWID_S_DIAM';
 Table_Name:='S_DIAM';}
 fdl:=TStringList.Create;
 fdl.Add('Diam');
 ListFindFields:=fdl;
 CurFindField:='Diam';
 fdl.Free;
 SetLength(NotEmptyFields, 1);
 NotEmptyFields[0]:='Diam';
 SetLength(UniqFields, 1);
 UniqFields[0]:='Diam';
end;

//*******************************************************************
destructor TS_DiamF.Destroy;
begin
 inherited;
 S_DiamF:=nil;
end;

//*******************************************************************
procedure TS_DiamF.Translate;
begin
  inherited;
  Caption:=TrLangMSG(msgSpravochOne)+' '+ansilowercase(TrLangMSG(msgDiams));
  DataGrid_dgr.Columns[0].Title.Caption:=TrLangMSG(msgDiam);
end;

end.
