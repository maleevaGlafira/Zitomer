unit s_dolgn;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  baze_dic, StdCtrls, Buttons, Grids, DBGrids, ExtCtrls, Placemnt, Menus,
  DBCtrls, DBTables, Db, RXDBCtrl, frmLANG, cntsLANG;

type
  TS_BrigF = class(TBazeDicF)
  public
    function TestInpData :boolean;override;
    function onBeforeDel(var CanConfirm :boolean; var WarnDelStr :string) :boolean;override;
    constructor CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);override;
    destructor Destroy;override;
    procedure Translate;override;
  end;

var
  S_BrigF: TS_BrigF;

implementation
  uses avartype, datam;

{$R *.DFM}
//*******************************************************************
constructor TS_BrigF.CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);
var
 fdl :TStringList;
begin
 inherited CreateDic(AOwner, TbName,KeyFd, DSur);
{ NewIDStorProcName:='NEWID_S_BRIG';
 Table_Name:='S_BRIG';}
 fdl:=TStringList.Create;
 fdl.Add('Name_r');
 fdl.Add('Dolgn');
 ListFindFields:=fdl;
 CurFindField:='Name_r';
 fdl.Free;
 SetLength(NotEmptyFields, 1);
 NotEmptyFields[0]:='Name_r';
 SetLength(UniqFields, 1);
 UniqFields[0]:='Name_r';
// RefreshCaption;
end;

//*******************************************************************
destructor TS_BrigF.Destroy;
begin
 inherited;
 S_BrigF:=nil
end;

//*******************************************************************
function TS_BrigF.TestInpData :boolean;
begin
 result:=inherited TestInpData;
(* if not result then exit;
 if {(not Empty_ValueInCt(DM1.S_Brig_q.FieldByName('Name_r'), self.handle,
         'Необходимо ввести ФИО')and}
    (Uniq_Value('SELECT ID FROM S_Brig'+#10+
              'WHERE (Name_r = "'+DM1.S_Brig_q.FieldByName('ID').asString+
              '")and(ID <> '+
               // IntToStr - чтобы при новой зап. IDParty = 0
               IntToStr(DM1.S_Brig_q.FieldByName('ID').asInteger)+')',
               DataGrid_dgr, Self.Handle,
               DM1.S_Brig_q.FieldByName('Name_r').asString+
               ' уже существует. Необходимо ввести'+#10+
               'ввести інший код або натиснути кнопку "Відміна".'))
   then result:=true
   else result:=false;
   *)
end;

//*******************************************************************
function TS_BrigF.onBeforeDel(var CanConfirm :boolean; var WarnDelStr :string) :boolean;
begin
 result:=inherited onBeforeDel(CanConfirm, WarnDelStr);
 WarnDelStr:=TrLangMSG(msgDelete)+' "'+CurDataSet.FieldByName('Name_r').asString+'" ?';
end;

//*******************************************************************
procedure TS_BrigF.Translate;
begin
  inherited;
  Caption:=TrLangMSG(msgSpravochOne)+' '+ansilowercase(TrLangMSG(msgDolzLic));
  DataGrid_dgr.Columns[0].Title.Caption:=TrLangMSG(msgFIO);
  DataGrid_dgr.Columns[1].Title.Caption:=TrLangMSG(msgResponse);
end;

end.
