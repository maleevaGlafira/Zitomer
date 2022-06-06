unit IB_Reports;

interface

uses SysUtils, CustomReport, GridViewBuilder, WaitProcessForm, AnalysisViewForm,
      AliGrid, IBDatabase, Windows, db, Classes, Controls, Graphics, FR_Class,
      FR_DSet, IBCustomDataSet, Math;

type
  TSimpleBaseReport=class(TCustomReport)
  private
    function GetResultFormGrid: TStringAlignGrid;
    procedure PrintBtnClick(Sender: TObject);
    procedure OrderBtnClick(Sender: TObject);
  public
    function Execute: boolean; override;
  end;

  TZavWithImage=class(TSimpleBaseReport)
  private
    function IDRecToStr(dset: TIBDataSet): string;
    function GetPotencialZavID: string;
    function GetZavIDWithImage: string;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareResultFormHeader; override;
    procedure PrepareResultFormGrid; override;
    procedure PrepareResultFormBtns; override;
    procedure PrepareFastReport; override;
  end;


implementation

uses ServiceFuncUnit, OperAttFormUnit, zav, main, ZavWithImageOptForm;

{ TSimpleBaseReport }

function TSimpleBaseReport.Execute: boolean;
var
  WaitForm: Tfrm_WaitProcess;
begin
  Result:=false;

  if not ShowOptionForm then exit;

  WaitForm:=Tfrm_WaitProcess.Create(nil);
  try
    WaitForm.Show;
    PrepareResultFormHeader;
    PrepareResultFormBtns;
    PrepareResultFormGrid;
    WaitForm.Close;
  finally
    WaitForm.Free;
  end;

  F_ResultForm.ShowModal;

  Result:=true;
end;

function TSimpleBaseReport.GetResultFormGrid: TStringAlignGrid;
var
  i: integer;
begin
  for i:=0 to F_ResultForm.ComponentCount-1 do
    if (F_ResultForm.Components[i] is TStringAlignGrid) then
    begin
      Result:=(F_ResultForm.Components[i] as TStringAlignGrid);
      break;
    end;
end;


procedure TSimpleBaseReport.OrderBtnClick(Sender: TObject);
var
  Grid: TStringAlignGrid;
  ZvForm:TFormZav;
begin
  Grid:=GetResultFormGrid;
  if (not Assigned(Grid)) or (not Assigned(Grid.Objects[0,Grid.Row])) then exit;

  ZvForm:=TFormZav.ZavCreate(nil,tfmZayavAfterInsert,integer(Grid.Objects[0,Grid.Row]));
  ZvForm.ShowModal;
  if CloseStatus<>0 then
    repeat
      if CloseStatus=2 then
        ZvForm:=TFormZav.ZavCreate(nil,tfmZayavCopy,ZavToCopy)
      else
        ZvForm:=TFormZav.ZavCreate(nil,tfmZayavNew,0);

      ZvForm.ShowModal;
    until CloseStatus=0;
end;

procedure TSimpleBaseReport.PrintBtnClick(Sender: TObject);
begin
  if not LoadReportFile then exit;
  PrepareFastReport;

  ShowReport;
end;

{ TZavWithImage }

procedure TZavWithImage.CreateForms;
begin
  F_OptionForm:=Tfrm_ZavWithImageOpt.Create(nil, F_Name);
  F_ResultForm:=Tfrm_AnalysisView.Create(nil, F_Name);
end;

function TZavWithImage.GetPotencialZavID: string;
var
  zAttach: string;
  minOpen,minClosed, maxOpen, maxClosed, _minID, _maxID: integer;
