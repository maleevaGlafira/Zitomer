unit NGReports2015;

interface
uses  Classes, Controls, NGBaseReport, FR_Class, Aligrid, DB, Graphics, SysUtils,
     FR_DSet, AnalysisViewForm, WithoutWaterOptForm, WWaterDModule, Variants,
     SvodVed2DModule, SvodVed3DModule, SvodVed2OptForm, SvodVed3OptForm, SearchAdresOptForm, SearchAdresDModule,
     UtechkiZaPeriodOptForm, UtechkiZaPeriodDModule, SvodVed2AlienDModule,
     SvodVed2AlienOptForm, OptEkonomPokazForm, RepEkonomPokazDM,
     OptTrudoZatrat, RepTrudoZatratDModule, OptMatUseForm, RepMatUseDM, RepOtlDMUnit,
     SvodkaSESOptForm, SvodkaSESDModule, GridViewBuilder, Forms, Windows, FrPreviewForm,
     svodPlanVorksDM,SvodPlanWorksOpt,DateUtils,  DiskonOptForm,DiskondRepDModule,
     SvodVedOtlNar,
     
     DModuleRepJurnal,OptRepJurnal,
     RepExcavNotFinishedDModule,OptRepExcavNotFinishedForm,RepExcavNotFinished2DModule,
     RepCloseExcavdModule,OptRepCloseExcavForm,
     DiskondRepDModuleGroup,OptDiscon13Group ;

type
{ TDiskonSvod = class(T NGBaseReport)
 private
   f_dt_begin,F_dt_end:TDateTime;
   F_OptFrm: Tfrm_DiskonOpt;
   F_PreviewFrm: Tfrm_FrPreview;
    F_DM: Tdm_DiskondRep;
 public
   function Execute:boolean; override;
 protected
   procedure InitFields; override;
   procedure CreateForms; override;
   procedure DestroyForms; override;
   procedure PrepareFastReport; override;
 end;
}
 TRepJurnal = class(TNGBaseReport)
 private
   f_dt:TDateTime;
   rev:string;
   F_OptFrm: Tfrm_OptRepJurnal;
   F_PreviewFrm: Tfrm_FrPreview;
    F_DM: Tdm_RepJurnal;
 public
   function Execute:boolean; override;
 protected
   procedure InitFields; override;
   procedure CreateForms; override;
   procedure DestroyForms; override;
   procedure PrepareFastReport; override;
 end;

  TDiskonForm13 = class(TNGBaseReport)
 private
   f_dt_begin,F_dt_end:TDateTime;
   F_OptFrm: Tfrm_DiskonOpt;
   F_PreviewFrm: Tfrm_FrPreview;
   F_DM: Tdm_DiskondRep;
   F_ResFrm: Tfrm_AnalysisView;
 {��������� ��� ����������� ����}

  // procedure(ShowValue: variant; var Res: string) of object;
  procedure PrepareResultFormGrid;
  procedure PrepareResultFormHeader;
  procedure PrintBtnClick(Sender: TObject);
  procedure PrepareResultFormBtns;
  procedure ZavBtnClick(Sender: TObject);
  procedure OnExel(Sender: TObject);
  procedure cutadres(ShowValue: variant; var Res: string) ;
 public
   function Execute:boolean; override;
 protected
   procedure InitFields; override;
   procedure CreateForms; override;
   procedure DestroyForms; override;
   procedure PrepareFastReport; override;
 end;

 TRepExcavNotFinished = class(TNgBaseReport)
 private
  // f_dt_begin,F_dt_end:TDateTime;
   F_OptFrm: Tfrm_OptRepExcavNotFinished;
   F_PreviewFrm: Tfrm_FrPreview;
   F_DM: Tdm_RepExcavNotFinished;
   F_ResFrm: Tfrm_AnalysisView;
   procedure cutadres(ShowValue: variant; var Res: string) ;
   procedure ZavBtnClick(Sender: TObject);
 protected
  procedure PrepareResultFormGrid;
  procedure PrepareResultFormHeader;
  procedure PrintBtnClick(Sender: TObject);
  procedure PrepareResultFormBtns;
//  procedure ZavBtnClick(Sender: TObject);
  procedure OnExel(Sender: TObject);
 protected
   procedure InitFields; override;
   procedure CreateForms; override;
   procedure DestroyForms; override;
   procedure PrepareFastReport; override;


 public
   function Execute:boolean;override;
 end;


 TRepExcavNotFinished2 = class(TNgBaseReport)
 private
  // f_dt_begin,F_dt_end:TDateTime;
   F_OptFrm: Tfrm_OptRepExcavNotFinished;
   F_PreviewFrm: Tfrm_FrPreview;
   F_DM: Tdm_RepExcavNotFinished2;
   F_ResFrm: Tfrm_AnalysisView;
   procedure cutadres(ShowValue: variant; var Res: string) ;
   procedure ZavBtnClick(Sender: TObject);
 protected
  procedure PrepareResultFormGrid;
  procedure PrepareResultFormHeader;
  procedure PrintBtnClick(Sender: TObject);
  procedure PrepareResultFormBtns;
