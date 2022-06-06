unit FormPlanObor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FRMLANG, cntsLANG, DB, DBTables, ExtCtrls, StdCtrls, Buttons,
  Grids, DBGrids;

type
  Tfrm_PlanObor = class(TFormLang)
    DBGr_Planobor: TDBGrid;
    BB_Insert: TBitBtn;
    BB_Delete: TBitBtn;
    BB_Save: TBitBtn;
    BB_Close: TBitBtn;
    Planobors_upd: TUpdateSQL;
    Planobors_q: TQuery;
    Planobors_qID: TIntegerField;
    Planobors_qID_ZAV: TIntegerField;
    Planobors_qID_NAR: TIntegerField;
    Planobors_qID_OBOR: TIntegerField;
    Planobors_qList_OBOR: TStringField;
    Planobors_sur: TDataSource;
    Qry_tmp: TQuery;
    Panel1: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure v(Sender: TObject; var Action: TCloseAction);
    procedure DBGr_PlanoborEnter(Sender: TObject);
    procedure BB_InsertClick(Sender: TObject);
    procedure BB_DeleteClick(Sender: TObject);
    procedure Planobors_surUpdateData(Sender: TObject);
    procedure BB_SaveClick(Sender: TObject);
    procedure DBGr_PlanoborExit(Sender: TObject);
    procedure Planobors_qBeforePost(DataSet: TDataSet);
    procedure BB_CloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    F_ObjectID :integer;
  public
    { Public declarations }
      _isClosed:boolean;
    constructor PlanOborCreate(AOwner: TComponent;tZav,tNar,Mode:integer; ObjID: integer = -1);
    procedure RefreshBase(Qry_Sp:TQuery);
     procedure Translate;override;

  end;

var
  frm_PlanObor: Tfrm_PlanObor;
   ObZav,ObNar:integer;

implementation
 uses main, zav, pr_obor, strtool, datam, avartype, obor,ServiceFuncUnit;
{$R *.dfm}

constructor Tfrm_PlanObor.PlanOborCreate(AOwner: TComponent;tZav,tNar,Mode:integer; ObjID: integer = -1);
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

procedure Tfrm_PlanObor.FormCreate(Sender: TObject);
begin
  inherited;
if FormZav.FltDel and not FormMain.DictNotHide.checked
  then begin

    SetFilterDelete( DM1.S_PlanObor_q, true);

  end;

 frm_PlanObor:=Self;
 UstColors(Self);

 dm1.S_PlanObor_q.close; dm1.S_PlanObor_q.open;
 Planobors_q.Close;
 Planobors_q.ParamByName('idZav').asInteger:=obZav;
 Planobors_q.ParamByName('idNar').asInteger:=obNar;
 Planobors_q.Open;

 DBGr_Planobor.ReadOnly := not( rsNARAD in RightsSet ){* or isClosed};

  BB_Insert.Enabled:=not (not(rsNARAD in RightsSet) {* or isClosed});
 BB_Delete.Enabled:=not (not(rsNARAD in RightsSet){* or isClosed});
 BB_Save.Enabled:=not (not(rsNARAD in RightsSet) {* or isClosed});

end;

procedure Tfrm_PlanObor.v(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
Planobors_q.Close;
 Action:=caFree;
 if FormZav.FltDel and not FormMain.DictNotHide.checked
  then
   SetFilterDelete( DM1.S_PlanObor_q, false);
end;

procedure Tfrm_PlanObor.DBGr_PlanoborEnter(Sender: TObject);
begin
  inherited;
    BB_Insert.Enabled:=not (not(rsNARAD in RightsSet) {* or isClosed});
    BB_Delete.Enabled:=not (not(rsNARAD in RightsSet) {* or isClosed});
    BB_Save.Enabled:=not (not(rsNARAD in RightsSet) {* or isClosed});


end;

procedure Tfrm_PlanObor.BB_InsertClick(Sender: TObject);
begin
  inherited;
  Planobors_q.Insert;
  Planobors_q.Post;
  Planobors_q.CommitUpdates;
  RefreshBase(Planobors_q);
end;


procedure Tfrm_PlanObor.RefreshBase(Qry_Sp:TQuery);
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

procedure Tfrm_PlanObor.BB_DeleteClick(Sender: TObject);
begin
  inherited;
if MessageDlg(TrLangMSG(msgDeleteRecord),
                 mtConfirmation, [mbYes, mbNo], 0) = mrYes then
     begin
           Planobors_q.Delete;
           Planobors_q.CommitUpdates;
           RefreshBase(Planobors_q);
     end;
end;



procedure Tfrm_PlanObor.Planobors_surUpdateData(Sender: TObject);
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
 Planobors_sur.OnUpdateData:=Planobors_surUpdateData;
end;

procedure Tfrm_PlanObor.BB_SaveClick(Sender: TObject);
begin
  inherited;
Planobors_surUpdateData(Self);
end;

procedure Tfrm_PlanObor.DBGr_PlanoborExit(Sender: TObject);
begin
  inherited;
 BB_SaveClick(self);
end;

procedure Tfrm_PlanObor.Planobors_qBeforePost(DataSet: TDataSet);
begin
  inherited;
 if DataSet.FieldByName('id_zav').asString = ''
    then DataSet.FieldByName('id_zav').asInteger:=ObZav;
 if DataSet.FieldByName('id_nar').asString = ''
    then DataSet.FieldByName('id_nar').asInteger:=ObNar;
end;

procedure Tfrm_PlanObor.BB_CloseClick(Sender: TObject);
begin
  inherited;
 Close;
end;

procedure Tfrm_PlanObor.Translate;
begin
 BB_Insert.Caption:=TrLangMSG(msgInsert);
  BB_Delete.Caption:='&'+TrLangMSG(msgDelete);
  BB_Save.Caption:='&'+TrLangMSG(msgSave);
  BB_Close.Caption:='&'+TrLangMSG(msgExit);


  DBGr_Planobor.Columns[0].Title.Caption:=TrLangMSG(msgPlanmechan);
end;



procedure Tfrm_PlanObor.FormShow(Sender: TObject);
begin
  inherited;
caption:=TrLangMSG(msgPlanmechan);
end;

end.
