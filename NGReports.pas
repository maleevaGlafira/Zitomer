unit NGReports;

interface

uses Classes, Controls, NGBaseReport, FR_Class, Aligrid, DB, Graphics, SysUtils,
     FR_DSet, AnalysisViewForm, WithoutWaterOptForm, WWaterDModule, Variants,
     SvodVed2DModule, SvodVed3DModule, SvodVed2OptForm, SvodVed3OptForm, SearchAdresOptForm, SearchAdresDModule,
     UtechkiZaPeriodOptForm, UtechkiZaPeriodDModule, SvodVed2AlienDModule,
     SvodVed2AlienOptForm, OptEkonomPokazForm, RepEkonomPokazDM,
     OptTrudoZatrat, RepTrudoZatratDModule, OptMatUseForm, RepMatUseDM, RepOtlDMUnit,
     SvodkaSESOptForm, SvodkaSESDModule, GridViewBuilder, Forms, Windows, FrPreviewForm,
     svodPlanVorksDM,SvodPlanWorksOpt,DateUtils,  DiskonOptForm,DiskondRepDModule,
     SvodVedOtlNar,OpenDisconShiftDModule;

type
  TWWater=class(TNGBaseReport)
  private
    F_OptFrm: Tfrm_WithoutWaterOpt;
    F_ResFrm: Tfrm_AnalysisView;
    F_DM: Tdm_wwater;
    F_TekDate: TDateTime;
    procedure PrepareResultFormHeader;
    procedure PrepareResultFormBtns;
    procedure PrepareResultFormGrid;
    procedure OnZavTypeShow(DataSet: TDataSet;
        AggregateValueArr: array of double; var OutRow: TStringList);
    procedure OnDateFieldShow(ShowValue: variant; var Res: string);
    procedure ZavBtnClick(Sender: TObject);
    procedure PrintBtnClick(Sender: TObject);
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure DestroyForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;

  TSvodVed2=class(TNGBaseReport)
  private
    F_OptFrm: Tfrm_SvodVed2Opt;
    F_ResFrm: Tfrm_AnalysisView;
    F_DM: Tdm_SvodVed2;
    procedure PrepareResultFormGrid;
    procedure PrepareResultFormBtns;
    procedure PrepareResultFormHeader;
    procedure ZavBtnClick(Sender: TObject);
    procedure PrintBtnClick(Sender: TObject);
    procedure OnZavTypeShow(DataSet: TDataSet;
        AggregateValueArr: array of double; var OutRow: TStringList);
    procedure OnAttachShow(DataSet: TDataSet;
        AggregateValueArr: array of double; var OutRow: TStringList);
    procedure OnMainFooterShow(DataSet: TDataSet;
        AggregateValueArr: array of double; var OutRow: TStringList);
    procedure OnRevsShow(DataSet: TDataSet;
        AggregateValueArr: array of double; var OutRow: TStringList);
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure DestroyForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;

  TSvodVed21=class(TSvodVed2)
  protected
    procedure InitFields; override;
    procedure CreateForms; override;

  end;

  TSvodVed3=class(TSvodVed2)
  private
    F_OptFrm: Tfrm_SvodVed3Opt;
    F_ResFrm: Tfrm_AnalysisView;
    F_DM: Tdm_SvodVed3;
    procedure PrepareResultFormGrid;
    procedure PrepareResultFormBtns;
    procedure PrepareResultFormHeader;
    procedure ZavBtnClick(Sender: TObject);
    procedure PrintBtnClick(Sender: TObject);
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;

  TSvodVed2Alien=class(TSvodVed2)
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
  end;

  TOtlRep=class(TNGBaseReport)
  private
    F_DM: Tdm_OtlReport;
    F_OptFrm: Tfrm_SvodVedOtlNar;
    F_ResFrm: Tfrm_AnalysisView;
    F_DocherFrm: Tfrm_AnalysisView; //ПОКАЗЫВАЕТ СВЯЗЯНЫЕ С ОТОЛОДЕННОЙ ЗАЯВКИ
   
    procedure PrepareResultFormBtns;
    procedure PrepareResultFormGrid;
    procedure PrepareResultFormHeader;
    procedure PrintBtnClick(Sender: TObject);
    procedure ZavBtnClick(Sender: TObject);
    procedure PrepareDocherFormGrid;
    procedure PrepareDocherFormBtns;
    procedure OnDocherFormOrderClick(Sender: TObject);
    procedure OnExel(Sender: TObject);
    procedure OnDochPrintClick(Sender: TObject);
    procedure OnAttachShow(DataSet: TDataSet;
               AggregateValueArr: array of double; var OutRow: TStringList);
    procedure OnMainFooterShow(DataSet: TDataSet;
               AggregateValueArr: array of double; var OutRow: TStringList);
    procedure onGroupPrepareDoch(Sender: TObject);
    procedure OnGroupHeaderShow(DataSet: TDataSet;
        AggregateValueArr: array of double; var OutRow: TStringList);
    procedure mainGridFixedColClick(Sender: TObject;  col: Integer);
    procedure GridShowHintCell(Sender: TObject; col,
              row: Integer; var HintStr: String; var CanShow: Boolean;
              var HintInfo: THintInfo);
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
    procedure DestroyForms; override;
  public
    function Execute: boolean; override;
  end;


  TSearchAdres=class(TNGBaseReport)
  private
    F_OptFrm: Tfrm_SearchAdresOpt;
    F_DM: Tdm_SearchAdres;
    F_ResFrm: Tfrm_AnalysisView;
    F_DocherFrm: Tfrm_AnalysisView;
    F_PreviewFrm:Tfrm_FrPreview;
    XlApp:variant;
    procedure PrepareResultFormHeader;
    procedure PrepareResultFormGrid;
    procedure PrepareResultFormBtns;
    procedure OnPrintClick(Sender: TObject);
    procedure OnOrderClick(Sender: TObject);
 private
    procedure OnDiamCellShow(ShowValue: variant; var Res: string);
    procedure PrepareDocherFormGrid;
    procedure PrepareDocherFormBtns;
    procedure OnDocherFormOrderClick(Sender: TObject);
    procedure OnExel(Sender: TObject);
    procedure OnDochPrintClick(Sender: TObject);
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure DestroyForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;

  TUtechkiZaPeriod=class(TNGBaseReport)
  private
    F_OptFrm: Tfrm_UtechkiZaPeriodOpt;
    F_DM: Tdm_UtechkiZaPeriod;
    F_ResFrm: Tfrm_AnalysisView;
    procedure PrepareResultFormHeader;
    procedure PrepareResultFormGrid;
    procedure PrepareResultFormBtns;
    procedure OnShowColumnDataCell(ShowValue: variant; var Res: string);
    procedure OnShowRevsHeader(DataSet: TDataSet;
            AggregateValueArr: array of double; var OutRow: TStringList);
    procedure OnShowMainGrFooter(DataSet: TDataSet;
            AggregateValueArr: array of double; var OutRow: TStringList);
    procedure OnZavBtnClick(Sender: TObject);
    procedure OnPrintBtnClick(Sender: TObject);
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure DestroyForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;

  TEkonomPokaz=class(TNGBaseReport)
  private
    F_OptFrm: Tfrm_OptEkonomPokaz;
    F_DM: Tdm_RepEkonomPokaz;
    procedure SetZavID(const Value: integer);
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure DestroyForms; override;
    procedure PrepareFastReport; override;
  public
    property ZavID: integer write SetZavID;
    function Execute: boolean; override;
  end;

  TTrudoZatrat=class(TNGBaseReport)
  private
    F_OptFrm: Tfrm_OptTrudoZatrat;
    F_DM: Tdm_RepTrudoZatrat;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure DestroyForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;


  TMatUse=class(TNGBaseReport)
  private
    F_OptFrm: Tfrm_OptMatUse;
    F_DM: Tdm_RepMatUse;
    F_PreviewFrm: Tfrm_FrPreview;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure DestroyForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;

  TSvodkaSES=class(TNGBaseReport)
  private
    F_PreparedReportName: string;
    F_IsDisp: boolean;
    F_OptFrm: Tfrm_SvodkaSESOpt;
    F_DM: Tdm_SvodkaSES;
    F_ResFrm: Tfrm_AnalysisView;
    F_GVB: TGridViewBuilder;
    F_IsRecreate: boolean;
    procedure ZavBtnClick(Sender: TObject);
    procedure PrintBtnClick(Sender: TObject);
    procedure OnShowDiamDataCell(ShowValue: variant; var Res: string);
    procedure PrepareResFrmGrid;
    procedure PrepareResFrmHeader;
    procedure PrepareResFrmBtns;
    procedure OnGroupHeaderShow(DataSet: TDataSet;
        AggregateValueArr: array of double; var OutRow: TStringList);
    function GetPrepRepAttribute: integer;
    procedure OnGetListOfSaves;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure DestroyForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;

  TSvodPlanWorks = class(TNGBaseReport)
  private
    F_OptFrm: Tfrm_SvodPlanWorkOpt;
    F_DM: Tdm_SvodPlanWorks;
    F_PreviewFrm: Tfrm_FrPreview;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure DestroyForms; override;
    procedure PrepareFastReport; override;
  public
   function Execute:boolean;override;
  end;


 TDiskonSvod = class(TNGBaseReport)
 private

    f_dt_begin,F_dt_end:TDateTime;
    F_typ:integer;
   F_OptFrm: Tfrm_DiskonOpt;
   F_PreviewFrm: Tfrm_FrPreview;
    F_DM: Tdm_DiskondRep;

 protected
   procedure InitFields; override;
   procedure CreateForms; override;
   procedure DestroyForms; override;
   procedure PrepareFastReport; override;
 public
   function Execute:boolean; override;
 end;

 TOpenDisconShift = class(TNgBaseReport)
 private
    F_ResFrm: Tfrm_AnalysisView;
    F_DM: Tdm_RepOpenDisconShift;
    F_GVB: TGridViewBuilder;
  procedure ZavBtnClick(Sender: TObject);
 protected

   procedure CreateForms; override;
   procedure DestroyForms; override;
   procedure PrepareResFrmGrid;
   procedure PrepareResFrmHeader;
   procedure PrepareResFrmBtns;
   procedure OnGroupHeaderShow(DataSet: TDataSet;
        AggregateValueArr: array of double; var OutRow: TStringList);
    procedure InitFields; override;

  public
   function Execute:boolean; override;
  end;



implementation

uses WaitProcessForm, ServiceFuncUnit, OperAttFormUnit, cntsLANG,frmLANG, ComObj, XLConst,
Types;

{ TWWater }

procedure TWWater.CreateForms;
begin
  F_OptFrm:=Tfrm_WithoutWaterOpt.Create(nil, F_Name);
  F_ResFrm:=Tfrm_AnalysisView.Create(nil, F_Name);
  F_DM:=Tdm_wwater.Create(nil);
