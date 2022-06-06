unit sprav;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db, ExtCtrls, DBCtrls, Grids, DBGrids, StdCtrls, Buttons, Spin,
  RxQuery, RXDBCtrl, Menus;

type
  TFormSprav = class(TForm)
    Qry_SP: TQuery;
    UpdSP: TUpdateSQL;
    DS_SP: TDataSource;
    Qry_prov: TQuery;
    Panel1: TPanel;
    ChB_Sort: TCheckBox;
    Label2: TLabel;
    Ed_Find: TEdit;
    BB_Insert: TBitBtn;
    BB_Delete: TBitBtn;
    BB_Save: TBitBtn;
    Label1: TLabel;
    SpEd_Font: TSpinEdit;
    BB_Close: TBitBtn;
    DBGr_SP: TRxDBGrid;
    Bevel1: TBevel;
    Bevel2: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BB_InsertClick(Sender: TObject);
    procedure BB_DeleteClick(Sender: TObject);
    procedure BB_SaveClick(Sender: TObject);
    procedure DS_SPUpdateData(Sender: TObject);
    procedure SpEd_FontChange(Sender: TObject);
    procedure BB_CloseClick(Sender: TObject);
    procedure Ed_FindChange(Sender: TObject);
    procedure ChB_SortClick(Sender: TObject);
    procedure Qry_SPAfterInsert(DataSet: TDataSet);
    procedure DBGr0_SPKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    tutFields,tutTitles:TstringList;
    BaseName,FindField,AllSelect,SortSelect,AliasName:string;
    CondField,CondUsl,CondZnach:string;
    NumFields:integer;
    OwMenu:TMenuItem;
  public
    { Public declarations }
    constructor SpravCreate(AOwner: TMenuItem;
          alName,dbName,fCaption:string;nTitles,nFields:TStringList);
    procedure RefreshBase;
  end;

var
  FormSprav: TFormSprav;

implementation
 uses strtool;
{$R *.DFM}

constructor TFormSprav.SpravCreate(AOwner: TMenuItem;
          alName,dbName,fCaption:string;nTitles,nFields:TStringList);
begin
  OwMenu:=AOwner;
  AliasName:=alName;
  tutFields:=TStringList.Create;
  tutFields.Clear;
  tutFields.AddStrings(nFields);
  tutTitles:=TStringList.Create;
  tutTitles.Clear;
  tutTitles.AddStrings(nTitles);
  NumFields:=nFields.Count-1;
  BaseName:=dbName;
  inherited Create(AOwner.Owner);
  FormSprav.Caption:=fCaption;
//  DbPath:=DbP;
end;

procedure TFormSprav.FormCreate(Sender: TObject);
var i:integer;
    ss,tt,zz,tt_str:string;
begin
 CondField:='';CondUsl:='';CondZnach:='';
 Qry_SP.DatabaseName:=AliasName;
 Qry_Prov.DatabaseName:=AliasName;
 FormSprav:=Self;
 SpEd_Font.Value:=DbGr_Sp.Font.Size;
 ChB_Sort.Caption:=ChB_Sort.Caption+'"'+tutTitles.Strings[0]+'"';
 ss:='';tt:='';zz:='';FindField:='';
 for i:=0 to NumFields do
  begin
   if tutTitles.Strings[i]<>'CONDITION' then
     DbGr_SP.Columns.Add;
  end;

 for i:=0 to NumFields do
  begin
   if tutTitles.Strings[i]='CONDITION' then
    begin
      tt_str:=tutFields.Strings[i];
      CondField:=ExtractWordsx_(1,1,tt_str,';',false);
      CondUsl:=ExtractWordsx_(2,1,tt_str,';',false);
      CondZnach:=ExtractWordsx_(3,1,tt_str,';',false);
    end
   else
    begin
     DbGr_SP.Columns.Items[i].FieldName:=tutFields.Strings[i];
     DbGr_SP.Columns.Items[i].Title.Caption:=tutTitles.Strings[i];
     if i=0 then
      begin
       FindField:=tutFields.Strings[i];
       ss:=tutFields.Strings[i];
       tt:=':'+ss;
       zz:=ss+'=:'+ss;
      end
     else
      begin
       ss:=ss+','+tutFields.Strings[i];
       tt:=tt+',:'+tutFields.Strings[i];
       zz:=zz+','+tutFields.Strings[i]+'=:'+tutFields.Strings[i];
      end;
    end;
  end;
 Qry_SP.SQL.Clear;
 AllSelect:='select * from '+BaseName+' '+CondUsl;
 SortSelect:='select * from '+BaseName+' '+CondUsl+' order by '+FindField;
 Qry_SP.SQL.Add(AllSelect);
 UpdSP.InsertSQL.Clear;
 tt_str:='insert into '+BaseName+' ('+
                           ss+CondField+') values ('+tt+CondZnach+')';
 UpdSP.InsertSQL.Add(tt_str);
 UpdSP.DeleteSQL.Clear;
 tt_str:='delete from '+BaseName+' where id=:id';
 UpdSP.DeleteSQL.Add(tt_str);
 UpdSP.ModifySQL.Clear;
 tt_str:='update '+BaseName+' set '+zz+' where id=:id';
 UpdSP.ModifySQL.Add(tt_str);
 Qry_SP.Open;
end;

procedure TFormSprav.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Qry_SP.Close;
  tutFields.Free;
  tutTitles.Free;
  OwMenu.Enabled:=true;
  Action:=caFree;
end;

procedure TFormSprav.BB_InsertClick(Sender: TObject);
begin
 Qry_SP.Insert;
 Qry_Sp.Post;
 Qry_Sp.CommitUpdates;
 RefreshBase;
