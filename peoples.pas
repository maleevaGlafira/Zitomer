unit peoples;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RXCtrls, StdCtrls, DB, DBTables, RxQuery, RxLookup, ExtCtrls,
  cntsLANG,ServiceFuncUnit,frmLANG;

type
  TfmBrig = class(TFormLang)
    AllList: TListBox;
    ActiveList: TListBox;
    RxLabel1: TRxLabel;
    RxLabel2: TRxLabel;
    RxLabel3: TRxLabel;
    DBL_Gang: TRxDBLookupCombo;
    qry_Brig: TRxQuery;
    Qry_select: TRxQuery;
    ds_Brig: TDataSource;
    Qry_advSel: TRxQuery;
    Qry_All: TRxQuery;
    AllCBox: TRxDBLookupCombo;
    Qry_tmp2: TRxQuery;
    ds_All: TDataSource;
    sbSave: TRxSpeedButton;
    sbExit: TRxSpeedButton;
    Panel1: TPanel;
    sbInsert: TRxSpeedButton;
    sbDelete: TRxSpeedButton;
    sbClearAll: TRxSpeedButton;
    constructor FCreate(Aowner:TComponent;temMode:integer;tId_zav:integer=0;tId_work:integer=0;tId_team:integer=0;tIsClosed:integer=1);
    procedure DBL_GangChange(Sender: TObject);
    procedure sbInsertClick(Sender: TObject);
    procedure sbDeleteClick(Sender: TObject);
    procedure sbClearAllClick(Sender: TObject);
    procedure sbSaveClick(Sender: TObject);
    procedure sbExitClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    Mode:integer; //0 -Редактирование справочников
                  //1 -Редактирование работающих бригад
    id_zav:integer;
    id_work:integer;
    id_team:integer;
    lteam:TStrings;
    firstin:boolean;
    procedure ModifyList(Id:integer;DBMan:Boolean;Name_R:string;sign:string);
  public
    { Public declarations }
    procedure Translate;override;
  end;

const sel_list_people ='select id,name_r,DOLGN,UID,PRAVA,DEL,'+
                       ' rtrim(name_r)||''    ''||rtrim(DOLGN) as name_r_full '+
                       ' from s_brig '+
                       ' where ((Dolgn LIKE ''%s'') or (Dolgn like ''%s'') or (id=-1))'+
                        ' and del = ''-'''+
                        ' order by name_r';
const  MAST='Майстер';
const  BRIG='Бригадир';

var
  fmBrig: TfmBrig;

implementation

uses main, datam;

{$R *.dfm}

constructor TfmBrig.FCreate(Aowner:TComponent;temMode:integer;tId_zav:integer=0;tId_work:integer=0;tId_team:integer=0;tIsClosed:integer=1);
var
  i:integer;
  sql:string;
begin
  Create(AOwner);
  if not DM1.Db_Avar.InTransaction then
    DM1.Db_Avar.StartTransaction;
  id_zav:=tId_zav;
  id_work:=tId_work;
  id_team:=tId_team;
  Mode:=Temmode;
  sql:=format(sel_list_people,['%'+MAST+'%', '%'+BRIG+'%']);
  Qry_Brig.SQL.Text:=sql;
  Qry_Brig.Open;

  Qry_all.Open;
  Qry_all.First;
  while not Qry_all.Eof do
  begin
    AllList.AddItem(Trim(Qry_all.FieldByName('Name_R').AsString),Ptr(Qry_all.FieldByName('ID').AsInteger));
   // AllCBox.AddItem(Trim(Qry_tmp.FieldByName('Name_R').AsString),Ptr(Qry_tmp.FieldByName('ID').AsInteger));
    Qry_all.Next;
  end;
  ///Qry_all.Close;

  firstin:=False;

  if Mode=1 then
  begin
    Qry_AdvSel.ParamByName('ID_zav').AsInteger:=id_zav;
    Qry_AdvSel.ParamByName('ID_Work').AsInteger:=Id_work;
    Qry_AdvSel.Open;
    Qry_AdvSel.First;
    if Qry_AdvSel.Eof then
      firstin:=True;
    Qry_AdvSel.Close;
  end;

  if Mode=1 then
  begin
    Qry_Brig.Locate('id',id_team,[]);
    DBL_Gang.DisplayValue:=Qry_Brig.FieldByName('name_r_full').AsString;
    lteam:=TStringList.Create;
    LTeam.Assign(ActiveList.Items);
  end
  else
    DBL_Gang.DisplayValue:=' ';

  if Mode=1 then
  begin
    DBL_GANG.Enabled:=False;
    Qry_AdvSel.ParamByName('ID_zav').AsInteger:=id_zav;
    Qry_AdvSel.ParamByName('ID_Work').AsInteger:=Id_work;
    Qry_AdvSel.Open;
    Qry_AdvSel.First;
    while not Qry_AdvSel.Eof do
    begin
      ModifyList(Qry_AdvSel.FieldByName('ID').AsInteger,False,Trim(Qry_AdvSel.FieldByName('Name_r').AsString),Qry_AdvSel.FieldByName('Sign').AsString);
