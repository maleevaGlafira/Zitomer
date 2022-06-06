unit S_OBORTYPEGLOB;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, baze_dic, Placemnt, Menus, StdCtrls, DBCtrls, ExtCtrls, Buttons,
  Grids, DBGrids, RXDBCtrl, db, S_OTGlob_fieldsUnit;

type
  TS_OBORTYPEGLOBF = class(TBazeDicF)
    bb_Params: TBitBtn;
    procedure bb_ParamsClick(Sender: TObject);
  private
    { Private declarations }
    F_OldAfterScroll : TDataSetNotifyEvent;
    procedure NewAfterScrool(DataSet: TDataSet);
  public
    { Public declarations }
    constructor CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);override;
    destructor Destroy;override;
    procedure Translate;override;
  end;

var
  S_OBORTYPEGLOBF: TS_OBORTYPEGLOBF;

implementation

uses datam, avartype,frmLANG,cntsLANG;

{$R *.dfm}

constructor TS_OBORTYPEGLOBF.CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);
var
 fdl :TStringList;
begin
  dm1.s_obortypeglob_q.SQL.Text :=
   ' SELECT s.id, s.Name_r,  s.del'+
   ' FROM s_obortypeglob s '+
   ' WHERE s.id > 0 '+
   ' ORDER BY s.Name_r ';

 inherited CreateDic(AOwner, TbName,KeyFd, DSur);
{ NewIDStorProcName:='NEWID_S_REVS';
 Table_Name:='S_REVS';}
 fdl:=TStringList.Create;
 fdl.Add('Name_r');
 ListFindFields:=fdl;
 CurFindField:='Name_r';
 fdl.Free;
 SetLength(NotEmptyFields, 1);
 NotEmptyFields[0]:='Name_r';
 SetLength(UniqFields, 1);
 UniqFields[0]:='Name_r';

 F_OldAfterScroll := CurDataSet.AfterScroll;
 CurDataSet.AfterScroll := NewAfterScrool;

end;

//*******************************************************************
destructor TS_OBORTYPEGLOBF.Destroy;
begin
 inherited;
 CurDataSet.AfterScroll := F_OldAfterScroll;

 S_OBORTYPEGLOBF:=nil;
end;

procedure TS_OBORTYPEGLOBF.Translate;
begin
  inherited;
//   Caption:='Справочник обобщённых типов оборудования';
  Caption:=TrLangMSG(msgSpravochOne)+' '+ansilowercase(TrLangMSG(msgCommonTypEquip));
  DataGrid_dgr.Columns[0].Title.Caption:=TrLangMSG(msgDesign);
  bb_Params.Caption:=TrLangMSG(msgParams);
end;


procedure TS_OBORTYPEGLOBF.bb_ParamsClick(Sender: TObject);
//var _S_OTGlob_fieldsF : TS_OTGlob_fieldsF;
begin
  inherited;
// Справочник ПАРАМЕТРОВ (ПОЛЕЙ) Обобщённых типов оборудования
   Screen.Cursor:=crHourGlass;
   if not assigned(S_OTGlob_fieldsF) then
     S_OTGlob_fieldsF:=TS_OTGlob_fieldsF.CreateDic(application,'S_OTGlob_fields','ID', DM1.S_OTGlob_fields_sur);
   Screen.Cursor:=crDefault;
//   S_OTGlob_fieldsF.Caption := 'Параметры ' + dm1.s_object_q.FieldByName('name_r').AsString;
   ShowDicForm(TForm(S_OTGlob_fieldsF));

end;

procedure TS_OBORTYPEGLOBF.NewAfterScrool(DataSet: TDataSet);
begin
  //
   if assigned(S_OTGlob_fieldsF) then
     S_OTGlob_fieldsF.ChangeOTG;
end;
end.
