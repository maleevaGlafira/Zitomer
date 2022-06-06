unit zav_obj;

interface
{$I !map_define.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, RXLookup, DBTables, ExtCtrls, Buttons, Mask, ToolEdit, Math,
  ComCtrls, Menus,prosm2, frmLANG, cntsLANG, variants, RXSpin,RxStrUtils,
  StrUtils,reports_unit,StackUnit,datam,OperAttFormUnit,ServiceFuncUnit,
  {$IFDEF MAP} SendMessToAvarOnMap, AvarOnMapConst, _avonm_DMAvarUnit, {$ENDIF}
  Zav_DMUnit, DBCtrls,DateUtils,Report_Zayav_Unit, NGReports, narad,
  GeoCoordUnit, RXCtrls, zav;


type
  TFormZavObj = class(TFormZav)
 //   Label8: TLabel;
    dbl_Object: TRxDBLookupCombo;
    Label26: TLabel;
    dbl_Soorug: TRxDBLookupCombo;
    cb_ObjObor: TCheckBox;
    bt_Objobor: TButton;
    procedure cbAttachChange(Sender: TObject);
    procedure dbl_ObjectChange(Sender: TObject);
    procedure DBL_raonKeyPress(Sender: TObject; var Key: Char);
    procedure cb_ObjOborClick(Sender: TObject);
    procedure bt_ObjoborClick(Sender: TObject);
    procedure DBL_raonChange(Sender: TObject);
  private
    procedure NewPrint; override;
    procedure LightNeedFields; override;
    procedure DisplayValuesFromDB; override;
    procedure ShowRevsRaonUlic; override;
    procedure InitNarForm( _NarForm: TFormNarad ); override;
    function GetAdresForPrint: string; override;
    procedure InitCbAttach; override;
    function GetObjOborGlob(IDZav: integer): string;
  public
    function CheckFill(toClose:boolean):boolean; override;
    procedure isVvod(st:boolean); override;
  end;

implementation

{$R *.dfm}

uses strtool, main, ObjOborUnit, DM_VedomPublicUnit,HelpFunctions;

{ TFormZavObj }

function TFormZavObj.CheckFill(toClose: boolean): boolean;
var
  res1: boolean;
begin
    {1}try
      Result := false;
      Res1 := false;
       if (not isClosed) and (not (not (rsZAV in RightsSet))) and
         (Strip('A','. ',DE_in.Text)<>'') and
         (TE_in.Time<>0) and
         {вид заявки}(FDM_Zav.Qry_owner.FieldByName('ID').asInteger>0) and
         {о чем заявлено}(FDM_Zav.Qry_comment.FieldByName('ID').asInteger>0) and
                          ( trim(DBL_WhatMatter.Text) <> '' ) and
         {Объект}        (FDM_Zav.qry_Object.FieldByName( 'ID' ).AsInteger > 0) and
                          ( trim(DBL_Object.Text) <> '' )
          then begin
             if (FDM_Zav.Qry_owner.FieldByName('OWNER_TYPE').asInteger=3{id=4}) {если "на выяснении"}
             then Res1:=(true)
             else Res1:=(false or (ZavCode>0)) and ((FNNarCount<>0) or
              ((FDM_Zav.Qry_owner.FieldByName('OWNER_TYPE').asInteger=4{id=3 - ложные}))) or
              (Lb_Nzav.Caption='Новый');
             if (not(Res1){ and (BB_Narad.Font.Color<>ErrCol)  })then
             begin
                BB_Narad.Font.Color:=clGreen
             end else
             begin
                if {FDM_Zav.NNarCount(ZavCode)<0} FNNarCount<0 then BB_Narad.Font.Color:=ErrCol
                else BB_Narad.Font.Color:=TextCol;
             end;
          end;

