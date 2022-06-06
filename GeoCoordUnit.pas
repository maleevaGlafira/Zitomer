unit GeoCoordUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RXCtrls, StdCtrls, RXSpin, Buttons;

type
  TFrm_GEOCOORD = class(TFrame)
    se_Deg_N: TRxSpinEdit;
    se_Min_N: TRxSpinEdit;
    se_Sec_N: TRxSpinEdit;
    se_Deg_E: TRxSpinEdit;
    se_Min_E: TRxSpinEdit;
    se_Sec_E: TRxSpinEdit;
    RxLabelN: TRxLabel;
    RxLabelE: TRxLabel;
    BitBtn1: TBitBtn;
    procedure bt_OKClick(Sender: TObject);
   // function se_Check(Sender: TObject): boolean;
  private
    { Private declarations }
    f_geosecN: real;
    f_geosecE: real;
  public
    { Public declarations }
    procedure SecToMinDeg(_secin : real; var  _deg, _min : integer; var _secout: real);
    function AllToSec(_deg, _min: integer; _sec:real):real;
    property geosecN: real read f_geosecN write f_geosecN;
    property geosecE: real read f_geosecE write f_geosecE;
    function AllCHECKED: boolean;
  end;

implementation

{$R *.dfm}

procedure TFrm_GEOCOORD.bt_OKClick(Sender: TObject);
begin
  f_geosecN := AllToSec(se_Deg_N.AsInteger, se_Min_N.AsInteger, se_Sec_N.Value);
  f_geosecE := AllToSec(se_Deg_E.AsInteger, se_Min_E.AsInteger, se_Sec_E.Value);



end;

procedure TFrm_GEOCOORD.SecToMinDeg(_secin : real; var  _deg, _min : integer; var _secout: real);
const    c_min = 60;
         c_deg = 3600;
var _isec : integer;
    _ir : real;
begin
//    x mod y = x - (x div y) * y
// mod - остаток от деления, div - целочисленное деление

  _ir := int( _secin);
  _isec := trunc(_ir);
  _Deg := _isec div c_deg;
  _min := _isec div c_min - ( _deg * c_min );
  _secout := _secin - (_deg * c_deg) - ( _min * c_min );


end;

function TFrm_GEOCOORD.AllToSec(_deg, _min: integer; _sec:real):real;
begin

   result := (_deg * 3600) + (_min * 60) + _sec;
end;

function TFrm_GEOCOORD.AllCHECKED: boolean;

    function se_Check(Sender: TObject): boolean;
    var _nm, _nd: integer; // множители минут и градусов
        _tsec : real;
    begin
     if ((sender as TRxSpinEdit).Value > (sender as TRxSpinEdit).MaxValue )
     or ((sender as TRxSpinEdit).Value < (sender as TRxSpinEdit).MinValue ) then
      begin
        MessageBox(handle,'Некорректные координаты','Диспетчер АВР',MB_OK or MB_ICONSTOP);
        result := false;
        end
       else result := true;

    {  _nm := 0;
      _nd := 0;
      _tsec := se_Sec_E.Value;
      if _tsec >=60 then
        begin
          _nm := Trunc(_tsec) div 60;
          if _nm > 59 then _nd := _nm div 60;
          se_Sec_E.Value := _tsec - 60;
          se_Min_E.AsInteger := se_Min_E.AsInteger + _nm;
          se_Deg_E.AsInteger := se_Deg_E.AsInteger + _nd;
        end;
     }
    end;

begin

    result := ( se_Check(se_Deg_N) and se_Check(se_Deg_E)
             and se_Check(se_Min_N) and se_Check(se_Min_E)
             and se_Check(se_Sec_N) and se_Check(se_Sec_E) );

end;


end.
