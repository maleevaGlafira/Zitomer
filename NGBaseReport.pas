unit NGBaseReport;

interface

uses SysUtils, FR_Class, FR_DSet, Forms, Windows, DB, Menus;

const
  REPORT_DIR_NAME='ib_reports';

type
  TNGBaseReport=class
  protected
    F_Name: string;
    F_ReportFileName: string;
    procedure PrintFastReport(fr_rep: TfrReport);
    procedure ShowZav(id_zav: integer);
    procedure ShowZavObj(id_zav: integer; zavformtype: integer );
    procedure ShowFastReport(fr_rep: TfrReport);
    function LoadAndPrintFR(fr_rep: TfrReport; prep_name: string; dt: TDateTime; _attribute: integer = -1): boolean;
    procedure SavePreparedReport(_frRep: TfrReport; _PrepRepName: string; _Dt: TDateTime; _attribute: integer = -1);
    procedure LoadPreparedReportList( _PrepRepName: string; _Dt: TDateTime; _attribute: integer = -1; _DS: TDataSet = nil);
    procedure SaveFRToFile(fr_rep: TfrReport; file_name: string);
  protected
    procedure InitFields; virtual;
    procedure CreateForms; virtual;
    procedure DestroyForms; virtual;
    procedure PrepareFastReport; virtual;
  private
    function LoadReportFileTo(var fr_rep: TfrReport): boolean;
  public
    constructor Create;
    destructor Destroy; override;
    function Execute: boolean; virtual;
  end;

implementation

uses BaseFrPreviewForm, FrPreviewForm, zav, OperAttFormUnit, main, FormZavFactory,
  FillReportManager;

constructor TNGBaseReport.Create;
begin
  inherited Create;
  InitFields;
  CreateForms;
end;

procedure TNGBaseReport.CreateForms;
begin
//
end;

destructor TNGBaseReport.Destroy;
begin
  DestroyForms;
  inherited Destroy;;
end;

procedure TNGBaseReport.DestroyForms;
begin
//
end;

function TNGBaseReport.Execute: boolean;
begin
  Result:=false;
end;

procedure TNGBaseReport.InitFields;
begin
//
end;

function TNGBaseReport.LoadAndPrintFR(fr_rep: TfrReport; prep_name: string;
  dt: TDateTime; _attribute: integer = -1): boolean;
var
  _FillRepMgr: Tdm_FillReportManager;
  _FileName: string;
begin
  _FillRepMgr:=Tdm_FillReportManager.Create(nil);
  try
    _FileName:=_FillRepMgr.LoadPreparedRep(prep_name, dt, _attribute);
    if trim(_FileName)<>'' then
    begin
      fr_rep.LoadPreparedReport(_FileName);
      ShowFastReport(fr_rep);
      Result:=true;
    end else Result:=false;
  finally
    _FillRepMgr.Free;
  end;
end;

function TNGBaseReport.LoadReportFileTo(var fr_rep: TfrReport): boolean;
var
  FullReportFileName: string;
begin
  FullReportFileName:=ExtractFilePath(ParamStr(0))+REPORT_DIR_NAME+'\'+F_ReportFileName;

  Result:=fr_rep.LoadFromFile(FullReportFileName);
  if not Result then
    Application.MessageBox(PChar('Не могу загрузить файл '+FullReportFileName),
              'Диспетчер АВР', MB_OK+MB_ICONWARNING);
end;


procedure TNGBaseReport.PrepareFastReport;
begin
//
end;

procedure TNGBaseReport.PrintFastReport(fr_rep: TfrReport);
begin
  if LoadReportFileTo(fr_rep) then
  begin
    PrepareFastReport;
    fr_rep.PrepareReport;
    ShowFastReport(fr_rep);
  end;
end;

procedure TNGBaseReport.SaveFRToFile(fr_rep: TfrReport; file_name: string);
begin
  fr_rep.PrepareReport;
  fr_rep.SavePreparedReport(file_name);
end;

procedure  TNGBaseReport.LoadPreparedReportList( _PrepRepName: string; _Dt: TDateTime; _attribute: integer = -1; _DS: TDataSet = nil);
var _FillRepMgr: Tdm_FillReportManager;
begin
  _FillRepMgr:=Tdm_FillReportManager.Create(nil);
   _FillRepMgr.GetSavesIDList( _PrepRepName, _DT, _attribute, _DS);
end;

procedure TNGBaseReport.SavePreparedReport(_frRep: TfrReport;
  _PrepRepName: string; _Dt: TDateTime; _attribute: integer = -1);
var
  _FillRepMgr: Tdm_FillReportManager;
  _FileName: string;
begin
  _FillRepMgr:=Tdm_FillReportManager.Create(nil);
  try
    _FileName:=_FillRepMgr.TempDir+_PrepRepName+'.frp';
    _frRep.PrepareReport;
    _frRep.SavePreparedReport(_FileName);
    _FillRepMgr.SavePreparedReport(_PrepRepName, _Dt,  _attribute, _FileName);
  finally
    _FillRepMgr.Free;
  end;
end;

procedure TNGBaseReport.ShowFastReport(fr_rep: TfrReport);
begin
//  fr_rep.PrepareReport;
  fr_rep.ShowPreparedReport;
  if Assigned(fr_rep.Preview) and (fr_rep.Preview.Owner is Tfrm_BaseFrPreview) then
    (fr_rep.Preview.Owner as Tfrm_BaseFrPreview).ShowModal;
end;


procedure TNGBaseReport.ShowZav(id_zav: integer);
var
  ZvForm:TFormZav;
begin
  ZvForm:=TFormZav_ZavCreate(nil,tfmZayavAfterInsert,id_zav);
  ZvForm.ShowModal;
  if CloseStatus<>0 then
    repeat
      if CloseStatus=2 then
        ZvForm:=TFormZav_ZavCreate(nil,tfmZayavCopy,ZavToCopy)
      else
        ZvForm:=TFormZav_ZavCreate(nil,tfmZayavNew,0);

      ZvForm.ShowModal;
    until CloseStatus=0;
end;

procedure TNGBaseReport.ShowZavObj(id_zav: integer; zavformtype: integer);
var
  ZvForm:TFormZav;
  _fake_MI: TMenuItem;
begin
  try
   _fake_MI := TMenuItem.Create(nil);
   case zavformtype of
     0:  _fake_MI.tag := 1; // форма с адресом
     1:  _fake_MI.tag := 4; // форма с объектом и сооружением
   end;
  ZvForm:=TFormZav_ZavCreate(_fake_MI,tfmZayavAfterInsert,id_zav);
  ZvForm.ShowModal;
  if CloseStatus<>0 then
    repeat
      if CloseStatus=2 then
        ZvForm:=TFormZav_ZavCreate(_fake_MI,tfmZayavCopy,ZavToCopy)
      else
        ZvForm:=TFormZav_ZavCreate(_fake_MI,tfmZayavNew,0);

      ZvForm.ShowModal;
    until CloseStatus=0;
   finally
      _fake_MI.Free;
   end;
end;

end.
