unit VedomsUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, Mask, ToolEdit, ExtCtrls,
  FRMLANG,cntsLANG,fresult,DateUtils,VedManagerUnit,OperAttFormUnit,
  RxLookup, DB, DBTables;

type
  TVedForm=(tvfNull,tvfUtech_Vodopr,tvfUtech_Other,tvfUtech_Vodomer,tvfUstran, tvfUstran_vod,
  tvfAbon,tvfVipoln,tvfKolvo,tvfDelZayav,tvfViborPoUl,tvfPostupAbon);

  TVedomsForm = class(TOperAttForm)
    BB_Ok: TBitBtn;
    BB_esc: TBitBtn;
    OutPanel: TPanel;
    InPanel: TPanel;
    Label3: TLabel;
    DE_In: TDateEdit;
    TE_In: TDateTimePicker;
    OLD_OK_BitBtn: TBitBtn;
    P_Ul: TPanel;
    Label1: TLabel;
    DBL_ul1: TRxDBLookupCombo;
    Qry_ul1: TQuery;
    DS_ul1: TDataSource;
    Label2: TLabel;
    DE_Out: TDateEdit;
    TE_Out: TDateTimePicker;
    P_Blag: TPanel;
    rb_AllZav: TRadioButton;
    rb_NeedBlagZav: TRadioButton;
    procedure FormCreate(Sender: TObject);
    procedure OLD_OK_BitBtnClick(Sender: TObject);
    procedure BB_OkClick(Sender: TObject);
    procedure BB_escClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FvedForm:TVedForm;
    ZMode:integer;
    StrAttach:string;
    FvedFormName:string;
    procedure _ShowReport(_RepExp:TRepExp);
  public
    { Public declarations }
    constructor SZ_VedomsCreate(AOwner:TComponent; Mode:integer; vedForm:TVedForm);
  end;

function NN_utechki(id,col:integer;var ss:string):integer;
function NN_abon(id,col:integer;var ss:string):integer;

var
  VedomsForm: TVedomsForm;

implementation


{$R *.dfm}

constructor TVedomsForm.SZ_VedomsCreate(AOwner:TComponent;Mode:integer;
  vedForm:TVedForm);
 begin
   ZMode:=Mode;
   FvedForm:=vedForm;
   inherited Create(AOwner);
 end;

procedure TVedomsForm.FormCreate(Sender: TObject);
begin
  inherited;
  case FvedForm of
    tvfUtech_Vodopr:
      begin
        Caption:=TrLangMSG(msgVedUtech_Vodopr);
        FvedFormName:='utechki_vodopr';
        OutPanel.Hide;
        Label3.Caption:='На';
        Width:=308;
      end;
    tvfUtech_Other:
      begin
        Caption:=TrLangMSG(msgVedUtech_Other);
        FvedFormName:='utechki_other';
        OutPanel.Hide;
        Label3.Caption:='На';
        Width:=308;
      end;
    tvfUtech_Vodomer:
      begin
        Caption:=TrLangMSG(msgVedUtech_Vodomer);
        FvedFormName:='utechki_vodomer';
        OutPanel.Hide;
        Label3.Caption:='На';
        Width:=308;
      end;
    tvfUstran:
      begin
        Caption:=TrLangMSG(msgVedUstran);
        FvedFormName:='ustran';
      end;
    tvfUstran_vod:
      begin
        Caption:=TrLangMSG(msgVedUstran_vod);
        FvedFormName:='ustran_vod';
      end;
    tvfAbon:
      begin
        Caption:=TrLangMSG(msgVedAbon);
        FvedFormName:='abon';
        OutPanel.Hide;
        Label3.Caption:='На';
        Width:=308;
      end;
    tvfVipoln:
      begin
        Caption:=TrLangMSG(msgVedVipoln);
        P_Blag.Visible := TRUE;
        FvedFormName:='vipoln';
      end;  
    tvfKolvo:
      begin
        Caption:=TrLangMSG(msgVedKolvo);
        FvedFormName:='kolvo';
        TE_In.Hide;
        TE_Out.Hide;
      end;
    tvfDelZayav:
      begin
        Caption:=TrLangMSG(msgDelZayav);
        FvedFormName:='DelZayav';
        {TE_In.Hide;
        TE_Out.Hide;}
      end;
    tvfViborPoUl:
       begin
        Qry_Ul1.Open;
        P_Ul.Visible:=TRUE;
        Caption:=TrLangMSG(msgViborPoUl);
        FvedFormName:='ViborPoUl';
      end;
    tvfPostupAbon:
      begin
        Caption:=TrLangMSG(msgVedPostupAbon);
        FvedFormName:='PostupAbon';
      end;
  end;
  //
  DE_In.Date:=MyNow;
  DE_Out.Date:=MyNow;
  if OutPanel.Visible then
    begin
      TE_In.Time:=StrToDateTime(DateToStr(DE_In.Date)+' 00:00:00');
      TE_Out.Time:=StrToDateTime(DateToStr(DE_Out.Date)+' 23:59:59');
    end
      else
    begin
      TE_In.Time:=StrToDateTime(DateToStr(DE_In.Date)+' 08:00:00');
      //TE_In.Time:=MyNow;
      //TE_Out.Time:=MyNow;
    end;
  //  
  DM_VedManager:=TDM_VedManager.Create(self);
