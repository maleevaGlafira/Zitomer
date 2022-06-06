object fmSpreadSh: TfmSpreadSh
  Left = 349
  Top = 179
  BorderStyle = bsSingle
  Caption = #1057#1042#1054#1044#1053#1040#1071' '#1042#1045#1044#1054#1052#1054#1057#1058#1068' '#1047#1040' '#1057#1052#1045#1053#1059
  ClientHeight = 143
  ClientWidth = 244
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
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 244
    Height = 77
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 26
      Top = 14
      Width = 74
      Height = 13
      Alignment = taCenter
      Caption = #1044#1072#1090#1072' '#1089#1084#1077#1085#1099
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object DateEdit_N: TDateEdit
      Left = 121
      Top = 12
      Width = 98
      Height = 17
      ButtonWidth = 17
      NumGlyphs = 2
      CalendarStyle = csDialog
      YearDigits = dyFour
      TabOrder = 0
      OnEnter = DateEdit_NEnter
      OnExit = DateEdit_NExit
    end
    object buRaon: TButton
      Left = 7
      Top = 41
      Width = 234
      Height = 25
      Caption = #1062#1077#1093
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = buRaonClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 77
    Width = 244
    Height = 38
    Align = alBottom
    TabOrder = 1
    object buFind: TBitBtn
      Left = 13
      Top = 9
      Width = 64
      Height = 20
      Caption = #1055#1086#1080#1089#1082
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS SANS SERIF'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = buFindClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object buQuit: TBitBtn
      Left = 173
      Top = 8
      Width = 65
      Height = 20
      Caption = #1042#1099#1093#1086#1076
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS SANS SERIF'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = buQuitClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000010000000000000000000
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
    object Animate1: TAnimate
      Left = 106
      Top = 1
      Width = 39
      Height = 36
      CommonAVI = aviFindComputer
      StopFrame = 8
      Visible = False
    end
  end
  object SBar: TStatusBar
    Left = 0
    Top = 115
    Width = 244
    Height = 28
    Panels = <>
  end
  object dset_tmp: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_tmp
    Left = 196
    Top = 44
  end
  object tran_tmp: TIBTransaction
    DefaultDatabase = DM_main.IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait'
      'read')
    Left = 152
    Top = 52
  end
  object frReport: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbPrint, pbExit]
    RebuildPrinter = False
    Left = 40
    Top = 4
    ReportForm = {19000000}
  end
  object frDB_SvodVed: TfrDBDataSet
    DataSet = dset_tmp
    Left = 8
    Top = 4
  end
  object dset_wwater: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran_tmp
    Left = 100
    Top = 56
  end
end
