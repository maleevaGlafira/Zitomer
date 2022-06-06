unit SelMestFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseItemSelecterFrame, StdCtrls, Buttons;

type
  Tframe_SelMest = class(Tframe_BaseItemSelecter)
  private
    { Private declarations }
     procedure Init; override;
  public
    { Public declarations }
  end;

var
  frame_SelMest: Tframe_SelMest;

implementation

{$R *.dfm}

{ Tframe_BaseItemSelecter1 }

procedure Tframe_SelMest.Init;
begin
  inherited;
  F_ItemSelecter.IsMakeFullSelectIfNotShow := false;
  F_ItemSelecter.FormCaption := 'Выберите местность раскопки';
  F_ItemSelecter.SQL :=
    ' select id ItemID, name_r ItemName'+
    ' from s_mest'+
    ' where ( del = ''-'') and ( id > 0 ) ' +
    ' order by name_r';
  //
  F_FieldName := 'Местность раскопки';
end;

end.
 