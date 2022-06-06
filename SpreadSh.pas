unit SpreadSh;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, RxQuery, ComCtrls, Buttons, StdCtrls, Mask, ToolEdit, Math,
  ExtCtrls, frmLANG, cntsLANG, fresult2,Variants, RxStrUtils,OperAttFormUnit,
  IBCustomDataSet, IBDatabase, FR_Class, FR_DSet, FR_DBSet, FrPreviewForm;

type
  TfmSpreadSh = class(TOperAttForm)
    Panel1: TPanel;
    DateEdit_N: TDateEdit;
    buRaon: TButton;
    Panel2: TPanel;
    buFind: TBitBtn;
    buQuit: TBitBtn;
    Animate1: TAnimate;
    SBar: TStatusBar;
    Label1: TLabel;
    dset_tmp: TIBDataSet;
    tran_tmp: TIBTransaction;
    frReport: TfrReport;
    frDB_SvodVed: TfrDBDataSet;
    dset_wwater: TIBDataSet;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure buRaonClick(Sender: TObject);
    procedure buQuitClick(Sender: TObject);
    procedure buFindClick(Sender: TObject);
    procedure DateEdit_NEnter(Sender: TObject);
    procedure DateEdit_NExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FrPreviewForm: Tfrm_FrPreview;
    MainGrArr: array[1..4] of string;
  private
    procedure OnMainGrHeaderShow(DataSet: TDataSet;
        AggregateValueArr: array of double; var OutRow: TStringList);
    procedure OnRevsHeaderShow(DataSet: TDataSet;
        AggregateValueArr: array of double; var OutRow: TStringList);
    procedure OnColumnCellShow(ShowValue: variant; var Res: string);
    procedure OnStrCellShow(ShowValue: variant; var Res: string);
  public
    procedure PrintClick(Sender: TObject);
  end;

var
  fmSpreadSh : TfmSpreadSh;

implementation

uses DataM, SelForm{,strtool}, main, Aligrid, Grids, GridViewBuilder, DMMain,
      ServiceFuncUnit, AvrDBConst;

var
  SPer_Revs_DL,SREVS_TXT_DL:string;

{$R *.DFM}


procedure TfmSpreadSh.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action:=caFree;
end;

procedure TfmSpreadSh.buRaonClick(Sender: TObject);
var rr : TSelectForm;
begin
   rr:=TSelectForm.Create(self);
   rr.Query.SQL.text:='select id code,name_r pole1 from s_revs where (id>0) and del=''-''';
   rr.ShowModal;
   if rr.Temp_Code<>'' then
        SPer_Revs_DL:=' and z.id_revs in '+rr.temp_code;
   SREVS_TXT_DL:=rr.seltext;
end;

procedure TfmSpreadSh.buQuitClick(Sender: TObject);
begin
  Close;
end;

procedure TfmSpreadSh.buFindClick(Sender: TObject);
var
  GVB: TGridViewBuilder;
  GBCol: TGBColumn;
  zAttach: string;
  ViewForm : TFormResult2;

  procedure AddGrp(const GroupField: string; OnHeaderShow: TShowGroupBorderCaptionEvent;
                   Color: TColor);
  var
    Grp: TGroup;
  begin
    Grp:=GVB.AddGroup(GroupField);
    Grp.GroupHeader.Visible:=true;
    Grp.GroupFooter.Visible:=false;
    Grp.GroupHeader.Font.Style:=[fsBold];
    Grp.GroupHeader.Color:=Color;
    Grp.GroupHeader.Alignment:=alCenter;
    Grp.IsNumberRecordInGroup:=true;
    Grp.GroupHeader.OnShowCaption:=OnHeaderShow;
  end;