begin
  _minID:=1; _maxID:=1;
  with (F_OptionForm as Tfrm_ZavWithImageOpt) do
  begin
    zAttach:='';//' and id_attach='+IntToStr(ord(OperateAttach));//+1);  - пусть ВСЁ выбирается
    MyOpenIBDS(F_Dset[0],
      ' select min(id), max(id) from nzavjav'+
      ' where dt_in>'''+DateToStr(dp_Date1.date)+''' and dt_in<='''+DateToStr(dp_Date2.Date+1)+''''+
      ' and delz=0'+zAttach+
      ' union all'+
      ' select min(id), max(id) from zavjav'+
      ' where dt_in>'''+DateToStr(dp_Date1.date)+''' and dt_in<='''+DateToStr(dp_Date2.Date+1)+''''+
      ' and delz=0'+zAttach);
  end; // end with

 // Result:=IDRecToStr(F_Dset[0]);

  F_Dset[0].First;

    minOpen := F_Dset[0].FieldByName('min').AsInteger;
    maxOpen := F_Dset[0].FieldByName('max').AsInteger;
    F_Dset[0].Next;
    minClosed := F_Dset[0].FieldByName('min').AsInteger;
    maxClosed := F_Dset[0].FieldByName('max').AsInteger;

    if (minOpen >0 )and(minClosed > 0) then
    begin
       _minID := min(minOpen, minClosed);
       _maxID := max(maxOpen, maxClosed);
    end
    else
     if minOpen > 0 then
        begin
         _minID := minOpen;
         _maxID := maxOpen;
        end else
          if minClosed >0 then
            begin
             _minID := minClosed;
             _maxID := maxClosed;
            end;

    Result:= ' id_zav >= ' + inttostr( _minID) +
              ' and id_zav <= ' + inttostr( _maxID);

end;

function TZavWithImage.GetZavIDWithImage: string;
var
  tr: TIBTransaction;
  id_potenc: string;
begin
  Result:='';

  id_potenc:=GetPotencialZavID;
  if id_potenc='' then exit;

  tr:=F_AvrImageDset.Transaction;
  if tr.InTransaction then
    tr.Rollback;
  tr.StartTransaction;
  try
    MyOpenIBDS(F_AvrImageDset,
      ' select id_zav id from avr_image'+
     // ' where id_zav in '+id_potenc);
      ' where '+id_potenc);
    Result:=IDRecToStr(F_AvrImageDset);
    tr.Commit;
  except
    tr.Rollback;
    raise;
  end;
end;

function TZavWithImage.IDRecToStr(dset: TIBDataSet): string;
begin
  Result:='';

  if not dset.Active then dset.Open;

  dset.First;
  while not dset.Eof do
  begin
    Result:=Result+','+dset.FieldByName('id').AsString;
    dset.Next;
  end;

  Delete(Result, 1, 1);

  if Result<>'' then
    Result:='('+Result+')';
end;

procedure TZavWithImage.InitFields;
begin
  F_Name:='Ведомость заявок с изображениями';
  F_ReportFileName:='ZavWithImage.frf';
end;

procedure TZavWithImage.PrepareFastReport;
begin
  with (F_OptionForm as Tfrm_ZavWithImageOpt) do
  begin
    frVariables['dt_begin']:=DateToStr(dp_Date1.Date);
    frVariables['dt_end']:=DateToStr(dp_Date2.Date);
  end;
end;

procedure TZavWithImage.PrepareResultFormBtns;
begin
  with (F_ResultForm as Tfrm_AnalysisView) do
  begin
    btn_Order.OnClick:=OrderBtnClick;
    btn_Print.OnClick:=PrintBtnClick;
  end;
end;

procedure TZavWithImage.PrepareResultFormGrid;
var
  GVB: TGridViewBuilder;
  id_with_img: string;
begin
  id_with_img:=GetZavIDWithImage;

  if id_with_img='' then id_with_img:='(-1,0)';{raise Exception.Create('Данные за указанный период отсутствуют');}
{
  AddSelSQLToIBdset(F_Dset[0],
    ' select z.id, z.dt_in, z.nomer,'+
    ' (select adres from get_adres(z.id_ul1,z.id_ul2,z.kod_ul,z.dop_adr,z.id_dopadres)) adres'+
    ' from zavjav z'+
    ' where z.id in'+id_with_img+
    ' union all'+
    ' select z.id, z.dt_in, z.nomer,'+
    ' (select adres from get_adres(z.id_ul1,z.id_ul2,z.kod_ul,z.dop_adr,z.id_dopadres)) adres'+
    ' from nzavjav z'+
    ' where z.id in'+id_with_img+
    ' order by 2');

  GVB:=TGridViewBuilder.Create(F_Dset[0], (F_ResultForm as Tfrm_AnalysisView).Grid);
  try
    AddColToGVB(GVB, 'dt_in', 'Дата'+#13+'поступления', alCenter);
    AddColToGVB(GVB, 'nomer', 'Номер'+#13+'заявки', alCenter);
    AddColToGVB(GVB, 'adres', 'Адрес', Aligrid.alLeft);
    GVB.IsNumberRecord:=true;
    GVB.IDFieldName:='ID';
 }


   AddSelSQLToIBdset(F_Dset[0],
    ' select z.id, z.dt_in, z.nomer,'+
    ' (select adres from get_adres(z.id_ul1,z.id_ul2,z.kod_ul,z.dop_adr,z.id_dopadres)) adres'+
    ' ,(select sa.name_r from s_attach sa where sa.id = z.id_attach) sattach '+
    ' from zavjav z'+
    ' where z.id in'+id_with_img+
    ' union all'+
    ' select z.id, z.dt_in, z.nomer,'+
    ' (select adres from get_adres(z.id_ul1,z.id_ul2,z.kod_ul,z.dop_adr,z.id_dopadres)) adres'+
    ' ,(select sa.name_r from s_attach sa where sa.id = z.id_attach) sattach '+
    ' from nzavjav z'+
    ' where z.id in'+id_with_img+
    ' order by 2');

  GVB:=TGridViewBuilder.Create(F_Dset[0], (F_ResultForm as Tfrm_AnalysisView).Grid);
  try
    AddColToGVB(GVB, 'dt_in', 'Дата'+#13+'поступления', alCenter);
    AddColToGVB(GVB, 'nomer', 'Номер'+#13+'заявки', alCenter);
    AddColToGVB(GVB, 'adres', 'Адрес', Aligrid.alLeft);
    AddColToGVB(GVB, 'sattach', 'Принадл.', Aligrid.alLeft);

    GVB.IsNumberRecord:=true;
    GVB.IDFieldName:='ID';



    GVB.BuildGridView;
  finally
    GVB.Free;
  end;
end;

procedure TZavWithImage.PrepareResultFormHeader;
begin
  with (F_ResultForm as Tfrm_AnalysisView),
        (F_OptionForm as Tfrm_ZavWithImageOpt) do
  begin
    CenterLabel:='Ведомость заявок с изображениями за период'+#13+
                  'с '+DateToStr(dp_Date1.Date)+
                  ' по '+DateToStr(dp_Date2.Date);
  end;
end;


end.
