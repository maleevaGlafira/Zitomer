unit OborsSh;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, RxQuery, ComCtrls, Buttons, StdCtrls, Mask, ToolEdit, Math,
  ExtCtrls, frmLANG, cntsLANG, fresult,Variants,OperAttFormUnit, DateUtils;

type
  TfmOborsSh = class(TOperAttForm)
    Panel1: TPanel;
    lbDate: TLabel;
    lbPo: TLabel;
    DateEdit_N: TDateEdit;
    DateEdit_K: TDateEdit;
    buRaon: TButton;
    buVID: TButton;
    Panel2: TPanel;
    buFind: TBitBtn;
    buQuit: TBitBtn;
    Animate1: TAnimate;
    SBar: TStatusBar;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure buRaonClick(Sender: TObject);
    procedure buVIDClick(Sender: TObject);
    procedure buQuitClick(Sender: TObject);
    procedure buFindClick(Sender: TObject);
    procedure DateEdit_KExit(Sender: TObject);
    procedure DateEdit_KEnter(Sender: TObject);
    procedure DateEdit_NEnter(Sender: TObject);
    procedure DateEdit_NExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    view : TFormResult;
    SumLeakage:double;
  public
    { Public declarations }
  end;

var
  fmOborsSh : TfmOborsSh;

function NN10(id,col:integer;var ss:string):integer;
function NN_OborSh(id,col:integer;var ss:string):integer;

implementation

uses DataM, SelForm{,strtool}, main;

var SPer_Raon_DL,SPer_Mesto_DL,SPer_TXT_DL,SRAON_TXT_DL,SPer_ULIC,SPer_TXT_ULIC: String;

{$R *.DFM}


function NN_OborSh(id,col:integer;var ss:string):integer;
var
  dt_float: double;
  h, m, d: word;
begin
  Result:=0;
  if col=4 then
  begin
    dt_float:=StrToFloat(ss);
    d:=trunc(dt_float);
    h:=d*24+HourOf(dt_float);
    m:=MinuteOf(dt_float);
    ss:=IntToStr(h)+':'+IntToStr(m);
  end;
end;



procedure TfmOborsSh.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action:=caFree;
end;

procedure TfmOborsSh.buRaonClick(Sender: TObject);
var rr : TSelectForm;
begin
   rr:=TSelectForm.Create(self);
   rr.Query.SQL.text:='select id code,name_r pole1 from s_revs where (id>0) and del=''-''';
   rr.ShowModal;
   if rr.Temp_Code<>'' then
     //SPer_Raon_DL:=' and( z.id_revs in '+rr.temp_code+' or zn.id_revz in '+rr.temp_code+')';
       SPer_Raon_DL:=rr.Temp_Code;
   SRAON_TXT_DL:=rr.seltext;
end;

procedure TfmOborsSh.buVIDClick(Sender: TObject);
var rr : TSelectForm;
begin
   rr:=TSelectForm.Create(self);
   rr.Query.SQL.text:='select id code,name_r pole1 from s_tzav where (id>0) and del=''-''';
   rr.ShowModal;
   if rr.Temp_Code<>'' then
    // SPer_Mesto_DL:=' and (z.id_tzav in '+rr.temp_code+' or zn.id_ztav in '+rr.temp_code+')';
     SPer_Mesto_DL:=rr.Temp_Code;
   SPer_TXT_DL:=rr.seltext;
end;

procedure TfmOborsSh.buQuitClick(Sender: TObject);
begin
  Close;
end;

procedure TfmOborsSh.buFindClick(Sender: TObject);
var s,s1,s2: string;
    sTit:TStringList;
    top_Label:string;
    zAttach:string;
    i:integer;
