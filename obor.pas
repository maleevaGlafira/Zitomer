unit obor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db, Grids, DBGrids, StdCtrls, Buttons, {DualList, }FRMLANG,
  DBClient, SimpleDS, ExtCtrls, ComCtrls, RxLookup,
  cntsLANG, IBCustomDataSet, ServiceFuncUnit, DualList;

type
  TFormObor = class(TFormLang)
    Panel1: TPanel;
    DBGr_Obor: TDBGrid;
    Qry_tmp: TQuery;
    DLD_vib: TDualListDialog;
    Timer: TTimer;
    Obors_q: TQuery;
    Obors_qID: TIntegerField;
    Obors_qID_ZAV: TIntegerField;
    Obors_qID_NAR: TIntegerField;
    Obors_qID_OBOR: TIntegerField;
    Obors_qList_Obor: TStringField;
    Obors_upd: TUpdateSQL;
    Obors_sur: TDataSource;
    StatusBar1: TStatusBar;
    BB_Insert: TBitBtn;
    BB_Delete: TBitBtn;
    BB_Save: TBitBtn;
    BB_Up: TBitBtn;
    BB_DLD: TBitBtn;
    BB_Close: TBitBtn;
    Bevel1: TBevel;
    DBGr_Planobor: TDBGrid;
    Planobors_sur: TDataSource;
    Planobors_q: TQuery;
    Planobors_upd: TUpdateSQL;
    Planobors_qID: TIntegerField;
    Planobors_qID_ZAV: TIntegerField;
    Planobors_qID_NAR: TIntegerField;
    Planobors_qID_OBOR: TIntegerField;
    Planobors_qList_OBOR: TStringField;
    dbg_Instrum: TDBGrid;
    Instrum_sur: TDataSource;
    Instrum_q: TQuery;
    instrum_upd: TUpdateSQL;
    Instrum_qID: TIntegerField;
    Instrum_qID_ZAV: TIntegerField;
    Instrum_qID_NAR: TIntegerField;
    Instrum_qID_INSTRUM: TIntegerField;
    Instrum_qlp_INSTRUM: TStringField;
    dbg_ObjObor: TDBGrid;
    objobor_q: TQuery;
    objobor_upd: TUpdateSQL;
    objobor_sur: TDataSource;
    objobor_qID: TIntegerField;
    objobor_qID_ZAV: TIntegerField;
    objobor_qID_NAR: TIntegerField;
    objobor_qID_OBJOBOR: TIntegerField;
    s_objobor_q: TQuery;
    s_objobor_qid: TIntegerField;
    s_objobor_qid_object: TIntegerField;
    s_objobor_qname_r: TStringField;
    s_objobor_qdel: TStringField;
    objobor_qlp_OBJOBOR: TStringField;
    s_objobor_sur: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGr_OborEnter(Sender: TObject);
    procedure BB_InsertClick(Sender: TObject);
    procedure BB_DeleteClick(Sender: TObject);
    procedure __DS_oborUpdateData(Sender: TObject);
    procedure __DS_planoborUpdateData(Sender: TObject);
    procedure __DS_instrumUpdateData(Sender: TObject);
    procedure __DS_objoborUpdateData(Sender: TObject);
    procedure BB_SaveClick(Sender: TObject);
    procedure DBGr_OborExit(Sender: TObject);
    procedure BB_DLDClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure BB_UpClick(Sender: TObject);
    procedure Qr_BeforePost(DataSet: TDataSet);
    procedure BB_CloseClick(Sender: TObject);
    procedure DBGr_PlanoborEnter(Sender: TObject);
    procedure DBGr_PlanoborExit(Sender: TObject);
    procedure dbg_InstrumEnter(Sender: TObject);
    procedure dbg_InstrumExit(Sender: TObject);
    procedure dbg_ObjOborEnter(Sender: TObject);
    procedure dbg_ObjOborExit(Sender: TObject);
  private
    TekBase:integer;
    F_ObjectID: integer;
  public
    { Public declarations }
    _isClosed:boolean;
    constructor OborCreate(AOwner: TComponent;tZav,tNar,Mode:integer; ObjID: integer = -1);
    procedure RefreshBase(Qry_Sp:TQuery);
    procedure Vib_DLD(Qry_sour,Qry_dest:TQuery;
                            SourId,DestId,tit,cap_l1,cap_l2:string);

    procedure Translate;override;
  end;

