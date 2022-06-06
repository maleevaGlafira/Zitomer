unit ShiftDmodule;

interface

uses
  SysUtils, Classes,DMmain, DB, IBCustomDataSet,Controls, IBDatabase,OperAttFormUnit ;

type
  ShiftName = record
    id:integer;
   name:string;
 end;

 PShiftName = ^ShiftName;


  Tdm_Shift = class(TDataModule)
    dset_shift: TIBDataSet;
    dset_shiftnum: TIBDataSet;
    tran: TIBTransaction;
    dsetShifts: TIBDataSet;
    dset_idshiftZav: TIBDataSet;
    dset_shiftRevs: TIBDataSet;
  private
    { Private declarations }
     F_shiftDate:TDate;
     F_shiftNum:Integer;
    function converttypToStr(typ:TOperAtt):string;
    function getIdShiftByZav(id_zav:integer):integer;
    function getIdShiftByRevs(id_revs:integer):integer;
  public
    { Public declarations }
   function isNeedChangeShift(typ:TOperAtt;id_shift:integer=-1):boolean;
   procedure getShiiftNumber(id_shift:integer; var num:integer;var dat:TDate);
   function perMitDoChangeShift(id_shift:integer;var nums: string;var  dat: TDate):boolean;

   function datInCurShift(id_shift:integer; dat:TdateTime):boolean;

   function datInCurShiftRevs(id_revs:integer; dat:TdateTime):boolean;
   function datInCurShiftZavjav(id_zav:integer; dat:TdateTime):boolean;

   function getShiftDate(id_shift:integer):TDateTime;
   function getShiftDateZavjav(id_zav:integer):TDateTime;
   function getAllShiftName():TList;
  end;

const    StrShiftTimeBegin = '08:00';
         StrShiftTimeEnd = '08:00';
         sel_notclosednar = ' select z.nomer, z.dt_in,sa.name_r '+
                               ' from narad n join  zavjav z on n.id_zav=z.id '+
                               ' join s_attach sa on  sa.id=z.id_attach '+
                               '  join s_revs sr on sr.id =z.id_revs '+
                               '  join servanttable st on st.id=sr.id_shift and st.id=:id_shift '+
                               '  where ((n.dt_in>:dat -60   and n.dt_in<:dat +1)  '+
                               '  or (n.dt_dep>:dat-60   and  n.dt_dep<:dat +1)) '+
                               '  and n.dt_out is null '+
                               '  union '+
                               '  select z.nomer, z.dt_in,sa.name_r '+
                               '  from nnarad n join  nzavjav z on n.id_zav=z.id '+
                               '  join s_attach sa on sa.id=z.id_attach'+
                               '  join s_revs sr on sr.id =z.id_revs '+
                               '  join servanttable st on st.id=sr.id_shift and st.id=:id_shift '+
                               '  where ((n.dt_in>:dat -60   and n.dt_in<:dat +1)  '+
                               '  or (n.dt_dep>:dat-60   and  n.dt_dep<:dat +1)) '+
                               '  and n.dt_out is null ';

var
  dm_Shift: Tdm_Shift;

implementation
uses Math,Variants;

{$R *.dfm}

function Tdm_Shift.isNeedChangeShift(typ: TOperAtt; id_shift:integer): boolean;
var shiftDate :TDateTime;
    tim:TDateTime;
    curtim:TDateTime;
    timsmen:TdateTime;
    typStr:string;
begin
typStr:=converttypToStr(typ);
if  dset_shift.Active then
  dset_shift.Close;
 dset_shift.Open;
dset_shift.First;
result:=false;
tim:=StrToTime(StrShiftTimeBegin);
shiftDate:=int(dm_main.getTime());
curtim:=frac(DM_Main.getTime);
if curtim<StrToTime(StrShiftTimeBegin) then
     shiftDate:=shiftDate-1;

while not dset_shift.Eof do
begin
if dset_shift.FieldByName('id').AsInteger=id_shift then
begin
 if shiftDate>dset_shift.FieldByName('SHIFTDATE').AsDateTime
  then
   result:=true
  else
   result:=false;
  break;
end;
 if dset_shift.FieldByName('SHIFTTYPE').AsString = typStr then
 begin


   timsmen:=dset_shift.FieldByName('SHIFTDATE').AsDateTime;
   if shiftDate>timsmen then
     result:=true

  else
  begin
      result:=false;
     break;

  end;

 end;
 dset_shift.Next;
end;
dset_shift.Close;

end;

procedure Tdm_Shift.getShiiftNumber(id_shift: integer; var num: integer;
var  dat: TDate);
  var typStr:string;
begin
//typStr:=converttypToStr(typ);
if  dset_shift.Active then
 dset_shift.Close;
dset_shift.Open;
 if  dset_shift.Locate('id',VarArrayOf([id_shift]),[loCaseInsensitive]) then
 begin
   num:= dset_shift.fieldByName('SHIFTNUMBER').AsInteger;
   dat:=dset_shift.fieldByName('SHIFTDate').asdatetime;
 end;
 F_shiftDate:=dat;
 F_shiftNum:=num;
end;

function Tdm_Shift.perMitDoChangeShift(id_shift:integer;var nums: string;
  var dat: TDate): boolean;
