unit S_Trudozatrat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, baze_dic, Placemnt, Menus, StdCtrls, DBCtrls, ExtCtrls, Buttons,
  Grids, DBGrids, RXDBCtrl, db, frmLANG, cntsLANG;

type
  TS_TrudozatratF = class(TBazeDicF)
  private
  public
    constructor CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource); override;
    destructor Destroy;override;
    procedure Translate;override;
  end;

var
  S_TrudozatratF: TS_TrudozatratF;

implementation

uses datam, main;

{$R *.dfm}

{ TS_TrudozatratF }

constructor TS_TrudozatratF.CreateDic(AOwner: TComponent; TbName,
  KeyFd: string; Dsur: TDataSource);
var
  fdl :TStringList;
begin
  if not DM1.S_Work_q.Active then DM1.S_Work_q.Open;
  if not DM1.S_AllDiam_q.Active then DM1.S_AllDiam_q.Open;
  if not DM1.s_MestType_q.Active then DM1.s_MestType_q.Open;

  inherited CreateDic(AOwner, TbName, KeyFd, DSur);

  fdl := TStringList.Create;
  try
    fdl.Add( 'lp_Work' );
    ListFindFields := fdl;
    CurFindField := 'lp_Work';
  finally
    fdl.Free;
  end;

  SetLength( NotEmptyFields, 6 );
  NotEmptyFields[ 0 ] := 'lp_Work';
  NotEmptyFields[ 1 ] := 'lp_Diam';
  NotEmptyFields[ 2 ] := 'lp_MestType';
  NotEmptyFields[ 3 ] := 'kol_ed';
  NotEmptyFields[ 4 ] := 'tz_summer';
  NotEmptyFields[ 5 ] := 'tz_winter';

  SetLength( UniqFields, 3 );
  UniqFields[ 0 ] := 'id_Work';
  UniqFields[ 1 ] := 'id_Diam';
  UniqFields[ 2 ] := 'id_mesttype';
end;


destructor TS_TrudozatratF.Destroy;
begin
  inherited;
  S_TrudozatratF := nil;
end;

procedure TS_TrudozatratF.Translate;
begin
  inherited;
  Caption:=TrLangMSG(msgSpravochOne)+' '+TrLangMSG(msgTrudozatrat);
  DataGrid_dgr.Columns[0].Title.Caption:=TrLangMSG(msgWorkOne);
  DataGrid_dgr.Columns[1].Title.Caption:=TrLangMSG(msgDiam);
  DataGrid_dgr.Columns[2].Title.Caption:=TrLangMSG(msgPlace);
  DataGrid_dgr.Columns[3].Title.Caption:=TrLangMSG(msgCount);
  DataGrid_dgr.Columns[4].Title.Caption:=TrLangMSG(msgLaborInput)+'('+TrLangMSG(msgSummer)+')';
  DataGrid_dgr.Columns[5].Title.Caption:=TrLangMSG(msgLaborInput)+'('+TrLangMSG(msgWinter)+')';



end;

end.
