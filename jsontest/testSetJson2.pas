unit testSetJson2;

{$define sent}
interface


uses  SysUtils, Variants, Classes,Forms,
uLkJSON, StdCtrls, ComCtrls,IniFiles,httpSentSynapse,main,HelpFunctionsSentDiscon ;

const  formatdat = 'yyyy-mm-dd';
const formattime = 'hh:mm';
const typDiscon : array [1..3] of string = ('Отключение воды','Отключение канализации', 'Снижение давления воды');
const formatPlaces:array [1..2] of string =('водопровода', 'канализации');

const IniDatafile='data.ini';


//const NewUrl='http://infoxvod.com.ua/avr-exchange.php?ent=repair&action=add';
//const AddUrl='http://infoxvod.com.ua/avr-exchange.php?ent=stoplist&action=upd';

//const DelUrl='http://infoxvod.com.ua/avr-exchange.php?ent=stoplist&action=del';


type
{ год в id привяжем к наряду}
{ можно отослать только 1 раз после этого сбрасываем данные
}
TSentToServ = class
private
  TAttach:integer;
  id:string;
  date:TDateTime;
  adres:String;
  jplaces:TlkJSONlist;
  jdel:TlkJSONlist;
  http:ThttpSent;
   _iSsentHead:boolean;
   worklog:boolean;
   F_kod:char;
   f_canSent:boolean;
    min_time :TDateTime;
 function _isSentAdd :boolean;
 function _isSentDel:boolean;

 function strAtt: string;
 function sentJson(json:TlkJSONObject;url:string):boolean;
public
 constructor create (http:ThttpSent;id:integer;date:TDateTime;tAtt:integer;adres:string;log:boolean=true;kod:char='v');
 property isSentAdd:boolean read _isSentAdd;
 property isSentDel:boolean read _isSentDel;
 property isSenthead:boolean read _isSenthead;
 function AddPlace(id:integer;
                   street:String;
                   houses:String;
                   stopplan,stopfact,resplan,resfact:TDateTime ):integer;
 function AddDel(id:integer):integer;
 function SentHead:boolean;
 function SentAdd:boolean;
 function SentDel:boolean;

 property getCanSetn:boolean read  f_canSent;


  destructor free;
end;

procedure myWorkLog(_logtext:string);
function getProx( var proxHost,proxyPort,proxUser,proxPassword:string):boolean;

implementation
function TSentToServ.AddDel(id: integer): integer;
var obj:TlkJSONObject;
function isplaces:boolean;
var i:integer;
str:string;
begin
  result:=false;
  for i:= 0 to jplaces.Count-1 do
  begin
   str:=jplaces.Child[i].Field['id'].Value;
   if str=IntToStr(id)+strAtt+FormatDateTime('yyyy',date) then
   begin
    jplaces.Delete(i);
    result:=true;
    break;
   end;
  end;



end;

begin
// if not  isplaces then
// begin
 obj:=TlkJSONObject.Create;
 obj.Add('id',IntToStr(id)+strAtt+FormatDateTime('yyyy',date));
result:=jdel.Add(obj);
//  end;
end;

function TSentToServ.AddPlace(id: integer; street, houses: String;
  stopplan, stopfact, resplan,resfact: TDateTime): integer;
var stop,res,place:TlkJSONObject;
  buildlist:TlkJSONlist;
   str:string;

 function addInter(obj:TlkJSONObject;plan,fact:TDateTime):integer;
  begin
   if plan>min_time then
   str:=formatDateTime(formatDat,plan)+'T'+formatDateTime(formatTime,plan)
   else
   str:='';
   obj.Add('plan',str);
   if fact>min_time then
   str:=formatDateTime(formatDat,fact)+'T'+formatDateTime(formatTime,fact)
   else
   str:='';
   obj.add('fact',str);
   result:=1;


 end;
begin
  stop:=TlkJSONObject.Create();
  addInter(stop,stopplan,stopfact);
  res:=TlkJSONObject.Create();
  addInter(res,resplan,resfact);
  place:=TlkJSONObject.Create();
  str:=IntToStr(id)+strAtt+formatDateTime('yyyy',stopfact);
  place.Add('id',str);
  place.Add('street',street);
  buildlist:=TlkJSONlist.Create;
  buildlist.Add(houses);
  place.Add('rangeBuilding',buildlist);
  place.Add('stopping',stop);
  place.Add('resumption',res);
  result:=jplaces.Add(place);

 { stop.Free;
  stop:=nil;

  res.Free;
  res:=nil;

  buildlist.Free;
  buildlist:=nil;

 // place.Free;
 // place:=nil;
 }
end;



constructor TSentToServ.create(http: ThttpSent; id: integer;
  date: TDateTime; tAtt: integer; adres: string;log:boolean; kod:char);
