
unit httpSentSynapse;


interface
uses
   Windows, Messages, SysUtils, Variants, Classes,httpsend,
  StdCtrls,ssl_openssl,ssl_openssl_lib;


type
 FGetproxy = function ( var proxHost,proxyPort,proxUser,proxPassword:string):boolean;

 ThttpSent = class
  private
    HTTP: THTTPSend;
    httpStatus:boolean;
    str_Error:String;
    ProxyHost,ProxyPort, ProxyUser,    ProxyPass:string;
    getProxy: FGetproxy;
  public
   property pErrr:string read str_Error;
   property pStatus:boolean read httpStatus;
   property pGetProxy:FGetproxy write getProxy;
   function doPost(url:string;stream:TStringStream;var ansver:string):boolean;
   constructor Create(Fproxy:fgetProxy);
   destructor free;
end;

implementation

{ ThttpSent }

constructor ThttpSent.Create(Fproxy: fGetProxy);
var  proxHost,proxyPort,proxUser,proxPassword:string;
begin

  if assigned(fProxy) then
  begin
   getProxy:=fProxy;
   if getProxy(proxhost,proxyPort,proxUser,proxPassword) then
    begin
      self.ProxyHost:=proxhost;
      self.ProxyPort:=proxyPort;
      self.ProxyUser:=proxUser;
      self.ProxyPass:=proxPassword;
    end;
  end;
  try
   

   httpstatus:=true;
  except on e:exception do
  begin
    str_Error:=e.Message;
    httpstatus:=false;
  end
  end;
end;
{Post запрос по указному url данные запроса в stream
  Запрос  выполнен  httpstatus:=true;
  Код ответа 200 значит запрос выполнен успешно в ответе тело ответа запроса  true
  Код ответа не 200 щначит запро выполнен с ошиькой в ответе код ответа

  Запрос не выполнен  httpstatus:=false;
  сообщение об ошибке в str_error

}
function ThttpSent.doPost(url: string; stream: TStringStream; var ansver:string): boolean;
var postStream:TStringStream;
    const
      HttHeaderSeparator = ':';
     
    procedure AddOrReplaceHeader(Headers: TStringList; const Header: string);
    var
      LOldNameValueSeparator: Char;
      SeparatorPos, IndexOfHeader: Integer;
      HeaderName: string;
    begin
      if (Headers = nil) then
        Exit;
      SeparatorPos := Pos(HttHeaderSeparator, Header);
      if (SeparatorPos = 0) then
        raise Exception.Create('Strange header o_O : value missing!');
      HeaderName := Copy(Header, 1, SeparatorPos - 1);
      LOldNameValueSeparator := Headers.NameValueSeparator;
      Headers.NameValueSeparator := HttHeaderSeparator;
      try
        IndexOfHeader := Headers.IndexOfName(HeaderName);
        if (IndexOfHeader >= 0) then
          Headers[IndexOfHeader] := Header
        else
          Headers.Add(Header);
      finally
        Headers.NameValueSeparator := LOldNameValueSeparator;
      end;
    end;
begin
 HTTP:=THTTPSend.Create;
 http.ProxyHost:=proxyHost;
 http.ProxyPort:=ProxyPort;
 http.ProxyUser:=ProxyUser;
 http.ProxyPass:=ProxyPass;
  HTTP.Sock.CreateWithSSL(TSSLOpenSSL);
  httpstatus:=true;
 result:=false;
 postStream:=TStringStream.Create('');
 http.Document.LoadFromStream(stream);
 http.MimeType:='application/json';
 http.UserAgent:='Mozilla/5.0 (Windows NT 5.1; rv:5.0) Gecko/20100101 Firefox/5.0';
// AddOrReplaceHeader(HTTP.Headers, 'User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:5.0) Gecko/20100101 Firefox/5.0');
// AddOrReplaceHeader(HTTP.Headers, 'Content-Type: application/json');

 try

     try
       HTTP.Sock.SSLDoConnect;
       if http.HTTPMethod('post',url) then
        httpstatus:=true
       else
        httpstatus:=false;
       if http.ResultCode=200 then
        begin
          result:=true;
          http.Document.SaveToStream(postStream);
          ansver:=UTF8Decode(postStream.DataString);

        end
        else  begin
        if not httpstatus then
          ansver:='---Can''t do post !!---- '
          else
         ansver:='---Can''t do post !!---- #13 Resuly code is '+IntTOStr(http.ResultCode)+' not succses!!! RESULTSTRING '+HTTP.ResultString;
        end;
      except on e:exception do
      begin
       httpstatus:=false;
       str_error:=e.Message;
       ansver:= 'Error --'+str_error;
       result:=false;
      end;
     end;
 finally
   http.Sock.CloseSocket;
   http.Free;
   http:=nil;
 end;


end;

destructor ThttpSent.free;
begin
//http.Sock.CloseSocket;
if http<>nil then
if assigned(http) then
  http.Free;
  http:=nil;
end;

end.