var
  FormObor: TFormObor;
  ObZav,ObNar:integer;

implementation
 uses main, zav, pr_obor, strtool, datam, avartype;
{$R *.DFM}


constructor TFormObor.OborCreate(AOwner: TComponent;tZav,tNar,Mode:integer; ObjID: integer = -1);
begin
  ObZav:=tZav;
  ObNar:=tNar;
  F_ObjectID := ObjID;
  _isClosed:=false;
  if Mode=0 then
    begin
       _isClosed:=true;
    end;
  inherited Create(AOwner);
end;

procedure TFormObor.FormCreate(Sender: TObject);
begin
  if FormZav.FltDel and not FormMain.DictNotHide.checked
  then begin
    SetFilterDelete( DM1.S_Obor_q, true);
    SetFilterDelete( DM1.S_PlanObor_q, true);
    SetFilterDelete( DM1.s_instrum_q, true);
  end;

 FormObor:=Self;
 UstColors(Self);

 TekBase:=0;

 dm1.S_Obor_q.close; dm1.S_Obor_q.open;
 Obors_q.close;
 Obors_q.ParamByName('idZav').asInteger:=obZav;
 Obors_q.ParamByName('idNar').asInteger:=obNar;
 Obors_q.Open;

 dm1.S_PlanObor_q.close; dm1.S_PlanObor_q.open;
 Planobors_q.Close;
 Planobors_q.ParamByName('idZav').asInteger:=obZav;
 Planobors_q.ParamByName('idNar').asInteger:=obNar;
 Planobors_q.Open;

 dm1.s_instrum_q.Close; dm1.s_instrum_q.Open;
 Instrum_q.Close;
 Instrum_q.ParamByName('idZav').asInteger:=obZav;
 Instrum_q.ParamByName('idNar').asInteger:=obNar;
 Instrum_q.Open;


 if F_ObjectID > 0 then
 begin
   s_objobor_q.Close;
   s_objobor_q.ParamByName( 'pObjectID' ).AsInteger := F_ObjectID;
   s_objobor_q.Open;

   Objobor_q.Close;
   Objobor_q.ParamByName('idZav').asInteger:=obZav;
   Objobor_q.ParamByName('idNar').asInteger:=obNar;
   Objobor_q.Open;

   dbg_ObjObor.Visible := true;
 end;

 DBGr_Obor.ReadOnly := not( rsNARAD in RightsSet ){* or isClosed};
 DBGr_Planobor.ReadOnly := not( rsNARAD in RightsSet ){* or isClosed};
 dbg_Instrum.ReadOnly := not( rsNARAD in RightsSet ){* or isClosed};
 dbg_Objobor.ReadOnly := not( rsNARAD in RightsSet ){* or isClosed};

 BB_Insert.Enabled:=not (not(rsNARAD in RightsSet) {* or isClosed});
 BB_Delete.Enabled:=not (not(rsNARAD in RightsSet){* or isClosed});
 BB_Save.Enabled:=not (not(rsNARAD in RightsSet) {* or isClosed});
 BB_DLD.Enabled:=not (not(rsNARAD in RightsSet) {* or isClosed});
end;

