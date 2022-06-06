unit sz_prois;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, ToolEdit, Spin, Db, DBTables, RXLookup, frm_srdb,
  frmLANG
  frmLANG, cntsLANG;

type
  Tsz_proisv = class(TFormLang)
    Label1: TLabel;
    Label2: TLabel;
    SE_NomIn: TSpinEdit;
    SE_NomOut: TSpinEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    DE_in: TDateEdit;
    TE_in: TMaskEdit;
    Label6: TLabel;
    DE_out: TDateEdit;
    TE_out: TMaskEdit;
    BB_Ok: TBitBtn;
    Qry_tmp: TQuery;
    DBL_raon: TRxDBLookupCombo;
    DS_raon: TDataSource;
    Qry_Raon: TQuery;
    DBL_Revs: TRxDBLookupCombo;
    Qry_Revs: TQuery;
    DS_Revs: TDataSource;
    Lb_NmUl: TLabel;
    DBL_ul1: TRxDBLookupCombo;
    Lb_Ndom: TLabel;
    Ed_ndom: TEdit;
    Qry_ul1: TQuery;
    DS_ul1: TDataSource;
    GrB_damg: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    DBL_damg: TRxDBLookupCombo;
    DBL_place: TRxDBLookupCombo;
    DBL_Diam: TRxDBLookupCombo;
    DBL_mest: TRxDBLookupCombo;
    DS_Damg: TDataSource;
    Qry_Damg: TQuery;
    DS_place: TDataSource;
    Qry_place: TQuery;
    Qry_diam: TQuery;
    DS_diam: TDataSource;
    DS_mest: TDataSource;
    Qry_mest: TQuery;
    Label11: TLabel;
    DBL_zav: TRxDBLookupCombo;
    DS_zav: TDataSource;
    Qry_zav: TQuery;
    Label12: TLabel;
    Qry_tzav: TQuery;
    DS_tzav: TDataSource;
    Label13: TLabel;
    Qry_sod: TQuery;
    DS_sod: TDataSource;
    DBL_sod: TRxDBLookupCombo;
    DBL_tzav: TRxDBLookupCombo;
    DBL_brig: TRxDBLookupCombo;
    Qry_Brig: TQuery;
    DS_Brig: TDataSource;
    Label14: TLabel;
    BB_Close: TBitBtn;
    BitBtn1: TBitBtn;
    Frm_SDb1: TFrm_SDb;
    Button1: TButton;
    Button2: TButton;
    Label15: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure BB_OkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BB_CloseClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function  Str2SQL(Fstr,F_Name:string;isLike,isAnd:boolean):string;
    function  Int2SQL(Fint:integer;F_Name:string;isand:boolean):string;
    function  Int2Tit(id_Name,F_Name,Dob_str:string;Qry_tt:TQuery):string;
    procedure Int2STit(id_Name,Dob_str:string;Qry_tt:TQuery; var SL:TstringList);
    function  Int2sSQL(id_Name,F_Name,Dob_str:string;Qry_tt:TQuery;var nom:integer):string;
    function  Int2wSQL(id_Name,F_Name:string;Qry_tt:TQuery):string;
    function  Int2whSQL(id_Name,F_Name,d_Name:string;Qry_tt:TQuery):string;
    procedure Translate;override;
  end;

var
  sz_proisv: Tsz_proisv;

implementation
uses zav,strtool,fresult,main;
{$R *.DFM}

procedure Tsz_proisv.FormCreate(Sender: TObject);
//var tt_date:TDateTime;
begin
  UstColors(Self);
//  tt_Date:=Now;
{  DE_In.Date:=tt_Date;
  DE_Out.Date:=tt_Date;
  TE_In.Text:=Time2Str(tt_Date);
  TE_Out.Text:=TE_In.Text;}

  Qry_Raon.Open;
  Qry_Revs.Open;
//  Qry_Revs2.Open;
  Qry_Damg.Open;
  Qry_Mest.Open;
  Qry_Place.Open;
  Qry_Diam.Open;
  Qry_zav.Open;
  Qry_tzav.Open;
  Qry_sod.Open;
  Qry_ul1.Open;
