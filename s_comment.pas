unit s_Comment;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  baze_dic, DBTables, Menus, Placemnt, Grids, DBGrids, RXDBCtrl, DBCtrls,
  StdCtrls, Buttons, ExtCtrls, db, frmLANG, cntsLANG;

type
  TS_CommentF = class(TBazeDicF)
  public
    function TestInpData :boolean;override;
    function onBeforeDel(var CanConfirm :boolean; var WarnDelStr :string) :boolean;override;
    constructor CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);override;
    destructor Destroy;override;
    procedure Translate;override;
  end;

var
  S_CommentF: TS_CommentF;

implementation

{$R *.DFM}
//*******************************************************************
constructor TS_CommentF.CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);
var
 fdl :TStringList;
begin
 inherited CreateDic(AOwner, TbName,KeyFd, DSur);
{ NewIDStorProcName:='NEWID_S_Comment';
 Table_Name:='S_Comment';}
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
destructor TS_CommentF.Destroy;
begin
 inherited;
 S_CommentF:=nil;
end;

//*******************************************************************
function TS_CommentF.TestInpData :boolean;
begin
{ if (not Empty_ValueInCt(DM1.S_Brig_q.FieldByName('Name_r'), self.handle,
         '?????????? ?????? ???')
   then result:=true
   else result:=false;}
 result:=inherited TestInpData;
end;

//*******************************************************************
function TS_CommentF.onBeforeDel(var CanConfirm :boolean; var WarnDelStr :string) :boolean;
begin
 result:=inherited onBeforeDel(CanConfirm, WarnDelStr);
 WarnDelStr:=TrLangMSG(msgDelete)+' "'+CurDataSet.FieldByName('Name_r').asString+'" ?';
end;

//*******************************************************************
procedure TS_CommentF.Translate;
begin
  inherited;
  Caption:=TrLangMSG(msgSpravochOne)+' '+ansilowercase(TrLangMSG(msgSoderzZajav));
  DataGrid_dgr.columns[0].Title.Caption:=TrLangMSG(msgTitle);
end;

end.
