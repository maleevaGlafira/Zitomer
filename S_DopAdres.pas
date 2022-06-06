unit S_DopAdres;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, baze_dic, Placemnt, Menus, StdCtrls, DBCtrls, ExtCtrls, Buttons,
  Grids, DBGrids, RXDBCtrl, DB;

type
  TS_DopAdresF = class(TBazeDicF)
  private
  public
    constructor CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);override;
    destructor Destroy;override;
    procedure Translate;override;
  end;

var
  S_DopAdresF: TS_DopAdresF;

implementation

{$R *.dfm}

uses cntsLANG, frmLANG;

{ TS_DopAdresF }

constructor TS_DopAdresF.CreateDic(AOwner: TComponent; TbName,
  KeyFd: string; Dsur: TDataSource);
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
end;

destructor TS_DopAdresF.Destroy;
begin
  S_DopAdresF:=nil;
  inherited;
end;

procedure TS_DopAdresF.Translate;
begin
  inherited;
  Caption:=TrLangMSG(msgSpravochOne)+' '+ansilowercase(TrLangMSG(msgDopAdresov));
  DataGrid_dgr.Columns[0].Title.Caption:=TrLangMSG(msgDopAdres);
end;

end.
