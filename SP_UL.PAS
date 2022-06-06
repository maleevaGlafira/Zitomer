unit sp_ul;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBCtrls, Grids, DBGrids, RXDBCtrl, DBTables, Db, RXLookup, StdCtrls,
  Spin, Buttons;

type
  prEdidCell = function (Ow:TComponent;FontSize:integer;fCap,sSQL:string):string;
  TFormSpUl = class(TForm)
    DS_SpUl: TDataSource;
    Qry_SpUl: TQuery;
    UpdSpUl: TUpdateSQL;
    DBGr_SpUl: TRxDBGrid;
    BB_Insert: TBitBtn;
    BB_Delete: TBitBtn;
    BB_Save: TBitBtn;
    Label1: TLabel;
    SpEd_Font: TSpinEdit;
    BB_Close: TBitBtn;
    Qry_SpUlID: TIntegerField;
    Qry_SpUlNAME_R: TStringField;
    Qry_SpUlID_VIDUL: TIntegerField;
    Qry_vidul: TQuery;
    DS_vidul: TDataSource;
    Qry_SpUlvidul_look: TStringField;
    Qry_SpUlORINT: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGr_SpUlCellClick(Column: TColumn);
    procedure DBGr_SpUlDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BB_CloseClick(Sender: TObject);
    procedure BB_InsertClick(Sender: TObject);
    procedure BB_SaveClick(Sender: TObject);
    procedure BB_DeleteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure IzmTip;
  end;

var
  FormSpUl: TFormSpUl;

implementation
  uses vvod_ol;
{$R *.DFM}

procedure TFormSpUl.FormCreate(Sender: TObject);
begin
  Qry_SpUl.Open;
end;

procedure TFormSpUl.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Qry_SpUl.Close;
  Action:=caFree;
end;

procedure TFormSpUl.DBGr_SpUlCellClick(Column: TColumn);
//var ff:TFormVvod;
begin
  {ff:=TFormVvod.Create(Self);
  ff.ShowModal;}
  //VvodOl(Self,12,'Выбор типа улицы','select name_r vvod,id from s_vidul order by name_r');
end;

procedure TFormSpUl.DBGr_SpUlDblClick(Sender: TObject);
begin
  IzmTip;
end;

procedure TFormSpUl.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=VK_RETURN) then
   begin
     IzmTip;
   end;
end;

procedure TFormSpUl.IzmTip;
var tt_str:string;
begin
 {
 if DbGr_SpUl.Col=2 then
  begin
    tt_str:=VvodOl(Self,10,'DBN_AVAR','Выбор типа улицы',
       'select name_r vvod,id from s_vidul order by name_r',Qry_SpUl.FieldByName('ID_VIDUL').asString,NIL);
    if tt_str<>'' then
      begin
         Qry_SpUl.Edit;
         Qry_SpUl.FieldByName('ID_VIDUL').asString:=tt_str;
         Qry_SpUl.Post;
         Qry_SpUl.CommitUpdates;
         Qry_SpUl.Close;
         Qry_SpUl.Open;
      end;              //TInplaceEditor ;


    end;
  }
end;



procedure TFormSpUl.BB_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFormSpUl.BB_InsertClick(Sender: TObject);
begin
 Qry_SPUl.Insert;
 Qry_SpUl.Post;
 Qry_SpUl.CommitUpdates;
 Qry_SpUl.Close;
 Qry_SpUl.Open;
end;
{
select u.id id,u.name_r name_r,v.name_r vid,u.id_vidul from s_ulic u,s_vidul v where u.id_vidul=v.id


}
procedure TFormSpUl.BB_SaveClick(Sender: TObject);
begin
 Qry_SpUl.CommitUpdates;
 Qry_SpUl.Close;
 Qry_SpUl.Open;

end;

procedure TFormSpUl.BB_DeleteClick(Sender: TObject);
begin
 Qry_SPUl.Delete;
 Qry_SpUl.Post;
 Qry_SpUl.CommitUpdates;
 Qry_SpUl.Close;
 Qry_SpUl.Open;

end;

end.