end;

procedure TFormSprav.BB_DeleteClick(Sender: TObject);
var tek_id:string;
    numBm,i:integer;
    isMulti:boolean;
begin
  numBm:=DBGr_Sp.SelectedRows.Count;
  isMulti:=false;
  if NumBm>1 then
    begin
       dec(NumBm);
       isMulti:=true;
    end
  else
     NumBm:=0;

  for i:=0 to NumBm do
    begin
           if isMulti then
              Qry_SP.Bookmark:=DbGr_SP.SelectedRows.Items[i];

           tek_id:=Qry_SP.FieldByName('ID').asString;
           UpdSP.DeleteSQL.Clear;
           UpdSP.DeleteSQL.Add('delete from '+BaseName+' where id='+tek_id);
           Qry_SP.Delete;
           Qry_Sp.CommitUpdates;
     end;
  RefreshBase;
end;

procedure TFormSprav.BB_SaveClick(Sender: TObject);
begin
 DS_SPUpdateData(Self);
end;

procedure TFormSprav.DS_SPUpdateData(Sender: TObject);
var sInd,i:integer;
    tt_str:string;
begin
DS_SP.OnUpdateData:=NIL;
   //DbGr_SP.Columns.Items[i].FieldName
 if Qry_SP.Modified then
   begin
    tt_str:='';
    for i:=0 to 0{NumFields} do
     begin
      if tutTitles.Strings[i]<>'CONDITION' then
       tt_str:=tt_str+' and '+tutFields.strings[i]+
       '="'+Qry_SP.FieldByName(tutFields.strings[i]).asString+'"';
     end;
    if CondUsl='' then
       begin
         tt_str:=copy(tt_str,5,1000);
         tt_str:=' where '+tt_str;
       end;
    tt_str:='select count(id) mm from '+BaseName+' '+
    CondUsl+tt_str+' and id<>'+Qry_SP.FieldByName('ID').asString;
    Qry_Prov.SQL.Clear;
    Qry_Prov.SQL.Add(tt_str);
    Qry_Prov.Open;
    i:=Qry_Prov.FieldByName('MM').asInteger;
    Qry_Prov.Close;
    if i>0 then
      begin
        MessageDlg('Такая запись уже есть!',mtError,[mbOk],0);
        RefreshBase;
        exit;
      end
    else
      Qry_Sp.Post;
   end;
 if Qry_SP.UpdatesPending then
  begin
   Qry_SP.ApplyUpdates;
   Qry_Sp.CommitUpdates;
   sInd:=DBGr_Sp.SelectedIndex;
   RefreshBase;
   DBGr_Sp.SelectedIndex:=sInd;
  end;
DS_SP.OnUpdateData:=DS_SPUpdateData;
end;

procedure TFormSprav.SpEd_FontChange(Sender: TObject);
begin
 DbGr_Sp.Font.Size:=SpEd_Font.Value;
end;

procedure TFormSprav.BB_CloseClick(Sender: TObject);
begin
 Close;
end;

procedure TFormSprav.Ed_FindChange(Sender: TObject);
var tt_str:string;
begin
 if Ed_Find.Text = '' then exit;
 if not (Qry_Sp.Locate(FindField,Ed_Find.Text,[loCaseInsensitive, loPartialKey])) then
  begin
   if Qry_Sp.FindField(FindField).DataType = ftString then
     begin
      tt_str:=Ed_Find.Text;
      Ed_Find.Text:=First(strlen(pchar(tt_str))-1,tt_str);
     end; // if Qry_Sp.FindField(FindField).DataType = ftString ...
  end; // if not (Qry_Sp.Locate(FindField,Ed_Find.Text, ...
end;

procedure TFormSprav.ChB_SortClick(Sender: TObject);
begin
  Ed_Find.Enabled:=ChB_Sort.Checked;
  Label2.Enabled:=ChB_Sort.Checked;
  RefreshBase;
end;

procedure TFormSprav.Qry_SPAfterInsert(DataSet: TDataSet);
begin
  DS_SPUpdateData(Self);
end;

procedure TFormSprav.DBGr0_SPKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=VK_DOWN)and (not (ssCtrl in shift))then
   begin
     Qry_SP.MoveBy(1);
     if Qry_SP.EOF then
        exit;
     Qry_SP.moveby(-1);
   end;
  {if (key=VK_DELETE) and (ssCtrl in Shift)  and
   ((wgNoDel in FOptionsX ) or (DataLink.DataSet.recordcount=0))
   then exit;}

  inherited KeyDown(Key, Shift);
end;

procedure TFormSprav.RefreshBase;
var old_id:integer;
begin
  old_id:=Qry_SP.FieldByName('ID').asInteger;
  Qry_Sp.Close;
  Qry_SP.SQL.Clear;
  if old_id=0 then
    begin
       Qry_Sp.SQL.Add('select max(id) mm from '+BaseName);
       Qry_Sp.Open;
       old_id:=Qry_SP.FieldByName('MM').asInteger;
       Qry_SP.Close;
       Qry_SP.SQL.Clear;
    end;
  if ChB_Sort.Checked then
    Qry_Sp.SQL.Add(SortSelect)
  else
    Qry_Sp.SQL.Add(AllSelect);

  Qry_Sp.Open;
  Qry_Sp.Locate('ID',old_id,[]);

end;


procedure TFormSprav.Button1Click(Sender: TObject);
begin
 Qry_Sp.Locate('DIAM', Ed_Find.Text,[loCaseInsensitive, loPartialKey]);
end;

end.
