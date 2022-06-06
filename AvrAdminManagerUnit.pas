unit AvrAdminManagerUnit;
{
	�������� ��� ���������� avradmin.dll.

	+++

  avradmin.dll - ���������� ��� ������� ���� ������������� 
   ��������� "��� ��������� ���" ��� ���� �������. 

  ������� ���������:
   _OnEndLoad:pointer - ��������� �� callback ���������, ������� ���������, 
    ����� ���������� ����������;
   _alias:PChar - ����� ����, � ������� ����� ��������;
   _sysDbaPass:PChar - ������ ��� ������������ sysdba.
  
  +++
  
  ��������:
  1) ��� ����� ������������ ������ ���������� � �������� ('S_');
  2) ����� �� �������� ��������� ������ ���� ���������
  3) ��� ������ �� ������������ � �� ��������, ������ ��������� ������� 
  (S_RIGHTS) � �������,  � ������� ����� ������� (�����, ������� ����������� �������): 
   ID, NAME_R, UR_READ, UR_ZAV, UR_RASK, UR_ZADV, UR_POTER, 
   UR_NARAD, /*, SPRAV - �� ����*/, UR_DEL, UR_ADMIN;
  ������ � ��� - ����� ������ � �������� �� �������������� � �������� �������.
  
  ��� �������� ����������: 
  1) ����������� ������ ���� ������ (� ��� ����� � ������������) � ��������.
  2) � ���� ������ ������ ������� S_RIGHTS � S_YESNO. ���� �� ��� - ��� ��������� 
  � �����������.
  S_RIGHTS - ����������� ���������-��-�������������. ����� ������ ��������������
  ���� �������� � ������� "������" � "�����������������".
  3) ���� S_RIGHTS ����, �� ����������� ������ ������, ������� ����������� � ���,
   � ������ ������ ������ ����. ���� � S_RIGHTS �����-�� ������� ���, �� ��� �����������.
  4) ��������� ����� ������:  �����������, �������-��-�����������, ���������,
   � ������������ � ������� �� ������� S_BRIG � ������� ��������� uid �� ����� NULL.

  ����� �������� ����� ������� ������������. 
  
  ����� �������� ����� ���� ������������� �� ���� ���, �� ���������   
  ���������� � ���� PRAVA � ������� S_BRIG � �������������, � ������� ���� ��������� uid,
  � ����� �� ��������� ���������� �� ������� S_RIGHTS, � ������ ������������ 
  � ��������. ����� �������, ���� ����������� �����-���� �������, ���� ��������� - ���
  ������������ ������� �� ��� ����� � ������������ � ��������� ��������, 
  � ������� ��� �������.

  ��������� ������������ ���� ���� �� ���, ������ ��������� �� �������� �������:
  <����� ����>_<id ������������ � ������� S_BRIG>. ������� ������� ������ ��� �� ����.

  �� ����� ���������� ��������� ��������� ������������ ���� ������. ������ ��� ���
  ������ gsec.exe. �������������, ������ ������ ������������� ����������� ���� � gsec.exe   
  � ���-�����.

  ��� ������� ������ �� ���� � ����, ������� �������� � ������. � ������������� 
  ������������ ��� ����������� � ���� - ���������, ���� ����� TCP.

  �� �������� ����� ���� ������ � ������� ����� �������������� ������� S_RIGHTS. 
  ��������� � �� ����� ������ ��� �������, ��� �� �������.
     
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
  then MessageBox(0, '������� �������� avradmin.dll', '��������� ���', MB_OK or MB_ICONWARNING);  
end;

destructor TAvrAdminManager.Destroy;
begin
  if (FhLibraryHandle>0) then FreeLibrary(FhLibraryHandle);
  inherited;
end;

end.
