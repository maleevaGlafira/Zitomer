unit s_work_mest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, baze_dic, Placemnt, Menus, StdCtrls, DBCtrls, ExtCtrls, Buttons,
  Grids, DBGrids, RXDBCtrl, DB,frmLANG,cntsLANG;

type
  Ts_work_mestF = class(TBazeDicF)
  private
  public
    constructor CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);override;
    destructor Destroy;override;
    procedure Translate;override;
  end;

var
  s_work_mestF: Ts_work_mestF;

implementation

uses datam;

{$R *.dfm}

{ Ts_work_mestF }

constructor Ts_work_mestF.CreateDic(AOwner: TComponent; TbName,
  KeyFd: string; Dsur: TDataSource);
var
 fdl :TStringList;
begin
 inherited CreateDic(AOwner, TbName,KeyFd, DSur);
 DM1.S_Mest_q.Close; DM1.S_Mest_q.Open;
 DM1.s_BlagWork_q.Close; DM1.s_BlagWork_q.Open;

{
 fdl:=TStringList.Create;
 fdl.Add('Name_r');
 ListFindFields:=fdl;
 CurFindField:='Name_r';
 fdl.Free;
}
 SetLength(NotEmptyFields, 2);
 NotEmptyFields[0]:='listWORK';
 NotEmptyFields[1]:='list_MEST';

 SetLength(UniqFields, 2);
 UniqFields[0]:='id_work';
 UniqFields[1]:='id_mest';
end;

destructor Ts_work_mestF.Destroy;
begin
  inherited;
  s_work_mestF := nil;
end;

procedure Ts_work_mestF.Translate;
begin
  inherited;
//
 Caption:=TrLangMSG(msgSpravochOne)+' '+TrLangMSG(msgAddMustBlagWork);
DataGrid_dgr.Columns[0].Title.Caption:=TrLangMSG(msgPlace);
DataGrid_dgr.Columns[1].Title.Caption:=TrLangMSG(msgWorkOne);

end;

end.
