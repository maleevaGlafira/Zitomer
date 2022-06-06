object FormPrOb: TFormPrOb
  Left = 431
  Top = 362
  BorderStyle = bsDialog
  Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077
  ClientHeight = 130
  ClientWidth = 397
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object TbC_Vib: TTabControl
    Left = 0
    Top = 0
    Width = 397
    Height = 130
    Align = alClient
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Tabs.Strings = (
      #1052#1077#1093#1072#1085#1080#1079#1084#1099
      #1055#1083#1072#1085#1080#1088#1091#1077#1084#1099#1077' '#1084#1077#1093#1072#1085#1080#1079#1084#1099
      #1048#1085#1089#1090#1088#1091#1084#1077#1085#1090#1099
      #1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077)
    TabIndex = 0
    TabStop = False
    OnChange = TbC_VibChange
    object Panel1: TPanel
      Left = 6
      Top = 28
      Width = 383
      Height = 95
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      object lbl_Name: TLabel
        Left = 10
        Top = 19
        Width = 52
        Height = 13
        Alignment = taRightJustify
        Caption = #1052#1077#1093#1072#1085#1080#1079#1084
      end
      object Bevel1: TBevel
        Left = 4
        Top = 57
        Width = 374
        Height = 13
        Shape = bsTopLine
      end
      object BB_Next: TBitBtn
        Left = 7
        Top = 63
        Width = 93
        Height = 25
        Caption = '&'#1044#1086#1073#1072#1074#1080#1090#1100
        TabOrder = 0
        OnClick = BB_NextClick
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          0400000000000001000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
          333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
          0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
          07333337F33333337F333330FFFFFFFF07333337F33333337F333330FFFFFFFF
          07333FF7F33333337FFFBBB0FFFFFFFF0BB37777F3333333777F3BB0FFFFFFFF
          0BBB3777F3333FFF77773330FFFF000003333337F333777773333330FFFF0FF0
          33333337F3337F37F3333330FFFF0F0B33333337F3337F77FF333330FFFF003B
          B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
          3BB33773333773333773B333333B3333333B7333333733333337}
        NumGlyphs = 2
      end
      object B_Next: TButton
        Left = 100
        Top = 63
        Width = 29
        Height = 25
        Caption = '&>>'
        TabOrder = 1
        OnClick = SpB_NextClick
      end
      object B_Prev: TButton
        Left = 129
        Top = 63
        Width = 29
        Height = 25
        Caption = '&<<'
        TabOrder = 2
        OnClick = SpB_PrevClick
      end
      object BB_ESC: TBitBtn
        Left = 284
        Top = 63
        Width = 93
        Height = 25
        Caption = #1042#1099#1093#1086#1076
        TabOrder = 3
        OnClick = BB_ESCClick
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
      object Obor_lcb: TRxDBLookupCombo
        Left = 68
        Top = 15
        Width = 221
        Height = 23
        DropDownCount = 8
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        LookupField = 'NAME_R'
        LookupDisplay = 'NAME_R_AND_FIO'
        LookupSource = DM1.S_Obor_sur
        ParentFont = False
        TabOrder = 4
        Visible = False
        OnChange = Obor_lcbChange
      end
      object PlanObor_lcb: TRxDBLookupCombo
        Left = 68
        Top = 15
        Width = 221
        Height = 23
        DropDownCount = 8
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        LookupField = 'NAME_R'
        LookupDisplay = 'NAME_R'
        LookupSource = DM1.s_PlanObor_sur
        ParentFont = False
        TabOrder = 5
        Visible = False
        OnChange = PlanObor_lcbChange
      end
      object Instrum_lcb: TRxDBLookupCombo
        Left = 68
        Top = 15
        Width = 221
        Height = 23
        DropDownCount = 8
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        LookupField = 'NAME_R'
        LookupDisplay = 'NAME_R'
        LookupSource = DM1.s_instrum_sur
        ParentFont = False
        TabOrder = 6
        Visible = False
        OnChange = Instrum_lcbChange
      end
      object ObjObor_lcb: TRxDBLookupCombo
        Left = 69
        Top = 17
        Width = 220
        Height = 21
        DropDownCount = 8
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        LookupField = 'name_r'
        LookupDisplay = 'name_r'
        LookupSource = FormObor.s_objobor_sur
        ParentFont = False
        TabOrder = 7
        Visible = False
        OnChange = ObjObor_lcbChange
      end
    end
  end
  object Qry_tmp: TQuery
    DatabaseName = 'DBN_AVAR'
    Left = 176
    Top = 52
  end
end
