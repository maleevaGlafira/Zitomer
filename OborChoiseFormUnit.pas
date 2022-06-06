unit OborChoiseFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, datam, IBDatabase, DB, IBCustomDataSet,
  IBQuery, RxLookup, DBCtrls, DMMain;

type
  TOborChoiseForm = class(TForm)
    p_Bottom: TPanel;
    p_Main: TPanel;
    bt_OK: TButton;
    bt_Cancel: TButton;
    rb_AllZavWork: TRadioButton;
    rb_OborWork: TRadioButton;
    tran: TIBTransaction;
    dset: TIBQuery;
    ds_LookupObor: TDataSource;
    DBL_ObjObor: TRxDBLookupCombo;
    procedure bt_OKClick(Sender: TObject);
    procedure rb_AllZavWorkClick(Sender: TObject);
    procedure rb_OborWorkClick(Sender: TObject);
  private
    { Private declarations }
    F_IDZAV: integer;
    F_IdObjObor: integer;
    F_WithObor: boolean;
    F_OborName: string;
    procedure GetObjObors;
  public
    { Public declarations }
    property OborName: string read F_OborName;
    property IDZAV: integer write F_IDZAV;
    property IdObjObor: integer read F_IdObjObor;
    property WithObor: boolean read F_WithObor;
  end;

var
  OborChoiseForm: TOborChoiseForm;

implementation

{$R *.dfm}

procedure TOborChoiseForm.GetObjObors;
var _SQL : string;
begin
//
  _SQL := 'select oo.id_objobor '+
        ' ,(select name_r from s_objobor where id = oo.id_objobor ) name_r '+
        ' from objoborzav oo '+
        ' where oo.id_zav = ' + inttostr(F_IDZAV) +
        ' order by 2 ';

  if dset.Active then dset.Close;
  dset.SQL.Text := _SQL;
  dset.Open;


end;


procedure TOborChoiseForm.bt_OKClick(Sender: TObject);
begin
 //
 F_OborName := 'для наряда';
 F_WithObor := rb_OborWork.Checked;
  if F_WithObor then
      begin
        F_IdObjObor := dset.FieldByName('id_objobor').AsInteger;
        F_OborName := 'для оборудования: '+dset.FieldByName('name_r').AsString;
      end
      else F_IdObjObor := -1;
  dset.Close;
end;

procedure TOborChoiseForm.rb_AllZavWorkClick(Sender: TObject);
begin
   dset.Close;
end;

procedure TOborChoiseForm.rb_OborWorkClick(Sender: TObject);
begin
   if rb_OborWork.Checked then GetObjObors;
end;

end.
