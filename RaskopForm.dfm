object frm_Raskop: Tfrm_Raskop
  Left = 315
  Top = 21
  Width = 707
  Height = 766
  Caption = 'frm_Raskop'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lbl_Restored: TLabel
    Left = 132
    Top = 686
    Width = 116
    Height = 16
    Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1083#1077#1085#1086
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btn_Post: TBitBtn
    Left = 380
    Top = 681
    Width = 97
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = btn_PostClick
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
  object btn_Delete: TBitBtn
    Left = 4
    Top = 681
    Width = 89
    Height = 25
    Caption = #1059#1076#1072#1083#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    TabStop = False
    OnClick = btn_DeleteClick
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
  inline frame_Raskop: Tframe_Raskop
    Left = 0
    Top = 0
    Width = 689
    Height = 433
    TabOrder = 0
    inherited tc_Raskops: TTabControl
      Width = 689
      Height = 433
      inherited Label3: TLabel
        Left = 0
        Top = 398
        Visible = False
      end
      inherited Label5: TLabel
        Top = 324
        WordWrap = True
      end
      inherited Label6: TLabel
        Left = 17
        Top = 372
      end
      inherited Label7: TLabel
        Left = 184
        Top = 332
      end
      inherited Label8: TLabel
        Left = 403
        Top = 332
      end
      inherited Label9: TLabel
        Left = 289
        Top = 332
      end
      inherited Label10: TLabel
        Top = 332
      end
      inherited Label11: TLabel
        Left = 201
        Top = 332
      end
      inherited Label12: TLabel
        Left = 311
        Top = 332
      end
      inherited Bevel1: TBevel
        Left = 10
        Top = 321
        Width = 407
      end
      inherited Label14: TLabel
        Left = 424
      end
      inherited Label15: TLabel
        Top = 158
      end
      inherited Label16: TLabel
        Top = 190
      end
      inherited Label17: TLabel
        Top = 158
      end
      inherited Label18: TLabel
        Left = 216
        Top = 190
      end
      inherited Label19: TLabel
        Top = 190
      end
      inherited Label20: TLabel
        Left = 16
        Top = 238
      end
      inherited Label21: TLabel
        Left = 240
        Top = 238
      end
      inherited Label22: TLabel
        Left = 16
        Top = 270
      end
      inherited Label23: TLabel
        Left = 232
        Top = 270
      end
      inherited Label25: TLabel
        Top = 158
      end
      inherited gb_Adres: TGroupBox
        inherited lbl_S_Ulic1: TLabel
          Left = 4
        end
        inherited lbl_S_DopAdres: TLabel
          Left = 248
        end
      end
      inherited mem_NeedWorks: TDBMemo
        Top = 392
        Width = 470
      end
      inherited dbl_S_Brig_Blag: TRxDBLookupCombo
        Left = 489
      end
      inherited ne_Len: TDBNumberEditEh
        Left = 136
        Top = 328
        TabOrder = 11
      end
      inherited ne_Wid: TDBNumberEditEh
        Left = 248
        Top = 328
        TabOrder = 12
      end
      inherited ne_Dep: TDBNumberEditEh
        Left = 360
        Top = 328
        TabOrder = 13
      end
      inherited mem_Ogragd: TDBMemo
        Top = 363
        Width = 297
        TabOrder = 14
      end
      inherited dbl_S_Ogragd: TRxDBLookupCombo
        Top = 366
        TabOrder = 15
      end
      inherited dbe_planDateExcav: TDBDateEdit
        TabOrder = 8
      end
      inherited DBDE_dateOrg: TDBDateEdit
        TabOrder = 9
      end
      inherited DBDE_dateClosedDocument: TDBDateEdit
        TabOrder = 10
      end
      inherited rdbl_orgRoad: TRxDBLookupCombo
        Top = 192
      end
      inherited de_DT_CHEB: TDBDateEdit
        Left = 128
        Top = 240
      end
      inherited de_NUMBERCHEB: TDBEdit
        Left = 328
        Top = 240
      end
      inherited dbe_DT_DOWNASFALT: TDBDateEdit
        Left = 128
        Top = 272
      end
      inherited dbe_DT_UPASFALT: TDBDateEdit
        Left = 328
        Top = 272
      end
    end
    inherited ds_orgRoad: TDataSource
      Left = 488
      Top = 256
    end
  end
  object btn_Exit: TBitBtn
    Left = 484
    Top = 681
    Width = 97
    Height = 25
    Caption = #1042#1099#1093#1086#1076
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = btn_ExitClick
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
  object btn_Narad: TBitBtn
    Left = 550
    Top = 235
    Width = 113
    Height = 25
    Caption = #1042#1099#1077#1079#1076#1099
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = btn_NaradClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
      55555555FFFFFFFF5555555000000005555555577777777FF555550999999900
      55555575555555775F55509999999901055557F55555557F75F5001111111101
      105577FFFFFFFF7FF75F00000000000011057777777777775F755070FFFFFF0F
      01105777F555557F7FF75500FFFFFF0F00105577F555FF7F77575550FF70000F
      0F0055575FF777757F775555000FFFFF0F005555777555FF7F77555550FF7000
      0F055555575FF777757F555555000FFFFF05555555777555FF7F55555550FF70
      0005555555575FF7777555555555000555555555555577755555555555555555
      5555555555555555555555555555555555555555555555555555}
    NumGlyphs = 2
  end
  object btn_Restore: TBitBtn
    Left = 100
    Top = 681
    Width = 193
    Height = 25
    Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    TabStop = False
    OnClick = btn_RestoreClick
  end
  inline frame_WorksInfo: Tframe_WorksInfo
    Left = 1
    Top = 440
    Width = 672
    Height = 240
    TabOrder = 6
    inherited lbl_AddInfo: TLabel
      Top = 146
      Width = 672
    end
    inherited Grid: TStringAlignGrid
      Width = 672
      Height = 146
      ColWidths = (
        64
        64
        64
        64
        64)
      PropCell = ()
      PropCol = ()
      PropRow = ()
      PropFixedCol = ()
      PropFixedRow = ()
    end
    inherited pnl_NeedWorks: TPanel
      Top = 159
      Width = 672
      inherited Label1: TLabel
        Width = 672
      end
      inherited mem_NeedWorks: TMemo
        Width = 672
      end
    end
    inherited tran: TIBTransaction
      Top = 32
    end
  end
  object btn_Act: TBitBtn
    Left = 298
    Top = 681
    Width = 71
    Height = 25
    Caption = #1040#1082#1090
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    TabStop = False
    Visible = False
    OnClick = btn_ActClick
    Glyph.Data = {
      E6040000424DE604000000000000360000002800000014000000140000000100
      180000000000B0040000120B0000120B0000000000000000000091D0FF91D0FF
      91D0FF91D0FF91D0FF91D0FF91D0FF91D0FF91D0FF91D0FF91D0FF91D0FF91D0
      FF91D0FF91D0FF91D0FF91D0FF91D0FF91D0FF91D0FF94D2FF94D2FF94D2FF94
      D2FF94D2FF94D2FF94D2FF94D2FF94D2FF94D2FF94D2FF94D2FF94D2FF94D2FF
      94D2FF94D2FF94D2FF94D2FF94D2FF94D2FF97D4FF97D4FF97D4FF97D4FF97D4
      FF97D4FF97D4FF97D4FF97D4FF97D4FF97D4FF97D4FF97D4FF97D4FF97D4FF97
      D4FF97D4FF97D4FF97D4FF97D4FF9AD5FF9AD5FF9AD5FF9BC1DB806850806050
      8060507060507058407058407050407050406048306048306048308097A49AD5
      FF9AD5FF9AD5FF9AD5FF9DD7FF9DD7FF95BFDB9F8C87E0D0C0B0A090B0A090B0
      A090B0A090B0A090B0A090B0A090B0A090B0A090B0A09060483095C5E59DD7FF
      9DD7FF9DD7FFA0D9FFA0D9FFA0B4BFAF9B96FFE8E0FFF8F0FFF0E0FFE8E0F0D8
      D0F0D0B0F0C0A000A00000A00000A000705840604830737470A0D9FFA0D9FFA0
      D9FFA3DBFFA3DBFFAF9487E0D8D0FFFFFFFFFFFFFFFFFFFFFFFFFFF0F0F0E0E0
      F0D8C000FF1000FFB000A000806850705040604830A3DBFFA3DBFFA3DBFFA6DD
      FFA6DDFFB09080F0E8E0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F0F0E8E000
      FF1000FF1000A000907060706050604830A6DDFFA6DDFFA6DDFFA9DFFFA9DFFF
      B09880D0C0B0D0B8B0C0B0A0B0A090B09880A088809080709070608068608060
      50705850908070806860705840A9DFFFA9DFFFA9DFFFACE0FFACE0FFC0A090FF
      F8F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F0FFF0F0F0F0F0F0E8E0
      A08880907860806050ACE0FFACE0FFACE0FFACE1FFACE1FFA8C5D2AFA08FD0B0
      A0C0A8A0D0B0A0C0A090B09080A08070907060806050706050807060B0A090A0
      8870806050ACE1FFACE1FFACE1FFAFE3FFAFE3FFAFE3FFA9C3CFC0B0A0E0C8C0
      FFFFFFFFF8FFFFF8FFFFF0F0F0F0E0F0E0E0C0A8A0806050A09080C0B0A08060
      50AFE3FFAFE3FFAFE3FFB3E5FFB3E5FFB3E5FFB3E5FFB5DBEDC0B0A0FFFFFFF0
      E8E0D0C8C0D0C8C0D0B8B0D0C0B0E0D0D0806860806050B09890B0A090B3E5FF
      B3E5FFB3E5FFB6E7FFB6E7FFB6E7FFB6E7FFB6E7FFC6C9C3F0E8E0FFFFFFFFFF
      FFFFFFFFFFF8FFFFF0F0F0E0D0D0B8B08060509EABB2B6E7FFB6E7FFB6E7FFB6
      E7FFBAE9FFBAE9FFBAE9FFBAE9FFBAE9FFBCE2F5D0B8B0FFFFFFF0F0F0D0C8C0
      D0C8C0D0B8B0C0B0B0E0D8D080706083685ABAE9FFBAE9FFBAE9FFBAE9FFBDEB
      FFBDEBFFBDEBFFBDEBFFBDEBFFBDEBFFC5D4DCDDD1D2FFFFFFFFFFFFFFFFFFFF
      FFFFFFF8FFF0E8E0D0B8B0806050B5D9E9BDEBFFBDEBFFBDEBFFC1EDFFC1EDFF
      C1EDFFC1EDFFC1EDFFC1EDFFC1EDFFC7D5DCD0C0B0D0C0B0D0C0B0D0C0B0D0C0
      B0D0C0B0D0C0B0D0C0B0C1EDFFC1EDFFC1EDFFC1EDFFC4EFFFC4EFFFC4EFFFC4
      EFFFC4EFFFC4EFFFC4EFFFC4EFFFC4EFFFC4EFFFC4EFFFC4EFFFC4EFFFC4EFFF
      C4EFFFC4EFFFC4EFFFC4EFFFC4EFFFC4EFFFC8F2FFC8F2FFC8F2FFC8F2FFC8F2
      FFC8F2FFC8F2FFC8F2FFC8F2FFC8F2FFC8F2FFC8F2FFC8F2FFC8F2FFC8F2FFC8
      F2FFC8F2FFC8F2FFC8F2FFC8F2FFCCF4FFCCF4FFCCF4FFCCF4FFCCF4FFCCF4FF
      CCF4FFCCF4FFCCF4FFCCF4FFCCF4FFCCF4FFCCF4FFCCF4FFCCF4FFCCF4FFCCF4
      FFCCF4FFCCF4FFCCF4FF}
  end
end