//      ModifyList(Qry_AdvSel.FieldByName('ID').AsInteger,True,Trim(Qry_AdvSel.FieldByName('Name_r').AsString),Qry_AdvSel.FieldByName('Sign').AsString);
//      ModifyList(Qry_AdvSel.FieldByName('ID').AsInteger,False,Trim(Qry_AdvSel.FieldByName('Name_r').AsString),Qry_AdvSel.FieldByName('Sign').AsString);
      Qry_AdvSel.Next;
    end;
    Qry_AdvSel.Close;
//    Mode:=0;
  end;
  if {(tIsClosed=0) or }(not(rsNARAD in RightsSet)) then
  begin
    sbInsert.Enabled:=false;
    sbDelete.Enabled:=false;
    sbClearAll.Enabled:=false;
    AllList.Enabled:=false;
    ActiveList.Enabled:=false;
    sbSave.Enabled:=false
  end;
  //
  sbInsert.Enabled:=rsNARAD in RightsSet;
  sbDelete.Enabled:=rsNARAD in RightsSet;
  sbClearAll.Enabled:=rsNARAD in RightsSet;
end;

procedure TfmBrig.Translate;
begin
 self.Caption:=TrLangMSG(msgBrigsList);
 RxLabel1.Caption:=TrLangMSG(msgBrigorMaster);
 RxLabel2.Caption:=TrLangMSG(msgWorkrersWorked);
 RxLabel3.Caption:=TrLangMSG(msgAll);
 sbSave.Caption:=TrLangMSG(msgSave);
 sbExit.Caption:=TrLangMSG(msgExit);
 sbInsert.Hint:=TrLangMSG(msgAdd);
 sbDelete.Hint:=TrLangMSG(msgDelete);
 sbClearAll.Hint:=TrLangMSG(msgClearAll);
end;


procedure TfmBrig.DBL_GangChange(Sender: TObject);
begin
  ActiveList.Items.Clear;
  if ((mode<>1) or ((mode=1) and firstin)) and (not not(rsNARAD in RightsSet)) then
  begin
    Qry_Select.ParamByName('chief').AsInteger:=qry_Brig.FieldByName('Id').AsInteger;
    Qry_Select.Open;
    Qry_Select.First;
    while not Qry_Select.Eof do
    begin
      if mode=1 then
        ModifyList(Qry_select.FieldByName('ID').AsInteger,True,Trim(Qry_select.FieldByName('Name_R').AsString) ,'+')
      else
        ActiveList.AddItem(Trim(Qry_select.FieldByName('Name_R').AsString),Ptr(Qry_select.FieldByName('ID').AsInteger));

//        ModifyList(Qry_select.FieldByName('ID').AsInteger,True,Trim(Qry_select.FieldByName('Name_R').AsString) ,'+');
      Qry_select.Next;
    end;
    Qry_select.Close;
  end;
  id_team:=Qry_Brig.FieldByName('ID').AsInteger;
end;

procedure TfmBrig.ModifyList(Id:integer;DBMan:Boolean;Name_R:string;sign:string);
var
  i:integer;

function ExistIdInList(Ident:integer):boolean;
var
  ii:integer;
begin
  Result:=False;
  for ii:=0 to LTeam.Count-1 do
  begin
    if Integer(LTeam.Objects[ii])=Ident then
    begin
      Result:=True;
      Exit;
    end;
  end;
end;

begin
  for i:=0 to ActiveList.Count-1 do
  begin
    if Sign='-' then
    begin
      if ActiveList.Items[i]=Name_r then
      begin
        case Mode of
          0:Qry_tmp2.Sql.Text:='delete from s_team where chief='+IntToStr(id_team)+ ' and labour='+IntToStr(id);
{
          1:Qry_tmp2.SQL.Text:='delete from ord_people where id_zav='+IntToStr(id_zav)+
                               ' and id_work='+IntToStr(id_work)+
                               ' and id_team='+IntToStr(id_team)+
                               ' and add_people='+IntToStr(id);
}
{
          1:begin
              if ExistIdInList(id) then
              begin
                Qry_tmp2.SQL.Text:='insert into Ord_people (id_zav,id_work,id_team,add_people,sign) values('
                                   +IntToStr(id_zav)+','
                                   +IntToStr(id_work)+','
                                   +IntToStr(id_team)+','
                                   +IntToStr(id)+',''-'')';
              end
              else
              begin
                Qry_tmp2.SQL.Text:='delete from ord_people where id_zav='+IntToStr(id_zav)+
                                   ' and id_work='+IntToStr(id_work)+
                                   ' and id_team='+IntToStr(id_team)+
                                   ' and add_people='+IntToStr(id);
              end
            end;
}
          1:Qry_tmp2.SQL.Text:='delete from ord_people where id_zav='+IntToStr(id_zav)+
                               ' and id_work='+IntToStr(id_work)+