procedure TFormObor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Obors_q.Close;
 Planobors_q.Close;
 Instrum_q.Close;
 Objobor_q.Close;

 s_objobor_q.Close;

 Action:=caFree;

  if FormZav.FltDel and not FormMain.DictNotHide.checked
  then begin
    SetFilterDelete( DM1.S_Obor_q, false);
    SetFilterDelete( DM1.S_PlanObor_q, false);
    SetFilterDelete( DM1.S_Instrum_q, false);
  end;
end;

procedure TFormObor.DBGr_OborEnter(Sender: TObject);
begin
  TekBase:=0;
//  GrB_Upr.Caption:=' Механизмы ';
 StatusBar1.Panels[0].Text:=' '+TrLangMSG(msgMechan)+' '; // ds
 {30.09.2004}
    BB_Insert.Enabled:=not (not(rsNARAD in RightsSet) {* or isClosed});
    BB_Delete.Enabled:=not (not(rsNARAD in RightsSet) {* or isClosed});
    BB_Save.Enabled:=not (not(rsNARAD in RightsSet) {* or isClosed});
    BB_DLD.Enabled:=not (not(rsNARAD in RightsSet) {* or isClosed});
    BB_Up.Enabled:=not (not(rsNARAD in RightsSet) {* or isClosed});
 {/30.09.2004}
end;


procedure TFormObor.BB_InsertClick(Sender: TObject);                         
begin
  if TekBase=0 then
    begin
     {Qry_obor}Obors_q.Insert;
     {Qry_obor}Obors_q.Post;
     {Qry_obor}Obors_q.CommitUpdates;
     RefreshBase({Qry_obor}Obors_q);
    end
  else if TekBase=3 then
    begin
     Planobors_q.Insert;
     Planobors_q.Post;
     Planobors_q.CommitUpdates;
     RefreshBase(Planobors_q);
    end
  else if TekBase=4 then
    begin
     Instrum_q.Insert;
     Instrum_q.Post;
     Instrum_q.CommitUpdates;
     RefreshBase(Instrum_q);
    end
  else if TekBase=5 then
    begin
     Objobor_q.Insert;
     Objobor_q.Post;
     Objobor_q.CommitUpdates;
     RefreshBase(Objobor_q);
    end
end;

procedure TFormObor.RefreshBase(Qry_Sp:TQuery);
var old_id:integer;
    tt_str,nm:string;

begin
  old_id:=Qry_SP.FieldByName('ID').asInteger;
  Qry_Sp.Close;
  if old_id=0 then
    begin
       nm:='';
       tt_str:='~~~~~~';
       old_id:=1;
       while tt_str<>'' do
         begin
           if AnsiUpperCase(tt_str) = 'FROM' then
             nm:=ExtractWords_(old_id,0,Qry_SP.SQL[0]);

           tt_str:=ExtractWords_(old_id,0,Qry_SP.SQL[0]);
           inc(old_id);
         end;
       if nm<>'' then
         begin
          MyOpenSQL(Qry_tmp,'select max(id) mm from '+nm); //+BaseName);
          old_id:=Qry_tmp.FieldByName('MM').asInteger;
          Qry_tmp.Close;
         end;
    end;
  Qry_Sp.Open;
  Qry_Sp.Locate('ID',old_id,[]);
end;

procedure TFormObor.BB_DeleteClick(Sender: TObject);
begin
   if MessageDlg(TrLangMSG(msgDeleteRecord),
                 mtConfirmation, [mbYes, mbNo], 0) = mrYes then
     begin
       if TekBase=0 then
         begin
           {Qry_Obor}Obors_q.Delete;
           {Qry_Obor}Obors_q.CommitUpdates;
           RefreshBase({Qry_Obor}Obors_q);
         end
       else if TekBase=3 then
         begin
           Planobors_q.Delete;
           Planobors_q.CommitUpdates;
           RefreshBase(Planobors_q);
         end
       else if TekBase=4 then
         begin
           Instrum_q.Delete;
           Instrum_q.CommitUpdates;
           RefreshBase(Instrum_q);
         end
       else if TekBase=5 then
         begin
           Objobor_q.Delete;
           Objobor_q.CommitUpdates;
           RefreshBase(Objobor_q);
         end;
     end;
