unit S_ObjObor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, baze_dic, Placemnt, Menus, StdCtrls, DBCtrls, ExtCtrls, Buttons,
  Grids, DBGrids, RXDBCtrl, DB, RxLookup, IBCustomDataSet, IBSQL,
  IBDatabase, ValEdit, IBScript, ComCtrls, HETreeView, RXSplit, DualList,
  RXCtrls;

type
  TS_ObjOborF = class(TBazeDicF)
    dbl_Object: TRxDBLookupCombo;
    Label1: TLabel;
    tran: TIBTransaction;
    ds_OborGroup: TDataSource;
    dset_OborGroup: TIBDataSet;
    dset_OborGroupID: TIntegerField;
    dset_OborGroupOBORTYPE: TIntegerField;
    dset_OborGroupDETAIL: TIntegerField;
    dset_OborGroupDEL: TIBStringField;
    dset_OborGroupNAME_R: TIBStringField;
    Panel4: TPanel;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    p_Group: TPanel;
    GroupGrid: TRxDBGrid;
    Panel5: TPanel;
    Panel6: TPanel;
    dbg_Params: TRxDBGrid;
    dset_OborTypeParams: TIBDataSet;
    dset_OborTypeParamsID: TIntegerField;
    dset_OborTypeParamsNAME_R: TIBStringField;
    dset_OborTypeParamsP_VALUE: TIBStringField;
    dset_OborTypeParamsMEASURE: TIBStringField;
    dset_OborTypeParamsID_OBORTYPE: TIntegerField;
    dset_OborTypeParamsID_FIELD: TIntegerField;
    dset_OborTypeParamsSOF_ID: TIntegerField;
    ds_OborTypeParams: TDataSource;
    Splitter3: TSplitter;
    ValueListEditor: TValueListEditor;
    dset_ParamLook: TIBDataSet;
    dset_ParamLookP_PARAM: TIBStringField;
    dset_ParamLookP_VALUE: TIBStringField;
    ds_ParamLook: TDataSource;
    RxSplitter1: TRxSplitter;
    BB_CopyNew: TBitBtn;
    IBSQL: TIBSQL;
    Panel7: TPanel;
    procedure dbl_ObjectChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dset_OborGroupAfterScroll(DataSet: TDataSet);
    procedure BB_CopyNewClick(Sender: TObject);
    procedure DataGrid_dgrDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure BDelClick(Sender: TObject);
    procedure DataGrid_dgrTitleBtnClick(Sender: TObject; ACol: Integer;
      Field: TField);
    procedure BNewClick(Sender: TObject);
  private
    F_CurrentOborTypeID: integer;
    F_OldAfterScroll:TDataSetNotifyEvent;
    F_NewClick: TNotifyEvent;
    F_NewEOFClick: TNotifyEvent;
    OldBeforePost: TDataSetNotifyEvent;
    OldFilter: string;
    procedure NewBeforePost(DataSet: TDataSet);
    procedure NewAfterScroll(DataSet: TDataSet);
    procedure BlancAfterScrool(DataSet: TDataSet); // - типа заглушка :)
    procedure InitFrame;
    function IsSostObor: boolean;
    Function GetCurrentOborTypeID: integer;
  public
    constructor CreateDic(AOwner :TComponent; TbName,KeyFd :string; Dsur :TDataSource);override;
    destructor Destroy;override;
    procedure Translate;override;
  end;

var
  S_ObjOborF: TS_ObjOborF;

implementation

uses datam,  frmLANG, cntsLANG;

{$R *.dfm}

{ TS_ObjOborF }

constructor TS_ObjOborF.CreateDic(AOwner: TComponent; TbName,
  KeyFd: string; Dsur: TDataSource);
var
  fdl: TStringList;
begin
 if dm1.s_obortype_lookup.Active then dm1.s_obortype_lookup.Close;
 dm1.s_obortype_lookup.Open;
 if dm1.s_soorug_lookup.Active then dm1.s_soorug_lookup.Close;
 dm1.s_soorug_lookup.Open;




 inherited CreateDic(AOwner, TbName,KeyFd, DSur);
 if not dm1.s_object_q.Active then dm1.s_object_q.Open;

 fdl := TStringList.Create;
 try
   fdl := TStringList.Create;
   fdl.Add( 'Name_r' );
   ListFindFields := fdl;
   CurFindField := 'Name_r';
 finally
   fdl.Free;
 end;

 SetLength( NotEmptyFields, 1 );
 NotEmptyFields[0] := 'Name_r';
 SetLength( UniqFields, 4 );
 UniqFields[0] := 'Name_r';
