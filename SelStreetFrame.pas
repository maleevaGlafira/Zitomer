unit SelStreetFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseItemSelecterFrame, StdCtrls, Buttons;

type
  Tframe_SelStreets = class(Tframe_BaseItemSelecter)
  private
    { Private declarations }
    procedure Init; override;
  public
    { Public declarations }
  end;

var
  frame_SelStreets: Tframe_SelStreets;

implementation

{$R *.dfm}
procedure Tframe_SelStreets.Init;
begin
F_ItemSelecter.IsMakeFullSelectIfNotShow := false;
  F_ItemSelecter.FormCaption := 'Выберите улицу';
  F_ItemSelecter.SQL :=   'select su.id as ItemID,  '+
                          'trim(su.name_r)||'' ''||lower(trim(sv.name_r)) as ItemName '+
                          ' from s_ulic su join s_vidul sv on sv.id=su.id_vidul '+
                          ' where (id>0) and del=''-''  order by 2'  ;

  //

  F_FieldName := 'Улица';
end;

end.
