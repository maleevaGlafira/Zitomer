unit RepEkonomPokazDM;

interface

uses
  SysUtils, Classes, DMMain, DB, IBCustomDataSet, IBDatabase, FR_Class,
  NGReportBaseDModule, kbmMemTable, FR_DSet, FR_DBSet;

type
  Tdm_RepEkonomPokaz = class(Tdm_NGReportBase)
    tran: TIBTransaction;
    dset: TIBDataSet;
    mt_TZ: TkbmMemTable;
    mt_Obor: TkbmMemTable;
    mt_Mat: TkbmMemTable;
    mt_TZplace: TStringField;
    mt_TZdiam: TIntegerField;
    mt_TZtz: TFloatField;
    mt_TZwork: TStringField;
    frDS_TZ: TfrDBDataSet;
    mt_TZbrig: TStringField;
    mt_TZdolgn: TStringField;
    frDS_Obor: TfrDBDataSet;
    frDS_Mat: TfrDBDataSet;
    mt_Oborobor: TStringField;
    mt_Matmat: TStringField;
    mt_Mated_izm: TStringField;
    mt_Matdiam: TIntegerField;
    mt_Matkol_mat: TFloatField;
    dset_WorkTime: TIBDataSet;
  private
    F_ZavID: integer;
    F_IsCalcTZ: boolean;
    //
    F_ZavNomer,
    F_ZavYear: integer;
    F_ZavAttach: string;
    procedure FillTZ;
    procedure FillObor;
    procedure FillMat;
    procedure SetAddFields;
    function GetWorkTime( _BrigID: integer ): double;
  public
    property ZavID: integer read F_ZavID write F_ZavID;
    property IsCalcTZ: boolean read F_IsCalcTZ write F_IsCalcTZ; {если true тогда считаем трудозатраты}
    procedure PrepareDset;
    //
    property ZavNomer: integer read F_ZavNomer;
    property ZavYear: integer read F_ZavYear;
    property ZavAttach: string read F_ZavAttach;
  end;

implementation

{$R *.dfm}

uses HelpFunctions, WorkTimeCalcer;

{ Tdm_RepEkonomPokaz }


procedure Tdm_RepEkonomPokaz.FillMat;
var
  i: integer;
begin
  mt_Mat.Close;
  mt_Mat.Open;

  MyOpenIBDS( dset,
    ' select' +
    ' sm.name_r mat, sm.ed_izm, sd.diam, sum(m.kol_mat) kol_mat' +
    ' from s_mat sm, maters m' +
    ' left join s_diam sd on sd.id = m.id_diam' +
    ' where ( sm.id = m.id_mat )' +
    ' and (m.id_zav = ' + IntToStr( F_ZavID ) + ')' +
    ' group by sm.name_r, sm.ed_izm, sd.diam' );
  dset.First;
  while not dset.Eof do
  begin
    mt_Mat.Append;
    for i:=0 to dset.FieldCount -1 do
      mt_Mat.FieldByName( dset.Fields[i].FieldName ).Value := dset.Fields[i].Value;
    mt_mat.Post;
    dset.Next;
  end;
  dset.Close;
end;

procedure Tdm_RepEkonomPokaz.FillObor;
begin
  mt_Obor.Close;
  mt_Obor.Open;

  MyOpenIBDS( dset,
    ' select' +
    ' distinct so.name_r obor' +
    ' from obors o' +
    ' left join s_obor so on so.id = o.id_obor' +
    ' where (so.name_r is not null)' +
    ' and ( o.id_zav = ' + IntToStr( F_ZavID ) + ' )' );
  dset.First;
  while not dset.Eof do
  begin
    mt_Obor.Append;
    mt_Obor.FieldByName( 'obor' ).AsString := dset.FieldByName( 'obor' ).AsString;
    mt_Obor.Post;

    dset.Next;
  end;
  dset.Close;
end;

procedure Tdm_RepEkonomPokaz.FillTZ;
  function _CalcWork( _name, _ed_izm: string ): string;
  begin
    Result := trim( _name );
    _ed_izm := trim( _ed_izm );
    if _ed_izm <> '' then
      Result := Result + ' (' + _ed_izm + ')';
  end;
