unit Report_Zayav_Unit;

interface
uses Report_Parent_Unit,FR_Class,DB,DM_VedomPublicUnit,SysUtils,AvarOnMapConst,
     FR_DSet, DBTables,HelpFunctions;


type

TLoadType=(ltData, ltEmpty);

  TZayavRep=class(TParentRep)
  private
    FfrFirstViezdZadv: TfrUserDataset;
    FfrOtherViezdZadv: TfrUserDataset;
    FScreenShotFileName_1,FScreenShotFileName_2:string;
    FNeedOfCountScreenShot:integer;
    F_isObj: boolean;
    procedure LoadZadv(IsFirstViezd: boolean; LoadType: TLoadType);
    procedure LoadNar(IsFirst:boolean;LoadType: TLoadType );
  public
    constructor Create(_work_report:TfrReport; _fn:string);
    destructor Destroy; override;
    //
    property frFirstViezdZadv: TfrUserDataset write FfrFirstViezdZadv;
    property frOtherViezdZadv: TfrUserDataset write FfrOtherViezdZadv;
    procedure OnFirst_FirstViezdZadv(Sender: TObject);
    procedure OnNext_FirstViezdZadv(Sender: TObject);
    procedure OnFirst_NotFirstViezdZadv(Sender: TObject);
    procedure OnNext_NotFirstViezdZadv(Sender: TObject);
    procedure OnFirst_Zadv(Sender: TObject);
    procedure OnNext_Zadv(Sender: TObject);
    //
    procedure Execute; override;
    //
    property NeedOfCountScreenShot:integer read FNeedOfCountScreenShot write FNeedOfCountScreenShot;
    property ScreenShotFileName_1:string read FScreenShotFileName_1 write FScreenShotFileName_1;
    property ScreenShotFileName_2:string read FScreenShotFileName_2 write FScreenShotFileName_2;
    property isObj: boolean write F_isObj;
    procedure OnFirst_Nar(Sender: TObject);
    procedure OnNext_Nar(Sender: TObject);


  end;

var ZR_FMatsCount,ZR_FPeoplesCount,ZR_FMexanCount:integer;

implementation

procedure TZayavRep.Execute;
var _i: byte;
begin
  _i := 2; //- первая страница с фотками 2 с данными 
//  _i := 2; - первая страница с фотками
  if FNeedOfCountScreenShot<>0 then
    begin
      try
        (FWorkReport.FindObject('Picture1') as TfrPictureView).Picture.LoadFromFile(FScreenShotFileName_1);
        FWorkReport.Pages[_i].Visible:=true;
        if FNeedOfCountScreenShot=2 then
          begin
            (FWorkReport.FindObject('Picture2') as TfrPictureView).Picture.LoadFromFile(FScreenShotFileName_2);
            FWorkReport.Pages[_i+1].Visible:=true;
          end
            else
          begin
            FWorkReport.Pages[_i+1].Visible:=false;
            FWorkReport.Pages.Delete(_i+1);
          end;
      except
        FWorkReport.Pages[_i].Visible:=false;
        FWorkReport.Pages.Delete(_i);
        FWorkReport.Pages[_i+1].Visible:=false;
        FWorkReport.Pages.Delete(_i+1);
      end;
    end
      else
    begin
      FWorkReport.Pages[_i].Visible:=false;
      FWorkReport.Pages[_i+1].Visible:=false;
      FWorkReport.Pages.Delete(_i);
      FWorkReport.Pages.Delete(_i);
    end;
  inherited Execute;
end;


constructor TZayavRep.Create(_work_report:TfrReport; _fn:string);
begin
  inherited Create(_work_report,_fn);

  F_isObj := false; // это для не объектных заявок
  //
  FNeedOfCountScreenShot:=0;
  FScreenShotFileName_1:='';
  FScreenShotFileName_2:='';
  //
  AddNameAndValue('Attach');
  AddNameAndValue('NZayav');
  AddNameAndValue('Address');
  AddNameAndValue('DatePostupl');
  AddNameAndValue('TimePostupl');
  AddNameAndValue('Zayavitel');
  AddNameAndValue('Phone');
  AddNameAndValue('WhatMatter');
  AddNameAndValue('PervViezdDate');
  AddNameAndValue('PervViezdTime');
  AddNameAndValue('ZayavType');
  AddNameAndValue('MestoPovr');
  AddNameAndValue('XarPovr');
  AddNameAndValue('MatTrub');
  AddNameAndValue('Diam');
  AddNameAndValue('MestnPovr');
  AddNameAndValue('WithoutWater');
  AddNameAndValue('FirstViezdWorks');
  AddNameAndValue('PlanObors');
  AddNameAndValue('PoluchDate');
  AddNameAndValue('PoluchBr');
  AddNameAndValue('UtochPovrezhd');
  AddNameAndValue('DateBeginWork2');
  AddNameAndValue('DateEndWork2');
  AddNameAndValue('TimeBeginWork2');
  AddNameAndValue('TimeEndWork2');
  AddNameAndValue('WithoutFirstViezdWorks');
  AddNameAndValue('UsedObors');
  AddNameAndValue('Maters');
  AddNameAndValue('DiamLeak');
  AddNameAndValue('SquareLeak');
  AddNameAndValue('GLZ');
  AddNameAndValue('Press');
  AddNameAndValue('NeedWorks');
  AddNameAndValue('Master');
  AddNameAndValue('peredano');
  AddNameAndValue('dt_act');
  AddNameAndValue('bract');
  AddNameAndValue('brblag');

  AddNameAndValue('sdal');
  AddNameAndValue('DisOut');

  AddNameAndValue('Prinadlezhn');
  AddNameAndValue('Rayon');

  AddNameAndValue('ObjSoor');
  AddNameAndValue('SpisObj');

  AddNameAndValue('Isp');

  //
  ZR_FMatsCount:=0;
  ZR_FPeoplesCount:=0;
  ZR_FMexanCount:=0;
