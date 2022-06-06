unit ServiceFuncUnit;

interface
uses SysUtils,Forms,DBTables,Windows,ComCtrls,strtool,StrUtils,AppErrUnit,
      DateUtils, GridViewBuilder, aligrid, IBCustomDataSet, Graphics, IBSQL;

const MAP_SELECT_SQL=
  '    z.id_attach id_attach, z.nomer narjad_nom, z.dt_in data_soob, z.dt_in time_soob, extract(year from (z.dt_in)) year_soob, '+
  '    (select name_r from s_rayon sr where sr.id=z.id_rayon) rayon, '+
  '    (select name_r from s_ulic su where su.id=z.id_ul1) ul1, '+
  '    z.id_ul2 ul2, z.kod_ul kod_ul, '+
  '    (select name_r from s_vidul svi where svi.id=(select id_vidul from s_ulic su where su.id=z.id_ul1)) vidul, '+
  '    (select name_r from s_sod sso where sso.id=z.id_sod) xar_povr, '+
  '    (select name_r from s_place spl where spl.id=z.id_place) mesto_name, '+
  '    (select diam from s_diam sdi where sdi.id=z.id_diam) diam_diam, '+
  '    z.dt_out data_end, z.dt_out time_end ';

procedure MyExecSQL(Qry_i:TQuery;SQLstr:string);
procedure MyOpenSQL(Qry_i:TQuery;SQLstr:string);
procedure IBOpenSQL(dset: TIBDataSet; SelSQL: string);
procedure IBExecSQL(sql: TIBSQL; ExecSQL: string);
function AntiQuote(value:string):string;
function MyFloatToStr(value:double):string;
function Time2Str(InTime:TDateTime):string;
procedure Add2Memo(TutMemo:TRichEdit;Pref,dop,tStr:string;len:integer);
function SubstKav(value:string):string;
function IfZeroThenEmptyStr(value:string):string;
function MyTimeToStr(_time:TDateTime):string;
procedure ShowErr(_handle:THandle; _mes:string; E:Exception);
function MyTime2Str(ATime: TDateTime): string;
function MyDate2Str(ADate: TDateTime): string;
function AddColToGVB(GridViewBuilder: TGridViewBuilder; const FieldName, ColCaption: string; Align:
                 TMyAlign=alLeft; ShowColumnCellEvent: TShowColumnCellEvent=nil): TGBColumn;
procedure AddSelSQLToIBdset(dset: TIBDataSet; SelSQL: string);
procedure MyOpenIBDS(dset: TIBDataSet; const sel_sql: string);
function IsDateCorrect(strDateTime: string): boolean;
function DeletePusto(s: string): string;


var isTest:boolean;
implementation

function DeletePusto(s: string): string;
begin
  if pos('пусто', AnsiLowerCase(trim(s)))>0 then
    Result:=''
  else
    Result:=s;  
end;



function IsDateCorrect(strDateTime: string): boolean;
var
  dttm: TDateTime;
begin
  try
    dttm:=StrToDateTime(strDateTime);
  except
    Result:=false;
    exit;
  end;
  Result:=true;
end;



procedure MyOpenIBDS(dset: TIBDataSet; const sel_sql: string);
begin
  dset.Close;
  dset.SelectSQL.Clear;
  dset.SelectSQL.Add(sel_sql);
  dset.Open;
end;


procedure WRITE_EXCEPT(_comment:string;E:Exception);
begin
  (Application.MainForm as TAppErrForm).RGAppError.SaveErrString(' -- ('+E.ClassName+') '+_comment+' -- '+E.Message);
end;

