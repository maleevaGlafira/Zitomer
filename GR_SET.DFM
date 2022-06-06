object Form_grset: TForm_grset
  Left = 275
  Top = 208
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Настройка графика'
  ClientHeight = 105
  ClientWidth = 341
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 4
    Top = 8
    Width = 101
    Height = 16
    Caption = 'Ширина линии'
  end
  object SpEd_Width: TSpinEdit
    Left = 116
    Top = 4
    Width = 45
    Height = 26
    Hint = 'Изменить ширину'#13#10'линии графика'
    MaxValue = 20
    MinValue = 1
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    Value = 1
    OnChange = SpEd_WidthChange
  end
  object ChB_3D: TCheckBox
    Left = 4
    Top = 36
    Width = 169
    Height = 17
    Caption = 'Трехмерный график'
    ParentShowHint = False
    ShowHint = False
    TabOrder = 1
    OnClick = ChB_3DClick
  end
  object ChB_Patt: TCheckBox
    Left = 212
    Top = 4
    Width = 113
    Height = 17
    Caption = 'Штриховка'
    TabOrder = 2
    OnClick = ChB_PattClick
  end
  object CmB_St: TComboBox
    Left = 184
    Top = 32
    Width = 153
    Height = 24
    Hint = 'Тип линии'#13#10'или штриховки'
    Style = csDropDownList
    ItemHeight = 16
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnChange = CmB_StChange
  end
  object BB_Ok: TBitBtn
    Left = 116
    Top = 68
    Width = 100
    Height = 33
    Hint = 'Сохранить настройки'
    Caption = 'Принять'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = BB_OkClick
    Kind = bkOK
  end
  object BB_Cn: TBitBtn
    Left = 232
    Top = 68
    Width = 100
    Height = 33
    Hint = 'Отменить настройки'
    Caption = 'Отмена'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnClick = BB_CnClick
    Kind = bkCancel
  end
end