//  procedure ZavBtnClick(Sender: TObject);
  procedure OnExel(Sender: TObject);
 protected
   procedure InitFields; override;
   procedure CreateForms; override;
   procedure DestroyForms; override;
   procedure PrepareFastReport; override;


 public
   function Execute:boolean;override;
 end;

  TRepCloseExcavd = class(TNgBaseReport)
 private
  // f_dt_begin,F_dt_end:TDateTime;
   F_OptFrm: Tfrm_RepClosedExcavOpt;
   F_PreviewFrm: Tfrm_FrPreview;
   F_DM: Tdm_RepCloseExcav;
   F_ResFrm: Tfrm_AnalysisView;
  // procedure cutadres(ShowValue: variant; var Res: string) ;
   procedure ZavBtnClick(Sender: TObject);
   procedure cutWorks(ShowValue: variant; var Res: string) ;
   procedure prepareDate(ShowValue: variant; var Res: string) ;
   procedure prepareDateTime(ShowValue: variant; var Res: string) ;
   procedure prepareInt(ShowValue: variant; var Res: string) ;
   procedure shownumbers(DataSet: TDataSet;
   AggregateValueArr: array of double; var OutRow: TStringList) ;
 protected
  procedure PrepareResultFormGrid;
  procedure PrepareResultFormHeader;
  procedure PrintBtnClick(Sender: TObject);
  procedure PrepareResultFormBtns;
//  procedure ZavBtnClick(Sender: TObject);
  procedure OnExel(Sender: TObject);
 protected
   procedure InitFields; override;
   procedure CreateForms; override;
   procedure DestroyForms; override;
   procedure PrepareFastReport; override;


 public
   function Execute:boolean;override;
 end;



 TDiskonForm13Group = class(TNGBaseReport)
 private
   f_dt_begin,F_dt_end:TDateTime;
   F_OptFrm: Tfrm_OptDiscon13Group;
   F_PreviewFrm: Tfrm_FrPreview;
   F_DM: Tdm_DiskondRepGroup;
   F_ResFrm: Tfrm_AnalysisView;
 {��������� ��� ����������� ����}

  // procedure(ShowValue: variant; var Res: string) of object;
  procedure PrepareResultFormGrid;
  procedure PrepareResultFormHeader;
  procedure PrintBtnClick(Sender: TObject);
  procedure PrepareResultFormBtns;
  procedure ZavBtnClick(Sender: TObject);
  procedure OnExel(Sender: TObject);
  procedure cutadres(ShowValue: variant; var Res: string) ;
 public
   function Execute:boolean; override;
 protected
   procedure InitFields; override;
   procedure CreateForms; override;
   procedure DestroyForms; override;
   procedure PrepareFastReport; override;
 end;





implementation

uses WaitProcessForm, ServiceFuncUnit, OperAttFormUnit, cntsLANG, ComObj, XLConst,
Types,SimpleGridToExel,HelpFunctions;

{ TDiskonSvod }

{procedure TDiskonSvod.CreateForms;
begin

  F_optFrm:=Tfrm_DiskonOpt.Create(nil,f_Name);
  f_dm:= Tdm_DiskondRep.Create(nil);
  F_PreviewFrm:=F_PreviewFrm.Create(f_dm,F_dm.frReport);
  F_DM.frReport.Preview:=F_PreviewFrm.frPreview;
end;

procedure TDiskonSvod.DestroyForms;
begin
  inherited;

  f_dm.Free;
  F_optFrm.Free;

end;

function TDiskonSvod.Execute: boolean;
var WaitFrm:Tfrm_WaitProcess;
begin
result:=false;
if F_optFrm.ShowModal<>mrOk then exit;
WaitFrm:=Tfrm_WaitProcess.Create(nil);
try
 WaitFrm.Show;
 F_dt_begin:=F_optFrm.DateIn;
 F_dt_end:=f_OptFrm.DateOut;
 f_dm.dt_begin:=f_dt_begin;
 F_dm.dt_end:=F_Dt_end;

 if f_dm.Preparedsets then
 begin

      F_DM.PrepareDsets;

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

end;

procedure TDiskonSvod.InitFields;
begin
  inherited;
  F_name:='������ ��������� �� ������';
  F_ReportFileName:='DisconRep.frf';

end;

procedure TDiskonSvod.PrepareFastReport;
begin
  inherited;
  frVariables['dt_begin']:=FormatdateTime('dd.mm.yyyy hh:mm',F_dt_begin);
  frVariables['dt_end']:=FormatdateTime('dd.mm.yyyy hh:mm',F_dt_end);
end;
 }
{ TRepJurnal }

procedure TRepJurnal.CreateForms;
begin
  inherited;
  F_optFrm:=Tfrm_OptRepJurnal.Create(nil,f_Name);
  f_dm:= Tdm_RepJurnal.Create(nil);
  F_PreviewFrm:=Tfrm_FrPreview.Create(f_dm,F_dm.frReport);
  F_DM.frReport.Preview:=F_PreviewFrm.frPreview;
end;

procedure TRepJurnal.DestroyForms;
begin
  inherited;
   F_dm.Free;
   F_optFrm.Free;
end;

function TRepJurnal.Execute: boolean;
var WaitFrm:Tfrm_WaitProcess;
begin
result:=false;
if F_optFrm.ShowModal<>mrOk then exit;
WaitFrm:=Tfrm_WaitProcess.Create(nil);
try
 WaitFrm.Show;
 F_dt:=F_optFrm.dat;
 rev :=F_optFrm.revname;
 f_dm.dat:=F_dt;
 f_dm.isOtl:=F_optFrm.isOtl;
 f_dm.attach:=f_optFrm.attach;

// f_dm.idRev:=f_optFrm.idRev;
f_dm.idrevs:=f_optFrm.revsid;
 f_dm.aliens:=F_optFrm.idALien;
 if f_dm.prepareDsets then
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

end;

procedure TRepJurnal.InitFields;
begin
  inherited;
  f_name := '�������� ������';
  F_ReportFileName:='repJurnal.frf';
end;

