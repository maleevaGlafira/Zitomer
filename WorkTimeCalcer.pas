unit WorkTimeCalcer;

{
  Класс для подсчета общего времени работ.
  Нужен, т.к. некоторые периоды работы перекрывают друг друга
  и может быть ситуация, что одно и то же время считается несколько раз.
  Все периоды изначально должны быть отсортерованы по дате начала работ
}

interface

uses Classes;

type
  TWorkTime=class
  private
    F_BeginWork,
    F_EndWork: TDateTime;
  public
    property BeginWork: TDateTime read F_BeginWork write F_BeginWork;
    property EndWork: TDateTime read F_EndWork write F_EndWork;
  end;

  TWorkTimeList=class(TList)
  public
    procedure Clear; override;
    function AddWorkTime( _BeginWork, _EndWork: TDateTime ): TWorkTime; //все периоды изначально должны быть отсортерованы по дате начала работ
  end;

  TWorkTimeCalcer=class
  private
    F_WorkIntervals: TWorkTimeList;
    procedure CalcUplotIntervals( out _list: TWorkTimeList );
  public
    property WorkIntervals: TWorkTimeList read F_WorkIntervals write F_WorkIntervals;
    constructor Create;
    destructor Destroy; override;
    function Calc: double;
  end;


implementation

{ TWorkTimeCalcer }

function TWorkTimeCalcer.Calc: double;
var
  _UplotIntervals: TWorkTimeList;
  _wt: TWorkTime;
  i: integer;
begin
  _UplotIntervals := TWorkTimeList.Create;
  try
    CalcUplotIntervals( _UplotIntervals );
    Result := 0;
    for i:=0 to _UplotIntervals.Count-1 do
    begin
      _wt := TWorkTime( _UplotIntervals.Items[ i ] );
      Result := Result + ( _wt.EndWork - _wt.BeginWork );
    end;
  finally
    _UplotIntervals.Free;
  end;
end;

procedure TWorkTimeCalcer.CalcUplotIntervals(out _list: TWorkTimeList);
var
  i, _count: integer;
  _tmp_ls: TWorkTimeList;
  _tek_wt, _next_wt: TWorkTime;
  _is_find: boolean;
begin
  _tmp_ls := TWorkTimeList.Create;
  try
    for i:=0 to F_WorkIntervals.Count -1 do
    begin
      _tek_wt := TWorkTime( F_WorkIntervals.Items[ i ] );
      _tmp_ls.AddWorkTime( _tek_wt.BeginWork, _tek_wt.EndWork );
    end;

    _count := _tmp_ls.Count;
    while _count > 0 do
    begin
      _tek_wt := TWorkTime( _tmp_ls.Items[ 0 ] );
      _is_find := false;
      for i := 1 to _tmp_ls.Count-1 do
      begin
        _next_wt := TWorkTime( _tmp_ls.Items[ i ] );
        if _next_wt.BeginWork < _tek_wt.EndWork then
        begin
          if _next_wt.EndWork > _tek_wt.EndWork then _tek_wt.EndWork := _next_wt.EndWork;
          _tmp_ls.Delete( i );
          _count := _tmp_ls.Count;
          _is_find := true;
          break;
        end;
      end;
      if not _is_find then
      begin
        _list.AddWorkTime( _tek_wt.BeginWork, _tek_wt.EndWork );
        _tmp_ls.Delete( 0 );
        _count := _tmp_ls.Count;
      end;
    end;
  finally
    _tmp_ls.Free;
  end;
end;

constructor TWorkTimeCalcer.Create;
begin
  inherited;
  F_WorkIntervals := TWorkTimeList.Create;
end;

destructor TWorkTimeCalcer.Destroy;
begin
  F_WorkIntervals.Free;
  inherited;
end;

{ TWorkTimeList }

function TWorkTimeList.AddWorkTime(_BeginWork,
  _EndWork: TDateTime): TWorkTime;
begin
  Result := TWorkTime.Create;
  Result.BeginWork := _BeginWork;
  Result.EndWork := _EndWork;

  Add( Result );
end;

procedure TWorkTimeList.Clear;
var
  i: integer;
begin
  for i:=0 to Count-1 do
    TWorkTime( Items[ i ] ).Free;
  inherited Clear;
end;

end.
