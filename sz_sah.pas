unit sz_sah;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, ToolEdit, Db, DBTables, ExtCtrls, RxLookup,prosm2,
  ComCtrls, frm_dat, frmLANG, cntsLANG, variants,OperAttFormUnit,
  ServiceFuncUnit;

type
  TFormSah = class(TOperAttForm)
    Qry_tzav: TQuery;
    Qry_sah: TQuery;
    Qry_rayon: TQuery;
    Qry_tmp: TQuery;
    RG_vib: TRadioGroup;
    BB_Set: TBitBtn;
    Qry_mat: TQuery;
    DS_mat: TDataSource;
    DBL_mat: TRxDBLookupCombo;
    DBL_Diam: TRxDBLookupCombo;
    Qry_diam: TQuery;
    DS_diam: TDataSource;
    RB_bezr: TRadioButton;
    RB_sr: TRadioButton;
    ChB_open: TCheckBox;
    ChB_Excel: TCheckBox;
    Frm_Dt: TFrm_Date;
    BB_ok: TBitBtn;
    BB_Exit: TBitBtn;
    rbBury: TRadioButton;
    rbAsphalt: TRadioButton;
    rbAll: TRadioButton;
    Qry_tmp2: TQuery;
    procedure BB_ExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BB_SetClick(Sender: TObject);
    procedure BB_okClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RG_vibClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    XLApp: Variant;
    mm_rayon:array [0..100] of integer;
    Prosm:TProsmForm2;
    Fl_Work:boolean;
    tt_ras:string;
    zStrAttach:string;
    procedure PrintV_Likv;
    procedure PrintIs_mat;
    procedure PrintIs_matD;
    procedure PrintLikv_D;
    procedure PrintPer_Z;
    procedure PrintRask;
    procedure ust_viz(num:integer);
    procedure MyProsmClose(Sender: TObject; var Action: TCloseAction);
    procedure Translate;override;
  end;


var
  FormSah: TFormSah;

implementation
  uses set_sah,strtool,fresult,main,ComObj, XLConst, zav, avartype,support,
  AvrDBConst;
{$R *.DFM}

var
   wwater_col: integer;
  fl: boolean;

function NN1_PrintPerZ(id,col:integer;var ss:string):integer;
begin
  Result:=1;

  if old_id<>id then
  begin
   fl:=true;
   old_id:=id;
  end;

  if col=wwater_col then
  begin
    if fl then
    begin
      MyOpenSQL(FormSah.Qry_tmp2,
                ' select ww.id,'+
                ' (select rtrim(u.name_r)||" "||rtrim(vid.name_r)||", "||'+
                '   rtrim(ww.house)'+
                '   from s_ulic u'+
                '   left join s_vidul vid on vid.id=u.id_vidul'+
                '   where u.id=ww.id_ul) ulic'+
                ' from wwater ww'+
                ' where ww.id_zav='+ss);
    end;
    ss:=trim(FormSah.Qry_tmp2.FieldByName('ulic').AsString);
    FormSah.Qry_tmp2.Next;
  end else
  begin
    if not fl then ss:='';
  end;

  if col=wwater_col+1 then
  begin
    if (not FormSah.Qry_tmp2.Active) or (FormSah.Qry_tmp2.Eof) then
    begin
      Result:=0;
      FormSah.Qry_tmp2.Close;
      fl:=true;
    end else fl:=false;
  end;
end;


procedure TFormSah.BB_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TFormSah.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  Qry_mat.Close;
  Qry_diam.Close;
  Action:=caFree;
end;

procedure TFormSah.BB_SetClick(Sender: TObject);
var SpForm:TFormSSah;
begin
SpForm:=TFormSSah.Create(Self);
SpForm.ShowModal;
end;

procedure TFormSah.BB_okClick(Sender: TObject);
const MasBuk: array [1..26] of string =
             ('A','B','C','D','E','F','G','H','I','J',
              'K','L','N','M','O','P','Q','R','S','T',
              'U','V','W','X','Y','Z');
const cond_otl = ' and (id_otl=0 or id_otl is null) ';
var zSQL,nzSQL,tzSQL,tnzSQL,tt_str,tt_str2,zag,zag2,zag3,zag4:string;
    line,db_sql:string;
    i,nom,all,vsego,t1,t2,dlin,dlin1,kol_sah:integer;
    XLCol,XLRow,XLZagCol,XLinCol,XLOutCol:integer;
    fl1,fl_rayon:boolean;
    Sheet: Variant;
    PEREH,POSTU,VIPOL,OSTAT:string;
begin
  zStrAttach:=' and (id_attach='+IntToStr(ord(OperateAttach))+')';
  if LANG=ltRU
  then begin
    PEREH:='перех';
    POSTU:='пост ';
    VIPOL:='выпол';
    OSTAT:='остат';
  end
  else begin
    PEREH:='перех';
    POSTU:='надій';
    VIPOL:='викон';
    OSTAT:='залиш';
  end;

  with Frm_Dt do
   begin
       if not ProvDate(DE_in.Date,DE_Out.Date,Time2Str(TE_in.Time),Time2Str(TE_out.Time)) then
         exit;
   end;
  XLCol:=3;XLRow:=5;XLZagCol:=4;
  XLOutCol:=1;
  if RG_vib.ItemIndex=0 then
    begin
     with frm_dt do
     begin
         if ChB_Excel.Checked then
            begin
             XLApp:= CreateOleObject('Excel.Application');
             //XLApp.Visible := True;
             XLApp.Workbooks.Add(xlWBatWorkSheet);
             XLApp.Workbooks[1].WorkSheets[1].Name :='Шахматка';
             Sheet := XLApp.Workbooks[1].WorkSheets['Шахматка'];
            end; // if ChB_Excel.Checked ...
         Prosm:=TProsmForm2.Create(Self);
         Prosm.OnClose:=MyProsmClose;
         Prosm.Show;
         Prosm.Memo1.Lines.Add(AnsiUpperCase(TrLangMSG(msgVedomostPovr)));
         Prosm.Memo1.Lines.Add(AnsiUpperCase(TrLangMSG(msgForRangeFrom))+' '+DE_in.Text+' '+Time2Str(TE_in.Time)+' ДО '+
                                 DE_out.Text+' '+Time2Str(TE_out.Time));
         Prosm.BB_Print.Enabled:=false;
         Prosm.BB_Close.Caption:='Стоп';
         if ChB_Excel.Checked then
            begin
              Sheet.Cells[1,1]:=AnsiUpperCase(TrLangMSG(msgVedomostPovr));
              Sheet.Cells[2,1]:=AnsiUpperCase(TrLangMSG(msgForRangeFrom))+' '+DE_in.Text+' '+Time2Str(TE_in.Time)+' ДО '+
                                 DE_out.Text+' '+Time2Str(TE_out.Time);
              Sheet.Cells[1,1].Font.Bold := True;
              Sheet.Cells[2,1].Font.Bold := True;
            end;
         fl1:=true;
         fl_rayon:=true;
         dlin:=0;
         Fl_work:=true;
         Qry_rayon.Open;
         While fl_rayon and Fl_work do
          begin
            Application.ProcessMessages;
            nom:=1;
