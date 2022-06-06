object DM_Reports: TDM_Reports
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 1060
  Top = 256
  Height = 328
  Width = 206
  object frReportAll: TfrReport
    InitialZoom = pzDefault
    ModifyPrepared = False
    PreviewButtons = [pbZoom, pbPrint, pbFind, pbExit]
    RebuildPrinter = False
    Left = 24
    Top = 8
    ReportForm = {19000000}
  end
  object frDBDataSet1: TfrDBDataSet
    CloseDataSource = True
    DataSet = DM_VedomPublic.Qry_Zadv
    Left = 104
    Top = 16
  end
  object frUserDataset1: TfrUserDataset
    Left = 32
    Top = 80
  end
  object frUserDataset2: TfrUserDataset
    Left = 120
    Top = 80
  end
  object frUserDataset3: TfrUserDataset
    Left = 32
    Top = 152
  end
  object frDBDataSet2: TfrDBDataSet
    DataSet = DM_VedomPublic.Qry_narad
    Left = 104
    Top = 144
  end
end