end;

procedure TWWater.DestroyForms;
begin
  F_OptFrm.Free;
  F_ResFrm.Free;
  F_DM.Free;
end;

function TWWater.Execute: boolean;
var
  WaitFrm: Tfrm_WaitProcess;
begin
  Result:=false;
  if F_OptFrm.ShowModal<>mrOk then exit;

  WaitFrm:=Tfrm_WaitProcess.Create(nil);
  try
    WaitFrm.Show;

    F_DM.dt_beg:=F_OptFrm.dp_Date1.Date;
    F_DM.dt_end:=F_OptFrm.dp_Date2.Date;
    F_DM.OperAtt:=F_OptFrm.OperateAttach;
    F_DM.PrepareDsets;

    PrepareResultFormHeader;
    PrepareResultFormBtns;
    PrepareResultFormGrid;

  finally
    WaitFrm.Close;
    WaitFrm.Free;
  end;

  F_ResFrm.ShowModal;

  Result:=true;
end;

procedure TWWater.InitFields;
begin
  F_Name:='Ведомость абонентов без воды';
  F_ReportFileName:='wwater.frf';
  F_TekDate:=Now;  
end;

procedure TWWater.OnDateFieldShow(ShowValue: variant; var Res: string);
begin
  try
    if VarType(ShowValue)<>varNull then
      if (TDateTime(ShowValue)=0) then Res:='';
  except
  end;
end;

