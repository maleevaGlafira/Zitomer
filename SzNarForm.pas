unit SzNarForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OperAttFormUnit, StdCtrls, Buttons, ExtCtrls, frm_dat,frmLANG,cntsLANG,
  DB, DBTables;

type
  Tfrm_sz_nar = class(TOperAttForm)
    Frm_Dt: TFrm_Date;
    BtnOk: TBitBtn;
    btnCansel: TBitBtn;
    RG_Sort: TRadioGroup;
    Q_count: TQuery;
    sel_revs: TButton;
    sel_brig: TButton;
    cb_otl: TCheckBox;
    procedure btnCanselClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sel_revsClick(Sender: TObject);
    procedure sel_brigClick(Sender: TObject);
  private
    { Private declarations }
      Z_Mode:integer;
      F_RevsID:string;
      F_RevsName:string;
      f_BrigID:string;
      F_BrigName:string;
     function Count(Sql:string;var n:integer):integer;
  public
    { Public declarations }
    constructor  frm_sz_narCreate(AOwner:TComponent;Mode:integer);
  end;

var
  frm_sz_nar: Tfrm_sz_nar;

implementation
uses fresult,main,avartype,Selform;

{$R *.dfm}
constructor  Tfrm_sz_nar.frm_sz_narCreate(AOwner:TComponent;Mode:integer);
begin
  Z_Mode:=Mode;
  F_RevsID:='';
  F_RevsName:='';
  f_BrigID:='';
  F_BrigName:='';
  inherited Create(AOwner);
end;

procedure Tfrm_sz_nar.btnCanselClick(Sender: TObject);
begin
  inherited;
Close;
end;

procedure Tfrm_sz_nar.FormCreate(Sender: TObject);
begin
  inherited;
caption:=TrLangMSG(mcsVedNarPeriod);{'Ведомость єтапов за период '}
RG_Sort.ItemIndex:=0;
end;

procedure Tfrm_sz_nar.BtnOkClick(Sender: TObject);
Const SQL_STRing='select z.id ,z.id_ul1,z.id_ul2,z.kod_ul,z.dop_adr,z.id_dopadres, '+
' n.id ID_nar,n.dt_in ,z.id_soorug, z.id_object,z.nomer,z.id_revs,z.dt_in,'+
' (select ss.name_r from s_soorug ss where ss.id=z.id_soorug) soorug , '+
' ( select so.name_r from s_object so where  z.id_object=so.id) object, '+
' (select srv.name_r from s_revs srv where srv.id=z.id_revs) pole2, ' +
' cast( z.nomer as char(5))||''/ ''||lpad(extract(day from z.dt_in),2,''0'')||''.''|| '+
'                                  lpad(extract(month from z.dt_in),2,''0'')||''.''|| '+
'                                  extract(year from z.dt_in)||'' ''|| '+
                               '   lpad(extract(hour from z.dt_in),2,''0'')||'':''||'+
                               '   lpad(extract(minute from z.dt_in),2,''0'')           pole3,'+

'(select ss.name_r from s_sod ss where ss.id=z.id_comment)   pole4,'+
' (n.dt_in )||''-''||cast(n.dt_out as char(16)) pole5, '+
' n.nomer pole6, '+
 ' (select  sd.diam from  s_diam sd where sd.id=z.id_diam) pole7, '+
 ' (select sb.name_r||''   ''||sb.dolgn from s_brig sb where sb.id=n.id_brig) pole8, '+
 ' n.numteam pole9, '+
 ' n.dop_inf pole14, '+
 '  1 pole10, 1 pole11, 1 pole13, z.dt_out pole15, '+
 ' (select ss.name_r from s_sod ss where ss.id=z.id_sod) pole12 '+
 ' from nnarad n inner join nzavjav z on n.id_zav=z.id  and (z.delz=0 and (z.is_otl is null or z.is_otl<>1))'+
  ' where' +
  ' %s '+
  ' union '+
  'select z.id ,z.id_ul1,z.id_ul2,z.kod_ul,z.dop_adr,z.id_dopadres, '+
' n.id ID_nar,n.dt_in , z.id_soorug, z.id_object, z.nomer,z.id_revs,z.dt_in,'+
' (select ss.name_r from s_soorug ss where ss.id=z.id_soorug) soorug , '+
' ( select so.name_r from s_object so where  z.id_object=so.id) object, '+
' (select srv.name_r from s_revs srv where srv.id=z.id_revs) pole2, '  +
' cast( z.nomer as char(5))||''/ ''||lpad(extract(day from z.dt_in),2,''0'')||''.''|| '+
                                 ' lpad(extract(month from z.dt_in),2,''0'')||''.''||  '+
                                 ' extract(year from z.dt_in)||'' ''||                 '+
                                 ' lpad(extract(hour from z.dt_in),2,''0'')||'':''|| '+
                                 ' lpad(extract(minute from z.dt_in),2,''0'')           pole3,'+
