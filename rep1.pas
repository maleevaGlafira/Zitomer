unit rep1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, RxLookup, Buttons, Db, DBTables, DateUtil, frmLANG, cntsLANG,
  OperAttFormUnit;

type
  TRep1F = class(TOperAttForm)
    Panel1: TPanel;
    Sod_lcb: TRxDBLookupCombo;
    Quarte_cb: TComboBox;
    Year_cb: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Bevel1: TBevel;
    BtOk: TBitBtn;
    BitBtn1: TBitBtn;
    Qr1: TQuery;
    Vidrep_rg: TRadioGroup;
    Period_rg: TRadioGroup;
    Label4: TLabel;
    Mat_lcb: TRxDBLookupCombo;
    EmptyRows_chb: TCheckBox;
    procedure BtOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Mat_lcbChange(Sender: TObject);
    procedure Quarte_cbChange(Sender: TObject);
    procedure Year_cbChange(Sender: TObject);
    procedure Sod_lcbChange(Sender: TObject);
    procedure Period_rgClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure FormDestroy(Sender: TObject);
  private
    StrAttach:String;
    procedure CtrlState;
  public
    procedure Translate;override;
  end;

var
 Rep1F: TRep1F;

implementation
  uses fresult, avartype, datam, HelpFunctions;

 const
  Mat_DisplEmpt = '< все >';

{$R *.DFM}
//*******************************************************************
procedure TRep1F.BtOkClick(Sender: TObject);
var
  FRes:TFormResult;
  sTit:TstringList;
  masp :MasPeriod;
 // _dt_begin,_dt_end :array [1..4] of string;
  dic_tbl,dic_field,link_cond, mat_cond :string;
  str1, sod_table,sod_cond :string;
  i,j{, indx1} :integer;
  mascount :array [1..4] of integer;
  allcount :integer;
  _col_count :integer;
  per :integer;
  top_label :string;
  Empty_Row :boolean;
  Fill_Rows :integer;
begin
 strAttach:=' and (id_attach='+IntToStr(ord(OperateAttach))+')';
 FillChar(mascount, sizeof(mascount), 0);
 sTit:=TstringList.Create;
 try
   if Mat_lcb.Text = Mat_DisplEmpt
      then mat_cond:='' // все
      else mat_cond:=Format('(matr.id_mat = %s)and',[Mat_lcb.Value]);

   if Sod_lcb.Text = Mat_DisplEmpt
      then begin
            sod_table:='';
            sod_cond:='';
           end
      else begin
            sod_table:=', s_sod sod ';
            sod_cond:=Format(' (z.id_sod = sod.id)and(sod.id = %s)and ',[Sod_lcb.Value]);
           end;

   if Vidrep_rg.ItemIndex = 0{диаметр}
      then begin
            dic_tbl:='s_diam'; dic_field:='diam'; link_cond:='(matr.id_diam = s.id)';
            sTit.Add(TrLangMSG(msgDiam));
           end
      else begin {РАйон}
            dic_tbl:='s_revs'; dic_field:='name_r'; link_cond:='(z.id_revs = s.id)';
            sTit.Add(TrLangMSG(msgREV));
           end;

   top_label:='';
   if Sod_lcb.text <> Mat_DisplEmpt then top_label:=Sod_lcb.text
                                    else top_label:=TrLangMSG(msgVedomost)+' ';

   if Mat_lcb.text = Mat_DisplEmpt
      then begin
            if Sod_lcb.text = Mat_DisplEmpt then
               top_label:=top_label +' '+ansilowercase(TrLangMSG(msgMaters))+' ';
           end
      else if top_label <> '' then
              top_label:=top_label +' ('+Mat_lcb.text+') ';

   if Period_rg.ItemIndex = 0{квартал} then
     begin
      top_label:=top_label +Format('за %s-й квартал %s года',
                        [Quarte_cb.Text, Year_cb.Text]);
      _col_count:=3;
      masp:=GetDatePeriod(StrToInt(Year_cb.Text), StrToInt(Quarte_cb.Text));
      for i:=1 to _col_count do sTit.Add(masp[i].title);
      sTit.Add(Format(TrLangMSG(msgAllCount)+' за %s кв.',[Quarte_cb.Text]));
     end // if Period_rg = 0 ...
      else begin {год}
            top_label:=top_label +Format('за %s '+ansilowercase(TrLangMSG(msgYear)),[Year_cb.Text]);
            _col_count:=4;
            masp:=GetDatePeriod(StrToInt(Year_cb.Text));
            for i:=1 to _col_count do sTit.Add(masp[i].title);
            sTit.Add(TrLangMSG(msgAllCount)+' за '+ansilowercase(TrLangMSG(msgYear)));
           end; // if Period_rg = 0 ... else

   sTit.Add(TrLangMSG(msgPercentForAmount));

   if Qr1.Active then Qr1.Close;
   Qr1.SQL.Clear;
   with Qr1 do
    begin
     str1:='';
     for i:=1 to _col_count do
