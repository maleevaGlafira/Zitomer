unit comp_zv;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, frm_dat, Db, DBTables, StdCtrls, Buttons, ComCtrls,
  RxLookup, ExtCtrls, frmLANG, cntsLANG,OperAttFormUnit;

type
  TCompZReferF = class(TFormLang)
    Frm_Dt: TFrm_Date;
    BtOk: TBitBtn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DataSource1: TDataSource;
    Query1: TQuery;
    DataSource2: TDataSource;
    Query2: TQuery;
    BExit: TBitBtn;
    StatusBar1: TStatusBar;
    UpdateSQL1: TUpdateSQL;
    Qry_ul2: TQuery;
    Qry_ul1: TQuery;
    UpdateSQL2: TUpdateSQL;
    S_Tzav_q: TQuery;
    S_Tzav_sur: TDataSource;
    Panel1: TPanel;
    S_Tzav_lcb: TRxDBLookupCombo;
    Label1: TLabel;
    StaticText1: TStaticText;
    BB_zav: TBitBtn;
    BPrint: TBitBtn;
    procedure BtOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure DateChange(Sender: TObject);
    procedure S_Tzav_lcbCloseUp(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure BPrintClick(Sender: TObject);

  private
    baze_caption :string;
    baze_q_CloseZ :string;
    baze_q_NotCloseZ :string;
    function id2Adr(id_cod,id_ul1:integer;id_ul2:string):string; // temp

  protected
   procedure CtrlState;
  public
    procedure Translate;override;
  end;

var
  CompZReferF: TCompZReferF;

implementation
 uses main, strtool, zav, fresult, avartype, FormZavFactory;

{$R *.DFM}
//*******************************************************************
procedure TCompZReferF.CtrlState;
begin
{ with Frm_Dt do
 Btok.enabled:=(min_dt <> '')and(max_dt <> '');}
end;

// temp
//*******************************************************************
function TCompZReferF.id2Adr(id_cod,id_ul1:integer;id_ul2:string):string;
  var tt_str,ul2:string;
begin
   tt_str:='';
   if id_ul2='' then
     id_ul2:='-1';
   if Qry_Ul1.Locate('ID',id_ul1,[]) then
    begin
      tt_str:=Qry_Ul1.FieldByName('NAME_R').asString;
      if tt_str<>'' then
        tt_str:=Strip('B',' ',tt_str);
    end
   else
     tt_str:='';

   ul2:='';
   if id_ul2<>'' then
     ul2:=Strip('B',' ',id_ul2);

   if id_cod=0 then
    begin
      tt_str:=tt_str+','+ul2;
    end
   else if id_cod=1 then
    begin
      if not Qry_Ul2.Locate('ID',ul2,[]) then
         Qry_Ul2.First;
   //   if Qry_Ul2['NAME_R']<>'' then
        tt_str:=tt_str+' > '+ //trim(Qry_Ul2['NAME_R']);
        Strip('B',' ',Qry_Ul2.FieldByName('NAME_R').asString);
    end
   else if id_cod=2 then
    begin
      tt_str:='Мест.-'+tt_str;
    end;
  Result:=tt_str;
  //+' '+Qry_tmp.FieldByName('DOP_ADR').asString;
end;

//*******************************************************************
procedure TCompZReferF.BtOkClick(Sender: TObject);
   //----------------------------------
   function _aa(ds1 :TQuery; close_zayav :boolean) :boolean;
   begin
    result:=false;
    if ds1.Active then ds1.Close;
    ds1.SQL.Clear;
   // ds1.SQL.Add('select z.nomer, sd.name_r, sr.name_r as revs, z.dt_in, z.dt_out');}
    if close_zayav then begin
                         ds1.UpdateObject:=UpdateSQL1;
                         frm_Dt.t_db:='zavjav';
                         frm_Dt.Min_dt:='dt_out';
                         frm_Dt.Max_dt:='dt_out';
                         ds1.SQL.Text:=baze_q_CloseZ;
                        end
                   else begin
                         ds1.UpdateObject:=UpdateSQL2;
                         frm_Dt.t_db:='nzavjav';
                         frm_Dt.Min_dt:='dt_in';
                         frm_Dt.Max_dt:='dt_in';
                         ds1.SQL.Text:=baze_q_NotCloseZ;
                        end;
    {ds1.SQL.Add('from '+frm_Dt.t_db+' z,s_sod sd,s_diam dm,s_revs sr');
    ds1.SQL.Add('where sd.id=z.id_sod and sr.id=-z.id_to and dm.id=z.id_diam');}
    ds1.SQL.Add(frm_Dt.SQLStr);
    ds1.SQL.Add('Order by sr.name_r, z.nomer');
    try
     //UpdateSQL1.DataSet:=ds1;
     ds1.Open;
     ds1.DisableControls;
     while not ds1.eof do
       begin
        ds1.Edit;
        ds1.FieldByName('Adr').asString:=id2Adr(ds1.FieldByName('KOD_UL').asInteger,
                       ds1.FieldByName('ID_UL1').asInteger,
                       ds1.FieldByName('ID_UL2').asString)+' '+
                       ds1.FieldByName('DOP_ADR').asString;
        ds1.post;
        ds1.next;
       end; // while
      ds1.UpdateObject:=nil;
      ds1.First;
      ds1.EnableControls;
    except
     result:=false;
     exit;
    end;
   end;
   //----------------------------------
begin
{and z.dt_in>="01.10.2000 00:00" and z.dt_in<="01.11.2000 23:59"
ORDER BY sr.name_r, z.nomer}

 with Frm_Dt do
 if not ProvDate(DE_in.Date,DE_Out.Date,
    Time2Str(TE_in.Time),Time2Str(TE_out.Time)) then exit;
 Qry_ul1.Open;
 Qry_ul2.Open;
 _aa(Query1, true);
 _aa(Query2, false);
 S_Tzav_lcbCloseUp(nil);
 Qry_ul1.Close;
 Qry_ul2.Close;

{ StatusBar1.panels[0].text:='Закрытые: '+InttoStr(Query1.RecordCount);
 StatusBar1.panels[1].text:='Незакрытые: '+InttoStr(Query2.RecordCount);}
end;

//*******************************************************************
procedure TCompZReferF.FormCreate(Sender: TObject);
begin
 PageControl1.Anchors:=[akLeft,akTop,akRight,akBottom];
 Panel1.Anchors:=[akLeft,akTop,akRight];
 BtOk.Anchors:=[akTop,akRight];
 BB_zav.Anchors:=[akTop,akRight];
 BExit.Anchors:=[akTop,akRight];
 BorderStyle:=bsSizeable;

 baze_caption:=Caption;
 baze_q_CloseZ:=Query1.SQL.Text;
 baze_q_NotCloseZ:=Query2.SQL.Text;
 Constraints.MinWidth:=BB_zav.Left + BB_zav.Width + 3;
 with frm_dt do
  begin
   DE_Out.Date:=Date;
   DE_In.Date:=Date-1;
   Te_In.Time:=strtotime('07:00');
   Te_Out.Time:=Te_In.Time;
  end; // with
 S_Tzav_q.Open; // ds
 S_Tzav_lcb.DisplayValue:=S_Tzav_q.FieldbyName('name_r').asString;
 CtrlState; // ds
end;

//*******************************************************************
procedure TCompZReferF.BExitClick(Sender: TObject);
begin
 Close;
end;

//*******************************************************************
procedure TCompZReferF.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 Action:=caFree;
end;

//*******************************************************************
procedure TCompZReferF.FormDestroy(Sender: TObject);
begin
 CompZReferF:=nil;
end;

//*******************************************************************
procedure TCompZReferF.DateChange(Sender: TObject);
begin
 CtrlState;
end;

//*******************************************************************
procedure TCompZReferF.S_Tzav_lcbCloseUp(Sender: TObject);
begin
 if (not Query1.Active)or(not Query2.Active) then exit;
 if S_Tzav_q.FieldByName('ID').asInteger > 0 then
  begin
   Query1.Filter:='id_tzav = '+S_Tzav_q.FieldByName('ID').asString;
   Query1.Filtered:=true;
   Query2.Filter:='id_tzav = '+S_Tzav_q.FieldByName('ID').asString;
   Query2.Filtered:=true;
  end
   else begin
         Query1.Filtered:=false;
         Query2.Filtered:=false;
        end;
{ StatusBar1.panels[0].text:='Закрытые: '+InttoStr(Query1.RecordCount);
 StatusBar1.panels[1].text:='Незакрытые: '+InttoStr(Query2.RecordCount);}
end;

//*******************************************************************
{procedure TFormResult.FormDestroy(Sender: TObject);
begin
 GL_Count:=-1; // ds

  if not VarIsEmpty(XLApp) then begin
    XLApp.DisplayAlerts := False;  // Discard unsaved files....
    XLApp.Quit;
    XLApp:=UnAssigned;
  end;
end;}

//*******************************************************************
procedure TCompZReferF.DBGridDblClick(Sender: TObject);
var
 ZvForm:TFormZav;
 _idz :integer;
 ds1 :TDataSet;
begin
 if (not Query1.Active)or(not Query2.Active) then exit;
 if PageControl1.ActivePage = TabSheet1
    then ds1:=Query1
    else ds1:=Query2;
 if ds1.recordCount = 0 then exit;
 _idz:=ds1.fieldbyName('ID').asInteger;
 ZvForm:=TFormZav_ZavCreate(Self,tfmZayavAfterInsert,_idz);
 ZvForm.ShowModal;
end;

procedure TCompZReferF.BPrintClick(Sender: TObject);
var
 Qr1 :TQuery;
 sTit :TstringList;
 FRes:TFormResult;
 top_label :string;
 sql_txt :string;
begin
 sTit:=TstringList.Create;
 sTit.Add(TrLangMSG(msgREV)); sTit.Add('Номер');
 sTit.Add(TrLangMSG(msgAddr)); sTit.Add(TrLangMSG(msgDateRegister));
 if PageControl1.ActivePage = TabSheet1{закрытые}
   then begin
         Qr1:=Query1;
         top_label:=TrLangMSG(msgSravnitSpravka)+' ('+TrLangMSG(msgClosed)+' наряда) ';
         sTit.Add('Дата закрытия');
        end
   else begin
         Qr1:=Query2;
         top_label:=TrLangMSG(msgSravnitSpravka)+' ('+TrLangMSG(msgNotClosed)+' наряда) ';
        end;
 top_label:=top_label+'за '+ansilowercase(TrLangMSG(msgRange))+' '+Frm_Dt.TitStr;

 sql_txt:=Qr1.SQL.Text;
 if StrToIntDef(S_Tzav_lcb.Value, -1) > 0
   then begin
         top_label:=top_label+'. Тип наряда: '+S_Tzav_lcb.Text;
         Insert(' and '+Qr1.Filter+' ', sql_txt, pos('AND',AnsiUpperCase(sql_txt)));
        end;

 FRes:=TFormResult.ResCreate(Self,false,'dbn_avar','Результат',top_label,'',
           sTit,-1,nil,false, true{группировка}, false{не заполнять StringGrid});
 FRes.Show;
 with FRes do
  begin
   NumCols:=0;
   PrBar.Position:=0;
   PrBar.Max:=Qr1.RecordCount +10;
   ShowProgress:=true; // ds
   Qr1.DisableControls;
   try
     Qr1.First;
     while not Qr1.EOF do
      begin
        StrGr_res.Cells[0,StrGr_res.RowCount-1]:=Qr1.FieldByName('REVS').asString;
        StrGr_res.Cells[1,StrGr_res.RowCount-1]:=Qr1.FieldByName('NOMER').asString;
        StrGr_res.Cells[2,StrGr_res.RowCount-1]:=Qr1.FieldByName('ADR').asString;
        StrGr_res.Cells[3,StrGr_res.RowCount-1]:=Qr1.FieldByName('DT_IN').asString;
        if PageControl1.ActivePage = TabSheet1{закрытые}
           then StrGr_res.Cells[4,StrGr_res.RowCount-1]:=Qr1.FieldByName('DT_OUT').asString;

        Qr1.Next;
        StrGr_res.RowCount:=StrGr_res.RowCount+1;
        inc(FRes.NumCols);
        PrBar.Position:=PrBar.Position+1;
        StatusBar1.Repaint;
      end; // while

     FRes.Caption:=Format('%s: %d',[TrLangMSG(msgCount),NumCols]);
     PrBar.Position:=PrBar.Max - 5;
     isIdView:=true;
     ChLB_Pol.ApplyState(cbChecked,false);
     Upd_Cols;
     PrBar.Position:=PrBar.Max;
     ShowProgress:=false; // ds
     StrGr_res.AdjustColWidths;
     StrGr_res.SetFocus;
   finally
     Qr1.EnableControls;
   end;
 end; // with
 sTit.Free;
end;

//*******************************************************************
procedure TCompZReferF.Translate;
begin
  inherited;
  Caption:=TrLangMSG(msgSravnitSpravka);
  BtOk.Caption:=TrLangMSG(msgApply);
  BExit.Caption:=TrLangMSG(msgExit);
  StaticText1.Caption:=TrLangMSG(msgFilter);
  BPrint.Caption:=TrLangMSG(msgPrint);
  TabSheet1.Caption:=TrLangMSG(msgClosed)+' наряды';
  TabSheet2.Caption:=TrLangMSG(msgNotClosed)+' наряды';
  DBGrid1.Columns[0].Title.Caption:=TrLangMSG(msgREV);
  DBGrid1.Columns[2].Title.Caption:=TrLangMSG(msgAddr);
  DBGrid1.Columns[3].Title.Caption:=TrLangMSG(msgDateRegister);
  DBGrid1.Columns[4].Title.Caption:=TrLangMSG(msgDateClose);
  DBGrid2.Columns[0].Title.Caption:=TrLangMSG(msgREV);
  DBGrid2.Columns[2].Title.Caption:=TrLangMSG(msgAddr);
  DBGrid2.Columns[3].Title.Caption:=TrLangMSG(msgDateRegister);
end;

initialization
 CompZReferF:=nil

end.