begin
  try
    StrToDate(DateEdit_N.Text);
   except
    ShowMessage('Введите дату!!!!');
    DateEdit_N.SetFocus;
    exit;
  end;

  if tran_tmp.InTransaction then
    tran_tmp.Rollback;
  tran_tmp.StartTransaction;
  try
    ViewForm:=TFormResult2.ResCreateEmpty(self);
    try
      GVB:=TGridViewBuilder.Create(dset_tmp, ViewForm.StrGr_res);
      with GVB do
      begin
        try
          zAttach:=' and z.id_attach='+IntToStr(ord(OperateAttach));

          dset_tmp.Close;
          dset_tmp.SelectSQL.Clear;
          dset_tmp.SelectSQL.Text:=
          ' select 1 MainGr, z.id, z.dt_in, z.id_revs,'+
          ' (select name_r from s_revs where id=z.id_revs) revs,'+
          ' (select adres from get_adres(z.id_ul1,z.id_ul2,z.kod_ul,z.dop_adr,z.id_dopadres)) adres,'+
          '  cast(''  '' as char(40)) mest,'+
          '  cast(''  '' as char(15)) matpipe,'+
          '  cast(''  '' as char(40)) sod,'+
          '  cast(-1 as integer) diam,'+
          '  cast(''  '' as varchar(500)) Rekomend,'+
          '  (select wwater_list from get_wwater_list(z.id)) wwater'+
          ' from nzavjav z'+
          ' where id_alien=4'+zAttach+SPer_Revs_DL+
          ' and delz=0'+
          ' and (z.dt_in between '''+DateToStr(DateEdit_N.Date)+' 08:00:00'' and '''+DateToStr(DateEdit_N.Date+1)+' 07:59:59'') '+
          ' union all'+
          ' select 2 MainGr, z.id, z.dt_in, z.id_revs,'+
          ' (select name_r from s_revs where id=z.id_revs) revs,'+
          ' (select adres from get_adres(z.id_ul1,z.id_ul2,z.kod_ul,z.dop_adr,z.id_dopadres)) adres,'+
          '  cast(''  '' as char(40)) mest,'+
          '  cast(''  '' as char(15)) matpipe,'+
          '  cast(''  '' as char(40)) sod,'+
          '  cast(-1 as integer) diam,'+
          '  cast(''  '' as varchar(500)) Rekomend,'+
          '  (select wwater_list from get_wwater_list(z.id)) wwater'+
          ' from nzavjav z'+
          ' where id_alien=4'+zAttach+SPer_Revs_DL+
          ' and delz=0'+
          ' and z.dt_in<'''+DateToStr(DateEdit_N.Date)+' 08:00:00'''+
          ' union all'+
          ' select 3 MainGr, z.id, z.dt_in, z.id_revs,'+
          ' (select name_r from s_revs where id=z.id_revs) revs,'+
          ' (select adres from get_adres(z.id_ul1,z.id_ul2,z.kod_ul,z.dop_adr,z.id_dopadres)) adres,'+
          ' (select name_r from s_mest where id=z.id_mest) mest,'+
          ' (select name_r from s_matpipe where id=z.id_matpipe) matpipe,'+
          ' (select name_r from s_sod where id=z.id_sod) sod,'+
          ' (select diam from s_diam where id=z.id_diam) diam,'+
          ' (select dop_inf from nnarad  where (id_zav=z.id) and (nomer='+
          '        (select max(nomer) from nnarad where id_zav=z.id) ) ) Rekomend,'+
          '  (select wwater_list from get_wwater_list(z.id)) wwater'+
          ' from nzavjav z'+
          ' where not id_alien in (3,4)'+zAttach+SPer_Revs_DL+
          ' and delz=0'+
          ' and z.dt_in<='''+DateToStr(DateEdit_N.Date+1)+' 07:59:59'''+
          ' union all'+
          ' select 4 MainGr, z.id, z.dt_in, z.id_revs,'+
          ' (select name_r from s_revs where id=z.id_revs) revs,'+
          ' (select adres from get_adres(z.id_ul1,z.id_ul2,z.kod_ul,z.dop_adr,z.id_dopadres)) adres,'+
          ' (select name_r from s_mest where id=z.id_mest) mest,'+
          '  cast(''  '' as char(15)) matpipe,'+
          '  cast(''  '' as char(40)) sod,'+
          '  cast(-1 as integer) diam,'+
          '  cast(''  '' as varchar(500)) Rekomend,'+
          '  (select wwater_list from get_wwater_list(z.id)) wwater'+
          ' from zavjav z'+
          ' where not id_alien in (3,4)'+zAttach+SPer_Revs_DL+
          ' and delz=0'+
          ' and z.dt_in<='''+DateToStr(DateEdit_N.Date+1)+' 07:59:59'''+
          //' and exists(select id from raskop where  (id_zavin=z.id) and (dt_out is null))'+
          ' and exists(select out_id from get_zav_raskops( z.id, ' +
            IntToStr( Ord( tsc_sw_ZASIPKA ) ) + ', -1, -1, -1 ) where out_dt_work1 is null)' +
          ' order by 1,5,3';

          IDFieldName:='ID';

          AddColToGVB(GVB, 'dt_in', 'Дата'+#13+'поступления', alCenter);
          AddColToGVB(GVB, 'adres', 'Адрес');
          AddColToGVB(GVB, 'mest', 'Местность'+#13+'повреждения', alLeft, OnStrCellShow);
          AddColToGVB(GVB, 'matpipe', 'Материал'+#13+'трубы', alLeft, OnStrCellShow);
          AddColToGVB(GVB, 'sod', 'Характер'+#13+'повреждения', alLeft, OnStrCellShow);
          AddColToGVB(GVB, 'diam', 'Диаметр', alCenter, OnColumnCellShow);
          GBCol:=AddColToGVB(GVB, 'rekomend', 'Меры и рекомендаци'+#13+'по локализаци');
          GBCol.DisplayWidth:=50;
          GBCol:=AddColToGVB(GVB, 'wwater', 'Абоненты'+#13+'без воды');
          GBCol.DisplayWidth:=50;

          AddGrp('MainGr', OnMainGrHeaderShow, clAqua);
          AddGrp('id_revs', OnRevsHeaderShow, clGrayText);

          BuildGridView;
        finally
          GVB.Free;
        end;
      end; // end with

      ViewForm.Lb_usl.Caption:='Сводная ведомость за смену '+DateEdit_N.Text+#13#10+SREVS_TXT_DL;
      ViewForm.BB_Print.OnClick:=PrintClick;

      ViewForm.ShowModal;
    finally
      ViewForm.Free;
    end;

    tran_tmp.Commit;
  except
    tran_tmp.Rollback;
    raise;
  end;
end;





procedure TfmSpreadSh.DateEdit_NEnter(Sender: TObject);
begin
  inherited;
  DateEdit_N.Color:=New_Col;
end;

procedure TfmSpreadSh.DateEdit_NExit(Sender: TObject);
begin
  inherited;
 If DateEdit_N.Text<>'  .  .    ' Then begin
     try
       StrToDate(DateEdit_N.Text);
     except
       beep;
       IF MessageDlg('Дата введена не верно. Продолжить ввод?', mtWarning,[mbYes, mbNo],0)= mrYes Then begin
          DateEdit_N.SetFocus;
       end
       else begin
          DateEdit_N.Text:='  .  .    ';
       end;
     end;
   end;
  DateEdit_N.Color:=Old_Col;
end;

procedure TfmSpreadSh.FormCreate(Sender: TObject);
begin
  inherited;
  fmSpreadSh:=self;
  SPer_Revs_DL:='';

  MainGrArr[1]:='НА ВЫЯСНЕНИИ ЗА СМЕНУ';
  MainGrArr[2]:='НА ВЫЯСНЕНИИ НА ДАННЫЙ МОМЕНТ';
  MainGrArr[3]:='НЕЗАКРЫТЫЕ';
  MainGrArr[4]:='ТРЕБУЮТ БЛАГОУСТРОЙСТВА';

  FrPreviewForm:=Tfrm_FrPreview.Create(self, frReport);
  frReport.Preview:=FrPreviewForm.frPreview;
end;


procedure TfmSpreadSh.OnMainGrHeaderShow(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
var
  i: integer;
begin
  for i:=1 to 3 do
    OutRow.Add(' ');

  i:=DataSet.FieldByName('MainGr').AsInteger;
  OutRow.Add(MainGrArr[i]);
end;

procedure TfmSpreadSh.OnRevsHeaderShow(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
var
  i: integer;
begin
  for i:=1 to 3 do
    OutRow.Add(' ');

  OutRow.Add(trim(DataSet.FieldByName('revs').AsString));
end;


procedure TfmSpreadSh.OnColumnCellShow(ShowValue: variant;
  var Res: string);
begin
  if (ShowValue=0) or (ShowValue=-1) then
       Res:='';
end;

procedure TfmSpreadSh.PrintClick(Sender: TObject);
var
  RepFileName: string;
  i: integer;
begin
  RepFileName:=ExtractFilePath(ParamStr(0))+'all_reports\svod_ved.frf';
  if not frReport.LoadFromFile(RepFileName) then
  begin
    Application.MessageBox(PChar('Не могу загрузить файл '+RepFileName),
                                'Диспетчер АВР',MB_OK+MB_ICONERROR);
    exit;
  end;


  frVariables['dat']:=DateToStr(DateEdit_N.Date);
  if SREVS_TXT_DL<>'' then
    frVariables['rayon']:=SREVS_TXT_DL
  else
    frVariables['rayon']:='(ВСЕ)';

  case OperateAttach of
    toaVoda: frVariables['Attach']:='ВОДОПРОВОД';
    toaKanal: frVariables['Attach']:='КАНАЛИЗАЦИЯ';
    toaVRK: frVariables['Attach']:='ВРК';
  end;

  for i:=low(MainGrArr) to high(MainGrArr) do
  begin
    frVariables['Arr_MainGr_'+IntToStr(i)]:=MainGrArr[i];
    frVariables['Arr_CIG_Arrey_'+IntToStr(i)]:=0;
  end;

  frReport.PrepareReport;
  frReport.ShowReport;
  FrPreviewForm.ShowModal;
end;

procedure TfmSpreadSh.FormDestroy(Sender: TObject);
begin
  inherited;
  FrPreviewForm.Free;
end;

procedure TfmSpreadSh.OnStrCellShow(ShowValue: variant; var Res: string);
begin
  Res:=DeletePusto(Res);
end;

end.
