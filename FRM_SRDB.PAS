unit frm_srdb;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, RxLookup, Db, DBTables, ExtCtrls, frmLANG, cntsLANG,
  ServiceFuncUnit;

type
  TFrm_SDb = class(TFrame)
    Qry_sear: TQuery;
    DS_sear: TDataSource;
    DBLC_sear: TRxDBLookupCombo;
    Lb_name: TLabel;
    GrB_Spis: TGroupBox;
    LB_Sear: TListBox;
    BB_Add: TBitBtn;
    BB_Del: TBitBtn;
    BB_Clear: TBitBtn;
    GrB_like: TGroupBox;
    Ed_sear: TEdit;
    BB_like: TBitBtn;
    Qry_tmp: TQuery;
    Povrezhd_rg: TRadioGroup;
    procedure BB_AddClick(Sender: TObject);
    procedure BB_ClearClick(Sender: TObject);
    procedure BB_DelClick(Sender: TObject);
    function  ReadDBName:string;
    procedure SetDBName(value:string);
    function  ReadFld:string;
    procedure SetFld(value:string);
    function  ReadTxt:string;
    procedure SetTxt(value:string);
    procedure BB_likeClick(Sender: TObject);
  {  function  ReadID:string;
    procedure SetID(value:string);}
  private
    { Private declarations }
//    Fn_field:string;
  public
    { Public declarations }
    SQLStr:string{ read ReadSQL write SetSQL};
    MainSQlStr:string;
    n_field,Like_field:string {read ReadID write SetID};
    SQLField:string;
    GetTit:string;
    isLike,isUpper:integer;
    constructor Create(AOwner: TComponent); override;

    property DbName:string read ReadDBName write SetDbName;
    property L_field:string read ReadFld write SetFld;
//    property n_field:string read ReadID write SetID;
    property Text :string read ReadTxt write SetTxt;
    procedure Open;
    procedure Close;
    function GetSQL:string;
  end;

implementation
   uses main,strtool;
{$R *.DFM}

procedure TFrm_SDb.BB_AddClick(Sender: TObject);
var _n_field_value:integer;
begin
  if (Ed_Sear.Text<>'') and (not BB_Like.Enabled) or (n_field='') then
    begin
     if Lb_Sear.Items.IndexOf(Ed_Sear.Text)<0 then
       begin
         Lb_Sear.Items.AddObject(Ed_Sear.Text,TObject(0));
       end;
    end
  else
    begin
     if Lb_Sear.Items.IndexOf(DbLc_sear.DisplayValue)<0 then
      begin
        _n_field_value:=Qry_sear.FieldByName(n_field).asInteger;
        if (Strip('A',' ',DbLc_sear.DisplayValue)<>'') and (_n_field_value>-1) then
          begin
            if (n_field<>'') then
             Lb_Sear.Items.AddObject(DbLc_sear.DisplayValue,
                              TObject(_n_field_value))
            else
             Lb_Sear.Items.AddObject(DbLc_sear.DisplayValue,TObject(0));
             //Lb_Sear.Items.Add(DbLc_sear.DisplayValue);
          end;
      end;
    end;
end;

procedure TFrm_SDb.BB_ClearClick(Sender: TObject);
begin
      Lb_Sear.Items.Clear;
end;

procedure TFrm_SDb.BB_DelClick(Sender: TObject);
var i:integer;
begin         //tstrings
   i:=0;
   repeat
     begin
       if Lb_Sear.Selected[i] then
          Lb_Sear.Items.Delete(i)
       else
          inc(i);
     end;
   until i>=Lb_Sear.Items.Count;
end;

function TFrm_SDb.ReadDBName:string;
begin
  Result:=Qry_sear.DataBaseName;
end;

procedure TFrm_SDb.SetDBName(value:string);
begin
  Qry_sear.DataBaseName:=value;
  Qry_tmp.DataBaseName:=value;
