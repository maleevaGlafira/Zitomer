unit RepMaterMakerForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FRMLANG, Grids, DBGridEh, ExtCtrls, StdCtrls, Mask, ToolEdit,
  RxLookup, Buttons, ComCtrls, RepMaterMakerDModule, DB;

type
  TStatus  = (REmpty, ROpenDeps);
  Tfrm_RepMaterMaker = class(TFormLang)
    RxDBLBrigs: TRxDBLookupCombo;
    lbl_brigcap: TLabel;
    lbl_capReport: TLabel;
    RxDBLReports_out: TRxDBLookupCombo;
    btn_openDeps: TButton;
    pnl_Data: TPanel;
    DBG_deps: TDBGridEh;
    pnl_Bottums: TPanel;
    btn_DoReport: TBitBtn;
    btn_Close: TBitBtn;
    StatusBar1: TStatusBar;
    ds_deps: TDataSource;
    ds_brigs: TDataSource;
    ds_reports_out: TDataSource;
    btn_CloseDeps: TButton;
    btn_set_nums: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RxDBLBrigsChange(Sender: TObject);
    procedure btn_openDepsClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_CloseDepsClick(Sender: TObject);
    procedure btn_set_numsClick(Sender: TObject);
    procedure btn_DoReportClick(Sender: TObject);
  private
    { Private declarations }
    F_id_brig, f_id_out_report, F_id_report:integer;
    f_status:TStatus;
    F_dm:Tdm_RepMaterMaker;
    procedure setReposrtStatus(status:TStatus);
    procedure DoReportexel(Sender: TObject);
  public
    { Public declarations }
      procedure Translate;override;
  end;

var
  frm_RepMaterMaker: Tfrm_RepMaterMaker;

implementation

{$R *.dfm}
uses ConstRepMater, AnalysisViewForm,MemTableToExel;

procedure Tfrm_RepMaterMaker.FormCreate(Sender: TObject);
begin
  inherited;
  F_dm:=Tdm_RepMaterMaker.Create(Self);
  F_id_brig:=-1;
  f_id_out_report:=-1;
   F_id_report:=-1;

end;

procedure Tfrm_RepMaterMaker.Translate;
begin
 lbl_capReport.Caption:=ReportWord;
 btn_openDeps.Caption:=cacp_SearchDep;
 btn_CloseDeps.Caption:=cap_close_deps;
 btn_DoReport.Caption:=cap_MakeRport;
 btn_Close.Caption:=cap_close;
 Caption:=report_mater_title;
end;

procedure Tfrm_RepMaterMaker.setReposrtStatus(status:TStatus);
begin
f_status:=status;
case status of
   REmpty:begin
      RxDBLBrigs.Enabled:=true;
      RxDBLReports_out.Enabled:=(RxDBLBrigs.LookupSource.DataSet.FieldByName('id').AsInteger>0);
      if RxDBLReports_out.Enabled then
      begin
       btn_openDeps.Enabled:=(F_id_brig>0) and (F_id_out_report>0);
      end
      else
      begin
       btn_openDeps.Enabled:=false;

      end;
      btn_CloseDeps.Enabled:=false;
      btn_set_nums.Enabled:=false;
   end;

   ROpenDeps:
   begin
      RxDBLReports_out.Enabled:=false;
      RxDBLBrigs.Enabled:=false;
      btn_set_nums.Enabled:=true;
      btn_CloseDeps.Enabled:=true;
   end;
end;
end;

procedure Tfrm_RepMaterMaker.FormShow(Sender: TObject);
var s:string;
begin
  inherited;

 s:=F_dm.OpenDsets;

 if s<>'' then
   Statusbar1.Panels[0].Text:=s
 else
   F_dm.sertBrigId(-1);
 RxDBLReports_out.Enabled:=false;
 btn_openDeps.Enabled:=false;
 setReposrtStatus(REmpty);
end;

procedure Tfrm_RepMaterMaker.RxDBLBrigsChange(Sender: TObject);
  function checkrdbl(rdbl:TRxDBLookupCombo; mes:string):boolean;
  begin
  
  rdbl.Enabled:=true;
    if rdbl.LookupSource.DataSet.FieldByName('id').AsInteger<=0 then
    begin
      Statusbar1.Panels[0].Text:=mes;
      rdbl.setFocus;
      result:=false;
    end
    else
    begin
     if trim(rdbl.DisplayValue)='' then
       rdbl.DisplayValue:=rdbl.LookupSource.DataSet.fieldbyname(rdbl.LookupDisplay).asstring;
     result:=true;
    end

  end;
