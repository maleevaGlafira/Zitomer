unit sz_nzav;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, RXLookup, Db, DBTables, Mask, ToolEdit, ComCtrls,
  frm_dat, ExtCtrls, frmLANG, cntsLANG,OperAttFormUnit,ServiceFuncUnit,
  BaseItemSelecterFrame, SelOwnerFrame, SelTZavFrame;

type
  TFormSZ_nzav = class(TOperAttForm)
    Qry_damg: TQuery;
    DS_damg: TDataSource;
    Qry_tmp: TQuery;
    Qry_rayon: TQuery;
    DS_rayon: TDataSource;
    Panel1: TPanel;
    ZayavType_rg: TRadioGroup;
    Frm_Dt: TFrm_Date;
    Label3: TLabel;
    DBL_tZav: TRxDBLookupCombo;
    RB_Rask: TRadioButton;
    RB_NoRask: TRadioButton;
    DBL_rayon: TRxDBLookupCombo;
    Label4: TLabel;
    Bevel1: TBevel;
    BB_Ok: TBitBtn;
    BB_esc: TBitBtn;
    CheckBox1: TCheckBox;
    GroupBox1: TGroupBox;
    rbAllCrash: TRadioButton;
    rbCrashColl: TRadioButton;
    rbCrashNotColl: TRadioButton;
    chb_otl: TCheckBox;
    frame_SelOwner1: Tframe_SelOwner;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BB_ESCClick(Sender: TObject);
    procedure BB_OkClick(Sender: TObject);
    procedure ZayavType_rgClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure frame_SelOwner1btn_SelItemClick(Sender: TObject);
  private
    { Private declarations }
    StrAttach:string;
  public
    { Public declarations }
    constructor SZ_NzavCreate(AOwner:TComponent;Mode:integer);
    procedure Translate;override;
  end;

var
  FormSZ_nzav: TFormSZ_nzav;
  ZMode:integer;
  Write_All_Works:boolean=true;

implementation
uses main,zav,fresult,strtool, avartype, AvrDBConst;
{$R *.DFM}

constructor TFormSZ_nzav.SZ_NzavCreate(AOwner:TComponent;Mode:integer);
 begin
   ZMode:=Mode;
   inherited Create(AOwner);
 end;
procedure TFormSZ_nzav.FormCreate(Sender: TObject);
//var tt_date:TDateTime;
begin
  CheckBox1.checked:=Write_All_Works;
  ZayavType_rg.Visible:=(Zmode = 2); // ds
  FormSZ_nzav:=Self;
  Qry_damg.Open;
  Qry_rayon.Open;
  Qry_rayon.First;
  if Zmode=1 then
   begin
    Frm_Dt.DE_Out.Date:=Date;
    Frm_Dt.Te_Out.Time:=Time;
    MyOpenSQL(Qry_damg,'select id,name_r from s_tzav where del=''-'' order by name_r');
    Qry_damg.Open;
    Label3.Caption:='Тип наряда';
    RB_Rask.Visible:=false;
    RB_NoRask.Visible:=false;
    RB_Rask.Enabled:=false;
    RB_NoRask.Enabled:=false;
    Label4.Visible:=false;
    DBL_rayon.Visible:=false;

    DBL_rayon.Enabled:=false;
    chb_otl.Visible:=true;
    frame_SelOwner1.Visible:=true;

    FormSZ_nzav.Caption:=TrLangMSG(msgVedNoCloseZajav);{'Ведомость учета незакрытых заявок';}
    DBL_tZav.ShowHint:=false;
   end
  else if Zmode=2 then
   begin