'(select ss.name_r from s_sod ss where ss.id=z.id_comment)   pole4,'+
' (n.dt_in )||''-''||cast(n.dt_out as char(16)) pole5, '+
' n.nomer pole6, '+
 ' (select  sd.diam from  s_diam sd where sd.id=z.id_diam) pole7, '+
 ' (select sb.name_r||''   ''||sb.dolgn  from s_brig sb where sb.id=n.id_brig) pole8, '+
 ' n.numteam pole9, '+
 ' n.dop_inf pole14, '+
 '  1 pole10, 1 pole11, 1 pole13, z.dt_out pole15, '+
 ' (select ss.name_r from s_sod ss where ss.id=z.id_sod) pole12 '+
 ' from narad n inner join zavjav z on n.id_zav=z.id  and (z.delz=0 and (z.is_otl is null or z.is_otl<>1)) '+
  ' where' +
  ' %s '+
  {  + 'union '+
  'select z.id id_z,z.id_ul1,z.id_ul2,z.kod_ul,z.dop_adr,z.id_dopadres, '+
' n.id ,n.dt_dep , '+
'     cast( z.nomer as char(8))||''/ ''||cast(z.fyear as char(8))  pole1, '+
' (select ss.name_r from s_sod ss where ss.id=z.id_comment)   pole2, '+
' (n.dt_dep )||''-''||cast(n.dt_out as char(16)) pole3, '+
' n.nomer pole4, '+
 ' (select  sd.diam from  s_diam sd where sd.id=z.id_diam) pole5, '+
 ' (select sb.name_r from s_brig sb where sb.id=n.id_brig) pole6, '+
 ' n.numteam pole7, '+
 ' n.dop_inf pole12, '+
 '  1 pole8, 1 pole9, 1 pole11, z.dt_out pole13, '+
 ' (select ss.name_r from s_sod ss where ss.id=z.id_sod) pole10 '+
 ' from narad n inner join nzavjav z on n.id_zav=z.id '+
  ' where' +
  ' %s '+
   'union '+
  'select z.id id_z,z.id_ul1,z.id_ul2,z.kod_ul,z.dop_adr,z.id_dopadres, '+
' n.id ,n.dt_dep , '+
'     cast( z.nomer as char(8))||''/ ''||cast(z.fyear as char(8))  pole1, '+
' (select ss.name_r from s_sod ss where ss.id=z.id_comment)   pole2, '+
' (n.dt_dep )||''-''||cast(n.dt_out as char(16)) pole3, '+
' n.nomer pole4, '+
 ' (select  sd.diam from  s_diam sd where sd.id=z.id_diam) pole5, '+
 ' (select sb.name_r from s_brig sb where sb.id=n.id_brig) pole6, '+
 ' n.numteam pole7, '+
 ' n.dop_inf pole12, '+
 '  1 pole8, 1 pole9, 1 pole11, z.dt_out pole13, '+
 ' (select ss.name_r from s_sod ss where ss.id=z.id_sod) pole10 '+
 ' from narad n inner join zavjav z on n.id_zav=z.id '+
  ' where' +
  ' %s '+  }
  ' %s ';

var FRes:TFormResult;
    sTit:TstringList;
    tt_str,tt_sql,tt_sql2,tt_tit:string;
    tzav_n,tzav_sql:string;
    rayon_n,rayon_sql:string;
    str1 :string;
    StrAttach:string;
    sOrder:string;
    Sql_Count:string;
    attach:integer;
    Cols:integer;
    tt_otl:string;
begin
  inherited;
  attach:=ord(OperateAttach);

  case attach of
  1:StrAttach:=' (z.id_attach in (1,3,4))';
  2:StrAttach:=' (z.id_attach in (2,5))';
  end;

//
with Frm_Dt do //проверка правильного ввода даты
  begin
   if not ProvDate(DE_in.Date,DE_Out.Date,Time2Str(TE_in.Time),Time2Str(TE_out.Time)) then
     exit;
  end;
with Frm_Dt do
begin

 t_db:='n';
 Min_dt:='dt_in';
 Max_dt:='dt_in';
 tt_sql:=DateTime2SQL ;//+ ' and  ( z.is_otl is null or z.is_otl <>1 ) ' ;
 tt_str:=DateTime2Tit;
end  ;
 cn:=0;old_res:=0;old_id:=0;TekWord:=1;fl:=false;
TekWord2:=1;fl2:=false;fl3:=false;
   TekMas20;
case RG_Sort.ItemIndex of
 0:  sOrder:='order by 12, 13';
 1:  sOrder:='order by 12, 8';
end;

if F_RevsID<>'' then
StrAttach:=StrAttach+ ' and z.id_revs in'+F_RevsID+' ';
if F_BrigID<>'' then
StrAttach:=StrAttach+ ' and n.id_brig in'+F_brigID+' ';

