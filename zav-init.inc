procedure TFormZav.InitCbAttach;
begin
  cbAttach.Items.Clear;
  cbAttach.Items.AddObject( 'ВОДОПРОВІД',  Ptr( Integer( toaVoda ) ) );
  cbAttach.Items.AddObject( 'КАНАЛІЗАЦІЯ', Ptr( Integer( toaKanal ) ) );
  cbAttach.Items.AddObject( TRLangMSG(msgZavVRK){'ЗАЯВКИ ВРК'},  Ptr( Integer( toaVRK ) ) );
  case ZavAttach of
     toaVoda: begin cbAttach.ItemIndex := 0;
                    BB_WithoutWater.Caption:=TrLangMSG(msgWithoutWater);
              end;
     toaKanal: begin cbAttach.ItemIndex := 1;
                     BB_WithoutWater.Caption:=TrLangMSG(msgWithoutWaterKanal);
                     FDM_Zav.Qry_owner.sql.text:=StringReplace(FDM_Zav.Qry_owner.sql.text, 'attach=1', 'attach=2',
                          [ rfIgnoreCase]);
               end;
     toaVRK:   cbAttach.ItemIndex := 2;
    else
	  begin
      ZavAttach := toaVoda;
      cbAttach.ItemIndex := 0;
	  end;
  end;
end;

procedure TFormZav.InitFills;
var tt_Date,_dt1:TDateTime;
begin
  FUpdateZavFlag:=FALSE; //заявка не изменялась
  //
  if FormMode=tfmZayavNew then
  begin
    FNNarCount:=0;
    LastMyNow:=now;
    BB_Zadv.Enabled:=FALSE;
    BB_Ras.Enabled:=FALSE;
  end else FNNarCount:=FDM_Zav.NNarCount(ZavCode);
  //заполняем список "тип адреса повреждения"
  CB_tAdr.Items[0]:=TrLangMSG(msgStreet)+','+TrLangMSG(msgNumDom);
  CB_tAdr.Items[1]:=TrLangMSG(msgCrossRoad);
  CB_tAdr.Items[2]:=TrLangMSG(msgPlace);
  CB_tadr.ItemIndex:=0;

  //принадлежность
  InitCbAttach;

  if FileExists(CurrentDir+'\dop_inf.txt') then
       SL_DopInf.LoadFromFile(CurrentDir+'\dop_inf.txt');
    isAutoVvod:=true;
    isSel:=false;
    PushFormZav(Self);
    //N1Click(Self);
    UstColors(Self);
    FormZav.Caption:='Наряд  '+TrLangMSG(msgUserOne)+' - '+NameUser;
    //////////////////////
    FDM_Zav.Qry_Sdal.Open;
    FDM_Zav.Qry_Poluch.Open;
    FDM_Zav.Qry_Raon.Open;
    FDM_Zav.Qry_Revs.Open;
    FDM_Zav.Qry_owner.Open;
    FDM_Zav.Qry_Damg.Open;
    FDM_Zav.s_MatPipe.Open;
    FDM_Zav.Qry_Mest.Open;
    FDM_Zav.Qry_Place.Open;
    FDM_Zav.Qry_DiamZ.Open;
    FDM_Zav.Qry_vrk.Open;
    FDM_Zav.Qry_zav.Open;
    FDM_Zav.Qry_comment.Open;
    FDM_Zav.Qry_tzav.Open;
   // UpdateSod;
    FDM_Zav.Qry_ul1.Open;
    FDM_Zav.Qry_ul2.Open;
    FDM_Zav.Qry_DopAdres.Open;
    FDM_Zav.Qry_Brig.Open;
    FDM_Zav.Qry_Brig1.Open;
    //
    FDM_Zav.Qry_object.Close;
    FDM_Zav.Qry_object.ParamByName( 'pAttachID' ).AsInteger := Ord( ZavAttach );
    FDM_Zav.Qry_object.Open;

    {Podpor Glasha}
    FDM_Zav.Qry_podpor.Open;
    FDM_Zav.Qry_settlers.Open;
    // формирует дату закрытия заявки по времени последнего выезда
    tt_Date:=strtodatetime(datetimetostr(MyNow,'dd.mm.yyyy hh:mm:00'));
    if  not(isClosed) then
    begin
      DE_Out.OnChange:=nil;
      _dt1:=FDM_Zav.GetMaxDateTimeViezd(ZavCode);
      if _dt1>0 then tt_Date:=_dt1;
      DE_Out.Date:=tt_Date; DE_Out.OnChange:=DBL_raonChange;
      //
      TE_Out.OnChange:=nil;
      TE_Out.Time:=tt_Date; TE_Out.OnChange:=DBL_raonChange;
      if  (Date()-DE_Out.Date>=1) then
      begin
        DE_Out.Date:=Now();
        TE_Out.Time:=Now();
      end
    end;
