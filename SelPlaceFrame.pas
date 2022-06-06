unit SelPlaceFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseItemSelecterFrame, StdCtrls, Buttons;

type
  Tframe_SelPlace = class(Tframe_BaseItemSelecter)
  private
    procedure Init; override;
  public
  end;


implementation

{$R *.dfm}

uses AvrDBConst;


{ Tframe_SelPlace }

procedure Tframe_SelPlace.Init;
begin
  F_ItemSelecter.IsMakeFullSelectIfNotShow := false;
  F_ItemSelecter.FormCaption := 'Выберите место повреждения';
  F_ItemSelecter.SQL :=
    ' select id ItemID, name_r ItemName'+
    ' from s_place'+
    ' where ( del = ''-'') and ( id > 0 ) ' +
    ' order by name_r';
  //
  F_FieldName := 'Место повреждения';
end;

end.