end;

destructor TZayavRep.Destroy;
begin
  inherited;
end;

procedure TZayavRep.OnFirst_FirstViezdZadv(Sender: TObject);
begin
  DM_VedomPublic.Qry_FirstViezdZadv.First;
  if DM_VedomPublic.Qry_FirstViezdZadv.Eof then
  (Sender as TfrUserDataset).RangeEndCount:=0;
  if not DM_VedomPublic.Qry_FirstViezdZadv.Eof then LoadZadv(true, ltData);
end;

procedure TZayavRep.OnFirst_Zadv(Sender: TObject);
begin
  DM_VedomPublic.Qry_Zadv.First;

  if not DM_VedomPublic.Qry_Zadv.Eof then LoadZadv(true, ltData);
end;

procedure TZayavRep.OnNext_Zadv(Sender: TObject);
begin
  DM_VedomPublic.Qry_Zadv.Next;
  if not DM_VedomPublic.Qry_Zadv.Eof then LoadZadv(true, ltData);
 // else LoadZadv(true, ltEmpty);
end;


procedure TZayavRep.OnNext_FirstViezdZadv(Sender: TObject);
var
 str:string;
begin
 DM_VedomPublic.Qry_FirstViezdZadv.Next;
 str:= Sender.ClassName  ;
 if DM_VedomPublic.Qry_FirstViezdZadv.Eof then
  (Sender as TfrUserDataset).RangeEndCount:=0;
  if not DM_VedomPublic.Qry_FirstViezdZadv.Eof then LoadZadv(true, ltData);
 // else LoadZadv(true, ltEmpty);

end;

procedure TZayavRep.LoadZadv(IsFirstViezd: boolean; LoadType: TLoadType);
var
  okon: string;
  qry: TQuery;
  dt_str: string;
begin
 if F_isObj then
    begin
      okon:='1';
      qry:=DM_VedomPublic.Qry_Zadv;
    end;
 if (not F_isObj) then
  if IsFirstViezd  then
  begin
    okon:='1';
    qry:=DM_VedomPublic.Qry_FirstViezdZadv;
  end else
  begin
    okon:='2';
    qry:=DM_VedomPublic.Qry_NotFirstViezdZadv;
  end;

  if LoadType=ltData then
  begin
    if F_isObj then frVariables['Zadv_Adres'+okon]:=qry.FieldByName('calc_ObjSoor').AsString
      else
    frVariables['Zadv_Adres'+okon]:=qry.FieldByName('adres').AsString;
    if qry.FieldByName('diam').AsInteger<>0 then
      frVariables['Zadv_Diam'+okon]:=qry.FieldByName('diam').AsString
    else
      frVariables['Zadv_Diam'+okon]:='';

    frVariables['Zadv_OtvetClose'+okon]:=qry.FieldByName('brig_in').AsString;

    DateTimeToString(dt_str, 'dd.mm.yy hh:mm', qry.FieldByName('dt_in').AsDateTime);
    frVariables['Zadv_DateClose'+okon]:=dt_str;

    if qry.FieldByName('id_brout').AsInteger<>-1 then
      frVariables['Zadv_OtvetOpen'+okon]:=qry.FieldByName('brig_out').AsString
    else
      frVariables['Zadv_OtvetOpen'+okon]:='';

    if (qry.FieldByName('dt_out').IsNull) or (qry.FieldByName('dt_out').AsDateTime=0) then
      frVariables['Zadv_DateOpen'+okon]:=''
    else
    begin
      DateTimeToString(dt_str, 'dd.mm.yy hh:mm', qry.FieldByName('dt_out').AsDateTime);
      frVariables['Zadv_DateOpen'+okon]:=dt_str;
    end;
  end else
  begin
    frVariables['Zadv_Adres'+okon]:='';
    frVariables['Zadv_Diam'+okon]:='';
    frVariables['Zadv_OtvetClose'+okon]:='';
    frVariables['Zadv_DateClose'+okon]:='';
    frVariables['Zadv_OtvetOpen'+okon]:='';
    frVariables['Zadv_DateOpen'+okon]:='';
  end;
end;

