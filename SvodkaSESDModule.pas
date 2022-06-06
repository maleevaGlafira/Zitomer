unit SvodkaSESDModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class, kbmMemTable, DB, IBCustomDataSet,
  IBDatabase, DMMain, GridViewBuilder, FR_DSet, FR_DBSet;

type
  Tdm_SvodkaSES = class(Tdm_NGReportBase)
    ResultDset: TkbmMemTable;
    CheckDset: TkbmMemTable;
    frDBResult: TfrDBDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    F_DtBeg,
    F_DtEnd: TDateTime;
    //
    F_IsVodaConsid: boolean;
    F_OwnerID_voda,
    F_TZavID_voda,
    F_PlaceID_voda,
    F_SodID_voda: string;
    //
    F_IsKanalConsid: boolean;
    F_OwnerID_kanal,
    F_TZavID_kanal,
    F_PlaceID_kanal,
    F_SodID_kanal: string;
    //

    F_IsVRKConsid: boolean;
    F_OwnerID_VRK,
    F_TZavID_VRK,
    F_PlaceID_VRK,
    F_SodID_VRK: string;
    //
    F_RowInformerList: TRowInformerList;
  public
    property DtBeg: TDateTime read F_DtBeg write F_DtBeg;
    property DtEnd: TDateTime read F_DtEnd write F_DtEnd;
    //
    property IsVodaConsid: boolean read F_IsVodaConsid write F_IsVodaConsid;
    property OwnerID_voda: string read F_OwnerID_voda write F_OwnerID_voda;
    property TZavID_voda: string read F_TZavID_voda write F_TZavID_voda;
    property PlaceID_voda: string read F_PlaceID_voda write F_PlaceID_voda;
    property SodID_voda: string read F_SodID_voda write F_SodID_voda;
    //
    property IsKanalConsid: boolean read F_IsKanalConsid write F_IsKanalConsid;
    property OwnerID_kanal: string read F_OwnerID_kanal write F_OwnerID_kanal;
    property TZavID_kanal: string read F_TZavID_kanal write F_TZavID_kanal;
    property PlaceID_kanal: string read F_PlaceID_kanal write F_PlaceID_kanal;
    property SodID_kanal: string read F_SodID_kanal write F_SodID_kanal;
    //
    property IsVRKConsid: boolean read F_IsVRKConsid write F_IsVRKConsid;
    property OwnerID_VRK: string read F_OwnerID_VRK write F_OwnerID_VRK;
    property TZavID_VRK: string read F_TZavID_VRK write F_TZavID_VRK;
    property PlaceID_VRK: string read F_PlaceID_VRK write F_PlaceID_VRK;
    property SodID_VRK: string read F_SodID_VRK write F_SodID_VRK;
    //
    property RowInformerList: TRowInformerList read F_RowInformerList
      write F_RowInformerList;

    procedure PrepareCheckDset;
    procedure PrepareResultDset;
  end;

implementation

{$R *.dfm}

uses HelpFunctions, MemTableFiller, OperAttFormUnit;

{ Tdm_SvodkaSES }

procedure Tdm_SvodkaSES.PrepareCheckDset;
  function _AddCond( _own, _tzav, _place, _sod: string ): string;
  begin
    Result := '';
    _own := trim( _own );
    _tzav := trim( _tzav );
    _place := trim( _place );
    _sod := trim( _sod );
    if _own <> '' then
      Result := Result + Format( ' and ( z.id_alien in (%s) )', [_own] );
    if _tzav <> '' then
      Result := Result + Format( ' and ( z.id_tzav in (%s) )', [_tzav] );
    if _place <> '' then
      Result := Result + Format( ' and ( z.id_place in (%s) )', [_place] );
    if _sod <> '' then
      Result := Result + Format( ' and ( z.id_sod in (%s) )', [_sod] );
  end;

   procedure CheckIsClosed(_DS:TkbmMemTable);
   begin
    //
      _DS.First;
      while not _DS.Eof
      do begin
        if _DS.FieldByName('is_closed').AsInteger = 0 then
           begin
            if _DS.State <> dsEdit then _DS.Edit;
            _DS.FieldByName('dt_out').Clear;
            _DS.Post;
           end;
        _DS.Next;
      end;
   end;


const
  SEL_SQL =
    ' select sa.name_r as attach, z.dt_in, z.nomer,' +