procedure ShowErr(_handle:THandle; _mes:string; E:Exception);
begin
  MessageBox(_handle,PChar(_mes+#13+E.Message),'Диспетчер АВР',MB_OK or MB_ICONWARNING);
  WRITE_EXCEPT(_mes,E);
end;

function MyTimeToStr(_time:TDateTime):string;
begin
  DateTimeToString(result,'hh:mm:ss',_time);
end;

function IfZeroThenEmptyStr(value:string):string;
var _d:double;
begin
  try
    _d:=StrToFloat(value);
    if _d>0 then result:=FloatToStr(_d)
      else result:='';
  except
    result:='';
  end;
end;

{28.09.2004}
function SubstKav(value:string):string;
var i:integer;
begin
  result:=Trim(value);
  i:=POS('"',result);
  while i<>0 do
    begin
      result[i]:='''';
      i:=POSEX('"',result);
    end;
end;
{/28.09.2004}

procedure Add2Memo(TutMemo:TRichEdit;Pref,dop,tStr:string;len:integer);
var empstr:string;
    i,cnt:integer;
begin
  empstr:=FillStr(Length(Pref),' ');
  tStr:=RepChar(#13,' ',strip('A',#10,tStr));
  cnt:=LineCntFix(tstr,Len);
  for i:=1 to cnt do
    begin
     if i=1 then
      TutMemo.Lines.Add(Pref+dop+ExtractLineFix(i,Len,tstr))
     else
      TutMemo.Lines.Add(empstr+dop+ExtractLineFix(i,Len,tstr));
    end;
end;

function Time2Str(InTime:TDateTime):string;
var Hor,Min,Sk,mSk:Word;
    sHor,sMin:string;
begin
  DecodeTime(InTime,Hor,Min,Sk,mSk);
  sHor:=IntToStr(Hor);
  if Hor<10 then
     sHor:='0'+sHor;
  sMin:=IntToStr(Min);
  if Min<10 then
     sMin:='0'+sMin;
  Result:=sHor+':'+sMin;
end;

procedure MyExecSQL(Qry_i:TQuery;SQLstr:string);
var tt:longword;
begin
   tt:=0;
   Qry_i.Close;
   Qry_i.SQL.Clear;
   if SQLstr<>'' then
     begin
      Qry_i.SQL.Add(SQLstr);
      try
       if isTest then tt:=GetTickCount;
       Qry_i.ExecSQL;
       if isTest then tt:=GetTickCount-tt;
      except
       on E: Exception do
        begin
         E.Message:=E.Message+#13#10+SQLStr;
         (Application.MainForm as TAppErrForm).RGAppError.WriteException(Application.MainForm,E);
        end;
      end;
      if isTest then
         (Application.MainForm as TAppErrForm).RGAppError.SaveErrString(
               'Open: '+SQLStr+#13#10'Time: '+inttostr(tt));
     end;
end;

procedure MyOpenSQL(Qry_i:TQuery;SQLstr:string);
var tt:longword;
begin
   tt:=0;
   Qry_i.Close;
   Qry_i.SQL.Clear;
   if SQLstr<>'' then
     begin
      Qry_i.SQL.Add(SQLstr);
      try
       if isTest then tt:=GetTickCount;
       Qry_i.Open;
       if isTest then tt:=GetTickCount-tt;
      except
       on E: Exception do
        begin
         E.Message:=E.Message+#13#10+SQLStr;
         (Application.MainForm as TAppErrForm).RGAppError.WriteException((Application.MainForm as TAppErrForm),E);
        end;
      end;
      if isTest then
         (Application.MainForm as TAppErrForm).RGAppError.SaveErrString(
               'Exec: '+SQLStr+#13#10'Time: '+inttostr(tt));
     end;
end;

function MyFloatToStr(value:double):string;
var k:integer;
begin
  result:=FloatToStr(value);
  k:=Pos(',',result);
  if k>0 then result[k]:='.';
end;

function AntiQuote(value:string):string;
var s:string;
  k:integer;
begin
  k:=POS('"',value);
  while k>0 do
    begin
      value[k]:='''';
      k:=POS('"',value);
    end;
  result:=value;
end;

function MyTime2Str(ATime: TDateTime): string;
begin
  Result:='';
  if ATime<>0 then
    Result:=TimeToStr(ATime);
end;

function MyDate2Str(ADate: TDateTime): string;
begin
  Result:='';
  if ADate<>0 then
    Result:=DateToStr(ADate);
end;

function AddColToGVB(GridViewBuilder: TGridViewBuilder; const FieldName, ColCaption: string; Align:
          TMyAlign=alLeft; ShowColumnCellEvent: TShowColumnCellEvent=nil): TGBColumn;
var
  col: TGBColumn;
begin
  col:=GridViewBuilder.AddColumn;
  col.FieldName:=FieldName;
  col.Alignment:=Align;
  col.ColumnTitle.Font.Style:=[fsBold];
  col.ColumnTitle.Alignment:=alCenter;
  col.ColumnTitle.Caption:=ColCaption;
  if Assigned(ShowColumnCellEvent) then
    col.OnShowColumnCell:=ShowColumnCellEvent;
  Result:=col;
end;

procedure AddSelSQLToIBdset(dset: TIBDataSet; SelSQL: string);
begin
  dset.Close;
  dset.SelectSQL.Clear;
  dset.SelectSQL.Text:=SelSQL;
end;

procedure IBOpenSQL(dset: TIBDataSet; SelSQL: string);
begin
  if dset.Active then
    dset.Close;
  dset.SelectSQL.Clear;
  dset.SelectSQL.Text:=SelSQL;
  dset.Open;
end;

procedure IBExecSQL(sql: TIBSQL; ExecSQL: string);
begin
  sql.Close;
  sql.SQL.Clear;
  sql.SQL.Text:=ExecSQL;
  sql.ExecQuery;
end;

{function STime2DateTime(InDate:TDateTime;InTime:String):TDateTime;
var h,m:Word;
begin
   h:=StrToInt(First(2,InTime));
   m:=StrToInt(Last(2,InTime));
   Result:=Time2DateTime(InDate,h,m);
end;}

{function Time2DateTime(InDate:TDateTime;Hour,Min:Word):TDateTime;
var tt_time:TDateTime;
begin
   InDate:=int(InDate);
   tt_time:=EncodeTime(Hour, Min, 0, 0);
   Result:=InDate+tt_time;
end;}

{function Date2Year(InDate:TDateTime):Word;
var  Year, Month, Day: Word;
begin
  DecodeDate(InDate,Year, Month, Day);
  Result:=Year;
end;}

initialization

end.
