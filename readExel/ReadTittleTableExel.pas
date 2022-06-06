unit ReadTittleTableExel;

interface
uses Classes, Variants,SysUtils, ReadDataExel;


type
TReadTittleTableExel = class
private
 WorkSheet:Variant;
 //Excel:Variant;
 col_nums:array [0..10] of integer;

 title_table_row, start_table_row:integer;
 start_col:integer;


 f_err:string;
 protected
 F_writerData:TWriteData;
 f_checker:TCheckEnd;
 cols_name:TStringList;
 function writeData(list:TStringList):string;
 function CheckEnd(cell:Variant):boolean;

 public
 constructor Create(Sheet:Variant; title_row,start_row:integer;start__col:integer; names:tStringList);
// destructor Destroy();
 function setCols() :boolean;
 function DoRead():boolean;
 property err_mes:string read f_err;
 property checkerend:TCheckEnd write f_checker;
 property WriterData : TWriteData write F_writerData;
end;

implementation
uses ExelError;

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
function check(ind_name, col:integer; var is_break:boolean):boolean;
 var listname:TStringList;
 ind:integer;
 s:string;
begin
 result:=false;
 is_break:=false;
  s:=WorkSheet.Cells[title_table_row,col];

 if cols_name.Objects[ind_name]=nil then
  result:=(pos(cols_name[ind_name],s)>0)
 else
 begin
  try
  listname:=TStringList(cols_name.Objects[ind_name]);

   for ind:=0 to listname.Count-1 do
   begin
    s:=WorkSheet.Cells[title_table_row+ind,col];
    if pos(listname[ind],s)<=0 then
    begin
     result:=false; break;
    end
   end;
   result:=(ind=listname.Count);

  except on e:exception
   do  begin is_break:=true; f_err:='TReadTittleTableExel Object type not correct!!' end;
  end;

 end

end;
var i,j :integer;
s:string;
is_break:boolean;
begin
  result:=false;
  j:=0;
  try
  for i:=start_col to start_col+2000 do
  begin
     s:= trim(WorkSheet.Cells[title_table_row,i]);

     if check(j,i,is_break ) then
     begin
      col_nums[j]:=i;
      j:=j+1;
      if j>=cols_name.Count then
       begin
        result:=true;
        break;
       end
     end
     else
     if is_break then
      begin
       result:=false;
       break;
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

                 F_err:=readerExel.err+' ' +F_err;
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
 if assigned( f_writerdata) then
   result:=f_writerdata(list)
else
result:='Not define writer data';
end;


function TReadTittleTableExel.CheckEnd(cell:Variant):boolean;
begin
if assigned(f_checker) then
 result:=f_checker(cell)
 else
 begin
  f_err:='Checker not define!!';
  result:=true;
end;
end;



end.
