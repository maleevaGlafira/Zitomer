unit OperAttFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FRMLANG, Menus;

type
  TFormMode=(tfmZayavNew,tfmZayavCopy,tfmZayavAfterInsert);
  TOperAtt=(
    toaNull     = 0,
    toaVoda     = 1,
    toaKanal    = 2,
    toaVRK      = 3,
    toaObjVoda  = 4,
    toaObjKanal = 5 );

  TOperAttForm = class(TFormLang)
  private
    { Private declarations }
  public
    { Public declarations }
    OperateAttach:TOperAtt;
    function OperAttFormFill(Sender:TObject):TOperAtt;
  end;

function OperAttDetectFromMenuItem(Sender:TObject):TOperAtt;
function GetAttachName(oper_att: TOperAtt): string;

var
  OperAttForm: TOperAttForm;
  LastMenuItemSender_Tag:integer;

implementation

{$R *.dfm}
uses cntsLang;

function GetAttachName(oper_att: TOperAtt): string;
begin
  case oper_att of
    toaVoda: Result := TrLangMSG(msgVodoprovod);//'бнднопнбнд';
    toaKanal: Result := TrLangMSG(msgKANANAL);//'йюмюкхгюжхъ';
    toaVRK: Result := TrLangMSG(msgVRK);//'бпй';
    toaObjVoda: Result := TrLangMSG(msgObjVdod);//'назейрш бнднопнбндю';
    toaObjKanal: Result :=TrLangMSG(msgObjKanal); //'назейрш йюмюкхгюжхх';
  end;
end;


function OperAttDetectFromMenuItem(Sender:TObject):TOperAtt;
var _sender_menu:boolean;
begin
  if (Sender=nil) then _sender_menu:=false else _sender_menu:=(Sender is TMenuItem);
  //
  if not _sender_menu then
    begin
      if LastMenuItemSender_Tag=0 then exit;
    end
      else LastMenuItemSender_Tag:=(Sender as TMenuItem).Tag;
  case LastMenuItemSender_Tag of
    1: result := toaVoda;
    2: result := toaKanal;
    3: result := toaVRK;
    4: result := toaObjVoda;
    5: result := toaObjKanal;
    else
    result:=toaVoda;
  end;
end;

function TOperAttForm.OperAttFormFill(Sender:TObject):TOperAtt;
var _OperAtt:TOperAtt;
begin
  _OperAtt:=OperAttDetectFromMenuItem(Sender);
  //
  with self do
  begin
    case _OperAtt of
      toaVoda: Caption := Caption + ' '+TrLangMSG(msgVodoprovod);
      toaKanal: Caption := Caption + ' '+TrLangMSG(msgKANANAL);//йюмюкхгюжхъ ';
      toaVRK: Caption := Caption + ' ' +TrLangMSG(msgVRK);//' бпй';
      toaObjVoda: Caption := Caption + ' '+TrLangMSG(msgObjVdod);//назейрш бнднопнбндю';
      toaObjKanal: Caption := Caption + ' '+TrLangMSG(msgObjKanal);//назейрш йюмюкхгюжхх';
    end;
  end;
  Result:=_OperAtt;
end;

end.
