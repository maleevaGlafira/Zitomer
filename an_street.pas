unit an_street;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, RxLookup, Db, DBTables, FResult, Aligrid, frm_dat,
  ExtCtrls, frmLANG, cntsLANG,ServiceFuncUnit;

type
  TAnFormStreet = class(TFormLang)
    Qry_street: TQuery;
    DS_street: TDataSource;
    Qry_tmp: TQuery;
    Panel1: TPanel;
    Label1: TLabel;
    DBL_street: TRxDBLookupCombo;
    BB_Ok: TBitBtn;
    BB_Exit: TBitBtn;
    FrmDt_ul: TFrm_Date;
    Work_rg: TRadioGroup;
    Damg_lcb: TRxDBLookupCombo;
    Label2: TLabel;
    Bevel1: TBevel;
    Excavation_chb: TCheckBox;
    NotExcavation_chb: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BB_ExitClick(Sender: TObject);
    procedure BB_OkClick(Sender: TObject);
    procedure FrmDtChange(Sender: TObject);
    procedure DBL_streetChange(Sender: TObject);
    procedure ChbClick(Sender: TObject);
    procedure Damg_lcbChange(Sender: TObject);

  private
    procedure CtrlState;

  public
    { Public declarations }
    FRes:TFormResult;
    ZvRes:TFormResult;
    procedure Gr_Click(sender:TObject);
    procedure Zv_Click(sender:TObject);
    function StrGr_resCompareCol(Sender: TObject; Column, Row1, Row2: Integer): t_relation;
    procedure Translate;override;
  end;

var
  AnFormStreet: TAnFormStreet;

implementation
  uses main,fd_grf,strtool, datam, avartype;
{$R *.DFM}

procedure TAnFormStreet.FormCreate(Sender: TObject);
begin
  AnFormStreet:=Self;
  Qry_street.Open;
  if not DM1.S_Damg_q.Active then DM1.S_Damg_q.Open; // ds
  CtrlState; // ds
end;

procedure TAnFormStreet.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Qry_street.Close;
  Action:=caFree;
end;


procedure TAnFormStreet.BB_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TAnFormStreet.BB_OkClick(Sender: TObject);
var
  sTit:TstringList;
  main_sql,work_sql :string;
  not_cond, damgSql_Cond :string;
  all,i:integer;
