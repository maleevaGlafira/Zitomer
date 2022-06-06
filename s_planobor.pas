unit s_planobor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, baze_dic, Placemnt, Menus, StdCtrls, DBCtrls, ExtCtrls, Buttons,
  Grids, DBGrids, RXDBCtrl,db, frmLANG, cntsLANG;

type
  TS_PlanOborF = class(TBazeDicF)
  public
    constructor CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);override;
    destructor Destroy;override;
    procedure Translate;override;
  end;

var
  S_PlanOborF: TS_PlanOborF;

implementation

{$R *.dfm}

{ TS_PlanOborF }

constructor TS_PlanOborF.CreateDic(AOwner: TComponent; TbName,
  KeyFd: string; Dsur: TDataSource);
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
 SetLength(UniqFields, 1);
 UniqFields[0]:='Name_r';
end;

destructor TS_PlanOborF.Destroy;
begin
 inherited;
 S_PlanOborF:=nil;
end;

procedure TS_PlanOborF.Translate;
begin
  inherited;
  Caption:=TrLangMSG(msgSpravochOne)+' '+ansilowercase(TrLangMSG(msgPlanMechaniz));
  DataGrid_dgr.Columns[0].Title.Caption:=TrLangMSG(msgTitle);
end;

end.
