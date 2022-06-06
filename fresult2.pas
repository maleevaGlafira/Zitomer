unit fresult2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fresult, ExtCtrls, Menus, DB, DBTables, ComCtrls, StdCtrls,
  Buttons, RXCtrls, Grids, Aligrid, Spin, OperAttFormUnit;

type
  TFormResult2 = class(TFormResult)
    procedure BB_zavClick(Sender: TObject);
    procedure StrGr_resDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

 uses strtool,zav,prosm,main,ComObj, XLConst,OpSqlex, avartype,spreadsh,
  datam, FormZavFactory;

procedure TFormResult2.BB_zavClick(Sender: TObject);
var ZvForm:TFormZav;
begin
  if not Assigned(StrGr_res.Objects[0,StrGr_Res.Row])then exit;
  ZvForm:=TFormZav_ZavCreate(Self,tfmZayavAfterInsert,integer(StrGr_res.Objects[0,StrGr_Res.Row]));
  try
    ZvForm.ShowModal;
     if CloseStatus<>0 then
         repeat
           if CloseStatus=2 then
             ZvForm:=TFormZav_ZavCreate(Self,tfmZayavCopy,ZavToCopy)
           else
             ZvForm:=TFormZav_ZavCreate(Self,tfmZayavNew,0);

           ZvForm.ShowModal;
         until CloseStatus=0;
   finally
    //ZvForm.Free;
    //ZvForm.Close;
    //
    {$IFDEF MAP}
    if (MAP_IS_WORK) then
      begin
        DM_GateSpisOfAvar.ReConnectEventsToManager;
      end;
    {$ENDIF}
   end;
  //             tstringgrid
{uo
  StrGr_Res.RowCount:=2;
  if isFillGrid then UpdAll;
}
end;


procedure TFormResult2.StrGr_resDblClick(Sender: TObject);
begin
 if BB_zav.Visible then
   BB_zavClick(Sender);
end;

end.
