unit BaseWorkAndMatDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseNarDetailDM, IBDatabase, DB;

type
  TShowMode = ( smAll,        {ќтображать все записи}
                smAttached,   {ќтображать только соответ-ие заданной большой работе}
                smFree );     {ќтображать записи неприв€занные ни к какой большой работе }
  Tdm_BaseWorkAndMat = class(Tdm_BaseNarDetail)
    procedure MainFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure DataModuleCreate(Sender: TObject);
  protected
    F_ShowMode: TShowMode;
    F_Current_ID_IN_BWORKS: integer;
  public
    property Current_ID_IN_BWORKS: integer read F_Current_ID_IN_BWORKS write F_Current_ID_IN_BWORKS;
    property ShowMode: TShowMode read F_ShowMode write F_ShowMode;
    procedure Refilter; virtual;
  end;


implementation

{$R *.dfm}

{ Tdm_BaseWorkAndMat }

procedure Tdm_BaseWorkAndMat.MainFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  case F_ShowMode of
    smAll: Accept := true;
    smAttached: Accept := ( DataSet.FieldByName( 'BWORKS_ID' ).AsInteger = F_Current_ID_IN_BWORKS );
    smFree: Accept := DataSet.FieldByName( 'BWORKS_ID' ).IsNull;
  end;
end;

procedure Tdm_BaseWorkAndMat.Refilter;
begin
//
end;

procedure Tdm_BaseWorkAndMat.DataModuleCreate(Sender: TObject);
begin
  inherited;
  F_Current_ID_IN_BWORKS := -1;
  F_ShowMode := smAll;
end;

end.
