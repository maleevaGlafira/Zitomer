unit AddRaskopForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, RaskopFrame, NGRaskopDM,frmLANG;

type
  Tfrm_AddRaskop = class(TFormLang)
    btn_ok: TBitBtn;
    btn_cancel: TBitBtn;
    btn_Add: TBitBtn;
    frame_Raskop: Tframe_Raskop;
    btn_Copy: TBitBtn;
    procedure btn_AddClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure btn_cancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_CopyClick(Sender: TObject);
  private
    F_Raskop: Tdm_NGRaskop;
    procedure OnChangeEnabledBtnsHandler(_EnabledBtns: TEnabledBtns);
  public
    constructor Create( AOwner: TComponent; ARaskop: Tdm_NGRaskop );
    procedure Translate;override;
  end;

implementation

{$R *.dfm}

{ Tfrm_AddRaskop }
uses cntsLANG;

constructor Tfrm_AddRaskop.Create(AOwner: TComponent;
  ARaskop: Tdm_NGRaskop);
begin
  inherited Create( AOwner );
  F_Raskop := ARaskop;

  frame_Raskop.Raskop := F_Raskop;
  frame_Raskop.IsShowTabs := true;
  frame_Raskop.OnChangeEnabledBtns := OnChangeEnabledBtnsHandler;
  frame_Raskop.Init;
end;

procedure Tfrm_AddRaskop.Translate;
begin
 self.Caption:=TrLangMSG(msgAddExcav);
 btn_Add.Caption:=TrLangMSG( msgAdd);
 btn_cancel.Caption:=TrLangMSG( msgCancel);
 btn_Copy.Caption:=TrLangMSG( msgCopy); 
 btn_ok.Caption:=TrLangMSG( msgApply);
 frame_Raskop.Translate;
end;

procedure Tfrm_AddRaskop.OnChangeEnabledBtnsHandler(
  _EnabledBtns: TEnabledBtns);
begin
  btn_Add.Enabled := _EnabledBtns.EnabledAdd;
  btn_Copy.Enabled := _EnabledBtns.EnabledCopy;
  btn_ok.Enabled := _EnabledBtns.EnabledPost;
end;

procedure Tfrm_AddRaskop.btn_AddClick(Sender: TObject);
begin
  frame_Raskop.AddRaskop;
end;

procedure Tfrm_AddRaskop.btn_okClick(Sender: TObject);
begin
  frame_Raskop.PostRaskop;
  ModalResult := mrOk;
end;

procedure Tfrm_AddRaskop.btn_cancelClick(Sender: TObject);
begin
  frame_Raskop.CancelRaskop;
  Close;
end;

procedure Tfrm_AddRaskop.FormShow(Sender: TObject);
begin
  if btn_Add.Visible and btn_Add.Enabled then
    btn_Add.SetFocus;
end;

procedure Tfrm_AddRaskop.btn_CopyClick(Sender: TObject);
begin
  frame_Raskop.CopyRaskop;
end;

end.
