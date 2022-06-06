unit rep3;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, CheckLst, ExtCtrls, Buttons, frmLANG, cntsLANG, OperAttFormUnit;

type
  TRep3F = class(TOperAttForm)
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Bevel1: TBevel;
    Quarte_cb: TComboBox;
    Year_cb: TComboBox;
    BtOk: TBitBtn;
    BitBtn1: TBitBtn;
    Period_rg: TRadioGroup;
    Vidrep_rg: TRadioGroup;
    Mat_lch: TCheckListBox;
    AllMat_chb: TCheckBox;
    Extend_chb: TCheckBox;
    EmptyRows_chb: TCheckBox;
    procedure BtOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Quarte_cbChange(Sender: TObject);
    procedure Year_cbChange(Sender: TObject);
    procedure Mat_lchClickCheck(Sender: TObject);
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
 Rep3F: TRep3F;

implementation
 uses avartype, datam, fresult, HelpFunctions;

{$R *.DFM}
//*******************************************************************
procedure TRep3F.BtOkClick(Sender: TObject);
var
 masp :MasPeriod;
 FRes:TFormResult;
 dic_tbl,dic_field,link_cond,cond_mat,select_cond :string;
 sTit:TstringList;
 i,j,k,per,_col_count,_idmat :integer;
 CountList, CtListPeriods :TList;
 str1, top_label :string;
 PeriodCount,ExtCol :integer;
 Empty_Row :boolean;
 Fill_Rows :integer;
begin
 strAttach:=' and (id_attach='+IntToStr(ord(OperateAttach))+')';
// FillChar(mascount, sizeof(mascount), 0);
 sTit:=TstringList.Create;
 CountList:=TList.Create;
 CtListPeriods:=TList.Create;
 if Vidrep_rg.ItemIndex = 0{диаметр}
    then begin
          dic_tbl:='s_diam'; dic_field:='diam'; link_cond:='(matr.id_diam = s.id)';
          sTit.Add(TrLangMSG(msgDiam));
         end
    else begin {Район}
          dic_tbl:='s_revs'; dic_field:='name_r'; link_cond:='(z.id_revs = s.id)';
          sTit.Add(TrLangMSG(msgREV));
         end;

 top_label:=TrLangMSG(msgUsePipeFor);
 if Period_rg.ItemIndex = 0{квартал} then
   begin
    top_label:=Format('%s %s-й квартал %s '+TrLangMSG(msgOnYear),[top_label, Quarte_cb.Text, Year_cb.Text]);
    PeriodCount:=3;
    masp:=GetDatePeriod(StrToInt(Year_cb.Text), StrToInt(Quarte_cb.Text));
   end // if Period_rg = 0 ...
    else begin {год}
          top_label:=Format('%s %s-й '+TrLangMSG(msgYear),[top_label, Year_cb.Text]);
          PeriodCount:=4;
          masp:=GetDatePeriod(StrToInt(Year_cb.Text));
         end; // if Period_rg = 0 ... else

 str1:='';
 _col_count:=0;