{отложеннные}
if  cb_otl.Checked then
 tt_otl:=''
else
 tt_otl:='  and (is_otl<>1 or is_otl is null ) ';

sql_Count:='select count (*),1 from nnarad n inner join nzavjav z on n.id_zav=z.id '+
            ' where '+
            StrAttach+
            tt_sql+tt_otl+
            ' union '+
            'select count (*),2 from narad n inner join zavjav z on n.id_zav=z.id '+
            ' where '+
            StrAttach+
            tt_sql+tt_otl+
             ' union '+
            'select count (*),3 from nnarad n inner join zavjav z on n.id_zav=z.id '+
            ' where '+
            StrAttach+
            tt_sql+tt_otl+
             ' union '+
            'select count (*),4 from narad n inner join nzavjav z on n.id_zav=z.id '+
            ' where '+
            StrAttach+
            tt_sql+tt_otl;

if Count(sql_Count,Cols)=mryes then
begin
 sTit:=TstringList.Create;
 sTit.Clear;
 sTit.Add('№');
 stit.Add(TrLangMsg(msgAddr));
 stit.Add('Участок');   //2
 Stit.Add('Номер '+#13+' наряда');  //3
 stit.add(TrLangMsg( msgContext)); //4
 sTit.Add(TrLangMsg(vsgVip));      //5
 stit.add('№'+#13+'эт.');              //6
 stit.add('Д-тр');               //7
 stit.add('Бригадир');              //8
 stit.add('Кол.'+#13+'чел.');//9('Колличество человек');
 stit.add(TrLangMsg(msgMechan));  //10Мезанизмы
 stit.add(TrLangMsg(msgWorkMany)); //11работы
 stit.Add(TrLangMsg( msgSoderzZajav));//12 Характер заявки
 stit.Add(TrLangMsg( msgMaterMany)); //13материалы
 stit.Add(TrLangMsg(msgNotice));   ///14 примечание
 stit.Add(TrLangMsg(msgDateClose));  //15 Дата закрытия
  str1:=Format(SQL_STRing, [StrAttach+tt_sql+tt_otl,StrAttach+tt_sql+tt_otl,{StrAttach+ tt_sql,
                          StrAttach+tt_sql}sOrder]);
 FRes:=TFormResult.ResCreate(Self,True,'dbn_avar','Результат',
                              TrLangMSG(mcsVedNarPeriod)+' '+tt_str+' '+GetAttachName(OperateAttach),
                             str1,stit,1,NNSznar,false,false,true,false,true,Cols,0) ;

 Fres.NumCols:=Cols;
 Fres.ShowModal;
 sTit.Free;
 F_RevsID:='';
 F_RevsName:='';
 f_BrigID:='';
 F_BrigName:='';
end;


end;

function Tfrm_sz_nar.Count(Sql:string;var n:integer):integer;
var
MyButtons:TMsgDlgButtons;
begin
Result:=0;
MyButtons:=[mbYes, mbNo];
q_Count.SQL.Clear;
q_Count.SQL.Text:=Sql;
q_Count.Open;
q_Count.First;


n:=0;
while not q_Count.Eof do   begin
n:=n+q_Count.Fields[0].AsInteger;
q_Count.Next;
end;
if n>0 then
 Result:= MessageDlg(format(TrLangMSG(msgFound),[n]),
                   mtConfirmation, MyButtons, 0)
 else
  MessageDlg(TrLangMSG(msgNotFound), mtInformation, [mbYes], 0);


end ;

procedure Tfrm_sz_nar.FormShow(Sender: TObject);
begin
  inherited;
//Caption:=TrLangMSG(mcsVedNarPeriod);
btnOk.Caption:=TrLangMSG( msgApply);
btnCansel.Caption:=TrLangMSG(msgCancel);

end;

procedure Tfrm_sz_nar.sel_revsClick(Sender: TObject);
var sel_frm: TSelectForm;
begin
  inherited;
  sel_frm:=TSelectForm.Create(self);
  sel_frm.Query.SQL.Text:='select id code,name_r pole1 from s_revs where (id>0) and del=''-''';
  sel_frm.ShowModal;
  F_RevsID:=sel_frm.Temp_Code;
  F_RevsName:=sel_frm.SelText;

end;

procedure Tfrm_sz_nar.sel_brigClick(Sender: TObject);
var sel_frm: TSelectForm;
begin
  inherited;
  sel_frm:=TSelectForm.Create(self);
  sel_frm.Query.SQL.Text:='select id code ,sb.name_r||''  ''||sb.dolgn pole1 from s_brig'+
                          '  sb where sb.id>0 and sb.del=''-'' and id>0 order by 2';


  sel_frm.ShowModal;
  f_BrigID:=sel_frm.Temp_Code;
  F_BrigName:=sel_frm.SelText;


end;

end.