//  Qry_ul2.Open;
  Qry_Brig.Open;
  DBL_BRIG.DisplayValue:=Qry_Brig.FieldByName('NAME').asString;
//    DBL_ul2.DisplayValue:=Qry_ul2.FieldByName('NAME_R').asString;
    DBL_Raon.DisplayValue:=Qry_Raon.FieldByName('NAME_R').asString;
    DBL_Revs.DisplayValue:=Qry_Revs.FieldByName('NAME_R').asString;
    DBL_Damg.DisplayValue:=Qry_Damg.FieldByName('NAME_R').asString;
    DBL_Mest.DisplayValue:=Qry_Mest.FieldByName('NAME_R').asString;
    DBL_Place.DisplayValue:=Qry_Place.FieldByName('NAME_R').asString;
    DBL_Diam.DisplayValue:=Qry_Diam.FieldByName('DIAM').asString;
    DBL_Zav.DisplayValue:=Qry_Zav.FieldByName('NAME_R').asString;
    DBL_tZav.DisplayValue:=Qry_tZav.FieldByName('NAME_R').asString;
    DBL_Sod.DisplayValue:=Qry_Sod.FieldByName('NAME_R').asString;
    DBL_ul1.DisplayValue:=Qry_ul1.FieldByName('NAME_R').asString;
end;

function  Tsz_proisv.Str2SQL(Fstr,F_Name:string;isLike,isAnd:boolean):string;
var NumEl,i:integer;
    str_res,tt_str,ss:string;
begin
if Fstr='' then
  Result:=''
else
 begin
   NumEl:=WordCntx(FStr,';',false);
   str_res:='';
   for i:=1 to NumEl do
    begin
     if i=1 then
       ss:=' '
     else
       begin
       if isAnd then
         ss:=' and '
       else
         ss:=' or ';
       end;
     tt_str:=ExtractWordsx_(i,1,Fstr,';',false);
     if isLike then
       str_res:=str_res+ss+F_Name+' like "%'+tt_str+'%"'
     else
       str_res:=str_res+ss+F_Name+'="'+tt_str+'"';
    end;
   Result:=str_res;
 end;

end;

function  Tsz_proisv.Int2SQL(Fint:integer;F_Name:string;isand:boolean):string;
begin
 Result:='';
 if Fint>0 then
  begin
   if isAnd then
     Result:=' and '+F_Name+'='+inttostr(Fint)
   else
     Result:=' '+F_Name+'='+inttostr(Fint);
  end;
 end;

function  Tsz_proisv.Int2Tit(id_Name,F_Name,Dob_str:string;Qry_tt:TQuery):string;
begin
 Result:='';
   If Qry_tt.FieldByName(id_Name).asInteger>0 then
     begin
        Result:=' '+Dob_str+' "'+Qry_tt.FieldByName(F_Name).asString+'"';
     end;
 end;

procedure Tsz_proisv.Int2STit(id_Name,Dob_str:string;Qry_tt:TQuery; var SL:TstringList);
begin
   If Qry_tt.FieldByName(id_Name).asInteger<=0 then
     begin
        SL.Add(Dob_str)
    end;
 end;

function  Tsz_proisv.Int2sSQL(id_Name,F_Name,Dob_str:string;Qry_tt:TQuery;var nom:integer):string;
begin
 Result:='';
   If Qry_tt.FieldByName(id_Name).asInteger<=0 then
     begin
        Result:=','+F_Name+' '+Dob_str+inttostr(nom);
        inc(nom);
     end;
 end;

function  Tsz_proisv.Int2wSQL(id_Name,F_Name:string;Qry_tt:TQuery):string;
begin
 Result:='';
   If Qry_tt.FieldByName(id_Name).asInteger<=0 then
     begin
        Result:=','+F_Name;
     end;
 end;

function  Tsz_proisv.Int2whSQL(id_Name,F_Name,d_Name:string;Qry_tt:TQuery):string;
begin
 Result:='';
   If Qry_tt.FieldByName(id_Name).asInteger<=0 then
     begin
        Result:=' and '+F_Name+'='+D_Name;
     end;
 end;


