unit SvodVed2DModule;

interface

uses
  SysUtils, Classes, FR_Class, IBDatabase, DB, IBCustomDataSet, Controls,
  DMMain, RxMemDS, OperAttFormUnit, FR_DSet, FR_DBSet;


type
  Tdm_SvodVed2 = class(TDataModule)
    frReport: TfrReport;
    dset_tmp: TIBDataSet;
    tran: TIBTransaction;
    md_res: TRxMemoryData;
    md_resnomer: TIntegerField;
    md_resdt_in: TDateTimeField;
    md_resattach: TStringField;
    md_resadres: TStringField;
    md_ressod: TStringField;
    md_resid: TIntegerField;
    md_resmain_gr: TIntegerField;
    dset_tmp2: TIBDataSet;
    md_resid_attach: TIntegerField;
    md_resid_revs: TIntegerField;
    md_resrevs: TStringField;
    md_resvrabote: TStringField;
    md_resprimech: TStringField;
    dset_tmp3: TIBDataSet;
    md_reszav_type_name: TStringField;
    frDS_res: TfrDBDataSet;
    md_resvipol: TStringField;
    md_reswwater_list: TStringField;
    md_resobject: TStringField;
    md_resdt_out: TDateTimeField;
    md_resdisp_in: TStringField;
    md_resdisp_out: TStringField;
    md_resdt_in_str: TStringField;
    md_resbrigs: TStringField;
    procedure DataModuleDestroy(Sender: TObject);
  private
    procedure insert_base_field(zav_type_name: string; dset_src, dset_des: TDataSet);
    procedure append_zaplan(OperAtt: TOperAtt);
    procedure append_vipolneno(OperAtt: TOperAtt);
    procedure append_vrabote(OperAtt: TOperAtt);
    procedure append_postupilo(OperAtt: TOperAtt);
    function get_sutki_cond(dt_field: string): string;
    function get_dt_cond(dt_field: string): string;
    function get_smena: TDateTime;
    function get_primech(id_zav: integer): string;
    procedure FILL(OperAtt: TOperAtt);
  protected
    F_RevsID: string;
    F_dt_smena: TDate;
    F_tm_smena: TTime;
    F_SEL_ZAV: string;
    F_IsVoda, F_IsKanal, F_IsVrk, F_IsObjVoda, F_IsObjKanal: boolean;
    F_IsCloseZavInc, F_IsOpenZavInc, F_IsViesnenZavInc, F_IsLozhZavInc: boolean;
    f_isOtl:boolean; //отложенные
    F_GroupByState: boolean;
    procedure InitSEL_ZAV; virtual;
    function get_ownertype_id( IsForCloseZav: boolean ): string; virtual;
    function gellistfromstring(slist:string):string;
  public
    property GroupByState: boolean read F_GroupByState write F_GroupByState;
    property RevsID: string read F_RevsID write F_RevsID;
    property dt_smena: TDate read F_dt_smena write F_dt_smena;
    property tm_smena: TTime read F_tm_smena write F_tm_smena;
    property IsVoda: boolean read F_IsVoda write F_IsVoda;
    property IsKanal: boolean read F_IsKanal write F_IsKanal;
    property IsVrk: boolean read F_IsVrk write F_IsVrk;
    property IsObjVoda: boolean read F_IsObjVoda write F_IsObjVoda;
    property IsObjKanal: boolean read F_IsObjKanal write F_IsObjKanal;
    property IsOtl:boolean read F_isOtl write F_isOtl;
    //
    property IsCloseZavInc: boolean read F_IsCloseZavInc write F_IsCloseZavInc;
    property IsOpenZavInc: boolean read F_IsOpenZavInc write F_IsOpenZavInc;
    property IsViesnenZavInc: boolean read F_IsViesnenZavInc write F_IsViesnenZavInc;
    property IsLozhZavInc: boolean read F_IsLozhZavInc write F_IsLozhZavInc;
    //
    procedure PrepareDset;
  end;


implementation

{$R *.dfm}

uses ServiceFuncUnit,frmLANG,cntsLANG;

var
  ARR_COM_FIELD: array[0..7] of string=
    ('id','nomer','id_attach','id_revs','revs','attach','adres','wwater_list');


procedure Tdm_SvodVed2.insert_base_field(zav_type_name: string; dset_src, dset_des: TDataSet);
function getAdminname(name:string):string;
begin
  result:=name;
  if (name='0') or (name='1') then
   result:=TrLangMSG(msgAdmin)
 else if name='-1' then
  result:='' ;

end;
var
  i: integer;
  _time: TTime;
  s:string;