begin
  sTit:=TstringList.Create;
  sTit.Add(TrLangMSG(msgNumDom));sTit.Add(TrLangMSG(msgCountCrash));
  sTit.Add(TrLangMSG(msgCrash));

  work_sql:=''; {damgSql_alias:='';} damgSql_Cond:=''; {damgSql_field:='';}
  //if Work_rg.itemIndex = 0 {с раскопкой} then // ds
  if (not Excavation_chb.Checked)or(not NotExcavation_chb.Checked)
    then begin
          not_cond:='';
          if NotExcavation_chb.Checked then{Без раскопки} not_cond:=' not ';
          if (Excavation_chb.Checked)or(NotExcavation_chb.Checked)
             then work_sql:=Format(' and %s exists (select rs.id from works rs '+
                                   ' where (delz=0) and rs.id_zav = zavjav.id and (wk.id_work in (%d,%d))) ',
                                   [not_cond, RASKOPKA_ID1,RASKOPKA_ID2]);
         end; // if (not Excavation_chb.Checked) ...

  if Damg_lcb.text <> Damg_lcb.DisplayEmpty then
    begin
     {damgSql_field:=', dmg.Name_r pole2 ';
     damgSql_alias:=', s_damg dmg ';}
     damgSql_Cond:=' and dmg.id = '+DM1.S_Damg_q.FieldByName('ID').asString+' ';
     {damg_sql:='and exists (select dmg.id from s_damg dmg where dmg.id=zavjav.id_damg and dmg.id='+
                DM1.S_Damg_q.FieldByName('ID').asString+')';}
    end; // if Damg_lcb.text <> Damg_lcb.DisplayEmpty ...

  main_sql:='select distinct '+ Qry_street.FieldByName('ID').asString+' id, '+
            //'zavjav.id, '+ // ds
            ' id_ul2 pole0,id_ul2||''#''||zavjav.id_damg pole1, dmg.Name_r pole2 FROM zavjav'+
            ' LEFT JOIN s_damg dmg on (dmg.id = zavjav.id_damg) WHERE '+
          ' (delz=0) and id_ul1='+Qry_street.FieldByName('ID').asString+
          ' and kod_ul=0 '+FrmDt_ul.SQLStr +work_sql+damgSql_Cond+ ' order by id_ul2';

  FRes:=TFormResult.ResCreate(Self,false,'dbn_avar','Результат',strip('B',' ',TrLangMSG(msgAnalizPovr)+' '+
        'по '+Qry_street.FieldByName('NAME_R').asString+' '+FrmDt_ul.TitStr),
        main_sql,sTit,-1,NN8,false);

  Fres.BB_zav.Visible:=false; // т.к. вместо ID наряда идет ID улицы, исползуемое
                              // в Fres для подсчета повреждений (такая вот задница ...)
  Fres.StrGr_res.onDblClick:=nil;

  if FRes.exit_fl then
    begin
     sTit.free;
     FRes.free;
     exit;
    end;
  FRes.StrGr_res.OnCompareCol:=StrGr_resCompareCol;
  FRes.StrGr_res.SortColumn(0,true);
  Fres.StrGr_res.RowCount:=Fres.StrGr_res.RowCount+1;
  Fres.StrGr_res.Cells[0,Fres.StrGr_res.RowCount-1]:='без номера';
  MyOpenSQL(Qry_tmp,'select count(id) mm from zavjav where (delz=0) and '+
           '((id_ul1='+Qry_street.FieldByName('ID').asString
          +' and kod_ul<>0) or (kod_ul=1 and id_ul2="'+Qry_street.FieldByName('ID').asString          +'")) '+FrmDt_ul.SQLStr);
  Fres.StrGr_res.Cells[1,Fres.StrGr_res.RowCount-1]:=
     Qry_tmp.FieldByName('MM').asString;
  Qry_tmp.Close;

    Fres.StrGr_res.RowCount:=Fres.StrGr_res.RowCount+2;
    Fres.StrGr_res.Cells[0,Fres.StrGr_res.RowCount-1]:=TrLangMSG(msgITOGO);
    all:=0;
    for i:=1 to Fres.StrGr_res.RowCount-2 do
       all:=all+strtointdef(trim(Fres.StrGr_res.Cells[1,i]),0);

    Fres.StrGr_res.Cells[1,Fres.StrGr_res.RowCount-1]:=inttostr(all);
    Fres.StrGr_res.AdjustColWidths;
    Fres.StrGr_res.ColWidths[Fres.StrGr_res.ColCount-1]:=2;
    Fres.BB_Graf.Enabled:=true;
    Fres.BB_Graf.Visible:=true;
    Fres.BB_Graf.OnClick:=AnFormStreet.Gr_Click;
    Fres.BB_zav.Caption:='наряда';
    Fres.BB_Zav.OnClick:=AnFormStreet.Zv_Click;

 if not Fres.exit_fl then Fres.ShowModal // ds
                else Fres.Close;
  sTit.Free;
end;

function TAnFormStreet.StrGr_resCompareCol(Sender: TObject; Column, Row1,
  Row2: Integer): t_relation;
var a1,a2,i,a:integer;
   // b1,b2:double;
begin
    a1:=StrToIntdef(FRes.StrGr_res.cells[Column,Row1],0);
    if a1=0 then
       begin
         for i:=length(FRes.StrGr_res.cells[Column,Row1]) downto 1 do
           begin
              a:=StrToIntdef(copy(FRes.StrGr_res.cells[Column,Row1],1,i),0);
              if a>0 then
                begin
                 a1:=a;
                 break;
                end;
           end;
       end;
    a2:=StrToIntdef(FRes.StrGr_res.cells[Column,Row2],0);
    if a2=0 then
       begin
         for i:=length(FRes.StrGr_res.cells[Column,Row2]) downto 1 do
           begin
              a:=StrToIntdef(copy(FRes.StrGr_res.cells[Column,Row2],1,i),0);
              if a>0 then
                begin
                 a2:=a;
                 break;
                end;
           end;
       end;
    result:=rel_equal;
    if a1>a2 then
      result:=rel_greater
    else if a2>a1 then
      result:=rel_less;
 end;

procedure TAnFormStreet.Gr_Click(sender:TObject);
var i:integer;
    TutGraf:TGrafFForm;
begin
  CreateRes(CurrentDir,1);
  AddSet(CurrentDir,'GR_LABEL','Анализ повреждений по '+
   AnFormStreet.Qry_street.FieldByName('Name_R').asString);
  AddSet(CurrentDir,'X_AXIS','Номер дома');
  AddSet(CurrentDir,'Y_AXIS','Кол-во повреждений');
  AddSet(CurrentDir,'POLE0','Номер');
  For i:=1 to Fres.StrGr_res.RowCount-3 do
   begin
        AddRes(CurrentDir,[i,Fres.StrGr_res.Cells[0,i],
                           strtointdef(Fres.StrGr_res.Cells[1,i],0)]);
   end;
   TutGraf:=TGrafFForm.GrCreate(Self,CurrentDir);
   TutGraf.ShowModal;
