procedure TFormZav.toPoteriForm;
begin
  if Assigned(PoteriForm) then
  begin
    PoteriForm.Op_Protyazh:=FOp_Protyazh;
    PoteriForm.Cl_Doza:=FCl_Doza;
    PoteriForm.Cl_Contact_Time:=FCl_Contact_Time;
    PoteriForm.Cl_Promiv_Time:=FCl_Promiv_Time;
    PoteriForm.Cl_Pressure:=FCl_Pressure;
    PoteriForm.Utoch_Xar_Povr:=FUtoch_Xar_Povr;
    PoteriForm.ID_OpDiam_Povrezhd:=FOp_Id_Diam;
    PoteriForm.ActDate:=FActDate;
    //
    PoteriForm.sePress_Value:=sePress_Value;
    PoteriForm.seSquareLeak_Value:=seSquareLeak_Value;
    PoteriForm.seSpeedLeak_Value:=seSpeedLeak_Value;
    PoteriForm.seGLZ_Value:=seGLZ_Value;
    //
    PoteriForm.SVISCH_DIAM := FSVISCH_DIAM;
    PoteriForm.TRESCH_DLINA := FTRESCH_DLINA;
    PoteriForm.TRESCH_SHIRINA := FTRESCH_SHIRINA;
    PoteriForm.TOR_VNESHN_DIAM := FTOR_VNESHN_DIAM;
    PoteriForm.TOR_VNUTR_DIAM := FTOR_VNUTR_DIAM;
    PoteriForm.TOR_UGOL := FTOR_UGOL;
    PoteriForm.XAR_MESTA_POVR := TXarPovr(FXAR_MESTA_POVR);
    //
    PoteriForm.Diam_Povrezhd:=DBL_Diam.Text;
    PoteriForm.PostuplDateTime:=DateOf(DE_In.Date)+TimeOf(TE_In.Time);
    PoteriForm.MatPipe:=FDM_Zav.s_matpipe.FieldByName('NAME_R').AsString;
    //
    if FPoteriEndDateTime<>0 then
      begin
        PoteriForm.EndDate:=DateToStr(FPoteriEndDateTime);
        PoteriForm.EndTime:=MyTimeToStr(FPoteriEndDateTime);
      end
        else
      begin
        PoteriForm.EndDate:='';
        PoteriForm.EndTime:='';
      end;
    try
      PoteriForm.Street:=DM1.Gen_Addr('',DBL_ul1.Text,DBL_ul2.Text,Ed_ndom.Text,IntToStr(CB_tAdr.ItemIndex),Ed_DopAdr.Text,dbl_DopAdres.text);
    except
      PoteriForm.Street:='вул. , 100';
    end;
  end;
end;

procedure TFormZav.fromPoteriForm;
begin
  if Assigned(PoteriForm) then
  begin
    sePress_Value:=PoteriForm.sePress_Value;
    seSquareLeak_Value:=PoteriForm.seSquareLeak_Value;
    seSpeedLeak_Value:=PoteriForm.seSpeedLeak_Value;
    seGLZ_Value:=PoteriForm.seGLZ_Value;
    //
    FOp_Protyazh:=PoteriForm.Op_Protyazh;
    FCl_Doza:=PoteriForm.Cl_Doza;
    FCl_Contact_Time:=PoteriForm.Cl_Contact_Time;
    FCl_Promiv_Time:=PoteriForm.Cl_Promiv_Time;
    FCl_Pressure:=PoteriForm.Cl_Pressure;
    FUtoch_Xar_Povr:=PoteriForm.Utoch_Xar_Povr;
    FOp_Id_Diam:=PoteriForm.ID_OpDiam_Povrezhd;
    FOp_Diam:=PoteriForm.OpDiam_Povrezhd;
    FActDate:=PoteriForm.ActDate;
    //
    FXAR_MESTA_POVR := integer(PoteriForm.XAR_MESTA_POVR);
    FSVISCH_DIAM := PoteriForm.SVISCH_DIAM;
    FTRESCH_DLINA := PoteriForm.TRESCH_DLINA;
    FTRESCH_SHIRINA := PoteriForm.TRESCH_SHIRINA;
    FTOR_VNESHN_DIAM := PoteriForm.TOR_VNESHN_DIAM;
    FTOR_VNUTR_DIAM := PoteriForm.TOR_VNUTR_DIAM;
    FTOR_UGOL := PoteriForm.TOR_UGOL;
    //
    if (PoteriForm.EndDate<>'')
      then  FPoteriEndDateTime:=StrToDateTime(PoteriForm.EndDate+' '+PoteriForm.EndTime)
      else  FPoteriEndDateTime:=0;
  end;
end;


procedure TFormZav.SavePoteriForClosedZav;
var
  _s: string;
begin
  if isClosed then
  begin
    _s :=
      ' update zavjav set' +

      ' XAR_MESTA_POVR=' + IntToStr( FXAR_MESTA_POVR ) + ',' +
      ' SVISCH_DIAM=' + IntToStr( FSVISCH_DIAM ) + ',' +
      ' TRESCH_DLINA=' + IntToStr( FTRESCH_DLINA ) + ',' +
      ' TRESCH_SHIRINA=' + IntToStr( FTRESCH_SHIRINA ) + ',' +
      ' TOR_VNESHN_DIAM=' + IntToStr( FTOR_VNESHN_DIAM ) + ',' +
      ' TOR_VNUTR_DIAM=' + IntToStr( FTOR_VNUTR_DIAM ) + ',' +
      ' TOR_UGOL=' + IntToStr( FTOR_UGOL ) + ',' +

      ' PoteriEndDateTime="' + DateTimeToStr( FPoteriEndDateTime ) + '",' +
      ' ACTDATE="' + DateTimeToStr(FActDate) + '",' +
      ' Op_Protyazh=' + MyFloatToStr( FOp_Protyazh ) + ',' +
      ' Cl_Doza=' + MyFloatToStr( FCl_Doza ) + ',' +
      ' Cl_Contact_Time="' + DE_in.Text + ' ' + Time2Str( FCl_Contact_Time ) + '",' +
      ' Cl_Promiv_Time="' + DE_in.Text + ' ' + Time2Str( FCl_Promiv_Time ) + '",' +
      ' Cl_Pressure=' + MyFloatToStr( FCl_Pressure ) + ',' +
      ' Utoch_Xar_Povr=' + QuotedStr( FUtoch_Xar_Povr ) + ',' +
      ' Op_Id_Diam=' + IntToStr( FOp_Id_Diam ) + ',' +

      ' pressure=' + ReplaceStr( MyFloatToStr( sePress_Value ), ',', '.' ) + ',' +
      ' square=' + ReplaceStr( MyFloatToStr( seSquareLeak_Value ), ',', '.' ) + ',' +
      ' q=' + ReplaceStr( MyFloatToStr( seSpeedLeak_Value ), ',', '.' ) + ',' +
      ' glz=' + ReplaceStr( MyFloatToStr( seGLZ_Value ), ',', '.' ) +

      ' where id=' + IntToStr( ZavCode );

      MyExecSQL( FDM_Zav.Qry_zajav, _s );
      MyExecSQL( FDM_Zav.Qry_zajav, 'COMMIT' );
  end;
end;