      if (not isClosed) and toClose and res1 and not(FDM_Zav.Qry_owner.FieldByName('OWNER_TYPE').asInteger in [1{id=2,5}]) then
        begin
        if {(not isIzm)and}
          ((Strip('A','. ',DE_out.Text)<>'') and (TE_out.Time<>0) and (DE_out.Visible))
            or not(DE_out.Visible)
           then begin
             case FDM_Zav.Qry_owner.FieldByName('OWNER_TYPE').asInteger of
               3: Result:=false;
               4: Result:=true;
               2,1:begin
                     if {тип заявки}(FDM_Zav.Qry_tzav.FieldByName('ID').asInteger>0)
                     then Result:=true
                     else Result:=false;
                   end
             end;
          end
        end
      else
        Result:=res1;
  except
    on E:Exception do ShowErr(handle,'TFormZav.CheckFill :: 1',E);
  end;
end;

procedure TFormZavObj.DisplayValuesFromDB;
begin
  inherited;
  if FormMode = tfmZayavAfterInsert then
  begin
    DBL_Revs.DisplayValue:=FDM_Zav.Qry_Revs.FieldByName('NAME_R').asString;  
    dbl_Object.DisplayValue := FDM_Zav.qry_Object.FieldByName( 'name_r' ).AsString;
    dbl_Soorug.DisplayValue := FDM_Zav.qry_Soorug.FieldByName( 'name_r' ).AsString;
  end;
end;

function TFormZavObj.GetAdresForPrint: string;
begin
  Result := DBL_Revs.DisplayValue +', '+dbl_Object.DisplayValue+', '+ dbl_Soorug.DisplayValue; 
end;

procedure TFormZavObj.InitCbAttach;
begin
  cbAttach.Items.Clear;
  cbAttach.Items.AddObject( 'ОБЪЕКТЫ ВОДОПРОВОДА',  Ptr( Integer( toaObjVoda ) ) );
  cbAttach.Items.AddObject( 'ОБЪЕКТЫ КАНАЛИЗАЦИИ',  Ptr( Integer( toaObjKanal ) ) );
  case ZavAttach of
     toaObjVoda:  cbAttach.ItemIndex := 0;
     toaObjKanal: cbAttach.ItemIndex := 1;
     else
     begin
      ZavAttach := toaObjVoda;
      cbAttach.ItemIndex := 0;
     end;
  end;
end;

procedure TFormZavObj.InitNarForm(_NarForm: TFormNarad);
begin
  _NarForm.MestTypeID := GetMestTypeID;
  _NarForm.ObjectID := dbl_Object.LookupSource.DataSet.FieldByName( 'id' ).AsInteger;
end;

procedure TFormZavObj.isVvod(st: boolean);
begin
  inherited;
  dbl_Object.Enabled := st;
end;

procedure TFormZavObj.LightNeedFields;
var
  _cl:TColor;
begin
  if (not isClosed) and (not (not (rsZAV in RightsSet))) then
    begin
      _cl:=clYellow;
      DE_In.Color:=_cl;
      TE_In.Color:=_cl;
      {
      DBL_Revs.Color:=_cl;
      case CB_tAdr.ItemIndex of
        0: begin DBL_Ul1.Color:=_cl; end;
        1: begin DBL_Ul1.Color:=_cl; DBL_Ul2.Color:=_cl; end;
        2: begin DBL_Ul1.Color:=clWhite; end;
      end;
      }
      DBL_Owner.Color:=_cl;
      DBL_WhatMatter.Color:=_cl;
      DBL_Object.Color := _cl;
      //ED_Ndom.Color:=_cl;

      if FDM_Zav.Qry_owner.Active then
        begin
          if not (FDM_Zav.Qry_owner.FieldByName('OWNER_TYPE').asInteger in [2{,1}{id=1,6,7,8,2,5,9}]) then
            begin
              _cl:=clWhite;
            end;
          //{местность} DBL_Mest.Color:=_cl;
          {тип заявки} DBL_tzav.Color:=_cl;
          //{характер повреждения}DBL_sod.Color:=_cl;
          //{место повреждения} DBL_Place.Color:=_cl;
          //{диаметр} //DBL_Diam.Color:=_cl;
          //{материал трубы} //DBL_Matpipe.Color:=_cl;
        end;
      
    end;
end;

procedure TFormZavObj.ShowRevsRaonUlic;
begin
  FDM_Zav.Qry_Object.Locate( 'ID', strtointdef( FDM_Zav.Qry_zajav.FieldByName('ID_Object').AsString,-1),[]);
  DBL_Object.DisplayValue:=FDM_Zav.Qry_Object.FieldByName('name_r').AsString;

  FDM_Zav.Qry_Soorug.Locate( 'ID', strtointdef( FDM_Zav.Qry_zajav.FieldByName('ID_Soorug').AsString,-1),[]);
  DBL_Soorug.DisplayValue:=FDM_Zav.Qry_Soorug.FieldByName('name_r').AsString;

