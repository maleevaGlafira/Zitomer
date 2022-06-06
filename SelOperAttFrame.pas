unit SelOperAttFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls;

type
  Tframe_SelOperAtt = class(TFrame)
    gb_Attach: TGroupBox;
    chb_Voda: TCheckBox;
    chb_Kanal: TCheckBox;
    chb_Vrk: TCheckBox;
  private
  public
    function GetOperAtt: string;
  end;

implementation

{$R *.dfm}

{ Tframe_SelOperAtt }

function Tframe_SelOperAtt.GetOperAtt: string;
  procedure _check( _chb: TCheckBox; _att: integer );
  begin
    if _chb.Checked then
      Result := Result + ',' + IntToStr( _att );
  end;
begin
  Result := '';
  _check( chb_Voda,  1 );
  _check( chb_Kanal, 2 );
  _check( chb_Vrk,   3 );

  Delete( Result, 1, 1 );
end;

end.
