unit s_sah;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  baze_dic, Menus, Placemnt, Grids, DBGrids, RXDBCtrl, DBCtrls, StdCtrls,
  Buttons, ExtCtrls, db, frmLANG, cntsLANG;

type
  TS_SahF = class(TBazeDicF)
  public
    function TestInpData :boolean;override;
    function onBeforeDel(var CanConfirm :boolean; var WarnDelStr :string) :boolean;override;
    constructor CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);override;
    destructor Destroy;override;
    procedure Translate;override;
  end;

var
  S_SahF: TS_SahF;

implementation

{$R *.DFM}
//*******************************************************************
constructor TS_SahF.CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);
var
 fdl :TStringList;
begin
 inherited CreateDic(AOwner, TbName,KeyFd, DSur);
{ NewIDStorProcName:='NEWID_S_SAH';
 Table_Name:='S_SAH';}
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
destructor TS_SahF.Destroy;
begin
 inherited;
 S_SahF:=nil;
end;

//*******************************************************************
function TS_SahF.TestInpData :boolean;
begin
 result:=inherited TestInpData;
end;

//*******************************************************************
function TS_SahF.onBeforeDel(var CanConfirm :boolean; var WarnDelStr :string) :boolean;
begin
 result:=inherited onBeforeDel(CanConfirm, WarnDelStr);
 WarnDelStr:=TrLangMSG(msgDelete)+' "'+CurDataSet.FieldByName('Name_r').asString+'" ?';
end;

//*******************************************************************
procedure TS_SahF.Translate;
begin
  inherited;
  Caption:=TrLangMSG(msgSpravochOne)+' '+ansilowercase(TrLangMSG(msgTypesColSHACH));
  DataGrid_dgr.Columns[0].Title.Caption:=TrLangMSG(msgTitle);
end;

end.