var strShidtDate:string;
    strMes:string;
    typStr:string;
begin
nums:='';
 // typStr:=converttypToStr(typ);
  getShiiftNumber(id_shift,F_shiftNum,F_shiftDate);
  if dset_shiftnum.Active then
   dset_shiftnum.Close;
  strShidtDate:=DateToStr(F_shiftDate)+' '+StrShiftTimeBegin;
  dset_shiftnum.SelectSQL.Text:=sel_notclosednar;
  dset_shiftnum.ParamByName('dat').AsString:=strShidtDate;
  dset_shiftnum.ParamByName('id_shift').AsInteger:=id_shift;
{  if (typ = toaVoda)or(typ = toaObjVoda) then
  begin
    dset_shiftnum.ParamByName('ida1').AsInteger:=1;
    dset_shiftnum.ParamByName('ida2').AsInteger:=4;

  end;
  if  (typ = toaKanal) or (typ = toaObjKanal) then
  begin
    dset_shiftnum.ParamByName('ida1').AsInteger:=2;
    dset_shiftnum.ParamByName('ida2').AsInteger:=5;

  end;
 }
  dset_shiftnum.Open;
  if dset_shiftnum.RecordCount>0 then
  begin

    result:=false;
    dset_shiftnum.First;
    while not dset_shiftnum.Eof do
    begin
      nums:=nums+', ¹'+dset_shiftnum.FieldByName('nomer').asstring;
      dat:=dset_shiftnum.FieldByName('dt_in').AsDateTime;
      dset_shiftnum.Next;
    end;
    delete(nums,1,1);
  end
  else
  result:=true;
end;

function Tdm_Shift.converttypToStr(typ: TOperAtt): string;
begin
 case typ of
 toaNull,toaVoda , toaObjVoda:result:='V';
 toaObjKanal,toaKanal :result:='K';
 else result:='V';
 end;
end;

function Tdm_Shift.datInCurShift(id_shift: integer; dat: TdateTime): boolean;
  var  _shiftNum:integer;
  _shiftDate:TDate;
begin
  _shiftDate:=0;
  getShiiftNumber(id_shift,_shiftNum,_shiftDate);
  result :=(int(F_shiftDate)+StrToTime(StrShiftTimeBegin)<=dat) and (int(F_shiftDate)+StrToTime(StrShiftTimeEnd)+1>=dat);
end;

function Tdm_Shift.getShiftDate(id_shift: integer): TDateTime;
var dat:TDate;
    num:integer;
begin
  getShiiftNumber(id_shift,num,dat);
  result:=dat;
end;

function Tdm_Shift.getAllShiftName: TList;
var item:PShiftName;
    resultList:TList;
begin
 resultList:=TList.Create;
 if dsetShifts.Active then
  dsetShifts.Close;
 dsetShifts.open;
 while not dsetshifts.Eof do
 begin
   new(item);
   item^.name:=dsetShifts.FieldByName('shiftName').AsString;
   item^.id:=dsetShifts.FieldByName('id').AsInteger;
   resultList.Add(item);
   dsetshifts.Next;
 end;
 result:=resultList;
end;

function Tdm_Shift.datInCurShiftRevs(id_revs: integer;
  dat: TdateTime): boolean;
  var id_shift:integer;
begin
result:=true;
id_shift:=getIdShiftByRevs(id_revs);
if id_shift>0 then
 result:=datInCurShift(id_shift,dat);

end;

function Tdm_Shift.datInCurShiftZavjav(id_zav: integer;
  dat: TdateTime): boolean;
  var id_shift:integer;
begin
id_shift:=getIdShiftByZav(id_zav);
if id_shift>0 then
result:=datInCurShift(id_shift,dat)
else
 result:=false;
end;

function Tdm_Shift.getShiftDateZavjav(id_zav: integer): TDateTime;
var id_shift:integer;
begin
id_shift:=getIdShiftByZav(id_zav);
if id_shift>0 then
  result:=getShiftDate(id_shift)
else
 result:=0;
end;



function Tdm_Shift.getIdShiftByZav(id_zav: integer): integer;
begin
try
    if dset_idshiftZav.Active then
      dset_idshiftZav.close;
    dset_idshiftZav.ParamByName('id_zav').AsInteger:=id_zav;
    dset_idshiftZav.Open;
    dset_idshiftZav.First;
    if not dset_idshiftZav.FieldByName('id_shift').IsNull then
     result:=dset_idshiftZav.fieldbyname('id_shift').AsInteger
    else
    begin
     dset_idshiftZav.Next;
     result:=dset_idshiftZav.fieldbyname('id_shift').AsInteger;
    end;
    dset_idshiftZav.Close;
except
 result:=-1;
end
end;

function Tdm_Shift.getIdShiftByRevs(id_revs: integer): integer;
begin
try
 if dset_shiftRevs.Active then
  dset_shiftRevs.Close;
 dset_shiftRevs.ParamByName('id_revs').AsInteger:=id_revs;
 dset_shiftRevs.Open;
 result:=dset_shiftRevs.fieldByName('id_shift').AsInteger;
 dset_shiftRevs.Close;
 except
  result:=-1;
 end;
end;

end.
