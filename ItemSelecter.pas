unit ItemSelecter;

interface

uses Classes, ItemSelecterDModule, SelectItemForm, Controls, SysUtils;

type
  TSelItem=class
  private
    F_ID: integer;
    F_Name: string;
  public
    property ID: integer read F_ID write F_ID;
    property Name: string read F_Name write F_Name;
  end;

  TSelItemList=class
  private
    F_ItemList: TList;
    F_IsChanged: boolean;
    F_ItemsID,
    F_ItemsName: string;
    function GetSelItem(Index: integer): TSelItem;
    procedure SetItemsIDAndName;
    function GetItemsID: string;
    function GetItemsName: string;
  public
    property Items[Index: integer]: TSelItem read GetSelItem;
    procedure AddItem( _ID: integer; _Name: string );
    property ItemsID: string read GetItemsID;
    property ItemsName: string read GetItemsName;
    procedure Clear;
    function Count: integer;
    constructor Create;
    destructor Destroy; override;
    function IsHasItemWithID( _ItemID: integer ): boolean;
  end;

  TDefaultItemList=class(TList)
  private
    F_ItemsID: string;
    procedure SetItemsID(const Value: string);
  public
    property ItemsID: string read F_ItemsID write SetItemsID;
    function IsValueInItems( _Value: integer ): boolean;
  end;

  TItemSelecter=class
  private
    F_DM: Tdm_ItemSelecter;
    F_IsSelected: boolean;
    F_IsChangedInForm: boolean;
    F_SelItemList: TSelItemList;
    F_FormCaption: string;
    F_ItemNameField,
    F_ItemIDField: string;
    F_IsMakeFullSelectIfNotShow: boolean;
    F_DefaultItemList: TDefaultItemList;
    procedure FillFullSelItemList;
    function FillDefaultSelItemList: boolean;
    procedure SetSQL(const Value: string);
    function GetSelItemList: TSelItemList;
    procedure SetDefaultItemsID(const Value: string);
  public
    constructor Create;
    destructor Destroy; override;
    property SQL: string write SetSQL;
    property FormCaption: string read F_FormCaption write F_FormCaption;
    property IsMakeFullSelectIfNotShow: boolean read F_IsMakeFullSelectIfNotShow
      write F_IsMakeFullSelectIfNotShow;
    property ItemNameField: string read F_ItemNameField write F_ItemNameField;
    property ItemIDField: string read F_ItemIDField write F_ItemIDField;
    property SelItemList: TSelItemList read GetSelItemList;
    procedure Reset;
    procedure ShowSelectForm;
    property DefaultItemsID: string write SetDefaultItemsID;
  end;

implementation

{ TItemSelecter }

constructor TItemSelecter.Create;
begin
  inherited Create;
  F_DM := Tdm_ItemSelecter.Create(nil);
  F_SelItemList := TSelItemList.Create;
  F_DefaultItemList := TDefaultItemList.Create;
  F_FormCaption := '';
  F_ItemNameField := 'ItemName';
  F_ItemIDField := 'ItemID';
  F_IsMakeFullSelectIfNotShow := false;
  Reset;
end;

destructor TItemSelecter.Destroy;
begin
  F_DM.Free;
  F_SelItemList.Free;
  F_DefaultItemList.Free;
  inherited Destroy;
end;


function TItemSelecter.FillDefaultSelItemList: boolean;
begin
  if F_DefaultItemList.Count > 0 then
  begin
    F_SelItemList.Clear;
    F_DM.StartTransaction;
    try
      with F_DM do
      begin
        dset.Open;
        dset.First;
        while not dset.Eof do
        begin
          if F_DefaultItemList.IsValueInItems( dset.FieldByName( F_ItemIDField ).AsInteger ) then
          begin
            F_SelItemList.AddItem( dset.FieldByName( F_ItemIDField ).AsInteger,
                                  trim( dset.FieldByName( F_ItemNameField ).AsString ) );
            F_IsSelected := true;
          end;
          dset.Next;
        end;
      end;
    finally
      F_DM.StopTransaction;
    end;
  end;
  Result := F_IsSelected;
end;

procedure TItemSelecter.FillFullSelItemList;
begin
  F_SelItemList.Clear;

  F_DM.StartTransaction;
  try
    with F_DM do
    begin
      dset.Open;
      dset.First;
      while not dset.Eof do
      begin
        F_SelItemList.AddItem( dset.FieldByName( F_ItemIDField ).AsInteger,
                               trim( dset.FieldByName( F_ItemNameField ).AsString ) );
        dset.Next;
      end;
    end;
  finally
    F_DM.StopTransaction;
  end;

  F_IsSelected := true;
end;

function TItemSelecter.GetSelItemList: TSelItemList;
begin
  if F_IsChangedInForm then
  begin
    if not F_IsSelected then
      if F_IsMakeFullSelectIfNotShow then
        FillFullSelItemList;
  end else
  begin
    if not F_IsSelected then
      if not FillDefaultSelItemList then
        if F_IsMakeFullSelectIfNotShow then
          FillFullSelItemList;
  end;

  Result := F_SelItemList;
end;

procedure TItemSelecter.Reset;
begin
  F_IsSelected := false;
  F_IsChangedInForm := false;
  F_SelItemList.Clear;
end;

procedure TItemSelecter.SetDefaultItemsID(const Value: string);
begin
  F_DefaultItemList.ItemsID := Value;
