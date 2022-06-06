inherited frm_OborIB: Tfrm_OborIB
  Left = 416
  Top = 238
  Width = 738
  Height = 427
  Caption = 'frm_OborIB'
  OldCreateOrder = True
  Position = poMainFormCenter
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inline frame_Obor: Tframe_Obor
    Left = 0
    Top = 0
    Width = 722
    Height = 313
    Align = alTop
    Color = clSilver
    ParentColor = False
    TabOrder = 0
    inherited DBGrid: TDBGridEh
      Left = 0
      Top = 90
      Width = 722
      Height = 223
      Align = alClient
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
      Columns = <
        item
          FieldName = 'NAME_R'
          Footers = <>
          Width = 363
        end
        item
          FieldName = 'WORK_TIME'
          Footers = <>
          Title.Caption = #1044#1083#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100' '#1088#1072#1073#1086#1090#1099
          Width = 132
        end>
    end
    inherited pnl_Fields: TPanel
      Left = 0
      Top = 0
      Width = 722
      Height = 90
      Align = alTop
      Visible = False
    end
    inherited dset_Main: TIBDataSet
      ForcedRefresh = True
      RefreshSQL.Strings = (
        'SELECT id, id_zav, id_nar, id_obor, sm.name_r'
        'FROM obors o join mexan sm on o.id_obor=sm.id'
        'WHERE (id_zav = :idZav)and'
        '               (id_nar = :idNar)'
        'ORDER BY id')
      SelectSQL.Strings = (
        
          'SELECT o.id, id_zav, id_nar, id_obor, sm.NAME_R_AND_FIO name_r, ' +
          'WORK_TIME'
        'FROM obors o join mexan sm on o.id_obor=sm.id'
        'WHERE (id_zav = :idZav)and'
        '               (id_nar = :idNar)'
        'ORDER BY id')
      ModifySQL.Strings = (
        'update obors set id_obor=:id_obor, WORK_TIME=:WORK_TIME'
        ' where id=:id')
      Top = 176
      inherited dset_MainNAME_R: TIBStringField
        Size = 60
      end
    end
  end
  object btn_Append: TBitBtn
    Left = 16
    Top = 328
    Width = 89
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = btn_AppendClick
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
  object btn_Edit: TBitBtn
    Left = 112
    Top = 328
    Width = 75
    Height = 25
    Caption = #1048#1079#1084#1077#1085#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = btn_EditClick
  end
  object btn_Delete: TBitBtn
    Left = 192
    Top = 328
    Width = 89
    Height = 25
    Caption = #1059#1076#1072#1083#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = btn_DeleteClick
    Glyph.Data = {
      42010000424D4201000000000000760000002800000011000000110000000100
      040000000000CC00000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
      888880000000888888888888888880000000888888888888880F800000008888
      0F888888888880000000888000F8888880F880000000888000F888880F888000
      00008888000F88800F888000000088888000F800F8888000000088888800000F
      8888800000008888888000F888888000000088888800000F8888800000008888
      8000F80F8888800000008880000F88800F8880000000880000F8888800F88000
      00008800F8888888800F80000000888888888888888880000000888888888888
      888880000000}
  end
  object btn_Post: TBitBtn
    Left = 464
    Top = 328
    Width = 83
    Height = 25
    Caption = #1047#1072#1087#1080#1089#1072#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = btn_PostClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333FFFFFFFFFFFFF33000077777770033377777777777773F000007888888
      00037F3337F3FF37F37F00000780088800037F3337F77F37F37F000007800888
      00037F3337F77FF7F37F00000788888800037F3337777777337F000000000000
      00037F3FFFFFFFFFFF7F00000000000000037F77777777777F7F000FFFFFFFFF
      00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
      00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
      00037F7F333333337F7F000FFFFFFFFF07037F7F33333333777F000FFFFFFFFF
      0003737FFFFFFFFF7F7330099999999900333777777777777733}
    NumGlyphs = 2
  end
  object btn_Cancel: TBitBtn
    Left = 552
    Top = 328
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    OnClick = btn_CancelClick
  end
  object btn_exit: TBitBtn
    Left = 632
    Top = 328
    Width = 75
    Height = 25
    Caption = '&'#1042#1099#1093#1086#1076
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    OnClick = btn_exitClick
    Kind = bkClose
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 370
    Width = 722
    Height = 19
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Panels = <>
    SimplePanel = True
    UseSystemFont = False
  end
  object btn_CopyPlan: TBitBtn
    Left = 288
    Top = 328
    Width = 153
    Height = 25
    Caption = #1057#1082#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1087#1083#1072#1085
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
    WordWrap = True
    OnClick = btn_CopyPlanClick
  end
end
