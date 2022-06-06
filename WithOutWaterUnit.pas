unit WithOutWaterUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FRMLANG, ExtCtrls, Grids, DBGrids, StdCtrls, Buttons, RxLookup,
  Mask, DBCtrls, DBTables, DB;

type
  TWithoutWaterForm = class(TFormLang)
    pnl_Bottom: TPanel;
    dbg_WWater: TDBGrid;
    BB_Insert: TBitBtn;
    bb_edit: TBitBtn;
    bb_post: TBitBtn;
    bb_cancel: TBitBtn;
    bb_delete: TBitBtn;
    bb_exit: TBitBtn;
    qry_wwater: TQuery;
    upd_wwater: TUpdateSQL;
    ds_wwater: TDataSource;
    qry_wwaterid: TIntegerField;
    qry_wwaterid_zav: TIntegerField;
    qry_wwaterid_ul: TIntegerField;
    qry_wwaterhouse: TStringField;
    qry_wwatercomment: TStringField;
    qry_ul: TQuery;
    qry_wwaterloop_ul: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure bb_exitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BB_InsertClick(Sender: TObject);
    procedure bb_editClick(Sender: TObject);
    procedure bb_postClick(Sender: TObject);
    procedure bb_cancelClick(Sender: TObject);
    procedure bb_deleteClick(Sender: TObject);
    procedure qry_wwaterAfterEdit(DataSet: TDataSet);
    procedure qry_wwaterBeforePost(DataSet: TDataSet);
    procedure qry_wwaterAfterInsert(DataSet: TDataSet);
  private
    FReadOnly: boolean;
    FID_zav: integer;
    FIsChanged: boolean;

    procedure IsSaveChange(val: boolean);
  public
    constructor Create(AOwner: TComponent; _ReadOnly: boolean);
    property ID_zav: integer read FID_zav write FID_zav;
  end;


implementation

{$R *.dfm}

{ TWithoutWaterForm }

constructor TWithoutWaterForm.Create(AOwner: TComponent;
  _ReadOnly: boolean);
begin
  FReadOnly:=_ReadOnly;
  FIsChanged:=false;
  inherited Create(AOwner);
end;

procedure TWithoutWaterForm.FormCreate(Sender: TObject);
begin
  if FReadOnly then
  begin
    bb_Insert.Enabled:=false;
    bb_edit.Enabled:=false;
    bb_delete.Enabled:=false;
    dbg_wwater.ReadOnly:=true;
    qry_wwaterloop_ul.ReadOnly:=true;
  end;
end;

procedure TWithoutWaterForm.bb_exitClick(Sender: TObject);
begin
  Close;
end;

procedure TWithoutWaterForm.FormShow(Sender: TObject);
begin
  qry_wwater.Close;
  qry_wwater.ParamByName('pID_zav').AsInteger:=FID_zav;
  qry_wwater.Open;

  qry_ul.Close;
  qry_ul.Open;
end;

procedure TWithoutWaterForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FIsChanged then
    if Application.MessageBox('Изменения не сохранены. Сохранить?',
                  'Диспетчер АВР', MB_YESNO+MB_ICONQUESTION)=IDYES then
    begin
      qry_wwater.ApplyUpdates;
      qry_wwater.CommitUpdates;
    end else
    begin
      qry_wwater.CancelUpdates;
    end;
  qry_wwater.Close;
  qry_ul.Close;
end;

procedure TWithoutWaterForm.BB_InsertClick(Sender: TObject);
begin
  qry_wwater.Insert;
end;

procedure TWithoutWaterForm.bb_editClick(Sender: TObject);
begin
  qry_wwater.Edit;
end;

procedure TWithoutWaterForm.bb_postClick(Sender: TObject);
begin
  qry_wwater.ApplyUpdates;
  qry_wwater.CommitUpdates;
  IsSaveChange(false);
end;

procedure TWithoutWaterForm.bb_cancelClick(Sender: TObject);
begin
  qry_wwater.CancelUpdates;
  IsSaveChange(false);
end;

procedure TWithoutWaterForm.bb_deleteClick(Sender: TObject);
begin
  if Application.MessageBox('Удалить запись?', 'Диспетчер АВР',
                   MB_YESNO+MB_ICONQUESTION)=IDYES then
    qry_wwater.Delete;
end;

procedure TWithoutWaterForm.qry_wwaterAfterEdit(DataSet: TDataSet);
begin
  IsSaveChange(true);
end;

procedure TWithoutWaterForm.qry_wwaterBeforePost(DataSet: TDataSet);
var
  IsOk: boolean;
begin
  IsOk:=false;
  if (qry_wwater.FieldByName('ID_UL').IsNull) or (qry_wwater.FieldByName('ID_UL').AsInteger=-1) then
    Application.MessageBox('Введите наименовние улицы','ДиспетчерАВР',MB_OK+MB_ICONERROR)
  else
  if (qry_wwater.FieldByName('House').IsNull) or (trim(qry_wwater.FieldByName('House').AsString)='') then
    Application.MessageBox('Введите номер дома','ДиспетчерАВР',MB_OK+MB_ICONERROR)
  else
    IsOk:=true;

  if not IsOk then Abort;
end;

procedure TWithoutWaterForm.IsSaveChange(val: boolean);
begin
  FIsChanged:=val;
  bb_post.Enabled:=val;
  bb_cancel.Enabled:=val;
end;

procedure TWithoutWaterForm.qry_wwaterAfterInsert(DataSet: TDataSet);
begin
  qry_wwater.FieldByName('ID_ZAV').AsInteger:=FID_zav;
  IsSaveChange(true);
end;

end.
