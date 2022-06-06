unit an_kvart;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, RxLookup, Db, DBTables, Buttons,fresult,frmLANG,cntsLANG;

type
  TAnFormKvart = class(TFormLang)
    CB_year: TComboBox;
    CB_kvart: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DBL_damg: TRxDBLookupCombo;
    RB_All: TRadioButton;
    RB_raskop: TRadioButton;
    RB_noraskop: TRadioButton;
    BB_Ok: TBitBtn;
    BB_Close: TBitBtn;
    Qry_damg: TQuery;
    DS_damg: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BB_CloseClick(Sender: TObject);
    procedure BB_OkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FRes:TFormResult;
    procedure Gr_Click(sender:TObject);
    procedure Translate;override;
  end;

var
  AnFormKvart: TAnFormKvart;

implementation
  uses DateUtil,main,fd_grf,strtool;
{$R *.DFM}

procedure TAnFormKvart.FormCreate(Sender: TObject);
var TekYY,TekMon,TekDay,i:Word;
begin
  AnFormKvart:=Self;
  DecodeDate(Now,TekYY,TekMon,TekDay);
  Cb_Year.Items.Clear;
   for i:=TekYY downto 1989 do
    begin
      Cb_Year.Items.Add(InttoStr(i));
    end;
  CB_Year.ItemIndex:=0;
  CB_Kvart.ItemIndex:=0;
  Qry_damg.Open;
  DBL_damg.DisplayValue:=Qry_damg.FieldByName('NAME_R').asString;
end;

procedure TAnFormKvart.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Qry_damg.Close;
  Action:=caFree;
end;

procedure TAnFormKvart.BB_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TAnFormKvart.BB_OkClick(Sender: TObject);
var dt_in,dt_out,sql_rask,sql_damg:string;
    sTit:TstringList;
    dt_in1,dt_out1,dt_in2,dt_out2,dt_in3,dt_out3:string;
    tt_raskop,tt_damg,mon1,mon2,mon3,main_sql,isRas:string;
    all,i,j:integer;
