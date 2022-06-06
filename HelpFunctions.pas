unit HelpFunctions;

interface

  uses Classes, SysUtils, RxLookup, RxDBComb, DB, Controls,
  aligrid, Graphics, IBCustomDataSet, Variants, IBSQL, Dialogs, Windows,
  rxStrUtils, StdCtrls, ExtCtrls, Mask, kbmMemTable, GridViewBuilder;

  function RevPos(src:AnsiString; c:char):integer;
  function IsStringContainsInteger(val:AnsiString):boolean;
  function IsFileExists(strFileName:AnsiString):boolean;
  procedure MessageStringVal(val:AnsiString);
  procedure MessageBoolVal(val:boolean);
  procedure MessageIntVal(val:integer);
  function ASTring2Multiline(strAnsi:AnsiSTring):AnsiString;
  function Multiline2PureASTring(strMultiline:AnsiSTring):AnsiString;
  function Multiline2ClearSTring(strMultiline:AnsiSTring):AnsiString;
  function Multiline2ASTring(strMultiline:AnsiSTring):AnsiString;
  function Change1stword(strPhrase:AnsisTring; strWord:AnsiSTring):AnsiString;
  procedure ResetDBL(dbl: TRxDBLookupCombo);
  procedure FixDBLValue(value: integer; dbl: TRxDBLookupCombo);
  function IsDBLEmpty(dbl: TRxDBLookupCombo): boolean;
  function DateTime2Str(ADate: TDate; ATime: TTime): string;
  function FixFloatStr(str: string): string;
  function IsDateLess(lhs, rhs:string):boolean;
  function ReplaceChar(str: string; old_char, new_char: char): string;
  procedure AddSelSQLToDset(dset: TIBDataSet; SelSQL: string);
  function VarToString(val: variant): string;
  function VarToFloat(val: variant): double;
  function VarToInteger(val: variant): integer;
  function IsDateCorrect(strDateTime: string): boolean;
  procedure MyOpenIBDS(dset: TIBDataSet; const sel_sql: string);
  procedure MyExecIBSQL(ibsql: TIBSQL; const exec_sql: string);
  function AddField(_DataSet:TDataSet; const AFieldName:string;
              AFieldClass:TFieldClass; ASize:Word; _Calculated:boolean):TField;
  function NameCase(const s: string): string;
  function Date2FileName(dt: TDate): string;
  function DateTime2FileName(dttm: TDateTime): string;
  procedure EnableLblOnGroupBox(gb: TGroupBox; value: boolean);
  procedure EnableLblOnPanel(pnl: TPanel; value: boolean);
  procedure CorrectTimeEdit(MaskEdit: TMaskEdit);
  function GetComputerName: string;
  function GetYear(dttm: TDateTime): integer;
  procedure SaveBlobToFile(_Field: TField; _FileName: string);
  function Str_to_Int(s: string): integer;
  function MyVarToStr(const V: Variant): string;
//  function IsHasProp(obj: TObject; prop_name: string): boolean;
  function MixDateTime( _Date, _Time: TDateTime ): TDateTime;
  function FieldAsString( _Field: TField ): string;

  procedure FillResultDsetByCheckList( _CheckDset: TDataSet; _CheckList: TRowInformerList;
    _ResultDSet: TkbmMemTable );
 procedure addprob(var str:string; len :integer);
  function addprobf( str:string; len :integer):string;
  function StringFromDateTime(date:TDatetime; format:String):string;
  function MultilineString(str:string):string;

implementation

procedure FillResultDsetByCheckList( _CheckDset: TDataSet; _CheckList: TRowInformerList;
  _ResultDSet: TkbmMemTable );
var
  i: integer;
  _ri: TRowInformer;