// UniqFields[1] := 'id_object';
 UniqFields[1] := 'id_obortype';
 UniqFields[2] := 'id_soorug';
 UniqFields[3] := 'id_diam';

 //name_r, id_object, id_obortype, id_soorug, id_diam

 F_OldAfterScroll := CurDataSet.AfterScroll;
 CurDataSet.AfterScroll := NewAfterScroll;

 OldBeforePost := dm1.s_objobor_q.BeforePost;
 dm1.s_objobor_q.BeforePost := NewBeforePost;
{ if CurDataSet.Eof then
        BNew.OnClick := BNewClick_EOF
        else
        BNew.OnClick := BNewClick;}
 OldFilter := dm1.s_objobor_q.Filter;
 InitFrame;
end;

destructor TS_ObjOborF.Destroy;
begin
  dm1.s_objobor_q.BeforePost := OldBeforePost;
  dm1.s_objobor_q.Filter := OldFilter;
  CurDataSet.AfterScroll := F_OldAfterScroll;
  inherited;
  S_ObjOborF := nil;
end;

procedure TS_ObjOborF.Translate;
begin
 Caption:=TrLangMSG(msgSpravochOne)+' '+TrLangMSG(msgEquipObjects);
 Label1.Caption:=TrLangMSG(msgObjectOne);
 DataGrid_dgr.Columns[1].Title.Caption:=TrLangMSG(msgDesign);

end;

procedure TS_ObjOborF.NewBeforePost(DataSet: TDataSet);
begin
  DataSet.FieldByName( 'id_object' ).AsInteger := dm1.s_object_q.FieldByName( 'id' ).AsInteger;
  if Assigned( OldBeforePost ) then OldBeforePost( DataSet );
end;

procedure TS_ObjOborF.dbl_ObjectChange(Sender: TObject);
begin
  with DM1 do
  begin
    s_objobor_q.Filtered:=false;
    s_objobor_q.Filter:='id_object=' + S_Object_q.FieldByName('ID').AsString;
    s_objobor_q.Filtered:=true;

    s_soorug_lookup.Filtered:=false;
    s_soorug_lookup.Filter:='id_object=' + S_Object_q.FieldByName('ID').AsString;
    s_soorug_lookup.Filtered:=true;

//   if DM1.s_soorug_lookup.Active then dm1.s_soorug_lookup.Close;

{   DM1.s_soorug_q.SQL.Text :=
     ' SELECT s.id, s.Name_r,  s.id_object,s.del '+
     ' FROM s_soorug s '+
     ' WHERE s.id = -1  ' +
     ' or id_object = ' + S_Object_q.FieldByName('ID').AsString +
     ' ORDER BY s.Name_r';}

//   dm1.s_soorug_lookup.Open;


    Caption := BazeCaption;
  end;
end;

procedure TS_ObjOborF.FormShow(Sender: TObject);
begin
  inherited;
  dm1.s_object_q.First;
  dbl_ObjectChange( nil );
  dbl_Object.DisplayValue := dm1.s_object_q.FieldByName('name_r').AsString;
  F_CurrentOborTypeID := CurDataSet.FieldByName( 'ID_obortype' ).AsInteger;
//  dbl_ObjectChange( nil );  
end;

procedure TS_ObjOborF.NewAfterScroll(DataSet: TDataSet);
begin
  DataGrid_dgr.Enabled := false;
  if Assigned( F_OldAfterScroll ) then
    F_OldAfterScroll( DataSet );

  if DM1.s_obortype_lookup.Active then DM1.s_obortype_lookup.Close;
  DM1.s_obortype_lookup.Open;
  if DM1.s_soorug_lookup.Active then DM1.s_soorug_lookup.Close;
  DM1.s_soorug_lookup.Open;

  if CurDataSet.FieldByName('id_parent').AsInteger >0 then
    begin
     BB_CopyNew.Enabled := false;
    end
    else
    begin
//      CtrlState;
      BB_CopyNew.Enabled := BDel.Enabled;
    end;


  InitFrame;