end;


procedure TFormZav.EnabledControlsDependsFromOwner;
begin
  case FDM_Zav.Qry_owner.FieldByName('OWNER_TYPE').asInteger of
  2,1{id=1,6,7,8,2,5,9}:begin
        HidePrior(True);
        BB_Narad_enabled(true);
      end;
  4{id=3}:begin
        HidePrior(False);
        BB_Narad_enabled(True);
      end;
  3{id=4}:begin
        HidePrior(False);
        BB_Narad_enabled(false);
      end;
  end;
end;

function TFormZav.ConvertCheckedToZayavDelStatus:integer;
begin
  if CB_DelZayav.Checked then result:=1 else result:=0;
end;

function TFormZav.GetZayavDelStatus:boolean;
begin
  result:=(FDM_Zav.Qry_zajav.FieldByName('DELZ').AsInteger=1);
  CB_DelZayav.Checked:=result;
  if ((not (not (rsZAV in RightsSet))) or (LockForDel)) and (rsDELZAV in RightsSet) then
    begin
      CB_DelZayav.Show;
    end;  
end;  

procedure TFormZav.FindIDZavInTabl;
begin
  MyOpenSQL(FDM_Zav.Qry_zajav,'select * from nzavjav where id='+IntToStr(ZavCode));
  if (FDM_Zav.Qry_zajav.eof) and (FormMode<>tfmZayavNew) then
    begin
     FDM_Zav.Qry_zajav.Close;
     MyOpenSQL(FDM_Zav.Qry_zajav,'select * from zavjav where id='+IntToStr(ZavCode));
     FDM_Zav.Qry_zajav.Open;
     if FDM_Zav.Qry_zajav.eof then
       begin
         FDM_Zav.Qry_zajav.Close;
         MessageDlg(format(TrLangMSG(msgZajavIDNotFound),[ZavCode]),mtError,
            [mbOk], 0);
         Close;
       end
     else
      begin
       if FormMode<>tfmZayavCopy then
        begin
         isClosed:=true;
         Lb_DisOut.Caption:=trim(NameUser)+' ';
         isVvod(false);
        end;
      end;
    end else isClosed:=FALSE;
end;

procedure TFormZav.SetCaptionDisOutNameUser;
begin
    if isClosed then
      begin
          DE_out.Date:=FDM_Zav.Qry_zajav.FieldByName('DT_OUT').asDateTime;
          TE_out.Time:=FDM_Zav.Qry_zajav.FieldByName('DT_OUT').asDateTime;
        if FDM_Zav.Qry_zajav.FieldByName('ID_DISOUT').asInteger=-1 then
            Lb_DisOut.Caption:=trim(TrLangMSG(msgAdmin))+' '
        else
          begin
              if FDM_Zav.Qry_Brig.Locate('ID',FDM_Zav.Qry_zajav.FieldByName('ID_DISOUT').asInteger,[]) then
                  Lb_DisOut.Caption:=trim(FDM_Zav.Qry_Brig.FieldByName('NAME_R').asString)+' ';
          end;
      end
    else
      begin
        Lb_DisOut.Caption:='';
      end;
end;

procedure TFormZav.SetCaptionStatusCloseOrNoOfZayav;
begin
  if isClosed then
    begin
     Lb_Stat.Font.Color:=TextCol;
     Lb_Nzav.Font.Color:=TextCol;
     Lb_Stat.Caption:='Наряд '+ansilowercase(TrLangMSG(msgCloseWent));
    end
  else
    begin
     Lb_Nzav.Font.Color:=MessCol;
     Lb_Stat.Font.Color:=MessCol;
     Lb_Stat.Caption:='Наряд НЕ '+ansilowercase(TrLangMSG(msgCloseWent));
    end;