end;

procedure TFormObor.__DS_oborUpdateData(Sender: TObject);
var sInd:integer;
begin
 {DS_obor}Obors_sur.OnUpdateData:=NIL;
 if {Qry_obor}Obors_q.Modified then
  {Qry_obor}Obors_q.Post;
 if {Qry_obor}Obors_q.UpdatesPending then
  begin
   {Qry_obor}Obors_q.ApplyUpdates;
   {Qry_obor}Obors_q.CommitUpdates;
   sInd:=DBGr_obor.SelectedIndex;
   RefreshBase({Qry_Obor}Obors_q);
   DBGr_obor.SelectedIndex:=sInd;
  end;
 {DS_obor}Obors_sur.OnUpdateData:=__DS_oborUpdateData;
end;

procedure TFormObor.BB_SaveClick(Sender: TObject);
begin
 if TekBase=0 then
   __DS_oborUpdateData(Self)
 else if TekBase=3 then
   __DS_planoborUpdateData(Self)
 else if TekBase=4 then
   __DS_instrumUpdateData(Self)
 else if TekBase=5 then
   __DS_objoborUpdateData(Self)
end;

procedure TFormObor.DBGr_OborExit(Sender: TObject);
begin
  BB_SaveClick(self);
end;

procedure TFormObor.BB_DLDClick(Sender: TObject);
var
  PrOb:TFormPrOb;
begin
  PrOb:=TFormPrOb.Create(Self);
  PrOb.IsShowObjobor := ( F_ObjectID > 0 );
  PrOb.ShowModal;
end;

procedure TFormObor.Vib_DLD(Qry_sour,Qry_dest:TQuery;
                            SourId,DestId,tit,cap_l1,cap_l2:string);
var n_ob,i:integer;
begin
   Qry_sour.First;
   DLD_vib.List1.Clear;
   DLD_vib.List2.Clear;
   while not Qry_sour.EOF do
     begin
        if Qry_dest.Locate(DestId,Qry_sour.FieldByName(SourID).AsInteger,[]) then
          begin
            DLD_vib.List2.AddObject(Qry_sour.FieldByName('NAME_R').AsString,
                 TObject(Qry_sour.FieldByName(SourId).AsInteger));
          end
        else
          begin
            DLD_vib.List1.AddObject(Qry_sour.FieldByName('NAME_R').AsString,
                 TObject(Qry_sour.FieldByName(SourId).AsInteger));
          end;
        Qry_sour.Next;
     end;

   MyOpenSQL(Qry_tmp,'select w.id,w.name_r||" "||w.ed_izm||"-"||p.name_r'+
             ' name_r from s_work w,s_place p where w.id>0 and w.ftype=p.id');
   Qry_dest.First;
   while not Qry_dest.EOF do
     begin
        if DLD_vib.List2.IndexOfObject(TObject(Qry_dest.
                           FieldByName(DestId).AsInteger))=-1 then
          begin
           if Qry_tmp.Locate(SourId,Qry_dest.FieldByName(DestID).AsInteger,[]) then
             begin
                DLD_vib.List2.AddObject(Qry_tmp.FieldByName('NAME_R').AsString,
                   TObject(Qry_tmp.FieldByName(SourId).AsInteger));
             end;
          end;
        Qry_dest.Next;
     end;
   Qry_tmp.Close;

   if DLD_vib.Execute then
   begin
      Qry_dest.First;
      while not Qry_dest.EOF do
        begin
          n_ob:=DLD_vib.List2.IndexOfObject(TObject(Qry_dest.FieldByName(DestId).AsInteger));
          if n_ob=-1 then     //ДОБАВИТЬ проверку !!!
             Qry_dest.Delete
          else
             begin
               DLD_vib.List2.Delete(n_ob);
               Qry_dest.Next;
             end;
        end;
      if DLD_vib.List2.Count>0 then
        begin
          for i:=0 to DLD_vib.List2.Count-1 do
            begin
               Qry_dest.Insert;
               Qry_dest.FieldByName(DestId).asInteger:=
                  integer(DLD_vib.List2.Objects[i]);
               Qry_dest.Post;
            end;

        end;
   end;
