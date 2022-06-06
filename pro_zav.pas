unit pro_zav;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, RxLookup, StdCtrls, Buttons, frmLANG, cntsLANG, OperAttFormUnit,
  ServiceFuncUnit;

type
  TProizZForm = class(TFormLang)
    GrB_Zav: TGroupBox;
    Label1: TLabel;
    CB_Year: TComboBox;
    DBLL_zav: TRxDBLookupList;
    Qry_zav: TQuery;
    DS_zav: TDataSource;
    BB_Ok: TBitBtn;
    BB_ESC: TBitBtn;
    Ed_nom: TEdit;
    Label2: TLabel;
    BB_sear: TBitBtn;
    Qry_tmp: TQuery;
    gb_Attach: TGroupBox;
    rbWaterAtt: TRadioButton;
    rbServityAtt: TRadioButton;
    rbVrkAtt: TRadioButton;
    GroupBox1: TGroupBox;
    RB_All: TRadioButton;
    RB_zak: TRadioButton;
    RB_nZak: TRadioButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CB_YearChange(Sender: TObject);
    procedure BB_ESCClick(Sender: TObject);
    procedure BB_OkClick(Sender: TObject);
    procedure BB_searClick(Sender: TObject);
    procedure Ed_nomKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure RefreshBase;
    function  CountBase:integer;
    procedure Translate;override;
  end;

var
  ProizZForm: TProizZForm;

implementation
   uses main,zav,strtool,FormZavFactory;
{$R *.DFM}

procedure TProizZForm.FormCreate(Sender: TObject);
var TekYY,TekMon,TekDay,i:Word;
begin
   DecodeDate(Now,TekYY,TekMon,TekDay);
  Cb_Year.Items.Clear;
   for i:=TekYY downto 1989 do
    begin
      Cb_Year.Items.Add(InttoStr(i));
    end;
  CB_Year.ItemIndex:=0;
  //RefreshBase;
end;

procedure TProizZForm.RefreshBase;
var tt_str,tt_sear,tt_att:string;
    idAtt:integer;
begin
  idAtt := 1;
  if rbWaterAtt.Checked then
    idAtt := 1
  else
  if rbServityAtt.Checked then
    idAtt := 2
  else
  if rbVrkAtt.Checked then
    idAtt := 3;

  case idAtt of
    1: FormMain.OperAtt:=toaVoda;
    2: FormMain.OperAtt:=toaKanal;
    3: FormMain.OperAtt:=toaVRK;
  end;


  tt_sear:='';

  tt_att:=' and id_attach='+IntToStr(idAtt)+' ';
  if ed_nom.Text<>'' then
    tt_sear:=' and nomer like "'+RepChar('?','%',RepChar('*','%',ed_nom.text))+'"';

  if RB_All.Checked then
     tt_str:='select cast(nomer as char(6))||charnum||" "||extract(day from  dt_in )||''.''||extract(month from  dt_in )||''.''||extract(year  from  dt_in ) '+
           'vvod,id,fyear,nomer from zavjav where (delz=0) and fyear='+Cb_Year.Items[CB_Year.ItemIndex]+
           tt_sear+tt_att+' union '+
           'select cast(nomer as char(6))||charnum||" "||cast(dt_in as char(20)) '+
           'vvod,id,fyear,nomer from nzavjav where (delz=0) and fyear='+Cb_Year.Items[CB_Year.ItemIndex]+
           tt_sear+tt_att+'order by 3 desc,4 desc'

  else if RB_Zak.Checked then
     tt_str:='select cast(nomer as char(6))||charnum||" "||extract(day from  dt_in )||''.''||extract(month from  dt_in )||''.''||extract(year  from  dt_in ) '+
           'vvod,id from zavjav where (delz=0) and fyear='+Cb_Year.Items[CB_Year.ItemIndex]+
           tt_sear+tt_att+' order by fyear desc,nomer desc'
  else if RB_NZak.Checked then
     tt_str:='select cast(nomer as char(6))||charnum||" "||extract(day from  dt_in )||''.''||extract(month from  dt_in )||''.''||extract(year  from  dt_in )  '+
           'vvod,id from nzavjav where (delz=0) and fyear='+Cb_Year.Items[CB_Year.ItemIndex]+
           tt_sear+tt_att+' order by fyear desc,nomer desc';

{
  if RB_All.Checked then
     tt_str:='select cast(nomer as char(6))||charnum||" "||DatetimeToStr(dt_in) '+
           'vvod,id,fyear,nomer from zavjav where (delz=0) and fyear='+Cb_Year.Items[CB_Year.ItemIndex]+
           tt_sear+tt_att+' union '+
           'select cast(nomer as char(6))||charnum||" "||DatetimeToStr(dt_in) '+
           'vvod,id,fyear,nomer from nzavjav where (delz=0) and fyear='+Cb_Year.Items[CB_Year.ItemIndex]+
           tt_sear+tt_att+'order by 3 desc,4 desc'

  else if RB_Zak.Checked then
     tt_str:='select cast(nomer as char(6))||charnum||" "||DatetimeToStr(dt_in) '+
           'vvod,id from zavjav where (delz=0) and fyear='+Cb_Year.Items[CB_Year.ItemIndex]+
           tt_sear+tt_att+' order by fyear desc,nomer desc'
  else if RB_NZak.Checked then
     tt_str:='select cast(nomer as char(6))||charnum||" "||DatetimeToStr(dt_in) '+
           'vvod,id from nzavjav where (delz=0) and fyear='+Cb_Year.Items[CB_Year.ItemIndex]+
           tt_sear+tt_att+' order by fyear desc,nomer desc';
}

  MyOpenSQL(Qry_zav,tt_str);
  DBLL_zav.DisplayValue:=Qry_zav.FieldByName('VVOD').asString;