begin
  sql_rask:='';mon1:='';mon2:='';mon3:='';
  sql_damg:='';tt_raskop:='';tt_damg:='';
  isRas:='0';
  if CB_kvart.ItemIndex=0 then
     begin
       dt_in:='01.01.'+CB_Year.Text;
       dt_out:=inttostr(DaysPerMonth(strtointdef(CB_Year.Text,1),3))+
              '.03.'+CB_Year.Text+' 23:59:59';
       dt_in1:='01.01.'+CB_Year.Text;
       dt_out1:=inttostr(DaysPerMonth(strtointdef(CB_Year.Text,1),1))+
              '.01.'+CB_Year.Text+' 23:59:59';
       dt_in2:='01.02.'+CB_Year.Text;
       dt_out2:=inttostr(DaysPerMonth(strtointdef(CB_Year.Text,1),2))+
              '.02.'+CB_Year.Text+' 23:59:59';
       dt_in3:='01.03.'+CB_Year.Text;
       dt_out3:=inttostr(DaysPerMonth(strtointdef(CB_Year.Text,1),3))+
              '.03.'+CB_Year.Text+' 23:59:59';
       mon1:=' '+LongMonthNames[1]+' ';mon2:=LongMonthNames[2]+' ';mon3:='  '+LongMonthNames[3]+'  ';
     end
  else if CB_kvart.ItemIndex=1 then
     begin
       dt_in:='01.04.'+CB_Year.Text;
       dt_out:=inttostr(DaysPerMonth(strtointdef(CB_Year.Text,1),6))+
              '.06.'+CB_Year.Text+' 23:59:59';
       dt_in1:='01.04.'+CB_Year.Text;
       dt_out1:=inttostr(DaysPerMonth(strtointdef(CB_Year.Text,1),4))+
              '.04.'+CB_Year.Text+' 23:59:59';
       dt_in2:='01.05.'+CB_Year.Text;
       dt_out2:=inttostr(DaysPerMonth(strtointdef(CB_Year.Text,1),5))+
              '.05.'+CB_Year.Text+' 23:59:59';
       dt_in3:='01.06.'+CB_Year.Text;
       dt_out3:=inttostr(DaysPerMonth(strtointdef(CB_Year.Text,1),6))+
              '.06.'+CB_Year.Text+' 23:59:59';
       mon1:=' '+LongMonthNames[4]+' ';mon2:='  '+LongMonthNames[5]+'   ';mon3:='  '+LongMonthNames[6]+'  ';
     end
  else if CB_kvart.ItemIndex=2 then
     begin
       dt_in:='01.07.'+CB_Year.Text;
       dt_out:=inttostr(DaysPerMonth(strtointdef(CB_Year.Text,1),9))+
              '.09.'+CB_Year.Text+' 23:59:59';
       dt_in1:='01.07.'+CB_Year.Text;
       dt_out1:=inttostr(DaysPerMonth(strtointdef(CB_Year.Text,1),7))+
              '.07.'+CB_Year.Text+' 23:59:59';
       dt_in2:='01.08.'+CB_Year.Text;
       dt_out2:=inttostr(DaysPerMonth(strtointdef(CB_Year.Text,1),8))+
              '.08.'+CB_Year.Text+' 23:59:59';
       dt_in3:='01.09.'+CB_Year.Text;
       dt_out3:=inttostr(DaysPerMonth(strtointdef(CB_Year.Text,1),9))+
              '.09.'+CB_Year.Text+' 23:59:59';
       mon1:='  '+LongMonthNames[7]+'  ';mon2:=' '+LongMonthNames[8]+' ';mon3:=LongMonthNames[9];
     end
  else if CB_kvart.ItemIndex=3 then
     begin
       dt_in:='01.10.'+CB_Year.Text;
       dt_out:=inttostr(DaysPerMonth(strtointdef(CB_Year.Text,1),12))+
              '.12.'+CB_Year.Text+' 23:59:59';
       dt_in1:='01.10.'+CB_Year.Text;
       dt_out1:=inttostr(DaysPerMonth(strtointdef(CB_Year.Text,1),10))+
              '.10.'+CB_Year.Text+' 23:59:59';
       dt_in2:='01.11.'+CB_Year.Text;
       dt_out2:=inttostr(DaysPerMonth(strtointdef(CB_Year.Text,1),11))+
              '.11.'+CB_Year.Text+' 23:59:59';
       dt_in3:='01.12.'+CB_Year.Text;
       dt_out3:=inttostr(DaysPerMonth(strtointdef(CB_Year.Text,1),12))+
              '.12.'+CB_Year.Text+' 23:59:59';
       mon1:=LongMonthNames[10]+' ';mon2:=' '+LongMonthNames[11]+' ';mon3:=LongMonthNames[12]+' ';
     end;
  if RB_raskop.Checked then
   begin
    isRas:='1';
    tt_raskop:=' ('+TrLangMSG(msgWithDigging)+') ';
    sql_rask:=' and id in (select id_zav from works w where w.id_work=206)';
   end
  else if RB_noraskop.Checked then
   begin
    isRas:='2';
    tt_raskop:=' ('+TrLangMSG(msgWithoutDigging)+') ';
    sql_rask:=' and id not in (select id_zav from works w where w.id_work=206)';
   end;

  if Qry_damg.FieldByName('ID').asInteger>0 then
   begin
    sql_damg:=' and id='+Qry_damg.FieldByName('ID').asString;
    tt_damg:=' '+ansilowercase(TrLangMSG(msgCrash))+' - '+Qry_damg.FieldByName('NAME_R').asString;
   end;

  sTit:=TstringList.Create;
  sTit.Add(TrLangMSG(msgTypeCrash));sTit.Add(mon1);sTit.Add(mon2);
  sTit.Add(mon3);sTit.Add('Квартал');
  if StorProc then
    {main_sql:=
    'select id,name_r pole0,'+
    '(select my_count from count_damg(d.id,"'+dt_in1+'","'+dt_out1+' 23:59:59",'+isRas+')) pole1,'+
    '(select my_count from count_damg(d.id,"'+dt_in2+'","'+dt_out2+' 23:59:59",'+isRas+')) pole2,'+
    '(select my_count from count_damg(d.id,"'+dt_in3+'","'+dt_out3+' 23:59:59",'+isRas+')) pole3,'+
    '(select my_count from count_damg(d.id,"'+dt_in +'","'+dt_out +' 23:59:59",'+isRas+')) pole4 '+
    ' from s_damg d where id>0 '+sql_damg}
    main_sql:=
    'select id,name_r pole0,'+
    '(select my_count from count_damg(d.id,"'+dt_in1+'","'+dt_out1+' ",'+isRas+')) pole1,'+
    '(select my_count from count_damg(d.id,"'+dt_in2+'","'+dt_out2+' ",'+isRas+')) pole2,'+
    '(select my_count from count_damg(d.id,"'+dt_in3+'","'+dt_out3+' ",'+isRas+')) pole3,'+
    '(select my_count from count_damg(d.id,"'+dt_in +'","'+dt_out +' ",'+isRas+')) pole4 '+
    ' from s_damg d where id>0 '+sql_damg
  else
    main_sql:=
    'select id,name_r pole0,'+
    '(select count(id) from zavjav where (delz=0) and dt_in>="'+dt_in1+
    '" and dt_in<="'+dt_out1+'" and id_damg=d.id'+sql_rask+')+'+
    '(select count(id) from nzavjav where (delz=0) and dt_in>="'+dt_in1+
    '" and dt_in<="'+dt_out1+'" and id_damg=d.id'+sql_rask+') pole1,'+
    '(select count(id) from zavjav where (delz=0) and dt_in>="'+dt_in2+
    '" and dt_in<="'+dt_out2+'" and id_damg=d.id'+sql_rask+')+'+
    '(select count(id) from nzavjav where (delz=0) and dt_in>="'+dt_in2+
    '" and dt_in<="'+dt_out2+'" and id_damg=d.id'+sql_rask+') pole2,'+
    '(select count(id) from zavjav where (delz=0) and dt_in>="'+dt_in3+
    '" and dt_in<="'+dt_out3+'" and id_damg=d.id'+sql_rask+')+'+
    '(select count(id) from nzavjav where (delz=0) and dt_in>="'+dt_in3+
    '" and dt_in<="'+dt_out3+'" and id_damg=d.id'+sql_rask+') pole3,'+
    '(select count(id) from zavjav where (delz=0) and dt_in>="'+dt_in+
    '" and dt_in<="'+dt_out+'" and id_damg=d.id'+sql_rask+')+'+
    '(select count(id) from nzavjav where (delz=0) and dt_in>="'+dt_in+
    '" and dt_in<="'+dt_out+'" and id_damg=d.id'+sql_rask+') pole4'+
    ' from s_damg d where id>0 '+sql_damg;

  FRes:=TFormResult.ResCreate(Self,false,'dbn_avar','Результат',TrLangMSG(msgVedAnalizPovr)+' '+tt_raskop+
        'за '+CB_Kvart.Text+' квартал '+CB_Year.Text+' '+TrLangMSG(msgOnYear)+tt_damg,
        main_sql,sTit,-1,NIL,false);
   Fres.StrGr_res.RowCount:=Fres.StrGr_res.RowCount+2;
   Fres.StrGr_res.Cells[0,Fres.StrGr_res.RowCount-1]:=TrLangMSG(msgITOGO);

   for j:=1 to 4 do
    begin
     all:=0;
     for i:=1 to Fres.StrGr_res.RowCount-2 do
       all:=all+strtointdef(Fres.StrGr_res.Cells[j,i],0);

     Fres.StrGr_res.Cells[j,Fres.StrGr_res.RowCount-1]:=inttostr(all);
    end;

     i:=1;
     while i<Fres.StrGr_res.RowCount do //strtofloat
       begin
         if Trim(Fres.StrGr_res.Cells[4,i])='0' then
            Fres.StrGr_res.RemoveRow(i)
         else
            inc(i);
       end;

    Fres.StrGr_res.AdjustColWidths;
    Fres.StrGr_res.ColWidths[Fres.StrGr_res.ColCount-1]:=2;
    Fres.BB_Graf.Enabled:=true;
    Fres.BB_Graf.Visible:=true;
    Fres.BB_Graf.OnClick:=AnFormKvart.Gr_Click;
  FRes.ShowModal;
  sTit.Free;