end;

procedure TFormZav.SetCaptionDTInAndNZavAndBrigInAndOwner;
var tt_date:TDateTime;
begin
  if (FormMode=tfmZayavCopy) or (FormMode=tfmZayavNew) then Lb_Nzav.Caption:=TrLangMSG(msgNewM)
    else Lb_Nzav.Caption:=FDM_Zav.Qry_zajav.FieldByName('NOMER').asString;
  DE_in.Date:=FDM_Zav.Qry_zajav.FieldByName('DT_IN').asDateTime;
  TE_In.Time:=FDM_Zav.Qry_zajav.FieldByName('DT_IN').asDateTime;
  SetMyLastDate(DE_in.Date);
  SetMyLastTime(TE_In.Time);
  ///
  if (FDM_Zav.Qry_zajav.FieldByName('ID_DISIN').asInteger=0)
    or (FDM_Zav.Qry_zajav.FieldByName('ID_DISIN').asInteger=-1)
      then Lb_DisIn.Caption:=trim(TrLangMSG(msgAdmin))+' '
      else
       begin
         if FDM_Zav.Qry_Brig.Locate('ID',FDM_Zav.Qry_zajav.FieldByName('ID_DISIN').asInteger,[]) then
            Lb_DisIn.Caption:=trim(FDM_Zav.Qry_Brig.FieldByName('NAME_R').asString)+' ';
       end;
  //
  DBL_owner.OnChange:=NIL;
  if (FormMode=tfmZayavNew) then
    begin
      FDM_Zav.Qry_owner.Locate('OWNER_TYPE',3,[]);
      FDM_Zav.Qry_comment.Locate('ID',-1,[]);
      FDM_Zav.Qry_ul1.Locate('ID',-1,[]);
      FDM_Zav.Qry_ul2.Locate('ID',-1,[]);
      FDM_Zav.Qry_DopAdres.Locate('ID',-1,[]);
      HidePrior(False);
      Lb_DisIn.Caption:=trim(NameUser)+' ';
      Lb_DisOut.Caption:='';
      Lb_Nzav.Font.Color:=ErrCol;
      tt_Date:=strtodatetime(datetimetostr(MyNow,'dd.mm.yyyy hh:mm:00'));
      DE_In.Date:=tt_Date;
      DE_Out.Date:=tt_Date;
      TE_In.Time:=tt_Date;
      TE_Out.Time:=TE_In.Time;
      org1_name:='';org1_tf:='';org1_Fam:='';
      TekAlien:=-1;
      Int_To:=0;
      Ed_dopAdr.Text:=FDM_Zav.Qry_ul1.FieldByName('ORINT').asString;
      DE_In.Enabled:=true;
      TE_In.Enabled:=true;
    end
      else
    begin
      if not FDM_Zav.Qry_owner.Locate('ID',FDM_Zav.Qry_zajav.FieldByName('ID_alien').asInteger,[]) then
        FDM_Zav.Qry_owner.Locate('ID',1,[]);
    end;
  DBL_owner.DisplayValue:=FDM_Zav.Qry_owner.FieldByName('NAME_R').asString;
  DBL_owner.OnChange:=ChB_AlienClick;
end;

procedure TFormZav.ShowBrigOnControl;
begin
  // показать бригадира на контроле
  if not FDM_Zav.Qry_Brig.Locate('ID',FDM_Zav.Qry_zajav.FieldByName('CONT').asInteger,[]) then
        FDM_Zav.Qry_Brig.First;
  DBLC_BRIG.DisplayValue:=FDM_Zav.Qry_Brig.FieldByName('NAME').asString;
  if FDM_Zav.Qry_zajav.FieldByName('CONT').asInteger>0 then
     ChB_Cont.Checked:=true
  else
     ChB_Cont.Checked:=false;
end;

procedure TFormZav.ShowAlienInfo;
begin
  // отобразить информацию о заявке, если она чужая
  TekAlien:=FDM_Zav.Qry_zajav.FieldByName('ALIEN').asInteger;
  OldAlien:=TekAlien;
  ZapAlien(true,TekAlien);
end;

