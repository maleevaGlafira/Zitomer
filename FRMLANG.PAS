unit frmLANG;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TLangType=(ltRU,ltUA);
  TLangMSG=array[TLangType]of string;

  TFormLang = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure Translate;virtual;
  end;

function TrLangMSG(msg:TLangMSG):string;overload;
function TrLangMSG(msg:TLangMSG;const lang:TLangType):string;overload;

var
  LANG:TLangType=ltUA; // Текущий язык проекта
  days:integer=0;
Const Old_Col=clWindow;
      New_Col=clLime;


implementation

{$R *.DFM}

// Возвращает строку в зависимости от языка
function TrLangMSG(msg:TLangMSG):string;overload;
begin
  result:=msg[LANG]
end;

function TrLangMSG(msg:TLangMSG;const lang:TLangType):string;overload;
begin
  result:=msg[lang]
end;

constructor TFormLang.Create(AOwner: TComponent);
begin
  inherited;
  Translate;
end;

procedure TFormLang
.Translate;
begin
  // inherited;
  // заполняйте свойства в зависимости от языка
end;

end.


