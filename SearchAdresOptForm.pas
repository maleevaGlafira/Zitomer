unit SearchAdresOptForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, StdCtrls, Mask, ToolEdit, Buttons, RXSpin,
  ExtCtrls;

type
  Tfrm_SearchAdresOpt = class(Tfrm_BaseOption)
    dp_Date1: TDateEdit;
    dp_Date2: TDateEdit;
    sp_DmgCount: TRxSpinEdit;
    btn_Revs: TBitBtn;
    btn_Place: TBitBtn;
    btn_Diam: TBitBtn;
    btn_ok: TBitBtn;
    btn_exit: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Label4: TLabel;
    cb_SortType: TComboBox;
    Bevel4: TBevel;
    procedure btn_okClick(Sender: TObject);
    procedure btn_RevsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_PlaceClick(Sender: TObject);
    procedure btn_DiamClick(Sender: TObject);
    procedure btn_exitClick(Sender: TObject);
  private
    F_Dt_beg: TDate;
    F_Dt_end: TDate;
    F_RevsID: string;
    F_strRevs: string;
    F_PlaceID: string;
    F_strPlace: string;
    F_DiamID: string;
    F_strDiam: string;
    F_DmgCount: integer;
    F_IsDescSort: boolean;
  public
    property Dt_beg: TDate read F_Dt_beg;
    property Dt_end: TDate read F_Dt_end;
    property RevsID: string read F_RevsID;
    property strRevs: string read F_strRevs;
    property PlaceID: string read F_PlaceID;
    property strPlace: string read F_strPlace;
    property DiamID: string read F_DiamID;
    property strDiam: string read F_strDiam;
    property DmgCount: integer read F_DmgCount;
    property IsDescSort: boolean read F_IsDescSort;

    constructor Create(AOwner: TComponent; Title: string);
  end;


implementation

{$R *.dfm}

uses SelForm;

{ Tfrm_SearchAdresOpt }

constructor Tfrm_SearchAdresOpt.Create(AOwner: TComponent; Title: string);
begin
  inherited Create(AOwner);
  Caption:=Title;
end;

procedure Tfrm_SearchAdresOpt.btn_okClick(Sender: TObject);

begin
  if dp_Date1.Date=0 then
  begin
    Application.MessageBox('Дата начала периода введена неверно.', 'Диспетчер АВР', MB_OK+MB_ICONWARNING);
    exit;
  end;

  if dp_Date2.Date=0 then dp_Date2.Date:=Date;
{
  if dp_Date2.Date=0 then
  begin
    Application.MessageBox('Дата окончания периода введена неверно.', 'Диспетчер АВР', MB_OK+MB_ICONWARNING);
    exit;
  end;
}

  if dp_Date1.Date>dp_Date2.Date then
  begin
    Application.MessageBox('Дата окончания не может быть больше даты начала.', 'Диспетчер АВР', MB_OK+MB_ICONWARNING);
    exit;
  end;

  F_Dt_beg:=dp_Date1.Date;
  F_Dt_end:=dp_Date2.Date;
  F_DmgCount:=trunc(sp_DmgCount.Value);
  F_IsDescSort:=(cb_SortType.ItemIndex=1);

  ModalResult:=mrOk;
end;

procedure Tfrm_SearchAdresOpt.btn_RevsClick(Sender: TObject);
var
  sql: string;
begin
  sql:='select id code,name_r pole1 from s_revs where (id>0) and del=''-''';
  ShowSelectItemDlg(sql, F_RevsID, F_strRevs);
end;

procedure Tfrm_SearchAdresOpt.FormShow(Sender: TObject);
begin
  inherited;
  F_strRevs:='Все';
  F_strPlace:='Все';
  F_strDiam:='Все';

  F_RevsID:='';
  F_PlaceID:='';
  F_DiamID:='';
end;

procedure Tfrm_SearchAdresOpt.btn_PlaceClick(Sender: TObject);
var
  sql: string;
begin
  sql:=
    ' select id code, name_r pole1'+
    ' from s_place'+
    ' where (id>0) and del=''-'' order by name_r';
  ShowSelectItemDlg(sql, F_PlaceID, F_strPlace);
end;

procedure Tfrm_SearchAdresOpt.btn_DiamClick(Sender: TObject);
var
  sql: string;
begin
  sql:=
    ' select id code, diam pole1'+
    ' from s_diam'+
    ' where (id>0) and del=''-'' order by diam';
  ShowSelectItemDlg(sql, F_DiamID, F_strDiam);
end;

procedure Tfrm_SearchAdresOpt.btn_exitClick(Sender: TObject);
begin
  Close;
end;

end.
