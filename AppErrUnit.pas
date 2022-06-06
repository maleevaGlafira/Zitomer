unit AppErrUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,frmLANG, Appex, RGAppError;

type
  TAppErrForm = class(TFormLang)
    RGAppError: TRGAppError;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AppErrForm: TAppErrForm;

implementation

{$R *.dfm}

end.
