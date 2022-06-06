unit logform;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  baze_dic, Menus, Placemnt, Grids, DBGrids, RXDBCtrl, DBCtrls, StdCtrls,
  Buttons, ExtCtrls, db, RxLookup, frm_dat, frmLANG, cntsLANG;

type
  TLogFilter = (lfDate, lfUsers);
  TSetLogFilter = set of TLogFilter;

  TTableLogF = class(TBazeDicF)
    Frm_Dt: TFrm_Date;
    BDateFilter: TSpeedButton;
    BClearDic: TSpeedButton;
    Users_lcb: TRxDBLookupCombo;
    procedure BClearDicClick(Sender: TObject);
    procedure Users_lcbCloseUp(Sender: TObject);
    procedure BDateFilterClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    FLogFilter :TSetLogFilter;
    FLogFiltered :boolean;
    procedure SetLogFiltered(fl :boolean);

  public
    procedure CtrlState;override;
    property LogFilter :TSetLogFilter read FLogFilter write FLogFilter;
    property LogFiltered :boolean read FLogFiltered write SetLogFiltered;
    constructor CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);override;
    destructor Destroy;override;
    procedure Translate;override;
  end;

var
  TableLogF: TTableLogF;

implementation
  uses datam, main, avartype;

{$R *.DFM}
//*******************************************************************
constructor TTableLogF.CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);
var
 fdl :TStringList;
begin
 inherited CreateDic(AOwner, TbName,KeyFd, DSur);
 BClearDic.Anchors:=[akLeft,akBottom];
 Users_lcb.Anchors:=[akLeft,akBottom];
 Frm_Dt.Anchors:=[akLeft,akBottom];
 BDateFilter.Anchors:=[akLeft,akBottom];

 Read_Only:=true;
 fdl:=TStringList.Create;
 fdl.Add('User_Name');
 fdl.Add('OLD_VALUE');
 fdl.Add('NEW_VALUE');
 ListFindFields:=fdl;
 CurFindField:='NEW_VALUE';
 fdl.Free;
 if not DM1.Users_q.Active then DM1.Users_q.Open;

{ SetLength(NotEmptyFields, 1);
 NotEmptyFields[0]:='Name_r';
 SetLength(UniqFields, 1);
 UniqFields[0]:='Name_r';}
end;

//*******************************************************************
destructor TTableLogF.Destroy;
begin
 inherited;
 TableLogF:=nil;
end;

//*******************************************************************
procedure TTableLogF.BClearDicClick(Sender: TObject);
begin
 inherited;
 DM1.tempQr_q.SQL.Clear;
 DM1.tempQr_q.SQL.text:='delete from TableLog';
 try
  DM1.tempQr_q.ExecSQL;
  BRefrClick(self);
 except
 end;
end;

//*******************************************************************
procedure TTableLogF.CtrlState;
begin
 inherited;
 BRefr.Enabled:=true;
end;

//*******************************************************************
procedure TTableLogF.Users_lcbCloseUp(Sender: TObject);
begin
 LogFilter:=LogFilter + [lfUsers];
 LogFiltered:=true;
end;

//*******************************************************************
procedure TTableLogF.BDateFilterClick(Sender: TObject);
begin
 with Frm_Dt do
  begin
   if not ProvDate(DE_in.Date,DE_Out.Date,Time2Str(TE_in.Time),Time2Str(TE_out.Time))
      then exit;
   if not CheckFields
      then {отмена фильтрации} LogFilter:=LogFilter - [lfDate]
      else LogFilter:=LogFilter + [lfDate];
   LogFiltered:=(LogFilter <> []);
  end; // with
end;

//*******************************************************************
procedure TTableLogF.SetLogFiltered(fl :boolean);
var
 str1 :string;
begin
 str1:='';
 if fl then
   begin
     if lfDate in LogFilter   then
        str1:=str1 +'(DATE_CHANGE >= '+chr(39)+frm_Dt.DE_In.Text+' '+
              Time2Str(frm_Dt.TE_In.Time)+chr(39)+ ')and(DATE_CHANGE <= '+chr(39)+
              frm_Dt.DE_Out.Text+' '+Time2Str(frm_Dt.TE_Out.Time)+chr(39)+')';

     if (lfUsers in LogFilter)and
        (StrToIntDef(Users_lcb.Value, -1) > 0) then
       begin
        if str1 <> '' then str1:=str1 + ' and ';
        str1:=str1 + 'USER_NAME = '+chr(39)+Users_lcb.Text+chr(39);
       end;

     DM1.TableLog_q.Filter:=str1;
    end; // if fl ...

  DM1.TableLog_q.Filtered:=(fl)and(str1 <> '');
end;

//*******************************************************************
procedure TTableLogF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 DM1.Users_q.Active:=false;
 inherited;
end;

//*******************************************************************
procedure TTableLogF.Translate;
begin
  inherited;
  Caption:=TrLangMSG(msgHistoryChanges);
  BClearDic.Hint:=TrLangMSG(msgClear)+' журнал';
  BDateFilter.Hint:=TrLangMSG(msgUseFilterDate);
  DataGrid_dgr.Columns[0].Title.Caption:=TrLangMSG(msgUserOne);
  DataGrid_dgr.Columns[1].Title.Caption:=TrLangMSG(msgOldValue);
  DataGrid_dgr.Columns[2].Title.Caption:=TrLangMSG(msgNewValue);
end;

end.
