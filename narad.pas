unit narad;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Mask, StdCtrls, ToolEdit, Buttons, ComCtrls, RXLookup, Db, DBTables,
  ExtCtrls, frmLANG, cntsLANG, variants,ServiceFuncUnit, OperAttFormUnit,
  avartype, OborChoiseFormUnit, IBCustomDataSet,DMmain, IBDatabase ;

type
  TFormNarad = class(TFormLang)
    TbC_nar: TTabControl;
    BB_Add: TBitBtn;
    BB_del: TBitBtn;
    BB_Save: TBitBtn;
    BB_Exit: TBitBtn;
    Qry_narad: TQuery;
    Qry_brig: TQuery;
    DS_brig: TDataSource;
    Qry_tmp: TQuery;
    Lb_stat: TLabel;
    BB_zadv: TBitBtn;
    BB_Ras: TBitBtn;
    Lb_save: TLabel;
    Qry_tmp2: TQuery;
    Qry_brig2: TQuery;
    Panel1: TPanel;
    Label14: TLabel;
    Label13: TLabel;
    DE_dep: TDateEdit;
    DE_out: TDateEdit;
    TE_dep: TDateTimePicker;
    TE_out: TDateTimePicker;
    Label4: TLabel;
    Label5: TLabel;
    Label2: TLabel;
    DBL_brig: TRxDBLookupCombo;
    Mm_dopinf: TMemo;
    BB_obor: TBitBtn;
    Bevel1: TBevel;
    Label8: TLabel;
    Lb_DisIn: TLabel;
    Lb_DisOut: TLabel;
    Label3: TLabel;
    DBL_brig3: TRxDBLookupCombo;
    DS_brig3: TDataSource;
    Qry_brig3: TQuery;
    Label6: TLabel;
    Label7: TLabel;
    edNUMBERT: TEdit;
    Label9: TLabel;
    edNUMTEAM: TEdit;
    Label11: TLabel;
    DE_in: TDateEdit;
    TE_in: TDateTimePicker;
    BitBtn1: TBitBtn;
    BB_Works: TBitBtn;
    btn_PlanObor: TButton;
    btn_mexan: TBitBtn;
    but_planWorjs: TButton;
    Qry_dopinf: TIBDataSet;
    tran: TIBTransaction;
    sp_intime_dep: TSpeedButton;
    sp_intime_in: TSpeedButton;
    sp_intime_out: TSpeedButton;
    lbl_DopInfoPlanWork: TLabel;
    mem_dopplalwork: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TbC_narChange(Sender: TObject);
    procedure BB_AddClick(Sender: TObject);
    procedure BB_ExitClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BB_delClick(Sender: TObject);
    procedure BB_SaveClick(Sender: TObject);
    procedure DBL_runwChange(Sender: TObject);
    procedure BB_zadvClick(Sender: TObject);
    procedure BB_RasClick(Sender: TObject);
    procedure BB_OborClick(Sender: TObject);
    procedure Mm_dopinfChange(Sender: TObject);
    procedure Mm_dopinfExit(Sender: TObject);
    procedure Mm_dopinfKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBL_runwKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn1Click(Sender: TObject);
    procedure DE_outChange(Sender: TObject);
    procedure DE_inButtonClick(Sender: TObject);
    procedure BB_WorksClick(Sender: TObject);
    procedure bb_planWorkMatersClick(Sender: TObject);
    procedure btn_PlanOborClick(Sender: TObject);
    procedure btn_mexanClick(Sender: TObject);
    procedure but_planWorjsClick(Sender: TObject);
    procedure EnableBottms(enable:boolean);
    procedure sp_intime_depClick(Sender: TObject);
    procedure sp_intime_inClick(Sender: TObject);
    procedure sp_intime_outClick(Sender: TObject);
    procedure mem_dopplalworkChange(Sender: TObject);
  private
    FReadOnly:boolean;
    F_MestTypeID,
    F_ObjectID: integer;
    F_OperAtt: TOperAtt;
    F_DefaultAdres: TAdresRec;
    F_DefaultActiveRaskopID: integer;
    F_CloseNarDate:TdateTime;
    function SetCloseZavdate():TDateTime;
    procedure SetReadOneRow(read:boolean);
  public
    { Public declarations }
    SaveFlag,LockSaveFlag:boolean;
    NewZap,isSel:boolean;
    constructor NarCreate(AOwner: TComponent;Mode,zCod:integer;_ReadOnly:boolean;_OperAtt: TOperAtt);
    procedure NarUpdate(seekId:integer);
    procedure RecUpdate(isNew:boolean);
    function CountNar(isCl:boolean):integer;
    procedure SwSave(st:boolean);
    function CheckFillNar:boolean;
    procedure Text2Nar(ss:integer);
    procedure Translate;override;
    property MestTypeID: integer read F_MestTypeID write F_MestTypeID;
    property ObjectID: integer read F_ObjectID write F_ObjectID;
    property DefaultActiveRaskopID: integer read F_DefaultActiveRaskopID
      write F_DefaultActiveRaskopID;
    property DefaultAdres: TAdresRec read F_DefaultAdres write F_DefaultAdres;
  end;

var
  FormNarad: TFormNarad;
  NaradMode,NrZajvCod,{NarCod,}NarCount:integer;
  narTb:string;

implementation
  uses zav,obor,FormPlanObor,main,strtool, datam, support, peoples,
  WorkDM, WorkForm, WorkContainerDM, zav_obj, WorkContainerPlanDM,WorkDMPlan,
  FormOborIB,ShiftDmodule;
{$R *.DFM}


constructor TFormNarad.NarCreate(AOwner: TComponent;Mode,zCod:integer;_ReadOnly:boolean; _OperAtt: TOperAtt);
begin
 FReadOnly:=_ReadOnly;
 NaradMode:=Mode;
 if Mode=0 then
    narTb:='narad'
 else
    narTb:='nnarad';
 NrZajvCod:=zCod;
 //
 F_OperAtt := _OperAtt;
 F_MestTypeID := -1;
 F_ObjectID := -1;
 F_DefaultActiveRaskopID := -1;

 F_DefaultAdres.kod_ul := 0;
 F_DefaultAdres.id_ul1 := -1;
 F_DefaultAdres.id_ul2 := '';
 F_DefaultAdres.dop_adr := '';
 F_DefaultAdres.id_DopAdres := -1;

 inherited Create(AOwner);
