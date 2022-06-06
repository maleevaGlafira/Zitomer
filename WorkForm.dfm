object frm_Work: Tfrm_Work
  Left = 310
  Top = 207
  Width = 737
  Height = 505
  Caption = #1056#1072#1073#1086#1090#1099'\'#1084#1072#1090#1077#1088#1080#1072#1083#1099
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnl_BWork: TPanel
    Left = 0
    Top = 0
    Width = 721
    Height = 137
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 0
    object pnl_BWorkBtns: TPanel
      Left = 605
      Top = 2
      Width = 114
      Height = 133
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object btn_AddBWork: TBitBtn
        Left = 5
        Top = 5
        Width = 105
        Height = 25
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100
        TabOrder = 0
        OnClick = btn_AddBWorkClick
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          33333333FF33333333FF333993333333300033377F3333333777333993333333
          300033F77FFF3333377739999993333333333777777F3333333F399999933333
          33003777777333333377333993333333330033377F3333333377333993333333
          3333333773333333333F333333333333330033333333F33333773333333C3333
          330033333337FF3333773333333CC333333333FFFFF77FFF3FF33CCCCCCCCCC3
          993337777777777F77F33CCCCCCCCCC3993337777777777377333333333CC333
          333333333337733333FF3333333C333330003333333733333777333333333333
          3000333333333333377733333333333333333333333333333333}
        NumGlyphs = 2
      end
      object btn_EditBWork: TBitBtn
        Left = 4
        Top = 35
        Width = 105
        Height = 25
        Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
        TabOrder = 1
        OnClick = btn_EditBWorkClick
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000000
          000033333377777777773333330FFFFFFFF03FF3FF7FF33F3FF700300000FF0F
          00F077F777773F737737E00BFBFB0FFFFFF07773333F7F3333F7E0BFBF000FFF
          F0F077F3337773F3F737E0FBFBFBF0F00FF077F3333FF7F77F37E0BFBF00000B
          0FF077F3337777737337E0FBFBFBFBF0FFF077F33FFFFFF73337E0BF0000000F
          FFF077FF777777733FF7000BFB00B0FF00F07773FF77373377373330000B0FFF
          FFF03337777373333FF7333330B0FFFF00003333373733FF777733330B0FF00F
          0FF03333737F37737F373330B00FFFFF0F033337F77F33337F733309030FFFFF
          00333377737FFFFF773333303300000003333337337777777333}
        NumGlyphs = 2
      end
      object btn_DelBWork: TBitBtn
        Left = 4
        Top = 66
        Width = 105
        Height = 25
        Caption = #1059#1076#1072#1083#1080#1090#1100
        TabOrder = 2
        OnClick = btn_DelBWorkClick
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333333333FF33333333333330003333333333333777333333333333
          300033FFFFFF3333377739999993333333333777777F3333333F399999933333
          3300377777733333337733333333333333003333333333333377333333333333
          3333333333333333333F333333333333330033333F33333333773333C3333333
          330033337F3333333377333CC3333333333333F77FFFFFFF3FF33CCCCCCCCCC3
          993337777777777F77F33CCCCCCCCCC399333777777777737733333CC3333333
          333333377F33333333FF3333C333333330003333733333333777333333333333
          3000333333333333377733333333333333333333333333333333}
        NumGlyphs = 2
      end
    end
    object dbg_BWork: TDBGridEh
      Left = 2
      Top = 2
      Width = 603
      Height = 133
      Align = alClient
      DataSource = ds_BWork
      FooterColor = clWindow
      FooterFont.Charset = DEFAULT_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -11
      FooterFont.Name = 'MS Sans Serif'
      FooterFont.Style = []
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      UseMultiTitle = True
      OnDblClick = dbg_BWorkDblClick
      OnKeyDown = dbg_BWorkKeyDown
      Columns = <
        item
          FieldName = 'lp_BWork'
          Footers = <>
          Title.Caption = #1057#1083#1086#1078#1085#1072#1103' '#1088#1072#1073#1086#1090'c'#1072
          Width = 405
        end>
    end
  end
  object pnl_Work: TPanel
    Left = 0
    Top = 193
    Width = 721
    Height = 239
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object pnl_WorkBtns: TPanel
      Left = 608
      Top = 0
      Width = 113
      Height = 239
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      Visible = False
      object btn_AddDetails: TBitBtn
        Left = 5
        Top = 21
        Width = 105
        Height = 25
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100
        TabOrder = 0
        OnClick = btn_AddDetailsClick
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          33333333FF33333333FF333993333333300033377F3333333777333993333333
          300033F77FFF3333377739999993333333333777777F3333333F399999933333
          33003777777333333377333993333333330033377F3333333377333993333333
          3333333773333333333F333333333333330033333333F33333773333333C3333
          330033333337FF3333773333333CC333333333FFFFF77FFF3FF33CCCCCCCCCC3
          993337777777777F77F33CCCCCCCCCC3993337777777777377333333333CC333
          333333333337733333FF3333333C333330003333333733333777333333333333
          3000333333333333377733333333333333333333333333333333}
        NumGlyphs = 2
      end
      object btn_EditDetails: TBitBtn
        Left = 4
        Top = 52
        Width = 105
        Height = 25
        Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
        TabOrder = 1
        OnClick = btn_EditDetailsClick
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000000
          000033333377777777773333330FFFFFFFF03FF3FF7FF33F3FF700300000FF0F
          00F077F777773F737737E00BFBFB0FFFFFF07773333F7F3333F7E0BFBF000FFF
          F0F077F3337773F3F737E0FBFBFBF0F00FF077F3333FF7F77F37E0BFBF00000B
          0FF077F3337777737337E0FBFBFBFBF0FFF077F33FFFFFF73337E0BF0000000F
          FFF077FF777777733FF7000BFB00B0FF00F07773FF77373377373330000B0FFF
          FFF03337777373333FF7333330B0FFFF00003333373733FF777733330B0FF00F
          0FF03333737F37737F373330B00FFFFF0F033337F77F33337F733309030FFFFF
          00333377737FFFFF773333303300000003333337337777777333}
        NumGlyphs = 2
      end
      object btn_DelDetails: TBitBtn
        Left = 4
        Top = 83
        Width = 105
        Height = 25
        Caption = #1059#1076#1072#1083#1080#1090#1100
        TabOrder = 2
        OnClick = btn_DelDetailsClick
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333333333FF33333333333330003333333333333777333333333333
          300033FFFFFF3333377739999993333333333777777F3333333F399999933333
          3300377777733333337733333333333333003333333333333377333333333333
          3333333333333333333F333333333333330033333F33333333773333C3333333
          330033337F3333333377333CC3333333333333F77FFFFFFF3FF33CCCCCCCCCC3
          993337777777777F77F33CCCCCCCCCC399333777777777737733333CC3333333
          333333377F33333333FF3333C333333330003333733333333777333333333333
          3000333333333333377733333333333333333333333333333333}
        NumGlyphs = 2
      end
    end
    object pc_Details: TPageControl
      Left = 0
      Top = 0
      Width = 608
      Height = 239
      ActivePage = ts_Work
      Align = alClient
      TabOrder = 1
      OnChange = pc_DetailsChange
      object ts_Work: TTabSheet
        Tag = 1
        Caption = #1056#1072#1073#1086#1090#1072
        object dbg_Works: TDBGridEh
          Left = 0
          Top = 35
          Width = 600
          Height = 176
          Align = alClient
          DataSource = ds_Works
          FooterColor = clWindow
          FooterFont.Charset = DEFAULT_CHARSET
          FooterFont.Color = clWindowText
          FooterFont.Height = -11
          FooterFont.Name = 'MS Sans Serif'
          FooterFont.Style = []
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          UseMultiTitle = True
          OnDblClick = dbg_WorksDblClick
          OnKeyDown = dbg_WorksKeyDown
          Columns = <
            item
              FieldName = 'lpWORK'
              Footers = <>
              Title.Caption = #1056#1072#1073#1086#1090#1072
              Width = 172
            end
            item
              FieldName = 'lpPLACE'
              Footers = <>
              Title.Caption = #1052#1077#1089#1090#1086
              Width = 104
            end
            item
              FieldName = 'lpKILLCLOG'
              Footers = <>
              Title.Caption = #1051#1080#1082#1074#1080#1076#1072#1094#1080#1103' '#1079#1072#1089#1086#1088#1072
              Width = 170
            end
            item
              FieldName = 'lpPUMP'
              Footers = <>
              Title.Caption = #1052#1077#1090#1086#1076' '#1086#1090#1082#1072#1095#1082#1080
              Width = 141
            end
            item
              FieldName = 'lpPES'
              Footers = <>
              Title.Caption = #1057#1040#1043
              Width = 146
            end
            item
              FieldName = 'lpDIAM'
              Footers = <>
              Title.Caption = #1044#1080#1072#1084#1077#1090#1088
              Width = 57
            end
            item
              FieldName = 'KOL_WORK'
              Footers = <>
              Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
              Width = 68
            end
            item
              FieldName = 'TZ_TRUDOZATRAT'
              Footers = <>
              Title.Caption = #1058#1088#1091#1076#1086#1079#1072#1090#1088#1072#1090#1099'||'#1058#1088#1091#1076#1086#1079#1072#1090#1088#1072#1090#1099' '#1085#1072' '#1079#1072#1076#1072#1085'. '#1082#1086#1083'-'#1074#1086' '#1077#1076'.'
              Width = 107
            end
            item
              FieldName = 'TZ_KOL_ED'
              Footers = <>
              Title.Caption = #1058#1088#1091#1076#1086#1079#1072#1090#1088#1072#1090#1099'||'#1050#1086#1083'-'#1074#1086' '#1077#1076#1080#1085#1080#1094
            end
            item
              FieldName = 'clcTOTAL_TZ'
              Footers = <>
              Title.Caption = #1058#1088#1091#1076#1086#1079#1072#1090#1088#1072#1090#1099'||'#1054#1073#1097#1080#1077' '#1090#1088#1091#1076#1086#1079#1072#1090#1088#1072#1090#1099
              Width = 86
            end>
        end
        object pnl_RecalcTZ: TPanel
          Left = 0
          Top = 0
          Width = 600
          Height = 35
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          object l_ObjOborName: TLabel
            Left = 232
            Top = 8
            Width = 3
            Height = 13
          end
          object btn_RecalcTZ: TBitBtn
            Left = 4
            Top = 3
            Width = 189
            Height = 25
            Caption = #1055#1077#1088#1077#1089#1095#1080#1090#1072#1090#1100' '#1090#1088#1091#1076#1086#1079#1072#1090#1088#1072#1090#1099
            TabOrder = 0
            OnClick = btn_RecalcTZClick
          end
        end
      end
    end
    object pnl_materold: TPanel
      Left = 200
      Top = 160
      Width = 209
      Height = 81
      Caption = 'pnl_materold'
      TabOrder = 2
      Visible = False
      object dbg_Mater: TDBGridEh
        Left = 1
        Top = 1
        Width = 207
        Height = 79
        Align = alClient
        DataSource = ds_Mater
        FooterColor = clWindow
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Name = 'MS Sans Serif'
        FooterFont.Style = []
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        UseMultiTitle = True
        OnDblClick = dbg_MaterDblClick
        OnKeyDown = dbg_WorksKeyDown
        Columns = <
          item
            FieldName = 'lp_Mat'
            Footers = <>
            Title.Caption = #1052#1072#1090#1077#1088#1080#1072#1083
            Width = 197
          end
          item
            FieldName = 'lp_Diam'
            Footers = <>
            Title.Caption = #1044#1080#1072#1084#1077#1090#1088
            Width = 75
          end
          item
            FieldName = 'kol_mat'
            Footers = <>
            Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
            Width = 74
          end>
      end
    end
  end
  object pnl_Bottom: TPanel
    Left = 0
    Top = 432
    Width = 721
    Height = 35
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 2
    object BitBtn4: TBitBtn
      Left = 616
      Top = 5
      Width = 93
      Height = 25
      Caption = #1042#1099#1093#1086#1076
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = BitBtn4Click
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
    object btn_FastAdd: TBitBtn
      Left = 8
      Top = 5
      Width = 145
      Height = 25
      Caption = #1041#1099#1089#1090#1088#1086#1077' '#1076#1086#1073#1072#1074#1083#1077#1085#1080#1077
      TabOrder = 1
      OnClick = btn_FastAddClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333FF3333333333333003333
        3333333333773FF3333333333309003333333333337F773FF333333333099900
        33333FFFFF7F33773FF30000000999990033777777733333773F099999999999
        99007FFFFFFF33333F7700000009999900337777777F333F7733333333099900
        33333333337F3F77333333333309003333333333337F77333333333333003333
        3333333333773333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
    end
  end
  object pnl_View: TPanel
    Left = 0
    Top = 137
    Width = 721
    Height = 56
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object rg_View: TRadioGroup
      Left = 6
      Top = 9
      Width = 611
      Height = 41
      Caption = #1054#1090#1086#1073#1088#1072#1078#1072#1090#1100
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        #1042#1089#1077' '#1079#1072#1087#1080#1089#1080
        #1055#1088#1080#1074#1103#1079#1072#1085#1085#1099#1077' '#1082' '#1089#1083#1086#1078'. '#1088#1072#1073#1086#1090#1077
        #1057#1074#1086#1073#1086#1076#1085#1099#1077' '#1079#1072#1087#1080#1089#1080)
      TabOrder = 0
      OnClick = rg_ViewClick
    end
  end
  object ds_Works: TDataSource
    DataSet = dm_Work.dset_Works
    Left = 48
    Top = 320
  end
  object ds_Mater: TDataSource
    Left = 45
    Top = 378
  end
  object ds_BWork: TDataSource
    Left = 48
    Top = 96
  end
end
