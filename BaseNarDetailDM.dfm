object dm_BaseNarDetail: Tdm_BaseNarDetail
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 465
  Top = 251
  Height = 246
  Width = 347
  object tran_Main: TIBTransaction
    DefaultDatabase = DM_main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 32
    Top = 16
  end
  object tran_Spr: TIBTransaction
    DefaultDatabase = DM_main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 32
    Top = 96
  end
end
