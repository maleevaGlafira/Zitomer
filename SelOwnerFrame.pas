unit SelOwnerFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseItemSelecterFrame, StdCtrls, Buttons;

type
  Tframe_SelOwner = class(Tframe_BaseItemSelecter)
  private
    procedure Init; override;
  public
  end;


implementation

{$R *.dfm}

{ Tframe_SelOwner }

procedure Tframe_SelOwner.Init;
begin
  F_ItemSelecter.IsMakeFullSelectIfNotShow := false;
  F_ItemSelecter.FormCaption := 'Выберите вид наряда';
  F_ItemSelecter.SQL :=
    ' select id as ItemID, name_r as ItemName' +
    ' from s_owner' +
    ' where ( del = ''-'' ) and ( id > 0 ) '+
    ' order by name_r';

  //

  F_FieldName := 'Вид наряда';
end;

end.
