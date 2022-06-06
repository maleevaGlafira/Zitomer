unit s_obor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  baze_dic, Menus, Placemnt, Grids, DBGrids, RXDBCtrl, DBCtrls, StdCtrls,
  Buttons, ExtCtrls, db, frmLANG, cntsLANG;

type
  TS_OborF = class(TBazeDicF)
  public
    constructor CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);override;
    destructor Destroy;override;
    procedure Translate;override;
  end;

var
  S_OborF: TS_OborF;

implementation

{$R *.DFM}
//*******************************************************************
constructor TS_OborF.CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);
var
 fdl :TStringList;
begin
 inherited CreateDic(AOwner, TbName,KeyFd, DSur);
{ NewIDStorProcName:='NEWID_S_OBOR';
 Table_Name:='S_OBOR';}
 fdl:=TStringList.Create;
 fdl.Add('Name_r');
 //fdl.Add('Nomer');
 ListFindFields:=fdl;
 CurFindField:='Name_r';
 fdl.Free;
 SetLength(NotEmptyFields, 1);
 NotEmptyFields[0]:='Name_r';
 SetLength(UniqFields, 2);
 UniqFields[0]:='Name_r';
 UniqFields[1]:='FIO';

end;

//*******************************************************************
destructor TS_OborF.Destroy;
begin
 inherited;
 S_OborF:=nil;
end;

//*******************************************************************
procedure TS_OborF.Translate;
begin
  inherited;
  Caption:=TrLangMSG(msgSpravochOne)+' '+ansilowercase(TrLangMSG(msgMechaniz));
  DataGrid_dgr.Columns[0].Title.Caption:=TrLangMSG(msgTitle);

end;

end.
