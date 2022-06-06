unit set_sah;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Grids, DBGrids, RXDBCtrl, RxLookup, StdCtrls, Buttons, frmLANG,
  cntsLANG,ServiceFuncUnit;

type
  TFormSSah = class(TFormLang)
    Qry_stzav: TQuery;
    Qry_ssod: TQuery;
    Qry_ssah: TQuery;
    DS_stzav: TDataSource;
    DS_ssod: TDataSource;
    DBL_tzav: TRxDBLookupCombo;
    DBG_sod: TRxDBGrid;
    Qry_ssodID: TIntegerField;
    Qry_ssodTYPE: TIntegerField;
    Qry_ssodNAME_R: TStringField;
    Qry_ssodSAH: TIntegerField;
    Qry_ssodSahLook: TStringField;
    Upd_ssod: TUpdateSQL;
    Label1: TLabel;
    BB_Close: TBitBtn;
    BB_Save: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBL_tzavChange(Sender: TObject);
    procedure DS_ssodUpdateData(Sender: TObject);
    procedure DBG_sodKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BB_CloseClick(Sender: TObject);
    procedure BB_SaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
     procedure Upd_sod;
     procedure Translate;override;
  end;

var
  FormSSah: TFormSSah;

implementation
 uses main;
{$R *.DFM}

procedure TFormSSah.FormCreate(Sender: TObject);
begin

  Qry_ssah.Open;
  Qry_stzav.Open;
  DBL_tzav.DisplayValue:=Qry_stzav.FieldByName('NAME_R').asString;
  Qry_ssod.Open;
  Upd_sod;
end;

procedure TFormSSah.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  Qry_ssod.Close;
  Qry_ssah.Close;
  Qry_stzav.Close;
  Action:=caFree;

end;


procedure TFormSSah.Upd_sod;
var old_id:integer;
begin
  old_id:=Qry_ssod.FieldByName('ID').asInteger;
  MyOpenSQL(Qry_ssod,'select * from s_sod where id>0 and ftype='+
                   Qry_stzav.FieldByName('ID').asString);
  Qry_Ssod.Locate('ID',old_id,[]);
end;

procedure TFormSSah.DBL_tzavChange(Sender: TObject);
begin
  Upd_Sod;
end;

procedure TFormSSah.DS_ssodUpdateData(Sender: TObject);
var sInd:integer;
begin
DS_ssod.OnUpdateData:=NIL;
 if Qry_ssod.Modified then
  Qry_ssod.Post;
 if Qry_ssod.UpdatesPending then
  begin
   Qry_ssod.ApplyUpdates;
   Qry_ssod.CommitUpdates;
   sInd:=DBG_sod.SelectedIndex;
   Upd_Sod; //RefreshBase(Qry_Obor);
   DBG_sod.SelectedIndex:=sInd;
  end;
DS_ssod.OnUpdateData:=DS_ssodUpdateData;

end;

procedure TFormSSah.DBG_sodKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=VK_DOWN)and (not (ssCtrl in shift))then
   begin
     Qry_ssod.MoveBy(1);
//     if Qry_ssod.EOF then
//        exit;
     Qry_ssod.moveby(-1);
   end;

  inherited KeyDown(Key, Shift);

end;

procedure TFormSSah.BB_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFormSSah.BB_SaveClick(Sender: TObject);
begin
 DS_ssodUpdateData(Self);
end;

{

select * from s_sah where id in (select sah from s_sod where ftype=1)

переходные
select count(id) from nzavjav where dt_in ВНЕ заданного периода

select count(id) from nzavjav where id_sod in
(select id from s_sod where sah=4)



select count(id) mm,0 mm1 from nzavjav where id_sod in
(select id from s_sod where sah=3)
union
select 0 mm,count(id) mm1 from zavjav where id_sod in
(select id from s_sod where sah=3)


}
procedure TFormSSah.Translate;
begin
  inherited;
  Caption:=TrLangMSG(msgSetupVedPovr);
  DBG_sod.Columns[0].Title.Caption:=TrLangMSG(msgDesign);
  DBG_sod.Columns[1].Title.Caption:=TrLangMSG(msgVedomOne);
  BB_Close.Caption:=TrLangMSG(msgExit);
  BB_Save.Caption:=TrLangMSG(msgSave);
end;

end.