procedure TZayavRep.OnFirst_NotFirstViezdZadv(Sender: TObject);
begin
  DM_VedomPublic.Qry_NotFirstViezdZadv.First;
  if not DM_VedomPublic.Qry_NotFirstViezdZadv.Eof then LoadZadv(false, ltData);
end;

procedure TZayavRep.OnNext_NotFirstViezdZadv(Sender: TObject);
begin
  DM_VedomPublic.Qry_NotFirstViezdZadv.Next;
  if not DM_VedomPublic.Qry_NotFirstViezdZadv.Eof then LoadZadv(false, ltData)
  else LoadZadv(false, ltEmpty);
end;

procedure TZayavRep.LoadNar(IsFirst:boolean;LoadType: TLoadType );
var Works,Maters,UsedObor,diam:string;
   id_nar:integer;
   str:string;
begin
if Loadtype=ltData then
begin
with DM_VedomPublic.Qry_narad do begin
   id_nar:=FieldByName('id').asinteger;
   if  not FieldByName('dt_in').IsNull then
   begin
     DateTimeToString(str,'dd.mm.yyyy',FieldByName('dt_in').AsDateTime);
     frVariables['DateBeginWork2']:=str;
     DateTimeToString(str,'hh.mm',FieldByName('dt_in').AsDateTime);
     frVariables['TimeBeginWork2']:=str;
   end
   else  begin
    frVariables['DateBeginWork2']:='';//дата начала выезда
    frVariables['TimeBeginWork2']:='';//время начала выезда
   end  ;

   if  not FieldByName('dt_out').IsNull then
   begin
     DateTimeToString(str,'dd.mm.yyyy',FieldByName('dt_out').AsDateTime);
     frVariables['DateEndWork2']:=str;
     DateTimeToString(str,'hh.mm',FieldByName('dt_out').AsDateTime);
     frVariables['TimeEndWork2']:=str;
   end
   else  begin
    frVariables['DateEndWork2']:='';//дата начала выезда
    frVariables['DateEndWork2']:='';//время начала выезда
   end ;
   if FieldByName('dop_inf').IsNull then
      frVariables['UtochPovrezhd']:=addprobf('',270)// уточняющая инф
   else
       frVariables['UtochPovrezhd']:=addprobf(FieldByName('dop_inf').AsString,270);
   if FieldByName('name_r').IsNull then
      frVariables['Isp']:=''// уточняющая инф
   else
       frVariables['Isp']:=FieldByName('name_r').AsString;
    if  not FieldByName('dolgn').IsNull then
       frVariables['Isp']:=frVariables['Isp']+'['+FieldByName('dolgn').AsString+']';

end;
works:='';

with DM_VedomPublic.QryWorks do begin
 if  Active then
  Close;
 ParamByName('id_nar').AsInteger:=id_nar;
 Open;
 First;
 while not Eof do
 begin
   works:=works+', '+FieldByName('name_r').asstring;
  Next;
 end;
end;
delete (works,1,1);
ADDPROB(WORKS,270);
frVariables['Works']:=Works;
maters:='';
with DM_VedomPublic.QryMaters do begin
 if  Active then
  Close;
 ParamByName('id_nar').AsInteger:=id_nar;
 Open;
 First;
 while not Eof do
 begin
   maters:=maters+', '+FieldByName('name_r').asstring+' ';
   if FieldByName('diam').AsInteger>0 then
   maters:=maters+' '+'диаметр-'+FieldByName('diam').asstring;

   maters:=maters+' '+FieldByName('kol_mat').asstring+FieldByName('ed_izm').asstring;
  Next;
 end;
end;
delete (maters,1,1);
addprob(maters,270);
frVariables['Maters']:=maters;

UsedObor:='';
with DM_VedomPublic.QryObor do begin
 if  Active then
  Close;
 ParamByName('id_nar').AsInteger:=id_nar;
 Open;
 First;
 while not Eof do
 begin
   UsedObor:=UsedObor+', '+FieldByName('name_r').asstring;
  Next;
 end;
end;
delete (UsedObor,1,1);
addprob(UsedObor,270);
frVariables['UsedObors']:=UsedObor;
end
else
begin
frVariables['DateBeginWork2']:='';//дата начала выезда
frVariables['TimeBeginWork2']:='';//время начала выезда
frVariables['DateEndWork2']:='';//дата конца выезда
frVariables['NimeEndWork2']:='';//время конца выезда
frVariables['UtochPovrezhd']:='';// уточняющая инф
frVariables['Works']:='';
frVariables['Maters']:='';
frVariables['UsedObors']:='';
end;
end;

procedure TZayavRep.OnFirst_Nar(Sender: TObject);
begin
 while (DM_VedomPublic.Qry_narad.FieldByName('id').IsNull)and (not DM_VedomPublic.Qry_narad.Eof) do
   DM_VedomPublic.Qry_narad.Next;
 if (not DM_VedomPublic.Qry_narad.Eof) then
  LoadNar(true,ltData);
end;

procedure TZayavRep.OnNext_Nar(Sender: TObject);
begin
 if (not DM_VedomPublic.Qry_narad.Eof) then
  LoadNar(true,ltData);
//DM_VedomPublic.Qry_narad.next;
end;



end.
