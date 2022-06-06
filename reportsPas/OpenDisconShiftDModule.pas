unit OpenDisconShiftDModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class,DMmain, DB, RxMemDS, IBDatabase,
  IBCustomDataSet;

type
  Tdm_RepOpenDisconShift = class(Tdm_NGReportBase)
    dset_main: TIBDataSet;
    tran: TIBTransaction;
    rmem: TRxMemoryData;
    rmemid: TIntegerField;
    rmemnomer: TIntegerField;
    rmemattach: TStringField;
    rmemaddress: TStringField;
    rmemnarads: TMemoField;
    rmemrev: TStringField;
    rmemdt_in: TStringField;
    rmemid_revs: TIntegerField;
    rmemcomment: TStringField;
  private
    { Private declarations }
    F_ShiftDate:TDate;
  public
    { Public declarations }
    function PrePareDsets():boolean;
  end;

var
  dm_RepOpenDisconShift: Tdm_RepOpenDisconShift;

const  sel_notclosednar = ' select z.id,z.nomer, z.dt_in,sa.name_r attach, '+
                               '(select adres from get_adres(z.id_ul1,z.id_ul2,z.kod_ul,z.dop_adr,z.id_dopadres)) address,'+
                               'sr.name_r rev, z.id_revs, sd.name_r comment'+
                               ' from narad n join  zavjav z on n.id_zav=z.id '+
                               ' join s_attach sa on  sa.id=z.id_attach '+
                               '  join s_revs sr on sr.id =z.id_revs '+
                               ' left join s_sod  sd on sd.id=z.id_comment '+
                               '  where ((n.dt_in>:dat-60   and n.dt_in<:dat+1)  '+
                               '  or (n.dt_dep>:dat-60   and  n.dt_dep<:dat+1)) '+
                               '  and n.dt_out is null '+
                               '  union '+
                               '  select z.id, z.nomer, z.dt_in,sa.name_r  attach,'+
                               ' (select adres from get_adres(z.id_ul1,z.id_ul2,z.kod_ul,z.dop_adr,z.id_dopadres)) address, '+
                               ' sr.name_r rev,z.id_revs, sd.name_r comment'+
                               '  from nnarad n join  nzavjav z on n.id_zav=z.id '+
                               '  join s_attach sa on sa.id=z.id_attach'+
                               '  join s_revs sr on sr.id =z.id_revs '+
                               ' left join s_sod  sd on sd.id=z.id_comment '+
                               '  where ((n.dt_in>:dat-60   and n.dt_in<:dat+1)  '+
                               '  or (n.dt_dep>:dat-60   and  n.dt_dep<:dat+1)) '+
                               '  and n.dt_out is null order by 7,2';


implementation

{$R *.dfm}
uses ShiftDmodule;

function Tdm_RepOpenDisconShift.PrePareDsets():boolean;

  procedure fillRow();
  begin
   rmem.Append;
   rmem.FieldByName('id').AsInteger:=dset_main.fieldbyname('id').AsInteger;
   rmem.FieldByName('nomer').AsInteger:=dset_main.fieldbyname('nomer').AsInteger;
   rmem.FieldByName('attach').AsString:=dset_main.fieldbyname('attach').AsString;
   rmem.FieldByName('rev').AsString:=dset_main.fieldbyname('rev').AsString;
   rmem.FieldByName('address').AsString:=dset_main.fieldbyname('address').AsString;
   //rmem.FieldByName('narads').AsString:=dset_main.fieldbyname('narads').AsString;
   rmem.FieldByName('dt_in').AsString:=FormatDateTime('dd.mm.yyyy hh:mm',dset_main.fieldbyname('dt_in').AsDateTime);
   rmem.FieldByName('id_revs').AsInteger:=dset_main.fieldbyname('id_revs').AsInteger;
   rmem.FieldByName('comment').AsString:=dset_main.fieldbyname('comment').AsString;
   rmem.Post;
  end;

begin
 if rmem.Active then rmem.Close;
 if dset_main.Active then dset_main.Close;
 F_ShiftDate:=date();
 dset_main.SelectSQL.Text:= sel_notclosednar;
 dset_main.ParamByName('dat').AsDate:=F_ShiftDate+StrToTime(StrShiftTimeBegin);
 try
   dset_main.Open;
   dset_main.First;
   rmem.Open;
   while not dset_main.Eof do
   begin
    fillRow();
    dset_main.Next;
   end;
   result:=true;
 except on e:exception do
 begin
  result:=false;
 end;
end;
end;

end.
