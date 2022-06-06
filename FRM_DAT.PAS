unit frm_dat;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, Mask, ToolEdit,frmLANG,cntsLANG;

type
  TFrm_Date = class(TFrame)
    Label1: TLabel;
    DE_In: TDateEdit;
    Te_in: TDateTimePicker;
    Label2: TLabel;
    DE_Out: TDateEdit;
    Te_Out: TDateTimePicker;
    function DateTime2SQL:string;
    function DateTime2Tit:string;
//    function Time2Str(InTime:TDateTime):string;
    procedure SetT_db(value:string);
    procedure SetMin_dt(value:string);
    procedure SetMax_dt(value:string);
  private
    { Private declarations }
    Ft_db:string;
    Fmin_dt:string;
    Fmax_dt:string;
    Fn_db:byte;
    Fn_min:byte;
    Fn_max:byte;
  public
    { Public declarations }
//    IsDateIn :boolean;
    constructor Create(AOwner: TComponent); override;
    function CheckFields :boolean;
    property t_db:string read Ft_db write SetT_db;
    property n_db:byte read Fn_db write Fn_db default 0;

    property min_dt:string read Fmin_dt write SetMin_dt;
    property n_min:byte read Fn_min write Fn_min default 0;

    property max_dt:string read Fmax_dt write SetMax_dt;
    property n_max:byte read Fn_max write Fn_max default 0;

    property SQLStr:string read DateTime2SQL;
    property TitStr:string read DateTime2Tit;
    procedure SetNull;
    function getDateIn:TDateTime;
    function getDateOut:TDateTime;
    function CorrextDates():boolean;
    procedure setDateIn(d:TDateTime);
    procedure setDateOut(d:TDateTime);

  end;

implementation
  uses strtool, avartype;
{$R *.DFM}

function TFrm_Date.DateTime2SQL:string;
var tt_str,revs_sql:string;
begin
   if Fn_db=0 then
      Ft_db:=' z';
   if Fn_min=0 then
      FMin_dt:='dt_in';
   if Fn_max=0 then
      FMax_dt:='dt_in';
   revs_sql:=' and (delz=0) ';
          if Strip('A','. ',DE_In.Text)<>'' then
            begin
              revs_sql:=revs_sql+' and '+Ft_db+'.'+FMin_dt+'>="'+DE_In.Text;
              tt_str:=Strip('A',' ',Time2Str(TE_In.Time));
              if Strip('A',':',tt_str)<>'' then
                begin
                 revs_sql:=revs_sql+' '+tt_str+'"';
                end
              else
                 revs_sql:=revs_sql+'"';
            end;

          if Strip('A','. ',DE_Out.Text)<>'' then
            begin
              revs_sql:=revs_sql+' and '+Ft_db+'.'+FMax_dt+'<="'+DE_Out.Text;
              tt_str:=Strip('A',' ',time2str(TE_Out.Time));
              if Strip('A',':',tt_str)<>'' then
                begin
                 revs_sql:=revs_sql+' '+tt_str+'"';
                end
              else
                 revs_sql:=revs_sql+' 23:59"';
            end;
  Result:=revs_sql;
end;

function TFrm_Date.DateTime2Tit:string;
var tt_str,tt_tit:string;
begin
   tt_tit:='';
          if Strip('A','. ',DE_In.Text)<>'' then
            begin
              tt_tit:=tt_tit+' '+TrLangMSG(msgFrom)+' "'+DE_In.Text+'"';
              tt_str:=Strip('A',' ',Time2Str(TE_In.Time));
              if Strip('A',':',tt_str)<>'' then
                 tt_tit:=tt_tit+' "'+tt_str+'"';
            end;

          if Strip('A','. ',DE_Out.Text)<>'' then
            begin
              tt_tit:=tt_tit+' по "'+DE_Out.Text+'"';
              tt_str:=Strip('A',' ',time2str(TE_Out.Time));
              if Strip('A',':',tt_str)<>'' then
                 tt_tit:=tt_tit+' "'+tt_str+'"';
            end;
  Result:=tt_tit;
end;

procedure TFrm_Date.SetT_db(value:string);
  begin
    FT_db:=value;
    if value<>'' then
       Fn_db:=1
    else
       Fn_db:=0;
  end;

procedure TFrm_Date.SetMin_dt(value:string);
  begin
    FMin_dt:=value;
    if value<>'' then
       Fn_Min:=1
    else
       Fn_Min:=0;
  end;

procedure TFrm_Date.SetMax_dt(value:string);
  begin
    FMax_dt:=value;
    if value<>'' then
       Fn_Max:=1
    else
       Fn_Max:=0;
  end;

procedure TFrm_Date.SetNull;
  begin
    FMax_dt:='';
    Fn_Max:=0;
    FMin_dt:='';
    Fn_Min:=0;
    FT_db:='';
    Fn_db:=0;

  end;

//*******************************************************************
function TFrm_Date.CheckFields :boolean;
begin
 result:=(Trim(copy(DE_In.Text,1,2)) <> '')and{DE_In}
         (Trim(copy(DE_In.Text,4,2)) <> '')and
         (Trim(copy(DE_In.Text,7,4)) <> '')and
         (Trim(copy(DE_Out.Text,1,2)) <> '')and{DE_Out}
         (Trim(copy(DE_Out.Text,4,2)) <> '')and
         (Trim(copy(DE_Out.Text,7,4)) <> '')
         (*and

         (Trim(copy(TE_In.Time,1,2)) <> '')and{TE_In}
         (Trim(copy(TE_In.Text,4,2)) <> '')and
         (Trim(copy(TE_In.Text,7,2)) <> '')and
         (Trim(copy(TE_Out.Text,1,2)) <> '')and{DE_Out}
         (Trim(copy(TE_Out.Text,4,2)) <> '')and
         (Trim(copy(TE_Out.Text,7,2)) <> '')and*)
end;

//*******************************************************************
constructor TFrm_Date.Create(AOwner: TComponent);
begin
  inherited;
  Label1.caption:=TrLangMSG(msgFrom);
end;

function TFrm_Date.getDateIn:TDateTime;

begin

 result:=DE_In.Date+Te_in.date-trunc(Te_in.date);;
end;

function TFrm_Date.getDateOut:TDateTime;
begin
 result:=DE_Out.Date+Te_Out.Time-trunc(te_out.Time);
end;

function TFrm_Date.CorrextDates():boolean;
begin
result:=(getDateIn()<=getDateOut);
end;

procedure TFrm_Date.setDateIn(d:TDateTime);
begin
 De_in.Date:=d;
 Te_in.Time:=d ;
end;


procedure TFrm_Date.setDateOut(d:TDateTime);
begin
 De_out.Date:=d;
 Te_out.Time:=d ;
end;



end.
