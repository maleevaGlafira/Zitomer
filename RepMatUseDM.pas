unit RepMatUseDM;

interface

uses
  SysUtils, Classes, NGReportBaseDModule, FR_Class, ItemSelecter,  DMMain,
  IBDatabase, DB, kbmMemTable, IBCustomDataSet, FR_DSet, FR_DBSet, OperAttFormUnit;

type
  TfrValueRec=record
    dt_in, nomer, adres: variant;
  end;

  Tdm_RepMatUse = class(Tdm_NGReportBase)
    tran: TIBTransaction;
    ResultDset: TkbmMemTable;
    dset: TIBDataSet;
    ResultDsetrevs: TStringField;
    ResultDsetdt_in: TDateTimeField;
    ResultDsetnomer: TIntegerField;
    ResultDsetmat: TStringField;
    ResultDsetdiam: TIntegerField;
    ResultDsetzav_id: TIntegerField;
    ResultDsetkol_mat: TFloatField;
    ResultDsetadres: TStringField;
    dset_ZavAdres: TIBDataSet;
    frDS_Result: TfrDBDataSet;
    ResultDsetattach: TStringField;
    ResultDsetid_attach: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
  private
    F_BeginDate,
    F_EndDate: TDateTime;
    F_AttSelItems,
    F_RevsSelItems,
    F_MatSelItems: TSelItemList;
    F_frValueRec: TfrValueRec;
    procedure FillResultDset;
    procedure frReportGetValue(const ParName: String; var ParValue: Variant);
  public
    property BeginDate: TDateTime read F_BeginDate write F_BeginDate;
    property EndDate: TDateTime read F_EndDate write F_EndDate;
    property AttSelItems: TSelItemList read F_AttSelItems write F_AttSelItems;
    property RevsSelItems: TSelItemList read F_RevsSelItems write F_RevsSelItems;
    property MatSelItems: TSelItemList read F_MatSelItems write F_MatSelItems;
    procedure PrepareDset;
  end;


implementation

{$R *.dfm}

uses HelpFunctions;

{ Tdm_RepMatUse }

procedure Tdm_RepMatUse.FillResultDset;
  function _cond( _s: string; _SelItems: TSelItemList ): string;
  begin
    Result := '';
    if _SelItems.Count > 0 then
      Result := Format( _s, [ _SelItems.ItemsID ] );
  end;

  function _mat( _name, _ed_izm: string ): string;
  begin
    Result := trim( _name );
    if trim( _ed_izm ) <> '' then
      Result := Result + '(' +trim( _ed_izm ) + ')';
  end;

  function _adres( _ZavID: integer ): string;
  begin
    dset_ZavAdres.Close;
    dset_ZavAdres.ParamByName( 'pZavID' ).AsInteger := _ZavID;
    dset_ZavAdres.Open;
    Result := dset_ZavAdres.FieldByName( 'adres' ).AsString;
    dset_ZavAdres.Close;
  end;
var
  _sql: string;
