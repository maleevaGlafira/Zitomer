procedure TFormZav.PrintEkonomPokaz;
var
  _rep: TEkonomPokaz;
begin
  _rep := TEkonomPokaz.Create;
  try
    _rep.ZavID := ZavCode;
    _rep.Execute;
  finally
    _rep.Free;
  end;
end;

function TFormZav.GetAdresForPrint: string;
begin
  Result := DM1.Gen_Addr('',DBL_ul1.Text,DBL_ul2.Text,Ed_ndom.Text,IntToStr(CB_tAdr.ItemIndex),Ed_DopAdr.Text,dbl_DopAdres.text);
end;



procedure TFormZav.NewPrint;
  function PrepareStr(str: string): string;
  begin
    //if AnsiUpperCase(trim(str))='<ÏÓÑÒÎ>' then
    if (pos('', str)<>0) or (pos('', str)<>0) then
      Result:=''
    else
      Result:=str;
  end;
  function PrepareDiam(str: string): string;
  begin
    if trim(str)='0' then
      Result:=''
    else
      Result:=str;  
  end;

  function _GetAttach(_OperAtt: TOperAtt): string;
  begin
    case _OperAtt of
      toaVoda: Result := 'ÏÎ Â/Ñ';
      toaKanal: Result := 'ÏÎ Â/Î';
      else Result := '';
    end;
  end;
var
  _viezd_date,_begin_date,_end_date: TDateTime;
  _DTBeginWork2,_DTEndWork2: TDateTime;
  _Brigs2, _master:string;
  __ZavCode:integer;
  _peredano, _dt_act, _bract,_brblag: string;
