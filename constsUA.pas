unit ConstsUA;

interface
uses consts,dialogs;

resourcestring

  SMsgDlgWarningUA = '������������';
  SMsgDlgErrorUA = '�������';
  SMsgDlgInformationUA = '����������';
  SMsgDlgConfirmUA = 'ϳ�����������';
  SMsgDlgYesUA = '&���';
  SMsgDlgNoUA = '&ͳ';
  SMsgDlgOKUA = 'OK';
  SMsgDlgCancelUA = '���������';
  SMsgDlgHelpUA = '&������';
  SMsgDlgHelpNoneUA = '������ �����������';
  SMsgDlgHelpHelpUA = '������';
  SMsgDlgAbortUA = '�&��������';
  SMsgDlgRetryUA = '&���������';
  SMsgDlgIgnoreUA = '���&�������';
  SMsgDlgAllUA = '&��';
  SMsgDlgNoToAllUA = '�&� ��� ���';
  SMsgDlgYesToAllUA = '�&� ��� ���';

Var
  CaptionsUA: array[TMsgDlgType] of Pointer = (@SMsgDlgWarningUA, @SMsgDlgErrorUA,
    @SMsgDlgInformationUA, @SMsgDlgConfirmUA, nil);
  ButtonCaptionsUA: array[TMsgDlgBtn] of Pointer = (
    @SMsgDlgYesUA, @SMsgDlgNoUA, @SMsgDlgOKUA, @SMsgDlgCancelUA, @SMsgDlgAbortUA,
    @SMsgDlgRetryUA, @SMsgDlgIgnoreUA, @SMsgDlgAllUA, @SMsgDlgNoToAllUA, @SMsgDlgYesToAllUA,
    @SMsgDlgHelpUA);

  CaptionsRU: array[TMsgDlgType] of Pointer = (@SMsgDlgWarning, @SMsgDlgError,
    @SMsgDlgInformation, @SMsgDlgConfirm, nil);
  ButtonCaptionsRU: array[TMsgDlgBtn] of Pointer = (
    @SMsgDlgYes, @SMsgDlgNo, @SMsgDlgOK, @SMsgDlgCancel, @SMsgDlgAbort,
    @SMsgDlgRetry, @SMsgDlgIgnore, @SMsgDlgAll, @SMsgDlgNoToAll, @SMsgDlgYesToAll,
    @SMsgDlgHelp);

implementation

end.