begin
  ResultDset.Close;
  ResultDset.Open;

  _sql :=
    ' select sa.name_r attach, sr.name_r revs, z.dt_in, z.nomer,' +
    ' sm.name_r mat, sd.diam, sm.ed_izm, z.id zav_id, z.id_attach,' +
    ' sum(m.kol_mat) kol_mat' +
    ' from %s z, s_revs sr, s_attach sa, s_mat sm, maters m' +
    ' left join s_diam sd on sd.id = m.id_diam' +
    ' where (z.id = m.id_zav)' +
    ' and (z.id_revs = sr.id) and (m.id_mat = sm.id)' +
    ' and (z.id_attach = sa.id)' +
    ' and (z.dt_in >= ''' + DateToStr( F_BeginDate ) + ''')' +
    ' and (z.dt_in < ''' + DateToStr( F_EndDate ) + ''')' +
    ' and (z.delz = 0 ) '+
    _cond( ' and (z.id_attach in (%s) )', F_AttSelItems ) +
    //_cond( ' and (z.id_revs in (%s) )',   F_RevsSelItems ) +
    _cond( ' and (m.id_mat in ( %s) )',   F_MatSelItems ) +
    ' group by sa.name_r, sr.name_r, z.dt_in, z.nomer,' +
    ' sm.name_r, sd.diam, sm.ed_izm, z.id, z.id_attach';

  MyOpenIBDS( dset,
    Format( _sql, [ 'nzavjav' ] ) +
    ' union all' +
    Format( _sql, [ 'zavjav' ] ) +
    ' order by 1, 2, 3, 4, 5, 6' );

  dset.First;
  while not dset.Eof do
  begin
    ResultDset.Append;
    ResultDset[ 'attach' ] := dset[ 'attach' ];
    ResultDset[ 'id_attach' ] := dset[ 'id_attach' ];

    if dset.FieldByName( 'id_attach' ).AsInteger in [ Ord( toaObjVoda ), Ord( toaObjKanal ) ] then
      ResultDset[ 'revs' ] := ''
    else
      ResultDset[ 'revs' ] := dset[ 'revs' ];

    ResultDset[ 'dt_in' ] := dset[ 'dt_in' ];
    ResultDset[ 'nomer' ] := dset[ 'nomer' ];
    ResultDset[ 'mat' ] := _mat( dset.fieldbyname( 'mat' ).AsString, dset.fieldbyname('ed_izm').AsString );
    ResultDset[ 'diam' ] := dset[ 'diam' ];
    ResultDset[ 'zav_id' ] := dset[ 'zav_id' ];
    ResultDset[ 'kol_mat' ] := dset[ 'kol_mat' ];
    ResultDset[ 'adres' ] := _adres( dset.FieldByName( 'zav_id' ).AsInteger );
    ResultDset.Post;

    dset.Next;
  end;
  dset.Close;
end;

procedure Tdm_RepMatUse.frReportGetValue(const ParName: String;
  var ParValue: Variant);
  procedure _PrepValue( var _OldValue: variant; var _NewValue: variant; _view: TfrView );
  begin
    if _view <> nil then
    begin
      if _OldValue <> _NewValue then
      begin
        (_view as TfrMemoView).FrameTyp := 13;
        _OldValue := _NewValue;
      end else
      begin
        (_view as TfrMemoView).FrameTyp := 5;
        _NewValue := '';
      end;
    end;
  end;
begin
  if Pos( 'RESULTDSET."DT_IN"', AnsiUpperCase( ParName ) ) <> 0 then
  begin
    ParValue := ResultDset.FieldByName( 'dt_in' ).AsDateTime;
    _PrepValue( F_frValueRec.dt_in, ParValue,
      frReport.FindObject( 'mem_dt_in' ) );
  end else
  if Pos( 'RESULTDSET."NOMER"', AnsiUpperCase( ParName ) ) <> 0 then
  begin
    ParValue := ResultDset.FieldByName( 'nomer' ).AsInteger;
    _PrepValue( F_frValueRec.nomer, ParValue,
      frReport.FindObject( 'mem_nomer' ) );
  end else
  if Pos( 'RESULTDSET."ADRES"', AnsiUpperCase( ParName ) ) <> 0 then
  begin
    ParValue := ResultDset.FieldByName( 'adres' ).AsString;
    _PrepValue( F_frValueRec.adres, ParValue,
      frReport.FindObject( 'mem_adres' ) );
  end;
end;

procedure Tdm_RepMatUse.PrepareDset;
begin
  F_frValueRec.dt_in := 0;
  F_frValueRec.nomer := -1;
  F_frValueRec.adres := '';

  if tran.InTransaction then tran.Rollback;
  tran.StartTransaction;
  try
    FillResultDset;
    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      E.Message := E.Message + '(Tdm_RepMatUse.PrepareDset)'
    end;
  end;
end;

procedure Tdm_RepMatUse.DataModuleCreate(Sender: TObject);
begin
  inherited;
  frReport.OnGetValue := frReportGetValue;
end;

end.
