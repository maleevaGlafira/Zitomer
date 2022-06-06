unit SvodVed3DModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SvodVed2DModule, FR_DSet, FR_DBSet, DB, RxMemDS, IBDatabase,
  IBCustomDataSet, FR_Class;

type
  Tdm_SvodVed3 = class(Tdm_SvodVed2)
  private
    { Private declarations }
       procedure InitSEL_ZAV; override;
  public
    { Public declarations }
  end;

var
  dm_SvodVed3: Tdm_SvodVed3;

implementation

{$R *.dfm}

 var
  ARR_COM_FIELD: array[0..8] of string=
    ('id','nomer','dt_in','id_attach','id_revs','revs','attach','object','wwater_list');

procedure Tdm_SvodVed3.InitSEL_ZAV;
var
  revs_cond: string;
begin
 if F_RevsID<>'' then
    revs_cond:=' and z.id_revs in'+F_RevsID
 else
    revs_cond:='';

 F_SEL_ZAV:=
    ' select z.id, z.nomer, z.dt_in, z.dt_out vipol, z.id_attach, z.id_revs,' +
    ' sr.name_r revs, att.name_r attach,' +
    ' (select adres from get_zav_adres(z.id)) adres,' +
    ' (select obor_list from get_objobor_list( z.id ) ) sod,' +
    ' (select wwater_list from get_wwater_list( z.id ) ) wwater_list' +
    ' from %s z'+
    ' left join s_revs sr on ( sr.id = z.id_revs )' +
    ' left join s_attach att on ( att.id = z.id_attach )' +
    ' left join s_sod ss on ( ss.id = z.id_sod )' +
    ' left join s_tzav st on (st.id = ss.ftype)' +
    ' left join s_place sp on (sp.id = ss.place_type)' +
    ' left join s_owner so on ( so.id = z.id_alien )' +
    ' where (delz=0) and (z.id_attach = %d) and (so.owner_type in( %s ) ) and  %s'+
    revs_cond +
    ' order by sr.name_r, z.dt_in';
end;

end.
