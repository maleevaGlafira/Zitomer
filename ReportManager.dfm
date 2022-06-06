object DM_ReportManager: TDM_ReportManager
  OldCreateOrder = False
  Left = 297
  Top = 309
  Height = 271
  Width = 421
  object frReport: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbPrint, pbExit]
    RebuildPrinter = False
    Left = 16
    Top = 16
    ReportForm = {19000000}
  end
  object dset_tmp1: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = Transac
    Left = 16
    Top = 144
  end
  object Transac: TIBTransaction
    DefaultDatabase = DM_main.IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 88
    Top = 80
  end
  object dset_tmp2: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = Transac
    Left = 96
    Top = 144
  end
  object dset_tmp3: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = Transac
    Left = 184
    Top = 144
  end
  object pind_Load: TProgressIndicator
    Caption = 'Progress Indicator'
    CancelCaption = 'Cancel'
    Left = 320
    Top = 16
  end
  object frDBDataSet1: TfrDBDataSet
    DataSet = dset_tmp1
    Left = 16
    Top = 80
  end
  object IBSQL: TIBSQL
    Database = DM_main.IBDatabase
    Transaction = Tran_IBSQL
    Left = 328
    Top = 80
  end
  object Tran_IBSQL: TIBTransaction
    DefaultDatabase = DM_main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 328
    Top = 136
  end
  object dset_AvrImage: TIBDataSet
    Database = DM_main.IBDB_AvrImage
    Transaction = transac_AvrImage
    Left = 192
    Top = 16
  end
  object transac_AvrImage: TIBTransaction
    DefaultDatabase = DM_main.IBDB_AvrImage
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 192
    Top = 72
  end
end