//            fl_rayon:=false; // !!!!!!!!!!!!!!!!!!!!!!!!!!!!
            db_sql:=' ';
            if Qry_rayon.Eof then
             begin
//              db_sql:=' id_to<=-1 and ';
              fl_rayon:=false;
             end
            else
//              db_sql:=' id_to=-'+Qry_rayon.FieldByName('ID').asString+' and ';
            while nom<5 do
             begin
                 if ChB_Excel.Checked then
                    begin
                      if nom=1 then
                         Sheet.Rows[XLRow].Borders[xlEdgeTop].LineStyle := xlDouble
                      else
                         Sheet.Range['B'+inttostr(XLRow)+':'+
                              MasBuk[XlOutCol]+inttostr(XLRow)].
                              Borders[xlEdgeTop].LineStyle := xlContinuous;
                    end;
               if nom=1 then
                 begin
                  if fl_rayon then
                    begin
                     tt_str:='|'+PadCenter(Qry_rayon.FieldByName('NAME_R').asString,8,' ')+
                             '|'+PEREH;
                     {29.07.2004}
                     db_sql:=' (id_rayon='+Qry_rayon.FieldByName('ID').asString+') and '
                     {/29.07.2004}
                    end
                  else
                     tt_str:='|'+PadCenter(TrLangMSG(msgITOGO),8,' ')+
                             '|'+PEREH;
                 if ChB_Excel.Checked then
                    begin
                      Sheet.Cells[XLRow,1].Font.Bold := True;
                      if Fl_rayon then
                        begin
                         Sheet.Cells[XLRow,1]:=Qry_rayon.FieldByName('NAME_R').asString;
                         Sheet.Cells[XLRow,2]:=PEREH;
                        end
                      else
                        begin
                         Sheet.Cells[XLRow,1]:=AnsiLowerCase(TrLangMSG(msgITOGO));
                         Sheet.Cells[XLRow,2]:=PEREH;
                        end;
                    end;
                 {кол-во заявок закрытых и незакрытых - перех}
                  zSQL:='select count(id) mm from zavjav where (delz=0 ) and '+db_sql+
                         'dt_in<="'+
                         DE_In.Text+' '+Time2Str(TE_In.Time)+'" and dt_out >="'+
                         DE_In.Text+' '+Time2Str(TE_in.Time)+'"'+zStrAttach;
                  nzSQL:='select count(id) mm from nzavjav where (delz=0 ) and '+db_sql+
                         'dt_in<="'+DE_In.Text+' '+Time2Str(TE_In.Time)+'"'+zStrAttach;
                 end
               else if nom=2 then
                 begin
                  tt_str:='|        |'+POSTU;
                 if ChB_Excel.Checked then
                    Sheet.Cells[XLRow,2]:=trim(POSTU);
                  {кол-во заявок закрытых и незакрытых - пост}
                  zSQL:='select count(id) mm from zavjav where (delz=0 ) and '+db_sql+
                         'dt_in>="'+
                         DE_In.Text+' '+Time2Str(TE_In.Time)+'" and dt_in<="'+
                         DE_Out.Text+' '+Time2Str(TE_Out.Time)+'"'+zStrAttach;
                  nzSQL:='select count(id) mm from nzavjav where (delz=0 ) and '+db_sql+
                         'dt_in>="'+
                         DE_In.Text+' '+Time2Str(TE_In.Time)+'" and dt_in<="'+
                         DE_Out.Text+' '+Time2Str(TE_Out.Time)+'"'+zStrAttach;
                 end
               else if nom=3 then
                 begin
                  tt_str:='|        |'+VIPOL;
                 if ChB_Excel.Checked then
                    Sheet.Cells[XLRow,2]:=VIPOL;
                  {кол-во заявок закрытых и незакрытых - выпол}  
                  zSQL:='select count(id) mm from zavjav where (delz=0 ) and '+db_sql+
                         'dt_out>="'+
                         DE_In.Text+' '+Time2Str(TE_In.Time)+'" and dt_out<="'+
                         DE_Out.Text+' '+Time2Str(TE_Out.Time)+'"'+zStrAttach;
                  nzSQL:='select count(id) mm from nzavjav where (delz=0 ) and id<-1000'+zStrAttach;
                 end
               else if nom=4 then
                 begin
                  tt_str:='|        |'+OSTAT;
                 if ChB_Excel.Checked then
                    Sheet.Cells[XLRow,2]:=OSTAT;
                  {кол-во заявок закрытых и незакрытых - остат}
                  zSQL:='select count(id) mm from zavjav where (delz=0 ) and '+db_sql+
                         'dt_in<="'+
                         DE_Out.Text+' '+Time2Str(TE_Out.Time)+
                         '" and dt_out>="'+
                         DE_Out.Text+' '+Time2Str(TE_Out.Time)+'"'+zStrAttach;
                  nzSQL:='select count(id) mm from nzavjav where (delz=0 ) and '+db_sql+
                         'dt_in<="'+
                         DE_Out.Text+' '+Time2Str(TE_Out.Time)+'"'+zStrAttach;
                 end;
               vsego:=0;
               tt_str2:='';
               zag:= '|  '+TrLangMSG(msgREV)+'  |     нарядов|';
               zag2:='|        |           |';
               zag3:='|  NN    |     '+PadLeft(TrLangMSG(msgAllCount),6,' ')+'|';
               zag4:='|        |           |';
               if ChB_Excel.Checked then
                begin
                  Sheet.Cells[3,1]:=TrLangMSG(msgREV);
                  Sheet.Cells[4,1]:='NN';
                  Sheet.Cells[3,3]:='нарядов';
                  Sheet.Cells[4,3]:=TrLangMSG(msgAllCount);
                  Sheet.Rows[3].Borders[xlEdgeTop].LineStyle := xlDouble;
                end;
               Qry_tzav.Open; //течь, ремонт, прочие
               XLCol:=4;
               While not Qry_tzav.EOF do
                 begin
                  dlin1:=0;
                  {кол-во перечня течей(ремонтов или прочих)}
                  MyOpenSQL(Qry_sah,'select count(id) mm from s_sah where id in (select sah from s_sod where ftype='+
                                  Qry_tzav.FieldByName('ID').asString+')');
                  kol_sah:=Qry_sah.FieldByName('MM').asInteger;
                  {перечень перечня течей(ремонтов или прочих)}
                  MyOpenSQL(Qry_sah,'select * from s_sah where id in (select sah from s_sod where ftype='+
                                  Qry_tzav.FieldByName('ID').asString+')');
                  if not Qry_sah.EOF then
                    begin
                           all:=0;XLinCol:=XLZagCol;
                           while not Qry_sah.EOF do
                            begin
                               //all:=0;
                               if (fl1) and (kol_sah>1) then
                                 begin
                                   zag:=zag+padcenter(ExtractWordsx_(1,1,Qry_sah.FieldByName('NAME_R').asString,';',false),5,' ')+'|';
                                   zag2:=zag2+padcenter(ExtractWordsx_(2,1,Qry_sah.FieldByName('NAME_R').asString,';',false),5,' ')+'|';
                                   dlin1:=dlin1+6;
                                   if ChB_Excel.Checked then
                                      begin
                                       Sheet.Cells[4,XLZagCol]:=Strip('A',';',Qry_sah.FieldByName('NAME_R').asString);
                                       inc(XLZagCol);
                                      end;
                                 end;
                                 {Qry_sah - магистраль, квартальные, колодцы, ПГ, ВРК, прочие,
                                 арматура, коллектор}
                               tzSQL:=zSQL+ cond_otl + '  and id_sod in (select id from s_sod where sah='+
                                    Qry_sah.FieldByName('ID').asString+' and ftype='+
                                    Qry_tzav.FieldByName('ID').asString+')';
                               tnzSQL:=nzSQL+cond_otl +' and id_sod in (select id from s_sod where sah='+
                                    Qry_sah.FieldByName('ID').asString+' and ftype='+
                                    Qry_tzav.FieldByName('ID').asString+')';
                               MyOpenSQL(Qry_tmp,tzSQL);
                               t1:=Qry_tmp.FieldByName('MM').asInteger;
                               MyOpenSQL(Qry_tmp,tnzSQL);
                               t2:=Qry_tmp.FieldByName('MM').asInteger;
                               Qry_tmp.Close;
                               all:=all+t1+t2;
                               if kol_sah>1 then
                                begin
                                 if t1+t2>0 then
                                   tt_str2:=tt_str2+padRight(inttostr(t1+t2),5,' ')+'|'
                                 else
                                   tt_str2:=tt_str2+'     |';
                                 if ChB_Excel.Checked and ((t1+t2)>0) then
                                    Sheet.Cells[XLRow,XLCol]:=t1+t2;
                                 inc(XLCol);
                                end;
                               Qry_sah.Next;
                            end;
                           vsego:=vsego+all;
                           if fl1 then
                             begin
                                   if ChB_Excel.Checked then
                                      begin
                                       Sheet.Cells[4,XLZagCol]:=AnsiUpperCase(TrLangMSG(msgAllCount));
                                       Sheet.Cells[3,XLInCol]:=Qry_tzav.FieldByName('NAME_R').asString;
                                       Sheet.Cells[3,XLInCol].HorizontalAlignment:=xlCenter;
                                       Sheet.Cells[3,XLZagCol].Borders[xlEdgeRight].LineStyle := xlContinuous;
                                       Sheet.Range[MasBuk[XLInCol]+'3:'+MasBuk[XlZagCol]+'3'].Merge;
                                       inc(XlZagCol);
                                      end;
                              zag:=zag+copy(AnsiUpperCase(TrLangMSG(msgAllCount)),1,5)+'|';
                              zag2:=zag2+'     |';
                              zag3:=zag3+padCenter(Qry_tzav.FieldByName('NAME_R').asString,dlin1+5,' ')+'|';
                              zag4:=zag4+FillStr(dlin1+5,'-')+'|';
                              dlin:=dlin+dlin1+6;
                             end;
                           if all=0 then
                              tt_str2:=tt_str2+'     |'
                           else
                              tt_str2:=tt_str2+padRight(inttostr(all),5,' ')+'|';

                           if ChB_Excel.Checked then
                                  Sheet.Cells[XLRow,XLCol]:=all;
                           inc(XLCol);

                    end;
                  Qry_sah.Close;
                  Qry_tzav.Next;
                end;
               Qry_tzav.Close;
               tt_str:=tt_str+padRight(inttostr(vsego),6,' ')+'|'+tt_str2;
               if ChB_Excel.Checked then
                 begin
                  Sheet.Cells[XLRow,3]:=vsego;
                  Sheet.Cells[XLRow,3].Font.Bold := True;
                 end;

               if fl1 then
                 begin
                  XLOutCol:=XLZagCol-1;
                  Line:=FillStr(dlin,'-');
                  Prosm.Memo1.Lines.Add('----------------------'+line);
                  Prosm.Memo1.Lines.Add(zag3);
                  Prosm.Memo1.Lines.Add(zag4);
                  Prosm.Memo1.Lines.Add(zag);
                  Prosm.Memo1.Lines.Add(zag2);
                  Prosm.Memo1.Lines.Add('----------------------'+line);
                  fl1:=false;
                 end;
               Prosm.Memo1.Lines.Add(tt_str);
               if nom<4 then
                  Prosm.Memo1.Lines.Add('|        |     -------'+line)
               else
                  Prosm.Memo1.Lines.Add('----------------------'+line);
               inc(nom);
               inc(XLRow);
             end;
            Qry_rayon.Next;
          end;
         Qry_rayon.Close;
         Prosm.Memo1.Lines.Add(TrLangMSG(msgCreate)+':'+DateToStr(Now)+' '+TimeToStr(Now));
         Prosm.BB_Print.Enabled:=true;
         Prosm.BB_Close.Caption:=TrLangMSG(msgExit);

         if ChB_Excel.Checked then
           begin
             Sheet.Cells[XLRow,1]:=TrLangMSG(msgCreate)+':'+DateToStr(Now)+' '+TimeToStr(Now);
             Sheet.Range['D4:'+MasBuk[XlOutCol]+'4'].
                   Borders[xlEdgeTop].LineStyle := xlContinuous;
             Sheet.Rows[XlRow].
                   Borders[xlEdgeTop].LineStyle := xlDouble;
             Sheet.Cells[1,1].HorizontalAlignment:=xlCenter;
             Sheet.Cells[2,1].HorizontalAlignment:=xlCenter;
             Sheet.Range['A1:'+MasBuk[XlOutCol]+'1'].Merge;
             Sheet.Range['A2:'+MasBuk[XlOutCol]+'2'].Merge;
             for i:=1 to XlOutCol do
               begin
                Sheet.Columns[i].AutoFit;
                if (i<5) and (i<>3) then
                   Sheet.Range[MasBuk[i]+'3:'+MasBuk[i]+inttostr(XLRow-1)].
                     Borders[xlEdgeLeft].LineStyle := xlContinuous
                else if i<>3 then
                   Sheet.Range[MasBuk[i]+'4:'+MasBuk[i]+inttostr(XLRow-1)].
                     Borders[xlEdgeLeft].LineStyle := xlContinuous;
               end;

             Sheet.Range[MasBuk[XlOutCol]+'4:'+MasBuk[XlOutCol]+inttostr(XLRow-1)].
                     Borders[xlEdgeRight].LineStyle := xlContinuous;
             XLApp.Visible := True;
           end;
     end;
    end
  else if RG_vib.ItemIndex=1 then
   PrintV_Likv
  else if RG_vib.ItemIndex=2 then
   PrintIs_mat
  else if RG_vib.ItemIndex=3 then
   PrintIs_matD
  else if RG_vib.ItemIndex=4 then
   PrintLikv_D
  else if RG_vib.ItemIndex=5 then
   PrintPer_Z
  else if RG_vib.ItemIndex=6 then
   PrintRask;
