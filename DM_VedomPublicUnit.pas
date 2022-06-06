unit DM_VedomPublicUnit;

interface

uses
  SysUtils, Classes, Dialogs, FR_Class, frOLEExl,DateUtils,Windows,StrUtils,main,
  DB, DBTables,ServiceFuncUnit;

type
  TDSNavigate=(tdsnFirst,tdsnNext);
  TDSState=(tdssOK,tdssEOF);
  TWorksInher=(wiFirstViezd, wiWithoutFirstViezd, wiAllViezd);
  //
  TDM_VedomPublic = class(TDataModule)
    frOLEExcelExport1: TfrOLEExcelExport;
    SD_Excel: TSaveDialog;
    Qry_tmp: TQuery;
    Qry_Zadv: TQuery;
    Qry_Zadvaddr: TStringField;
    Qry_ZadvBRIG_IN: TStringField;
    Qry_ZadvBRIG_OUT: TStringField;
    Qry_ZadvDT_IN: TDateTimeField;
    Qry_ZadvDT_OUT: TDateTimeField;
    Qry_ZadvID_UL2: TStringField;
    Qry_ZadvUL_KOD: TIntegerField;
    Qry_ZadvDOP_ADR: TStringField;
    Qry_ZadvUL1: TStringField;
    Qry_Raskop: TQuery;
    Qry_RaskopBRIG_IN: TStringField;
    Qry_RaskopBRIG_OUT: TStringField;
    Qry_RaskopBRREC: TStringField;
    Qry_RaskopDT_IN: TDateTimeField;
    Qry_RaskopDT_OUT: TDateTimeField;
    Qry_RaskopDT_REC: TDateTimeField;
    Qry_Peoples: TQuery;
    Qry_Mats: TQuery;
    Qry_MatsMAT_NAME: TStringField;
    Qry_MatsED_IZM: TStringField;
    Qry_MatsKOL_MAT: TFloatField;
    Qry_PeoplesBRIG_NAME: TStringField;
    Qry_PeoplesBRIG_DOLZHN: TStringField;
    Qry_Mexan: TQuery;
    Qry_MexanNAME_R: TStringField;
    Qry_FirstViezdZadv: TQuery;
    Qry_FirstViezdZadvUL1: TStringField;
    Qry_FirstViezdZadvID_UL2: TStringField;
    Qry_FirstViezdZadvUL_KOD: TIntegerField;
    Qry_FirstViezdZadvDOP_ADR: TStringField;
    Qry_FirstViezdZadvBRIG_IN: TStringField;
    Qry_FirstViezdZadvBRIG_OUT: TStringField;
    Qry_FirstViezdZadvDT_IN: TDateTimeField;
    Qry_FirstViezdZadvDT_OUT: TDateTimeField;
    Qry_FirstViezdZadvadres: TStringField;
    Qry_FirstViezdZadvID_BROUT: TIntegerField;
    Qry_NotFirstViezdZadv: TQuery;
    StringField1: TStringField;
    StringField2: TStringField;
    IntegerField1: TIntegerField;
    StringField3: TStringField;
    StringField4: TStringField;
    StringField5: TStringField;
    DateTimeField1: TDateTimeField;
    DateTimeField2: TDateTimeField;
    StringField6: TStringField;
    IntegerField2: TIntegerField;
    Qry_FirstViezdZadvdiam: TIntegerField;
    Qry_NotFirstViezdZadvdiam: TIntegerField;
    Qry_ZadvID_DOPADRES: TIntegerField;
    Qry_FirstViezdZadvID_DOPADRES: TIntegerField;
    Qry_ZadvOBJNAME: TStringField;
    Qry_ZadvSOORUGNAME: TStringField;
    Qry_ZadvOBJOBORNAME: TStringField;
    Qry_Zadvcalc_ObjSoor: TStringField;
    Qry_ZadvDIAM: TIntegerField;
    Qry_ZadvID_UL1: TIntegerField;
    Qry_ZadvID_OBJECT: TIntegerField;
    Qry_ZadvID_BRIN: TIntegerField;
    Qry_ZadvID_BROUT: TIntegerField;
    Qry_ZadvID_OBJOBOR: TIntegerField;
    Qry_narad: TQuery;
    QryMaters: TQuery;
    QryWorks: TQuery;
    QryObor: TQuery;
    Qry_NotFirstViezdZadvid_dopadres: TIntegerField;
    procedure Qry_ZadvCalcFields(DataSet: TDataSet);
    procedure Qry_FirstViezdZadvCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    FRepName:string;
    FfrWorkRep:TfrReport;
    //function MakeDSAction(action:TDSNavigate; _SQL:string):TDSState;
  public
    FNN:integer;
    { Public declarations }
    {function SpisZadv(action:TDSNavigate; _id_zav:integer;
      var NN,addr,zakr_fio,zakr_date,zakr_time,otkr_fio,otkr_data,otkr_time:string):TDSState;}
    function FirstViezd(_id_zav:integer; var _viezd_date,_begin_date,_end_date: TDateTime; var _master:string):boolean;

    procedure CalcNomerViezd(_id_zav:integer; var _min_viezd,_max_viezd:integer;
      var _min_date,_max_date:TDateTime);
    function UpperCaseWord(_str:string; _Word:string):string; overload;
    function UpperCaseWord(_str:string; _numOfWord:integer):string; overload;
    function GenExcelFileName(_name:string):string;
    procedure ExcelClick(Sender:TObject);
    function Works(WorksInher: TWorksInher; _id_zav: integer): string;overload;
    function WorksObjObor(WorksInher: TWorksInher; _id_zav: integer): string;
    function AdresRask(_id_zav: integer): string;
    function DTFromFirstViezdToLastViezd(_id_zav:integer; var _dt_start, _dt_end:TDateTime; var _brigs:string):boolean;
    function WithoutWater(_id_zav: integer): string;
    function PlanObors(_id_zav: integer): string;
    function UsedObors(_id_zav: integer): string;
    function UtochPovrezhd(_id_zav: integer): string;
    function Maters(_id_zav: integer): string;
    function NeedWorks(_id_zav: integer): string;
    procedure RazritPeredano(_id_zav: integer; var _peredano, _dt_act, _bract,_brblag: string);
    //
    property RepName:string read FRepName write FRepName;
    property frWorkRep:TfrReport read FfrWorkRep write FfrWorkRep;

    function GetSdal(id_zav:integer):string;
   
  end;

