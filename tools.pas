unit Tools;
interface
uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Dialogs, IniFiles, DBFilter,RxDBComb,BDe,variants,
  StdCtrls, Forms, DBCtrls, DB, DBGrids, DBTables, Grids, ExtCtrls, Buttons,
  Menus;

const cur_K=10000;
type
  TCRwkt=(crTag,crNoZeroTag,crFull,crMasterfld,crTbev,Crfldev,Crind,CrDatabase,CrFielddefs,CrAllfld,crCalcFld,crLookFld);
  {обр on...,fieldchange,set_old_ind,set_old_database,все поля,только fielddefs,+calc,}
  {   lookup      по умолчанию  flddefs}
  tcrwktset= set of TCRwkt;
  v_mode=(one_rec,all_rec,no_prompt);
  mov_mode=set of v_mode;
function ed_sts(dset:tdataset):boolean;{тест редактирование}
function extractfname(fname:string):string;
function extractfext(fname:string):string;
function  cmpstru(src_tab,dest_tab:ttable):boolean;
function  create_tab(base_tab:ttable;dbname,tabname:string):ttable;
function  create_wkt(base_t:ttable;Aowner:TComponent):ttable;
function calcNds(sum:extended):double ;
function sumAddNds(sum:extended):double ;
function sumSubNds(sum:extended):double ;

{$IFDEF WIN32}
function loadAniCurs(AniPath:string;numc:integer):boolean;
procedure curs_wait; //курсор-ожидание
procedure curs_norm;
procedure AniCurs_wait ; //курсор-ожидание анимированный

function DelphiLoaded: Boolean;
procedure loaditems(ls:tstrings;ds:Tdataset;fldnames:string);
procedure cascadeDel(MTab:ttable);
procedure form_del_sql(BLst,reslst:Tstringlist);
procedure   getDependTables(Table: TTable;RIntList: TStringList);
procedure add_rec(src_mast,src_det:ttable;dir_d:string;mode:mov_mode);
procedure sort_tab(wk_tab:ttable;sort_fld_ind:integer);
procedure prep_flt(flt:trxdbfilter;enddate:string); {удаление из фильтра lookup field}
procedure fix_record(wk_tab:ttable); {зафиксировать тек запись в тек индексе}
procedure copy_wktF(base_t,result_t:tdbdataset;mode:tcrWKtset);
function create_wktF(base_t:ttable;Aowner:TComponent;mode:tcrWKtset):ttable;
{создать копию курсора-TTABLE с полным копированием полей  &events}
{  TCRwkt=(crFull,crMasterfld,crTbev,Crfldev,Crind,CrDatabase,crfldefs,crCalcFld,crLookFld);}

function  cr_grid(pan:twincontrol;wk_tab:ttable;
          const dis_tags: variant):tdbgrid;forward;
procedure put_rec(wk_tab:ttable;var buf:variant);{перенести буфер в БД}
procedure get_rec(wk_tab:ttable;var buf:variant);{перенести запись в буфер}
procedure def_grid(wk_grid:tdbgrid;wk_tab:tDataset;const dis_tags:variant);forward;
function GetFldVal(dataset:tdataset;fldname:string):variant;
procedure SetFldVal(dataset:tdataset;fldname:string;value:variant);
function currval(value:variant):currency;
function addCurFld(dataset:tdataset;fldname:string;value:currency):currency;
procedure SetFldCur(dataset:tdataset;fldname:string;value:currency);
function GetFldCur(dataset:tdataset;fldnameS:string):currency;
procedure _CopyStrProp(src,dest:Tcontrol;namProp:string);
procedure _CopyOrdProp(src,dest:Tcontrol;namProp:string);
procedure _setOrdProp(dest:Tcontrol;namProp:string;prop:longint);
function _GetOrdProp(dest:Tcontrol;namProp:string):longint;
function _GetStrProp(src:Tcontrol;namProp:string):string;
procedure _SetStrProp(dest:Tcontrol;namProp,val:string);
procedure _LstControls(cnt:tWinControl;lst:tstringlist);
function _copyFld(bas_f:tfield;dest_set:tdataset;newname:string):tfield;
{$ELSE}
function addCurFld(dataset:tdataset;fldname:string;value:double):double;
procedure SetFldCur(dataset:tdataset;fldname:string;value:double);
function GetFldCur(dataset:tdataset;fldnameS:string):double;
function fl_to_cur(val:double):double;
{$ENDIF}

function copy_m(mast_src,mast_dest:ttable;fldnames:string;const fldvalues: array of const):integer;
procedure copyrec(src_tab,dest_tab:tdataset);
function copy_md(det_src,det_dest:ttable;fldnames:string;const fldvalues: array of const):integer;

