unit spul;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db, ExtCtrls, DBCtrls, Grids, DBGrids, StdCtrls, Buttons, Spin,
  RxQuery, RXDBCtrl;

type
  TFormSprav = class(TForm)
    Qry_SP: TQuery;
    UpdSP: TUpdateSQL;
    DS_SP: TDataSource;
    BB_Insert: TBitBtn;
    BB_Delete: TBitBtn;
    BB_Save: TBitBtn;
    SpEd_Font: TSpinEdit;
    Label1: TLabel;
    BB_Close: TBitBtn;
    Ed_Find: TEdit;
    Label2: TLabel;
    ChB_Sort: TCheckBox;
    DBGr_SP: TRxDBGrid;
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
  private
    { Private declarations }
    tutFields,tutTitles:TstringList;
    BaseName,FindField,AllSelect,SortSelect:string;
    NumFields:integer;
  public
    { Public declarations }
    constructor SpravCreate(AOwner: TComponent;
          dbName,fCaption:string;nTitles,nFields:TStringList);
  end;

var
  FormSprav: TFormSprav;

implementation
 uses strtool;
{$R *.DFM}

constructor TFormSprav.SpravCreate(AOwner: TComponent;
          dbName,fCaption:string;nTitles,nFields:TStringList);
begin
  tutFields:=TStringList.Create;
  tutFields.Clear;
  tutFields.AddStrings(nFields);
  tutTitles:=TStringList.Create;
  tutTitles.Clear;
  tutTitles.AddStrings(nTitles);
  NumFields:=nFields.Count-1;
  BaseName:=dbName;
  inherited Create(AOwner);
  FormSprav.Caption:=fCaption;
//  DbPath:=DbP;
end;

procedure TFormSprav.FormCreate(Sender: TObject);
var i:integer;
    ss,tt,zz,tt_str:string;
begin
 FormSprav:=Self;
 SpEd_Font.Value:=DbGr_Sp.Font.Size;
 ChB_Sort.Caption:=ChB_Sort.Caption+'"'+tutTitles.Strings[0]+'"';
 ss:='';tt:='';zz:='';FindField:='';
 for i:=0 to NumFields do
   DbGr_SP.Columns.Add;

 for i:=0 to NumFields do
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
 Qry_SP.SQL.Clear;
 AllSelect:='select * from '+BaseName;
 SortSelect:='select * from '+BaseName+' order by '+FindField;
 Qry_SP.SQL.Add(AllSelect);
 UpdSP.InsertSQL.Clear;
 tt_str:='insert into '+BaseName+' ('+
                           ss+') values ('+tt+')';
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
  Action:=caFree;
end;

procedure TFormSprav.BB_InsertClick(Sender: TObject);
begin
 Qry_SP.Insert;
 Qry_Sp.Post;
 Qry_Sp.CommitUpdates;
 Qry_Sp.Close;
 Qry_Sp.Open;
end;

procedure TFormSprav.BB_DeleteClick(Sender: TObject);
var tek_id:string;
    numBm,i,old_id:integer;
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
  old_id:=Qry_SP.FieldByName('ID').asInteger;
  Qry_Sp.Close;
  Qry_Sp.Open;
  if old_id>0 then
     Qry_Sp.Locate('ID',old_id,[])
  else
     Qry_SP.Last;
end;

procedure TFormSprav.BB_SaveClick(Sender: TObject);
begin
 DS_SPUpdateData(Self);
end;

procedure TFormSprav.DS_SPUpdateData(Sender: TObject);
var old_ID,sInd:integer;
begin
DS_SP.OnUpdateData:=NIL;
 if Qry_SP.Modified then
  Qry_Sp.Post;                       //TDBGridColumns
 if Qry_SP.UpdatesPending then
  begin
   Qry_SP.ApplyUpdates;
   Qry_Sp.CommitUpdates;
   old_id:=Qry_SP.FieldByName('ID').asInteger;
   sInd:=DBGr_Sp.SelectedIndex;
   Qry_Sp.Close;
   Qry_Sp.Open;
   if old_id>0 then
     Qry_Sp.Locate('ID',old_id,[])
   else
     Qry_SP.Last;
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
 if Ed_Find.Text<>'' then
  begin
   // Qry_Sp.AfterScroll:=NIL;
   if not (Qry_Sp.Locate(FindField,Ed_Find.Text,[loCaseInsensitive, loPartialKey])) then
    begin
     tt_str:=Ed_Find.Text;
     Ed_Find.Text:=First(strlen(pchar(tt_str))-1,tt_str);
    end;
 //  Qry_Sp.AfterScroll:=Qry_SPAfterScroll;
  end;
end;

procedure TFormSprav.ChB_SortClick(Sender: TObject);
var old_id:integer;
begin
  Ed_Find.Enabled:=ChB_Sort.Checked;
  Label2.Enabled:=ChB_Sort.Checked;
  old_id:=Qry_SP.FieldByName('ID').asInteger;
  Qry_Sp.Close;
  Qry_SP.SQL.Clear;
  if ChB_Sort.Checked then
    Qry_Sp.SQL.Add(SortSelect)
  else
    Qry_Sp.SQL.Add(AllSelect);

  Qry_Sp.Open;
  Qry_Sp.Locate('ID',old_id,[]);
end;

procedure TFormSprav.Qry_SPAfterInsert(DataSet: TDataSet);
begin
  DS_SPUpdateData(Self);
end;
   //TBookmarkList
   //  TBookmarkStr
   //  TBookmark
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

end.