//uo select_cond:=' (select count(matr.id) from zavjav z, maters matr '+
 select_cond:=' (select sum(kol_mat) from zavjav z, maters matr '+
                  ' where (delz=0) and %s '+StrAttach+' and '+
                        ' (matr.id_zav = z.id)and %s '+
                        ' (z.dt_out >= "%s")and(z.dt_out <= "%s")), ';
 if AllMat_chb.Checked then ExtCol:=1
                       else ExtCol:=0;
 for i:=0 to Mat_lch.Items.Count-1+ExtCol do
   begin
     _idmat:=-1;
     if (AllMat_chb.Checked)and(i = Mat_lch.Items.Count-1+ExtCol)
     then begin
           sTit.Add(TrLangMSG(msgAll));
           cond_mat:='';
           _idmat:=1;
          end // if (AllMat_chb.Checked)and ...
           else if Mat_lch.Checked[i] then
              begin
               sTit.Add(Mat_lch.Items[i]);
               _idmat:=Integer(Mat_lch.Items.Objects[i]);
               cond_mat:=Format('(matr.id_mat = %d)and ',[_idmat]);
              end;

      if _idmat > 0 then
        begin
         if Extend_chb.Checked then
            for j:=1 to PeriodCount do // по периодам(месяцы кавртала, кв. года)
              begin
                sTit.Add(' ');
                str1:=str1 + Format(select_cond,
                   [link_cond, cond_mat, masp[j].begin_d, masp[j].end_d]);
              end; // for i:=1 to PeriodCount

          sTit.Add(' % ');
          str1:=str1 + Format(select_cond,
          {' (select count(matr.id) from zavjav z, maters matr '+
             '     where %s and '+
                       ' (matr.id_zav = z.id)and %s '+
                       ' (z.dt_in >= "%s")and(z.dt_in <= "%s")) as c%d, '}
             [link_cond, cond_mat, masp[1].begin_d, masp[PeriodCount].end_d]);
          inc(_col_count);
        end; // if _idmat > 0 ...
     end; // for
 Delete(str1, length(str1)-1, 1);

 with DM1 do
  begin
   if tempQr_q.Active then tempQr_q.Close;
   tempQr_q.SQL.Clear;
   with tempQr_q do
    begin
     SQL.Text:=Format('select s.%s, %s'+
           'from %s s '+
           'where (s.id > 0) '+
           'order by s.%s ',
           [dic_field, str1, dic_tbl, dic_field]);
    end; // with
    try
     tempQr_q.Open;
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
      StrGr_res.FixedCols:=1;
      if Extend_chb.Checked then
        begin
         StrGr_res.RowCount:=StrGr_res.RowCount + 1;
         StrGr_res.FixedRows:=2;
         for i:=1 to StrGr_res.ColCount-1 do // очищаем шапку
          for j:=0 to 1 do
            StrGr_res.Cells[i,j]:='';

         for i:=0 to PeriodCount-1 do // 1-ая строка шапки
           StrGr_res.Cells[i*_col_count+1,0]:=masp[i+1].title;
         StrGr_res.Cells[PeriodCount*_col_count +1,0]:=top_label;

         for j:=0 to PeriodCount-1 do // периоды
          begin
           k:=1;
           for i:=0 to Mat_lch.Items.Count-1 do // 2-ая строка шапки
             if Mat_lch.Checked[i] then
              begin
               StrGr_res.Cells[j*_col_count+k,1]:=Mat_lch.Items[i];
               StrGr_res.Cells[PeriodCount*_col_count+k*2-1,1]:=Mat_lch.Items[i];
               StrGr_res.Cells[PeriodCount*_col_count+k*2,1]:='%'; // %
               inc(k);
              end; // i
           if AllMat_chb.Checked then
              StrGr_res.Cells[(j+1)*_col_count,1]:='Все';
          end; // j

          if AllMat_chb.Checked then
            begin
             StrGr_res.Cells[StrGr_res.ColCount-2,1]:='Все';
             StrGr_res.Cells[StrGr_res.ColCount-1,1]:='%';
            end;
        end; // if Extend_chb.Checked ...

       PrBar.Position:=0;
       PrBar.Max:=tempQr_q.RecordCount +10;
       Fill_Rows:=0;
       if FRes.Visible then ShowProgress:=true; // ds
       for i:=1 to _col_count do CountList.Add(pointer(0)); // инициализируем
       if Extend_chb.Checked
         then for i:=1 to PeriodCount*_col_count do CtListPeriods.Add(pointer(0)) // инициализируем
         else PeriodCount:=0;

       while not tempQr_q.EOF do
        begin
          Empty_Row:=true;
          StrGr_res.Cells[0,StrGr_res.RowCount-1]:=tempQr_q.Fields[0].asString; // справочник(знвчения)
          if Extend_chb.Checked then
            for i:=0 to PeriodCount-1 do // заполнение периодов
             for j:=1 to _col_count do
              begin
               StrGr_res.Cells[(i*_col_count+j),StrGr_res.RowCount-1]:=tempQr_q.Fields[{(_col_count+1)*i+j}(j-1)*PeriodCount+j+i].asString;
               CtListPeriods.Items[i*_col_count+j-1]:=pointer(integer(CtListPeriods.Items[i*_col_count+j-1]) +
                                                    tempQr_q.Fields[{(_col_count+1)*i+j}(j-1)*PeriodCount+j+i].asInteger);
              end;

             for i:=1 to _col_count do // заполнение обобщенных данных
               begin
                if Extend_chb.Checked then k:=(PeriodCount+1)*i
                                      else k:=i;
                //StrGr_res.Cells[_col_count*PeriodCount+i*2-1,StrGr_res.RowCount-1]:=  tempQr_q.Fields[k].asString;
                StrGr_res.Cells[_col_count*PeriodCount+i*2-1,StrGr_res.RowCount-1] := HelpFunctions.FieldAsString( tempQr_q.Fields[k] );
                CountList.Items[i-1]:=pointer(integer(CountList.Items[i-1]) + tempQr_q.Fields[k].asInteger);
                if Empty_Row then Empty_Row:=(tempQr_q.Fields[k].asInteger = 0);
               end; // for i

             if (EmptyRows_chb.Checked)and(Empty_Row)
                 then StrGr_res.Rows[StrGr_res.RowCount-1].Clear
                 else begin
                       inc(Fill_Rows);
                       StrGr_res.RowCount:=StrGr_res.RowCount+1;
                      end; // if (EmptyRows_chb.Checked)and(Empty_Row) ... else

          tempQr_q.Next;

          if FRes.Visible then
            begin
              PrBar.Position:=PrBar.Position+1;
              StatusBar1.Repaint;
            end;
        end; // while

       if (EmptyRows_chb.Checked)and(Fill_Rows = 0) then
         begin
           MessageBoxEx(application.handle,
           pchar('  '+TrLangMSG(msgDataForRangeNotExist)),
           pchar(TrLangMSG(msgInform)), MB_OK+MB_ICONINFORMATION+MB_SETFOREGROUND,$0419);
           Fres.Free;
           exit;
         end; // if (Empty_Row)and( ...

       for i:=StrGr_res.FixedRows to StrGr_res.RowCount-2{чтобы не зап. пустую строку} do
        begin