end;

procedure TFormObor.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   case key of
    VK_DELETE:if (not (not(rsNARAD in RightsSet) {* or isClosed})) then
      BB_DeleteClick(Self);
{   else if key=VK_Insert then
      BB_InsertClick(Self);}
    vk_F2:begin
      FormMain.DictNotHide.checked:=true;
      SetFilterDelete(DM1.S_Obor_q, false);
      SetFilterDelete(DM1.S_PlanObor_q, false);
      SetFilterDelete(DM1.S_Instrum_q, false);
      FormCreate(nil)
    end;
  end;
end;

procedure TFormObor.FormShow(Sender: TObject);
begin
 Timer.Enabled:=true;
 dbg_InstrumEnter(dbg_Instrum);
end;

procedure TFormObor.TimerTimer(Sender: TObject);
begin
{
 Timer.Enabled:=false;
 if BB_DLD.Enabled and (Works_q.EOF or Maters_q.EOF) then
    BB_DLDClick(Self);
}
end;

procedure TFormObor.BB_UpClick(Sender: TObject);
var tek_id,up_id:integer;
    tek_work,tek_diam,tek_place:string;
    up_work,up_diam,up_place:string;
    tek_kol,up_kol:string;

begin
  up_id:=-1;
  if TekBase=0 then
    begin
     Tek_id:={Qry_obor}Obors_q.FieldByName('ID').asInteger;
     Tek_work:=inttostr(strtointdef({Qry_obor}Obors_q.FieldByName('ID_OBOR').asString,-1));

     {Qry_obor}Obors_q.Prior;
     if not {Qry_obor}Obors_q.Bof then
       begin
         Up_id:={Qry_work ???}Obors_q.FieldByName('ID').asInteger;
         up_work:=inttostr(strtointdef({Qry_obor}Obors_q.FieldByName('ID_OBOR').asString,-1));
       end;
     if up_id>0 then
       begin
         MyExecSQL(Qry_tmp,'update obors set id_obor='+up_work+
                            ' where id='+inttostr(tek_id));
         MyExecSQL(Qry_tmp,'update obors set id_obor='+tek_work+
                            ' where id='+inttostr(up_id));
         MyExecSQL(Qry_tmp,'COMMIT');
       end;
     RefreshBase({Qry_obor}Obors_q);
    end
  else if TekBase=3 then
    begin
     Tek_id:=Planobors_q.FieldByName('ID').asInteger;
     Tek_work:=inttostr(strtointdef(Planobors_q.FieldByName('ID_OBOR').asString,-1));

     Planobors_q.Prior;
     if not Planobors_q.Bof then
       begin
         Up_id:=Planobors_q.FieldByName('ID').asInteger;
         up_work:=inttostr(strtointdef(Planobors_q.FieldByName('ID_OBOR').asString,-1));
       end;
     if up_id>0 then
       begin
         MyExecSQL(Qry_tmp,'update planobors set id_obor='+up_work+
                            ' where id='+inttostr(tek_id));
         MyExecSQL(Qry_tmp,'update planobors set id_obor='+tek_work+
                            ' where id='+inttostr(up_id));
         MyExecSQL(Qry_tmp,'COMMIT');
       end;
     RefreshBase(Planobors_q);
    end
  else if TekBase=4 then
    begin
     Tek_id:=Instrum_q.FieldByName('ID').asInteger;
     Tek_work:=inttostr(strtointdef(Instrum_q.FieldByName('ID_Instrum').asString,-1));

     Instrum_q.Prior;
     if not Instrum_q.Bof then
       begin
         Up_id:=Instrum_q.FieldByName('ID').asInteger;
         up_work:=inttostr(strtointdef(Instrum_q.FieldByName('ID_Instrum').asString,-1));
       end;
     if up_id>0 then
       begin
         MyExecSQL(Qry_tmp,'update Instrum set id_Instrum='+up_work+
                            ' where id='+inttostr(tek_id));
         MyExecSQL(Qry_tmp,'update Instrum set id_Instrum='+tek_work+
                            ' where id='+inttostr(up_id));
         MyExecSQL(Qry_tmp,'COMMIT');
       end;
     RefreshBase(Instrum_q);
    end
  else if TekBase=5 then
    begin
     Tek_id:=Objobor_q.FieldByName('ID').asInteger;
     Tek_work:=inttostr(strtointdef(Objobor_q.FieldByName('ID_Objobor').asString,-1));

     Objobor_q.Prior;
     if not Objobor_q.Bof then
       begin
         Up_id:=Objobor_q.FieldByName('ID').asInteger;
         up_work:=inttostr(strtointdef(Objobor_q.FieldByName('ID_Objobor').asString,-1));
       end;
     if up_id>0 then
       begin
         MyExecSQL(Qry_tmp,'update Objobor set id_Objobor='+up_work+
                            ' where id='+inttostr(tek_id));
         MyExecSQL(Qry_tmp,'update Objobor set id_Objobor='+tek_work+
                            ' where id='+inttostr(up_id));
         MyExecSQL(Qry_tmp,'COMMIT');
       end;
     RefreshBase(Objobor_q);
    end
