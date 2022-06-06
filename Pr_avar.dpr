program Pr_avar;

{%ToDo 'Pr_avar.todo'}

uses
  Forms,
  main in 'main.pas' {FormMain},
  sprav in 'sprav.pas' {FormSprav},
  vvod_ol in 'vvod_ol.pas' {FormVvod},
  zav in 'zav.pas' {FormZav},
  cl_zadv in 'cl_zadv.pas' {FormClZadv},
  narad in 'narad.pas' {FormNarad},
  sporg in 'sporg.pas' {FormOrg},
  obor in 'obor.pas' {FormObor},
  fresult in 'fresult.pas' {FormResult},
  sz_nzav in 'sz_nzav.pas' {FormSZ_nzav},
  Vxod in 'Vxod.pas' {ZastFrm},
  Prosm in 'Prosm.pas' {ProsmForm},
  fm2pr in 'fm2pr.pas' {Form2Pr},
  Prosm2 in 'prosm2.PAS' {ProsmForm2},
  stat in 'stat.pas' {FormStatus},
  set_sah in 'set_sah.pas' {FormSSah},
  pro_zav in 'pro_zav.pas' {ProizZForm},
  pr_obor in 'pr_obor.pas' {FormPrOb},
  an_kvart in 'an_kvart.pas' {AnFormKvart},
  an_street in 'an_street.pas' {AnFormStreet},
  OpSQLEx in 'OpSQLEx.pas' {FormOpSQL},
  Zast in 'Zast.pas' {FormZast},
  frm_dat in 'FRM_DAT.PAS' {Frm_Date: TFrame},
  frm_srdb in 'FRM_SRDB.PAS' {Frm_SDb: TFrame},
  sz_prois2 in 'sz_prois2.pas' {Sz_proizv2},
  comp_zv in 'comp_zv.pas' {CompZReferF},
  datam in 'datam.pas' {DM1: TDataModule},
  baze_dic in 'baze_dic.pas' {BazeDicF},
  s_dolgn in 's_dolgn.pas' {S_BrigF},
  avartype in 'avartype.pas',
  s_alien in 's_alien.pas' {S_AlienF},
  s_damg in 's_damg.pas' {S_DamgF},
  s_sod in 's_sod.pas' {S_SodF},
  s_revs in 'S_REVS.PAS' {S_RevsF},
  s_work in 's_work.pas' {S_WorkF},
  s_place in 's_place.pas' {S_PlaceF},
  s_mat in 'S_MAT.PAS' {S_MatF},
  s_runw in 's_runw.pas' {S_RunwF},
  s_diam in 's_diam.pas' {S_DiamF},
  s_mest in 's_mest.pas' {S_MestF},
  s_zav in 's_zav.pas' {S_ZavF},
  s_obor in 's_obor.pas' {S_OborF},
  s_tzav in 's_tzav.pas' {S_TzavF},
  rep1 in 'rep1.pas' {Rep1F},
  rep2 in 'rep2.pas' {RepMatF},
  bazerep in 'bazerep.pas' {BazeRepQY_F},
  rep3 in 'rep3.pas' {Rep3F},
  rep4 in 'rep4.pas' {Rep4F},
  nastr in 'nastr.pas' {NastrF},
  logform in 'logform.pas' {TableLogF},
  s_vidul in 's_vidul.pas' {s_vidulF},
  s_ulic in 's_ulic.pas' {s_ulicF},
  s_rayons in 's_rayons.pas' {S_RayonsF},
  frmLANG in 'FRMLANG.PAS' {FormLang},
  cntsLANG in 'cntsLANG.pas',
  ver in 'ver.pas',
  constsUA in 'constsUA.pas',
  s_leak in 's_leak.PAS' {S_LeakF},
  s_clog in 's_clog.pas' {S_ClogF},
  s_Fill in 's_fill.pas' {S_FillF},
  s_Net in 's_net.pas' {S_NetF},
  s_local in 's_local.PAS' {S_LocalF},
  s_Killclog in 's_killclog.PAS' {S_KillclogF},
  s_PES in 's_pes.PAS' {S_PESF},
  s_pump in 's_pump.PAS' {S_PumpF},
  s_Owner in 's_owner.PAS' {S_OwnerF},
  fReport in 'fReport.pas' {frmReport},
  fPreview in 'fPreview.pas' {frmPreview},
  s_Comment in 's_comment.pas' {S_CommentF},
  sz_sah1 in 'sz_sah1.pas' {FormSah1},
  peoples in 'peoples.pas' {fmBrig},
  DgrForm in 'DGRFORM.pas' {Graph},
  AN_DIAGR in 'AN_DIAGR.pas' {QueryForm},
  Ras_Q in 'Ras_Q.pas' {fmRas_Q},
  SpreadSh in 'SpreadSh.pas' {fmSpreadSh},
  OborsSh in 'OborsSh.pas' {fmOborsSh},
  BackUpRestoreForm in 'BackUpRestoreForm.pas' {BRForm},
  DelFilesAfterExitUnit in 'DelFilesAfterExitUnit.pas',
  s_remont in 's_remont.pas' {S_RemontF},
  PoteriUnit in 'PoteriUnit.pas' {PoteriForm},
  reports_unit in 'reports_unit.pas' {DM_Reports: TDataModule},
  Report_Act_Unit in 'Report_Act_Unit.pas',
  Report_Parent_Unit in 'Report_Parent_Unit.pas',
  FrPrintDM in 'FrPrintDM.pas' {DM_Print: TDataModule},
  VedManagerUnit in 'VedManagerUnit.pas' {DM_VedManager: TDataModule},
  VedomsUnit in 'VedomsUnit.pas' {VedomsForm},
  Report_Zayav_Unit in 'Report_Zayav_Unit.pas',
  DM_VedomPublicUnit in 'DM_VedomPublicUnit.pas' {DM_VedomPublic: TDataModule},
  S_MatPipeFUnit in 'S_MatPipeFUnit.pas' {S_MatPipeF},
  StackUnit in 'StackUnit.pas' {DMStack: TDataModule},
  OperAttFormUnit in 'OperAttFormUnit.pas' {OperAttForm},
  ServiceFuncUnit in 'ServiceFuncUnit.pas',
  Zav_DMUnit in 'Zav_DMUnit.pas' {DM_Zavv: TDataModule},
  AppErrUnit in 'AppErrUnit.pas' {AppErrForm},
  QShevelevUnit in 'QShevelevUnit.pas',
  MadExtrapolateUnit in 'MadExtrapolateUnit.pas',
  WithOutWaterUnit in 'WithOutWaterUnit.pas' {WithoutWaterForm},
  s_planobor in 's_planobor.pas' {S_PlanOborF},
  fresult2 in 'fresult2.pas' {FormResult2},
  DMAvrImage in 'DMAvrImage.pas' {DM_AvrImage: TDataModule},
  AvrImageViewForm in 'AvrImageViewForm.pas' {frm_AvrImageView},
  s_vrk in 's_vrk.pas' {S_VRK_F},
  ReportManager in 'ReportManager.pas' {DM_ReportManager: TDataModule},
  BaseOptionForm in 'BaseOptionForm.pas' {frm_BaseOption},
  ZavWithImageOptForm in 'ZavWithImageOptForm.pas' {frm_ZavWithImageOpt},
  WithoutWaterOptForm in 'WithoutWaterOptForm.pas' {frm_WithoutWaterOpt},
  NGBaseReport in 'NGBaseReport.pas',
  NGReports in 'NGReports.pas',
  NGReportManager in 'NGReportManager.pas',
  WWaterDModule in 'WWaterDModule.pas' {DM_WWater: TDataModule},
  SvodVed2DModule in 'SvodVed2DModule.pas' {dm_SvodVed2: TDataModule},
  SvodVed2OptForm in 'SvodVed2OptForm.pas' {frm_SvodVed2Opt},
  S_DopAdres in 'S_DopAdres.pas' {S_DopAdresF},
  SearchAdresOptForm in 'SearchAdresOptForm.pas' {frm_SearchAdresOpt},
  SearchAdresDModule in 'SearchAdresDModule.pas' {dm_SearchAdres: TDataModule},
  UtechkiZaPeriodOptForm in 'UtechkiZaPeriodOptForm.pas' {frm_UtechkiZaPeriodOpt},
  UtechkiZaPeriodDModule in 'UtechkiZaPeriodDModule.pas' {dm_UtechkiZaPeriod: TDataModule},
  PatchWaitForm in 'PatchWaitForm.pas' {frm_PatchWait},
  SvodVed2AlienDModule in 'SvodVed2AlienDModule.pas' {dm_SvodVed2Alien: TDataModule},
  WorkDM in 'WorkDM.pas' {dm_Work: TDataModule},
  WorkForm in 'WorkForm.pas' {frm_Work},
  EditWorkForm in 'EditWorkForm.pas' {frm_EditWork},
  MaterDM in 'MaterDM.pas' {dm_Mater: TDataModule},
  BaseNarDetailDM in 'BaseNarDetailDM.pas' {dm_BaseNarDetail: TDataModule},
  WorkContainerDM in 'WorkContainerDM.pas' {dm_WorkContainer: TDataModule},
  EditMaterForm in 'EditMaterForm.pas' {frm_EditMater},
  SvodVedOtlNar in 'SvodVedOtlNar.pas' {frm_SvodVedOtlNar},
  BWorkDM in 'BWorkDM.pas' {dm_BWork: TDataModule},
  EditBWorkForm in 'EditBWorkForm.pas' {frm_EditBWork},
  AddBWorkForm in 'AddBWorkForm.pas' {frm_AddBWork},
  DelBWorkForm in 'DelBWorkForm.pas' {frm_DelBWork},
  HelpFunctions in 'HelpFunctions.pas',
  BaseWorkAndMatDM in 'BaseWorkAndMatDM.pas' {dm_BaseWorkAndMat: TDataModule},
  FastAddWorkForm in 'FastAddWorkForm.pas' {frm_FastAddWork},
  S_Trudozatrat in 'S_Trudozatrat.pas' {S_TrudozatratF},
  S_BWork in 'S_BWork.pas' {S_BWorkF},
  BworkShiefFrame in 'BworkShiefFrame.pas' {frame_BworkShief: TFrame},
  BworkShiefDM in 'BworkShiefDM.pas' {dm_BworkShief: TDataModule},
  AddWorkToBworkForm in 'AddWorkToBworkForm.pas' {frm_AddWorkToBwork},
  AddMaterToBworkForm in 'AddMaterToBworkForm.pas' {frm_AddMaterToBwork},
  OptEkonomPokazForm in 'OptEkonomPokazForm.pas' {frm_OptEkonomPokaz},
  SelDatePeriodFrame in 'SelDatePeriodFrame.pas' {frame_SelDatePeriod: TFrame},
  SelOperAttFrame in 'SelOperAttFrame.pas' {frame_SelOperAtt: TFrame},
  RootReportDModule in 'RootReportDModule.pas' {dm_RootReport: TDataModule},
  NGReportBaseDModule in 'NGReportBaseDModule.pas' {dm_NGReportBase: Tdm_RootReport},
  RepEkonomPokazDM in 'RepEkonomPokazDM.pas' {dm_RepEkonomPokaz: TDataModule},
  RepTrudoZatratDModule in 'RepTrudoZatratDModule.pas',
  OptTrudoZatrat in 'OptTrudoZatrat.pas' {frm_OptTrudoZatrat},
  WorkTimeCalcer in 'WorkTimeCalcer.pas',
  zav_obj in 'zav_obj.pas' {FormZavObj},
  FormZavFactory in 'FormZavFactory.pas',
  S_Instrum in 'S_Instrum.pas' {S_InstrumF},
  s_object in 's_object.pas' {s_ObjectF},
  S_ObjObor in 'S_ObjObor.pas' {S_ObjOborF},
  OptMatUseForm in 'OptMatUseForm.pas' {frm_OptMatUse},
  RepMatUseDM in 'RepMatUseDM.pas' {dm_RepMatUse: TDataModule},
  ItemSelecter in 'ItemSelecter.pas',
  ItemSelecterDModule in 'ItemSelecterDModule.pas' {dm_ItemSelecter: TDataModule},
  SelectItemForm in 'SelectItemForm.pas' {frm_SelectItem},
  SelAttachFrame in 'SelAttachFrame.pas' {frame_SelAttach: TFrame},
  BaseItemSelecterFrame in 'BaseItemSelecterFrame.pas' {frame_BaseItemSelecter: TFrame},
  BaseOptionItemSelForm in 'BaseOptionItemSelForm.pas' {frm_BaseOptionItemSel},
  SelRevsFrame in 'SelRevsFrame.pas' {frame_SelRevs: TFrame},
  SelMatFrame in 'SelMatFrame.pas' {frame_SelMat: TFrame},
  BaseOptionItemSelWithSaveForm in 'BaseOptionItemSelWithSaveForm.pas' {frm_BaseOptionItemSelWithSave},
  AvrDBConst in 'AvrDBConst.pas',
  SvodkaSESOptForm in 'SvodkaSESOptForm.pas' {frm_SvodkaSESOpt},
  CookiesUnit in 'CookiesUnit.pas',
  SvodkaSESDModule in 'SvodkaSESDModule.pas' {dm_SvodkaSES: TDataModule},
  SelTZavFrame in 'SelTZavFrame.pas' {frame_SelTZav: TFrame},
  SelPlaceFrame in 'SelPlaceFrame.pas' {frame_SelPlace: TFrame},
  SelSodFrame in 'SelSodFrame.pas' {frame_SelSod: TFrame},
  MemTableFillerDM in 'MemTableFillerDM.pas' {dm_MemTableFiller: TDataModule},
  MemTableFiller in 'MemTableFiller.pas',
  BaseSingleItemSelectFrame in 'BaseSingleItemSelectFrame.pas' {frame_BaseSingleItemSelect: TFrame},
  SelSingleBrigFrame in 'SelSingleBrigFrame.pas' {frame_SelSingleBrig: TFrame},
  FillReportManager in 'FillReportManager.pas' {DM_FillReportManager: TDataModule},
  SelOwnerFrame in 'SelOwnerFrame.pas' {frame_SelOwner: TFrame},
  s_work_mest in 's_work_mest.pas' {s_work_mestF},
  NGRaskopDM in 'NGRaskopDM.pas' {dm_NGRaskop: TDataModule},
  RaskopForm in 'RaskopForm.pas' {frm_Raskop},
  RaskopFrame in 'RaskopFrame.pas' {frame_Raskop: TFrame},
  AddRaskopForm in 'AddRaskopForm.pas' {frm_AddRaskop},
  WorksInfoFrame in 'WorksInfoFrame.pas' {frame_WorksInfo: TFrame},
  GeoCoordUnit in 'GeoCoordUnit.pas' {Frm_GEOCOORD: TFrame},
  RepOtlDMUnit in 'RepOtlDMUnit.pas' {dm_OtlReport: TDataModule},
  Report_ActRask_Unit in 'Report_ActRask_Unit.pas',
  s_Ogragd in 's_Ogragd.pas' {S_OgragdF},
  S_OborType in 'S_OborType.pas' {S_OborTypeF},
  S_Soorug in 'S_Soorug.pas' {S_SOORUGF},
  S_OBORTYPEGLOB in 'S_OBORTYPEGLOB.pas' {S_OBORTYPEGLOBF},
  ObjOborUnit in 'ObjOborUnit.pas' {ObjOborForm},
  SvodVed3OptForm in 'SvodVed3OptForm.pas' {frm_SvodVed3Opt},
  SvodVed3DModule in 'SvodVed3DModule.pas' {dm_SvodVed3: TDataModule},
  S_OTGlob_fieldsUnit in 'S_OTGlob_fieldsUnit.pas' {S_OTGlob_fieldsF},
  OborChoiseFormUnit in 'OborChoiseFormUnit.pas' {OborChoiseForm},
  SzNarForm in 'SzNarForm.pas' {frm_sz_nar},
  DMmain in 'DMmain.pas' {DM_main: TDataModule},
  WorkDMPlan in 'WorkDMPlan.pas' {dm_Work_Plan: TDataModule},
  MaterPLanDM in 'MaterPLanDM.pas' {dm_MaterPlan: TDataModule},
  BWorkPlanDM in 'BWorkPlanDM.pas' {dm_BWorkPlan: TDataModule},
  WorkContainerPlanDM in 'WorkContainerPlanDM.pas' {dm_WorkContainerPlan: TDataModule},
  SvodWorkPlanOpt in 'SvodWorkPlanOpt.pas' {frm_PlanWorkOpt},
  SvodPlanWorksOpt in 'SvodPlanWorksOpt.pas' {frm_SvodPlanWorkOpt},
  svodPlanVorksDM in 'svodPlanVorksDM.pas' {dm_SvodPlanWorks: TDataModule},
  BaseResultForm in 'BaseResultForm.pas' {frm_BaseResult},
  SecurityBaseForm in 'SecurityBaseForm.pas' {frm_SecurityBase},
  BaseGridFrame in 'BaseGridFrame.pas' {frame_BaseGrid: TFrame},
  OborFrameIB in 'OborFrameIB.pas' {frame_Obor: TFrame},
  FormOborIB in 'FormOborIB.pas' {frm_OborIB},
  BaseGridForm in 'BaseGridForm.pas' {frm_BaseGrid},
  NewDisconnections in 'NewDisconnections.pas' {frm_DisconNew},
  NGReports2015 in 'NGReports2015.pas',
  DiskonOptForm in 'DiskonOptForm.pas' {frm_DiskonOpt},
  DiskondRepDModule in 'DiskondRepDModule.pas' {dm_DiskondRep: TDataModule},
  ShiftForm in 'ShiftForm.pas' {frm_shift},
  ShiftDmodule in 'ShiftDmodule.pas' {dm_Shift: TDataModule},
  httpSentSynapse in 'jsontest\httpSentSynapse.pas',
  OtlNaradListDModule in 'OtlNaradListDModule.pas' {dm_OtlNaradList: TDataModule},
  OtlNaradListForm in 'OtlNaradListForm.pas' {frm_OtlNaradList},
  AnalysisViewForm in 'AnalysisViewForm.pas' {frm_AnalysisView},
  OptRepJurnal in 'OptRepJurnal.pas' {frm_OptRepJurnal},
  DModuleRepJurnal in 'DModuleRepJurnal.pas' {dm_RepJurnal: TDataModule},
  ColAddGridbuilder in 'ColAddGridbuilder.pas',
  SimpleGridToExel in 'SimpleGridToExel.pas',
  HelpFunctionsSentDiscon in 'jsontest\HelpFunctionsSentDiscon.pas',
  OptRepExcavNotFinishedForm in 'Reports\OptRepExcavNotFinishedForm.pas' {frm_OptRepExcavNotFinished},
  RepExcavNotFinishedDModule in 'Reports\RepExcavNotFinishedDModule.pas' {dm_RepExcavNotFinished: TDataModule},
  RepExcavNotFinished2DModule in 'Reports\RepExcavNotFinished2DModule.pas' {dm_RepExcavNotFinished2: TDataModule},
  httpsend in 'jsontest\forinstal\httpsend.pas',
  OptRepCloseExcavForm in 'reportsPas\OptRepCloseExcavForm.pas' {frm_RepClosedExcavOpt},
  SelMestFrame in 'SelMestFrame.pas' {frame_SelMest: TFrame},
  RepCloseExcavdModule in 'reportsPas\RepCloseExcavdModule.pas' {dm_RepCloseExcav: TDataModule},
  DiskondRepDModuleGroup in 'reportsPas\DiskondRepDModuleGroup.pas' {dm_DiskondRepGroup: TDataModule},
  OptDiscon13Group in 'OptDiscon13Group.pas' {frm_OptDiscon13Group},
  SelStreetFrame in 'SelStreetFrame.pas' {frame_SelStreets: TFrame},
  OpenDisconShiftDModule in 'reportsPas\OpenDisconShiftDModule.pas' {dm_RepOpenDisconShift: TDataModule},
  MatersMastersDMoule in 'maters\MatersMastersDMoule.pas' {dm_MatersMasters: TDataModule},
  MaterRepMain in 'maters\MaterRepMain.pas' {frm_materstobrig},
  ExelError in 'readExel\ExelError.pas',
  ReadDataExel in 'readExel\ReadDataExel.pas',
  ReadMasterMaters in 'readExel\ReadMasterMaters.pas',
  ReaderFromExelFile in 'readExel\ReaderFromExelFile.pas',
  ReadTittleTableExel in 'readExel\ReadTittleTableExel.pas',
  ConstRepMater in 'maters\ConstRepMater.pas',
  RepMaterMakerDModule in 'maters\RepMaterMakerDModule.pas' {dm_RepMaterMaker: TDataModule},
  RepMaterMakerForm in 'maters\RepMaterMakerForm.pas' {frm_RepMaterMaker},
  AddReportMatOutForm in 'maters\AddReportMatOutForm.pas' {frm_AddReportMatOut},
  AddMaterToMaterRepForm in 'maters\AddMaterToMaterRepForm.pas' {frm_AddMaterToMaterRep},
  MemTableToExel in 'maters\MemTableToExel.pas';

