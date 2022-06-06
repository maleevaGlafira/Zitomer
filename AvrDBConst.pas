unit AvrDBConst;

interface

const
  SEL_S_BRIG =
    ' select id as ItemID,' +
    ' rtrim(name_r)||''  [''||rtrim(dolgn)||'']'' as ItemName' +
    ' from s_brig' +
    ' where (del = ''-'')' +
    ' order by name_r, dolgn';

  SEL_S_RAYON =
    ' select id as ItemID, name_r as ItemName' +
    ' from s_rayon' +
    ' where del=''-''' +
    ' order by name_r';

  SEL_S_TZAV =
    ' select id ItemID, name_r ItemName' +
    ' from s_tzav' +
    ' where del in (''-'')' +
    ' order by name_r';

  SEL_S_PLACE =
    ' select id ItemID, name_r ItemName'+
    ' from s_place'+
    ' where del=''-''' +
    ' order by name_r';

  SEL_S_SOD_NZAV =
    ' select ss.id ItemID,' +
    ' rtrim(ss.name_r)||'' (''||rtrim(st.name_r)||'',''||rtrim(sp.name_r)||'')''  ItemName' +
    ' from s_sod ss' +
    ' left join s_tzav st on st.id = ss.ftype' +
    ' left join s_place sp on sp.id = ss.place_type' +
    ' where ( ss.del in (''-'') )' +
    ' and ( ss.zayavl = 2 )' +
    ' order by ss.name_r, st.name_r, sp.name_r';


type
  TSC_S_REMONT_TYPE =
    (
      tsc_srt_TREBUETSYA = 1
     );

  TSC_S_WORK_TYPE =
    (
      tsc_swt_RASKOPKA = 1,
      tsc_swt_BLAGOUSTR = 2
    );

  TSC_S_WORK =
    (
      tsc_sw_ZASIPKA = 61,
      tsc_sw_SHEBEN = 126,
      tsc_sw_ASFALT = 127,
      tsc_sw_PLITKA = 128
    );
implementation

end.
