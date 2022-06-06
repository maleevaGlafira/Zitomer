unit RepTrudoZatratDModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class, IBDatabase, DB,
  IBCustomDataSet, kbmMemTable, FR_DSet, FR_DBSet, OperAttFormUnit;

type
  TfrValueRec=record
    Adres, OrderNumber, DepID: variant;
  end;

  Tdm_RepTrudoZatrat = class(Tdm_NGReportBase)
    tran: TIBTransaction;
    dset: TIBDataSet;
    dset_OrderInfo: TIBDataSet;
    ResultDset: TkbmMemTable;
    ResultDsetid_order: TIntegerField;
    ResultDsetid_dep: TIntegerField;
    ResultDsetStartDate: TDateTimeField;
    ResultDsetWorkName: TStringField;
    ResultDsetDiam: TIntegerField;
    ResultDsetWorkTime: TFloatField;
    ResultDsetAdres: TStringField;
    ResultDsetOrderNumber: TIntegerField;
    frDBResult: TfrDBDataSet;
    ResultDsetPlace: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    F_DtBeg,
    F_DtEnd: TDateTime;
    F_RegionID: integer;
    F_OperAttach: TOperAtt;
    F_frValueRec: TfrValueRec;
    procedure FillResultDset;
    procedure frReportGetValue(const ParName: String; var ParValue: Variant);
  public
    property DtBeg: TDateTime read F_DtBeg write F_DtBeg;
    property DtEnd: TDateTime read F_DtEnd write F_DtEnd;
    property OperAttach: TOperAtt read F_OperAttach write F_OperAttach;
    property RegionID: integer read F_RegionID write F_RegionID;
    function PrepareDset: boolean;
  end;


implementation

{$R *.dfm}

uses HelpFunctions;

{ Tdm_RepTrudoZatrat }

procedure Tdm_RepTrudoZatrat.FillResultDset;
  function _CalcWork( _name, _ed_izm: string ): string;
  begin
    Result := trim( _name );
    _ed_izm := trim( _ed_izm );
    if _ed_izm <> '' then
      Result := Result + ' (' + _ed_izm + ')';
  end;
