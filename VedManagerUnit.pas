unit VedManagerUnit;

interface

uses
  SysUtils, Classes, FR_Class,Forms, Windows, DB, DBTables, FR_DSet,
  FR_DBSet,datam, frOLEExl, FR_DCtrl,ExtCtrls,Buttons,FR_View, Dialogs,DateUtils,
  OperAttFormUnit, AvrDBConst,DMmain, IBDatabase, IBCustomDataSet;

type
  TRepExp=(treNull,treShow,treExcel);
  TBlagType = ( btAll, btNeedBlag );

  TDM_VedManager = class(TDataModule)
    frReportVed: TfrReport;
    Qry_tmp: TQuery;
    frDBDataSet1: TfrDBDataSet;
    Qry_Tmp_Sub: TQuery;
    frDBDataSet2: TfrDBDataSet;
    Qry_Ul2: TQuery;
    dset_tmp: TIBDataSet;
    tran: TIBTransaction;
    dset_ul2: TIBDataSet;
    dset_Tmp_Sub: TIBDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure frReportVedGetValue(const ParName: String;
      var ParValue: Variant);
  private
    { Private declarations }
    FVedName:string;
    FDT_In,FDT_Out:TDateTime;
    FVedRepDir:string;
    FNameUl:string;
    FIDUl:integer;
    FOperateAttach:TOperAtt;
    FAttachStr:string;
    FBlagType: TBlagType;
    function GetUlByID(_ul2:integer):string;
    procedure _Utechki;
    procedure _Utechki_Vodopr;
    procedure _Utechki_Other;
    procedure _Utechki_Vodomer;
    procedure _Ustran;
    procedure _Ustran_vod;
    procedure _Abon;
    procedure _Kolvo;
    procedure _Vipoln;
    procedure _DelZayav;
    procedure _ViborPoUl;
    procedure _PostupAbon;
    //
    function GetWhoWhenDel(_what:integer; value:string):string;
    procedure SetFOperateAttach(value:TOperAtt);
  public
    { Public declarations }
    function LoadVedReport(vedname:string):boolean;
    procedure ShowReport(_RepExp:TRepExp=treShow);
    //function GenAddr(_ul1,_ul2,_kod_ul,_dopadr:string):string;
    //
    property OperateAttach:TOperAtt read FOperateAttach write SetFOperateAttach;
    property DT_In:TDateTime read FDT_In write FDT_In;
    property DT_Out:TDateTime read FDT_Out write FDT_Out;
    property NameUl:string read FNameUl write FNameUl; //название улицы - используется ведомостью "выбор всех заявок по улице"
    property IDUl:integer read FIDUl write FIDUl; //айди улицы - используется ведомостью "выбор всех заявок по улице"
    property BlagType: TBlagType read FBlagType write FBlagType;
  end;

var
  DM_VedManager: TDM_VedManager;

implementation

uses DM_VedomPublicUnit;

{$R *.dfm}

