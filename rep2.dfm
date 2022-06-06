object RepMatF: TRepMatF
  Left = 249
  Top = 253
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1060#1086#1088#1084#1072' 2'
  ClientHeight = 367
  ClientWidth = 562
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
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
    Width = 562
    Height = 367
    Align = alClient
    BevelInner = bvLowered
    BorderWidth = 1
    TabOrder = 0
    object Bevel1: TBevel
      Left = 291
      Top = 288
      Width = 110
      Height = 13
      ParentShowHint = False
      Shape = bsTopLine
      ShowHint = False
    end
    object BtOk: TBitBtn
      Left = 292
      Top = 294
      Width = 110
      Height = 25
      Caption = #1055#1088#1080#1085#1103#1090#1100
      Default = True
      ModalResult = 1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = BtOkClick
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
    object BExit: TBitBtn
      Left = 292
      Top = 321
      Width = 110
      Height = 25
      Caption = #1042#1099#1093#1086#1076
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Kind = bkClose
    end
    object Vidrep_rg: TRadioGroup
      Left = 291
      Top = 36
      Width = 111
      Height = 189
      ItemIndex = 0
      Items.Strings = (
        #1044#1080#1072#1084#1077#1090#1088
        #1062#1077#1093
        #1062#1077#1093' 2')
      TabOrder = 2
      OnClick = Vidrep_rgClick
    end
    inline Frm_Dt: TFrm_Date
      Left = 6
      Top = 3
      Width = 425
      Height = 38
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      inherited Label1: TLabel
        Left = 2
        Top = 8
        Font.Height = -15
      end
      inherited Label2: TLabel
        Left = 199
        Top = 9
        Font.Height = -15
      end
      inherited DE_In: TDateEdit
        Left = 16
        Top = 6
        Width = 93
        Font.Height = -15
        ButtonWidth = 19
        OnChange = FrmData_Change
      end
      inherited Te_in: TDateTimePicker
        Left = 112
        Top = 6
        Width = 82
        Font.Height = -15
      end
      inherited DE_Out: TDateEdit
        Left = 220
        Top = 6
        Width = 93
        Font.Height = -15
        ButtonWidth = 19
      end
      inherited Te_Out: TDateTimePicker
        Left = 321
        Top = 6
        Width = 75
        Font.Height = -15
      end
    end
    object Mat_lch: TCheckListBox
      Left = 5
      Top = 41
      Width = 284
      Height = 305
      OnClickCheck = Mat_lchClickCheck
      ItemHeight = 13
      TabOrder = 4
    end
    object BCheck: TBitBtn
      Left = 291
      Top = 231
      Width = 110
      Height = 25
      Caption = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1077
      Default = True
      ModalResult = 1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = BCheckClick
      Glyph.Data = {
        42010000424D4201000000000000760000002800000011000000110000000100
        040000000000CC00000000000000000000001000000010000000000000000000
        BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        7777700000007777777777777777700000007777777774F77777700000007777
        7777444F77777000000077777774444F777770000000700000444F44F7777000
        000070FFF444F0744F777000000070F8884FF0774F777000000070FFFFFFF077
        74F77000000070F88888F077774F7000000070FFFFFFF0777774F000000070F8
        8777F07777774000000070FFFF00007777777000000070F88707077777777000
        000070FFFF007777777770000000700000077777777770000000777777777777
        777770000000}
    end
    object BUnCheck: TBitBtn
      Left = 291
      Top = 258
      Width = 110
      Height = 25
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1074#1089#1077
      Default = True
      ModalResult = 1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      OnClick = BUnCheckClick
      Glyph.Data = {
        42010000424D4201000000000000760000002800000011000000110000000100
        040000000000CC00000000000000000000001000000010000000000000000000
        BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        7777700000007770000777777777700000007770FB0774444444700000007770
        BF0777777777700000007770F007777777777000000077700077777777777000
        0000777777777777777770000000700700700700700070000000777777777777
        7777700000007070000777777770700000007070BF0770000070700000007770
        FB0777777777700000007070B007777777707000000070700077777777707000
        0000777777777777777770000000700700700700700070000000777777777777
        777770000000}
    end
    object EmptyRows_chb: TCheckBox
      Left = 7
      Top = 347
      Width = 268
      Height = 14
      Caption = #1053#1077' '#1087#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1085#1091#1083#1077#1074#1099#1077' '#1089#1090#1088#1086#1082#1080
      Checked = True
      State = cbChecked
      TabOrder = 7
    end
    object NaimMaterPanel: TPanel
      Left = 408
      Top = 3
      Width = 151
      Height = 361
      Align = alRight
      TabOrder = 8
      Visible = False
      object Label1: TLabel
        Left = 56
        Top = 7
        Width = 19
        Height = 13
        Caption = #1062#1077#1093
      end
      object Label2: TLabel
        Left = 48
        Top = 187
        Width = 56
        Height = 13
        Caption = #1041#1088#1080#1075#1072#1076#1080#1088#1099
      end
      object Bevel2: TBevel
        Left = 0
        Top = 176
        Width = 150
        Height = 3
      end
      object RayonCheckListBox: TCheckListBox
        Left = 3
        Top = 27
        Width = 147
        Height = 147
        OnClickCheck = RayonCheckListBoxClickCheck
        ItemHeight = 13
        TabOrder = 0
      end
      object BrigCheckListBox: TCheckListBox
        Left = 3
        Top = 208
        Width = 146
        Height = 151
        OnClickCheck = BrigCheckListBoxClickCheck
        ItemHeight = 13
        TabOrder = 1
      end
    end
  end
  object Qr1: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'SELECT d.diam, count(z.id)'
      'FROM s_diam d LEFT JOIN nzavjav z'
      '      ON (z.id_diam = d.id)and'
      '         (z.dt_in >= :dt_begin)and(z.dt_in <= :dt_end)'
      '      LEFT JOIN s_sod sod'
      '        on (z.id_sod = sod.id)'
      'WHERE (delz=0) and (z.id_sod = :idsod)'
      'GROUP BY d.diam')
    Left = 168
    Top = 100
    ParamData = <
      item
        DataType = ftDate
        Name = 'dt_begin'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'dt_end'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'idsod'
        ParamType = ptInput
      end>
  end
  object BrigRayQuery: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select sum(matr.kol_mat) as c'
      'from zavjav z, narad n,maters matr,s_mat sm'
      'where (delz=0) and (z.id=n.id_zav)'
      '    and (z.id_revs=:id_rayon)'
      '    and (n.id_brig=:id_brig)'
      '    and  (sm.name_r=:m_name) and'
      
        '    (matr.id > 0) and (sm.id=matr.id_mat) and (z.id=matr.id_zav)' +
        ' and (id_attach=:attach)')
    Left = 208
    Top = 144
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id_rayon'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'id_brig'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'm_name'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'attach'
        ParamType = ptUnknown
      end>
  end
end
