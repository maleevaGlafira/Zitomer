unit SelSodFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseItemSelecterFrame, StdCtrls, Buttons;

type
  Tframe_SelSod = class(Tframe_BaseItemSelecter)
  private
    procedure Init; override;
  public
  end;


implementation

{$R *.dfm}

uses AvrDBConst;

{ Tframe_SelSod }

procedure Tframe_SelSod.Init;
begin
  F_ItemSelecter.IsMakeFullSelectIfNotShow := false;
  F_ItemSelecter.FormCaption := 'Выберите характер повреждения';
  F_ItemSelecter.SQL := AvrDBConst.SEL_S_SOD_NZAV;
  //
  F_FieldName := 'Характер повреждения';
end;

end.
