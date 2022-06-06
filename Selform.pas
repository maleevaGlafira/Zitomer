unit Selform;
{$WARN SYMBOL_DEPRECATED OFF}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, CheckLst, Buttons, ComCtrls, DB, frmLANG, cntsLANG,
  DBTables;

type
  TSelectForm = class(TFormLang)
    Panel1: TPanel;
    Panel2: TPanel;
    CheckListBox1: TCheckListBox;
    buOK: TBitBtn;
    Panel4: TPanel;
    buQuit: TBitBtn;
    Query: TQuery;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure buQuitClick(Sender: TObject);
    procedure buOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Temp_Code : String;
    SelText:string;
    procedure Translate;override;
  end;

procedure ShowSelectItemDlg(SQL: string; var ItemsID: string; var ItemsName: string);

implementation

uses DataM;

{$R *.DFM}


procedure ShowSelectItemDlg(SQL: string; var ItemsID: string; var ItemsName: string);
var
  sf: TSelectForm;
begin
  sf:=TSelectForm.Create(nil);
  try
    sf.Query.SQL.text:=SQL;
    sf.ShowModal;
    ItemsID:=sf.Temp_Code;
    ItemsName:=sf.SelText;
  finally
    sf.Free;
  end;
end;



procedure TSelectForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TSelectForm.FormShow(Sender: TObject);
begin
    Query.Open;
    Query.First;
    while Not(Query.eof) do
    begin
       CheckListBox1.AddItem(Query.FieldByName('pole1').AsString,Tobject(Query.FieldByName('code').AsInteger));
       Query.Next;
    end;
    Query.Close;
end;

procedure TSelectForm.FormCreate(Sender: TObject);
begin
   Temp_code:='';
end;

procedure TSelectForm.buQuitClick(Sender: TObject);
begin
 Close;
end;

procedure TSelectForm.buOKClick(Sender: TObject);
var j : Integer;
  NeedForChecked:Boolean;
begin
  NeedForChecked:=True;
  for  j:=0  to CheckListBox1.Items.Count-1  do
  begin
    If CheckListBox1.Checked[j] Then
    Begin
      NeedForChecked:=False;
      If Temp_code='' Then
      begin
        appendstr(Temp_code,'(' + IntToStr(Integer(CheckListBox1.Items.Objects[j])));
      end
      else
      begin
        appendstr(Temp_code,',' + IntToStr(Integer(CheckListBox1.Items.Objects[j])));
      end;

      If SelText='' Then
      begin
        appendstr(SelText,'(' + CheckListBox1.Items[j]);
      end
      else
      begin
        appendstr(SelText,',' + CheckListBox1.Items[j]);
      end;

    end;
  end;
  if NeedForChecked then
  begin
    Temp_code:='';
    SelText:='';
  end;
  If Temp_code<>'' Then
    appendstr(Temp_code,')');
  If SelText<>'' Then
    appendstr(SelText,')');
  close;
end;

procedure TSelectForm.Translate;
begin
buOK.Caption:=TrLangMSG(msgApply);
buQuit.Caption:=TrLangMSG(msgExit);
Caption:=TrLangMSG(msgDoSelect);
end;


end.
