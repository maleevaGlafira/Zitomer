object SelectForm: TSelectForm
  Left = 392
  Top = 267
  Width = 379
  Height = 323
  ActiveControl = CheckListBox1
  BorderIcons = []
  Caption = #1042#1099#1073#1077#1088#1080#1090#1077
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 251
    Width = 363
    Height = 34
    Align = alBottom
    TabOrder = 0
    object buOK: TBitBtn
      Left = 13
      Top = 7
      Width = 100
      Height = 20
      Caption = #1055#1088#1080#1085#1103#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = buOKClick
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500000000055
        55550FFFFFFFFF0555550FEEEEEE000005000FFFFFF0BFBFB00E0F0EEEE000FB
        FB0E0FF00F0FBFBFBF0E0FE0B00000FBFB0E0FFF0FBFBFBFBF0E0FEEE0000000
        FB0E0FFFFF0B00BFB0000FEEEEE0B00005550FFFFFFF0B05555500F0F0F0F0B0
        555550808080800B055550808080805090550505050505550555}
    end
    object Panel4: TPanel
      Left = 271
      Top = 1
      Width = 91
      Height = 32
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 1
      object buQuit: TBitBtn
        Left = 16
        Top = 7
        Width = 68
        Height = 20
        Caption = #1042#1099#1093#1086#1076
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = buQuitClick
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00388888888877
          F7F787F8888888888333333F00004444400888FFF444448888888888F333FF8F
          000033334D5007FFF4333388888888883338888F0000333345D50FFFF4333333
          338F888F3338F33F000033334D5D0FFFF43333333388788F3338F33F00003333
          45D50FEFE4333333338F878F3338F33F000033334D5D0FFFF43333333388788F
          3338F33F0000333345D50FEFE4333333338F878F3338F33F000033334D5D0FFF
          F43333333388788F3338F33F0000333345D50FEFE4333333338F878F3338F33F
          000033334D5D0EFEF43333333388788F3338F33F0000333345D50FEFE4333333
          338F878F3338F33F000033334D5D0EFEF43333333388788F3338F33F00003333
          4444444444333333338F8F8FFFF8F33F00003333333333333333333333888888
          8888333F00003333330000003333333333333FFFFFF3333F00003333330AAAA0
          333333333333888888F3333F00003333330000003333333333338FFFF8F3333F
          0000}
        NumGlyphs = 2
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 363
    Height = 251
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 1
    object CheckListBox1: TCheckListBox
      Left = 1
      Top = 1
      Width = 361
      Height = 249
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ItemHeight = 13
      ParentFont = False
      TabOrder = 0
    end
  end
  object Query: TQuery
    DatabaseName = 'DBN_AVAR'
    Left = 168
    Top = 96
  end
end