//    ' z.id,   z.id_attach, z.dt_out,' +
    ' z.id,   z.id_attach, z.dt_out, %s ,' +
    ' (select adres from get_adres(z.id_ul1,z.id_ul2,z.kod_ul,z.dop_adr,z.id_dopadres)) adres,' +
    ' st.name_r as tzav, sp.name_r as place, ss.name_r as sod, sd.diam' +
    ' from %s z' +
    ' left join s_attach sa on ( sa.id = z.id_attach )' +
    ' left join s_tzav st on (st.id = z.id_tzav)' +
    ' left join s_place sp on (sp.id = z.id_place)' +
    ' left join s_sod ss on ( ss.id = z.id_sod )' +
    ' left join s_diam sd on ( sd.id = z.id_diam )';
var
  _cond, _sql, _VodaCond, _KanalCond,_VRKCond: string;
  _mtf: TMemTableFiller;
begin
  if F_IsVodaConsid or F_IsKanalConsid or F_IsVRKConsid  then
  begin
    _VodaCond :=
      ' ( ( z.id_attach = ' + IntToStr( Integer( toaVoda ) ) + ' )' +
       _AddCond( F_OwnerID_voda, F_TZavID_voda, F_PlaceID_voda, F_SodID_voda ) + ' )';

    _KanalCond :=
      ' ( ( z.id_attach = ' + IntToStr( Integer( toaKanal ) ) + ' )' +
       _AddCond( F_OwnerID_kanal, F_TZavID_kanal, F_PlaceID_kanal, F_SodID_kanal ) + ' )';

   _VRKCond :=
      ' ( ( z.id_attach = ' + IntToStr( Integer( toaVRK ) ) + ' )' +
       _AddCond( F_OwnerID_VRK, F_TZavID_VRK, F_PlaceID_VRK, F_SodID_VRK ) + ' )';

    _cond:='';
    if ( F_IsVodaConsid )   then
     _cond:= _VodaCond;
    if F_IsKanalConsid  then
     if _cond<>'' then
      _cond:=_cond+' or '+_KanalCond
     else
      _cond:=_KanalCond;
   if  F_IsVRKConsid  then
     if _cond<>'' then
      _cond:=_cond+' or '+_VRKCond
     else
      _cond:=_VRKCond;

  {  if ( F_IsVodaConsid ) and ( F_IsKanalConsid ) then
    begin
      _cond :=
        _VodaCond +
        ' or' +
        _KanalCond;
    end else
    if ( F_IsVodaConsid ) and ( not F_IsKanalConsid ) then
    begin
      _cond := _VodaCond;
    end else
    if ( not F_IsVodaConsid ) and ( F_IsKanalConsid ) then
    begin
      _cond := _KanalCond;
    end;
   }
    _cond :=
      ' where ( delz=0 and (z.is_otl=0 or z.is_otl<>1))' +
      ' and ( z.dt_in >= ''' + DateToStr( F_DtBeg ) + ''' )' +
      ' and ( z.dt_in < ''' + DateToStr( F_DtEnd + 1 ) + ''')' +
      ' and' +
      '  (' +
      _cond +
      '   )';
  end else
    _cond := ' where ( z.id = -1 )';  //нихрена не выводим

  _sql :=
    Format( SEL_SQL, [ '''0'' is_closed ' ,'nzavjav' ] ) +
    _cond +
    ' union all'+
    Format( SEL_SQL, [ '''1'' is_closed ','zavjav' ] ) +
    _cond +
    ' order by 1, 2, 3';

  _mtf := TMemTableFiller.Create;
  try
    _mtf.ResMemTable := CheckDset;
    _mtf.FillResMemTable( _sql );
    CheckIsClosed(_mtf.ResMemTable);// убираем время закрытия у незакрытых заявок
  finally
    _mtf.Free;
  end;



end;

procedure Tdm_SvodkaSES.PrepareResultDset;
begin
  FillResultDsetByCheckList( CheckDset, F_RowInformerList, ResultDset );
end;

procedure Tdm_SvodkaSES.DataModuleCreate(Sender: TObject);
begin
  inherited;
  F_RowInformerList := TRowInformerList.Create;
end;

procedure Tdm_SvodkaSES.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  F_RowInformerList.Free;
end;

end.