var
  DM_VedomPublic: TDM_VedomPublic;

implementation

uses datam;

{$R *.dfm}

{function TDM_VedomPublic.MakeDSAction(action:TDSNavigate; _SQL:string):TDSState;
begin
  result:=tdssEOF;
  with Qry_tmp do
    begin
      case action of
        tdsnFirst:
          begin
            result:=tdssOK;
            FNN:=0;
            SQL.Clear;
            SQL.Add(_SQL);
            Qry_tmp.First;
            Open;
          end;
        tdsnNext:
          begin
            inc(FNN);
            Qry_tmp.Next;
            if not Qry_tmp.Eof then result:=tdssOK else dec(FNN);
          end;
      end;
    end;
end;}

{function TDM_VedomPublic.SpisZadv(action:TDSNavigate; _id_zav:integer;
  var NN,addr,zakr_fio,zakr_date,zakr_time,otkr_fio,otkr_data,otkr_time:string):TDSState;
var s:string;
begin
  result:=tdssEOF;
  result:=MakeDSAction(action,
  'select id_ul1,id_ul2,ul_kod,dop_adr, '+
  '  (select name_r from s_brig where s_brig.id=zadv.id_brin) brig_in, '+
  '  (select name_r from s_brig where s_brig.id=zadv.id_brout) brig_out, '+
  '  dt_in,dt_out '+
  'from zadv '+
  'where (id_zavin='+IntToStr(_id_zav)+') or (id_zavout='+IntToStr(_id_zav)+')');
  with Qry_Tmp do
    begin
      addr:=DM1.GenAddr(FieldByName('id_ul1').AsString,FieldByName('id_ul2').AsString,
        FieldByName('ul_kod').AsString,FieldByName('dop_adr').AsString);
      zakr_fio:=FieldByName('brig_out').AsString;
      zakr_date:=FieldByName('brig_out').AsString;
    end;
  NN:=IntToStr(FNN);
end;}

function TDM_VedomPublic.DTFromFirstViezdToLastViezd(_id_zav:integer; var _dt_start, _dt_end: TDateTime;
  var _brigs:string):boolean;
