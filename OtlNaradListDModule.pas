unit OtlNaradListDModule;

interface

uses
  SysUtils, Classes,DMmain, DB, IBCustomDataSet, IBSQL, IBDatabase,
  kbmMemTable;

type
  Tdm_OtlNaradList = class(TDataModule)
    tran: TIBTransaction;
    IBSQL_main: TIBSQL;
    dset: TIBDataSet;
    dsetNOMER: TIntegerField;
    dsetDT_IN: TDateTimeField;
    dsetREV: TIBStringField;
    dsetADRES: TIBStringField;
    dsetPLACE: TIBStringField;
    dsetID: TIntegerField;
    dset_linkorder: TIBDataSet;
    memmain: TkbmMemTable;
    memmainid: TIntegerField;
    memmainmoner: TIntegerField;
    memmainDT_IN: TDateTimeField;
    memmainREV: TStringField;
    memmainadres: TStringField;
    memmainplace: TStringField;
    ibsql_del: TIBSQL;
    dsetID_REVS: TIntegerField;
    memmainid_revs: TIntegerField;
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }

    F_idzavyav:integer;

    F_otlOrder:integer;
    F_id_attach:integer;
    function checkListOrder():boolean;
    function refreshList():boolean;
    procedure fillMemFromDset();

  public
    { Public declarations }
    constructor Create(AOwner: TComponent; id_zav:integer; id_attach:integer ); overload;
    function prepareList(id_attach:integer):boolean;
    function Save(id_zav:integer):boolean;
    property otlOrder :integer read F_otlOrder;
    function saveDel():boolean;
    procedure sordted(columnname:String);
  end;
  const
  sql= 'select z.id,z.nomer,   z.dt_in,z.id_revs , '+
       ' (select trim(sr.name_r) from  s_revs sr where sr.id=z.id_revs) rev , '+
       ' (select adres  from get_adres(z.id_ul1,z.id_ul2, z.kod_ul, z.dop_adr, z.id_dopadres) )adres, '+
       ' (select sp.name_r from s_place sp where sp.id=z.id_place) place, '+
       ' z.id_revs id_r,z.id_revs  '+
       '  from nzavjav z where z.id_attach =:id_atach '+

       '  and z.is_otl=1  and z.id<>:id_zav'+
       '  ';
  sql_zav= 'select z.id,z.nomer, z.id_revs ,   z.dt_in, '+
       ' (select trim(sr.name_r) from  s_revs sr where sr.id=z.id_revs) rev , '+
       ' (select adres  from get_adres(z.id_ul1,z.id_ul2, z.kod_ul, z.dop_adr, z.id_dopadres) )adres, '+
       ' (select sp.name_r from s_place sp where sp.id=z.id_place) place, '+
       ' z.id_revs id_r '+
       '  from nzavjav z where z.id =:id_zav ';
  sql_insert = ' insert into  LINKOTLORDER (id_zavjav,id_otlzavjav)  values (:id_zav, :id_otlnar)';
  order_option = 'order by z.id_revs, adres';
  sql_del = 'delete from linkotlorder lo where lo.id_zavjav=:id_zav';




implementation

{$R *.dfm}

function Tdm_OtlNaradList.checkListOrder: boolean;
begin
 result:=true;
 dset_linkorder.ParamByName('id_zav').AsInteger:=F_idzavyav;
 try
   dset_linkorder.Open;
   dset_linkorder.First;
   if dset_linkorder.RecordCount>0 then
   begin
     F_otlOrder:=dset_linkorder.fieldbyname('id_otlzavjav').AsInteger;
   end;
   result:=true;
 except
  result:=false;
 end;
end;

constructor Tdm_OtlNaradList.Create(AOwner: TComponent; id_zav, id_attach: integer);
begin
   inherited Create(AOwner);
   F_idzavyav:=id_zav;
   F_id_attach:=id_attach;
   F_otlOrder:=0;
end;

