unit SelAttachFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ItemSelecter, BaseItemSelecterFrame, StdCtrls, Buttons;

type
  Tframe_SelAttach = class(Tframe_BaseItemSelecter)
  private
    procedure Init; override;
  public
  end;

implementation

{$R *.dfm}

{ Tframe_SelAttach }

procedure Tframe_SelAttach.Init;
begin
  F_ItemSelecter.IsMakeFullSelectIfNotShow := false;
  F_ItemSelecter.FormCaption := 'Выберите принадлежность';
  F_ItemSelecter.SQL :=
    ' select id ItemID, name_r ItemName' +
    ' from s_attach' +
    ' where (del=''-'') and (id>0)' +
    ' order by name_r';
  //
  F_FieldName := 'Принадлежность';
end;

end.
