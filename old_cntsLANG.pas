unit cntsLANG;

interface
uses frmLANG,SysUtils,DateUtils;

type
  
  //
  TWidthCheck=(twcNull,twcA4,twcA3);
  //
  {TUserRights=record
    Write,Sprav,Admin:boolean;
  end;}

  TRightsSet=set of (rsREAD,rsZAV,rsRASK,rsZADV,rsNARAD,rsPOTER,rsSPRAV,rsDELZAV,rsADMIN,rsWWATER);
  TRightsType=(rtREAD,rtZAV,rtRASK,rtZADV,rtNARAD,rtPOTER,rtSPRAV,rtDELZAV,rtADMIN,rtWWATER);
  TRightsInTable=array[TRightsType]of string;

  TRightsAliases=array[TRightsType]of string;

Const
  A4_WIDTH=80;
  LETTER_WIDTH=8;
  //
  RightsInTable:TRightsInTable=('READ','ZAV','RASK','ZADV','NARAD','POTER','SPRAV','DELZAV','ADMIN','WWATER');
  RightsAliases:TRightsAliases = ('Чтение','Корректировка основной формы',
    'Корректировка раскопок','Корректировка задвижек', 'Корректировка выездов',
    'Корректировка потерь', 'Изменения справочников','Удаление заявок','Администирирование',
    'Корректировка списка абонентов(без воды)');
  //  
  msgApply:TLangMSG = ('Принять','Прийняти');
  msgClose:TLangMSG = ('Закрыть','Закрити');
  msgSave:TLangMSG = ('Сохранить','Зберегти');
  msgRefresh:TLangMSG = ('Обновить','Обновити');
  msgDelete:TLangMSG = ('Удалить','Видалити');
  msgAdd:TLangMSG = ('Добавить','Додати');
  msgInsert:TLangMSG = ('Вставить','Вставити');
  msgExit:TLangMSG = ('Выход','Вихід');
  msgCancel:TLangMSG = ('Отмена','Скасувати');
  msgCancelRun:TLangMSG = ('Прервать','Перервати');
  msgPrint:TLangMSG = ('Печать','Друк');
  msgSearch:TLangMSG = ('Поиск','Пошук');
  msgClear:TLangMSG = ('Очистить','Очистити');
  msgSelect:TLangMSG = ('Выбрать','Вибрати');
  msgShow:TLangMSG = ('Показать','Показати');
  msgExec:TLangMSG = ('Выполнить','Виконати');
  msgCheck:TLangMSG = ('Проверить','Перевірити');
  msgLoad:TLangMSG = ('Загрузить','Завантажити');
  msgOut:TLangMSG = ('Вывод в Excel','Завантажити');
  msgAlien:TLangMSG = ('Чужая','Чужа');
  msgNewW:TLangMSG = ('Новая','Нова');
  msgNewM:TLangMSG = ('Новый','Новий');
  msgCondition:TLangMSG = ('Условие','Умова');
  msgConditions:TLangMSG = ('Условия','Умови');
  msgSearchBody:TLangMSG = ('Поиск по вхождению','Пошук за входженням');
  msgConfirm:TLangMSG = ('Подтверждение','Підтвердження');
  msgInform:TLangMSG = ('Информация','Інформація');
  msgError:TLangMSG = ('Ошибка','Помилка');

  msgITOGO:TLangMSG = ('ИТОГО','ІТОГО');
  msgFrom:TLangMSG = ('С','З');
  msgREVS:TLangMSG = ('Цехов','Цехів');
  msgNaimPredpr:TLangMSG = ('Наим.мат.','Наим.мат.');
  msgCompany:TLangMSG = ('Организация','Організація');
  msgForCompany:TLangMSG = ('организацию','організацію');
  msgCount:TLangMSG = ('кол-во','кількість');
  msgCountBig:TLangMSG = ('Количество','Кількість');
  msgCrash:TLangMSG = ('Повреждение','Пошкодження');
  msgCrashes:TLangMSG = ('Повреждения','Пошкодження');
  msgCountCrash:TLangMSG = ('Кол-во повреждений','Кількість пошкоджень');
  msgListCrash:TLangMSG = ('Список повреждений','Список пошкоджень');
  msgTypeCrash:TLangMSG = ('Тип повреждения','Тип пошкодження');
  msgStreet:TLangMSG = ('Улица','Вулиця');
  msgPlace:TLangMSG = ('Местность','Місцевість');
  msgSpotPlace:TLangMSG = ('Место','Місце');
  msgDmgPlace:TLangMSG = ('Место повреждения','Місце пошкодження');
  msgCrossRoad:TLangMSG = ('Перекресток','Перехрестя');
  msgAddr:TLangMSG = ('Адрес','Адреса');
  msgNumDom:TLangMSG = ('номер дома','номер будинка');
  msgNumDoms:TLangMSG = ('номера домов','номера будинків');
  msgDom:TLangMSG = ('дом','будинок');
  msgDomShort:TLangMSG = ('д.','б.');
  msgCross:TLangMSG = ('пересечение с','перетинання з');
  msgYear:TLangMSG = ('Год','Рік');
  msgOnYear:TLangMSG = ('года','року');
  msgRange:TLangMSG = ('Период','Період');
  msgAll:TLangMSG = ('Все','Усі');
  msgAllCount:TLangMSG = ('Всего','Усього');
  msgWithDigging:TLangMSG = ('с раскопкой','з розкопкою');
  msgWithoutDigging:TLangMSG = ('без раскопки','без розкопки');
  msgDiam:TLangMSG = ('Диаметр','Діаметр');
  msgDiamShort:TLangMSG = ('Диам.','Діам.');
  msgForDiam:TLangMSG = ('по диаметрам','по діаметрам');
  msgDiams:TLangMSG = ('Диаметров','Діаметрів');
  msgINCity:TLangMSG = ('по городу','по місту');
  msgZadvs:TLangMSG = ('Задвижки','Засувки');
  msgCloseZadv:TLangMSG = ('Перекрытые задвижки','Перекриті засувки');
  msgWhoClose:TLangMSG = ('Перекрыл','Перекрив');
  msgWhoOpen:TLangMSG = ('Открыл','Відкрив');
  msgDigWorks:TLangMSG = ('Раскопки','Розкопки');
  msgDigWorkOne:TLangMSG = ('Раскопка','Розкопка');
  msgPereCloseZadv:TLangMSG = ('Перекрыта','Перекрита');
  msgDiggRaskop:TLangMSG = ('Раскопано','Розкопано');
  msgNoDiggRaskop:TLangMSG = ('Обратная'+#13+'засыпка','Засипано');
  msgDoDiggRaskop:TLangMSG = ('Засыпать','Засипати');
  msgVidOpenZadv:TLangMSG = ('Открыта','Відкрита');
  msgVidCloseZadv:TLangMSG = ('Закрыта','Закрита');
  msgOpenWent:TLangMSG = ('Открыт','Відкрит');
  msgCloseWent:TLangMSG = ('Закрыт','Закрит');
  msgClosed:TLangMSG = ('Закрытые','Закриті');
  msgForClosed:TLangMSG = ('закрытым','закритим');
  msgForNotClosed:TLangMSG = ('незакрытым','незакритим');
  msgNotClosed:TLangMSG = ('Незакрытые','Незакриті');
  msgAddrCloseZadv:TLangMSG = ('Адрес перекрытой задвижки','Адреса перекритої засувки');
  msgAddrRaskop:TLangMSG = ('Адрес раскопки','Адреса розкопки');
  msgDopAddr:TLangMSG = ('Дополнительный адрес','Додаткова адреса');
  msgDopAddrShort:TLangMSG = ('Доп.адрес','Додат.адреса');
  msgDopInfo:TLangMSG = ('Дополнительная информация','Додаткова інформація');
  msgDopInfoShort:TLangMSG = ('Доп.информация','Додат.інформація');
  msgDoOpenZadv:TLangMSG = ('Открыть'#13#10'задвижку','Відкрити'#13#10'засувку');
  msgDoAddZadvFromZajav:TLangMSG = ('Добавить незакрытую задвижку из закрытой заявки','Додати незакриту засувку з закритої заявки');
  msgDoAddRaskopFromZajav:TLangMSG = ('Добавить незакопанную раскопку из закрытой заявки','Додати незакопану розкопку з закритої заявки');
  msgCloseZadvCount:TLangMSG = ('Перекрытых задвижек %d из них открытых %d','Перекритих засувок %d з них відкритих %d');
  msgCloseRaskopCount:TLangMSG = ('Раскопок %d из них незасыпанных %d','Розкопок %d из них незасипаних %d');
  msgWentCountClose:TLangMSG = ('Всего выездов %d из них закрытых %d','Усього виїздів %d з них закритих %d');

  msgUsers:TLangMSG = ('Пользователи','Користувачі');
  msgUserOne:TLangMSG = ('Пользователь','Користувач');
  msgNameUser:TLangMSG = ('Имя пользователя','Ім''я користувача');

  msgIdentUser:TLangMSG = ('Идентификатор пользователя (англ)','Ідентифікатор користувача (англ)');
  msgRunIdentUser:TLangMSG = ('Идентификация пользователя','Ідентифікація користувача');
  msgPasswdAdmin:TLangMSG = ('Пароль администратора','Пароль адміністратора');
  msgUserGrant:TLangMSG = (' Права пользователя ',' Привілеї користувача');
  msgRead:TLangMSG = ('Чтение','Читання');
  msgChangeDB:TLangMSG = ('Изменение рабочих баз','Зміна робочих баз');
  msgChangeSprav:TLangMSG = ('Изменение справочников','Зміна довідників');
  msgAdminJob:TLangMSG = ('Администрирование','Адміністрування');
  msgAdmin:TLangMSG = ('Администратор','Адміністратор');

  msgCapMainForm:TLangMSG = ('АРМ диспетчера АВР','АРМ діспетчера АВР');
  msgMashineVxod:TLangMSG = ('Рабочее место диспетчера АВР','Робоче місце діспетчера АВР');
  msgKiev:TLangMSG = ('Кременчугский Водоканал','Водоканал');
  msgVedom:TLangMSG = ('Ведомости','Відомості');
  msgVedomOne:TLangMSG = ('Ведомость','Відомость');
  msgNewZajav:TLangMSG = ('Новая заявка','Нова заявка');
  msgSelOfYearAndNum:TLangMSG = ('Выбор по номеру и году','Вибір по номеру і году');
  msgVedomost:TLangMSG = ('Ведомость учета','Відомість обліку');
  msgVedomostPovr:TLangMSG = ('Ведомость учета повреждений','Відомість обліку пошкоджень');
  msgVedNoCloseZajav:TLangMSG = ('Ведомость учета незакрытых заявок за период','Відомість обліку незакритих заявок');
  msgVedZajav:TLangMSG = ('Ведомость учета заявок','Відомість обліку заявок');
  msgVedLikvidirPovr:TLangMSG = ('Ведомость учета ликвидированных повреждений с раскопкой','Відомість обліку ліквідованих пошкоджень з разкопкою');
  msgVedLikvidirPovrForRange:TLangMSG = ('Ведомость ликвидации повреждений за период','Відомість ліквідації пошкоджень за період');
  msgVedPovrChess:TLangMSG = ('Ведомость учета повреждений ("шахматка")','Відомість обліку пошкоджень ("шахматка")');
  msgVedUsedMat:TLangMSG = ('Ведомость учета израсходованных материалов','Відомість обліку витрачених матеріалів');
  msgVedUsedMatDiam:TLangMSG = ('Ведомость учета израсход. материалов по диаметрам','Відомість обліку витрач. матеріалів по діаметрам');
  msgVedUsedMatDiametram:TLangMSG = ('Ведомость учета израсходованных материалов по диаметрам','Відомість обліку витраченних матеріалів по діаметрам');
  msgVedClosedZadv:TLangMSG = ('Сводка перекрытых задвижек','Зведення перекритих засувок');
  msgVedRaskop:TLangMSG = ('Сводка раскопок','Зведення розкопок');
  msgVedUtech:TLangMSG = ('Ведомость утечек','Зведення утечек');
  msgVedUtech_Vodopr:TLangMSG = ('Ведомость утечек. Водопроводные и водопроводные на списание','Зведення утечек');
  msgVedUtech_Other:TLangMSG = ('Ведомость утечек. Другие','Зведення утечек');
  msgVedUtech_Vodomer:TLangMSG = ('Ведомость утечек. Водомерные и водомерные на списание','Зведення утечек');
  msgVedUstran:TLangMSG = ('Ведомость устраненных заявок','Зведення устраненных заявок');
  msgVedUstran_vod:TLangMSG = ('Ведомость устраненных заявок(отдел водопровода)','Зведення устраненных заявок(відділ водопроводу)');
  msgVedAbon:TLangMSG = ('Ведомость в абонентный отдел','Зведення в абонентный отдел');
  msgVedKolvo:TLangMSG = ('Количество (по участкам) устраненных утечек за период','Количество (по участкам) устраненных утечек за период');
  msgDelZayav:TLangMSG = ('Ведомость удаленных заявок','Ведомость удаленных заявок');
  msgViborPoUl:TLangMSG = ('Выбор всех заявок по улице','Выбор всех заявок по улице');
  msgVedPostupAbon:TLangMSG = ('Ведомость поступивших заявок (абонентный отдел)','Ведомость поступивших заявок (абонентный отдел)');
  msgVedVipoln:TLangMSG = ('Ведомость выполнения восстановительных работ (по раскопкам)','Зведення выполнения восстановительных работ (по раскопкам)');
  msgSvodkaLikvPovr:TLangMSG = ('Сводка ликвидированных повреждений','Зведення ліквідованих пошкоджень');
  msgSetupVedPovr:TLangMSG = ('Настройка ведомости учета повреждений','Настроювання відомісті обліку пошкоджень');
  msgProizSearch:TLangMSG = ('Произвольный поиск','Довільний пошук');
  msgUniverSpravka:TLangMSG = ('Универсальная справка','Універсальна довідка');
  msgSravnitSpravka:TLangMSG = ('Сравнительная справка','Порівняльна довідка');
  msgNewUser:TLangMSG = ('Новый пользователь','Новий користувач');
  msgVersion:TLangMSG = ('Версия','Версія');
  msgAnaliz:TLangMSG = ('Анализ','Аналіз');
  msgVedAnalizPovr:TLangMSG = ('Ведомость анализа повреждений','Відомість аналізу пошкоджень');
  msgAnalizPovr:TLangMSG = ('Анализ повреждений','Аналіз пошкоджень');
  msgAnalizPovrUlic:TLangMSG = ('Анализ повреждений по улице','Аналіз пошкоджень по вулиці');
  msgSpravoch:TLangMSG = ('Справочники','Довідники');
  msgSpravochOne:TLangMSG = ('Справочник','Довідник');
  msgDolzLic:TLangMSG = ('Должностных лиц','Посадових особ');
  msgResponse:TLangMSG = ('Должность','Посада');
  msgRAYONS:TLangMSG = ('Административных районов','Адміністративних районів');
  msgREMONT:TLangMSG = ('Выполнение ремонта','Виконання ремонту');
  msgREGIONone:TLangMSG = ('Регион','Регион');
  msgRAYONone:TLangMSG = ('Административный район','Адміністративний район');
  msgRAYON:TLangMSG = ('Район','Район');
  msgREV:TLangMSG =  ('Цех','Цех');
  msgNameStreets:TLangMSG = ('Наименований улиц','Назв вулиць');
  msgTypeStreets:TLangMSG = ('Видов улиц','Видів вулиць');
  msgWorks:TLangMSG = ('Работ','Робіт');
  msgWorkOne:TLangMSG = ('Работа','Робота');
  msgWorkMany:TLangMSG = ('Работы','Роботи');
  msgMaters:TLangMSG = ('Материалов','Матеріалів');
  msgMaterOne:TLangMSG = ('Материал','Матеріал');
  msgMaterMany:TLangMSG = ('Материалы','Матеріали');
  msgMechan:TLangMSG = ('Механизмы','Механізми');
  msgPlanmechan: TLangMSG = ('Планируемые механизмы','Механізми, що плануються');
  msgDoWorks:TLangMSG = ('Выполняющих работу','Виконуючих роботи');
  msgDoWorkOne:TLangMSG = ('Выполняющий работу','Виконуючий роботу');
  msgMestnostPovr:TLangMSG = ('Местности повреждений','Місцевостей пошкоджень');
  msgMestPovr:TLangMSG = ('Мест повреждений','Місць пошкоджень');
  msgZajavitels:TLangMSG = ('Заявителей','Заявників');
  msgDopAdresov:TLangMSG = ('Дополнительных адресов', 'Додаткових адрес');
  msgDopAdres:TLangMSG = ('Дополнительный адрес', 'Додаткова адреса');
  msgZajavitelOne:TLangMSG = ('Заявитель','Заявник');
  msgSoderzZajav:TLangMSG = ('Характер повреждений','Зміста заявок');
  msgMechaniz:TLangMSG = ('Механизмов','Механізмів');
  msgPlanMechaniz:TLangMSG = ('Обобщенных механизмов','Обобщенных механізмів');
  msgPovrezd:TLangMSG = ('Типов повреждений','Пошкоджень');
  msgTypeZajav:TLangMSG = ('Типов заявок','Типів заявок');
  msgTypesColSHACH:TLangMSG = ('Типов колонок шахматки','Типів стовпчиків "шахматки"');
  msgService:TLangMSG = ('Сервис','Сервіс');
  msgContext:TLangMSG = ('Содержание','Зміст');
  msgHistoryChanges:TLangMSG = ('История изменений','Історія змін');
  msgNastrojka:TLangMSG = ('Настройки','Настроювання');
  msgAddMap:TLangMSG = ('Подключить карту','Підключити карту');
  msgDelMap:TLangMSG = ('Отключить карту','Відключити карту');
  msgClock:TLangMSG = ('Часы','Годинник');
  msgAutoVVod:TLangMSG = ('Автоввод','Автовведення');
  msgOpenOtherName:TLangMSG = ('Войти под другим именем','Ввійти під іншим ім''ям');
  msgExitProg:TLangMSG = ('Выход из программы','Вихід з програми');
  msgErrorServer:TLangMSG = ('Ошибка подключения к серверу !','Помилка підключення к серверу !');
  msgErrorCountry:TLangMSG = ('Неправильно установлена страна: ','Помилково встановлена країна: ');
  msgSelPredvZajav:TLangMSG = ('Выбор предварительной заявки','Вибір предварительной заявки');
  msgDelZajav:TLangMSG = ('Выбор заявки на удаление','Вибір заявки на удаление');
  msgSelNoCloseZajav:TLangMSG = ('Выбор незакрытой заявки','Вибір незакритої заявки');
  msgSelCloseZajav:TLangMSG = ('Выбор закрытой заявки','Вибір закритої заявки');
  msgSelCloseZadv:TLangMSG = ('Выбор закрытой задвижки','Вибір закритої засувки');
  msgDigger:TLangMSG = ('ЗАСЫПАНО','ЗАСИПАНО');
  msgDataEndLTBegin:TLangMSG = ('Дата окончания меньше даты начала!','Дата закінчення менше дати початка!');
  msgDataBeginWentLTOpen:TLangMSG = ('Дата начала выезда раньше даты открытия заявки !','Дата початку виїзда раніше дати відкриття заявки');
  msgDataTimeGRTemp:TLangMSG = ('Дата/время больше текущей!','Дата/час більше поточної!');
  msgDataTimeLTin:TLangMSG = ('Дата/время меньше даты открытия!','Дата/час меньше дати відкриття!');
  msgNoDateTime:TLangMSG = ('Не определены дата и (или) время !','Невизначена дата і (або) час');
  msgDateRegister:TLangMSG = ('Дата регистрации','Дата реєстрації');
  msgDateArrive:TLangMSG = ('Дата поступления','Дата надходження');
  msgDateClose:TLangMSG = ('Дата закрытия','Дата закриття');
  msgDateOpen:TLangMSG = ('Дата открытия','Дата відкриття');
  msgDateOpenShort:TLangMSG = ('Дата отк.','Дата відк.');
  msgDateRaskopShort:TLangMSG = ('Дата рас.','Дата роз.');
  msgPasswdAdminNoDefine:TLangMSG = ('Пароль администратора не определен !','Пароль адміністратора не визначен !');
  msgPasswdNoDefineOrConfirm:TLangMSG = ('Пароль не определен или не подтвержден !','Пароль не визначен або не підтверджен');
  msgHideShow:TLangMSG = ('Видимость/Невидимость','Видимість/Невидимість');
  msgAutoRefresh:TLangMSG = ('Автоматическое обновление справочника'#13#10'(после внесения изменений)','Автоматичне відновлення довідника'#13#10'(після внесення змін)');
  msgDBNavigatorHints:TLangMSG = ('"Первая запись","Предыдущая запись","Следующая запись","Последняя запись","Вставить запись","Удалить запись","Редактировать запись","Сохранить (F2)","Отмена","Обновить"',
                                  '"Перший запис","Попередній запис","Наступний запис","Останній запис","Вставити запис","Видалити запис","Редагувати запис","Зберегти (F2)","Скасування","Відновити"');
  msgSearchOfField:TLangMSG = ('Поиск по полю ','Пошук по полю');
  msgDeleteRecord:TLangMSG = ('Удалить запись?','Видалити запис?');
  msgSaveChanges:TLangMSG = ('Сохранить внесенные изменения?','Зберегти внесенні зміни?');
  msgDeleteMore:TLangMSG = ('Вы хотите удалить сразу несколько записей','Ви бажаете видалити відразу декілька записів');
  msgExistError:TLangMSG = (' уже существует. Необходимо ввести другое значение или нажать кнопку "Отмена".',' вже існує. Необхідно ввести інше значення або натиснути кнопку "Скасувати"');
  msgExitWithSaveREC:TLangMSG = ('Выйти без сохранения новой записи?','Вийти без збереження нового запису?');
  msgExitWithSave:TLangMSG = ('Выйти без сохранения изменений?','Вийти без збереження змін?');
  msgChangeNoSave:TLangMSG = ('Изменения НЕ сохранены!','Зміни НЕ збережені!');
  msgNoChange:TLangMSG = ('Нет изменений','Нема змін');
  msgFilter:TLangMSG = ('Фильтр','Фільтр');
  msgSizeFont:TLangMSG = ('Размер шрифта','Розмір шрифта');
  msgLoadResult:TLangMSG = ('Загрузка результата ...','Завантажування результату ...');
  msgColumns:TLangMSG = ('Колонки','Стовпчик');
  msgUseFilterDate:TLangMSG = ('Применить фильтр по дате','Застосувати фільтр по даті');
  msgOldValue:TLangMSG = ('Старое значение','Старе значення');
  msgNewValue:TLangMSG = ('Новое значение','Нове значення');
  msgCoder:TLangMSG = ('Кодировка','Кодування');
  msgPrintText:TLangMSG = ('Печать текстовая','Друк текстовий');
  msgCountSymPage:TLangMSG = ('К-во символов на листе','Кіл. символів на аркуші');
  msgCountLinePage:TLangMSG = ('К-во строк на листе','Кіл. рядків на аркуші');
  msgON:TLangMSG = ('включить','увімкнути');
  msgOFF:TLangMSG = ('выключить','відключити');
  msgCondensedFont:TLangMSG = ('Сжатый шрифт','Стислий шрифт');
  msgPage:TLangMSG = ('Лист','Аркуш');
  msgOnPage:TLangMSG = ('По листам','По аркушам');
  msgPart:TLangMSG = ('часть','частина');
  msgSortField:TLangMSG = ('Сортировка по полю','Сортування по полю');
  msgFound:TLangMSG = ('Найдено %d записей. Показать?','Знайдено %d записів. Показати?');
  msgNotFound:TLangMSG = ('Записей,удовлетворяющих условию НЕ НАЙДЕНО !','Записів, задовольняючих умові НЕ ЗНАЙДЕНО !');
  msgCreate:TLangMSG = ('Создано','Створено');
  msgWent:TLangMSG = ('Выезды','Виїзди');
  msgWentOne:TLangMSG = ('Выезд','Виїзд');
  msgWentNotClose:TLangMSG = ('Выезд Не закрыт !','Виїзд Не закритий');
  msgJobsAndMat:TLangMSG = ('Работы/материалы','Роботи/Матеріали');
  msgConfirmDelWent:TLangMSG = ('  Вместе с выездом будут удалены материалы, оборудование, работы и раскопки, соответствующие данному выезду.'#13'  Удалить выезд?',
                                '  Разом з виїздом будуть видалені матеріали, устаткування і роботи, відповідні до даного виїзду.'#13'  Видалити виїзд?');
  msgCommon:TLangMSG = ('Общие','Спільні');
  msgSaveMainForm:TLangMSG = ('Сохранять расположение главной формы','Зберігати розташування головної форми');
  msgLang:TLangMSG = ('Язык','Мова');
  msgLangUA:TLangMSG = ('Украинский','Українська');
  msgLangRU:TLangMSG = ('Русский','Російська');
  msgColor:TLangMSG = ('Цвета','Кольори');
  msgThis:TLangMSG = ('Это','Це');
  msgThisMsg:TLangMSG = ('Сообщение','Повідомлення');
  msgThisBoldMsg:TLangMSG = ('Выделенное сообщение','Виділене повідомлення');
  msgThisMsgError:TLangMSG = ('Сообщение об ошибке','Повідомлення про помилку');
  msgDefault:TLangMSG = ('По умолчанию','По умовчанню');
  msgFieldEdit:TLangMSG = ('Поля ввода','Поля введення');
  msgChoose:TLangMSG = ('Выбор','Вибір');
  msgQuickAdd:TLangMSG = ('Быстрое добавление','Швидке додавання');
  msgEquip:TLangMSG = ('Оборудование','Устаткування');
  msgEquipJobMat:TLangMSG = ('Оборудование, работы, материалы','Устаткування, роботи, матеріали');
  msgDemandDiam:TLangMSG = ('требует ввода диаметра.','потребує введення діаметра.');
  msgSomeSel:TLangMSG = ('Произвольный выбор','Довільний вибір');
  msgShowResult:TLangMSG = ('Просмотр результата','Перегляд результата');
  msgLines:TLangMSG = ('Строк','Рядків');
  msgCols:TLangMSG = ('столбцов','стовпців');
  msgNotShowNullRow:TLangMSG = ('Не показывать нулевые строки','Не показувати нульові рядки');
  msgPercentForAmount:TLangMSG = ('% от общ.кол.','% від заг.кількості');
  msgErrorExecQuery:TLangMSG = ('Ошибка выполнения запроса.','Помилка виконання запита.');
  msgDataForRangeNotExist:TLangMSG = ('За указанный период данные отсутствуют.','За зазначенний період дані відсутні.');
  msgNotConsistOfDiam:TLangMSG = ('не содержит диаметра','не містить діаметра');
  msgChooseAll:TLangMSG = ('Выделить все','Виділити усе');
  msgClearAll:TLangMSG = ('Очистить все','Очистити усе');
  msgAllMaters:TLangMSG = ('Все материалы','Усі матеріали');
  msgExReport:TLangMSG = ('Расширенный отчет','Розширений звіт');
  msgUsePipeFor:TLangMSG = ('Израсходовано труб за ','Витрачено труб за ');
  msgShortening:TLangMSG = ('Сокращение','Скорочення');
  msgGroupBy:TLangMSG = ('Группировка','Групування');
  msgTitle:TLangMSG = ('Название','Назва');
  msgDesign:TLangMSG = ('Наименование','Найменування');
  msgFIO:TLangMSG = ('ФИО','Прізвище');
  msgSurname:TLangMSG = ('Фамилия','Прізвище');
  msgAccup:TLangMSG = ('Должность','Посада');
  msgODDSIZE:TLangMSG = ('Ед. изм.','Од. вим.'); {Одиниця виміру}
  msgCategory:TLangMSG = ('Категория','Категорія');
  msgFilterCategory:TLangMSG = ('Фильтр по категориям (Del или BackSpace - очистка фильра)',
                                'Фільтр по категоріям (Del або BackSpace - очистка фільтра)');
  msgNotice:TLangMSG = ('Примечание','Примітка');
  msgTime:TLangMSG = ('Время','Час');
  msgDTClosed:TLangMSG = ('закрытия','закриття');
  msgDTRegister:TLangMSG = ('регистрации','реєстрації');
  msgInfoAboutCrash:TLangMSG = ('Информация о повреждении','Інформація о пошкодженні');
  msgQuery:TLangMSG = ('запрос','запит');
  msgDebug:TLangMSG = ('Отладка','Налагодження');
  msgForms:TLangMSG = ('Формы','Форми');
  msgQueryExec:TLangMSG = (' SQL запрос выполнен',' SQL запит виконано');
  msgChoseRep:TLangMSG = (' Выбор отчета ',' Вибір звіту ');
  msgOnlyNotOpened:TLangMSG = ('только неоткрытые','тільки невідкриті');
  msgOnlyNotDig:TLangMSG = ('только незакопанные','тільки нерозкопані');
  msgOutput:TLangMSG = ('Вывод в','Вивід до ');
  msgForRangeFrom:TLangMSG = ('за период с','за період з');
  msgAndSpill:TLangMSG = ('в т.ч. засорения','у т.ч. засорки');
  msgAndLeak:TLangMSG = ('в т.ч.ликв.течи','у т.ч. течія');
  msgAndMend:TLangMSG = ('в т.ч. поломки','у т.ч. поломки');
  msgAndRepair:TLangMSG = ('в т.ч.ликв.ремонты','у т.ч. ремонти');
  msgAndOther:TLangMSG = ('в т.ч.ликв.прочие','у т.ч. інші');
  msgAndNoSpill:TLangMSG = ('неликвидирован. засорения','неліквідовані т.ч. засорки');
  msgAndNoLeak:TLangMSG = ('неликв.течи','нелікв. т.ч. течи');
  msgAndNoMend:TLangMSG = ('неликвидирован. поломки','неліквідовані поломки');
  msgAndNoRepair:TLangMSG = ('неликв.ремонты','нелікв. ремонти');
  msgAndNoOther:TLangMSG = ('неликв.прочие','неліквідовані інші');
  msgTempClosed:TLangMSG = ('перекрытых на текущий момент','перекритих на наступний момент');
  msgTempNotDig:TLangMSG = ('незакопанных на текущий момент','незакопаних на наступний момент');
  msgShowOnMap:TLangMSG = ('Показать заявку на карте','Показати заявку на карті');
  msgTieOnMap:TLangMSG = ('Привязать заявку к карте','Прив''язати заявку до карти');
  msgWrongPasswd:TLangMSG = ('Неправильное имя пользователя или пароль !','Неправильне ім''я користувача обо пароль !');
  msgClientServer:TLangMSG = ('Клиент/Сервер','Клієнт/Сервер');
  msgLoadProgram:TLangMSG = ('Загрузка программы','Завантаження програми');
  msgSaveChangedInfo:TLangMSG = ('Сохранить измененную информацию','Зберегти змінену інформацію');
  msgCloseWindow:TLangMSG = ('Закрыть окно','Закрити вікно');
  msgCopyZajav:TLangMSG = ('Копировать текущую заявку в новую','Копіювати поточну заявку до нової');
  msgNoNomDom:TLangMSG = ('Не заполнен НОМЕР ДОМА !','Не заповнен НОМЕР БУДИНКУ !');
  msgSaveNewZajav:TLangMSG = ('Сохранить новую заявку ?','Зберегти нову заявку ?');
  msgSameZajav:TLangMSG = (' незакрытых заявок имеют похожий адрес. Показать?',
                           ' незакритих заявок мають схожу адресу. Показати?');
  msgSameZajavList:TLangMSG = ('Незакрытые заявки с адресом близким к ','Незакриті заявки з адресою близькою до');
  msgZajavSetNom:TLangMSG = ('Заявке присвоен номер ','Заявке присвоено номер ');
  msgZajavIDNotFound:TLangMSG = ('Заявка с ID=%d НЕ НАЙДЕНА!','Заявка з ID=%d НЕ ЗНАЙДЕНА!');
  msgZajavWithOpenZadv:TLangMSG = ('У заявки присутствуют перекрытые задвижки! Закрыть заявку?',
                                   'У заявки присутні перекриті засувки! Закрити заявку?');
  msgZajavWithOpenRaskop:TLangMSG = ('У заявки присутствуют незасыпанные раскопки! Закрыть заявку?',
                                     'У заявки присутні незасипані розкопки! Закрити заявку?');
  msgZajavWithoutDiam:TLangMSG = ('Не определен ДИАМЕТР! Закрыть заявку?',
                                  'Не визначен ДІАМЕТР! Закрити заявку?');
  msgCloseZajav:TLangMSG = ('Закрыть заявку ?','Закрити заявку ?');
  msgZajavWithoutCloseWent:TLangMSG = ('У заявки нет закрытых выездов! ','У заявки нема закритих виїздів! ');
  msgZajavWithoutWent:TLangMSG = ('У заявки нет выездов !','У заявки нема виїздів !');
  msgZajavWentDel:TLangMSG = ('У заявки уже есть выезды! Удалите их. ','У заявки вже иснують виїзди! Видалити їх. ');
  msgClosing:TLangMSG = ('ЗАКРЫТИЕ','ЗАКРИТТЯ');
  msgSending:TLangMSG = ('ПОСТУПЛЕНИЕ','НАДХОДЖЕННЯ');
  msgBegin:TLangMSG = ('Начало','Початок');
  msgEnd:TLangMSG = ('Конец','Кінець');
  msgTellWent:TLangMSG = ('ОПИСАНИЕ ВЫЕЗДА','ОПИС ВИЇЗДА');
  msgWhoDoJob:TLangMSG = ('ВЫПОЛНЯЛ РАБОТУ','ВИПОВНЮВАВ РОБОТУ');
  msgNewYear:TLangMSG = (' Поменялся год !'#13#10'Сохранить заявку с номером 1 за %d год ?'#13#10'Ввод заявок с %d годом будет уже невозможен !',
                         ' Змінився рік !'#13#10'Зберегти заявку з номером 1 за %d рік ?'#13#10'Введення заявок з %d роком буде вже неможливо !');
  msgConfirmNewYear:TLangMSG = (' Вы уверены ?'#13#10'Ввод заявок с %d годом будет уже невозможен !',
                                ' Ви впевнені ?'#13#10'Введення заявок з %d роком буде вже неможливо !');
  msgPrintAllWorks:TLangMSG = ('печатать все работы заявки','друкувати усі роботи заявки');
  msgNotPrintKoll:TLangMSG = ('Не учитывать повреждения на коллекторах (Все повреждения)','Не враховувати пошкодження на колекторах');
  msgPrintKoll:TLangMSG = ('Только повреждения на коллекторах','Тільки пошкодження на колекторах');
  msgPrintNotKoll:TLangMSG = ('Все, кроме повреждений на коллекторах','Усі, крім пошкоджень на колекторах');
  msgDictAll:TLangMSG = ('Полная видимость','Повна видимість');
  msgDictShow:TLangMSG = ('Только видимые','Тільки видні');
  msgDictHide:TLangMSG = ('Только невидимые','Тільки невидні');
  msgTypeLeak:TLangMSG = ('Видов течи','Видів течі');
  msgTypeClog:TLangMSG = ('Видов засора','Видів засмічення');
  msgTypeFill:TLangMSG = ('Видов засыпки','Видів засипання');
  msgTypeNet:TLangMSG = ('Видов сети','Видів мережі');
  msgTypeKillClog:TLangMSG = ('Видов ликвидации засора','Видів ліквідації засмічення');
  msgTypeLocal:TLangMSG = ('Мер локализации аварий','Заходів локалізації аварій');
  msgTypePump:TLangMSG = ('Методов откачки','Заходів відкачки');
  msgTypePES:TLangMSG = ('Использования САК','Використання САК');
  msgTypeOwner:TLangMSG = ('Принадлежности заявки','Принадлежністі заявки');

  msgTypeNetOne:TLangMSG = ('Сеть','Мережа');
  msgTypeLeakOne:TLangMSG = ('Выливания','Виливання');
  msgTypeClogOne:TLangMSG = ('Вид засора','Вид засмічення');
  msgTypeFillOne:TLangMSG = ('Вид засыпки'#10#13'колодца','Вид засипання'#10#13'колодязя');
//  msgMineZav:TLangMSG = ('Своя','Своя');
//  msgTheirZav:TLangMSG = ('Чужая','Чужа');
//  msgTheirMineZav:TLangMSG = ('Чужая, работы свои','Чужа, роботи свої');
//  msgFalseZav:TLangMSG = ('Ложная','Помилкова');
  msgNUMBERT:TLangMSG = ('Номер'#13'бригады','Номер'#13'бригади');
  msgNUMTEAM:TLangMSG = ('Кол-во'#13'человек','Кіл-ть'#13'людей');
  msgTypeLocalMany:TLangMSG = ('Меры локализации'#13'аварии','Заходи локалізації'#13'аварії');
  msgKillClog:TLangMSG = ('Ликвидация засора','Ліквідація засмічення');
  msgPump:TLangMSG = ('Метод откачки','Захід відкачки');
  msgPES:TLangMSG = ('САК','САК');
  msgTypePESOne:TLangMSG = ('Использование САК','Використання САК');
  msgPlaceSHIT:TLangMSG = ('Место удаления отходов','Місце ліквідації відходів');
  msgPlaceSAN:TLangMSG = ('Санитарные мероприятия','Санітарні заходи');
  msgPRN:TLangMSG = ('Принтер(возможно сетевое имя)','Прінтер(можливе ім''я в локальної мережі)');
  msgConfirmQuestion:TLangMSG = ('Вы уверены ?','Ви впевнені ?');
  msgPrintMoreLater:TLangMSG=('Принтер занят. Попробуйте печать попозже','Прінтер зайнятий. Спробуйте друк пізніше ');
  msgBury:TLangMSG=('незакопанные','незакопані');
  msgAsphalt:TLangMSG=('незаасфальтрованные','незаасфльтовані');

var RightsSet:TRightsSet;
    MyNowFlag:boolean;
    LastMyNow:TDateTime;

function MyNow:TDateTime;
function MyTime:TDateTime;
function MyDate:TDateTime;
procedure SetMyLastDate(value:TDateTime);
procedure SetMyLastTime(value:TDateTime);
procedure Patch;

implementation

uses AvrPatchUnit;

procedure SetMyLastDate(value:TDateTime);
begin
  LastMyNow:=DateOf(value)+TimeOf(LastMyNow);
end;

procedure SetMyLastTime(value:TDateTime);
begin
  LastMyNow:=DateOf(LastMyNow)+TimeOf(value);
end;

function MyDate:TDateTime;
begin
  if MyNowFlag then result:=dateOf(LastMyNow)
    else result:=date;
end;

function MyTime:TDateTime;
begin
  if MyNowFlag then result:=timeOf(LastMyNow)
    else result:=time;
end;

function MyNow:TDateTime;
begin
  if MyNowFlag then result:=LastMyNow
    else result:=now;
end;

procedure Patch;
var
  patch: TAvrPatch;
begin
  if not ((ParamCount=2) and (AnsiUpperCase(trim(ParamStr(1)))='-SCRIPT')) then exit;

  patch:=TAvrPatch.Create('AVARKREMEN', ParamStr(2));
  try
    patch.Execute;
  finally
    patch.Free;
  end;
end;

end.