procedure Tdm_OtlNaradList.DataModuleDestroy(Sender: TObject);
begin
if dset_linkorder.Active then
 dset_linkorder.Close;
if dset.Active then dset.Close;
if tran.InTransaction then
 tran.Rollback;
memmain.Close;

end;

procedure Tdm_OtlNaradList.fillMemFromDset;
begin
    dset.First;
    if memmain.Active then memmain.Close;
      memmain.Open;
      while not dset.Eof do begin

       memmain.Append;
       memmain.FieldByName('id').AsInteger:=dset.fieldbyname('id').AsInteger;
       memmain.FieldByName('nomer').AsInteger:=dset.FieldByName('nomer').AsInteger;
       memmain.FieldByName('dt_in').AsDateTime:=dset.FieldByName('dt_in').AsDateTime;
       memmain.FieldByName('adres').AsString:=dset.FieldByName('adres').AsString;
       memmain.FieldByName('place').AsString:=dset.FieldByName('place').AsString;
       memmain.FieldByName('rev').AsString:=dset.FieldByName('rev').AsString;
       memmain.FieldByName('id_revs').AsInteger:=dset.FieldByName('id_revs').AsInteger;

       memmain.Post;
       dset.Next;


      end;
end;

function Tdm_OtlNaradList.prepareList(id_attach: integer): boolean;
begin
  result:=false;

   if tran.InTransaction then
    tran.Rollback;
   tran.StartTransaction;

   try
    if checkListOrder then
     begin
      if  F_otlOrder>0 then
       begin
        dset.SelectSQL.Text:= sql_zav;
        dset.ParamByName('id_zav').AsInteger:=F_otlOrder;

        dset.Open;

       end
     else
       begin
          dset.SelectSQL.Text:= sql+order_option;
        dset.ParamByName('id_atach').AsInteger:=id_attach;
        dset.ParamByName('id_zav').AsInteger:=F_idzavyav;
        dset.Open;


       end;
      dset.First ;
      fillMemFromDset;
      result:=true;
      tran.Commit;
    end;
   except
    tran.Rollback;
   end

end;

function Tdm_OtlNaradList.refreshList: boolean;
begin
 try
   if tran.InTransaction then
      tran.Rollback;
   tran.StartTransaction;
   if memmain.Active then
     memmain.Close;
   memmain.Open;
   dset.SelectSQL.Text:=sql+order_option;
   dset.ParamByName('id_atach').AsInteger:=F_id_attach;
   dset.ParamByName('id_zav').AsInteger:=F_idzavyav;
   dset.Open;
   fillMemFromDset;
   result:=true;
 except


   result:=false;
 end;

end;

function Tdm_OtlNaradList.Save(id_zav: integer): boolean;
begin
  if  not tran.InTransaction then
   tran.StartTransaction;
  IBSQL_main.SQL.Text:=sql_insert;
  IBSQL_main.ParamByName('id_zav').AsInteger:=F_idzavyav;
  IBSQL_main.ParamByName('id_otlnar').AsInteger:=id_zav;
  try
   IBSQL_main.ExecQuery;
   tran.Commit;
   //preareList;
   F_otlOrder:=id_zav;
   result:=true;
  except
   tran.Rollback;
   result:=false;
  end;
end;

function Tdm_OtlNaradList.saveDel: boolean;
begin
 try
  if  not tran.InTransaction then
   tran.StartTransaction;
 ibsql_del.SQL.Text:=sql_del;
 ibsql_del.ParamByName('id_zav').AsInteger:=F_idzavyav;
 ibsql_del.ExecQuery;
 tran.Commit;
 refreshList;
 result:=true;
 except
   if   tran.InTransaction then
    tran.Rollback;
  result:=false;
 end;
end;

procedure Tdm_OtlNaradList.sordted(columnname: String);
begin

 memmain.SortOn('id_revs;'+columnname,[mtcoCaseInsensitive]);
end;

end.