end;


function TProizZForm.CountBase:integer;
var tt_str,tt_atach,tt_sear:string;
    kol:integer;
begin
  kol:=0;
  tt_sear:='';
  if ed_nom.Text<>'' then
    tt_sear:=' and nomer like "'+RepChar('?','%',RepChar('*','%',ed_nom.text))+'"';
  if rbWaterAtt.Checked then
   tt_atach:= ' and id_attach=1 ';

   if rbServityAtt.Checked then
   tt_atach:= ' and id_attach=2 ';

   if rbVrkAtt.Checked then
   tt_atach:= ' and id_attach=3 ';


  if RB_All.Checked then
   begin
     tt_str:='select count(id) mm from zavjav where (delz=0) and fyear='+Cb_Year.Items[CB_Year.ItemIndex]+
             tt_sear+tt_atach;
     MyOpenSQL(Qry_tmp,tt_str);
     kol:=Qry_tmp.FieldByName('MM').asInteger;
     tt_str:='select count(id) mm from nzavjav where (delz=0) and fyear='+Cb_Year.Items[CB_Year.ItemIndex]+
             tt_sear+tt_atach;
     MyOpenSQL(Qry_tmp,tt_str);
     kol:=kol+Qry_tmp.FieldByName('MM').asInteger;
   end
  else if RB_Zak.Checked then
   begin
     tt_str:='select count(id) mm from zavjav where (delz=0) and fyear='+Cb_Year.Items[CB_Year.ItemIndex]+
             tt_sear+tt_atach;
     MyOpenSQL(Qry_tmp,tt_str);
     kol:=Qry_tmp.FieldByName('MM').asInteger;
   end
  else if RB_NZak.Checked then
   begin
     tt_str:='select count(id) mm from nzavjav where (delz=0) and fyear='+Cb_Year.Items[CB_Year.ItemIndex]+
             tt_sear+tt_atach;
     MyOpenSQL(Qry_tmp,tt_str);
     kol:=kol+Qry_tmp.FieldByName('MM').asInteger;
   end;
  Qry_tmp.Close;
  Result:=kol;
end;


procedure TProizZForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Qry_zav.Close;
  Action:=caFree;
end;

procedure TProizZForm.CB_YearChange(Sender: TObject);
begin
 RefreshBase;
end;

procedure TProizZForm.BB_ESCClick(Sender: TObject);
begin
  Close;
end;

procedure TProizZForm.BB_OkClick(Sender: TObject);
var ZvForm:TFormZav;
begin
         try
           ZvForm:=TFormZav_ZavCreate(Self,tfmZayavAfterInsert,Qry_zav.FieldByName('ID').asInteger);
           ZvForm.ShowModal;
         except
           if ZvForm<>nil then FreeAndNil(ZvForm);
         end;

         if CloseStatus<>0 then
           Close;
           {
             repeat
               if CloseStatus=2 then
                 ZvForm:=TFormZav.ZavCreate(Self,3,ZavToCopy)
               else
                 ZvForm:=TFormZav.ZavCreate(Self,0,0);
               ZvForm.ShowModal;
             until CloseStatus=0;}
end;

procedure TProizZForm.BB_searClick(Sender: TObject);
var cc:integer;
begin
   BB_Ok.Enabled:=false;
   cc:=CountBase;
   if cc>1 then
     begin
      RefreshBase;
      BB_Ok.Enabled:=true;
     end
   else if cc=1 then
     begin
      RefreshBase;
    //  BB_OkClick(Self)
     end
  else
  begin
   DBLL_zav.DisplayValue:='';
  end
end;

procedure TProizZForm.Ed_nomKeyPress(Sender: TObject; var Key: Char);
begin
          if Key = #13 then
          begin
            SelectNext(Sender as TWinControl, True, True );
            Key := #0;
          end;
end;

procedure TProizZForm.Translate;
begin
  inherited;
  Caption:=TrLangMSG(msgSomeSel);
  Label1.Caption:=TrLangMSG(msgYear);
  RB_All.Caption:=TrLangMSG(msgAll);
  RB_zak.Caption:=TrLangMSG(msgClosed);
  RB_nZak.Caption:=TrLangMSG(msgNotClosed);
  BB_sear.Caption:=TrLangMSG(msgSearch);
  BB_Ok.Caption:=TrLangMSG(msgApply);
  BB_ESC.Caption:=TrLangMSG(msgCancel);
  gb_Attach.Caption:=TrLangMSG(msgPrinad);
  rbServityAtt.Caption:=TrLangMSG(msgKANANAL);
  rbVrkAtt.Caption:=TrLangMSG(msgVRK);
  rbWaterAtt.Caption:=TrLangMSG(msgVodoprovod);
  RB_All.Caption:=TrLangMSG(msgAll);
  RB_nZak.Caption:=TrLangMSG(msgClosed);
  RB_nZak.Caption:=TrLangMSG(msgNotClosed);

end;

end.