procedure TFormZav.ExportInfoToPoteriForm;
  begin
    {Пихаем значения в форму потери}
    sePress_Value:=FDM_Zav.Qry_zajav.FieldByName('Pressure').AsFloat;
    seSquareLeak_Value:=FDM_Zav.Qry_zajav.FieldByName('Square').AsFloat;
    seSpeedLeak_Value:=FDM_Zav.Qry_zajav.FieldByName('Q').AsFloat;
    seGLZ_Value:=FDM_Zav.Qry_zajav.FieldByName('GLZ').AsFloat;

    FOp_Protyazh:=FDM_Zav.Qry_zajav.FieldByName('Op_Protyazh').AsFloat;
    FCl_Doza:=FDM_Zav.Qry_zajav.FieldByName('Cl_Doza').AsFloat;
    FCl_Contact_Time:=FDM_Zav.Qry_zajav.FieldByName('Cl_Contact_Time').AsDateTime;
    FCl_Promiv_Time:=FDM_Zav.Qry_zajav.FieldByName('Cl_Promiv_Time').AsDateTime;
    FCl_Pressure:=FDM_Zav.Qry_zajav.FieldByName('Cl_Pressure').AsFloat;
    //
    FXAR_MESTA_POVR := FDM_Zav.Qry_zajav.FieldByName('XAR_MESTA_POVR').AsInteger;
		FSVISCH_DIAM := FDM_Zav.Qry_zajav.FieldByName('SVISCH_DIAM').AsInteger;
    FTRESCH_DLINA := FDM_Zav.Qry_zajav.FieldByName('TRESCH_DLINA').AsInteger;
    FTRESCH_SHIRINA := FDM_Zav.Qry_zajav.FieldByName('TRESCH_SHIRINA').AsInteger;
    FTOR_VNESHN_DIAM := FDM_Zav.Qry_zajav.FieldByName('TOR_VNESHN_DIAM').AsInteger;
    FTOR_VNUTR_DIAM := FDM_Zav.Qry_zajav.FieldByName('TOR_VNUTR_DIAM').AsInteger;
    FTOR_UGOL := FDM_Zav.Qry_zajav.FieldByName('TOR_UGOL').AsInteger;
    //
    FUtoch_Xar_Povr:=trim(FDM_Zav.Qry_zajav.FieldByName('Utoch_Xar_Povr').AsString);
//    if FUtoch_Xar_Povr='' then FUtoch_Xar_Povr:=trim(FDM_Zav.Qry_sod.FieldByName('NAME_R').AsString);
    if (FUtoch_Xar_Povr='<пусто>') then FUtoch_Xar_Povr:='';
    //
    FOp_Id_Diam:=FDM_Zav.Qry_zajav.FieldByName('Op_Id_Diam').AsInteger;
    if FOp_Id_Diam=0 then FOp_Id_Diam:=FDM_Zav.Qry_diamZ.FieldByName('ID').AsInteger;
    //
    FActDate:=FDM_Zav.Qry_zajav.FieldByName('ACTDATE').AsDateTime;
    if FActDate=0 then FActDate:=now;
    //
    FPoteriEndDateTime:=FDM_Zav.Qry_zajav.FieldByName('PoteriEndDateTime').AsDateTime;
end;

