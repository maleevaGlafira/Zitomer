unit ItemSelecterDModule;

interface

uses
  SysUtils, Classes, DMMain, IBDatabase, DB, IBCustomDataSet;

type
  Tdm_ItemSelecter = class(TDataModule)
    dset: TIBDataSet;
    tran: TIBTransaction;
  private
  public
    procedure StartTransaction;
    procedure StopTransaction;
  end;


implementation

{$R *.dfm}

{ Tdm_ItemSelecter }

procedure Tdm_ItemSelecter.StartTransaction;
begin
  if not tran.InTransaction then tran.StartTransaction;
end;

procedure Tdm_ItemSelecter.StopTransaction;
begin
  if tran.InTransaction then tran.Commit;
end;

end.
