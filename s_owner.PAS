unit s_Owner;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  baze_dic, Menus, Placemnt, Grids, DBGrids, RXDBCtrl, DBCtrls, StdCtrls,
  Buttons, ExtCtrls, db, frmLANG, cntsLANG;

type
  TS_OwnerF = class(TBazeDicF)
  private
    { Private declarations }
  public
    { Public declarations }
    constructor CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);override;
    destructor Destroy;override;
    procedure Translate;override;
  end;

var
  S_OwnerF: TS_OwnerF;

implementation

{$R *.DFM}

constructor TS_OwnerF.CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);
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
destructor TS_OwnerF.Destroy;
begin
 inherited;
 S_OwnerF:=nil;
end;

procedure TS_OwnerF.Translate;
begin
  inherited;
  Caption:=TrLangMSG(msgSpravochOne)+' '+ansilowercase(TrLangMSG(msgTypeOwner));
  DataGrid_dgr.Columns[0].Title.Caption:=TrLangMSG(msgDesign);
  DataGrid_dgr.Columns[1].Title.Caption:=TrLangMSG(msgType);
//  DataGrid_dgr.Columns[2].Title.Caption:=TrLangMSG(msgDesign);
end;

end.
