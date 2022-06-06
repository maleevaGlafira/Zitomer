unit TReadTittleTableExel;

interface
uses Classes, Variants,SysUtils, ReadDataExel;
const  Err_Read_Cols_totle = 'Ошибка чтения заголовков колонок!! ';
const  Err_Find_all_titles = 'Неправильно прочитаны колонки';

type
TReadTittleTableExel = class
private
 WorkSheet:Variant;
 //Excel:Variant;
 col_nums:array [0..10] of integer;

 title_table_row, start_table_row:integer;
 start_col:integer;
 cols_name:TStringList;

 f_err:string;
 protected
 function writeData(list:TStringList):string;  virtual;
 function CheckEnd(cell:Variant):boolean; virtual;

 public
 constructor Create(Sheet:Variant; title_row,start_row:integer;start__col:integer; names:tStringList);
// destructor Destroy();
 function setCols() :boolean;
 function DoRead():boolean;
 property err_mes:string read f_err;
end;

implementation

constructor TReadTittleTableExel.Create(Sheet:Variant; title_row,start_row:integer;start__col:integer; names:tStringList);
begin
 WorkSheet:=Sheet;
 title_table_row:=title_row;
 cols_name:=names;
 start_col:=start__col;
 F_err:='';
 start_table_row:=start_row;
end;

function  TReadTittleTableExel.setCols():boolean;
var i,j :integer;
s:string;
begin
  result:=false;
  j:=0;
  try
  for i:=start_col to start_col+2000 do
  begin
     s:= trim(WorkSheet.Cells[title_table_row,i]);
     if pos(cols_name[j],s)>=0 then
     begin
      col_nums[j]:=i;
      j:=j+1;
      if j>=cols_name.Count then
       begin
        result:=true;
        break;
       end
     end;

  end;
  except on e:exception do
  begin
     f_err:=Err_Read_Cols_totle+' '+e.Message;
  end;

  end;
end;

function TReadTittleTableExel.DoRead():boolean;
var readerExel:TReadDataExel;
begin
result:=false;
 if setCols() then
  begin

    readerExel:=TReadDataExel.Create(WorkSheet,start_table_row,
             start_col,col_nums,writeData,CheckEnd);
             try
               if not readerExel.readDatas() then
               begin
                 F_err:=readerExel.err;
                  result:=false;
               end else result:=true;
             finally
              readerExel.Free;
             end;

  end
  else f_err:=Err_Find_all_titles;
end;

function TReadTittleTableExel.writeData(list:TStringList):string;
begin
result:='';
end;


function TReadTittleTableExel.CheckEnd(cell:Variant):boolean;
begin
result:=false;
end;



end.
