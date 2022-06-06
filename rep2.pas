unit rep2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  RxLookup, StdCtrls, ExtCtrls, Buttons, frm_dat, CheckLst, Db, DBTables,
  frmLANG, cntsLANG,OperAttFormUnit;

const
  FORM_WIDTH1=417;
  FORM_WIDTH2=570;
type
  TRepMatF = class(TOperAttForm)
    Panel1: TPanel;
    Bevel1: TBevel;
    BtOk: TBitBtn;
    BExit: TBitBtn;
    Vidrep_rg: TRadioGroup;
    Frm_Dt: TFrm_Date;
    Mat_lch: TCheckListBox;
    Qr1: TQuery;
    BCheck: TBitBtn;
    BUnCheck: TBitBtn;
    EmptyRows_chb: TCheckBox;
    NaimMaterPanel: TPanel;
    RayonCheckListBox: TCheckListBox;
    Label1: TLabel;
    Label2: TLabel;
    BrigCheckListBox: TCheckListBox;
    Bevel2: TBevel;
    BrigRayQuery: TQuery;
    procedure FormCreate(Sender: TObject);
    procedure BtOkClick(Sender: TObject);
    procedure BCheckClick(Sender: TObject);
    procedure BUnCheckClick(Sender: TObject);
    procedure FrmData_Change(Sender: TObject);
    procedure Mat_lchClickCheck(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure Vidrep_rgClick(Sender: TObject);
    procedure BrigCheckListBoxClickCheck(Sender: TObject);
    procedure RayonCheckListBoxClickCheck(Sender: TObject);
  private
    StrAttach:String;
    procedure CtrlState;
    procedure FillLch(_DataSet:TDataSet; _Lch:TCheckListBox;
      _name_field,_id_field:string);
    function IsBrigInRayon(_id_brig,_id_rayon:integer;_Attach:integer;_m_name:string):integer;
  public
    procedure Translate;override;
  end;

var
 Rep2F: TRepMatF;

implementation

uses datam, fresult, main, avartype, HelpFunctions;

{$R *.DFM}

function TRepMatF.IsBrigInRayon(_id_brig,_id_rayon:integer;_Attach:integer;_m_name:string):integer;
begin
  result:=0;
  with BrigRayQuery do
    begin
      Close;
      ParamByName('id_brig').Value:=_id_brig;
      ParamByName('id_rayon').Value:=_id_rayon;
      ParamByName('m_name').Value:=_m_name;
      ParamByName('attach').Value:=_Attach;
      Open;
      result:=FieldByName('c').AsInteger;
      Close;
    end;
end;

procedure TRepMatF.FillLch(_DataSet:TDataSet; _Lch:TCheckListBox;
  _name_field,_id_field:string);
begin
   try
    if not _DataSet.Active then _DataSet.Open;
    _lch.Clear;
    _DataSet.disablecontrols;
    _DataSet.First;
    while not _DataSet.EOF do
      begin
       _lch.Items.AddObject(_DataSet.FieldByName(_name_field).asString,
          pointer(_DataSet.FieldByName(_id_field).asInteger));
       _DataSet.Next;
      end; // while
   finally
     _DataSet.EnableControls;
   end; // with
end;
   
//*******************************************************************
procedure TRepMatF.FormCreate(Sender: TObject);
begin
 {Mat_lch.Anchors:=[akLeft,akTop,akRight,akBottom];
 Vidrep_rg.Anchors:=[akTop,akRight];
 BCheck.Anchors:=[akRight,akBottom];
 BUnCheck.Anchors:=[akRight,akBottom];
 Bevel1.Anchors:=[akRight,akBottom];
 BtOk.Anchors:=[akRight,akBottom];
 BExit.Anchors:=[akRight,akBottom];
 EmptyRows_chb.Anchors:=[akLeft,akBottom];}
 BorderStyle:=bsSizeable;
 //
 Width:=FORM_WIDTH1;
 Constraints.MaxWidth:=Width;
 Constraints.MinWidth:=Width;
 //
 FillLch(DM1.S_mat_q,Mat_Lch,'NAME_R','ID');
 FillLch(DM1.S_brig_q,BrigCheckListBox,'NAME_R','ID');
 FillLch(DM1.S_revs_q,RayonCheckListBox,'NAME_R','ID');
{ with DM1 do
   try
    if not S_mat_q.Active then S_mat_q.Open;
    Mat_lch.Clear;
    S_mat_q.disablecontrols;
    S_mat_q.First;
    while not S_mat_q.EOF do
      begin
       Mat_lch.Items.AddObject(S_mat_qNAME_R.asString, pointer(S_mat_qID.asInteger));
       S_mat_q.Next;
      end; // while
   finally
     S_mat_q.EnableControls;
   end; // with}
  //
 CtrlState;
end;

//*******************************************************************
procedure TRepMatF.BtOkClick(Sender: TObject);
//
procedure AddToTopLabelFromClb(_clb:TCheckListBox; var _str:string);
var i:integer;
begin
   for i:=0 to _clb.Items.Count-1 do
   if _clb.Checked[i] then _str:=_str +_clb.Items[i]+ ' ,';
   Delete(_str, length(_str), 1);
end;
//
var
 FRes:TFormResult;
 dic_tbl, dic_field, link_cond :string;
 sTit:TstringList;
 i,j,per,_col_count, _row_count, _idmat, _idray, _idbrig,_k,_ray_count, _field_for_itogo:integer;
 CountList :TList;
 str1, top_label :string;
 Empty_Row :boolean;
 Fill_Rows :integer;
 _naim_predpr:boolean;
 _mats_str,s,_zn:string;
begin
 strAttach:=' and (id_attach='+IntToStr(ord(OperateAttach))+')';
 {Проверим дату}
 with Frm_Dt do
 if not ProvDate(DE_in.Date,DE_Out.Date,Time2Str(TE_in.Time),Time2Str(TE_out.Time))
    then exit;
 //
 sTit:=TstringList.Create; {похоже титулы :), т.е. название колонок}
 CountList:=TList.Create;
 _col_count:=0;
 top_label:=TrLangMSG(msgVedomost)+' ';
 //
 AddToTopLabelFromClb(Mat_lch,top_label);
 //
 _naim_predpr:=FALSE;
 case Vidrep_rg.ItemIndex of
  0{диаметр}:
        begin
          dic_tbl:='s_diam'; dic_field:='diam'; link_cond:='(matr.id_diam = s.id)';
          sTit.Add(TrLangMSG(msgDiam));
          top_label:=top_label +TrLangMSG(msgForDiam)+' ';
        end;
  1{Район}:
        begin
          dic_tbl:='s_revs'; dic_field:='name_r'; link_cond:='(z.id_revs = s.id)';
          sTit.Add('Цех');
          top_label:=top_label +'по '+TrLangMSG(msgREV)+' ';
         end;
  2{}:  begin
          _naim_predpr:=TRUE;
          top_label:=top_label+#13+'районы: ';
          AddToTopLabelFromClb(RayonCheckListBox,top_label);
          top_label:=top_label+#13+'бригадиры: ';
          AddToTopLabelFromClb(BrigCheckListBox,top_label);
          top_label:=top_label+#13;
          dic_tbl:=''; dic_field:=''; link_cond:='';
          sTit.Add('1');
          top_label:=top_label +'по '+TrLangMSG(msgNaimPredpr)+' ';
        end;
 end;
 top_label:=top_label+'за '+ansilowercase(TrLangMSG(msgRange))+' '+Frm_Dt.TitStr;

 frm_Dt.min_dt:='dt_out';
 frm_Dt.max_dt:='dt_out';
 str1:='';
 //
 {сформируем запрос и накидаем в стринггриде названия колонок}
  if not(_naim_predpr) then
    begin
    for i:=0 to Mat_lch.Items.Count-1 do
     if Mat_lch.Checked[i] then
       begin
        _idmat:=Integer(Mat_lch.Items.Objects[i]);
        sTit.Add(Mat_lch.Items[i]);
        sTit.Add(' % ');
            str1:=str1 + Format(' (select sum(matr.kol_mat) from zavjav z, maters matr '+
           '     where (delz=0) and %s '+StrAttach+' and '+
           '           (matr.id_zav = z.id)and(matr.id_mat = %d) %s) as c%d, ',
           [link_cond, _idmat, frm_Dt.SQLStr, _col_count+1]);
        inc(_col_count);
       end;
    // if length(list_mat) = 0 then exit;
    Delete(str1, length(str1)-1, 1);
    //
    if Qr1.Active then Qr1.Close;
    Qr1.SQL.Clear;
    with Qr1 do
    begin
     SQL.Text:=Format('select s.%s, %s'+
           'from %s s '+
           'where (s.id > 0) '+
           'order by s.%s ',
           [dic_field, str1,{link_cond, list_mat ,frm_Dt.SQLStr,} dic_tbl, dic_field]);
    end; // with
  end
    else
  begin
    _mats_str:='';
    {сформируем строку-условие по материалам}
    for i:=0 to Mat_Lch.Items.Count-1 do
      begin
        _idmat:=Integer(Mat_Lch.Items.Objects[i]);
        if Mat_Lch.Checked[i] then
          begin
            if _mats_str='' then _mats_str:=' ((sm.id='+IntToStr(_idmat)+') '
              else _mats_str:=_mats_str+' or (sm.id='+IntToStr(_idmat)+') ';
          end;
      end;
    if _mats_str<>'' then _mats_str:=_mats_str+') ';
    sTit.Add('Ед.изм');
    inc(_col_count);
    _ray_count:=0;
    {накидаем названия районов в шапку}
     for i:=0 to RayonCheckListBox.Items.Count-1 do
     if RayonCheckListBox.Checked[i] then
       begin
        _idray:=Integer(RayonCheckListBox.Items.Objects[i]);
        sTit.AddObject(RayonCheckListBox.Items[i],pointer(_idray));
        //sTit.Add(' % ');
            str1:=str1 + ' (select sum(matr.kol_mat) from zavjav z, maters matr, narad n '+
           '     where (delz=0) and (matr.id > 0) and (sm.id=matr.id_mat) and (n.id=matr.id_nar) and (z.id=matr.id_zav) and (z.id_revs='+IntToStr(_idray)+') '+StrAttach+
           ') as c'+IntToStr(i)+', ';
        inc(_col_count);
        inc(_ray_count);
       end;
    if BrigCheckListBox.Items.Count=0 then Delete(str1, length(str1)-1, 1);
    {накидаем названия бригад в шапку}
     for i:=0 to BrigCheckListBox.Items.Count-1 do
     if BrigCheckListBox.Checked[i] then
       begin
        _idbrig:=Integer(BrigCheckListBox.Items.Objects[i]);
        sTit.AddObject(BrigCheckListBox.Items[i],pointer(_idbrig));
        //sTit.Add(' % ');
            str1:=str1 + ' (select sum(matr.kol_mat) from zavjav z, s_brig brig, narad n, maters matr '+
           '     where (delz=0) and (matr.id > 0) and (sm.id=matr.id_mat) and (z.id=matr.id_zav) and (brig.id=n.id_brig) and (n.id_zav=matr.id_zav) '+
           ' and (brig.id='+IntToStr(_idbrig)+') '+StrAttach+
           ') as c'+IntToStr(i)+', ';
        inc(_col_count);
       end;
     {теперь при формировании "итого", надо учесть посчитанное для районов и вы честь из них
     посчитанное для бригад, если в районе была бригада.}
    // if length(list_mat) = 0 then exit;
    if BrigCheckListBox.Items.Count>0 then Delete(str1, length(str1)-1, 1);
    //
    if Qr1.Active then Qr1.Close;
    Qr1.SQL.Clear;
    with Qr1 do
    begin
     SQL.Text:='select sm.name_r, sm.ed_izm, '+str1+
           ' from s_mat sm '+
           ' where '+_mats_str+
           ' order by sm.name_r ';
    end; // with
  end;
  //     
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
 //FRes.Show;
{Вообщем выполнили уже запрос и накидали в стринггриде название колонок.
Теперь надо строки заполнить}

 with FRes do
  begin
     PrBar.Position:=0;
     PrBar.Max:=Qr1.RecordCount +10;
     Fill_Rows:=0;
     if FRes.Visible then ShowProgress:=true; // ds
     if not(_naim_predpr) then  for i:=1 to _col_count do CountList.Add(pointer(0)); // инициализируем
     StrGr_res.FixedCols:=1;
     //
     _row_count:=0;
     {Наляпаем значений}
     while not Qr1.EOF do
      begin
        Empty_Row:=true;
        _zn:=trim(Qr1.Fields[0].asString);
        StrGr_res.Cells[0,StrGr_res.RowCount-1]:=_zn; // справочник(знвчения)
        //
        if (_naim_predpr) then CountList.Add(pointer(0)); // инициализируем
        for i:=1 to _col_count do
         begin
          s := HelpFunctions.FieldAsString( Qr1.Fields[i] );
          if s='' then s:='0';
            if not(_naim_predpr) then
              begin
                StrGr_res.Cells[i*2-1,StrGr_res.RowCount-1]:=s; // данные отчета
                CountList.Items[i-1]:=pointer(integer(CountList.Items[i-1]) + Qr1.Fields[i].asInteger);
                if Empty_Row then Empty_Row:=(Qr1.Fields[i].asInteger = 0);
              end
                else
              begin
                StrGr_res.Cells[i,StrGr_res.RowCount-1]:=s;
                if i>1 then
                  begin
                    _field_for_itogo:=Qr1.Fields[i].asInteger;
                    CountList.Items[_row_count]:=pointer(integer(CountList.Items[_row_count]) + _field_for_itogo);
                    //
                    if Empty_Row then Empty_Row:=(Qr1.Fields[i].asInteger = 0);
                    {если поле это бригада, значит надо проверить, добавлять к итого или вычитать}
                    if (i>_ray_count) and (_field_for_itogo>0) then
                      begin
                        for _k:=2 to 2+_ray_count-1 do
                          begin
                            //BrigCheckListBox.Items.Objects[i]
                            _field_for_itogo:=IsBrigInRayon(integer(sTit.Objects[i]),integer(sTit.Objects[_k]),(ord(OperateAttach)+1),_zn);
                             CountList.Items[_row_count]:=pointer(integer(CountList.Items[_row_count])-_field_for_itogo);
                          end;
                      end;
                  end;
              end;
         end; // for i
        //
        Qr1.Next;
        //
        if (_naim_predpr) then
          begin
            {наколбасить столбец с итого}
            if _row_count=0 then
              begin
                StrGr_res.ColCount:=StrGr_res.ColCount+2;
                StrGr_res.Cells[StrGr_res.ColCount-1,0]:=AnsiUpperCase(TrLangMSG(msgAllCount));
              end;
            StrGr_res.Cells[StrGr_res.ColCount-1,_row_count+1]:=IntToStr(integer(CountList.Items[_row_count]));
          end;
        //
        if (EmptyRows_chb.Checked)and(Empty_Row)
           then StrGr_res.Rows[StrGr_res.RowCount-1].Clear
           else begin
                 StrGr_res.RowCount:=StrGr_res.RowCount+1;
                 inc(Fill_Rows);
                 inc(_row_count);
                end; // if (EmptyRows_chb.Checked) ...
 //       StrGr_res.RowCount:=StrGr_res.RowCount+1;
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
       end; // if (EmptyRows_chb.Checked)and(Fill_Rows = 0) ...
     //
     //
     if not(_naim_predpr) then
      begin
        // накидаем процентов
        for i:=1 to StrGr_res.RowCount-2{чтобы не зап. пустую строку} do
        begin
          //per:=0;
          for j:=1 to _col_count do
          if integer(CountList.Items[j-1]) = 0
              then StrGr_res.Cells[j*2{%},i]:='0'
              else begin
                    per:=StrToIntDef(StrGr_res.Cells[j*2-1,i], 0);
                    StrGr_res.Cells[j*2{%},i]:=FloatToStrF((per/integer(CountList.Items[j-1]))*100,ffGeneral,3,2);
                   end; // j
        end; // for i
        //
        StrGr_res.RowCount:=StrGr_res.RowCount+2;
        StrGr_res.Cells[0,StrGr_res.RowCount-1]:=AnsiUpperCase(TrLangMSG(msgAllCount));
        for i:=1 to _col_count do
          begin
          StrGr_res.Cells[i*2-1,StrGr_res.RowCount-1]:=IntToStr(integer(CountList.Items[i-1]));
          StrGr_res.Cells[i*2,StrGr_res.RowCount-1]:='100%';
          end;
         //
      end
        else
      begin
        StrGr_res.RowCount:=StrGr_res.RowCount-1;
      end;
    {}
    //
     if FRes.Visible then PrBar.Position:=PrBar.Max - 5;
     //
     isIdView:=true;
     ChLB_Pol.ApplyState(cbChecked,false);
     Upd_Cols;
     if FRes.Visible then PrBar.Position:=PrBar.Max;
     ShowProgress:=false; // ds
     StrGr_res.AdjustColWidths;
     Fres.NumCols:=Fill_Rows;
     Fres.Caption:='Результат - '+TrLangMSG(msgCount)+': '+IntToStr(Fill_Rows);
     FRes.Showmodal;

//     StrGr_res.SetFocus;
// Fres.StrGr_res.ColWidths[Fres.StrGr_res.ColCount-1]:=2;
 end; // with
 CountList.Free;
 sTit.Free;
end;

//*******************************************************************
procedure TRepMatF.BCheckClick(Sender: TObject);
var
 i :integer;
begin
 for i:=0 to Mat_lch.Items.Count-1 do
   Mat_lch.Checked[i]:=true;
 CtrlState;
end;

//*******************************************************************
procedure TRepMatF.BUnCheckClick(Sender: TObject);
var
 i :integer;
begin
 for i:=0 to Mat_lch.Items.Count-1 do
   Mat_lch.Checked[i]:=false;
 BtOk.Enabled:=false;
end;

//*******************************************************************
procedure TRepMatF.CtrlState;
begin
 BtOk.Enabled:=((Frm_Dt.CheckFields) and
               (CheckCheckedCHLB(Mat_lch)) and (Vidrep_rg.ItemIndex<>2))  or
               ((Vidrep_rg.ItemIndex=2) and (Frm_Dt.CheckFields) and (CheckCheckedCHLB(Mat_lch))
                and ((CheckCheckedCHLB(RayonCheckListBox)) or (CheckCheckedCHLB(BrigCheckListBox))) );
end;

//*******************************************************************
procedure TRepMatF.FrmData_Change(Sender: TObject);
begin
 CtrlState;
end;

//*******************************************************************
procedure TRepMatF.Mat_lchClickCheck(Sender: TObject);
begin
 CtrlState;
end;

//*******************************************************************
procedure TRepMatF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action:=caFree;
end;

procedure TRepMatF.FormDestroy(Sender: TObject);
begin
 Rep2F:=nil;
end;

procedure TRepMatF.Translate;
begin
  inherited;
  BtOk.Caption:=TrLangMSG(msgApply);
  BExit.Caption:=TrLangMSG(msgExit);
  Vidrep_rg.Items[0]:=TrLangMSG(msgDiam);
 { Vidrep_rg.Items[1]:=TrLangMSG(msgRAYON);}
  Vidrep_rg.Items[1]:=TrLangMSG(msgREV);
  EmptyRows_chb.Caption:=TrLangMSG(msgNotShowNullRow);
  BCheck.Caption:=TrLangMSG(msgChooseAll);
  BUnCheck.Caption:=TrLangMSG(msgClearAll);
end;

procedure TRepMatF.Vidrep_rgClick(Sender: TObject);
begin
  inherited;
  case Vidrep_rg.ItemIndex of
    0:begin
        Constraints.MaxWidth:=FORM_WIDTH1;
        Constraints.MinWidth:=Constraints.MaxWidth;
        NaimMaterPanel.Hide;
      end;
    1:begin
        Constraints.MaxWidth:=FORM_WIDTH1;
        Constraints.MinWidth:=Constraints.MaxWidth;
        NaimMaterPanel.Hide;
      end;
    2:begin
        Constraints.MaxWidth:=FORM_WIDTH2;
        Constraints.MinWidth:=Constraints.MaxWidth;
        NaimMaterPanel.Show;
      end;
  end;
end;

procedure TRepMatF.BrigCheckListBoxClickCheck(Sender: TObject);
begin
  inherited;
 CtrlState;
end;

procedure TRepMatF.RayonCheckListBoxClickCheck(Sender: TObject);
begin
  inherited;
 CtrlState;
end;

end.
