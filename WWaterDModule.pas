unit WWaterDModule;

interface

uses
  SysUtils, Classes, Controls, DMMain, IBQuery, DB, IBCustomDataSet,
  IBDatabase, OperAttFormUnit, FR_DSet, FR_DBSet, FR_Class, RxMemDS;

type
  TDM_WWater = class(TDataModule)
    tran_tmp: TIBTransaction;
    dset_src: TIBDataSet;
    qry_Detail: TIBQuery;
    ds_main: TDataSource;
    frReport1: TfrReport;
    frDS_Main: TfrDBDataSet;
    frDS_Detail: TfrDBDataSet;
    md_main: TRxMemoryData;
    md_mainzav_type: TIntegerField;
    md_mainid: TIntegerField;
    md_maindt_in: TDateTimeField;
    md_maindt_out: TDateTimeField;
    md_mainnomer: TIntegerField;
    md_mainadres: TStringField;
    md_mainsod: TStringField;
    md_mainmaingr: TIntegerField;
    dset_tmp: TIBDataSet;
    md_mainwwater_time: TStringField;
    procedure DataModuleDestroy(Sender: TObject);
  private
    F_dt_beg, F_dt_end: TDate;
    F_OperAtt: TOperAtt;
    procedure PrepareMemDset;
    function get_wwater_time(zav_type, id_zav: integer; dt_in, dt_out: TDate): string;  //время без воды
    function TimeDeltaToHour(delta: double): string;
  public
    property dt_beg: TDate read F_dt_beg write F_dt_beg;
    property dt_end: TDate read F_dt_end write F_dt_end;
    property OperAtt: TOperAtt read F_OperAtt write F_OperAtt;
    procedure PrepareDsets;
  end;

implementation

{$R *.dfm}

uses ServiceFuncUnit, AvrDBConst;

{ TDM_WWater }

procedure TDM_WWater.PrepareDsets;
begin
  if tran_tmp.InTransaction then
    tran_tmp.Commit;
  tran_tmp.StartTransaction;
  try
    PrepareMemDset;
    qry_detail.Open;
  except
    on E: Exception do
    begin
      tran_tmp.Rollback;
      raise Exception.Create(E.Message+'(TDM_WWater.PrepareDsets)');
    end;
  end;
end;

procedure TDM_WWater.DataModuleDestroy(Sender: TObject);
begin
  if tran_tmp.InTransaction then
    tran_tmp.Commit;
end;

procedure TDM_WWater.PrepareMemDset;
var
  zav_type, id_zav: integer;
  dt_in, dt_out: TDateTime;
begin
  if dset_src.Active then
    dset_src.Close;
  dset_src.ParamByName('pDt1').AsDate:=F_dt_beg;
  dset_src.ParamByName('pDt2').AsDate:=F_dt_end+1;
  dset_src.ParamByName('pAtt').AsInteger:=ord(F_OperAtt);
  dset_src.Open;
  dset_src.First;

  md_main.Close;
  md_main.Open;
  while not dset_src.Eof do
  begin
    zav_type:=dset_src.FieldByName('zav_type').AsInteger;
    id_zav:=dset_src.FieldByName('id').AsInteger;
    dt_in:=dset_src.FieldByName('dt_in').AsDateTime;
    if zav_type=1 then
      dt_out:=0
    else
      dt_out:=dset_src.FieldByName('dt_out').AsDateTime;

    md_main.Append;
    md_main.FieldByName('zav_type').AsInteger:=zav_type;
    md_main.FieldByName('id').AsInteger:=id_zav;
    md_main.FieldByName('dt_in').AsDateTime:=dt_in;
    md_main.FieldByName('dt_out').AsDateTime:=dt_out;
    md_main.FieldByName('nomer').AsInteger:=dset_src.FieldByName('nomer').AsInteger;
    md_main.FieldByName('adres').AsString:=dset_src.FieldByName('adres').AsString;
    md_main.FieldByName('sod').AsString:=dset_src.FieldByName('sod').AsString;
    md_main.FieldByName('maingr').AsInteger:=0;
    md_main.FieldByName('wwater_time').AsString:=get_wwater_time(zav_type, id_zav, dt_in, dt_out);

    md_main.Post;

    dset_src.Next;
  end;
  dset_src.Close;
end;

function TDM_WWater.get_wwater_time(zav_type, id_zav: integer; dt_in, dt_out: TDate): string;   //время без воды
var
  delta: double;
  minDT, maxDT: TDateTime;
begin
  MyOpenIBDS( dset_tmp,
    ' select zd.dt_in, zd.dt_out, zd.id_zavout, sr.id_remont_type' +
    ' from zadv zd' +
    ' left join s_remont sr on sr.id = zd.id_remont' +
    ' where zd.id_zavin = ' + IntToStr( id_zav ) );

  {zav_type=1-незакрытые; zav_type=2-закрытые}
  if dset_tmp.Eof then //если у заявки нет задвижек
  begin
    if zav_type = 1 then delta := Now - dt_in
    else delta := dt_out - dt_in;
  end else //если у заявки есть задвижки
  begin
    dset_tmp.First;
    minDT := dset_tmp.FieldByName( 'dt_in' ).AsDateTime;
    maxDT := -1;
    while not dset_tmp.Eof do
    begin
      if dset_tmp.FieldByName( 'dt_in' ).AsDateTime < minDT then
        minDT := dset_tmp.FieldByName('dt_in').AsDateTime;

      if dset_tmp.FieldByName( 'id_zavout' ).AsInteger <> 0 then
      begin
        if dset_tmp.FieldByName( 'dt_out' ).AsDateTime > maxDT then
          maxDT := dset_tmp.FieldByName( 'dt_out' ).AsDateTime;
      end else
        if dset_tmp.FieldByName( 'id_remont_type' ).AsInteger <> Integer( tsc_srt_TREBUETSYA ) then
          maxDT := Now;

      dset_tmp.Next;
    end; // end while

    if maxDT < 0 then maxDT := Now;

    delta := maxDT - minDt;
  end;
  dset_tmp.Close;

  Result := TimeDeltaToHour( delta );
//  Result:=FormatFloat('0.##', delta*24);
end;

function TDM_WWater.TimeDeltaToHour(delta: double): string;
var
  hour, minut: integer;
  dl: double;
begin
  dl := 24*delta;
  hour := trunc(dl);
  minut := trunc(60*(dl-hour));
  //Result:=IntToStr(hour)+' ч. '+IntToStr(minut)+' м.';
  //Result := IntToStr(hour)+':'+IntToStr(minut);
  Result := FormatFloat( '00', hour ) + ':' + FormatFloat( '00', minut );
end;

end.