end;

//*******************************************************************
procedure TFormObor.Qr_BeforePost(DataSet: TDataSet);
begin
 if DataSet.FieldByName('id_zav').asString = ''
    then DataSet.FieldByName('id_zav').asInteger:=ObZav;
 if DataSet.FieldByName('id_nar').asString = ''
    then DataSet.FieldByName('id_nar').asInteger:=ObNar;
end;


//*******************************************************************
procedure TFormObor.BB_CloseClick(Sender: TObject);
begin
 Close;
end;


//*******************************************************************
procedure TFormObor.Translate;
begin
  inherited;
  Caption:=TrLangMSG(msgEquip);
  BB_Insert.Caption:=TrLangMSG(msgInsert);
  BB_Delete.Caption:='&'+TrLangMSG(msgDelete);
  BB_Save.Caption:='&'+TrLangMSG(msgSave);
  BB_DLD.Caption:='&'+TrLangMSG(msgQuickAdd);
  BB_Close.Caption:='&'+TrLangMSG(msgExit);
  DLD_vib.OkBtnCaption:=TrLangMSG(msgSelect);
  DLD_vib.CancelBtnCaption:=TrLangMSG(msgCancel);

  DBGr_Obor.Columns[0].Title.Caption:=TrLangMSG(msgMechan);
  dbg_Instrum.Columns[0].Title.Caption:=TrLangMSG(msgTools);
  dbg_ObjObor.Columns[0].Title.Caption:=TrLangMSG(msgEquip);
  DBGr_Planobor.Columns[0].Title.Caption:=TrLangMSG(msgPlanmechan);

end;

procedure TFormObor.DBGr_PlanoborEnter(Sender: TObject);
begin
  TekBase:=3;
  StatusBar1.Panels[0].Text:=' '+TrLangMSG(msgPlanmechan)+' '; // ds
  BB_Insert.Enabled:=not (not(rsNARAD in RightsSet) {* or isClosed});
  BB_Delete.Enabled:=not (not(rsNARAD in RightsSet) {* or isClosed});
  BB_Save.Enabled:=not (not(rsNARAD in RightsSet) {* or isClosed});
  BB_DLD.Enabled:=not (not(rsNARAD in RightsSet) {* or isClosed});
  BB_Up.Enabled:=not (not(rsNARAD in RightsSet) {* or isClosed});