procedure Tsz_proisv.BB_OkClick(Sender: TObject);
var tt_str,tt_tit,tt_str2,tt_str3:string;
    FRes:TFormResult;
    sTit:TstringList;
    i_nom:integer;
begin
   i_nom:=4;
   tt_tit:='Заявки';
   sTit:=TStringList.Create;
   sTit.Clear;
   sTit.Add('Номер');
   sTit.Add('Дат.отк.');sTit.Add('Дат.зак');sTit.Add('Адрес');

   Int2Stit('ID','Район',Qry_raon,sTit);
   Int2Stit('ID','РЭВС',Qry_revs,sTit);
   Int2Stit('ID','Заявитель',Qry_zav,sTit);
   Int2Stit('ID','Тип заявки',Qry_tzav,sTit);
   Int2Stit('ID','Содержание',Qry_sod,sTit);
   Int2Stit('ID','Повреждение',Qry_damg,sTit);
   Int2Stit('ID','Местность',Qry_mest,sTit);
   Int2Stit('ID','Место',Qry_place,sTit);
   Int2Stit('ID','Диаметр',Qry_diam,sTit);
   Int2Stit('ID','Оп.откр.',Qry_Brig,sTit);
   Int2Stit('ID','Оп.закр.',Qry_Brig,sTit);

//   Int2Stit('ID','Характер',Qry_sod,sTit);
   //sTit.Add('РЭВС');sTit.Add('Характер');
   tt_str:='';
   tt_str2:='select z.id,z.id_ul1,z.id_ul2,z.kod_ul,z.dop_adr,cast(z.nomer as char(8))||"/"||cast(z.fyear as char(8)) pole0,'+
            'z.dt_in pole1,z.dt_out pole2'+
            int2sSQL('ID','ry.name_r','pole',Qry_raon,i_nom)+
            int2sSQL('ID','r.name_r','pole',Qry_revs,i_nom)+
            int2sSQL('ID','zv.name_r','pole',Qry_zav,i_nom)+
            int2sSQL('ID','tz.name_r','pole',Qry_tzav,i_nom)+
            int2sSQL('ID','sd.name_r','pole',Qry_sod,i_nom)+
            int2sSQL('ID','dg.name_r','pole',Qry_damg,i_nom)+
            int2sSQL('ID','mt.name_r','pole',Qry_mest,i_nom)+
            int2sSQL('ID','pl.name_r','pole',Qry_place,i_nom)+
            int2sSQL('ID','dm.diam','pole',Qry_diam,i_nom)+
            int2sSQL('ID','b1.name_r','pole',Qry_Brig,i_nom)+
            int2sSQL('ID','b2.name_r','pole',Qry_Brig,i_nom)+
            //,r.name_r pole4,sd.name_r pole5 '+
          ' from ';
   {tt_str2:='select z.id,z.id_ul1,z.id_ul2,z.kod_ul,r.name_r pole0,z.dt_in pole1,'+
          'z.dt_out pole2,cast(z.nomer as char(8))||"/"||cast(z.fyear as char(8)) pole3,'+
          'sd.name_r pole5 '+
          'from ';}

   tt_str3:=' z'+
            int2wSQL('ID','s_rayon ry',Qry_raon)+
            int2wSQL('ID','s_revs r',Qry_revs)+
            int2wSQL('ID','s_zav zv',Qry_zav)+
            int2wSQL('ID','s_tzav tz',Qry_tzav)+
            int2wSQL('ID','s_sod sd',Qry_sod)+
            int2wSQL('ID','s_damg dg',Qry_damg)+
            int2wSQL('ID','s_mest mt',Qry_mest)+
            int2wSQL('ID','s_place pl',Qry_place)+
            int2wSQL('ID','s_diam dm',Qry_diam)+
            int2wSQL('ID','s_brig b1',Qry_brig)+
            int2wSQL('ID','s_brig b2',Qry_brig)+