begin
  inherited;
  __ZavCode:=-2;
  if (Lb_Nzav.Caption<>TrLangMSG(msgNewW)) and (Lb_Nzav.Caption<>'') then __ZavCode:=ZavCode;
  try
    DM_Reports:=TDM_Reports.Create(nil,trtZayav);
  except
    on E:Exception do
      begin
        MessageDLG('TFormZav.NewPrint'#13+E.Message, mtWarning, [mbOk],0);
      {  MessageBox(handle,PChar('TFormZav.NewPrint'#13+
          E.Message),'Äèñïåò÷åð ÀÂÐ', MB_OK or MB_ICONWARNING);}
        DM_Reports.Free;
        Exit;
      end;
  end;
  try
      if not(MAP_IS_WORK) then
        begin
          DM_Reports.ZayavRep.NeedOfCountScreenShot:=F_NeedOfCountScreenShot;
          DM_Reports.ZayavRep.ScreenShotFileName_1:= F_SCREENSHOT_PATH_1;
          DM_Reports.ZayavRep.ScreenShotFileName_2:= F_SCREENSHOT_PATH_2;
//          DM_Reports.ZayavRep.ScreenShotFileName_1:=''
        end
          else
        begin
          DM_Reports.ZayavRep.NeedOfCountScreenShot:=DM_GateAvar.NeedOfCountScreenShot;
          DM_Reports.ZayavRep.ScreenShotFileName_1:=DM_GateAvar.SCREENSHOT_PATH_1;
          DM_Reports.ZayavRep.ScreenShotFileName_2:=DM_GateAvar.SCREENSHOT_PATH_2;
        end;
      with DM_Reports.ZayavRep do
      begin
        //
            with DM_VedomPublic do
              begin
                Qry_FirstViezdZadv.Close;
                Qry_FirstViezdZadv.ParamByName('pID_Zav').Value:=__ZavCode;
                Qry_FirstViezdZadv.Open;

                Qry_NotFirstViezdZadv.Close;
                Qry_NotFirstViezdZadv.ParamByName('pID_Zav').Value:=__ZavCode;
                Qry_NotFirstViezdZadv.Open;

                Qry_narad.Close;
                Qry_narad.ParamByName('id_zav').value:=__ZavCode;
                Qry_narad.open;



              end;
        //
        DM_VedomPublic.FirstViezd(__ZavCode,_viezd_date,_begin_date,_end_date,_master);
        DM_VedomPublic.DTFromFirstViezdToLastViezd(__ZavCode,_DTBeginWork2,_DTEndWork2,_Brigs2);
        DM_VedomPublic.RazritPeredano(__ZavCode, _peredano, _dt_act, _bract,_brblag);
        //VarValue['Rayon']:=DBL_Raon.DisplayValue;
        //VarValue['Prinadlezhn']:=cbAttach.Text;//DBL_Owner.DisplayValue;

        VarValue['Attach']:=_GetAttach( ZavAttach );
        VarValue['NZayav']:=LB_Nzav.Caption;
        //VarValue['Address']:=DM1.Gen_Addr('',DBL_ul1.Text,DBL_ul2.Text,Ed_ndom.Text,IntToStr(CB_tAdr.ItemIndex),Ed_DopAdr.Text,dbl_DopAdres.text);
        VarValue['Address']:=GetAdresForPrint;
        VarValue['DatePostupl']:=DE_In.Text;
        VarValue['TimePostupl']:=TimeToStr(TE_In.Time);
        VarValue['Zayavitel']:=PrepareStr(DBL_Zav.DisplayValue);
        VarValue['Phone']:=Ed_dopinfTEL.Text;
        VarValue['WhatMatter']:=PrepareStr(DBL_WhatMatter.DisplayValue);
        VarValue['PervViezdDate']:=MyDate2Str(_end_date);
        VarValue['PervViezdTime']:=MyTime2Str(_end_date);
        VarValue['ZayavType']:=PrepareStr(DBL_tzav.DisplayValue);
        VarValue['MestoPovr']:=PrepareStr(DBL_place.DisplayValue);
        //if __ZavCode>-1 then
        VarValue['XarPovr']:=PrepareStr(DBL_Sod.DisplayValue);
        VarValue['MatTrub']:=PrepareStr(DBL_matpipe.DisplayValue);
        //if __ZavCode>-1 then
        VarValue['Diam']:=PrepareDiam(DBL_Diam.DisplayValue);
        VarValue['MestnPovr']:=PrepareStr(DBL_mest.DisplayValue);
        VarValue['WithoutWater']:=DM_VedomPublic.WithoutWater(__ZavCode);
        VarValue['FirstViezdWorks']:=DM_VedomPublic.Works(wiFirstViezd, __ZavCode);
        VarValue['PlanObors']:=DM_VedomPublic.PlanObors(__ZavCode);
        VarValue['Master']:=_master;
        if DE_Poluch.Date<>0 then
          VarValue['PoluchDate']:=DE_Poluch.Text;
        VarValue['PoluchBr']:=PrepareStr(DBL_BrPoluch.DisplayValue);
        if _DTBeginWork2<>0 then
        begin
          VarValue['DateBeginWork2']:=DateToStr(_DTBeginWork2);
          VarValue['TimeBeginWork2']:=TimeToStr(_DTBeginWork2);
        end;
        if _DTEndWork2<>0 then
        begin
          VarValue['DateEndWork2']:=DateToStr(_DTEndWork2);
          VarValue['TimeEndWork2']:=TimeToStr(_DTEndWork2);
        end;
        VarValue['UtochPovrezhd']:=DM_VedomPublic.UtochPovrezhd(__ZavCode);
        VarValue['WithoutFirstViezdWorks']:=DM_VedomPublic.Works(wiWithoutFirstViezd, __ZavCode);
      //  VarValue['UsedObors']:=DM_VedomPublic.UsedObors(__ZavCode);
    //    VarValue['Maters']:=DM_VedomPublic.Maters(__ZavCode);

        {!!!!!!!!}
        {
        if seDiamLeak_Value<>0 then
          VarValue['DiamLeak']:=seDiamLeak.Text;
        }

        if seSquareLeak_Value<>0 then
          VarValue['SquareLeak']:=FormatFloat('####0.0##',seSquareLeak_Value);
        if seGLZ_Value<>0 then
          VarValue['GLZ']:=FormatFloat('####0.0##',seGLZ_Value);
        if sePress_Value<>0 then
          VarValue['Press']:=FormatFloat('####0.0##',sePress_Value);

        VarValue['NeedWorks']:=DM_VedomPublic.NeedWorks(__ZavCode);
        VarValue['peredano']:=_peredano;
        VarValue['dt_act']:=_dt_act;
        VarValue['BrAct']:=_BrAct;
        VarValue['BrBlag']:=_brblag;
        VarValue['Sdal']:=PrepareStr(DBL_Sdal.DisplayValue);
        VarValue['DisOut']:=DM_VedomPublic.GetSdal(__ZavCode);//Lb_disOut.Caption;

        Execute;
      end;
  finally
    with DM_VedomPublic do
    begin
      Qry_FirstViezdZadv.Close;
      Qry_NotFirstViezdZadv.Close;
    end;
    DM_Reports.Free;
  end;
end;





procedure TFormZav.OldPrint;
var //PrF2:TProsmForm2;
    tt_str,tt_str2,s_line,s_line2:string;
    i,cnt,XLRow:integer;
    NarForm:TFormNarad;
    Obor:TFormObor;
    ZadvForm:TFormClZadv;
    fl:boolean;
    Sheet:Variant;
begin
    XLRow:=1;
    if isClosed then
       MyOpenSQL(FDM_Zav.Qry_zajav,'select * from zavjav where id='+IntToStr(ZavCode))
    else
       MyOpenSQL(FDM_Zav.Qry_zajav,'select * from nzavjav where id='+IntToStr(ZavCode));
    ButVis(FormZav,false);
           if isInExcel then
              begin
               XLRow:=8;//XLRow:=5;XLZagCol:=4;
               XLApp:= CreateOleObject('Excel.Application');
               XLApp.Visible := True;
               XLApp.Workbooks.Add(xlWBatWorkSheet);
               XLApp.Workbooks[1].WorkSheets[1].Name :='ãÞÚÁÉÞ';
               Sheet := XLApp.Workbooks[1].WorkSheets['ãÞÚÁÉÞ'];
              end;

    PrF2:=TProsmForm2.Create(Self);
    PrF2.OnClose:=MyProsmClose;
    s_line:=FillStr(65,'-');
    s_line2:=FillStr(50,'-');
//    tt_str:=Qry_Revs.FieldByName('NAME_R').asString+' '+Qry_owner.FieldByName('NAME_R').asString;
    tt_str:=FDM_Zav.Qry_owner.FieldByName('NAME_R').asString;
{    if Qry_owner.FieldByName('ID').asInteger in [2,5] then
      begin
       tt_str:=Lb_2Alien.Caption+' '+AnsiUpperCase(TrLangMSG(msgAlien))+' ';
       if isInExcel then
          Sheet.Cells[1,1]:=Lb_2Alien.Caption+' '+AnsiUpperCase(TrLangMSG(msgAlien))+' ';
      end
    else
      begin
       tt_str:=Qry_Revs.FieldByName('NAME_R').asString+' ÿáíú ';
       if isInExcel then
          Sheet.Cells[1,1]:=Qry_Revs2.FieldByName('NAME_R').asString+' ÿáíú ';
      end;
 }
    if isInExcel
    then Sheet.Cells[1,1]:=tt_str;
    tt_str:=tt_str+PadRight('ìíëåï '+Lb_nzav.Caption+' '+AnsiUpperCase(TrLangMSG(msgYear))+' '+FDM_Zav.Qry_zajav.FieldByName('FYEAR').asString,
                   65-Length(tt_str),' ');
    if isInExcel then
       begin
          Sheet.Cells[1,2]:='ìíëåï '+Lb_nzav.Caption;
          Sheet.Cells[1,3]:=' '+AnsiUpperCase(TrLangMSG(msgYear))+' '+FDM_Zav.Qry_zajav.FieldByName('FYEAR').asString;
       end;
    PrF2.Memo1.Lines.Add(tt_str);
    if isClosed then
     begin
      PrF2.Memo1.Lines.Add(AnsiUpperCase(TrLangMSG(msgVidCloseZadv)));
      if isInExcel then
          Sheet.Cells[2,1]:=AnsiUpperCase(TrLangMSG(msgVidCloseZadv));
     end
    else
     begin
      PrF2.Memo1.Lines.Add('ìå '+AnsiUpperCase(TrLangMSG(msgVidCloseZadv)));
      if isInExcel then
          Sheet.Cells[2,1]:='ìå '+AnsiUpperCase(TrLangMSG(msgVidCloseZadv));
     end;

    PrF2.Memo1.Lines.Add(s_line);
    PrF2.Memo1.Lines.Add('              äÞÐÞ       '+PadLeft(TrLangMSG(msgTime),5,' ')+'    ÄÕßÎÅÐÂÅÏ');
    PrF2.Memo1.Lines.Add(TrLangMSG(msgSending)+' | '+DE_In.Text+' '+Time2Str(TE_In.Time)+'    '+
                   Lb_DisIn.Caption);
    if isClosed then
     begin
      PrF2.Memo1.Lines.Add(TrLangMSG(msgClosing)+'    | '+DE_Out.Text+' '+Time2Str(TE_Out.Time)+'    '+
                   Lb_DisOut.Caption);
     end
    else
     begin
      PrF2.Memo1.Lines.Add(TrLangMSG(msgClosing)+'    | ');
     end;

    if isInExcel then
       begin
          Sheet.Cells[4,2]:='äÞÐÞ';
          Sheet.Cells[4,3]:=TrLangMSG(msgTime);
          Sheet.Cells[4,4]:='íÎÅÏÞÐÍÏ';

          Sheet.Cells[5,1]:=TrLangMSG(msgSending);
          Sheet.Cells[5,2]:=DE_In.Text;
          Sheet.Cells[5,3]:=Time2Str(TE_In.Time);
          Sheet.Cells[5,4]:=Lb_DisIn.Caption;
          Sheet.Cells[6,1]:=TrLangMSG(msgClosing);
          Sheet.Cells[6,2]:=DE_Out.Text;
          Sheet.Cells[6,3]:=Time2Str(TE_Out.Time);
          Sheet.Cells[6,4]:=Lb_DisOut.Caption;

          Sheet.Range['A4:A6'].Columns.AutoFit;
          Sheet.Range['B4:B6'].Columns.AutoFit;
          Sheet.Range['C4:C6'].Columns.AutoFit;
          Sheet.Range['D4:D6'].Columns.AutoFit;
       end;

    PrF2.Memo1.Lines.Add(s_line);
    if ChB_Cont.Checked then
      begin
        if isInExcel then
          begin
            Sheet.Cells[XLRow,1]:='ãþúáéþ ìþ éíìðïíêå: ';
            Sheet.Cells[XLRow,2]:=Strip('B',' ',FDM_Zav.Qry_Brig.FieldByName('NAME').asString);
            inc(XLRow);
          end;
        PrF2.Memo1.Lines.Add(s_line);
        PrF2.Memo1.Lines.Add('ãþúáéþ ìþ éíìðïíêå: '+Strip('B',' ',FDM_Zav.Qry_Brig.FieldByName('NAME').asString));
        PrF2.Memo1.Lines.Add(s_line);
      end;
//    tt_str:=Trim(Qry_zav.FieldByName('NAME_R').asString)+' '+
//            Trim(Ed_dopinfORG.Text)+' '+Trim(Ed_dopinfNAM.Text)+' '+Trim(Ed_dopinfACUP.Text)+' '+Trim(Ed_dopinfTEL.Text)+' ';
    tt_str:=Trim(FDM_Zav.Qry_zav.FieldByName('NAME_R').asString)+' '+
            Trim(Ed_dopinfORG.Text)+' '+Trim(Ed_dopinfNAM.Text)+' '+Trim(Ed_dopinfTEL.Text)+' ';
    tt_str2:='';
//    if Qry_revs.FieldByName('ID').asInteger>-1 then
  //          tt_str2:=Trim(Qry_revs.FieldByName('NAME_R').asString)+' '+
    //                       Trim(Ed_FrRevs.Text);
    if isInExcel then
       begin
         Sheet.Cells[XLRow,1]:=AnsiUpperCase(TrLangMSG(msgZajavitelOne));
         Sheet.Cells[XLRow,2]:=tt_str;
         inc(XLRow);
       end;
    Add2Memo(PrF2.Memo1,PadLeft(AnsiUpperCase(TrLangMSG(msgZajavitelOne)),9,' ')+'              ','|',tt_str,40);
    if tt_str2<>'' then
       Add2Memo(PrF2.Memo1,'                       ','|',tt_str2,40);
    tt_str:=Strip('B',' ',FDM_Zav.Qry_ul1.FieldByName('NAME_R').asString);
    if CB_tAdr.Itemindex=0 then begin
    tt_str:=tt_str+' '+TrLangMSG(msgDomShort)+Trim(Ed_ndom.Text)
    end
    else if CB_tAdr.Itemindex=1 then
      tt_str:=tt_str+'<'+Strip('B',' ',FDM_Zav.Qry_ul2.FieldByName('NAME_R').asString)
    else
      tt_str:=tt_str+' '+AnsiLowerCase(TrLangMSG(msgPlace));

    tt_str:=tt_str+' '+Ed_dopAdr.Text;
    if isInExcel then
       begin
         Sheet.Cells[XLRow,1]:=AnsiUpperCase(TrLangMSG(msgAddr));
         Sheet.Cells[XLRow,2]:=tt_str;
         inc(XLRow);
         //Sheet.Cells[XLRow,1]:=AnsiUpperCase(TrLangMSG(msgREGIONone));
         //Sheet.Cells[XLRow,2]:=FDM_Zav.Qry_Region.FieldByName('NAME_R').asString;
         //inc(XLRow);
         Sheet.Cells[XLRow,1]:=AnsiUpperCase(TrLangMSG(msgRAYONone));
         Sheet.Cells[XLRow,2]:=FDM_Zav.Qry_raon.FieldByName('NAME_R').asString;
         inc(XLRow);
         Sheet.Cells[XLRow,1]:=AnsiUpperCase(TrLangMSG(msgDopInfoShort));
         Sheet.Cells[XLRow,2]:=edDop_inf.Text;
         inc(XLRow);
         Sheet.Cells[XLRow,1]:='í âåë ãþúáêåìí';
         Sheet.Cells[XLRow,2]:=FDM_Zav.Qry_comment.FieldByName('name_r').AsString;
         inc(XLRow);
         inc(XLRow);
         Sheet.Cells[XLRow,1]:='ðõî ãþúáéõ';
         Sheet.Cells[XLRow,2]:=FDM_Zav.Qry_tzav.FieldByName('NAME_R').asString;
         inc(XLRow);
         Sheet.Cells[XLRow,1]:=AnsiUpperCase(TrLangMSG(msgContext))+' ãþúáéõ';
         Sheet.Cells[XLRow,2]:=FDM_Zav.Qry_sod.FieldByName('NAME_R').asString;
         inc(XLRow);
         Sheet.Cells[XLRow,1]:=AnsiUpperCase('õìòíïëþæõú í îíáïåôäåìõõ');
         inc(XLRow);
         Sheet.Cells[XLRow,1]:=AnsiUpperCase(TrLangMSG(msgCrash));
         Sheet.Cells[XLRow,2]:=FDM_Zav.Qry_damg.FieldByName('NAME_R').asString;
         inc(XLRow);
         Sheet.Cells[XLRow,1]:=AnsiUpperCase(TrLangMSG(msgSpotPlace))+' '+AnsiUpperCase(TrLangMSG(msgCrash));
         Sheet.Cells[XLRow,2]:=FDM_Zav.Qry_place.FieldByName('NAME_R').asString;
         inc(XLRow);
         Sheet.Cells[XLRow,1]:='ëþðåïõþê ðïñàø';
         Sheet.Cells[XLRow,2]:=FDM_Zav.s_matpipe.FieldByName('name_r').asString;
         inc(XLRow);
         Sheet.Cells[XLRow,1]:=AnsiUpperCase(TrLangMSG(msgDIAM));
         Sheet.Cells[XLRow,2]:=FDM_Zav.Qry_DiamZ.FieldByName('DIAM').asString;
         inc(XLRow);
         Sheet.Cells[XLRow,1]:=AnsiUpperCase(TrLangMSG(msgtypeClogOne));
         Sheet.Cells[XLRow,1]:=AnsiUpperCase(TrLangMSG(msgPlace))+' '+AnsiUpperCase(TrLangMSG(msgCrash));
         Sheet.Cells[XLRow,2]:=FDM_Zav.Qry_mest.FieldByName('NAME_R').asString;
         inc(XLRow);
         Sheet.Cells[XLRow,1]:='öêñàõìþ ãþêíôåìõú';
         Sheet.Cells[XLRow,2]:=FloatToStr(seGLZ_Value);
         inc(XLRow);
         Sheet.Cells[XLRow,1]:='äþáêåìõå á ðïñàå';
         Sheet.Cells[XLRow,2]:=FloatToStr(sePress_value);
         inc(XLRow);
         Sheet.Cells[XLRow,1]:='îêíûþäý ðåâõ';
         Sheet.Cells[XLRow,2]:=FloatToStr(seSquareLeak_value);
         inc(XLRow);
         Sheet.Cells[XLRow,1]:='ÿéíïíÿðý áøðåéþìõú';
         Sheet.Cells[XLRow,2]:=FloatToStr(seSpeedLeak_value);
         inc(XLRow);
         Sheet.Range['A8:A'+inttostr(XLRow)].Columns.AutoFit;
         Sheet.Range['B8:B'+inttostr(XLRow)].Columns.AutoFit;

         inc(XLRow,2);
       end;

    Add2Memo(PrF2.Memo1,PadLeft(AnsiUpperCase(TrLangMSG(msgAddr)),23,' '),'|',tt_str,40);
    //PrF2.Memo1.Lines.Add(PadLeft(AnsiUpperCase(TrLangMSG(msgREGIONone)),23,' ')+'|'+FDM_Zav.Qry_Region.FieldByName('NAME_R').asString);
    PrF2.Memo1.Lines.Add(PadLeft(AnsiUpperCase(TrLangMSG(msgRAYONone)),23,' ')+'|'+FDM_Zav.Qry_raon.FieldByName('NAME_R').asString);
    Add2Memo(PrF2.Memo1,PadLeft(AnsiUpperCase(TrLangMSG(msgDopInfoShort)),23,' '),'|',edDop_inf.Text,40);
    Add2Memo(PrF2.Memo1,PadLeft('í âåë ãþúáêåìí',23,' '),'|',FDM_Zav.Qry_comment.FieldByName('name_r').AsString,40);
    PrF2.Memo1.Lines.Add(s_line);

    PrF2.Memo1.Lines.Add(PadLeft('ðõî ãþúáéõ',23,' ')+'|'+FDM_Zav.Qry_tzav.FieldByName('NAME_R').asString);
    Add2Memo(PrF2.Memo1,PadLeft(AnsiUpperCase(TrLangMSG(msgContext))+' ãþúáéõ',23,' '),'|',FDM_Zav.Qry_sod.FieldByName('NAME_R').asString,40);
    PrF2.Memo1.Lines.Add(PadLeft(AnsiUpperCase(TrLangMSG(msgCrash)),23,' ')+'|'+FDM_Zav.Qry_damg.FieldByName('NAME_R').asString);
    Add2Memo(PrF2.Memo1,PadLeft(AnsiUpperCase(TrLangMSG(msgSpotPlace))+' '+AnsiUpperCase(TrLangMSG(msgCrashes)),23,' '),'|',FDM_Zav.Qry_place.FieldByName('NAME_R').asString,40);
    PrF2.Memo1.Lines.Add(PadLeft('ëþðåïõþê ðïñàø',23,' ')+'|'+FDM_Zav.s_matpipe.FieldByName('name_r').asString);
    PrF2.Memo1.Lines.Add(PadLeft(AnsiUpperCase(TrLangMSG(msgDiam)),23,' ')+'|'+FDM_Zav.Qry_DiamZ.FieldByName('DIAM').asString);
    PrF2.Memo1.Lines.Add(PadLeft(AnsiUpperCase(TrLangMSG(msgPlace))+' '+AnsiUpperCase(TrLangMSG(msgCrashes)),23,' ')+'|'+FDM_Zav.Qry_mest.FieldByName('NAME_R').asString);
    PrF2.Memo1.Lines.Add(PadLeft('öêñàõìþ ãþêíôåìõú',23,' ')+'|'+FloatToStr(seGLZ_value));
    PrF2.Memo1.Lines.Add(PadLeft('äþáêåìõå á ðïñàå',23,' ')+'|'+FloatToStr(sePress_value));
    PrF2.Memo1.Lines.Add(PadLeft('îêíûþäý ðåâõ',23,' ')+'|'+FloatToStr(seSquareLeak_value));
    PrF2.Memo1.Lines.Add(PadLeft('ÿéíïíÿðý áøðåéþìõú',23,' ')+'|'+FloatToStr(seSpeedLeak_value));
    PrF2.Memo1.Lines.Add(s_line);

    FDM_Zav.Qry_tmp.SQL.Clear;
    if isClosed then
      FDM_Zav.Qry_tmp.SQL.Add('select count(id) mm from narad where id_zav='+Inttostr(ZavCode))
    else
      FDM_Zav.Qry_tmp.SQL.Add('select count(id) mm from nnarad where id_zav='+Inttostr(ZavCode));

    FDM_Zav.Qry_tmp.Open;
    i:=FDM_Zav.Qry_tmp.FieldByName('MM').asInteger;
    FDM_Zav.Qry_tmp.Close;
    if i>0 then
     begin
               if isClosed then
                 NarForm:=TFormNarad.NarCreate(Self,0,ZavCode,not(rsNARAD in RightsSet), ZavAttach)
               else
                 NarForm:=TFormNarad.NarCreate(Self,1,ZavCode,not(rsNARAD in RightsSet), ZavAttach);
               cnt:=NarForm.TbC_nar.Tabs.Count-1;
               for i:=0 to cnt do
                 begin
                    NarForm.TbC_nar.TabIndex:=i;
                    NarForm.TbC_narChange(Self);
                    PrF2.Memo1.Lines.Add(AnsiUpperCase(TrLangMSG(msgWentOne))+' '+NarForm.Qry_narad.FieldByName('NOMER').asString);
                    PrF2.Memo1.Lines.Add(PadLeft(AnsiUpperCase(TrLangMSG(msgWentOne)),23,' ')+NarForm.DE_dep.Text+' '+Time2Str(NarForm.TE_dep.Time));
                    PrF2.Memo1.Lines.Add(PadLeft(AnsiUpperCase(TrLangMSG(msgBegin)),23,' ')+NarForm.DE_In.Text+' '+Time2Str(NarForm.TE_In.Time));
                    PrF2.Memo1.Lines.Add(PadLeft(AnsiUpperCase(TrLangMSG(msgEnd)),23,' ')+NarForm.DE_Out.Text+' '+Time2Str(NarForm.TE_Out.Time));
                    Add2Memo(PrF2.Memo1,PadLeft(AnsiUpperCase(TrLangMSG(msgTellWent)),23,' '),'|',NarForm.MM_dopInf.Text,40);
//                    PrF2.Memo1.Lines.Add(PadLeft(AnsiUpperCase(TrLangMSG(msgWhoDoJob)),23,' ')+NarForm.Qry_runw.FieldByName('NAME_R').asString);
                    PrF2.Memo1.Lines.Add(PadLeft('àïõöþäõï',23,' ')+NarForm.Qry_brig.FieldByName('NAME_R').asString);
                    if NarForm.Qry_brig3.FieldByName('ID').asInteger<>-1
                    then PrF2.Memo1.Lines.Add(PadLeft('àïõöþäõï(ïÿñ)',23,' ')+NarForm.Qry_brig3.FieldByName('NAME_R').asString);
                    if isInExcel then
                       begin
                         Sheet.Cells[XLRow,1]:=AnsiUpperCase(TrLangMSG(msgWentOne));
                         Sheet.Cells[XLRow,2]:=NarForm.Qry_narad.FieldByName('NOMER').asString;
                         inc(XLRow);
                         Sheet.Cells[XLRow,1]:=AnsiUpperCase(TrLangMSG(msgWentOne));
                         Sheet.Cells[XLRow,2]:=NarForm.DE_dep.Text+' '+Time2Str(NarForm.TE_dep.Time);
                         inc(XLRow);
                         Sheet.Cells[XLRow,1]:=AnsiUpperCase(TrLangMSG(msgBegin));
                         Sheet.Cells[XLRow,2]:=NarForm.DE_In.Text+' '+Time2Str(NarForm.TE_In.Time);
                         inc(XLRow);
                         Sheet.Cells[XLRow,1]:=AnsiUpperCase(TrLangMSG(msgEnd));
                         Sheet.Cells[XLRow,2]:=NarForm.DE_Out.Text+' '+Time2Str(NarForm.TE_Out.Time);
                         inc(XLRow);
                         Sheet.Cells[XLRow,1]:=AnsiUpperCase(TrLangMSG(msgTellWent));
                         Sheet.Cells[XLRow,2]:=NarForm.MM_dopInf.Text;
                         inc(XLRow);
                         Sheet.Cells[XLRow,1]:=AnsiUpperCase(TrLangMSG(msgWhoDoJob));
//                         Sheet.Cells[XLRow,2]:=NarForm.Qry_runw.FieldByName('NAME_R').asString;
                         inc(XLRow);
                         Sheet.Cells[XLRow,1]:='àïõöþäõï';
                         Sheet.Cells[XLRow,2]:=NarForm.Qry_brig.FieldByName('NAME_R').asString;
                         inc(XLRow);
                         if NarForm.Qry_brig3.FieldByName('ID').asInteger<>-1
                         then begin
                           inc(XLRow);
                           Sheet.Cells[XLRow,1]:='àïõöþäõï(ïÿñ)';
                           Sheet.Cells[XLRow,2]:=NarForm.Qry_brig3.FieldByName('NAME_R').asString;
                         end;
                         Sheet.Range['A9:A'+inttostr(XLRow)].Columns.AutoFit;
                         Sheet.Range['B9:B'+inttostr(XLRow)].Columns.AutoFit;
                         inc(XLRow,2);
                       end;
                    (*
                    Obor:=TFormObor.OborCreate(NarForm,NrZajvCod,NarForm.Qry_narad['ID'],0);
                    Obor.{Qry_mat}Maters_q.First;
                    fl:=true;
                    while not Obor.{Qry_mat}Maters_q.EOF do
                      begin
                         if fl then
                           begin
                             PrF2.Memo1.Lines.Add(Padcenter(' '+AnsiUpperCase(TrLangMSG(msgMaterMany))+': ',50,'-'));
                             PrF2.Memo1.Lines.Add(TrLangMSG(msgDesign)+'                    | '+TrLangMSG(msgCount)+' | '+TrLangMSG(msgDiamShort));
                             PrF2.Memo1.Lines.Add(s_line2);
                              if isInExcel then
                                 begin
                                   Sheet.Cells[XLRow,1]:=AnsiUpperCase(TrLangMSG(msgMaterMany))+':';
                                   inc(XLRow);
                                   Sheet.Cells[XLRow,1]:=TrLangMSG(msgDesign);
                                   Sheet.Cells[XLRow,2]:=TrLangMSG(msgCount);
                                   Sheet.Cells[XLRow,3]:=TrLangMSG(msgDiamShort);
                                   inc(XLRow);
                                 end;
                             fl:=false;
                           end;
                         PrF2.Memo1.Lines.Add(Obor.{Qry_mat}Maters_q.FieldByName('LIST_MATER'{'MAT_LOOK'}).asString+' | '+
                         PadRight(FloatToStr(Round(Obor.{Qry_mat}Maters_q.FieldByName('KOL_MAT').asFloat,-2)),6,' ')+' | '+
                         Obor.{Qry_mat}Maters_q.FieldByName('LIST_DIAM'{'DIAM_LOOK'}).asString);
                         if isInExcel then
                                 begin
                                   Sheet.Cells[XLRow,1]:=Obor.{Qry_mat}Maters_q.FieldByName('LIST_MATER'{'MAT_LOOK'}).asString;
                                   Sheet.Cells[XLRow,2]:=Obor.{Qry_mat}Maters_q.FieldByName('KOL_MAT').asFloat;
                                   Sheet.Cells[XLRow,3]:=Obor.{Qry_mat}Maters_q.FieldByName('LIST_DIAM'{'DIAM_LOOK'}).asString;
                                   inc(XLRow);
                                 end;
                         Obor.{Qry_mat}Maters_q.Next;
                      end;
                    fl:=true;
                    Obor.{Qry_work}Works_q.First;
                     while not Obor.{Qry_work}Works_q.EOF do
                      begin
                         if fl then
                            begin
                              PrF2.Memo1.Lines.Add(Padcenter(' '+AnsiUpperCase(TrLangMSG(msgWorkMany))+': ',50,'-'));
                              PrF2.Memo1.Lines.Add(TrLangMSG(msgDesign)+'                    | '+TrLangMSG(msgCount)+' | '+TrLangMSG(msgDiamShort));
                              PrF2.Memo1.Lines.Add(s_line2);
                              if isInExcel then
                                 begin
                                   Sheet.Cells[XLRow,1]:=AnsiUpperCase(TrLangMSG(msgWorkMany))+':';
                                   inc(XLRow);
                                   Sheet.Cells[XLRow,1]:=TrLangMSG(msgDesign);
                                   Sheet.Cells[XLRow,2]:=TrLangMSG(msgCount);
                                   Sheet.Cells[XLRow,3]:=TrLangMSG(msgDiamShort);
                                   inc(XLRow);
                                 end;
                              fl:=false;
                            end;
                         PrF2.Memo1.Lines.Add(Padleft(Obor.{Qry_work}Works_q.FieldByName('LIST_WORK'{'WORK_LOOK'}).asString,31,' ')+' | '+
                         PadRight(FloatToStr(Obor.{Qry_work}Works_q.FieldByName('KOL_work').asFloat),6,' ')+' | '+
                         Obor.{Qry_work}Works_q.FieldByName('LIST_DIAM'{'DIAM_LOOK'}).asString);
                         if isInExcel then
                                 begin
                                   Sheet.Cells[XLRow,1]:=Obor.{Qry_work}Works_q.FieldByName('LIST_WORK'{'WORK_LOOK'}).asString;
                                   Sheet.Cells[XLRow,2]:=Obor.{Qry_work}Works_q.FieldByName('KOL_work').asFloat;
                                   Sheet.Cells[XLRow,3]:=Obor.{Qry_work}Works_q.FieldByName('LIST_DIAM'{'DIAM_LOOK'}).asString;
                                   inc(XLRow);
                                 end;

                         Obor.{Qry_work}Works_q.Next;
                      end;
                    fl:=true;
                    Obor.{Qry_obor}Obors_q.First;
                    while not Obor.{Qry_obor}Obors_q.EOF do
                      begin
                         if fl then
                           begin
                             PrF2.Memo1.Lines.Add(Padcenter(' '+AnsiUpperCase(TrLangMSG(msgEquip))+': ',30,'-'));
                              if isInExcel then
                                 begin
                                   Sheet.Cells[XLRow,1]:=AnsiUpperCase(TrLangMSG(msgEquip))+':';
                                   inc(XLRow);
                                 end;
                             fl:=false;
                           end;
                         PrF2.Memo1.Lines.Add(Obor.{Qry_obor}Obors_q.FieldByName('LIST_OBOR'{'OBOR_LOOK'}).asString);
                         if isInExcel then
                                 begin
                                   Sheet.Cells[XLRow,1]:=Obor.{Qry_obor}Obors_q.FieldByName('LIST_OBOR'{'OBOR_LOOK'}).asString;
                                   inc(XLRow);
                                 end;
                         Obor.{Qry_obor}Obors_q.Next;
                      end;
                    Obor.Close;
                    *)
                    PrF2.Memo1.Lines.Add(s_line);
                 end;
               NarForm.Close;
     end;

    MyOpenSQL(FDM_Zav.Qry_tmp,'select count(id) mm from zadv where id_zavin='+Inttostr(ZavCode)+' or id_zavout='+Inttostr(ZavCode));
    i:=FDM_Zav.Qry_tmp.FieldByName('MM').asInteger;
    FDM_Zav.Qry_tmp.Close;
    if i>0 then
      begin
         if isClosed then
           ZadvForm:=TFormClZadv.ZadvCreate(Self,0,ZavCode,0,'zadv',ZavAttach,not(rsZADV in RightsSet),FALSE)
         else
           ZadvForm:=TFormClZadv.ZadvCreate(Self,1,ZavCode,0,'zadv',ZavAttach,not(rsZADV in RightsSet),FALSE);
         cnt:=ZadvForm.TbC_zadv.Tabs.Count-1;
         PrF2.Memo1.Lines.Add(AnsiUpperCase(TrLangMSG(msgCloseZadv)));
         if isInExcel then
             begin
               inc(XLRow);
               Sheet.Cells[XLRow,1]:=AnsiUpperCase(TrLangMSG(msgCloseZadv));
               inc(XLRow);
             end;

         for i:=0 to cnt do
           begin
             ZadvForm.TbC_zadv.TabIndex:=i;
             Add2Memo(PrF2.Memo1,PadLeft(AnsiUpperCase(TrLangMSG(msgPereCloseZadv)),23,' '),'|',ZadvForm.DE_In.Text+' '+Time2Str(ZadvForm.TE_In.Time)+' '+
                                   Trim(ZadvForm.Qry_BrIn.FieldByName('NAME_R').asString)+' ãÞÚÁÉÞ:'+ZadvForm.Lb_zavin.Caption,40);
             Add2Memo(PrF2.Memo1,PadLeft(AnsiUpperCase(TrLangMSG(msgVidOpenZadv)),23,' '),'|',ZadvForm.DE_Out.Text+' '+Time2Str(ZadvForm.TE_Out.Time)+' '+
                                   Trim(ZadvForm.Qry_BrOut.FieldByName('NAME_R').asString)+' ãÞÚÁÉÞ:'+ZadvForm.Lb_zavOut.Caption,40);
             PrF2.Memo1.Lines.Add(PadLeft(AnsiUpperCase(TrLangMSG(msgDiam)),23,' ')+'|'+ZadvForm.Qry_Diam.FieldByName('DIAM').asString);
             tt_str:=Strip('B',' ',ZadvForm.Qry_ul1.FieldByName('NAME_R').asString);
             if CB_tAdr.Itemindex=0 then
                tt_str:=tt_str+' '+TrLangMSG(msgDomShort)+Trim(ZadvForm.Ed_ndom.Text)
             else if CB_tAdr.Itemindex=1 then
                tt_str:=tt_str+'<'+Strip('B',' ',ZadvForm.Qry_ul2.FieldByName('NAME_R').asString)
             else
                tt_str:=tt_str+' '+ansilowercase(TrLangMSG(msgPlace));

              tt_str:=tt_str+' '+ZadvForm.Ed_dopAdr.Text;
              Add2Memo(PrF2.Memo1,PadLeft(AnsiUpperCase(TrLangMSG(msgAddr)),23,' '),'|',tt_str,40);
              PrF2.Memo1.Lines.Add(s_line);
              if isInExcel then
                 begin
                         Sheet.Cells[XLRow,1]:=AnsiUpperCase(TrLangMSG(msgPereCloseZadv));
                         Sheet.Cells[XLRow,2]:=ZadvForm.DE_In.Text+' '+Time2Str(ZadvForm.TE_In.Time)+' '+
                                   Trim(ZadvForm.Qry_BrIn.FieldByName('NAME_R').asString)+' ãÞÚÁÉÞ:'+ZadvForm.Lb_zavin.Caption;
                         inc(XLRow);
                         Sheet.Cells[XLRow,1]:=AnsiUpperCase(TrLangMSG(msgVidOpenZadv));
                         Sheet.Cells[XLRow,2]:=ZadvForm.DE_Out.Text+' '+Time2Str(ZadvForm.TE_Out.Time)+' '+
                                   Trim(ZadvForm.Qry_BrOut.FieldByName('NAME_R').asString)+' ãÞÚÁÉÞ:'+ZadvForm.Lb_zavOut.Caption;
                         inc(XLRow);
                         Sheet.Cells[XLRow,1]:=AnsiUpperCase(TrLangMSG(msgDiam));
                         Sheet.Cells[XLRow,2]:=ZadvForm.Qry_Diam.FieldByName('DIAM').asString;
                         inc(XLRow);
                         Sheet.Cells[XLRow,1]:=AnsiUpperCase(TrLangMSG(msgAddr));
                         Sheet.Cells[XLRow,2]:=tt_str;
                         inc(XLRow,2);
                 end;

           end;
         ZadvForm.Close;
      end;

    MyOpenSQL(FDM_Zav.Qry_tmp,'select count(id) mm from raskop where id_zavin='+Inttostr(ZavCode)+' or id_zavout='+Inttostr(ZavCode));
    i:=FDM_Zav.Qry_tmp.FieldByName('MM').asInteger;
    FDM_Zav.Qry_tmp.Close;
    if i>0 then
      begin
         if isClosed then
           ZadvForm:=TFormClZadv.ZadvCreate(Self,0,ZavCode,0,'raskop',ZavAttach,not(rsRASK in RightsSet),FALSE)
         else
           ZadvForm:=TFormClZadv.ZadvCreate(Self,1,ZavCode,0,'raskop',ZavAttach,not(rsRASK in RightsSet),FALSE);
         cnt:=ZadvForm.TbC_zadv.Tabs.Count-1;
         PrF2.Memo1.Lines.Add(AnsiUpperCase(TrLangMSG(msgDigWorks)));
         if isInExcel then
             begin
               Sheet.Cells[XLRow,1]:=AnsiUpperCase(TrLangMSG(msgDigWorks));
               inc(XLRow);
             end;
         for i:=0 to cnt do
           begin
             ZadvForm.TbC_zadv.TabIndex:=i;
             Add2Memo(PrF2.Memo1,PadLeft(AnsiUpperCase(TrLangMSG(msgDiggRaskop)),23,' '),'|',ZadvForm.DE_In.Text+' '+Time2Str(ZadvForm.TE_In.Time)+' '+
                                   Trim(ZadvForm.Qry_BrIn.FieldByName('NAME_R').asString)+' ãÞÚÁÉÞ:'+ZadvForm.Lb_zavin.Caption,40);
             Add2Memo(PrF2.Memo1,'ãþéíîþìí               ','|',ZadvForm.DE_Out.Text+' '+Time2Str(ZadvForm.TE_Out.Time)+' '+
                                   Trim(ZadvForm.Qry_BrOut.FieldByName('NAME_R').asString)+' ãÞÚÁÉÞ:'+ZadvForm.Lb_zavOut.Caption,40);
             tt_str:=Strip('B',' ',ZadvForm.Qry_ul1.FieldByName('NAME_R').asString);
             if CB_tAdr.Itemindex=0 then
                tt_str:=tt_str+' '+TrLangMSG(msgDomShort)+Trim(ZadvForm.Ed_ndom.Text)
             else if CB_tAdr.Itemindex=1 then
                tt_str:=tt_str+'<'+Strip('B',' ',ZadvForm.Qry_ul2.FieldByName('NAME_R').asString)
             else
                tt_str:=tt_str+' '+ansilowercase(TrLangMSG(msgPlace));

              tt_str:=tt_str+' '+ZadvForm.Ed_dopAdr.Text;
              Add2Memo(PrF2.Memo1,PadLeft(AnsiUpperCase(TrLangMSG(msgAddr)),23,' '),'|',tt_str,40);
              PrF2.Memo1.Lines.Add(s_line);
              if isInExcel then
                 begin
                         Sheet.Cells[XLRow,1]:=AnsiUpperCase(TrLangMSG(msgDiggRaskop));
                         Sheet.Cells[XLRow,2]:=ZadvForm.DE_In.Text+' '+Time2Str(ZadvForm.TE_In.Time)+' '+
                                   Trim(ZadvForm.Qry_BrIn.FieldByName('NAME_R').asString)+' ãÞÚÁÉÞ:'+ZadvForm.Lb_zavin.Caption;
                         inc(XLRow);
                         Sheet.Cells[XLRow,1]:='ãþéíîþìí';
                         Sheet.Cells[XLRow,2]:=ZadvForm.DE_Out.Text+' '+Time2Str(ZadvForm.TE_Out.Time)+' '+
                                   Trim(ZadvForm.Qry_BrOut.FieldByName('NAME_R').asString)+' ãÞÚÁÉÞ:'+ZadvForm.Lb_zavOut.Caption;
                         inc(XLRow);
                         Sheet.Cells[XLRow,1]:=AnsiUpperCase(TrLangMSG(msgAddr));
                         Sheet.Cells[XLRow,2]:=tt_str;
                         inc(XLRow,2);
                 end;

           end;
         ZadvForm.Close;
      end;
    FDM_Zav.Qry_zajav.Close;
  //  if not isinExcel then
    PrF2.ShowModal;
    ButVis(FormZav,true);
    ViewButPr;
end;