begin
  _ResultDset.Close;
  _ResultDset.CreateTableAs( _CheckDset, [ mtcpoStructure ] );
  _ResultDset.Open;

  for i:=0 to _CheckList.Count-1 do
  begin
    _ri := TRowInformer( _CheckList.Items[i] );
    if _ri.IsRowChecked then
    begin
      _CheckDset.RecNo := _ri.RecNumInDataSet;
      _ResultDset.Append;
      _ResultDset.AssignRecord( _CheckDset, _ResultDset );
    end;
  end;
end;

function FieldAsString( _Field: TField ): string;
var
  _val: Variant;
begin
  _val := _Field.Value;
  if  VarType( _val ) = varDouble	then
    Result := FormatFloat( '0.##', _val )
  else
    Result := _Field.asString;
end;


function MixDateTime( _Date, _Time: TDateTime ): TDateTime;
begin
  Result := Trunc( _Date ) + Frac( _Time );
end;

{
function IsHasProp(obj: TObject; prop_name: string): boolean;
var
  p_info: PPropInfo;
begin
  p_info:=GetPropInfo(obj, prop_name);
  if p_info=nil then
    Result:=false
  else
    Result:=true;
end;
}

function MyVarToStr(const V: Variant): string;
begin
  Result := VarToStr( V );
  if ( VarType( V ) = varString ) or
     ( VarType( V ) = varDate ) then
    Result := QuotedStr( Result );;
end;


function Strip(L:char;C:string;Str:string):string;
{L is left,center,right,all,ends}
var Ii :  integer;
begin
   if length(str)<>0 then
    Case Upcase(L) of
    'L' : begin       {Left}
              While (length(Str) > 0)  and  (pos(Str[1],C)<>0) and (length(Str) > 0) do
                    Delete(Str,1,1);
          end;
    'R' : begin       {Right}
              While ((length(Str) > 0)  and ( pos(Str[length(Str)],C)<>0)) do
                    Delete(Str,length(Str),1);
          end;
    'B' : begin       {Both left and right}
              While (length(Str) > 0)  and    (pos(Str[1],C)<>0) do
                    Delete(Str,1,1);
              While (length(Str) > 0)  and  (pos(Str[length(Str)],C)<>0)  do
                    Delete(Str,length(Str),1);
             {удал€ем лишние символы}
              II := 1;
              Repeat
                   If (length(Str) > 0)  and  (pos(Str[Ii],C)<>0)
                    and (ii<length(Str))and (pos(Str[Ii+1],C)<>0)
                    then
                      Delete(Str,Ii,1)
                   else
                      Ii := succ(Ii);
              Until (Ii > length(Str)) or (Str = '');
          end;
    'A' : begin       {All}
              II := 1;
              Repeat
                   If (length(Str) > 0)  and  (pos(Str[Ii],C)<>0) then
                      Delete(Str,Ii,1)
                   else
                      Ii := succ(Ii);
              Until (Ii > length(Str)) or (Str = '');
          end;
    end;
    Strip := Str;
end;  {Func Strip}



function Str_to_Int(s: string): integer;
var
  temp, i: integer;
  Str: string;
begin
    Str:=s;
    If length(Str) = 0 then
       Str_to_Int := 0
    else
    begin
       Str:=Strip('A',' ',Str);
       for i:=1 to length(str) do
          if not (str[i] in ['0'..'9','+','-']) then begin
            delete (str,i,length(str));
            break;
          end;
       val(Str,temp,i);
          Str_to_Int := temp
    end;
end;


procedure SaveBlobToFile(_Field: TField; _FileName: string);
var
  _FileS: TFileStream;
  _BlobS: TStream;
  _DirName: string;
begin
  if FileExists(_FileName) then SysUtils.DeleteFile(_FileName);

  _DirName:=ExtractFilePath(_FileName);
  if not DirectoryExists(_DirName) then
    CreateDir(_DirName);

  _BlobS:=_Field.DataSet.CreateBlobStream(_Field, bmRead);
  try
    _FileS:=TFileStream.Create(_FileName, fmCreate);
    try
      _FileS.CopyFrom(_BlobS, _BlobS.Size);
    finally
      _FileS.Free;
    end;
  finally
    _BlobS.Free;
  end;