procedure TFormZav.ShowRevsRaonUlic;
begin
  cb_tAdr.OnChange:=nil;
  try
    /// Отобразить цех, район, улицу, поселок
    CB_tAdr.ItemIndex:=FDM_Zav.Qry_zajav.FieldByName('KOD_UL').asInteger;
    if not FDM_Zav.Qry_Raon.Locate('ID',FDM_Zav.Qry_zajav.FieldByName('ID_RAYON').asInteger,[]) then
       if not FDM_Zav.Qry_Raon.Locate('ID',1,[]) then
            FDM_Zav.Qry_Raon.First;
    DBL_Raon.DisplayValue:=FDM_Zav.Qry_Raon.FieldByName('NAME_R').asString;
    if not FDM_Zav.Qry_Revs.Locate('ID',FDM_Zav.Qry_zajav.FieldByName('ID_REVS').asInteger,[]) then
    begin
            FDM_Zav.Qry_Revs.First;
            case ZavAttach of
               toaVoda: FDM_Zav.Qry_Revs.Locate('ID',Id_revs_voda,[]);
               toaKanal: FDM_Zav.Qry_Revs.Locate('ID',Id_revs_kan,[])
            end;
    end ;
    DBL_Revs.DisplayValue:=FDM_Zav.Qry_Revs.FieldByName('NAME_R').asString;
    if not FDM_Zav.Qry_Settlers.Locate('ID',FDM_Zav.Qry_zajav.FieldByName('ID_SETTLER').asInteger,[])  then
            FDM_Zav.qry_settlers.first;

    //Найдем регион улицы
    FDM_Zav.Qry_ul1.Close;
    FDM_Zav.Qry_ul1.Open;
    if not  FDM_Zav.setFilterStreetByRegion() then
       MessageDlg(TrLangMSG(msgErrorSetFStreetFilter),mtError, [mbOk], 1 );
    if not FDM_Zav.Qry_ul1.Locate('ID',FDM_Zav.Qry_zajav.FieldByName('ID_UL1').asInteger,[]) then FDM_Zav.Qry_ul1.First;
    //
        if CB_tAdr.ItemIndex=2 then
          begin
            FDM_Zav.Qry_DopAdres.Locate('ID', strtointdef(FDM_Zav.Qry_zajav.FieldByName('ID_DopAdres').AsString,-1),[]);
            DBL_DopAdres.DisplayValue:=FDM_Zav.Qry_DopAdres.FieldByName('name_r').AsString;
          end
        else if CB_tAdr.ItemIndex=1 then
          begin
           FDM_Zav.Qry_ul2.Locate('ID',strtointdef(FDM_Zav.Qry_zajav.FieldByName('ID_UL2').asString,-1),[]);
           DBL_ul2.DisplayValue:=FDM_Zav.Qry_ul2.FieldByName('NAME_R').asString;
          end
        else if CB_tAdr.ItemIndex=0 then
          begin
           Ed_Ndom.Text:=FDM_Zav.Qry_zajav.FieldByName('ID_UL2').asString;
          end;
    ED_dopAdr.Text:=FDM_Zav.Qry_zajav.FieldByName('DOP_ADR').asString;
    //
    SetCaptionUl;
  finally
    cb_tAdr.OnChange:=CB_tAdrChange;
  end;
end;

procedure TFormZav.ShowDopInf;
begin
  if FormMode<>tfmZayavCopy then
   begin
    edDop_inf.OnChange:=nil;
    edDop_inf.Text:=FDM_Zav.Qry_zajav.FieldByName('DOP_INF').asString;
    if edDop_inf.Lines.Count>0 then FLastFirstStrOfDopInf:=edDop_inf.Lines[0]
      else FLastFirstStrOfDopInf:='';
    edDop_inf.OnChange:=Mmm_dopinfChange;
   end;
  OldFirstLine:=edDop_inf.text;
end;

procedure TFormZav.SetCaptionAttach;
var
  _ii: integer;
begin
  case ZavAttach of
    toaVoda:     _ii := 0;
    toaKanal:    _ii := 1;
    toaVRK:      _ii := 2;
    toaObjVoda:  _ii := 3;
    toaObjKanal: _ii := 4;
  end;

  cbAttach.ItemIndex := _ii;

  if ZavAttach=toaVRK then pnl_VRK.Visible:=true
  else pnl_VRK.Visible:=false;

   if ZavAttach=toaKanal then pnl_podpor.Visible:=true
  else pnl_podpor.Visible:=false;
  
end;

procedure TFormZav.SetCaptionDamgAndInfo;
begin
  // Повреждение и информация о нем
  {Характер повреждения}
