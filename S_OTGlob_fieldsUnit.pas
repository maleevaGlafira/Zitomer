unit S_OTGlob_fieldsUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, baze_dic, Placemnt, Menus, StdCtrls, DBCtrls, ExtCtrls, Buttons,
  Grids, DBGrids, RXDBCtrl, db, RxLookup;

type
  TS_OTGlob_fieldsF = class(TBazeDicF)
    Label1: TLabel;
    dbl_OborTypeGlob: TRxDBLookupCombo;
    procedure dbl_OborTypeGlobChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    OldBeforePost: TDataSetNotifyEvent;
    OldFilter: string;
    procedure NewBeforePost(DataSet: TDataSet);
  public
    { Public declarations }
    constructor CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);override;
    destructor Destroy;override;
    procedure Translate;override;
    procedure ChangeOTG;
  end;

var
  S_OTGlob_fieldsF: TS_OTGlob_fieldsF;

implementation

uses datam,frmLANG,cntsLANG;

{$R *.dfm}

constructor TS_OTGlob_fieldsF.CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);
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
// UniqFields[1]:='id_OTG';

 OldBeforePost := dm1.S_OTGlob_fields_q.BeforePost;
 dm1.S_OTGlob_fields_q.BeforePost := NewBeforePost;
 OldFilter := dm1.S_OTGlob_fields_q.Filter;

end;

//*******************************************************************
destructor TS_OTGlob_fieldsF.Destroy;
begin
  dm1.S_OTGlob_fields_q.BeforePost := OldBeforePost;
  dm1.S_OTGlob_fields_q.Filter := OldFilter;
 inherited;
 S_OTGlob_fieldsF:=nil;
end;

procedure TS_OTGlob_fieldsF.Translate;
begin
  inherited;
  // Caption:='Справочник параметров обобщённых типов оборудования';
  Caption:=TrLangMSG(msgParams)+' '+ dm1.s_obortypeglob_q.FieldByName('name_r').AsString;
  DataGrid_dgr.Columns[0].Title.Caption:=TrLangMSG(msgDesign);
  DataGrid_dgr.Columns[1].Title.Caption:=TrLangMSG(msgODDSIZE);
  label4.Caption:=TrLangMSG(msgSearch);
  label1.Caption:=TrLangMSG(msgCommonTypEquipShort);

//  {'Параметры ' }
end;

procedure TS_OTGlob_fieldsF.dbl_OborTypeGlobChange(Sender: TObject);
begin
  inherited;
  with DM1 do
  begin
    S_OTGlob_fields_q.Filtered:=false;
    S_OTGlob_fields_q.Filter:='ID_OTG=' + s_obortypeglob_q.FieldByName('ID').AsString;
    S_OTGlob_fields_q.Filtered:=true;

    Caption := BazeCaption;
  end;
end;

procedure TS_OTGlob_fieldsF.FormShow(Sender: TObject);
begin
  inherited;
//

  ChangeOTG;

{  dbl_OborTypeGlobChange( nil );
  dbl_OborTypeGlob.DisplayValue := dm1.s_obortypeglob_q.FieldByName('name_r').AsString;
  dbl_OborTypeGlob.Show;}
end;

procedure TS_OTGlob_fieldsF.NewBeforePost(DataSet: TDataSet);
begin
  DataSet.FieldByName( 'ID_OTG' ).AsInteger := dm1.s_obortypeglob_q.FieldByName( 'id' ).AsInteger;
  if Assigned( OldBeforePost ) then OldBeforePost( DataSet );
end;


procedure TS_OTGlob_fieldsF.ChangeOTG;
begin
  dbl_OborTypeGlobChange( nil );
  dbl_OborTypeGlob.DisplayValue := dm1.s_obortypeglob_q.FieldByName('name_r').AsString;
  Translate;
end;

end.