begin
  ResultDset.Close;
  ResultDset.Open;

  MyOpenIBDS( dset,
    ' select w.id_zav, w.id_nar, n.dt_in,' +
    ' sp.name_r place, sw.name_r work_name, sw.ed_izm,  sd.diam,' +
    ' sum( ( select tz from calc_tz(w.tz_trudozatrat, w.tz_kol_ed, w.kol_work ) ) ) tz' +
    ' from nzavjav z, nnarad n, works w' +
    ' left join s_work sw on sw.id = w.id_work' +
    ' left join s_place sp on sp.id = w.id_place' +
    ' left join s_diam sd on sd.id = w.id_diam' +
    ' where (w.id_zav = z.id) and (w.id_nar = n.id)' +
    ' and  (sw.name_r is not null) and (w.id_work > 0)' +
    ' and (n.dt_in >= ''' + DateToStr( F_DtBeg ) + ''')' +
    ' and (n.dt_in <= ''' + DateToStr( F_DtEnd + 1 ) + ''')' +
    ' and (z.id_revs = ' + IntToStr( F_RegionID ) + ')' +
    ' and (z.id_attach = ' + IntToStr( ord( F_OperAttach ) ) + ')' +
    ' group by w.id_zav, w.id_nar, n.dt_in, sp.name_r, sw.name_r, sw.ed_izm,  sd.diam' +
    ' union all' +
    ' select w.id_zav, w.id_nar, n.dt_in,' +
    ' sp.name_r place, sw.name_r work_name, sw.ed_izm,  sd.diam,' +
    ' sum( ( select tz from calc_tz(w.tz_trudozatrat, w.tz_kol_ed, w.kol_work ) ) ) tz' +
    ' from zavjav z, narad n, works w' +
    ' left join s_work sw on sw.id = w.id_work' +
    ' left join s_place sp on sp.id = w.id_place' +
    ' left join s_diam sd on sd.id = w.id_diam' +
    ' where (w.id_zav = z.id) and (w.id_nar = n.id)' +
    ' and  (sw.name_r is not null) and (w.id_work > 0)' +
    ' and (n.dt_in >= ''' + DateToStr( F_DtBeg ) + ''')' +
    ' and (n.dt_in <= ''' + DateToStr( F_DtEnd + 1 ) + ''')' +
    ' and (z.id_revs = ' + IntToStr( F_RegionID ) + ')' +
    ' and (z.id_attach = ' + IntToStr( ord( F_OperAttach ) ) + ')' +
    ' group by w.id_zav, w.id_nar, n.dt_in, sp.name_r, sw.name_r, sw.ed_izm,  sd.diam' +
    ' order by 1, 2, 3, 4, 5, 7' );

  dset.First;
  while not dset.Eof do
  begin
    dset_OrderInfo.Close;
    dset_OrderInfo.ParamByName( 'pOrderID' ).AsInteger :=
      dset.FieldByName( 'id_zav' ).AsInteger;
    dset_OrderInfo.Open;

    with ResultDset do
    begin
      Append;
      FieldByName( 'id_order' ).AsInteger := dset.FieldByName( 'id_zav' ).AsInteger;
      FieldByName( 'id_dep' ).AsInteger := dset.FieldByName( 'id_nar' ).AsInteger;
      FieldByName( 'StartDate' ).AsDateTime := dset.FieldByName( 'dt_in' ).AsDateTime;
      FieldByName( 'Place' ).AsString := dset.FieldByName( 'place' ).AsString;
      FieldByName( 'WorkName' ).AsString := _CalcWork( dset.FieldByName( 'work_name' ).AsString,
                                                       dset.FieldByName( 'ed_izm' ).AsString );
      FieldByName( 'WorkTime' ).AsFloat := dset.FieldByName( 'tz' ).AsFloat;
      FieldByName( 'Diam' ).AsInteger := dset.FieldByName( 'diam' ).AsInteger;
      FieldByName( 'Adres' ).AsString := dset_OrderInfo.FieldByName( 'adres' ).AsString;
      FieldByName( 'OrderNumber' ).AsInteger := dset_OrderInfo.FieldByName( 'OrderNumber' ).AsInteger;
      Post;
    end;

    dset.Next;
  end;
  dset.Close;
end;

procedure Tdm_RepTrudoZatrat.frReportGetValue(const ParName: String;
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
var
  _view: TfrView;
  _DepID: integer;
begin
  if Pos( 'ORDERNUMBER', AnsiUpperCase( ParName ) ) <> 0 then
  begin
    ParValue := ResultDset.FieldByName( 'OrderNumber' ).AsInteger;
    _PrepValue( F_frValueRec.OrderNumber, ParValue,
      frReport.FindObject( 'mem_OrderNumber' ) );
  end else
  if Pos( 'ADRES', AnsiUpperCase( ParName ) ) <> 0 then
  begin
    ParValue := ResultDset.FieldByName( 'Adres' ).AsString;
    _PrepValue( F_frValueRec.Adres, ParValue,
      frReport.FindObject( 'mem_Adres' ) );
  end else
  if Pos( 'STARTDATE', AnsiUpperCase( ParName ) ) <> 0 then
  begin
    _view := frReport.FindObject( 'mem_StartDate' );
    if _view <> nil then
    begin
      _DepID := ResultDset.FieldByName( 'id_dep' ).AsInteger;
      if F_frValueRec.DepID <> _DepID then
      begin
        (_view as TfrMemoView).FrameTyp := 13;
        F_frValueRec.DepID := _DepID;
        ParValue := ResultDset.FieldByName( 'StartDate' ).AsDateTime;
      end else
      begin
        ParValue := 0;
        (_view as TfrMemoView).FrameTyp := 5;
      end;
    end;
  end;
end;

function Tdm_RepTrudoZatrat.PrepareDset: boolean;
begin
  Result := true;

  F_frValueRec.OrderNumber := -1;
  F_frValueRec.Adres := '';
  F_frValueRec.DepID := -1;

  if tran.InTransaction then tran.Rollback;
  tran.StartTransaction;
  try
    FillResultDset;

    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      raise Exception.Create( E.Message + '(Tdm_RepTrudoZatrat.PrepareDset)' );
    end;
  end;
end;

procedure Tdm_RepTrudoZatrat.DataModuleCreate(Sender: TObject);
begin
  inherited;
  frReport.OnGetValue := frReportGetValue;
end;

end.
