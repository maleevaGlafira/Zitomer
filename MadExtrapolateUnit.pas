unit MadExtrapolateUnit;

interface

type

  TMadExtrapolate=class
  private
    //Fxmin,Ffmin,Fxmax,Ffmax:double;
  protected
    function LagrangeInterpolate(n:Integer; x,F:array of double;t:Double):Double;
  public
    function SimpleExtrapolate(xmin,fmin,xmax,fmax:double; n:Integer; const x,F:array of double; t:Double):Double;
  end;

implementation

{------------------------------------------------------------------------------}
{*** Ѕ≈«”ћЌјя Ё —“–јѕќЋя÷»я ****}
function TMadExtrapolate.SimpleExtrapolate(xmin,fmin,xmax,fmax:double; n:Integer; const x,F:array of double; t:Double):Double;
var k:double;
  i,j:integer;
  X1,F1:array of double;
begin
  SetLength(X1,n);
  SetLength(F1,n);
  j:=0;
  for i:=0 to N-1 do
    begin
      if F[i]<>-1 then
        begin
          F1[j]:=F[i];
          X1[j]:=X[i];
          inc(j);
        end;
    end;
  N:=j;
  //
  if t<X1[0] then
    begin
      k:=(t-xmin)/(X1[0]-xmin);
      result:=fmin+(F1[0]-fmin)*k;
    end
      else
  if t>x[n-1] then
    begin
      k:=(t-X1[n-1])/(xmax-X1[n-1]);
      result:=F1[n-1]+(fmax-F1[n-1])*k;
    end
      else
  if (t>=X1[0]) or (t<=X1[n-1]) then
    begin
      result:=LagrangeInterpolate(n,X1,F1,t);
    end;
end;

function TMadExtrapolate.LagrangeInterpolate(n:Integer; x,F:array of double; t:Double):Double;
{короче, вроде как такое:
ѕараметры:
    N       - число точек в массиве
    X, F    - массивы абсцисс и ординат с номерами от 0 до N-1.
    T       - параметр, положение точки на кривой.
    
–езультат:
    «начение интерпол€ционного полинома проход€щего через точки
(x[i], F[i]), в точке t.
}
var
    I,J,k:Integer;
    less2,less1,more1,more2:integer;
    _X,_F:array [0..3] of double;
begin
  //
  if N>3 then
    begin
      for i:=0 to N-2 do
        begin
          if (X[i]<=t) and (X[i+1]>=t) then
            begin
              N:=4;
              less1:=i;
              more1:=i+1;
              if (i-1<0) then less2:=i else less2:=i-1;
              if (i+2>(N-1)) then more2:=i+1 else more2:=i+2;
              _F[0]:=F[less2]; _F[1]:=F[less1]; _F[2]:=F[more1]; _F[3]:=F[more2];
              _X[0]:=X[less2]; _X[1]:=X[less1]; _X[2]:=X[more1]; _X[3]:=X[more2];
              k:=1; F[0]:=_F[0]; X[0]:=_X[0];
              for j:=1 to N-1 do
                begin
                  if _X[j-1]<>_X[j] then
                    begin
                      F[k]:=_F[j];
                      X[k]:=_X[j];
                      inc(k);
                    end else dec(N);                      
                end;
            end;
        end;
    end;
  //
  try
    N:=N-1;
    j:=0;
    while j<=n-1 do
    begin
      i:=j+1;
      while i<=n do
      begin
          F[i]:=((t-X[j])*F[i]-(t-X[i])*F[j])/(X[i]-X[j]);
        Inc(i);
      end;
      Inc(j);
    end;
    Result:=F[n];
  except
    result:=-1;
  end;
end;

{------------------------------------------------------------------------------}

end.
