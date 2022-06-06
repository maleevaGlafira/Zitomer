unit SecurityBaseForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,FRMLANG;

type
  Tfrm_SecurityBase = class(TFormLang)
  protected
    class function IsCurrentUserCanEdit: boolean; virtual;
    class function IsCurrentDistrictCanAccessRegion(RegionID: integer): boolean; virtual;

     class function GetDistrictID: integer;//2012.02
  public
    class function GetGUID: string; virtual; abstract;
  end;


implementation

{$R *.dfm}




{ Tfrm_SecurityBase }

class function Tfrm_SecurityBase.IsCurrentUserCanEdit: boolean;
begin
  Result:=true;
end;

class function Tfrm_SecurityBase.IsCurrentDistrictCanAccessRegion(RegionID: integer): boolean;
begin
  Result:=true;
end;


class function Tfrm_SecurityBase.GetDistrictID: integer; //2012.02
begin
  Result := 1;
end;
end.