end;

procedure TItemSelecter.SetSQL(const Value: string);
begin
  F_DM.dset.Close;
  F_DM.dset.SelectSQL.Clear;
  F_DM.dset.SelectSQL.Text := Value;
end;

procedure TItemSelecter.ShowSelectForm;
var
  _frm: Tfrm_SelectItem;
  _name: string;
  _id, i: integer;
begin

  _frm := Tfrm_SelectItem.Create( F_FormCaption );
  try
    _frm.ds_Items.DataSet := F_DM.dset;
    F_DM.StartTransaction;
    try
      with F_DM, _frm do
      begin
        dset.Open;
        dset.First;
        while not F_DM.dset.Eof do
        begin
          _name := dset.FieldByName( F_ItemNameField ).AsString;
          _id := dset.FieldByName( F_ItemIDField ).AsInteger;
          chlb_Items.Items.AddObject( _name, ptr( _id ) );

          if not F_IsSelected then
          begin
            if F_DefaultItemList.IsValueInItems( _id ) then
              chlb_Items.Checked[ chlb_Items.Count-1 ] := true;
          end else
          begin
            if F_SelItemList.IsHasItemWithID( _id ) then
              chlb_Items.Checked[ chlb_Items.Count-1 ] := true;
          end;

          dset.Next;
        end;

        if _frm.ShowModal = mrOk then
        begin
          F_SelItemList.Clear;
          F_IsChangedInForm := _frm.IsChanged;
          if _frm.IsHasChecked then
          begin
            F_IsSelected := true;
            for i:=0 to chlb_Items.Count-1 do
              if chlb_Items.Checked[i] then
              begin
                _name := trim( chlb_Items.Items[i] );
                _id := Integer( chlb_Items.Items.Objects[i] );
                F_SelItemList.AddItem( _id, _name );
              end;
          end;
        end;
      end;
    finally
      F_DM.StopTransaction;
    end;
  finally
    _frm.Free;
  end;
end;

{ TSelItemList }

procedure TSelItemList.AddItem(_ID: integer; _Name: string);
var
  _SelItem: TSelItem;
begin
  _SelItem := TSelItem.Create;
  _SelItem.ID := _ID;
  _SelItem.Name := _Name;
  F_ItemList.Add( _SelItem );

  F_IsChanged := true;
end;

procedure TSelItemList.Clear;
var
  i: integer;
begin
  for i:=0 to F_ItemList.Count-1 do
    TSelItem(F_ItemList.Items[i]).Free;
  F_ItemList.Clear;

  F_IsChanged := true;
end;

function TSelItemList.Count: integer;
begin
  Result := F_ItemList.Count;
end;

constructor TSelItemList.Create;
begin
  inherited Create;
  F_ItemList := TList.Create;
  F_IsChanged := false;
end;

destructor TSelItemList.Destroy;
var
  i: integer;
begin
  Clear;
  F_ItemList.Free;
  inherited Destroy;
end;

function TSelItemList.GetItemsID: string;
begin
  if F_IsChanged then SetItemsIDAndName;
  Result := F_ItemsID;
end;

function TSelItemList.GetItemsName: string;
begin
  if F_IsChanged then SetItemsIDAndName;
  Result := F_ItemsName;
end;

function TSelItemList.GetSelItem(Index: integer): TSelItem;
begin
  Result := TSelItem( F_ItemList.Items[Index] );
end;

function TSelItemList.IsHasItemWithID(_ItemID: integer): boolean;
var
  i: integer;

begin
  Result := false;

  for i:=0 to F_ItemList.Count-1 do
    if _ItemID = TSelItem(F_ItemList.Items[i]).ID then
    begin
      Result := true;
      break;
    end;
end;

procedure TSelItemList.SetItemsIDAndName;
var
  i: integer;
begin
  F_ItemsID := '';
  F_ItemsName := '';

  if F_ItemList.Count > 0 then
  begin
    for i:=0 to F_ItemList.Count-1 do
    begin
      F_ItemsID := F_ItemsID + ', ' + IntToStr( TSelItem( F_ItemList.Items[i] ).ID );
      F_ItemsName := F_ItemsName + ', ' + trim( TSelItem( F_ItemList.Items[i] ).Name );
    end;

    Delete( F_ItemsID, 1, 2);
    Delete( F_ItemsName, 1, 2);
  end else F_ItemsName := 'бяе';

  F_IsChanged := false;
end;

{ TDefaultItemList }

function TDefaultItemList.IsValueInItems(_Value: integer): boolean;
var
  i: integer;
begin
  Result := false;
  for i:=0 to Count-1 do
    if _Value = integer( Items[i] ) then
    begin
      Result := true;
      break;
    end;
end;

procedure TDefaultItemList.SetItemsID(const Value: string);
var
  i: integer;
  _s, _val: string;
begin
  F_ItemsID := Value;
  //
  Clear;
  //
  _s := trim( Value );
  if _s <> '' then
  begin
    _val := '';
    for i:=1 to length( _s )+1 do
      if ( i = length( _s )+1 ) or ( _s[i] = ',' ) then
      begin
        _val := trim( _val );
        if _val <> '' then
        begin
          Add( ptr( StrToInt( _val ) ) );
          _val := '';
        end;
      end else
      begin
        _val := _val + _s[i];
      end;
  end;
end;

end.