//    MyOpenSQL(Qry_damg,'select id,name_r from s_tzav order by name_r');
//    Qry_damg.Open;
    Label3.Caption:=TrLangMSG(msgCrash);
    DBL_tZav.Hint:='Характер повреждения'+#13+'Место повреждения'+#13+
                   'Тип наряда';
    DBL_tZav.ShowHint:=true;
    ZayavType_rgClick(self);
    DBL_rayon.DisplayValue:=Qry_rayon.FieldByName('NAME_R').asString;
    chb_otl.Visible:=true;
    frame_SelOwner1.Visible:=true;
    FormSZ_nzav.Caption:=TrLangMSG(msgVedZajav)+' за '+ansilowercase(TrLangMSG(msgRange));
   end
  else if Zmode=3 then
   begin
    DBL_tZav.ShowHint:=false;
    Label4.Visible:=false;
    Label3.Visible:=false;
    DBL_rayon.Visible:=false;
    DBL_rayon.Enabled:=false;
    DBL_tzav.Visible:=false;
    DBL_tzav.Enabled:=false;
    chb_otl.Visible:=false;

    FormSZ_nzav.Caption:=TrLangMSG(msgVedLikvidirPovr);
   end;

  DBL_tZav.DisplayValue:=Qry_damg.FieldByName('NAME_R').asString;
  {tt_Date:=Now;
  DE_In.Date:=tt_Date;
  DE_Out.Date:=tt_Date;}
  //DE_In.Text:='';
  //DE_Out.Text:='';
  //TE_In.Text:='';//Time2Str(tt_Date);
  //TE_Out.Text:='';//TE_In.Text;
end;

procedure TFormSZ_nzav.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Qry_damg.Close;
  Qry_rayon.Close;
  Action:=caFree;
end;

procedure TFormSZ_nzav.BB_ESCClick(Sender: TObject);
begin
  Close;
end;

//*******************************************************************
procedure TFormSZ_nzav.BB_OkClick(Sender: TObject);
var FRes:TFormResult;
    sTit:TstringList;
    tt_str,tt_sql,tt_sql2,tt_tit:string;
    tzav_n,tzav_sql:string;
    rayon_n,rayon_sql:string;
    str1 :string;
    Kollector:string;
    tt_otl:string;
    set_typ:string; //для Zmode=2 ( Ведомость учета нарядов за период )
begin
 if rbAllCrash.checked then Kollector:='';
 if rbCrashColl.checked then Kollector:=' and sd.sah=9';
 if rbCrashNotColl.checked then Kollector:=' and sd.sah<>9';
  StrAttach:=' and (z.id_attach='+IntToStr(ord(OperateAttach))+') ';
 set_typ:=frame_SelOwner1.ItemSelecter.SelItemList.ItemsID;
 if set_typ<>'' then
  set_typ:=Format(' and  id_alien in (%s)',[set_typ]);

 with Frm_Dt do
  begin
   if not ProvDate(DE_in.Date,DE_Out.Date,Time2Str(TE_in.Time),Time2Str(TE_out.Time)) then
     exit;
  end;
   Qry_tmp.Close;
   cn:=0;old_res:=0;old_id:=0;TekWord:=1;fl:=false;
   old_rayon:='';
   TekWord2:=1;fl2:=false;fl3:=false;
   TekMas20;
   tzav_n:=AnsiUpperCase(TrLangMSG(msgAll));
   tzav_sql:='';
   rayon_n:=tzav_n;
   rayon_sql:='';
   tt_tit:='';
   frm_Dt.t_db:='z';
   if ((Zmode=1) or (Zmode=2)) and
   (Qry_damg.FieldByName('ID').asInteger>0) then
    begin
      tzav_n:=upper(Qry_damg.FieldByName('NAME_R').asString);
      if Zmode=1 then
         tzav_sql:=' and z.id_tzav='+Qry_damg.FieldByName('ID').asString
      else
         tzav_sql:=' and z.id_sod='+Qry_damg.FieldByName('ID').asString;


    end;
    if (Zmode=2)or (Zmode=1) then
    begin
      tzav_sql:= tzav_sql+ set_typ;
      tzav_n:=tzav_n+'('+upper(frame_SelOwner1.ItemSelecter.SelItemList.ItemsName)+')';
    end;
   if (Zmode=2) and (Qry_rayon.FieldByName('ID').asInteger>0) then
    begin
      rayon_n:=Qry_rayon.FieldByName('NAME_R').asString;
      rayon_sql:={' and z.id_rayon=-' ds}
                ' and z.id_revs='+Qry_rayon.FieldByName('ID').asString;
    end;
   tt_otl:=''; 
   if ((Zmode=2)or (Zmode=1)) and ( not chb_otl.Checked) then
    tt_otl:=' and (z.is_otl<>1 or z.is_otl is null) ';

   sTit:=TStringList.Create;
   sTit.Clear;
  if Zmode=1 then
     begin
       with Frm_Dt do
         begin
          Min_dt:='dt_in';
          Max_dt:='dt_in';
         end;
       rayon_sql:=rayon_sql+frm_Dt.SQLStr;
       tt_tit:=tt_tit+frm_Dt.TitStr;
