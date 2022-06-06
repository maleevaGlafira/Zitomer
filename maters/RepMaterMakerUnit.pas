unit RepMaterMakerUnit;

interface

uses IBDatabase, DB, IBCustomDataSet, kbmMemTable,  Grids, Aligrid;

const Err_openDset = 'Порожні набори даних';
const Err_EptyObjects = 'Не визначено вхідні дані';
const Err_Title = 'Помилка фориування заголовків';


type TRepMaterMake = class
private
  grid:TStringAlignGrid;
   dset_materdep:TIBDataSet;
  mem_deps, dset_report:TDataSet;
 function PrepareTitleRow():boolean;
public
constructor Create(grid:TStringAlignGrid; mem_deps, dset_report:TDataSet; dset_materdep:TIBDataSet);
destructor Destroy();
function DoReport():string;
end;

implementation
uses ExelError, SysUtils;

constructor TRepMaterMake.Create(grid:TStringAlignGrid; mem_deps, dset_report:TDataSet; dset_materdep:TIBDataSet);
begin
 self.grid:=grid;
 self.dset_materdep:=dset_materdep;
 self.mem_deps:=mem_deps;
 self.dset_report:=dset_report;
end;

destructor  TRepMaterMake.Destroy;
begin

self.grid:=nil;
 self.dset_materdep:=nil;
 self.mem_deps:=nil;
 self.dset_report:=nil;
end;

function TRepMaterMake.DoReport():string;

begin
  if (mem_deps=nil) or (dset_report=nil) and (grid=nil) and  (dset_materdep=nil) then
   result:= Err_EptyObjects
  else
  if not ((mem_deps.Active) and  (dset_report.Active)) then
   result:=Err_openDset
  else
  begin
     if PrepareTitleRow() then
     begin
     end
     else
      result:=Err_Title;



  end;


end;

 function TRepMaterMake.PrepareTitleRow():boolean;
 var i:integer;
 begin
   result:=false;
   grid.Cells[0,0]:=UpperCase(StartYearWord);
   grid.Cells[1,0]:=UpperCase(NameWord+NameWord2);
   grid.Cells[2,0]:=UnitWord;
   grid.Cells[3,0]:=LeftWord;
   grid.Cells[4,0]:=SumWord;
   mem_deps.First;
   i:=5;
   try
   while not mem_deps.Eof do
   begin
    grid.Cells[i,0]:=mem_deps.fieldbyname('n_col').AsString;
    i:=i+1;
    mem_deps.Next;
   end;
   result:=true;
   except on e:exception do
    result:=false;
   end


 end;
end.
