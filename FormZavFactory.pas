unit FormZavFactory;

{ здесь создаются формы заявки. В зависимости от принадлежности }

interface

uses
  Classes, Zav, Zav_Obj, OperAttFormUnit;

// вот такой конструктор мы должны делегировать конструтор
//constructor ZavCreate(AOwner: TComponent; Mode:TFormMode; zCod:integer);
function TFormZav_ZavCreate( AOwner: TComponent; Mode:TFormMode; zCod:integer ): TFormZav;

implementation

function TFormZav_ZavCreate( AOwner: TComponent; Mode:TFormMode; zCod:integer ): TFormZav;
var
  _OperAtt: TOperAtt;
begin
  if LastMenuItemSender_Tag = 0 then  LastMenuItemSender_Tag := 1 {toaVoda + 1};
  _OperAtt := OperAttDetectFromMenuItem( AOwner );

  if ( _OperAtt in [toaObjVoda, toaObjKanal] )then
    result := TFormZavObj.ZavCreate( AOwner, Mode, zCod )
  else
    result := TFormZav.ZavCreate( AOwner, Mode, zCod );
end;

end.
