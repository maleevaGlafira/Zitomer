unit HelpFunctionsSentDiscon;


interface



uses SysUtils

,Zav_DMUnit;
const OwneyKECBB = 13; //�Ȫ��� ���� ���    d    kan r
const TYPEHIIDELEAK = 8; //����������� ���� ���     d  kan r


const TypeHideLeakKan =4; //������� ����



const fromatText = '���������� ��������� ����� �� ������ %s';//'���������� ��������� ����� �� ���������� ����  %s �� ������ %s';
const fromatTextD = '����������� ������������� �� ������ %s';
const fromatTextR  = '����������� ������������� �� ������ %s';


function calcIdKod(DM_Zavv:TDM_Zavv;ZavCode:integer;tAtt: integer=0 ):char; //��������� ��� � �������� �� � ������
function setText(kod:char;place:string; adress:string):string;

implementation

function calcIdKod(DM_Zavv:TDM_Zavv;ZavCode:integer;tAtt: integer ):char;

var attach:integer;
begin
 if  tAtt=0 then
   tAtt:=Ord(DM_Zavv.GetZavAttach(ZavCode));
if tAtt in [2,5] then begin tAtt:=2 ;result:='v' end
else
if tAtt  = 3 then begin attach:=3 ; result:='k' end
else
if tAtt in [1,4] then
begin
  if (DM_Zavv.Qry_owner.FieldByName('id').AsInteger=OwneyKECBB)
   and (DM_Zavv.Qry_tzav.FieldByName('id').AsInteger=TYPEHIIDELEAK)
   then   begin
      tAtt:=4;
      result := 'd';
    end
   else
   begin
    tAtt:=1;
    result := 'v';
  end;
end;
if tAtt in [2,5] then
begin
  if (DM_Zavv.Qry_owner.FieldByName('id').AsInteger=OwneyKECBB)
   and (DM_Zavv.Qry_tzav.FieldByName('id').AsInteger=TYPEHIIDELEAK)
   then
   begin
    tAtt:=5;
    result:='r';
   end
   else
   begin
     tAtt:=2;
     result:='k';
   end;
end;
end;

function setText(kod:char;place:string; adress:string):string;
begin
if (kod='d')
 then
    result:=format(fromatTextD,[adress])
 else
 if   (kod='r') then
    result:=format(fromatTextR,[adress])

 else
   result:= format(fromatText,[adress]);
end;

end.
