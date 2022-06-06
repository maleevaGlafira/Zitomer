unit S_Soorug;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, baze_dic, Placemnt, Menus, StdCtrls, DBCtrls, ExtCtrls, Buttons,
  Grids, DBGrids, RXDBCtrl, db;

type
  TS_SOORUGF = class(TBazeDicF)
    procedure DataGrid_dgrTitleClick(Column: TColumn);
    procedure DBNav_dnClick(Sender: TObject; Button: TNavigateBtn);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);override;
    destructor Destroy;override;
    procedure Translate;override;
  end;

var
  S_SOORUGF: TS_SOORUGF;

implementation

uses datam,cntsLANG,frmLANG;

{$R *.dfm}

constructor TS_SOORUGF.CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);
var
 fdl :TStringList;
begin
{ DM1.s_soorug_q.SQL.Text :=
 ' SELECT s.id, s.Name_r,  s.id_object,s.del '+
 ' ,(select so.name_r from s_object so where so.id = s.id_object ) name_o '+
 ' FROM s_soorug s '+
 ' WHERE s.id > 0 ' +
 ' ORDER BY s.Name_r';
 }
 inherited CreateDic(AOwner, TbName,KeyFd, DSur);
{ NewIDStorProcName:='NEWID_S_REVS';
 Table_Name:='S_REVS';}
 //if not DM1.s_object_q.Active then DM1.s_object_q.Open;
 if not DM1.ibds_soorug.Active then DM1.ibds_soorug.Open;
 fdl:=TStringList.Create;
 fdl.Add('Name_r');
 ListFindFields:=fdl;
 CurFindField:='Name_r';
 fdl.Free;
 SetLength(NotEmptyFields, 1);
 NotEmptyFields[0]:='Name_r';
 SetLength(UniqFields, 2);
 UniqFields[0]:='Name_r';
 UniqFields[1]:='id_object';
end;

//*******************************************************************
destructor TS_SOORUGF.Destroy;
begin
 inherited;
 S_SOORUGF:=nil;
end;

procedure TS_SOORUGF.Translate;
begin
  inherited;
   Caption:='Справочник сооружений';
  Caption:=TrLangMSG(msgSpravochOne)+' '+ansilowercase(TrLangMSG(msgConstructions));

  DataGrid_dgr.Columns[0].Title.Caption:=TrLangMSG(msgDesign);
  DataGrid_dgr.Columns[1].Title.Caption:=TrLangMSG(msgObjectOne);

end;


procedure TS_SOORUGF.DataGrid_dgrTitleClick(Column: TColumn);
var sOrder: string;
begin
  inherited;
 // sOrder := ' order by s.'+ Column.FieldName;

 case Column.Index of
 0: sOrder := ' order by s.Name_r' ;
 1: sOrder := ' order by 5';
 end;

  DM1.ibds_soorug.Close;
//   DM1.s_soorug_q.SQL.Text :=
  DM1.ibds_soorug.SelectSQL.Text :=
 ' SELECT s.id, s.Name_r,  s.id_object,s.del '+
 ' ,(select name_r from s_object where id = s.id_object ) name_o '+
 //' , so.name_r name_o '+
 ' FROM s_soorug s '+
 //' left join s_object so on (s.id_object = so.id) '+
 ' WHERE s.id > 0 '+
  sOrder;
// ' ORDER BY s.Name_r';
  DM1.ibds_soorug.Open;
//   BRefr.Click;

end;

procedure TS_SOORUGF.DBNav_dnClick(Sender: TObject; Button: TNavigateBtn);
begin
  inherited;
 //
 if Button = nbPost then
    begin

      DM1.IBTransaction1.Commit;
      if not dm1.ibds_soorug.Active then dm1.ibds_soorug.Open;
    end;  
end;

end.
