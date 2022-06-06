unit AvrAdminManagerUnit;
{
	Оболочка для библиотеки avradmin.dll.

	+++

  avradmin.dll - библиотека для раздачи прав пользователям 
   программы "АРМ Диспетчер АВР" для всех городов. 

  Входные параметры:
   _OnEndLoad:pointer - указатель на callback процедуру, которая вызовется, 
    когда библиотека загрузится;
   _alias:PChar - алиас базы, с которой будем работать;
   _sysDbaPass:PChar - пароль для пользователя sysdba.
  
  +++
  
  Оговорки:
  1) Все имена справочников должны начинаться с префикса ('S_');
  2) Права на хранимые процедуры даются всем абсолютно
  3) Для таблиц не справочников и не процедур, ведётся отдельная таблица 
  (S_RIGHTS) с правами,  в которой такие колонки (групы, которым принадлежат таблицы): 
   ID, NAME_R, UR_READ, UR_ZAV, UR_RASK, UR_ZADV, UR_POTER, 
   UR_NARAD, /*, SPRAV - не надо*/, UR_DEL, UR_ADMIN;
  записи в ней - имена таблиц и признаки их принадлежности к правовым группам.
  
  При загрузке библиотеки: 
  1) загружается список всех таблиц (в том числе и справочников) и процедур.
  2) В этом списке ищутся таблицы S_RIGHTS и S_YESNO. Если их нет - они создаются 
  и заполняются.
  S_RIGHTS - заполняется таблицами-не-справочниками. Сразу дается принадлежность
  всем таблицам к группам "Чтение" и "Администрирование".
  3) Если S_RIGHTS была, то проверяется список таблиц, которые содержиться в ней,
   и полный список таблиц базы. Если в S_RIGHTS какой-то таблицы нет, то она добавляется.
  4) Создаются такие списки:  справочники, таблицы-не-справочники, процедуры,
   и пользователи с правами из таблицы S_BRIG у которых псевдоним uid не равен NULL.

  Можно задавать права каждому пользователю. 
  
  Можно перебить права всем пользователям за один раз, на основании   
  информации в поле PRAVA в таблице S_BRIG у пользователей, у которых есть псевдоним uid,
  а также на основании информации из таблицы S_RIGHTS, и списка справочников 
  и процедур. Таким образом, если добавлялась какая-либо таблица, либо процедура - все
  пользователи получат на них права в соответствии с правовыми группами, 
  в которых они состоят.

  Псевдоним пользователя даже если он был, теперь создается по строгому правилу:
  <алиас базы>_<id пользователя в таблице S_BRIG>. Вручную вводить теперь его не надо.

  По этому псевдониму создатеся системный пользователь базы данных. Только уже без
  помощи gsec.exe. Следовательно, теперь отпала необходимость прописывать путь к gsec.exe   
  в ини-файле.

  Имя сервера берётся из пути к базе, который прописан в алиасе. И автоматически 
  определяется тип подключения к нему - локальный, либо через TCP.

  На основной форме есть кнопка с вызовом формы редактирования таблицы S_RIGHTS. 
  Изменения в неё можно внести как вручную, так из скрипта.
     
}

interface

uses Windows, SysUtils;

type
  TProcOfObject = procedure of object;
  TShowAvrAdmin = procedure (_OnEndLoad:pointer; _alias:PChar; _sysDbaPass:PChar);
  TAvrAdminManager = class
  private
    FOnEndLoad: TProcOfObject;
    FShowAvrAdmin: TShowAvrAdmin;
    FhLibraryHandle: THandle;
    FAlias, FSysDbaPassword: string;
  protected
  public
    constructor Create(_alias, _sysdbaPassword: string);
    destructor Destroy; override;
    procedure Show;
    property OnEndLoad:TProcOfObject read FOnEndLoad write FOnEndLoad;    
  end;

implementation

procedure TAvrAdminManager.Show;
begin
  if Assigned(FShowAvrAdmin) then
  begin
    FShowAvrAdmin(@FOnEndLoad, PChar(FAlias), PChar(FSysDbaPassword));
  end;

  end;

constructor TAvrAdminManager.Create(_alias, _sysdbaPassword: string);
begin
  FOnEndLoad := nil;
  FAlias := _alias;
  FSysDbaPassword := _sysdbaPassword;
  FhLibraryHandle := LoadLibrary(PChar(ExtractFilePath(ParamStr(0)) + 'avradmin.dll'));
  FShowAvrAdmin := GetProcAddress(FhLibraryHandle, 'ShowAvrAdmin');
  if not Assigned(FShowAvrAdmin)
  then MessageBox(0, 'Помилка загрузки avradmin.dll', 'Диспетчер АВР', MB_OK or MB_ICONWARNING);  
end;

destructor TAvrAdminManager.Destroy;
begin
  if (FhLibraryHandle>0) then FreeLibrary(FhLibraryHandle);
  inherited;
end;

end.