//uo       str1:=str1 + Format(' (select count(matr.id) from zavjav z, maters matr %s '+
       str1:=str1 + Format(' (select sum(matr.kol_mat) from zavjav z, maters matr %s '+
                      '  where (delz=0) and %s '+StrAttach+' and %s '+
                      // '    (z.id_sod = sod.id)and(sod.id = %s)and '+
                          ' (matr.id_zav = z.id)and %s '+
                          ' (z.dt_out >= "%s")and(z.dt_out <= "%s")) as c%d, ',
               [sod_table, link_cond, sod_cond, mat_cond,
                masp[i].begin_d, masp[i].end_d, i]);

     System.Delete(str1, length(str1)-1, 1);
     SQL.Text:=Format('select s.%s, %s from %s s '+
                       'where s.id > 0 '+
                       'order by s.%s ',[dic_field, str1, dic_tbl, dic_field]);
    end; // with
    try
     Qr1.Open;
    except
     MessageBoxEx(application.handle,
         pchar('  '+TrLangMSG(msgErrorExecQuery)),
         pchar(TrLangMSG(msgError)), MB_OK+MB_ICONERROR+MB_SETFOREGROUND,$0419);
     exit;
    end;

   FRes:=TFormResult.ResCreate(Self,false,'dbn_avar','Результат',top_label,'',
             sTit,-1,nil,false, true{группировка}, false{не заполнять StringGrid});
//   FRes.Show;
   with FRes do
    begin
       PrBar.Position:=0;
       PrBar.Max:=Qr1.RecordCount +10;
       StrGr_res.FixedCols:=1;
       Fill_Rows:=0;
       if FRes.Visible then ShowProgress:=true; // ds
       while not Qr1.EOF do
        begin
          Empty_Row:=true;
          StrGr_res.Cells[0,StrGr_res.RowCount-1]:=Qr1.Fields[0].asString; // справочник(значения)
          for i:=1 to _col_count do
           begin
            //StrGr_res.Cells[i,StrGr_res.RowCount-1]:= Qr1.Fields[i].asString; // данные отчета
            StrGr_res.Cells[i,StrGr_res.RowCount-1]:= HelpFunctions.FieldAsString( Qr1.Fields[i] ); // данные отчета
            mascount[i]:=mascount[i] + Qr1.Fields[i].asInteger;
            if Empty_Row then Empty_Row:=(Qr1.Fields[i].asInteger = 0);
           end; // for i
          Qr1.Next;

          if (EmptyRows_chb.Checked)and(Empty_Row)
             then StrGr_res.Rows[StrGr_res.RowCount-1].Clear
             else begin
                   StrGr_res.RowCount:=StrGr_res.RowCount+1;
                   inc(Fill_Rows);
                  end;

          if FRes.Visible then
            begin
             PrBar.Position:=PrBar.Position+1;
             StatusBar1.Repaint;
            end; // if FRes.Visible ...
        end; // while

       if (EmptyRows_chb.Checked)and(Fill_Rows = 0) then
         begin
           MessageBoxEx(application.handle,
               pchar('  '+TrLangMSG(msgDataForRangeNotExist)),
               pchar(TrLangMSG(msgInform)), MB_OK+MB_ICONINFORMATION+MB_SETFOREGROUND,$0419);
           Fres.Free;
           exit;
         end; // if (Empty_Row)and( ...

       allcount:=0;
       for i:=1 to _col_count do allcount:=allcount + mascount[i];
       for i:=1 to StrGr_res.RowCount-2{чтобы не зап. пустую строку} do
        begin
         per:=0;
         for j:=1 to _col_count do
           per:=per + StrToIntDef(StrGr_res.Cells[j,i], 0);
         StrGr_res.Cells[_col_count+1{всего},i]:=IntToStr(per);
         if allcount = 0
            then StrGr_res.Cells[_col_count+2{%},i]:='0'
            else StrGr_res.Cells[_col_count+2{%},i]:=FloatToStrF((per/allcount)*100,ffGeneral,3,2);
        end; // for i
       StrGr_res.RowCount:=StrGr_res.RowCount+2;
       StrGr_res.Cells[0,StrGr_res.RowCount-1]:=ansiuppercase(TrLangMSG(msgAllCount));
       for i:=1 to _col_count do
         StrGr_res.Cells[i,StrGr_res.RowCount-1]:=IntToStr(mascount[i]);
       StrGr_res.Cells[_col_count+1 ,StrGr_res.RowCount-1]:=IntToStr(allcount);
       StrGr_res.Cells[_col_count+2 ,StrGr_res.RowCount-1]:='100%';
       //StrGr_res.RowCount:=StrGr_res.RowCount+1;
       if FRes.Visible then PrBar.Position:=PrBar.Max - 5;

       isIdView:=true;
       ChLB_Pol.ApplyState(cbChecked,false);
       Upd_Cols;
       PrBar.Position:=PrBar.Max;
       if FRes.Visible then ShowProgress:=false; // ds
       StrGr_res.AdjustColWidths;
       Fres.NumCols:=Fill_Rows;
       Fres.Caption:='Результат - '+TrLangMSG(msgCount)+': '+IntToStr(Fill_Rows);
       FRes.ShowModal;
    //   StrGr_res.SetFocus;
  // Fres.StrGr_res.ColWidths[Fres.StrGr_res.ColCount-1]:=2;
   end; // with
 finally
  sTit.Free;
 end;
