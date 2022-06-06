object Form_Axis: TForm_Axis
  Left = 363
  Top = 276
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Настройка осей координат'
  ClientHeight = 304
  ClientWidth = 322
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
  object Gr_Axis: TGroupBox
    Left = 2
    Top = 69
    Width = 317
    Height = 100
    Caption = 'Шкала осей координат'
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 20
      Width = 8
      Height = 16
      Caption = 'X'
    end
    object Label2: TLabel
      Left = 8
      Top = 48
      Width = 9
      Height = 16
      Caption = 'Y'
    end
    object Label3: TLabel
      Left = 240
      Top = 44
      Width = 16
      Height = 16
      Caption = 'по'
    end
    object Label4: TLabel
      Left = 240
      Top = 20
      Width = 16
      Height = 16
      Caption = 'по'
    end
    object ChB_YAxis: TCheckBox
      Left = 28
      Top = 44
      Width = 145
      Height = 21
      Caption = 'Автоматически  С'
      State = cbChecked
      TabOrder = 0
      OnClick = ChB_YAxisClick
    end
    object SpEd_Yc: TSpinEdit
      Left = 180
      Top = 43
      Width = 48
      Height = 26
      MaxValue = 1000
      MinValue = 0
      TabOrder = 1
      Value = 0
      OnChange = SpEd_YcChange
    end
    object SpEd_Ypo: TSpinEdit
      Left = 264
      Top = 43
      Width = 48
      Height = 26
      MaxValue = 100000
      MinValue = 0
      TabOrder = 2
      Value = 0
      OnChange = SpEd_YpoChange
    end
    object ChB_XAxis: TCheckBox
      Left = 28
      Top = 20
      Width = 145
      Height = 17
      Caption = 'Автоматически  С'
      State = cbChecked
      TabOrder = 3
      OnClick = ChB_XAxisClick
    end
    object SpEd_Xpo: TSpinEdit
      Left = 264
      Top = 11
      Width = 48
      Height = 26
      MaxValue = 100000
      MinValue = 0
      TabOrder = 4
      Value = 0
      OnChange = SpEd_XpoChange
    end
    object SpEd_Xc: TSpinEdit
      Left = 180
      Top = 11
      Width = 48
      Height = 26
      MaxValue = 0
      MinValue = 0
      TabOrder = 5
      Value = 0
      OnChange = SpEd_XcChange
    end
    object ChB_Grid: TCheckBox
      Left = 28
      Top = 72
      Width = 69
      Height = 17
      Caption = 'Сетка'
      State = cbChecked
      TabOrder = 6
      OnClick = ChB_GridClick
    end
  end
  object BB_Cn: TBitBtn
    Left = 208
    Top = 264
    Width = 100
    Height = 33
    Hint = 'Отменить настройки'
    Caption = 'Отмена'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = BB_CnClick
    Kind = bkCancel
  end
  object BB_Ok: TBitBtn
    Left = 208
    Top = 224
    Width = 100
    Height = 33
    Hint = 'Сохранить настройки'
    Caption = 'Принять'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = BB_OkClick
    Kind = bkOK
  end
  object GrB_Font: TGroupBox
    Left = 4
    Top = 176
    Width = 197
    Height = 121
    Caption = 'Шрифты'
    TabOrder = 3
    object Label5: TLabel
      Left = 12
      Top = 21
      Width = 43
      Height = 16
      Caption = 'меток'
    end
    object Label6: TLabel
      Left = 12
      Top = 49
      Width = 66
      Height = 16
      Caption = 'подписей'
    end
    object SpB_met: TSpeedButton
      Left = 144
      Top = 16
      Width = 25
      Height = 25
      Hint = 'Изменить фонт'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333FF3FFFFFFF33FFF003000000033
        0000773777777733777703330033033330037FFF77F37F33377F700007330333
        3003777777337FFFF77F303003337000007337F77F3377777773303073333033
        003337F77F3337F377F337007333303300333777733337FF77F3330033333703
        07333377F333377F7733330733333300033333773FF3F3777F33333399393300
        033333337737FF777F333333339993307333333333777FF77333333333999930
        3333333333777737333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = SpB_metClick
    end
    object SpB_pod: TSpeedButton
      Left = 144
      Top = 48
      Width = 25
      Height = 25
      Hint = 'Изменить фонт'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333FF3FFFFFFF33FFF003000000033
        0000773777777733777703330033033330037FFF77F37F33377F700007330333
        3003777777337FFFF77F303003337000007337F77F3377777773303073333033
        003337F77F3337F377F337007333303300333777733337FF77F3330033333703
        07333377F333377F7733330733333300033333773FF3F3777F33333399393300
        033333337737FF777F333333339993307333333333777FF77333333333999930
        3333333333777737333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = SpB_podClick
    end
    object Label7: TLabel
      Left = 12
      Top = 84
      Width = 80
      Height = 16
      Caption = 'расстояние'
    end
    object SpEd_dlm: TSpinEdit
      Left = 84
      Top = 15
      Width = 49
      Height = 26
      Hint = 'Быстрое изменение'#13#10'размера шрифта'
      MaxValue = 20
      MinValue = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Value = 20
      OnChange = SpEd_dlmChange
    end
    object SpEd_tit: TSpinEdit
      Left = 84
      Top = 47
      Width = 49
      Height = 26
      Hint = 'Быстрое изменение'#13#10'размера шрифта'
      MaxValue = 100
      MinValue = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Value = 0
      OnChange = SpEd_titChange
    end
    object SpEd_LbSz: TSpinEdit
      Left = 120
      Top = 79
      Width = 49
      Height = 26
      Hint = 'Расстояние между'#13#10'метками и подписями'
      MaxValue = 100
      MinValue = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Value = 0
      OnChange = SpEd_LbSzChange
    end
  end
  object GB_Title: TGroupBox
    Left = 2
    Top = 4
    Width = 317
    Height = 57
    Caption = 'Наименование графика'
    TabOrder = 4
    object SpB_Tit: TSpeedButton
      Left = 284
      Top = 20
      Width = 25
      Height = 25
      Hint = 'Изменить фонт'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333FF3FFFFFFF33FFF003000000033
        0000773777777733777703330033033330037FFF77F37F33377F700007330333
        3003777777337FFFF77F303003337000007337F77F3377777773303073333033
        003337F77F3337F377F337007333303300333777733337FF77F3330033333703
        07333377F333377F7733330733333300033333773FF3F3777F33333399393300
        033333337737FF777F333333339993307333333333777FF77333333333999930
        3333333333777737333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = SpB_TitClick
    end
    object Ed_Title: TEdit
      Left = 8
      Top = 20
      Width = 269
      Height = 24
      Hint = 'Изменить наименование'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnChange = Ed_TitleChange
    end
  end
  object BB_Color: TBitBtn
    Left = 208
    Top = 188
    Width = 100
    Height = 33
    Hint = 'Изменить цвет'#13#10'фона графика'
    Caption = 'Цвет'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnClick = BB_ColorClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555550FF0559
      1950555FF75F7557F7F757000FF055591903557775F75557F77570FFFF055559
      1933575FF57F5557F7FF0F00FF05555919337F775F7F5557F7F700550F055559
      193577557F7F55F7577F07550F0555999995755575755F7FFF7F5570F0755011
      11155557F755F777777555000755033305555577755F75F77F55555555503335
      0555555FF5F75F757F5555005503335505555577FF75F7557F55505050333555
      05555757F75F75557F5505000333555505557F777FF755557F55000000355557
      07557777777F55557F5555000005555707555577777FF5557F55553000075557
      0755557F7777FFF5755555335000005555555577577777555555}
    NumGlyphs = 2
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MinFontSize = 0
    MaxFontSize = 0
    Left = 232
    Top = 116
  end
  object ColorDialog1: TColorDialog
    Ctl3D = True
    Left = 166
    Top = 145
  end
end
