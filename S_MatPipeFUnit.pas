unit S_MatPipeFUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, baze_dic, Placemnt, Menus, StdCtrls, DBCtrls, ExtCtrls, Buttons,
  Grids, DBGrids, RXDBCtrl,DB;

type
  TS_MatPipeF = class(TBazeDicF)
  private
    { Private declarations }
  public
    { Public declarations }
    constructor CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);override;
    destructor Destroy;override;
    procedure Translate;override;
  end;

var
  S_MatPipeF: TS_MatPipeF;

implementation

{$R *.dfm}
uses frmLANG,cntsLANG;

//*******************************************************************
constructor TS_MatPipeF.CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);
var
 fdl :TStringList;
begin
 inherited CreateDic(AOwner, TbName,KeyFd, DSur);
 fdl:=TStringList.Create;
 fdl.Add('Name_r');
 ListFindFields:=fdl;
 CurFindField:='Name_r';
 fdl.Free;
 SetLength(NotEmptyFields, 1);
 NotEmptyFields[0]:='Name_r';
 SetLength(UniqFields, 1);
 UniqFields[0]:='Name_r';
 //
 //DataGrid_dgr.Columns[0].FieldName:='name_r';
end;

//*******************************************************************
destructor TS_MatPipeF.Destroy;
begin
 inherited;
 S_MatPipeF:=nil;
end;

//*******************************************************************
procedure TS_MatPipeF.Translate;
begin
  inherited;
  Caption:=TrLangMSG(msgSpravochOne)+' '+ansilowercase(TrLangMSG(msgMaterTrub));
  DataGrid_dgr.Columns[0].Title.Caption:=TrLangMSG(msgMaterTrubOne);
  //DataGrid_dgr.Columns[1].Title.Caption:=TrLangMSG(msgODDSIZE);
  //DataGrid_dgr.Columns[2].Title.Caption:=TrLangMSG(msgDiam);
end;

end.