{$R *.RES}

begin
  Patch;

  GetLastUsedLanguage;
  FormZast := TFormZast.Create(Application);
 { FormZast.Top:=10;
  FormZast.Left:=10;}
  FormZast.Show;
  FormZast.Update;

  NastrF:=TNastrF.Create(application);

  Application.Initialize;
  Application.Title := '��������� ���';
  Application.CreateForm(TDM1, DM1);
  Application.CreateForm(TDM_main, DM_main);
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(Tdm_Shift, dm_Shift);
  Application.CreateForm(Tfrm_AnalysisView, frm_AnalysisView);
  Application.CreateForm(Tfrm_AddMaterToMaterRep, frm_AddMaterToMaterRep);
  //  Application.CreateForm(TOborChoiseForm, OborChoiseForm);
  //  Application.CreateForm(TS_GroupsOfObjectsVDS, S_GroupsOfObjectsVDS); // temp by Vadim
  //  Application.CreateForm(TDM_GroupsOfObjectsVDS, DM_GroupsOfObjectsVDS); // temp by Vadim
  //  Application.CreateForm(TFormStatus, FormStatus);  // by Vadim
  Application.CreateForm(TDM_VedomPublic, DM_VedomPublic);
  //  Application.CreateForm(TBRForm, BRForm);
  Application.Run;
  SetLastUsedLanguage;
  //
  DelFilesAfterExit:=TDelFilesAfterExit.Create;
  DelFilesAfterExit.Items.Add(DelFilesAfterExit.GetCurrDir+'*.db');
  DelFilesAfterExit.Items.Add(DelFilesAfterExit.GetCurrDir+'*.MB');
  DelFilesAfterExit.DeleteFiles;
  DelFilesAfterExit.Free;
end.