var s:string;
begin
  result:=false;
  try
    s:=''; _dt_start:=0; _dt_end:=0; _brigs:='';
    //
    MyOpenSQL(Qry_tmp,'select * from nzavjav where (delz=0) and id='+IntToStr(_id_zav));
    if Qry_tmp.eof then
      begin
        MyOpenSQL(Qry_tmp,'select * from zavjav where (delz=0) and id='+IntToStr(_id_zav));
        if not Qry_tmp.eof then s:='narad';
      end else s:='nnarad';
    //
    if s<>'' then
      begin
        result:=true;
        MyOpenSQL(Qry_tmp,' select dt_in, dt_out, s_brig.id brig_id, s_brig.name_r brig_name '+
                          ' from '+s+' '+
                          ' left join s_brig on (s_brig.id='+s+'.id_brig) '+
                          ' where (id_zav='+IntToStr(_id_zav)+') '+
                          ' order by dt_in');
        with Qry_Tmp do
          begin
            Next;
            _dt_start:=Qry_tmp.FieldByName('dt_in').AsDateTime;
            while not(EOF) do
              begin
                s:=trim(FieldByName('brig_name').AsString);
                if (FieldByName('brig_id').AsInteger>-1) and (POS(s,_brigs)=0) then
                  begin
                   if _brigs<>'' then _brigs:=_brigs+'; ';
                    _brigs:=_brigs+s;
                  end;
                Next;
              end;
            Last;
            _dt_end:=Qry_tmp.FieldByName('dt_out').AsDateTime;
            if RecordCount<2 then
              begin
                _dt_start:=0;
                _dt_end:=0;
                _brigs:='';
              end;
          end;
      end;
  finally
    Qry_Tmp.Close;
  end;
end;


function TDM_VedomPublic.FirstViezd(_id_zav:integer; var _viezd_date,_begin_date,
                        _end_date: TDateTime; var _master:string):boolean;
var s:string;
begin
  result:=false;
  try
    _viezd_date:=0; _begin_date:=0; _end_date:=0; _master:='';
    s:='';
    //
    MyOpenSQL(Qry_tmp,'select * from nzavjav where (delz=0) and id='+IntToStr(_id_zav));
    if Qry_tmp.eof then
      begin
        MyOpenSQL(Qry_tmp,'select * from zavjav where (delz=0) and id='+IntToStr(_id_zav));
        if not Qry_tmp.eof then s:='narad';
      end else s:='nnarad';
    //
    if s<>'' then
      begin
        result:=true;
        MyOpenSQL(Qry_tmp,'select n.dt_in, n.dt_out, n.dt_dep, s_brig.name_r brig_name, s_brig.dolgn '+
                          'from '+s+' n '+
                          'left join s_brig on s_brig.id=n.id_brig '+
                          'where (id_zav='+IntToStr(_id_zav)+') '+
                          'group by dt_in, dt_out, dt_dep, s_brig.name_r, s_brig.dolgn  '+
                          'having (min(nomer)=(select min(nomer) from '+s+' where (id_zav='+IntToStr(_id_zav)+')))');
        if Qry_tmp.FieldByName('dt_dep').AsDateTime>1 then
          _viezd_date:=Qry_tmp.FieldByName('dt_dep').AsDateTime;
        if Qry_tmp.FieldByName('dt_in').AsDateTime>1 then
          _begin_date:=Qry_tmp.FieldByName('dt_in').AsDateTime;
        if Qry_tmp.FieldByName('dt_out').AsDateTime>1 then
          _end_date:=Qry_tmp.FieldByName('dt_out').AsDateTime;
        _master:=_master+Qry_tmp.FieldByName('brig_name').AsString;
        if trim(Qry_tmp.FieldByName('dolgn').AsString)<>'' then
          _master:=_master+' ['+trim(Qry_tmp.FieldByName('dolgn').AsString)+']';
      end;
  finally
    Qry_Tmp.Close;
  end;
end;

procedure TDM_VedomPublic.CalcNomerViezd(_id_zav:integer; var _min_viezd,_max_viezd:integer;
  var _min_date,_max_date:TDateTime);
