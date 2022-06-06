unit ConstsUA;

interface
uses consts,dialogs;

resourcestring

  SMsgDlgWarningUA = 'Попередження';
  SMsgDlgErrorUA = 'Помилка';
  SMsgDlgInformationUA = 'Інформація';
  SMsgDlgConfirmUA = 'Підтвердження';
  SMsgDlgYesUA = '&Так';
  SMsgDlgNoUA = '&Ні';
  SMsgDlgOKUA = 'OK';
  SMsgDlgCancelUA = 'Скасувати';
  SMsgDlgHelpUA = '&Довідка';
  SMsgDlgHelpNoneUA = 'Довідка недоступний';
  SMsgDlgHelpHelpUA = 'Довідка';
  SMsgDlgAbortUA = 'П&ерервати';
  SMsgDlgRetryUA = '&Повторити';
  SMsgDlgIgnoreUA = 'Про&довжити';
  SMsgDlgAllUA = '&Усі';
  SMsgDlgNoToAllUA = 'Н&і для усіх';
  SMsgDlgYesToAllUA = 'Д&а для усіх';

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