//  if not FDM_Zav.Qry_Sod.Locate('ID',FDM_Zav.Qry_zajav.FieldByName('ID_SOD').asInteger,[]) then
//          FDM_Zav.Qry_Sod.First;
  Diam_Present:=false;//(FDM_Zav.Qry_sod.FieldByName('diampresent').asInteger = _DiamPresent);
 // _DiamPresent
  {ВРК}
  if not FDM_Zav.Qry_vrk.Locate('ID', FDM_Zav.Qry_zajav.FieldByName('ID_VRK').asInteger, []) then
        FDM_Zav.Qry_vrk.First;
  {Место повреждения}          
  if not FDM_Zav.Qry_Place.Locate('ID',FDM_Zav.Qry_zajav.FieldByName('ID_PLACE').asInteger,[]) then
          FDM_Zav.Qry_Place.First;
  {Диаметр}
  if not FDM_Zav.Qry_DiamZ.Locate('ID',FDM_Zav.Qry_zajav.FieldByName('ID_DIAM').asInteger,[]) then
          FDM_Zav.Qry_DiamZ.First;
  {Материал трубы}
  if not FDM_Zav.s_matpipe.Locate('ID',FDM_Zav.Qry_zajav.FieldByName('ID_MATPIPE').asInteger,[]) then
       FDM_Zav.s_matpipe.First;
  {Местность повреждения}     
  if not FDM_Zav.Qry_mest.Locate('ID',FDM_Zav.Qry_zajav.FieldByName('ID_MEST').asInteger,[]) then
                  FDM_Zav.Qry_mest.First;
  {Тип заявки}
  if not FDM_Zav.Qry_tZav.Locate('ID',FDM_Zav.Qry_zajav.FieldByName('ID_TZAV').asInteger,[]) then
         FDM_Zav.Qry_tZav.First;
  {Pdpor}
  if not FDM_Zav.Qry_podpor.Locate('ID',FDM_Zav.Qry_zajav.FieldByName('ID_podpor').asInteger,[]) then
         FDM_Zav.Qry_podpor.First;
end;


procedure TFormZav.SetCaptionSdalPoluchInfo;
begin
  if not FDM_Zav.Qry_sdal.Locate('ID',FDM_Zav.Qry_zajav.FieldByName('ID_BRSDAL').asInteger,[]) then
      FDM_Zav.Qry_Sdal.First;
  if not FDM_Zav.Qry_Poluch.Locate('ID',FDM_Zav.Qry_zajav.FieldByName('ID_BRPOLUCH').asInteger,[]) then
      FDM_Zav.Qry_Poluch.First;

  DE_Poluch.Date:=FDM_Zav.Qry_zajav.FieldByName('DT_POLUCH').asDateTime;
  TE_Poluch.Time:=FDM_Zav.Qry_zajav.FieldByName('DT_POLUCH').asDateTime;
end;

procedure TFormZav.SetCaptionZayavitelInfo;
var s:string;
begin
  //Заявитель
  if not FDM_Zav.Qry_Zav.Locate('ID',FDM_Zav.Qry_zajav.FieldByName('ID_ZAV').asInteger,[]) then
    FDM_Zav.Qry_Zav.First;
  //О чем заявлено
  if not FDM_Zav.Qry_comment.Locate('ID',FDM_Zav.Qry_zajav.FieldByName('ID_comment').asInteger,[]) then
    FDM_Zav.Qry_comment.Locate('ID',-1,[]);
  //StaticText1.Caption:=FDM_Zav.Qry_Zajav.FieldByName('CharNum').AsString;
  /// Дополнительная информация об организации?
  ED_dopInfORG.OnChange:=NIL;
  s:=FDM_Zav.Qry_zajav.FieldByName('DOP_ZAV').asString;
  ED_dopInfORG.Text:=trim(CutWord(s,'&'));
  ED_dopInfNAM.Text:=trim(CutWord(s,'&'));
  //        ED_dopInfACUP.Text:=trim(CutWord(s,'&'));
  ED_dopInfTEL.Text:=trim(s);
  ED_dopInfORG.OnChange:=ED_dopInfORGChange;
end;

