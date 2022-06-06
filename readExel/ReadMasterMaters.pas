unit ReadMasterMaters;

interface
 uses ReaderFromExelFile, ExelError ;
 type
 TreadMasterMaters = class(TReaderFromExelFile)
 private
   num_year, num_month:integer;
 protected
 function getDataFromTitleRow():boolean; override;
 function SetStartRows:boolean;override;

 function Checker(cell:variant):boolean; override;
  public
   property n_year:integer read num_year;
   property n_month:integer read num_month;

 end;
 const max_cols=20;
  const  StartCol=2;

implementation

uses Classes, Variants,SysUtils;


function TreadMasterMaters.SetStartRows:boolean;
var i:integer;
    is_start:integer;
    s:string;
begin
    result:=false;
    i:=1;
    is_start:=0;
    year_row:=-1;
    title_table_row:=-1;
    start_table_row:=-1;
    start_col:=2;
    try
    s:=VarToStr( WorkSheet.Cells[i,start_col] );
    while (i<200)and (is_start<2)  do begin
      if pos(StartYearWord,s)>0 then
          year_row:=i;
      if pos(StartTableWord,s)>0 then
      begin
       is_start:=is_start+1;
       title_table_row:=i;
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
    result:=(is_start=2)and(title_table_row>0)and(start_table_row>0)and (year_row>0);
    if not result then F_error:=Error_IncorrectReport;
    except on e:exception do
        f_error :=  Error_ReadExel+' ('+e.message+')';
    end;
end;

function TreadMasterMaters.getDataFromTitleRow():boolean;
var s, s_year:string;
p, i:integer;
col_list:TStringList;
begin
   col_names.Add(StartTableWord);
   col_names.Add(NameWord);
   col_names.Add(UnitWord);
   col_names.Add(PriceWord);
   col_list:=TStringList.Create;
   col_list.Add(EndSaldWord);
   col_list.Add(LeftWord);
   col_names.AddObject(EndSaldWord, TObject(col_list));

 result:=false;
if year_row>0 then
begin
   num_month:=0;
   num_year:=0;
   s:=trim(WorkSheet.Cells[year_row,StartCol]);
   p:=pos('ã.',s);
   if p<=0 then
    p:=pos('ð.',s);
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

function TreadMasterMaters.Checker(cell:variant):boolean;

  var numform:string;
begin
try
 numform:=cell.NumberFormat;
 result:=pos('0',numform)<=0;
except on e:Exception do
begin
  result:=true;
  f_error:=e.message;
end;
end;


 end;

end.