//       sTit.Add(TrLangMSG(msgREV));
       sTit.Add('Дата');sTit.Add('Номер');sTit.Add(TrLangMSG(msgAddr));sTit.Add('Цех');
       sTit.Add(TrLangMSG(msgContext){'Характер'});sTit.Add(TrLangMSG(msgDiamShort));sTit.Add(TrLangMSG(msgNotice));
       sTit.Add(TrLangMSG(msgWorkMany));
       FRes:=TFormResult.ResCreate(Self,true,'dbn_avar','Результат',TrLangMSG(msgVedNoCloseZajav)+' ('+
                        tzav_n+') '+tt_tit,
                 'select z.id,z.id_ul1,z.id_ul2,z.kod_ul,z.dop_adr, z.id_dopadres, z.dt_in pole0,'+
                 'cast(z.nomer as char(8))||"/"||cast(z.fyear as char(8)) pole1,'+
                 'sd.name_r pole4,dm.diam pole5,z.dop_inf pole6, a.name_r pole3, " " pole7 from nzavjav z,s_diam dm, s_revs a, s_sod sd '+
                 'where (delz=0)'+ tt_otl+
                  ' and z.id_comment=sd.id '+Kollector+StrAttach+' and dm.id=z.id_diam and a.id=z.id_revs'+tzav_sql+rayon_sql+
                 ' order by z.dt_in,z.nomer'
                 ,sTit,2,NN,false); //исключим отложеннные

       Fres.ShowModal;
       Qry_tmp.Close;
     end // if Zmode = 1 ...
      else if Zmode=2 then
         begin
           with Frm_Dt do
             begin
              if ZayavType_rg.Itemindex = 0 then str1:='dt_out'
                                            else str1:='dt_in';
              Min_dt:=str1; // ds 'dt_in';
              Max_dt:=str1; // ds 'dt_in';
             end; // with
           rayon_sql:=rayon_sql+frm_Dt.SQLStr;
           tt_tit:=tt_tit+frm_Dt.TitStr;

           sTit.Add('Номер');

           sTit.Add('Дата');sTit.Add(TrLangMSG(msgAddr));
           sTit.Add(TrLangMSG(msgContext));sTit.Add(TrLangMSG(msgDiamShort));sTit.Add(TrLangMSG(msgNotice));
           sTit.Add(TrLangMSG(msgWorkMany));sTit.Add('Дата закр.');//sTit.Add(TrLangMSG(msgREV));

           {sTit.Add('Дата');sTit.Add('Адрес');
           sTit.Add('Характер');sTit.Add('Диам');sTit.Add('Примечание');
           sTit.Add('Работы');sTit.Add('Дата закр.');}
{uo           if RB_Rask.Checked then
             begin
              tt_str:=' '+TrLangMSG(msgWithDigging)+' ';
              tt_sql:='';
             end
           else
             begin
              tt_str:=' '+TrLangMSG(msgWithoutDigging)+' ';
              tt_sql:='not ';
             end; }

           case ZayavType_rg.Itemindex of // ds
              1{незакрытые} :
                   tt_sql2:='select z.id,z.id_ul1,z.id_ul2,z.kod_ul,z.dop_adr, z.id_dopadres,cast(z.nomer as char(8))||"/"||cast(z.fyear as char(8)) pole0,z.dt_in pole1,'+
                     'sd.name_r pole3,dm.diam pole4,z.dop_inf pole5," " pole6," " pole7 from nzavjav z,s_diam dm,s_ulic u,s_sod sd '+
                     'where (delz=0) and z.id_ul1=u.id '+Kollector+StrAttach+' and dm.id=z.id_diam and z.id_comment=sd.id'+
                     tzav_sql+rayon_sql+tt_otl+
                     {'sd.name_r pole3,dm.diam pole4,z.dop_inf pole5," " pole6,z.dt_out pole7 from zavjav z,s_sod sd,s_diam dm '+
                     'where sd.id=z.id_sod and dm.id=z.id_diam'+tzav_sql+rayon_sql+}
