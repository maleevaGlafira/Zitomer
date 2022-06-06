object DMStack: TDMStack
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 610
  Top = 248
  Height = 143
  Width = 183
  object Qry_tmp: TQuery
    DatabaseName = 'dbn_avar'
    SQL.Strings = (
      '')
    Left = 24
    Top = 12
  end
  object Qry_Tmp1: TQuery
    DatabaseName = 'dbn_avar'
    SQL.Strings = (
      '')
    Left = 72
    Top = 12
  end
end
