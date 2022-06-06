object Graph: TGraph
  Left = 256
  Top = 145
  Width = 640
  Height = 515
  Caption = #1044#1080#1072#1075#1088#1072#1084#1084#1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Diagram: TDiagram
    Left = 0
    Top = 35
    Width = 632
    Height = 421
    Align = alClient
    PopupMenu = PopupMenu
    OnDblClick = DiagramDblClick
    Active = False
    MinMaxAuto = False
    CountColumns = 20
    CountRows = 10
    CountLayers = 5
    PercentSpace = 20
    ShadowRow = 80
    rho = 50.000000000000000000
    LabelCaption = 'Diagram'
    FontCaption.Charset = DEFAULT_CHARSET
    FontCaption.Color = clBlack
    FontCaption.Height = -23
    FontCaption.Name = 'Arial'
    FontCaption.Style = [fsBold, fsItalic]
    FontLabel.Charset = DEFAULT_CHARSET
    FontLabel.Color = clWindowText
    FontLabel.Height = -13
    FontLabel.Name = 'Arial'
    FontLabel.Style = []
    Style = dsMatrix
  end
  object Panel: TPanel
    Left = 0
    Top = 456
    Width = 632
    Height = 32
    Align = alBottom
    TabOrder = 0
    object pn2: TPanel
      Tag = 1993
      Left = 51
      Top = 6
      Width = 40
      Height = 21
      BevelInner = bvLowered
      Color = clYellow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      Visible = False
      OnClick = pnYearClick
    end
    object pn3: TPanel
      Tag = 1994
      Left = 98
      Top = 6
      Width = 40
      Height = 21
      BevelInner = bvLowered
      Color = clLime
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      Visible = False
      OnClick = pnYearClick
    end
    object pn4: TPanel
      Tag = 1995
      Left = 145
      Top = 6
      Width = 39
      Height = 21
      BevelInner = bvLowered
      Color = clBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      Visible = False
      OnClick = pnYearClick
    end
    object pn5: TPanel
      Tag = 1996
      Left = 193
      Top = 6
      Width = 40
      Height = 21
      BevelInner = bvLowered
      Color = clRed
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      Visible = False
      OnClick = pnYearClick
    end
    object pn1: TPanel
      Tag = 1992
      Left = 7
      Top = 6
      Width = 40
      Height = 21
      BevelInner = bvLowered
      Color = clOlive
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      Visible = False
      OnClick = pnYearClick
    end
    object pn6: TPanel
      Tag = 1992
      Left = 241
      Top = 6
      Width = 40
      Height = 21
      BevelInner = bvLowered
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      Visible = False
      OnClick = pnYearClick
    end
    object pn7: TPanel
      Tag = 1993
      Left = 285
      Top = 6
      Width = 40
      Height = 21
      BevelInner = bvLowered
      Color = clPurple
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      Visible = False
      OnClick = pnYearClick
    end
    object pn8: TPanel
      Tag = 1994
      Left = 332
      Top = 6
      Width = 40
      Height = 21
      BevelInner = bvLowered
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
      Visible = False
      OnClick = pnYearClick
    end
    object pn9: TPanel
      Tag = 1995
      Left = 379
      Top = 6
      Width = 39
      Height = 21
      BevelInner = bvLowered
      Color = clFuchsia
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
      Visible = False
      OnClick = pnYearClick
    end
    object pn10: TPanel
      Tag = 1996
      Left = 427
      Top = 6
      Width = 40
      Height = 21
      BevelInner = bvLowered
      Color = clAqua
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 9
      Visible = False
      OnClick = pnYearClick
    end
  end
  object Panel_Track: TPanel
    Left = 3
    Top = 38
    Width = 189
    Height = 34
    Caption = 'Panel_Track'
    Enabled = False
    TabOrder = 1
    Visible = False
    object TrackBar: TTrackBar
      Left = 4
      Top = 9
      Width = 182
      Height = 16
      Max = 50
      Min = 1
      PageSize = 5
      Position = 50
      SelEnd = 5
      TabOrder = 0
      OnChange = TrackBarChange
    end
  end
  object pnl_Btn: TPanel
    Left = 0
    Top = 0
    Width = 632
    Height = 35
    Align = alTop
    TabOrder = 2
    object bb_Print: TBitBtn
      Left = 103
      Top = 5
      Width = 90
      Height = 25
      Caption = #1055#1077#1095#1072#1090#1100
      TabOrder = 0
      OnClick = bb_PrintClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        00033FFFFFFFFFFFFFFF0888888888888880777777777777777F088888888888
        8880777777777777777F0000000000000000FFFFFFFFFFFFFFFF0F8F8F8F8F8F
        8F80777777777777777F08F8F8F8F8F8F9F0777777777777777F0F8F8F8F8F8F
        8F807777777777777F7F0000000000000000777777777777777F3330FFFFFFFF
        03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
        03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
        33333337F3FF7F3733333330F08F0F0333333337F7737F7333333330FFFF0033
        33333337FFFF7733333333300000033333333337777773333333}
      NumGlyphs = 2
    end
    object bb_Save: TBitBtn
      Left = 8
      Top = 5
      Width = 89
      Height = 25
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      TabOrder = 1
      OnClick = bb_SaveClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333330070
        7700333333337777777733333333008088003333333377F73377333333330088
        88003333333377FFFF7733333333000000003FFFFFFF77777777000000000000
        000077777777777777770FFFFFFF0FFFFFF07F3333337F3333370FFFFFFF0FFF
        FFF07F3FF3FF7FFFFFF70F00F0080CCC9CC07F773773777777770FFFFFFFF039
        99337F3FFFF3F7F777F30F0000F0F09999937F7777373777777F0FFFFFFFF999
        99997F3FF3FFF77777770F00F000003999337F773777773777F30FFFF0FF0339
        99337F3FF7F3733777F30F08F0F0337999337F7737F73F7777330FFFF0039999
        93337FFFF7737777733300000033333333337777773333333333}
      NumGlyphs = 2
    end
  end
  object Timer: TTimer
    Enabled = False
    Interval = 150
    OnTimer = TimerTimer
    Left = 336
    Top = 104
  end
  object PopupMenu: TPopupMenu
    Left = 232
    Top = 136
    object track: TMenuItem
      Caption = #1056#1072#1089#1090#1086#1103#1085#1080#1077' '#1085#1072#1073#1083#1102#1076#1077#1085#1080#1103
      OnClick = trackClick
    end
  end
  object SaveDlg: TSavePictureDialog
    Filter = 'Bitmaps (*.bmp)|*.bmp'
    Left = 280
    Top = 192
  end
end