begin
// if not F_GroupByState then exit; // только для СводВед2, а для СводВед21 - не надо
  dset_des.FieldByName('main_gr').AsInteger:=0;
  if F_GroupByState then dset_des.FieldByName('zav_type_name').AsString:=zav_type_name
      else dset_des.FieldByName('zav_type_name').AsString:= '';
  dset_des.FieldByName('sod').AsString:=DeletePusto(dset_src.FieldByName('sod').AsString);
  _time :=dset_src.FieldByName('vipol').AsDateTime;
   s:=FormatDateTime('dd.mm.yy hh:mm',_time );
  if zav_type_name = 'ВИКОНАНО' then
            dset_des.FieldByName('vipol').AsString:=DeletePusto( s);//DateTimeToStr( _time));

  dset_des.FieldByName('disp_in').AsString := getAdminname(dset_src.FieldByName('disp_in').AsString);
  dset_des.FieldByName('disp_out').AsString := getAdminname(dset_src.FieldByName('disp_out').AsString);



  for i:=low(ARR_COM_FIELD) to high(ARR_COM_FIELD) do
    dset_des.FieldByName(ARR_COM_FIELD[i]).Value:=dset_src.FieldByName(ARR_COM_FIELD[i]).Value;
 _time:=dset_src.FieldByName('dt_in').asdatetime;
  s:=FormatDateTime('dd.mm.yy hh:mm',_time );
  dset_des.FieldByName('dt_in_str').asString:=s;
  dset_des.FieldByName('primech').AsString:=get_primech(dset_src.FieldByName('id').AsInteger);
  s:=gellistfromstring(dset_src.FieldByName('brigs').asstring);
  dset_des.FieldByName('brigs').AsString:=s;

end;

procedure Tdm_SvodVed2.append_zaplan(OperAtt: TOperAtt);
var
  cond: string;
begin
  {Открытые заявки в которых стоит галочка "На контроле"}

  cond:='z.cont<>0 and '+get_dt_cond('z.dt_in');
  {Открытые заявки в которых нет галочки "отложенные "}
  if not( F_isOtl) then
    cond:=cond + ' and (z.is_otl<>1 or z.is_otl is null )';

  MyOpenIBDS(dset_tmp, Format(F_SEL_ZAV, ['nnarad','nzavjav',
                                          ord(OperAtt),
                                          get_ownertype_id( false ),
                                          cond]));
  while not dset_tmp.Eof do
  begin
    md_res.Append;
    insert_base_field('ЗАПЛАНОВАНІ', dset_tmp, md_res);

    {Если есть выезды за дан. сутки то в поле "В работе" ставим "+"}

    MyOpenIBDS(dset_tmp2,
      ' select count(*) kol from nnarad'+
      ' where id_zav='+dset_tmp.FieldByName('id').AsString+
      ' and '+get_sutki_cond('dt_in'));
    if dset_tmp2.FieldByName('kol').AsInteger>0 then
      md_res.FieldByName('vrabote').AsString:='+';
    dset_tmp2.Close;

    {/Если есть выезды за дан. сутки то в поле "В работе" ставим "+"}



    {Везде в поле "В работе" ставим "+" - !!!ВРЕМЕНО}
    //md_res.FieldByName( 'vrabote' ).AsString := '+';
    {/Везде в поле "В работе" ставим "+" - !!!ВРЕМЕНО}

    md_res.Post;
    dset_tmp.Next;
  end;
end;

procedure Tdm_SvodVed2.PrepareDset;
begin
  if md_res.Active then md_res.Close;
  md_res.Open;
  if tran.InTransaction then
    tran.Rollback;
  tran.StartTransaction;
  try
    InitSEL_ZAV;

    if F_IsVoda then FILL(toaVoda);
    if F_IsKanal then FILL(toaKanal);
    if F_IsVrk then FILL(toaVRK);
    if F_IsObjVoda then FILL(toaObjVoda);
    if F_IsObjKanal then FILL(toaObjKanal);


    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      raise Exception.Create(E.Message+'(PrepareDset)');
    end;
  end;
end;

procedure Tdm_SvodVed2.DataModuleDestroy(Sender: TObject);
begin
  md_res.Close;
end;

procedure Tdm_SvodVed2.append_vipolneno(OperAtt: TOperAtt);
begin
  {Закрытые заявки за сутки}

  MyOpenIBDS(dset_tmp, Format(F_SEL_ZAV, ['narad','zavjav',
                                          ord(OperAtt),
                                          get_ownertype_id( true ),
                                          get_sutki_cond('z.dt_out')]));
  while not dset_tmp.Eof do
  begin
    md_res.Append;
    insert_base_field('ВИКОНАНО', dset_tmp, md_res);
    md_res.Post;
    dset_tmp.Next;
  end;
