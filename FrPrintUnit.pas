unit FrPrintUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FR_Class, FR_DSet, StdCtrls, Grids;

type
  TForm1 = class(TForm)
    Button1: TButton;
    RowDataset: TfrUserDataset;
    frReport1: TfrReport;
    Memo1: TMemo;
    ColDataset: TfrUserDataset;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure frReport1GetValue(const ParName: string;
      var ParValue: Variant);
    procedure frReport1PrintColumn(ColNo: Integer; var Width: Integer);
    procedure frReport1BeforePrint(Memo: TStringList; View: TfrView);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    procedure PrintCell(_col,_row:integer;value:string);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.PrintCell(_col,_row:integer;value:string);
begin
  //
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  ColDataset.RangeEnd := reCount;
  ColDataset.RangeEndCount := StringGrid1.ColCount;
  RowDataset.RangeEnd := reCount;
  RowDataset.RangeEndCount := StringGrid1.RowCount;
  frReport1.ShowReport;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i, j: Integer;
begin
  for i := 0 to StringGrid1.ColCount - 1 do
    for j := 0 to StringGrid1.RowCount - 1 do
      StringGrid1.Cells[i, j] := IntToStr(j * StringGrid1.ColCount + i + 1);
end;

procedure TForm1.frReport1GetValue(const ParName: string;
  var ParValue: Variant);
begin
  if AnsiCompareText(ParName, 'Cell') = 0 then
    ParValue := memo1.Lines[RowDataset.RecNo];
end;

procedure TForm1.frReport1PrintColumn(ColNo: Integer; var Width: Integer);
begin
  if ColNo=1 then Width := 200 else Width:=50;
  (frReport1.FindObject('Memo1') as TFrMemoView).dx:=Width;
  (frReport1.FindObject('Memo1') as TFrMemoView).Alignment:=3;
end;

procedure TForm1.frReport1BeforePrint(Memo: TStringList; View: TfrView);
begin
//  PrintCell(ColDataset.RecNo, RowDataset.RecNo,'шо'#13'за'#13'дела');
 // Memo.Assign(Memo1.Lines);
//  View.
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  ColDataset.RangeEnd:=reCount;
  ColDataset.RangeEndCount:=1;
  RowDataset.RangeEnd:=reCount;
  RowDataset.RangeEndCount:=memo1.Lines.Count;
  frReport1.ShowReport;
end;

end.