begin
  mt_TZ.Close;
  mt_TZ.Open;

  {Информация по трудозатратам}
  MyOpenIBDS( dset,
    ' select' +
    ' sw.name_r work_name, sp.name_r place, sd.diam, w.id_zav, sw.ed_izm,' +
    ' sum( ( select tz from calc_tz(w.tz_trudozatrat, w.tz_kol_ed, w.kol_work ) ) ) tz' +
    ' from works w' +
    ' left join s_work sw on sw.id = w.id_work' +
    ' left join s_place sp on sp.id = w.id_place' +
    ' left join s_diam sd on sd.id = w.id_diam' +
    ' where (sw.name_r is not null) and (w.id_work > 0)' +
    ' and (w.id_zav = ' + IntToStr( F_ZavID ) + ')' +
    ' group by sw.name_r, sp.name_r, sd.diam, w.id_zav, sw.ed_izm' );

  dset.First;
  while not dset.Eof do
  begin
    mt_TZ.Append;
    mt_TZ.FieldByName( 'work' ).AsString := _CalcWork( dset.FieldByName( 'work_name' ).AsString,
                                                       dset.FieldByName( 'ed_izm' ).AsString );
    mt_TZ.FieldByName( 'place' ).AsString := dset.FieldByName( 'place' ).AsString;
    mt_TZ.FieldByName( 'diam' ).AsInteger := dset.FieldByName( 'diam' ).AsInteger;
    if F_IsCalcTZ then
      mt_TZ.FieldByName( 'tz' ).AsFloat := dset.FieldByName( 'tz' ).AsFloat;
    mt_TZ.Post;

    dset.Next;
  end;
  dset.Close;
  {/Информация по трудозатратам}

  {Информация по бригаде}
  mt_TZ.First;

  MyOpenIBDS( dset,
    ' select distinct b.id, b.name_r brig, b.dolgn' +
    ' from s_brig b, ord_people op' +
    ' where (op.add_people=b.id)' +
    ' and (op.id_zav=' + IntToStr( F_ZavID ) + ')' +
    ' and (b.id > 0)' +
    ' order by b.name_r' );

  dset.First;
  while not dset.Eof do
  begin
    if mt_TZ.Eof then mt_TZ.Append
    else mt_TZ.Edit;
                                                                                                                
    mt_TZ.FieldByName( 'brig' ).AsString := dset.FieldByName( 'brig' ).AsString;
    mt_TZ.FieldByName( 'dolgn' ).AsString := dset.FieldByName( 'dolgn' ).AsString;
    if not F_IsCalcTZ then
      mt_TZ.FieldByName( 'tz' ).AsFloat := GetWorkTime( dset.FieldByName( 'id' ).AsInteger );

    mt_TZ.Post;
    mt_TZ.Next;

    dset.Next;
  end;
  dset.Close;
  {/Информация по бригаде}
end;

function Tdm_RepEkonomPokaz.GetWorkTime(_BrigID: integer): double;
  function _IsDtNull( Value: double ): boolean;
  begin
    Result := ( Value < 100 );
  end;

  function _CalcEnd( _Dt: TDateTime ): double;
  begin
    if _IsDtNull( _Dt ) then
      Result := Now
    else
      Result := _Dt;
  end;
var
  _WorkTimeCalcer: TWorkTimeCalcer;
begin
  Result := 0;

  dset_WorkTime.Close;
  dset_WorkTime.ParamByName( 'pZavID' ).AsInteger := F_ZavID;
  dset_WorkTime.ParamByName( 'pBrigID' ).AsInteger := _BrigID;
  dset_WorkTime.Open;

  if not dset_WorkTime.Eof then
  begin
    _WorkTimeCalcer := TWorkTimeCalcer.Create;
    try
      dset_WorkTime.First;
      while not dset_WorkTime.Eof do
      begin
        {Перед передачей интервалов работ список интервал должен
        быть обзязательно отсортирован по дате начала работ.}
        _WorkTimeCalcer.WorkIntervals.AddWorkTime(  dset_WorkTime.FieldByName( 'dt_in' ).AsDateTime,
                                                    _CalcEnd( dset_WorkTime.FieldByName( 'dt_out' ).AsDateTime ) );
        dset_WorkTime.Next;
      end;
      Result := ( _WorkTimeCalcer.Calc * 24 ); //сутки перевели в часы
    finally
      _WorkTimeCalcer.Free;
    end;
  end;
  dset_WorkTime.Close;
end;

procedure Tdm_RepEkonomPokaz.PrepareDset;
begin
  if tran.InTransaction then tran.Rollback;
  tran.StartTransaction;
  try
    FillTZ;
    FillObor;
    FillMat;
    SetAddFields;

    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      E.Message := E.Message + '(Tdm_RepEkonomPokaz.PrepareDset)';
      raise;
    end;
  end;
end;

procedure Tdm_RepEkonomPokaz.SetAddFields;
begin
  MyOpenIBDS( dset,
    ' select z.nomer, extract(year from z.dt_in) year_, sa.name_r attach' +
    ' from nzavjav z' +
    ' left join s_attach sa on sa.id = z.id_attach' +
    ' where z.id = ' + IntToStr( F_ZavID ) +
    ' union all' +
    ' select z.nomer, extract(year from z.dt_in) year_, sa.name_r attach' +
    ' from zavjav z' +
    ' left join s_attach sa on sa.id = z.id_attach' +
    ' where z.id = ' + IntToStr( F_ZavID ) );

  F_ZavNomer := dset.FieldByName( 'nomer' ).AsInteger;
  F_ZavYear := dset.FieldByName( 'year_' ).AsInteger;
  F_ZavAttach := dset.FieldByName( 'attach' ).AsString;
end;

end.
