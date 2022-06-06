unit s_object;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, baze_dic, Placemnt, Menus, StdCtrls, DBCtrls, ExtCtrls, Buttons,
  Grids, DBGrids, RXDBCtrl, db;

type
  Ts_ObjectF = class(TBazeDicF)
  private
  public
    constructor CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource); override;
    destructor Destroy;override;
    procedure Translate;override;
  end;

var
  s_ObjectF: Ts_ObjectF;

implementation

uses datam, frmLANG, cntsLANG;

{$R *.dfm}

{ Ts_ObjectF }



constructor Ts_ObjectF.CreateDic(AOwner: TComponent; TbName, KeyFd: string;
  Dsur: TDataSource);
var
  fdl :TStringList;
begin
  if not DM1.qry_ObjAtt.Active then DM1.qry_ObjAtt.Open;

  inherited CreateDic(AOwner, TbName, KeyFd, DSur);

  fdl := TStringList.Create;
  try
    fdl.Add( 'name_r' );
    ListFindFields := fdl;
    CurFindField := 'name_r';
  finally
    fdl.Free;
  end;

  SetLength( NotEmptyFields, 2 );
  NotEmptyFields[ 0 ] := 'name_r';
  NotEmptyFields[ 1 ] := 'lp_Attach';

  SetLength( UniqFields, 3 );
  UniqFields[ 0 ] := 'name_r';
  UniqFields[ 1 ] := 'id_attach';
  UniqFields[ 2 ] := 'id_revs';
end;

destructor Ts_ObjectF.Destroy;
begin
  inherited;
  s_ObjectF := nil;
end;


procedure Ts_ObjectF.Translate;
begin
 Caption:=TrLangMSG(msgSpravochOne)+' '+TrLangMSG(msgObjects);
 DataGrid_dgr.Columns[0].Title.Caption:=TrLangMSG(msgDesign);
 DataGrid_dgr.Columns[1].Title.Caption:=TrLangMSG(msgPrinad);
 DataGrid_dgr.Columns[2].Title.Caption:=TrLangMSG(msgDesign);
end;

end.                                                   