//  DbName:=value;
end;

function TFrm_SDb.ReadFld:string;
begin
  Result:=DBLC_Sear.LookUpField;
end;

procedure TFrm_SDb.SetFld(value:string);
begin
  DBLC_Sear.LookUpField:=value;
  DBLC_Sear.LookUpDisplay:=value;
end;

function TFrm_SDb.ReadTxt:string;
begin
  Result:=Lb_Name.Caption;
end;

procedure TFrm_SDb.SetTxt(value:string);
begin
  Lb_Name.Caption:=value;
end;

procedure TFrm_SDb.Open;
var
 povrezhd_fl :boolean;
begin
  povrezhd_fl:=(AnsiUppercase(SQLstr) = 'POVREZHD'); // ds
  GrB_like.Visible:=not povrezhd_fl;
  GrB_Spis.Visible:=not povrezhd_fl;
  Lb_name.Visible:=not povrezhd_fl;
  DBLC_sear.Visible:=not povrezhd_fl;
  Povrezhd_rg.Visible:=povrezhd_fl;
  //Excavation_pl.Visible:=povrezhd_fl;
  if not povrezhd_fl then Povrezhd_rg.Top:=0;

 if SQLstr<>'' then
  begin
   if povrezhd_fl then// ds
     begin
      Povrezhd_rg.Top:=GrB_like.Top;
      {if Povrezhd_rg.ItemIndex = 0
        then Ed_sear.Text:='text' // чтобы было сформировано условие
        else Ed_sear.Text:='';}

     end // if AnsiUppercase(SQLstr) = ...
      else begin
            MyOpenSQL(Qry_sear,SQLstr);
            DBLC_Sear.Left:=Lb_Name.Left+Lb_Name.Width+4;
            DBLC_Sear.Width:=(GrB_Spis.Left + GrB_Spis.Width) - DBLC_Sear.Left -5;
                // self.Width - 4{ ds }{528} - DBLC_Sear.Left;
            DBLC_Sear.DisplayValue:=Qry_sear.FieldByName(L_Field).asString;
            BB_Like.Enabled:=true;
            BB_Like.Visible:=true;
            Ed_Sear.Enabled:=true;
           end;
  end // if SQLstr <> '' ...
    else begin
          BB_Like.Enabled:=false;
          BB_Like.Visible:=false;
          Ed_Sear.Enabled:=true;
         end; // if SQLstr <> '' ... else
end;

procedure TFrm_SDb.Close;
begin
  Qry_sear.Close;
end;

{function TFrm_SDb.ReadId:string;
begin
  Result:=Fn_field;
end;

procedure TFrm_SDb.SetId(value:string);
begin
  Fn_field:=value;
end;}

function TFrm_SDb.GetSQL:string;
var i:integer;
    res,tt_str,UPl_field,UPl_value:string;
