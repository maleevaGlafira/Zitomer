unit avartype;

interface
  uses Forms, Windows, Sysutils, db, controls, buttons, dbtables, classes,
       dbctrls, RxLookup, stdctrls, DateUtil,checklst;

const
 IniFlParams = 'params.ini';
 IniFlAvar = 'avar.ini';
 FullPathIniFlParams :string = '';
 FullPathIniFlAvar :string = '';
 _DiamPresent = 1;
 DefEmptyValue = -1;
// RASKOPKA_ID :integer = 206;
 RASKOPKA_ID1 :integer = 203; //Вручную
 RASKOPKA_ID2 :integer = 204; //Экскаватором
 DefAdmPassw = 'masterkey';
 IdentUseSecInDate = 'UseSecInDate';
 UseSecInDate :boolean=true;
 isMapConnected :boolean=false;
// month_day :[];
type
  TPeriod = record
    begin_d :string;
      end_d :string;
      title :string;
   end; // TPeriod

  TOptionalFind = (ofGeneral, ofPovrezhd);
  MasPeriod = array [1..4] of TPeriod;

  TAdresRec=record
    kod_ul: integer;
    id_ul1: integer;
    id_ul2: string;
    dop_adr: string;
    id_DopAdres: integer;
  end;


{  TMonthRec = record
    MName :string[20];
    Day_Count :integer;
   end; // record}

//var
// MonthRec :array [1..12] of TMonthRec;
{uo LongMonthNames
   MonthArray :array [1..12] of string;
}
//function FillMonthRec(AMName :string[20]; ADay_Count :integer) :TMonthRec;
procedure ButCtrlState(Qr1 :TDataSet;bnew ,bdel, bhide :pointer; k_focus :TWinControl);
function AddNewRec(Qr1 :TDataSet; k_focus :TWinControl) :boolean;
function DelRec(hl :HWND; Qr1:TDataSet; str1 :string; Confirm :boolean=true) :boolean;
function SaveChangesQuery(Qr1 :TQuery) :boolean;
function Empty_ValueInCt(pCt :TComponent; hl :HWND; text1 :string) :boolean;
function Uniq_Value(usl :string; win_c :TWinControl; hl :HWND; text1 :string) :boolean;
//procedure ShowDicForm(fm1 :TForm; show_modal :boolean=true);
procedure ShowDicForm(fm1 :TForm; show_modal :boolean=false); //by Vadim 30.07.2009
function GetDicNewID(StorProc_Name :string) :integer;
function IsMatDiamPresent(id_mat :integer) :boolean;
function GetDatePeriod(_year :integer; nq :integer=0) :MasPeriod;
function CheckCheckedCHLB(chlb1 :TCheckListBox) :boolean;
function GetDiamIDFromDLCB(DiamPresent_ :boolean; rxDLCB :TRxDBLookupCombo) :integer;
function getRecordCountQr(SQLtext :string) :integer;
function getAddr(type_addr :integer; baze_street, cross_street,
                 house_numb, dop_addr :string) :string;
function getRayonName(id_rayon :integer) :string;
function Time2Str(InTime:TDateTime):string;
function Time2DateTime(InDate:TDateTime;Hour,Min:Word):TDateTime;
function Date2Year(InDate:TDateTime):Word;
function STime2DateTime(InDate:TDateTime;InTime:String):TDateTime;

Procedure SetFilterDelete(Q:TQuery;value:boolean);
function IsDateTimeCorrect(cur_dt, def_dt: string): string;


var
  RaonChar:Char;

implementation
  uses datam, strtool, dialogs;

{//===================================================================
function FillMonthRec(AMName :string[20]; ADay_Count :integer) :TMonthRec;
begin
 with result do
  begin
   MName:=AMName;
   Day_Count:=ADay_Count;
  end;
end;
 }
//===================================================================
procedure ButCtrlState(Qr1 :TDataSet;bnew ,bdel, bhide:pointer;
                       k_focus :TWinControl);
begin
  if (Qr1.State = dsInsert)or(Qr1.State = dsEdit)or
     (not Qr1.CanModify) then
    begin
     if Assigned(bnew) then TControl(bnew).Enabled:=false;
     if Assigned(bdel) then TControl(bdel).Enabled:=false;
    end // if (Qr1.State = dsInsert)or ...
      else if (Qr1.State = dsBrowse) then
             begin
              if Assigned(bnew) then TControl(bnew).Enabled:=true;
              if Assigned(bdel) then TControl(bdel).Enabled:=(Qr1.recordCount > 0);
              if Assigned(k_focus) then SetFocus(k_focus.Handle);
             end; // if (Qr1.State = dsBrowse) ...
  TControl(bhide).Enabled:=TControl(bdel).Enabled
end;

//===================================================================
function AddNewRec(Qr1 :TDataSet; k_focus :TWinControl) :boolean;
begin
 result:=false;
 if Qr1.CanModify then
   begin
    Qr1.Append;
    k_focus.SetFocus;
    result:=true;
   end;
end;

//===================================================================
function DelRec(hl :HWND; Qr1:TDataSet; str1 :string; Confirm :boolean=true) :boolean;
begin
 result:=false;
   //if Qr1.RecordCount = 0 then exit;

 if (Confirm)and({MessageBoxEx(hl,PChar(str1),
                   'Подтверждение',MB_YESNO + MB_ICONQUESTION,
                   LANG_Ukrainian)}
                   MessageDlg(str1,mtConfirmation, [mbYes,mbNo], 0) <> IDYES) then exit;
 Qr1.Delete;
 result:=true;
end;

//===================================================================
function SaveChangesQuery(Qr1 :TQuery) :boolean;
begin
 result:=false;
  try
   if Qr1.UpdatesPending then
     begin
      Qr1.ApplyUpdates;
      Qr1.CommitUpdates;
     end;
  except
   Qr1.CancelUpdates;
   Exit;
  end;
 result:=true;
end;

//===================================================================
function Empty_ValueInCt(pCt :TComponent; hl :HWND; text1 :string) :boolean;
var
 tfld_fl :boolean;
begin
 result:=false;
 tfld_fl:=false;
 if (pCt is TField)and(TField(pCt).asString = '') then
    begin
     result:=true;
     tfld_fl:=true;
    end
     else if (pCt is TDBEdit)and(TDBEdit(pCt).text = '') then result:=true
             else if (pCt is TRxDBLookupCombo)and(TRxDBLookupCombo(pCt).text = '')
                      then result:=true
                      else if (pCt is TRxDBLookupCombo)and(TRxDBLookupCombo(pCt).text = '')
                           then result:=true
                           else if (pCt is TDBLookupComboBox)and(TDBLookupComboBox(pCt).text = '')
                                   then result:=true;
 if result then
   begin
   MessageDlg(text1,mtConfirmation,[mbOk],0);
    //MessageBoxEx(hl,PChar(text1),mtConfirmation, [mbOk,mbNo],
    //             'Предупреждение',MB_OK + MB_ICONINFORMATION,
    //             LANG_Ukrainian);
    if tfld_fl then TField(pCt).FocusControl
               else TWinControl(pCt).SetFocus;
   end;
end;

//===================================================================
function Uniq_Value(usl :string; win_c :TWinControl;
                    hl :HWND; text1 :string) :boolean;
begin
 result:=false;
 with DM1 do
  begin
   if tempQr_q.Active then tempQr_q.Close;
   tempQr_q.SQL.Clear;
   tempQr_q.SQL.Add(usl);
   try
     tempQr_q.Open;
     if not tempQr_q.EOF then
       begin
        result:=false;
        MessageBoxEx(hl, PChar(text1),'Предупреждение',
                     MB_OK + MB_ICONINFORMATION, LANG_Ukrainian);
        win_c.SetFocus;
       end
         else result:=true;
     tempQr_q.Close;
    except
    end;
  end; // with
end;

//===================================================================
//procedure ShowDicForm(fm1 :TForm; show_modal :boolean=true);
procedure ShowDicForm(fm1 :TForm; show_modal :boolean=false);  // by Vadim 30.07.2009
//var
// vv :TDataSource;
begin
{ Screen.Cursor:=crHourGlass;
 if not assigned(fm1) then
    Application.CreateForm(FmClass, fm1);
 Screen.Cursor:=crDefault;}
 if fm1.WindowState = wsMinimized
    then fm1.WindowState:=wsNormal;
 if show_modal then
                begin
                  fm1.ShowModal;
                  fm1.FormStyle := fsNormal;
                 end
               else
                  begin
                    fm1.Show;
                    fm1.FormStyle := fsStayOnTop;
                  end;
 SetForegroundWindow(fm1.Handle);
end;

//===================================================================
function GetDicNewID(StorProc_Name :string) :integer;
begin
 with DM1 do
  begin
   tempQr_q.SQL.Clear;
   tempQr_q.SQL.Add('SELECT * FROM '+StorProc_Name);
   try
    tempQr_q.Open;
    result:=tempQr_q.Fields[0].asInteger;
   except
     result:=-1;
   end;
   if tempQr_q.Active then tempQr_q.Close;
 end; // with
end;

//===================================================================
function IsMatDiamPresent(id_mat :integer) :boolean;
begin
 with DM1 do
  begin
   tempQr_q.SQL.Clear;
   tempQr_q.SQL.Add(Format('SELECT * FROM S_MAT WHERE (ID = %d)and(DIAMPRESENT = %d)',
                    [id_mat, _DiamPresent]));
   try
    tempQr_q.Open;
    result:=not tempQr_q.EOF;
   except
     result:=true;
   end;
   if tempQr_q.Active then tempQr_q.Close;
 end; // with
end;

//===================================================================
function GetDatePeriod(_year :integer; nq :integer=0) :MasPeriod;
var
 i,indx1,c :integer;
 str1 :string;
begin
  if nq > 0 {номер квартала} then
    begin
      c:=3;
      indx1:=nq*3-2;
      for i:=0 to 2 do
       begin
        str1:=IntToStr(indx1+i);
        if length(str1) = 1 then str1:='0'+str1;
        result[i+1].begin_d:=Format('01.%s.',[str1]);
        result[i+1].end_d:=Format('%2d.%s.',[DaysPerMonth(_year,indx1+i),str1]);
        result[i+1].title:=LongMonthNames{MonthArray}[indx1+i];
       end;
    end // if nq > 0 {номер квартала} ...
     else begin {год}
            c:=4;
            result[1].begin_d:='01.01.'; result[1].end_d:='31.03.';
            result[2].begin_d:='01.04.'; result[2].end_d:='30.06.';
            result[3].begin_d:='01.07.'; result[3].end_d:='30.09.';
            result[4].begin_d:='01.10.'; result[4].end_d:='31.12.';
            for i:=1 to 4 do result[i].title:=Format('%d кв.',[i]);
          end; // if nq > 0 ... else
 for i:=1 to c do
   begin
    result[i].begin_d:=result[i].begin_d + IntToStr(_year) +' 00:00';
    result[i].end_d:=result[i].end_d + IntToStr(_year) +' 23:59';
   end; // for
end;

//===================================================================
function CheckCheckedCHLB(chlb1 :TCheckListBox) :boolean;
var
 i :integer;
begin
 result:=false;
 for i:=0 to chlb1.Items.Count-1 do
  if chlb1.Checked[i] then
    begin
     result:=true;
     exit;
    end;
end;

//===================================================================
function GetDiamIDFromDLCB(DiamPresent_ :boolean; rxDLCB :TRxDBLookupCombo) :integer;
begin
 result:=DefEmptyValue;
 if not DiamPresent_ then exit;
 result:=StrToIntDef(rxDLCB.Value, DefEmptyValue);
end;

//===================================================================
function getRecordCountQr(SQLtext :string) :integer;
var
 i :integer;
begin
 result:=-1;
 if Trim(SQLtext) = '' then exit;
 with DM1 do
  begin
   tempQr_q.SQL.Clear;
   i:=Pos('FROM',AnsiUpperCase(SQLtext));
   if i<=0 then exit;
   SQLtext:=copy(SQLtext,i,length(SQLtext)-i);
{   i:=Pos('ORDER BY',AnsiUpperCase(SQLtext));
   if i > 0 then SQLtext:=copy(SQLtext, 1, i-1);}
   tempQr_q.SQL.Text:='select count(*) '+ SQLtext;
   try
    tempQr_q.Open;
    result:=tempQr_q.Fields[0].asInteger;
   finally
    if tempQr_q.Active then tempQr_q.Close;
   end;
 end; // with
end;

//===================================================================
function getAddr(type_addr :integer; baze_street, cross_street,
                 house_numb, dop_addr :string) :string;
//var
// str1 :string;
begin
 result:=Strip('B',' ',baze_street);
 case type_addr of
   0 {улица, дом}  :result:=Format('%s, %s',[result, house_numb]);
   1 {перекресток} :result:=Format('%s > %s',[result, cross_street]);
   2 {местность}   :result:=Format('Мест.- %s',[result]);
  end; // case
 result:=result+' '+dop_addr;
end;

//===================================================================
function getRayonName(id_rayon :integer) :string;
begin
 result:='';
 with DM1 do
  begin
   tempQr_q.SQL.Clear;
   tempQr_q.SQL.Text:='select name_r from s_rayon where id='+inttostr(id_rayon);
   try
    tempQr_q.Open;
    result:=tempQr_q.Fields[0].asString;
   finally
    if tempQr_q.Active then tempQr_q.Close;
   end;
 end; // with
end; 

//===================================================================
function Time2Str(InTime:TDateTime):string;
var Hor,Min,Sk,mSk:Word;
    sHor,sMin, sSk:string;
begin
  DecodeTime(InTime,Hor,Min,Sk,mSk);
  sHor:=IntToStr(Hor);
  if Hor<10 then
     sHor:='0'+sHor;
  sMin:=IntToStr(Min);
  if Min<10 then
     sMin:='0'+sMin;
  Result:=sHor+':'+sMin;

  if UseSecInDate then
     begin
      sSk:=IntToStr(Sk);
      if Sk<10 then sSk:='0'+sSk;
      result:=result+':'+sSk;
     end; // if UseSecInDate ...
 end;

//===================================================================
function Time2DateTime(InDate:TDateTime;Hour,Min:Word):TDateTime;
var tt_time:TDateTime;
begin
   InDate:=int(InDate);
   tt_time:=EncodeTime(Hour, Min, 0, 0);
   Result:=InDate+tt_time;
end;

function Date2Year(InDate:TDateTime):Word;
var  Year, Month, Day: Word;
begin
  DecodeDate(InDate,Year, Month, Day);
  Result:=Year;
end;

function STime2DateTime(InDate:TDateTime;InTime:String):TDateTime;
var h,m:Word;
begin
   h:=StrToInt(First(2,InTime));
   m:=StrToInt(Last(2,InTime));
   Result:=Time2DateTime(InDate,h,m);
end;

function IsDateTimeCorrect(cur_dt, def_dt: string): string;
var
  d: TDateTime;
begin
  Result:=cur_dt;
  try
    d:=StrToDateTime(cur_dt);
  except
    Result:=def_dt;
  end;
end;

// Если value=true то не будет в запросе полей с del='d'
Procedure SetFilterDelete(Q:TQuery;value:boolean);
var i:integer;
    s:string;
    actv:boolean;
    ChDel:char;
begin
  with Q do begin
    s:=sql.text;
    if value
    then ChDel:='d'
    else ChDel:='x';
    i:=pos('(''-'','''+ChDel+''')',s);
    if i>0
    then begin
      if value
      then s[i+6]:='x'
      else s[i+6]:='d';
      actv:=Active;
      sql.text:=s;
      if actv then Open;
    end
  end;
end;



//===================================================================
initialization
 FullPathIniFlParams:=  ExtractFilePath(ParamStr(0)) + IniFlParams;
 FullPathIniFlAvar:=ParamStr(1);
 if Trim(FullPathIniFlAvar) = '' then
    FullPathIniFlAvar:=ExtractFilePath(ParamStr(0)) + IniFlAvar;

{ MonthRec[1]:=FillMonthRec('Январь',31);
 DecodeDate(now, _curYear, _curMonth, _curDay);
 if IsLeapYear(_curYear) then MonthRec[2]:=FillMonthRec('Февраль',29)
                         else MonthRec[2]:=FillMonthRec('Февраль',28);
 MonthRec[3]:=FillMonthRec('Март',31); MonthRec[4]:=FillMonthRec('Апрель',30);
 MonthRec[5]:=FillMonthRec('Май',31); MonthRec[6]:=FillMonthRec('Июнь',30);
 MonthRec[7]:=FillMonthRec('Июль',31); MonthRec[8]:=FillMonthRec('Август',31);
 MonthRec[9]:=FillMonthRec('Сентябрь',30); MonthRec[10]:=FillMonthRec('Октябрь',31);
 MonthRec[11]:=FillMonthRec('Ноябрь',30); MonthRec[11]:=FillMonthRec('Декабрь',31);}
{uo
 MonthArray[1]:='Январь';   MonthArray[2]:='Февраль';
 MonthArray[3]:='Март';     MonthArray[4]:='Апрель';
 MonthArray[5]:='Май';      MonthArray[6]:='Июнь';
 MonthArray[7]:='Июль';     MonthArray[8]:='Август';
 MonthArray[9]:='Сентябрь'; MonthArray[10]:='Октябрь';
 MonthArray[11]:='Ноябрь';  MonthArray[12]:='Декабрь';
}
end.
