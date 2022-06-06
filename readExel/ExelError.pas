unit ExelError;

interface

 

 const StartTableWord='Êîä';

 const StartYearWord='Ìàòåğ³àëüíèé';
 const monthes_rus : array [1..12]  of string = ('ßíâàğü','Ôåâğàëü','Ìàğò','Àïğåëü','Ìàé','Èşíü','Èşëü','Àâãóñò','Ñåíòÿáğü','Îêòÿáğü','Íîÿáğü','Äåêàáğü');
// const monthes_ua = array [1..12] of integer = [];
const Digits = ['0'..'9'];
const NameWord = 'Íàéìåíóâàííÿ';
const UnitWord = 'Îä.âèì.';
const PriceWord = 'Ö³íà';
const EndSaldWord = 'Ê³íö. ñàëüäî';
const LeftWord = 'Ê³ëüê³ñòü';
const NameWord2 = ' ö³íîñòåé';
const Sumword = 'Ñóìà';

const Error_FileNotFound='Ôàéë íå çíàéäåíî!!';
const Error_OpenFile='Íå ìîãó ñîçäàòü îáúåêò';
const Warmimg_ToManyWorkBooks = 'Áàãàòî êíèã ó äîêóìåíò³ ïîâèíà áóòè îäíà';
const  Warning_ToManySheets = ' Áàãàòî ëèñò³â ó äîêóìåíò³ ïîâèíåí áóòè îäèí';
const Error_ReadExel = 'Ïîìèëêà ÷èòàííÿ ôàéëà ';
const Error_IncorrectTitleRow = 'Ïåğåâ³ğòå ñòğîêó çàãîëîâêà Î÷èêóâàëîñü "Ìàòåğ³àëüíèé çâ³ò ïî ìàòåğèàëàõ çà Ïåğèîä:  2021 ã."';
const Error_IncorrectTitleTableRow = 'Íåïğàâèëüíà ñòğîêà çàãîëîâêà  òîáëèö³';
const Error_closeFile = 'Ïîìèëêà çàêğ³òòÿ ôàéëà!!';
const Error_readYear = 'Ïîìèëêà ÷èòàííÿ ğîêó';
const Error_IncorrectReport= 'Íåìîæó çíàéòè çàãîëîâêè ñòğîê';
const Error_Format = 'Íåïğàâèëüíèé ôîğìàò äàííèõ ó ÿ÷åéö³';
const Error_Emty_exel = 'Ïîğîæí³é Exel ôàéë íåäîñòàòíüî ëèñò³â àáî  êíèã';
const  Err_Read_Cols_totle = 'Ïîìèëêà ÷èòàííÿ çàãîëîâê³îâ êîëîíîê!! ';
const  Err_Find_all_titles = 'Íåïğàâèëüíî ïğî÷èòàí³ çàãîëîâêè  êîëîíîê';
const Err_MaterreportAlreadyExist = 'Òàêèé ìàòåğ³àëüíèé çâ³ò âæå º ó áàç³';

const Cap_left = 'Çàëèø.';
const Cap_all_q = 'Âñüîãî';
const Cap_isstore = 'Êîì';

const msgAddMaterReport = 'Äîäàâàííÿ ìàòåğ³àëüíîãî çâ³òó';


const monthes_ru : array [1..12]  of string = ('ßíâàğü','Ôåâğàëü','Ìàğò','Àïğåëü','Ìàé','Èşíü','Èşëü','Àâãóñò','Ñåíòÿáğü','Îêòÿáğü','Íîÿáğü','Äåêàáğü');
const monthes_ua : array [1..12]  of string = ('Ñ³÷åíü', 'Ëşòèé', 'Áåğåçåíü', 'Êâ³òåíü', 'Òğàâåíü', '×åğâåíü', 'Ëèïåíü', 'Ñåğïåíü', 'Âåğåñåíü', 'Æîâòåíü', 'Ëèñòîïàä', 'Ãğóäåíü' );

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