end;

procedure TFormObor.DBGr_PlanoborExit(Sender: TObject);
begin
  BB_SaveClick(self);
end;

procedure TFormObor.__DS_planoborUpdateData(Sender: TObject);
var sInd:integer;
begin
 Planobors_sur.OnUpdateData:=NIL;
 if Planobors_q.Modified then
  Planobors_q.Post;
 if Planobors_q.UpdatesPending then
  begin
   Planobors_q.ApplyUpdates;
   Planobors_q.CommitUpdates;
   sInd:=DBGr_planobor.SelectedIndex;
   RefreshBase(Planobors_q);
   DBGr_planobor.SelectedIndex:=sInd;
  end;
 Planobors_sur.OnUpdateData:=__DS_planoborUpdateData;
end;

procedure TFormObor.dbg_InstrumEnter(Sender: TObject);
begin
  TekBase:=4;
  StatusBar1.Panels[0].Text:=' '+TrLangMSG(msgTools)+' ';//' Инструменты '; // ds
  BB_Insert.Enabled:=not (not(rsNARAD in RightsSet) {* or isClosed});
  BB_Delete.Enabled:=not (not(rsNARAD in RightsSet) {* or isClosed});
  BB_Save.Enabled:=not (not(rsNARAD in RightsSet) {* or isClosed});
  BB_DLD.Enabled:=not (not(rsNARAD in RightsSet) {* or isClosed});
  BB_Up.Enabled:=not (not(rsNARAD in RightsSet) {* or isClosed});
end;

procedure TFormObor.dbg_InstrumExit(Sender: TObject);
begin
  BB_SaveClick(self);
end;

procedure TFormObor.__DS_instrumUpdateData(Sender: TObject);
var sInd:integer;
begin
 Instrum_sur.OnUpdateData:=NIL;
 if Instrum_q.Modified then
  Instrum_q.Post;
 if Instrum_q.UpdatesPending then
  begin
   Instrum_q.ApplyUpdates;
   Instrum_q.CommitUpdates;
   sInd:=dbg_Instrum.SelectedIndex;
   RefreshBase(Instrum_q);
   dbg_Instrum.SelectedIndex:=sInd;
  end;
 Instrum_sur.OnUpdateData:=__DS_InstrumUpdateData;
end;

procedure TFormObor.__DS_objoborUpdateData(Sender: TObject);
var sInd:integer;
begin
 Objobor_sur.OnUpdateData:=NIL;
 if Objobor_q.Modified then
  Objobor_q.Post;
 if Objobor_q.UpdatesPending then
  begin
   Objobor_q.ApplyUpdates;
   Objobor_q.CommitUpdates;
   sInd:=dbg_Objobor.SelectedIndex;
   RefreshBase(Objobor_q);
   dbg_Objobor.SelectedIndex:=sInd;
  end;
 Objobor_sur.OnUpdateData:=__DS_InstrumUpdateData;
end;

procedure TFormObor.dbg_ObjOborEnter(Sender: TObject);
begin
  TekBase:=5;
  StatusBar1.Panels[0].Text:=' '+TrLangMSG(msgEquip)+' ';//' Оборудование '; // ds
  BB_Insert.Enabled:=not (not(rsNARAD in RightsSet) {* or isClosed});
  BB_Delete.Enabled:=not (not(rsNARAD in RightsSet) {* or isClosed});
  BB_Save.Enabled:=not (not(rsNARAD in RightsSet) {* or isClosed});
  BB_DLD.Enabled:=not (not(rsNARAD in RightsSet) {* or isClosed});
  BB_Up.Enabled:=not (not(rsNARAD in RightsSet) {* or isClosed});
end;

procedure TFormObor.dbg_ObjOborExit(Sender: TObject);
begin
  BB_SaveClick(self);
end;

end.