end;


function GetYear(dttm: TDateTime): integer;
var
  y, m, d: word;
begin
  DecodeDate(dttm, y, m, d);
  Result:=y;
end;

function GetComputerName: string;
var
   buffer: array[0..MAX_COMPUTERNAME_LENGTH + 1] of Char;
   Size: Cardinal;
begin
   Size := MAX_COMPUTERNAME_LENGTH + 1;
   Windows.GetComputerName(@buffer, Size);
   Result := StrPas(buffer);
end;


procedure CorrectTimeEdit(MaskEdit: TMaskEdit);
var
  s: string;
  i: integer;
begin
  s:=MaskEdit.Text;
  for i:=1 to length(s) do
    if s[i]=' ' then
      s[i]:='0';
  MaskEdit.Text:=s;
end;

procedure EnableLblOnPanel(pnl: TPanel; value: boolean);
var
  i: integer;
begin
  for i:=0 to pnl.ControlCount-1 do
    if (pnl.Controls[i] is TLabel) then
      (pnl.Controls[i] as TLabel).Enabled:=value;
end;


procedure EnableLblOnGroupBox(gb: TGroupBox; value: boolean);
var
  i: integer;
begin
  for i:=0 to gb.ControlCount-1 do
    if (gb.Controls[i] is TLabel) then
      (gb.Controls[i] as TLabel).Enabled:=value;
end;


function RevPos(src:AnsiString; c:char):integer;
var n:integer;
begin
  RevPos := -1;
  n := Length(src);
  while n <> 0 do
  begin
    if src[n] = c then
    begin
      RevPos := n;
      break;
    end;
    n := n - 1;
  end;
end;

function IsStringContainsInteger(val:AnsiString):boolean;
var nNum:integer;
begin
        IsStringContainsInteger := true;
          try
        nNum := StrToInt(val);
        except
          On E: EConvertError do
          begin
            MessageDlg(val + ' не €вл€етс€ числом.', mtError, [mbOK], 0);
            IsStringContainsInteger := false;
          end;
        end;
end;

function IsFileExists(strFileName:AnsiString):boolean;
var finddata:TWin32FindData;
    findres:integer;
begin
  findres := windows.FindFirstFile( PChar(strFileName), finddata);
  if findres = -1 then //INVALID_HANDLE_VALUE then ?????? а какого собсно делф€ не понимает знаковых констант? это ж  0хFFFFFFFF
  begin
    IsFileExists := false;
    Exit;
  end;
  Windows.findclose(findres);
  IsFileExists := true;
end;


procedure MessageStringVal(val:AnsiString);
begin
  MessageDlg(val, mtInformation, [mbOK], 0);
end;


procedure MessageBoolVal(val:boolean);
begin
  if val then
    MessageDlg('true', mtInformation, [mbOK], 0)
  else
    MessageDlg('false', mtInformation, [mbOK], 0);
end;


procedure MessageIntVal(val:integer);
begin
  MessageDlg(IntToStr(val), mtInformation, [mbOK], 0);
end;


function ASTring2Multiline(strAnsi:AnsiSTring):AnsiString;
var n:integer;
  strRes:AnsiSTring;
begin
  n:= 0;

  while n <= Length(strAnsi) - 3 do    //seems that Pos function searches only in first substring// n := Pos(strAddInfo, 'QokQ');
  begin
     if (strAnsi[n] = 'Q') and (strAnsi[n + 1] = 'o') and
          (strAnsi[n + 2] = 'k') and (strAnsi[n + 3] = 'Q') then
     begin
       strAnsi := Copy(strAnsi, 1, n-1) + #13 + #10 + Copy(strAnsi, n+4, Length(strAnsi) - n - 3);
       n:= n + 1;
     end;
     n:= n + 1;
  end;
  strRes := strAnsi;
  AString2Multiline := strRes;
