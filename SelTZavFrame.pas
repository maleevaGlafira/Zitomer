unit SelTZavFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseItemSelecterFrame, StdCtrls, Buttons;

type
  Tframe_SelTZav = class(Tframe_BaseItemSelecter)
  private
    procedure Init; override;
  public
  end;


implementation

{$R *.dfm}

uses AvrDBConst;

{ Tframe_SelTZav }

procedure Tframe_SelTZav.Init;
begin
  F_ItemSelecter.IsMakeFullSelectIfNotShow := false;
  F_ItemSelecter.FormCaption := 'Выберите тип наряда';
  F_ItemSelecter.SQL :=
    ' select id ItemID, name_r ItemName' +
    ' from s_tzav' +
    ' where ( del in (''-'') ) and ( id > 0 )' +
    ' order by name_r';
  //
  F_FieldName := 'Тип наряда';
end;

end.