//                     ' and '+tt_sql+'exists (select rs.id from works rs where rs.id_zav=z.id and rs.id_work=206)'+
                     ' order by u.name_r';
               0 {закрытые} :// 'union '
                   tt_sql2:='select z.id,z.id_ul1,z.id_ul2,z.kod_ul,z.dop_adr,z.id_dopadres,cast(z.nomer as char(8))||"/"||cast(z.fyear as char(8)) pole0,z.dt_in pole1,'+
                     'sd.name_r pole3,dm.diam pole4,z.dop_inf pole5," " pole6,z.dt_out pole7 from zavjav z,s_diam dm,s_ulic u,s_sod sd '+
                     'where (delz=0 and (z. is_otl<>1 or z.is_otl is null)) and z.id_comment=sd.id and z.id_ul1=u.id '+Kollector+StrAttach+' and dm.id=z.id_diam'+
                     tzav_sql+rayon_sql+
                     {'sd.name_r pole3,dm.diam pole4,z.dop_inf pole5," " pole6,z.dt_out pole7 from zavjav z,s_sod sd,s_diam dm '+
                     'where sd.id=z.id_sod and dm.id=z.id_diam'+tzav_sql+rayon_sql+}
//                     ' and '+tt_sql+'exists (select rs.id from works rs where rs.id_zav=z.id and rs.id_work=206)'+
                     ' order by u.name_r';
                  else exit;
                end; // case
      {     tt_sql2:='select z.id,z.id_ul1,z.id_ul2,z.kod_ul,cast(z.nomer as char(8))||"/"||cast(z.fyear as char(8)) pole0,z.dt_in pole1,'+
                     'sd.name_r pole3,dm.diam pole4,z.dop_inf pole5," " pole6,z.dt_out pole7 from nzavjav z,s_sod sd,s_diam dm '+
                     'where sd.id=z.id_sod and dm.id=z.id_diam'+tzav_sql+rayon_sql+
                     ' and '+tt_sql+'exists (select rs.id from raskop rs where rs.id_zavin=z.id or rs.id_zavout=z.id) '+
                     'union select z.id,z.id_ul1,z.id_ul2,z.kod_ul,cast(z.nomer as char(8))||"/"||cast(z.fyear as char(8)) pole0,z.dt_in pole1,'+
                     'sd.name_r pole3,dm.diam pole4,z.dop_inf pole5," " pole6,z.dt_out pole7 from zavjav z,s_sod sd,s_diam dm '+
                     'where sd.id=z.id_sod and dm.id=z.id_diam'+tzav_sql+rayon_sql+
                     ' and '+tt_sql+'exists (select rs.id from raskop rs where rs.id_zavin=z.id or rs.id_zavout=z.id)'+
                     ' order by 5';}
       {select n.id from nzavjav n where
       exists (select id from raskop r where r.id_zavin=n.id)}
           FRes:=TFormResult.ResCreate(Self,true,'dbn_avar','Результат',TrLangMSG(msgVedZajav)+' ('+
                            tzav_n+')'+tt_str+' '+tt_tit+
                            ' Экспл. р-н:'+rayon_n,tt_sql2,
                            sTit,2,NN1,false);
           if not Fres.exit_fl then Fres.ShowModal
                          else Fres.Close;
           Qry_tmp.Close;
         end // if Zmode=2 ...

          else if Zmode=3 then
             begin
               with Frm_Dt do
                 begin
                  Min_dt:='dt_out';
                  Max_dt:='dt_out';
                 end;
               rayon_sql:=rayon_sql+frm_Dt.SQLStr;
               tt_tit:=tt_tit+frm_Dt.TitStr;

