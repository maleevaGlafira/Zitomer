object dm_ItemSelecter: Tdm_ItemSelecter
  OldCreateOrder = False
  Left = 522
  Top = 356
  Height = 192
  Width = 243
  object dset: TIBDataSet
    Database = DM_main.IBDatabase
    Transaction = tran
    Left = 24
    Top = 16
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_main.IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 112
    Top = 16
  end
end
