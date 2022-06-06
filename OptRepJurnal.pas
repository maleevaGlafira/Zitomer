unit OptRepJurnal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, StdCtrls, Buttons, DB, IBCustomDataSet,
  RxLookup, Mask, ToolEdit, BaseItemSelecterFrame, SelOwnerFrame,
  SelRevsFrame;

type
  Tfrm_OptRepJurnal = class(Tfrm_BaseOption)
    dt_in: TDateEdit;
    rle_revs: TRxLookupEdit;
    Label1: TLabel;
    Label2: TLabel;
    dset_revs: TIBDataSet;
    ds_revs: TDataSource;
    btn_ok: TBitBtn;
    btn_cancel: TBitBtn;
    cb_otl: TCheckBox;
    frame_SelOwner1: Tframe_SelOwner;
    frame_SelRevs1: Tframe_SelRevs;
    procedure FormCreate(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure btn_cancelClick(Sender: TObject);
    procedure frame_SelOwner1btn_SelItemClick(Sender: TObject);
    procedure frame_SelRevs1btn_SelItemClick(Sender: TObject);
  private
    Fdat: TDate;
    F_attach:integer;
    F_revname:string;
    f_alienid:string;
    { Private declarations }
    f_revsid:string;
    F_revnames:string;
    function getDate():TDate;
    function getRev():integer;
    function getIsOtl():boolean;
    procedure Setdat(const Value: TDate);

  public
    { Public declarations }

    property dat:TDate read getDate ;
    property idRev:integer read getRev;
    property isOtl:boolean read getIsOtl;
    property attach:integer read F_attach;
    property revname:string read F_revname;
    property idALien:string read f_alienid;
    property revnames:string read F_revnames;
    property revsid:string read f_revsid;
  end;

var
  frm_OptRepJurnal: Tfrm_OptRepJurnal;

implementation

{$R *.dfm}


{ Tfrm_BaseOption1 }
uses DMmain;

function Tfrm_OptRepJurnal.getDate: TDate;
begin

result:=dt_in.Date;
end;

function Tfrm_OptRepJurnal.getIsOtl: boolean;
begin
result:=cb_otl.Checked;
end;

function Tfrm_OptRepJurnal.getRev: integer;
begin
result:=dset_revs.fieldbyname('id').AsInteger;
end;

procedure Tfrm_OptRepJurnal.Setdat(const Value: TDate);
begin
  Fdat := Value;
end;

procedure Tfrm_OptRepJurnal.FormCreate(Sender: TObject);
begin
  inherited;
dset_revs.Open;
dt_in.Date:=Date()-1;
dset_revs.First;
dset_revs.Next;
rle_revs.LookupValue:=dset_revs.fieldbyname('id').AsString;

end;

procedure Tfrm_OptRepJurnal.btn_okClick(Sender: TObject);
begin
  inherited;
F_attach:=ord(OperateAttach);
if dset_revs.fieldbyname('id').asinteger>0 then
f_revName:=dset_revs.fieldbyname('name_r').AsString
else
f_revName:='';
if dt_in.Date>Date() then
begin
 ShowMessage('Дата больще текущей');
 exit;

end;
ModalResult:=MrOk;

end;

procedure Tfrm_OptRepJurnal.btn_cancelClick(Sender: TObject);
begin
  inherited;
ModalResult:=mrCancel;
end;

procedure Tfrm_OptRepJurnal.frame_SelOwner1btn_SelItemClick(
  Sender: TObject);
begin
  inherited;
  frame_SelOwner1.btn_SelItemClick(Sender);
  f_alienid:=frame_SelOwner1.ItemSelecter.SelItemList.ItemsID;
end;

procedure Tfrm_OptRepJurnal.frame_SelRevs1btn_SelItemClick(
  Sender: TObject);
begin
  inherited;
  frame_SelRevs1.btn_SelItemClick(Sender);
  f_revsid:=frame_SelRevs1.ItemSelecter.SelItemList.ItemsID;
  F_revnames:=frame_SelRevs1.ItemSelecter.SelItemList.ItemsName;
end;

end.