function  CalcMastNextCode(DataSet: TDataSet):integer;
function  calcNextnum(DataSet: TDataSet):string;
function  calcnextAi(DataSet: TDataSet):integer;
function  CalcMastminCode(DataSet: TDataSet):integer;
function  copyDBfiles (BdS, BdD : TFileName) : integer;
function  DelDBfiles (BdS : TFileName) : integer;
function  MoveDBfiles (BdS, BdD : TFileName) : integer;
{$IFNDEF WIN32}
 function lookfld(keyfld:string;lookset:tdataset;lookkey,lookresult:string):string;
{$ENDIF}
function roundcur(num:extended):double;
{////////////////////////////////////////////}

{$IFDEF WIN32}
type
 Tmemlist=class
    inc_step:integer;
    rec_dim:integer;
  public
    max_num:integer;
    last_used:longint;
    Vrec:variant;
    function add_item(const addValues: array of variant):integer;
    function next_item(prev_item:integer):integer;
    constructor Create(dim_it,step_inc:integer);
    { step_inc  по скольку элементов добавлять при расширении и создании}
    { dim_it число компонентов в элементе}
    destructor Destroy;override;
    Procedure clear;
    Procedure del_item( del_item:integer);  {пометить удаленным}
    function  findVal(prevItem:integer;const FindValues: array of variant):integer;
  end;
{$ENDIF}

implementation
uses   RXDBCtrl,strtool,
{$IFNDEF WIN32}
  DBUtils,
  {$ELSE}
   dblook,typinfo,RxQuery,
  {$ENDIF}
 FileUtil;

const
  OneMoney  = 'грв.';
  TwoMoney  = 'грв.';
  FiveMoney = 'грв.';
{////////////////////////////////}
{//////////////////////////}
var wk_curs:tcursor;
    ani_curs:integer;
function create_tab(base_tab:ttable;dbname,tabname:string):ttable;
var newtab:ttable; {создать копию таблицы в базе}

begin
   newtab:=ttable.create(nil);
   base_tab.fielddefs.update;
   base_tab.indexdefs.update;
   with newtab do
begin
  Active := False;
  DatabaseName := dbname;
  TableName := tabname;
  TableType := base_tab.TableType;
   FieldDefs.clear;
   FieldDefs.assign(base_tab.fielddefs);
   IndexDefs.clear;
   IndexDefs.assign(base_tab.IndexDefs);
  CreateTable;
end;
 result:=newtab;
end;

function ATO(const s: string): string;
var
  p,p1: array[0..255] of char;
begin
  StrPCopy(p, s);
  AnsiToOem(p, p1);
  Result := StrPas(p1);
end;

function OTA(const s: string): string;
var
  p,p1: array[0..255] of char;
begin
  StrPCopy(p, s);
  OemToAnsi(p, p1);
  Result := StrPas(p1);
end;

function strAdj( s : string; n : integer ) : string;
  var cnt : integer; left : boolean;
  i: integer;
begin
  if n > 255 then n := 255;
  if n < -255 then n := -255;
  if length( s ) > abs( n ) then begin
    strAdj := copy( s, 1, abs( n ) ); exit;
  end;
  left := n < 0; { дополнение пробелами слева }
  n := abs( n ); cnt := n-Length(s)+1;
  if left and ((cnt-1) > 0) then
    for i:= 1 to cnt-1 do s:= ' '+s;
  if (not left) and ( length(s) < n ) then
    for i := length(s)+1 to n do s := s + ' ';
  strAdj := s;
end;

{$IFDEF WIN32}
 ///////////////////////


 procedure  fix_record(wk_tab:ttable); {зафиксировать тек запись в тек индексе}
 var mkey:array [0..2] of variant;
     i:integer;
 begin
  with wk_tab do begin
   for i:=0 to indexfieldcount-1  do
     mkey[i]:=indexfields[i].value;
  setrangestart;
   for i:=0 to indexfieldcount-1  do
     indexfields[i].value:=mkey[i];
  setrangeend;
   for i:=0 to indexfieldcount-1  do
     indexfields[i].value:=mkey[i];
  ApplyRange;
  end;
 end;

function cr_grid(pan:twincontrol;wk_tab:ttable;const dis_tags:variant):tdbgrid;
begin
   Result:=tdbgrid.create(pan);
   result.parent:=pan;
   if (pan is tpanel) then
     result.font:=(pan as tpanel).font;
   def_grid(result,wk_tab,dis_tags);
end;

procedure prep_flt(flt:trxdbfilter;enddate:string); {удаление из фильтра lookup field}
var ib,ie,i:integer;s,s1:string;wk_fld:tfield;end_dat:boolean;
 begin
  if enddate='  .  .  ' then end_dat:=false else end_dat:=true;
  with flt.filter  do begin
    i:=0;
    while i< count do begin
     s:=strings[i];
     ib:=pos('[',s) ; ie:=pos(']',s) ;
     s1:=copy(s,ib+1,ie-ib-1);
     wk_fld:=flt.datasource.dataset.findfield(s1);
     if not assigned(wk_fld) or not wk_fld.lookup  then begin;
        if  end_dat and (upper(s1)='ДАТА') then begin
          ib:= pos('=',s) ;
          system.insert('>',s,ib);
         strings[i]:=s;
        end;
    {    inc(i);}
      end
     else  strings[i]:='';                        {delete(i);}
           inc(i);

    end;
      if end_dat then insert (0,'([дата]<='''+ enddate +''') and ');

      if count=0 then exit;
      s:=strings[count-1];
      ib:=pos(')',s) ;
      system.delete(s,ib+1,100);
      strings[count-1]:=s;
   end;
  end;
{//////////////////////////////////////}
    constructor Tmemlist.Create(dim_it,step_inc:integer);
      begin
         last_used:=0;
         inc_step:=step_inc;
         rec_dim:=dim_it;
         vrec:=varArrayCreate([1,inc_step,0,rec_dim ],varVariant);
         max_num:=inc_step;
      end;

    destructor Tmemlist.Destroy;
     begin
        clear;
     end;
Procedure Tmemlist.clear;
     begin
          max_num:=inc_step;
          last_used:=0;
          vrec:=unassigned;
          vrec:=varArrayCreate([1,inc_step,0,rec_dim ],varVariant);
     end;
        {------------------}
function Tmemlist.add_item(const addValues: array of variant):integer;
     label add_it;
         var  free_it,ii,jj:word;
         tmp_ar:variant;
      begin
          for ii := 1 to max_num do
          begin
            if VarIsEmpty(vrec[ii,0]) then  {пустая ячейка}
             begin
               free_it:=ii;
               goto add_it;
             end;
          end; {for}
          {не нашли пустой ячейки  увеличиваем массив}
           tmp_ar:=varArrayCreate([1,max_num+inc_step,0,rec_dim ],varVariant);
            for ii := 1 to max_num do
              for jj:=0 to rec_dim do
                 tmp_ar[ii,jj]:= vrec[ii,jj];
              vrec:=tmp_ar; {вернем назад}
               free_it:= max_num+1;
               max_num:=max_num++inc_step;
     add_it:  if free_it > last_used then   last_used:=free_it;
              vrec[free_it,0]:=1;  {помечаем занятый}
              for  ii:=1 to rec_dim do
                 if (high (addValues)>=ii-1)
                     and not (VarIsNull(addValues[ii-1]))
                  then
                   vrec[free_it,ii]:=addValues[ii-1]
                   else
                    vrec[free_it,ii]:=unassigned;
              result:=free_it;
      end;
        {------------------}
    Procedure Tmemlist.del_item( del_item:integer);
   var  ii:word;
    begin
        if (del_item>last_used)or(del_item<1) then exit;  {вне границ}
          for ii := 0 to rec_dim do
             vrec[del_item,ii]:=unassigned;
           if del_item=last_used then
             for ii:=del_item-1 downto 1 do
               if not varisempty(vrec[ii,0]) then
                begin
                 last_used:=ii;
                 break;
                end;
    end;
    {////////////////////////////}
    function Tmemlist.next_item(prev_item:integer):integer;
     var ii:integer;
     begin
        result:=0;
        for  ii:=prev_item+1 to last_used do
               if not varisempty(vrec[ii,0]) then
                begin
                 result:=ii;
                 exit;
                end;
     end;
   {=======================}

    function  Tmemlist.findVal(prevItem:integer;const FindValues:
                           array of variant):integer;
   var  ii,jj,cur_item:integer;
   label next_it;
   begin
          result:=0;
          for ii := previtem+1 to last_used do
          begin
            if varisempty(vrec[ii,0]) then continue;
            cur_item:=high(findvalues)+1;
            for jj:=1 to cur_item do begin
             if not VarIsNull(findvalues[jj-1]) and
                (  VarIsempty( vrec[ii,jj]) or
                  (findvalues[jj-1] <> vrec[ii,jj])) then goto next_it;
             end;
              result:=ii;
              exit;
       next_it:
         end; {for}
    end;
 {//////////// tmemitem /////////////////}
procedure def_grid(wk_grid:tdbgrid;wk_tab:Tdataset;const dis_tags:variant);
 type
    Tcnt_l=record { список компонентов}
      lbl_c,ed_c:tcontrol;
      tag_l:integer;
    end;
   ar=array [0..1000] of Tcnt_l;
   p_ar=^ar;
  ///////////////
 var
 jj,ii,ll,max_tag:integer;wk_lb,wk_ed:tcontrol;
 tmpField:tfield;wk_col:tcolumn;c_cnt:tcontrol;
 wk_act:boolean; cnt_lst:tstringlist;
  lst_comp:p_ar; wk_comp:Tcnt_l;
  l_swap:boolean;
  Str_bas:string;
  PropInfo: PPropInfo;

  ////////////////
  label m1;
begin
   tmpfield:=nil;
//   wk_grid.readonly:=true;
   wk_grid.align:=alclient;
   wk_grid.columns.clear;
   wk_grid.visible:=false;
   with wk_tab do
   begin
      wk_act:=active;
      if active then close;
   end;
   cnt_lst:=tstringlist.create;
  _LstControls(wk_grid.parent,cnt_lst);
   getmem(lst_comp,sizeof(Tcnt_l)*cnt_lst.Count);
    max_tag:=0;
   for ii:=0 to  cnt_lst.Count-1   do begin
     c_cnt:=cnt_lst.objects[ii] as tcontrol;
     with  lst_comp[max_tag]  do
     if  c_cnt.tag<0  then {cписок controls  с tag<0}
      begin
         tag_l:=-c_cnt.tag; {изменим знак}
         lbl_c:=c_cnt;
         ed_c:=nil;
         inc( max_tag);
      end
   end;
   {сортировка}
    l_swap:=true;
    while l_swap do
    begin
      l_swap:=false;
      for ii :=0  to max_tag-2 do
       with  lst_comp[ii] do
      begin
        if tag_l>lst_comp[ii+1].tag_l then
          begin
            wk_comp:=lst_comp[ii];
            lst_comp[ii]:=lst_comp[ii+1];
            lst_comp[ii+1]:=wk_comp;
            l_swap:=true;
          end;
      end;
    end;
   for ii:=0 to  max_tag-1   do
    for jj :=0  to cnt_lst.Count-1 do
       with  wk_grid.parent,lst_comp[ii] do {cписок controls  с tag>0}
        if   (tag_l=(cnt_lst.objects[jj] as tcontrol).tag)  then
            ed_c:=(cnt_lst.objects[jj] as tcontrol);

   for ii:=0 to  max_tag-1   do begin
    with  lst_comp[ii] do  {cписок controls  с tag>0}
        begin
           wk_ed:= ed_c;
           wk_lb:=lbl_c;
        end;
    If ( wk_ed=nil)or( wk_lb=nil) Then goto m1;
    if (vartype(dis_tags) =vararray ) then
    for  ll:=0 to VarArrayHighBound(dis_tags,1) do  {выбрасываем запр tags}
           if dis_tags[ll]=ii then goto m1;
    wk_col:=wk_grid.columns.add;
    If (wk_ed is tdblookupMcombo) Then Begin
      {проверяем наличие поля в tab}
    tmpField:=wk_tab.findfield(wk_ed.name);
    If (not assigned(tmpField) )
     Then if   not( loBoxListMode in (wk_ed as tdblookupMcombo).options)
     then
       Begin {создаем поле}
        tmpField := TStringfield.Create(wk_tab);
        tmpField.FieldName :=wk_ed.name;
        tmpField.DataSet := wk_tab;
        tmpField.Lookup:= True;
        tmpField.LookupDataSet :=(wk_ed as tdblookupMcombo ).lookuptable;
        tmpField.LookupKeyFields :=(wk_ed as tdblookupMcombo ).LookupField;
        tmpField.KeyFields :=(wk_ed as tdblookupMcombo ).dataField;
        tmpField.LookupResultField :=(wk_ed as tdblookupMcombo ).LookupDisplay;
       End
      else {loBoxListMode}
         tmpfield:=wk_tab.findfield((wk_ed as tdblookupMcombo).datafield );
     end  { if lookupmcombo}
     else  begin
        PropInfo := TypInfo.GetPropInfo(wk_ed.ClassInfo, 'datafield');
        if (PropInfo = nil) or (PropInfo^.PropType^.Kind <> tkLstring) then  continue;
        str_bas:= {TObject}(GetsTRProp(wk_ed, PropInfo));// as TDataSource;
        tmpfield:=wk_tab.findfield(str_bas );
        if tmpfield=nil then continue;
     end;

      wk_col.fieldname:=tmpfield.fieldname;
      wk_col.title.caption:=(wk_lb as tlabel).caption;
       if strcmpi(wk_ed.name,'autocb')=0 then begin
          wk_col.title.caption:='Ав';
          wk_col.width:=20;
       end;
       if strcmpi(wk_ed.name,'Printedbox')=0 then begin
          wk_col.title.caption:='Пч';
          wk_col.width:=20;
       end;
       if strcmpi(wk_ed.name,'DeTag')=0 then begin
          wk_col.title.caption:='Прм';
          wk_col.width:=30;
       end;
  m1:
    end;
    wk_tab.active:=wk_act;
    cnt_lst.free;
 end;
{///////////////////}
{//////////////////////////////////////////////}
procedure put_rec(wk_tab:ttable;var buf:variant);{перенести буфер в БД}
var j:integer;
   begin
      with wk_tab do
      begin
      edit;
         for j := 0 to fieldcount -1 do
         begin
            if(wk_tab.fields[j]<> nil)
              and (not  wk_tab.fields[j].lookup)
              and (not  wk_tab.fields[j].calculated)
              and not ( wk_tab.fields[j].DataType =  ftAutoInc )
             then
              wk_tab.fields[j].value:=buf[j];
   if wk_tab.state<>dsedit then
         end; {for}
         post;
      end;
   end;
{//////////////////////////////////////}
procedure get_rec(wk_tab:ttable;var buf:variant);{перенести запись в буфер}
var j:integer;
   begin
      with wk_tab do
      begin
         for j := 0 to fieldcount -1 do
         begin
            buf[j]:= wk_tab.fields[j].value;
        if vartype(wk_tab.fields[j].value)=varstring
          then   begin
            buf[j]:= wk_tab.fields[j].asstring;
         end;
         end; {for}
      end;
   end;
{//////////////////////////////////////}
procedure sort_tab(wk_tab:ttable;sort_fld_ind:integer);
 var buf1,buf2,varfld:variant;fl_sort,f_str:boolean;tmp_tab:ttable;
 label m_ex;
 begin
{      mode:=[crTag,crTbev,Crfldev,Crind,CrDatabase,crCalcFld,crLookFld,crMasterfld];}

 tmp_tab:=  create_wktF(wk_tab,nil,[crLookFld,CRIND,CrDatabase,crMasterfld]);
   tmp_tab.mastersource:=wk_tab.mastersource;
   with tmp_tab do
   begin
    open;
    buf1:=varArrayCreate([0,fieldcount-1],varVariant);
    buf2:=varArrayCreate([0,fieldcount-1],varVariant);
    while true do
      begin
           fl_sort:=true;
           first;
           while not eof do
           begin
             get_rec(tmp_tab,buf1);
             next;
             varfld:= buf1[sort_fld_ind];
             if (vartype(varfld)=varString )or (vartype(varfld)=varoleStr ) then
              f_str:=true else f_str:=false;
             if  not eof and(
              ( f_str )
               and
                ( strcmpi(varfld,fields[sort_fld_ind].asstring)>0)
               )
              or( not f_str
               and
                ( varfld > fields[sort_fld_ind].value)
               )
             then begin
               get_rec(tmp_tab,buf2);
               put_rec(tmp_tab,buf1);
               prior;
               put_rec(tmp_tab,buf2);
               next;
               fl_sort:=false;
             end;
           end;
          if fl_sort then goto m_ex;
      end;
   end;
  m_ex:
     tmp_tab.free;
     wk_tab.refresh;
 end;
 procedure copy_wktF(base_t,result_t:tdbdataset;mode:tcrWKtset);
 {сделать из курсора полную копию базового}
  var i:integer;{wk_f,}bas_f:tfield;
  begin
      if Crfull in mode then
      mode:=[crTag,crTbev,Crfldev,Crind,CrDatabase,crCalcFld,crLookFld,crMasterfld];
      Result_T.close;
    with base_t do begin
      result_t.fielddefs.clear;
      if CrDatabase in mode then
        Result_T.databasename:=databasename;
      if (base_t is ttable) and (Result_T is ttable) then
           (Result_T as ttable).tablename:=(base_t as ttable).tablename;
      if Crind in mode then
        if (base_t is ttable) and (Result_T is ttable) then
            (Result_T as ttable).indexname:=(base_t as ttable).indexname;
      if crMasterfld in mode then
        if (base_t is ttable) and (Result_T is ttable) then
          (Result_T as ttable).masterfields:=(base_t as ttable).masterfields;
         if (fieldcount=0)or(crfieldDefs in mode)  then begin  {на основе  fielddefs  - из физ таблицы}
            if not active then fielddefs.update;
            Result_T.fielddefs.assign(fielddefs);
            for I := 0 to Result_T.FieldDefs.Count - 1 do
            if Result_T.FieldDefs[I].DataType <> ftUnknown then
                Result_T.FieldDefs[I].CreateField(Result_T);
        end
        else begin    { на основе полей проекта}
           for i := 0 to fieldcount-1 do
           begin
               bas_f:= fields[i];
               if ((bas_f.fieldkind = fkLookup) and not (crLookFld in mode) )
                or ((bas_f.fieldkind = fkCalculated) and not (crCalcFld in mode))
//                or  ((bas_f.tag=0) and  (crNoZeroTag in mode))
               then continue;
               _copyFld(bas_f,result_t,bas_f.fieldname);
           end;
        end;
      if CrFldEv in mode then
      for I := 0 to Result_T.FieldCount - 1 do
        Result_T.fields[i].onchange:= fieldbyname(Result_T.fields[i].fieldname).onchange;

      if CrTbEv in mode then begin
        Result_T.beforepost:=beforepost;
        Result_T.afterpost:=afterpost;
        Result_T.afterdelete:=afterdelete;
        Result_T.beforedelete:=beforedelete;
        Result_T.onnewrecord:=onnewrecord;
        Result_T.oncalcfields:=oncalcfields;
        Result_T.AutoCalcFields:=AutoCalcFields;
     end;
      if crTag in mode then
              Result_T.tag:=tag;
    end;
  end;


function GetFldVal(dataset:tdataset;fldname:string):variant;
var wk_f:tfield;
begin
  wk_f:=dataset.findfield(fldname);
  if assigned(wk_f)then result:=wk_f.value
  else  result:=null;
end;
procedure SetFldVal(dataset:tdataset;fldname:string;value:variant);
var wk_f:tfield;
begin
  wk_f:=dataset.findfield(fldname);
  if assigned(wk_f) and wk_f.canmodify then begin
    if not ed_sts(dataset) then dataset.edit;
    wk_f.value:=value;
  end;
end;
function currval(value:variant):currency;
 begin {вернуть поле как   currency}
   if value=null then result:=0
   else result:=currency(value);
 end;
procedure add_rec(src_mast,src_det:ttable;dir_d:string;mode:mov_mode);
label m_exit;
var res:word; dst_mast,dst_det:ttable;next_dest,add_code:integer;
begin
   dst_det:=nil;
   if not direxists(dir_d ) then  begin
     showmessage('Рез.каталог не найден:'+dir_d);
     exit;
   end;
    with  src_mast do
    if (recordcount=0) then exit; {нечего копировать}

   if not fileexists(normaldir(dir_d)+src_mast.tablename) then begin
     create_tab(src_mast,dir_d,src_mast.tablename);
     if src_det<>nil then
     create_tab(src_det,dir_d,src_det.tablename);
   end;
     dst_mast:=ttable.create(nil);
     dst_mast.databasename:=dir_d;
     dst_mast.tablename:=src_mast.tablename;
     if src_det<>nil then  begin
     dst_det:=ttable.create(nil);
     dst_det.databasename:=dir_d;
     dst_det.tablename:=src_det.tablename;
     end;
    dst_mast.open;
    if dst_det<>nil then dst_det.open;
   if  (dst_mast.recordcount>0) and not(no_prompt in mode) then begin
       res:=   MessageDlg('Результирующая БД не пустая.Добавлять(Yes).Предв.очистить(No).Отменить(Cancel)',
               mtWarning,[mbYes, mbNo,mbCancel],0);
        case res of
               mrNo: begin
                     dst_mast.emptytable;
                     if src_det<>nil then  dst_det.emptytable;
                     end;
               mrCancel: goto m_exit;
        end;
     end;
    next_dest:=CalcMastNextCode(dst_mast);
    if all_rec  in mode then
       add_code:= next_dest - CalcMastMinCode(src_mast)
    else
       add_code:= next_dest - src_mast.fieldbyname('cod').asinteger;
    if all_rec in mode then src_mast.first;
    while  not src_mast.eof do begin
       dst_mast.append;
       copyrec(src_mast,dst_mast);
       dst_mast.fieldbyname('cod').asinteger:=
            dst_mast.fieldbyname('cod').asinteger+add_code;
       dst_mast.post;
       if src_det<> nil then begin
          src_det.first;
          while  not src_det.eof do begin
            dst_det.append;
            copyrec(src_det,dst_det);
            dst_det.fieldbyname('cod_m').asinteger:=
                 dst_det.fieldbyname('cod_m').asinteger+add_code;
            dst_det.post;
            src_det.delete;
          end;
       end;
       src_mast.delete;
       if one_rec in mode then goto m_exit;
    end;
m_exit:
     dst_mast.close;
     dst_mast.free;
     if src_det<>nil then  begin
       dst_det.close;
       dst_det.free;
     end;
end;
{/////////////////////}

{$ENDIF}
{////////////////////////////////////}
Function Upper(Str:string):string;
var
  I : SmallInt;
begin
    For I := 1 to length(Str) do
        If ord(Str[I]) in [97..122,224..255] then
           Str[I] := chr(ord(Str[I]) - 32);
    Upper := Str;
end;  {Func Upper}
function calcnextAi(DataSet: TDataSet):integer;
var wk_t1,wk_t:ttable;
begin  {  вычисление след номера накладной}
    wk_t:= dataset as ttable;
         wk_t1:=create_wkt(wk_t,nil );
         wk_t1.indexname:='';   {посл номер}
         wk_t1.open;
         if wk_t1.recordcount>0 then begin
           wk_t1.last;
           result:=wk_t1.fieldbyname('ai').asinteger+1;
          end
          else  result:=1;
          wk_t1.free;
end;
{/////////////////}

{/////////////////////////////////////}
function calcNextNum(DataSet: TDataSet):string;
var wk_t1,wk_t:ttable;
begin  {  вычисление след номера накладной}
    wk_t:= dataset as ttable;
         wk_t1:=create_wkt(wk_t,nil );
         wk_t1.indexname:='';   {посл номер}
{         wk_t1.filter:=wk_t.filter;}
{         wk_t1.filtered:=wk_t.filtered;}
         wk_t1.open;
         if wk_t1.recordcount>0 then begin
           wk_t1.last;
           result:=int_to_str(str_to_int(wk_t1.fieldbyname('номер').asstring)+1);
          end
          else  result:='1';
          wk_t1.free;
end;
{/////////////////}
function  CalcMastNextCode(DataSet: TDataSet):integer;
var wk_t,wk_t1:ttable;
begin  {вычисление поля cod для новойзаписи}
        wk_t:= dataset as ttable;
      with wk_t do begin
         wk_t1:=create_wkt(wk_t,nil);
         wk_t1.indexname:='i_cod';
         wk_t1.open;
         wk_t1.last;
         result:=wk_t1.fieldbyname('cod').asinteger+1;
         wk_t1.free;
      end

end;
{/////////////////}
function  CalcMastminCode(DataSet: TDataSet):integer;
var wk_t,wk_t1:ttable;
begin  {вычисление min поля cod}
        wk_t:= dataset as ttable;
      with wk_t do begin
         wk_t1:=create_wkt(wk_t,nil);
         wk_t1.indexname:='i_cod';
         wk_t1.open;
         wk_t1.first;
         result:=wk_t1.fieldbyname('cod').asinteger;
         wk_t1.free;
      end

end;
{/////////////////////////}

function cmpstru(src_tab,dest_tab:ttable):boolean;
label ok;
var i,j:integer;  {сравнивает структуры 2 таблиц}
    DIDef,SIdef:TIndexDef;
   begin
      result:=false; {разные пол}
      with src_tab do
      begin
        fielddefs.update;
        dest_tab.fielddefs.update;
        if  fielddefs.count <> dest_tab.fielddefs.count then exit;
         for j := 0 to fielddefs.count -1 do
         begin
           if  dest_tab.fielddefs.items[j].name <> fielddefs.items[j].name
                 then exit;
           if  dest_tab.fielddefs.items[j].size <> fielddefs.items[j].size
                 then exit;
           if  dest_tab.fielddefs.items[j].datatype <> fielddefs.items[j].datatype
                 then exit;
         end; {for}
          IndexDefs.Update;
          dest_tab.IndexDefs.Update;
          if IndexDefs.Count<>dest_tab.IndexDefs.Count then exit;
         for j := 0 to IndexDefs.count -1 do  begin
           SIdef:= IndexDefs.Items[j];
           for i := 0 to dest_tab.IndexDefs.count -1 do
            begin
              DIdef:=dest_tab.IndexDefs.Items[i];
              if (strcmpi(Didef.name,SIdef.name)=0)
               and ( strcmpi(Didef.fields,SIdef.fields)=0)
               and (Didef.options = SIdef.options) then goto ok;
            end;
            exit;
            ok:
         end;
      end;
     result:=true;
   end;

{/////////////////}
function extractfname(fname:string):string;
 {извлекает имя без расширени}
 var i:integer;s:string;
 begin
   s:=extractfilename(fname);
   i:=pos('.',s);
   if i>0 then
     result:= copy(s,1,i-1)
     else result:=s;
 end;
function extractfext(fname:string):string;
{ извлекает расширение c .}
 var i:integer;
 begin
   i:=pos('.',fname);
   if i>0 then
     result:= copy(fname,i,4)
     else result:='';
 end;
{////////////////}
function MoveDBfiles (BdS, BdD : TFileName) : integer;
{если не задавать вых имя то путь BdD  заканчивать \}
var fr :integer;
    SearchRec: TSearchRec;
    ext,nameS,nameD,pathS,PathD: string;
begin
   pathS:=extractfilepath(BdS);
   pathD:=extractfilepath(BdD);
   nameS:=extractFname(BdS);
   nameD:=extractFname(BdD);
   Result:=0;         {если не совпадают пути}
   if (strcmpi(bdS,BdD)=0) {совп вх и вых}
      or(  ( named='' ) and(pathS=PathD))
        then  begin
        result:=1; exit;
        end;
      if nameD='' then nameD:=nameS; {если не задано им}
      fr := FindFirst(pathS+nameS+'.*', faAnyFile, SearchRec);
      while fr = 0 do
      begin
         ext:=ExtractFext(SearchRec.Name);
         movefile(pathS+nameS+ext,PathD+named+ext);
         fr := FindNext(SearchRec);
      end;
      SysUtils.FindClose(SearchRec);
end;
function copyDBfiles (BdS, BdD : TFileName) : integer;
var fr :integer;
    SearchRec: TSearchRec;
    ext,nameS,nameD,pathS,PathD: string;
begin
{если не задавать вых имя то путь BdD  заканчивать \}
   pathS:=extractfilepath(BdS);
   pathD:=extractfilepath(BdD);
   nameS:=extractFname(BdS);
   nameD:=extractFname(BdD);
   Result:=0;         {если не совпадают пути}
   if (strcmpi(bdS,BdD)=0) {совп вх и вых}
      or(  ( named='' ) and(pathS=PathD))
        then  begin
        result:=1; exit;
        end;
      if nameD='' then nameD:=nameS; {если не задано им}
      fr := FindFirst(pathS+nameS+'.*', faAnyFile, SearchRec);
      while fr = 0 do
      begin
         ext:=ExtractFext(SearchRec.Name);
         copyfile(pathS+nameS+ext,PathD+named+ext,nil);
         fr := FindNext(SearchRec);
      end;
      SysUtils.FindClose(SearchRec);
end;


function DelDBfiles (BdS : TFileName) : integer;
var fr :integer; {удаляет базу}
    SearchRec: TSearchRec;
    tabpath,tabname: string;
begin
   Result:=0;
   begin
      tabname:=extractFname(BdS);
      tabpath:=extractfilepath(bds);
      fr := FindFirst(tabpath+tabname+'.*', faAnyFile, SearchRec);
      while fr = 0 do
      begin
         SysUtils.deletefile(tabpath+SearchRec.Name);
         fr := FindNext(SearchRec);
      end;
      SysUtils.FindClose(SearchRec);
   end;
end;
function ed_sts(dset:tdataset):boolean;{тест редактирование}
begin
  if assigned (dset) then
   result:=(dset.state=dsinsert) or (dset.state=dsedit)
  else result:=false;
end;
{==============================================}
{$IFDEF WIN32}
function GetFldCur(dataset:tdataset;fldnameS:string):currency;
 const pars='+-*/';
 var
  i:integer;s,ps:string;wk_f:tfield;
 val:currency;
 begin {вернуть поле как   currency выражение}
   result:=0;
   for  i:=1  to WordCntx(fldnameS,pars,false) do
   begin
     s:=strip('A',' ',ExtractWordsx(i,1,fldnameS,pars,false));
     if i=1 then ps:='+'
     else ps:=parsWordsx(i-1,fldnameS,pars,false);
      wk_f:= dataset.findfield(s);
      if wk_f=nil  then val:=0
          else val:=wk_f.asfloat;
     case ps[1] of
      '-' : result:=result-val;
      '/' : if val=0 then begin
             result:=0;exit;end
            else  result:=result/val;
      '*' : result:=result*val;
     else result:=result+val;
     end;
   end;
 end;
procedure SetFldCur(dataset:tdataset;fldname:string;value:currency);
 var  wk_f:tfield;
begin
      wk_f:= dataset.findfield(fldname);
      if( wk_f<>nil ) and wk_f.canmodify then begin
      if not ed_sts(dataset) then dataset.edit;
      wk_f.asfloat:=value;
      end;
end;
function addCurFld(dataset:tdataset;fldname:string;value:currency):currency;
var wk_f:tfield;
begin
  wk_f:=dataset.findfield(fldname);
  if assigned(wk_f) and wk_f.canmodify then begin
    if not ed_sts(dataset) then dataset.edit;
    if  wk_f.asfloat=0 then  wk_f.asfloat:=value
    else wk_f.asfloat:=wk_f.asfloat+value;
    result:=wk_f.asfloat;
  end
  else result:=0;
end;
 function create_wktF(base_t:ttable;Aowner:TComponent;mode:tcrWKtset):ttable;
{создать копию курсора-TTABLE с полным копированием полей  &events}
{  TCRwkt=(crFull,crMasterfld,crTbev,Crfldev,Crind,CrDatabase,crfldefs,crCalcFld,crLookFld);}
  begin
        Result:=ttable.create(aowner);
        copy_wktF(base_t,result,mode);
  end;
{================  win 16  ==============================}
{$Else}

{++++++++}
function GetFldCur(dataset:tdataset;fldnameS:string):double;
 const pars='+-*/';
 var
  i:integer;s,ps:string;wk_f:tfield;
 val:double;
 begin {вернуть поле как   currency выражение}
   result:=0;
   for  i:=1  to WordCntx(fldnameS,pars,false) do
   begin
     s:=strip('A',' ',ExtractWordsx(i,1,fldnameS,pars,false));
     if i=1 then ps:='+'
     else ps:=parsWordsx(i-1,fldnameS,pars,false);
      wk_f:= dataset.findfield(s);
      if wk_f=nil  then val:=0
          else val:=fl_to_cur(wk_f.asfloat);
     case ps[1] of
      '-' : result:=fl_to_cur(result-val);
      '/' : result:=fl_to_cur(result/val);
      '*' : result:=fl_to_cur(result*val);
     else result:=fl_to_cur(result+val);
     end;
   end;
 end;
procedure SetFldCur(dataset:tdataset;fldname:string;value:double);
 var  wk_f:tfield;
begin
      wk_f:= dataset.findfield(fldname);
      if( wk_f<>nil ) and wk_f.canmodify then begin
      if not ed_sts(dataset) then dataset.edit;
      wk_f.asfloat:=fl_to_cur(value);
      end;
end;
function addCurFld(dataset:tdataset;fldname:string;value:double):double;
var wk_f:tfield;
begin
  wk_f:=dataset.findfield(fldname);
  if assigned(wk_f) and wk_f.canmodify then begin
    if not ed_sts(dataset) then dataset.edit;
    if  wk_f.asfloat=0 then  wk_f.asfloat:=fl_to_cur(value)
    else wk_f.asfloat:=fl_to_cur(wk_f.asfloat)+fl_to_cur(value);
    result:=wk_f.asfloat;
  end
  else result:=0;
end;
{++++++++++++++++++}
function fl_to_cur(val:double):double;
begin
   result:= (round(val*cur_K)) / cur_k ;
end;

{++++++++++++++++++}
 function lookfld(keyfld:string;lookset:tdataset;lookkey,lookresult:string):string;
 var dbl:TDBLocate;
 begin
   dbl:=TDBLocate.create; dbl.dataset:=lookset;
   with lookset do
   if  dbl.Locate(lookkey,Keyfld,true, false)
   then result:=fieldbyname(lookresult).asstring
   else result:='';
 end;
{$ENDIF}
{/////////////////////////////////////}
function copy_m(mast_src,mast_dest:ttable;fldnames:string;const fldvalues: array of const):integer;
{копирует одну запись из mast таблицы в ней же}
 var  src_m,dst_m:ttable;
  i:integer;s:string;cod_M:integer;wk_f:tfield;
 begin
    src_m:=mast_src;
    dst_m:= create_wkt(mast_dest,nil);
    dst_m.open;
    dst_m.append;
    result:=dst_m.fieldbyname('ai').asinteger;
    copyrec(src_m,dst_m);
    cod_m:=CalcMastNextCode(dst_m);
    dst_m.edit;
    dst_m.fieldbyname('cod').asinteger:=cod_m;
    for i:=1 to wordcntx(fldnames,';',false) do begin
       s := ExtractWordsx(i,1,fldnames,';',false);
       wk_f:=dst_m.findfield(s);
       if wk_f<>nil then
          wk_f.assignvalue(fldvalues[i-1]);
    end;
    dst_m.post;
    dst_m.free;
 end;
 {///////////////////////}

function  copy_md(det_src,det_dest:ttable;fldnames:string;const fldvalues: array of const):integer;
{копирует одну запись из mast(по отношению к det) таблицы}
{ и соответствующие det}
 var  src_m,src_d,dst_m,dst_d:ttable;
  i:integer;s:string;cod_M:integer;wk_f:tfield;
 begin
     src_d:=det_src;
     src_m:=det_src.mastersource.dataset as ttable;
     dst_d:= create_wkt(det_dest as ttable,nil);
     dst_m:= create_wkt(det_dest.mastersource.dataset as ttable,nil);
     dst_m.open;
     dst_d.open;
    cod_m:=CalcMastNextCode(dst_m);
    dst_m.append;
    copyrec(src_m,dst_m);
    dst_m.edit;
    dst_m.fieldbyname('cod').asinteger:=cod_m;
    for i:=1 to wordcntx(fldnames,';',false) do begin
       s := ExtractWordsx(i,1,fldnames,';',false);
       wk_f:=dst_m.findfield(s);
       if wk_f<>nil then
          wk_f.assignvalue(fldvalues[i-1]);
    end;
    dst_m.post;
    result:=dst_m.fieldbyname('ai').asinteger;
    src_d.first;
    with src_d do
    while not eof do begin
       dst_d.append;
       copyrec(src_d,dst_d);
       dst_d.edit;
       dst_d.fieldbyname('cod_m').asinteger:=cod_m;
       dst_d.post;
       next;
    end;
    dst_d.free;dst_m.free;
 end;
function create_wkt(base_t:ttable;Aowner:TComponent):ttable;
{создать копию курсора-TTABLE}
  begin
    with base_t do begin
      result:=ttable.create(aowner);
      result.databasename:=databasename;
      result.tablename:=tablename;
      result.indexname:=indexname;
    end;
  end;
procedure copyrec(src_tab,dest_tab:tdataset);
{копирует поля записи из одной базы в другую}
var j:integer;
 wk_fld:tfield;
 {$IFnDEF WIN32}   Wkmemo:tstringlist;
                   Stream: TBlobStream;
 {$endif}

   begin
 {$IFnDEF WIN32}
   wkmemo:=nil;
 {$endif}

      with src_tab do
      begin
         for j := 0 to fieldcount -1 do
         begin
            wk_fld:= dest_tab.findfield(fields[j].fieldname);
            if( wk_fld<> nil) and not wk_fld.readonly
             then

{$IFDEF WIN32}
              wk_fld.value:=fields[j].value;
{$else}
            if wk_fld is tmemofield then begin
               if wkmemo=nil then  WkMemo:=Tstringlist.create;
               Stream := TBlobStream.Create(TBlobField(fields[j]), bmRead);
               try
                 wkmemo.LoadFromStream(Stream);
               finally
                 Stream.Free;
               end;
               Stream := TBlobStream.Create(TBlobField(wk_fld), bmWrite);
               try
                 wkmemo.SaveToStream(Stream);
               finally
                 Stream.Free;
               end;
            end
            else if wk_fld is tfloatfield then wk_fld.asfloat:=fields[j].asfloat
            else  wk_fld.text:=(fields[j].text);
{$endif}
         end; {for}
      end;
{$IFNDEF WIN32}
  if wkmemo<>nil then WkMemo.free;
{$ENDIF}

   end;
function roundcur(num:extended):double;
 begin
   result:=round(num*100)/100;
 end;
function calcNds(sum:extended):double ;
begin
   result:=roundcur(sum/5);
end;
function sumSubNds(sum:extended):double ;
begin
   result:=sum -roundcur(sum/6);
end;
function sumAddNds(sum:extended):double ;
begin
   result:=sum+calcNds(sum);
end;
{$IFDEF WIN32}
function DelphiLoaded: Boolean;

       function WindowExists(ClassName, WindowName: string): Boolean;
       begin
         Result :=  FindWindow(PChar(ClassName), PChar(WindowName)) <> 0;
       end;

     begin
       Result := WindowExists('TPropertyInspector', 'Object Inspector')
             and WindowExists('TMenuBuilder', 'Menu Designer')
             and WindowExists('TApplication', 'Delphi 3')
             and WindowExists('TAlignPalette', 'Align')
             and WindowExists('TAppBuilder', '');
end;
procedure curs_wait; //курсор-ожидание
begin
{$IFDEF  DEBUG}
  exit;
{$ENDIF}

  wk_curs := SCREEN.Cursor;
  SCREEN.Cursor := crHourGlass;
end;
procedure curs_norm; //норм курсор
begin
{$IFDEF  DEBUG}
  exit;
{$ENDIF}
  SCREEN.Cursor := wk_curs;
end;
procedure AniCurs_wait; //курсор-ожидание анимированный
var
  sPath : Array[0..MAX_PATH-1] of Char;
  Path  : String;
begin
{$IFDEF  DEBUG}
  exit;
{$ENDIF}
  if ani_curs=0 then begin  //загрузить курсор
   GetWindowsDirectory( sPath,MAX_PATH);
   Path := StrPas(sPath);
   Path := Path + '\cursors\hourglas.ani';
   if fileexists(Path) and loadanicurs(Path,1)
   then ani_curs:=1
   else ani_curs:=-1;
  end;
    wk_curs := SCREEN.Cursor;
    if ani_curs>0 then SCREEN.Cursor :=ani_curs
    else   SCREEN.Cursor := crHourGlass;  //не загружен аним курсор
end;
function loadanicurs(AniPath:string;numc:integer):boolean;
var
  h : THandle;
begin
  result:=true;
  h := LoadImage(0,
//    'C:\winnt\cursors\hourglas.ani',
    pchar(AniPath),
    IMAGE_CURSOR,
    0,
    0,
    LR_DEFAULTSIZE or
    LR_LOADFROMFILE
  );
  if h = 0 then result:=false//ShowMessage('Cursor not loaded')
  else
  begin
    Screen.Cursors[numc] := h;
  end;
end;



procedure loaditems(ls:tstrings;ds:Tdataset;fldnames:string);
 var flds,objs:string;
begin  //load  tstrings from dataset
   flds:=extractwordsx(1,1, fldnames,';',false);
   if flds='' then exit;
   objs:=extractwordsx(2,1, fldnames,';',false);
   ds.first;
   with ds do
    while not eof do
     begin
      if objs<>'' then
        ls.AddObject(fieldbyname(flds).asstring,tobject(fieldbyname(objs).asinteger))
      else
      ls.Add(fieldbyname(flds).asstring);
      next;
     end;
end;

procedure cascadeDel(MTab:ttable);
var ipos,i:integer; reslst,blst:tstringlist;
    s1,s2,s3:string;wk_sql:TSQLScript ;
begin
  if mTab.eof then exit;{ DB is Empty}
  mtab.indexdefs.update;
  s1:='';
  with mtab.indexdefs do
  for i:=0 to  count-1 do
     if  ixPrimary in items[i].Options then
      begin
       s1:=items[i].fields;
       break;
      end;
  if s1='' then exit;{key fields not found }
  iPos := 1; s3:='';
  while iPos <= Length(s1) do begin
           s2:= ExtractFieldName(s1, iPos);
           if s3<>'' then s3:=s3+';';
           s3:=s3+mTab.fieldbyname(s2).asstring;
  end;
    blst:=tstringlist.create;
    reslst:=tstringlist.create;
    blst.add(Mtab.database.directory + extractfilename(Mtab.tablename)+'|');
    blst[0]:=blst[0]+'|'+s1+'|'+s3;
    form_del_sql(BLst,reslst);
    if reslst.count>0 then begin
      wk_sql:= TSQLScript.create(nil);
      wk_sql.sql.assign(reslst);
      wk_sql.execsql;
      wk_sql.free;
    end;
//    reslst.SaveToFile('111._1');
    reslst.free;
    blst.free;
end;
procedure form_del_sql(BLst,reslst:Tstringlist);
var  wk_lst,t_lst:TStringList;wk_t:ttable;nw,i,j:integer;s:string;
     nofirst:boolean;
   function exwd(numl,numw,subw:integer):string;
   begin
     result:=extractwordsx(numw,1,blst[numl],'|',false);
     if subw<>0 then result:=extractwordsx(subw,1,result,';',false);
   end;
begin  {сканирует зависимости таблиц и формирует список SQL на удаление}
 {Blst[0] - для входа : Mtable -полное имя;Key;KeyValue}
  wk_t:=ttable.create(nil);
  wk_lst:=tstringlist.create;
  t_lst:=tstringlist.create;
  wk_t.tablename:=extractwordsx(1,1,blst[blst.count-1],'|',false);
  wk_t.open;
  getDependTables(wk_t,t_lst);
  for i :=0  to t_lst.count-1 do
  begin
    wk_lst.clear;
    wk_lst.AddStrings(Blst);
    wk_lst.add(t_lst[i]);
    form_del_sql(wk_Lst,reslst);
  end;
  if blst.count>1 then
  begin
      nofirst:=false;
      s:=format('DELETE from "%s" WHERE exists (select * from ',[exwd(blst.count-1,1,0)]);
      reslst.add(s);
      for  i:=blst.count-1  downto 1 do
            reslst.add(format('"%s" ,',[exwd(i,1,0)]) );
      reslst.add(format('"%s" where',[exwd(0,1,0)]) );    { select from list  }
      for  i:=blst.count-1  downto 1 do
      begin
        nw:=wordcntx(exwd(i,2,0),';',false);{num key fields}
        for j :=1  to nw do
        begin
         s:=format('"%s".%s="%s".%s',[exwd(i,1,0),exwd(i,3,j),exwd(i-1,1,0),exwd(i,2,j)]);
         if   nofirst then s:='and '+s
         else nofirst:=true;
         reslst.add(s);
        end;
      end;
        nw:=wordcntx(exwd(0,2,0),';',false);{num key fields}
        for j :=1  to nw do
        begin
         s:=format (' and "%s".%s=%s',[exwd(0,1,0),exwd(0,2,j),exwd(0,3,j)]);
         reslst.add(s);
        end;
      reslst.add('  )  ;');
  end;
(*

DELETE from "D:\D_WORK\TST\DB\Tb_det2.DB" WHERE exists
(
select *
	from  "D:\D_WORK\TST\DB\Tb_det.db" ,
			"D:\D_WORK\TST\DB\Tb_mast.DB" ,
			"D:\D_WORK\TST\DB\Tb_det2.DB"
			where
		 "D:\D_WORK\TST\DB\Tb_det2.DB".Cod_m="D:\D_WORK\TST\DB\Tb_det.db".Au
	and "D:\D_WORK\TST\DB\Tb_det.db".Cod_m="D:\D_WORK\TST\DB\Tb_mast.DB".Au
	and "D:\D_WORK\TST\DB\Tb_mast.DB".Au=1

  *)
   wk_t.free;
   wk_lst.free;
   t_lst.free;
end;
////////////
procedure   getDependTables(Table: TTable;RIntList: TStringList);
var //  cписок имен зависимых таблиц  Через BDE
  res: RINTDesc;
  Str: String;
  Props: CURProps;   i:integer;
  B:byte; m_tab,d_tab:ttable;
begin

//  ThisTable := '';  OtherTable := '';
  FillChar(Res, sizeof(Res), #0);
  Check(DbiGetCursorProps(Table.Handle, Props));
  m_tab:=ttable.create(nil);
  m_tab.tablename:=Table.tablename;
  m_tab.databasename:=table.DatabaseName;
  d_tab:=ttable.create(nil);
//  d_tab.databasename:=table.DatabaseName;
  m_tab.fielddefs.update;
  for i := 1 to Props.iRefIntChecks do
  begin
     Check(DbiGetRIntDesc(Table.Handle, i, @Res));
     if (RIntList <> nil) and
         (Res.eType = rintMASTER) then  begin
          str:=Res.szTblName;//1-слово -имя таб 2-список vfst fld 3- deped fld
          d_tab.tablename:=str; str:=str+'|';
          d_tab.fielddefs.update;
          for B := 0 to DBIMAXFLDSINKEY do
          begin
            if Res.aiThisTabFld[B] <> 0 then
            begin
              if B <> 0 then
                str:=str+';'+m_tab.fielddefs[Res.aiThisTabFld[B]-1].name

              else
                str:=str+m_tab.fielddefs[Res.aiThisTabFld[B]-1].name;
            end
            else
              Break;
          end;
           str:=str+'|';
          for B := 0 to DBIMAXFLDSINKEY do
          begin
            if Res.aiOthTabFld[B] <> 0 then
            begin
              if B <> 0 then
                str:=str+';'+d_tab.fielddefs[Res.aiOthTabFld[B]-1].name
              else
                str:=str+d_tab.fielddefs[Res.aiOthTabFld[B]-1].name;
            end
            else

              Break;
          end;
      RIntList.add(Str);
    end;
  end;
  m_tab.free;d_tab.free;
end;



procedure _CopyStrProp(src,dest:Tcontrol;namProp:string);
var Str_bas:string;
  PropInfo: PPropInfo;
begin //копирование строчных Property
  PropInfo := TypInfo.GetPropInfo(src.ClassInfo, namprop);
  if (PropInfo = nil) or (PropInfo^.PropType^.Kind <> tkLstring) then  exit;
  str_bas:= {TObject}(GetsTRProp(src, PropInfo));// as TDataSource;
  ///////////
  PropInfo := TypInfo.GetPropInfo(dest.ClassInfo,namProp);
  SetStrProp(dest, PropInfo,str_bas);
end;
procedure _CopyOrdProp(src,dest:Tcontrol;namProp:string);
var Int_bas:longint;
  PropInfo: PPropInfo;
begin //копирование классовых Property
  PropInfo := TypInfo.GetPropInfo(src.ClassInfo, namprop);
  if (PropInfo = nil) or (PropInfo^.PropType^.Kind <> tkClass) then  exit;
  Int_bas:= (GetOrdProp(src, PropInfo));// as TDataSource;
  ///////////
  PropInfo := TypInfo.GetPropInfo(dest.ClassInfo,namProp);
  SetOrdProp(dest, PropInfo,Int_bas);
end;
procedure _setOrdProp(dest:Tcontrol;namProp:string;prop:longint);
var  PropInfo: PPropInfo;
begin //установка Property
  PropInfo := TypInfo.GetPropInfo(dest.ClassInfo, namprop);
  if (PropInfo = nil) or (PropInfo^.PropType^.Kind <> tkClass) then  exit;
  SetOrdProp(dest, PropInfo,prop);
end;
function _GetOrdProp(dest:Tcontrol;namProp:string):longint;
var   PropInfo: PPropInfo;
begin //установка Property
  result:=0;
  PropInfo := TypInfo.GetPropInfo(dest.ClassInfo, namprop);
  if (PropInfo = nil) or (PropInfo^.PropType^.Kind <> tkClass) then  exit;
  result:= (GetOrdProp(dest, PropInfo));// as TDataSource;
end;
function _GetStrProp(src:Tcontrol;namProp:string):string;
var PropInfo: PPropInfo;
begin //копирование строчных Property
  result:='';
  PropInfo := TypInfo.GetPropInfo(src.ClassInfo, namprop);
  if (PropInfo = nil) or (PropInfo^.PropType^.Kind <> tkLstring) then  exit;
  result:= (GetsTRProp(src, PropInfo));// as TDataSource;
end;
procedure _SetStrProp(dest:Tcontrol;namProp,val:string);
var PropInfo: PPropInfo;
begin //копирование строчных Property
  PropInfo := TypInfo.GetPropInfo(dest.ClassInfo, namprop);
  if (PropInfo = nil) or (PropInfo^.PropType^.Kind <> tkLstring) then  exit;
   (setsTRProp(dest, PropInfo,val));// as TDataSource;
end;
////////////////////////////
procedure _LstControls(cnt:tWinControl;lst:tstringlist);
var i:integer;wc:tcontrol;
begin  //список  controls  текущего
  if  not assigned(lst) or not (lst is tstringlist) then exit;
  with cnt do
  for i :=0  to controlcount-1 do
  begin
     wc:=controls[i];
     lst.addobject(wc.name,wc);
     if (wc is tWinControl) and ((wc as tWinControl).controlcount>0)
       then  _LstControls(wc as tWinControl,lst);
  end;
end;
//////////////////
function _copyFld(bas_f:tfield;dest_set:tdataset;newname:string):tfield;
var wk_act: boolean;
begin //создать копию поля с именем newname
        with dest_set do
        begin
           wk_act:=active;
           if active then close;
        end;
       result:= dest_set.findfield(newname);
       if assigned(result) then result.free;
       result:=(TComponentClass(bas_f.ClassType)).create(dest_set) as tfield ;
   with bas_f do    begin
       result.FieldName :=newname;
       result.DataSet := dest_set;
       result.Lookup:= Lookup;
       result.LookupDataSet :=LookupDataSet;
       result.LookupKeyFields :=LookupKeyFields;
       result.KeyFields :=KeyFields;
       result.LookupResultField :=LookupResultField;
       result.size:=size;
       result.tag:=tag;
       result.visible:=visible;
       result.fieldkind:=fieldkind;
       result.DisplayLabel:=DisplayLabel;
       if result is tnumericfield then begin
         (result as tnumericfield).displayformat:=(bas_f as tnumericfield).displayformat;
         (result as tnumericfield).editformat:=(bas_f as tnumericfield).editformat;
       end;
    end;
    dest_set.active:=wk_act;
end;
{$ENDIF}
initialization
{$IFDEF WIN32}
 ani_curs:=0;
{$ENDIF}


{//////////////////////////////////////}
end.
