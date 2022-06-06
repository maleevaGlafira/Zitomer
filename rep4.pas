unit rep4;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, CheckLst, ExtCtrls, Buttons, RxLookup, frmLANG, cntsLang,OperAttFormUnit;

type
  TRep4F = class(TOperAttForm)
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Bevel1: TBevel;
    Quarte_cb: TComboBox;
    Year_cb: TComboBox;
    BtOk: TBitBtn;
    BExit: TBitBtn;
    Period_rg: TRadioGroup;
    Diam_lchb: TCheckListBox;
    Damg_lchb: TCheckListBox;
    ShortForm_ed: TEdit;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    Label1: TLabel;
    Label4: TLabel;
    Rayon_lcb: TRxDBLookupCombo;
    Excavation_chb: TCheckBox;
    EmptyRows_chb: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure ShortForm_edChange(Sender: TObject);
    procedure BtOkClick(Sender: TObject);
    procedure Quarte_cbChange(Sender: TObject);
    procedure Damg_lchbClick(Sender: TObject);
    procedure Year_cbChange(Sender: TObject);
    procedure Period_rgClick(Sender: TObject);
    procedure Damg_lchbClickCheck(Sender: TObject);
    procedure Diam_lchbClickCheck(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    StrAttach:String;
    mlen :integer;
    InitDiamMas :TStringList;
    InitDamgMas :TStringList;
    procedure CtrlState;
    function getItems(in_str :string; ShortOnly :boolean=false;
                        trim_fl:boolean=false; short_nm :boolean=false) :string;
    function FindValueInDefMas(mas :TStringList; v :string) :boolean;
  public
    { Public declarations }
    procedure Translate;override;
  end;

var
 Rep4F: TRep4F;

implementation

uses datam, strtool, avartype, fresult;
  const
   separ_shortform = '  | ';
   rayon_DisplEmpt = '< все >';
   MAX_DIAM_CONST = 100000000;
   Union_cond = 'union all';
  { InitDiamMas :array [1..17] of integer =
               (50,75,100,150,200,250,300,350,400,500,600,700,800,900,1000,
                            1200,1400);}
  // space_str = '                                                   ';

{$R *.DFM}
//*******************************************************************
procedure TRep4F.FormCreate(Sender: TObject);
var
 i :integer;
begin
 rayon_lcb.Anchors:=[akLeft,akTop,akRight];
 StaticText2.Anchors:=[akLeft,akTop,akRight];
 Diam_lchb.Anchors:=[akLeft,akTop,akBottom];
 Damg_lchb.Anchors:=[akLeft,akTop,akRight,akBottom];
 ShortForm_ed.Anchors:=[akLeft,akRight,akBottom];
 Bevel1.Anchors:=[akLeft,akRight,akBottom];
 BtOk.Anchors:=[akRight,akBottom];
 BExit.Anchors:=[akRight,akBottom];
 EmptyRows_chb.Anchors:=[akLeft,akBottom];
 BorderStyle:=bsSizeable;

{ Constraints.MaxWidth:=Width;
 Constraints.MinWidth:=Width;}
 InitDiamMas:=TStringList.Create;
 InitDamgMas:=TStringList.Create;

 InitDiamMas.Add('50');           InitDamgMas.Add('');
 InitDiamMas.Add('75');
 InitDiamMas.Add('100');
 InitDiamMas.Add('150');
 InitDiamMas.Add('200');
 InitDiamMas.Add('250');
 InitDiamMas.Add('300');
 InitDiamMas.Add('350');
 InitDiamMas.Add('400');
 InitDiamMas.Add('500');
 InitDiamMas.Add('600');
 InitDiamMas.Add('700');
 InitDiamMas.Add('800');
 InitDiamMas.Add('900');
 InitDiamMas.Add('1000');
 InitDiamMas.Add('1200');
 InitDiamMas.Add('1400');

 with DM1 do
   try
    rayon_lcb.DisplayEmpty:=rayon_DisplEmpt;
    if not S_revs_q.Active then S_revs_q.Open;
    if not S_tzav_q.Active then S_tzav_q.Open;
    mlen:=0;
    Damg_lchb.Clear;
    S_tzav_q.disablecontrols;
    S_tzav_q.First;
    while not S_tzav_q.EOF do
      begin
//nut anton
       if S_tzav_q.fieldbyName('del').AsString='-' then
       begin
//
       Damg_lchb.Items.AddObject(S_tzav_q.FieldByName('Name_r').asString,
                                pointer(S_tzav_q.FieldByName('ID').asInteger));
       if mlen < length(S_tzav_q.FieldByName('Name_r').asString)
          then mlen:=length(S_tzav_q.FieldByName('Name_r').asString);

       if FindValueInDefMas(InitDamgMas, S_tzav_q.FieldByName('Name_r').asString)
          then Damg_lchb.Checked[Damg_lchb.Items.Count-1]:=true;
       end;
//nut anton

       S_tzav_q.Next;
      end; // while
    for i:=0 to Damg_lchb.Items.Count-1 do
     begin
      Damg_lchb.Items[i]:=PadLeft(Damg_lchb.Items[i], mlen,' ')+
               {copy(space_str,1,mlen-length(Damg_lchb.Items[i]))} separ_shortform;
      if Damg_lchb.Checked[i] then // инициализация short_form
        begin
          Damg_lchb.ItemIndex:=i;
          ShortForm_ed.Text:=Copy(Damg_lchb.Items[i],1,1);
        end;

     end;

    if not S_diam_q.Active then S_diam_q.Open;
    Diam_lchb.Clear;
    S_diam_q.disablecontrols;
    S_diam_q.First;
    while not S_diam_q.EOF do
      begin
//nut anton
       if s_diam_q.fieldbyName('del').AsString='-' then
       begin
//
       Diam_lchb.Items.AddObject(S_diam_q.FieldByName('Diam').asString,
                                pointer(S_diam_q.FieldByName('ID').asInteger));
       if FindValueInDefMas(InitDiamMas, S_diam_q.FieldByName('Diam').asString)
          then Diam_lchb.Checked[Diam_lchb.Items.Count-1]:=true;
       end;
//nut anton
       S_diam_q.Next;
      end; // while

   finally
     S_tzav_q.EnableControls;
     S_diam_q.EnableControls;
     InitDiamMas.Free;
     InitDamgMas.Free;
   end; // with
 CtrlState;
end;

//*******************************************************************
procedure TRep4F.ShortForm_edChange(Sender: TObject);
begin
 if Damg_lchb.Itemindex < 0 then exit;
 Damg_lchb.Items[Damg_lchb.Itemindex]:=getItems(Damg_lchb.Items[Damg_lchb.Itemindex])+
                                       separ_shortform + ShortForm_ed.text;
end;

//*******************************************************************
procedure TRep4F.BtOkClick(Sender: TObject);
var
 str1,cond_rayon, top_label, dt_begin, dt_end,Period_title :string;
 Excavat_cond :string;
 i,j,k,l,m,all_sum, _col_count, PeriodCount :integer;
 sTit :TstringList;
 CountList :TList;
 masp :MasPeriod;
 FRes:TFormResult;
 min_diam, max_diam :integer;
 _gdiam_count, cur_gdiam :integer;
 maxdiam_operand :string;
 Fill_Rows :integer;
begin
 strAttach:=' and (id_attach='+IntToStr(ord(OperateAttach))+')';
 sTit:=TstringList.Create;
 CountList:=TList.Create;
 _col_count:=0;

 top_label:=TrLangMSG(msgCrashes)+' ';
 if Excavation_chb.Checked then
   begin
    top_label:=top_label + TrLangMSG(msgWithDigging)+' ';
    //Excavat_cond:=Format(' and(wk.id_zav = z.id)and(wk.id_work in (%d,%d)) ',[RASKOPKA_ID1,RASKOPKA_ID2]);
    Excavat_cond:=' and (exists(select id from raskop where id_zavin=z.id)) '
   end // if Excavation_chb.Checked ...
    else begin
          Excavat_cond:='';
         end;
 top_label:=top_label + 'за';
 if Period_rg.ItemIndex = 0{квартал} then
   begin
    Period_title:=Format('За %s квартал',[Quarte_cb.Text]);
    top_label:=Format('%s %s-й квартал %s '+TrLangMSG(msgOnYear)+' ',[top_label, Quarte_cb.Text, Year_cb.Text]);
    PeriodCount:=3;
    masp:=GetDatePeriod(StrToInt(Year_cb.Text), StrToInt(Quarte_cb.Text));
   end // if Period_rg = 0 ...
    else begin {год}
          Period_title:=Format('За %s '+ansilowercase(TrLangMSG(msgYear)),[Year_cb.Text]);
          top_label:=Format('%s %s-й '+ansilowercase(TrLangMSG(msgYear))+' ',[top_label, Year_cb.Text]);
          PeriodCount:=4;
          masp:=GetDatePeriod(StrToInt(Year_cb.Text));
         end; // if Period_rg = 0 ... else

 if rayon_lcb.Text = rayon_DisplEmpt
    then begin
          top_label:=top_label+TrLangMSG(msgINCity)+' ';
          cond_rayon:='';
         end
    else begin
          top_label:=Format('%s по %s ',[top_label, rayon_lcb.Text]);
          cond_rayon:=Format(' and (z.id_revs = %s)',[rayon_lcb.Value]);
         end;

  for i:=0 to Damg_lchb.Items.Count-1 do
    if Damg_lchb.Checked[i] then inc(_col_count);

  _gdiam_count:=0;
  for i:=0 to Diam_lchb.Items.Count-1 do // кол-во по группировке
    if Diam_lchb.Checked[i] then inc(_gdiam_count);

  sTit.Add('Диаметр');
  for i:=1 to _col_count*(PeriodCount +1) do sTit.Add(' ');
  sTit.Add('Всего');
  if Period_rg.ItemIndex = 1{год} then sTit.Add(' % ');

  FRes:=TFormResult.ResCreate(Self,false,'dbn_avar','Результат',top_label,'',
           sTit,-1,nil,false, true{группировка}, false{не заполнять StringGrid});
//  FRes.Show;
 with DM1, FRes do
  begin
   StrGr_res.RowCount:=StrGr_res.RowCount + 1;
   StrGr_res.FixedCols:=1;
   StrGr_res.FixedRows:=2;

   StrGr_res.Cells[0,1]:='труб(мм)'; // 2-ая строка шапки (Всего труб)
   for i:=1 to PeriodCount +1 do
    begin
     k:=1;
     if i > PeriodCount
        then StrGr_res.Cells[PeriodCount*_col_count++1, 0]:=Period_title
        else StrGr_res.Cells[(i-1)*_col_count++1, 0]:=masp[i].title; // 1-ая строка шапки
     for j:=0 to Damg_lchb.Items.Count-1 do // 2-ая строка шапки
       if Damg_lchb.Checked[j] then
        begin
         StrGr_res.Cells[(i-1)*_col_count+k,1]:=getItems(Damg_lchb.Items[j], false, true, true);
         inc(k);
        end;
    end; // for i

   StrGr_res.Cells[(PeriodCount +1)*_col_count+1, 0]:='Всего';
   {uo min_diam:=-1; }max_diam:=-1;

   min_diam:=0; cur_gdiam:=1;
   Fill_Rows:=0;
   for i:=0 to Diam_lchb.Items.Count-1 do // по группам диаметров
    if Diam_lchb.Checked[i] then
      begin
       if min_diam < 0
          then min_diam:=StrToIntDef(Diam_lchb.Items[i], max_diam) // diam
          else max_diam:=StrToIntDef(Diam_lchb.Items[i], max_diam); // diam
       if (min_diam > 0)and(i = Diam_lchb.Items.Count-1)and(max_diam < 0)
          then max_diam:=MAX_DIAM_CONST;
       if (min_diam >= 0)and(max_diam > 0) then // определены границы
         begin
           str1:='';
           for m:=1 to PeriodCount +1{+ за период} do
             for j:=0 to Damg_lchb.Items.Count-1 do
               if Damg_lchb.Checked[j] then
                 begin
                  if m > PeriodCount
                    then begin
                          dt_begin:=masp[1].begin_d;
                          dt_end:=masp[PeriodCount].end_d;
                         end
                    else begin
                          dt_begin:=masp[m].begin_d;
                          dt_end:=masp[m].end_d;
                         end;
//Nut Anton
//                   if cur_gdiam = _gdiam_count{последнее значение из группы}
//                     then maxdiam_operand:='<='
//                     else maxdiam_operand:='<';
                   maxdiam_operand:='<=';
//Nut Anton
                  str1:=str1 +
                          Format('select count(distinct(z.id)) from zavjav z, s_tzav tzav, '+
                                                               's_diam d  '+
                        'where (delz=0) and (z.id_diam = d.id)and(d.diam > %d)and(d.diam %s %d)and '+
                              '(tzav.id = z.id_tzav)'+StrAttach+'and '+
                              '(z.id_tzav = %d)and(z.dt_out between "%s" and "%s") '+
                              '%s %s %s ',
                      [min_diam, maxdiam_operand, max_diam, integer(Damg_lchb.Items.Objects[j]),
                       dt_begin, dt_end, cond_rayon, Excavat_cond, Union_cond]);
                 end; // (for j)
           Delete(str1, length(str1)-length(Union_cond), length(Union_cond));

           if tempQr_q.Active then tempQr_q.Close;
           tempQr_q.SQL.Clear;
           tempQr_q.SQL.Text:=str1;
           try
             tempQr_q.Open;
            except
             MessageBoxEx(application.handle,
                 pchar('  '+TrLangMSG(msgErrorExecQuery)),
                 pchar(TrLangMSG(msgError)), MB_OK+MB_ICONERROR+MB_SETFOREGROUND,$0419);
             exit;
            end;

           // заполнение отчета данными
           StrGr_res.Cells[0, StrGr_res.RowCount-1]:=IntToStr(max_diam);
           if StrGr_res.RowCount = 3{первое значение диаметра} then
              StrGr_res.Cells[0, StrGr_res.RowCount-1]:='до '+
                                      StrGr_res.Cells[0, StrGr_res.RowCount-1];

           tempQr_q.First; all_sum:=0;
           for l:=0 to PeriodCount{+ за период} do
            for k:=1 to _col_count do
              begin
               StrGr_res.Cells[(l*_col_count+k),StrGr_res.RowCount-1]:=tempQr_q.Fields[0].asString;
               if l = PeriodCount{сумма по итоговым данным} then
                  all_sum:=all_sum + tempQr_q.Fields[0].asInteger;
               tempQr_q.Next;
              end; // _col_count
           StrGr_res.Cells[((PeriodCount+1)*_col_count+1),StrGr_res.RowCount-1]:=IntToStr(all_sum); // всего

           if (EmptyRows_chb.Checked)and(all_sum = 0)
             then StrGr_res.Rows[StrGr_res.RowCount-1].Clear
             else begin
                   StrGr_res.RowCount:=StrGr_res.RowCount+1;
                   inc(Fill_Rows);
                  end;
           //StrGr_res.RowCount:=StrGr_res.RowCount +1;
           min_diam:=max_diam; max_diam:=-1;
         end; // if (min_diam >= 0)and(max_diam > 0) ...
        inc(cur_gdiam);
      end; // for i // по группам диаметров

   if (EmptyRows_chb.Checked)and(Fill_Rows = 0) then
     begin
       MessageBoxEx(application.handle,
       pchar('  '+TrLangMSG(msgDataForRangeNotExist)),
       pchar(TrLangMSG(msgInform)), MB_OK+MB_ICONINFORMATION+MB_SETFOREGROUND,$0419);
       Fres.Free;
       exit;
     end; // if (Empty_Row)and( ...

  // итоговая часть отчета
  CountList.Clear;
  for i:=1 to StrGr_res.ColCount-1 do CountList.Add(pointer(0)); // инициализируем

  for i:=2 to StrGr_res.RowCount-1 do // подсчет суммы по колонкам
    for j:=1 to StrGr_res.ColCount-1 do
      CountList.Items[j-1]:=pointer(integer(CountList.Items[j-1]) +
                                StrToIntDef(StrGr_res.Cells[j,i], 0));

  StrGr_res.RowCount:=StrGr_res.RowCount +1; // пустая строка

  StrGr_res.RowCount:=StrGr_res.RowCount +1;
  StrGr_res.Cells[0, StrGr_res.RowCount-2]:=TrLangMSG(msgITOGO);
  StrGr_res.Cells[0, StrGr_res.RowCount-1]:=AnsiUpperCase(TrLangMSG(msgAllCount));
  for i:=0 to PeriodCount do // заполнение
    begin
      all_sum:=0;
      for j:=1 to _col_count do
       begin
        StrGr_res.Cells[(i*_col_count+j),StrGr_res.RowCount-2]:=
                       IntToStr(integer(CountList.Items[(i*_col_count+j)-1]));
        all_sum:=all_sum + integer(CountList.Items[(i*_col_count+j)-1]);
       end; // for j
       //if i <= PeriodCount-1{пропускаем итоговые данные} then
       StrGr_res.Cells[(i*_col_count+Round((_col_count-1)/2)+1), StrGr_res.RowCount-1]:=IntToStr(all_sum);
     end; // for i
   all_sum:=integer(CountList.Items[_col_count*(PeriodCount +1)]); // итоговая сумма за период
   StrGr_res.Cells[_col_count*(PeriodCount +1)+1, StrGr_res.RowCount-2]:=IntToStr(all_sum);

   if Period_rg.ItemIndex = 1{год} then
    begin
     for i:=2 to StrGr_res.RowCount -4 do
      begin
       if all_sum = 0 // % по вертикали
        then StrGr_res.Cells[StrGr_res.ColCount-1, i]:='0'
        else StrGr_res.Cells[StrGr_res.ColCount-1, i]:=
                FloatToStrF((StrToIntDef(StrGr_res.Cells[StrGr_res.ColCount-2, i],0)/all_sum)*100,ffGeneral,3,2);
      end; // for i

     StrGr_res.RowCount:=StrGr_res.RowCount +1; // % по горизонтали
     for i:=0 to PeriodCount do
      begin
       all_sum:=0;
       for j:=1 to _col_count do
         all_sum:=all_sum + integer(CountList.Items[(i*_col_count+j)-1]);
       for j:=1 to _col_count do
        if all_sum = 0
          then StrGr_res.Cells[(i*_col_count+j),StrGr_res.RowCount-1]:='0'
          else begin
                k:=Round((integer(CountList.Items[(i*_col_count+j)-1])/all_sum)*100);
                StrGr_res.Cells[(i*_col_count+j),StrGr_res.RowCount-1]:=IntToStr(k);
               end;
      end; // for i
     StrGr_res.Cells[0, StrGr_res.RowCount-1]:='%';
     StrGr_res.Cells[StrGr_res.ColCount-1, StrGr_res.RowCount-1]:='100%';
    end; // if Period_rg.ItemIndex = 1

   isIdView:=true;
   ChLB_Pol.ApplyState(cbChecked,false);
   Upd_Cols;
   PrBar.Position:=PrBar.Max;
   ShowProgress:=false; // ds
   StrGr_res.AdjustColWidths;
   Fres.NumCols:=Fill_Rows;
   Fres.Caption:='Результат - '+TrLangMSG(msgCount)+': '+IntToStr(Fill_Rows);
   FRes.ShowModal;
//   StrGr_res.SetFocus;
 end; // with

 CountList.Free;
 sTit.Free;
end;

//*******************************************************************
function TRep4F.getItems(in_str :string; ShortOnly :boolean=false;
                        trim_fl:boolean=false; short_nm :boolean=false) :string;
begin
 result:='';
 if (ShortOnly)or(short_nm)
    then result:=copy(in_str, mlen+length(separ_shortform)+1, length(in_str));
 if ShortOnly then exit;
 if Trim(result) = ''
    then result:=copy(in_str, 1, mlen)//+length(separ_shortform)-1);
    else exit;
 if trim_fl then result:=Strip('R',' ',result);
 //Trim(result);
end;

//*******************************************************************
function TRep4F.FindValueInDefMas(mas :TStringList; v :string) :boolean;
begin
 result:=(mas.IndexOf(v) > -1);
{ for i:=low(InitDiamMas) to High(InitDiamMas) do
   if InitDiamMas[i] = d then
     begin
      result:=true;
      exit;
     end;}
end;

//*******************************************************************
procedure TRep4F.Quarte_cbChange(Sender: TObject);
begin
 if not (StrToIntDef(Quarte_cb.Text, -1) in [1,2,3,4])
    then Quarte_cb.text:='1';
end;

//*******************************************************************
procedure TRep4F.Damg_lchbClick(Sender: TObject);
//var
// str1 :string;
begin
 ShortForm_ed.text:=getItems(Damg_lchb.Items[Damg_lchb.ItemIndex], true{shortonly});
end;

//*******************************************************************
procedure TRep4F.Year_cbChange(Sender: TObject);
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
procedure TRep4F.CtrlState;
begin
 Quarte_cb.Enabled:=(Period_rg.ItemIndex = 0{квартал});
 BtOk.Enabled:=(StrToIntDef(Year_cb.Text,-1) > -1)and
               (CheckCheckedCHLB(Diam_lchb))and
               (CheckCheckedCHLB(Damg_lchb));
end;

//*******************************************************************
procedure TRep4F.Period_rgClick(Sender: TObject);
begin
 CtrlState;
end;

//*******************************************************************
procedure TRep4F.Damg_lchbClickCheck(Sender: TObject);
begin
 CtrlState;
end;

//*******************************************************************
procedure TRep4F.Diam_lchbClickCheck(Sender: TObject);
begin
 CtrlState;
end;

//*******************************************************************
procedure TRep4F.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action:=caFree;
end;

procedure TRep4F.FormDestroy(Sender: TObject);
begin
 Rep4F:=nil;
end;

procedure TRep4F.Translate;
begin
  inherited;
  Label3.Caption:=TrLangMSG(msgYear);
  Label1.Caption:=TrLangMSG(msgShortening);
  Label4.Caption:=TrLangMSG(msgREV);
  BtOk.Caption:=TrLangMSG(msgApply);
  BExit.Caption:=TrLangMSG(msgExit);
  Period_rg.Caption:=' '+TrLangMSG(msgRange)+' ';
  Period_rg.Items[1]:=TrLangMSG(msgYear);
  StaticText1.Caption:=' '+TrLangMSG(msgGroupBy)+' ';
  StaticText2.Caption:=' '+TrLangMSG(msgCrash)+' ';
  Excavation_chb.Caption:=TrLangMSG(msgDigWorkOne);
  EmptyRows_chb.Caption:=TrLangMSG(msgNotShowNullRow);
end;

end.