begin
  inherited;
if (Sender as TRxDBLookupCombo).Name = 'RxDBLBrigs' then
 F_dm.sertBrigId(RxDBLBrigs.LookupSource.DataSet.FieldByName('id').AsInteger);
if checkrdbl(RxDBLBrigs,mes_SelBrig) then
 if checkrdbl(RxDBLReports_out,mes_SelReport) then
  begin
    btn_openDeps.Enabled:=true;
  end ;
  F_id_brig:=RxDBLBrigs.LookupSource.DataSet.FieldByName('id').AsInteger;
  F_id_out_report:=RxDBLReports_out.LookupSource.DataSet.FieldByName('id').AsInteger;


{if RxDBLBrigs.LookupSource.DataSet.FieldByName('id').AsInteger<=0 then
 begin
   Statusbar1.Panels[0].Text:=mes_SelBrig;
   RxDBLReports.Enabled:=false;
 end
 else
 begin
      RxDBLReports.Enabled:=true;
      if RxDBLReports_out.LookupSource.DataSet.FieldByName('id').AsInteger<=0 then
      begin
       Statusbar1.Panels[0].Text:=mes_SelReport;
       RxDBLReports_out.SetFocus;
      end
      else
      begin
       RxDBLReports_out.DisplayValue:=RxDBLReports.LookupSource.DataSet.fieldbyname(RxDBLReports.LookupDisplay).asstring;
       if RxDBLReports.LookupSource.DataSet.FieldByName('id').AsInteger<=0
       begin
       Statusbar1.Panels[0].Text:=mes_SelReport;
       RxDBLReports_out.SetFocus;
      end
       btn_openDeps.SetFocus;
      end;

 end;}
end;

procedure Tfrm_RepMaterMaker.btn_openDepsClick(Sender: TObject);
var s:string;
begin
  inherited;
if RxDBLReports_out.LookupSource.DataSet.FieldByName('id').AsInteger<=0 then
      begin
       Statusbar1.Panels[0].Text:=mes_SelReport;
       RxDBLReports_out.SetFocus;
      end
 else
 begin
  s:=F_dm.searchDeps();
 if s<>'' then
 begin
  Statusbar1.Panels[0].Text:=s;
 end
 else
 begin
  setReposrtStatus(ROpenDeps);
   Statusbar1.Panels[0].Text:= mes_depfound;
 end


 end;

end;

procedure Tfrm_RepMaterMaker.FormDestroy(Sender: TObject);
begin
  inherited;
f_dm.Free;
end;

procedure Tfrm_RepMaterMaker.btn_CloseDepsClick(Sender: TObject);
begin
  inherited;
F_dm.closemems;
setReposrtStatus(REmpty);
Statusbar1.Panels[0].Text:='';
end;

procedure Tfrm_RepMaterMaker.btn_set_numsClick(Sender: TObject);
begin
  inherited;
F_dm.setNumbers();
Statusbar1.Panels[0].Text:='';

end;

procedure Tfrm_RepMaterMaker.btn_DoReportClick(Sender: TObject);
var frm_res:Tfrm_AnalysisView;
err:string;
begin
  inherited;
  frm_res:=Tfrm_AnalysisView.Create(self,'Матеріальний звіт');
  frm_res.CenterLabel:='Майстер '+RxDBLBrigs.LookupSource.DataSet.FieldByName('name_r').AsString;
  frm_res.LeftLabel:= 'За '+  RxDBLReports_out.LookupSource.DataSet.FieldByName('show_title').AsString;
  try
   err:= F_dm.doReport(frm_res.Grid);
   if err<>'' then
     Statusbar1.Panels[0].Text:=err
    else
    begin
     Statusbar1.Panels[0].Text:=mes_RepMaked;
     frm_res.btn_Print.OnClick:=DoReportexel;
     frm_res.ShowModal;
    end

  finally
   frm_res.Free;
  end;
end;

procedure Tfrm_RepMaterMaker.DoReportexel(Sender: TObject);
var title,title_l2, about:string;
begin
  title:=report_mater_title_l1;
  title_l2:=report_mater_title_l2+' Майстер '+RxDBLBrigs.LookupSource.DataSet.FieldByName('name_r').AsString;
  about:=format(report_mater_title_l3,[RxDBLReports_out.LookupSource.DataSet.FieldByName('month').asstring,
       RxDBLReports_out.LookupSource.DataSet.FieldByName('NUM_YEAR').asinteger]);
  MaterTableToExel(F_dm.mem_report,title,10,'',0,about,'СВОДКА', title_l2);
end;

end.
