unit SimpleGridToExel;


interface
 uses WaitProcessForm, ServiceFuncUnit, OperAttFormUnit, cntsLANG, ComObj, XLConst,
Types, Classes, Controls,  FR_Class, Aligrid, DB, Graphics, SysUtils;


procedure GridToExel( Grid: TStringAlignGrid;title:string;titlereport:string;const about: array of string);

implementation

procedure GridToExel( Grid: TStringAlignGrid;title:string;titlereport:string;const about: array of string);
var XlApp:variant;
     Sheet: Variant;

     i,j,colw:integer;
     WaitFrm :Tfrm_WaitProcess;
   //  let:char;
//     Range:variant;

    lastkod:char;
    startReportRow:integer;
    strrange:string;
begin
//
 WaitFrm:=Tfrm_WaitProcess.Create(nil);
 WaitFrm.show;
TRy
  XlApp:=CreateOleObject('Excel.Application');

  XlApp.Workbooks.Add(xlWBatWorkSheet);
  XlApp.Workbooks[1].WorkSheets[1].Name:='Лист1';
  Sheet:=XlApp.Workbooks[1].WorkSheets[1];

  Sheet.cells[1,1]:=titlereport;

  lastkod:=chr(64+grid.ColCount); //ord('A') 65
  Sheet.Range['A1:'+lastkod+'1'].Merge;
  XlApp.Range['A1:'+lastkod+'1'].HorizontalAlignment:=xlCenter;
  XlApp.Range['A1:'+lastkod+'1'].Font.Bold := True;
  Sheet.cells[2,1]:=titlereport;
  Sheet.Range['A2:'+lastkod+'2'].Merge;
  XlApp.Range['A2:'+lastkod+'2'].HorizontalAlignment:=xlLeft;
  Sheet.cells[1,2].WrapText:=true;
  XlApp.Range['A2:'+lastkod+'2'].Font.Bold := True;
  startReportRow:=4;
  for i:=Low(about) to high(about) do
  begin

   Sheet.Range['A'+IntToStr(startReportRow-1)+':'+lastkod+IntToStr(startReportRow-1)].Merge;
   Sheet.cells[startReportRow-1,1]:=about[i];
   Sheet.cells[startReportRow-1,1].WrapText:=true;
   startReportRow:=startReportRow+1;

  end;
 // Sheet.cells[3,1]:=about;
  //table title
  for j:=0 to grid.ColCount-1 do
  begin
    Sheet.cells[startReportRow,j+1]:=Grid.Cells[j,0];
    Sheet.cells[startReportRow,j+1].HorizontalAlignment:=xlCenter ;
    Sheet.cells[startReportRow,j+1].Font.Bold := True;
    Sheet.cells[startReportRow,j+1].Borders.LineStyle:=xlContinuous;
    Sheet.cells[startReportRow,j+1].Borders.Weight:=4;
    //И включаем перенос по словам:
    Sheet.cells[startReportRow,j+1].WrapText:=true;
    strrange:=chr(65+j)+':'+chr(65+j);
    colw:=Grid.ColWidths[j];
     Sheet.Columns.Range[strrange].ColumnWidth :=30;
  end;

  for i:=1 to Grid.RowCount-1 do
    for j:=0 to Grid.ColCount-1 do begin
      Sheet.cells[startReportRow+i,j+1]:=trim(Grid.Cells[j,i]);
      Sheet.cells[startReportRow+i,j+1].HorizontalAlignment:=1  ;
      Sheet.cells[startReportRow+i,j+1].Borders.LineStyle:=xlContinuous;
      if length(trim(Grid.Cells[j,i]))<5 then
       Sheet.cells[startReportRow+i,j+1].HorizontalAlignment:=xlCenter ;
    // Sheet.cells[4+i,j+1].WrapText:=true;
    Sheet.cells[startReportRow+i,j+1].Borders.Weight:=2;
    Sheet.cells[startReportRow+i,j+1].WrapText:=true;
//    Sheet.cells[startReportRow+i,j+1].ColumnWidth:= Grid.ColWidths[j];



     //[chr(64+j)+':'+chr(64+j)].ColumnWidth:= Grid.ColWidths[j];
    end;

  Sheet.Range['A'+InttOStr(startReportRow)+':'+lastkod+IntToStr(Grid.RowCount+startReportRow)].Columns.AutoFit ;
  Sheet.Range['A4:'+lastkod+IntToStr(Grid.RowCount+startReportRow)].Rows.AutoFit ;
finally
    WaitFrm.Close;
    WaitFrm.free;

end;
  XLApp.DisplayAlerts := False;
  XlApp.Visible := True;

end ;




end.
