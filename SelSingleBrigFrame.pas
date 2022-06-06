unit SelSingleBrigFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseSingleItemSelectFrame, DB, kbmMemTable, RxLookup, StdCtrls;

type
  Tframe_SelSingleBrig = class(Tframe_BaseSingleItemSelect)
  private
    procedure Init; override;
  public
  end;


implementation

{$R *.dfm}

uses AvrDBConst;

{ Tframe_SelSingleBrig }

procedure Tframe_SelSingleBrig.Init;
begin
  F_MemTableFiller.FillResMemTable( AvrDBConst.SEL_S_BRIG );
  F_FieldName := 'Должностное лицо';
end;

end.
