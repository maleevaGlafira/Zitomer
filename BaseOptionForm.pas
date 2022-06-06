unit BaseOptionForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OperAttFormUnit, Vxod;

type
  Tfrm_BaseOption = class(TOperAttForm)
    procedure FormShow(Sender: TObject);
  private
  public
    constructor Create( AOwner: TComponent; ATitle: string ); overload;
  end;


implementation

{$R *.dfm}

constructor Tfrm_BaseOption.Create(AOwner: TComponent; ATitle: string);
begin
  inherited Create( AOwner );
  Caption := ATitle;
end;

procedure Tfrm_BaseOption.FormShow(Sender: TObject);
begin
  inherited;
  OperAttFormFill(nil);
end;

end.
