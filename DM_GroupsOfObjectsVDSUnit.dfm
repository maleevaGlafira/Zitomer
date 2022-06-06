object DM_GroupsOfObjectsVDS: TDM_GroupsOfObjectsVDS
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 604
  Top = 320
  Height = 185
  Width = 297
  object qSelectObjectsVDS: TQuery
    DatabaseName = 'DBN_AVAR'
    Left = 52
    Top = 12
  end
  object qTmp: TQuery
    DatabaseName = 'DBN_AVAR'
    Left = 140
    Top = 20
  end
  object qTmp2: TQuery
    DatabaseName = 'DBN_AVAR'
    Left = 180
    Top = 20
  end
end