  FDM_Zav.Qry_revs.Locate( 'ID', strtointdef( FDM_Zav.Qry_zajav.FieldByName('ID_Revs').AsString,-1),[]);
  DBL_Revs.DisplayValue:=FDM_Zav.Qry_revs.FieldByName('name_r').AsString;


end;

procedure TFormZavObj.cbAttachChange(Sender: TObject);
begin
  ZavAttach := TOperAtt( Integer( cbAttach.Items.Objects[ cbAttach.ItemIndex ] ) );

  FDM_Zav.Qry_object.Close;
  FDM_Zav.Qry_object.ParamByName( 'pAttachID' ).AsInteger := Ord( ZavAttach );
  FDM_Zav.Qry_object.Open;

  FDM_Zav.Qry_object.First;

  inherited;
end;

procedure TFormZavObj.dbl_ObjectChange(Sender: TObject);
 var idObj: integer;
begin
  idObj := FDM_Zav.qry_Object.FieldByName('id').AsInteger;

  if FDM_Zav.Qry_soorug.Active then FDM_Zav.Qry_soorug.Close;
  FDM_Zav.Qry_soorug.ParamByName( 'pObjectID' ).AsInteger := idObj;
  FDM_Zav.Qry_soorug.Open;

  FDM_Zav.Qry_soorug.First;

  DBL_raonChange(Sender);
  inherited;
//

end;

procedure TFormZavObj.DBL_raonKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
   //
end;

procedure TFormZavObj.cb_ObjOborClick(Sender: TObject);
 var tmp_id, _pos: integer;
      _sql, _addsql : string;
begin
  inherited;
//
  tmp_id := FDM_Zav.Qry_comment.FieldByName('id').AsInteger;
  _addsql := '';
  _sql := 'select id,name_r , ID_OBORTYPEGLOB '+
          ' from s_sod '+
          ' where (del in (''-'',''d'')) and (zayavl=1) '+
          ' order by name_r ';
   _pos := pos('order',_sql);
  if cb_ObjObor.Checked then
    begin
      _addsql := GetObjOborGlob(ZavCode);
      Insert(_addsql , _sql, _pos);
    end;
  FDM_Zav.Qry_comment.Close;
  FDM_Zav.Qry_comment.SQL.Text := _sql;
  FDM_Zav.Qry_comment.Open;
  //FDM_Zav.Qry_comment.Filter := 'ID_OBORTYPEGLOB in '+ GetObjOborGlob(ZavCode);
end;

function TFormZavObj.GetObjOborGlob(IDZav: integer): string;
var _res: string;
begin
  //

  FDM_Zav.IBQ_tmp.SQL.Text :=
  ' select distinct id from s_obortypeglob where id in '+
  ' (select distinct id_obortypeglob from s_obortype where id in '+
  ' (select distinct id_obortype from s_objobor where id in '+
  ' (select distinct id_objobor from objoborzav where id_zav = '+IntToStr(ZavCode)+')))';
  FDM_Zav.IBQ_tmp.Open;
  FDM_Zav.IBQ_tmp.First;
  _res := '';
  while not FDM_Zav.IBQ_tmp.Eof do
  begin
   _res := _res + ', '+ FDM_Zav.IBQ_tmp.fieldbyname('id').AsString;
   FDM_Zav.IBQ_tmp.Next;
  end;
   FDM_Zav.IBQ_tmp.Close;
  _res := ' and ID_OBORTYPEGLOB in ( -1 ' + _res + ') or (id = -1) ';
  Result := _res;

end;

procedure TFormZavObj.bt_ObjoborClick(Sender: TObject);
var frm : TObjOborForm;
begin
  inherited;
//
  frm:= TObjOborForm.Create(nil);
  try
    frm.IdZav := ZavCode;
    frm.IdObj:= FDM_Zav.qry_Object.FieldByName('id').AsInteger;
    frm.IdSoorug:= FDM_Zav.qry_soorug.FieldByName('id').AsInteger;
    frm.isClosed:= isClosed;
    frm.ShowModal;
  finally
    frm.Free;
  end;
end;

procedure TFormZavObj.DBL_raonChange(Sender: TObject);
begin
  inherited;
//

end;


procedure TFormZavObj.NewPrint;
  function PrepareStr(str: string): string;
  begin
    //if AnsiUpperCase(trim(str))='<ПУСТО>' then
    if (pos('пусто', str)<>0) or (pos('ПУСТО', str)<>0) then
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
      toaVoda: Result := 'ПО В/С';
      toaKanal: Result := 'ПО В/О';
      toaObjVoda: Result := 'ПО ОБЪЕКТАМ В/С';
      toaObjKanal: Result := 'ПО ОБЪЕКТАМ В/О';
      else Result := '';
    end;
  end;