end;


procedure TFormNarad.FormCreate(Sender: TObject);
begin
  SaveFlag:=FALSE;
  LockSaveFlag:=FALSE;
  //
  if  FormZav.FltDel and not FormMain.DictNotHide.checked
  then begin
    SetFilterDelete(Qry_brig,true);

    SetFilterDelete(Qry_brig3,true);
//    SetFilterDelete(Qry_runw,true);
  end;

  FormNarad:=Self;
  UstColors(Self);
  isSel:=false;
  NewZap:=false;
  Qry_Brig.Open;

  Qry_Brig3.Open;
//  Qry_runw.Open;
  Qry_Brig2.Open;
  NarUpdate(0);
  if {(NaradMode=0) or} FReadOnly then
    begin
      DBL_BrIg.Enabled:=false;
      DBL_BrIg3.Enabled:=false;
//      DBL_runw.Enabled:=false;

      mm_dopinf.Enabled:=false;
      mem_dopplalwork.Enabled:=false;
      DE_dep.Enabled:=false;
      DE_in.Enabled:=false;
      DE_out.Enabled:=false;
      TE_dep.Enabled:=false;
      sp_intime_dep.Enabled:=false;
      TE_in.Enabled:=false;
      sp_intime_in.Enabled:=false;
      Te_out.Enabled:=false;
      sp_intime_out.Enabled:=false;
      BB_Add.Enabled:=false;
      BB_Del.Enabled:=false;
      edNUMBERT.enabled:=false;
      edNUMTEAM.enabled:=false;
    end;
    if Qry_narad.Active then
     EnableBottms( Qry_narad.FieldByName('id').AsInteger>0)
   else
     EnableBottms( false);
   F_CloseNarDate:=SetCloseZavDate();
   if F_CloseNarDate>0 then
     if Qry_narad.FieldByName('dt_out').AsDateTime>0 then
      if Qry_narad.FieldByName('dt_out').AsDateTime<=F_CloseNarDate then
        SetReadOneRow(true or FReadOnly);

end;

procedure TFormNarad.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Qry_Brig2.Close;
  Qry_Narad.Close;
  Qry_Brig.Close;

  Qry_Brig3.Close;
  Qry_dopinf.Close
//  Qry_runw.Close;
end;

procedure TFormNarad.NarUpdate(seekId:integer);
var i:integer;
begin
  Caption:=format(TrLangMSG(msgWentCountClose),[CountNar(false),CountNar(true)]);
  MyOpenSQL(Qry_tmp,'select count(id) mm from '+narTb+' where id_zav='+IntToStr(NrZajvCod));
  if (Qry_tmp.FieldByName('MM').asInteger>0) and (NrZajvCod>0) then
   begin
    NarCount:=Qry_tmp['MM'];
    Qry_tmp.Close;
    MyOpenSQL(Qry_narad,'select id, id_zav,nomer, dt_in, dt_out,id_work,id_brig,ID_DISIN,ID_DISOUT,ID_BRIG2, numbert,NUMTEAM,DT_DEP from '+narTb+' where id_zav='+IntToStr(NrZajvCod)+
                      'order by nomer' );
    MyOpenIBDS(QRY_dopinf,'select id,nomer,dop_inf,dop_palnwork from '+narTb+' where id_zav='+IntToStr(NrZajvCod)+
                      'order by nomer' );

    Qry_Narad.First;
    TbC_Nar.Tabs.Clear;
    for i:=0 to NarCount-1 do
      begin
        if i=0 then TbC_nar.Tabs.Add(TrLangMSG(msgFirst))//'Первичный'
          else TbC_nar.Tabs.Add('N'+inttostr(Qry_Narad['nomer']));
        //Zadv2Cod[i]:=Qry_zadv['ID'];
        Qry_Narad.Next;
      end;
      if SeekId>0 then
        begin
          Qry_Narad.Locate('ID',seekId,[]);
          QRY_dopinf.Locate('ID',seekId,[]);
        end
      else
        begin
          Qry_Narad.First;
          QRY_dopinf.First;
        end;
      TbC_Nar.TabIndex:=Qry_Narad['nomer']-1;
      RecUpdate(false);
      EnableBottms(true);
  end // if Qry_tmp.FieldByName('MM').asInteger > 0 ...
    else begin
          TbC_Nar.Tabs.Clear;
          EnableBottms(false);
{uo  Нафига теперь еще безхозный наряд ???
          // проверка на "безхозные" заявки(у которых есть работы,
          // а наряды куда-то испарились из (N)NARAD )
          MyOpenSQL(Qry_tmp,'select distinct id_nar from works where id_zav='+IntToStr(NrZajvCod));
          if Qry_tmp.EOF then Qry_tmp.Close;
          BB_obor.Enabled:=Qry_tmp.Active;
          if BB_obor.Enabled then
            begin
              i:=1;
              MyExecSQL(Qry_tmp2,'alter trigger tr_nnarad inactive');
              MyExecSQL(Qry_tmp2,'COMMIT');
              if not DM1.Db_Avar.inTransaction then DM1.Db_Avar.StartTransaction;
              while not Qry_tmp.EOF do
                begin
                 //TbC_nar.Tabs.Add('Неопределенный'+IntToStr(i));
                 MyExecSQL(Qry_tmp2,Format(
                    'insert into %s (id, id_zav, nomer) values(%d, %d, %d)',
                            [narTb, Qry_tmp.FieldByName('ID_NAR').asInteger, NrZajvCod, i]));
                 Qry_tmp.Next;
                 inc(i);
                end; // while
              MyExecSQL(Qry_tmp2,'alter trigger tr_nnarad active');
              DM1.Db_Avar.Commit;
              Qry_tmp.Close;
              NarUpdate(0);
              exit;
            end; // if BB_obor.Enabled ...
}
         // ds  BB_obor.Enabled:=false;
          if not FReadOnly then
            begin
              MyOpenSQL(Qry_narad,'select id, id_zav,nomer, dt_in, dt_out,id_work,id_brig,ID_DISIN,ID_DISOUT,ID_BRIG2, numbert,NUMTEAM,DT_DEP from '+narTb+' where id_zav='+IntToStr(NrZajvCod)+
                      ' order by nomer' );
              MyOpenIBDS(Qry_dopinf,'select id, nomer, dop_inf, dop_palnwork from '+narTb+' where id_zav='+IntToStr(NrZajvCod)+
                      ' order by nomer' );
              BB_AddClick(Self);
            end;
     end; // if Qry_tmp.FieldByName('MM').asInteger > 0 ... else
