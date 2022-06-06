[Main]
NmNomer=z.nomer
DtMin=dt_in
DtMax=dt_in
Dt_DB=z
Spis=tzav;ulica;revs
RunSQL=select z.id,z.id_ul1,z.id_ul2,z.kod_ul,z.dop_adr,z.nomer pole0,z.fyear pole1,z.dt_in pole2 from zavjav z where (delz=0) and id>0 
RunTit=Номер;Год;Дат.пост.;Адрес
RunAdres=3
isNomer=1
isData=1
Name=Проба
