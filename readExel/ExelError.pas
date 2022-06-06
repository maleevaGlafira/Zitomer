unit ExelError;

interface

 

 const StartTableWord='���';

 const StartYearWord='�����������';
 const monthes_rus : array [1..12]  of string = ('������','�������','����','������','���','����','����','������','��������','�������','������','�������');
// const monthes_ua = array [1..12] of integer = [];
const Digits = ['0'..'9'];
const NameWord = '������������';
const UnitWord = '��.���.';
const PriceWord = 'ֳ��';
const EndSaldWord = 'ʳ��. ������';
const LeftWord = 'ʳ������';
const NameWord2 = ' ��������';
const Sumword = '����';

const Error_FileNotFound='���� �� ��������!!';
const Error_OpenFile='�� ���� ������� ������';
const Warmimg_ToManyWorkBooks = '������ ���� � �������� ������ ���� ����';
const  Warning_ToManySheets = ' ������ ����� � �������� ������� ���� ����';
const Error_ReadExel = '������� ������� ����� ';
const Error_IncorrectTitleRow = '�������� ������ ��������� ����������� "����������� ��� �� ���������� �� ������:  2021 �."';
const Error_IncorrectTitleTableRow = '����������� ������ ���������  �������';
const Error_closeFile = '������� ������� �����!!';
const Error_readYear = '������� ������� ����';
const Error_IncorrectReport= '������ ������ ��������� �����';
const Error_Format = '������������ ������ ������ � ������';
const Error_Emty_exel = '������� Exel ���� ����������� ����� ���  ����';
const  Err_Read_Cols_totle = '������� ������� ���������� �������!! ';
const  Err_Find_all_titles = '����������� �������� ���������  �������';
const Err_MaterreportAlreadyExist = '����� ����������� ��� ��� � � ���';

const Cap_left = '�����.';
const Cap_all_q = '������';
const Cap_isstore = '���';

const msgAddMaterReport = '��������� ������������ ����';


const monthes_ru : array [1..12]  of string = ('������','�������','����','������','���','����','����','������','��������','�������','������','�������');
const monthes_ua : array [1..12]  of string = ('ѳ����', '�����', '��������', '������', '�������', '�������', '������', '�������', '��������', '�������', '��������', '�������' );

function setMonth_ru(num:integer):string;
function setMonth_ua(num:integer):string;
function setFirstdtMonth(month, year:integer):string;
implementation

uses SysUtils;
function setMonth_ru(num:integer):string;
begin
 result:='';
 if (num>=1 )and (num<=12) then
 result:=monthes_ru[num];
end;

function setMonth_ua(num:integer):string;
begin
 result:='';
 if (num>=1 )and (num<=12) then
 result:=monthes_ua[num];
end;

function setFirstdtMonth(month, year:integer):string;
var stryear:string;
begin
 result:='01';
 if month<10 then
  result:=result+format('.0%d.',[month])
 else
  result:=result+format('.0%d.',[month]);
  stryear:=IntTostr(year);
   Delete(stryear,1,2);
 result:=result+stryear

end;



end.