begin
  _min_viezd:=0; _min_date:=0; _max_viezd:=0; _max_date:=0;
  MyOpenSQL(Qry_tmp,'select * from nzavjav where (delz=0) and id='+IntToStr(_id_zav));
  if Qry_tmp.eof then
    begin
      MyOpenSQL(Qry_tmp,'select * from zavjav where (delz=0) and id='+IntToStr(_id_zav));
      //
      MyOpenSQL(Qry_tmp,'select dt_in, min(nomer) nmin '+
                        'from narad '+
                        'where (id_zav='+IntToStr(_id_zav)+') '+
                        'group by dt_in '+
                        'having (min(nomer)=(select min(nomer) from narad where (id_zav='+IntToStr(_id_zav)+')))');
      _min_viezd:=Qry_tmp.FieldByName('nmin').AsInteger;
      _min_date:=Qry_tmp.FieldByName('dt_in').AsDateTime;
      //
        MyOpenSQL(Qry_tmp,'select dt_out,max(nomer) nmax '+
                          'from narad '+
                          'where (id_zav='+IntToStr(_id_zav)+') '+
                          'group by dt_out '+
                          'having (max(nomer)=(select max(nomer) from narad where (id_zav='+IntToStr(_id_zav)+')))');
      _max_viezd:=Qry_tmp.FieldByName('nmax').AsInteger;
      _max_date:=Qry_tmp.FieldByName('dt_out').AsDateTime;
    end
      else
    begin
      MyOpenSQL(Qry_tmp,'select dt_in, min(nomer) nmin '+
                        'from nnarad '+
                        'where (id_zav='+IntToStr(_id_zav)+') '+
                        'group by dt_in '+
                        'having (min(nomer)=(select min(nomer) from nnarad where (id_zav='+IntToStr(_id_zav)+')))');
      _min_viezd:=Qry_tmp.FieldByName('nmin').AsInteger;
      _min_date:=Qry_tmp.FieldByName('dt_in').AsDateTime;
      //
        MyOpenSQL(Qry_tmp,'select dt_out,max(nomer) nmax '+
                          'from nnarad '+
                          'where (id_zav='+IntToStr(_id_zav)+') '+
                          'group by dt_out '+
                          'having (max(nomer)=(select max(nomer) from nnarad where (id_zav='+IntToStr(_id_zav)+')))');
      _max_viezd:=Qry_tmp.FieldByName('nmax').AsInteger;
      _max_date:=Qry_tmp.FieldByName('dt_out').AsDateTime;
    end;
end;

function TDM_VedomPublic.UpperCaseWord(_str:string; _Word:string):string;
{_Word - слово, который надо написать БОЛЬШИМИ буквами. Слова разделены запятыми.}
var s,s1:string;
  i,i1,n,l,d:integer;
  _find_ok:boolean;
begin
  result:=_str;
  if _Word<>'' then
    begin
      _find_ok:=false;
      l:=length(_str);
      i:=1; n:=0;
      i1:=i;
      i:=PosEx(',',_str,i1);
      while (i>0) do
      begin
        inc(n);
        if trim(AnsiUpperCase(_Word))=trim(AnsiUpperCase(Copy(_str,i1,i-i1)))
          then
            begin
              _find_ok:=true;
              break;
            end;  
        i1:=i+1;
        i:=PosEx(',',_str,i1);
      end;
      if (i=0) then
        begin
          i:=l+1;
          if trim(AnsiUpperCase(_Word))=trim(AnsiUpperCase(Copy(_str,i1,i-i1)))
            then _find_ok:=true;
        end;            
      if _find_ok then
        begin
          d:=i-i1;
          s:=AnsiUpperCase(Copy(_str,i1,d));
          Delete(_str,i1,d);
          Insert(s,_str,i1);
          result:=_str;
        end;          
    end;
end;

function TDM_VedomPublic.UpperCaseWord(_str:string; _numOfWord:integer):string;
{_numOfWord - номер слова, который надо написать БОЛЬШИМИ буквами. Нумерация с 1.
Слова разделены запятыми.}
var s,s1:string;
i,i1,n,l,d:integer;
begin
  result:=_str;
  if _numOfWord>0 then
    begin
      l:=length(_str);
      i:=1; n:=0;
      i1:=i;
      i:=PosEx(',',_str,i1);
      while (i>0) do
      begin
        inc(n);
        if n=_numOfWord then break;
        i1:=i+1;
        i:=PosEx(',',_str,i1);
      end;
      if n<>_numOfWord then i:=l+1;
      d:=i-i1;
      s:=AnsiUpperCase(Copy(_str,i1,d));
      Delete(_str,i1,d);
      Insert(s,_str,i1);
      result:=_str;
    end;
end;

function TDM_VedomPublic.GenExcelFileName(_name:string):string;
  function GenCurrTimeStamp():string;
    function Add1Zero(value:string):string;
      begin
        result:=value;
        if length(value)=1 then result:='0'+value;
      end;
  var _ndt:TDateTime;
  begin
    _ndt:=now;
    result:=IntToStr(YearOf(_ndt))+'-'+Add1Zero(IntToStr(MonthOf(_ndt)))+'-'+Add1Zero(IntToStr(DayOf(_ndt)))+
      '#'+Add1Zero(IntToStr(HourOf(_ndt)))+'-'+Add1Zero(IntToStr(MinuteOf(_ndt)))+'-'+Add1Zero(IntToStr(SecondOf(_ndt)));
  end;
