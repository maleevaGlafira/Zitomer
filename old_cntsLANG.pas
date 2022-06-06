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
  RightsAliases:TRightsAliases = ('������','������������� �������� �����',
    '������������� ��������','������������� ��������', '������������� �������',
    '������������� ������', '��������� ������������','�������� ������','������������������',
    '������������� ������ ���������(��� ����)');
  //  
  msgApply:TLangMSG = ('�������','��������');
  msgClose:TLangMSG = ('�������','�������');
  msgSave:TLangMSG = ('���������','��������');
  msgRefresh:TLangMSG = ('��������','��������');
  msgDelete:TLangMSG = ('�������','��������');
  msgAdd:TLangMSG = ('��������','������');
  msgInsert:TLangMSG = ('��������','��������');
  msgExit:TLangMSG = ('�����','�����');
  msgCancel:TLangMSG = ('������','���������');
  msgCancelRun:TLangMSG = ('��������','���������');
  msgPrint:TLangMSG = ('������','����');
  msgSearch:TLangMSG = ('�����','�����');
  msgClear:TLangMSG = ('��������','��������');
  msgSelect:TLangMSG = ('�������','�������');
  msgShow:TLangMSG = ('��������','��������');
  msgExec:TLangMSG = ('���������','��������');
  msgCheck:TLangMSG = ('���������','���������');
  msgLoad:TLangMSG = ('���������','�����������');
  msgOut:TLangMSG = ('����� � Excel','�����������');
  msgAlien:TLangMSG = ('�����','����');
  msgNewW:TLangMSG = ('�����','����');
  msgNewM:TLangMSG = ('�����','�����');
  msgCondition:TLangMSG = ('�������','�����');
  msgConditions:TLangMSG = ('�������','�����');
  msgSearchBody:TLangMSG = ('����� �� ���������','����� �� ����������');
  msgConfirm:TLangMSG = ('�������������','ϳ�����������');
  msgInform:TLangMSG = ('����������','����������');
  msgError:TLangMSG = ('������','�������');

  msgITOGO:TLangMSG = ('�����','�����');
  msgFrom:TLangMSG = ('�','�');
  msgREVS:TLangMSG = ('�����','�����');
  msgNaimPredpr:TLangMSG = ('����.���.','����.���.');
  msgCompany:TLangMSG = ('�����������','����������');
  msgForCompany:TLangMSG = ('�����������','����������');
  msgCount:TLangMSG = ('���-��','�������');
  msgCountBig:TLangMSG = ('����������','ʳ������');
  msgCrash:TLangMSG = ('�����������','�����������');
  msgCrashes:TLangMSG = ('�����������','�����������');
  msgCountCrash:TLangMSG = ('���-�� �����������','ʳ������ ����������');
  msgListCrash:TLangMSG = ('������ �����������','������ ����������');
  msgTypeCrash:TLangMSG = ('��� �����������','��� �����������');
  msgStreet:TLangMSG = ('�����','������');
  msgPlace:TLangMSG = ('���������','̳�������');
  msgSpotPlace:TLangMSG = ('�����','̳���');
  msgDmgPlace:TLangMSG = ('����� �����������','̳��� �����������');
  msgCrossRoad:TLangMSG = ('�����������','����������');
  msgAddr:TLangMSG = ('�����','������');
  msgNumDom:TLangMSG = ('����� ����','����� �������');
  msgNumDoms:TLangMSG = ('������ �����','������ �������');
  msgDom:TLangMSG = ('���','�������');
  msgDomShort:TLangMSG = ('�.','�.');
  msgCross:TLangMSG = ('����������� �','����������� �');
  msgYear:TLangMSG = ('���','г�');
  msgOnYear:TLangMSG = ('����','����');
  msgRange:TLangMSG = ('������','�����');
  msgAll:TLangMSG = ('���','��');
  msgAllCount:TLangMSG = ('�����','������');
  msgWithDigging:TLangMSG = ('� ���������','� ���������');
  msgWithoutDigging:TLangMSG = ('��� ��������','��� ��������');
  msgDiam:TLangMSG = ('�������','ĳ�����');
  msgDiamShort:TLangMSG = ('����.','ĳ��.');
  msgForDiam:TLangMSG = ('�� ���������','�� ��������');
  msgDiams:TLangMSG = ('���������','ĳ������');
  msgINCity:TLangMSG = ('�� ������','�� ����');
  msgZadvs:TLangMSG = ('��������','�������');
  msgCloseZadv:TLangMSG = ('���������� ��������','�������� �������');
  msgWhoClose:TLangMSG = ('��������','��������');
  msgWhoOpen:TLangMSG = ('������','³�����');
  msgDigWorks:TLangMSG = ('��������','��������');
  msgDigWorkOne:TLangMSG = ('��������','��������');
  msgPereCloseZadv:TLangMSG = ('���������','���������');
  msgDiggRaskop:TLangMSG = ('���������','���������');
  msgNoDiggRaskop:TLangMSG = ('��������'+#13+'�������','��������');
  msgDoDiggRaskop:TLangMSG = ('��������','��������');
  msgVidOpenZadv:TLangMSG = ('�������','³������');
  msgVidCloseZadv:TLangMSG = ('�������','�������');
  msgOpenWent:TLangMSG = ('������','³�����');
  msgCloseWent:TLangMSG = ('������','������');
  msgClosed:TLangMSG = ('��������','������');
  msgForClosed:TLangMSG = ('��������','��������');
  msgForNotClosed:TLangMSG = ('����������','����������');
  msgNotClosed:TLangMSG = ('����������','��������');
  msgAddrCloseZadv:TLangMSG = ('����� ���������� ��������','������ ��������� �������');
  msgAddrRaskop:TLangMSG = ('����� ��������','������ ��������');
  msgDopAddr:TLangMSG = ('�������������� �����','��������� ������');
  msgDopAddrShort:TLangMSG = ('���.�����','�����.������');
  msgDopInfo:TLangMSG = ('�������������� ����������','��������� ����������');
  msgDopInfoShort:TLangMSG = ('���.����������','�����.����������');
  msgDoOpenZadv:TLangMSG = ('�������'#13#10'��������','³������'#13#10'�������');
  msgDoAddZadvFromZajav:TLangMSG = ('�������� ���������� �������� �� �������� ������','������ ��������� ������� � ������� ������');
  msgDoAddRaskopFromZajav:TLangMSG = ('�������� ������������ �������� �� �������� ������','������ ���������� �������� � ������� ������');
  msgCloseZadvCount:TLangMSG = ('���������� �������� %d �� ��� �������� %d','���������� ������� %d � ��� �������� %d');
  msgCloseRaskopCount:TLangMSG = ('�������� %d �� ��� ������������ %d','�������� %d �� ��� ����������� %d');
  msgWentCountClose:TLangMSG = ('����� ������� %d �� ��� �������� %d','������ ����� %d � ��� �������� %d');

  msgUsers:TLangMSG = ('������������','�����������');
  msgUserOne:TLangMSG = ('������������','����������');
  msgNameUser:TLangMSG = ('��� ������������','��''� �����������');

  msgIdentUser:TLangMSG = ('������������� ������������ (����)','������������� ����������� (����)');
  msgRunIdentUser:TLangMSG = ('������������� ������������','������������� �����������');
  msgPasswdAdmin:TLangMSG = ('������ ��������������','������ ������������');
  msgUserGrant:TLangMSG = (' ����� ������������ ',' ������ �����������');
  msgRead:TLangMSG = ('������','�������');
  msgChangeDB:TLangMSG = ('��������� ������� ���','���� ������� ���');
  msgChangeSprav:TLangMSG = ('��������� ������������','���� ��������');
  msgAdminJob:TLangMSG = ('�����������������','�������������');
  msgAdmin:TLangMSG = ('�������������','�����������');

  msgCapMainForm:TLangMSG = ('��� ���������� ���','��� ��������� ���');
  msgMashineVxod:TLangMSG = ('������� ����� ���������� ���','������ ���� ��������� ���');
  msgKiev:TLangMSG = ('������������� ���������','���������');
  msgVedom:TLangMSG = ('���������','³������');
  msgVedomOne:TLangMSG = ('���������','³�������');
  msgNewZajav:TLangMSG = ('����� ������','���� ������');
  msgSelOfYearAndNum:TLangMSG = ('����� �� ������ � ����','���� �� ������ � ����');
  msgVedomost:TLangMSG = ('��������� �����','³������ �����');
  msgVedomostPovr:TLangMSG = ('��������� ����� �����������','³������ ����� ����������');
  msgVedNoCloseZajav:TLangMSG = ('��������� ����� ���������� ������ �� ������','³������ ����� ���������� ������');
  msgVedZajav:TLangMSG = ('��������� ����� ������','³������ ����� ������');
  msgVedLikvidirPovr:TLangMSG = ('��������� ����� ��������������� ����������� � ���������','³������ ����� ���������� ���������� � ���������');
  msgVedLikvidirPovrForRange:TLangMSG = ('��������� ���������� ����������� �� ������','³������ �������� ���������� �� �����');
  msgVedPovrChess:TLangMSG = ('��������� ����� ����������� ("��������")','³������ ����� ���������� ("��������")');
  msgVedUsedMat:TLangMSG = ('��������� ����� ��������������� ����������','³������ ����� ���������� ��������');
  msgVedUsedMatDiam:TLangMSG = ('��������� ����� ��������. ���������� �� ���������','³������ ����� ������. �������� �� ��������');
  msgVedUsedMatDiametram:TLangMSG = ('��������� ����� ��������������� ���������� �� ���������','³������ ����� ����������� �������� �� ��������');
  msgVedClosedZadv:TLangMSG = ('������ ���������� ��������','�������� ���������� �������');
  msgVedRaskop:TLangMSG = ('������ ��������','�������� ��������');
  msgVedUtech:TLangMSG = ('��������� ������','�������� ������');
  msgVedUtech_Vodopr:TLangMSG = ('��������� ������. ������������� � ������������� �� ��������','�������� ������');
  msgVedUtech_Other:TLangMSG = ('��������� ������. ������','�������� ������');
  msgVedUtech_Vodomer:TLangMSG = ('��������� ������. ���������� � ���������� �� ��������','�������� ������');
  msgVedUstran:TLangMSG = ('��������� ����������� ������','�������� ����������� ������');
  msgVedUstran_vod:TLangMSG = ('��������� ����������� ������(����� �����������)','�������� ����������� ������(���� �����������)');
  msgVedAbon:TLangMSG = ('��������� � ���������� �����','�������� � ���������� �����');
  msgVedKolvo:TLangMSG = ('���������� (�� ��������) ����������� ������ �� ������','���������� (�� ��������) ����������� ������ �� ������');
  msgDelZayav:TLangMSG = ('��������� ��������� ������','��������� ��������� ������');
  msgViborPoUl:TLangMSG = ('����� ���� ������ �� �����','����� ���� ������ �� �����');
  msgVedPostupAbon:TLangMSG = ('��������� ����������� ������ (���������� �����)','��������� ����������� ������ (���������� �����)');
  msgVedVipoln:TLangMSG = ('��������� ���������� ����������������� ����� (�� ���������)','�������� ���������� ����������������� ����� (�� ���������)');
  msgSvodkaLikvPovr:TLangMSG = ('������ ��������������� �����������','�������� ���������� ����������');
  msgSetupVedPovr:TLangMSG = ('��������� ��������� ����� �����������','������������ ������ ����� ����������');
  msgProizSearch:TLangMSG = ('������������ �����','�������� �����');
  msgUniverSpravka:TLangMSG = ('������������� �������','����������� ������');
  msgSravnitSpravka:TLangMSG = ('������������� �������','���������� ������');
  msgNewUser:TLangMSG = ('����� ������������','����� ����������');
  msgVersion:TLangMSG = ('������','�����');
  msgAnaliz:TLangMSG = ('������','�����');
  msgVedAnalizPovr:TLangMSG = ('��������� ������� �����������','³������ ������ ����������');
  msgAnalizPovr:TLangMSG = ('������ �����������','����� ����������');
  msgAnalizPovrUlic:TLangMSG = ('������ ����������� �� �����','����� ���������� �� ������');
  msgSpravoch:TLangMSG = ('�����������','��������');
  msgSpravochOne:TLangMSG = ('����������','�������');
  msgDolzLic:TLangMSG = ('����������� ���','��������� ����');
  msgResponse:TLangMSG = ('���������','������');
  msgRAYONS:TLangMSG = ('���������������� �������','�������������� ������');
  msgREMONT:TLangMSG = ('���������� �������','��������� �������');
  msgREGIONone:TLangMSG = ('������','������');
  msgRAYONone:TLangMSG = ('���������������� �����','�������������� �����');
  msgRAYON:TLangMSG = ('�����','�����');
  msgREV:TLangMSG =  ('���','���');
  msgNameStreets:TLangMSG = ('������������ ����','���� ������');
  msgTypeStreets:TLangMSG = ('����� ����','���� ������');
  msgWorks:TLangMSG = ('�����','����');
  msgWorkOne:TLangMSG = ('������','������');
  msgWorkMany:TLangMSG = ('������','������');
  msgMaters:TLangMSG = ('����������','��������');
  msgMaterOne:TLangMSG = ('��������','�������');
  msgMaterMany:TLangMSG = ('���������','��������');
  msgMechan:TLangMSG = ('���������','��������');
  msgPlanmechan: TLangMSG = ('����������� ���������','��������, �� ����������');
  msgDoWorks:TLangMSG = ('����������� ������','���������� ������');
  msgDoWorkOne:TLangMSG = ('����������� ������','���������� ������');
  msgMestnostPovr:TLangMSG = ('��������� �����������','̳��������� ����������');
  msgMestPovr:TLangMSG = ('���� �����������','̳��� ����������');
  msgZajavitels:TLangMSG = ('����������','��������');
  msgDopAdresov:TLangMSG = ('�������������� �������', '���������� �����');
  msgDopAdres:TLangMSG = ('�������������� �����', '��������� ������');
  msgZajavitelOne:TLangMSG = ('���������','�������');
  msgSoderzZajav:TLangMSG = ('�������� �����������','����� ������');
  msgMechaniz:TLangMSG = ('����������','��������');
  msgPlanMechaniz:TLangMSG = ('���������� ����������','���������� ��������');
  msgPovrezd:TLangMSG = ('����� �����������','����������');
  msgTypeZajav:TLangMSG = ('����� ������','���� ������');
  msgTypesColSHACH:TLangMSG = ('����� ������� ��������','���� ��������� "��������"');
  msgService:TLangMSG = ('������','�����');
  msgContext:TLangMSG = ('����������','����');
  msgHistoryChanges:TLangMSG = ('������� ���������','������ ���');
  msgNastrojka:TLangMSG = ('���������','������������');
  msgAddMap:TLangMSG = ('���������� �����','ϳ�������� �����');
  msgDelMap:TLangMSG = ('��������� �����','³�������� �����');
  msgClock:TLangMSG = ('����','��������');
  msgAutoVVod:TLangMSG = ('��������','������������');
  msgOpenOtherName:TLangMSG = ('����� ��� ������ ������','����� �� ����� ��''��');
  msgExitProg:TLangMSG = ('����� �� ���������','����� � ��������');
  msgErrorServer:TLangMSG = ('������ ����������� � ������� !','������� ���������� � ������� !');
  msgErrorCountry:TLangMSG = ('����������� ����������� ������: ','��������� ����������� �����: ');
  msgSelPredvZajav:TLangMSG = ('����� ��������������� ������','���� ��������������� ������');
  msgDelZajav:TLangMSG = ('����� ������ �� ��������','���� ������ �� ��������');
  msgSelNoCloseZajav:TLangMSG = ('����� ���������� ������','���� ��������� ������');
  msgSelCloseZajav:TLangMSG = ('����� �������� ������','���� ������� ������');
  msgSelCloseZadv:TLangMSG = ('����� �������� ��������','���� ������� �������');
  msgDigger:TLangMSG = ('��������','��������');
  msgDataEndLTBegin:TLangMSG = ('���� ��������� ������ ���� ������!','���� ��������� ����� ���� �������!');
  msgDataBeginWentLTOpen:TLangMSG = ('���� ������ ������ ������ ���� �������� ������ !','���� ������� ����� ����� ���� �������� ������');
  msgDataTimeGRTemp:TLangMSG = ('����/����� ������ �������!','����/��� ����� �������!');
  msgDataTimeLTin:TLangMSG = ('����/����� ������ ���� ��������!','����/��� ������ ���� ��������!');
  msgNoDateTime:TLangMSG = ('�� ���������� ���� � (���) ����� !','����������� ���� � (���) ���');
  msgDateRegister:TLangMSG = ('���� �����������','���� ���������');
  msgDateArrive:TLangMSG = ('���� �����������','���� �����������');
  msgDateClose:TLangMSG = ('���� ��������','���� ��������');
  msgDateOpen:TLangMSG = ('���� ��������','���� ��������');
  msgDateOpenShort:TLangMSG = ('���� ���.','���� ���.');
  msgDateRaskopShort:TLangMSG = ('���� ���.','���� ���.');
  msgPasswdAdminNoDefine:TLangMSG = ('������ �������������� �� ��������� !','������ ������������ �� �������� !');
  msgPasswdNoDefineOrConfirm:TLangMSG = ('������ �� ��������� ��� �� ����������� !','������ �� �������� ��� �� ����������');
  msgHideShow:TLangMSG = ('���������/�����������','��������/����������');
  msgAutoRefresh:TLangMSG = ('�������������� ���������� �����������'#13#10'(����� �������� ���������)','����������� ���������� ��������'#13#10'(���� �������� ���)');
  msgDBNavigatorHints:TLangMSG = ('"������ ������","���������� ������","��������� ������","��������� ������","�������� ������","������� ������","������������� ������","��������� (F2)","������","��������"',
                                  '"������ �����","��������� �����","��������� �����","������� �����","�������� �����","�������� �����","���������� �����","�������� (F2)","����������","³�������"');
  msgSearchOfField:TLangMSG = ('����� �� ���� ','����� �� ����');
  msgDeleteRecord:TLangMSG = ('������� ������?','�������� �����?');
  msgSaveChanges:TLangMSG = ('��������� ��������� ���������?','�������� ������� ����?');
  msgDeleteMore:TLangMSG = ('�� ������ ������� ����� ��������� �������','�� ������� �������� ������ ������� ������');
  msgExistError:TLangMSG = (' ��� ����������. ���������� ������ ������ �������� ��� ������ ������ "������".',' ��� ����. ��������� ������ ���� �������� ��� ��������� ������ "���������"');
  msgExitWithSaveREC:TLangMSG = ('����� ��� ���������� ����� ������?','����� ��� ���������� ������ ������?');
  msgExitWithSave:TLangMSG = ('����� ��� ���������� ���������?','����� ��� ���������� ���?');
  msgChangeNoSave:TLangMSG = ('��������� �� ���������!','���� �� ��������!');
  msgNoChange:TLangMSG = ('��� ���������','���� ���');
  msgFilter:TLangMSG = ('������','Գ����');
  msgSizeFont:TLangMSG = ('������ ������','����� ������');
  msgLoadResult:TLangMSG = ('�������� ���������� ...','�������������� ���������� ...');
  msgColumns:TLangMSG = ('�������','��������');
  msgUseFilterDate:TLangMSG = ('��������� ������ �� ����','����������� ������ �� ���');
  msgOldValue:TLangMSG = ('������ ��������','����� ��������');
  msgNewValue:TLangMSG = ('����� ��������','���� ��������');
  msgCoder:TLangMSG = ('���������','���������');
  msgPrintText:TLangMSG = ('������ ���������','���� ���������');
  msgCountSymPage:TLangMSG = ('�-�� �������� �� �����','ʳ�. ������� �� ������');
  msgCountLinePage:TLangMSG = ('�-�� ����� �� �����','ʳ�. ����� �� ������');
  msgON:TLangMSG = ('��������','��������');
  msgOFF:TLangMSG = ('���������','���������');
  msgCondensedFont:TLangMSG = ('������ �����','������� �����');
  msgPage:TLangMSG = ('����','�����');
  msgOnPage:TLangMSG = ('�� ������','�� �������');
  msgPart:TLangMSG = ('�����','�������');
  msgSortField:TLangMSG = ('���������� �� ����','���������� �� ����');
  msgFound:TLangMSG = ('������� %d �������. ��������?','�������� %d ������. ��������?');
  msgNotFound:TLangMSG = ('�������,��������������� ������� �� ������� !','������, �������������� ���� �� �������� !');
  msgCreate:TLangMSG = ('�������','��������');
  msgWent:TLangMSG = ('������','�����');
  msgWentOne:TLangMSG = ('�����','����');
  msgWentNotClose:TLangMSG = ('����� �� ������ !','���� �� ��������');
  msgJobsAndMat:TLangMSG = ('������/���������','������/��������');
  msgConfirmDelWent:TLangMSG = ('  ������ � ������� ����� ������� ���������, ������������, ������ � ��������, ��������������� ������� ������.'#13'  ������� �����?',
                                '  ����� � ������ ������ ������� ��������, ������������ � ������, ������� �� ������ �����.'#13'  �������� ����?');
  msgCommon:TLangMSG = ('�����','�����');
  msgSaveMainForm:TLangMSG = ('��������� ������������ ������� �����','�������� ������������ ������� �����');
  msgLang:TLangMSG = ('����','����');
  msgLangUA:TLangMSG = ('����������','���������');
  msgLangRU:TLangMSG = ('�������','��������');
  msgColor:TLangMSG = ('�����','�������');
  msgThis:TLangMSG = ('���','��');
  msgThisMsg:TLangMSG = ('���������','�����������');
  msgThisBoldMsg:TLangMSG = ('���������� ���������','������� �����������');
  msgThisMsgError:TLangMSG = ('��������� �� ������','����������� ��� �������');
  msgDefault:TLangMSG = ('�� ���������','�� ���������');
  msgFieldEdit:TLangMSG = ('���� �����','���� ��������');
  msgChoose:TLangMSG = ('�����','����');
  msgQuickAdd:TLangMSG = ('������� ����������','������ ���������');
  msgEquip:TLangMSG = ('������������','������������');
  msgEquipJobMat:TLangMSG = ('������������, ������, ���������','������������, ������, ��������');
  msgDemandDiam:TLangMSG = ('������� ����� ��������.','������� �������� �������.');
  msgSomeSel:TLangMSG = ('������������ �����','�������� ����');
  msgShowResult:TLangMSG = ('�������� ����������','�������� ����������');
  msgLines:TLangMSG = ('�����','�����');
  msgCols:TLangMSG = ('��������','��������');
  msgNotShowNullRow:TLangMSG = ('�� ���������� ������� ������','�� ���������� ������ �����');
  msgPercentForAmount:TLangMSG = ('% �� ���.���.','% �� ���.�������');
  msgErrorExecQuery:TLangMSG = ('������ ���������� �������.','������� ��������� ������.');
  msgDataForRangeNotExist:TLangMSG = ('�� ��������� ������ ������ �����������.','�� ����������� ����� ��� ������.');
  msgNotConsistOfDiam:TLangMSG = ('�� �������� ��������','�� ������ �������');
  msgChooseAll:TLangMSG = ('�������� ���','������� ���');
  msgClearAll:TLangMSG = ('�������� ���','�������� ���');
  msgAllMaters:TLangMSG = ('��� ���������','�� ��������');
  msgExReport:TLangMSG = ('����������� �����','���������� ���');
  msgUsePipeFor:TLangMSG = ('������������� ���� �� ','��������� ���� �� ');
  msgShortening:TLangMSG = ('����������','����������');
  msgGroupBy:TLangMSG = ('�����������','����������');
  msgTitle:TLangMSG = ('��������','�����');
  msgDesign:TLangMSG = ('������������','������������');
  msgFIO:TLangMSG = ('���','�������');
  msgSurname:TLangMSG = ('�������','�������');
  msgAccup:TLangMSG = ('���������','������');
  msgODDSIZE:TLangMSG = ('��. ���.','��. ���.'); {������� �����}
  msgCategory:TLangMSG = ('���������','��������');
  msgFilterCategory:TLangMSG = ('������ �� ���������� (Del ��� BackSpace - ������� ������)',
                                'Գ���� �� ��������� (Del ��� BackSpace - ������� �������)');
  msgNotice:TLangMSG = ('����������','�������');
  msgTime:TLangMSG = ('�����','���');
  msgDTClosed:TLangMSG = ('��������','��������');
  msgDTRegister:TLangMSG = ('�����������','���������');
  msgInfoAboutCrash:TLangMSG = ('���������� � �����������','���������� � ����������');
  msgQuery:TLangMSG = ('������','�����');
  msgDebug:TLangMSG = ('�������','������������');
  msgForms:TLangMSG = ('�����','�����');
  msgQueryExec:TLangMSG = (' SQL ������ ��������',' SQL ����� ��������');
  msgChoseRep:TLangMSG = (' ����� ������ ',' ���� ���� ');
  msgOnlyNotOpened:TLangMSG = ('������ ����������','����� ��������');
  msgOnlyNotDig:TLangMSG = ('������ ������������','����� ����������');
  msgOutput:TLangMSG = ('����� �','���� �� ');
  msgForRangeFrom:TLangMSG = ('�� ������ �','�� ����� �');
  msgAndSpill:TLangMSG = ('� �.�. ���������','� �.�. �������');
  msgAndLeak:TLangMSG = ('� �.�.����.����','� �.�. �����');
  msgAndMend:TLangMSG = ('� �.�. �������','� �.�. �������');
  msgAndRepair:TLangMSG = ('� �.�.����.�������','� �.�. �������');
  msgAndOther:TLangMSG = ('� �.�.����.������','� �.�. ����');
  msgAndNoSpill:TLangMSG = ('��������������. ���������','���������� �.�. �������');
  msgAndNoLeak:TLangMSG = ('������.����','�����. �.�. ����');
  msgAndNoMend:TLangMSG = ('��������������. �������','���������� �������');
  msgAndNoRepair:TLangMSG = ('������.�������','�����. �������');
  msgAndNoOther:TLangMSG = ('������.������','���������� ����');
  msgTempClosed:TLangMSG = ('���������� �� ������� ������','���������� �� ��������� ������');
  msgTempNotDig:TLangMSG = ('������������ �� ������� ������','����������� �� ��������� ������');
  msgShowOnMap:TLangMSG = ('�������� ������ �� �����','�������� ������ �� ����');
  msgTieOnMap:TLangMSG = ('��������� ������ � �����','����''����� ������ �� �����');
  msgWrongPasswd:TLangMSG = ('������������ ��� ������������ ��� ������ !','����������� ��''� ����������� ��� ������ !');
  msgClientServer:TLangMSG = ('������/������','�볺��/������');
  msgLoadProgram:TLangMSG = ('�������� ���������','������������ ��������');
  msgSaveChangedInfo:TLangMSG = ('��������� ���������� ����������','�������� ������ ����������');
  msgCloseWindow:TLangMSG = ('������� ����','������� ����');
  msgCopyZajav:TLangMSG = ('���������� ������� ������ � �����','�������� ������� ������ �� ����');
  msgNoNomDom:TLangMSG = ('�� �������� ����� ���� !','�� �������� ����� ������� !');
  msgSaveNewZajav:TLangMSG = ('��������� ����� ������ ?','�������� ���� ������ ?');
  msgSameZajav:TLangMSG = (' ���������� ������ ����� ������� �����. ��������?',
                           ' ���������� ������ ����� ����� ������. ��������?');
  msgSameZajavList:TLangMSG = ('���������� ������ � ������� ������� � ','�������� ������ � ������� �������� ��');
  msgZajavSetNom:TLangMSG = ('������ �������� ����� ','������ ��������� ����� ');
  msgZajavIDNotFound:TLangMSG = ('������ � ID=%d �� �������!','������ � ID=%d �� ��������!');
  msgZajavWithOpenZadv:TLangMSG = ('� ������ ������������ ���������� ��������! ������� ������?',
                                   '� ������ ������� �������� �������! ������� ������?');
  msgZajavWithOpenRaskop:TLangMSG = ('� ������ ������������ ������������ ��������! ������� ������?',
                                     '� ������ ������� ��������� ��������! ������� ������?');
  msgZajavWithoutDiam:TLangMSG = ('�� ��������� �������! ������� ������?',
                                  '�� �������� Ĳ�����! ������� ������?');
  msgCloseZajav:TLangMSG = ('������� ������ ?','������� ������ ?');
  msgZajavWithoutCloseWent:TLangMSG = ('� ������ ��� �������� �������! ','� ������ ���� �������� �����! ');
  msgZajavWithoutWent:TLangMSG = ('� ������ ��� ������� !','� ������ ���� ����� !');
  msgZajavWentDel:TLangMSG = ('� ������ ��� ���� ������! ������� ��. ','� ������ ��� ������� �����! �������� ��. ');
  msgClosing:TLangMSG = ('��������','��������');
  msgSending:TLangMSG = ('�����������','�����������');
  msgBegin:TLangMSG = ('������','�������');
  msgEnd:TLangMSG = ('�����','ʳ����');
  msgTellWent:TLangMSG = ('�������� ������','���� �ȯ���');
  msgWhoDoJob:TLangMSG = ('�������� ������','���������� ������');
  msgNewYear:TLangMSG = (' ��������� ��� !'#13#10'��������� ������ � ������� 1 �� %d ��� ?'#13#10'���� ������ � %d ����� ����� ��� ���������� !',
                         ' ������� �� !'#13#10'�������� ������ � ������� 1 �� %d �� ?'#13#10'�������� ������ � %d ����� ���� ��� ��������� !');
  msgConfirmNewYear:TLangMSG = (' �� ������� ?'#13#10'���� ������ � %d ����� ����� ��� ���������� !',
                                ' �� ������� ?'#13#10'�������� ������ � %d ����� ���� ��� ��������� !');
  msgPrintAllWorks:TLangMSG = ('�������� ��� ������ ������','��������� �� ������ ������');
  msgNotPrintKoll:TLangMSG = ('�� ��������� ����������� �� ����������� (��� �����������)','�� ����������� ����������� �� ����������');
  msgPrintKoll:TLangMSG = ('������ ����������� �� �����������','ҳ���� ����������� �� ����������');
  msgPrintNotKoll:TLangMSG = ('���, ����� ����������� �� �����������','��, ��� ���������� �� ����������');
  msgDictAll:TLangMSG = ('������ ���������','����� ��������');
  msgDictShow:TLangMSG = ('������ �������','ҳ���� ����');
  msgDictHide:TLangMSG = ('������ ���������','ҳ���� ������');
  msgTypeLeak:TLangMSG = ('����� ����','���� ����');
  msgTypeClog:TLangMSG = ('����� ������','���� ���������');
  msgTypeFill:TLangMSG = ('����� �������','���� ���������');
  msgTypeNet:TLangMSG = ('����� ����','���� �����');
  msgTypeKillClog:TLangMSG = ('����� ���������� ������','���� �������� ���������');
  msgTypeLocal:TLangMSG = ('��� ����������� ������','������ ���������� �����');
  msgTypePump:TLangMSG = ('������� �������','������ �������');
  msgTypePES:TLangMSG = ('������������� ���','������������ ���');
  msgTypeOwner:TLangMSG = ('�������������� ������','������������ ������');

  msgTypeNetOne:TLangMSG = ('����','������');
  msgTypeLeakOne:TLangMSG = ('���������','���������');
  msgTypeClogOne:TLangMSG = ('��� ������','��� ���������');
  msgTypeFillOne:TLangMSG = ('��� �������'#10#13'�������','��� ���������'#10#13'��������');
//  msgMineZav:TLangMSG = ('����','����');
//  msgTheirZav:TLangMSG = ('�����','����');
//  msgTheirMineZav:TLangMSG = ('�����, ������ ����','����, ������ ���');
//  msgFalseZav:TLangMSG = ('������','���������');
  msgNUMBERT:TLangMSG = ('�����'#13'�������','�����'#13'�������');
  msgNUMTEAM:TLangMSG = ('���-��'#13'�������','ʳ�-��'#13'�����');
  msgTypeLocalMany:TLangMSG = ('���� �����������'#13'������','������ ����������'#13'����');
  msgKillClog:TLangMSG = ('���������� ������','˳������� ���������');
  msgPump:TLangMSG = ('����� �������','����� �������');
  msgPES:TLangMSG = ('���','���');
  msgTypePESOne:TLangMSG = ('������������� ���','������������ ���');
  msgPlaceSHIT:TLangMSG = ('����� �������� �������','̳��� �������� ������');
  msgPlaceSAN:TLangMSG = ('���������� �����������','������� ������');
  msgPRN:TLangMSG = ('�������(�������� ������� ���)','������(������� ��''� � �������� �����)');
  msgConfirmQuestion:TLangMSG = ('�� ������� ?','�� ������� ?');
  msgPrintMoreLater:TLangMSG=('������� �����. ���������� ������ �������','������ ��������. ��������� ���� ����� ');
  msgBury:TLangMSG=('������������','���������');
  msgAsphalt:TLangMSG=('�������������������','��������������');

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
