unit SelRevsFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseItemSelecterFrame, StdCtrls, Buttons;

type
  Tframe_SelRevs = class(Tframe_BaseItemSelecter)
  private
    procedure Init; override;
  public
  end;


implementation

{$R *.dfm}

{ Tframe_SelRevs }

procedure Tframe_SelRevs.Init;
begin
  F_ItemSelecter.IsMakeFullSelectIfNotShow := false;
  F_ItemSelecter.FormCaption := 'Выберите цех';
  F_ItemSelecter.SQL :=
    ' select id ItemID, name_r ItemName' +
    ' from s_revs' +
    ' where (del=''-'') and (id>0)' +
    ' order by name_r';
  //

  F_FieldName := 'Цех';  
end;

end.
 