procedure TDM_VedManager._PostupAbon;
var s:string;
begin
  s:='select z.kod_ul,z.dt_in z_dt_in,'+
    '  z.id_alien,'+
  ' (select for_vedom from s_owner'+
  ' where z.id_alien=s_owner.id) as own, z.id_ul1,z.id_ul2,'+
  ' z.nomer, sd.id xar_povr_id, sd.name_r xar_povr, sd.id XAR_POVR_ID, dm.diam dm_diam, smat.id smat_id, smat.name_r smat_name, '+
  ' (select rtrim(u.name_r)||" "||rtrim(v.name_r)'+
  ' from s_ulic u,s_vidul v'+
  '  where (u.del in (''-'',''d'')) and (u.id_vidul>-2) and (u.id_vidul=v.id)'+
  '   and (u.id=z.id_ul1)) as ul1,'+
  '   id_ul2, dop_adr, z.id_dopadres'+
  '  from %s z,s_diam dm, s_sod sd, s_matpipe smat '+
  '  where (delz=0 and (is_otl is null or is_otl<>1)) and (dm.id=z.id_diam) and (smat.id=z.id_matpipe) and '+
  '  (z.dt_in>='''+DateTimeToStr(Fdt_in)+''') and (z.dt_in<='''+DateTimeToStr(Fdt_out)+''')'+
  '   and (z.id_sod=sd.id)'+
  '   and ((z.id_alien=2) or (z.id_alien=5))'+FAttachStr;
  //
  dset_tmp.Close;
  dset_tmp.SelectSQL.Clear;
  dset_tmp.SelectSQL.Add(Format(s,['zavjav'])+' union '+Format(s,['nzavjav'])+' order by 4,2,7');
  //
  frVariables['time1']:=TimeToStr(DT_In);
  frVariables['date1']:=DateToStr(DT_In);
  frVariables['time2']:=TimeToStr(DT_Out);
  frVariables['date2']:=DateToStr(DT_Out);
end;

procedure TDM_VedManager.SetFOperateAttach(value:TOperAtt);
begin
  FOperateAttach:=value;
  FAttachStr:=' and (z.id_attach='+IntToStr(integer(FOperateAttach))+') ';
end;

function TDM_VedManager.GetUlByID(_ul2:integer):string;
begin
  dset_ul2.Close;
  dset_ul2.ParamByName('id_ul2').AsInteger:=_ul2;
  dset_ul2.Open;
  result:=dset_ul2.FieldByName('ul2').AsString;
  dset_ul2.Close;
end;

{function TDM_VedManager.GenAddr(_ul1,_ul2,_kod_ul,_dopadr:string):string;
begin
  result:='';
  _ul1:=trim(_ul1); _ul2:=trim(_ul2); _kod_ul:=trim(_kod_ul); _dopadr:=trim(_dopadr);
  if _kod_ul='0' then result:=_ul1+','+_ul2
    else
      begin
        result:=_ul1+' / '+GetUlByID(StrToInt(_ul2));
      end;
  if _dopadr<>'' then result:=result+' ('+_dopadr+')';
end;}

procedure TDM_VedManager._ViborPoUl;
var s:string;
begin
  s:=' select z.nomer as NOMER, z.dt_in Z_DT_IN, z.id_alien, '+
      '   (select for_vedom from s_owner '+
      '   where z.id_alien=s_owner.id) as own, '+
      '  z.id_ul2 as NDOM, z.dop_adr as DOPADR, '+
      '  sd.id xar_povr_id, sd.name_r as XAR_POVR, '+
      '  dm.diam as DIAM, z.dt_out as DT_USTRAN, '+
      ' (select min( out_dt_raskop ) from get_zav_raskops(z.id, -1, -1, -1, -1 ) ) DT_RASK,'+
      ' (select max( out_dt_work1 ) from get_zav_raskops(z.id, ' + IntToStr( Ord( tsc_sw_ZASIPKA ) ) + ', -1, -1, -1 ) ) DT_ZASYP,'+
      ' z.id_dopadres '+
      ' from %s z, '+
      ' s_diam dm, s_sod sd '+
      ' where (delz=0 and (is_otl is null or is_otl<>1) ) and (dm.id=z.id_diam) and '+
      ' (z.dt_in>='''+DateTimeToStr(Fdt_in)+''') and (z.dt_in<='''+DateTimeToStr(Fdt_out)+''') '+
      ' and (z.id_sod=sd.id) '+
      //' and (z.kod_ul=0) '+
      ' and ( (z.id_ul1='+IntToStr(FIDUl)+') or (z.id_ul2='''+IntToStr(FIDUl)+''' and z.kod_ul=1) ) '+
      FAttachStr;

  dset_tmp.Close;
  dset_tmp.SelectSQL.Clear;
  dset_tmp.SelectSQL.Add(Format(s,['zavjav'])+' union '+Format(s,['nzavjav'])+' order by 4,2,1 ');
  //
  frVariables['findul']:=NameUl;
  frVariables['time1']:=TimeToStr(DT_In);
  frVariables['date1']:=DateToStr(DT_In);
  frVariables['time2']:=TimeToStr(DT_Out);
  frVariables['date2']:=DateToStr(DT_Out);
end;

procedure TDM_VedManager._DelZayav;
begin
  dset_tmp.Close;
  dset_tmp.SelectSQL.Clear;
  //
  dset_tmp.SelectSQL.Add('  select z.id_alien, ');
  dset_tmp.SelectSQL.Add('  (select for_vedom from s_owner ');
  dset_tmp.SelectSQL.Add('   where z.id_alien=s_owner.id) as own, ');
  dset_tmp.SelectSQL.Add(' z.nomer, z.dt_in z_dt_in, ');
  dset_tmp.SelectSQL.Add('  (select rtrim(u.name_r)||" "||rtrim(v.name_r) ');
  dset_tmp.SelectSQL.Add('   from s_ulic u,s_vidul v ');
  dset_tmp.SelectSQL.Add('   where (u.del in (''-'',''d'')) and (u.id_vidul>-2) and (u.id_vidul=v.id) ');
  dset_tmp.SelectSQL.Add('    and (u.id=z.id_ul1)) as ul1, id_ul2, dop_adr, kod_ul, z.id_dopadres, ');
  dset_tmp.SelectSQL.Add(' z.id_comment, ss.name_r COMMENT_name, z.dop_inf, ');
  dset_tmp.SelectSQL.Add(' z.id_disin, ');
  dset_tmp.SelectSQL.Add(' (select s_brig.name_r from s_brig ');
  dset_tmp.SelectSQL.Add('   where z.id_disin=s_brig.id) as disin, ');
  dset_tmp.SelectSQL.Add('   "                               " as who_to_del, ');
  dset_tmp.SelectSQL.Add('   "                               " as when_to_del ');
  dset_tmp.SelectSQL.Add('from nzavjav z, S_SOD ss ');
  dset_tmp.SelectSQL.Add('where (z.delz=1) and (z.id_comment=ss.id) '+FAttachStr);
  dset_tmp.SelectSQL.Add(' ');
  dset_tmp.SelectSQL.Add('union ');
  dset_tmp.SelectSQL.Add(' ');
  dset_tmp.SelectSQL.Add('select z.id_alien, ');
  dset_tmp.SelectSQL.Add('  (select for_vedom from s_owner ');
  dset_tmp.SelectSQL.Add('   where z.id_alien=s_owner.id) as own, ');
  dset_tmp.SelectSQL.Add(' z.nomer, z.dt_in z_dt_in, ');
  dset_tmp.SelectSQL.Add('   (select rtrim(u.name_r)||" "||rtrim(v.name_r) ');
  dset_tmp.SelectSQL.Add('   from s_ulic u,s_vidul v ');
  dset_tmp.SelectSQL.Add('   where (u.del in (''-'',''d'')) and (u.id_vidul>-2) and (u.id_vidul=v.id) ');
  dset_tmp.SelectSQL.Add('    and (u.id=z.id_ul1)) as ul1, id_ul2, dop_adr, kod_ul, z.id_dopadres, ');
  dset_tmp.SelectSQL.Add(' z.id_comment, ss.name_r COMMENT_name, z.dop_inf, ');
  dset_tmp.SelectSQL.Add(' z.id_disin, ');
  dset_tmp.SelectSQL.Add(' (select s_brig.name_r from s_brig ');
  dset_tmp.SelectSQL.Add('   where z.id_disin=s_brig.id) as disin, ');
  dset_tmp.SelectSQL.Add('   "                               " as who_to_del, ');
  dset_tmp.SelectSQL.Add('   "                               " as when_to_del ');
  dset_tmp.SelectSQL.Add('from zavjav z, S_SOD ss ');
  dset_tmp.SelectSQL.Add('where (z.delz=1) and (z.id_comment=ss.id) '+FAttachStr);
  //
  dset_tmp.SelectSQL.Add('order by 1,4,3');
  //
  frVariables['time1']:=TimeToStr(DT_In);
  frVariables['date1']:=DateToStr(DT_In);
  frVariables['time2']:=TimeToStr(DT_Out);
  frVariables['date2']:=DateToStr(DT_Out);
end;

procedure TDM_VedManager._Abon;
begin
  dset_tmp.Close;
  dset_tmp.SelectSQL.Clear;
  dset_tmp.SelectSQL.Add('select z.kod_ul,z.dt_in z_dt_in,');
  dset_tmp.SelectSQL.Add('  z.id_alien,');
  dset_tmp.SelectSQL.Add('(select for_vedom from s_owner');
  dset_tmp.SelectSQL.Add('where z.id_alien=s_owner.id) as own, z.id_ul1,z.id_ul2,');
  dset_tmp.SelectSQL.Add('z.nomer, sd.id xar_povr_id, sd.name_r xar_povr, sd.id XAR_POVR_ID, dm.diam dm_diam, smat.id smat_id, smat.name_r smat_name, ');
  //
  dset_tmp.SelectSQL.Add('(select rtrim(u.name_r)||" "||rtrim(v.name_r)');
  dset_tmp.SelectSQL.Add('from s_ulic u,s_vidul v');
  dset_tmp.SelectSQL.Add(' where (u.del in (''-'',''d'')) and (u.id_vidul>-2) and (u.id_vidul=v.id)');
  dset_tmp.SelectSQL.Add('  and (u.id=z.id_ul1)) as ul1,');
  //
  dset_tmp.SelectSQL.Add('  id_ul2, dop_adr, z.id_dopadres ');
  //
  dset_tmp.SelectSQL.Add(' from nzavjav z,s_diam dm, s_sod sd, s_matpipe smat ');
  dset_tmp.SelectSQL.Add(' where (delz=0 and is_otl=0 ) and (dm.id=z.id_diam) and (smat.id=z.id_matpipe) and ');
  dset_tmp.SelectSQL.Add(' (z.dt_in<='''+DateTimeToStr(Fdt_in)+''')');
  dset_tmp.SelectSQL.Add('  and (z.id_sod=sd.id)');
  //
  dset_tmp.SelectSQL.Add('  and ((z.id_alien=2) or (z.id_alien=5))'+FAttachStr);
  //
  dset_tmp.SelectSQL.Add('order by 4,z.dt_in,z.nomer');
  //
  frVariables['time1']:=TimeToStr(DT_In);
  frVariables['date1']:=DateToStr(DT_In);
end;

procedure TDM_VedManager._Utechki_Vodopr;
begin
  frVariables['utech_type']:='водопроводные';
  _Utechki;
end;

procedure TDM_VedManager._Utechki_Other;
begin
  frVariables['utech_type']:='';//'остальные';
  _Utechki;
end;

procedure TDM_VedManager._Utechki_Vodomer;
begin
  frVariables['utech_type']:='водомерные и водомерные на списание';
  _Utechki;
end;

procedure TDM_VedManager._Utechki;
var s:string;
begin
  dset_tmp.Close;
  dset_tmp.SelectSQL.Clear;
  dset_tmp.SelectSQL.Add('select z.kod_ul,z.dt_in z_dt_in,');
  dset_tmp.SelectSQL.Add('  z.id_alien,');
  if FVedName='utechki_vodopr' then
    begin
      dset_tmp.SelectSQL.Add(' z.id_revs z_id_revs, ');
      dset_tmp.SelectSQL.Add('  (select name_r from s_revs ');
      dset_tmp.SelectSQL.Add('  where s_revs.id=z.id_revs) as revs, ');
      dset_tmp.SelectSQL.Add('  z.dt_poluch, z.id_brpoluch, ');
      dset_tmp.SelectSQL.Add('  (select name_r from s_brig where id=z.id_brpoluch) as brpoluch, ');
      dset_tmp.SelectSQL.Add('  (select count(id) from zadv where id_zavin=z.id and id_zavout=0) as nzadv_count, ');
      dset_tmp.SelectSQL.Add(' (select wwater_list from get_wwater_list(z.id))  as wwater, '); //{(select wwater_list from get_wwater_list(z.id))
    end;
  dset_tmp.SelectSQL.Add('so.for_vedom as own, z.id_ul1,z.id_ul2,');
  dset_tmp.SelectSQL.Add('z.nomer, sd.id xar_povr_id, sd.name_r xar_povr,dm.diam dm_diam,');
  //
  dset_tmp.SelectSQL.Add('(select rtrim(u.name_r)||" "||rtrim(v.name_r)');
  dset_tmp.SelectSQL.Add('from s_ulic u,s_vidul v');
  dset_tmp.SelectSQL.Add(' where (u.del in (''-'',''d'')) and (u.id_vidul>-2) and (u.id_vidul=v.id)');
  dset_tmp.SelectSQL.Add('  and (u.id=z.id_ul1)) as ul1,');
  //
  dset_tmp.SelectSQL.Add('  id_ul2, dop_adr, z.id_dopadres ');
  //
  dset_tmp.SelectSQL.Add(' from nzavjav z,s_diam dm, s_sod sd, s_owner so');
  dset_tmp.SelectSQL.Add(' where (delz=0 and is_otl=0) and (z.id_alien=so.id) and (so.owner_type<>4) and (dm.id=z.id_diam) and');
  dset_tmp.SelectSQL.Add(' (z.dt_in<='''+DateTimeToStr(Fdt_in)+''')');
  dset_tmp.SelectSQL.Add('  and (z.id_sod=sd.id)'+FAttachStr);
  //
    if FVedName='utechki_vodopr' then
    begin
      dset_tmp.SelectSQL.Add('  and (z.id_alien=1)');
      dset_tmp.SelectSQL.Add(' order by 11,10,z.dt_in,z.nomer');
    end
      else
    if FVedName='utechki_other' then
    begin
      dset_tmp.SelectSQL.Add('  and (z.id_alien<>1)');
      dset_tmp.SelectSQL.Add(' order by 4,z.dt_in,z.nomer');
    end
      else
    if FVedName='utechki_vodomer' then
    begin
      dset_tmp.SelectSQL.Add('  and ((z.id_alien=6) or (z.id_alien=8))');
      dset_tmp.SelectSQL.Add(' order by 4,z.dt_in,z.nomer');
    end;
  //
  //
  s:=dset_tmp.SelectSQL.Text;
  s:=s+'121';
  frVariables['time1']:=TimeToStr(DT_In);
  frVariables['date1']:=DateToStr(DT_In);
end;

procedure TDM_VedManager._Ustran;
begin
  dset_tmp.Close;
  dset_tmp.SelectSQL.Clear;
  dset_tmp.SelectSQL.Add('select z.kod_ul,z.dt_in z_dt_in, z.dt_out z_dt_out,');
  dset_tmp.SelectSQL.Add('  z.id_alien,');
  dset_tmp.SelectSQL.Add('(select for_vedom from s_owner');
  dset_tmp.SelectSQL.Add('where z.id_alien=s_owner.id) as own, z.id_ul1,z.id_ul2,');
  dset_tmp.SelectSQL.Add('z.nomer, sd.id xar_povr_id, sd.name_r xar_povr,dm.diam dm_diam,');
  //
  dset_tmp.SelectSQL.Add('(select rtrim(u.name_r)||" "||rtrim(v.name_r)');
  dset_tmp.SelectSQL.Add('from s_ulic u,s_vidul v');
  dset_tmp.SelectSQL.Add(' where (u.del in (''-'',''d'')) and (u.id_vidul>-2) and (u.id_vidul=v.id)');
  dset_tmp.SelectSQL.Add('  and (u.id=z.id_ul1)) as ul1,');
  //
  dset_tmp.SelectSQL.Add('  id_ul2, dop_adr, z.id_dopadres ');
  //
  dset_tmp.SelectSQL.Add(' from zavjav z,s_diam dm, s_sod sd');
  dset_tmp.SelectSQL.Add(' where (delz=0 and is_otl=0) and (dm.id=z.id_diam) and');
  dset_tmp.SelectSQL.Add(' (z.dt_out>='''+DateTimeToStr(Fdt_in)+''') and (z.dt_out<='''+DateTimeToStr(Fdt_out)+''')');
  dset_tmp.SelectSQL.Add('  and (z.id_sod=sd.id) and (z.id_alien<>3)'+FAttachStr);
  dset_tmp.SelectSQL.Add('order by 4,z.dt_in,z.nomer');
  //
  frVariables['time1']:=TimeToStr(DT_In);
  frVariables['date1']:=DateToStr(DT_In);
  frVariables['time2']:=TimeToStr(DT_Out);
  frVariables['date2']:=DateToStr(DT_Out);
end;

procedure TDM_VedManager._Kolvo;
begin
  dset_tmp.Close;
  dset_tmp.SelectSQL.Clear;
  dset_tmp.SelectSQL.Add('  select z.id_alien,o.name_r, z.id_revs, r.name_r, count(z.id_revs)');
  dset_tmp.SelectSQL.Add('from zavjav z, s_revs r, s_owner o');
  dset_tmp.SelectSQL.Add(' where (delz=0) and (z.id_revs=s_revs.id) and (z.id_alien=s_owner.id) and');
  dset_tmp.SelectSQL.Add(' (z.dt_in>='''+DateTimeToStr(Fdt_in)+''') and (z.dt_out<='''+DateTimeToStr(Fdt_out)+''')');
  dset_tmp.SelectSQL.Add('    and (z.id_alien in (1,6))'+FAttachStr);
  dset_tmp.SelectSQL.Add('group by z.id_alien,o.name_r, z.id_revs, r.name_r');
  //
  frVariables['dt1']:=DateToStr(DT_In);
  frVariables['dt2']:=DateToStr(DT_Out);
end;

procedure TDM_VedManager._Vipoln;
var
  _BlagCond, _BlagTypeName: string;
  _sql: string;
  Field:TField;
begin
  if FBlagType = btNeedBlag then
  begin
    _BlagCond := ' and (r.out_id_zavout=0) ';
    _BlagTypeName := 'только требующие благоустройство';
  end else
  begin
    _BlagCond := '';
    _BlagTypeName := 'все наряды по благоустройству';
  end;

  _sql :=
    ' select  z.nomer, r.out_ul_kod kod_ul,z.dt_in z_dt_in,' +
    ' so.for_vedom as own,' +
    ' sm.name_r as mest,' +
    ' z.id_alien, r.out_id_ul1  id_ul1, r.out_id_ul2 id_ul2,' +
    ' sd.id xar_povr_id, sd.name_r xar_povr,dm.diam dm_diam,' +
    ' (select rtrim(u.name_r)||" "||rtrim(v.name_r)' +
    ' from s_ulic u,s_vidul v' +
    ' where (u.del in (''-'',''d'')) and (u.id_vidul>-2) and (u.id_vidul=v.id)' +
    ' and (u.id=r.out_id_ul1)) as ul1,' +
    ' dop_adr, z.id_dopadres,' +
    ' r.out_dt_raskop r_dt_in, r.out_dt_work1 r_dt_out, r.out_dt_work2 r_dt_rec, r.out_dt_work3 r_dt_gran,' +
    ' r.out_dt_work4 r_dt_plitka,' +
    ' r.out_id_zavout id_zout '+
    ' from %s z' +
    Format(' left join get_zav_raskops( z.id, %d, %d, %d, %d ) r on r.out_id_zavin = z.id',
      [ Ord( tsc_sw_ZASIPKA), Ord( tsc_sw_ASFALT ), Ord( tsc_sw_SHEBEN ), Ord( tsc_sw_PLITKA ) ] ) +
    ' left join s_diam dm on dm.id = z.id_diam' +
    ' left join s_sod sd on sd.id = z.id_sod' +
    ' left join s_owner so on so.id = z.id_alien' +
    ' left join s_mest sm on sm.id = z.id_mest' +
    ' where (delz=0) and  (r.out_id_zavin is not null) and' +
    ' (z.dt_in>=''' + DateTimeToStr( Fdt_in ) + ''') and (z.dt_out<=''' + DateTimeToStr( Fdt_out ) + ''')' +
    FAttachStr + _BlagCond;

  dset_tmp.Close;
  dset_tmp.SelectSQL.Clear;



  dset_tmp.SelectSQL.Add( Format( _sql, ['nzavjav'] ) );
  dset_tmp.SelectSQL.Add(' union');
  dset_tmp.SelectSQL.Add( Format( _sql, ['zavjav'] ) );
  dset_tmp.SelectSQL.Add(' order by 4,1,3');
///
{
  dset_tmp.SelectSQL.Add('select  z.nomer, r.ul_kod kod_ul,z.dt_in z_dt_in,');
  dset_tmp.SelectSQL.Add('(select for_vedom from s_owner');
  dset_tmp.SelectSQL.Add(' where z.id_alien=s_owner.id) as own,');
  dset_tmp.SelectSQL.Add(' (select name_r from s_mest');
  Qry_Tmp.SQL.Add(' where z.id_mest=s_mest.id) as mest,');
  Qry_Tmp.SQL.Add(' z.id_alien, r.id_ul1, r.id_ul2,');
  Qry_Tmp.SQL.Add(' sd.id xar_povr_id, sd.name_r xar_povr,dm.diam dm_diam,');
  Qry_Tmp.SQL.Add(' (select rtrim(u.name_r)||" "||rtrim(v.name_r)');
  Qry_Tmp.SQL.Add('  from s_ulic u,s_vidul v');
  Qry_Tmp.SQL.Add('  where (u.del in (''-'',''d'')) and (u.id_vidul>-2) and (u.id_vidul=v.id)');
  Qry_Tmp.SQL.Add('   and (u.id=r.id_ul1)) as ul1,');
  Qry_Tmp.SQL.Add('  dop_adr,z.id_dopadres, ');
  Qry_Tmp.SQL.Add('  r.dt_in r_dt_in, r.dt_out r_dt_out, r.dt_rec r_dt_rec, r.dt_gran r_dt_gran');
  Qry_Tmp.SQL.Add('  from nzavjav z,s_diam dm, s_sod sd, raskop r');
  Qry_Tmp.SQL.Add('  where (delz=0) and (z.id=r.id_zavin) and (dm.id=z.id_diam) and');
  Qry_Tmp.SQL.Add(' (z.dt_in>='''+DateTimeToStr(Fdt_in)+''') and (z.dt_out<='''+DateTimeToStr(Fdt_out)+''')');
  Qry_Tmp.SQL.Add('  and (z.id_sod=sd.id) '+FAttachStr + _BlagCond);
  Qry_Tmp.SQL.Add(' union');
  Qry_Tmp.SQL.Add('    select z.nomer, r.ul_kod kod_ul,z.dt_in z_dt_in,');
  Qry_Tmp.SQL.Add('    (select for_vedom from s_owner');
  Qry_Tmp.SQL.Add('     where z.id_alien=s_owner.id) as own,');
  Qry_Tmp.SQL.Add('     (select name_r from s_mest');
  Qry_Tmp.SQL.Add('     where z.id_mest=s_mest.id) as mest,');
  Qry_Tmp.SQL.Add('     z.id_alien, r.id_ul1, r.id_ul2,');
  Qry_Tmp.SQL.Add('     sd.id xar_povr_id, sd.name_r xar_povr,dm.diam dm_diam,');
  Qry_Tmp.SQL.Add('     (select rtrim(u.name_r)||" "||rtrim(v.name_r)');
  Qry_Tmp.SQL.Add('      from s_ulic u,s_vidul v');
  Qry_Tmp.SQL.Add('      where (u.del in (''-'',''d'')) and (u.id_vidul>-2) and (u.id_vidul=v.id)');
  Qry_Tmp.SQL.Add('       and (u.id=r.id_ul1)) as ul1,');
  Qry_Tmp.SQL.Add('      dop_adr, z.id_dopadres, ');
  Qry_Tmp.SQL.Add('      r.dt_in r_dt_in, r.dt_out r_dt_out, r.dt_rec r_dt_rec, r.dt_gran r_dt_gran');
  Qry_Tmp.SQL.Add('      from zavjav z,s_diam dm, s_sod sd, raskop r');
  Qry_Tmp.SQL.Add('      where (delz=0) and (z.id=r.id_zavin) and (dm.id=z.id_diam) and');
  Qry_Tmp.SQL.Add(' (z.dt_in>='''+DateTimeToStr(Fdt_in)+''') and (z.dt_out<='''+DateTimeToStr(Fdt_out)+''')');
  Qry_Tmp.SQL.Add('   and   (z.id_sod=sd.id)'+FAttachStr + _BlagCond);
  Qry_Tmp.SQL.Add('order by 4,1,3');
}
///
  frVariables['time1']:=TimeToStr(DT_In);
  frVariables['date1']:=DateToStr(DT_In);
  frVariables['time2']:=TimeToStr(DT_Out);
  frVariables['date2']:=DateToStr(DT_Out);
  frVariables['BlagType']:=_BlagTypeName;
end;

procedure TDM_VedManager.ShowReport(_RepExp:TRepExp=treShow);
begin
  if Fvedname='utechki_vodopr' then _Utechki_Vodopr
    else
  if Fvedname='utechki_other' then _Utechki_Other
    else
  if Fvedname='utechki_vodomer' then _Utechki_Vodomer
    else
  if Fvedname='ustran' then _Ustran
    else
  if Fvedname='ustran_vod' then _Ustran_vod
    else
  if Fvedname='abon' then _Abon
    else
  if Fvedname='vipoln' then _Vipoln
    else
  if Fvedname='kolvo' then _Kolvo
    else
  if Fvedname='DelZayav' then _DelZayav
    else
  if Fvedname='ViborPoUl' then _ViborPoUl
    else
  if Fvedname='PostupAbon' then _PostupAbon;  
  //  
  try
    dset_tmp.Open;
    dset_tmp.SelectSQL.Text;
    case _RepExp of
      treShow:
        begin
          DM_VedomPublic.RepName:=Fvedname;
          DM_VedomPublic.frWorkRep:=frReportVed;
          frReportVed.OnExcelClick:=DM_VedomPublic.ExcelClick;
          frReportVed.PrepareReport;
          frReportVed.ShowPreparedReport;
        end;
      treExcel:
        begin
          //frReportVed.PrepareReport;
          //frReportVed.ExportTo(frOLEExcelExport1,ExtractFilePath(ParamStr(0))+'report.xls');
        end;
    end;  
  except
    on E:Exception do
      begin
        MessageBox(TForm(Owner).Handle,
          Pchar('Не могу открыть dset_tmp:'#13+E.Message),'Диспетчер АВР', MB_OK or MB_ICONWARNING);
      end;          
  end;
end;

function TDM_VedManager.LoadVedReport(vedname:string):boolean;
var s:string;
begin
  FVedName:=vedname;
  s:=FVedRepDir+vedname+'.frf';
  result:=frReportVed.LoadFromFile(s);
  if not result then MessageBox(TForm(Owner).Handle,
    Pchar('Не могу открыть: '+s),'Диспетчер АВР', MB_OK or MB_ICONWARNING);
end;

procedure TDM_VedManager.DataModuleCreate(Sender: TObject);
begin
  FVedRepDir:=ExtractFilePath(ParamStr(0))+'ved_reports\';
  if not DirectoryExists(FVedRepDir) then
    begin
      CreateDir(FVedRepDir);
    end;
end;

function TDM_VedManager.GetWhoWhenDel(_what:integer; value:string):string;
const
  W1='удаление ';
  W2=' диспетчером ';
  W3=' >';
  W4=#13#10;
  L1=length(W1);
  L2=length(W2);
var i1,i2,i3,i4,l,k:integer;
begin
  //Пример: 'удаление 03.10.2005 диспетчером БУЛДАКОВА >'
  result:='';
  l:=length(value);
  i1:=POS(W1,value);
  i2:=POS(W2,value);
  i3:=POS(W3,value);
  i4:=POS(W4,value);
  case _what of
    0: result:=Copy(value,i2+L2,i3-i2-l2);
    1: result:=Copy(value,i1+L1,i2-i1-l1);
    2:
      begin
        if i4>0 then
          begin
            result:=Copy(value,i4+2,l-(i4+1));
            k:=POS(#13,result);
            while k>0 do
              begin
                result[k]:=' '; result[k+1]:=' ';
                k:=POS(#13,result);
              end;
          end;              
      end;
  end;
end;

procedure TDM_VedManager.frReportVedGetValue(const ParName: String;
  var ParValue: Variant);
//var  s:string;  
begin
//
  if ParName='dset_tmp."UL1"' then
    ParValue:=DM1.Gen_Addr('',dset_tmp.FieldByName('ul1').AsString,
    dset_tmp.FieldByName('id_ul2').AsString,
    dset_tmp.FieldByName('kod_ul').AsString,
    dset_tmp.FieldByName('dop_adr').AsString,
    dset_tmp.FieldByName('id_dopadres').AsString)
      else
  {if (ParName='dset_tmp."Z_DT_IN"') or (ParName='Qry_tmp."Z_DT_OUT"') then
    begin
      ParValue:=ParValue;//Copy(s,1,10);
    end;}
    if Fvedname='DelZayav' then
      begin
        if ParName='dset_tmp."WHO_TO_DEL"' then
          ParValue:=GetWhoWhenDel(0,dset_tmp.FieldByName('dop_inf').AsString);
        if ParName='dset_tmp."WHEN_TO_DEL"' then
          ParValue:=GetWhoWhenDel(1,dset_tmp.FieldByName('dop_inf').AsString);
        if ParName='dset_tmp."DOP_INF"' then
          ParValue:=GetWhoWhenDel(2,dset_tmp.FieldByName('dop_inf').AsString);
      end;
    if Fvedname = 'vipoln' then
    begin
      if ParName='dset_tmp."R_DT_REC"' then
        if ( dset_tmp.FieldByName( 'R_DT_REC' ).IsNull ) and ( not dset_tmp.FieldByName( 'R_DT_PLITKA' ).IsNull ) then
          ParValue := dset_tmp.FieldByName( 'R_DT_PLITKA' ).Value;
    end;
end;

procedure TDM_VedManager._Ustran_vod;
begin
  dset_tmp.Close;
  dset_tmp.SelectSQL.Clear;
  dset_tmp.SelectSQL.Add('select z.kod_ul,z.dt_in z_dt_in, z.dt_out z_dt_out,');
  dset_tmp.SelectSQL.Add('  z.id_alien, z.id_revs z_id_revs, ');
  dset_tmp.SelectSQL.Add('(select for_vedom from s_owner');
  dset_tmp.SelectSQL.Add('where z.id_alien=s_owner.id) as own, z.id_ul1,z.id_ul2,');
  dset_tmp.SelectSQL.Add('z.nomer, sd.id xar_povr_id, sd.name_r xar_povr,dm.diam dm_diam,');
  //
  dset_tmp.SelectSQL.Add('(select name_r from s_revs where s_revs.id=z.id_revs) revs,');
  dset_tmp.SelectSQL.Add('(select rtrim(u.name_r)||" "||rtrim(v.name_r) ');
  dset_tmp.SelectSQL.Add('from s_ulic u,s_vidul v');
  dset_tmp.SelectSQL.Add(' where (u.del in (''-'',''d'')) and (u.id_vidul>-2) and (u.id_vidul=v.id)');
  dset_tmp.SelectSQL.Add('  and (u.id=z.id_ul1)) as ul1,');
  //
  dset_tmp.SelectSQL.Add('  id_ul2, dop_adr, z.id_dopadres ');
  //
  dset_tmp.SelectSQL.Add(' from zavjav z,s_diam dm, s_sod sd');
  dset_tmp.SelectSQL.Add(' where (delz=0) and (dm.id=z.id_diam) and');
  dset_tmp.SelectSQL.Add(' (z.dt_out>='''+DateTimeToStr(Fdt_in)+''') and (z.dt_out<='''+DateTimeToStr(Fdt_out)+''')');
  dset_tmp.SelectSQL.Add('  and (z.id_sod=sd.id) and (z.id_alien in (1,6,7,8)) '+FAttachStr);
  dset_tmp.SelectSQL.Add(' order by 4,5,z.dt_in,z.nomer');
  //
  frVariables['time1']:=TimeToStr(DT_In);
  frVariables['date1']:=DateToStr(DT_In);
  frVariables['time2']:=TimeToStr(DT_Out);
  frVariables['date2']:=DateToStr(DT_Out);
end;

end.
