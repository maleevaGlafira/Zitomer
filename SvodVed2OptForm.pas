unit SvodVed2OptForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, ComCtrls, StdCtrls, Mask, ToolEdit, ExtCtrls,
  Buttons;

type
  Tfrm_SvodVed2Opt = class(Tfrm_BaseOption)
    dp_Time: TDateTimePicker;
    dp_Date: TDateEdit;
    btn_revs: TBitBtn;
    btn_ok: TBitBtn;
    btn_cancel: TBitBtn;
    Bevel1: TBevel;
    Label1: TLabel;
    Bevel2: TBevel;
    gb_Attach: TGroupBox;
    chb_Voda: TCheckBox;
    chb_Kanal: TCheckBox;
    chb_Vrk: TCheckBox;
    GroupBox1: TGroupBox;
    chb_Close: TCheckBox;
    chb_Open: TCheckBox;
    chb_Viesnen: TCheckBox;
    chb_Lozh: TCheckBox;
    chb_otl: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure btn_revsClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure btn_cancelClick(Sender: TObject);
  protected
    F_RevsName, F_RevsID: string;
    function GetRevsName: string;
    function GetZavTypeNames: string; virtual;
  public
    property RevsName: string read GetRevsName;
    property ZavTypeNames: string read GetZavTypeNames;
    property RevsID: string read F_RevsID;
    constructor Create(AOwner: TComponent; Title: string);
    procedure Translate;override;

  end;


implementation

{$R *.dfm}

uses Selform, ServiceFuncUnit,frmLANG,cntsLANG;

{ Tfrm_SvodVed2Opt }

constructor Tfrm_SvodVed2Opt.Create(AOwner: TComponent; Title: string);
begin
  inherited Create(AOwner);
  Caption:=Title;
end;

procedure Tfrm_SvodVed2Opt.FormShow(Sender: TObject);
begin
  inherited;
  F_RevsName := '';
  F_RevsID := '';
end;

procedure Tfrm_SvodVed2Opt.btn_revsClick(Sender: TObject);
var
  sel_frm: TSelectForm;
begin
  sel_frm:=TSelectForm.Create(self);
  sel_frm.Query.SQL.Text:='select id code,name_r pole1 from s_revs where (id>0) and del=''-''';
  sel_frm.ShowModal;
  F_RevsID:=sel_frm.Temp_Code;
  F_RevsName:=sel_frm.SelText;
end;


procedure Tfrm_SvodVed2Opt.btn_okClick(Sender: TObject);
begin
  if (dp_Date.Date=0) or (not IsDateCorrect(dp_Date.Text)) then
  begin
  {  Application.MessageBox('Дата не введена или введена неверно. Попробуйте еще раз.',
                            'Диспетчер АВР', MB_OK+MB_ICONWARNING);}
    MessageDlg( TrLangMSG(msgErrorDate)+' '+TrLangMSG(msgTryAgain),
           mtError, [mbOk], 1);
    exit;
  end;

  ModalResult:=mrOK;
end;

procedure Tfrm_SvodVed2Opt.btn_cancelClick(Sender: TObject);
begin
  Close;
end;

function Tfrm_SvodVed2Opt.GetRevsName: string;
begin
  Result:=trim(F_RevsName);
  if Result='' then Result:= TrLangMSG(msgAll); //'Все';
end;

function Tfrm_SvodVed2Opt.GetZavTypeNames: string;
  procedure _check( _chb: TCheckBox );
  begin
    if _chb.Checked then
      Result := Result + ', ' + trim( _chb.Caption );
  end;
begin
  Result := '';

  _check( chb_Close );
  _check( chb_Open );
  _check( chb_Viesnen );
  _check( chb_Lozh );
  _check( chb_otl );

  Delete( Result, 1, 2 );
end;

{ MessageDlg(
          TrLangMSG(msgDtDiskoncon), mtError, [mbOk], 1);}

procedure Tfrm_SvodVed2Opt.Translate;
begin
 Label1.Caption:= TrLangMSG(msgForShift);//За сутки
 btn_revs.Caption:= TrLangMSG(msgREV);// Участок
 btn_ok.Caption:=TrLangMSG(msgApply);
 btn_cancel.Caption:=TrLangMSG(msgCancel);
 gb_Attach.Caption:=TrLangMSG(msgPrinad);//Принадлежность
 chb_Kanal.Caption:=TrLangMSG(msgKANANAL);//Канализация
 chb_Voda.Caption:=TrLangMSG(msgVodoprovod) ;//Водопровод
 chb_Vrk.Caption:=TrLangMSG(msgZavVRK);//Заявки ВРК
 GroupBox1.Caption:=TrLangMSG(msgOrdertyptype);//Тип заявок
 chb_Close.Caption:=TrLangMSG(msgClosed);    //Закрытые
 chb_Open.Caption:=TrLangMSG(msgOpened); //Открытые
 chb_Viesnen.Caption:=TrLangMSG(msgOnConfirm); //На выяснении
 chb_Lozh.Caption:=TrLangMSG(msgLies);//Ложные
 chb_otl.Caption:=TrLangMSG(msgDeffered);//Отложенные
end;

end.
