unit BworkShiefDM;

interface

uses
  SysUtils, Classes, DMMain, IBDatabase, DB, IBCustomDataSet, kbmMemTable,
  IBSQL;

const
  SEL_BWORK_WORKS =
    ' select bww.id, bww.id_bwork, bww.id_work, bww.id_diam,' +
    ' w.name_r work_name, w.ed_izm ed_izm,' +
    ' p.name_r place, d.diam' +
    ' from s_bwork_work bww' +
    ' left join s_work w on w.id = bww.id_work' +
    ' left join s_diam d on d.id = bww.id_diam' +
    ' left join s_place p on p.id = w.ftype' +
    ' where bww.id_bwork = %d' +
    ' order by w.name_r, p.name_r, d.diam';

  SEL_BWORK_MATERS =
    ' select bwm.id, bwm.id_bwork, bwm.id_mater, bwm.id_diam,' +
    ' m.name_r mater, d.diam' +
    ' from s_bwork_mater bwm' +
    ' left join s_mat m on m.id = bwm.id_mater' +
    ' left join s_diam d on d.id = bwm.id_diam' +
    ' where bwm.id_bwork = %d' +
    ' order by m.name_r, d.diam';

type
  TDetailTab = (dtWork, dtMater);

  Tdm_BworkShief = class(TDataModule)
    tran: TIBTransaction;
    mt_BworkWorks: TkbmMemTable;
    mt_BworkWorksid: TIntegerField;
    mt_BworkWorksid_bwork: TIntegerField;
    mt_BworkWorksid_work: TIntegerField;
    mt_BworkWorksid_diam: TIntegerField;
    mt_BworkWorkswork_name: TStringField;
    mt_BworkWorksed_izm: TStringField;
    mt_BworkWorksplace: TStringField;
    dset: TIBDataSet;
    mt_BworkMaters: TkbmMemTable;
    IBSQL: TIBSQL;
    mt_BworkWorksdiam: TIntegerField;
    mt_BworkMatersid: TIntegerField;
    mt_BworkMatersid_bwork: TIntegerField;
    mt_BworkMatersid_mater: TIntegerField;
    mt_BworkMatersid_diam: TIntegerField;
    mt_BworkMatersmater: TStringField;
    mt_BworkMatersdiam: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
    procedure mt_BworkWorksdiamGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
  private
    F_BworkID: integer;
  public
    property BworkID: integer read F_BworkID write F_BworkID;
    procedure FillDetailTab( _DetailTab: TDetailTab );
    procedure AddWorkToBwork( _WorkID, _DiamID: integer );
    procedure AddMaterToBwork( _MaterID, _DiamID: integer );
    procedure DelCurRec( _DetailTab: TDetailTab );
  end;

implementation

{$R *.dfm}

uses HelpFunctions;

{ Tdm_BworkShief }


procedure Tdm_BworkShief.AddMaterToBwork(_MaterID, _DiamID: integer);
var
  _tr: TIBTransaction;
begin
  _tr := ibsql.Transaction;

  if _tr.InTransaction then _tr.Rollback;
  _tr.StartTransaction;
  try
    MyExecIBSQL( IBSQL,
      ' insert into s_bwork_mater(' +
      '   id_bwork,' +
      '   id_mater,' +
      '   id_diam)' +
      ' values(' +
      '   ' + IntToStr( F_BworkID ) + ',' +
      '   ' + IntToStr( _MaterID ) + ',' +
      '   ' + IntToStr( _DiamID ) + ')' );

    _tr.Commit
  except
    on E: Exception do
    begin
      _tr.Rollback;
      E.Message := E.Message + '(Tdm_BworkShief.AddMaterToBwork)';
      raise;
    end;
  end;

  FillDetailTab( dtMater );
end;

procedure Tdm_BworkShief.AddWorkToBwork(_WorkID, _DiamID: integer);
var
  _tr: TIBTransaction;
begin
  _tr := ibsql.Transaction;

  if _tr.InTransaction then _tr.Rollback;
  _tr.StartTransaction;
  try
    MyExecIBSQL( IBSQL,
      ' insert into s_bwork_work(' +
      '   id_bwork,' +
      '   id_work,' +
      '   id_diam)' +
      ' values(' +
      '   ' + IntToStr( F_BworkID ) + ',' +
      '   ' + IntToStr( _WorkID ) + ',' +
      '   ' + IntToStr( _DiamID ) + ')' );

    _tr.Commit
  except
    on E: Exception do
    begin
      _tr.Rollback;
      E.Message := E.Message + '(Tdm_BworkShief.AddWorkToBwork)';
      raise;
    end;
  end;

  FillDetailTab( dtWork );
end;

procedure Tdm_BworkShief.DataModuleCreate(Sender: TObject);
begin
  F_BworkID := -1;
end;

procedure Tdm_BworkShief.DelCurRec(_DetailTab: TDetailTab);
var
  _tr: TIBTransaction;
  _mt: TkbmMemTable;
  _tbl: string;
begin
  if _DetailTab = dtWork then
  begin
    _mt := mt_BworkWorks;
    _tbl := 's_bwork_work';
  end else
  begin
    _mt := mt_BworkMaters;
    _tbl := 's_bwork_mater';
  end;
  _tr := ibsql.Transaction;

  if _tr.InTransaction then _tr.Rollback;
  _tr.StartTransaction;
  try
    MyExecIBSQL( ibsql,
      ' delete from ' + _tbl +
      ' where id = ' + _mt.FieldByName( 'id' ).AsString );

    _tr.Commit;
  except
    on E: Exception do
    begin
      _tr.Rollback;
      E.Message := E.Message + '(Tdm_BworkShief.DelCurRec)';
      raise;
    end;
  end;

  _mt.Delete;
end;

procedure Tdm_BworkShief.FillDetailTab(_DetailTab: TDetailTab);
var
  i: integer;
  _tr: TIBTransaction;
  _mt: TkbmMemTable;
  _sel_sql: string;
begin
  if _DetailTab = dtWork then
  begin
    _mt := mt_BworkWorks;
    _sel_sql := SEL_BWORK_WORKS;
  end else
  begin
    _mt := mt_BworkMaters;
    _sel_sql := SEL_BWORK_MATERS;
  end;
  _tr := dset.Transaction;

  //

  _mt.DisableControls;
  try
    _mt.Close;
    _mt.Open;

    if _tr.InTransaction then _tr.Rollback;
    _tr.StartTransaction;
    try
      MyOpenIBDS( dset, Format( _sel_sql, [ BworkID ] ) );
      dset.First;
      while not dset.Eof do
      begin
        _mt.Append;
        for i:=0 to dset.FieldCount-1 do
          _mt.FieldByName( dset.Fields[ i ].FieldName ).Value := dset.Fields[ i ].Value;
        _mt.Post;

        dset.Next;
      end;
      _mt.First;
      
      _tr.Commit;
    except
      on E: Exception do
      begin
        _tr.Rollback;
        E.Message := E.Message + '(Tdm_BworkShief.Fill)';
        raise;
      end;
    end;
  finally
    _mt.EnableControls;
  end;
end;

procedure Tdm_BworkShief.mt_BworkWorksdiamGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  if Sender.AsInteger <=0 then
    Text := ''
  else
    Text := Sender.AsString;
end;

end.