end;

procedure TFormNarad.RecUpdate(isNew:boolean);
var dt:TDateTime;
begin
   Lb_DisIn.Caption:='';
   Lb_DisOut.Caption:='';
   mm_dopinf.onChange:=NIL;
   mem_dopplalwork.OnChange:=nil;
   if isNew then
     begin
{
          if not Qry_runw.Locate('NAME_R',
                    FormZav.Qry_revs.FieldByName('NAME_R').asString,[]) then
              Qry_runw.First;
}
          Qry_Brig.Locate('ID','-1',[]);

          Qry_Brig3.Locate('ID','-1',[]);
//          Qry_Brig3.First;
          mm_dopinf.Text:='';
          mem_dopplalwork.Text:='';
          if F_OperAtt in [ toaObjVoda, toaObjKanal ] then
          begin
            DE_dep.Text := '';
            TE_dep.Time := 0;
          end else
          begin
            dt:=Mynow;
            DE_dep.Date:=dt;
          end;

          TE_dep.Time:=strtodatetime(datetimetostr(dt,'dd.mm.yyyy hh:mm:00'));
//          DE_in.Date:=DE_dep.date;
  //        TE_in.Time:=TE_dep.Time;
          DE_in.Text:='';
          TE_in.Time:=0; //''; //Time2Str(Now);
          DE_out.Text:='';
          TE_out.Time:=0; //''; //Time2Str(Now);
          BB_Obor.Enabled:=false;
          BB_Works.Enabled := false;
          edNUMBERT.text:='';
          edNUMTEAM.text:='';
     end
   else begin
              edNUMBERT.text:=Qry_narad.fieldbyname('NUMBERT').AsString;
              edNUMTEAM.text:=Qry_narad.fieldbyname('NUMTEAM').AsString;
//              Qry_runw.Locate('ID',Qry_narad['ID_WORK'],[]);
              Qry_Brig.Locate('ID',Qry_narad['ID_BRIG'],[]);

              Qry_Brig3.Locate('ID',Qry_narad['ID_BRIG2'],[]);
              mm_dopinf.Text:=Qry_dopinf.FieldByName('DOP_INF').asString;
              mem_dopplalwork.Text:=Qry_dopinf.FieldByName('dop_palnwork').asString;
              DE_dep.Date:=Qry_Narad.FieldByName('DT_DEP').asDateTime;
              TE_dep.Time:=Qry_Narad.FieldByName('DT_DEP').asDateTime;
              DE_in.Date:=Qry_Narad.FieldByName('DT_IN').asDateTime;
              TE_In.Time:=Qry_Narad.FieldByName('DT_IN').asDateTime;
              DE_Out.Date:=Qry_Narad.FieldByName('DT_OUT').asDateTime;
              TE_Out.Time:=Qry_Narad.FieldByName('DT_OUT').asDateTime;
              Lb_DisIn.Caption:='';
              Lb_DisOut.Caption:='';
              if Qry_Narad.FieldByName('ID_DISIN').asInteger=0 then
                 Lb_DisIn.Caption:=trim(TrLangMSG(msgAdmin))+' '
        else begin
              if (Qry_Brig2.Locate('ID',Qry_Narad.FieldByName('ID_DISIN').asInteger,[]))
                 then Lb_DisIn.Caption:=trim(Qry_Brig2.FieldByName('NAME_R').asString)+' ';
             end;
          if (Qry_Narad.FieldByName('ID_DISOUT').asInteger=0) then
             Lb_DisOut.Caption:=trim(TrLangMSG(msgAdmin))+' '
          else begin
                if (Qry_Brig2.Locate('ID',Qry_Narad.FieldByName('ID_DISOUT').asInteger,[]))
                   then Lb_DisOut.Caption:=trim(Qry_Brig2.FieldByName('NAME_R').asString)+' ';
               end;

          BB_Obor.Enabled := true;
          BB_Works.Enabled := true;
     end;
  mm_dopinf.onChange:=mm_dopinfChange;
  mem_dopplalwork.OnChange:=mem_dopplalworkChange;
//  DBL_runw.DisplayValue:=Qry_runw['NAME_R'];
  DBL_brig.DisplayValue:=Qry_Brig['NAME_R'];

  DBL_brig3.DisplayValue:=Qry_Brig3['NAME_R'];
  SwSave(false);
  if DE_Out.Date=0 then
    Lb_Stat.Caption:=TrLangMSG(msgWentNotClose)
  else
    Lb_Stat.Caption:='';
  if {(NaradMode<>0) and} (not FReadOnly) then
   BB_Add.Enabled:= not isNew;


end;

function TFormNarad.CountNar(isCl:boolean):integer;
begin
  Qry_tmp.Close;
  Qry_tmp.SQL.Clear;
  if isCl then
    Qry_tmp.SQL.Add('select count(id) mm from '+narTb+' where id_zav='+IntToStr(NrZajvCod)+
                    ' and dt_out is not NULL')
  else
    Qry_tmp.SQL.Add('select count(id) mm from '+narTb+' where id_zav='+IntToStr(NrZajvCod));

  Qry_tmp.Open;
  Result:=Qry_tmp['MM'];
  Qry_tmp.Close
end;

