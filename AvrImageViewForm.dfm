object frm_AvrImageView: Tfrm_AvrImageView
  Left = 271
  Top = 179
  Width = 526
  Height = 484
  Caption = #1048#1079#1086#1073#1088#1072#1078#1077#1085#1080#1103
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object pnl_Btns: TPanel
    Left = 0
    Top = 0
    Width = 510
    Height = 26
    Align = alTop
    TabOrder = 0
    DesignSize = (
      510
      26)
    object sp_first: TSpeedButton
      Left = 2
      Top = 2
      Width = 23
      Height = 22
      Hint = '1-'#1086#1077' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1077' '
      Flat = True
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFF0FFFFFFFF0FFFFFF0FFFFFF000FFFFFF0FFFF00000FFFFFF0FF000000
        0FFFFFF0FFFF00000FFFFFF0FFFFFF000FFFFFF0FFFFFFFF0FFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      ParentShowHint = False
      ShowHint = True
      OnClick = sp_firstClick
    end
    object sp_prev: TSpeedButton
      Left = 25
      Top = 2
      Width = 23
      Height = 22
      Hint = #1055#1088#1077#1076#1099#1076#1091#1097#1077#1077' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1077
      Flat = True
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF0FFFFFFFFFFFFF000FFFFFFFFFFF00000FFFFFFFFF0000000F
        FFFFFFFFFF00000FFFFFFFFFFFFF000FFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      ParentShowHint = False
      ShowHint = True
      OnClick = sp_prevClick
    end
    object sp_last: TSpeedButton
      Left = 71
      Top = 2
      Width = 23
      Height = 22
      Hint = #1055#1086#1089#1083#1077#1076#1085#1077#1077' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1077
      Flat = True
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFF0FFFFFFFF0FFFFFF000FFFFFF0FFFFFF00000FFFF0FFFFFF0000000FF
        0FFFFFF00000FFFF0FFFFFF000FFFFFF0FFFFFF0FFFFFFFF0FFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      ParentShowHint = False
      ShowHint = True
      OnClick = sp_lastClick
    end
    object sp_next: TSpeedButton
      Left = 48
      Top = 2
      Width = 23
      Height = 22
      Hint = #1057#1083#1077#1076#1091#1102#1097#1077#1077' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1077
      Flat = True
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFF0FFFFFFFFFFFFFFF000FFFFFFFFFFFFF00000FFFFFFFFFFF0000000
        FFFFFFFFF00000FFFFFFFFFFF000FFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      ParentShowHint = False
      ShowHint = True
      OnClick = sp_nextClick
    end
    object sp_add: TSpeedButton
      Left = 152
      Top = 2
      Width = 23
      Height = 22
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1077
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        20000000000000040000120B0000120B00000000000000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FBFBFB00EEEEEE00DADADA00CDCDCD00CDCDCD00DADA
        DA00F2F2F200FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FBFBFB00E7E7E700C2C2C200A0A0A00097979700B0B0
        B000DADADA00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00F9F9F900EEEEEE000000000000000000000000009696
        9600CDCDCD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FBFB
        FB00EFEFEF00E1E1E100E1E1E100EBEBEB000000000000000000000000008787
        8700A7A7A700CDCDCD00DADADA00F2F2F200FFFFFF00FFFFFF00FFFFFF00FCFC
        FC00E8E8E800CBCBCB00C1C1C100D5D5D5000000000000000000000000008282
        82008080800090909000B0B0B000DADADA00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FAFAFA000000000000000000000000000000000000000000000000000000
        00000000000000000000A0A0A000CFCFCF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00313131001B1B1B00151515001313130000000000000000000000
        00000000000000000000B3B3B300D5D5D500FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00878787008686860077777700555555001F1F1F00000000000606
        06000505050000000000DCDCDC00E7E7E700FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00717171002525250000000000F5F5
        F500FFFFFF00FFFFFF00FCFCFC00F8F8F800FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007E7E7E003434340000000000E0E0
        E000FAFAFA00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008D8D8D005858580000000000E6E6
        E600F2F2F200FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFD
        FD00FAFAFA00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
      ParentShowHint = False
      ShowHint = True
      OnClick = sp_addClick
    end
    object sp_delete: TSpeedButton
      Left = 182
      Top = 2
      Width = 23
      Height = 22
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1077
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        20000000000000040000120B0000120B00000000000000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FBFB
        FB00F4F4F400E9E9E900DDDDDD00D7D7D700D4D4D400D4D4D400D4D4D400D4D4
        D400D4D4D400D8D8D800E0E0E000EBEBEB00F6F6F600FDFDFD00FFFFFF00F6F6
        F600DFDFDF00BBBBBB0096969600808080007777770077777700777777007777
        7700797979008181810098989800BCBCBC00E1E1E100F7F7F700FFFFFF00F8F8
        F800D3D3D300999999005D5D5D00404040004040400040404000404040004040
        40004040400040404000484848007E7E7E00C2C2C200EEEEEE00FFFFFF00FFFF
        FF00F4F4F40019191900121212000C0C0C000A0A0A0009090900090909000909
        090009090900080808000909090071717100B6B6B600EAEAEA00FFFFFF00FFFF
        FF00FFFFFF00505050002B2B2B00121212000101010000000000000000000000
        00000000000000000000131313009C9C9C00C5C5C500EDEDED00FFFFFF00FFFF
        FF00FFFFFF00939393009C9C9C00949494008C8C8C008C8C8C008C8C8C008B8B
        8B007C7C7C005656560023232300E2E2E200E6E6E600F6F6F600FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFE00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
      ParentShowHint = False
      ShowHint = True
      OnClick = sp_deleteClick
    end
    object sp_exit: TSpeedButton
      Left = 477
      Top = 2
      Width = 23
      Height = 22
      Hint = #1042#1099#1093#1086#1076
      Anchors = [akTop, akRight]
      Flat = True
      Glyph.Data = {
        26040000424D2604000000000000360000002800000012000000120000000100
        180000000000F0030000120B0000120B00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFF0000FFFFFFFFFFFF626FA2091D6B0B1B5A0C1A520C1A520B
        1A540B1A5309195406185605175604155501145400104C383F5CFFFFFFFFFFFF
        0000FFFFFFFFFFFF1031B81937AD1E379A1F358E1F358F1D358F1B358F183491
        1331920E2F92092C92042489011B72001255FFFFFFFFFFFF0000FFFFFFFFFFFF
        193FD52C4FDD3555D73E5ACD7284D4CACFE0E4E4E4E4E4E4C5CCE06683D71244
        D00938C0032795021764FFFFFFFFFFFF0000FFFFFFFFFFFF254ADF6580E96882
        E9A2B2F2FFFFFFBBC8F6738FEE708FEFBACAF8FFFFFF98B1F60E44D8072EA403
        1A6BFFFFFFFFFFFF0000FFFFFFFFFFFF2F53E16D85EAA1B1F1FFFFFF8398EE47
        6AE64167E73864E82D5EE97394F1FFFFFF6482DE0C32A4071D6BFFFFFFFFFFFF
        0000FFFFFFFFFFFF385AE2748BEBEFF2FDBBC6F54F6EE64A6BE6FFFFFFFFFFFF
        2E5DE82557E8B6C7F8CBD2E81235A30B206BFFFFFFFFFFFF0000FFFFFFFFFFFF
        4161E47A90ECFFFFFF8195ED516EE64969E5FFFFFFFFFFFF2D59E62453E66687
        EEECECEC1738A30E226AFFFFFFFFFFFF0000FFFFFFFFFFFF4766E58095EDFFFF
        FF8195ED516DE64968E5FFFFFFFFFFFF2D56E42551E46583ECECECEC1C3AA211
        236AFFFFFFFFFFFF0000FFFFFFFFFFFF516EE6879BEDF2F4FDB7C2F5526DE649
        66E4FFFFFFFFFFFF2D53E2274FE2B0BFF5CFD5E81F3BA013246AFFFFFFFFFFFF
        0000FFFFFFFFFFFF5571E78EA0EFABBAF4FFFFFF8193ED4D68E54362E43B5CE3
        3155E26D86EBFFFFFF6A80DA223CA0142569FFFFFFFFFFFF0000FFFFFFFFFFFF
        607BE899AAF08CA0EFA6B5F2FFFFFFB1BDF47186EA6C83E9B0BDF4FFFFFF95A8
        F02D4ED0233DA0142569FFFFFFFFFFFF0000FFFFFFFFFFFF889CEEC3CDF7BEC9
        F69CADF1B7C3F5F3F5FDFFFFFFFFFFFFF0F3FDAEBBF37D93EC3C5EE32744B113
        2672FFFFFFFFFFFF0000FFFFFFFFFFFFBBC6F5E5E9FBDBE1FAC1CBF6BDC8F6BA
        C5F5B8C3F5B6C2F5B4C0F4B1BEF4ADBBF37D93EC2C4CC9132A88FFFFFFFFFFFF
        0000FFFFFFFFFFFFE9EDFCD8DEF9BCC7F6A4B3F2A0AFF29DADF19AABF19BABF0
        98A9F094A6EF92A5EF758CEB2549D87988C3FFFFFFFFFFFF0000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFF0000}
      ParentShowHint = False
      ShowHint = True
      OnClick = sp_exitClick
    end
    object sp_Print: TSpeedButton
      Left = 215
      Top = 2
      Width = 23
      Height = 22
      Hint = #1055#1077#1095#1072#1090#1072#1090#1100' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1077
      Flat = True
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
      ParentShowHint = False
      ShowHint = True
      OnClick = sp_PrintClick
    end
  end
  object sbar: TStatusBar
    Left = 0
    Top = 427
    Width = 510
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object pnl_Img: TPanel
    Left = 0
    Top = 26
    Width = 510
    Height = 401
    Align = alClient
    Color = clGray
    TabOrder = 2
    object Image: TImage
      Left = 129
      Top = 73
      Width = 328
      Height = 224
      Stretch = True
    end
  end
  object OpenDlg: TOpenPictureDialog
    Filter = 
      'All (*.jpg;*.jpeg)|*.jpg;*.jpeg|JPEG Image File (*.jpg)|*.jpg|JP' +
      'EG Image File (*.jpeg)|*.jpeg'
    Left = 224
    Top = 136
  end
end