end;

procedure TFormSah.PrintV_Likv;
var FRes:TFormResult;
    sTit:TstringList;
    cni:integer;
begin
{
 select id_to pole0,count(*) pole1," " pole2  from zavjav
where dt_out <="07.06.1999 08:00" and dt_out<="07.06.1999 08:00" group by id_to
}
    Frm_dt.SetNull;
    Frm_dt.t_db:='z';
    cn1:=0;old_id:=0;old_res:=0;old_resR:=0;cn:=0;
    old_idN:=0;old_resN:=0;old_resNR:=0;cnN:=0;
{nut} old_cn:=0;old_cnn:=0;   
    frm_Dt.min_dt:='dt_in';
    frm_Dt.max_dt:='dt_in';
//    frm_Dt.min_dt:='dt_out';
//    frm_Dt.max_dt:='dt_out';
    MyOpenSQL(Qry_tmp,'select count(id) mm from zavjav z '+

              ' where (delz=0) and '+
               'id_revs in (select id from s_revs where id>0) '+zStrAttach+
               frm_Dt.SQLStr
               );
    cni:=Qry_tmp.FieldByName('MM').asInteger;
    frm_Dt.min_dt:='dt_in';
    frm_Dt.max_dt:='dt_in';
    MyOpenSQL(Qry_tmp,'select count(id) mm from nzavjav z '+

              { 'where dt_out >="'+DE_in.Text+' '+Time2Str(TE_in.Time)+
               '" and dt_out<="'+DE_out.Text+' '+Time2Str(TE_out.Time)+
               '" and '+}'where (delz=0 ) and '+
               'id_revs in (select id from s_revs where id>0) '+zStrAttach+
               frm_Dt.SQLStr
               );
    cni:=cni+Qry_tmp.FieldByName('MM').asInteger;
    GL_Count:=cni; // ds
    Qry_tmp.Close;
     sTit:=TstringList.Create;
     sTit.Add(' Цех ');sTit.Add(TrLangMSG(msgAllCount)+' нарядов');sTit.Add(TrLangMSG(msgPercentForAmount){'% от об.кол.'});
     sTit.Add(TrLangMSG(msgAndLeak));
     sTit.Add(TrLangMSG(msgAndNoLeak));
     sTit.Add(TrLangMSG(msgAndRepair));
     sTit.Add(TrLangMSG(msgAndNoRepair));
     sTit.Add(TrLangMSG(msgAndOther));
     sTit.Add(TrLangMSG(msgAndNoOther));
    { FRes:=TFormResult.ResCreate(Self,'dbn_avar','Результат','Ведомость ликвидации повреждений '+
                      'на '+DateToStr(Now)+' '+TimeToStr(Now),
               'select id_to pole0,count(*) pole1,'+
               'count(*) pole2,"1" pole3,"2" pole4,"-1" id from zavjav '+
               'where dt_out >="'+DE_in.Text+' '+TE_in.Text+
               '" and dt_out<="'+DE_out.Text+' '+TE_out.Text+'" group by id_to'
               ,sTit,-1,NN4,false);}
     FRes:=TFormResult.ResCreate(Self,false,'dbn_avar','Результат',TrLangMSG(msgVedLikvidirPovrForRange)+
            ' '{+ansilowercase(TrLangMSG(msgFrom))+' '}
                      +{DE_In.Text+' '+Time2Str(TE_in.Time)+' до '+
                      DE_Out.Text+' '+Time2Str(TE_Out.Time)}frm_Dt.TitStr,
               'select name_r,id pole0,"=0" pole1,'+
               '"=0" pole2,"=1" pole3,"=1" pole4,"=2" pole5,"=2" pole6,">2" pole7,">2" pole8, id from s_revs where id>0 '+
               'order by name_r'
               ,sTit,-1,NN4,false,false,true,false);
     FRes.BB_zav.Visible:=false;          
     Fres.StrGr_res.RowCount:=Fres.StrGr_res.RowCount+2;
     Fres.StrGr_res.Cells[0,Fres.StrGr_res.RowCount-1]:=TrLangMSG(msgITOGO);
     Fres.StrGr_res.Cells[1,Fres.StrGr_res.RowCount-1]:=inttostr(cni);
     Fres.StrGr_res.Cells[2,Fres.StrGr_res.RowCount-1]:='100';
     Fres.StrGr_res.Cells[3,Fres.StrGr_res.RowCount-1]:=inttostr(old_id);
     Fres.StrGr_res.Cells[4,Fres.StrGr_res.RowCount-1]:=inttostr(old_idN);
     Fres.StrGr_res.Cells[5,Fres.StrGr_res.RowCount-1]:=inttostr(old_res);
     Fres.StrGr_res.Cells[6,Fres.StrGr_res.RowCount-1]:=inttostr(old_resN);
     Fres.StrGr_res.Cells[7,Fres.StrGr_res.RowCount-1]:=inttostr(old_resR);
     Fres.StrGr_res.Cells[8,Fres.StrGr_res.RowCount-1]:=inttostr(old_resNR);
     Fres.StrGr_res.Cells[9,Fres.StrGr_res.RowCount-1]:=inttostr(old_cn);
     Fres.StrGr_res.Cells[10,Fres.StrGr_res.RowCount-1]:=inttostr(old_cnN);
     Fres.StrGr_res.AdjustColWidths;
     Fres.StrGr_res.ColWidths[Fres.StrGr_res.ColCount-1]:=2;
     Fres.ShowModal;
     sTit.Free;
