unit _avonm_DopFuncsUnit;

interface

uses SendMessToAvarOnMap,AvarOnMapConst,Graphics,SysUtils;

function GetTextTypeOfAvar(_Attach:TAttach;_nom_narjad,_year_narjad:integer):string;
procedure SaveEmptyPic(_width,_height:integer;_fn:string);

implementation

procedure SaveEmptyPic(_width,_height:integer;_fn:string);
var _bm:TBitmap;
begin
  try
    try
      _bm:=TBitmap.Create;
      _bm.Width:=_width;
      _bm.Height:=_height;
      _bm.Canvas.Brush.Color:=clWhite;
      _bm.Canvas.FillRect(_bm.Canvas.ClipRect);
      _bm.Canvas.Brush.Color:=clBlack;
      _bm.Canvas.FrameRect(_bm.Canvas.ClipRect);
      _bm.SaveToFile(_fn);
    finally
      _bm.Free;
    end;
  except
    //
  end;
end;

function GetTextTypeOfAvar(_Attach:TAttach;_nom_narjad,_year_narjad:integer):string;
var _id_avar:integer;
  _TypeOfAvar:TTypeOfAvar;
begin
  if (MAP_IS_WORK) and (ManageAvarOnMap.RECEIVE_TYPES) then
  begin
    _id_avar:=EncodeID(_Attach,_nom_narjad, Byte(_year_narjad-1899));
    _TypeOfAvar:=ManageAvarOnMap.GetTypeByIDAvar(_id_avar);
    //
    case _TypeOfAvar of
      toaNull: result:='-';
      toaBezAddr:  result:='Без адр.';
      toaPredv:  result:='Предвар.';
      toaRazm:  result:='Разм.';
    end;
  end else result:='no info';
end;

end.
