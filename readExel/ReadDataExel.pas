unit ReadDataExel;


interface
uses Classes, Variants,SysUtils;





const error_row = 'Непраильный формат данных на строке';
const Error_ReadExel = 'Ошибка чтения файла ';

type TWriteData = function(list:TStringList):string of object;
type TCheckEnd  =function(cell:Variant):boolean of object;
type TReadDataExel = class
private
 WorkSheet:Variant;
 f_startCol:integer;
 F_start_row:integer;
 F_col_nums:array[0..120] of integer;
 f_writerData:TWriteData;
 f_checkEnd:TCheckEnd;
 f_curList:TStringList;
 f_err:string;
 function readData(row:integer):boolean;
 function ToCellFormat(cell:variant):string;
public

 constructor Create(wSheet:Variant; start_row:integer;
                    startCol:integer;
                    col_nums:array of integer;
                    writerData:TWriteData;
                     checkerEnd:TCheckEnd);
  destructor Free();
 property err:string read F_err;

 function readDatas():boolean;
end;

implementation

constructor TReadDataExel.Create(wSheet:Variant; start_row:integer;
                    startCol:integer;
                    col_nums:array of integer;
                    writerData:TWriteData;
                     checkerEnd:TCheckEnd);
var i:integer;
begin
  WorkSheet:=wSheet;
  f_start_row:=start_row;

  f_writerData:=writerData;
  f_checkEnd:=checkerEnd;
  f_startCol:=startCol;
  f_err:='';
  for i:=0 to length(col_nums)-1 do
  begin
   f_col_nums[i]:=col_nums[i];
  end;
  f_curList:=TStringList.Create;
end;

destructor TReadDataExel.Free();
begin
 WorkSheet:=varNull;
 f_curList.Free;
end;

function TReadDataExel.readDatas:boolean;
var s:string;
row:integer;
begin
 result:=false;
 f_err:='';
 row:=f_start_row;
 s:=WorkSheet.Cells[row,f_StartCol];
 while(row<f_start_row+3600)and (s<>'') and (not f_checkEnd(WorkSheet.Cells[row,f_StartCol])) do
 begin
   if not readData(row) then
   begin

    f_err:=error_row+' '+inttoStr(row)+' ' +f_err;
    result:=false;
    break;
   end;
   result:=true;
   row:=row+1;
   s:=WorkSheet.Cells[row,f_StartCol];

 end;

end;

function TReadDataExel.readData(row:integer):boolean;
var j:integer;
    s:string;
begin
result:=false;
f_curList.Clear;
try
for j:=0 to length(F_col_nums)-1 do
 if F_col_nums[j]>=f_startCol then
 begin
 s:=ToCellFormat(WorkSheet.Cells[row,F_col_nums[j]]);
  f_curList.add(s);
 end
 else
 break;
 if assigned(f_writerData) then
  begin
    f_err:=f_writerData(f_curList);
    result:= (F_err='');
   end;
except on e:exception do
begin
 result:=false;
 f_err:=Error_ReadExel+' '+e.Message;
end;
end;
end;

function TReadDataExel.ToCellFormat(cell:variant):string;
 var pf, ps:integer;
 numform,val:string;

begin
  numform:=cell.NumberFormat;
  val:=cell;
  if numform='00000000000'  then
  begin

   pf:=length(numform);

   ps:=length(val);
   while (ps>0) and (pf>0) do
   begin
    if numform[pf]='0' then
     begin
      numform[pf]:=val[ps];
      ps:=ps-1;
     end;
     pf:=pf-1;
   end;
     result:=numform;
  end
  else
  result:=val;
end;

end.
