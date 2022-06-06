unit QShevelevUnit;

interface
uses SysUtils,DateUtils,MadExtrapolateUnit,{ShevelGraphUnit,}Graphics;

const

  ALL_DIAMS=39;

type

  TMatArr=array [0..ALL_DIAMS-1] of double;

const

  {äèàìåòð = ìì}
  SHEV_ARR_DIAM: TMatArr =
    ({0}10,15,20,25,40,         {5}50,60,65,75,80,
    {10}100,125,150,200,250,      {15}300,350,400,450,500,
    {20}600,700,800,900,1000,     {25}1200,1400,1500,1600,1700,
    {30}1800,1900,2000,2100,2200, {35}2300,2400,2500,2600);

  {ïîòîê ë/ñ}
  SHEV_STAL_DIAM: TMatArr =
    ({0}0.21, 0.35, 0.65, 1.1, 2.5, {5}6.5, 7.7, -1, 11, 14.25,
    {10}20.5, 28, 39.5, 69, 106,      {15}152, 208, 268, 344, 420,
    {20}600, 790, 1020, 1290, 1580,   {25}2280, 3080, -1, 4020, -1,
    {30}-1, -1, -1, -1, -1,           {35}-1, -1, -1, -1);

  {ïîòîê ë/ñ}
  SHEV_CHUGUN_DIAM: TMatArr =
    ({0}0.21, 0.35, 0.65, 1.1, 2.5, {5}6.5, -1, 7, -1, 10.75,
    {10}16.5, 25.5, 36.5, 65 , 101,   {15}146, 196, 254, 320, 396,
    {20}570, 770, 1000, 1280, 1580,   {25} 2280, 3080, -1, 4020, -1,
    {30}-1 , -1, -1, -1, -1,          {35}-1, -1, -1, -1);

type


  TMatPipe=(tmpNull,tmpStal,tmpChugun);

  TQShevelev=class
    private
      FMatPipe:TMatPipe;
      FStalArr:TMatArr;
      FChugunArr:TMatArr;
      FMatPipeStr:string;
      FMadExtrapolate:TMadExtrapolate;
      function _GetPotokLS(_diam:integer; _mat_arr:array of double):double;
      procedure SetFMatPipeStr(value:string);
    protected
    public
      constructor Create;
      destructor Destroy; override;
      //
      function GetPotokLS(_diam:integer):double;
      function GetQinM3(_time:TDateTime; _diam:integer):double;
      //procedure PrintShevelevGraph;
      //
      property MatPipeStr:string read FMatPipeStr write SetFMatPipeStr;
  end;

implementation


{procedure TQShevelev.PrintShevelevGraph;
var _frm_ShevelevGraph:Tfrm_ShevelevGraph;
  i,k:integer;
begin
  _frm_ShevelevGraph:=Tfrm_ShevelevGraph.Create(nil);
  try
     _frm_ShevelevGraph.MainChart.SeriesList.Series[0].Clear;
     _frm_ShevelevGraph.MainChart.SeriesList.Series[1].Clear;
     //
     MatPipeStr:='ÑÒÀËÜ';
     _frm_ShevelevGraph.MainChart.SeriesList.Series[0].Title:=MatPipeStr;
     for i:=0 to ALL_DIAMS-1 do
      begin
        _frm_ShevelevGraph.MainChart.SeriesList.Series[0].AddXY(SHEV_ARR_DIAM[i],GetPotokLS(trunc(SHEV_ARR_DIAM[i])));
      end;
    //
    MatPipeStr:='×ÓÃÓÍ';
    _frm_ShevelevGraph.MainChart.SeriesList.Series[1].Title:=MatPipeStr;
     for i:=0 to ALL_DIAMS-1 do
      begin
        _frm_ShevelevGraph.MainChart.SeriesList.Series[1].AddXY(SHEV_ARR_DIAM[i],GetPotokLS(trunc(SHEV_ARR_DIAM[i])));
      end;
    _frm_ShevelevGraph.ShowModal;
  finally
    _frm_ShevelevGraph.Free;
  end;
end;}

function TQShevelev.GetQinM3(_time:TDateTime; _diam:integer):double;
var _chasov:double;
begin
  _chasov:=HourOf(_time)+MinuteOf(_time)/60+SecondOf(_time)/3600;
  result:=_chasov*3600*(GetPotokLS(_diam)/1000);
end;

procedure TQShevelev.SetFMatPipeStr(value:string);
begin
  FMatPipeStr:=AnsiUpperCase(trim(value));
  FMatPipe:=tmpNull;
  if POS('ÑÒÀËÜ',FMatPipeStr)>0 then FMatPipe:=tmpStal
    else
  if POS('×ÓÃÓÍ',FMatPipeStr)>0 then FMatPipe:=tmpChugun;
end;

function TQShevelev.GetPotokLS(_diam:integer):double;
begin
  result:=-3;
  case FMatPipe of
      tmpStal: result:=_GetPotokLS(_diam,SHEV_STAL_DIAM);
      tmpChugun: result:=_GetPotokLS(_diam,SHEV_CHUGUN_DIAM);
        else
      result:=_GetPotokLS(_diam,SHEV_STAL_DIAM);
    end;
end;

function TQShevelev._GetPotokLS(_diam:integer; _mat_arr:array of double):double;
var i,k:integer;
begin
  k:=-1;
  for i:=0 to ALL_DIAMS-1 do
    begin
      if (SHEV_ARR_DIAM[i]=_diam) then k:=i;
    end;
  if k=-1 then result:=-2 else result:=_mat_arr[k];
  if result<=-1 then result:=FMadExtrapolate.SimpleExtrapolate(0,0,9999,4020,ALL_DIAMS,SHEV_ARR_DIAM,_mat_arr,_diam);
end;

constructor TQShevelev.Create;
begin
  inherited Create;
  FMadExtrapolate:=TMadExtrapolate.Create;
end;

destructor TQShevelev.Destroy;
begin
  FMadExtrapolate.Free;
  inherited;
end;

end.