//   ,s_revs r,s_sod sd
           ' where (delz=0) and z.id>0'+
            int2whSQL('ID','ry.id','z.id_rayon',Qry_raon)+
            int2whSQL('ID','-r.id','z.id_to',Qry_revs)+
            int2whSQL('ID','zv.id','z.id_zav',Qry_zav)+
            int2whSQL('ID','tz.id','z.id_tzav',Qry_tzav)+
            int2whSQL('ID','sd.id','z.id_sod',Qry_sod)+
            int2whSQL('ID','dg.id','z.id_damg',Qry_damg)+
            int2whSQL('ID','mt.id','z.id_mest',Qry_mest)+
            int2whSQL('ID','pl.id','z.id_place',Qry_place)+
            int2whSQL('ID','dm.id','z.id_diam',Qry_diam)+
            int2whSQL('ID','b1.id','z.id_disin',Qry_brig)+
            int2whSQL('ID','b2.id','z.id_disout',Qry_brig);
//            r.id=z.id_revs and sd.id=z.id_sod';

          if Strip('A','. ',DE_In.Text)<>'' then
            begin
              tt_tit:=tt_tit+' c "'+DE_In.Text+'"';
              tt_str3:=tt_str3+' and z.dt_in>"'+DE_In.Text;
              if Strip('A',': ',TE_In.Text)<>'' then
                begin
                 tt_str3:=tt_str3+' '+TE_in.Text+'"';
                 tt_tit:=tt_tit+' "'+TE_in.Text+'"';
                end
              else
                 tt_str3:=tt_str3+'"';
            end;

          if Strip('A','. ',DE_Out.Text)<>'' then
            begin
              tt_tit:=tt_tit+' по "'+DE_Out.Text+'"';
              tt_str3:=tt_str3+' and z.dt_in<"'+DE_Out.Text;
              if Strip('A',': ',TE_Out.Text)<>'' then
                begin
                 tt_str3:=tt_str3+' '+TE_Out.Text+'"';
                 tt_tit:=tt_tit+' "'+TE_Out.Text+'"';
                end
              else
                 tt_str3:=tt_str3+' 23:59"';
            end;
          if SE_NomIn.Value>0 then
             begin
                tt_tit:=tt_tit+' номер >="'+SE_NomIn.Text+'"';
                tt_str3:=tt_str3+' and z.nomer>='+SE_NomIn.Text;
             end;
          if SE_NomOut.Value>0 then
             begin
                tt_tit:=tt_tit+' номер <="'+SE_NomOut.Text+'"';
                tt_str3:=tt_str3+' and z.nomer<='+SE_NomOut.Text;
             end;
          if Qry_Brig.FieldByName('ID').asInteger>0 then
            begin
              tt_tit:=tt_tit+' откр/закр "'+Qry_Brig.FieldByName('NAME_R').asString+'"';
              tt_str:=tt_str3+' and ('+
                 Int2SQL(Qry_Brig.FieldByName('ID').asInteger,'id_disin',false)+' or'+
                 Int2SQL(Qry_Brig.FieldByName('ID').asInteger,'id_disout',false)+')';
            end;

          if Qry_ul1.FieldByName('ID').asInteger>0 then
            begin
              tt_tit:=tt_tit+' по "'+Strip('B',' ',Qry_ul1.FieldByName('NAME_R').asString)+'"';
              tt_str3:=tt_str3+' and ('+
              Int2SQL(Qry_Ul1.FieldByName('ID').asInteger,'id_ul1',false)+' or (kod_ul=1 and id_ul2="'+
              Qry_Ul1.FieldByName('ID').asString+'"))';
            end;
          if Ed_ndom.Text<>'' then
            begin
              tt_tit:=tt_tit+' с N домов "'+Ed_ndom.Text+'"';
              tt_str3:=tt_str3+' and ( kod_ul=0 and ('+str2SQL(Ed_Ndom.Text,'id_ul2',false,false)+'))';
            end;
          tt_str3:=tt_str3+
          Int2SQL(Qry_Raon.FieldByName('ID').asInteger,'id_rayon',true)+
          Int2SQL(Qry_revs.FieldByName('ID').asInteger,'id_revs',true)+
          Int2SQL(Qry_zav.FieldByName('ID').asInteger,'id_zav',true)+
          Int2SQL(Qry_tzav.FieldByName('ID').asInteger,'id_tzav',true)+
          Int2SQL(Qry_sod.FieldByName('ID').asInteger,'id_sod',true)+
          Int2SQL(Qry_damg.FieldByName('ID').asInteger,'id_damg',true)+
          Int2SQL(Qry_mest.FieldByName('ID').asInteger,'id_mest',true)+
          Int2SQL(Qry_place.FieldByName('ID').asInteger,'id_place',true)+
          Int2SQL(Qry_diam.FieldByName('ID').asInteger,'id_diam',true);

          tt_tit:=tt_tit+
          Int2tit('ID','NAME_R','район',Qry_Raon)+
          Int2tit('ID','NAME_R','экс.район',Qry_revs)+
          Int2tit('ID','NAME_R','заявитель',Qry_zav)+
          Int2tit('ID','NAME_R','тип',Qry_tzav)+
          Int2tit('ID','NAME_R','тип заявки',Qry_sod)+
          Int2tit('ID','NAME_R','повреждение',Qry_damg)+
          Int2tit('ID','NAME_R','местность',Qry_mest)+
          Int2tit('ID','NAME_R','место',Qry_place)+
          Int2tit('ID','DIAM'  ,'диаметр',Qry_diam);


   tt_str:=tt_str2+'nzavjav'+tt_str3+' union '+
           tt_str2+'zavjav'+tt_str3;

   if tt_tit='Заявки' then
      tt_tit:=tt_tit+' ВСЕ';

   tt_tit:=tt_tit+' на '+DateToStr(Now)+' '+Time2Str(Now);
   FRes:=TFormResult.ResCreate(Self,'dbn_avar','Результат',tt_tit,
              tt_str,sTit,3,NN3,true);
   Fres.ShowModal;
 //adress 4