begin
inherited create;
jplaces:=TlkJsonlist.Create;
jdel:=TlkJsonlist.Create;
self.http:=http;
_isSentHead:=false;

 case tatt of
 1,4: tatt:=1;
 2,5: tatt:=2;
 3  :tatt:=3;
 end;
TAttach:=tatt;
F_kod:=kod;
self.id:=InttoStr(id)+'#'+f_kod+'#'+FormatDateTime('yyyy',date);

self.date:=date;
self.adres:=adres;
self.worklog:=log;
F_canSent:=true; // сначала нужно попробовать отослать
min_time := StrToDateTime('01.01.2000');
end;

destructor TSentToServ.free;
begin
if jdel<>nil then
jdel.Free;
if jplaces<>nil then
 jplaces.Free;
end;

function TSentToServ.SentAdd: boolean;
var json:TlkJSONObject;
begin
 result:=false;
 if jplaces<>nil  then
// if F_canSent then
  if jplaces.Count>0 then
  begin
    json:=TlkJSONObject.Create();
    try
      json.Add('repairId',self.id);
      json.Add('places',jplaces);
      try
        result:=sentJson(json,Addurl);
      except
        result:=false;
      end;
    finally
      json.Free;
      jplaces:=nil;
    end;
  end
  else
    result:=false
 else
  result:=false


end;

function TSentToServ.SentDel: boolean;
var json:TlkJSONObject;
begin
 json:=TlkJSONObject.Create();
 try
 result:=false;
   if  jdel<>nil then
//   if F_canSent then
    if jdel.Count>0 then
    begin

     json.Add('repairId',id);
     json.Add('places',jdel);
     try
       result:=sentJson(json,DelUrl);
      except
         result:=false;
      end;
    end;
 finally
  json.Free;
  jdel:=nil;
 end;

end;

function TSentToServ.SentHead: boolean;
 var json:TlkJSONObject;
begin
result:=false;
//if F_canSent then
if (jdel.Count>0) or (jplaces.Count>0) then
begin
json:=TlkJSONObject.Create();
try

json.Add('id',id);
json.Add('date',formatdatetime(formatdat,date));
json.Add('type',typDiscon[tAttach]);
json.Add('text',setText(f_kod,formatPlaces[tAttach],adres));
try
result:=sentJson(json,NewUrl);
_isSentHead:=true;
except
 result:=false;
end;
finally
  json.Free;
end;
end;
end;

function TSentToServ.strAtt: string;
begin
if tAttach=2 then
 result:='#k#'
else
 result:='#v#';
end;

procedure myWorkLog(_logtext:string);
var f: textfile;
fileH:integer;
begin
 if  not FileExists(ExtractFilePath(ParamStr(0)) + 'sentjson.log') then begin
  fileH:=FileCreate(ExtractFilePath(ParamStr(0)) + 'sentjson.log');
  FileClose(fileH);
  end;

    AssignFile(F, ExtractFilePath(ParamStr(0)) + 'sentjson.log') ;

    Append(F);
    WriteLn(F, DateTimeToStr(Now)+' :: '+_logtext);
    Flush(F);
    CloseFile(F);
end;
function TSentToServ._isSentAdd: boolean;
begin
 result:=( jplaces=nil);
end;

function TSentToServ._isSentDel: boolean;
begin
 result:=( jdel=nil);
end;

function TSentToServ.sentJson(json:TlkJSONObject;url:string):boolean;
 var stream:TStringStream;
   answer:string;
begin
//result:=false;
 stream:=TStringStream.Create('');
 try
     TlkJSONstreamed.SaveToStream(json,stream);
     if worklog then
       myworklog('post to '+url+':' +stream.DataString);
     {$ifdef sent}
     if F_canSent then
       result:=http.doPost(url,stream,answer)
     else
      result:=false;
     F_canSent:=result;
     if worklog then
      begin
        myworklog('Answer : '+answer);
        myworklog('Status : '+http.pErrr+' status '+BoolToStr(http.pStatus,true) );
    end;
    {$endif}
 finally
 stream.free;
 end;

end;

function getProx( var proxHost,proxyPort,proxUser,proxPassword:string):boolean;
var  Ini: TIniFile;
path:string;
begin
try
 path:=ExtractFilePath(Application.ExeName);

  Ini:=TIniFile.Create(path+'proxy.ini');
 path:=path+'1';
try
  proxHost:=Ini.ReadString('proxy','Host','');
  proxyPort:=Ini.ReadString('proxy','Port','8080');
  proxUser:=Ini.ReadString('proxy','User','');
  proxPassword:=Ini.ReadString('proxy','Pass','');
finally
Ini.Free;
end;
except
  proxHost:='';
 proxyPort:='8080';
 proxUser:='';
 proxPassword:='';

end;
result:=true;
end;

end.
