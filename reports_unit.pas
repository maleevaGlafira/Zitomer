unit reports_unit;

interface

uses
  SysUtils, Classes, FR_Class,Report_Act_Unit,Report_ActRask_Unit
  ,Report_Zayav_Unit, FR_DSet,
  FR_DBSet;

const
  ALL_REP_DIR_NAME='all_reports';

type
  TRepType=(trtNull,trtAct,trtZayav,trtActRask, trtZavObj);
  
  TDM_Reports = class(TDataModule)
    frReportAll: TfrReport;
    frDBDataSet1: TfrDBDataSet;
    frUserDataset1: TfrUserDataset;
    frUserDataset2: TfrUserDataset;
    frUserDataset3: TfrUserDataset;
    frDBDataSet2: TfrDBDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FRepName:string;
    FAllRepDir:string;
    FActRep:TActRep;
    FActRaskRep:TActRaskRep;    FRepType:TRepType;
    FZayavRep:TZayavRep;
  public
    constructor Create(AOwner:TComponent; _RepType:TRepType); overload;
    { Public declarations }
    property ActRep:TActRep read FActRep;
    property ActRaskRep:TActRaskRep read FActRaskRep;
    property ZayavRep:TZayavRep read FZayavRep;
    property RepType:TRepType read FRepType;
  end;

var
  DM_Reports: TDM_Reports;

implementation

uses DM_VedomPublicUnit, NGRaskopDM;

{$R *.dfm}

constructor TDM_Reports.Create(AOwner:TComponent; _RepType:TRepType);
begin
  FAllRepDir:=ExtractFilePath(ParamStr(0))+ALL_REP_DIR_NAME+'\';
  if not DirectoryExists(FAllRepDir) then
    begin
      CreateDir(FAllRepDir);
    end;
  //
  FRepType:=_RepType;
  //
  inherited Create(AOwner);
end;

procedure TDM_Reports.DataModuleCreate(Sender: TObject);
begin
  frDBDataSet1.DataSet:=nil;
  case FRepType of
    trtAct:
      begin
        FRepName:='act';
        frReportAll.OnGetValue:=nil;
        frDBDataSet1.DataSet:=nil;
        FActRep:=TActRep.Create(frReportAll,FAllRepDir+FRepName+'.frf');
      end;
    trtZayav:
      begin
        FRepName:='zayav_2';
        frReportAll.OnGetValue:=nil;
      
        frDBDataSet1.DataSet:=DM_VedomPublic.Qry_Zadv;
        FZayavRep:=TZayavRep.Create(frReportAll,FAllRepDir+FRepName+'.frf');
        frUserDataset1.RangeEnd:=recount;
        frUserDataset1.RangeEndCount:=10;
        frUserDataset1.OnFirst:=FZayavRep.OnFirst_FirstViezdZadv;
        frUserDataset1.OnNext:=FZayavRep.OnNext_FirstViezdZadv;

        frUserDataset2.RangeEnd:=reCount;
        frUserDataset2.RangeEndCount:=5;
        frUserDataset2.OnFirst:=FZayavRep.OnFirst_NotFirstViezdZadv;
        frUserDataset2.OnNext:=FZayavRep.OnNext_NotFirstViezdZadv;


        frDBDataSet2.RangeEnd:=reCount;
        frDBDataSet2.OnFirst:=FZayavRep.OnFirst_Nar;
        frDBDataSet2.OnNext:=FZayavRep.OnNext_Nar;
        frDBDataSet2.RangeEndCount:=99;
        frDBDataSet2.DataSet:=DM_VedomPublic.Qry_narad;

        {frUserDataset3.RangeEnd:=reCount;
        frUserDataset3.OnFirst:=FZayavRep.OnFirst_Nar;
        frUserDataset3.OnNext:=FZayavRep.OnNext_Nar;  }



      end;
    trtActRask:
      begin
        FRepName:='actrask';
        frReportAll.OnGetValue:=nil;
        frDBDataSet1.DataSet:=nil;
        FActRaskRep:=TActRaskRep.Create(frReportAll,FAllRepDir+FRepName+'.frf');
      end;
    trtZavObj:
      begin
        FRepName:='zayavobj';
        frReportAll.OnGetValue:=nil;
        frDBDataSet1.DataSet:=DM_VedomPublic.Qry_Zadv;
        FZayavRep:=TZayavRep.Create(frReportAll,FAllRepDir+FRepName+'.frf');
        FZayavRep.isObj := true;

        frUserDataset1.RangeEnd:=reCount;
        frUserDataset1.RangeEndCount:=7;
        frUserDataset1.OnFirst:=FZayavRep.OnFirst_Zadv;
        frUserDataset1.OnNext:=FZayavRep.OnNext_Zadv;

       { frUserDataset2.RangeEnd:=reCount;
        frUserDataset2.RangeEndCount:=5;
        frUserDataset2.OnFirst:=FZayavRep.OnFirst_NotFirstViezdZadv;
        frUserDataset2.OnNext:=FZayavRep.OnNext_NotFirstViezdZadv;}
      end;
  end;
  DM_VedomPublic.RepName:=FRepName;
  DM_VedomPublic.frWorkRep:=frReportAll;
  frReportAll.OnExcelClick:=nil;//DM_VedomPublic.ExcelClick;
end;

procedure TDM_Reports.DataModuleDestroy(Sender: TObject);
begin
  if FActRep<>nil then FActRep.Free;
end;

end.
