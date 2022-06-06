object sz_proisv: Tsz_proisv
  Left = 124
  Top = 56
  Width = 633
  Height = 612
  Caption = 'Произвольный поиск'
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 11
    Top = 14
    Width = 53
    Height = 16
    Caption = 'Номер с'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 152
    Top = 14
    Width = 16
    Height = 16
    Caption = 'по'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 11
    Top = 99
    Width = 36
    Height = 15
    Caption = 'Район'
  end
  object Label4: TLabel
    Left = 282
    Top = 99
    Width = 66
    Height = 15
    Caption = 'Эксп.район'
  end
  object Label5: TLabel
    Left = 11
    Top = 42
    Width = 9
    Height = 16
    Caption = 'С'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 191
    Top = 42
    Width = 16
    Height = 16
    Caption = 'по'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Lb_NmUl: TLabel
    Left = 7
    Top = 127
    Width = 36
    Height = 16
    Caption = 'Улица'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Lb_Ndom: TLabel
    Left = 208
    Top = 127
    Width = 86
    Height = 16
    Caption = 'номерa домов'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label11: TLabel
    Left = 11
    Top = 155
    Width = 60
    Height = 15
    Caption = 'Заявитель'
  end
  object Label12: TLabel
    Left = 7
    Top = 180
    Width = 63
    Height = 15
    Caption = 'Тип заявки'
  end
  object Label13: TLabel
    Left = 215
    Top = 184
    Width = 116
    Height = 15
    Caption = 'Содержание заявки'
  end
  object Label14: TLabel
    Left = 11
    Top = 67
    Width = 56
    Height = 15
    Caption = 'Оператор'
  end
  object Label15: TLabel
    Left = 32
    Top = 491
    Width = 45
    Height = 15
    Caption = 'Label15'
  end
  object SE_NomIn: TSpinEdit
    Left = 67
    Top = 11
    Width = 75
    Height = 24
    MaxValue = 100000
    MinValue = 0
    TabOrder = 0
    Value = 0
  end
  object SE_NomOut: TSpinEdit
    Left = 173
    Top = 11
    Width = 75
    Height = 24
    MaxValue = 100000
    MinValue = 0
    TabOrder = 1
    Value = 0
  end
  object DE_in: TDateEdit
    Left = 25
    Top = 39
    Width = 99
    Height = 20
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ButtonWidth = 19
    NumGlyphs = 2
    ParentFont = False
    YearDigits = dyFour
    TabOrder = 2
  end
  object TE_in: TMaskEdit
    Left = 131
    Top = 39
    Width = 53
    Height = 23
    EditMask = '!90:00;1;_'
    MaxLength = 5
    TabOrder = 3
    Text = '  :  '
  end
  object DE_out: TDateEdit
    Left = 212
    Top = 39
    Width = 99
    Height = 20
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ButtonWidth = 19
    NumGlyphs = 2
    ParentFont = False
    YearDigits = dyFour
    TabOrder = 4
  end
  object TE_out: TMaskEdit
    Left = 318
    Top = 39
    Width = 53
    Height = 23
    EditMask = '!90:00;1;_'
    MaxLength = 5
    TabOrder = 5
    Text = '  :  '
  end
  object BB_Ok: TBitBtn
    Left = 11
    Top = 533
    Width = 79
    Height = 29
    Caption = 'Показать'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    OnClick = BB_OkClick
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
  object DBL_raon: TRxDBLookupCombo
    Left = 78
    Top = 95
    Width = 184
    Height = 22
    DropDownCount = 8
    LookupField = 'name_r'
    LookupDisplay = 'name_r'
    LookupSource = DS_raon
    TabOrder = 7
  end
  object DBL_Revs: TRxDBLookupCombo
    Left = 357
    Top = 95
    Width = 132
    Height = 22
    DropDownCount = 8
    LookupField = 'Name_R'
    LookupDisplay = 'Name_r'
    LookupSource = DS_Revs
    TabOrder = 8
  end
  object DBL_ul1: TRxDBLookupCombo
    Left = 49
    Top = 124
    Width = 153
    Height = 24
    DropDownCount = 8
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    LookupField = 'name_r'
    LookupDisplay = 'name_r'
    LookupSource = DS_ul1
    ParentFont = False
    TabOrder = 9
  end
  object Ed_ndom: TEdit
    Left = 296
    Top = 124
    Width = 192
    Height = 23
    TabOrder = 10
  end
  object GrB_damg: TGroupBox
    Left = 11
    Top = 214
    Width = 459
    Height = 79
    Caption = 'Информация о повреждении'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 11
    object Label7: TLabel
      Left = 7
      Top = 21
      Width = 82
      Height = 16
      Caption = 'Повреждение'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 7
      Top = 49
      Width = 37
      Height = 16
      Caption = 'Место'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 191
      Top = 49
      Width = 51
      Height = 16
      Caption = 'Диаметр'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 236
      Top = 25
      Width = 63
      Height = 16
      Caption = 'Местность'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object DBL_damg: TRxDBLookupCombo
      Left = 102
      Top = 19
      Width = 128
      Height = 24
      DropDownCount = 8
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      LookupField = 'name_r'
      LookupDisplay = 'name_r'
      LookupSource = DS_Damg
      ParentFont = False
      TabOrder = 0
    end
    object DBL_place: TRxDBLookupCombo
      Left = 53
      Top = 47
      Width = 128
      Height = 24
      DropDownCount = 8
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      LookupField = 'name_r'
      LookupDisplay = 'name_r'
      LookupSource = DS_place
      ParentFont = False
      TabOrder = 1
    end
    object DBL_Diam: TRxDBLookupCombo
      Left = 251
      Top = 47
      Width = 60
      Height = 24
      DropDownCount = 8
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      LookupField = 'diam'
      LookupDisplay = 'diam'
      LookupSource = DS_diam
      ParentFont = False
      TabOrder = 2
    end
    object DBL_mest: TRxDBLookupCombo
      Left = 307
      Top = 19
      Width = 128
      Height = 24
      DropDownCount = 8
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      LookupField = 'name_r'
      LookupDisplay = 'name_r'
      LookupSource = DS_mest
      ParentFont = False
      TabOrder = 3
    end
  end
  object DBL_zav: TRxDBLookupCombo
    Left = 81
    Top = 152
    Width = 118
    Height = 22
    DropDownCount = 8
    LookupField = 'name_r'
    LookupDisplay = 'name_r'
    LookupSource = DS_zav
    TabOrder = 12
  end
  object DBL_sod: TRxDBLookupCombo
    Left = 342
    Top = 180
    Width = 128
    Height = 22
    DropDownCount = 8
    LookupField = 'name_r'
    LookupDisplay = 'name_r'
    LookupSource = DS_sod
    TabOrder = 13
  end
  object DBL_tzav: TRxDBLookupCombo
    Left = 78
    Top = 180
    Width = 110
    Height = 22
    DropDownCount = 8
    LookupField = 'name_r'
    LookupDisplay = 'name_r'
    LookupSource = DS_tzav
    TabOrder = 14
  end
  object DBL_brig: TRxDBLookupCombo
    Left = 81
    Top = 67
    Width = 181
    Height = 22
    DropDownCount = 8
    Enabled = False
    LookupField = 'NAME'
    LookupDisplay = 'NAME'
    LookupSource = DS_Brig
    TabOrder = 15
  end
  object BB_Close: TBitBtn
    Left = 406
    Top = 540
    Width = 79
    Height = 29
    Caption = 'Выход'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 16
    OnClick = BB_CloseClick
    Kind = bkClose
  end
  object BitBtn1: TBitBtn
    Left = 138
    Top = 540
    Width = 66
    Height = 22
    Caption = 'BitBtn1'
    TabOrder = 17
    OnClick = BitBtn1Click
  end
  inline Frm_SDb1: TFrm_SDb
    Left = 15
    Top = 300
    Width = 423
    Height = 108
    Font.Height = -9
    TabOrder = 18
    inherited Lb_name: TLabel
      Top = 5
    end
    inherited DBLC_sear: TRxDBLookupCombo
      Left = 49
      Width = 371
      Height = 20
      Font.Height = -9
    end
    inherited GrB_Spis: TGroupBox
      Left = 160
      Top = 21
      Width = 259
      Height = 85
      Font.Height = -9
      inherited LB_Sear: TListBox
        Left = 4
        Top = 12
        Width = 185
        Height = 67
      end
      inherited BB_Add: TBitBtn
        Left = 192
        Top = 11
        Width = 62
        Height = 20
      end
      inherited BB_Del: TBitBtn
        Left = 192
        Top = 34
        Width = 62
        Height = 21
      end
      inherited BB_Clear: TBitBtn
        Left = 192
        Top = 58
        Width = 62
        Height = 21
      end
    end
    inherited GrB_like: TGroupBox
      Top = 21
      Width = 156
      Height = 85
      Font.Height = -9
      inherited Ed_sear: TEdit
        Left = 5
        Top = 22
        Width = 145
      end
      inherited BB_like: TBitBtn
        Left = 7
        Top = 53
        Width = 66
        Height = 22
      end
    end
    inherited Povrezhd_rg: TRadioGroup
      Top = 48
      Width = 419
      Height = 30
      Font.Height = -9
    end
  end
  object Button1: TButton
    Left = 240
    Top = 547
    Width = 66
    Height = 22
    Caption = 'Button1'
    TabOrder = 19
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 325
    Top = 526
    Width = 66
    Height = 22
    Caption = 'Button2'
    TabOrder = 20
    OnClick = Button2Click
  end
  object Qry_tmp: TQuery
    DatabaseName = 'DBN_AVAR'
    Left = 476
    Top = 4
  end
  object DS_raon: TDataSource
    DataSet = Qry_Raon
    Left = 92
    Top = 108
  end
  object Qry_Raon: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id,name_r from s_rayon order by name_r')
    Left = 136
    Top = 104
  end
  object Qry_Revs: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id,name_r from s_revs order by name_r')
    Left = 468
    Top = 108
  end
  object DS_Revs: TDataSource
    DataSet = Qry_Revs
    Left = 508
    Top = 108
  end
  object Qry_ul1: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      
        'select u.id id,u.name_r||" "||v.name_r name_r,u.orint  from s_ul' +
        'ic u,s_vidul v'
      'where u.id_vidul=v.id order by u.name_r')
    Left = 88
    Top = 140
  end
  object DS_ul1: TDataSource
    DataSet = Qry_ul1
    Left = 164
    Top = 140
  end
  object DS_Damg: TDataSource
    DataSet = Qry_Damg
    Left = 160
    Top = 260
  end
  object Qry_Damg: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id,name_r from s_damg order by name_r')
    Left = 200
    Top = 256
  end
  object DS_place: TDataSource
    DataSet = Qry_place
    Left = 100
    Top = 292
  end
  object Qry_place: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id,name_r from s_place  order by name_r')
    Left = 148
    Top = 288
  end
  object Qry_diam: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id,cast(diam as char(4)) diam from s_diam  order by diam')
    Left = 288
    Top = 292
  end
  object DS_diam: TDataSource
    DataSet = Qry_diam
    Left = 320
    Top = 292
  end
  object DS_mest: TDataSource
    DataSet = Qry_mest
    Left = 384
    Top = 260
  end
  object Qry_mest: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id,name_r from s_mest order by name_r')
    Left = 432
    Top = 264
  end
  object DS_zav: TDataSource
    DataSet = Qry_zav
    Left = 112
    Top = 168
  end
  object Qry_zav: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id,name_r from s_zav order by name_r')
    Left = 148
    Top = 168
  end
  object Qry_tzav: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id,name_r,isviezd from s_tzav order by name_r')
    Left = 112
    Top = 200
  end
  object DS_tzav: TDataSource
    DataSet = Qry_tzav
    Left = 152
    Top = 200
  end
  object Qry_sod: TQuery
    DatabaseName = 'DBN_AVAR'
    SQL.Strings = (
      'select id,name_r from s_sod order by name_r')
    Left = 408
    Top = 204
  end
  object DS_sod: TDataSource
    DataSet = Qry_sod
    Left = 456
    Top = 200
  end
  object Qry_Brig: TQuery
    DatabaseName = 'dbn_avar'
    SQL.Strings = (
      'select id,name_r,name_r||" "||dolgn name,prava from s_brig'
      '/*where id=-1 or prava like "%WRITE%"*/ order by name_r')
    Left = 124
    Top = 76
  end
  object DS_Brig: TDataSource
    DataSet = Qry_Brig
    Left = 172
    Top = 72
  end
end