end;

function Tdm_SvodVed2.get_sutki_cond(dt_field: string): string;
begin
  Result:=dt_field+'>"'+DateToStr(F_dt_smena)+' '+TimeToStr(F_tm_smena)+'"'+
          ' and '+dt_field+'<="'+DateToStr(F_dt_smena+1)+' '+TimeToStr(F_tm_smena)+'"';
end;

procedure Tdm_SvodVed2.append_vrabote(OperAtt: TOperAtt);
var
  cond: string;
  is_find: boolean;
  dttm, dttm_smena: TDateTime;
begin
  {Открытые заявки у которых нет галочки "На контроле"
  и у которых дата непервичных выездов попадает в
  заданные сутки}

  dttm_smena:=get_smena;

  cond:=
    ' (z.cont=0) and '+
    ' (z.id in'+
    '     (select distinct id_zav'+
    '     from nnarad n'+
    '     where '+get_sutki_cond('n.dt_in')+')'+
    ' )';

{Открытые заявки в которых нет галочки "отложенные "}
 if not (F_isOtl) then
  cond:=cond + ' and (z.is_otl<>1 or z.is_otl is null )';
  MyOpenIBDS(dset_tmp, Format(F_SEL_ZAV, ['nnarad','nzavjav',
                                          ord(OperAtt),
                                          get_ownertype_id( false ),
                                          cond]));
  while not dset_tmp.Eof do
  begin
    MyOpenIBDS(dset_tmp2,
        ' select dt_in from nnarad where id_zav='+
        dset_tmp.FieldByName('id').AsString+
        ' order by dt_in');
    dset_tmp2.Last;
    if dset_tmp2.RecordCount>=2 then
    begin
      dset_tmp2.First;
      dset_tmp2.Next;
      is_find:=false;
      while not dset_tmp2.Eof do
      begin
        dttm:=dset_tmp2.FieldByName('dt_in').AsDateTime;
        if (dttm>dttm_smena) and (dttm<=dttm_smena+1) then
        begin
          is_find:=true;
          break;
        end;
        dset_tmp2.Next;
      end;

      if is_find then
      begin
        md_res.Append;
//        insert_base_field('В РАБОТЕ НЕЗАПЛАНИРОВАННЫЕ', dset_tmp, md_res);
        insert_base_field('В РОБОТІ', dset_tmp, md_res);
        md_res.Post;
      end;
    end; //end if dset_tmp2.RecordCount>=2

    dset_tmp.Next;
  end;
end;

procedure Tdm_SvodVed2.append_postupilo(OperAtt: TOperAtt);
var
  cond: string;
  is_append: boolean;
  dttm, dttm_smena: TDateTime;
begin
  {все открытые заявки
  у которых нет галочки "На контроле",
  за исключением заявок у которых дата непервичных
  выездов попадают в заданные сутки}

  dttm_smena:=get_smena;

  cond:='z.cont=0 and '+get_dt_cond('z.dt_in');
{Открытые заявки в которых нет галочки "отложенные "}
if not (F_isOtl) then
  cond:=cond + ' and (z.is_otl<>1 or z.is_otl is null )';
  MyOpenIBDS(dset_tmp, Format(F_SEL_ZAV, ['nnarad','nzavjav',
                                          ord(OperAtt),
                                          get_ownertype_id( false ) ,
                                          cond ]));
  while not dset_tmp.Eof do
  begin
    is_append:=true;
    MyOpenIBDS(dset_tmp2,
        ' select dt_in from nnarad where id_zav='+
        dset_tmp.FieldByName('id').AsString+
        ' order by dt_in');
    dset_tmp2.Last;
    if dset_tmp2.RecordCount>=2 then
    begin
      dset_tmp2.First;
      dset_tmp2.Next;
      while not dset_tmp2.Eof do
      begin
        dttm:=dset_tmp2.FieldByName('dt_in').AsDateTime;
        if (dttm>dttm_smena) and (dttm<=dttm_smena+1) then
        begin
          is_append:=false;
          break;
        end;
        dset_tmp2.Next;
      end;
    end;

    if is_append then
    begin
      md_res.Append;
      insert_base_field('ПОСТУПИЛО И ОТКРЫТО', dset_tmp, md_res);
      md_res.Post;
    end;

    dset_tmp.Next;
  end;
end;


