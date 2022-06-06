unit EditMaterForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls, RxLookup, DB, MaterDM,
  frmLANG;

type
  Tfrm_EditMater = class(TFormLang)
    Bevel1: TBevel;
    btn_ok: TBitBtn;
    btn_exit: TBitBtn;
    dbl_Mat: TRxDBLookupCombo;
    dbl_Diam: TRxDBLookupCombo;
    ed_KolMat: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ds_S_Mat: TDataSource;
    ds_Main: TDataSource;
    ds_S_Diam: TDataSource;
    procedure btn_okClick(Sender: TObject);
    procedure btn_exitClick(Sender: TObject);
  private
    F_Mater: Tdm_Mater;
  public
    constructor Create( AOwner: TComponent; AMater: Tdm_Mater );
    procedure Translate;override;
  end;


implementation

{$R *.dfm}
 uses cntsLANG;
{ Tfrm_EditMater }
procedure Tfrm_EditMater.Translate();
begin
   self.Caption:=TrLangMSG(msgEditMater);
   Label1.Caption:=TrLangMSG(msgMaterOne);
   Label2.Caption:=TrLangMSG(msgDiam);
   Label3.Caption:=TrLangMSG(msgCountBig);
   btn_ok.Caption:=TrLangMSG(msgApply);
   btn_exit.Caption:=TrLangMSG(msgCancel);

end;

constructor Tfrm_EditMater.Create(AOwner: TComponent; AMater: Tdm_Mater);
begin
  inherited Create( AOwner );
  F_Mater := AMater;
end;

procedure Tfrm_EditMater.btn_okClick(Sender: TObject);
var
  _ErrMsg: string;
  _ErrFieldOrd: integer;
begin
  if not F_Mater.IsInputValuesCorrect( _ErrMsg, _ErrFieldOrd ) then
  begin
    case _ErrFieldOrd of
      Ord( mfMater ): dbl_Mat.SetFocus;
    end;
    //
    MessageDlg(_ErrMsg,mtwarning,[mbok], 0);
   // Application.MessageBox( PChar( _ErrMsg ), 'Внимание', MB_OK + MB_ICONWARNING );
  end else
    ModalResult := mrOk;
end;

procedure Tfrm_EditMater.btn_exitClick(Sender: TObject);
begin
  Close;
end;

end.