procedure TWWater.OnZavTypeShow(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
var
  i: integer;
  s: string;
begin
  for i:=1 to 6 do OutRow.Add('');
  if DataSet.FieldByName('zav_type').AsInteger=1 then
    s:='ОТКРЫТЫЕ НАРЯДЫ' else
  if DataSet.FieldByName('zav_type').AsInteger=2 then
    s:='ЗАКРЫТЫЕ НАРЯДЫ';
  s:=s+' (всего:'+FloatToStr(AggregateValueArr[0])+')';
  OutRow.Add(s);
end;

procedure TWWater.PrepareFastReport;
begin
  case F_OptFrm.OperateAttach of
    toaVoda: frVariables['Attach']:='ВОДОПРОВОД';
    toaKanal: frVariables['Attach']:='КАНАЛИЗАЦИЯ';
    toaVRK: frVariables['Attach']:='ЗАЯВКИ ВРК';
  end;

  frVariables['dt_beg']:=DateToStr(F_OptFrm.dp_Date1.Date);
  frVariables['dt_end']:=DateToStr(F_OptFrm.dp_Date2.Date);
  frVariables['dt_tek']:=DateTimeToStr(F_TekDate);
end;

procedure TWWater.PrepareResultFormBtns;
begin
  F_ResFrm.btn_Order.OnClick:=ZavBtnClick;
  F_ResFrm.btn_Print.OnClick:=PrintBtnClick;
end;

procedure TWWater.PrepareResultFormGrid;
var
  gvb: TGridViewBuilder;
  col: TGBColumn;
  group: TGroup;
begin
  gvb:=TGridViewBuilder.Create(F_DM.md_main, F_DM.qry_Detail, F_ResFrm.Grid);
  try
    AddColToGVB(gvb, 'dt_in', 'Дата'+#13+'поступления', alCenter);
    AddColToGVB(gvb, 'dt_out', 'Дата'+#13+'закрытия', alCenter, OnDateFieldShow);
    AddColToGVB(gvb, 'nomer', 'Номер'+#13+' наряда', alCenter);
    AddColToGVB(gvb, 'wwater_time', 'Время'+#13+'без воды', alCenter);
    AddColToGVB(gvb, 'adres', 'Адрес наряда  ');
    AddColToGVB(gvb, 'sod', 'Характер'+#13+'повреждения');

    col:=AddColToGVB(gvb, 'ww_adres', 'Абоненты без воды');
    col.ColumnType:=ctDetail;

    col:=AddColToGVB(gvb, 'comment', 'Коментарий');
    col.ColumnType:=ctDetail;

    group:=gvb.AddGroup('MainGr');
    group.IsNumberRecordInGroup:=true;
    group.GroupHeader.Visible:=false;
    group.GroupFooter.Visible:=false;

    group:=gvb.AddGroup('zav_type');
    group.IsNumberRecordInGroup:=true;
    group.GroupHeader.Visible:=true;
    group.GroupHeader.Alignment:=alCenter;
    group.GroupHeader.Font.Style:=[fsBold];
    group.GroupHeader.Color:=clAqua;
    group.GroupHeader.OnShowCaption:=OnZavTypeShow;
    group.GroupFooter.Visible:=false;
    group.AddAggregateField(atCount, 'id');

    gvb.IDFieldName:='id';

    gvb.BuildGridView;
  finally
    gvb.Free;
  end;
end;

procedure TWWater.PrepareResultFormHeader;
begin
  F_ResFrm.CenterLabel:='Ведомость абонентов без воды'+#13+
        'за период с '+DateToStr(F_OptFrm.dp_Date1.Date)+' по '+
        DateToStr(F_OptFrm.dp_Date2.Date)+
        ' на '+DateTimeToStr(F_TekDate);
end;

procedure TWWater.PrintBtnClick(Sender: TObject);
begin
  PrintFastReport(F_DM.frReport1);
end;

procedure TWWater.ZavBtnClick(Sender: TObject);
begin
  with F_ResFrm do
    if Assigned(Grid.Objects[0,Grid.Row]) then
      ShowZav(integer(Grid.Objects[0,Grid.Row]));
end;
{TSvodVed21}
procedure TSvodVed21.CreateForms;
begin
  F_OptFrm:=Tfrm_SvodVed2Opt.Create(nil, F_Name);
  F_ResFrm:=Tfrm_AnalysisView.Create(nil, F_Name);
  F_DM:=Tdm_SvodVed2.Create(nil);
  F_DM.GroupByState := false;
end;

procedure TSvodVed21.InitFields;
begin
  F_Name:=TrLangMSG(msgSConsolidStateTitle);//'Сводная ведомость ';
  F_ReportFileName:='SvodVed21.frf';
end;


{/TSvodVed21}


{ TSvodVed2 }

procedure TSvodVed2.CreateForms;
begin
  F_OptFrm:=Tfrm_SvodVed2Opt.Create(nil, F_Name);
  F_ResFrm:=Tfrm_AnalysisView.Create(nil, F_Name);
  F_DM:=Tdm_SvodVed2.Create(nil);
  F_DM.GroupByState := true;
end;

procedure TSvodVed2.DestroyForms;
begin
  F_OptFrm.Free;
  F_ResFrm.Free;
  F_DM.Free;
end;

function TSvodVed2.Execute: boolean;
var
  WaitFrm: Tfrm_WaitProcess;
begin
  Result:=false;
  if F_OptFrm.ShowModal<>mrOk then exit;

  WaitFrm:=Tfrm_WaitProcess.Create(nil);
  try
    WaitFrm.Show;

    F_DM.dt_smena := F_OptFrm.dp_Date.Date;
    F_DM.tm_smena := F_OptFrm.dp_Time.Time;
    F_DM.RevsID := F_OptFrm.RevsID;
    F_DM.IsVoda := F_OptFrm.chb_Voda.Checked;
    F_DM.IsKanal := F_OptFrm.chb_Kanal.Checked;
    F_DM.IsVrk := F_OptFrm.chb_Vrk.Checked;
    //
    F_DM.IsCloseZavInc := F_OptFrm.chb_Close.Checked;
    F_DM.IsOpenZavInc := F_OptFrm.chb_Open.Checked;
    F_DM.IsViesnenZavInc := F_OptFrm.chb_Viesnen.Checked;
    F_DM.IsLozhZavInc := F_OptFrm.chb_Lozh.Checked;
    //

    f_DM.IsOtl := F_OptFrm.chb_otl.Checked;
    F_DM.PrepareDset;

    PrepareResultFormHeader;
    PrepareResultFormBtns;
    PrepareResultFormGrid;

  finally
    WaitFrm.Close;
    WaitFrm.Free;
  end;

  F_ResFrm.ShowModal;

  Result:=true;
end;

procedure TSvodVed2.InitFields;
begin
  F_Name:='Сводная ведомость №2';
  F_ReportFileName:='SvodVed2.frf';
end;

procedure TSvodVed2.OnAttachShow(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
var
  i: integer;
begin
  for i:=1 to 4 do OutRow.Add('');
  OutRow.Add(trim(DataSet.FieldByName('attach').AsString)+
            ': '+FloatToStr(AggregateValueArr[0]));
end;

procedure TSvodVed2.OnMainFooterShow(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
var
  i: integer;
begin
  for i:=1 to 4 do OutRow.Add('');
  OutRow.Add('ВСЬОГО НАРЯДІВ'+FloatToStr(AggregateValueArr[0]));
end;

procedure TSvodVed2.OnRevsShow(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
var
  i: integer;
begin
  for i:=1 to 4 do OutRow.Add('');
  OutRow.Add(trim(DataSet.FieldByName('revs').AsString)+' участок'); 
end;

procedure TSvodVed2.OnZavTypeShow(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
var
  i: integer;
  s: string;
begin
  for i:=1 to 4 do OutRow.Add('');
  s:=trim(DataSet.FieldByName('zav_type_name').AsString);
  OutRow.Add(s+': '+FloatToStr(AggregateValueArr[0]));
end;

procedure TSvodVed2.PrepareFastReport;
begin
  frVariables[ 'dt_beg' ] := DateToStr(F_OptFrm.dp_Date.Date)+' '+FormatDateTime('hh:mm',F_OptFrm.dp_Time.Time);
  frVariables[ 'dt_end' ] := DateToStr(F_OptFrm.dp_Date.Date+1)+' '+FormatDateTime('hh:mm',F_OptFrm.dp_Time.Time);
  frVariables[ 'revs' ] := F_OptFrm.RevsName;
  frVariables[ 'zavtypes' ] := F_OptFrm.ZavTypeNames;
end;

procedure TSvodVed2.PrepareResultFormBtns;
begin
  F_ResFrm.btn_Order.OnClick:=ZavBtnClick;
  F_ResFrm.btn_Print.OnClick:=PrintBtnClick;
end;

procedure TSvodVed2.PrepareResultFormGrid;
  procedure PrepareGroupBorder(gr_border: TGroupBorder; cl: TColor; ShowEv: TShowGroupBorderCaptionEvent);
  begin
    gr_border.Visible:=true;
    gr_border.Alignment:=alCenter;
    gr_border.Font.Style:=[fsBold];
    gr_border.Color:=cl;
    gr_border.OnShowCaption:=ShowEv;
  end;
var
  gvb: TGridViewBuilder;
  col: TGBColumn;
  group: TGroup;
begin
  gvb := TGridViewBuilder.Create( F_DM.md_res, F_ResFrm.Grid );
  try
    gvb.IDFieldName := 'id';

    AddColToGVB( gvb, 'nomer', 'Номер'+#13+'наряда', alCenter );
    AddColToGVB( gvb, 'dt_in_str', 'Дата'+#13+'надходження', alCenter );
    AddColToGVB( gvb, 'disp_in', 'Відкрив'+#13+'наряд' );
    AddColToGVB( gvb, 'adres', 'Адреса наряда' );
//    AddColToGVB( gvb, 'sod', 'Характер'+#13+'повреждения' );
    AddColToGVB( gvb, 'vipol', 'Виконано' );
    AddColToGVB( gvb, 'disp_out' ,'Закрив'+#13+'наряд' );
    //AddColToGVB( gvb, 'vrabote', 'В роботі', alCenter );
    AddColToGVB( gvb, 'brigs', 'Бригадири' );

    col := AddColToGVB(gvb, 'primech', 'Додатково' );
    col.DisplayWidth := 50;

    col := AddColToGVB( gvb, 'wwater_list', 'Нема води' );
    col.DisplayWidth := 50;

    group:=gvb.AddGroup('main_gr');
    group.GroupHeader.Visible:=false;
    PrepareGroupBorder(group.GroupFooter, clYellow, OnMainFooterShow);
    group.AddAggregateField(atCount, 'id');


    group:=gvb.AddGroup('id_attach');
    group.IsNumberRecordInGroup:=true;
    group.GroupFooter.Visible:=false;
    PrepareGroupBorder(group.GroupHeader, clAqua, OnAttachShow);
    group.AddAggregateField(atCount, 'id');

    if F_DM.GroupByState then
    begin
      group:=gvb.AddGroup('zav_type_name');
      group.IsNumberRecordInGroup:=true;
      group.GroupFooter.Visible:=false;
      PrepareGroupBorder(group.GroupHeader, clMoneyGreen, OnZavTypeShow);
      group.AddAggregateField(atCount, 'id');
    end;

    group:=gvb.AddGroup('id_revs');
    group.GroupFooter.Visible:=false;
    PrepareGroupBorder(group.GroupHeader, F_ResFrm.Grid.Color, OnRevsShow);

    gvb.BuildGridView;
  finally
    gvb.Free;
  end;
end;

procedure TSvodVed2.PrepareResultFormHeader;
begin
  F_ResFrm.CenterLabel:=
    AnsiUpperCase( F_Name ) + #13 +
    ' за зміну з '+DateTimeToStr(F_OptFrm.dp_Date.Date)+FormatDateTime(' hh:mm',F_OptFrm.dp_Time.Time)+
    ' по '+DateTimeToStr(F_OptFrm.dp_Date.Date+1)+FormatDateTime(' hh:mm',F_OptFrm.dp_Time.Time);
  F_ResFrm.LeftLabel:=
    'Ділянка: '+F_OptFrm.RevsName + #13 +
    'ТИП НАРЯДІВ: ' + F_OptFrm.ZavTypeNames;
end;

procedure TSvodVed2.PrintBtnClick(Sender: TObject);
begin
  PrintFastReport(F_DM.frReport);
end;

procedure TSvodVed2.ZavBtnClick(Sender: TObject);
begin
  with F_ResFrm do
    if Assigned(Grid.Objects[0,Grid.Row]) then
      ShowZav(integer(Grid.Objects[0,Grid.Row]));
end;


{ TSvodVed3 }

procedure TSvodVed3.ZavBtnClick(Sender: TObject);
begin
  with F_ResFrm do
    if Assigned(Grid.Objects[0,Grid.Row]) then
      ShowZavObj(integer(Grid.Objects[0,Grid.Row]), 1);
end;

procedure TSvodVed3.PrepareFastReport;
begin
  frVariables[ 'dt_beg' ] := DateToStr(F_OptFrm.dp_Date.Date-1)+' '+TimeToStr(F_OptFrm.dp_Time.Time);
  frVariables[ 'dt_end' ] := DateToStr(F_OptFrm.dp_Date.Date)+' '+TimeToStr(F_OptFrm.dp_Time.Time);
  frVariables[ 'revs' ] := F_OptFrm.RevsName;
  frVariables[ 'zavtypes' ] := F_OptFrm.ZavTypeNames;
end;

procedure TSvodVed3.InitFields;
begin
  F_Name:='Сводная ведомость №3';
  F_ReportFileName:='SvodVed2.frf';
end;

procedure TSvodVed3.CreateForms;
begin
  F_OptFrm := Tfrm_SvodVed3Opt.Create(nil, F_Name);
  F_ResFrm := Tfrm_AnalysisView.Create(nil, F_Name);

  F_DM := Tdm_SvodVed3.Create(nil);
end;

procedure TSvodVed3.PrepareResultFormGrid;
  procedure PrepareGroupBorder(gr_border: TGroupBorder; cl: TColor; ShowEv: TShowGroupBorderCaptionEvent);
  begin
    gr_border.Visible:=true;
    gr_border.Alignment:=alCenter;
    gr_border.Font.Style:=[fsBold];
    gr_border.Color:=cl;
    gr_border.OnShowCaption:=ShowEv;
  end;
var
  gvb: TGridViewBuilder;
  col: TGBColumn;
  group: TGroup;
begin
  gvb := TGridViewBuilder.Create( F_DM.md_res, F_ResFrm.Grid );
  try
    gvb.IDFieldName := 'id';

    AddColToGVB( gvb, 'nomer', 'Номер'+#13+'НАРЯДА', alCenter );
    AddColToGVB( gvb, 'dt_in', 'Дата'+#13+'поступления', alCenter );
    AddColToGVB( gvb, 'adres', 'Объект, сооружение' );
    AddColToGVB( gvb, 'sod', 'Оборудование' );
    AddColToGVB( gvb, 'vipol', 'Выполнено' );
    AddColToGVB( gvb, 'vrabote', 'В работе', alCenter );

    col := AddColToGVB(gvb, 'primech', 'Примечание' );
    col.DisplayWidth := 50;

    col := AddColToGVB( gvb, 'wwater_list', 'Без воды' );
    col.DisplayWidth := 50;

    group:=gvb.AddGroup('main_gr');
    group.GroupHeader.Visible:=false;
    PrepareGroupBorder(group.GroupFooter, clYellow, OnMainFooterShow);
    group.AddAggregateField(atCount, 'id');


    group:=gvb.AddGroup('id_attach');
    group.IsNumberRecordInGroup:=true;
    group.GroupFooter.Visible:=false;
    PrepareGroupBorder(group.GroupHeader, clAqua, OnAttachShow);
    group.AddAggregateField(atCount, 'id');

    group:=gvb.AddGroup('zav_type_name');
    group.IsNumberRecordInGroup:=true;
    group.GroupFooter.Visible:=false;
    PrepareGroupBorder(group.GroupHeader, clMoneyGreen, OnZavTypeShow);
    group.AddAggregateField(atCount, 'id');

    group:=gvb.AddGroup('id_revs');
    group.GroupFooter.Visible:=false;
    PrepareGroupBorder(group.GroupHeader, F_ResFrm.Grid.Color, OnRevsShow);

    gvb.BuildGridView;
  finally
    gvb.Free;
  end;
end;

procedure TSvodVed3.PrepareResultFormBtns;
begin
  F_ResFrm.btn_Order.OnClick:=ZavBtnClick;
  F_ResFrm.btn_Print.OnClick:=PrintBtnClick;
end;

procedure TSvodVed3.PrepareResultFormHeader;
begin
  F_ResFrm.CenterLabel:=
    AnsiUpperCase( F_Name ) + #13 +
    ' за сутки c '+DateToStr(F_OptFrm.dp_Date.Date-1)+' '+TimeToStr(F_OptFrm.dp_Time.Time)+
    ' по '+DateToStr(F_OptFrm.dp_Date.Date)+' '+TimeToStr(F_OptFrm.dp_Time.Time);
  F_ResFrm.LeftLabel:=
    'УЧАСТОК: '+F_OptFrm.RevsName + #13 +
    'ТИП НАРЯДОВ: ' + F_OptFrm.ZavTypeNames;
end;

procedure TSvodVed3.PrintBtnClick(Sender: TObject);
begin
  PrintFastReport(F_DM.frReport);
end;

function TSvodVed3.Execute: boolean;
var
  WaitFrm: Tfrm_WaitProcess;
begin
  Result:=false;
  if F_OptFrm.ShowModal<>mrOk then exit;

  WaitFrm:=Tfrm_WaitProcess.Create(nil);
  try
    WaitFrm.Show;

    F_DM.dt_smena := F_OptFrm.dp_Date.Date;
    F_DM.tm_smena := F_OptFrm.dp_Time.Time;
    F_DM.RevsID := F_OptFrm.RevsID;
    F_DM.IsVoda := False;
    F_DM.IsKanal := false;
    F_DM.IsVrk := false;
    F_DM.IsObjVoda := F_OptFrm.chb_Voda.Checked;
    F_DM.IsObjKanal := F_OptFrm.chb_Kanal.Checked;
    //
    F_DM.IsCloseZavInc := F_OptFrm.chb_Close.Checked;
    F_DM.IsOpenZavInc := F_OptFrm.chb_Open.Checked;
    F_DM.IsViesnenZavInc := F_OptFrm.chb_Viesnen.Checked;
    F_DM.IsLozhZavInc := F_OptFrm.chb_Lozh.Checked;
    //
    F_DM.PrepareDset;

    PrepareResultFormHeader;
    PrepareResultFormBtns;
    PrepareResultFormGrid;

  finally
    WaitFrm.Close;
    WaitFrm.Free;
  end;

  F_ResFrm.ShowModal;

  Result:=true;
end;



{/ TSvodVed3 }


{ TSearchAdres }

procedure TSearchAdres.CreateForms;
begin
  F_OptFrm:=Tfrm_SearchAdresOpt.Create(nil, F_Name);
  F_DM:=Tdm_SearchAdres.Create(nil);
  F_ResFrm:=Tfrm_AnalysisView.Create(nil, F_Name);

  F_DocherFrm:=Tfrm_AnalysisView.Create(nil, 'Список нарядов');
  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM,  F_DM.frREportDoch);
   F_DM.frREportDoch.Preview:=F_PreviewFrm.frPreview;
end;

procedure TSearchAdres.DestroyForms;
begin
  F_OptFrm.Free;
  F_DM.Free;
  F_ResFrm.Free;
  F_DocherFrm.Free;
  if  XlApp<>Unassigned then
  if XlApp.visible then
  begin
   XlApp.visible:=false;
   XlApp.Quit;
   XlApp:=Unassigned;
  end;
end;

function TSearchAdres.Execute: boolean;
var
  WaitFrm: Tfrm_WaitProcess;
begin
  Result:=false;

  if F_OptFrm.ShowModal<>mrOk then exit;

  WaitFrm:=Tfrm_WaitProcess.Create(nil);
  try
    WaitFrm.Show;

    F_DM.Dt_beg:=F_OptFrm.Dt_beg;
    F_DM.Dt_end:=F_OptFrm.Dt_end;
    F_DM.RevsID:=F_OptFrm.RevsID;
    F_DM.PlaceID:=F_OptFrm.PlaceID;
    F_DM.DiamID:=F_OptFrm.DiamID;
    F_DM.DmgCount:=F_OptFrm.DmgCount;
    F_DM.IsDescSort:=F_OptFrm.IsDescSort;
    F_DM.OperAtt:=F_OptFrm.OperateAttach;

    F_DM.PrepareDset;

    PrepareResultFormHeader;
    PrepareResultFormGrid;
    PrepareResultFormBtns;
  finally
    WaitFrm.Close;
    WaitFrm.Free;
  end;

  F_ResFrm.ShowModal;

  Result:=true;
end;

procedure TSearchAdres.InitFields;
begin
  F_Name:='Поиск адресов больше определенного кол-ва';
  F_ReportFileName:='SearchAdres.frf';
end;

procedure TSearchAdres.OnDiamCellShow(ShowValue: variant; var Res: string);
var
  val: integer;
begin
  try
    val:=integer(ShowValue);
    if val=0 then Res:='';
  except
    Res:='';
  end;
end;

procedure TSearchAdres.OnDocherFormOrderClick(Sender: TObject);
begin
  with F_DocherFrm do
    if Assigned(Grid.Objects[0,Grid.Row]) then
      ShowZav(integer(Grid.Objects[0,Grid.Row]));
end;

procedure TSearchAdres.OnOrderClick(Sender: TObject);
begin
  if not Assigned(F_ResFrm.Grid.Objects[0,F_ResFrm.Grid.Row]) then exit;

  F_DM.PrepareDsetByGroup(integer(F_ResFrm.Grid.Objects[0,F_ResFrm.Grid.Row]));

  PrepareDocherFormGrid;
  PrepareDocherFormBtns;

  F_DocherFrm.Height:=F_ResFrm.Height-30;
  F_DocherFrm.Width:=F_ResFrm.Width-30;
  F_DocherFrm.ShowModal;
end;

procedure TSearchAdres.OnPrintClick(Sender: TObject);
begin
  PrintFastReport(F_DM.frReport);
end;

procedure TSearchAdres.OnDochPrintClick(Sender: TObject);
var oldF_ReportFileName:string;
begin
  oldF_ReportFileName:=F_ReportFileName;
  F_ReportFileName:='SearchAdresDoch.frf';
  frVariables['dt_beg']:=DateToStr(F_OptFrm.Dt_beg);
  frVariables['dt_end']:=DateToStr(F_OptFrm.Dt_end);
  frVariables['address']:= F_ResFrm.Grid.Cells[1,F_ResFrm.Grid.Row];
  PrintFastReport(f_DM.frREportDoch);
  F_PreviewFrm.ShowModal;
  F_ReportFileName:=oldF_ReportFileName ;
end;

procedure TSearchAdres.PrepareDocherFormBtns;
begin
  F_DocherFrm.btn_Order.OnClick:=OnDocherFormOrderClick;
  F_DocherFrm.btn_Print.OnClick:=OnDochPrintClick;
end;

procedure TSearchAdres.PrepareDocherFormGrid;
var
  gvb: TGridViewBuilder;
begin
  gvb:=TGridViewBuilder.Create(F_DM.md_bygroup, F_DocherFrm.Grid);
  try
    gvb.IDFieldName:='id';
    gvb.IsNumberRecord:=true;

    AddColToGVB(gvb, 'dt_in', 'Дата'+#13+'поступления', alCenter);
    AddColToGVB(gvb, 'nomer', 'Номер'+#13+'наряда', alCenter);
    AddColToGVB(gvb, 'revs', 'Участок', alLeft);
    AddColToGVB(gvb, 'adres', 'Адрес', alLeft);
    AddColToGVB(gvb, 'place', 'Место'+#13+'повреждения', alLeft);
    AddColToGVB(gvb, 'diam', 'Диаметр', alCenter, OnDiamCellShow);

    


    gvb.BuildGridView;
  finally
    gvb.Free;
  end;
end;

procedure TSearchAdres.PrepareFastReport;
begin
  frVariables['dt_beg']:=DateToStr(F_OptFrm.Dt_beg);
  frVariables['dt_end']:=DateToStr(F_OptFrm.Dt_end);
  frVariables['revs']:=F_OptFrm.strRevs;
  frVAriables['place']:=F_OptFrm.strPlace;
  frVariables['diam']:=F_OptFrm.strDiam;
  frVariables['dmg_count']:=IntToStr(F_OptFrm.DmgCount);
  frVariables['attach']:=GetAttachName(F_OptFrm.OperateAttach);
end;

procedure TSearchAdres.PrepareResultFormBtns;
begin
  F_ResFrm.btn_Order.OnClick:=OnOrderClick;
  F_ResFrm.btn_Order.Caption:='Список нарядов';

  F_ResFrm.btn_Print.OnClick:=OnPrintClick;
  F_ResFrm.btn_Excel.OnClick:=OnExel;
end;

procedure TSearchAdres.PrepareResultFormGrid;
var
  gvb: TGridViewBuilder;
begin
  gvb:=TGridViewBuilder.Create(F_DM.md_res, F_ResFrm.Grid);
  try
    gvb.IsNumberRecord:=true;
    gvb.IDFieldName:='id_group';

    AddColToGVB(gvb, 'adres', 'Адрес', alLeft);
    AddColToGVB(gvb, 'dmg_count', 'Количество'+#13+' повреждений', alCenter);

    gvb.BuildGridView;
  finally
    gvb.Free;
  end;
end;

procedure TSearchAdres.PrepareResultFormHeader;
begin
  with F_ResFrm do
  begin
    CenterLabel:='Список адресов по которым за'+#13+
                  'период c '+DateToStr(F_OptFrm.Dt_beg)+' по '+DateToStr(F_OptFrm.Dt_end)+#13+
                  'кол-во повреждений превышало '+IntToStr(F_OptFrm.DmgCount)+
                  ' ('+GetAttachName(F_OptFrm.OperateAttach)+')';
    LeftLabel:='Участок: '+F_OptFrm.strRevs+#13+
               'Место повреждения: '+F_OptFrm.strPlace+#13+
               'Диаметр: '+F_OptFrm.strDiam;
  end;
end;

procedure TSearchAdres.OnExel(Sender: TObject);
var XlApp:variant;
     Sheet: Variant;

     i,j:integer;
     WaitFrm :Tfrm_WaitProcess;
     let:char;
//     Range:variant;
begin
//
 WaitFrm:=Tfrm_WaitProcess.Create(nil);
 WaitFrm.show;
TRy
  XlApp:=CreateOleObject('Excel.Application');

  XlApp.Workbooks.Add(xlWBatWorkSheet);
  XlApp.Workbooks[1].WorkSheets[1].Name:='Поиск адресов';
  Sheet:=XlApp.Workbooks[1].WorkSheets[1];

  Sheet.cells[1,1]:='Список адресов по которым за';
 // Sheet.Range['A1:C1'].Select;
  Sheet.Range['A1:C1'].Merge;
  XlApp.Range['A1:C1'].HorizontalAlignment:=xlCenter;
   XlApp.Range['A1:C1'].Font.Bold := True;
  Sheet.cells[2,1]:='период c '+DateToStr(F_OptFrm.Dt_beg)+' по '+DateToStr(F_OptFrm.Dt_end);
//  Sheet.Range['A2:C2'].Select;
  Sheet.Range['A2:C2'].Merge;
  XlApp.Range['A2:C2'].HorizontalAlignment:=xlCenter;
   XlApp.Range['A2:C2'].Font.Bold := True;
  Sheet.cells[3,1]:= 'кол-во повреждений превышало '+IntToStr(F_OptFrm.DmgCount);
 // Sheet.Range['A3:C3'].Select;
  Sheet.Range['A3:C3'].Merge;
  XlApp.Range['A3:C3'].Font.Bold := True;
  XlApp.Range['A3:C3'].HorizontalAlignment:=xlCenter;
 // Sheet.cells[3,1].allign:=xlCenter ;
 { Sheet.cells[1,1].Font.Bold := True;
  Sheet.cells[2,1].Font.Bold := True;
  Sheet.cells[3,1].Font.Bold := True;      }
  Sheet.cells[4,1]:='';

  Sheet.cells[5,1]:='Цех: '+F_OptFrm.strRevs;
  Sheet.cells[6,1]:='Место повреждения: '+F_OptFrm.strPlace;
  Sheet.cells[7,1]:='Диаметр: '+F_OptFrm.strDiam;
 // Sheet.Range['A5:B7'].Select;

 { XlApp.Selection.Borders.LineStyle:=xlSolid;
  XlApp.Selection.Borders.Weight:=2;}

  Sheet.cells[8,1]:='';

  for j:=0 to F_ResFrm.Grid.ColCount-1 do begin
    Sheet.cells[9,j+1]:=F_ResFrm.Grid.Cells[j,0];
    Sheet.cells[9,j+1].HorizontalAlignment:=xlCenter ;
    Sheet.cells[9,j+1].Font.Bold := True;
    Sheet.cells[9,j+1].Borders.LineStyle:=xlContinuous;
    Sheet.cells[9,j+1].Borders.Weight:=4;
    //И включаем перенос по словам:
    Sheet.cells[9,j+1].WrapText:=true;
 end;
   let:=chr(ord('A')+F_ResFrm.Grid.ColCount-1);
   //Sheet.Columns[2].ColumnWidth:=50;
  // Sheet.Columns[1].ColumnWidth:=4;
  //  Sheet.Columns[3].ColumnWidth:=13;

   for i:=1 to F_ResFrm.Grid.RowCount-1 do
    for j:=0 to F_ResFrm.Grid.ColCount-1 do begin
      Sheet.cells[9+i,j+1]:=F_ResFrm.Grid.Cells[j,i];
      Sheet.cells[9+i,j+1].HorizontalAlignment:=1  ;
      Sheet.cells[9+i,j+1].Borders.LineStyle:=xlContinuous;
    /// Sheet.cells[9+i,j+1].WrapText:=true;
    Sheet.cells[9+i,j+1].Borders.Weight:=2;
    end;
   Sheet.Range['A9:'+let+IntToStr(F_ResFrm.Grid.RowCount+9)].Columns.AutoFit ;

  finally
    WaitFrm.Close;
    WaitFrm.free;

  end;
  XLApp.DisplayAlerts := False;
  XlApp.Visible := True;

 ///   XLApp.Quit;
//  XLApp.free;
 // XLApp:=UnAssigned;
end;

{ TUtechkiZaPeriod }

procedure TUtechkiZaPeriod.CreateForms;
begin
  F_OptFrm:=Tfrm_UtechkiZaPeriodOpt.Create(nil, F_Name);
  F_DM:=Tdm_UtechkiZaPeriod.Create(nil);
  F_ResFrm:=Tfrm_AnalysisView.Create(nil, F_Name);
end;

procedure TUtechkiZaPeriod.DestroyForms;
begin
  F_OptFrm.Free;
  F_DM.Free;
  F_ResFrm.Free;
end;

function TUtechkiZaPeriod.Execute: boolean;
var
  WaitFrm: Tfrm_WaitProcess;
begin
  Result:=false;

  if F_OptFrm.ShowModal<>mrOk then exit;

  WaitFrm:=Tfrm_WaitProcess.Create(nil);
  try
    WaitFrm.Show;

    F_DM.Dt_beg:=F_OptFrm.Dt_beg;
    F_DM.Dt_end:=F_OptFrm.Dt_end;
    F_DM.OperAtt:=F_OptFrm.OperateAttach;
    F_DM.PrepareDset;

    PrepareResultFormHeader;
    PrepareResultFormGrid;
    PrepareResultFormBtns;
  finally
    WaitFrm.Close;
    WaitFrm.Free;
  end;

  F_ResFrm.ShowModal;

  Result:=true;
end;

procedure TUtechkiZaPeriod.InitFields;
begin
  F_Name:='Сводка утечек за период';
  F_ReportFileName:='UtechkiZaPeriod.frf';
end;

procedure TUtechkiZaPeriod.OnPrintBtnClick(Sender: TObject);
begin
  PrintFastReport(F_DM.frReport);
end;

procedure TUtechkiZaPeriod.OnShowColumnDataCell(ShowValue: variant;
  var Res: string);
begin
  Res:=FormatFloat('#####0.0#', double(ShowValue));
end;

procedure TUtechkiZaPeriod.OnShowMainGrFooter(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
var
  i: integer;
begin
  for i:=1 to 4 do
    OutRow.Add('');
  OutRow.Add('ВСЕГО: '+FloatToStr(AggregateValueArr[0]));
  for i:=1 to 4 do
    OutRow.Add(FormatFloat('#####0.0#', AggregateValueArr[i]));
end;

procedure TUtechkiZaPeriod.OnShowRevsHeader(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
var
  i: integer;
begin
  for i:=1 to 4 do
    OutRow.Add('');
  OutRow.Add(trim(DataSet.FieldByName('revs').AsString)+
                  ': '+FloatToStr(AggregateValueArr[0]));
  for i:=1 to 4 do
    OutRow.Add(FormatFloat('#####0.0#', AggregateValueArr[i]));
end;

procedure TUtechkiZaPeriod.OnZavBtnClick(Sender: TObject);
begin
  with F_ResFrm do
    if Assigned(Grid.Objects[0,Grid.Row]) then
      ShowZav(integer(Grid.Objects[0,Grid.Row]));
end;

procedure TUtechkiZaPeriod.PrepareFastReport;
begin
  frVariables['DateBegin']:=DateToStr(F_OptFrm.Dt_beg);
  frVariables['DateEnd']:=DateToStr(F_OptFrm.Dt_end);
  frVariables['Attach']:=GetAttachName(F_OptFrm.OperateAttach);
end;

procedure TUtechkiZaPeriod.PrepareResultFormBtns;
begin
  F_ResFrm.btn_Order.OnClick:=OnZavBtnClick;
  F_ResFrm.btn_Print.OnClick:=OnPrintBtnClick;
end;

procedure TUtechkiZaPeriod.PrepareResultFormGrid;
var
  gvb: TGridViewBuilder;
  gr: TGroup;
begin
  gvb:=TGridViewBuilder.Create(F_DM.md_res, F_ResFrm.Grid);
  try
    gvb.IDFieldName:='ID';

    AddColToGVB(gvb, 'dt_in', 'Дата'+#13+'поступления', alCenter);
    AddColToGVB(gvb, 'nomer', 'Номер'+#13+'наряда', alCenter);
    AddColToGVB(gvb, 'adres', 'Адрес');
    AddColToGVB(gvb, 'povrezhd', 'Потери в результате'+#13+'повреждения, м3', alCenter, OnShowColumnDataCell);
    AddColToGVB(gvb, 'oporozhn', 'Потери в результате'+#13+'опорожнения, м3', alCenter, OnShowColumnDataCell);
    AddColToGVB(gvb, 'promyv', 'Потери в результате'+#13+'промывки, м3', alCenter, OnShowColumnDataCell);
    AddColToGVB(gvb, 'sum_poteri', 'Общие потери,'+#13+'м3', alCenter, OnShowColumnDataCell);

    gr:=gvb.AddGroup('main_gr');
    gr.IsNumberRecordInGroup:=true;
    gr.GroupHeader.Visible:=false;
    gr.GroupFooter.Visible:=true;
    gr.GroupFooter.Alignment:=alCenter;
    gr.GroupFooter.Font.Style:=[fsBold];
    gr.GroupFooter.Color:=clMoneyGreen;
    gr.GroupFooter.OnShowCaption:=OnShowMainGrFooter;
    gr.AddAggregateField(atCount, 'id');
    gr.AddAggregateField(atSum, 'povrezhd');
    gr.AddAggregateField(atSum, 'oporozhn');
    gr.AddAggregateField(atSum, 'promyv');
    gr.AddAggregateField(atSum, 'sum_poteri');

    gr:=gvb.AddGroup('id_revs');
    gr.IsNumberRecordInGroup:=true;
    gr.GroupHeader.Visible:=true;
    gr.GroupFooter.Visible:=false;
    gr.GroupHeader.Color:=clAqua;
    gr.GroupHeader.OnShowCaption:=OnShowRevsHeader;
    gr.GroupHeader.Alignment:=alCenter;
    gr.GroupHeader.Font.Style:=[fsBold];
    gr.AddAggregateField(atCount, 'id');
    gr.AddAggregateField(atSum, 'povrezhd');
    gr.AddAggregateField(atSum, 'oporozhn');
    gr.AddAggregateField(atSum, 'promyv');
    gr.AddAggregateField(atSum, 'sum_poteri');

    gvb.BuildGridView;
  finally
    gvb.Free;
  end;
end;

procedure TUtechkiZaPeriod.PrepareResultFormHeader;
begin
  F_ResFrm.CenterLabel:='Сводка утечек за период ('+GetAttachName(F_OptFrm.OperateAttach)+')'+#13+
                        'с '+DateToStr(F_OptFrm.Dt_beg)+' по '+DateToStr(F_OptFrm.Dt_end);
end;

{ TSvodVed2Alien }

procedure TSvodVed2Alien.CreateForms;
begin
  F_OptFrm := Tfrm_SvodVed2AlienOpt.Create(nil, F_Name);
  F_ResFrm := Tfrm_AnalysisView.Create(nil, F_Name);

  F_DM := Tdm_SvodVed2Alien.Create(nil);
end;

procedure TSvodVed2Alien.InitFields;
begin
  F_Name := 'Сводная ведомость №2(чужие)';
  F_ReportFileName := 'SvodVed2Alien.frf';
end;

{ TOtlRep }

procedure TOtlRep.CreateForms;
begin
  F_OptFrm := Tfrm_SvodVedOtlNar.Create(nil, F_Name);
  F_ResFrm := Tfrm_AnalysisView.Create(nil, F_Name);
  F_DM := Tdm_OtlReport.Create(nil);
  F_DocherFrm:= Tfrm_AnalysisView.Create(nil ,F_name);

end;

procedure TOtlRep.DestroyForms;
begin

  F_DocherFrm.Free;
  F_OptFrm.Free;
  F_ResFrm.Free;
  F_DM.Free;
end;

procedure TOtlRep.InitFields;
begin
  F_Name := 'Сводка отложенных';
  F_ReportFileName := 'OtlRep.frf';
end;

procedure TOtlRep.PrepareFastReport;
begin
  frVariables[ 'dt_beg' ] := DateToStr(F_OptFrm.dp_StartDate.Date)+' '+TimeToStr(F_OptFrm.dt_startdate.Time);
  frVariables[ 'dt_end' ] := DateToStr(F_OptFrm.dt_enddate.Date)+' '+TimeToStr(F_OptFrm.dt_enddate.Time);
  frVariables[ 'revs' ] := F_OptFrm.RevsName;
  frVariables[ 'zavtypes' ] := F_OptFrm.ZavTypeNames;
end;

function TOtlRep.Execute: boolean;
var
  WaitFrm: Tfrm_WaitProcess;
begin
  Result:=false;

  //F_OptFrm.btn_ok.Enabled := true;
  //F_OptFrm.Bevel1.Visible := false;
  F_OptFrm.Label1.Caption := ' На ';
  F_OptFrm.dp_Date.Text := FormatDateTime('dd.mm.yyyy', Now);
  F_OptFrm.dp_Time.Time := Time;
  if F_OptFrm.ShowModal<>mrOk then exit;

  WaitFrm:=Tfrm_WaitProcess.Create(nil);
  try
    WaitFrm.Show;

   // F_DM.dt_smena := F_OptFrm.dp_Date.Date;
   // F_DM.tm_smena := F_OptFrm.dp_Time.Time;
   f_dm.dtBegin:= F_OptFrm.dp_StartDate.Date+frac(F_OptFrm.dt_startdate.DateTime);
   f_dm.dtEnd:= F_OptFrm.dp_EndDate.Date+frac(F_OptFrm.dt_enddate.DateTime);

    F_DM.RevsID := F_OptFrm.RevsID;
    F_DM.IsVoda := F_OptFrm.chb_Voda.Checked;
    F_DM.IsKanal := F_OptFrm.chb_Kanal.Checked;
    F_DM.IsVrk := F_OptFrm.chb_Vrk.Checked;
    //
    F_DM.IsCloseZavInc := false; //F_OptFrm.chb_Close.Checked;
    F_DM.IsOpenZavInc := true;// F_OptFrm.chb_Open.Checked;
    F_DM.IsViesnenZavInc := true; //F_OptFrm.chb_Viesnen.Checked;
    F_DM.IsLozhZavInc := true; //F_OptFrm.chb_Lozh.Checked;
    //
    F_dm.typZav:=F_OptFrm.rg_typeZav.ItemIndex;//тип наряда открытый закрытый


    F_DM.PrepareDset;

    PrepareResultFormHeader;
    PrepareResultFormBtns;
    PrepareResultFormGrid;

  finally
    WaitFrm.Close;
    WaitFrm.Free;
  end;

  F_ResFrm.ShowModal;

  Result:=true;
end;

procedure TOtlRep.PrintBtnClick(Sender: TObject);
begin
  PrintFastReport(F_DM.frReport);
end;

procedure TOtlRep.ZavBtnClick(Sender: TObject);
begin
  with F_ResFrm do
    if Assigned(Grid.Objects[0,Grid.Row]) then
      ShowZav(integer(Grid.Objects[0,Grid.Row]));
end;

procedure TOtlRep.OnAttachShow(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
var
  i: integer;
begin
  for i:=1 to 4 do OutRow.Add('');
  OutRow.Add(trim(DataSet.FieldByName('attach').AsString)+
            ': '+FloatToStr(AggregateValueArr[0]));
end;

procedure TOtlRep.OnMainFooterShow(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
var
  i: integer;
begin
  for i:=1 to 4 do OutRow.Add('');
  OutRow.Add('ВСЕГО НАРЯДОВ: '+FloatToStr(AggregateValueArr[0]));
end;



procedure TOtlRep.PrepareResultFormHeader;
begin
  F_ResFrm.CenterLabel:=
    AnsiUpperCase( F_Name ) + #13 +
    ' за период c '+DateToStr(F_OptFrm.dp_StartDate.Date)+' '+TimeToStr(F_OptFrm.dt_startdate.Time)+
    ' по '+DateToStr(F_OptFrm.dp_enddate.Date)+' '+TimeToStr(F_OptFrm.dt_enddate.Time);
  F_ResFrm.LeftLabel:=
    'Участок: '+F_OptFrm.RevsName + #13;
  F_resFrm.lbl_butttom.Visible:=true;
  F_resFrm.lbl_butttom.Left:=F_resFrm.btn_Excel.Left+F_resFrm.btn_Excel.Width+5;
  F_resFrm.lbl_butttom.Width:=F_resFrm.btn_Exit.Left-5-F_resFrm.lbl_butttom.Left;
end;

procedure TOtlRep.PrepareResultFormBtns;
begin
  F_ResFrm.Grid.OnFixedColClick:=mainGridFixedColClick;
  F_ResFrm.btn_Order.OnClick:=onGroupPrepareDoch;
  F_ResFrm.btn_Order.Caption:='Список';
  F_ResFrm.btn_nar2.Visible:=true;
  F_ResFrm.btn_nar2.OnClick:=ZavBtnClick;

  F_ResFrm.btn_Print.OnClick:=PrintBtnClick;
  F_ResFrm.Grid.OnShowHintCell:=GridShowHintCell;

end;

procedure TOtlRep.PrepareResultFormGrid;
  procedure PrepareGroupBorder(gr_border: TGroupBorder; cl: TColor; ShowEv: TShowGroupBorderCaptionEvent);
  begin
    gr_border.Visible:=true;
    gr_border.Alignment:=alCenter;
    gr_border.Font.Style:=[fsBold];
    gr_border.Color:=cl;
    gr_border.OnShowCaption:=ShowEv;
  end;
var
  gvb:TGridViewBuilder;
  col: TGBColumn;
  group: TGroup;
begin
//  if gvb=nil then
  gvb := TGridViewBuilder.Create( F_DM.md_res, F_ResFrm.Grid );
  try
 //  if gvb=nil then begin
    gvb.IDFieldName := 'id';

    AddColToGVB( gvb, 'nomer', 'Номер'+#13+'наряда', alCenter );
    AddColToGVB( gvb, 'dt_in', 'Дата'+#13+'поступления', alCenter );
    AddColToGVB( gvb, 'adres', 'Адрес наряда' );
    AddColToGVB( gvb, 'sod', 'Характер'+#13+'повреждения' );
    AddColToGVB( gvb, 'dt_out', 'Выполнено' );
 //   AddColToGVB( gvb, 'vrabote', 'В работе', alCenter );
    AddColToGVB( gvb, 'list_count', 'Кол-во'+#13+ 'связанных' , alCenter);

    col := AddColToGVB(gvb, 'primech', 'Примечание' );
    col.DisplayWidth := 50;

   // col := AddColToGVB( gvb, 'wwater_list', 'Без воды' );
   // col.DisplayWidth := 50;
   col := AddColToGVB( gvb, 'list_zav', 'Связанные'+#13+'наряды' );
    col.DisplayWidth := 50;


    group:=gvb.AddGroup('main_gr');
    group.GroupHeader.Visible:=false;
    PrepareGroupBorder(group.GroupFooter, clYellow, OnMainFooterShow);
    group.AddAggregateField(atCount, 'id');


    group:=gvb.AddGroup('id_attach');
    group.IsNumberRecordInGroup:=true;
    group.GroupFooter.Visible:=false;
    PrepareGroupBorder(group.GroupHeader, clAqua, OnAttachShow);
    group.AddAggregateField(atCount, 'id');

{    group:=gvb.AddGroup('zav_type_name');
    group.IsNumberRecordInGroup:=true;
    group.GroupFooter.Visible:=false;
    PrepareGroupBorder(group.GroupHeader, clMoneyGreen, OnZavTypeShow);
    group.AddAggregateField(atCount, 'id');
 }
{    group:=gvb.AddGroup('id_revs');
    group.GroupFooter.Visible:=false;
    PrepareGroupBorder(group.GroupHeader, F_ResFrm.Grid.Color, OnRevsShow);
 }
// end;
    gvb.BuildGridView;
    F_ResFrm.Grid.ShowHint:=true;//добавим подсказку для сортировки

  finally
   gvb.Free;
  end;
end;


procedure TOtlRep.OnDocherFormOrderClick(Sender: TObject);
begin
 with F_DocherFrm do
    if Assigned(Grid.Objects[0,Grid.Row]) then
      ShowZav(integer(Grid.Objects[0,Grid.Row]));
end;

procedure TOtlRep.OnDochPrintClick(Sender: TObject);
begin

end;

procedure TOtlRep.OnExel(Sender: TObject);
begin

end;

procedure TOtlRep.PrepareDocherFormBtns;
begin
  F_DocherFrm.btn_Order.OnClick:=OnDocherFormOrderClick;
end;

procedure TOtlRep.PrepareDocherFormGrid;
var
  gvb: TGridViewBuilder;
  col: TGBColumn;
  group: TGroup;
begin
  gvb := TGridViewBuilder.Create( F_DM.MD_RESGROUP, F_DocherFrm.Grid );
  try
    gvb.IDFieldName := 'id';
    AddColToGVB(gvb,'nomer','№'+#13+'наряда',alLeft);
    AddColToGVB(gvb,'revs','Участок',alLeft);
    //AddColToGVB(gvb,'attach','Ghbyflkt;yjcnm',alLeft);

    col:=gvb.AddColumn();
    col.FieldName:='adres';
    col.DisplayWidth:=60;
    col.ColumnTitle.Caption:='Адрес';
    col.Alignment:=alLeft;


    AddColToGVB(gvb,'sod','Характер'+#13+' повреждения',alLeft);
    AddColToGVB(gvb,'dt_in','Дата'+#13+'поступления',alLeft);

    group:=gvb.AddGroup('attach');
    group.GroupHeader.Color:=clAqua;
    group.GroupHeader.OnShowCaption:=OnGroupHeaderShow;
    group.GroupHeader.Visible:=true;
    group.GroupFooter.Visible:=false;
    

     gvb.BuildGridView;




  finally
   gvb.Free;
  end;


end;

procedure TOtlRep.onGroupPrepareDoch(Sender: TObject);
begin
 if Assigned(F_resFrm.Grid.Objects[0,F_resFrm.Grid.Row]) then
    begin
      if F_dm.preparebygroup(integer(F_resFrm.Grid.Objects[0,F_resFrm.Grid.Row])) then
      begin
         PrepareDocherFormGrid();
         PrepareDocherFormBtns();
         F_DocherFrm.lbl_Left.Visible:=true;
         F_DocherFrm.lbl_Left.Caption:='Наряды связянные с отоженной заявкой №'+
           F_resFrm.Grid.Cells[1,F_resFrm.Grid.Row];
         F_DocherFrm.Height:=F_ResFrm.Height-30;
         F_DocherFrm.Width:=F_ResFrm.Width-30;
         F_DocherFrm.ShowModal;
      end;
    end;

end;

procedure TOtlRep.OnGroupHeaderShow(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
begin
  OutRow.Add('');
  OutRow.Add('');
  OutRow.Add('');
  OutRow.Add(Dataset.fieldbyname('attach').AsString);

end;

procedure TOtlRep.mainGridFixedColClick(Sender: TObject; col: Integer);
var fieldname:string;
begin
fieldname:='';
case col of
 1: fieldname:='nomer';
 2: fieldname:='dt_in';
 3: fieldname:='adres';  
 5: fieldname:='dt_out';
 6: fieldname:='list_count';
end;
if fieldname<>'' then
begin
    F_dm.sorted(fieldname);
  PrepareResultFormGrid;
  F_ResFrm.Grid.ColorRow[0]:=F_ResFrm.Grid.FixedColor;
  F_ResFrm.Grid.ColorCell[col,0]:=claqua;
  F_ResFrm.Grid.Cells[col,0]:=#17+' '+F_ResFrm.Grid.Cells[col,0];
end;  
end;

procedure TOtlRep.GridShowHintCell(Sender: TObject; col,
  row: Integer; var HintStr: String; var CanShow: Boolean;
  var HintInfo: THintInfo);
begin
  inherited;
if (row = 0 )and (col in [1,2,3,6]) then
 begin
  HintStr:='можно сортировать'+#13+' нажмите на заголовок';
 CanShow:=true;
 end;
end;



{ TEkonomPokaz }

procedure TEkonomPokaz.CreateForms;
begin
  F_OptFrm := Tfrm_OptEkonomPokaz.Create( nil, F_Name );
  F_DM := Tdm_RepEkonomPokaz.Create( nil );
end;

procedure TEkonomPokaz.DestroyForms;
begin
  F_OptFrm.Free;
  F_DM.Free;
end;

function TEkonomPokaz.Execute: boolean;
begin
  if F_OptFrm.ShowModal <> mrOk then
    Result := false
  else
  begin
    F_DM.IsCalcTZ := F_OptFrm.IsCalcTZ;
    F_DM.PrepareDset;

    if F_OptFrm.IsCalcTZ then
      F_ReportFileName := 'EkonomPokaz.frf'
    else
      F_ReportFileName := 'EkonomPokaz2.frf';

    PrintFastReport( F_DM.frReport );
    Result := true;
  end;
end;

procedure TEkonomPokaz.InitFields;
begin
  F_Name := 'Экономические показатели ремонтных работ';
  //F_ReportFileName := 'EkonomPokaz.frf';
end;

procedure TEkonomPokaz.PrepareFastReport;
begin
  frVariables[ 'nomer' ] := IntToStr( F_DM.ZavNomer );
  frVariables[ 'year' ] := IntToStr( F_DM.ZavYear );
  frVariables[ 'attach' ] := F_DM.ZavAttach;
end;

procedure TEkonomPokaz.SetZavID(const Value: integer);
begin
  F_DM.ZavID := Value;
end;

{ TTrudoZatrat }

procedure TTrudoZatrat.CreateForms;
begin
  F_OptFrm := Tfrm_OptTrudoZatrat.Create( nil, F_Name );
  F_DM := Tdm_RepTrudoZatrat.Create( nil );
end;

procedure TTrudoZatrat.DestroyForms;
begin
  F_OptFrm.Free;
  F_DM.Free;
end;

function TTrudoZatrat.Execute: boolean;
var
  _WaitFrm: Tfrm_WaitProcess;
begin
  if F_OptFrm.ShowModal <> mrOk then
  begin
    Result := false;
  end else
  begin
    Result := true;

    _WaitFrm := Tfrm_WaitProcess.Create(nil);
    try
      _WaitFrm.Show;

      F_DM.DtBeg := F_OptFrm.frame_Dates.BeginDate;
      F_DM.DtEnd := F_OptFrm.frame_Dates.EndDate;
      F_DM.RegionID := F_OptFrm.GetRegionID;
      F_DM.OperAttach := F_OptFrm.OperateAttach;
      F_DM.PrepareDset;
    finally
      _WaitFrm.Close;
      _WaitFrm.Free;
    end;

    PrintFastReport( F_DM.frReport );
  end;
end;

procedure TTrudoZatrat.InitFields;
begin
  F_Name := 'Сводка трудозатрат';
  F_ReportFileName := 'TrudoZatrat.frf';
end;

procedure TTrudoZatrat.PrepareFastReport;
begin
  frVariables[ 'DtBeg' ] := DateToStr( F_OptFrm.frame_Dates.BeginDate );
  frVariables[ 'DtEnd' ] := DateToStr( F_OptFrm.frame_Dates.EndDate );
  frVariables[ 'RegionName' ] := F_OptFrm.GetRegionName;
  frVariables[ 'Attach' ]:=GetAttachName( F_OptFrm.OperateAttach );
end;

{ TMatUse }

procedure TMatUse.CreateForms;
begin
  F_OptFrm := Tfrm_OptMatUse.Create( nil, F_Name );
  F_DM := Tdm_RepMatUse.Create( nil );

  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM,  F_DM.frReport);
  F_DM.frReport.Preview:=F_PreviewFrm.frPreview;

 {   F_frPreviewForm:=Tfrm_FrPreview.Create(nil, frReport);
  frReport.Preview:=F_frPreviewForm.frPreview;
  }
end;

procedure TMatUse.DestroyForms;
begin
  F_OptFrm.Free;
  F_DM.Free;
end;

function TMatUse.Execute: boolean;
var
  WaitFrm: Tfrm_WaitProcess;
begin
  if F_OptFrm.ShowModal <> mrOk then
  begin
    Result := false;
  end else
  begin
    WaitFrm:=Tfrm_WaitProcess.Create(nil);
    try
      WaitFrm.Show;

      F_DM.BeginDate := F_OptFrm.frame_Dates.BeginDate;
      F_DM.EndDate := F_OptFrm.frame_Dates.EndDate;
      F_DM.AttSelItems := F_OptFrm.frame_SelAttach.ItemSelecter.SelItemList;
      //F_DM.RevsSelItems := F_OptFrm.frame_SelRevs.ItemSelecter.SelItemList;
      F_DM.MatSelItems := F_OptFrm.frame_SelMat.ItemSelecter.SelItemList;

      F_DM.PrepareDset;

      PrintFastReport( F_DM.frReport );
      F_PreviewFrm.frOLEExcelExport.OpenExcelAfterExport := true;
      F_PreviewFrm.Align := alClient;
      F_PreviewFrm.ShowModal;
    finally
      WaitFrm.Close;
      WaitFrm.Free;
    end;
    Result := true;
  end;
end;

procedure TMatUse.InitFields;
begin
  F_Name := 'Сводка использованных материалов';
  F_ReportFileName := 'MatUse.frf';
end;

procedure TMatUse.PrepareFastReport;
begin
  frVariables[ 'BeginDate' ] := DateToStr( F_OptFrm.frame_Dates.BeginDate );
  frVariables[ 'EndDate' ] := DateToStr( F_OptFrm.frame_Dates.EndDate );

//  F_PreviewFrm.PreviewButtons := [pbPrint, pbExcel];
  
end;

{ TSvodkaSES }

procedure TSvodkaSES.CreateForms;
begin
  F_OptFrm := Tfrm_SvodkaSESOpt.Create( nil, F_Name, ClassName );
  F_OptFrm.me_Time.Text := formatdatetime( 'hh:mm', Now );
  F_OptFrm.NEGetSavesList := OnGetListOfSaves;  
//  NEGetSavesList
//  F_OptFrm.ds_Saves.DataSet :=
  F_DM := Tdm_SvodkaSES.Create( nil );
  F_ResFrm := Tfrm_AnalysisView.Create( nil, F_Name );
  //
  F_GVB := TGridViewBuilder.Create( F_DM.CheckDset, F_ResFrm.Grid );
end;

procedure TSvodkaSES.DestroyForms;
begin
  F_GVB.Free;
  //
  F_OptFrm.Free;
  F_DM.Free;
  F_ResFrm.Free;
end;

procedure TSvodkaSES.OnGetListOfSaves;
begin
   if F_OptFrm.dset_MTSaves.Active then F_OptFrm.dset_MTSaves.Close;
   F_OptFrm.dset_MTSaves.Open;
   LoadPreparedReportList('SVODKASES', F_OptFrm.frame_SelSvodkaDate.de_Begin.Date
                          , GetPrepRepAttribute ,F_OptFrm.dset_MTSaves);
    //GetSavesIDList(_RepID: integer; _Dt: TDate; _Attribute: integer; _DS: TDataSet);
//   GetSavesIDList(1, _Dt: TDate; _Attribute: integer; _DS: TDataSet);
end;

function TSvodkaSES.Execute: boolean;
var
  _WaitFrm: Tfrm_WaitProcess;
begin
  Result := true;
  F_OptFrm.IsShowAddOpt := F_IsDisp;
  F_OptFrm.chb_IsReCreate.Checked := F_IsRecreate;
  if F_OptFrm.ShowModal <> mrOK then
    Result := false
  else
  begin
    F_IsRecreate := F_OptFrm.IsReCreate;
    if F_OptFrm.IsReCreate  then
    begin
      _WaitFrm := Tfrm_WaitProcess.Create( nil );
      try
        _WaitFrm.Show;


        F_DM.DtBeg := F_OptFrm.frame_SelDates.BeginDate;
        F_DM.DtEnd := F_OptFrm.frame_SelDates.EndDate;
        //
        F_DM.IsVodaConsid := F_OptFrm.IsVodaConsid;
        F_DM.OwnerID_voda := F_OptFrm.frame_SelOwner_voda.ItemSelecter.SelItemList.ItemsID;
        F_DM.TZavID_voda := F_OptFrm.frame_SelTZav_voda.ItemSelecter.SelItemList.ItemsID;
        F_DM.PlaceID_voda := F_OptFrm.frame_SelPlace_voda.ItemSelecter.SelItemList.ItemsID;
        F_DM.SodID_voda := F_OptFrm.frame_SelSod_voda.ItemSelecter.SelItemList.ItemsID;
        //
        F_DM.IsKanalConsid := F_OptFrm.IsKanalConsid;
        F_DM.OwnerID_kanal := F_OptFrm.frame_SelOwner_kanal.ItemSelecter.SelItemList.ItemsID;
        F_DM.TZavID_kanal := F_OptFrm.frame_SelTZav_kanal.ItemSelecter.SelItemList.ItemsID;
        F_DM.PlaceID_kanal := F_OptFrm.frame_SelPlace_kanal.ItemSelecter.SelItemList.ItemsID;
        F_DM.SodID_kanal := F_OptFrm.frame_SelSod_kanal.ItemSelecter.SelItemList.ItemsID;
         //
        F_DM.IsVRKConsid := F_OptFrm.IsVRKConsid;
      //  F_DM.OwnerID_VRK := F_OptFrm.frame_SelOwner_VRK.ItemSelecter.SelItemList.ItemsID;
      //  F_DM.TZavID_VRK := F_OptFrm.frame_SelTZav_VRK.ItemSelecter.SelItemList.ItemsID;
       // F_DM.PlaceID_VRK := F_OptFrm.frame_SelPlace_VRK.ItemSelecter.SelItemList.ItemsID;
       // F_DM.SodID_VRK := F_OptFrm.frame_SelSod_VRK.ItemSelecter.SelItemList.ItemsID;



        F_DM.PrepareCheckDset;

        PrepareResFrmHeader;
        PrepareResFrmGrid;
        PrepareResFrmBtns;

      finally
        _WaitFrm.Close;
        _WaitFrm.Free;
      end;
      F_ResFrm.ShowModal;
    end else
      if not LoadAndPrintFR( F_DM.frReport, F_PreparedReportName,
        F_OptFrm.SvodDateTime, F_OptFrm.SvodAttID )
      then
        Application.MessageBox( 'Сводка за заданное число не найдена!', 'Внимание', MB_OK+MB_ICONERROR );
  end;
end;

function TSvodkaSES.GetPrepRepAttribute: integer;
var
  _v, _k,_r: boolean;
begin
  _v := F_OptFrm.IsVodaConsid;
  _k := F_OptFrm.IsKanalConsid;
  _r := F_OptFrm.IsVRKConsid;

  if ( _v ) and ( _k ) and( not _r) then
    Result := 3 else
  if ( _v ) and ( not _k ) and( not _r) then
    Result := 1 else
  if ( not _v ) and ( _k ) and( not _r) then
    Result := 2 else
   if ( _v ) and ( _k ) and(  _r) then
    Result := 6 else
  if ( _v ) and ( not _k ) and(  _r) then
    Result := 4 else
  if ( not _v ) and ( _k ) and(  _r) then
    Result := 5
  else
   Result := -1;
end;

procedure TSvodkaSES.InitFields;
begin
  F_Name := 'Сводка в СЭС';
  F_ReportFileName := 'SvodkaSES.frf';
  F_PreparedReportName := 'SVODKASES';
  F_IsDisp := ( rsZAV in RightsSet );
  F_IsRecreate := true;
end;

procedure TSvodkaSES.OnGroupHeaderShow(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
var
  i: integer;
begin
  for i := 1 to 4 do
    OutRow.Add( '' );
  OutRow.Add( trim( DataSet.FieldByName( 'attach' ).AsString ) );
end;

procedure TSvodkaSES.OnShowDiamDataCell(ShowValue: variant;
  var Res: string);
var
  _val: integer;
begin
  try
    _val := Integer( ShowValue );
    if _val > 0 then
      Res := IntToStr( _val )
    else
      Res := '';
  except
    Res := '';
  end;
end;

procedure TSvodkaSES.PrepareFastReport;
begin
  frVariables[ 'BegDt' ] := DateToStr( F_OptFrm.frame_SelDates.BeginDate );
  frVariables[ 'EndDt' ] := DateToStr( F_OptFrm.frame_SelDates.EndDate );
  frVariables[ 'sdal' ] := F_OptFrm.GetSdal;
  frVariables[ 'prinyal' ] := F_OptFrm.GetPrinyal;
end;

procedure TSvodkaSES.PrepareResFrmBtns;
begin
  F_ResFrm.btn_Order.OnClick:=ZavBtnClick;
  F_ResFrm.btn_Print.OnClick:=PrintBtnClick;
end;

procedure TSvodkaSES.PrepareResFrmGrid;
var
  _group: TGroup;
begin
  if Assigned( F_GVB ) then F_GVB.Free;

  F_GVB := TGridViewBuilder.Create( F_DM.CheckDset, F_ResFrm.Grid);
  with F_GVB do
  begin
    IDFieldName := 'id';

    SetRowInformerList( F_DM.RowInformerList, TRowInformer );
    IsShowCheckBoxes := true;

    AddColToGVB( F_GVB, 'nomer', 'Номер' + #13 + 'наряда', alCenter );
    AddColToGVB( F_GVB, 'dt_in', 'Дата/время' + #13 + 'поступления', alCenter );
    AddColToGVB( F_GVB, 'dt_out', 'Дата/время' + #13 + 'закрытия', alCenter );
    AddColToGVB( F_GVB, 'adres', 'Адрес', alLeft );
    AddColToGVB( F_GVB, 'tzav', 'Тип' + #13 + 'наряда', alLeft );
    AddColToGVB( F_GVB, 'place', 'Место' + #13 + 'повреждения', alLeft );
    AddColToGVB( F_GVB, 'sod', 'Характер' + #13 + 'повреждения', alLeft );
    AddColToGVB( F_GVB, 'diam', 'Диаметр', alCenter, OnShowDiamDataCell );

    _group := AddGroup( 'id_attach' );
    _group.GroupHeader.Visible := true;
    _group.GroupHeader.Alignment := alCenter;
    _group.GroupHeader.Font.Style := [fsBold];
    _group.GroupHeader.OnShowCaption := OnGroupHeaderShow;
    _group.GroupFooter.Visible := false;

    BuildGridView;
  end;
end;

procedure TSvodkaSES.PrepareResFrmHeader;
begin
  F_ResFrm.CenterLabel :=
    'Сводка в СЭС' + #13 +
    'за период с ' + DateToStr( F_OptFrm.frame_SelDates.BeginDate ) +
    ' по ' + DateToStr( F_OptFrm.frame_SelDates.EndDate );
end;

procedure TSvodkaSES.PrintBtnClick(Sender: TObject);
begin
  F_DM.PrepareResultDset;
  PrintFastReport(F_DM.frReport);
  SavePreparedReport( F_DM.frReport, F_PreparedReportName,
      F_OptFrm.SvodDateTime, GetPrepRepAttribute );
//    F_OptFrm.frame_SelSvodkaDate.BeginDate, GetPrepRepAttribute );
end;

procedure TSvodkaSES.ZavBtnClick(Sender: TObject);
begin
  with F_ResFrm do
    if Assigned(Grid.Objects[0,Grid.Row]) then
      ShowZav(integer(Grid.Objects[0,Grid.Row]));
end;

{TSvodPlanWorks}

procedure TSvodPlanWorks.InitFields;
begin
  F_Name := 'Перечень запланированных работ';
  F_ReportFileName := 'SvodPlanWorks.frf';
end;


procedure TSvodPlanWorks.CreateForms;
begin
  F_OptFrm := Tfrm_SvodPlanWorkOpt.Create( nil, F_Name );
  F_DM := Tdm_SvodPlanWorks.Create( nil );

  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM,  F_DM.frReport);
  F_DM.frReport.Preview:=F_PreviewFrm.frPreview;

end;

procedure TSvodPlanWorks.DestroyForms;
begin
  F_OptFrm.Free;
  F_DM.Free;


end;

procedure TSvodPlanWorks.PrepareFastReport;
begin

frVariables[ 'DATEMy' ] := DateToStr( F_OptFrm.dp_Date.Date );

end;

function TSvodPlanWorks.Execute:boolean;
var WaitFrm:Tfrm_WaitProcess;
begin

if F_OptFrm.ShowModal <> mrOk then
  begin
    Result := false;
  end else
  begin
    WaitFrm:=Tfrm_WaitProcess.Create(nil);
    try
      WaitFrm.Show;

      F_DM.DT := F_OptFrm.dp_Date.Date+TimeOf(F_OptFrm.dp_Time.Time);
      F_DM.Attaches := F_OptFrm.attachesID;
      F_DM.revs:= F_OptFrm.RevsID;
      F_dm.otl:= F_OptFrm.cb_otl.Checked;


      F_DM.PrepareDsets;

      PrintFastReport( F_DM.frReport );
      F_PreviewFrm.frOLEExcelExport.OpenExcelAfterExport := true;
      F_PreviewFrm.Align := alClient;
      F_PreviewFrm.ShowModal;
    finally
      WaitFrm.Close;
      WaitFrm.Free;
    end;
    Result := true;
  end;


end;

{}

{TSvodPlanWorks}

procedure TDiskonSvod.InitFields;
begin
  F_Name := 'Сводка';
  F_ReportFileName := 'DisconRep.frf';
end;


procedure TDiskonSvod.CreateForms;
begin
  F_OptFrm := Tfrm_DiskonOpt.Create( nil, F_Name );
  F_DM := Tdm_DiskondRep.Create( nil );

  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM,  F_DM.frReport);
  F_DM.frReport.Preview:=F_PreviewFrm.frPreview;
  F_OptFrm.DateIn:=Now()-10;
  F_optFrm.DateOut:=Now();
end;

procedure TDiskonSvod.DestroyForms;
begin
  F_OptFrm.Free;
  F_DM.Free;


end;

procedure TDiskonSvod.PrepareFastReport;
begin

frVariables[ 'dt_begin' ] := FormatDateTime('dd.mm.yyyy hh:mm', F_dt_begin );
frVariables[ 'dt_end' ] := FormatDateTime('dd.mm.yyyy hh:mm', F_dt_end );
frVariables[ 'typ' ] :=F_typ;

end;

function TDiskonSvod.Execute:boolean;
var WaitFrm:Tfrm_WaitProcess;

begin

if F_OptFrm.ShowModal <> mrOk then
  begin
    Result := false;
  end else
  begin
    WaitFrm:=Tfrm_WaitProcess.Create(nil);
    try
      WaitFrm.Show;

  F_dt_begin:=F_optFrm.DateIn;
 F_dt_end:=f_OptFrm.DateOut;
 f_dm.dt_begin:=f_dt_begin;
 F_dm.dt_end:=F_Dt_end;
 F_dm.operAttach:= F_optFrm.OperateAttach;
 f_dm.revsID:=F_optFrm.revsID;
 F_typ:=F_optFrm.TypeDiscon ;
 f_dm.StreetDisconID:=F_optFrm.StreetDisconID;
 f_dm.StreetOrderID:=F_optFrm.StreetOrderID;
 F_DM.TypeDiscon:=F_typ;

 if f_dm.Preparedsets then
 begin

    

      PrintFastReport( F_DM.frReport );
      F_PreviewFrm.frOLEExcelExport.OpenExcelAfterExport := true;
      F_PreviewFrm.Align := alClient;
      F_PreviewFrm.ShowModal;
  result:=true;
 end;
    finally
      WaitFrm.Close;
      WaitFrm.Free;
    end;
    Result := true;
  end;


end;

procedure TOpenDisconShift.CreateForms;
begin
//  F_OptFrm := Tfrm_DiskonOpt.Create( nil, F_Name );
  F_DM := Tdm_RepOpenDisconShift.Create( nil );

  F_ResFrm := Tfrm_AnalysisView.Create( nil, F_Name );
//  F_DM.frReport.Preview:=F_PreviewFrm.frPreview;

end;

procedure TOpenDisconShift.DestroyForms;
begin
//  F_OptFrm.Free;
  F_DM.Free;
  F_ResFrm.Free;
end;

procedure TOpenDisconShift.PrepareResFrmHeader;
begin
  F_ResFrm.CenterLabel :=
    'Наряди  в яких незакриті  виїзди';

end;


procedure TOpenDisconShift.PrepareResFrmGrid;
var
  _group: TGroup;
begin
  if Assigned( F_GVB ) then F_GVB.Free;

  F_GVB := TGridViewBuilder.Create( F_DM.rmem, F_ResFrm.Grid);
  with F_GVB do
  begin
    IDFieldName := 'id';



    AddColToGVB( F_GVB, 'nomer', 'Номер' + #13 + 'наряда', alCenter );
    AddColToGVB( F_GVB, 'dt_in', 'Дата/час' + #13 + 'надходження', alCenter );
//    AddColToGVB( F_GVB, 'dt_out', 'Дата/время' + #13 + 'закрытия', alCenter );
    AddColToGVB( F_GVB, 'address', 'Адрес', alLeft );
    AddColToGVB( F_GVB, 'comment', 'Про що заявлено ', alLeft );

    _group := AddGroup( 'id_revs' );
    _group.GroupHeader.Visible := true;
    _group.GroupHeader.Alignment := alCenter;
    _group.GroupHeader.Font.Style := [fsBold];
    _group.GroupHeader.OnShowCaption := OnGroupHeaderShow;
    _group.GroupFooter.Visible := false;

    BuildGridView;
  end;
end;

procedure TOpenDisconShift.PrepareResFrmBtns;
begin
  F_ResFrm.btn_Order.OnClick:=ZavBtnClick;
  F_ResFrm.btn_Print.Visible:=false;
end;

procedure TOpenDisconShift.OnGroupHeaderShow(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
var
  i: integer;
begin
  for i := 1 to 2 do
    OutRow.Add( '' );
  OutRow.Add( trim( DataSet.FieldByName( 'attach' ).AsString ) );
end;

function TOpenDisconShift.Execute: boolean;
var
  _WaitFrm: Tfrm_WaitProcess;
begin
  Result := true;
  _WaitFrm := Tfrm_WaitProcess.Create( nil );
  try
    _WaitFrm.Show;
    F_DM.PrePareDsets;
    PrepareResFrmHeader;
    PrepareResFrmGrid;
    PrepareResFrmBtns;

   finally
        _WaitFrm.Close;
        _WaitFrm.Free;
   end;
   F_ResFrm.ShowModal;
   result:=false;
end;

procedure TOpenDisconShift.ZavBtnClick(Sender: TObject);
begin
  with F_ResFrm do
    if Assigned(Grid.Objects[0,Grid.Row]) then
      ShowZav(integer(Grid.Objects[0,Grid.Row]));
end;

procedure TOpenDisconShift.InitFields;
begin
  F_Name:='Наряди  в яких незакриті  виїзди';
end;



end.