function Tdm_SvodVed2.get_dt_cond(dt_field: string): string;
begin
  Result:=dt_field+'<="'+DateToStr(F_dt_smena)+' '+TimeToStr(F_tm_smena)+'"';
end;

function Tdm_SvodVed2.get_smena: TDateTime;
begin
  Result:=StrToDateTime(DateToStr(F_dt_smena)+' '+TimeToStr(F_tm_smena));
end;

procedure Tdm_SvodVed2.FILL(OperAtt: TOperAtt);
begin
  append_zaplan(OperAtt); //запланированные
  append_vipolneno(OperAtt); //выполнено
  append_vrabote(OperAtt); //в работе незапланированые - теперь "в работе"
  append_postupilo(OperAtt); //поступило
end;

procedure Tdm_SvodVed2.InitSEL_ZAV;
var
  revs_cond: string;
begin
 if F_RevsID<>'' then
    revs_cond:=' and z.id_revs in'+F_RevsID
 else
    revs_cond:='';

 //После просветления
 F_SEL_ZAV:=
    ' select z.id, z.nomer, z.dt_in, z.dt_out vipol, z.id_attach, z.id_revs,' +
    ' sr.name_r revs, att.name_r attach,' +
    ' (select adres from get_adres(z.id_ul1,z.id_ul2,z.kod_ul,z.dop_adr,z.id_dopadres)) adres,' +
    ' rtrim(ss.name_r)||"("||rtrim(st.name_r)||","||rtrim(sp.name_r)||")" as sod,' +
    ' (select wwater_list from get_wwater_list( z.id ) ) wwater_list, ' +
    '  coalesce( ob.name_r, z.id_disin) disp_in , coalesce(cb.name_r, z.id_disout)disp_out ,'+
    '   ( select list(trim(sb.name_r), '' #'' ) from s_brig sb,%s n where n.id_brig=sb.id and n.id_zav=z.id) brigs '+
    ' from %s z'+
    ' left join s_revs sr on ( sr.id = z.id_revs )' +
    ' left join s_attach att on ( att.id = z.id_attach )' +
    ' left join s_sod ss on ( ss.id = z.id_sod )' +
    ' left join s_tzav st on (st.id = ss.ftype)' +
    ' left join s_place sp on (sp.id = ss.place_type)' +
    ' left join s_owner so on ( so.id = z.id_alien )' +
    ' left join s_brig ob on ob.id = z.id_disin '+
    ' left join s_brig cb on cb.id = z.id_disout '+
    ' where (delz=0) and (z.id_attach = %d) and (so.owner_type in( %s ) ) and  %s'+
    ' and  (z.is_otl is null or z.is_otl<>1) ' + //всегда выбираем не отложенные
    revs_cond +
    ' order by sr.name_r, z.dt_in';
end;

function Tdm_SvodVed2.get_primech(id_zav: integer): string;
const
  SEL_NAR=' select dt_in, dop_inf from %s'+
          ' where id_zav=%d'+
          ' order by dt_in';
begin
  {Функция возвращает дополнительную инфу из последнего выезда}

  Result:='';
  MyOpenIBDS(dset_tmp3, Format(SEL_NAR, ['nnarad', id_zav]));
  if dset_tmp3.Eof then
    MyOpenIBDS(dset_tmp3, Format(SEL_NAR,['narad', id_zav]));
  if not dset_tmp3.Eof then
  begin
    dset_tmp3.Last;
    Result:=dset_tmp3.FieldByName('dop_inf').AsString;
  end;
end;

function Tdm_SvodVed2.get_ownertype_id(IsForCloseZav: boolean): string;
  procedure _check_type( _IsSel: boolean; _TypeID: integer );
  begin
    if _IsSel then
      Result := Result + ',' + IntToStr( _TypeID );
  end;
begin
  Result := '';

  if IsForCloseZav then
  begin
    _check_type( F_IsCloseZavInc, 2 );
    _check_type( F_IsLozhZavInc, 4 );
  end else
  begin
    _check_type( F_IsOpenZavInc, 2 );
    _check_type( F_IsViesnenZavInc, 3 );
    _check_type( F_IsLozhZavInc, 4 );
  end;

  Delete( Result, 1, 1 );

  if trim( Result ) = '' then
    Result := '-1';
end;


function Tdm_SvodVed2.gellistfromstring(slist:string):string;
var i,p:integer;
begin
    while(pos('#',slist)>0) do
    begin
       p:=pos('#',slist);
       delete(slist,p,1);
       if p<length(slist)-3 then
        insert(#13,slist,p-1);
    end;
    result:=slist;
end;

end.
