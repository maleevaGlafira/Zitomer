object Frm_Date: TFrm_Date
  Left = 0
  Top = 0
  Width = 424
  Height = 27
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Arial'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object Label1: TLabel
    Left = 3
    Top = 6
    Width = 9
    Height = 16
    Caption = #1057
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 214
    Top = 4
    Width = 16
    Height = 16
    Caption = #1087#1086
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object DE_In: TDateEdit
    Left = 17
    Top = 2
    Width = 100
    Height = 23
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    NumGlyphs = 2
    ParentFont = False
    YearDigits = dyFour
    TabOrder = 0
  end
  object Te_in: TDateTimePicker
    Left = 121
    Top = 2
    Width = 88
    Height = 24
    Date = 36460.000694444400000000
    Time = 36460.000694444400000000
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Kind = dtkTime
    ParentFont = False
    TabOrder = 1
  end
  object DE_Out: TDateEdit
    Left = 234
    Top = 2
    Width = 101
    Height = 23
    CheckOnExit = True
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    NumGlyphs = 2
    ParentFont = False
    YearDigits = dyFour
    TabOrder = 2
  end
  object Te_Out: TDateTimePicker
    Left = 338
    Top = 2
    Width = 80
    Height = 24
    Date = 36460.999305555600000000
    Time = 36460.999305555600000000
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Kind = dtkTime
    ParentFont = False
    TabOrder = 3
  end
end
