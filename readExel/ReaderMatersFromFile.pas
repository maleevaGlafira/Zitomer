unit ReaderMatersFromFile;

interface
uses Classes, Variants,SysUtils, ReadDataExel,ReadMatersMatersToExel;

const F_needListCount=1;
const F_needWorkBoks=1;
const Error_FileNotFound='Файл не найден!!';
const Error_OpenFile='Не могу создать объект';
const Warmimg_ToManyWorkBooks = 'Слишком много книг в документе должна быть одна';
const  Warning_ToManySheets = 'Слишком много листов в документе должна быть один';
const Error_ReadExel = 'Ошибка чтения файла ';
const Error_IncorrectTitleRow = 'Неправильная строка заголовка Ожмдалось "Матеріальний звіт по материалах за Период:  2021 г."';
const Error_IncorrectTitleTableRow = 'Неправильная строка заголовка  тоблицы';
const Error_closeFile = 'Ошибка закрітия файла!!';
const Error_readYear = 'Не могу прочитаьт год';

type TReaderMatersFromFile =class
private
 Excel : Variant;
 WorkSheet : Variant;

 F_name:String;


 function StartExel:boolean;
 function EndExel:boolean;
 function checkSheets:boolean;
 protected
  f_error:String;
  num_year, num_month:integer;
 year_row:string;
 start_col:integer;
 title_row, year_row:integer;
 title_table_row,start_table_row:integer;
 col_names:array [1..20] of string;
 function getDataFromTitleRow():boolean; virtual;
 function SetStartRows:boolean;virtual;

 function Checker(cell:variant):boolean; virtual;
public
 constructor Create(fname:string);
 destructor Destroy;
 function doRead(): boolean;
end;

implementation

uses ComObj;

constructor TReaderMatersFromFile.Create(Fname:string);
begin
   F_name:=fname;
end;

function TReaderMatersFromFile.StartExel():boolean;
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


function TReaderMatersFromFile.EndExel:boolean;
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

function TReaderMatersFromFile.checkSheets:boolean;
begin

  result:=false;
  if Excel.Workbooks.Count>F_needWorkBoks then
     f_error := Warmimg_ToManyWorkBooks
  else
   if Excel.Workbooks[1].WorkSheets.Count>F_needListCount then
     f_error := Warning_ToManySheets
     else
      result:=true;

end;

function TReaderMatersFromFile.SetStartRows:boolean;
var i:integer;
    is_start:integer;
    s:string;
begin
    result:=false;
    i:=1;
    is_start:=0;
    year_row:=-1;
    title_row:=-1;
    start_table_row:=-1;
    try
    s:=VarToStr( WorkSheet.Cells[i,StartCol] );
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
    end;


end;

function TReaderMatersFromFile.getDataFromTitleRow():boolean;
var s, s_year:string;
p, i:integer;
begin
 result:=false;
if year_row>0 then
begin
   num_month:=0;
   num_year:=0;
   s:=trim(WorkSheet.Cells[year_row,StartCol]);
   p:=pos('г.',s);
   if p<=0 then
    p:=pos('р.',s);
   if p>0 then
   begin
     i:=p-1;
     s_year:='';
     while s[i]=' ' do
      i:=i-1;
     while (s[i]  in Digits) do
     begin
       s_year:=s[i]+s_year;
       i:=i-1;
     end;
     try
      num_year:=StrToInt(s_year);
     except on e:exception do
       F_error:= Error_readYear;
     end;
     for i:=1 to 12 do
     begin
       if pos(monthes_rus[i], s)>0 then num_month:=i;
     end;
     result:=(num_month>0)and(num_year>0);
   end
   else
    F_error:=Error_IncorrectTitleRow;
end;
end;

function TReaderMatersFromFile.Checker(cell:variant):boolean;
var numform:string;
begin
 numform:=cell.NumberFormat;
 result:=pos('0',numform)<=0;
end;

function TReaderMatersFromFile.doRead():boolean;
var readerExel:TReadTittleTableExel;
begin
  if StartExel then
    begin
     try
      if checkSheets() then
       if SetStartRows() then
         if  getDataFromTitleRow() then
           begin
             readerExel:=TReadTittleTableExel.Create(WorkSheet, title_table_row,start_table_row, start_col,col_names);
             
           end;
      finally
       EndExel;
      end;
end;

end.