//         per:=0;
         for j:=1 to _col_count do
          if integer(CountList.Items[j-1]) = 0
              then StrGr_res.Cells[_col_count*PeriodCount+j*2{%},i]:='0'
              else begin
                    per:=StrToIntDef(StrGr_res.Cells[_col_count*PeriodCount+j*2-1,i], 0);
                    StrGr_res.Cells[_col_count*PeriodCount+j*2{%},i]:=FloatToStrF((per/integer(CountList.Items[j-1]))*100,ffGeneral,3,2);
                   end; // j
        end; // for i
       StrGr_res.RowCount:=StrGr_res.RowCount+2;
       StrGr_res.Cells[0,StrGr_res.RowCount-1]:=AnsiUpperCase(TrLangMSG(msgAllCount));

       for i:=0 to PeriodCount-1 do // заполнение периодов
         for j:=1 to _col_count do
          StrGr_res.Cells[(i*_col_count+j),StrGr_res.RowCount-1]:=IntToStr(integer(CtListPeriods.Items[i*_col_count+j-1]));

       for i:=1 to _col_count do
        begin
         StrGr_res.Cells[_col_count*PeriodCount+i*2-1,StrGr_res.RowCount-1]:=IntToStr(integer(CountList.Items[i-1]));
         StrGr_res.Cells[_col_count*PeriodCount+i*2,StrGr_res.RowCount-1]:='100%';
        end;
       if FRes.Visible then PrBar.Position:=PrBar.Max - 5;

       isIdView:=true;
       ChLB_Pol.ApplyState(cbChecked,false);
       Upd_Cols;
       if FRes.Visible then PrBar.Position:=PrBar.Max;
       ShowProgress:=false; // ds
       StrGr_res.AdjustColWidths;
       Fres.NumCols:=Fill_Rows;
       Fres.Caption:='Результат - '+TrLangMSG(msgCount)+': '+IntToStr(Fill_Rows);
       FRes.ShowModal;