procedure TRepJurnal.PrepareFastReport;
begin
  inherited;
  frVariables['dateStr']:=FormatdateTime('dd.mm.yyyy',f_dt);
  frVariables['rev']:=rev;
end;

{ TDiskonForm13 }

procedure TDiskonForm13.CreateForms;
begin
  inherited;
  F_optFrm:=Tfrm_DiskonOpt.Create(nil,f_Name);
  f_dm:= Tdm_DiskondRep.Create(nil);

  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM,  F_DM.frReport);
  F_DM.frReport.Preview:=F_PreviewFrm.frPreview;
  F_ResFrm:=Tfrm_AnalysisView.Create(nil,f_name);

end;

procedure TDiskonForm13.DestroyForms;
begin
  inherited;
  f_dm.Free;
  F_optFrm.Free;
  F_ResFrm.Free;
end;

function TDiskonForm13.Execute: boolean;
 var WaitFrm:Tfrm_WaitProcess;
begin
  result:=false;
  if F_optFrm.ShowModal<>mrOk then exit;
  WaitFrm:=Tfrm_WaitProcess.Create(nil);
  try
   WaitFrm.Show;
   F_dt_begin:=F_optFrm.DateIn;
   F_dt_end:=f_OptFrm.DateOut;
   f_dm.dt_begin:=f_dt_begin;
   F_dm.dt_end:=F_Dt_end;
   F_dm.operAttach:= F_optFrm.OperateAttach;
   f_dm.addkod:=true;
   F_dm.TypeDiscon:=F_optFrm.TypeDiscon;
   if f_dm.Preparedsets then
   begin

       // PrintFastReport( F_DM.frReport );
       // F_PreviewFrm.frOLEExcelExport.OpenExcelAfterExport := true;
       // F_PreviewFrm.Align := alClient;
       PrepareResultFormHeader;
        PrepareResultFormGrid;
        PrepareResultFormBtns;
    result:=true;
   end;
  finally
   WaitFrm.Close;
   WaitFrm.Free;
  end;
  F_ResFrm.ShowModal ;

end;

procedure TDiskonForm13.InitFields;
begin
  inherited;
  f_name := '���������� Թ13 �����';
   F_ReportFileName := 'Diskon13.frf';
end;

procedure TDiskonForm13.PrepareFastReport;
begin
  inherited;
  frVariables['dt_begin']:=FormatdateTime('dd.mm.yyyy hh:mm',F_dt_begin);
  frVariables['dt_end']:=FormatdateTime('dd.mm.yyyy hh:mm',F_dt_end);
end;

procedure TDiskonForm13.PrepareResultFormGrid;
var
  gvb: TGridViewBuilder;
  col :tGBcolumn;
  i:integer;
