unit S_BWork;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, baze_dic, Placemnt, Menus, StdCtrls, DBCtrls, ExtCtrls, Buttons,
  Grids, DBGrids, RXDBCtrl, db, ComCtrls, DBGridEh, BworkShiefFrame,frmLANG, cntsLANG;

type
  TS_BWorkF = class(TBazeDicF)
    frame_BworkShief: Tframe_BworkShief;
    procedure FormShow(Sender: TObject);
  private
    F_OldAfterScroll,
    F_OldAfterPost,
    F_OldAfterCancel,
    F_OldAfterInsert: TDataSetNotifyEvent;
    procedure NewAfterScroll(DataSet: TDataSet);
    procedure NewAfterPost(DataSet: TDataSet);
    procedure NewAfterCancel(DataSet: TDataSet);
    procedure NewAfterInsert(DataSet: TDataSet);
    procedure GetCurrentBworkID( var Value: integer );
    procedure InitFrame;
  public
    constructor CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource); override;
    destructor Destroy;override;
    procedure Translate;override;
  end;

var
  S_BWorkF: TS_BWorkF;

implementation

{$R *.dfm}

{ TS_BWorkF }

constructor TS_BWorkF.CreateDic(AOwner: TComponent; TbName, KeyFd: string;
  Dsur: TDataSource);
var
 fdl :TStringList;
begin
 inherited CreateDic(AOwner, TbName,KeyFd, DSur);
 fdl := TStringList.Create;
 try
    fdl.Add( 'Name_r' );
    ListFindFields := fdl;
    CurFindField := 'Name_r';
 finally
    fdl.Free;
 end;
 SetLength(NotEmptyFields, 1);
 NotEmptyFields[0]:='Name_r';
 SetLength(UniqFields, 1);
 UniqFields[0]:='Name_r';
 //
 F_OldAfterScroll := CurDataSet.AfterScroll;
 CurDataSet.AfterScroll := NewAfterScroll;
 F_OldAfterPost := CurDataSet.AfterPost;
 CurDataSet.AfterPost := NewAfterPost;
 F_OldAfterCancel := CurDataSet.AfterCancel;
 CurDataSet.AfterCancel := NewAfterCancel;
 F_OldAfterInsert := CurDataSet.AfterInsert;
 CurDataSet.AfterInsert := NewAfterInsert;
 //
 InitFrame;
end;

destructor TS_BWorkF.Destroy;
begin
  CurDataSet.AfterScroll := F_OldAfterScroll;
  inherited;
  S_BWorkF := nil;
end;

procedure TS_BWorkF.GetCurrentBworkID(var Value: integer);
begin
  if CurDataSet.Active then
    Value := CurDataSet.FieldByName( 'ID' ).AsInteger;
end;

procedure TS_BWorkF.InitFrame;
begin
  frame_BworkShief.GetCurrentBworkID := GetCurrentBworkID;
  frame_BworkShief.IsReadOnly := Read_Only;
end;

procedure TS_BWorkF.NewAfterScroll(DataSet: TDataSet);
begin
  if Assigned( F_OldAfterScroll ) then
    F_OldAfterScroll( DataSet );

  if Visible then
    frame_BworkShief.CurrentBworkID := CurDataSet.FieldByName( 'ID' ).AsInteger;
end;

procedure TS_BWorkF.Translate;
begin
  inherited;
  //
  Caption:=TrLangMSG(msgSpravochOne)+' '+TrLangMSG(msgBWork);
  DataGrid_dgr.Columns[0].Title.Caption:=TrLangMSG(msgDesign);
  frame_BworkShief.Translate();



end;

procedure TS_BWorkF.FormShow(Sender: TObject);
begin
  inherited;
  frame_BworkShief.CurrentBworkID := CurDataSet.FieldByName( 'ID' ).AsInteger;
end;

procedure TS_BWorkF.NewAfterPost(DataSet: TDataSet);
begin
  if Assigned( F_OldAfterPost ) then
    F_OldAfterPost( DataSet );

  if Visible then
    frame_BworkShief.EnableBtns( true );
end;

procedure TS_BWorkF.NewAfterCancel(DataSet: TDataSet);
begin
  if Assigned( F_OldAfterCancel ) then
    F_OldAfterCancel( DataSet );

  if Visible then
    frame_BworkShief.EnableBtns( true );
end;

procedure TS_BWorkF.NewAfterInsert(DataSet: TDataSet);
begin
  if Assigned( F_OldAfterInsert ) then
    F_OldAfterInsert( DataSet );

  if Visible then
    frame_BworkShief.EnableBtns( false );
end;

end.
