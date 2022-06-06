function FormZav:TFormZav;
begin
  if FCountZav in [1..16]
  then result:=FArrZavForm[FCountZav]
  else result:=nil;
end;

procedure PushFormZav(Frm:TFormZav);
begin
  inc(FCountZav);
  FArrZavForm[FCountZav]:=Frm
end;

procedure PopFormZav;
begin
  FArrZavForm[FCountZav]:=nil;
  dec(FCountZav);
end;