//               sTit.Add(TrLangMSG(msgREV));
               sTit.Add(TrLangMSG(msgAddr));
               sTit.Add('Дата поступления');
               sTit.Add('Номер');
               {sTit.Add('Характер');sTit.Add('Диам');sTit.Add('Материал');
               sTit.Add('Работы');}
               sTit.Add(TrLangMSG(msgContext){'Характер'});sTit.Add(TrLangMSG(msgDiamShort));sTit.Add(TrLangMSG(msgMaterOne));
               sTit.Add(TrLangMSG(msgWorkMany));sTit.Add(TrLangMSG(msgNotice));sTit.Add(TrLangMSG(msgCrash));

               if RB_Rask.Checked then
                 begin
                  tt_str:=' '+TrLangMSG(msgWithDigging)+' ';
                  tt_sql:='';
                 end
               else
                 begin
                  tt_str:=' '+TrLangMSG(msgWithoutDigging)+' ';
                  tt_sql:='not ';
                 end;
               FRes:=TFormResult.ResCreate(Self,true,'dbn_avar','Результат',TrLangMSG(msgVedLikvidirPovr)+tt_str+
                                ' '+tt_tit,
                         'select z.id,z.id_ul1,z.id_ul2,z.kod_ul,z.dop_adr,z.id_dopadres,'+
                         'z.dt_in pole1,'+
                         'cast(z.nomer as char(8))||"/"||cast(z.fyear as char(8)) pole2,'+
                         'sd.name_r pole3,dm.diam pole4," " pole5," " pole6,z.dop_inf pole7,dg.name_r pole8 from zavjav z,s_sod sd,s_diam dm,s_tzav dg '+
                         'where (delz=0 and (z. is_otl<>1 or z.is_otl is null)) and sd.id=z.id_comment'+Kollector+StrAttach+' and dm.id=z.id_diam and z.id_tzav=dg.id '+rayon_sql+
                         ' and '+tt_sql+'exists (select rs.id from raskop rs where rs.id_zavin=z.id)'+
                         ' order by z.nomer',sTit,0,NN2,false);
               Fres.ShowModal;
               Qry_tmp.Close;
             end;
  sTit.Free;
end;
{select id_to,id_tzav,count(*) from zavjav group by id_to,id_tzav}

//*******************************************************************
procedure TFormSZ_nzav.ZayavType_rgClick(Sender: TObject);
var
 str1 :string;
begin
 if ZayavType_rg.ItemIndex = 0 then str1:=TrLangMSG(msgDTClosed)
                               else str1:=TrLangMSG(msgDTRegister);
 with Frm_Dt do
  begin
   DE_In.Hint:='Дата '+str1+' наряда';
   DE_Out.Hint:='Дата '+str1+' наряда';
   Te_in.Hint:=TrLangMSG(msgTime)+' '+str1+' наряда';
   Te_Out.Hint:=TrLangMSG(msgTime)+' '+str1+' наряда';
  end; // with
end;

procedure TFormSZ_nzav.CheckBox1Click(Sender: TObject);
begin
  inherited;
  Write_All_Works:=CheckBox1.checked;
end;

//*******************************************************************
procedure TFormSZ_nzav.Translate;
begin
  inherited;
  GroupBox1.Caption:=TrLangMSG(msgContext)+' наряда';
  rbAllCrash.Caption:=TrLangMSG(msgNotPrintKoll);
  rbCrashColl.Caption:=TrLangMSG(msgPrintKoll);
  rbCrashNotColl.Caption:=TrLangMSG(msgPrintNotKoll);
  CheckBox1.Caption:=TrLangMSG(msgPrintAllWorks);
//  Label3.Caption:=TrLangMSG(msgCrash);
  Label4.Caption:=TrLangMSG(msgREV);
  ZayavType_rg.Items[0]:=TrLangMSG(msgClosed)+' наряда';
  ZayavType_rg.Items[1]:=TrLangMSG(msgNotClosed)+' наряда';
  RB_Rask.Caption:=TrLangMSG(msgWithDigging);
  RB_NoRask.Caption:=TrLangMSG(msgWithoutDigging);
  BB_Ok.Caption:=TrLangMSG(msgApply);
  BB_esc.Caption:=TrLangMSG(msgCancel);
end;

procedure TFormSZ_nzav.frame_SelOwner1btn_SelItemClick(Sender: TObject);
begin
  inherited;
  frame_SelOwner1.btn_SelItemClick(Sender);

end;

end.