begin
   GetTit:=Lb_Name.Caption+'(';
   if SQLField='' then
      sQLField:=n_field;

   res:='';
   if Lb_Sear.Items.Count=1 then
      Lb_Sear.Items.Clear;

   if Lb_Sear.Items.Count=0 then
     begin
        BB_AddClick(NIL);
     end;
   if Lb_Sear.Items.Count>0 then
    begin
     for i:=0 to Lb_Sear.Items.Count-1 do
       begin
          tt_str:='';
          if isUpper=1
          then begin
            UPl_field:='upper('+l_field+')';
            UPl_value:=AnsiUpperCase(Lb_Sear.Items.Strings[i]);
          end
          else begin
            UPl_field:=l_field;
            UPl_value:=Lb_Sear.Items.Strings[i];
          end;
          if (integer(Lb_Sear.Items.Objects[i])=0) or (SQLfield='') then
             begin
               if isLike=1 then
                 begin
                  tt_str:=UPl_field+' like "%'+UPl_value+'%"';
                  GetTit:=GetTit+'~"'+Lb_Sear.Items.Strings[i]+'" ';
                 end
                 else begin
                  tt_str:=UPl_field+' = "'+UPl_value+'"';
                  GetTit:=GetTit+'="'+Lb_Sear.Items.Strings[i]+'" ';
                 end;
             end
          else if n_field<>'' then
             begin
                tt_str:=SQLfield+'='+inttostr(integer(Lb_Sear.Items.Objects[i]));
                GetTit:=GetTit+'="'+Lb_Sear.Items.Strings[i]+'" ';
             end;

          if tt_str<>'' then
            begin
              GetTit:=GetTit+') ';
              if i=0 then
                res:=tt_str
              else
                res:=res+' or '+tt_str;
            end
          else
            GetTit:='';
       end;
    end;

   if (AnsiUppercase(SQLstr) = 'POVREZHD') then // повреждение(частный случай)
      case Povrezhd_rg.Itemindex of
        0 {с раскопкой}  :res:=' ';
        1 {без раскопки} :res:='not';
        2 {все}          :res:='';
       end; // case
  //   end; // if (AnsiUppercase(SQLstr) = 'POVREZHD' ...
   if pos('#',mainSQLStr)=0 then
     res:=MainSQlStr;

   if (MainSQLstr<>'') and (res<>'') then
     begin
        tt_str:=MainSQLstr;
        repeat
            i:=pos('#',tt_str);
            if i>0 then
              begin
                delete(tt_str,i,1);
                insert(' ',tt_str,i);
                insert(res,tt_str,i);
              end;
        until i=0;
        res:=tt_str;
     end;
    GetTit:=Strip('B',' ',GetTit);
    Result:=res;
end;

procedure TFrm_SDb.BB_likeClick(Sender: TObject);
var tt_str,tt_str2,tf:string;
    i,n,k:integer;
begin
        if Like_field<>'' then
           tf:=Like_field
        else
           tf:=L_field;

        tt_str2:=SQLstr;
        n:=pos('where',tt_str2);
        k:=pos('order',tt_str2);
        if n>0 then
         begin
           tt_str:=' and '+tf+' like "%'+Strip('A','"',Ed_Sear.Text)+'%" ';
         end
        else
         begin
           tt_str:=' where '+tf+' like "%'+Strip('A','"',Ed_Sear.Text)+'%" ';
         end;

         if k>0 then
          insert(tt_str,tt_str2,k)
         else
          tt_str2:=tt_str2+tt_str;

    i:=0;
    MyOpenSQL(Qry_tmp,tt_str2);
    while (not Qry_tmp.Eof) and (i<10) do
      begin
            if n_field<>'' then
             Lb_Sear.Items.AddObject(Qry_tmp.FieldByName(L_field).asString,
                              TObject(Qry_tmp.FieldByName(n_field).asInteger))
            else
             Lb_Sear.Items.AddObject(Qry_tmp.FieldByName(L_field).asString,TObject(0));

        Qry_tmp.Next;
        inc(i);
      end;
    Qry_tmp.Close;
end;

constructor TFrm_SDb.Create(AOwner: TComponent);
begin
  inherited;
  Lb_name.Caption:=TrLangMSG(msgCondition);
  GrB_Spis.Caption:=' '+TrLangMSG(msgConditions)+' ';
  BB_Add.Caption:=TrLangMSG(msgAdd);
  BB_Del.Caption:=TrLangMSG(msgDelete);
  BB_Clear.Caption:=TrLangMSG(msgClear);
  GrB_like.Caption:=' '+TrLangMSG(msgSearchBody)+' ';
  BB_like.Caption:=TrLangMSG(msgSearch);
  Povrezhd_rg.Items[0]:=TrLangMSG(msgWithDigging);
  Povrezhd_rg.Items[1]:=TrLangMSG(msgWithoutDigging);
  Povrezhd_rg.Items[2]:=TrLangMSG(msgAll);
end;

end.
