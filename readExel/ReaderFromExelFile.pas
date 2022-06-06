unit ReaderFromExelFile;

interface
uses Classes, Variants,SysUtils, ReadDataExel,ReadTittleTableExel;

const F_needListCount=1;
const F_needWorkBoks=1;


type TReaderFromExelFile =class
private
 Excel : Variant;


 F_name:String;
 F_writerData:TWriteData;


 function StartExel:boolean;
 function EndExel:boolean;
 function checkSheets:boolean;
 protected
  WorkSheet : Variant;
  f_error:String;


 start_col:integer;
 year_row:integer;
 title_table_row,start_table_row:integer;
  col_names:TStringList;

 function getDataFromTitleRow():boolean; virtual;
 function SetStartRows:boolean;virtual;

 function Checker(cell:variant):boolean; virtual;


public
 constructor Create(fname:string; writerData:TWriteData);
 destructor Destroy; override;
 function doRead(): boolean;
 property error:string read F_error;
end;

implementation

uses ComObj,ExelError;

constructor TReaderFromExelFile.Create(Fname:string;writerData:TWriteData);
begin
   F_name:=fname;
   col_names:=TStringList.Create;
   F_writerData:=writerData;
end;

destructor TReaderFromExelFile.Destroy;
var i:integer;
begin
for i:=0 to col_names.Count-1  do
if col_names.Objects[i]<>nil then
  col_names.Objects[i].Free;
  col_names.Free;
end;

function TReaderFromExelFile.StartExel():boolean;
begin
result:=false;

if FileExists(f_name)then
begin
   try
     Excel := CreateOleObject('Excel.Application');
     Excel.Visible := False;
     Excel.Workbooks.Open( F_name );
     WorkSheet:=Excel.Workbooks[1].WorkSheets[1];
     result:=true;
   except  on e:exception do
       f_error:=Error_OpenFile+' '+e.Message;
   end;

end
else
f_error:=Error_FileNotFound;
end;


function TReaderFromExelFile.EndExel:boolean;
begin
 result:=false;
 try
  Excel.Workbooks.Close;
  Excel.Quit;
  result:=true;
  Excel:=varnull;
  except on e:exception do
   F_error:=Error_closeFile;
 end;
end;

function TReaderFromExelFile.checkSheets:boolean;
begin

  result:=false;
  if Excel.Workbooks.Count=0 then  f_error := Error_Emty_exel
  else
  if Excel.Workbooks.Count>F_needWorkBoks then
     f_error := Warmimg_ToManyWorkBooks
  else
    begin
     if Excel.Workbooks[1].WorkSheets.Count=0 then f_error := Error_Emty_exel
    else
   if Excel.Workbooks[1].WorkSheets.Count>F_needListCount then
     f_error := Warning_ToManySheets
     else
      result:=true;
    end

end;

function TReaderFromExelFile.SetStartRows:boolean;
{var i:integer;
    is_start:integer;
    s:string;}
begin
    result:=false;
{    i:=1;
    is_start:=0;
    year_row:=-1;
    title_row:=-1;
    start_table_row:=-1;
    try
    s:=VarToStr( WorkSheet.Cells[i,start_col] );
    while (i<200)and (is_start<2)  do begin
      if pos(StartYearWord,s)>0 then
          year_row:=i;
      if pos(StartTableWord,s)>0 then
      begin
       is_start:=is_start+1;
       title_row:=i;
      end
      else
      if is_start=1 then
       if s<>'' then
       begin
       is_start:=is_start+1;
       start_table_row:=i;
       end;
      i:=i+1;
      s:=VarToStr( WorkSheet.Cells[i,StartCol] );
    end;
    result:=(is_start=2)and(title_row>0)and(start_table_row>0)and (year_row>0);
    if not result then F_error:=Error_IncorrectReport;
    except on e:exception do
        f_error :=  Error_ReadExel+' ' + F_name+'('+e.message+')';
    end;    }


end;

function TReaderFromExelFile.getDataFromTitleRow():boolean;

begin
 result:=false;

end;

function TReaderFromExelFile.Checker(cell:variant):boolean;

begin
 result:=false;
end;

function TReaderFromExelFile.doRead():boolean;
var readerExel:TReadTittleTableExel;
begin
   result:=false;
  if StartExel then
    begin
     try
      if checkSheets() then
       if SetStartRows() then
         if  getDataFromTitleRow() then
           begin
             readerExel:=TReadTittleTableExel.Create(WorkSheet, title_table_row,start_table_row, start_col,col_names);
             readerExel.WriterData:=f_writerdata;
             readerExel.checkerend:=Checker;
             try
              result:= readerExel.DoRead();
              if not result then  f_error:= readerExel.err_mes;
             finally
               readerExel.Free;
             end;

           end;
      finally

       EndExel;
      end;
     end;
end;



end.
