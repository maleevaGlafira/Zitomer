[Main]
NmNomer=z.nomer
DtMin=dt_in
DtMax=dt_in
Dt_DB=z
Spis=diam;dop_inf;mater;n_dom;revs;soder;tzav;ulica;place;work
RunSQL=select z.id,z.id_ul1,z.id_ul2,z.kod_ul,z.dop_adr,a.name_r pole0,z.nomer pole1,z.fyear pole2,z.dt_in pole4 from nzavjav z, s_attach a where (delz=0) and id>0 and a.id=z.id_attach 
RunTit=Принадл;Номер;Год;Дат.пост.;Адрес
RunAdres=3
isNomer=1
isData=1
Name=Произвольный поиск по незакрытым заявкам
