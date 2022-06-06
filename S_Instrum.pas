unit S_Instrum;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, baze_dic, Placemnt, Menus, StdCtrls, DBCtrls, ExtCtrls, Buttons,
  Grids, DBGrids, RXDBCtrl, DB;

type
  TS_InstrumF = class(TBazeDicF)
  public
    constructor CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);override;
    destructor Destroy;override;
    procedure Translate;override;
  end;

var
  S_InstrumF: TS_InstrumF;

implementation

{$R *.dfm}

{ TS_InstrumF }
 uses frmLANG, cntsLANG;
procedure TS_InstrumF.Translate;
begin
 Caption:=TrLangMSG(msgSpravochOne)+' '+TrLangMSG(msgInstruments);
 DataGrid_dgr.Columns[0].Title.Caption:=TrLangMSG(msgDesign);
end;

constructor TS_InstrumF.CreateDic(AOwner: TComponent; TbName,
  KeyFd: string; Dsur: TDataSource);
var
 fdl :TStringList;
begin
 inherited CreateDic(AOwner, TbName,KeyFd, DSur);
 fdl := TStringList.Create;
 fdl.Add( 'Name_r' );
 ListFindFields := fdl;
 CurFindField := 'Name_r';
 fdl.Free;
 SetLength( NotEmptyFields, 1 );
 NotEmptyFields[0] := 'Name_r';
 SetLength( UniqFields, 1 );
 UniqFields[0] := 'Name_r';
end;

destructor TS_InstrumF.Destroy;
begin
  inherited;
  S_InstrumF := nil;
end;

end.