end;

procedure TAnFormKvart.Gr_Click(sender:TObject);
var i:integer;
    TutGraf:TGrafFForm;
begin
  //uo а сюда оно не попадает
  CreateRes(CurrentDir,4);
  AddSet(CurrentDir,'GR_LABEL','Анализ повреждений за '{+tt_raskop}+
        'за '+AnFormKvart.CB_Kvart.Text+' квартал '+AnFormKvart.CB_Year.Text+' года'{+tt_damg});
  AddSet(CurrentDir,'X_AXIS','Тип повреждения');
  AddSet(CurrentDir,'Y_AXIS','Кол-во повреждений');
  AddSet(CurrentDir,'POLE0','п1');
  AddSet(CurrentDir,'POLE1','п2');
  AddSet(CurrentDir,'POLE2','п3');
  AddSet(CurrentDir,'POLE3','За квартал');
  For i:=1 to Fres.StrGr_res.RowCount-3 do
   begin
     if strtointdef(Fres.StrGr_res.Cells[4,i],0)>0 then
        AddRes(CurrentDir,[i,{first(5,}Fres.StrGr_res.Cells[0,i]{)},
                           strtointdef(Fres.StrGr_res.Cells[1,i],0),
                           strtointdef(Fres.StrGr_res.Cells[2,i],0),
                           strtointdef(Fres.StrGr_res.Cells[3,i],0),
                           strtointdef(Fres.StrGr_res.Cells[4,i],0)]);
   end;
   TutGraf:=TGrafFForm.GrCreate(Self,CurrentDir);
   TutGraf.ShowModal;
end;

procedure TAnFormKvart.Translate;
begin
  inherited;
  Caption:=TrLangMSG(msgVedAnalizPovr)+' за квартал';
  Label1.Caption:=TrLangMSG(msgYear);
  Label3.Caption:=TrLangMSG(msgCrash);
  RB_All.Caption:=TrLangMSG(msgAll);
  RB_raskop.Caption:=TrLangMSG(msgWithDigging);
  RB_noraskop.Caption:=TrLangMSG(msgWithoutDigging);
  BB_Ok.Caption:=TrLangMSG(msgApply);
  BB_Close.Caption:=TrLangMSG(msgClose);
end;

end.
