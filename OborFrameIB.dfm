inherited frame_Obor: Tframe_Obor
  Width = 529
  inherited DBGrid: TDBGridEh
    Width = 489
    Columns = <
      item
        FieldName = 'NAME_R'
        Footers = <>
      end
      item
        FieldName = 'WORK_TIME'
        Footers = <>
      end>
  end
  inherited pnl_Fields: TPanel
    Width = 487
    object Label1: TLabel
      Left = 34
      Top = 27
      Width = 70
      Height = 13
      Caption = #1052#1077#1093#1072#1085#1080#1079#1084#1099
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 16
      Top = 56
      Width = 86
      Height = 13
      Caption = #1042#1088#1077#1084#1103' '#1088#1072#1073#1086#1090#1099
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object dbl_mexan: TRxDBLookupCombo
      Left = 120
      Top = 24
      Width = 361
      Height = 21
      DropDownCount = 8
      DataField = 'ID_OBOR'
      DataSource = ds_Main
      LookupField = 'ID'
      LookupDisplay = 'NAME_R_AND_FIO'
      LookupSource = ds_mexan
      TabOrder = 0
    end
    object tdb_workTime: TDBDateTimeEditEh
      Left = 120
      Top = 56
      Width = 119
      Height = 21
      DataField = 'WORK_TIME'
      DataSource = ds_Main
      EditButton.Style = ebsUpDownEh
      Kind = dtkTimeEh
      TabOrder = 1
    end
  end
  inherited dset_Main: TIBDataSet
    BeforeDelete = dset_MainBeforeDelete
    DeleteSQL.Strings = (
      'delete from obors where id=:old_id')
    InsertSQL.Strings = (
      'insert into  obors (id_zav,id_nar,id_obor,WORK_TIME)'
      'values (:id_Zav,:id_Nar,:id_obor,:WORK_TIME)')
    SelectSQL.Strings = (
      'SELECT o.id, id_zav, id_nar, id_obor, sm.name_r, WORK_TIME'
      'FROM obors o join mexan sm on o.id_obor=sm.id'
      'WHERE (id_zav = :idZav)and'
      '               (id_nar = :idNar)'
      'ORDER BY id')
    ModifySQL.Strings = (
      'update obors set id_obor=:id_obor, WORK_TIME=:WORK_TIME'
      ' where id=:old_id')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_OBORS'
    object dset_MainID: TIntegerField
      FieldName = 'ID'
      Origin = 'OBORS.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_MainID_ZAV: TIntegerField
      FieldName = 'ID_ZAV'
      Origin = 'OBORS.ID_ZAV'
    end
    object dset_MainID_NAR: TIntegerField
      FieldName = 'ID_NAR'
      Origin = 'OBORS.ID_NAR'
    end
    object dset_MainID_OBOR: TIntegerField
      FieldName = 'ID_OBOR'
      Origin = 'OBORS.ID_OBOR'
    end
    object dset_MainNAME_R: TIBStringField
      DisplayLabel = #1052#1077#1093#1072#1085#1080#1079#1084#1099
      FieldName = 'NAME_R'
      Origin = 'S_OBOR.NAME_R'
      FixedChar = True
      Size = 25
    end
    object dset_MainWORK_TIME: TDateTimeField
      FieldName = 'WORK_TIME'
      Origin = 'OBORS.WORK_TIME'
      DisplayFormat = 'hh:mm:ss'
    end
  end
  object dset_mexan: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tr_Voc
    SelectSQL.Strings = (
      'SELECT *'
      'FROM MEXAN s'
      'WHERE s.del in ('#39'-'#39') and s.id > 0'
      'ORDER BY s.name_r,s.fio')
    Left = 280
    Top = 56
    object dset_mexanNAME_R: TIBStringField
      FieldName = 'NAME_R'
      Origin = 'MEXAN.NAME_R'
      FixedChar = True
      Size = 25
    end
    object dset_mexanFIO: TIBStringField
      FieldName = 'FIO'
      Origin = 'MEXAN.FIO'
      FixedChar = True
      Size = 25
    end
    object dset_mexanID: TIntegerField
      FieldName = 'ID'
      Origin = 'MEXAN.ID'
    end
    object dset_mexanDEL: TIBStringField
      FieldName = 'DEL'
      Origin = 'MEXAN.DEL'
      FixedChar = True
      Size = 1
    end
    object dset_mexanNAME_R_AND_FIO: TIBStringField
      FieldName = 'NAME_R_AND_FIO'
      Origin = 'MEXAN.NAME_R_AND_FIO'
      FixedChar = True
      Size = 52
    end
  end
  object ds_mexan: TDataSource
    DataSet = dset_mexan
    Left = 80
    Top = 48
  end
  object dset_fromPlan: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tr_Main
    Left = 504
    Top = 136
  end
  object IBSQL_fromplan: TIBSQL
    Database = DM_main.IBDatabase
    SQL.Strings = (
      'insert into obors (id_obor, work_time, ID_ZAV, ID_NAR)'
      'SELECT  id_obor, :data, :ID_ZAV ,:iD_NAR'
      'FROM planobors'
      'WHERE (id_zav = :id_Zav)and'
      '               (id_nar = :id_Nar)'
      '               and id_obor<>all'
      
        '               (select o.id_obor from obors o where o.id_zav=:id' +
        '_zav and o.id_nar=:id_nar )')
    Transaction = tr_Main
    Left = 480
    Top = 144
  end
end
