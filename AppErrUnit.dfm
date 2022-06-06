object AppErrForm: TAppErrForm
  Left = 374
  Top = 200
  Width = 123
  Height = 136
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object RGAppError: TRGAppError
    UseDefaultErrorLogFileName = True
    EmailProperties.FromAddress = 'roma@aqua.kharkov.ua'
    EmailProperties.ToAddress = 'roma@aqua.kharkov.ua'
    EmailProperties.SMTP = 'sw'
    EmailProperties.Enabled = False
    Left = 40
    Top = 16
  end
end