  function PrepObjectName( _obj, _soor, _zex: string  ): string;
  begin


   result := '';
  end;

  function GetObjectForPrint: string;
    var _obj, _soor, _objobor: string;
        _n : integer;
   begin
     _obj := DBL_Revs.DisplayValue;
     if _obj = '<пусто>' then _obj := ''
      else _obj := _obj + ', ';
     _soor := dbl_Object.DisplayValue;
     if _soor = '<пусто>' then _soor := ''
      else _soor := _soor + ', ';
     _objobor := dbl_Soorug.DisplayValue;
     if _objobor = '<пусто>' then _objobor := '';

     //
    Result := _obj+ _soor+ _objobor;
   end;

  function GetSpisOborForPrint: string;
   var tt_str, _res, _s: string;
       i: integer;
   begin
     //

    tt_str := 'select oz.id, oz.id_zav, oz.id_objobor '+
      ', (select name_r from s_objobor where id = oz.id_objobor) name_r '+
      'from objoborzav oz '+
      'where ( oz.id_zav = ' + inttostr(ZavCode) + ' ) '+
      'order by 4';
    _res := '';
    i := 0;
    MyOpenSQL(FDM_Zav.Qry_tmp,tt_str);
     FDM_Zav.Qry_tmp.First;
     while not FDM_Zav.Qry_tmp.Eof do
      begin
        if i>0 then _s := ', ' else _s := '';
        _res := _res + _s + FDM_Zav.Qry_tmp.fieldbyname('name_r').AsString;
        i:= i+1;
        FDM_Zav.Qry_tmp.Next;
      end;
     Result := _res;
   end;



var
  _viezd_date,_begin_date,_end_date: TDateTime;
  _DTBeginWork2,_DTEndWork2: TDateTime;
  _Brigs2, _master:string;
  __ZavCode:integer;
  _peredano, _dt_act, _bract,_brblag: string;
begin
 // inherited;
  __ZavCode:=-2;
  if (Lb_Nzav.Caption<>TrLangMSG(msgNewM)) and (Lb_Nzav.Caption<>'') then __ZavCode:=ZavCode;
  try
    DM_Reports:=TDM_Reports.Create(nil,trtZavObj);
  except
    on E:Exception do
      begin
        MessageBox(handle,PChar('TFormZav.NewPrint'#13+
          E.Message),'Диспетчер АВР', MB_OK or MB_ICONWARNING);
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
          //DM_Reports.ZayavRep.NeedOfCountScreenShot:=0;
          //DM_Reports.ZayavRep.ScreenShotFileName_1:=''
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
                Qry_Zadv.Close;
                Qry_Zadv.ParamByName('id_zav').Value:=__ZavCode;
                Qry_Zadv.Open;

                Qry_FirstViezdZadv.Close;
                Qry_FirstViezdZadv.ParamByName('pID_Zav').Value:=__ZavCode;
                Qry_FirstViezdZadv.Open;

                Qry_NotFirstViezdZadv.Close;
                Qry_NotFirstViezdZadv.ParamByName('pID_Zav').Value:=__ZavCode;
                Qry_NotFirstViezdZadv.Open;

                Qry_narad.Close;
                qry_narad.ParamByName('id_zav').Value:=__ZavCode;
                qry_narad.Open;
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
        VarValue['ObjSoor']:=GetObjectForPrint;
        VarValue['SpisObj']:=GetSpisOborForPrint;
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
        VarValue['WithoutWater']:=addprobf(DM_VedomPublic.WithoutWater(__ZavCode),270);
        VarValue['FirstViezdWorks']:=DM_VedomPublic.WorksObjObor(wiFirstViezd, __ZavCode);
        VarValue['PlanObors']:=addprobf(DM_VedomPublic.PlanObors(__ZavCode),270);
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
        VarValue['UsedObors']:=DM_VedomPublic.UsedObors(__ZavCode);
        VarValue['Maters']:=addprobf(DM_VedomPublic.Maters(__ZavCode),270);

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

        VarValue['NeedWorks']:=addprobf(DM_VedomPublic.NeedWorks(__ZavCode),270);
        VarValue['peredano']:=_peredano;
        VarValue['dt_act']:=_dt_act;
        VarValue['BrAct']:=_BrAct;
        VarValue['Brblag']:=_Brblag;

        VarValue['Sdal']:=PrepareStr(DBL_Sdal.DisplayValue);
        VarValue['DisOut']:=Lb_disOut.Caption;

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


end.