begin
  Sbar.SimpleText:='Идет подготовка данных';
  Sbar.Update;
  animate1.Visible:=True;
  animate1.Active:=true;
  top_label:='Анализ работы механизмов при ликвидации повреждений '+#13#10;
  zAttach:=' and z.id_attach='+IntToStr(ord(OperateAttach));
  SumLeakage:=0;
  try
  buFind.Enabled:=False;
  DateEdit_N.Enabled:=False;
  DateEdit_K.Enabled:=False;
  DM1.s_revs_q.Open;
  DM1.S_Place_q.Open;
  DM1.S_Sod_q.Open;
{
  S:='select z.id,"0" pole0,z.dt_in pole1,z.dt_out pole6,Cast(z.nomer as char(5))||z.charnum||"/"||cast(z.fyear as char(4)) pole2,z.q pole4,z.dop_adr,z.id_ul1,z.id_ul2, '+
     'z.kod_ul,z.id_place pole8,z.id_sod pole9,(select min(dt_in) from zadv b where b.id_zavin=z.id) dt_cl_bolt, '+
     'z.id_rayon pole3,"0" pole5, "'+DateToStr(DateEdit_N.date)+'" perbeg, "'+DateToStr(DateEdit_K.date)+'" perend '+
     'from zavjav z, s_attach a '+
     'where a.id=z.id_attach and z.q>0 '+zAttach;
//     'where a.id=z.id_attach ';
}
 { S:='select z.id,cast(z.nomer as char(8))||"/"||cast(z.fyear as char(8)) pole2, '+
     'so.name_r pole0, n.dt_out pole1, z.id_ul1,z.id_ul2,z.kod_ul,z.dop_adr,z.id_dopadres, '+
     '(n.dt_out-n.dt_in) pole4 '+
     'from obors o, s_obor so, narad n, zavjav z '+
     'where (delz=0) and o.id_obor=so.id and o.id_nar=n.id and o.id_zav=z.id ';
  }

  S:= '  select a.* from Analiz_Mech a';
{   where
     (pole1>='10.07.2007')
     and (pole1<'14.10.2008 23:59:59')
   order by pole0, pole1'
 }
  try
     if  (SPer_Mesto_DL<>'') or(SPer_Raon_DL<>'') Then
      AppendStr(s, ' left join zavjav z on z.id=a.id '+
                    ' left join nzavjav nz on  nz.id=a.id');
  except
  end;
  try
    If  DateEdit_N.Date>0 Then
    begin
//      AppendStr(s,' and (n.dt_out>='''+DateToStr(DateEdit_N.Date)+''')');
      AppendStr(s,' where (pole1>='''+DateToStr(DateEdit_N.Date)+''')');
      top_Label:=top_label+' C '+DateEdit_N.Text;
    end;
    except
  end;

  try
    If DateEdit_K.Date>0  Then
    begin
//      AppendStr(s,' and (n.dt_out<'''+DateToStr(DateEdit_K.Date)+' 23:59:59'')');
      AppendStr(s,' and (pole1<'''+DateToStr(DateEdit_K.Date)+' 23:59:59'')');
      top_Label:=top_label+' По '+DateEdit_K.Text;
    end;
  except
  end;


  If SPer_Mesto_DL<>'' Then
  begin
    s1:=' (z.id_tzav in  '+SPer_Mesto_DL;
    s2:=' (nz.id_tzav in  '+SPer_Mesto_DL;
  //  AppendStr(s,SPer_Mesto_DL);
    AppendStr(top_label,' Место повреждения - '+SPer_TXT_DL);
  end;
  If SPer_Raon_DL<>'' Then
  begin
   if s1<>'' then begin
      s1:=s1+' and z.id_revs in '+SPer_Raon_DL;
      s2:=s2+' and nz.id_revs in '+SPer_Raon_DL;
   end
   else
   begin
     s1:=s1+'( z.id_revs in '+SPer_Raon_DL;
     s2:=s2+'( nz.id_revs in '+SPer_Raon_DL;
   end;
   // AppendStr(s,SPer_Raon_DL);
    AppendStr(top_label,' Участок - '+SRAON_TXT_DL);
  end;
  if s1<>'' then
  begin
   s1:=s1+')';
   s2:=s2+')';
   s:=s+' and ('+s1+' or '+s2+')';
  end;

//  AppendStr(s,' order by so.name_r, n.dt_out');
  AppendStr(s,' order by pole0, pole1');

   sTit:=TStringList.Create;
    sTit.Add('Механизм');
    sTit.Add('Дата работы');
    sTit.Add('№ наряда');
    sTit.Add('Адрес аварии');
    sTit.Add('Длительность работы');


   view := TFormResult.ResCreate(Self,false,'dbn_avar','Результат',top_label,s,stit,3,NN_OborSh,false);
//   view.UpdAll;

{
   with view.StrGr_res do
   begin
     if RowCount>=2 then
     begin
       RowCount:=RowCount+2;
       Cells[3,RowCount-1]:='ВСЕГО';
       Cells[5,RowCount-1]:=FloatToStr(SumLeakage);
     end;
   end;
}
  View.ShowModal;
  Application.ProcessMessages;
  finally
     DM1.s_revs_q.Close;
     DM1.S_Place_q.Close;
     DM1.S_Sod_q.Close;
     SPer_Raon_DL:='';
     SPer_Mesto_DL:='';
     animate1.active:=false;
     animate1.Visible:=False;
     buFind.Enabled:=True;
     DateEdit_N.Enabled:=True;
     DateEdit_K.Enabled:=True;
     Sbar.SimpleText:='';
     s:='';
     sTit.Free;
