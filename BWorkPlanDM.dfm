inherited dm_BWorkPlan: Tdm_BWorkPlan
  inherited tran_Main: TIBTransaction
    Active = True
  end
  inherited dset_BWork: TIBDataSet
    GeneratorField.Generator = 'GEN_BWORKS_PLAN_ID'
  end
end
