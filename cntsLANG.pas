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
    'Корректировка раскопок','Корректировка задвижек', 'Корректировка Этапов',
    'Корректировка потерь', 'Изменения справочников','Удаление нарядов','Администирирование',
    'Корректировка списка абонентов(без воды)');
  //
  msgYes:TLangMSG = ('Да','Так');
  msgNo:TLangMSG = ('Нет','Ні');
  msgApply:TLangMSG = ('Принять','Прийняти');
  msgClose:TLangMSG = ('Закрыть','Закрити');
  msgSave:TLangMSG = ('Сохранить','Зберегти');
  msgRefresh:TLangMSG = ('Обновить','Обновити');
  msgDelete:TLangMSG = ('Удалить','Видалити');
  msgAdd:TLangMSG = ('Добавить','Додати');
  msgInsert:TLangMSG = ('Вставить','Вставити');
  msgEdit:TLangMSG = ('Редактировать','Редагувати');
  msgExit:TLangMSG = ('Выход','Вихід');
  msgCancel:TLangMSG = ('Отмена','Скасувати');
  msgCopy:TLangMSG = ('Копировать','Копіювати');
  msgCancelRun:TLangMSG = ('Прервать','Перервати');
  msgPrint:TLangMSG = ('Печать','Друк');
  msgSearch:TLangMSG = ('Поиск','Пошук');
  msgClear:TLangMSG = ('Очистить','Очистити');
  msgSelect:TLangMSG = ('Выбрать','Вибрати');
  msgShow:TLangMSG = ('Показать','Показати');
  msgExec:TLangMSG = ('Выполнить','Виконати');
  msgCheck:TLangMSG = ('Проверить','Перевірити');
  msgLoad:TLangMSG = ('Загрузить','Завантажити');
  msgDoSelect:TLangMSG = ('Выберите','Оберіть');
  msgOut:TLangMSG = ('Вывод в Excel','Завантажити');
  msgParams:TLangMSG = ('Параметры','Параметри');
  msgAlien:TLangMSG = ('Чужая','Чужа');
  msgForm:TLangMSG = ('Форма','Форма');
  msgNewW:TLangMSG = ('Новая','Нова');
  msgNewM:TLangMSG = ('Новый','Новий');
  msgCondition:TLangMSG = ('Условие','Умова');
  msgConditions:TLangMSG = ('Условия','Умови');
  msgSearchBody:TLangMSG = ('Поиск по вхождению','Пошук за входженням');
  msgConfirm:TLangMSG = ('Подтверждение','Підтвердження');
  msgInform:TLangMSG = ('Информация','Інформація');
  msgError:TLangMSG = ('Ошибка','Помилка');
  msgVodoprovod:TLangMSG = ('водопровод','водопровід');
  msgKANANAL:TLangMSG = ('канализация','водовідведення');
  msgObjVdod:TLangMSG = ('объекты водопровода','об''єкти водопроводу');
  msgObjKanal:TLangMSG = ('объекты канализации','об''єкти каналізції');
  msgITOGO:TLangMSG = ('ИТОГО','ІТОГО');
  msgFrom:TLangMSG = ('С','З');
  msgOrdersNumber:TLangMSG = ('Номер наряда','Номер наряду');
  msgOrders:TLangMSG = ('Наряды','Наряди');
  msgREVS:TLangMSG = ('Участков','Ділянок');
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
  msgPlaceShort:TLangMSG = ('Местн.','Місц.');

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
  msgMonth:TLangMSG = ('Месяц','Місяць');
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
  msgVidOpenZadv:TLangMSG = ('Открытый','Відкритий');
  msgVidCloseZadv:TLangMSG = ('Закрыта','Закрита');
  msgOpenWent:TLangMSG = ('Открыт','Відкрит');
  msgCloseWent:TLangMSG = ('Закрыт','Закрит');
  msgClosed:TLangMSG = ('Закрытые','Закриті');
  msgForClosed:TLangMSG = ('закрытым','закритим');
  msgForNotClosed:TLangMSG = ('незакрытым','незакритим');
  msgNotClosed:TLangMSG = ('Незакрытые','Незакриті');
  msgAddrCloseZadv:TLangMSG = ('Адрес перекрытой задвижки','Адреса перекритої засувки');
  msgAddrRaskop:TLangMSG = ('Адрес раскопки','Адреса розкопки');
  msgDopAddr:TLangMSG = ('Дополнительный адрес$','Додаткова адреса');
  msgDopAddrShort:TLangMSG = ('Доп. адрес','Додат. адреса');
  msgDopInfo:TLangMSG = ('Дополнительная информация','Додаткова інформація');

  msgDopInfoShort:TLangMSG = ('Доп.информация','Додат.інформація');
  msgDopInfoDoWork:TLangMSG = ('Доп.информация выполненных работ','Додаткова інформація виконаних робіт');
  msgDopInfoPlanWork:TLangMSG = ('Доп.информация запланированных работ','Додаткова інформація запланованих робіт');

  msgDoOpenZadv:TLangMSG = ('Открыть'#13#10'задвижку','Відкрити'#13#10'засувку');
  msgDoAddZadvFromZajav:TLangMSG = ('Добавить незакрытую задвижку из закрытого наряда','Додати незакриту засувку з закритого наряду');
  msgDoAddRaskopFromZajav:TLangMSG = ('Добавить незакопанную раскопку из закрытого наряда','Додати незакопану розкопку з закритого наряду');
  msgCloseZadvCount:TLangMSG = ('Перекрытых задвижек %d из них открытых %d','Перекритих засувок %d з них відкритих %d');
  msgCloseRaskopCount:TLangMSG = ('Раскопок %d из них незасыпанных %d','Розкопок %d из них незасипаних %d');
  msgWentCountClose:TLangMSG = ('Всего Этапов %d из них закрытых %d','Усього виїздів %d з них закритих %d');

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
  msgKiev:TLangMSG = ('"Житомирводоканал"',' "Житомирводоканал"');
  msgVedom:TLangMSG = ('Ведомости','Відомості');
  msgVedomOne:TLangMSG = ('Ведомость','Відомость');
  msgNewZajav:TLangMSG = ('Новый наряд','Новий наряд');
  msgSelOfYearAndNum:TLangMSG = ('Выбор по номеру и году','Вибір за номером і роком');
  msgVedomost:TLangMSG = ('Ведомость учета','Відомість обліку');
  msgVedomostPovr:TLangMSG = ('Ведомость учета повреждений','Відомість обліку пошкоджень');
  msgVedNoCloseZajav:TLangMSG = ('Ведомость учета незакрытых нарядов за период','Відомість обліку незакритих нарядів');
  msgVedZajav:TLangMSG = ('Ведомость учета нарядов','Відомість обліку нарядів');
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
  msgVedUstran:TLangMSG = ('Ведомость устраненных нарядов','Зведення устраненных нарядів');
  msgVedUstran_vod:TLangMSG = ('Ведомость устраненных нардов(отдел водопровода)','Зведення устраненных нарядів(відділ водопроводу)');
  msgVedAbon:TLangMSG = ('Ведомость в абонентный отдел','Зведення в абонентный отдел');
  msgVedKolvo:TLangMSG = ('Количество (по участкам) устраненных утечек за период','Количество (по участкам) устраненных утечек за период');
  msgDelZayav:TLangMSG = ('Ведомость удаленных нарядов','Ведомость удаленных нарядів');
  msgViborPoUl:TLangMSG = ('Выбор всех нарядов по улице','Выбор всех нарядів по улице');
  msgVedPostupAbon:TLangMSG = ('Ведомость поступивших нарядов (абонентный отдел)','Ведомость поступивших нарядів (абонентный отдел)');
  msgVedVipoln:TLangMSG = ('Ведомость выполнения восстановительных работ (по раскопкам)','Зведення выполнения восстановительных работ (по раскопкам)');
  msgSvodkaLikvPovr:TLangMSG = ('Сводка ликвидированных повреждений','Зведення ліквідованих пошкоджень');
  msgVedDamageKv:TLangMSG = ('Ведомость анализа повреждений за квартал','Відомість аналізу ушкоджень за квартал');
  msgAnalLeak:TLangMSG =('Анализ утечек','Аналіз витоків');
  msgDaylyLogTitle:TLangMSG =('Суточный журнал','Добовий журнал');
  msgSetupVedPovr:TLangMSG = ('Настройка ведомости учета повреждений','Настроювання відомісті обліку пошкоджень');
  msgProizSearch:TLangMSG = ('Произвольный поиск','Довільний пошук');
  msgUniverSpravka:TLangMSG = ('Универсальная справка','Універсальна довідка');
  msgSravnitSpravka:TLangMSG = ('Сравнительная справка','Порівняльна довідка');
  msgSConsolidStateTitle:TLangMSG = ('СВОДНАЯ ВЕДОМОСТЬ','ЗВЕДЕНА ВІДОМІСТЬ');
  msgStateLeaksTitle:TLangMSG = ('Сводка утечек за период','Звіт витоків за період');
  msgStateAddMoreCountTitle:TLangMSG = ('Поиск адресов больше определенного кол-ва',
                                          'Пошук адрес більше  певної кількості');

  msgNewUser:TLangMSG = ('Новый пользователь','Новий користувач');
  msgVersion:TLangMSG = ('Версия','Версія');
  msgAnaliz:TLangMSG = ('Анализ','Аналіз');
  msgVedAnalizPovr:TLangMSG = ('Ведомость анализа повреждений','Відомість аналізу пошкоджень');
  msgAnalizPovr:TLangMSG = ('Анализ повреждений','Аналіз пошкоджень');
  msgAnalizPovrUlic:TLangMSG = ('Анализ повреждений по улице','Аналіз пошкоджень по вулиці');
  msgAnalisWorkEquip: TLangMSG = ('Анализ работы механизмов','Аналіз роботи механізів');
  msgSpravoch:TLangMSG = ('Справочники','Довідники');
  msgSpravochOne:TLangMSG = ('Справочник','Довідник');
  msgDolzLic:TLangMSG = ('Должностных лиц','Посадових особ');
  msgResponse:TLangMSG = ('Должность','Посада');
  msgRAYONS:TLangMSG = ('Административных районов','Міст/Селищ');
  msgREMONT:TLangMSG = ('Выполнение ремонта','Виконання ремонту');
  msgREGIONone:TLangMSG = ('Регион','Регіон');
  msgRAYONone:TLangMSG = ('Административный район','Адміністративний район');
  msgRAYON:TLangMSG = ('Город/Пос.','Місто/Селище');
  msgREV:TLangMSG =  ('Участок','Ділянка');
  msgSetlers:TLangMSG =  ('Поселок','Селище');
  msgNameStreets:TLangMSG = ('Наименований улиц','Назв вулиць');
  msgTypeStreets:TLangMSG = ('Видов улиц','Видів вулиць');
  msgWorks:TLangMSG = ('Работ','Робіт');
  msgWorkOne:TLangMSG = ('Работа','Робота');
  msgWorkMany:TLangMSG = ('Работы','Роботи');
  msgMaters:TLangMSG = ('Материалов','Матеріалів');
  msgMaterOne:TLangMSG = ('Материал','Матеріал');
  msgMaterMany:TLangMSG = ('Материалы','Матеріали');
  msgMechan:TLangMSG = ('Механизмы','Механізми');
  msgObjectOne:TLangMSG = ('Объект','Об''єкт');
  msgPlanmechan: TLangMSG = ('Планируемые механизмы','Механізми, що плануються');
  msgDoWorks:TLangMSG = ('Выполняющих работу','Виконуючих роботи');
  msgDoWorkOne:TLangMSG = ('Выполняющий работу','Виконуючий роботу');
  msgMestnostPovr:TLangMSG = ('Местности повреждений','Місцевостей пошкоджень');
  msgMestPovr:TLangMSG = ('Мест повреждений','Місць пошкоджень');
  msgZajavitels:TLangMSG = ('Заявителей','Заявників');
  msgDopAdresov:TLangMSG = ('Дополнительных адресов', 'Додаткових адрес');
  msgDopAdres:TLangMSG = ('Дополнительный адрес', 'Додаткова адреса');
  msgZajavitelOne:TLangMSG = ('Заявитель','Заявник');
  msgSoderzZajav:TLangMSG = ('Характер повреждений','Зміста нарядів');
  msgMechaniz:TLangMSG = ('Механизмов','Механізмів');
  msgPlanMechaniz:TLangMSG = ('Обобщенных механизмов','Узагальнених механізмів');
  msgPovrezd:TLangMSG = ('Типов повреждений','Типів Пошкоджень');
  msgTypeZajav:TLangMSG = ('Типов нарядов','Типів нарядів');
  msgTypesColSHACH:TLangMSG = ('Типов колонок шахматки','Типів стовпчиків "шахматки"');
  msgMaterTrubOne:TLangMSG =('Материал трубу','Матеріал труби');
  msgMaterTrub:TLangMSG =('Материалов труб','Матеріалів труб');
  msgVRK:TLangMSG =('ВРК','ВРК');
  msgAddMustBlagWork:TLangMSG =('Обязательных работ по благоустройству','Обов''язкових робіт з блогоустрою');
  msgTrudozatrat:TLangMSG =('Трудозатрат','Трудовитрат');
  msgBWork:TLangMSG =('Сложных работ','Складних рабіт');
  msgInstruments:TLangMSG =('Инструментов','Інструментів');
  msgObjects:TLangMSG =('Объектов','Об''єктів');
  msgEquipObjects:TLangMSG =('Оборудования объектов','Обладнення об''єктів');
  msgFances:TLangMSG =('Ограждений','Огорож');
  msgCommonTypEquip:TLangMSG =('Обобщенных типов оборудования','Узагальнених типів обладнення');
  msgCommonTypEquipOne:TLangMSG =('Обобщенный тип оборудования','Узагальнений тип обладнення');
  msgCommonTypEquipShort:TLangMSG =('Обобщ. тип','Узагаль. тип');
  msgTypEquip:TLangMSG =('Типов оборудования','Типів обладнення');
  msgConstructions:TLangMSG =('Сооружений','Споруд');
  msgService:TLangMSG = ('Сервис','Сервіс');
  msgContext:TLangMSG = ('Содержание','Зміст');
  msgHistoryChanges:TLangMSG = ('История изменений','Історія змін');
  msgNastrojka:TLangMSG = ('Настройки','Настроювання');
  msgAddMap:TLangMSG = ('Подключить карту','Підключити карту');
  msgDelMap:TLangMSG = ('Отключить карту','Відключити карту');
  msgArhiv:TLangMSG = ('Архивирование', 'Архівуваня');
  msqRestore:TLangMSG = ('Восстановление','Востановлення');
  msgClock:TLangMSG = ('Часы','Годинник');
  msgSysClock:TLangMSG = ('Системное время','Систмний час');
  msgAutoVVod:TLangMSG = ('Автоввод','Автовведення');
  msgOpenOtherName:TLangMSG = ('Войти под другим именем','Ввійти під іншим ім''ям');
  msgExitProg:TLangMSG = ('Выход из программы','Вихід з програми');
  msqWindows:TLangMSG = ('Окна','Вікна');
  msgOrderNaVi:TLangMSG = ('Наряд на выяснении заявки' ,'Наряд на поясненні заявки');
  msgDeletingOrder:TLangMSG = ('Наряды на удаление' ,'Наряд на відалення');
  msqInpuSmen:TLangMSG = ('Ввод номера смены','Введення номеру зміни');
  msgErrorServer:TLangMSG = ('Ошибка подключения к серверу !','Помилка підключення к серверу !');
  msgErrorCountry:TLangMSG = ('Неправильно установлена страна: ','Помилково встановлена країна: ');
  msgSelPredvZajav:TLangMSG = ('Выбор предварительного наряда','Вибір попереднього наряду');
  msgDelZajav:TLangMSG = ('Выбор наряда на удаление','Вибір наряду на видалення');
  msgSelNoCloseZajav:TLangMSG = ('Выбор незакрытого наряда','Вибір незакритого наряду');
  msgSelCloseZajav:TLangMSG = ('Выбор закрытого наряда','Вибір закритого наряду');
  msgSelCloseZadv:TLangMSG = ('Выбор закрытой задвижки','Вибір закритої засувки');
  msgDigger:TLangMSG = ('ЗАСЫПАНО','ЗАСИПАНО');
  msgDataEndLTBegin:TLangMSG = ('Дата окончания/начала меньше даты начала/плана!','Дата закінчення менше дати початка!');
  msgDataBeginWentLTOpen:TLangMSG = ('Дата начала Этапа раньше даты открытия наряда !','Дата початку виїзда раніше дати відкриття наряду');
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
  msgWent:TLangMSG = ('Этапы','Виїзди');
  msgWentOne:TLangMSG = ('Этап','Виїзд');
  msgPlanTime:TLangMSG = ('Планируемое время', 'Запланований час');
  msgWentNotClose:TLangMSG = ('Этап Не закрыт !','Виїзд Не закритий');
  msgJobsAndMat:TLangMSG = ('Работы/материалы','Роботи/Матеріали');
  msjPlanJobs:TLangMSG =('Запланированные работы','Заплановані работи');

  msgConfirmDelWent:TLangMSG = ('  Вместе с Этапом будут удалены материалы, оборудование, работы и раскопки, соответствующие данному Этапу.'#13'  Удалить Этап?',
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
  msgErrorExec:TLangMSG = ('Ошибка выполнения ','Помилка виконання ');
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
  msgAbout:TLangMSG = ('О чем заявлено','Про що заявлено');
  msgOrdertype:TLangMSG = ('Вид наряда','Вид наряду');
  msgCbIsControl:TLangMSG = ('на контроле','на контролі');
  msgPrinad:TLangMSG = ('Принадлежность', 'Належність');
  msgOtl:TLangMSG=('отложен','відкладенний ');
  msgGetFrom:TLangMSG =('Получена','Отримана');
  msgGetFromDisp:TLangMSG =('Получена диспетчером','Отримана диспетчером');
  msgConfirmPerson:TLangMSG =('Сдал','Здав');
  msgConfirmBrig:TLangMSG =('Сдал мастеру','Здав майстру');
  msgOrdertyptype:TLangMSG= ('Тип наряда', 'Тип наряду');
  msgTrubi:TLangMSG= ('трубы','труби');  // чего?
  msgCordinates:TLangMSG= ('Координаты','Координати');
  msgFIO:TLangMSG = ('ФИО','ФІО');
  msgSurname:TLangMSG = ('Фамилия','Прізвище');
  msgAccup:TLangMSG = ('Должность','Посада');
  msgLosses:TLangMSG = ('Потери','Втрати');
   msgConnectToDeferred: TLangMSG = ('Связать с отложенным','Зв''язати з відкладеними');
  msgWithoutWater: TLangMSG =  ('Без воды','Без води');
  msgImage :TLangMSG =('Изображения','Зображення');

  msgOrderContenr:TLangMSG = ('Содержание наряда','Зміст наряду');
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
  msgShowOnMap:TLangMSG = ('Показать наряд на карте','Показати наряд на карті');
  msgTieOnMap:TLangMSG = ('Привязать наряд к карте','Прив''язати наряд до карти');
  msgWrongPasswd:TLangMSG = ('Неправильное имя пользователя или пароль !','Неправильне ім''я користувача обо пароль !');
  msgClientServer:TLangMSG = ('Клиент/Сервер','Клієнт/Сервер');
  msgLoadProgram:TLangMSG = ('Загрузка программы','Завантаження програми');
  msgSaveChangedInfo:TLangMSG = ('Сохранить измененную информацию','Зберегти змінену інформацію');
  msgCloseWindow:TLangMSG = ('Закрыть окно','Закрити вікно');
  msgCopyZajav:TLangMSG = ('Копировать текущий наряд в новый','Копіювати поточний наряд до нового');
  msgNoNomDom:TLangMSG = ('Не заполнен НОМЕР ДОМА !','Не заповнен НОМЕР БУДИНКУ !');
  msgSaveNewZajav:TLangMSG = ('Сохранить новый наряд ?','Зберегти новий наряд ?');
  msgSameZajav:TLangMSG = (' незакрытых нарядов имеют похожий адрес. Показать?',
                           ' незакритих нарядів мають схожу адресу. Показати?');
  msgSameZajavList:TLangMSG = ('Незакрытые наряды с адресом близким к ','Незакриті наряди з адресою близькою до');
  msgZajavSetNom:TLangMSG = ('Наряду присвоен номер ','Наряду присвоено номер ');
  msgZajavIDNotFound:TLangMSG = ('Наряд с ID=%d НЕ НАЙДЕН!','Наряд з ID=%d НЕ ЗНАЙДЕН!');
  msgZajavWithOpenZadv:TLangMSG = ('У наряда присутствуют перекрытые задвижки! Закрыть наряд?',
                                   'У наряді присутні перекриті засувки! Закрити наряд?');
  msgZAjavWithoutWWater:TLangMSG = ('У наряда присутствуют не закрытые отключения! Закрыть наряд?',
                                   'У наряді присутні незакриті відключення! Закрити наряд?');
  msgZajavWithOpenRaskop:TLangMSG = ('В наряде присутствуют незасыпанные раскопки! Закрыть наряд?',
                                     'У наряді присутні незасипані розкопки! Закрити наряд?');
  msgZajavWithoutDiam:TLangMSG = ('Не определен ДИАМЕТР! Закрыть наряд?',
                                  'Не визначен ДІАМЕТР! Закрити наряд?');
  msgCloseZajav:TLangMSG = ('Закрыть наряд ?','Закрити наряд ?');
  msgErrorSetFStreetFilter :TLangMSG= ('Ошибка открытия  списка улиц!!','Помилка відкриття списку вулиць!!');
  msgZajavWithoutCloseWent:TLangMSG = ('У наряда нет закрытых Этапов! ','У наряда нема закритих виїздів! ');
  msgZajavWithoutWent:TLangMSG = ('У наряда нет Этапов !','У наряда нема виїздів !');
  msgZajavWentDel:TLangMSG = ('У наряда уже есть Этапы! Удалите их. ','У наряда вже иснують виїзди! Видалити їх. ');
  msgClosing:TLangMSG = ('ЗАКРЫТИЕ','ЗАКРИТТЯ');
  msgSending:TLangMSG = ('ПОСТУПЛЕНИЕ','НАДХОДЖЕННЯ');
  msgBegin:TLangMSG = ('Начало','Початок');
  msgEnd:TLangMSG = ('Конец','Кінець');
  msgTellWent:TLangMSG = ('ОПИСАНИЕ ЭТАПА','ОПИС ВИЇЗДА');
  msgWhoDoJob:TLangMSG = ('ВЫПОЛНЯЛ РАБОТУ','ВИПОВНЮВАВ РОБОТУ');
  msgNewYear:TLangMSG = (' Поменялся год !'#13#10'Сохранить наряд с номером 1 за %d год ?'#13#10'Ввод нарядов с %d годом будет уже невозможен !',
                         ' Змінився рік !'#13#10'Зберегти наряд з номером 1 за %d рік ?'#13#10'Введення нарядів з %d роком буде вже неможливо !');
  msgConfirmNewYear:TLangMSG = (' Вы уверены ?'#13#10'Ввод нарядов с %d годом будет уже невозможен !',
                                ' Ви впевнені ?'#13#10'Введення нарядів з %d роком буде вже неможливо !');
  msgPrintAllWorks:TLangMSG = ('печатать все работы наряда','друкувати усі роботи наряда');
  msgNotPrintKoll:TLangMSG = ('Не учитывать повреждения на коллекторах (Все повреждения)','Не враховувати пошкодження на колекторах');
  msgPrintKoll:TLangMSG = ('Только повреждения на коллекторах','Тільки пошкодження на колекторах');
  msgPrintNotKoll:TLangMSG = ('Все, кроме повреждений на коллекторах','Усі, крім пошкоджень на колекторах');
  msgDictAll:TLangMSG = ('Полная видимость','Повна видимість');
  msgDictShow:TLangMSG = ('Только видимые','Тільки видимі');
  msgDictHide:TLangMSG = ('Только невидимые','Тільки невидимі');
  msgTypeLeak:TLangMSG = ('Видов течи','Видів течі');
  msgTypeClog:TLangMSG = ('Видов засора','Видів засмічення');
  msgTypeFill:TLangMSG = ('Видов засыпки','Видів засипання');
  msgTypeNet:TLangMSG = ('Видов сети','Видів мережі');
  msgTypeKillClog:TLangMSG = ('Видов ликвидации засора','Видів ліквідації засмічення');
  msgTypeLocal:TLangMSG = ('Мер локализации аварий','Заходів локалізації аварій');
  msgTypePump:TLangMSG = ('Методов откачки','Заходів відкачки');
  msgTypePES:TLangMSG = ('Использования САК','Використання САК');
  msgTypeOwner:TLangMSG = ('Принадлежности наряда','Принадлежністі наряду');

  msgTypeNetOne:TLangMSG = ('Сеть','Мережа');
  msgTypeLeakOne:TLangMSG = ('Выливания','Виливання');
  msgTypeClogOne:TLangMSG = ('Вид засора','Вид засмічення');
  msgTypeFillOne:TLangMSG = ('Вид засыпки'#10#13'колодца','Вид засипання'#10#13'колодязя');
//  msgMineZav:TLangMSG = ('Своя','Своя');
//  msgTheirZav:TLangMSG = ('Чужая','Чужа');
//  msgTheirMineZav:TLangMSG = ('Чужая, работы свои','Чужа, роботи свої');
  msgFalseZav:TLangMSG = ('Ложная','Помилкова');
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
  mcsVedNarPeriod:TLangMSG=('Ведомость этапов за период ','Відомість етапів у період');
  vsgVip:TLangMSG=('Выполнение','Виконання');
  msgNumNar:TLangMSG=('№ этапа','№ виїзду');
  msgDiscons:TLangMSG=('Отключения ','Відключення');
  msgWithoutWaterKanal:TLangMSG=('Отключения ' +#13+ 'водоотведения','Відключення' +#13+ ' водовідведення');
  msgCloseNar:TLangMSG = ('Предыдущая смена должна закрыть выезды   '+
                      'в нарядах %s ',
                      'Попередня  зміна має закрити виїзд '+
                      ' у нарядах %s ');
  msgChangeSmenDeny:TLangMSG = ('Пересменка запрещена!','Пересмінка заборонена!');
  msgDoChangeSmen:TLangMSG = ('Сделайте пересменку!','Поміняйте  зміну!');

  msgDatBeginInCurShift:TLangMSG = ('Даты  должны быть в пределах текущей смены!',
  'Дати  мають бути поточній у зміні');
 msgDatZavEndInCurShift:TLangMSG = ('Дата открытия наряда должна быть в пределах текущей смены!',
 'Дата відкриття наряду  має бути поточній у зміні');
  msgDatZavInCurShift:TLangMSG = ('Дата закрытия наряда должна быть в пределах текущей смены!',
 'Дата закриття наряду  має бути поточній у зміні');
 msgLinkedWithOtlZavjav:TLangMSG  = ('Наряд связан с №','Наряд зв''язан з №');

  msgDelLink:TLangMSG = ('Удалить связь с нарядом №','Видалити зв''язок  з нарядом № ');
  msgDelLinkShort:TLangMSG = ('Удалить связь ','Видалити зв''язок  ');

  msgWaterPipe:TLangMSG = (' Водопровод ',' Водопровід ');
  msgSeverage:TLangMSG = ('Канализация',' Водовідведення ');
  msgWaterObjects:TLangMSG=('Объекты водопровода','Об''єкти водопроводу');
  msgSeverageObjects:TLangMSG = ('Объекты канализации','Об''єкти каналізації' );
  msgShift:TLangMSG = ('Смена','Зміна');
  msgFillFirstNar:TLangMSG = ('Заполните первичны віезд', 'Заповніть первинний виїзд');
  msgWarnDisableCloseOrder:TLangMSG=('Наряд закрыть нельзя', 'Наряд закрити неможливо');
  msgWarnDisableOrderType:TLangMSG =('Наряд закрыть нельзя, так как его тип "НА ВЫЯСНЕНИИ"','Наряд закрити неможливо, його тип "НА ВЫЯСНЕНИИ"');//?????????????
  msgWarnByNarDate:TLangMSG =('дата закрытия последнего выезда больше даты закрытия наряда!','дата закриття останього виїзду більше за дату наряда!!');
  msgRemoveFdelOrder:TLangMSG=('убрать из нарядов на удаление', 'прибрати з нарядів для видалення ');
  msgaddTodelOrder:TLangMSG=('поместить на удаление ','помітити дл видалення');
  msgIsAddToDelete :TLangMSG=('поставлена на удаление','помычена для видалення дспетчером');
  msgNotFill:TLangMSG=('не заполнена', 'не заповнена');
  msgAddResonDel:TLangMsg=('Заполните ее причиной постановки на удаление','Заповніть її причиною для видлення');
  msgRemoveFOtlNar:TLangMSG=('убрать из отложенных нарядов', 'прибрати з відкладенних нарядів');
  msgAddOtlNar:TLangMSG=('отложить', 'відкласти');
  msgConectWith:TLangMSG=('Связан с №','Зв''язан з №' );
  msgZavVRK:TLangMSG=('ЗАЯВКИ ВРК', 'ЗАЯВКИ ВРК');//??????????????????
  msgToDel:TLangMSG=('на удаление','на видалення');
  msgFirst:TLangMSG=('Первичный','Первинний');
  msgFastAdd:TLangMSG=('Быстрое добавление', 'Швидке додавання');
  msgComplitWork:TLangMSG=('Сложная рбота', 'Складна робота');
  msgAllRecords:TLangMSG=('Все записи','Усі записи');
  msgConectCompWork:TLangMSG=('Привязанные к слож. работе','Прив''язані до склад. работи');
  msgFreeRecords:TLangMSG=('Свободные записи','Вільні записи');
  msgRecalcTZ:TLangMSG=('Пересчитать трудозатраты','Перерахувати трудовитрати');
  msgLaborInput:TLangMSG=('Трудозатраты','Трудовитрати') ;
  msgOnQuantity:TLangMSG=('на задан. кол-во ед.','на задан. кіл-сть од.');
  msgQuantityItems:TLangMSG=('Кол-во единиц','Кількість одиниць');
  msgCommonTZ:TLangMSG=('Общие трудозатраты','Спільні трудовитрати');

  msgConfirmDepWorkExcav:TLangMSG=('При удалении данной работы будет удалена сооствествующая' + #13 +
                                  'раскопка, а также все соответствующие ей работы по благоустройству.'+#13+
                                  'Продолжить?',
                                  'Разом з роботою будуть видалені відповідна розкопка і усі відповідні'+#13+
                                  'роботи з благоустрію'+#13+
                                  'Продовжти?');
  msgEditWork:TLangMSG=('Редактирование работы', 'Редагуваня робіт');
  msgNotDefined:TLangMSG =('не заданы','не вказані');
  msgFormZavNoDmL:TLangMSG=('на форме наряда не задана местность пов.','на формі наряду не вказаа місцевість пош.');
  msgNotFieldValue:TLangMSG=('Не задано поле','Не визначено поле');
  msgImpossRecalcTZ:TLangMSG=('Невозможно пересчитать трудозатраты','Неможливо перерахуати трудовитрати');
  msgNeedExcav:TLangMSG=('Необходимо ввести информацию по раскопке', 'Необхідно ввести інформацію про розкопку');
  msgNeedSetExcav:TLangMSG=('Выберите раскопку','Оберіть розкопку');
  msgAddBWork:TLangMSG=('Добавление сложной работы','Додавання складної роботи');
  msgEditBWork:TLangMSG=('Редактирование сложной работы','Редагування складної роботи');
  msgDelWorkForOld:TLangMSG=('Удалить работы соот. старому значению','Видалити роботи, що відповідають старому значенню');
  msgAddWorkForNew:TLangMSG=('Добавить работы соот. новому значению','Додати роботи, що відповідають новому значенню');
  msgDelMaterForOld:TLangMSG=('Удалить материалы соот. старому значению','Видалити матеріали, що відповідають старому значенню');
  msgAddMaterForNew:TLangMSG=('Добавить материалы соот. новому значению','Додати матеріали, що відповідають новому значенню');
  msgAddWorksAssigned:TLangMSG=('Добавить соот. работы','Додати відповідні роботи');
  msgAddMaterAssigned:TLangMSG=('Добавить соот. материалы','Додати відповідні матеріали');
  msgDelBwork:TLangMSG=('Удаление сложной работы','Видалення складної работи');
  msgConfirmDelBwork:TLangMSG=('Вы уверены, что хотите удалить сложную работу?','Ви впевнені, що бажаєте видалити складну роботу?');
  msgDelWorksAssigned:TLangMSG=('Удалить соот. работы','Видалити відповідні роботи');
  msgDelMaterAssigned:TLangMSG=('Удалить соот. материалы','Видалити відповідні матеріали');
  msgEditMater:TLangMSG=('Редактирование материалов','Редагування матеріалів');
  msgAddMater:TLangMSG=('Добавление материалов','Додавання матеріалів');
  msgAddAsigned:TLangMSG=('Добавить соответ.','Додати відповідні');
  msgSmallWork:TLangMSG=('подработы','малі роботи');
  msgNeedSaveNar:TLangMSG=('Сохраните выезд!!','Потрібно записати виїзд!!');
  msgNeedbrig:TLangMSG=('Выберете бригадира!!!','Оберіть бригадира!');
  msgWorkTime:TLangMSG=('Время работы','Час роботи');
  msgCopyPlan:TLangMSG=('Скопировать план','Скопіювати план');
  msgTools:TLangMSG=('Инструменты','Інструменти');
  msgBrigsList:TLangMSG=('Справочник Бригад','Довідник бригад');
  msgBrigorMaster:TLangMSG=('Бригадир или мастер','Бригадир або майстер');
  msgWorkrersWorked:TLangMSG=('Работали','Працювали');
  msgFirstStep:TLangMSG=('Первичный этап','Первинний етап');
  msgRemoveZadv:TLangMSG=('Сбросная задвижка','Скидна засувка');
  msgNormZadv:TLangMSG=('Нормальное состояние задвижки','Нормалний стан засувки');
  msgNote:TLangMSG=('Планшет,','Планшет');
  msgNumKOl:TLangMSG=('№ колодца','№ колодязя');
  msgZadvOne:TLangMSG=('Задвижка','Засувка');
  msgStateChanged:TLangMSG=('Состояние изменено','Стант змінено');
  msgFirstSate:TLangMSG=('Исходное состояние','Вихідний стан');
  msgAddZadvFromCloseOrder:TLangMSG=('Добавить незакрытую задвижку из закрытого наряда','Додати незакриту засувку зі закритого наряду');
  msgType:TLangMSG=('Тип','Тип');
  msgCrossRoadw:TLangMSG=('перекресток с ','перехрестя з');
  msgExcavTo:TLangMSG=('Разрытие передано','Розриття передано');
  msgAktFrom:TLangMSG=('акт от', 'акт від');
  msgNeedDoBlag :TLangMSG=('Необходимо выполнить работы','Необхідно виконати роботи');
  msgExcavSize :TLangMSG=('Размеры разрытия','Розміри розриття');
  msgFencing: TLangMSG=('Ограждение','Огорожа');
  msgLength: TLangMSG=('Длинна','Довжина');
  msgWidth: TLangMSG=('Ширина','Ширина');
  msgDepth: TLangMSG=('глубина','глибина');
  msgAccept: TLangMSG=('принял','прийняв');
  msgPlabBlagDate:TLangMSG=('Планируемая дата восстановления','Запланована дата відновлення');
  msgRoadWorkerDate:TLangMSG=('Дата передачи дорожникам','Дата передачі кампаніі асвальтувальників');
  msgBlagDate :TLangMSG=('Дата восстановления','Дата відновлення');
  msgFirmAsf :TLangMSG=('Фирма асфальтировки','Фірма асфальтувальник');
  msgNumAktAsf :TLangMSG=('№ акта дорожников','№ акту дорожників');
  msgChebDate :TLangMSG=('Дата щебенения','Дата щебеніння');
  msgChebAkt :TLangMSG=('№ акта щебенения','№ акту щебеніння');
  msgDownAsfDate :TLangMSG=('Дата нижней асфальтировки','Дата нижнього асфальтування');
  msgUpAsfDate :TLangMSG=('Дата верхней асфальтировки','Дата верхнього асфальтування');
  msgBalanceKeeper :TLangMSG=('Балансо содержатель','Балансо утримувач');
  msgSandDate :TLangMSG=('Дата (спланировано) засыпано песком','Дата (сплановано) засипано піском');
  msgRecover:TLangMSG=('Восстановить', 'Відновити');
  msgRecovered:TLangMSG=('Восстановлено','Відновлено');
  msgExcavCount:TLangMSG=('количество раскопок:','кількість розкопок');
  msgForDelExcav1:TLangMSG=('При удалении данной раскопки будут также удалены',
                            'При видаленні даної розкопки будуть також видалені');
  msgForDelExcav2:TLangMSG=('и все соответствующие работы.',
                            'і усі відповідні роботи.');
  msgDelExcavcConfirm:TLangMSG=('Вы уверены, что хотите удалить раскопку?',
                                'Ви впевнені, що бажаєте видалити розкопку?');
  msgNeedSaveChanges:TLangMSG=('Прежде сохраните внесенные изменения!',
  'Потрібно зберегти внесені зміни!');
  msgAddExcav:TLangMSG=('Добавить раскопку','Додати розкопку');
  msgNeedTadr:TLangMSG=('Введите тип адреса','Визначте тип адреси');
  msgNeedStreet:TLangMSG=('Введите наименование улицы!','Визначте вулицю');
  msgNeedHouse:TLangMSG=('Введите номер дома!','Визначте номер буд. ');
  msgNeedStreet2:TLangMSG=('Введите наименование улицы №2!','Визначте вулицю №2!');
  msgNeedPlace:TLangMSG=('Введите местность повреждения!','Визначте місцевість пошк.');
  msgIsActiveTran:TLangMSG=('Имеется активная транзакция','Увага  є інша активна транзакція');
  msgNotBlagTime:TLangMSG=('Не задано время окончания обязательных работ по благ-ву',
                           'Не заданий час закінчення обов''язкових робіт з благоустрою');
  msgendWork:TLangMSG=('Окончание работ','Закінчення робіт');
  msgClorDisconPart:TLangMSG=('Хлорирование отключенного участка водопровода',
                             'Хлорування відключеної ділянки мережі');
  msgDateAkt:TLangMSG=('Дата формирования акта','Дата формування акту');
  msgDateReciveOrder:TLangMSG=('Дата и время поступления заявки',
                               'Дата надхдження наряду');
  msgDepthPutM:TLangMSG=('Глубина заложения м','Глибина закладення');
  msgPressAtm:TLangMSG=('Давление воды, атм','Тиск води, атм.');
  msgSquareSvich:TLangMSG=('Площадь свища, мм2','Площа свищу, мм2');
  mshLeakSpeed:TLangMSG=('Утечка, м3/ч','Витік, м3/г');
  msgDamgeCharacterIs:TLangMSG=('Уточнение характера повреждения',
                                'Уточнення характера пошкодження');
  msgDoFlashing:TLangMSG=('Промывка производилась, ч','Промивка проводилася');
  msgDiamDamage:TLangMSG=('Диаметр участка повреждения, мм','Диаметр ділянки пошкодження');
  msgCharLeak:TLangMSG=('Характер места утечки','Характер місця витоку');
  msgClorDoz:TLangMSG=('Доза хлора, мг/л','Доза хлору, мг/л');
  msgTimeContact:TLangMSG=('Время контакта, ч','Час контакту, г');
  msgExternalDiam:TLangMSG=('Внешний диаметр, мм','Зовнішній діаметр');
  msgInteriorDiam:TLangMSG=('Внутренний диаметр, мм','Внутрішній діаметр, мм');
  msgConer:TLangMSG=('Угол, град','Кут, град');
  msgDiamSvich:TLangMSG=('Диаметр свища, мм','Діамети свищу, мм');
  msgCrackLength:TLangMSG=('Длина трещины, мм','Довжина тріщіни, мм');
  msgCrackWidth:TLangMSG=('Ширина трещины, мм','Ширина тріщіни, мм');
  msgLengthEmpty:TLangMSG=('Протяженность опорожненного участка водопровода, м',
                           'Протяжність спорожненої ділянки мережі, м');
  msgDiamEmpty:TLangMSG=('Диаметр участка опорожнения, мм','Діаметр спорожненої ділянки, мм');
  msgDefferedOrder:TLangMSG=('Отложенные наряды','Відкладені наряди');
  msgLinked:TLangMSG=('Связать наряд','Зв''язати наряд');
  msgAddInfShort:TLangMSG=('Доп. инф.','Дод. інф.');
  msgToPo:TLangMSG=('по','по');
  msgDateDiscon:TLangMSG=('Дата отключения','Дата відключення');
  msgDateCon:TLangMSG=('Дата включения','Дата включення');
  msgTimeDiscon:TLangMSG=('Время  отключения','Час відключення');
  msgTimeCon:TLangMSG=('Время  отключения','Час включення');
  msgDisconexecutor:TLangMSG=('Исполнитель откл.','Виконав відключеня');
  msgRespons:TLangMSG=('Ответственный за вкл.','Відповідальний за вкл.');
  msgDtPlanDiscon:TLangMSG=('Дата план  отключения','Дата плану відключення');
  msgDtPlanCon:TLangMSG=('Дата план включения','Дата плану включення');
  msgTimePlanDiscon:TLangMSG=('Время план отключения','Час плану відключення');
  msgTimePlanCon:TLangMSG=('Время плана  включения','Час плану включення');
  msgClassDiscon:TLangMSG=('Класификация отключений','Класифікація відключень');
  msgNumDiscon:TLangMSG=('№ откючения','№ відклюення');
  msgnHouse:TLangMSG=('№ дома','№ буд.');
  msgnDiscon:TLangMSG=('Отключено','Відключено');
  msgCon:TLangMSG=('Включено','Включено');
  msgCheckDtDiscon:TLangMSG=('Проверьте дату включения или нажмите "Отменить"',
                             'Перевірте дату включення або натисніть "Відмінити"');
  msgDtDiskoncon:TLangMSG=('Дата включения должна быть больше даты отключения',
                            'Дата включення повинна бути быльше за дату выдключення');
  msgConSmen:TLangMSG=('Время включения должно соответствовать дате смены',
                           'Дата і час включення повині відповідати зміні');
  msgConDtNow:TLangMSG=('Время включения больше текущей даты',
                        'Час включення більше за поточну дату');

  msgDisconSmen:TLangMSG=('Время выключения должно соответствовать дате смены',
                          'Час і дата відключення повині відповідати зміні');
  msgDisconDtNow:TLangMSG=('Время выключения больше текущей даты',
                            'Час відключення більше за поточну дату');

  msgNeedDisconExecutor:TLangMSG=('Введите исполнителя отключения',
                                  'Введіть хто виконав відключення');
  msgNeedClassDiscon:TLangMSG=('Введите Класификация отключений',
                                'Введіть класифікацію відключень');
  msgResponseNeed:TLangMSG=('Не введён ответственный за включение',
                            'Введіть відповідального за вкл.');
  msgAllhouses:TLangMSG=('все дома','усі буд.');
  msgEvenhouses:TLangMSG=('четные дома','перні буд.');
  msgNotEvenHouses:TLangMSG=('нечетные дома','непарні буд.');
  msgFirstImage:TLangMSG=(' 1-ое изображение','перше зображення');
  msgAddImage:TLangMSG=('Добавить изображение','Додати зображення');
  msgDeleteImage:TLangMSG=('Удалить изображение','Видалити зображення');
  msgPrevImage:TLangMSG=('Предыдущее изображение','Попереднє зображення');
  msgLastImage:TLangMSG=('Последнее изображение','Останнє зображення');
  msgNextImage:TLangMSG=('Следующее изображение','Наступне зображення');
  msgImageSize:TLangMSG=('Размер изображения:','Розмір зображення:');
  msgImageTitle:TLangMSG=('Изображения аварии - изображение №','Ззображення аварії - зображення №');
  msgConfirmDel:TLangMSG=('ImageВы уверены, что хотите удалить изображение?',
      'Ви впевнені, бажаєте видалити зображення? ');
  msgCearList:TLangMSG=('Очистить список','Очистити список');
  msgCongirmCLearList:TLangMSG=('Вы уверены, что хотите очистить список нарядов?',
                                'Ви впевнені, що бажаєте очистити список нарядів?');
  msgSgiftNumber:TLangMSG=('№ смены','№ зміни');
  msgShiftDate:TLangMSG=('Дата смены','Дата зміни');
  msgRecoverCoverShort:TLangMSG=('Восст. покрыт.','Віднов. покрит.');
  msgIsPayed:TLangMSG=('Оплачено','Сплачено');
  msgTypeWork:TLangMSG=('Тип работы','Тип роботи');
  msgSummer:TLangMSG=('лето','літо');
  msgWinter:TLangMSG=('зима','зима');
  msgConnectBWork:TLangMSG=('Привязка','Прив''язка');
  msgNeedChArhiv:TLangMSG=('Надо выбрать архив','Треба отбрати архів');
  msgConfirmArhivReplace:TLangMSG=('Вы уверены, что хотите заменить исходные файлы, на файлы из архива?',
                                    'Ви впевнені, що бажаєте замінити файли на файли з архіву?');
  msgForDay:TLangMSG=('За сутки','За добу');
  msgForShift:TLangMSG=('За смену','За зміну');

  msgLies:TLangMSG=('Ложные','Помилкові');
  msgOnConfirm:TLangMSG=('На выяснении','На поясненні');
  msgOpened:TLangMSG=('Открытые','Відкриті');
  msgDeffered:TLangMSG=('Отложенные','Відкладені');
  msgErrorDate:TLangMSG=('Дата не введена или введена неверно',
                         'Дата не введена або введена з поилкою');
 msgTryAgain:TLangMSG=('Попробуйте еще раз','Спробуйте ще раз');

 msgSearchResults:TLangMSG=('Результат поиска','Результати пошуку');
 msgSearchDiagram:TLangMSG=('График','Графік');

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

  patch:=TAvrPatch.Create('AVARODESSA', ParamStr(2));
  try
    patch.Execute;
  finally
    patch.Free;
  end;
end;

end.