begin
  gvb:=TGridViewBuilder.Create(F_DM.rmmain, F_ResFrm.Grid);
  try
    gvb.IsNumberRecord:=true;
    gvb.IDFieldName:='id';

    AddColToGVB(gvb, 'empty', '��� �������'+#13+'����������', alLeft);
    col:=AddColToGVB(gvb, 'adres1', '�����'+#13+'�����������', alLeft, cutadres);
    col.DisplayWidth:=50;
    col:=AddColToGVB(gvb, 'adress_disc', '�����'+#13+'����������', alLeft, cutadres);
    col.DisplayWidth:=50;
    AddColToGVB(gvb, 'coment', '����������', alLeft);
    if F_dm.listkod<>nil then
    begin
      for i:=0 to F_dm.listkod.Count-1 do
       AddColToGVB(gvb, 'kod'+F_dm.listkod[i], '��� �-�'+#13+F_dm.listkod[i], alCenter);

    end;
     AddColToGVB(gvb, 'dttm_discon', '���� ����������', alCenter);
     AddColToGVB(gvb, 'dttm_con', '���� ���������', alCenter);
     AddColToGVB(gvb, 'longminute', '����.'+#13+'�������', alCenter);
     AddColToGVB(gvb, 'empty', 'ʳ������ ��������'+#13+'���������', alCenter);
     AddColToGVB(gvb, 'empty', 'ʳ������ ��������'+#13+'�����������', alCenter);
     AddColToGVB(gvb, 'empty', '�������', alLeft);



    gvb.BuildGridView;
  finally
    gvb.Free;
  end;
end;

procedure TDiskonForm13.PrepareResultFormHeader;
begin
  F_ResFrm.CenterLabel:=
    AnsiUpperCase( F_Name ) + #13 +
    ' �� ������ c '+formatDateTime('dd.mm.yyyy hh:mm',F_optFrm.DateIn)+
    ' �� '+formatDateTime('dd.mm.yyyy hh:mm',F_optFrm.DateOut);
end;

procedure TDiskonForm13.PrintBtnClick(Sender: TObject);
begin
  PrintFastReport(F_DM.frReport);
   F_PreviewFrm.ShowModal;
end;


procedure TDiskonForm13.PrepareResultFormBtns;
begin

  F_ResFrm.btn_Print.OnClick:=PrintBtnClick;
  F_ResFrm.btn_Order.OnClick:=ZavBtnClick;
  f_resFrm.btn_Excel.OnClick:=OnExel;

end;

procedure TDiskonForm13.ZavBtnClick(Sender: TObject);
begin
  with F_ResFrm do
    if Assigned(Grid.Objects[0,Grid.Row]) then
      ShowZav(integer(Grid.Objects[0,Grid.Row]));
end;

procedure TDiskonForm13.OnExel(Sender: TObject);
begin

 GridToExel(F_ResFrm.Grid,f_name,f_name,
             [
             AnsiUpperCase( F_Name ) +
            ' �� ������ c '+formatDateTime('dd.mm.yyyy hh:mm',F_optFrm.DateIn)+
            ' �� '+formatDateTime('dd.mm.yyyy hh:mm',F_optFrm.DateOut)]);
end ;

procedure TDiskonForm13.cutadres(ShowValue: variant; var Res: string) ;
begin
  res:=String(ShowValue);
  res:=LineToMultiLine(res,50);
end;

{ TRepExcavNotFinished }

procedure TRepExcavNotFinished.CreateForms;
begin
  inherited;
  F_optFrm:=Tfrm_OptRepExcavNotFinished.Create(nil,f_Name);
  f_dm:= Tdm_RepExcavNotFinished.Create(nil);

  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM,  F_DM.frReport);
  F_DM.frReport.Preview:=F_PreviewFrm.frPreview;
  F_ResFrm:=Tfrm_AnalysisView.Create(nil,f_name);
end;

procedure TRepExcavNotFinished.DestroyForms;
begin
  inherited;
  F_optFrm.Free;
  f_dm.Free;
  //F_PreviewFrm.Free;
 // F_ResFrm.Free;
end;

function TRepExcavNotFinished.Execute: boolean;
var WaitFrm:Tfrm_WaitProcess;
begin
 result:=false;
 if F_optFrm.ShowModal<>mrOk then exit;
 f_dm.dtstart:=f_optFrm.startDate;
 f_dm.dtend:=f_optFrm.endDate;
 f_dm.revs:=F_optFrm.revsid;
 WaitFrm:=Tfrm_WaitProcess.Create(nil);
 WaitFrm.Show;
 try

  if F_dm.preparedset then
  begin
     PrepareResultFormHeader;
     PrepareResultFormGrid;
     PrepareResultFormBtns;
      F_ResFrm.ShowModal;
     result:=true;

  end
  else
   Application.MessageBox('������ ��������� �������!!','������',MB_OK+MB_ICONERROR);
 finally
  WaitFrm.Close;
  WaitFrm.Free;
 end;



end;

procedure TRepExcavNotFinished.InitFields;
begin
  inherited;
  f_name:='������ ��������������� ���� ��������';
  F_ReportFileName := 'RepExcavNotFinished.frf';
end;

procedure TRepExcavNotFinished.OnExel(Sender: TObject);
begin
  GridToExel(F_ResFrm.Grid,f_name,f_name,
            [ AnsiUpperCase( F_Name ) +
            ' �� ������ c '+formatDateTime('dd.mm.yyyy hh:mm',F_optFrm.startDate)+
            ' �� '+formatDateTime('dd.mm.yyyy hh:mm',F_optFrm.endDate)]);
end;

procedure TRepExcavNotFinished.PrepareFastReport;
begin
  inherited;
  frVariables['startdate']:=formatDateTime('dd.mm.yyyy hh:mm',F_optFrm.startDate);
  frVariables['enddate']:=formatDateTime('dd.mm.yyyy hh:mm',F_optFrm.endDate);
  frVariables['revs']:=F_optFrm.revnames;
end;

procedure TRepExcavNotFinished.PrepareResultFormBtns;
begin
 F_ResFrm.btn_Print.OnClick:=PrintBtnClick;
 F_ResFrm.btn_Excel.OnClick:=onExel;
 f_resFrm.btn_Order.OnClick:=ZavBtnClick;
end;

procedure TRepExcavNotFinished.PrepareResultFormGrid;
var
  gvb: TGridViewBuilder;
  col: TGBcolumn;

begin
  gvb:=TGridViewBuilder.Create(F_DM.rm_main, F_ResFrm.Grid);
  try
    gvb.IsNumberRecord:=true;
    gvb.IDFieldName:='id_zav';
    AddColToGVB(gvb, 'nomer', '�'+#13+'������', alLeft);
    AddColToGVB(gvb, 'dt_zav_in', '����'+#13+'�����������', alLeft);
    AddColToGVB(gvb, 'dt_zav_out', '�'+#13+'������', alLeft);
    AddColToGVB(gvb, 'adres', '�����', alLeft);
    AddColToGVB(gvb, 'mes', '���������'+#13+'��������', alLeft);
    AddColToGVB(gvb, 'dt_excav', '���� '+#13+'��������', alLeft);
    AddColToGVB(gvb, 'state', '���������'+#13+'��������', alLeft);
    AddColToGVB(gvb, 'todo', '����', alLeft);
    AddColToGVB(gvb, 'plandateexcav', '�����������'+#13+'����'+#13+'�������������', alLeft);
    AddColToGVB(gvb, 'dt_zasexcav', '����'+#13+'������� '+#13+'��������', alLeft);
    AddColToGVB(gvb, 'dt_planexcav', '����'+#13+'������������ '+#13+'��������', alLeft);
    AddColToGVB(gvb, 'dateorg', '���� �������� '+#13+'����������', alLeft);
    AddColToGVB(gvb, 'dt_cheb', '���� '+#13+'���������', alLeft);
    AddColToGVB(gvb, 'dt_asf', '����'+#13+' �������������'+#13+'(���������)', alLeft);
    AddColToGVB(gvb, 'datecloseddocument', '����'+#13+'������'+#13+'��������'+#13+'� ��������� '+#13+'�� ���������������'+#13+' ���� ', alLeft);
    AddColToGVB(gvb, 'notfinished', '�� '+#13+'���������'+#13+' ������'+#13+' � ����', alLeft);

    col:=AddColToGVB(gvb, 'add_inf', '�������������� '+#13+' ����������', alLeft);
    col.DisplayWidth:=50;
    gvb.BuildGridView;
 finally
  gvb.Free;
 end;

end;

procedure TRepExcavNotFinished.PrepareResultFormHeader;
begin
   F_ResFrm.CenterLabel:=
    AnsiUpperCase( F_Name ) + #13 +
    ' �� ������ c '+formatDateTime('dd.mm.yyyy hh:mm',F_optFrm.startDate)+
    ' �� '+formatDateTime('dd.mm.yyyy hh:mm',F_optFrm.endDate);

end;

procedure TRepExcavNotFinished.PrintBtnClick(Sender: TObject);
begin
  PrintFastReport(F_DM.frReport);
   F_PreviewFrm.ShowModal;
end;

procedure TRepExcavNotFinished.cutadres(ShowValue: variant; var Res: string) ;
begin
if ShowValue<>NULL then
begin
  res:=String(ShowValue);
  res:=LineToMultiLine(res,50);
end else res:='';
end;



procedure TRepExcavNotFinished.ZavBtnClick(Sender: TObject);
begin
  with F_ResFrm do
    if Assigned(Grid.Objects[0,Grid.Row]) then
      ShowZav(integer(Grid.Objects[0,Grid.Row]));
end;

{ TRepExcavNotFinished }

procedure TRepExcavNotFinished2.CreateForms;
begin
  inherited;
  F_optFrm:=Tfrm_OptRepExcavNotFinished.Create(nil,f_Name);
  f_dm:= Tdm_RepExcavNotFinished2.Create(nil);

  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM,  F_DM.frReport);
  F_DM.frReport.Preview:=F_PreviewFrm.frPreview;
  F_ResFrm:=Tfrm_AnalysisView.Create(nil,f_name);
end;

procedure TRepExcavNotFinished2.DestroyForms;
begin
  inherited;
  F_optFrm.Free;
  f_dm.Free;
  //F_PreviewFrm.Free;
 // F_ResFrm.Free;
end;

function TRepExcavNotFinished2.Execute: boolean;
var WaitFrm:Tfrm_WaitProcess;
begin
 result:=false;
 if F_optFrm.ShowModal<>mrOk then exit;
 f_dm.dtstart:=f_optFrm.startDate;
 f_dm.dtend:=f_optFrm.endDate;
 f_dm.revs:=F_optFrm.revsid;
 f_dm.id_att:=ord(F_optFrm.OperateAttach);
 WaitFrm:=Tfrm_WaitProcess.Create(nil);
 WaitFrm.Show;
 try

  if F_dm.preparedset then
  begin
     PrepareResultFormHeader;
     PrepareResultFormGrid;
     PrepareResultFormBtns;

      F_ResFrm.ShowModal;
     result:=true;

  end
  else
   Application.MessageBox('������ ��������� �������!!','������',MB_OK+MB_ICONERROR);
 finally
  WaitFrm.Close;
  WaitFrm.Free;
 end;



end;

procedure TRepExcavNotFinished2.InitFields;
begin
  inherited;
  f_name:='������� ��������� ����� ���������� ����������� ';
  F_ReportFileName := 'RepExcavNotFinished2.frf';
end;

procedure TRepExcavNotFinished2.OnExel(Sender: TObject);
begin
  GridToExel(F_ResFrm.Grid,'�����',f_name,
             [AnsiUpperCase( F_Name ) +
            ' �� ������ c '+formatDateTime('dd.mm.yyyy hh:mm',F_optFrm.startDate)+
            ' �� '+formatDateTime('dd.mm.yyyy hh:mm',F_optFrm.endDate)]);
end;

procedure TRepExcavNotFinished2.PrepareFastReport;
begin
  inherited;
  frVariables['start']:=formatDateTime('dd.mm.yyyy ',F_optFrm.startDate);
  frVariables['end']:=formatDateTime('dd.mm.yyyy ',F_optFrm.endDate);
 // frVariables['revs']:=F_optFrm.revnames;
 frVariables['curdatetime']:=F_dm.strcurdate;
 frVariables['curdate']:=F_dm.strcurdt;



end;

procedure TRepExcavNotFinished2.PrepareResultFormBtns;
begin
 F_ResFrm.btn_Print.OnClick:=PrintBtnClick;
 F_ResFrm.btn_Excel.OnClick:=onExel;
 f_resFrm.btn_Order.OnClick:=ZavBtnClick;
end;

procedure TRepExcavNotFinished2.PrepareResultFormGrid;
var
  gvb: TGridViewBuilder;
  col: TGBcolumn;

begin
  gvb:=TGridViewBuilder.Create(F_DM.rm_main, F_ResFrm.Grid);
  try
    gvb.IsNumberRecord:=true;
    gvb.IDFieldName:='id_zav';
    AddColToGVB(gvb, 'dt_zav_in', '����'+#13+'�����������', alLeft);
    AddColToGVB(gvb, 'nomer', '�'+#13+'������', alLeft);
    AddColToGVB(gvb, 'dt_zav_out', '����'+#13+'����������', alLeft);
    AddColToGVB(gvb, 'adres', '�����', alLeft);
    AddColToGVB(gvb, 'dt_excav', '���� '+#13+'��������', alLeft);
    AddColToGVB(gvb, 'mes', '���������'+#13+'��������', alLeft);
    AddColToGVB(gvb, 'state', '���������'+#13+'��������', alLeft);
    AddColToGVB(gvb, 'todo', '����', alLeft);
 
    col:=AddColToGVB(gvb, 'add_inf', '�������������� '+#13+' ����������', alLeft);
    col.DisplayWidth:=100;
    gvb.BuildGridView;
 finally
  gvb.Free;
 end;

end;

procedure TRepExcavNotFinished2.PrepareResultFormHeader;
begin
   F_ResFrm.CenterLabel:=
    AnsiUpperCase( F_Name ) + #13 +
    ' �� ������ c '+f_dm.strstart+#13+
    ' �� '+f_dm.strEnd;

end;

procedure TRepExcavNotFinished2.PrintBtnClick(Sender: TObject);
begin
  PrintFastReport(F_DM.frReport);
   F_PreviewFrm.ShowModal;
end;

procedure TRepExcavNotFinished2.cutadres(ShowValue: variant; var Res: string) ;
begin
if ShowValue<>NULL then
begin
  res:=String(ShowValue);
  res:=LineToMultiLine(res,100);
end else res:='';
end;

procedure TRepExcavNotFinished2.ZavBtnClick(Sender: TObject);
begin
  with F_ResFrm do
    if Assigned(Grid.Objects[0,Grid.Row]) then
      ShowZav(integer(Grid.Objects[0,Grid.Row]));
end;




{ TRepCloseExcavd }

procedure TRepCloseExcavd.CreateForms;
begin
  inherited;
  F_optFrm:=Tfrm_RepClosedExcavOpt.Create(nil,f_Name);
  f_dm:= Tdm_RepCloseExcav.Create(nil);

  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM,  F_DM.frReport);
  F_DM.frReport.Preview:=F_PreviewFrm.frPreview;
  F_ResFrm:=Tfrm_AnalysisView.Create(nil,f_name);
end;

{procedure TRepCloseExcavd.cutadres(ShowValue: variant; var Res: string);
begin
 if ShowValue<>NULL then
begin
  res:=String(ShowValue);
  res:=LineToMultiLine(res,50);
end else res:='';
end;}

procedure TRepCloseExcavd.cutWorks(ShowValue: variant; var Res: string) ;
begin
 if  ShowValue<>NULL then
 begin
  res:=String(ShowValue);
  res:=ReplaceChar(res, ';',#13);
 end;
end;

procedure TRepCloseExcavd.prepareDate(ShowValue: variant; var Res: string) ;
var dt:TDate;
begin
 if  ShowValue<>NULL  then
 begin
  dt:=TDate(ShowValue);
  res:=formatDateTime('dd.mm.yyyy',dt);
  if dt=0 then
   res:='';
 end;
end;

procedure TRepCloseExcavd.prepareDateTime(ShowValue: variant; var Res: string) ;
var dt:TDateTime;
begin
 if  ShowValue<>NULL  then
 begin
  dt:=TDateTime(ShowValue);
  res:=formatDateTime('dd.mm.yyyy hh:mm',dt);
  if dt=0 then
   res:='';
 end;
end;

procedure TRepCloseExcavd.prepareInt(ShowValue: variant; var Res: string) ;
var n:integer;
begin
if  ShowValue<>NULL  then
 begin
  n:=Integer(ShowValue);
  res:=IntTostr(n);
  if n=0 then
   res:='';
 end;
end;

procedure TRepCloseExcavd.DestroyForms;
begin
  inherited;
  F_optFrm.Free;
  f_dm.Free;
end;

function TRepCloseExcavd.Execute: boolean;
var WaitFrm:Tfrm_WaitProcess;
begin
result:=false;
 if F_optFrm.ShowModal<>mrOk then exit;
 f_dm.startDate:=f_optFrm.startDate;
 f_dm.endDate:=f_optFrm.endDate;
 f_dm.revsid:=F_optFrm.revsid;
 f_dm.id_att:=ord(F_optFrm.OperateAttach);
 F_dm.mestid:=F_optFrm.mestid;
 WaitFrm:=Tfrm_WaitProcess.Create(nil);

 WaitFrm.Show;
 try

  if F_dm.prePareDsets then
  begin
     PrepareResultFormHeader;
     PrepareResultFormGrid;
     PrepareResultFormBtns;

      F_ResFrm.ShowModal;
     result:=true;

  end
  else
   Application.MessageBox('������ ��������� �������!!','������',MB_OK+MB_ICONERROR);
 finally
  WaitFrm.Close;
  WaitFrm.Free;
 end;

end;

procedure TRepCloseExcavd.InitFields;
begin
  inherited;
  f_name:='��������� �������������� �������� ';
  F_ReportFileName := '';
end;

procedure TRepCloseExcavd.OnExel(Sender: TObject);
var s,s1,s2:string;
    org:string;
begin
  if ord(F_optFrm.OperateAttach)=1 then org:='(�������������)' else org:='(�����������)';
  s:=' ��������� ����� ������� ��� ����������� �������� '+org+
            ' � '+formatDateTime('dd.mm.yyyy ',F_optFrm.startDate)+
            ' �� '+formatDateTime('dd.mm.yyyy ',F_optFrm.endDate);
  s1:='������� :'+F_optFrm.revnames;
  s2:='��������� :'+F_optFrm.mestNames;
  GridToExel(F_ResFrm.Grid,'��������� ����� �������  ��������',
            '��������� ����� ������� ��� ����������� ��������',
            [s ,s1,s2]);//

end;

procedure TRepCloseExcavd.PrepareFastReport;
begin
  inherited;

end;

procedure TRepCloseExcavd.PrepareResultFormBtns;
begin
 F_ResFrm.btn_Excel.OnClick:=onExel;
 f_resFrm.btn_Order.OnClick:=ZavBtnClick;
end;

procedure TRepCloseExcavd.PrepareResultFormGrid;
var
  gvb: TGridViewBuilder;
//  col: TGBcolumn;
  group: TGroup;

begin
  gvb:=TGridViewBuilder.Create(F_DM.rm_main, F_ResFrm.Grid);
  try
    gvb.IsNumberRecord:=true;
    gvb.IDFieldName:='id_zav';
    AddColToGVB(gvb, 'numberyear', '�����', alLeft);
    AddColToGVB(gvb, 'dt_zav', '����', alLeft,prepareDateTime);
    AddColToGVB(gvb, 'excavAdress', '�����', alLeft);
    AddColToGVB(gvb, 'About', '����������', alLeft);
    AddColToGVB(gvb, 'diam', '����', alLeft,prepareInt);
    AddColToGVB(gvb, 'worksList', '������', alLeft,cutWorks);
    AddColToGVB(gvb, 'dtOutZav', '���� ����.', alLeft,prepareDateTime);
    AddColToGVB(gvb, 'dtStartExcav', '���� ������'+#13+'��������', alLeft,prepareDateTime);
    AddColToGVB(gvb, 'dt_plan_sand', '���� ���������'+#13+'��������'+#13+'(������� ������)', alLeft,prepareDate);
    AddColToGVB(gvb, 'mest', '���������'+#13+'��������', alLeft);
    AddColToGVB(gvb, 'dateorg', '���� ����'+#13+'�������� ���'
                                    +#13+'�������������'
                                    +#13+'��������'
                                    +#13+'�������', alLeft,prepareDate);
    AddColToGVB(gvb, 'numberroad', '����� ����'+#13+'�������� ���'
                                    +#13+'�������������'
                                    +#13+'��������'
                                    +#13+'�������', alLeft);

    AddColToGVB(gvb, 'dt_cheb', '���� ����'+#13+'����������'
                                    +#13+'��������'
                                    +#13+'(������)'
                                    , alLeft,prepareDate);
    AddColToGVB(gvb, 'numbercheb', '����� ����'+#13+'����������'
                                    +#13+'��������'
                                    +#13+'(������)'
                                    , alLeft);
    AddColToGVB(gvb, 'dt_downasfalt', '���� '+#13+'����������'
                                    +#13+'������� ����'
                                    +#13+'��������'
                                    , alLeft,prepareDate);
    AddColToGVB(gvb, 'dt_upasfalt', '���� '+#13+'�������������'
                                    +#13+'��������'
                                    +#13+'������� �����'
                                    +#13+'��������'
                                    , alLeft,prepareDate);
    AddColToGVB(gvb, 'datecloseddocument', '���� ������'
                                    +#13+'�������� �'
                                    +#13+'��������� '
                                    +#13+'���������'
                                    +#13+'���������������'
                                    , alLeft,prepareDate);

    (*col:=AddColToGVB(gvb, 'add_inf', '�������������� '+#13+' ����������', alLeft);
    col.DisplayWidth:=50;*)
    group:=gvb.AddGroup('forGroup');
    group.GroupHeader.OnShowCaption:=shownumbers;
    group.GroupHeader.Alignment:=alCenter;
    group.GroupHeader.Visible:=true;
    group.GroupFooter.Visible:=false;
    gvb.BuildGridView;
 finally
  gvb.Free;
 end;


end;

procedure TRepCloseExcavd.PrepareResultFormHeader;
var org:string;
begin
  if ord(F_optFrm.OperateAttach)=1 then org:='(�������������)' else org:='(�����������)';
 F_ResFrm.CenterLabel:=
    AnsiUpperCase( F_Name ) + #13 + org+
    ' �� ������ c '+formatDateTime('dd.mm.yyyy ',F_optFrm.startDate)+
    ' �� '+formatDateTime('dd.mm.yyyy ',F_optFrm.endDate);
 if F_optFrm.revnames<>'' then
 F_ResFrm.CenterLabel:=F_ResFrm.CenterLabel+#13+'������� :'+ F_optFrm.revnames;

 if F_optFrm.mestNames<>'' then
 F_ResFrm.CenterLabel:=F_ResFrm.CenterLabel+#13+'����� ����������� :'+ F_optFrm.mestNames;


end;

procedure TRepCloseExcavd.PrintBtnClick(Sender: TObject);
begin
//
end;

procedure TRepCloseExcavd.ZavBtnClick(Sender: TObject);
begin
  with F_ResFrm do
    if Assigned(Grid.Objects[0,Grid.Row]) then
      ShowZav(integer(Grid.Objects[0,Grid.Row]));
end;

procedure TRepCloseExcavd.shownumbers(DataSet: TDataSet;AggregateValueArr: array of double; var OutRow: TStringList) ;
var i:integer;
begin
for i:=1 to 17 do OutRow.Add(IntTOStr(i));
end;

{ TDiskonForm13Group }

procedure TDiskonForm13Group.CreateForms;
begin
  inherited;
  F_optFrm:=Tfrm_OptDiscon13Group.Create(nil,f_Name);
  f_dm:= Tdm_DiskondRepGroup.Create(nil);

  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM,  F_DM.frReport);
  F_DM.frReport.Preview:=F_PreviewFrm.frPreview;
  F_ResFrm:=Tfrm_AnalysisView.Create(nil,f_name);

end;

procedure TDiskonForm13Group.DestroyForms;
begin
  inherited;
  f_dm.Free;
  F_optFrm.Free;
  F_ResFrm.Free;
end;

function TDiskonForm13Group.Execute: boolean;
 var WaitFrm:Tfrm_WaitProcess;
begin
  result:=false;
  if F_optFrm.ShowModal<>mrOk then exit;
  WaitFrm:=Tfrm_WaitProcess.Create(nil);
  try
   WaitFrm.Show;
   F_dt_begin:=F_optFrm.DateIn;
   F_dt_end:=f_OptFrm.DateOut;
   f_dm.dt_begin:=f_dt_begin;
   F_dm.dt_end:=F_Dt_end;
   F_dm.operAttach:= F_optFrm.OperateAttach;
   f_dm.addkod:=true;
   F_dm.TypeDiscon:=F_optFrm.TypeDiscon;
   f_dm.maxmin:=F_optFrm.maxmin;
   F_dm.days:=F_optFrm.days;
   if f_dm.Preparedsets then
   begin

       // PrintFastReport( F_DM.frReport );
       // F_PreviewFrm.frOLEExcelExport.OpenExcelAfterExport := true;
       // F_PreviewFrm.Align := alClient;
       PrepareResultFormHeader;
        PrepareResultFormGrid;
        PrepareResultFormBtns;
    result:=true;
   end;
  finally
   WaitFrm.Close;
   WaitFrm.Free;
  end;
  F_ResFrm.ShowModal ;

end;

procedure TDiskonForm13Group.InitFields;
begin
  inherited;
  f_name := '���������� Թ13 ����� ������';
   F_ReportFileName := 'Diskon13Group.frf';
end;

procedure TDiskonForm13Group.PrepareFastReport;
begin
  inherited;
  frVariables['dt_begin']:=FormatdateTime('dd.mm.yyyy hh:mm',F_dt_begin);
  frVariables['dt_end']:=FormatdateTime('dd.mm.yyyy hh:mm',F_dt_end);
end;

procedure TDiskonForm13Group.PrepareResultFormGrid;
var
  gvb: TGridViewBuilder;
  col :tGBcolumn;
  i:integer;
begin
  gvb:=TGridViewBuilder.Create(F_DM.rmmain, F_ResFrm.Grid);
  try
    gvb.IsNumberRecord:=true;
    gvb.IDFieldName:='id';

    AddColToGVB(gvb, 'empty', '��� �������'+#13+'����������', alLeft);

    col:=AddColToGVB(gvb, 'adres1', '�����'+#13+'�����������', alLeft{, cutadres});
    col.DisplayWidth:=50;

    AddColToGVB(gvb, 'NOMER_DISCON', '�����', alLeft);
    col:=AddColToGVB(gvb, 'adress_disc', '������'+#13+'����������', alLeft{, cutadres});
    col.DisplayWidth:=-1;
    col:=AddColToGVB(gvb, 'coment', '����������', alLeft);
    col.DisplayWidth:=50;
    if F_dm.listkod<>nil then
    begin
      for i:=0 to F_dm.listkod.Count-1 do
       AddColToGVB(gvb, 'kod'+F_dm.listkod[i], '��� �-�'+#13+F_dm.listkod[i], alCenter);

    end;
     AddColToGVB(gvb, 'dttm_discon', '���� ����������', alCenter);
     AddColToGVB(gvb, 'dttm_con', '���� ���������', alCenter);
     AddColToGVB(gvb, 'longminute', '����.'+#13+'�������', alCenter);
     AddColToGVB(gvb, 'empty', 'ʳ������ ��������'+#13+'���������', alCenter);
     AddColToGVB(gvb, 'empty', 'ʳ������ ��������'+#13+'�����������', alCenter);
     AddColToGVB(gvb, 'empty', '�������', alLeft);
     AddColToGVB(gvb, 'nomer1', '�'+#13+'������', alCenter);
    AddColToGVB(gvb, 'region', '�����', alLeft);
    AddColToGVB(gvb, 'revs', '�������', alLeft);
    AddColToGVB(gvb, 'setlers', '�������', alLeft);




    gvb.BuildGridView;
  finally
    gvb.Free;
  end;
end;

procedure TDiskonForm13Group.PrepareResultFormHeader;
begin
  F_ResFrm.CenterLabel:=
    AnsiUpperCase( F_Name ) + #13 +
    ' �� ������ c '+formatDateTime('dd.mm.yyyy hh:mm',F_optFrm.DateIn)+
    ' �� '+formatDateTime('dd.mm.yyyy hh:mm',F_optFrm.DateOut);
end;

procedure TDiskonForm13Group.PrintBtnClick(Sender: TObject);
begin
  PrintFastReport(F_DM.frReport);
   F_PreviewFrm.ShowModal;
end;


procedure TDiskonForm13Group.PrepareResultFormBtns;
begin

  F_ResFrm.btn_Print.OnClick:=PrintBtnClick;
  F_ResFrm.btn_Order.OnClick:=ZavBtnClick;
  f_resFrm.btn_Excel.OnClick:=OnExel;

end;

procedure TDiskonForm13Group.ZavBtnClick(Sender: TObject);
begin
  with F_ResFrm do
    if Assigned(Grid.Objects[0,Grid.Row]) then
      ShowZav(integer(Grid.Objects[0,Grid.Row]));
end;

procedure TDiskonForm13Group.OnExel(Sender: TObject);
begin

 GridToExel(F_ResFrm.Grid,f_name,f_name,
             [
             AnsiUpperCase( F_Name ) +
            ' �� ������ c '+formatDateTime('dd.mm.yyyy hh:mm',F_optFrm.DateIn)+
            ' �� '+formatDateTime('dd.mm.yyyy hh:mm',F_optFrm.DateOut)]);
end ;

procedure TDiskonForm13Group.cutadres(ShowValue: variant; var Res: string) ;
begin
  res:=String(ShowValue);
  res:=LineToMultiLine(res,50);
end;

end.
