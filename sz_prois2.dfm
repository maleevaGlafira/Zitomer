object Sz_proizv2: TSz_proizv2
  Left = 279
  Top = 146
  Width = 700
  Height = 370
  Anchors = []
  Caption = #1055#1088#1086#1080#1079#1074#1086#1083#1100#1085#1099#1081' '#1087#1086#1080#1089#1082' '#1087#1086' '#1085#1072#1088#1103#1076#1072#1084
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Debug_pl: TPanel
    Left = 0
    Top = 270
    Width = 692
    Height = 73
    Align = alBottom
    TabOrder = 0
    Visible = False
    object MemoSQL: TRichEdit
      Left = 1
      Top = 1
      Width = 647
      Height = 71
      Align = alClient
      TabOrder = 0
    end
    object Panel2: TPanel
      Left = 648
      Top = 1
      Width = 43
      Height = 71
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 1
      object BB_Prov: TBitBtn
        Left = 15
        Top = 5
        Width = 28
        Height = 30
        Hint = #1055#1088#1086#1074#1077#1088#1080#1090#1100' '#1079#1072#1087#1088#1086#1089
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = BB_ProvClick
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
      object BB_dRun: TBitBtn
        Left = 15
        Top = 41
        Width = 28
        Height = 28
        Hint = #1042#1099#1087#1086#1083#1085#1080#1090#1100' '#1079#1072#1087#1088#1086#1089
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = BB_dRunClick
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          0400000000000001000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333333FF3FF3333333333CC30003333333333883888333333333C33
          3000333FF33338F33888339933333C3333333388F33338F3333F339933333C33
          33003388333338F33388333333333C333300333F333338F33388339333333C33
          3333338FF3333833333F33993333C33333003388FF33833333883339933C3333
          330033388FF83F33338833339933C33333333FF388F383F3333F993399333C33
          330088F388F338F33388993399333C33330088FF883338F33388399993333C33
          33333888833338F333FF333333333C33300033333333383FF8883333333333CC
          3000333333333388388833333333333333333333333333333333}
        NumGlyphs = 2
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 692
    Height = 270
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel1'
    TabOrder = 1
    object Splitter1: TSplitter
      Left = 493
      Top = 0
      Height = 270
      Align = alRight
    end
    object Baze_pl: TPanel
      Left = 0
      Top = 0
      Width = 493
      Height = 270
      Align = alClient
      BevelOuter = bvNone
      BorderWidth = 1
      TabOrder = 0
      object TbC_Sear: TTabControl
        Left = 1
        Top = 65
        Width = 491
        Height = 165
        Align = alClient
        HotTrack = True
        MultiLine = True
        TabOrder = 0
        OnChange = TbC_SearChange
      end
      object Panel3: TPanel
        Left = 1
        Top = 230
        Width = 491
        Height = 39
        Align = alBottom
        TabOrder = 1
        DesignSize = (
          491
          39)
        object BB_Run: TBitBtn
          Left = 5
          Top = 8
          Width = 92
          Height = 25
          Hint = #1042#1099#1087#1086#1083#1085#1080#1090#1100' '#1079#1072#1087#1088#1086#1089
          Anchors = [akLeft, akBottom]
          Caption = #1055#1088#1080#1085#1103#1090#1100
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = BB_RunClick
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000130B0000130B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            333333333333333FF3FF3333333333CC30003333333333773777333333333C33
            3000333FF33337F33777339933333C3333333377F33337F3333F339933333C33
            33003377333337F33377333333333C333300333F333337F33377339333333C33
            3333337FF3333733333F33993333C33333003377FF33733333773339933C3333
            330033377FF73F33337733339933C33333333FF377F373F3333F993399333C33
            330077F377F337F33377993399333C33330077FF773337F33377399993333C33
            33333777733337F333FF333333333C33300033333333373FF7773333333333CC
            3000333333333377377733333333333333333333333333333333}
          NumGlyphs = 2
        end
        object BB_Open: TBitBtn
          Left = 101
          Top = 8
          Width = 104
          Height = 25
          Hint = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1092#1086#1088#1084#1091
          Anchors = [akLeft, akBottom]
          Caption = #1042#1077#1076#1086#1084#1086#1089#1090#1080
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          Visible = False
          OnClick = BB_OpenClick
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000130B0000130B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
            333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
            0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
            07333337F3FF3FFF7F333330F00F000F07333337F77377737F333330FFFFFFFF
            07333FF7F3FFFF3F7FFFBBB0F0000F0F0BB37777F7777373777F3BB0FFFFFFFF
            0BBB3777F3FF3FFF77773330F00F000003333337F773777773333330FFFF0FF0
            33333337F3FF7F37F3333330F08F0F0B33333337F7737F77FF333330FFFF003B
            B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
            3BB33773333773333773B333333B3333333B7333333733333337}
          NumGlyphs = 2
        end
        object BB_Debug: TBitBtn
          Left = 209
          Top = 8
          Width = 29
          Height = 25
          Hint = #1054#1090#1083#1072#1076#1082#1072
          Anchors = [akLeft, akBottom]
          Caption = '>>'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          Visible = False
          OnClick = BB_DebugClick
        end
        object BB_Close: TBitBtn
          Left = 387
          Top = 8
          Width = 94
          Height = 25
          Hint = #1047#1072#1082#1088#1099#1090#1100
          Anchors = [akRight, akBottom]
          Caption = #1047#1072#1082#1088#1099#1090#1100
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          OnClick = BB_CloseClick
          Glyph.Data = {
            DE010000424DDE01000000000000760000002800000024000000120000000100
            0400000000006801000000000000000000001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            333333333333333333333333000033338833333333333333333F333333333333
            0000333911833333983333333388F333333F3333000033391118333911833333
            38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
            911118111118333338F3338F833338F3000033333911111111833333338F3338
            3333F8330000333333911111183333333338F333333F83330000333333311111
            8333333333338F3333383333000033333339111183333333333338F333833333
            00003333339111118333333333333833338F3333000033333911181118333333
            33338333338F333300003333911183911183333333383338F338F33300003333
            9118333911183333338F33838F338F33000033333913333391113333338FF833
            38F338F300003333333333333919333333388333338FFF830000333333333333
            3333333333333333333888330000333333333333333333333333333333333333
            0000}
          NumGlyphs = 2
        end
      end
      object Panel4: TPanel
        Left = 1
        Top = 1
        Width = 491
        Height = 64
        Align = alTop
        TabOrder = 2
        object Label2: TLabel
          Left = 2
          Top = 10
          Width = 43
          Height = 13
          Caption = #1053#1086#1084#1077#1088' '#1089
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label3: TLabel
          Left = 114
          Top = 9
          Width = 12
          Height = 13
          Caption = #1087#1086
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object SE_NomIn: TSpinEdit
          Left = 51
          Top = 6
          Width = 59
          Height = 22
          MaxValue = 100000
          MinValue = 0
          TabOrder = 0
          Value = 0
        end
        object SE_NomOut: TSpinEdit
          Left = 132
          Top = 6
          Width = 56
          Height = 22
          MaxValue = 100000
          MinValue = 0
          TabOrder = 1
          Value = 0
        end
        object DateZayav_rg: TRadioGroup
          Left = 365
          Top = 0
          Width = 115
          Height = 53
          ItemIndex = 0
          Items.Strings = (
            #1044#1072#1090#1072' '#1086#1090#1082#1088#1099#1090#1080#1103
            #1044#1072#1090#1072' '#1079#1072#1082#1088#1099#1090#1080#1103)
          ParentBackground = False
          TabOrder = 2
          OnClick = DateZayav_rgClick
        end
        inline Frm_Dt: TFrm_Date
          Left = 2
          Top = 31
          Width = 358
          Height = 26
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          inherited Label1: TLabel
            Left = 1
            Top = 4
            Width = 7
            Height = 13
            Font.Height = -11
          end
          inherited Label2: TLabel
            Left = 175
            Width = 12
            Height = 13
            Font.Height = -11
          end
          inherited DE_In: TDateEdit
            Left = 12
            Top = 0
            Width = 84
            Height = 22
            Font.Height = -11
            ButtonWidth = 19
          end
          inherited Te_in: TDateTimePicker
            Left = 99
            Top = 0
            Width = 73
            Height = 21
            Font.Height = -11
          end
          inherited DE_Out: TDateEdit
            Left = 192
            Top = 0
            Width = 84
            Height = 21
            Font.Height = -11
            ButtonWidth = 19
          end
          inherited Te_Out: TDateTimePicker
            Left = 279
            Top = 0
            Width = 73
            Height = 21
            Font.Height = -11
          end
        end
        object RB_Zav: TRadioButton
          Left = 192
          Top = 8
          Width = 77
          Height = 17
          Caption = #1047#1072#1082#1088#1099#1090#1099#1077
          Checked = True
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          TabStop = True
          OnClick = RB_ZavClick
        end
        object RB_Nzav: TRadioButton
          Left = 270
          Top = 8
          Width = 91
          Height = 17
          Caption = #1053#1077' '#1079#1072#1082#1088#1099#1090#1099#1077
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          OnClick = RB_NzavClick
        end
      end
    end
    object ChLB_2Sear: TCheckListBox
      Left = 496
      Top = 0
      Width = 196
      Height = 270
      OnClickCheck = ChLB_2SearClickCheck
      Align = alRight
      ItemHeight = 13
      TabOrder = 1
      OnClick = ChLB_2SearClick
    end
  end
  object OpenFl: TOpenDialog
    Filter = #1060#1086#1088#1084#1099'|*.frm'
    Left = 272
    Top = 276
  end
  object Qry_tmp: TQuery
    DatabaseName = 'DBN_AVAR'
    Left = 592
    Top = 64
  end
end