//  if Visible then
//    F_CurrentOborTypeID := CurDataSet.FieldByName( 'ID' ).AsInteger;
  DataGrid_dgr.Enabled := true;
{   if CurDataSet.Eof then
        BNew.OnClick := BNewClick_EOF
        else
        BNew.OnClick := BNewClick;
 }
 if (CurDataSet.State = dsBrowse) then
   DataGrid_dgr.SetFocus;
end;

procedure TS_ObjOborF.InitFrame;
  procedure FillOborGroupe;
   begin

      GroupGrid.Visible := true;
      ValueListEditor.Visible := true;

      if dset_OborGroup.Active then dset_OborGroup.Close;
      dset_OborGroup.ParamByName('obortype').AsInteger := F_CurrentOborTypeID;
      dset_OborGroup.Open;
   end;

  procedure FillOborTypeParams;
   begin
      dbg_Params.DataSource := nil;
      dbg_Params.Enabled := false;
      if dset_OborTypeParams.Active then dset_OborTypeParams.Close;
      dset_OborTypeParams.ParamByName('pid').AsInteger := F_CurrentOborTypeID;
      dset_OborTypeParams.Open;
      dbg_Params.DataSource := ds_OborTypeParams;
      dbg_Params.Enabled := true;
      //dbg_Params.Refresh;      
   end;


begin
  try
    F_CurrentOborTypeID := GetCurrentOborTypeID;
    if ( dset_OborGroup.State = dsEdit) or (dset_OborGroup.State = dsInsert) then
        dset_OborGroup.Cancel;

    if tran.InTransaction then tran.Commit;

    tran.StartTransaction;

    if IsSostObor then FillOborGroupe
    else
    begin
     GroupGrid.Visible := false;
     ValueListEditor.Visible := false;
    end;

    FillOborTypeParams;
  except
    on E: Exception do
    begin
      tran.Rollback;
      E.Message := E.Message + '(TS_OborTypeF.InitFrame)';
      raise;
    end;
  end; //except

end;


function TS_ObjOborF.IsSostObor: boolean;
begin
  //
   if CurDataSet.Active then
    Result := (CurDataSet.FieldByName( 'DIFFER' ).AsInteger = 1);
end;

Function TS_ObjOborF.GetCurrentOborTypeID;
begin
  if CurDataSet.Active then
    Result := CurDataSet.FieldByName( 'ID_OBORTYPE' ).AsInteger
    else
    Result := 0;
end;


procedure TS_ObjOborF.dset_OborGroupAfterScroll(DataSet: TDataSet);
var _col : integer;
begin
  inherited;
//
 _col := ValueListEditor.RowCount;
  while _col > 2 do
  begin
   ValueListEditor.DeleteRow(_col-1);
    _col := _col - 1;
  end;
  ValueListEditor.Values[ValueListEditor.Keys[1]] := ' ';
  ValueListEditor.Keys[1] := ' ';


  if dset_ParamLook.Active then dset_ParamLook.Close;
  dset_ParamLook.ParamByName('pid').AsInteger := dset_OborGroup.FieldByName('detail').AsInteger;
  dset_ParamLook.Open;
  dset_ParamLook.First;
  ValueListEditor.Keys[1] := dset_ParamLook.FieldByName('p_param').AsString;
  ValueListEditor.Values[ValueListEditor.Keys[1]] := dset_ParamLook.FieldByName('p_value').AsString;
  dset_ParamLook.Next;
  while not dset_ParamLook.Eof do
  begin

    ValueListEditor.InsertRow( dset_ParamLook.FieldByName('p_param').AsString
                              ,dset_ParamLook.FieldByName('p_value').AsString, true );
    dset_ParamLook.Next;
  end;
end;

procedure TS_ObjOborF.BB_CopyNewClick(Sender: TObject);
var _id, _id_parent, _id_soorug, _id_obortype : integer;
    _name_r : string;
begin
//  inherited;
//
  _id_parent := CurDataSet.FieldByName('ID').AsInteger;
  _id := CurDataSet.FieldByName('ID').AsInteger;
  _name_r := CurDataSet.FieldByName('NAME_R').AsString;
  _id_soorug := CurDataSet.FieldByName('ID_SOORUG').AsInteger;
  _id_obortype := CurDataSet.FieldByName('ID_OBORTYPE').AsInteger;

  //BNew.Click;
  BNewClick(nil);

  CurDataSet.FieldByName('ID_PARENT').AsInteger := _id;
  CurDataSet.FieldByName('NAME_R').AsString := _name_r;
  CurDataSet.FieldByName('ID_SOORUG').AsInteger := _id_soorug;