end;

//*******************************************************************
procedure TRep1F.FormCreate(Sender: TObject);
begin
 Mat_lcb.DisplayEmpty:=Mat_DisplEmpt;
 Sod_lcb.DisplayEmpty:=Mat_DisplEmpt;
 Sod_lcb.ResetField;
 if not dm1.s_mat_q.active then dm1.s_mat_q.open;
 CtrlState;
end;

//*******************************************************************
procedure TRep1F.Mat_lcbChange(Sender: TObject);
begin
 if Mat_lcb.Value = '' then exit;
 if (Vidrep_rg.ItemIndex = 0{диаметр})and
    (not IsMatDiamPresent(StrToIntDef(Mat_lcb.Value, -1)))
    then begin
           MessageBoxEx(application.handle,
               pchar('  '+TrLangMSG(msgMaterOne)+' "'+Mat_lcb.Text+'" '+TrLangMSG(msgNotConsistOfDiam)+'.'),
               pchar(TrLangMSG(msgInform)), MB_OK+MB_ICONINFORMATION+MB_SETFOREGROUND,$0419);
           Mat_lcb.ResetField;
         end;
end;

//*******************************************************************
procedure TRep1F.CtrlState;
begin
 Quarte_cb.Enabled:=(Period_rg.ItemIndex = 0{квартал});
 BtOk.Enabled:=(StrToIntDef(Year_cb.Text,-1) > -1);
               {and
               (StrToIntDef(Sod_lcb.Value, -1) > -1);}
end;

//*******************************************************************
procedure TRep1F.Quarte_cbChange(Sender: TObject);
begin
 if not (StrToIntDef(Quarte_cb.Text, -1) in [1,2,3,4])
    then Quarte_cb.text:='1';
end;

//*******************************************************************
procedure TRep1F.Year_cbChange(Sender: TObject);
var
 _curYear, _curMonth, _curDay :word;
begin
 if length(Year_cb.Text) >= 4 then
  begin
   _curYear:=StrToIntDef(Year_cb.Text, -1);
   if not (_curYear > 1980)and(_curYear < 2080)
      then begin
            DecodeDate(now, _curYear, _curMonth, _curDay);
            Year_cb.text:=IntToStr(_curYear);
           end;
  end; // if length(Year_cb.Text) >= 4 ...
 CtrlState;
end;

//*******************************************************************
procedure TRep1F.Sod_lcbChange(Sender: TObject);
begin
 CtrlState;
end;

//*******************************************************************
procedure TRep1F.Period_rgClick(Sender: TObject);
begin
 CtrlState;
end;

//*******************************************************************
procedure TRep1F.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action:=caFree;
end;

procedure TRep1F.FormDestroy(Sender: TObject);
begin
 Rep1F:=nil;
end;

procedure TRep1F.Translate;
begin
  inherited;
  Label1.Caption:=TrLangMSG(msgContext)+' наряда';
  Label3.Caption:=TrLangMSG(msgYear);
  Label4.Caption:=TrLangMSG(msgMaterOne);
  BtOk.Caption:=TrLangMSG(msgApply);
  BitBtn1.Caption:=TrLangMSG(msgExit);
  Period_rg.Caption:=' '+TrLangMSG(msgRange)+' ';
  Period_rg.Items[1]:=TrLangMSG(msgYear);
  Vidrep_rg.Items[0]:=TrLangMSG(msgDiam);
  Vidrep_rg.Items[1]:=TrLangMSG(msgREV);
  EmptyRows_chb.Caption:=TrLangMSG(msgNotShowNullRow);
end;

end.
