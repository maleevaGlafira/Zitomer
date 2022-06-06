inherited dm_SvodPlanWorks: Tdm_SvodPlanWorks
  inherited frReport: TfrReport
    Dataset = frDBDataSet1
    ReportForm = {19000000}
  end
  object rm_result: TRxMemoryData
    FieldDefs = <>
    Left = 24
    Top = 128
    object rm_resultid_attach: TIntegerField
      FieldName = 'id_attach'
    end
    object rm_resultid: TIntegerField
      FieldName = 'nar_id'
    end
    object rm_resultid_revs: TIntegerField
      FieldName = 'id_revs'
    end
    object rm_resultrev: TStringField
      FieldName = 'rev'
    end
    object rm_resultnomer: TIntegerField
      FieldName = 'nomer'
    end
    object rm_resultbrig: TStringField
      FieldName = 'brig'
      Size = 25
    end
    object rm_resultdt_dep: TStringField
      FieldName = 'dt_dep'
    end
    object rm_resultdt_out: TStringField
      FieldName = 'dt_out'
    end
    object rm_resultadres: TStringField
      FieldName = 'adres'
      Size = 150
    end
    object rm_resultmest: TStringField
      FieldName = 'mest'
      Size = 40
    end
    object rm_resultattach: TStringField
      FieldName = 'attach'
      Size = 50
    end
    object rm_resultplanobors: TStringField
      FieldName = 'planobors'
      Size = 1000
    end
    object rm_resultworks_plan: TStringField
      FieldName = 'works_plan'
      Size = 1000
    end
    object rm_resultaddition: TStringField
      FieldName = 'addition'
      Size = 1000
    end
    object rm_resultNUMBERT: TIntegerField
      FieldName = 'NUMBERT'
    end
  end
  object dset: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = IBTransaction1
    Left = 16
    Top = 80
  end
  object frDBDataSet1: TfrDBDataSet
    DataSet = rm_result
    Left = 88
    Top = 32
  end
  object dset_works: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = IBTransaction1
    SelectSQL.Strings = (
      
        'select sw.name_r  from works_plan wp join s_work sw on sw.id= wp' +
        '.ID_WORK where wp.id_nar=:id')
    Left = 96
    Top = 96
  end
  object dset_obor: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = IBTransaction1
    SelectSQL.Strings = (
      
        'select ppo.NAME_R_AND_FIO name_r from planobors po join mexan pp' +
        'o on ppo.id=po.id_obor where po.id_nar=:id')
    Left = 104
    Top = 192
  end
  object IBTransaction1: TIBTransaction
    DefaultDatabase = DM_main.IBDatabase
    Left = 168
    Top = 40
  end
end