end;



function Multiline2PureASTring(strMultiline:AnsiSTring):AnsiString;
var n:integer;
  strRes:AnsiSTring;
begin
    n := 1;
    strRes := strMultiline;
    while n <= Length(strRes) do
    begin
      if (strRes[n] = #13) then //local eos found
      begin
        strRes := Copy(strRes, 1, n-1) + ' ' + Copy(strRes, n+2, Length(strRes) - n - 1);
        n := n + 2;
      end;
      n:= n + 1;
    end;

  Multiline2PureASTring := strRes;
end;

function Multiline2ClearSTring(strMultiline:AnsiSTring):AnsiString;
var n:integer;
  strRes:AnsiSTring;
begin
    n := 1;
    strRes := strMultiline;
    while n <= Length(strRes) do
    begin
      if (strRes[n] = #13) then //local eos found
        strRes := Copy(strRes, 1, n-1) + ' ' + Copy(strRes, n+1, Length(strRes) - n);
      n:= n + 1;
    end;

  Multiline2ClearSTring := strRes;
end;


function Multiline2ASTring(strMultiline:AnsiSTring):AnsiString;
var n:integer;
  strRes:AnsiSTring;
begin
    n := 1;
    strRes := strMultiline;
    while n <= Length(strRes) do
    begin
      if (strRes[n] = #13) then //local eos found
      begin
        strRes := Copy(strRes, 1, n-1) + 'QokQ' + Copy(strRes, n+2, Length(strRes) - n - 1);
        n := n + 2;
      end;
      n:= n + 1;
    end;

  Multiline2ASTring := strRes;
end;


function Change1stword(strPhrase:AnsisTring; strWord:AnsiSTring):AnsiString;
var i, nLen:integer;
begin
  Change1stWord := strPhrase;
  if strPhrase = '' then
    exit;
  nLen := Length(strPhrase);
  i := 1;
  while (strPhrase[i] = ' ') and (i < nLen) do
  begin
    i := i+1;
  end;
  if i = nLen then
  begin
    exit;
  end;

  while (strPhrase[i] <> ' ') and (i < nLen) do
  begin
    i := i+1;
  end;

  if i = nLen then
    exit;
  Change1stWord := ' ' + strWord + ' ' + Copy(strPhrase, i, Length(strPhrase) - i + 1);
end;


function Date2FileName(dt: TDate): string;
begin
  Result:=DateToStr(dt);
  Delete(Result,3,1);
  Delete(Result,5,1);
end;

function NameCase(const s: string): string;
var
  sym: string;
begin
  Result:=AnsiLowerCase(trim(s));
  sym:=copy(Result, 1, 1);
  Delete(Result, 1, 1);
  Result:=AnsiUpperCase(sym)+Result;
end;


function AddField(_DataSet:TDataSet; const AFieldName:string;
  AFieldClass:TFieldClass; ASize:Word; _Calculated:boolean):TField;
begin
  Result:=_DataSet.FindField(AFieldName); // Field may already exists!
  if Result<>nil then Exit;

  Result:=AFieldClass.Create(_DataSet);
  with Result do
  try
    FieldName:=AFieldName;
    if (Result is TStringField) or (Result is TBCDField) or (Result is TBlobField) or
      (Result is TBytesField) or (Result is TVarBytesField) then
    begin
      Size:=ASize;
    end;
    Calculated:=_Calculated;
    DataSet:=_Dataset;
    Name:=_DataSet.Name+AFieldName;
  except
    Free; // We must release allocated memory on error!
    raise;
  end;
end;


procedure MyExecIBSQL(ibsql: TIBSQL; const exec_sql: string);
begin
  ibsql.Close;
  ibsql.SQL.Clear;
  ibsql.SQL.Add(exec_sql);
  ibsql.ExecQuery;
end;



procedure MyOpenIBDS(dset: TIBDataSet; const sel_sql: string);
begin
  dset.Close;
  dset.SelectSQL.Clear;
  dset.SelectSQL.Add(sel_sql);
  dset.Open;
end;


procedure ResetDBL(dbl: TRxDBLookupCombo);
var
  dbl_dset: TDataSet;
begin
  dbl_dset:=dbl.LookupSource.DataSet;
  if dbl_dset.Locate('ID',Integer(-1),[]) then
    dbl.DisplayValue:=dbl_dset.FieldByName('name_r').AsString
  else
    dbl.DisplayValue:='';  
end;


procedure FixDBLValue(value: integer; dbl:TRxDBLookupCombo);
var
  dbl_dset: TDataSet;
begin
  dbl_dset:=dbl.LookupSource.DataSet;
  if not dbl_dset.Locate('ID', value, []) then
    ResetDBL(dbl)
  else
    dbl.DisplayValue:=dbl_dset.FieldByName('name_r').AsString;
end;


function IsDBLEmpty(dbl: TRxDBLookupCombo): boolean;
var
  dbl_dset: TDataSet;
begin
  Result:=false;
  dbl_dset:=dbl.LookupSource.DataSet;
  if (dbl_dset.FieldByName('ID').AsInteger=-1) or
      (trim(dbl.Text)='')  then
    Result:=true;
end;

function DateTime2Str(ADate: TDate; ATime: TTime): string;
var
  dt: TDateTime;
begin
  dt:=Trunc(ADate);
  dt:=dt+(ATime-Trunc(ATime));
  Result:=''''+DateTimeToStr(dt)+'''';
end;

function FixFloatStr(str: string): string;
var
  p:integer;
begin
  p:=Pos(',',str);
  if p<>0 then
    str[p]:='.';
  Result:=str;
end;

function IsDateLess(lhs, rhs:string):boolean;
var
  dt1, dt2:TDatetime;
begin
  dt1 := StrToDateTime(lhs);
  dt2 := strToDateTime(rhs);
  Result := false;
  if(dt1 < dt2) then
    Result := true;
end;


function ReplaceChar(str: string; old_char, new_char: char): string;
var
  i: integer;
begin
  str:=str+' ';
  for i:=0 to Length(str)-1 do
    if str[i]=old_char then
      str[i]:=new_char;
  Result:=str;
end;

procedure AddSelSQLToDset(dset: TIBDataSet; SelSQL: string);
begin
  dset.Close;
  dset.SelectSQL.Clear;
  dset.SelectSQL.Add(SelSQL);
end;

function VarToString(val: variant): string;
begin
  if val=Null then
    Result:=''
  else
    Result:=string(val);
end;

function VarToFloat(val: variant): double;
begin
  if val=Null then
    Result:=0
  else
    Result:=double(val);
end;

function VarToInteger(val: variant): integer;
begin
  if val=Null then
    Result:=0
  else
    Result:=integer(val);
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

function DateTime2FileName(dttm: TDateTime): string;
begin
  Result:=DelSpace(DateTimeToStr(dttm));
  Result:=DelChars(Result,'.');
  Result:=DelChars(Result,':');
end;

procedure addprob(var str:string; len :integer);
var l:integer;
begin
l:=length(str);
while l<len do
begin
str:=str+' ';
l:=l+1;
end
end;

function addprobf(str:string; len :integer):string;
 var l:integer;
    ads:string;
begin
l:=length(str);
ads:=str;
while l<len do
begin
ads:=ads+' ';
l:=l+1;
end ;
result:=ads;
end;

function StringFromDateTime(date:TDatetime; format:String):string;
begin
 if date=0 then result:=''
 else
  result:=FormatDateTime(format, date);

end;

function MultilineString(str:string):string;
var i:integer;
begin
 result:=str;
 for i:=1 to length(str) do
  begin
   if str[i]= ' ' then
    result[i]:=#13;
  end;
end ;


end.