end;

//

function NN_utechki(id,col:integer;var ss:string):integer;
begin
  if (col=5) then
  begin
    Result:=0;
  end else result:=1;
end;

function NN_abon(id,col:integer;var ss:string):integer;
begin
  if (col=5) then
  begin
    Result:=0;
  end else result:=1;
end;

procedure TVedomsForm.OLD_OK_BitBtnClick(Sender: TObject);
var FRes:TFormResult;
    sTit:TstringList;
    tt_dt,tt_str,tt_sql,tt_sql2,tt_tit:string;
    tzav_n,tzav_sql:string;
    rayon_n,rayon_sql:string;
    str1 :string;
begin
  inherited;
  tzav_n:=DE_In.Text+' '+TimeToStr(TE_In.DateTime);
  sTit:=TStringList.Create;
  sTit.Clear;
  tt_dt:='(z.dt_in<='''+DateToStr(DE_In.Date)+' '+TimeToStr(TE_In.Date)+''') ';
  //sTit.Add(TrLangMSG(msgREV));
  sTit.Add('Номер');sTit.Add('Дата');sTit.Add(TrLangMSG(msgAddr));
  sTit.Add(TrLangMSG(msgContext){'Характер'});sTit.Add(TrLangMSG(msgDiamShort));
  FRes:=TFormResult.ResCreate(Self,false,'dbn_avar','Результат',TrLangMSG(msgVedUtech)+' ('+
                  tzav_n+') '+tt_tit,
           'select z.id,z.id_ul1,z.id_ul2,z.kod_ul,z.dop_adr, '+
           'z.nomer pole0, z.dt_in pole1,'+
           //
           {'(select rtrim(u.name_r)||" "||rtrim(v.name_r) '+
            'from s_ulic u,s_vidul v '+
            'where (u.del=''-'') and (u.id_vidul>-2) and (u.id_vidul=v.id) '+
            'and (u.id=z.id_ul1)) as pole2, '+}
            //
           'sd.name_r pole3, dm.diam pole4 '+
           'FROM nzavjav z,s_diam dm, s_sod sd '+
           'where (delz=0) and (dm.id=z.id_diam) and (z.id_sod=sd.id) and '+
            tt_dt+
           ' order by z.dt_in,z.nomer'
           ,sTit,2,NN_utechki,false);
  FRes.ShowModal;
  sTit.Free;
end;

procedure TVedomsForm.BB_OkClick(Sender: TObject);
begin
  inherited;
  _ShowReport(treShow);
end;

procedure TVedomsForm._ShowReport(_RepExp:TRepExp);
begin
  try
    DM_VedManager.LoadVedReport(FvedFormName);
    DM_VedManager.DT_In:=DateOf(DE_In.Date)+TimeOf(TE_In.Time);
    DM_VedManager.DT_Out:=DateOf(DE_Out.Date)+TimeOf(TE_Out.Time);
    if P_Ul.Visible then
      begin
        DM_VedManager.OperateAttach:=OperateAttach;
        DM_VedManager.NameUl:=Qry_Ul1.FieldByName('name_r').AsString;
        DM_VedManager.IDUl:=Qry_Ul1.FieldByName('ID').AsInteger;
      end;  
    if P_Blag.Visible then
    begin
      if rb_AllZav.Checked then
        DM_VedManager.BlagType := btAll
      else
        DM_VedManager.BlagType := btNeedBlag;
    end;
    DM_VedManager.ShowReport(_RepExp);
  except
    //DM_VedManager.Free;
    on E:Exception do
      begin
        MessageBox(handle,PChar('TVedomsForm._ShowReport:'#13+E.Message),
                'Диспетчер АВР', MB_OK or MB_ICONWARNING);
      end;                
  end;
end;

procedure TVedomsForm.BB_escClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TVedomsForm.FormDestroy(Sender: TObject);
begin
  inherited;
  DM_VedManager.Free;
end;

end.
