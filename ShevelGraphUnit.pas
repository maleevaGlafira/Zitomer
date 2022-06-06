unit ShevelGraphUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, TeeProcs, TeEngine, Chart, Series;

type
  Tfrm_ShevelevGraph = class(TForm)
    MainChart: TChart;
    Series1: TFastLineSeries;
    Series2: TFastLineSeries;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_ShevelevGraph: Tfrm_ShevelevGraph;

implementation

{$R *.dfm}

end.