procedure TFormZav.SetCaptionViezdZadvRaskopNarad;
var number:string;
begin
  {Выезды}
  if (FDM_Zav.Qry_zajav.FieldByName('IS_GO').asInteger=1) and (FormMode<>tfmZayavNew) then
     ChB_viezd.Checked:=true
  else
     ChB_viezd.Checked:=false;
  {Задвижки}
  if FDM_Zav.NZadvCount('zadv',ZavCode)>0 then
    BB_Zadv.Font.Color:=ErrCol
  else
    BB_Zadv.Font.Color:=TextCol;
  {Раскопки}
  if FDM_Zav.NZadvCount('raskop',ZavCode)>0 then
    BB_Ras.Font.Color:=ErrCol
  else
    BB_Ras.Font.Color:=TextCol;
  //  
  BB_Zadv.Enabled:=ChB_viezd.Checked;
  BB_Ras.Enabled:=ChB_viezd.Checked;
  //
  {Наряд}
  if (FDM_Zav.NNarCount(ZavCode)<0) then
    BB_Narad.Font.Color:=ErrCol
  else
    BB_Narad.Font.Color:=TextCol;
  //
  {Отключения}
  if (FDM_Zav.NWWATERCount(ZavCode)>0) then
    BB_WithoutWater.Font.Color:=ErrCol
   else
     BB_WithoutWater.Font.Color:=TextCol;
   //

  {Отложенніе}
   number:=FDM_Zav.getNumberLinkOrder(ZavCode);
   if (number<>'') then
    btn_linkOtlZav.Caption:=TrLangMSG(msgLinkedWithOtlZavjav)+number;
  BB_Narad_enabled(FormMode=tfmZayavNew);
end;

procedure TFormZav.SetCaptionUl;
var _cl:TColor;
begin
  _cl:=clYellow;
  if (not isClosed) and (not (not (rsZAV in RightsSet))) then
    begin
      case CB_tAdr.ItemIndex of
        0: begin DBL_Ul1.Color:=_cl; end;
        1: begin DBL_Ul1.Color:=_cl; DBL_Ul2.Color:=_cl; end;
        2: begin DBL_Ul1.Color:=clWhite; end;
      end;
    end;      
FDM_Zav.Qry_ul2.Close;
FDM_Zav.Qry_DopAdres.Close;
  if CB_tadr.ItemIndex=1 then
    begin
      Lb_NmUl.Caption:=TrLangMSG(msgStreet);
      DBL_Ul1.Left:=Lb_NmUl.Left+Lb_NmUl.Width+4;
      Lb_Ndom.Left:=DBL_Ul1.Left+DBL_Ul1.Width+4;
      Lb_Ndom.Caption:='>';
      Lb_Ndom.Visible:=true;
      Ed_Ndom.Enabled:=false;
      Ed_Ndom.Visible:=false;
      dbl_DopAdres.Visible:=false;
      if isClosed or (not (rsZAV in RightsSet)) then
        DBL_Ul2.Enabled:=false
      else
        DBL_Ul2.Enabled:=true;
      DBL_Ul2.Visible:=true;
      DBL_Ul2.Left:=Lb_Ndom.Left+Lb_Ndom.Width+4;
      FDM_Zav.Qry_ul2.Open;
    end
  else if CB_tadr.ItemIndex=2 then
    begin
      Lb_NmUl.Caption:=TrLangMSG(msgStreet{msgPlace});
      DBL_Ul1.Left:=Lb_NmUl.Left+Lb_NmUl.Width+4;
      Ed_Ndom.Enabled:=false;
      Ed_Ndom.Visible:=false;
      DBL_Ul2.Enabled:=false;
      DBL_Ul2.Visible:=false;
      Lb_Ndom.Visible:=true;
      Lb_Ndom.Caption:='Дод.адрес';
      Lb_Ndom.Left:=DBL_Ul1.Left+DBL_Ul1.Width+4;
      dbl_DopAdres.Visible:=true;
      if isClosed or (not (rsZAV in RightsSet)) then
        DBL_DopAdres.Enabled:=false
      else
        DBL_DopAdres.Enabled:=true;
      FDM_Zav.Qry_DopAdres.Open;
    end
  else
    begin
      Lb_NmUl.Caption:=TrLangMSG(msgStreet);
      DBL_Ul1.Left:=Lb_NmUl.Left+Lb_NmUl.Width+4;
      Lb_Ndom.Left:=DBL_Ul1.Left+DBL_Ul1.Width+4;
      Lb_Ndom.Visible:=true;
      Lb_Ndom.Caption:=TrLangMSG(msgNumDom);
      if isClosed or (not (rsZAV in RightsSet)) then
        Ed_Ndom.Enabled:=false
      else
        Ed_Ndom.Enabled:=true;
      Ed_Ndom.Visible:=true;
      Ed_Ndom.Left:=Lb_Ndom.Left+Lb_Ndom.Width+4;
      DBL_Ul2.Enabled:=false;
      DBL_Ul2.Visible:=false;
      dbl_DopAdres.Visible:=false;
    end;
end;