end;

procedure TS_ObjOborF.DataGrid_dgrDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin

  if DataGrid_dgr.DataSource.dataset.FieldByName('ID_PARENT').AsInteger >0
  then begin
    if(State=[])
    then begin
//      DataGrid_dgr.Canvas.Font.Style:= [fsItalic];
      DataGrid_dgr.Canvas.Font.Color:= clOlive;
//      DataGrid_dgr.Canvas.brush.Color:=clMoneyGreen;
    end;
{    if(gdSelected in State)
    then begin
      DataGrid_dgr.Canvas.Font.Color:=clOlive;
    end;}
  end;
//  DataGrid_dgr.DefaultDrawColumnCell( Rect, DataCol,Column,State);
  inherited;

end;

procedure TS_ObjOborF.BDelClick(Sender: TObject);
var id_parent: integer;
begin
  id_parent := CurDataSet.FieldByName('ID').AsInteger;
  inherited;
  if id_parent >0 then
    begin
      IBSQL.SQL.Text := 'DELETE FROM S_OBJOBOR WHERE ID_PARENT = '+ IntToStr(id_parent);
      IBSQL.ExecQuery;
      tran.Commit;
      BRefrClick(nil);
    end;
end;

procedure TS_ObjOborF.DataGrid_dgrTitleBtnClick(Sender: TObject;
  ACol: Integer; Field: TField);
  var  _sel, _ord: string;

  procedure  RefreshSQL;
  begin
     //
      dm1.s_objobor_q.Close;
      dm1.s_objobor_q.SQL.Text := _sel + _ord;
      dm1.s_objobor_q.Open;
  end;

begin
  inherited;


 _sel := 'select id, name_r, id_object, id_obortype, id_soorug, id_diam, del '+
         ' , (select st.DIFFER from s_obortype st where st.id=s_objobor.id_obortype ) DIFFER '+
         ' , (select ss.name_r from s_soorug ss where ss.id = s_objobor.id_soorug ) soorug '+
         ' , id_parent, inventar '+
         ' from s_objobor '+
         ' where ( del in (''-'',''d'') ) and  ( id > 0 ) ';


  case ACol of
    0: begin
         _ord := ' order by 11';
         RefreshSQL;
       end;
    1: begin
         _ord := ' order by 2,9,10';
         RefreshSQL;
       end;
    2: begin
          //
       end;
    3: begin
         _ord := ' order by 9,2,10';
         RefreshSQL;
       end;
  end;
end;

{procedure TS_ObjOborF.BNewClick_EOF(Sender: TObject);
var is_new: boolean;
begin
  is_new := CurDataSet.Eof;
  if CurDataSet.CanModify then
     begin
       CurDataSet.Append;
       if (CurDataSet.State in [dsInsert, dsEdit]) then
        CurDataSet.FieldByName('ID_PARENT').AsInteger := 0
       else
       begin
          CurDataSet.Edit;
          CurDataSet.FieldByName('ID_PARENT').AsInteger := 0
       end;
    end;
//  if (CurDataSet.State in [dsInsert, dsEdit]) then
//   CurDataSet.FieldByName('ID_PARENT').AsInteger := 0;
end;
     }
procedure TS_ObjOborF.BNewClick(Sender: TObject);
var is_new: boolean;
begin
 CurDataSet.AfterScroll := BlancAfterScrool;
  with DM1 do
  begin
    s_objobor_q.Filtered:=false;
    s_objobor_q.Filter:='id_object=' + S_Object_q.FieldByName('ID').AsString;
    s_objobor_q.Filtered:=true;
  end;
  inherited;
  //
 // if not(CurDataSet.State in [dsInsert, dsEdit]) then
 // CurDataSet.Edit;
  CurDataSet.FieldByName('ID_PARENT').AsInteger := 0;
  CurDataSet.AfterScroll := NewAfterScroll;
end;

procedure TS_ObjOborF.BlancAfterScrool(DataSet: TDataSet);
begin
  // это просто заглушка, но никто не запрещает писать сюда свой код, если уж сильно надо :)
end;

end.
