unit SvodVed2AlienOptForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SvodVed2OptForm, StdCtrls, Buttons, Mask, ToolEdit, ComCtrls,
  ExtCtrls;

type
  Tfrm_SvodVed2AlienOpt = class(Tfrm_SvodVed2Opt)
  private
    function GetZavTypeNames: string; override;
  public
  end;


implementation

{$R *.dfm}

{ Tfrm_SvodVed2Opt1 }

function Tfrm_SvodVed2AlienOpt.GetZavTypeNames: string;
begin
  Result := 'Чужие';
end;

end.