end;

procedure Tsz_proisv.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Qry_Raon.Close;
  Qry_Revs.Close;
//  Qry_Revs2.Close;
  Qry_Damg.Close;
  Qry_Mest.Close;
  Qry_Place.Close;
  Qry_Diam.Close;
  Qry_zav.Close;
  Qry_tzav.Close;
  Qry_sod.Close;
  Qry_ul1.Close;
//  Qry_ul2.Close;
  Qry_Brig.Close;
  Action:=caFree;
end;


procedure Tsz_proisv.BB_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure Tsz_proisv.BitBtn1Click(Sender: TObject);
begin
    Frm_sdb1.DbName:='DBN_AVAR';
    Frm_sdb1.SQLStr:='select id,name_r from s_vidul';
    Frm_sdb1.L_field:='name_r';
    Frm_sdb1.n_field:='id';
    Frm_sdb1.Text:='Вид улицы';
    Frm_sdb1.MainSQLstr:='and id_vidul in (select id from s_vidul where #)';
    Frm_sdb1.Open;
end;

procedure Tsz_proisv.Button1Click(Sender: TObject);
begin
    Frm_sdb1.Close;
end;

procedure Tsz_proisv.Button2Click(Sender: TObject);
begin
 Label15.Caption:=frm_SDB1.GetSql;
end;

procedure Tsz_proisv.Translate;
begin
  inherited;
  Caption:=TrLangMSG(msgProizSearch);
  Label1.Caption:='Номер '+ansilowercase(TrLangMSG(msgFrom));
  Label5.Caption:=TrLangMSG(msgFrom);
  Lb_NmUl.Caption:=TrLangMSG(msgStreet);
  Lb_Ndom.Caption:=TrLangMSG(msgNumDoms);
  Label11.Caption:=TrLangMSG(msgZajavitelOne);
  Label13.Caption:=TrLangMSG(msgContext)+' заявки';
  BB_Ok.Caption:=TrLangMSG(msgShow);
  GrB_damg.Caption:=TrLangMSG(msgInfoAboutCrash);
  Label7.Caption:=TrLangMSG(msgCrash);
  Label8.Caption:=TrLangMSG(msgSpotPlace);
  Label9.Caption:=TrLangMSG(msgDiam);
  Label10.Caption:=TrLangMSG(msgPlace);
  BB_Close.Caption:=TrLangMSG(msgExit);
end;

end.