//       StrGr_res.SetFocus;
  // Fres.StrGr_res.ColWidths[Fres.StrGr_res.ColCount-1]:=2;
   end; // with
   CountList.Free;
   CtListPeriods.Free;
   sTit.Free;
 end; // with
end;

//*******************************************************************
procedure TRep3F.FormCreate(Sender: TObject);
begin
 with DM1 do
   try
    if not S_mat_q.Active then S_mat_q.Open;
    Mat_lch.Clear;
    S_mat_q.disablecontrols;
    S_mat_q.First;
    while not S_mat_q.EOF do
      begin
//       if (Pos('ТРУБА', AnsiUpperCase(S_mat_qNAME_R.asString)) <> 0)and
  //        ((Pos( 'М'{lat}, AnsiUpperCase(S_mat_qED_IZM.asString)) <> 0)or
    //       (Pos('М'{rus}, AnsiUpperCase(S_mat_qED_IZM.asString)) <> 0))
      //   then begin
               Mat_lch.Items.AddObject(S_mat_qNAME_R.asString, pointer(S_mat_qID.asInteger));
               Mat_lch.Checked[Mat_lch.Items.Count-1]:=true;
        //      end;
       S_mat_q.Next;
      end; // while
   finally
     S_mat_q.EnableControls;
   end; // with
 CtrlState;

end;

//*******************************************************************
procedure TRep3F.CtrlState;
begin
 Quarte_cb.Enabled:=(Period_rg.ItemIndex = 0{квартал});
 BtOk.enabled:=(StrToIntDef(Year_cb.Text,-1) > -1)and
               (CheckCheckedCHLB(Mat_lch));
end;

//*******************************************************************
procedure TRep3F.Quarte_cbChange(Sender: TObject);
begin
 if not (StrToIntDef(Quarte_cb.Text, -1) in [1,2,3,4])
    then Quarte_cb.text:='1';
end;

//*******************************************************************
procedure TRep3F.Year_cbChange(Sender: TObject);
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
procedure TRep3F.Mat_lchClickCheck(Sender: TObject);
begin
 CtrlState;
end;

//*******************************************************************
procedure TRep3F.Period_rgClick(Sender: TObject);
begin
 CtrlState;
end;

//*******************************************************************
procedure TRep3F.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action:=caFree;
end;

procedure TRep3F.FormDestroy(Sender: TObject);
begin
 Rep3F:=nil;
end;

procedure TRep3F.Translate;
begin
  inherited;
  Label3.Caption:=TrLangMSG(msgYear);
  BtOk.Caption:=TrLangMSG(msgApply);
  BitBtn1.Caption:=TrLangMSG(msgExit);
  Period_rg.Caption:=' '+TrLangMSG(msgRange)+' ';
  Period_rg.Items[1]:=TrLangMSG(msgYear);
  Vidrep_rg.Items[0]:=TrLangMSG(msgDiam);
  Vidrep_rg.Items[1]:=TrLangMSG(msgREV);
  AllMat_chb.Caption:=TrLangMSG(msgAllMaters);
  Extend_chb.Caption:=TrLangMSG(msgExReport);
  EmptyRows_chb.Caption:=TrLangMSG(msgNotShowNullRow);
end;

end.
