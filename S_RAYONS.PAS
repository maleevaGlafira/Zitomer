unit s_rayons;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  baze_dic, Menus, Placemnt, Grids, DBGrids, RXDBCtrl, DBCtrls, StdCtrls,
  Buttons, ExtCtrls, db, frmLANG, cntsLANG;

type
  TS_RayonsF = class(TBazeDicF)
  private
    { Private declarations }
  public
    { Public declarations }
    constructor CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);override;
    destructor Destroy;override;
    procedure Translate;override;
  end;

var
  S_RayonsF: TS_RayonsF;

implementation

{$R *.DFM}

constructor TS_RayonsF.CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);
var
 fdl :TStringList;
begin
 inherited CreateDic(AOwner, TbName,KeyFd, DSur);
{ NewIDStorProcName:='NEWID_S_REVS';
 Table_Name:='S_REVS';}
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
destructor TS_RayonsF.Destroy;
begin
 inherited;
 S_RayonsF:=nil;
end;

procedure TS_RayonsF.Translate;
begin
  inherited;
  Caption:=TrLangMSG(msgSpravochOne)+' '+ansilowercase(TrLangMSG(msgRAYONS));
  DataGrid_dgr.Columns[0].Title.Caption:=TrLangMSG(msgDesign);
end;

end.
