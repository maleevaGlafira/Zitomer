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
    '������������� ��������','������������� ��������', '������������� ������',
    '������������� ������', '��������� ������������','�������� �������','������������������',
    '������������� ������ ���������(��� ����)');
  //
  msgYes:TLangMSG = ('��','���');
  msgNo:TLangMSG = ('���','ͳ');
  msgApply:TLangMSG = ('�������','��������');
  msgClose:TLangMSG = ('�������','�������');
  msgSave:TLangMSG = ('���������','��������');
  msgRefresh:TLangMSG = ('��������','��������');
  msgDelete:TLangMSG = ('�������','��������');
  msgAdd:TLangMSG = ('��������','������');
  msgInsert:TLangMSG = ('��������','��������');
  msgEdit:TLangMSG = ('�������������','����������');
  msgExit:TLangMSG = ('�����','�����');
  msgCancel:TLangMSG = ('������','���������');
  msgCopy:TLangMSG = ('����������','��������');
  msgCancelRun:TLangMSG = ('��������','���������');
  msgPrint:TLangMSG = ('������','����');
  msgSearch:TLangMSG = ('�����','�����');
  msgClear:TLangMSG = ('��������','��������');
  msgSelect:TLangMSG = ('�������','�������');
  msgShow:TLangMSG = ('��������','��������');
  msgExec:TLangMSG = ('���������','��������');
  msgCheck:TLangMSG = ('���������','���������');
  msgLoad:TLangMSG = ('���������','�����������');
  msgDoSelect:TLangMSG = ('��������','������');
  msgOut:TLangMSG = ('����� � Excel','�����������');
  msgParams:TLangMSG = ('���������','���������');
  msgAlien:TLangMSG = ('�����','����');
  msgForm:TLangMSG = ('�����','�����');
  msgNewW:TLangMSG = ('�����','����');
  msgNewM:TLangMSG = ('�����','�����');
  msgCondition:TLangMSG = ('�������','�����');
  msgConditions:TLangMSG = ('�������','�����');
  msgSearchBody:TLangMSG = ('����� �� ���������','����� �� ����������');
  msgConfirm:TLangMSG = ('�������������','ϳ�����������');
  msgInform:TLangMSG = ('����������','����������');
  msgError:TLangMSG = ('������','�������');
  msgVodoprovod:TLangMSG = ('����������','���������');
  msgKANANAL:TLangMSG = ('�����������','�������������');
  msgObjVdod:TLangMSG = ('������� �����������','��''���� �����������');
  msgObjKanal:TLangMSG = ('������� �����������','��''���� ���������');
  msgITOGO:TLangMSG = ('�����','�����');
  msgFrom:TLangMSG = ('�','�');
  msgOrdersNumber:TLangMSG = ('����� ������','����� ������');
  msgOrders:TLangMSG = ('������','������');
  msgREVS:TLangMSG = ('��������','ĳ�����');
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
  msgPlaceShort:TLangMSG = ('�����.','̳��.');

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
  msgMonth:TLangMSG = ('�����','̳����');
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
  msgVidOpenZadv:TLangMSG = ('��������','³�������');
  msgVidCloseZadv:TLangMSG = ('�������','�������');
  msgOpenWent:TLangMSG = ('������','³�����');
  msgCloseWent:TLangMSG = ('������','������');
  msgClosed:TLangMSG = ('��������','������');
  msgForClosed:TLangMSG = ('��������','��������');
  msgForNotClosed:TLangMSG = ('����������','����������');
  msgNotClosed:TLangMSG = ('����������','��������');
  msgAddrCloseZadv:TLangMSG = ('����� ���������� ��������','������ ��������� �������');
  msgAddrRaskop:TLangMSG = ('����� ��������','������ ��������');
  msgDopAddr:TLangMSG = ('�������������� �����$','��������� ������');
  msgDopAddrShort:TLangMSG = ('���. �����','�����. ������');
  msgDopInfo:TLangMSG = ('�������������� ����������','��������� ����������');

  msgDopInfoShort:TLangMSG = ('���.����������','�����.����������');
  msgDopInfoDoWork:TLangMSG = ('���.���������� ����������� �����','��������� ���������� ��������� ����');
  msgDopInfoPlanWork:TLangMSG = ('���.���������� ��������������� �����','��������� ���������� ������������ ����');

  msgDoOpenZadv:TLangMSG = ('�������'#13#10'��������','³������'#13#10'�������');
  msgDoAddZadvFromZajav:TLangMSG = ('�������� ���������� �������� �� ��������� ������','������ ��������� ������� � ��������� ������');
  msgDoAddRaskopFromZajav:TLangMSG = ('�������� ������������ �������� �� ��������� ������','������ ���������� �������� � ��������� ������');
  msgCloseZadvCount:TLangMSG = ('���������� �������� %d �� ��� �������� %d','���������� ������� %d � ��� �������� %d');
  msgCloseRaskopCount:TLangMSG = ('�������� %d �� ��� ������������ %d','�������� %d �� ��� ����������� %d');
  msgWentCountClose:TLangMSG = ('����� ������ %d �� ��� �������� %d','������ ����� %d � ��� �������� %d');

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
  msgKiev:TLangMSG = ('"����������������"',' "����������������"');
  msgVedom:TLangMSG = ('���������','³������');
  msgVedomOne:TLangMSG = ('���������','³�������');
  msgNewZajav:TLangMSG = ('����� �����','����� �����');
  msgSelOfYearAndNum:TLangMSG = ('����� �� ������ � ����','���� �� ������� � �����');
  msgVedomost:TLangMSG = ('��������� �����','³������ �����');
  msgVedomostPovr:TLangMSG = ('��������� ����� �����������','³������ ����� ����������');
  msgVedNoCloseZajav:TLangMSG = ('��������� ����� ���������� ������� �� ������','³������ ����� ���������� ������');
  msgVedZajav:TLangMSG = ('��������� ����� �������','³������ ����� ������');
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
  msgVedUstran:TLangMSG = ('��������� ����������� �������','�������� ����������� ������');
  msgVedUstran_vod:TLangMSG = ('��������� ����������� ������(����� �����������)','�������� ����������� ������(���� �����������)');
  msgVedAbon:TLangMSG = ('��������� � ���������� �����','�������� � ���������� �����');
  msgVedKolvo:TLangMSG = ('���������� (�� ��������) ����������� ������ �� ������','���������� (�� ��������) ����������� ������ �� ������');
  msgDelZayav:TLangMSG = ('��������� ��������� �������','��������� ��������� ������');
  msgViborPoUl:TLangMSG = ('����� ���� ������� �� �����','����� ���� ������ �� �����');
  msgVedPostupAbon:TLangMSG = ('��������� ����������� ������� (���������� �����)','��������� ����������� ������ (���������� �����)');
  msgVedVipoln:TLangMSG = ('��������� ���������� ����������������� ����� (�� ���������)','�������� ���������� ����������������� ����� (�� ���������)');
  msgSvodkaLikvPovr:TLangMSG = ('������ ��������������� �����������','�������� ���������� ����������');
  msgVedDamageKv:TLangMSG = ('��������� ������� ����������� �� �������','³������ ������ ��������� �� �������');
  msgAnalLeak:TLangMSG =('������ ������','����� ������');
  msgDaylyLogTitle:TLangMSG =('�������� ������','������� ������');
  msgSetupVedPovr:TLangMSG = ('��������� ��������� ����� �����������','������������ ������ ����� ����������');
  msgProizSearch:TLangMSG = ('������������ �����','�������� �����');
  msgUniverSpravka:TLangMSG = ('������������� �������','����������� ������');
  msgSravnitSpravka:TLangMSG = ('������������� �������','���������� ������');
  msgSConsolidStateTitle:TLangMSG = ('������� ���������','������� ²��̲���');
  msgStateLeaksTitle:TLangMSG = ('������ ������ �� ������','��� ������ �� �����');
  msgStateAddMoreCountTitle:TLangMSG = ('����� ������� ������ ������������� ���-��',
                                          '����� ����� �����  ����� �������');

  msgNewUser:TLangMSG = ('����� ������������','����� ����������');
  msgVersion:TLangMSG = ('������','�����');
  msgAnaliz:TLangMSG = ('������','�����');
  msgVedAnalizPovr:TLangMSG = ('��������� ������� �����������','³������ ������ ����������');
  msgAnalizPovr:TLangMSG = ('������ �����������','����� ����������');
  msgAnalizPovrUlic:TLangMSG = ('������ ����������� �� �����','����� ���������� �� ������');
  msgAnalisWorkEquip: TLangMSG = ('������ ������ ����������','����� ������ �������');
  msgSpravoch:TLangMSG = ('�����������','��������');
  msgSpravochOne:TLangMSG = ('����������','�������');
  msgDolzLic:TLangMSG = ('����������� ���','��������� ����');
  msgResponse:TLangMSG = ('���������','������');
  msgRAYONS:TLangMSG = ('���������������� �������','̳��/�����');
  msgREMONT:TLangMSG = ('���������� �������','��������� �������');
  msgREGIONone:TLangMSG = ('������','�����');
  msgRAYONone:TLangMSG = ('���������������� �����','�������������� �����');
  msgRAYON:TLangMSG = ('�����/���.','̳���/������');
  msgREV:TLangMSG =  ('�������','ĳ�����');
  msgSetlers:TLangMSG =  ('�������','������');
  msgNameStreets:TLangMSG = ('������������ ����','���� ������');
  msgTypeStreets:TLangMSG = ('����� ����','���� ������');
  msgWorks:TLangMSG = ('�����','����');
  msgWorkOne:TLangMSG = ('������','������');
  msgWorkMany:TLangMSG = ('������','������');
  msgMaters:TLangMSG = ('����������','��������');
  msgMaterOne:TLangMSG = ('��������','�������');
  msgMaterMany:TLangMSG = ('���������','��������');
  msgMechan:TLangMSG = ('���������','��������');
  msgObjectOne:TLangMSG = ('������','��''���');
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
  msgPlanMechaniz:TLangMSG = ('���������� ����������','������������ ��������');
  msgPovrezd:TLangMSG = ('����� �����������','���� ����������');
  msgTypeZajav:TLangMSG = ('����� �������','���� ������');
  msgTypesColSHACH:TLangMSG = ('����� ������� ��������','���� ��������� "��������"');
  msgMaterTrubOne:TLangMSG =('�������� �����','������� �����');
  msgMaterTrub:TLangMSG =('���������� ����','�������� ����');
  msgVRK:TLangMSG =('���','���');
  msgAddMustBlagWork:TLangMSG =('������������ ����� �� ���������������','����''������� ���� � �����������');
  msgTrudozatrat:TLangMSG =('�����������','�����������');
  msgBWork:TLangMSG =('������� �����','�������� ����');
  msgInstruments:TLangMSG =('������������','�����������');
  msgObjects:TLangMSG =('��������','��''����');
  msgEquipObjects:TLangMSG =('������������ ��������','���������� ��''����');
  msgFances:TLangMSG =('����������','������');
  msgCommonTypEquip:TLangMSG =('���������� ����� ������������','������������ ���� ����������');
  msgCommonTypEquipOne:TLangMSG =('���������� ��� ������������','������������ ��� ����������');
  msgCommonTypEquipShort:TLangMSG =('�����. ���','�������. ���');
  msgTypEquip:TLangMSG =('����� ������������','���� ����������');
  msgConstructions:TLangMSG =('����������','������');
  msgService:TLangMSG = ('������','�����');
  msgContext:TLangMSG = ('����������','����');
  msgHistoryChanges:TLangMSG = ('������� ���������','������ ���');
  msgNastrojka:TLangMSG = ('���������','������������');
  msgAddMap:TLangMSG = ('���������� �����','ϳ�������� �����');
  msgDelMap:TLangMSG = ('��������� �����','³�������� �����');
  msgArhiv:TLangMSG = ('�������������', '����������');
  msqRestore:TLangMSG = ('��������������','�������������');
  msgClock:TLangMSG = ('����','��������');
  msgSysClock:TLangMSG = ('��������� �����','�������� ���');
  msgAutoVVod:TLangMSG = ('��������','������������');
  msgOpenOtherName:TLangMSG = ('����� ��� ������ ������','����� �� ����� ��''��');
  msgExitProg:TLangMSG = ('����� �� ���������','����� � ��������');
  msqWindows:TLangMSG = ('����','³���');
  msgOrderNaVi:TLangMSG = ('����� �� ��������� ������' ,'����� �� �������� ������');
  msgDeletingOrder:TLangMSG = ('������ �� ��������' ,'����� �� ��������');
  msqInpuSmen:TLangMSG = ('���� ������ �����','�������� ������ ����');
  msgErrorServer:TLangMSG = ('������ ����������� � ������� !','������� ���������� � ������� !');
  msgErrorCountry:TLangMSG = ('����������� ����������� ������: ','��������� ����������� �����: ');
  msgSelPredvZajav:TLangMSG = ('����� ���������������� ������','���� ������������ ������');
  msgDelZajav:TLangMSG = ('����� ������ �� ��������','���� ������ �� ���������');
  msgSelNoCloseZajav:TLangMSG = ('����� ����������� ������','���� ����������� ������');
  msgSelCloseZajav:TLangMSG = ('����� ��������� ������','���� ��������� ������');
  msgSelCloseZadv:TLangMSG = ('����� �������� ��������','���� ������� �������');
  msgDigger:TLangMSG = ('��������','��������');
  msgDataEndLTBegin:TLangMSG = ('���� ���������/������ ������ ���� ������/�����!','���� ��������� ����� ���� �������!');
  msgDataBeginWentLTOpen:TLangMSG = ('���� ������ ����� ������ ���� �������� ������ !','���� ������� ����� ����� ���� �������� ������');
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
  msgWent:TLangMSG = ('�����','�����');
  msgWentOne:TLangMSG = ('����','����');
  msgPlanTime:TLangMSG = ('����������� �����', '������������ ���');
  msgWentNotClose:TLangMSG = ('���� �� ������ !','���� �� ��������');
  msgJobsAndMat:TLangMSG = ('������/���������','������/��������');
  msjPlanJobs:TLangMSG =('��������������� ������','���������� ������');

  msgConfirmDelWent:TLangMSG = ('  ������ � ������ ����� ������� ���������, ������������, ������ � ��������, ��������������� ������� �����.'#13'  ������� ����?',
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
  msgErrorExec:TLangMSG = ('������ ���������� ','������� ��������� ');
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
  msgAbout:TLangMSG = ('� ��� ��������','��� �� ��������');
  msgOrdertype:TLangMSG = ('��� ������','��� ������');
  msgCbIsControl:TLangMSG = ('�� ��������','�� �������');
  msgPrinad:TLangMSG = ('��������������', '���������');
  msgOtl:TLangMSG=('�������','����������� ');
  msgGetFrom:TLangMSG =('��������','��������');
  msgGetFromDisp:TLangMSG =('�������� �����������','�������� �����������');
  msgConfirmPerson:TLangMSG =('����','����');
  msgConfirmBrig:TLangMSG =('���� �������','���� �������');
  msgOrdertyptype:TLangMSG= ('��� ������', '��� ������');
  msgTrubi:TLangMSG= ('�����','�����');  // ����?
  msgCordinates:TLangMSG= ('����������','����������');
  msgFIO:TLangMSG = ('���','Բ�');
  msgSurname:TLangMSG = ('�������','�������');
  msgAccup:TLangMSG = ('���������','������');
  msgLosses:TLangMSG = ('������','������');
   msgConnectToDeferred: TLangMSG = ('������� � ����������','��''����� � �����������');
  msgWithoutWater: TLangMSG =  ('��� ����','��� ����');
  msgImage :TLangMSG =('�����������','����������');

  msgOrderContenr:TLangMSG = ('���������� ������','���� ������');
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
  msgShowOnMap:TLangMSG = ('�������� ����� �� �����','�������� ����� �� ����');
  msgTieOnMap:TLangMSG = ('��������� ����� � �����','����''����� ����� �� �����');
  msgWrongPasswd:TLangMSG = ('������������ ��� ������������ ��� ������ !','����������� ��''� ����������� ��� ������ !');
  msgClientServer:TLangMSG = ('������/������','�볺��/������');
  msgLoadProgram:TLangMSG = ('�������� ���������','������������ ��������');
  msgSaveChangedInfo:TLangMSG = ('��������� ���������� ����������','�������� ������ ����������');
  msgCloseWindow:TLangMSG = ('������� ����','������� ����');
  msgCopyZajav:TLangMSG = ('���������� ������� ����� � �����','�������� �������� ����� �� ������');
  msgNoNomDom:TLangMSG = ('�� �������� ����� ���� !','�� �������� ����� ������� !');
  msgSaveNewZajav:TLangMSG = ('��������� ����� ����� ?','�������� ����� ����� ?');
  msgSameZajav:TLangMSG = (' ���������� ������� ����� ������� �����. ��������?',
                           ' ���������� ������ ����� ����� ������. ��������?');
  msgSameZajavList:TLangMSG = ('���������� ������ � ������� ������� � ','�������� ������ � ������� �������� ��');
  msgZajavSetNom:TLangMSG = ('������ �������� ����� ','������ ��������� ����� ');
  msgZajavIDNotFound:TLangMSG = ('����� � ID=%d �� ������!','����� � ID=%d �� �������!');
  msgZajavWithOpenZadv:TLangMSG = ('� ������ ������������ ���������� ��������! ������� �����?',
                                   '� ����� ������� �������� �������! ������� �����?');
  msgZAjavWithoutWWater:TLangMSG = ('� ������ ������������ �� �������� ����������! ������� �����?',
                                   '� ����� ������� �������� ����������! ������� �����?');
  msgZajavWithOpenRaskop:TLangMSG = ('� ������ ������������ ������������ ��������! ������� �����?',
                                     '� ����� ������� ��������� ��������! ������� �����?');
  msgZajavWithoutDiam:TLangMSG = ('�� ��������� �������! ������� �����?',
                                  '�� �������� Ĳ�����! ������� �����?');
  msgCloseZajav:TLangMSG = ('������� ����� ?','������� ����� ?');
  msgErrorSetFStreetFilter :TLangMSG= ('������ ��������  ������ ����!!','������� �������� ������ ������!!');
  msgZajavWithoutCloseWent:TLangMSG = ('� ������ ��� �������� ������! ','� ������ ���� �������� �����! ');
  msgZajavWithoutWent:TLangMSG = ('� ������ ��� ������ !','� ������ ���� ����� !');
  msgZajavWentDel:TLangMSG = ('� ������ ��� ���� �����! ������� ��. ','� ������ ��� ������� �����! �������� ��. ');
  msgClosing:TLangMSG = ('��������','��������');
  msgSending:TLangMSG = ('�����������','�����������');
  msgBegin:TLangMSG = ('������','�������');
  msgEnd:TLangMSG = ('�����','ʳ����');
  msgTellWent:TLangMSG = ('�������� �����','���� �ȯ���');
  msgWhoDoJob:TLangMSG = ('�������� ������','���������� ������');
  msgNewYear:TLangMSG = (' ��������� ��� !'#13#10'��������� ����� � ������� 1 �� %d ��� ?'#13#10'���� ������� � %d ����� ����� ��� ���������� !',
                         ' ������� �� !'#13#10'�������� ����� � ������� 1 �� %d �� ?'#13#10'�������� ������ � %d ����� ���� ��� ��������� !');
  msgConfirmNewYear:TLangMSG = (' �� ������� ?'#13#10'���� ������� � %d ����� ����� ��� ���������� !',
                                ' �� ������� ?'#13#10'�������� ������ � %d ����� ���� ��� ��������� !');
  msgPrintAllWorks:TLangMSG = ('�������� ��� ������ ������','��������� �� ������ ������');
  msgNotPrintKoll:TLangMSG = ('�� ��������� ����������� �� ����������� (��� �����������)','�� ����������� ����������� �� ����������');
  msgPrintKoll:TLangMSG = ('������ ����������� �� �����������','ҳ���� ����������� �� ����������');
  msgPrintNotKoll:TLangMSG = ('���, ����� ����������� �� �����������','��, ��� ���������� �� ����������');
  msgDictAll:TLangMSG = ('������ ���������','����� ��������');
  msgDictShow:TLangMSG = ('������ �������','ҳ���� �����');
  msgDictHide:TLangMSG = ('������ ���������','ҳ���� �������');
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
  msgFalseZav:TLangMSG = ('������','���������');
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
  mcsVedNarPeriod:TLangMSG=('��������� ������ �� ������ ','³������ ����� � �����');
  vsgVip:TLangMSG=('����������','���������');
  msgNumNar:TLangMSG=('� �����','� �����');
  msgDiscons:TLangMSG=('���������� ','³���������');
  msgWithoutWaterKanal:TLangMSG=('���������� ' +#13+ '�������������','³���������' +#13+ ' �������������');
  msgCloseNar:TLangMSG = ('���������� ����� ������ ������� ������   '+
                      '� ������� %s ',
                      '���������  ���� �� ������� ���� '+
                      ' � ������� %s ');
  msgChangeSmenDeny:TLangMSG = ('���������� ���������!','��������� ����������!');
  msgDoChangeSmen:TLangMSG = ('�������� ����������!','��������  ����!');

  msgDatBeginInCurShift:TLangMSG = ('����  ������ ���� � �������� ������� �����!',
  '����  ����� ���� ������� � ���');
 msgDatZavEndInCurShift:TLangMSG = ('���� �������� ������ ������ ���� � �������� ������� �����!',
 '���� �������� ������  �� ���� ������� � ���');
  msgDatZavInCurShift:TLangMSG = ('���� �������� ������ ������ ���� � �������� ������� �����!',
 '���� �������� ������  �� ���� ������� � ���');
 msgLinkedWithOtlZavjav:TLangMSG  = ('����� ������ � �','����� ��''���� � �');

  msgDelLink:TLangMSG = ('������� ����� � ������� �','�������� ��''����  � ������� � ');
  msgDelLinkShort:TLangMSG = ('������� ����� ','�������� ��''����  ');

  msgWaterPipe:TLangMSG = (' ���������� ',' ��������� ');
  msgSeverage:TLangMSG = ('�����������',' ������������� ');
  msgWaterObjects:TLangMSG=('������� �����������','��''���� �����������');
  msgSeverageObjects:TLangMSG = ('������� �����������','��''���� ����������' );
  msgShift:TLangMSG = ('�����','����');
  msgFillFirstNar:TLangMSG = ('��������� �������� ����', '�������� ��������� ����');
  msgWarnDisableCloseOrder:TLangMSG=('����� ������� ������', '����� ������� ���������');
  msgWarnDisableOrderType:TLangMSG =('����� ������� ������, ��� ��� ��� ��� "�� ���������"','����� ������� ���������, ���� ��� "�� ���������"');//?????????????
  msgWarnByNarDate:TLangMSG =('���� �������� ���������� ������ ������ ���� �������� ������!','���� �������� ��������� ����� ����� �� ���� ������!!');
  msgRemoveFdelOrder:TLangMSG=('������ �� ������� �� ��������', '�������� � ������ ��� ��������� ');
  msgaddTodelOrder:TLangMSG=('��������� �� �������� ','������� �� ���������');
  msgIsAddToDelete :TLangMSG=('���������� �� ��������','�������� ��� ��������� ����������');
  msgNotFill:TLangMSG=('�� ���������', '�� ���������');
  msgAddResonDel:TLangMsg=('��������� �� �������� ���������� �� ��������','�������� �� �������� ��� ��������');
  msgRemoveFOtlNar:TLangMSG=('������ �� ���������� �������', '�������� � ����������� ������');
  msgAddOtlNar:TLangMSG=('��������', '��������');
  msgConectWith:TLangMSG=('������ � �','��''���� � �' );
  msgZavVRK:TLangMSG=('������ ���', '������ ���');//??????????????????
  msgToDel:TLangMSG=('�� ��������','�� ���������');
  msgFirst:TLangMSG=('���������','���������');
  msgFastAdd:TLangMSG=('������� ����������', '������ ���������');
  msgComplitWork:TLangMSG=('������� �����', '������� ������');
  msgAllRecords:TLangMSG=('��� ������','�� ������');
  msgConectCompWork:TLangMSG=('����������� � ����. ������','����''���� �� �����. ������');
  msgFreeRecords:TLangMSG=('��������� ������','³��� ������');
  msgRecalcTZ:TLangMSG=('����������� ������������','������������ ������������');
  msgLaborInput:TLangMSG=('������������','������������') ;
  msgOnQuantity:TLangMSG=('�� �����. ���-�� ��.','�� �����. ��-��� ��.');
  msgQuantityItems:TLangMSG=('���-�� ������','ʳ������ �������');
  msgCommonTZ:TLangMSG=('����� ������������','����� ������������');

  msgConfirmDepWorkExcav:TLangMSG=('��� �������� ������ ������ ����� ������� ���������������' + #13 +
                                  '��������, � ����� ��� ��������������� �� ������ �� ���������������.'+#13+
                                  '����������?',
                                  '����� � ������� ������ ������� �������� �������� � �� �������'+#13+
                                  '������ � ����������'+#13+
                                  '���������?');
  msgEditWork:TLangMSG=('�������������� ������', '���������� ����');
  msgNotDefined:TLangMSG =('�� ������','�� ������');
  msgFormZavNoDmL:TLangMSG=('�� ����� ������ �� ������ ��������� ���.','�� ���� ������ �� ������ �������� ���.');
  msgNotFieldValue:TLangMSG=('�� ������ ����','�� ��������� ����');
  msgImpossRecalcTZ:TLangMSG=('���������� ����������� ������������','��������� ����������� ������������');
  msgNeedExcav:TLangMSG=('���������� ������ ���������� �� ��������', '��������� ������ ���������� ��� ��������');
  msgNeedSetExcav:TLangMSG=('�������� ��������','������ ��������');
  msgAddBWork:TLangMSG=('���������� ������� ������','��������� ������� ������');
  msgEditBWork:TLangMSG=('�������������� ������� ������','����������� ������� ������');
  msgDelWorkForOld:TLangMSG=('������� ������ ����. ������� ��������','�������� ������, �� ���������� ������� ��������');
  msgAddWorkForNew:TLangMSG=('�������� ������ ����. ������ ��������','������ ������, �� ���������� ������ ��������');
  msgDelMaterForOld:TLangMSG=('������� ��������� ����. ������� ��������','�������� ��������, �� ���������� ������� ��������');
  msgAddMaterForNew:TLangMSG=('�������� ��������� ����. ������ ��������','������ ��������, �� ���������� ������ ��������');
  msgAddWorksAssigned:TLangMSG=('�������� ����. ������','������ ������� ������');
  msgAddMaterAssigned:TLangMSG=('�������� ����. ���������','������ ������� ��������');
  msgDelBwork:TLangMSG=('�������� ������� ������','��������� ������� ������');
  msgConfirmDelBwork:TLangMSG=('�� �������, ��� ������ ������� ������� ������?','�� �������, �� ������ �������� ������� ������?');
  msgDelWorksAssigned:TLangMSG=('������� ����. ������','�������� ������� ������');
  msgDelMaterAssigned:TLangMSG=('������� ����. ���������','�������� ������� ��������');
  msgEditMater:TLangMSG=('�������������� ����������','����������� ��������');
  msgAddMater:TLangMSG=('���������� ����������','��������� ��������');
  msgAddAsigned:TLangMSG=('�������� �������.','������ �������');
  msgSmallWork:TLangMSG=('���������','��� ������');
  msgNeedSaveNar:TLangMSG=('��������� �����!!','������� �������� ����!!');
  msgNeedbrig:TLangMSG=('�������� ���������!!!','������ ���������!');
  msgWorkTime:TLangMSG=('����� ������','��� ������');
  msgCopyPlan:TLangMSG=('����������� ����','��������� ����');
  msgTools:TLangMSG=('�����������','�����������');
  msgBrigsList:TLangMSG=('���������� ������','������� ������');
  msgBrigorMaster:TLangMSG=('�������� ��� ������','�������� ��� �������');
  msgWorkrersWorked:TLangMSG=('��������','���������');
  msgFirstStep:TLangMSG=('��������� ����','��������� ����');
  msgRemoveZadv:TLangMSG=('�������� ��������','������ �������');
  msgNormZadv:TLangMSG=('���������� ��������� ��������','��������� ���� �������');
  msgNote:TLangMSG=('�������,','�������');
  msgNumKOl:TLangMSG=('� �������','� ��������');
  msgZadvOne:TLangMSG=('��������','�������');
  msgStateChanged:TLangMSG=('��������� ��������','����� ������');
  msgFirstSate:TLangMSG=('�������� ���������','�������� ����');
  msgAddZadvFromCloseOrder:TLangMSG=('�������� ���������� �������� �� ��������� ������','������ ��������� ������� � ��������� ������');
  msgType:TLangMSG=('���','���');
  msgCrossRoadw:TLangMSG=('����������� � ','���������� �');
  msgExcavTo:TLangMSG=('�������� ��������','�������� ��������');
  msgAktFrom:TLangMSG=('��� ��', '��� ��');
  msgNeedDoBlag :TLangMSG=('���������� ��������� ������','��������� �������� ������');
  msgExcavSize :TLangMSG=('������� ��������','������ ��������');
  msgFencing: TLangMSG=('����������','�������');
  msgLength: TLangMSG=('������','�������');
  msgWidth: TLangMSG=('������','������');
  msgDepth: TLangMSG=('�������','�������');
  msgAccept: TLangMSG=('������','�������');
  msgPlabBlagDate:TLangMSG=('����������� ���� ��������������','����������� ���� ����������');
  msgRoadWorkerDate:TLangMSG=('���� �������� ����������','���� �������� ������ ����������������');
  msgBlagDate :TLangMSG=('���� ��������������','���� ����������');
  msgFirmAsf :TLangMSG=('����� �������������','Գ��� ���������������');
  msgNumAktAsf :TLangMSG=('� ���� ����������','� ���� ���������');
  msgChebDate :TLangMSG=('���� ���������','���� ��������');
  msgChebAkt :TLangMSG=('� ���� ���������','� ���� ��������');
  msgDownAsfDate :TLangMSG=('���� ������ �������������','���� �������� �������������');
  msgUpAsfDate :TLangMSG=('���� ������� �������������','���� ��������� �������������');
  msgBalanceKeeper :TLangMSG=('������� �����������','������� ���������');
  msgSandDate :TLangMSG=('���� (������������) �������� ������','���� (����������) �������� �����');
  msgRecover:TLangMSG=('������������', '³�������');
  msgRecovered:TLangMSG=('�������������','³��������');
  msgExcavCount:TLangMSG=('���������� ��������:','������� ��������');
  msgForDelExcav1:TLangMSG=('��� �������� ������ �������� ����� ����� �������',
                            '��� �������� ���� �������� ������ ����� �������');
  msgForDelExcav2:TLangMSG=('� ��� ��������������� ������.',
                            '� �� ������� ������.');
  msgDelExcavcConfirm:TLangMSG=('�� �������, ��� ������ ������� ��������?',
                                '�� �������, �� ������ �������� ��������?');
  msgNeedSaveChanges:TLangMSG=('������ ��������� ��������� ���������!',
  '������� �������� ������ ����!');
  msgAddExcav:TLangMSG=('�������� ��������','������ ��������');
  msgNeedTadr:TLangMSG=('������� ��� ������','�������� ��� ������');
  msgNeedStreet:TLangMSG=('������� ������������ �����!','�������� ������');
  msgNeedHouse:TLangMSG=('������� ����� ����!','�������� ����� ���. ');
  msgNeedStreet2:TLangMSG=('������� ������������ ����� �2!','�������� ������ �2!');
  msgNeedPlace:TLangMSG=('������� ��������� �����������!','�������� �������� ����.');
  msgIsActiveTran:TLangMSG=('������� �������� ����������','�����  � ���� ������� ����������');
  msgNotBlagTime:TLangMSG=('�� ������ ����� ��������� ������������ ����� �� ����-��',
                           '�� ������� ��� ��������� ����''������� ���� � �����������');
  msgendWork:TLangMSG=('��������� �����','��������� ����');
  msgClorDisconPart:TLangMSG=('������������ ������������ ������� �����������',
                             '���������� ��������� ������ �����');
  msgDateAkt:TLangMSG=('���� ������������ ����','���� ���������� ����');
  msgDateReciveOrder:TLangMSG=('���� � ����� ����������� ������',
                               '���� ���������� ������');
  msgDepthPutM:TLangMSG=('������� ��������� �','������� ����������');
  msgPressAtm:TLangMSG=('�������� ����, ���','���� ����, ���.');
  msgSquareSvich:TLangMSG=('������� �����, ��2','����� �����, ��2');
  mshLeakSpeed:TLangMSG=('������, �3/�','����, �3/�');
  msgDamgeCharacterIs:TLangMSG=('��������� ��������� �����������',
                                '��������� ��������� �����������');
  msgDoFlashing:TLangMSG=('�������� �������������, �','�������� �����������');
  msgDiamDamage:TLangMSG=('������� ������� �����������, ��','������� ������ �����������');
  msgCharLeak:TLangMSG=('�������� ����� ������','�������� ���� ������');
  msgClorDoz:TLangMSG=('���� �����, ��/�','���� �����, ��/�');
  msgTimeContact:TLangMSG=('����� ��������, �','��� ��������, �');
  msgExternalDiam:TLangMSG=('������� �������, ��','������� ������');
  msgInteriorDiam:TLangMSG=('���������� �������, ��','�������� ������, ��');
  msgConer:TLangMSG=('����, ����','���, ����');
  msgDiamSvich:TLangMSG=('������� �����, ��','ĳ����� �����, ��');
  msgCrackLength:TLangMSG=('����� �������, ��','������� ������, ��');
  msgCrackWidth:TLangMSG=('������ �������, ��','������ ������, ��');
  msgLengthEmpty:TLangMSG=('������������� ������������� ������� �����������, �',
                           '���������� ���������� ������ �����, �');
  msgDiamEmpty:TLangMSG=('������� ������� �����������, ��','ĳ����� ���������� ������, ��');
  msgDefferedOrder:TLangMSG=('���������� ������','³������� ������');
  msgLinked:TLangMSG=('������� �����','��''����� �����');
  msgAddInfShort:TLangMSG=('���. ���.','���. ���.');
  msgToPo:TLangMSG=('��','��');
  msgDateDiscon:TLangMSG=('���� ����������','���� ����������');
  msgDateCon:TLangMSG=('���� ���������','���� ���������');
  msgTimeDiscon:TLangMSG=('�����  ����������','��� ����������');
  msgTimeCon:TLangMSG=('�����  ����������','��� ���������');
  msgDisconexecutor:TLangMSG=('����������� ����.','������� ���������');
  msgRespons:TLangMSG=('������������� �� ���.','³����������� �� ���.');
  msgDtPlanDiscon:TLangMSG=('���� ����  ����������','���� ����� ����������');
  msgDtPlanCon:TLangMSG=('���� ���� ���������','���� ����� ���������');
  msgTimePlanDiscon:TLangMSG=('����� ���� ����������','��� ����� ����������');
  msgTimePlanCon:TLangMSG=('����� �����  ���������','��� ����� ���������');
  msgClassDiscon:TLangMSG=('������������ ����������','������������ ���������');
  msgNumDiscon:TLangMSG=('� ���������','� ���������');
  msgnHouse:TLangMSG=('� ����','� ���.');
  msgnDiscon:TLangMSG=('���������','³��������');
  msgCon:TLangMSG=('��������','��������');
  msgCheckDtDiscon:TLangMSG=('��������� ���� ��������� ��� ������� "��������"',
                             '�������� ���� ��������� ��� �������� "³������"');
  msgDtDiskoncon:TLangMSG=('���� ��������� ������ ���� ������ ���� ����������',
                            '���� ��������� ������� ���� ������ �� ���� �����������');
  msgConSmen:TLangMSG=('����� ��������� ������ ��������������� ���� �����',
                           '���� � ��� ��������� ����� ��������� ���');
  msgConDtNow:TLangMSG=('����� ��������� ������ ������� ����',
                        '��� ��������� ����� �� ������� ����');

  msgDisconSmen:TLangMSG=('����� ���������� ������ ��������������� ���� �����',
                          '��� � ���� ���������� ����� ��������� ���');
  msgDisconDtNow:TLangMSG=('����� ���������� ������ ������� ����',
                            '��� ���������� ����� �� ������� ����');

  msgNeedDisconExecutor:TLangMSG=('������� ����������� ����������',
                                  '������ ��� ������� ����������');
  msgNeedClassDiscon:TLangMSG=('������� ������������ ����������',
                                '������ ������������ ���������');
  msgResponseNeed:TLangMSG=('�� ����� ������������� �� ���������',
                            '������ ������������� �� ���.');
  msgAllhouses:TLangMSG=('��� ����','�� ���.');
  msgEvenhouses:TLangMSG=('������ ����','���� ���.');
  msgNotEvenHouses:TLangMSG=('�������� ����','������ ���.');
  msgFirstImage:TLangMSG=(' 1-�� �����������','����� ����������');
  msgAddImage:TLangMSG=('�������� �����������','������ ����������');
  msgDeleteImage:TLangMSG=('������� �����������','�������� ����������');
  msgPrevImage:TLangMSG=('���������� �����������','�������� ����������');
  msgLastImage:TLangMSG=('��������� �����������','������ ����������');
  msgNextImage:TLangMSG=('��������� �����������','�������� ����������');
  msgImageSize:TLangMSG=('������ �����������:','����� ����������:');
  msgImageTitle:TLangMSG=('����������� ������ - ����������� �','����������� ���� - ���������� �');
  msgConfirmDel:TLangMSG=('Image�� �������, ��� ������ ������� �����������?',
      '�� �������, ������ �������� ����������? ');
  msgCearList:TLangMSG=('�������� ������','�������� ������');
  msgCongirmCLearList:TLangMSG=('�� �������, ��� ������ �������� ������ �������?',
                                '�� �������, �� ������ �������� ������ ������?');
  msgSgiftNumber:TLangMSG=('� �����','� ����');
  msgShiftDate:TLangMSG=('���� �����','���� ����');
  msgRecoverCoverShort:TLangMSG=('�����. ������.','³����. ������.');
  msgIsPayed:TLangMSG=('��������','��������');
  msgTypeWork:TLangMSG=('��� ������','��� ������');
  msgSummer:TLangMSG=('����','���');
  msgWinter:TLangMSG=('����','����');
  msgConnectBWork:TLangMSG=('��������','����''����');
  msgNeedChArhiv:TLangMSG=('���� ������� �����','����� ������� �����');
  msgConfirmArhivReplace:TLangMSG=('�� �������, ��� ������ �������� �������� �����, �� ����� �� ������?',
                                    '�� �������, �� ������ ������� ����� �� ����� � ������?');
  msgForDay:TLangMSG=('�� �����','�� ����');
  msgForShift:TLangMSG=('�� �����','�� ����');

  msgLies:TLangMSG=('������','��������');
  msgOnConfirm:TLangMSG=('�� ���������','�� ��������');
  msgOpened:TLangMSG=('��������','³�����');
  msgDeffered:TLangMSG=('����������','³�������');
  msgErrorDate:TLangMSG=('���� �� ������� ��� ������� �������',
                         '���� �� ������� ��� ������� � �������');
 msgTryAgain:TLangMSG=('���������� ��� ���','��������� �� ���');

 msgSearchResults:TLangMSG=('��������� ������','���������� ������');
 msgSearchDiagram:TLangMSG=('������','������');

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
