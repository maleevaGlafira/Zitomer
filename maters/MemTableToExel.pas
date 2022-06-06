unit MemTableToExel;

interface
 uses WaitProcessForm, ServiceFuncUnit, OperAttFormUnit, cntsLANG, ComObj, XLConst,
Types, Classes, Controls,  FR_Class, Aligrid, DB, Graphics, SysUtils, kbmMemTable,
Math ;
const StartRow=2;

procedure MaterTableToExel(mem_report: TkbmMemTable;const title: string; title_cols:integer; const left_about:string;left_cols:integer; about:string;list_tytle:string; title2:string='');

implementation

function calcod(col_num:integer):string;
var cod:string;
  last_num, num:integer;
begin
  last_num:=col_num;
  cod:='';
  while last_num>0 do
  begin
  num:= last_num mod 26;
  if num=0 then
  begin
   num:=26;
   last_num:=last_num-26;
  end;
  last_num:=last_num div 26 ;
  cod:=chr(64+num)+cod;
 end;
 result:=cod;
end;

procedure MaterTableToExel(mem_report: TkbmMemTable;
  const title: string;
  title_cols:integer;
  const left_about:string;
  left_cols:integer; about:string;
  list_tytle:string;
   title2:string='');

    var Sheet:  Variant;
      XlApp:variant;
      StartTableRow:integer;
    start_col,  last_col:integer;
    last_row:integer;

    row, col, col_span, row_span:integer;
    ex_col, ex_row:integer;
    lastKOd:string;
    range:string;

    WaitFrm:Tfrm_WaitProcess;
procedure startExel;
begin
  XlApp:=CreateOleObject('Excel.Application');
  XlApp.Workbooks.Add(xlWBatWorkSheet);
  XlApp.Workbooks[1].WorkSheets[1].Name:=list_tytle;
  Sheet:=XlApp.Workbooks[1].WorkSheets[1];
end;
procedure setTitles();
var firstKod,lastKOd:string;

begin
   row:=StartRow;
   start_col:=1;
   firstKod:=chr(64+start_col); //ord('A') 65
   lastKod:= calcod(title_cols+start_col);

   Sheet.cells[Row,start_col].WrapText:=true;
   Sheet.cells[Row,start_col].HorizontalAlignment:=xlCenter ;
   Sheet.cells[Row,start_col]:=title;
   Sheet.Range[firstKod+IntToStr(StartRow)+':'+lastkod+IntToStr(StartRow)].Merge;
   Sheet.cells[Row,start_col].WrapText:=true;
   Sheet.cells[StartRow,start_col].HorizontalAlignment:=xlCenter ;
   Sheet.cells[Row,start_col]:=title;
   Sheet.Range[firstKod+IntToStr(StartRow)+':'+lastkod+IntToStr(StartRow)].Merge;
   row:=row+1;
   if title2<>'' then
   begin
     Sheet.cells[row,start_col].WrapText:=true;
     Sheet.cells[row,start_col].HorizontalAlignment:=xlCenter ;
     Sheet.cells[row,start_col]:=title2;
     Sheet.Range[firstKod+IntToStr(row)+':'+lastkod+IntToStr(row)].Merge;
     StartTableRow:=row+2;
   end;
   row:=row+2;
    if about<>'' then
    begin
     Sheet.Range[firstKod+IntToStr(row)+':'+lastkod+IntToStr(row)].Merge;
     Sheet.cells[row,start_col].HorizontalAlignment:=xlCenter ;
     Sheet.cells[row,start_col]:=about;
   end;
   StartTableRow:=row+2;
  end;

 function textval(val:string; qval:real):string;
 var partval:real;
 begin

  if qval>0 then
   begin
      partval:=qval-floor(qval);
     if partval<0.01 then
      result:=format('%.3f',[qval])
     else
     if partval=0 then
      result:=format('%.0f',[qval])
     else
      result:=format('%.2f',[qval])
   end
   else result:=val;
 end;

 procedure SpanCells(ex_row,ex_col,row_span, col_span:integer);
 var leftcod, rightcod:string;
    toprow, butrow:string;
    range:string ;
 begin
   if (col_span>1) or (row_span>1) then

   begin
    leftcod:=calcod(ex_col);
    rightcod:=calcod(ex_col+col_span-1);
    toprow:=InttoStr(ex_row);
    butrow:=InttoStr(ex_row+row_span-1);
    range:=leftcod+toprow+':'+rightcod+butrow;
    Sheet.Range[range].Merge;
   end;

 end ;

 procedure AvtoRows();
 var row:integer;
 begin
  for row:=1 to StartTableRow+last_row do
  Sheet.Rows[row].EntireRow.AutoFit;
 end;

 begin
 WaitFrm:=Tfrm_WaitProcess.Create(nil);
 WaitFrm.show;
  DecimalSeparator:='.';
  last_col:=0;
  last_row:=0;
  StartTableRow:=StartRow;
   start_col:=1;
   startExel();
   try

   setTitles();

   mem_report.First;
   while not mem_report.Eof do
    begin
      row:=mem_report.fieldbyname('row_num').AsInteger;
      col:=mem_report.fieldbyname('col_num').AsInteger;
      col_span:=mem_report.fieldbyname('col_span').AsInteger;
      row_span:=mem_report.fieldbyname('row_span').AsInteger;
      ex_col:=start_col+col;
      ex_row:=StartTableRow+row;

      Sheet.cells[ex_row,ex_col].WrapText:=true;

      if (row<3) or (col<3) then
        Sheet.cells[StartTableRow,ex_col].HorizontalAlignment:=xlCenter
       else
        Sheet.cells[StartTableRow,ex_col].HorizontalAlignment:=1 ;
      Sheet.cells[ex_row,ex_col]:=textval(mem_report.fieldbyname('val').AsString,mem_report.fieldbyname('qval').AsFloat );
      if (col=0) and (row>3) then
       Sheet.cells[ex_row,ex_col].NumberFormat:='00000000000';
       SpanCells(ex_row,ex_col,row_span, col_span);

      if col>last_col then
       last_col:=col;
      if row>last_row then
       last_row:=row;

       mem_report.Next;
    end;
    Sheet.Range['A2:A2'].RowHeight :=70;
    lastKod:=calcod(last_col+start_col);
    range:=format('%s%d:%s%d',['A',StartTableRow,lastKod,2+ StartTableRow]);
    Sheet.Range[range].Borders.LineStyle:=xlContinuous;
    Sheet.Range[range].Borders.Weight:=2;

    range:=format('%s%d:%s%d',['A',4+ StartTableRow,lastKod,last_row+ StartTableRow]);
    Sheet.Range[range].Borders.LineStyle:=xlContinuous;
    Sheet.Range[range].Borders.Weight:=2;

    range:=format('%s%d:%s%d',['C',4+ StartTableRow,lastKod,last_row+ StartTableRow]);
    Sheet.Range[range].ColumnWidth:=8;
    Sheet.Range['B1:B20'].ColumnWidth:=50;
    Sheet.Range['A1:'+format('%s%d',[lastKod,last_row+ StartTableRow])].Font.Name := 'Arial';
   AvtoRows();
  finally
     WaitFrm.Close;
    WaitFrm.free;

  end;
   XLApp.DisplayAlerts := False;
  XlApp.Visible := True;

end;

end.
