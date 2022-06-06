unit SelMatFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseItemSelecterFrame, StdCtrls, Buttons;

type
  Tframe_SelMat = class(Tframe_BaseItemSelecter)
  private
    procedure Init; override;
  public
  end;


implementation

{$R *.dfm}

{ Tframe_SelMat }

procedure Tframe_SelMat.Init;
begin
  F_ItemSelecter.IsMakeFullSelectIfNotShow := false;
  F_ItemSelecter.FormCaption := 'Выберите материал';
  F_ItemSelecter.SQL :=
    ' select id ItemID, name_r ItemName' +
    ' from s_mat' +
    ' where (del=''-'') and (id>0)' +
    ' order by name_r';
  //

  F_FieldName := 'Материал';
end;

end.