end;

procedure TFormSah.FormCreate(Sender: TObject);
begin
 FormSah:=Self;
 Qry_mat.Open;
 DBL_mat.DisplayValue:=Qry_mat.FieldByName('NAME_R').asString;
 Qry_diam.Open;
 DBL_diam.DisplayValue:=Qry_diam.FieldByName('DIAM').asString;
 ust_viz(Rg_vib.ItemIndex);
 with frm_dt do
  begin
   DE_Out.Date:=Date;
   DE_In.Date:=Date-1;
   Te_In.Time:=strtotime('07:00');
   Te_Out.Time:=Te_In.Time;
  end;
end;

procedure TFormSah.PrintIs_mat;
var FRes:TFormResult;
    sTit:TstringList;
    cnf:double;
begin
    Frm_dt.SetNull;
    cn1:=0;old_id:=0;old_res:=0;
    frm_Dt.min_dt:='dt_out';
    frm_Dt.max_dt:='dt_out';
    MyOpenSQL(Qry_tmp,'select sum(m.kol_mat) mm from maters m,zavjav z where (delz=0 and (is_otl<>1 or is_otl is null )) and m.id_mat='
    +Qry_mat.FieldByName('ID').asString+
    {'and m.id_zav=z.id and z.dt_in >="'+DE_in.Text+' '+Time2Str(TE_in.Time)+
    '" and z.dt_in<="'+DE_out.Text+' '+Time2Str(TE_out.Time)+'"');}
    ' and m.id_zav=z.id '+frm_dt.SQLStr+zStrAttach);

    cnf:= Qry_tmp.FieldByName('MM').asFloat;
    Qry_tmp.Close;
     sTit:=TstringList.Create;
     sTit.Add(' Цех ');sTit.Add(TrLangMSG(msgCount)+' ('+trim(Qry_mat.FieldByName('ED_IZM').asString)+')');
     sTit.Add(TrLangMSG(msgPercentForAmount));
     FRes:=TFormResult.ResCreate(Self,false,'dbn_avar','Результат',
       TrLangMSG(msgVedUsedMat)+' за '+ansilowercase(TrLangMSG(msgRange))+' '+frm_dt.titstr+{DE_In.Text+' '+Time2Str(TE_in.Time)+' до '+
                      DE_Out.Text+' '+Time2Str(TE_Out.Time)+}' '+
                      Qry_mat.FieldByName('NAME_R').asString,
               'select d.name_r pole0,cast(sum(m.kol_mat) as numeric(9,2)) pole1,cast((sum(m.kol_mat)/'+
               //'select d.name_r pole0,sum(m.kol_mat) pole1,(sum(m.kol_mat)/'+
               RepChar(',','.',floattostr(cnf))+')*100 as numeric(2,2)) pole2,"0" id from maters m,zavjav z,s_revs d where (delz=0 and (is_otl<>1 or is_otl is null )) and m.id_mat='+
  //             inttostr(cn)+')*100 pole2,"0" id from maters m,zavjav z,s_revs d where m.id_mat='+
               Qry_mat.FieldByName('ID').asString+
               ' and m.id_zav=z.id '+frm_dt.sqlstr+zStrAttach+{'and z.dt_in >="'+
               DE_in.Text+' '+Time2Str(TE_in.Time)+
               '" and z.dt_in<="'+DE_out.Text+' '+Time2Str(TE_out.Time)+
               '"}' and z.id_revs=d.id group by d.name_r'

               {'select name_r,id pole0,"0" pole1,'+
               '"0" pole2,id from s_rayon where id>0 '+
               'order by name_r'}
               ,sTit,-1,{NN5}NIL,false);
     Fres.StrGr_res.RowCount:=Fres.StrGr_res.RowCount+2;
     Fres.StrGr_res.Cells[0,Fres.StrGr_res.RowCount-1]:=TrLangMSG(msgITOGO);
     Fres.StrGr_res.Cells[1,Fres.StrGr_res.RowCount-1]:=FormatFloat( '0.##', cnf );
     Fres.StrGr_res.Cells[2,Fres.StrGr_res.RowCount-1]:='100';
     Fres.StrGr_res.AdjustColWidths;
     Fres.StrGr_res.ColWidths[Fres.StrGr_res.ColCount-1]:=2;
     Fres.ShowModal;
     sTit.Free;
end;

procedure TFormSah.PrintIs_matD;
var FRes:TFormResult;
    sTit:TstringList;
    i:integer;
    cnf:double;
begin
   Frm_dt.SetNull;
   frm_Dt.min_dt:='dt_out';
   frm_Dt.max_dt:='dt_out';
   //cn1:=0;old_id:=0;old_res:=0;
   MyOpenSQL(Qry_tmp,'select sum(m.kol_mat) mm from maters m,zavjav z where (delz=0 and (is_otl<>1 or is_otl is null ) ) and m.id_mat='
   +Qry_mat.FieldByName('ID').asString+zStrAttach+' and m.id_diam>0 '+
   'and m.id_zav=z.id '+frm_dt.sqlstr{and z.dt_in >="'+DE_in.Text+' '+Time2Str(TE_in.Time)+
   '" and z.dt_in<="'+DE_out.Text+' '+Time2Str(TE_out.Time)+'"'});
   cnf:=Qry_tmp.FieldByName('MM').asFloat;
   Qry_tmp.Close;
   if cnf>0 then
    begin
     sTit:=TstringList.Create;
     sTit.Add(' '+TrLangMSG(msgDiam)+' (мм) ');sTit.Add(TrLangMSG(msgCount)+' ('+trim(Qry_mat.FieldByName('ED_IZM').asString)+')');
     sTit.Add(TrLangMSG(msgPercentForAmount));
     FRes:=TFormResult.ResCreate(Self,false,'dbn_avar','Результат',
       TrLangMSG(msgVedUsedMatDiametram)+' за '+ansilowercase(TrLangMSG(msgRange))+' '{с '+DE_In.Text+' '+Time2Str(TE_in.Time)+' до '+
                      DE_Out.Text+' '+Time2Str(TE_Out.Time)+}+frm_dt.Titstr+
                      ' '+
                      Qry_mat.FieldByName('NAME_R').asString,
                'select d.diam pole0,cast(sum(m.kol_mat) as numeric(9,2)) pole1,cast((sum(m.kol_mat)/'+
                RepChar(',','.',floattostr(cnf))+')*100 as numeric(2,2)) pole2,"0" id from maters m,zavjav z,s_diam d where (delz=0 and (is_otl<>1 or is_otl is null ) ) and m.id_mat='+

               {'select d.diam pole0,sum(m.kol_mat) pole1,(sum(m.kol_mat)/'+
               inttostr(cn)+')*100 pole2,"0" id from maters m,zavjav z,s_diam d where m.id_mat='+}
               Qry_mat.FieldByName('ID').asString+zStrAttach+
               ' and m.id_zav=z.id '+frm_dt.SQLstr{and z.dt_in >="'+
               DE_in.Text+' '+Time2Str(TE_in.Time)+
               '" and z.dt_in<="'+DE_out.Text+' '+Time2Str(TE_out.Time)+
               '"}+' and m.id_diam=d.id group by d.diam'

               {'select diam,id pole0,"0" pole1,'+
               '"0" pole2,id from s_diam where id>0 '+
               'order by diam'}
               ,sTit,-1,{NN6}NIL,false);
     i:=1;
     while i<Fres.StrGr_res.RowCount do
       begin
         if Trim(Fres.StrGr_res.Cells[1,i])='0' then
            Fres.StrGr_res.RemoveRow(i)
         else
            inc(i);
       end;
     Fres.StrGr_res.RowCount:=Fres.StrGr_res.RowCount+2;
     Fres.StrGr_res.Cells[0,Fres.StrGr_res.RowCount-1]:=TrLangMSG(msgITOGO);
     Fres.StrGr_res.Cells[1,Fres.StrGr_res.RowCount-1]:= FormatFloat( '0.##', cnf);
     Fres.StrGr_res.Cells[2,Fres.StrGr_res.RowCount-1]:='100';
     Fres.StrGr_res.AdjustColWidths;
     Fres.StrGr_res.ColWidths[Fres.StrGr_res.ColCount-1]:=2;
     Fres.ShowModal;
     sTit.Free;
    end
   else
    MessageDlg(TrLangMSG(msgNotFound),
                   mtInformation, [mbYes], 0);

end;

{
 select * from zavjav
 where id in (select id_zav from maters where id_mat=13) and
 id_to=-5

 select sum(kol_mat) from maters where id_zav=2 and id_mat=13


select sum(kol_mat) from maters where id_zav in (select id from zavjav
where id in (select id_zav from maters where id_mat=13)) and id_mat=13

}
procedure TFormSah.RG_vibClick(Sender: TObject);
begin
   FormSah.Caption:=RG_vib.Items.Strings[Rg_vib.ItemIndex];
   ust_viz(Rg_vib.ItemIndex);
end;

procedure TFormSah.PrintLikv_D;
var FRes:TFormResult;
    sTit:TstringList;
    {kol_damg,kol_rayon,}i,j,a:integer;
    tt_sql,tt_tit:string;

begin
   Frm_dt.SetNull;
   frm_Dt.min_dt:='dt_out';
   frm_Dt.max_dt:='dt_out';

    for i:=0 to 100 do
      mm_rayon[i]:=0;
    cn1:=0;old_id:=0;old_res:=0;
    sTit:=TstringList.Create;
{    if RB_sr.Checked then
      begin
       tt_ras:='';
       tt_tit:=TrLangMSG(msgWithDigging)
      end
    else
      begin
       tt_ras:='not ';
       tt_tit:=TrLangMSG(msgWithoutDigging)
      end;}
    tt_ras:='';
    tt_tit:='';
    MyOpenSQL(Qry_tmp,'select * from s_revs where id>0 order by name_r');
    tt_sql:='';
    i:=1;
    sTit.Add(TrLangMSG(msgCrashes));
    while not Qry_tmp.EOF do
      begin
        sTit.Add(Qry_tmp.FieldByName('NAME_R').asString);
        tt_sql:=tt_sql+InSTRValue(Qry_tmp.FieldByName('NAME_R').asString)+
        ' pole'+inttostr(i)+',';
        inc(i);
        Qry_tmp.Next;
      end;
    Qry_tmp.Close;
    sTit.Add(ansilowercase(TrLangMSG(msgITOGO)));
    ResColCount:=sTit.Count+1;
    tt_sql:=tt_sql+'"'+ansilowercase(TrLangMSG(msgITOGO))+'" pole'+inttostr(i);
     FRes:=TFormResult.ResCreate(Self,false,'dbn_avar','Результат',
       TrLangMSG(msgSvodkaLikvPovr)+' '+tt_tit+
                      ' за '+ansilowercase(TrLangMSG(msgRange))+' '+frm_Dt.Titstr,
        ' select ss.id, rtrim(ss.name_r)||"("||rtrim(st.name_r)||","||rtrim(sp.name_r)||")" as pole0,'+tt_sql+
        ' from s_sod ss'+
        ' left join s_tzav st on (st.id=ss.ftype)'+
        ' left join s_place sp on (sp.id=ss.place_type)'+
        ' where ss.id>0 and '+
        ' ss.id in (select z.id_sod from zavjav z where (delz=0 and (is_otl<>1 or is_otl is null ) ) and z.dt_in >="'+frm_Dt.DE_in.Text+' '+Time2Str(frm_Dt.TE_in.Time)+
               '" and z.dt_in<="'+frm_Dt.DE_out.Text+' '+Time2Str(frm_Dt.TE_out.Time)+'"'+zStrAttach+')'+
        ' order by 2'
               {
               'select id,name_r pole0,'+tt_sql+
               ' from s_sod where id>0 and '+
               'id in (select z.id_sod from zavjav z where (delz=0 and (is_otl<>1 or is_otl is null ) ) and z.dt_in >="'+frm_Dt.DE_in.Text+' '+Time2Str(frm_Dt.TE_in.Time)+
               '" and z.dt_in<="'+frm_Dt.DE_out.Text+' '+Time2Str(frm_Dt.TE_out.Time)+'"'+zStrAttach+')'
               }
               ,sTit,-1,NN7,false);
     Fres.StrGr_res.RowCount:=Fres.StrGr_res.RowCount+2;
     Fres.StrGr_res.Cells[0,Fres.StrGr_res.RowCount-1]:=TrLangMSG(msgITOGO);
     for i:=1 to Fres.StrGr_res.ColCount-2 do
      begin
       a:=0;
       for j:=1 to Fres.StrGr_res.RowCount-3 do
         a:=a+strtointdef(Fres.StrGr_res.Cells[i,j],0);

       Fres.StrGr_res.Cells[i,Fres.StrGr_res.RowCount-1]:=inttostr(a);
      end;
     //Fres.StrGr_res.Cells[2,Fres.StrGr_res.RowCount-1]:='100';
     Fres.StrGr_res.AdjustColWidths;
     Fres.StrGr_res.ColWidths[Fres.StrGr_res.ColCount-1]:=2;
     Fres.ShowModal;
     Qry_tmp.Close;
     sTit.Free;
end;

procedure TFormSah.PrintPer_Z;
var FRes:TFormResult;
    sTit:TstringList;
    tt_sql,tt_ras, dt_cond:string;
begin
   with Frm_Dt do
   begin
       SetNull;
       if not ProvDate(DE_in.Date,DE_Out.Date,Time2Str(TE_in.Time),Time2Str(TE_out.Time)) then
          exit;
       dt_cond:=' and z.dt_in>="'+DE_In.Text+' '+Time2Str(TE_In.Time)+
                '" and z.dt_in <="'+DE_Out.Text+' '+Time2Str(TE_Out.Time)+'"';
   end;

   tt_ras:='';
   sTit:=TstringList.Create;
   sTit.Add(' '+TrLangMSG(msgAddr)+' ');
   sTit.Add(' № наряда ');
   sTit.Add(' Дата откр. наряда');
   sTit.Add(' '+TrLangMSG(msgDopAddrShort)+' ');
   sTit.Add(' Дата пер.');
   sTit.Add(' '+TrLangMSG(msgWhoClose)+' ');
   if ChB_Open.Checked then
     begin
{       tt_sql:='select '+
               ' z.id idz,z.id_zavin id,z.id_ul1,z.id_ul2,z.dop_adr,z.id_dopadres,z.ul_kod kod_ul,z.dop_adr pole3,'+
               'z.dt_in pole4,b1.name_r pole5,d.diam pole6, '+
               'z.id_zavin as pole7 '+
               'from zadv z,s_brig b1,s_diam d '+
               ' where z.id_brin=b1.id and id_brout=-1 '+
               ' and z.id_diam=d.id'+dt_cond;
 }

       tt_sql:='select '+
               ' z.id idz,z.id_zavin id,z.id_ul1,z.id_ul2,z.dop_adr,z.id_dopadres,z.ul_kod kod_ul '+
               ', rtrim(ltrim(zj.nomer)||""||ltrim(zj.charnum)) pole1 ,  zj.dt_in pole2'+
               ',z.dop_adr pole3,'+
               'z.dt_in pole4,b1.name_r pole5,d.diam pole6, '+
               'z.id_zavin as pole7 '+
               'from zadv z,s_brig b1,s_diam d , nzavjav zj '+
               ' where z.id_brin=b1.id and id_brout=-1 '+
               ' and z.id_zavin = zj.id and z.id_diam=d.id'+dt_cond;

       wwater_col:=7;
       tt_ras:='('+TrLAngMSG(msgTempClosed)+') ';
     end
   else
     begin
       tt_sql:='select '+
               'z.id idz,z.id_zavout id,z.id_ul1,z.id_ul2,z.dop_adr,z.id_dopadres,z.ul_kod kod_ul '+
               ', rtrim(ltrim(zj.nomer)||""||ltrim(zj.charnum)) pole1 ,  zj.dt_in pole2'+
               ',z.dop_adr pole3,'+
               'z.dt_in pole4,b1.name_r pole5,z.dt_out pole6,b2.name_r pole7,d.diam pole8, '+
               'z.id_zavout as pole9 '+
               'from zadv z,s_brig b1,s_brig b2,s_diam d , nzavjav zj '+
               ' where z.id_brin=b1.id and z.id_brout=b2.id '+
               '   and z.id_zavin = zj.id and z.id_diam=d.id'+dt_cond;

       tt_sql := tt_sql + ' union select '+
               'z.id idz,z.id_zavout id,z.id_ul1,z.id_ul2,z.dop_adr,z.id_dopadres,z.ul_kod kod_ul '+
               ', rtrim(ltrim(zj.nomer)||""||ltrim(zj.charnum)) pole1 ,  zj.dt_in pole2'+
               ',z.dop_adr pole3,'+
               'z.dt_in pole4,b1.name_r pole5,z.dt_out pole6,b2.name_r pole7,d.diam pole8, '+
               'z.id_zavout as pole9 '+
               'from zadv z,s_brig b1,s_brig b2,s_diam d , zavjav zj '+
               ' where z.id_brin=b1.id and z.id_brout=b2.id '+
               '   and z.id_zavin = zj.id and z.id_diam=d.id'+dt_cond;

       wwater_col:=9;
       sTit.Add(' '+TrLangMSG(msgDateOpenShort));sTit.Add(' '+TrLangMSG(msgWhoOpen)+' ');
     end;
    sTit.Add(' '+TrLangMSG(msgDiam)+' ');
    sTit.Add('Абоненты без воды');
    Qry_tmp2.Close;
    old_id:=0;
    //fl:=false;
    FRes:=TFormResult.ResCreate(Self,false,'dbn_avar','Результат',
          {'Сводка перекрытых задвижек '}TrLangMSG(msgVedClosedZadv)+' '+tt_ras+'за '+TrLangMSG(msgRange)+' '{с '+
          DE_In.Text+' '+Time2Str(TE_in.Time)+' до '+DE_Out.Text+' '+
          Time2Str(TE_Out.Time)}+frm_dt.Titstr,
          tt_sql,sTit,0,NN1_PrintPerZ,false);
    FRes.ShowModal;
    sTit.Free;
end;


procedure TFormSah.PrintRask;
var FRes:TFormResult;
    sTit:TstringList;
   // kol_damg,kol_rayon,i:integer;
    tt_sql,tt_ras:string;
begin
   Frm_dt.SetNull;
   tt_ras:='';
   Frm_dt.t_db:='z';
   sTit:=TstringList.Create;
   sTit.Add(' '+TrLangMSG(msgAddr)+' ');sTit.Add(' Номер ');sTit.Add(' '+TrLAngMSG(msgDateRaskopShort));
   if (rbBury.Checked) then
     begin
       tt_ras:='('+TrLangMSG(msgTempNotDig)+') ';
{
       tt_sql:='select z.id id,z.id_ul1,z.id_ul2,z.kod_ul,z.dop_adr,z.nomer pole1,z.dt_in pole2,z.id_dopadres from zavjav z '+
               'where (delz=0 and (is_otl<>1 or is_otl is null ) ) and exists (select id from raskop r where (r.id_zavin=z.id) and (r.dt_out is null)) '+
               frm_dt.sqlstr+zStrAttach+
               ' union all '+
               'select z.id id,z.id_ul1,z.id_ul2,z.kod_ul,z.dop_adr,z.nomer pole1,z.dt_in pole2,z.id_dopadres from nzavjav z '+
               'where (delz=0 and (is_otl<>1 or is_otl is null ) ) and exists (select id from raskop r where (r.id_zavin=z.id) and (r.dt_out is null)) '+
               frm_dt.sqlstr+zStrAttach+
               ' order by 6';
}
       tt_sql:='select z.id id,z.id_ul1,z.id_ul2,z.kod_ul,z.dop_adr,z.nomer pole1,z.dt_in pole2,z.id_dopadres from zavjav z '+
               'where (delz=0 and (is_otl<>1 or is_otl is null ) ) and exists (select out_id from get_zav_raskops( z.id, ' + IntToStr( Ord( tsc_sw_ZASIPKA ) ) + ', -1, -1, -1 ) where out_dt_work1 is null) '+
               frm_dt.sqlstr+zStrAttach+
               ' union all '+
               'select z.id id,z.id_ul1,z.id_ul2,z.kod_ul,z.dop_adr,z.nomer pole1,z.dt_in pole2,z.id_dopadres from nzavjav z '+
               'where (delz=0 and (is_otl<>1 or is_otl is null ) ) and exists (select out_id from get_zav_raskops( z.id, ' + IntToStr( Ord( tsc_sw_ZASIPKA ) ) + ', -1, -1, -1 ) where out_dt_work1 is null) '+
               frm_dt.sqlstr+zStrAttach+
               ' order by 6';


     end
   else if (rbAsphalt.Checked) then
     begin
       tt_ras:='('+TrLangMSG(msgTempNotDig)+') ';
{
       tt_sql:='select z.id id,z.id_ul1,z.id_ul2,z.kod_ul,z.dop_adr,z.nomer pole1,z.dt_in pole2,z.id_dopadres from zavjav z '+
              'where (delz=0 and (is_otl<>1 or is_otl is null ) ) and exists (select id from raskop r where (r.id_zavin=z.id) and (r.dt_rec is null)) '+
              ' and (z.id_mest in (1,2)) '+
              frm_dt.sqlstr+zStrAttach+
              ' union all '+
              'select z.id id,z.id_ul1,z.id_ul2,z.kod_ul,z.dop_adr,z.nomer pole1,z.dt_in pole2,z.id_dopadres from nzavjav z '+
              'where (delz=0 and (is_otl<>1 or is_otl is null ) ) and exists (select id from raskop r where (r.id_zavin=z.id) and (r.dt_rec is null)) '+
              ' and (z.id_mest in (1,2)) '+
              frm_dt.sqlstr+zStrAttach+
              ' order by 6';
}

       tt_sql:='select z.id id,z.id_ul1,z.id_ul2,z.kod_ul,z.dop_adr,z.nomer pole1,z.dt_in pole2,z.id_dopadres from zavjav z '+
              'where (delz=0 and (is_otl<>1 or is_otl is null ) ) and exists (select out_id from get_zav_raskops( z.id, ' + IntToStr( Ord( tsc_sw_ASFALT ) ) + ', -1, -1, -1 ) where out_dt_work1 is null) '+
              ' and (z.id_mest in (1,2)) '+
              frm_dt.sqlstr+zStrAttach+
              ' union all '+
              'select z.id id,z.id_ul1,z.id_ul2,z.kod_ul,z.dop_adr,z.nomer pole1,z.dt_in pole2,z.id_dopadres from nzavjav z '+
              'where (delz=0 and (is_otl<>1 or is_otl is null ) ) and exists (select out_id from get_zav_raskops( z.id, ' + IntToStr( Ord( tsc_sw_ASFALT ) ) + ', -1, -1, -1 ) where out_dt_work1 is null) '+
              ' and (z.id_mest in (1,2)) '+
              frm_dt.sqlstr+zStrAttach+
              ' order by 6';



     end
   else if (rbAll.Checked) then
     begin
       tt_sql:='select z.id id,z.id_ul1,z.id_ul2,z.kod_ul,z.dop_adr,z.nomer pole1,z.dt_in pole2, z.id_dopadres from raskop r,zavjav z '+
              'where (delz=0 and (is_otl<>1 or is_otl is null ) ) and r.id_zavin=z.id '+frm_dt.sqlstr+zStrAttach+
              ' union all '+
              'select z.id id,z.id_ul1,z.id_ul2,z.kod_ul,z.dop_adr,z.nomer pole1,z.dt_in pole2, z.id_dopadres from raskop r,nzavjav z '+
              'where (delz=0 and (is_otl<>1 or is_otl is null ) ) and r.id_zavin=z.id '+frm_dt.sqlstr+zStrAttach+
              ' order by 6';
     end;         //Exception
    FRes:=TFormResult.ResCreate(Self,false,'dbn_avar','Результат',
          TrLangMSG(msgVedRaskop)+' '+tt_ras+'за '+TrLangMSG(msgRANGE)+' '{с '+
          DE_In.Text+' '+Time2Str(TE_in.Time)+' до '+DE_Out.Text+' '+
          Time2Str(TE_Out.Time)}+frm_dt.titstr,
          tt_sql,sTit,0,NIL,false);
    FRes.ShowModal;
    sTit.Free;
end;

procedure TFormSah.ust_viz(num:integer);
begin
     BB_Set.Enabled  :=false;
     BB_Set.Visible  :=false;
     ChB_Excel.Enabled :=false;
     ChB_Excel.Visible :=false;
     DBL_mat.Enabled :=false;
     DBL_mat.Visible :=false;
     DBL_Diam.Enabled:=false;
     DBL_Diam.Visible:=false;
     RB_bezr.Enabled :=false;
     RB_bezr.Visible :=false;
     RB_sr.Enabled   :=false;
     RB_sr.Visible   :=false;
     ChB_Open.Enabled:=false;
     ChB_Open.Visible:=false;
     RbAll.Enabled :=false;
     RbAll.Visible :=false;
     RbBury.Enabled :=false;
     RbBury.Visible :=false;
     RbAsphalt.Enabled :=false;
     RbAsphalt.Visible :=false;

   if num=0 then
    begin
     BB_Set.Enabled:=true;
     BB_Set.Visible:=true;
     ChB_Excel.Enabled :=true;
     ChB_Excel.Visible :=true;
    end
   else if num=2 then
    begin
     DBL_mat.Enabled :=true;
     DBL_mat.Visible :=true;
    end
   else if num=3 then
    begin
     DBL_mat.Enabled :=true;
     DBL_mat.Visible :=true;
//     DBL_Diam.Enabled:=true;
//     DBL_Diam.Visible:=true;
    end
   else if num=4 then
    begin
//     RB_bezr.Enabled :=true;
//     RB_bezr.Visible :=true;
//     RB_sr.Enabled   :=true;
//     RB_sr.Visible   :=true;
    end
   else if num=5 then
    begin
     ChB_Open.Enabled:=true;
     ChB_Open.Visible:=true;
    end
   else if num=6 then
    begin
     RbAll.Enabled :=true;
     RbAll.Visible :=true;
     RbBury.Enabled :=true;
     RbBury.Visible :=true;
     RbAsphalt.Enabled :=true;
     RbAsphalt.Visible :=true;

    end;
end;
procedure TFormSah.FormDestroy(Sender: TObject);
begin
  if not VarIsEmpty(XLApp) then begin
    XLApp.DisplayAlerts := False;  // Discard unsaved files....
    XLApp.Quit;
    XLApp:=UnAssigned;
  end;

end;

procedure TFormSah.MyProsmClose(Sender: TObject; var Action: TCloseAction);
begin
  if Fl_Work then
     Fl_Work:=false
  else
    begin
     FormDestroy(FormSah);
     Prosm.FormClose(Sender,Action);
    end
end;
{
select name_r,
(select count(id) from zavjav where dt_in>="01.07.1999" and
dt_in<="31.07.1999" and id_damg=d.id) cnt07,
(select count(id) from zavjav where dt_in>="01.08.1999" and
dt_in<="31.08.1999" and id_damg=d.id) cnt8,
(select count(id) from zavjav where dt_in>="01.09.1999" and
dt_in<="30.09.1999" and id_damg=d.id) cnt9
from s_damg d
}
procedure TFormSah.Translate;
begin
  inherited;
  Caption:=TrLangMSG(msgVedPovrChess);
  RG_vib.Caption:=TrLangMSG(msgChoseRep);
  RG_vib.Items[0]:=TrLangMSG(msgVedPovrChess);
  RG_vib.Items[1]:=TrLangMSG(msgVedLikvidirPovrForRange);
  RG_vib.Items[2]:=TrLangMSG(msgVedUsedMat);
  RG_vib.Items[3]:=TrLangMSG(msgVedUsedMatDiam);
  RG_vib.Items[4]:=TrLangMSG(msgSvodkaLikvPovr);
  RG_vib.Items[5]:=TrLangMSG(msgVedClosedZadv);
  RG_vib.Items[6]:=TrLangMSG(msgVedRaskop);
  BB_Set.Caption:=TrLangMSG(msgNastrojka);
  RB_bezr.Caption:=TrLangMSG(msgWithoutDigging);
  RB_sr.Caption:=TrLangMSG(msgWithDigging);
  ChB_open.Caption:=TrLangMSG(msgOnlyNotOpened);
  rbAll.Caption:=TrLangMSG(msgAll);
  rbBury.Caption:=TrLangMSG(msgBury);
  rbAsphalt.Caption:=TrLangMSG(msgAsphalt);
  ChB_Excel.Caption:=TrLangMSG(msgOutput)+' Excel';
  BB_ok.Caption:=TrLangMSG(msgApply);
  BB_Exit.Caption:=TrLangMSG(msgExit);
end;

end.

