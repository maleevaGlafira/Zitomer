unit SvodVed2AlienDModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SvodVed2DModule, FR_DSet, FR_DBSet, DB, RxMemDS, IBDatabase,
  IBCustomDataSet, FR_Class;

type
  Tdm_SvodVed2Alien = class(Tdm_SvodVed2)
  private
  protected
    function get_ownertype_id( IsForCloseZav: boolean ): string; override;
  public
  end;

implementation

{$R *.dfm}


{ Tdm_SvodVed2Alien }

function Tdm_SvodVed2Alien.get_ownertype_id(
  IsForCloseZav: boolean): string;
begin
  Result := '1';
end;

end.
