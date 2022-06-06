unit fPreview;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, reportex;

type
  TfrmPreview = class(TForm)
    Memo1: TMemo;
    Panel1: TPanel;
    bbPRINTER: TBitBtn;
    edPRINTER: TEdit;
    BitBtn1: TBitBtn;
    SaveDialog1: TSaveDialog;
    BB_Exit: TBitBtn;
    BitBtn2: TBitBtn;
    RP: TReporterBDE;
    sbPred: TSpeedButton;
    sbNext: TSpeedButton;
    lPage: TLabel;
    procedure bbPRINTERClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BB_ExitClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure RPOutput(Sender: TObject; output: String);
    procedure FormDestroy(Sender: TObject);
    procedure sbPredClick(Sender: TObject);
    procedure sbNextClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    WRep, Page, Pages :integer;
    Lines:TStringList;
    procedure ShowPage(n:integer);
  end;

var
  frmPreview: TfrmPreview;

implementation
uses comobj,nastr,datam,support,math,cntsLANG,frmLANG;

{$R *.DFM}

procedure TfrmPreview.bbPRINTERClick(Sender: TObject);
var f1{,f2}:textfile;
//    s:string;
    i:integer;
begin
{
  assignfile(f1,'out.txt');
  reset(f1);
  assignfile(f2,'outp.txt');
  rewrite(f2);
  while not eof(f1) do begin
    readln(f1,s);
    writeln(f2,wintodos(s));
  end;
  closefile(f1);
  closefile(f2);
  copyfile('outp.txt',pchar(edPRINTER.text),true);
}
  try
    assignfile(f1,edPRINTER.text);
    rewrite(f1);
    for i:=0 to lines.count-1 do writeln(f1,wintodos(lines[i]));
  finally
    closefile(f1);
    ShowMessage(TrLangMSG(msgPrintMoreLater));
  end;
end;

procedure TfrmPreview.BitBtn1Click(Sender: TObject);
begin
  if SaveDialog1.Execute
  then copyfile('out.txt',pchar(SaveDialog1.filename),true);
end;

procedure TfrmPreview.FormCreate(Sender: TObject);
begin
  Lines:=TStringList.Create;
  Page:=1;
  edPRINTER.text:=NastrF.edPRNpath.text
end;

procedure TfrmPreview.FormDestroy(Sender: TObject);
begin
  lines.Free
end;

procedure TfrmPreview.BB_ExitClick(Sender: TObject);
begin
  close
end;

procedure TfrmPreview.BitBtn2Click(Sender: TObject);
var v:OleVariant;
begin
  v:=CreateOleObject('Word.Application');
  v.documents.open(ExtractFilePath(paramstr(0))+'.\out.txt',True);
  if Wrep>80 then v.activedocument.PageSetup.Orientation := 1{wdOrientLandscape};
  v.activedocument.range.Font.Name:='Courier New';
  if Wrep>120 then v.activedocument.range.Font.size:=8;
end;

procedure TfrmPreview.RPOutput(Sender: TObject; output: String);
begin
  Wrep:=max(Wrep,length(output));
  Lines.Add(output);
end;

procedure TfrmPreview.ShowPage(n:integer);
const pagesize=200;
var i,j:integer;
begin
  Pages:=lines.Count div pagesize;
  if((lines.Count mod pagesize)>0)or(pages=0) then inc(pages);
  if(n<1)or(n>pages) then exit;
  Page:=n;
  sbPred.Enabled:=(page>1);
  sbNext.Enabled:=(page<pages);
  lPage.Caption:=format('Страница %d из %d',[page, pages]);
  memo1.lines.BeginUpdate;
  memo1.lines.clear;
  j:=pagesize*(n-1);
  for i:=j to j+pagesize-1 do
  if i<lines.count then memo1.lines.Add(lines[i]);
  memo1.lines.EndUpdate;
  memo1.CaretPos:=point(0,0)
end;

procedure TfrmPreview.sbPredClick(Sender: TObject);
begin
  showpage(page-1);
end;

procedure TfrmPreview.sbNextClick(Sender: TObject);
begin
  showpage(page+1);
end;

end.