//     view.Free;
  end;
end;

procedure TfmOborsSh.DateEdit_KExit(Sender: TObject);
begin
  inherited;
  If DateEdit_K.Text<>'  .  .    ' Then begin
     try
       StrToDate(DateEdit_K.Text);
       If DateEdit_N.Text<> '  .  .    ' Then begin
          If StrToDate(DateEdit_N.Text)>StrToDate(DateEdit_K.Text) Then begin
             Application.MessageBox('Период задан не верно!!!','Внимание',MB_ICONERROR+MB_OK);
             DateEdit_K.Text:='  .  .    ';
          end;
       end;
     except
       beep;
       IF MessageDlg('Дата введена не верно. Продолжить ввод?', mtWarning,[mbYes, mbNo],0)= mrYes Then begin
          DateEdit_K.SetFocus;
       end
       else begin
          DateEdit_N.Text:='  .  .    ';
       end;
     end;
   end;
  DateEdit_N.Color:=Old_Col;
end;

procedure TfmOborsSh.DateEdit_KEnter(Sender: TObject);
begin
  inherited;
  DateEdit_K.Color:=New_Col;
end;

procedure TfmOborsSh.DateEdit_NEnter(Sender: TObject);
begin
  inherited;
  DateEdit_N.Color:=New_Col;
end;

procedure TfmOborsSh.DateEdit_NExit(Sender: TObject);
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
  DateEdit_K.Text:=DAteToStr(Date);
  DateEdit_N.Color:=Old_Col;
end;

procedure TfmOborsSh.FormCreate(Sender: TObject);
begin
  inherited;
  fmOborsSh:=self;
  SPer_Raon_DL:='';
  SPer_Mesto_DL:='';
  SPer_TXT_ULIC:='';
end;

Function CalcLeakage(Q:double;date_begin,date_end,date_close_bolt,perbeg,perend:TDateTime):double;
begin
  if date_end=0 then date_end:=now;
  if (date_close_bolt>0) and (Date_close_bolt<date_end) then date_end:=Date_close_bolt;
  date_begin:=max(date_begin,perbeg);
  date_end:=min(date_end,perend);

  result:=round(Q*24*(date_end-date_begin)*100)/100; // округляем до 2 знаков
  // Проверка на маразм

  if result<0 then result:=0
end;

function NN10(id,col:integer;var ss:string):integer;
var
  VaT:Variant;
begin
  Result:=0;
  if col=0 then
  begin
    ss:=IntToStr(fmOborsSh.view.StrGr_res.RowCount-1);
  end
  else if col=3 then
  begin
    VaT:=DM1.s_rayons_q.Lookup('id',ss,'name_r');
    if not VarIsNull(VaT) then
      ss:=Vat
    else
      ss:='';
  end
  else if col=4 then
  begin
    try
      ss:=FloatToStr(Round(StrToFloat(ss)*100)/100);
    except
    end;
  end
  else if col=5 then
  begin
    try
      ss:=FloatToStr(Round(CalcLeakage(fmOborsSh.view.Qry_tmp.fieldByName('pole4').asfloat,
                      fmOborsSh.view.Qry_tmp.fieldByName('pole1').AsDateTime,
                      fmOborsSh.view.Qry_tmp.fieldByName('pole6').AsDateTime,
                      fmOborsSh.view.Qry_tmp.fieldByName('dt_cl_bolt').AsDateTime,
                      fmOborsSh.view.Qry_tmp.fieldByName('perbeg').AsDateTime,
                      fmOborsSh.view.Qry_tmp.fieldByName('perend').AsDateTime)*100)/100);
      fmOborsSh.SumLeakage:=fmOborsSh.SumLeakage+StrToFloat(ss);
    except
    end;
  end
  else if col=8 then
  begin
    VaT:=DM1.S_Place_q.Lookup('id',ss,'name_r');
    if not VarIsNull(VaT) then
      ss:=Vat
    else
      ss:='';
  end
  else if col=9 then
  begin
    VaT:=DM1.S_Sod_q.Lookup('id',ss,'name_r');
    if not VarIsNull(VaT) then
      ss:=Vat
    else
      ss:='';
  end;

end;

end.