procedure TFormNarad.TbC_narChange(Sender: TObject);
begin
  if NewZap then
   begin
     if MessageDlg(TrLangMSG(msgExitWithSaveREC),
                 mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        begin
           TbC_nar.Tabs.Delete(TbC_nar.Tabs.Count-1);
           TbC_nar.TabIndex:=TbC_nar.Tabs.Count-1;
           //Qry_narad.Locate('fio',TbC_nar.TabIndex+1,[]);
           NewZap:=false;
           SwSave(false);
        end
     else
        begin
           TbC_nar.TabIndex:=TbC_nar.Tabs.Count-1;
           RecUpdate(true);
           exit;
        end;
   end
  else if BB_Save.Enabled then
   begin
     if MessageDlg(TrLangMSG(msgExitWithSave),
                 mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        begin
         SwSave(false);
        end
     else
        begin
          TbC_nar.TabIndex:=Qry_Narad['NOMER']-1;
           //RecUpdate(true);
           exit;
        end;

   end;


 Qry_Narad.Locate('NOMER',TbC_nar.TabIndex+1,[]);
 Qry_dopinf.Locate('NOMER',TbC_nar.TabIndex+1,[]);
 RecUpdate(false);
 if  F_CLoseNarDate>0 then
  if Qry_narad.FieldByName('dt_out').AsDateTime>0 then
   if Qry_narad.FieldByName('dt_out').AsDateTime<=F_CLoseNarDate then
    SetReadOneRow(true)
   else
    SetReadOneRow(false or FReadOnly)
  else
   SetReadOneRow(false or FReadOnly)
 else
   SetReadOneRow(false or FReadOnly);
end;

procedure TFormNarad.BB_AddClick(Sender: TObject);
begin
  BB_Add.Enabled:=false;
  TbC_Nar.Tabs.Add(TrLangMSG(msgNewM));
  TbC_Nar.TabIndex:=TbC_nar.Tabs.Count-1;
  RecUpdate(true);
  NewZap:=true;
  SwSave(true);
  EnableBottms( false);
  SetReadOneRow(false);

end;

procedure TFormNarad.SwSave(st:boolean);
begin
  BB_Save.Enabled:=st and CheckFillNar;
  if not LockSaveFlag then SaveFlag:=BB_Save.Enabled;
  if st then
   begin
    Lb_save.Font.Color:=ErrCol;
    Lb_Save.Caption:=TrLangMSG(msgChangeNoSave);
   end
  else
   begin
    Lb_save.Font.Color:=TextCol;
    Lb_save.Caption:=TrLangMSG(msgNoChange)
   end

end;

function TFormNarad.CheckFillNar:boolean;
begin
  if F_OperAtt in [ toaObjVoda, toaObjKanal ] then
    Result := ( Qry_Brig.FieldByName('ID').asInteger > 0 )
  else
    Result := (( Strip('A','. ',DE_dep.Text) <> '' ) and
              ( TE_dep.Time <> 0 ))
              or(
              ( Strip('A','. ',DE_in.Text) <> '' ) and
              ( TE_in.Time <> 0 ))
               and
              ( Qry_Brig.FieldByName('ID').asInteger > 0 );

{
  Result:=false;

  if (Strip('A','. ',DE_dep.Text)<>'') and
   (TE_dep.Time<>0) and
   (Qry_BrIg.FieldByName('ID').asInteger>0)or(Qry_BrIg3.FieldByName('ID').asInteger>0)
    then Result:=true;
}
end;

procedure TFormNarad.BB_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TFormNarad.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:=true;
  if BB_Save.Enabled then
    begin
      if MessageDlg(TrLangMSG(msgExitWithSave),
                 mtConfirmation, [mbYes, mbNo], 0) = mrNo then
        CanClose:=false;

    end;

end;

procedure TFormNarad.BB_delClick(Sender: TObject);
begin
 if not NewZap then
  begin
   if MessageDlg(TrLangMSG(msgConfirmDelWent), mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
     if not DM1.Db_Avar.inTransaction then DM1.Db_Avar.StartTransaction;

     MyExecSQL(Qry_tmp,
      ' delete from raskop where id in (' +
      '  select id_raskop from works' +
      ' where id_nar = ' + intTostr(Qry_narad['ID']) + ')' );
     MyExecSQL(Qry_tmp,'delete from maters where id_nar='+intTostr(Qry_narad['ID']));
     MyExecSQL(Qry_tmp,'delete from obors where id_nar='+intTostr(Qry_narad['ID']));
     MyExecSQL(Qry_tmp,'delete from works where id_nar='+intTostr(Qry_narad['ID']));
     MyExecSQL(Qry_tmp,'delete from bworks where id_nar='+intTostr(Qry_narad['ID']));
     MyExecSQL(Qry_tmp,'delete from instrum where id_nar='+intTostr(Qry_narad['ID']));
     MyExecSQL(Qry_tmp,'delete from objobor where id_nar='+intTostr(Qry_narad['ID']));
     MyExecSQL(Qry_tmp,'delete from ord_people where id_work='+intTostr(Qry_narad['ID']));
     MyExecSQL(Qry_tmp,'delete from planobors where id_nar='+intTostr(Qry_narad['ID']));

     MyExecSQL(Qry_tmp,'delete from ' + narTb + ' where id='+intTostr(Qry_narad['ID']));
     MyExecSQL(Qry_tmp,'update ' + narTb + ' n set nomer=nomer-1 where  id_zav='+intTostr(Qry_narad['ID_zav'])+' and nomer>'+intTostr(Qry_narad['nomer']));
     //MyExecSQL(Qry_tmp,'COMMIT');
     DM1.Db_Avar.Commit;
     NarUpdate(0);
    end;
  end;

end;

procedure TFormNarad.BB_SaveClick(Sender: TObject);
function correctDate:boolean;
begin
 if DE_In.Date>0 then
 begin
  result:=ProvDate(DE_In.Date,DE_Out.Date,Time2Str(TE_in.Time),Time2Str(TE_out.Time),false);
  if DE_dep.Date>0 then
   result:=result and (ProvDate(DE_dep.Date,DE_In.Date,Time2Str(TE_dep.Time),Time2Str(TE_In.Time),true));

 end
 else
  result:=(ProvDate(DE_dep.Date,DE_In.Date,Time2Str(TE_dep.Time),Time2Str(TE_In.Time),true) and
    ProvDate(DE_dep.Date,DE_Out.Date,Time2Str(TE_dep.Time),Time2Str(TE_Out.Time),true));

end;

function inShift():boolean;
begin
 result:=true;
 //  Закоментировано 20210607 не проверять смену
{  if (de_dep.Date>0) then
   result:=result and  dm_Shift.datInCurShiftZavjav(NrZajvCod,int(DE_dep.Date)+frac(TE_dep.Time)) ;
  if de_In.Date>0 then
    result:=result and  dm_Shift.datInCurShiftZavjav(NrZajvCod,int(DE_in.Date)+frac(TE_in.Time)) ;
 if de_out.Date>0 then
      result:=result and  dm_Shift.datInCurShiftZavjav(NrZajvCod,int(DE_out.Date)+frac(TE_out.Time)) ;}
end;
var ss:integer;
    tt_str:string;

begin
LockSaveFlag:=TRUE;
//
  {if not( F_OperAtt in [ toaObjVoda, toaObjKanal ] ) and
  ( (DE_DEP.Date+frac(TE_dep.Time))<(FormZav.DE_in.Date+frac(FormZav.TE_in.Time)) ) then
   begin
     MessageDlg(TrLangMSG(msgDataBeginWentLTOpen),
                 mtError, [mbOk], 0);
     exit;
   end;}
if not  inShift() then
begin
  MessageDlg(TrLangMSG(msgDatBeginInCurShift)+' '+DatetoStr((DM_shift.getShiftDateZavjav(NrZajvCod))),
                 mtError, [mbOk], 0);
  exit;
end;
if  correctDate()
    then
 begin
  if NewZap then
    begin
      tt_str:='select max(nomer) mm from '+narTb+
              ' where id_zav='+IntToStr(NrZajvCod);
      MyOpenSQL(Qry_tmp,tt_str);
      if Qry_tmp['MM']=NULL then
        ss:=1
      else
        ss:=Qry_tmp['MM']+1;
{      tt_str:='insert into nnarad(id_zav,nomer,dop_inf,'+
                      'dt_dep,dt_in,dt_out,id_brig,id_local,id_brig2,id_work,id_disin,id_disout,numbert,numteam) values('+IntToStr(NrZajvCod)+','+
                      inttostr(ss)+',"'+
                      '","'+DE_dep.Text+' '+Time2Str(TE_dep.Time)+'",';

}
      tt_str:='insert into ' + narTb + '(id_zav,nomer,dop_inf,'+
                      'dt_dep,dt_in,dt_out,id_brig,id_brig2,id_disin,id_disout,numbert,numteam) values('+IntToStr(NrZajvCod)+','+
                      inttostr(ss)+',"'+{mm_dopinf.Text+}'",';

      if DE_dep.Date=0 then
        tt_str := tt_str + 'NULL,'
      else
        tt_str := tt_str + '"'+DE_dep.Text+' '+Time2Str(TE_dep.Time)+'",';
      if DE_in.Date=0 then
         tt_str:=tt_str+'NULL,'
      else
         tt_str:=tt_str+'"'+DE_in.Text+' '+Time2Str(TE_in.Time)+'",';
      if DE_Out.Date=0 then
         tt_str:=tt_str+'NULL,'
      else
         tt_str:=tt_str+'"'+DE_Out.Text+' '+Time2Str(TE_Out.Time)+'",';

      tt_str:=tt_str+Qry_BrIg.FieldByName('ID').asString+','+

                     Qry_BrIg3.FieldByName('ID').asString+','+
//                     Qry_runw.FieldByName('ID').asString+','+
                     IntToStr(CodUser);

      if DE_Out.Date=0 then
         tt_str:=tt_str+',NULL'
      else
         tt_str:=tt_str+','+IntToStr(CodUser);

      if strtointdef(trim(edNUMBERT.text),-1)=-1
      then tt_str:=tt_str+',null'
      else tt_str:=tt_str+','+edNUMBERT.text;
      if strtointdef(trim(edNUMTEAM.text),-1)=-1
      then tt_str:=tt_str+',null'
      else tt_str:=tt_str+','+edNUMTEAM.text;

      tt_str:=tt_str+')';

      MyExecSQL(Qry_tmp,tt_str);
      MyOpenSQL(Qry_tmp,'select max(id) mm from ' + narTb + ' where id_zav='+IntToStr(NrZajvCod));
      ss:=Qry_tmp['MM'];
      Qry_tmp.Close;
      MyExecSQL(Qry_tmp,'COMMIT');
      NewZap:=false;
      Text2Nar(ss);
      NarUpdate(ss);
    end
  else
    begin
      tt_str:='update ' +  narTb + ' set '+
              {'dop_inf="'+mm_dopInf.Text+
              '",id_brig='+Qry_brig.FieldByName('ID').asString+}
              'id_brig='+Qry_brig.FieldByName('ID').asString+
      
              ',id_brig2='+Qry_brig3.FieldByName('ID').asString+
//              ',id_work='+Qry_runw.FieldByName('ID').asString+
              ',id_disout='+IntToStr(CodUser);

      if DE_dep.Date=0 then
        tt_str := tt_str + ',dt_dep=NULL'
      else
        tt_str := tt_str +',dt_dep="'+DE_dep.Text+' '+Time2Str(TE_dep.Time)+'"';
      if DE_in.Date=0 then
         tt_str:=tt_str+',dt_in=NULL'
      else
         tt_str:=tt_str+',dt_in="'+DE_in.Text+' '+Time2Str(TE_in.Time)+'"';
      if DE_Out.Date=0 then
         tt_str:=tt_str+',dt_out=NULL'
      else
         tt_str:=tt_str+',dt_out="'+DE_Out.Text+' '+Time2Str(TE_Out.Time)+'"';

      if strtointdef(trim(edNUMBERT.text),-1)=-1
      then tt_str:=tt_str+',numbert=null'
      else tt_str:=tt_str+',numbert='+edNUMBERT.text;
      if strtointdef(trim(edNUMTEAM.text),-1)=-1
      then tt_str:=tt_str+',numteam=null'
      else tt_str:=tt_str+',numteam='+edNUMTEAM.text;

      ss:=Qry_narad.FieldByName('ID').asInteger;
      tt_str:=tt_str+' where id='+inttostr(ss);

      MyExecSQL(Qry_tmp,tt_str);
      MyExecSQL(Qry_tmp,'COMMIT');
      Text2Nar(ss);
      NarUpdate(ss);
    end;
  SwSave(false);
 end;
end;

procedure TFormNarad.DBL_runwChange(Sender: TObject);
begin
   SwSave(true);
end;

procedure TFormNarad.BB_zadvClick(Sender: TObject);
begin
  FormZav.BB_zadvClick(FormNarad.Owner);
end;


procedure TFormNarad.BB_RasClick(Sender: TObject);
begin
  FormZav.BB_RasClick(FormNarad.Owner);
end;

procedure TFormNarad.BB_OborClick(Sender: TObject);
var
 Obor :TFormObor;
begin
{  if FormZav.Qry_place.FieldByName('ID').asInteger>0 then
    begin}
     ButVis(FormNarad,false);
     Obor:=TFormObor.OborCreate(Self,NrZajvCod, Qry_narad['ID'],NaradMode,F_ObjectID
     );
     visible:=false;
     Obor.ShowModal;
     visible:=true;
     ButVis(FormNarad,true);
     bb_zadv.Visible:=false;
     bb_ras.Visible:=false;
{    end
  else
    MessageDlg('У заявки не определено место повреждения !', mtError,
      [mbOk], 0);}

  //uo Пропадает список???
  Qry_brig3.close; Qry_brig3.open;
end;

procedure TFormNarad.Text2Nar(ss:integer);
begin

  MyExecSQL(Qry_tmp2,format('UPDATE  %s SET  DOP_INF=''%s'', dop_palnwork=''%s'' where id=%d ',
                             [narTb,trim(mm_DopInf.Text),trim(mem_dopplalwork.Text),ss]));
  Qry_tmp2.Close;                           
  MyExecSQL(Qry_tmp2,'Commit');
  Qry_tmp2.Close;
{  Qry_tmp2.Edit;
  Qry_tmp2.FieldByName('DOP_INF').asString:=trim(mm_DopInf.Text);
   Qry_tmp2.FieldByName('dop_palnwork').asString:=trim(mem_dopplalwork.Text);
  Qry_tmp2.Post;
  if Qry_tmp2.UpdatesPending then
    begin
     Qry_tmp2.ApplyUpdates;
     Qry_tmp2.CommitUpdates;
    end;
  Qry_tmp2.Close;
 }
end;


procedure TFormNarad.Mm_dopinfChange(Sender: TObject);
begin
 MM_dopinf.OnChange:=nil;
    if isSel then
       isSel:=false
    else
       ChangInEdit(TCustomEdit(mm_dopinf),100);
 MM_dopinf.OnChange:=Mm_dopinfChange;
 SwSave(true);
end;

procedure TFormNarad.Mm_dopinfExit(Sender: TObject);
begin
 InsertInSL(MM_DopInf.Lines[MM_DopInf.Lines.Count-1],SL_DopInf,100);
end;

procedure TFormNarad.Mm_dopinfKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
      if (Sender.ClassName='TEdit') or (Sender.ClassName='TMemo') then
        begin
          if (Key = VK_ESCAPE) then
           begin
            AutoVvodOff(TCustomEdit(Sender));
           end
          else if (Key = VK_DELETE) then
           begin
            TCustomEdit(Sender).ClearSelection;
           end
          else if (Sender.ClassName='TMemo') and
                  (TCustomEdit(Sender).SelLength>0) then
            isSel:=true;
        end;
end;

procedure TFormNarad.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
  vk_F2:begin
    FormMain.DictNotHide.checked:=true;
    SetFilterDelete(Qry_brig,false);

    SetFilterDelete(Qry_brig3,false);
//    SetFilterDelete(Qry_runw,false);
    NarUpdate(0)
  end;
  end;
end;

procedure TFormNarad.DBL_runwKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    SelectNext(Sender as TWinControl, True, True );
    Key := #0;
  end;
end;

procedure TFormNarad.Translate;
begin
  inherited;
  Caption:=TrLangMSG(msgWent);
  Label14.Caption:=TrLangMSG(msgPlanTime);
  Label11.Caption:=TrLangMSG(msgBegin)+' '+Ansilowercase(TrLangMSG(msgWorks));
  Label13.Caption:=TrLangMSG(msgEnd)+' '+Ansilowercase(TrLangMSG(msgWorks));
//  Label1.Caption:=TrLangMSG(msgDoWorkOne);
  Label8.Caption:=TrLangMSG(msgDopInfoDoWork);
  //BB_obor.Caption:=TrLangMSG(msgJobsAndMat);
  BB_Add.Caption:=TrLangMSG(msgAdd);
  BB_del.Caption:=TrLangMSG(msgDelete);
  BB_Save.Caption:=TrLangMSG(msgSave);
  BB_Exit.Caption:='&'+TrLangMSG(msgExit);
  BB_zadv.Caption:=TrLangMSG(msgZadvs);
  BB_Ras.Caption:=TrLangMSG(msgDigWorks);
  Label7.Caption:=TrLangMSG(msgNUMBERT);
  Label9.Caption:=TrLangMSG(msgNUMTEAM);
  lbl_DopInfoPlanWork.Caption:=TrLangMSG(msgDopInfoPlanWork);
  BB_Works.Caption:=TrLangMSG(msgJobsAndMat);
  btn_mexan.Caption:=TrLangMSG(msgMechan);
  BB_obor.Caption:=TrLangMSG(msgEquip);
  but_planWorjs.Caption:=TrLangMSG(msjPlanJobs);
  btn_PlanObor.Caption:=TrLangMSG(msgPlanmechan);
end;

procedure TFormNarad.BitBtn1Click(Sender: TObject);
begin
  if Qry_narad['ID']=null then
  begin
    MessageDlg(TrLangMSG(msgNeedSaveNar),mtWarning, [mbOk], 0);
//    ShowMessage('Сохраните этап!!!');
    exit;
  end;
  if Qry_brig['ID']=null then
  begin
    //ShowMessage('Выберете бригадира!!!');
      MessageDlg(TrLangMSG(msgNeedbrig),mtWarning, [mbOk], 0);
    DBL_brig.SetFocus;
    exit;
  end;
  // naradMode =0 - закрытый наряд; naradMode=1 - открытый наряд
  fmBrig:=TfmBrig.fCreate(nil,1,NrZajvCod,Qry_narad['ID'],Qry_brig['ID'],naradMode);
  fmBrig.ShowModal;
  fmBrig.Free;

end;

procedure TFormNarad.DE_outChange(Sender: TObject);
begin
  inherited;
  if DE_out.date=0 then
  begin
    Label5.Visible:=False;
    Lb_DisOut.Visible:=False;
  end
  else
  begin
    Label5.Visible:=true;
    Lb_DisOut.Visible:=true;
  end;

  DBL_runwChange(sender);
end;

procedure TFormNarad.DE_inButtonClick(Sender: TObject);
begin
  if (Sender is TDateEdit) then
    begin
      if (Sender as TDateEdit).Text='  .  .    ' then (Sender as TDateEdit).Date:=DE_Dep.Date;
    end;
  inherited;
end;

procedure TFormNarad.BB_WorksClick(Sender: TObject);
var
  _WrkFrm: Tfrm_Work;
  _ChoiseFrm: TOborChoiseForm;
    _WorkContainer: Tdm_WorkContainer;
  _ID_ObjObor: integer;
  _IsObjectZav: boolean;
begin

  _ID_ObjObor := -1 ;
  _IsObjectZav := ( FormZav is TFormZavObj );
  if _IsObjectZav then
   begin
   //создание и вызов формы выбора оборудования для текущего объекта
     _ChoiseFrm := TOborChoiseForm.Create( nil );
     _ChoiseFrm.IDZAV := NrZajvCod;
     if ( _ChoiseFrm.ShowModal = mrOk ) and ( _ChoiseFrm.WithObor ) then
         _ID_ObjObor := _ChoiseFrm.IdObjObor;
   end;

  _WorkContainer := Tdm_WorkContainer.Create( nil );
  _WrkFrm := Tfrm_Work.Create( nil, _WorkContainer );
  try
    _WorkContainer.StartTran;
    try
      _WorkContainer.ZavID := NrZajvCod;
      _WorkContainer.NarID := Qry_narad.FieldByName( 'ID' ).AsInteger;
      _WorkContainer.Work.WorkDate := Qry_narad.FieldByName( 'dt_in' ).AsDateTime;
      _WorkContainer.Work.MestTypeID := F_MestTypeID;

      _WorkContainer.Work.IsCanAddRaskop := ( not FormZav.isClosed ) and
        not( _IsObjectZav ) and ( rsRASK in RightsSet );

      _WorkContainer.IsObjZav :=  _IsObjectZav ;   // используется только для объектов
      _WorkContainer.IdObjObor := _ID_ObjObor;
      if _IsObjectZav then _WrkFrm.l_ObjOborName.Caption := _ChoiseFrm.OborName
            else _WrkFrm.l_ObjOborName.Caption := '';

      _WorkContainer.Work.Raskop.DefaultAdres := F_DefaultAdres;
      _WorkContainer.Work.Raskop.DefaultActiveRaskopID := F_DefaultActiveRaskopID;
      _WorkContainer.IsReadOnly := not( rsNARAD in RightsSet );

      _WorkContainer.OpenDset;
      _WrkFrm.ShowModal;

      _WorkContainer.CommitTran;
    except
      on E: Exception do
      begin
        _WorkContainer.RollbackTran;
        E.Message := E.Message + '(Tdm_WorkContainer)';
        raise;
      end;
    end;
  finally
    _WorkContainer.Free;
    _WrkFrm.Free;
  end;
end;


procedure TFormNarad.btn_PlanOborClick(Sender: TObject);
var
 Obor :Tfrm_PlanObor;
begin
  inherited;
 ButVis(FormNarad,false);
     Obor:=Tfrm_PlanObor.PlanOborCreate(Self,NrZajvCod, Qry_narad['ID'],NaradMode,F_ObjectID
     );
     visible:=false;
     Obor.ShowModal;
     visible:=true;
     ButVis(FormNarad,true);
     bb_zadv.Visible:=false;
     bb_ras.Visible:=false;
{    end
  else
    MessageDlg('У заявки не определено место повреждения !', mtError,
      [mbOk], 0);}

  //uo Пропадает список???
  Qry_brig3.close; Qry_brig3.open;
end;

procedure TFormNarad.btn_mexanClick(Sender: TObject);
var frmObor:Tfrm_OborIB;
begin
  inherited;
  if Qry_narad['ID']>0 then
  begin
    try
      ButVis(FormNarad,false);
      frmObor:=Tfrm_OborIB.Create(Self,NrZajvCod, Qry_narad['ID'],false);
      frmObor.ShowModal;
    finally
      frmObor.Free;
      ButVis(FormNarad,true);
    end;
  end;


end;

procedure TFormNarad.but_planWorjsClick(Sender: TObject);
var
  _WrkFrm: Tfrm_Work;
  _ChoiseFrm: TOborChoiseForm;
    _WorkContainer: Tdm_WorkContainer;
  _ID_ObjObor: integer;
  _IsObjectZav: boolean;
begin
  inherited;
_ID_ObjObor := -1 ;
  _IsObjectZav := ( FormZav is TFormZavObj );
  if _IsObjectZav then
   begin
   //создание и вызов формы выбора оборудования для текущего объекта
     _ChoiseFrm := TOborChoiseForm.Create( nil );
     _ChoiseFrm.IDZAV := NrZajvCod;
     if ( _ChoiseFrm.ShowModal = mrOk ) and ( _ChoiseFrm.WithObor ) then
         _ID_ObjObor := _ChoiseFrm.IdObjObor;
   end;

  _WorkContainer := Tdm_WorkContainerPlan.Create( nil );
  _WrkFrm := Tfrm_Work.Create( nil, _WorkContainer );
  _WrkFrm.pCaption:=TrLangMSG(msjPlanJobs)+'/'+TrLangMSG(msgMaterMany);
  try
    _WorkContainer.StartTran;
    try
      _WorkContainer.ZavID := NrZajvCod;
      _WorkContainer.NarID := Qry_narad.FieldByName( 'ID' ).AsInteger;
      _WorkContainer.Work.WorkDate := Qry_narad.FieldByName( 'dt_in' ).AsDateTime;
      _WorkContainer.Work.MestTypeID := F_MestTypeID;

      _WorkContainer.Work.IsCanAddRaskop := ( not FormZav.isClosed ) and
        not( _IsObjectZav ) and ( rsRASK in RightsSet );

      _WorkContainer.IsObjZav :=  _IsObjectZav ;   // используется только для объектов
      _WorkContainer.IdObjObor := _ID_ObjObor;
      if _IsObjectZav then _WrkFrm.l_ObjOborName.Caption := _ChoiseFrm.OborName
            else _WrkFrm.l_ObjOborName.Caption := '';

     // _WorkContainer.Work.Raskop.DefaultAdres := F_DefaultAdres;
     // _WorkContainer.Work.Raskop.DefaultActiveRaskopID := F_DefaultActiveRaskopID;
      _WorkContainer.IsReadOnly := not( rsNARAD in RightsSet );

      _WorkContainer.OpenDset;
      _WrkFrm.ShowModal;

      _WorkContainer.CommitTran;
    except
      on E: Exception do
      begin
        _WorkContainer.RollbackTran;
        E.Message := E.Message + '(Tdm_WorkContainer)';
        raise;
      end;
    end;
  finally
    _WorkContainer.Free;
    _WrkFrm.Free;
  end;

end;

procedure TFormNarad.EnableBottms(enable: boolean);
begin
BB_Works.Enabled:=enable;
btn_mexan.Enabled:=enable;
BitBtn1.Enabled:=enable;
BB_obor.Enabled:=enable;
but_planWorjs.Enabled:=enable;
btn_PlanObor.Enabled:=enable;
end;

function TFormNarad.SetCloseZavdate: TDateTime;
begin
if narTb='narad' then
begin
  MyOpenSQL(Qry_Tmp,'select dt_out from zavjav where id='+IntToStr(NrZajvCod));
  result:=Qry_tmp.fieldByName('dt_out').AsDateTime;
end
else
 result:=0;

end;

procedure TFormNarad.SetReadOneRow(read: boolean);
begin
   DBL_BrIg.Enabled:=not read;
      DBL_BrIg3.Enabled:=not read;
//      DBL_runw.Enabled:=false;

      mm_dopinf.Enabled:=not read;
      DE_dep.Enabled:=not read;
      DE_in.Enabled:=not read;
      DE_out.Enabled:=not read;
      TE_dep.Enabled:=not read;
      TE_in.Enabled:=not read;
      Te_out.Enabled:=not read;
      sp_intime_dep.Enabled:=not read;
      sp_intime_in.Enabled:=not read;
      sp_intime_out.Enabled:=not read;

      BB_Del.Enabled:=not read;
      edNUMBERT.enabled:=not read;
      edNUMTEAM.enabled:=not read;
end;

procedure TFormNarad.bb_planWorkMatersClick(Sender: TObject);
begin


end;

{ Старая кнопка работы материалы удалим
_WrkFrm: Tfrm_Work;
  _ChoiseFrm: TOborChoiseForm;
    _WorkContainer: Tdm_WorkContainer;
  _ID_ObjObor: integer;
  _IsObjectZav: boolean;}

 { _ID_ObjObor := -1 ;
  _IsObjectZav := ( FormZav is TFormZavObj );
  if _IsObjectZav then
   begin
   //создание и вызов формы выбора оборудования для текущего объекта
     _ChoiseFrm := TOborChoiseForm.Create( nil );
     _ChoiseFrm.IDZAV := NrZajvCod;
     if ( _ChoiseFrm.ShowModal = mrOk ) and ( _ChoiseFrm.WithObor ) then
         _ID_ObjObor := _ChoiseFrm.IdObjObor;
   end;

  _WorkContainer := Tdm_WorkContainerPlan.Create( nil );
  _WrkFrm := Tfrm_Work.Create( nil, _WorkContainer );
  try
    _WorkContainer.StartTran;
    try
      _WorkContainer.ZavID := NrZajvCod;
      _WorkContainer.NarID := Qry_narad.FieldByName( 'ID' ).AsInteger;
      _WorkContainer.Work.WorkDate := Qry_narad.FieldByName( 'dt_in' ).AsDateTime;
      _WorkContainer.Work.MestTypeID := F_MestTypeID;

      _WorkContainer.Work.IsCanAddRaskop := ( not FormZav.isClosed ) and
        not( _IsObjectZav ) and ( rsRASK in RightsSet );

      _WorkContainer.IsObjZav :=  _IsObjectZav ;   // используется только для объектов
      _WorkContainer.IdObjObor := _ID_ObjObor;
      if _IsObjectZav then _WrkFrm.l_ObjOborName.Caption := _ChoiseFrm.OborName
            else _WrkFrm.l_ObjOborName.Caption := '';

     // _WorkContainer.Work.Raskop.DefaultAdres := F_DefaultAdres;
     // _WorkContainer.Work.Raskop.DefaultActiveRaskopID := F_DefaultActiveRaskopID;
      _WorkContainer.IsReadOnly := not( rsNARAD in RightsSet );

      _WorkContainer.OpenDset;
      _WrkFrm.ShowModal;

      _WorkContainer.CommitTran;
    except
      on E: Exception do
      begin
        _WorkContainer.RollbackTran;
        E.Message := E.Message + '(Tdm_WorkContainer)';
        raise;
      end;
    end;
  finally
    _WorkContainer.Free;
    _WrkFrm.Free;
  end;  }


procedure TFormNarad.sp_intime_depClick(Sender: TObject);
var dt:TDateTime;
begin
  inherited;
  dt:=myNow;
  DE_dep.Date:=dt;
  TE_dep.Time:=strtodatetime(datetimetostr(dt,'dd.mm.yyyy hh:mm:00'));
end;

procedure TFormNarad.sp_intime_inClick(Sender: TObject);
var dt:TDateTime;
begin
  inherited;
  dt:=myNow;
  DE_in.Date:=dt;
  TE_in.Time:=strtodatetime(datetimetostr(dt,'dd.mm.yyyy hh:mm:00'));
end;

procedure TFormNarad.sp_intime_outClick(Sender: TObject);
var dt:TDateTime;
begin
  inherited;
  dt:=myNow;
  DE_out.Date:=dt;
  TE_out.Time:=strtodatetime(datetimetostr(dt,'dd.mm.yyyy hh:mm:00'));
end;

procedure TFormNarad.mem_dopplalworkChange(Sender: TObject);
begin
  inherited;
  mem_dopplalwork.OnChange:=nil;
    if isSel then
       isSel:=false
    else
       ChangInEdit(TCustomEdit(mem_dopplalwork),100);
 mem_dopplalwork.OnChange:=mem_dopplalworkChange;
 SwSave(true);
end;

end.