end;

procedure TAnFormStreet.Zv_Click(sender:TObject);
 var sTit:TstringList;
     main_sql,main_tit:string;
     //all,i:integer;
begin
 if FRes.StrGr_Res.Row<=FRes.StrGr_Res.RowCount-3 then
  begin
    sTit:=TstringList.Create;
    sTit.Add(TrLangMSG(msgYear));sTit.Add('Номер');sTit.Add(TrLangMSG(msgDateArrive));
    sTit.Add('Тип');sTit.Add(TrLangMSG(msgContext));
    if FRes.StrGr_Res.Row=FRes.StrGr_Res.RowCount-3 then
     begin
      main_tit:=','+TrLangMSG(msgDom)+' - без номера ';
      main_sql:=
      'select z.id,z.fyear pole0,z.nomer pole1,z.dt_in pole2,t.name_r pole3,s.name_r pole4 from zavjav z,s_tzav t,s_sod s where (delz=0) and'+
      'z.id_tzav=t.id and z.id_sod=s.id and s.ftype=t.id and '+
      '((z.id_ul1='+Qry_street.FieldByName('ID').asString
            +' and z.kod_ul<>0) or (z.kod_ul=2 and z.id_ul2="'+Qry_street.FieldByName('ID').asString
            +'")) '+FrmDt_ul.SQLStr;
     end
    else
     begin
      main_tit:=','+TrLangMSG(msgDom)+' '+FRes.StrGr_Res.Cells[0,FRes.StrGr_Res.Row]+' ';
      main_sql:=
      'select z.id,z.fyear pole0,z.nomer pole1,z.dt_in pole2,t.name_r pole3,s.name_r pole4 from zavjav z,s_tzav t,s_sod s where (delz=0) and'+
      'z.id_tzav=t.id and z.id_sod=s.id and s.ftype=t.id and '+
      'z.id_ul1='+Qry_street.FieldByName('ID').asString
            +' and z.kod_ul=0 and z.id_ul2="'+FRes.StrGr_Res.Cells[0,FRes.StrGr_Res.Row]
            +'" '+FrmDt_ul.SQLStr;
     end;
    ZvRes:=TFormResult.ResCreate(Self,false,'dbn_avar','Результат',strip('B',' ',TrLangMSG(msgListCrash)+
          ' по '+Qry_street.FieldByName('NAME_R').asString+main_tit+FrmDt_ul.TitStr),
          main_sql,sTit,-1,NIL,false);
    ZvRes.ShowModal;
    sTit.Free;
  end;
end;

//*******************************************************************
procedure TAnFormStreet.CtrlState;
begin
 BB_Ok.Enabled:=(FrmDt_ul.CheckFields)and
                (DBL_street.Text <> '')and
                ((Excavation_chb.Checked)or(NotExcavation_chb.Checked));
end;

//*******************************************************************
procedure TAnFormStreet.FrmDtChange(Sender: TObject);
begin
 CtrlState;
end;

//*******************************************************************
procedure TAnFormStreet.DBL_streetChange(Sender: TObject);
begin
 CtrlState;
end;

//*******************************************************************
procedure TAnFormStreet.ChbClick(Sender: TObject);
begin
 CtrlState;
end;

//*******************************************************************
procedure TAnFormStreet.Damg_lcbChange(Sender: TObject);
begin
 CtrlState;
end;

//*******************************************************************
procedure TAnFormStreet.Translate;
begin
  inherited;
  Caption:=TrLangMSG(msgAnalizPovrUlic)+' ('+TrLangMSG(msgClosed)+' наряда)';
  Label1.Caption:=TrLangMSG(msgStreet);
  Label2.Caption:=TrLangMSG(msgCrash);
  BB_Ok.Caption:=TrLangMSG(msgApply);
  BB_Exit.Caption:=TrLangMSG(msgClose);
  Work_rg.Items.Strings[0]:=TrLangMSG(msgWithDigging);
  Work_rg.Items.Strings[1]:=TrLangMSG(msgWithoutDigging);
  Excavation_chb.Caption:=TrLangMSG(msgWithDigging);
  NotExcavation_chb.Caption:=TrLangMSG(msgWithoutDigging);
end;

end.
