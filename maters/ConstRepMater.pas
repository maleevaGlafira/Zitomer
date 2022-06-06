
unit ConstRepMater;

interface

const Error_FileNotFound='Файл не знайдено!!';
const Err_InputStartDate  = 'Треба ввести дату початку пошуку!';
const Err_InputEndtDate  = 'Треба ввести дату кінця пошуку!';
const Err_StartMoreEndDate = 'Дата початку більше за дату кінця !';

const mes_OpenReport='Завантажте або відкрийте матеріальний звіт';
const mes_SelBrig = 'Оберіть бригадира';
const mes_SelReport = 'Оберіть матеріальний звіт';
const mes_SaveCloseReport = 'Збережіть або закрийте матріальний звіт';
const mes_SelBrigDep = 'Оберіть бригадира виїздів';

const mes_depfound = 'Пошук виконано';

const maked_deps = 'Виїзди ви-ні %s з %s по %s';
const mes_ChangedMakes = 'Зміни збережено!!';
const mesAddMater = 'Додавання  матеріала';

const quesIsDeleteMaterFromDep = 'Видалити матеріал "%s" з виїзду?';
const questIsDelMaterRepoordAllData = 'Звіт  вже  є у базі. Видалити усі дані звіту та зберегти новий?';
const mesCancelUser = 'Відмінено користувачем';
const mesReposrtIsSave = 'Звіт збережено';
const mesToGoToMater = 'Для пошуку  матеріала у звіті натисніть двічі';

const mesIsShureCorrectMaters = 'Ви впевнені у зміні найменування оба ціни по коду ';
const mesISSetValuesFromBase = 'Встановити значення з бази?';

const main_Caption = 'Розподіл матреріалів зі звіту';
const ReportWord = 'Звіт';

const OrderWord = 'Наряд';
const DepWord = '№ В-ду';
const DataWord = 'Дата';
const AdresWord = 'Адреса';
const NameMsterLong = 'НАЙМЕНУВАННЯ ЦІННОСТЕЙ';
const LastWork = 'ЗАЛИШОК';
const InputWOrd='ПРИХІД';

const FromStorage ='З КОМОРИ';
const IDROS ='ід роз';
const OtherWOrd = 'на інше';
const KIL = 'Кіл';
const SUMM='Сума';
const GetToUse = 'ВИДАТОК';
const LEFTWORD = 'Залишок';
const allWORD = 'ВСЬОГО';






 const cap_brig = 'Бригад';
 const cap_depscaption='Виїзди';
 const cap_OpenFile='Завантажити';
 const cap_Savereport='Зберегти відкритий звіт';
 const cap_openFromBase='Відкрити звіт';
 const cap_close_report='Закрити звіт';
 const cap_close_deps = 'Закрити виїзди';
const cap_depaddinfo='Додаткова інформація виїзду';
 const cap_used_maters='Використані матеріали';
 const cap_addmater='Додати';
 const  cap_change='Змінити';
const cap_delete='Видалити';
 const cap_close='Вихід';
 const cap_material='Матеріал';
 const cap_left='Залиш.';
 const cap_used='Використовується';
 const cacp_SearchDep = 'Пошук виїздів';
 const  cap_MaterReportCap = 'Матеріальний звіт';
const   cap_searchdeps = '';
 cap_dep = 'Виїзд';
 const capCancel = 'Відміна';
 const capAddmater = 'Додати матеріал';
 const cap_MakeRport = 'Сформувати звіт';
 const capColumn = 'Стовбець';

 const Err_nothingSave='Нічого зберігати';
const Err_connected='Нет соединения с базой';
const Err_Saving ='Помилка збереження до бази';
const Err_openDsets = 'Помилка отримання данних';
const Err_SaveRowToBase = 'Помилка збереження до бази строку ';
const Err_SavereportTitle = 'Не вдалося зберегти заголовок звіту!!';
const Err_Delete_Report = 'Помилка видалення звіту';
const Err_NoReport = 'Помилка відкриття звіту. Звіт не знайдено!';
const Err_OpenReport = 'Помилка відкриття звіту. ';
Const M_OpenSuccess = 'Звіт завантажено';
const M_SetBrig = 'Вкажіть майстра';
const mes_SelOutreport ='Вкажіть звіт';
const Err_OpenDeps = 'Помилка пошуку виїздів';
const err_savemater = 'Помилка збереження матеріалів';
const err_searchMatDep = 'Матеріал або виїзд не знайдено!!';
const err_notallowedAddMoreVal='Неможна додати більш ніж залишилось!!';

const errShortName = 'Не вистачає символів у полі найменування';
const  errEmptyUnits = 'Порожнє значення у полі од. вим.';
const errPrice = 'Помилка у полі ціна';
const errQuon ='Помилка у полі кількість';

const errReportNotopen = 'Неможливо додати матеріл у закритий невідомий звіт!!';
const errMaterKodAllreadyInReport='Матеріал з таким кодом вже ї у звіті';
const errMaterNameAllreadyInReport='Матеріал з таки ім'' ям вже у звіті';
{Do materreport}
const errNotInputMaterreport = 'Не знайдено звіт залишків ';
const err_FoundData = 'Помилка пощуку данних';
const errgetReportMaterData = 'Помилка формування назв матеріалів';
const errsgetReportMaterExel = 'Помилка формування звіту матеріалів';
const mes_RepMaked = 'Звіт сформлвано';


const report_mater_title='Матеріальний звіт';
const  report_mater_title_l1='МАТЕРІАЛЬНИЙ ЗВІТ ВИРОБНИЧОЇ ДІЯЛЬНОСТІ ВОДОПРОВОДУ ';
const  report_mater_title_l2='КП "ЖИТОМЕР ВОДОКАНАЛ"';

const  report_mater_title_l3='За_______%s_________%dр.';
const  report_mater_title_left='';



implementation

end.
