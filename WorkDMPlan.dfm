inherited dm_Work_Plan: Tdm_Work_Plan
  inherited tran_Main: TIBTransaction
    Active = True
  end
  inherited dset_Works: TIBDataSet
    GeneratorField.Generator = 'GEN_WORKS_PLAN'
  end
end