var _currDir,_excelDir:string;
begin
  _currDir:=ExtractFilePath(ParamStr(0));
  _excelDir:=_currDir+'excel';
  try
    if not DirectoryExists(_excelDir) then
      begin
        if not CreateDir(_excelDir) then
          raise Exception.Create('Cannot create:  '+_excelDir);
      end;  
  except
    on E:Exception do
      begin
        MessageBox(0,PChar('Ошибка создания папки'+#13+
          'для выходного файла Excel'+#13+E.Message),'Диспетчер АВР',MB_OK or MB_ICONWARNING);
        result:='';
        exit;  
      end;
  end;
  SD_Excel.InitialDir:=_excelDir;
  SD_Excel.FileName:=_name+'--('+GenCurrTimeStamp()+')'+'.xls';
  if SD_Excel.Execute then
    result:=SD_Excel.FileName
      else result:='';
end;

procedure TDM_VedomPublic.ExcelClick(Sender:TObject);
var _fn:string;
begin
  _fn:=GenExcelFileName(FRepName);
  if _fn<>'' then
    begin
      FfrWorkRep.PrepareReport;
      FfrWorkRep.ExportTo(frOLEExcelExport1,_fn);
    end else MessageBox(0,'Не указан выходной файл Excel','Диспетчер АВР',MB_OK or MB_ICONWARNING);
end;

procedure TDM_VedomPublic.Qry_ZadvCalcFields(DataSet: TDataSet);
 var _s, _resobj : string;
begin
 _s := '';
 _resobj := '';
//  with Qry_Zadv do
    begin
  {       Qry_Zadv.FieldByName('addr').AsString:=DM1.Gen_Addr('',Qry_Zadv.FieldByName('ul1').AsString,Qry_Zadv.FieldByName('id_ul2').AsString,
            Qry_Zadv.FieldByName('ul_kod').AsString,Qry_Zadv.FieldByName('dop_adr').AsString, Qry_Zadv.FieldByName('id_dopadres').AsString);
   }
//      if (Qry_Zadv.FieldByName('id_ul1').AsInteger > 0) and ( Qry_Zadv.FieldByName('id_object').AsInteger > 0 )then  _s := '; ' else _s := '';

    _s := ', ';
//    if Qry_Zadv.FieldByName('id_object').AsInteger > 0 then
    if Qry_Zadv.FieldByName('id_objobor').AsInteger > 0 then
      _resobj := //Qry_Zadv.FieldByName('objname').AsString + _s +
                 Qry_Zadv.FieldByName('soorugname').AsString + ', '+
                 Qry_Zadv.FieldByName('objoborname').AsString
     else
       _resobj:=DM1.Gen_Addr('',Qry_Zadv.FieldByName('ul1').AsString,Qry_Zadv.FieldByName('id_ul2').AsString,
            Qry_Zadv.FieldByName('ul_kod').AsString,Qry_Zadv.FieldByName('dop_adr').AsString, Qry_Zadv.FieldByName('id_dopadres').AsString);


       Qry_Zadv.FieldByName('calc_ObjSoor').AsString := _resobj;

    end;
end;

function TDM_VedomPublic.AdresRask(_id_zav: integer): string;
  function GenAddr(_ul1,_ul2,_house,_dopadr:string):string; overload;
  begin
    result:='';
    _ul1:=trim(_ul1); _ul2:=trim(_ul2);
    _house:=trim(_house); _dopadr:=trim(_dopadr);
    result:=result+_ul1;
    if (_ul2='') then
      begin  if _house<>'' then result:=result+','+_house; end
        else if _ul2<>'' then result:=result+' / '+_ul2;
    if _dopadr<>'' then result:=result+' ('+_dopadr+')';
  end;
var
  ul1, ul2, house, dopadr: string;
begin
  Result:='';
  MyOpenSQL(Qry_tmp,
  ' select id_zavin,(select rtrim(sul.name_r)||" "||rtrim(svul.name_r) from s_ulic sul,s_vidul svul'+
  ' where  (sul.del in (''-'',''d'')) and (sul.id_vidul>-2) and'+
  ' (sul.id_vidul=svul.id) and (ras.id_ul1=sul.id)) ul1, ul_kod,'+
  ' (select rtrim(sul.name_r)||" "||rtrim(svul.name_r) from s_ulic sul,s_vidul svul'+
  ' where (sul.del in (''-'',''d'')) and (sul.id_vidul>-2) and'+
  ' (sul.id_vidul=svul.id) and (ras.id_ul2=sul.id)) ul2, id_ul2, dop_adr'+
  ' from raskop ras where ras.id_zavin='+IntToStr(_id_zav));
  if Qry_tmp.Eof then exit;
  ul1:=''; ul2:=''; house:=''; dopadr:='';
  ul1:=Qry_tmp.FieldByName('ul1').AsString;
  if Qry_tmp.FieldByName('ul_kod').AsInteger=0 then
    house:=Qry_tmp.FieldByName('id_ul2').AsString
  else ul2:=Qry_tmp.FieldByName('ul2').AsString;
  dopadr:=Qry_tmp.FieldByName('dop_adr').AsString;
  result:=GenAddr(ul1,ul2,house,dopadr);
  Qry_tmp.Close;
end;

procedure TDM_VedomPublic.Qry_FirstViezdZadvCalcFields(DataSet: TDataSet);
begin
//  with DataSet do
//    begin
      DataSet.FieldByName('adres').AsString:=DM1.Gen_Addr('',DataSet.FieldByName('ul1').AsString,DataSet.FieldByName('id_ul2').AsString,
            DataSet.FieldByName('ul_kod').AsString,DataSet.FieldByName('dop_adr').AsString, DataSet.FieldByName('id_dopadres').AsString);
//    end;
end;

function TDM_VedomPublic.WithoutWater(_id_zav: integer): string;
var
  s: string;
begin
  Result:='';

  s:= ' select ww.house, ww.comment,'+
      ' (select rtrim(sul.name_r)||" "||rtrim(svul.name_r)'+
      ' from s_ulic sul,s_vidul svul'+
      ' where  (sul.del in (''-'',''d'')) and (sul.id_vidul>-2) and'+
      ' (sul.id_vidul=svul.id) and (sul.id=ww.id_ul)) ul'+
      ' from wwater ww'+
      ' where id_zav='+IntToStr(_id_zav);

  MyOpenSQL(Qry_tmp, s);
  with Qry_tmp do
  begin
    while not Eof do
    begin
      Result:=Result+trim(FieldByName('ul').AsString)+','+FieldByName('House').AsString;
      if trim(FieldByName('comment').AsString)<>'' then
        Result:=Result+'('+trim(FieldByName('comment').AsString)+')';
      Result:=Result+'; ';
      Next;
    end;

  end; //end with

  delete(Result, length(Result)-1, 2);
end;

function TDM_VedomPublic.WorksObjObor(WorksInher: TWorksInher; _id_zav: integer): string;
var
  sql, narTb, _ForZav, _ForObj, _s: string;
  _izav, _iobj: integer;
begin
  Result:=''; narTb:='';

  if WorksInher<>wiAllViezd then
  begin
    MyOpenSQL(Qry_tmp,'select * from nzavjav where (delz=0) and id='+IntToStr(_id_zav));
    if Qry_tmp.eof then
      begin
        MyOpenSQL(Qry_tmp,'select * from zavjav where (delz=0) and id='+IntToStr(_id_zav));
        if not Qry_tmp.eof then narTb:='narad';
      end else narTb:='nnarad';
  end;

  if narTb='' then exit;

  sql:= ' select distinct sw.name_r as work_name,  so.NAME_R_AND_FIO as oborname, w.id_objobor '+
        ' from works w'+
        ' left join s_work sw on (sw.id=w.id_work) '+
        ' left join mexan so on (so.id = w.id_objobor) '+
        ' where (sw.id>-1)'+
        ' and (w.id_zav='+IntToStr(_id_zav)+')';

  case WorksInher of
    wiFirstViezd:
      sql:=sql+' and (w.id_nar=(select id'+
            ' from '+narTb+' where id_zav='+IntToStr(_id_zav)+
            ' and nomer=(select min(nomer) from '+narTb+
            ' where id_zav='+IntToStr(_id_zav)+')))'+
            ' order by 2,1 ';

    wiWithoutFirstViezd:
      sql:=sql+' and (w.id_nar in(select id'+
            ' from '+narTb+' where id_zav='+IntToStr(_id_zav)+
            ' and nomer<>(select min(nomer) from '+narTb+
            ' where id_zav='+IntToStr(_id_zav)+')))'+
            ' order by 2,1 ';

  end; // end case

  MyOpenSQL(Qry_tmp, sql);
  _ForZav := '';
  _ForObj := '';
  _izav:= 0;
  _iobj:= 0;
  _s := '';
  try

      while not Qry_tmp.Eof do
      begin
        if Qry_tmp.FieldByName('id_objobor').IsNull then
           begin
             if _izav = 0 then _ForZav := 'по наряду: '
                          else _ForZav :=  _ForZav + ', ' ;
             _ForZav := _ForZav + trim(Qry_tmp.FieldByName('work_name').AsString);
             inc(_izav);
           end
           else
           begin
             if _iobj <> Qry_tmp.FieldByName('id_objobor').AsInteger then
                begin
                   _ForObj := _ForObj + ';      ' + trim(Qry_tmp.FieldByName('oborname').AsString)+ ': ';
                   _iobj := Qry_tmp.FieldByName('id_objobor').AsInteger;
                end else
                   _ForObj := _ForObj + ', ';
              _ForObj := _ForObj + trim(Qry_tmp.FieldByName('work_name').AsString);
           end;
        Qry_tmp.Next;
      end;
      if _izav > 0 then _ForZav := _ForZav ;//+ ';      ';
      if _iobj > 0 then _ForObj := _ForObj + '; ';
      Result:= _ForZav + _ForObj;
  finally
    Qry_tmp.Close;
  end;

 // delete(Result, length(Result)-1, 2);
end;

function TDM_VedomPublic.Works(WorksInher: TWorksInher;
  _id_zav: integer): string;
var
  sql, narTb: string;
begin
  Result:=''; narTb:='';

  if WorksInher<>wiAllViezd then
  begin
    MyOpenSQL(Qry_tmp,'select * from nzavjav where (delz=0) and id='+IntToStr(_id_zav));
    if Qry_tmp.eof then
      begin
        MyOpenSQL(Qry_tmp,'select * from zavjav where (delz=0) and id='+IntToStr(_id_zav));
        if not Qry_tmp.eof then narTb:='narad';
      end else narTb:='nnarad';
  end;

  if narTb='' then exit;

  sql:= ' select distinct sw.name_r as work_name'+
        ' from works w, s_work sw'+
        ' where (sw.id=w.id_work) and (sw.id>-1)'+
        ' and (w.id_zav='+IntToStr(_id_zav)+')';

  case WorksInher of
    wiFirstViezd:
      sql:=sql+' and (w.id_nar=(select id'+
            ' from '+narTb+' where id_zav='+IntToStr(_id_zav)+
            ' and nomer=(select min(nomer) from '+narTb+
            ' where id_zav='+IntToStr(_id_zav)+')))';

    wiWithoutFirstViezd:
      sql:=sql+' and (w.id_nar in(select id'+
            ' from '+narTb+' where id_zav='+IntToStr(_id_zav)+
            ' and nomer<>(select min(nomer) from '+narTb+
            ' where id_zav='+IntToStr(_id_zav)+')))';

  end; // end case

  MyOpenSQL(Qry_tmp, sql);
  try
    with Qry_tmp do
    begin
      while not Eof do
      begin
        Result:=Result+trim(FieldByName('work_name').AsString)+'; ';
        Next;
      end;
    end; //end with
  finally
    Qry_tmp.Close;
  end;

  delete(Result, length(Result)-1, 2);
end;

function TDM_VedomPublic.PlanObors(_id_zav: integer): string;
begin
  Result:='';

  MyOpenSQL(Qry_tmp,' select distinct so.NAME_R_AND_FIO name_r'+
                    ' from planobors po'+
                    ' left join mexan so on so.id=po.id_obor'+
                    ' where po.id_zav='+IntToStr(_id_zav));
  try
    Qry_tmp.First;
    while not Qry_tmp.Eof do
    begin
      Result:=Result+trim(Qry_tmp.FieldByName('name_r').AsString)+'; ';
      Qry_tmp.Next;
    end;
  finally
    Qry_tmp.Close;
  end;

  Delete(Result, length(Result)-1,2);
end;

function TDM_VedomPublic.UtochPovrezhd(_id_zav: integer): string;
var
  narTb: string;
begin
  narTb:='';

  MyOpenSQL(Qry_tmp,'select * from nzavjav where (delz=0) and id='+IntToStr(_id_zav));
  if Qry_tmp.eof then
  begin
    MyOpenSQL(Qry_tmp,'select * from zavjav where (delz=0) and id='+IntToStr(_id_zav));
    if not Qry_tmp.eof then narTb:='narad';
  end else narTb:='nnarad';

  if narTb='' then exit;

  MyOpenSQL(Qry_tmp,' select dop_inf'+
                    ' from '+narTb+
                    ' where'+
                    ' id_zav='+IntToStr(_id_zav)+' and'+
                    ' nomer=(select min(nomer) from '+narTb+
                    ' where id_zav='+IntToStr(_id_zav)+')');
  try
    Result:=trim(Qry_tmp.FieldByName('dop_inf').AsString);
  finally
    Qry_tmp.Close;
  end;
end;


function TDM_VedomPublic.UsedObors(_id_zav: integer): string;
begin
  Result:='';

  MyOpenSQL(Qry_tmp,' select distinct so.name_r'+
                    ' from obors o'+
                    ' left join s_obor so on so.id=o.id_obor'+
                    ' where o.id_zav='+IntToStr(_id_zav));
  try
    Qry_tmp.First;
    while not Qry_tmp.Eof do
    begin
      Result:=Result+trim(Qry_tmp.FieldByName('name_r').AsString)+'; ';
      Qry_tmp.Next;
    end;
  finally
    Qry_tmp.Close;
  end;

  Delete(Result, length(Result)-1,2);
end;

function TDM_VedomPublic.Maters(_id_zav: integer): string;
begin
  Result:='';

  MyOpenSQL(Qry_tmp,' select sm.name_r, sm.ed_izm, sum(m.kol_mat) kol_mat'+
                    ' from maters m, s_mat sm'+
                    ' where (m.id_mat=sm.id)'+
                    ' and (sm.id>-1)'+
                    ' and (m.id_zav='+IntToStr(_id_zav)+')'+
                    ' group by sm.name_r, sm.ed_izm');
  try
    while not Qry_tmp.Eof do
    begin
      Result:=Result+trim(Qry_tmp.FieldByName('name_r').AsString)+','+
              trim(Qry_tmp.FieldByName('ed_izm').AsString)+
              '('+FormatFloat('0.##', Qry_tmp.FieldByName('kol_mat').AsFloat)+'); ';
      Qry_tmp.Next;
    end;
  finally
    Qry_tmp.Close;
  end;

  Delete(Result, length(Result)-1, 2);
end;

function TDM_VedomPublic.NeedWorks(_id_zav: integer): string;
begin
  Result:='';

  MyOpenSQL(Qry_tmp,Format(' select needworks'+
      ' from raskop'+
      ' where ((id_zavin=%d) or (id_zavout=%d))'+
      ' and (needworks is not null)',[_id_zav, _id_zav]));
  try
    while not Qry_tmp.Eof do
    begin
      Result:=Result+trim(Qry_tmp.FieldByName('NeedWorks').AsString)+'; ';
      Qry_tmp.Next;
    end;
  finally
    Qry_tmp.Close;
  end;

  Delete(Result, length(Result)-1, 2);
end;

procedure TDM_VedomPublic.RazritPeredano(_id_zav: integer; var _peredano, _dt_act, _bract,_brblag: string);
begin
  _peredano:=''; _dt_act:=''; _bract:=''; _brblag:='';

  MyOpenSQL(Qry_tmp,Format(' select r.peredano, r.dt_act, r.id_bract,r.id_brblag ,'+
            ' (select name_r from s_brig where id=r.id_bract) bract,'+
            '(select name_r from s_brig where id=r.id_brblag) brblag '+
            ' from raskop r'+
            ' where ((r.id_zavin=%d) or (r.id_zavout=%d))'+
            ' and r.dt_act is not null'+
            ' order by dt_in', [_id_zav, _id_zav]));

  try
    Qry_tmp.First;
    if not Qry_tmp.Eof then
    begin
      _peredano:=Qry_tmp.FieldByName('peredano').AsString;
      _dt_act:=Qry_tmp.FieldByName('dt_act').AsString;
      if Qry_tmp.FieldByName('id_brblag').AsInteger<>-1 then
        _brblag:=Qry_tmp.FieldByName('brblag').AsString;
      if Qry_tmp.FieldByName('id_bract').AsInteger<>-1 then
        _bract:=Qry_tmp.FieldByName('bract').AsString;
    end;
  finally
    Qry_tmp.Close;
  end;
end;

function  TDM_VedomPublic.GetSdal(id_zav:integer):string;
begin
 if Qry_tmp.Active then
  Qry_tmp.Close;
 Qry_tmp.Open;
  Qry_tmp.SQL.Text:=Format('select rtrim(sb.name_r)||'' [''||rtrim(sb.dolgn)||'']'' res from zavjav z left join s_brig sb on sb.id=z.ID_DISOUT '+
  '    where z.id=%d'+
  ' union '+
  '  select rtrim(sb.name_r)||'' [''||rtrim(sb.dolgn)||'']'' from nzavjav z left join s_brig sb on sb.id=z.ID_DISOUT '+
  '   where z.id=%d ',[id_zav,id_zav]);
  Qry_tmp.Open;
  Qry_tmp.First;
  if not Qry_tmp.IsEmpty then
   Result:=Qry_tmp.fieldbyname('res').AsString
  else  Result:='';
  Qry_tmp.Close;

end;


end.
