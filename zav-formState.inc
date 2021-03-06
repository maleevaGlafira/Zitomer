procedure TFormZav.SaveState;
begin
  with CurrentStack.StackZav do
    begin
      zav_cbAttach_id:=cbAttach.ItemIndex;
      zav_DBL_sdal_id:=DBL_Sdal.LookupSource.Dataset.FieldByName('ID').AsInteger;
      zav_DBL_brpoluch_id:=DBL_BrPoluch.LookupSource.Dataset.FieldByName('ID').AsInteger;
      zav_DBL_owner_id:=DBL_owner.LookupSource.DataSet.FieldByName('ID').AsInteger;
      zav_DBL_Raon_id:=DBL_Raon.LookupSource.DataSet.FieldByName('ID').AsInteger;
      zav_DBL_Revs_id:=DBL_Revs.LookupSource.DataSet.FieldByName('ID').AsInteger;
      zav_DBL_Zav_id:=DBL_Zav.LookupSource.DataSet.FieldByName('ID').AsInteger;
      zav_DBL_WhatMatter_id:=DBL_WhatMatter.LookupSource.DataSet.FieldByName('ID').AsInteger;
      zav_CB_tAdr_id:=CB_tAdr.ItemIndex;
      zav_DBL_Ul1_id:=DBL_Ul1.LookupSource.DataSet.FieldByName('ID').AsInteger;
      if DBL_Ul2.LookupSource.DataSet.Active then
        zav_DBL_Ul2_id:=DBL_Ul2.LookupSource.DataSet.FieldByName('ID').AsInteger;
      zav_ED_DopAdr_txt:=Ed_DopAdr.Text;
      zav_EdDop_Inf_txt:=EdDop_Inf.Text;
      zav_DBL_tzav_id:=DBL_tzav.LookupSource.DataSet.FieldByName('ID').AsInteger;
      zav_DBL_Place_id:=DBL_Place.LookupSource.DataSet.FieldByName('ID').AsInteger;
     // zav_DBL_Sod_id:=DBL_Sod.LookupSource.DataSet.FieldByName('ID').AsInteger;    �������� �����������
      zav_DBL_vrk_id:=DBL_vrk.LookupSource.Dataset.FieldByName('ID').asInteger;
      zav_DBL_MatPipe_id:=DBL_MatPipe.LookupSource.DataSet.FieldByName('ID').AsInteger;
      zav_DBL_Diam_id:=DBL_Diam.LookupSource.DataSet.FieldByName('ID').AsInteger;
      zav_DBL_Mest_id:=DBL_Mest.LookupSource.DataSet.FieldByName('ID').AsInteger;
      //
      CurrentStack.SavePervViezdID(ZavCode);
  end;      
end;

procedure TFormZav.LoadState;
  function _LocateStr(DataSet:TDataSet; value:integer):string;
  begin
    DataSet.Locate('ID',value,[]);
    result:=DataSet.FieldByName('NAME_R').asString;
  end;
begin
  with CurrentStack.StackZav do
    begin
      {��������������}
      //cbAttach.ItemIndex:=DM_Stack.zav_cbAttach_id;
      {��� ������}
      DBL_Owner.DisplayValue:=
        _LocateStr(DBL_Owner.LookupSource.DataSet, zav_DBL_Owner_id);
      {�����}
      DBL_Raon.DisplayValue:=
        _LocateStr(DBL_Raon.LookupSource.DataSet, zav_DBL_Raon_id);
      {���}
      DBL_Revs.DisplayValue:=
        _LocateStr(DBL_Revs.LookupSource.DataSet, zav_DBL_Revs_id);
      {���������}
      DBL_Zav.DisplayValue:=
        _LocateStr(DBL_Zav.LookupSource.DataSet, zav_DBL_Zav_id);
      {� ��� ��������}
      DBL_WhatMatter.DisplayValue:=
        _LocateStr(DBL_WhatMatter.LookupSource.DataSet, zav_DBL_WhatMatter_id);
      {���}
        CB_tAdr.ItemIndex:=zav_CB_tAdr_id;
      {�����1}
      DBL_Ul1.DisplayValue:=
        _LocateStr(DBL_Ul1.LookupSource.DataSet, zav_DBL_Ul1_id);
      {�����2}
      if DBL_Ul2.LookupSource.DataSet.Active then
        DBL_Ul2.DisplayValue:=
          _LocateStr(DBL_Ul2.LookupSource.DataSet, zav_DBL_Ul2_id);
      {�������������� �����}
      Ed_DopAdr.Text:=zav_ED_DopAdr_txt;
      {�������������� ����������}
      EdDop_Inf.Text:=zav_EdDop_Inf_txt;
      {��� ������}
      DBL_tzav.DisplayValue:=
        _LocateStr(DBL_tzav.LookupSource.DataSet, zav_DBL_tzav_id);
      {����� �����������}
      DBL_Place.DisplayValue:=
        _LocateStr(DBL_Place.LookupSource.DataSet, zav_DBL_Place_id);
      {�������� �����������}
      {DBL_Sod.DisplayValue:=
        _LocateStr(DBL_Sod.LookupSource.DataSet, zav_DBL_Sod_id);}
      {���}
      DBL_vrk.DisplayValue:=
        _LocateStr(DBL_vrk.LookupSource.DataSet, zav_DBL_vrk_id);
      {�������� �����}
      DBL_MatPipe.DisplayValue:=
        _LocateStr(DBL_MatPipe.LookupSource.DataSet, zav_DBL_MatPipe_id);
      {�������}
        DBL_Diam.LookupSource.DataSet.Locate('ID',zav_DBL_Diam_id,[]);
        DBL_Diam.DisplayValue:=DBL_Diam.LookupSource.DataSet.FieldByName('DIAM').asString;
      {��������� �����������}
      DBL_Mest.DisplayValue:=
        _LocateStr(DBL_Mest.LookupSource.DataSet, zav_DBL_Mest_id);
      {����}
      DBL_Sdal.DisplayValue:=
        _LocateStr(DBL_Sdal.LookupSource.DataSet, zav_DBL_Sdal_id);
      {��������}
      DBL_BrPoluch.DisplayValue:=
        _LocateStr(DBL_BrPoluch.LookupSource.Dataset, zav_DBL_BrPoluch_id);
      ///
      FWasLoadState:=TRUE;
    end;      
  BB_Zadv.Enabled:=FALSE;
  BB_Ras.Enabled:=FALSE;
  BB_Poteri.Enabled:=FALSE;
  BB_clzav.Enabled:=FALSE;
  BB_WithoutWater.Enabled:=false;
  btn_linkOtlZav.Enabled:=false;
  BB_Image.Enabled:=false;
  //
  if (trim(AnsiUpperCase(DBL_Owner.DisplayValue))<>'������') or
     (trim(AnsiUpperCase(DBL_Owner.DisplayValue))<>AnsiUpperCase(TRLANgMSG(msgFalseZav)))
   then
    BB_Narad.Font.Color:=clGreen;
  //
  FNNarCount:=0;
  BB_Narad_Enabled(false);
  BB_Narad.Enabled:=false;
  //
  BB_Save_Enabled(true);
end;
