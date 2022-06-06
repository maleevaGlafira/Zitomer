unit OborFrameIB;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseGridFrame, DB, IBDatabase, IBCustomDataSet, ExtCtrls, Grids,
  DBGridEh, RxLookup,avartype, StdCtrls, Mask, DBCtrlsEh, IBSQL;

type
  Tframe_Obor = class(Tframe_BaseGrid)
    dset_MainID: TIntegerField;
    dset_MainID_ZAV: TIntegerField;
    dset_MainID_NAR: TIntegerField;
    dset_MainID_OBOR: TIntegerField;
    dset_MainNAME_R: TIBStringField;
    dset_mexan: TIBDataSet;
    dset_mexanNAME_R: TIBStringField;
    dset_mexanFIO: TIBStringField;
    dset_mexanID: TIntegerField;
    dset_mexanDEL: TIBStringField;
    dset_mexanNAME_R_AND_FIO: TIBStringField;
    ds_mexan: TDataSource;
    dbl_mexan: TRxDBLookupCombo;
    Label1: TLabel;
    dset_MainWORK_TIME: TDateTimeField;
    Label2: TLabel;
    tdb_workTime: TDBDateTimeEditEh;
    dset_fromPlan: TIBDataSet;
    IBSQL_fromplan: TIBSQL;
    procedure dset_MainBeforeDelete(DataSet: TDataSet);
  protected
    F_idZav: integer;
    F_idNar: integer;
    procedure OpenMainDset; override;
    procedure OpenVocDset; override;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Append; override;
    procedure Edit; override;
    property idZav: integer read F_idZav write F_idZav;
    property idNar: integer read F_idNar write F_idNar;
    function IsDataFieldsCorrect: boolean;
    function CopyFromPlan:boolean;
  end;

var
  frame_Obor: Tframe_Obor;
  var a:integer;

implementation

{$R *.dfm}
uses HelpFunctions;

procedure  Tframe_Obor.OpenMainDset;
begin
if dset_main.Active then
    dset_main.Close;
  dset_main.ParamByName('idZav').AsInteger:=F_idZav;
  dset_main.ParamByName('idNar').AsInteger:=f_idNar;
  dset_main.Open;
end;

procedure Tframe_Obor.OpenVocDset;
begin
inherited;

  if not dset_mexan.Active then
    dset_mexan.Open;
end;


procedure  Tframe_Obor.Append;
begin
inherited Append;
  dset_main.ParamByName('idZav').AsInteger:=F_idZav;
  dset_main.ParamByName('idNar').AsInteger:=F_idNar;
  dset_main.FieldByName('ID_ZAV').AsInteger:=F_idZav;
  dset_main.FieldByName('id_Nar').AsInteger:=F_idNar;
  dset_main.FieldByName('WORK_TIME').AsDateTime:=Date();

end;

function Tframe_Obor.IsDataFieldsCorrect: boolean;
begin
  Result:=false;

  if IsDBLEmpty(dbl_mexan) then
  begin
    dbl_mexan.SetFocus;
    SetProcessStatus('¬ведите механизмы');
    exit;
  end;

  Result:=true;
end;



procedure Tframe_Obor.dset_MainBeforeDelete(DataSet: TDataSet);

begin
  inherited;
a:=dset_main.FieldByName('id').AsInteger;

end;

procedure Tframe_Obor.Edit;
begin
 inherited;
 if dset_main.FieldByName('work_time').IsNull then
   dset_main.FieldByName('work_time').AsDateTime:=Date();
end;

function Tframe_Obor.CopyFromPlan:boolean;
begin
  Result:=false;
  try
   if dset_main.Active then dset_main.Close;
    IBSQL_fromplan.ParamByName('ID_ZAV').AsInteger:= F_idZav;
    IBSQL_fromplan.ParamByName('ID_Nar').AsInteger:= F_idNar;
    IBSQL_fromplan.ParamByName('data').AsString:= DateTimeToStr(Date());
    IBSQL_fromplan.ExecQuery;
    Tr_Main.CommitRetaining;
    dset_main.Open;
    result:=true;
   except on E:Exception do
      begin
        Tr_Main.RollbackRetaining;
        dset_Main.Close;
        dset_Main.Open;
        Application.MessageBox(PChar(E.Message), '', MB_OK+MB_ICONERROR);
        result:=false;
   end;
   end;

end;

end.
