object FormResult: TFormResult
  Left = 231
  Top = 213
  BorderStyle = bsSingle
  Caption = #1047#1072#1075#1088#1091#1079#1082#1072' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1072' ...'
  ClientHeight = 333
  ClientWidth = 568
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 314
    Width = 568
    Height = 19
    Panels = <
      item
        Width = 50
      end>
    OnDrawPanel = StatusBar1DrawPanel
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 568
    Height = 314
    Align = alClient
    BevelInner = bvLowered
    BorderWidth = 1
    TabOrder = 1
    DesignSize = (
      568
      314)
    object Label1: TLabel
      Left = 427
      Top = 8
      Width = 81
      Height = 13
      Anchors = [akTop, akRight]
      Caption = #1056#1072#1079#1084#1077#1088' '#1096#1088#1080#1092#1090#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object SpEd_Font: TSpinEdit
      Left = 522
      Top = 5
      Width = 46
      Height = 22
      Anchors = [akTop, akRight]
      MaxValue = 30
      MinValue = 6
      TabOrder = 0
      Value = 8
      OnChange = SpEd_FontChange
    end
    object StrGr_res: TStringAlignGrid
      Left = 5
      Top = 41
      Width = 451
      Height = 272
      Anchors = [akLeft, akTop, akRight, akBottom]
      DefaultRowHeight = 20
      FixedCols = 0
      RowCount = 2
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      PopupMenu = PoM_Sort
      TabOrder = 1
      OnDblClick = StrGr_resDblClick
      OnKeyDown = StrGr_resKeyDown
      OnMouseDown = StrGr_resMouseDown
      PropCell = ()
      PropCol = ()
      PropRow = ()
      PropFixedCol = ()
      PropFixedRow = ()
    end
    object ChLB_Pol: TRxCheckListBox
      Left = 459
      Top = 44
      Width = 108
      Height = 97
      Anchors = [akTop, akRight, akBottom]
      ItemHeight = 13
      TabOrder = 2
      OnClick = ChLB_PolClick
      InternalVersion = 202
    end
    object Panel2: TPanel
      Left = 459
      Top = 144
      Width = 107
      Height = 171
      Anchors = [akRight, akBottom]
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 3
      object Lb_count: TLabel
        Left = 50
        Top = 138
        Width = 36
        Height = 13
        AutoSize = False
        Caption = 'text'
        Visible = False
      end
      object Lb_Select: TLabel
        Left = 9
        Top = 138
        Width = 40
        Height = 13
        AutoSize = False
        Caption = 'text'
        Visible = False
      end
      object BB_Graf: TBitBtn
        Left = 5
        Top = 32
        Width = 96
        Height = 27
        Caption = #1043#1088#1072#1092#1080#1082
        Enabled = False
        TabOrder = 0
        Visible = False
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00337333733373
          3373337F3F7F3F7F3F7F33737373737373733F7F7F7F7F7F7F7F770000000000
          000077777777777777773303333333333333337FF333333F33333709333333C3
          333337773F3FF373F333330393993C3C33333F7F7F77F7F7FFFF77079797977C
          77777777777777777777330339339333C333337FF73373F37F33370C333C3933
          933337773F3737F37FF33303C3C33939C9333F7F7F7FF7F777FF7707C7C77797
          7C97777777777777777733033C3333333C33337F37F33333373F37033C333333
          33C3377F37333333337333033333333333333F7FFFFFFFFFFFFF770777777777
          7777777777777777777733333333333333333333333333333333}
        NumGlyphs = 2
      end
      object BB_zav: TBitBtn
        Left = 5
        Top = 59
        Width = 96
        Height = 27
        Caption = #1053#1072#1088#1103#1076
        TabOrder = 1
        OnClick = BB_zavClick
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333FF3333333333333C0C333333333333F777F3333333333CC0F0C3
          333333333777377F33333333C30F0F0C333333337F737377F333333C00FFF0F0
          C33333F7773337377F333CC0FFFFFF0F0C3337773F33337377F3C30F0FFFFFF0
          F0C37F7373F33337377F00FFF0FFFFFF0F0C7733373F333373770FFFFF0FFFFF
          F0F073F33373F333373730FFFFF0FFFFFF03373F33373F333F73330FFFFF0FFF
          00333373F33373FF77333330FFFFF000333333373F333777333333330FFF0333
          3333333373FF7333333333333000333333333333377733333333333333333333
          3333333333333333333333333333333333333333333333333333}
        NumGlyphs = 2
      end
      object BB_Print: TBitBtn
        Left = 5
        Top = 86
        Width = 96
        Height = 27
        Caption = #1055#1077#1095#1072#1090#1100
        TabOrder = 2
        OnClick = BB_PrintClick
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
      object BB_Excel: TBitBtn
        Left = 5
        Top = 113
        Width = 96
        Height = 27
        Caption = 'Excel'
        TabOrder = 3
        OnClick = BB_ExcelClick
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000074120000741200001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFF70F
          FFFFFFFFFFF70F80FFFFFFFFF70F8480FFFFFFF70F84C9880FFFF80F8F8DFC98
          0FFF888F8FF8F89F80FF000000777F8F80FFFE6666EF8F8FF80FFFE66EF60FF8
          F80FFF76EF8FF8F8FF70FF6EF678F8FF7800F6EF8E67FF7800FF000F08000800
          FFFFFFFF888800FFFFFFFFFFF000FFFFFFFFFFFFF0FFFFFFFFFF}
      end
      object BB_Close: TBitBtn
        Left = 5
        Top = 140
        Width = 96
        Height = 27
        Caption = #1042#1099#1093#1086#1076
        TabOrder = 4
        OnClick = BB_CloseClick
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
      object bbMap: TBitBtn
        Left = 5
        Top = 4
        Width = 96
        Height = 27
        Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1082#1072#1088#1090#1091
        Caption = #1056#1072#1079#1084#1077#1090#1080#1090#1100
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnClick = bbMapClick
        Glyph.Data = {
          46050000424D4605000000000000360000002800000012000000120000000100
          20000000000010050000120B0000120B00000000000000000000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00E4DAEC139668A35C7527649B710930CF7A010DF27A01
          0DF2710930CF7527649B9668A35CE4DAEC13FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00AA88BA45721E57A873215CF4905E9BF9C0A8
          CFFDECE6F2FFECE6F2FFC0A8CFFD905E9BF973215CF4721E57A8AA88BA45FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009D73AB54701345D59A6FA8F9EFE9
          F4FFF6F3F9FFFCFBFDFFFFFFFFFFFFFFFFFFFCFBFDFFF6F3F9FFEFE9F4FF9A6F
          A8F9701345D59D73AB54FFFFFF00FFFFFF00FFFFFF00BDBDFF424242FFD6C7B2
          D5FEE8E0EFFF9667A2FF701346FF790111FF800000FF800000FF730626FF7426
          62FFC6B0D4FFF6F3F9FFC7B2D5FE701142D6AD8CBD42FFFFFF00EDEDFF125757
          FFA8A8A8FFFFFAFAFFFF6A686CFF3E7F06FF604000FF800000FF800000FF8000
          00FF800000FF585000FF39851AFFABA0BAFFFEFDFEFF9A6FA8FF721E57A8E5DC
          ED12AEAEFF515151FFF3F3F3FFFFA8A8FFFF0B2BDFFF00FF00FF28AF00FF8000
          00FF800000FF800000FF800000FF10DF00FF10DF00FF70103FFFC7B2D5FFEEE8
          F3FF711A51F39F77AE516A6AFF959595FFFFFFFFFFFF4949FFFF0000FFFF00CF
          30FF00FF00FF407F00FF407F00FF407F00FF388F00FF00FF00FF388F00FF7F00
          02FF7F3D7DFFFFFFFFFF8C5795FF772C6A953333FFCCCCCCFFFFFFFFFFFF1313
          FFFF0000FFFF00708FFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF
          00FF683000FF800001FF700F3EFFFFFFFFFFBDA3CCFF710A33CC0A0AFFF5F5F5
          FFFFFFFFFFFF0000FFFF0000FFFF0020DFFF00FF00FF009F60FF800000FF8000
          00FF10DF00FF18CF00FF800000FF800000FF780112FFFFFFFFFFF0EBF5FF7B00
          0AF50A0AFFF5F5F5FFFFFFFFFFFF0404FFFF0000FFFF0000FFFF00AF50FF00EF
          10FF0000FFFF683000FF00FF00FF487000FF800000FF800000FF720627FFFFFF
          FFFFF0EBF5FF7B000AF53333FFCCCCCCFFFFFFFFFFFF3232FFFF0000FFFF0000
          FFFF00609FFF00FF00FF0050AFFF008F70FF00FF00FF702000FF800000FF7E00
          05FF742460FFFFFFFFFFBDA3CCFF710A33CC6A6AFF959595FFFFFFFFFFFF7575
          FFFF0101FFFF0000FFFF0010EFFF00FF00FF009F60FF00DF20FF00CF30FF8000
          00FF800000FF770216FF9C71AAFFFFFFFFFF8C5795FF772C6A95AEAEFF515151
          FFF3F3F3FFFFE2E2FFFF4646FFFF0101FFFF0000FFFF00AF50FF00EF10FF00FF
          00FF00609FFF0000FFFF7B010CFF884F8EFFF9F7FBFFEEE8F3FF711A51F39F77
          AE51EDEDFF125757FFA8A8A8FFFFFEFEFFFFD4D4FFFF5151FFFF1010FFFF0151
          AFFF00BF40FF00BF40FF0717EFFF1919FFFF9090FFFFEFE9F4FFFEFDFEFF9A6F
          A8FF721E57A8E5DCED12FFFFFF00BDBDFF424242FFD6D5D5FFFEF8F8FFFFDBDB
          FFFF8383FFFF4141FFFF1212FFFF2323FFFF5B5BFFFFA5A5FFFFF8F8FFFFF9F9
          FFFFC7B2D5FE701142D6AD8CBD42FFFFFF00FFFFFF00FFFFFF00ABABFF544545
          FFD5A8A8FFF9F4F4FFFFF9F9FFFFFDFDFFFFFFFFFFFFFFFFFFFFFDFDFFFFF9F9
          FFFFF4F4FFFFA8A8FFF94545FFD59D73AB54FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00BABAFF455757FFA85C5CFFF49B9BFFF9CFCFFFFDF2F2FFFFF2F2
          FFFFCFCFFFFD9B9BFFF95C5CFFF45757FFA8BABAFF45FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00ECECFF13A3A3FF5C6464FF9B3030
          FFCF0D0DFFF20D0DFFF23030FFCF6464FF9BA3A3FF5CECECFF13FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00}
      end
    end
    object BB_Clear: TBitBtn
      Left = 501
      Top = 130
      Width = 47
      Height = 20
      Anchors = [akTop, akRight]
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      Visible = False
      OnClick = BB_ClearClick
    end
    object StaticText1: TStaticText
      Left = 460
      Top = 29
      Width = 107
      Height = 16
      Alignment = taCenter
      Anchors = [akTop, akRight]
      AutoSize = False
      BorderStyle = sbsSunken
      Caption = #1050#1086#1083#1086#1085#1082#1080
      TabOrder = 5
    end
    object PrBar: TProgressBar
      Left = 172
      Top = 284
      Width = 216
      Height = 16
      TabOrder = 6
      Visible = False
    end
    object TopLabel: TScrollBox
      Left = 5
      Top = 4
      Width = 415
      Height = 35
      VertScrollBar.ButtonSize = 10
      VertScrollBar.Range = 200
      VertScrollBar.Smooth = True
      VertScrollBar.Size = 12
      VertScrollBar.Style = ssFlat
      Anchors = [akLeft, akTop, akRight]
      AutoScroll = False
      TabOrder = 7
      object Lb_usl: TLabel
        Left = 0
        Top = 0
        Width = 394
        Height = 200
        Align = alClient
        AutoSize = False
        Caption = 'Lb_usl'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        WordWrap = True
      end
    end
    object P_Wait: TPanel
      Left = 168
      Top = 120
      Width = 225
      Height = 81
      Anchors = []
      BevelInner = bvLowered
      Caption = #1054#1087#1088#1086#1089' "'#1040#1074#1072#1088#1080#1081' '#1085#1072' '#1082#1072#1088#1090#1077'"...'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
      Visible = False
      object An_Wait: TAnimate
        Left = 197
        Top = 4
        Width = 25
        Height = 25
        AutoSize = False
        CommonAVI = aviFindFile
        StopFrame = 8
      end
    end
  end
  object Qry_tmp: TQuery
    OnCalcFields = Qry_tmpCalcFields
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select nomer p1,dt_in p2 from nzavjav where (delz=0)')
    Left = 168
    Top = 220
  end
  object Qry_ul1: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      
        'select u.id id,u.name_r||" "||v.name_r name_r from s_ulic u,s_vi' +
        'dul v'
      'where (u.id>0) and (u.id_vidul=v.id)')
    Left = 112
    Top = 220
  end
  object Qry_ul2: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      
        'select u.id id,u.name_r||" "||v.name_r name_r from s_ulic u,s_vi' +
        'dul v'
      'where u.id_vidul=v.id')
    Left = 60
    Top = 220
  end
  object PoM_Sort: TPopupMenu
    Left = 140
    Top = 132
  end
  object Tm: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TmTimer
    Left = 108
    Top = 112
  end
  object Qry_DopAdres: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id, name_r'
      'from s_dopadres'
      'where id>0')
    Left = 232
    Top = 216
  end
end