//                               ' and id_team='+IntToStr(id_team)+
                               ' and add_people='+IntToStr(id);

        end;
        ActiveList.Items.Delete(i);
        if DBMan then
          Qry_tmp2.ExecSQL;
        exit;
      end;
    end;
    if Sign='+' then
    begin
      if ActiveList.Items[i]=Name_r then
        exit;
      if ActiveList.Items[i]>Name_r then
      begin
        case Mode of
          0:Qry_tmp2.Sql.Text:='insert into s_team (chief,labour) values ('+IntToStr(id_team)+','+IntToStr(id)+')';
          1:Qry_tmp2.SQL.Text:='insert into Ord_people (id_zav,id_work,id_team,add_people,sign) values('
                                   +IntToStr(id_zav)+','
                                   +IntToStr(id_work)+','
                                   +IntToStr(id_team)+','
                                   +IntToStr(id)+',''+'')';
{          1:begin
              if not ExistIdInList(id) then
              begin
                Qry_tmp2.SQL.Text:='insert into Ord_people (id_zav,id_work,id_team,add_people,sign) values('
                                   +IntToStr(id_zav)+','
                                   +IntToStr(id_work)+','
                                   +IntToStr(id_team)+','
                                   +IntToStr(id)+',''+'')';
              end
              else
              begin
                Qry_tmp2.SQL.Text:='delete from ord_people where id_zav='+IntToStr(id_zav)+
                                   ' and id_work='+IntToStr(id_work)+
                                   ' and id_team='+IntToStr(id_team)+
                                   ' and add_people='+IntToStr(id);
              end;
            end;
}
        end;
        ActiveList.Items.Insert(i,name_r);
        ActiveList.Items.Objects[i]:=Ptr(id);
        if DBMan then
          Qry_tmp2.ExecSQL;
        exit;
      end;
    end;
  end;

  if (Sign='+')then
  begin
    if (ActiveList.Count=0) then
    begin
      ActiveList.Items.Insert(0,name_r);
      ActiveList.Items.Objects[0]:=Ptr(id);
      case Mode of
        0:Qry_tmp2.Sql.Text:='insert into s_team (chief,labour) values ('+IntToStr(id_team)+','+IntToStr(id)+')';
        1:Qry_tmp2.SQL.Text:='insert into Ord_people (id_zav,id_work,id_team,add_people,sign) values('
                              +IntToStr(id_zav)+','
                              +IntToStr(id_work)+','
                              +IntToStr(id_team)+','
                              +IntToStr(id)+',''+'')';
      end;
      if DBMan then
        Qry_tmp2.ExecSQL;
    end
    else
    begin
      ActiveList.Items.Insert(i,name_r);
      ActiveList.Items.Objects[i]:=Ptr(id);
      case Mode of
        0:Qry_tmp2.Sql.Text:='insert into s_team (chief,labour) values ('+IntToStr(id_team)+','+IntToStr(id)+')';
        1:Qry_tmp2.SQL.Text:='insert into Ord_people (id_zav,id_work,id_team,add_people,sign) values('
                              +IntToStr(id_zav)+','
                              +IntToStr(id_work)+','
                              +IntToStr(id_team)+','
                              +IntToStr(id)+',''+'')';
      end;
      if DBMan then
        Qry_tmp2.ExecSQL;
    end;
  end;

end;


procedure TfmBrig.sbInsertClick(Sender: TObject);
begin
//  if qry_Brig.FieldByName('id').asInteger>0 then
  if AllList.ItemIndex>-1 then
    ModifyList(Integer(AllList.items.Objects[AllList.ItemIndex]),true,AllList.items.Strings[AllList.ItemIndex] ,'+');
end;

procedure TfmBrig.sbDeleteClick(Sender: TObject);
begin
  if (ActiveList.Count>0) and (ActiveList.ItemIndex<>-1) then
  ModifyList(Integer(ActiveList.items.Objects[ActiveList.ItemIndex]),true,ActiveList.items.Strings[ActiveList.ItemIndex] ,'-');
end;

procedure TfmBrig.sbClearAllClick(Sender: TObject);
var
  ii:integer;
begin
  for ii:=ActiveList.Count-1 downto 0 do
    ModifyList(Integer(ActiveList.items.Objects[ii]),true,ActiveList.items.Strings[ii] ,'-');
end;

procedure TfmBrig.sbSaveClick(Sender: TObject);
begin
  if (mode=1) and (firstin) and (ActiveList.Count=0) then
    MyExecSQL(Qry_tmp2,'insert into Ord_people (id_zav,id_work,add_people,sign) values('
                                   +IntToStr(id_zav)+','
                                   +IntToStr(id_work)+',-1,''-'')');

{    MyExecSQL(Qry_tmp2,'insert into Ord_people (id_zav,id_work,id_team,add_people,sign) values('
                                   +IntToStr(id_zav)+','
                                   +IntToStr(id_work)+','
                                   +IntToStr(id_team)+',-1,''-'')');
}

//  MyExecSQL(Qry_tmp2,'COMMIT');
  DM1.Db_Avar.Commit;
  Close;
end;

procedure TfmBrig.sbExitClick(Sender: TObject);
begin
//  MyExecSQL(Qry_tmp2,'RollBack');
  DM1.Db_Avar.Rollback;
  Close;
end;

procedure TfmBrig.FormDestroy(Sender: TObject);
begin
  inherited;
 Qry_all.close;
end;

end.
