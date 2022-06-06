unit s_remont;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, baze_dic, Menus, Placemnt, StdCtrls, DBCtrls, ExtCtrls, Buttons,
  Grids, DBGrids, RXDBCtrl,db, frmLANG, cntsLANG, datam;

type
  TS_RemontF = class(TBazeDicF)
  private
    { Private declarations }
  public
    { Public declarations }
    constructor CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);override;
    destructor Destroy;override;
    procedure Translate;override;
  end;

var
  S_RemontF: TS_RemontF;

implementation

uses s_rayons;

{$R *.dfm}

constructor TS_RemontF.CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);
var
 fdl :TStringList;
begin
 DM1.s_remont_type_q.Close; DM1.s_remont_type_q.Open; 

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
end;

//*******************************************************************
destructor TS_RemontF.Destroy;
begin
 inherited;
 S_RayonsF:=nil;
end;

procedure TS_RemontF.Translate;
begin
  inherited;
  Caption:=TrLangMSG(msgSpravochOne)+' '+ansilowercase(TrLangMSG(msgREMONT));
  DataGrid_dgr.Columns[0].Title.Caption:=TrLangMSG(msgDesign);
end;

end.
