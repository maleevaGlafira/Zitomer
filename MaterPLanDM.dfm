inherited dm_MaterPlan: Tdm_MaterPlan
  inherited tran_Main: TIBTransaction
    Active = True
  end
  inherited dset_Mater: TIBDataSet
    GeneratorField.Generator = 'GEN_MATERS_PLAN'
  end
end
