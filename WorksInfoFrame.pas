unit WorksInfoFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, Aligrid, IBDatabase, DB, IBCustomDataSet, DMMain,
  StdCtrls, ExtCtrls, kbmMemTable;

type
  Tframe_WorksInfo = class(TFrame)
    Grid: TStringAlignGrid;
    dset_WorksInfo: TIBDataSet;
    tran: TIBTransaction;
    dset_WorksInfoPLACE_NAME: TIBStringField;
    dset_WorksInfoWORK_NAME: TIBStringField;
    dset_WorksInfoED_IZM: TIBStringField;
    dset_WorksInfoBRIG_NAME: TIBStringField;
    dset_WorksInfoclc_WORK_NAME: TStringField;
    pnl_NeedWorks: TPanel;
    mem_NeedWorks: TMemo;
    Label1: TLabel;
    mt_NeedWorks: TkbmMemTable;
    dset_NeedWorks: TIBDataSet;
    dset_NeedWorksID_WORK: TIntegerField;
    dset_NeedWorksWORK_NAME: TIBStringField;
    mt_NeedWorksid_work: TIntegerField;
    mt_NeedWorkswork_name: TStringField;
    dset_WorksInfoID: TIntegerField;
    dset_WorksInfoDT_OUT: TDateTimeField;
    lbl_AddInfo: TLabel;
    procedure dset_WorksInfoCalcFields(DataSet: TDataSet);
  private
    F_IsCanRestore: boolean;
    procedure UpdateNeedWorksList;
  public
    procedure FillWorksInfo( _RaskopID, _MestID: integer );
    procedure ResetGrid;
    property IsCanRestore: boolean read F_IsCanRestore write F_IsCanRestore;
    constructor Create( AOwner: TComponent ); override;
    procedure Translate;
  end;

implementation

{$R *.dfm}

uses HelpFunctions, GridViewBuilder, ServiceFuncUnit,frmLANG,cntsLANG;

{ Tframe_WorksInfo }

procedure Tframe_WorksInfo.Translate;
begin
 lbl_AddInfo.Caption:=TrLangMSG(msgNotBlagTime);
 Label1.Caption:=TrLangMSG(msgNeedDoBlag);
end;

procedure Tframe_WorksInfo.FillWorksInfo(_RaskopID, _MestID: integer);
var
  _gvb: TGridViewBuilder;
  _IsFind: boolean;
begin
  if tran.InTransaction then tran.Rollback;
  tran.StartTransaction;
  try
    dset_WorksInfo.Close;
    dset_WorksInfo.ParamByName( 'pRaskopID' ).AsInteger := _RaskopID;
    dset_WorksInfo.Open;

    {Готовим грид с работами}
    _gvb := TGridViewBuilder.Create( dset_WorksInfo, Grid );
    try
      AddColToGVB( _gvb, 'dt_out', TrLangMSG(msgendWork){'Окончание работ'}, alCenter );
      AddColToGVB( _gvb, 'brig_name', 'Бригадир', alLeft );
      AddColToGVB( _gvb, 'place_name', TrLangMSG(msgDmgPlace){'Место повреждения'}, alLeft );
      AddColToGVB( _gvb, 'clc_WORK_NAME',TrLangMSG(msgWorkOne) {'Работа'}, alLeft );

      _gvb.BuildGridView;
    finally
      _gvb.Free;
    end;
    {Готовим грид с работами}

    {Готовим mt_NeedWorks}
    F_IsCanRestore := true;
    lbl_AddInfo.Visible := false;

    mt_NeedWorks.Close;
    mt_NeedWorks.Open;

    dset_NeedWorks.Close;
    dset_NeedWorks.ParamByName( 'pMestID' ).AsInteger := _MestID;
    dset_NeedWorks.Open;

    dset_NeedWorks.First;
    while not dset_NeedWorks.Eof do
    begin
      _IsFind := false;
      dset_WorksInfo.First;
      while not dset_WorksInfo.Eof do
      begin
        if dset_NeedWorks.FieldByName( 'id_work' ).AsInteger =
          dset_WorksInfo.FieldByName( 'id' ).AsInteger then
        begin
          _IsFind := true;
          if dset_WorksInfo.FieldByName( 'dt_out' ).AsDateTime < 1 then
          begin
            F_IsCanRestore := false;
            lbl_AddInfo.Visible := true;
          end;
          dset_WorksInfo.Last;
        end;
        dset_WorksInfo.Next;
      end;

      if not _IsFind then
      begin
        mt_NeedWorks.Append;
        mt_NeedWorks.FieldByName( 'id_work' ).AsInteger := dset_NeedWorks.FieldByName( 'id_work' ).AsInteger;
        mt_NeedWorks.FieldByName( 'work_name' ).AsString := dset_NeedWorks.FieldByName( 'work_name' ).AsString;
        mt_NeedWorks.Post;

        F_IsCanRestore := false;
      end;


      dset_NeedWorks.Next;
    end;
    {Готовим mt_NeedWorks}

    UpdateNeedWorksList;

    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      E.Message := E.Message + '(Tframe_WorksInfo.FillWorksInfo)';
      raise;
    end;
  end;
end;

procedure Tframe_WorksInfo.dset_WorksInfoCalcFields(DataSet: TDataSet);
var
  _EdIzm, _Work: string;
begin
  with DataSet do
  begin
    _EdIzm := trim( FieldByName( 'ed_izm' ).AsString );
    _Work := trim( FieldByName( 'work_name' ).AsString );
    if _EdIzm <> '' then
      _Work := _Work + '(' + _EdIzm + ')';

    FieldByName( 'clc_WORK_NAME' ).AsString := _Work;
  end;
end;

procedure Tframe_WorksInfo.ResetGrid;
begin
  Grid.Cells[ 0, 0 ] := '';
  Grid.ColCount := 0;
  Grid.RowCount := 0;
end;

procedure Tframe_WorksInfo.UpdateNeedWorksList;
var
  _s: string;
begin
  _s := '';
  mt_NeedWorks.First;
  while not mt_NeedWorks.Eof do
  begin
    _s := _s + ', ' + mt_NeedWorks.FieldByName( 'work_name' ).AsString;
    mt_NeedWorks.Next;
  end;
  Delete( _s, 1, 1 );

  mem_NeedWorks.Lines.Clear;
  mem_NeedWorks.Lines.Add( _s );
end;

constructor Tframe_WorksInfo.Create(AOwner: TComponent);
begin
  inherited Create( AOwner );
  mt_NeedWorks.Open;
end;

end.
