unit cl_zadv;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, RXLookup, ComCtrls, Grids, DBGrids, RXDBCtrl,
  Buttons, Mask, ToolEdit, ExtCtrls, frmLANG, cntsLANG,datam,OperAttFormUnit,
  ServiceFuncUnit;

type
  TFormClZadv = class(TFormLang)
    Qry_adr: TQuery;
    Qry_ul1: TQuery;
    Qry_ul2: TQuery;
    DS_ul1: TDataSource;
    DS_ul2: TDataSource;
    DS_zadv: TDataSource;
    TbC_zadv: TTabControl;
    Qry_tadr: TQuery;
    __Qry_diam: TQuery;
    DS_tadr: TDataSource;
    __DS_diam: TDataSource;
    Qry_tmp: TQuery;
    Lb_zakr: TLabel;
    Lb_save: TLabel;
    Qry_BrIn: TQuery;
    DS_brIn: TDataSource;
    Qry_brOut: TQuery;
    DS_brOut: TDataSource;
    Lb_zavin: TLabel;
    Lb_zavout: TLabel;
    Qry_tmp2: TQuery;
    Panel1: TPanel;
    GrB_adres: TGroupBox;
    Label12: TLabel;
    Lb_NmUl: TLabel;
    Lb_Ndom: TLabel;
    DBL_ul1: TRxDBLookupCombo;
    Ed_ndom: TEdit;
    DBL_ul2: TRxDBLookupCombo;
    Ed_dopAdr: TEdit;
    CB_tadr: TRxDBLookupCombo;
    GridPanel: TPanel;
    DBGr_zadv: TRxDBGrid;
    Qry_diam: TQuery;
    DS_diam: TDataSource;
    Lb_cross: TLabel;
    Lb_place: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    qry_pad: TQuery;
    qry_well: TQuery;
    qry_bolt: TQuery;
    ds_pad: TDataSource;
    ds_well: TDataSource;
    ds_bolt: TDataSource;
    Qry_BrRec: TQuery;
    ds_BrRec: TDataSource;
    DS_DispOut: TDataSource;
    Qry_DispOut: TQuery;
    DS_DispIn: TDataSource;
    Qry_DispIn: TQuery;
    DS_Remont: TDataSource;
    Qry_Remont: TQuery;
    Qry_Zadv: TQuery;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    StringField1: TStringField;
    IntegerField3: TIntegerField;
    StringField2: TStringField;
    DateTimeField1: TDateTimeField;
    IntegerField4: TIntegerField;
    DateTimeField2: TDateTimeField;
    IntegerField5: TIntegerField;
    StringField3: TStringField;
    StringField4: TStringField;
    StringField5: TStringField;
    StringField6: TStringField;
    StringField7: TStringField;
    IntegerField6: TIntegerField;
    IntegerField7: TIntegerField;
    IntegerField8: TIntegerField;
    IntegerField9: TIntegerField;
    IntegerField10: TIntegerField;
    IntegerField11: TIntegerField;
    IntegerField12: TIntegerField;
    IntegerField14: TIntegerField;
    IntegerField15: TIntegerField;
    IntegerField16: TIntegerField;
    IntegerField17: TIntegerField;
    DateTimeField4: TDateTimeField;
    Qry_ZadvDT_REC: TDateTimeField;
    Qry_ZadvID_BRREC: TIntegerField;
    DopZadvPanel: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Bevel2: TBevel;
    Label11: TLabel;
    Label15: TLabel;
    DBL_Pad: TRxDBLookupCombo;
    DBL_Well: TRxDBLookupCombo;
    DBL_Bolt: TRxDBLookupCombo;
    TE_Remont: TDateTimePicker;
    DBL_Remont: TRxDBLookupCombo;
    DE_Remont: TDateEdit;
    Label1: TLabel;
    DBL_diam: TRxDBLookupCombo;
    chb_IsPervichViezd: TCheckBox;
    Qry_ZadvIS_PERVICH_VIEZD: TIntegerField;
    Qry_BrAct: TQuery;
    ds_BrAct: TDataSource;
    Qry_ZadvPEREDANO: TStringField;
    Qry_ZadvDT_ACT: TDateTimeField;
    Qry_ZadvID_BRACT: TIntegerField;
    Qry_ZadvNEEDWORKS: TStringField;
    DBL_DopAdres: TRxDBLookupCombo;
    Qry_ZadvID_DOPADRES: TIntegerField;
    Qry_DopAdres: TQuery;
    ds_DopAdres: TDataSource;
    Qry_ZadvDT_GRAN: TDateTimeField;
    Qry_ZadvID_BRGRAN: TIntegerField;
    qry_brGran: TQuery;
    ds_brGran: TDataSource;
    cb_is_sbros: TCheckBox;
    Label19: TLabel;
    qry_norm: TQuery;
    ds_norm: TDataSource;
    DBL_norm: TRxDBLookupCombo;
    Qry_ZadvIS_SBROS: TSmallintField;
    Qry_ZadvID_NORMAL_STATE: TSmallintField;
    GrB_Object: TGroupBox;
    Label20: TLabel;
    Label21: TLabel;
    Label24: TLabel;
    DBL_Soorug: TRxDBLookupCombo;
    DBL_Object: TRxDBLookupCombo;
    DBL_ObjObor: TRxDBLookupCombo;
    ds_Object: TDataSource;
    ds_Soorug: TDataSource;
    ds_ObjObor: TDataSource;
    Qry_Object: TQuery;
    Qry_Soorug: TQuery;
    Qry_ObjObor: TQuery;
    Label22: TLabel;
    OldRaskopPanel: TPanel;
    lbl_Gran: TLabel;
    Label10: TLabel;
    DE_Gran: TDateEdit;
    DE_Rec: TDateEdit;
    TE_Gran: TDateTimePicker;
    TE_Rec: TDateTimePicker;
    DBL_brGran: TRxDBLookupCombo;
    DBL_BRREC: TRxDBLookupCombo;
    DopRaskopPanel: TPanel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    TE_Act: TDateTimePicker;
    DE_Act: TDateEdit;
    ed_Peredano: TEdit;
    DBL_BrAct: TRxDBLookupCombo;
    mem_NeedWorks: TMemo;
    Label2: TLabel;
    Label3: TLabel;
    MainZadvPanel: TPanel;
    Label14: TLabel;
    Label13: TLabel;
    DE_in: TDateEdit;
    DE_out: TDateEdit;
    TE_in: TDateTimePicker;
    TE_Out: TDateTimePicker;
    DBL_brIn: TRxDBLookupCombo;
    DBL_brOut: TRxDBLookupCombo;
    BB_Open: TBitBtn;
    BtnPanel: TPanel;
    BB_Add: TBitBtn;
    BB_del: TBitBtn;
    BB_Save: TBitBtn;
    BB_Copy: TBitBtn;
    ChB_Exist: TCheckBox;
    BB_Exit: TBitBtn;
    Qry_ZadvID_OBJECT: TIntegerField;
    Qry_ZadvID_SOORUG: TIntegerField;
    Qry_ZadvID_OBJOBOR: TIntegerField;
    Qry_ZadvOBJECT: TStringField;
    Qry_Zadvobjname: TStringField;
    Qry_Zadvsoorname: TStringField;
    Qry_Zadvoborname: TStringField;
    procedure CB_tAdrChange(Sender: TObject);
    procedure Qry_zadvCalcFields(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BB_AddClick(Sender: TObject);
    procedure TbC_zadvChange(Sender: TObject);
    procedure BB_SaveClick(Sender: TObject);
    procedure Qry_zadvAfterScroll(DataSet: TDataSet);
    procedure DBL_ul1Change(Sender: TObject);
    procedure BB_ExitClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BB_delClick(Sender: TObject);
    procedure BB_OpenClick(Sender: TObject);
    procedure ChB_ExistClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBL_PadChange(Sender: TObject);
    procedure DBL_WellChange(Sender: TObject);
    procedure DE_outButtonClick(Sender: TObject);
    procedure chb_IsPervichViezdClick(Sender: TObject);
    procedure mem_NeedWorksKeyPress(Sender: TObject; var Key: Char);
    procedure BB_CopyClick(Sender: TObject);
    procedure DBL_ObjectChange(Sender: TObject);
    procedure DBL_SoorugChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure _SmartLightAddr;
    procedure _SmartLightBrigadir;
    procedure _SmartLightObject;    
    procedure VosstanovlDorPokryt;
    procedure AlignDopRaskopPanel;
  public
    { Public declarations }
    FReadOnly:boolean;
    FVosstanovlDorPokryt_Flag:boolean;
    Zadv2Cod:array [0..29] of integer;
    NewZap,isZadv:boolean;
    AlienZav:integer;
    zAttach:TOperAtt;
    F_isObj: boolean;
    F_rayon:integer;
    constructor ZadvCreate(AOwner: TComponent;Mode,zCod,nCod:integer;tAlias:string;zAtt:TOperAtt;
       _ReadOnly:boolean; _VosstanovlDorPokryt_Flag:boolean);
    procedure ZadvUpdate(seekId:integer);
    procedure RecUpdate(isNew:integer);
    function FindCod(Cod:integer):integer;
    procedure SwSave(st:boolean);
    function CountZadv(isCl:boolean):integer;
    procedure UstIzm;
    function ZapZav(cod:integer):string;
    function CheckFillClZ(toClose:boolean):boolean;
    procedure Text2Zadv(ss:integer);
    procedure _EnableCtrlsForZadvWithRemont;
    procedure Translate;override;
  end;

var
  FormClZadv: TFormClZadv;
  ZadvMode,ZajvCod,NarCod,ZadvCount:integer;
  ZadAlias:string;

implementation
 uses strtool,zav,vvod_ol,main, avartype, DateUtil, Zav_DMUnit;
{$R *.DFM}

procedure TFormClZadv._SmartLightBrigadir;
var _cl:TColor;
begin
  _cl:=clYellow;
  DBL_BrIn.Color:=_cl;
  DBL_Diam.Color:=_cl;
  {if not(BB_Open.Visible) then DBL_BrOut.Color:=_cl
    else DBL_BrOut.Color:=clWhite;}
end;

procedure TFormClZadv._SmartLightObject;
var _cl:TColor;
begin
  _cl:=clYellow;
  DBL_Object.Color:=_cl;
//  DBL_Diam.Color:=_cl;
end;

procedure TFormClZadv._SmartLightAddr;
var _cl:TColor;
begin
  _cl:=clYellow;
  case Qry_tAdr.FieldByName('ID').AsInteger of
    0: begin DBL_Ul1.Color:=_cl;  ED_Ndom.Color:=_cl; end;
    1: begin DBL_Ul1.Color:=_cl; DBL_Ul2.Color:=_cl; end;
    2: begin DBL_Ul1.Color:=clWhite; end;
  end;
end;

constructor TFormClZadv.ZadvCreate(AOwner: TComponent;Mode,zCod,nCod:integer;tAlias:string;
  zAtt:TOperAtt; _ReadOnly:boolean; _VosstanovlDorPokryt_Flag:boolean);
begin
 FReadOnly:=_ReadOnly;
 ZadvMode:=Mode; // 0 -закрытая, 1 - открытая
 ZajvCod:=zCod;
 NarCod:=nCod;
 ZadAlias:=tAlias;
 zAttach:=zAtt;
 FVosstanovlDorPokryt_Flag:=_VosstanovlDorPokryt_Flag;
 if (zAttach = toaObjVoda) or (zAttach = toaObjKanal) then F_isObj:= true
  else F_isObj := false;
 inherited Create(AOwner);
 GrB_Object.Visible := F_isObj;
 DBGr_zadv.Columns.Items[1].Visible := F_isObj;

// if F_isObj then FormClZadv.Height := FormClZadv.Height  - GrB_Object.Height; 
{ GrB_adres.Visible := not F_isObj;

 GrB_adres.Align := alTop;
 GrB_Object.Align := alTop;
 MainZadvPanel.Align := alClient;}
end;

procedure TFormClZadv.CB_tAdrChange(Sender: TObject);
begin
_SmartLightAddr;
//isSave(false);
//Qry_ul2.Close;
  if Qry_tadr['ID']=1 then
    begin
      lb_cross.Caption:='перехрестя с';
      Lb_NmUl.visible:=true;
      Lb_place.visible:=false;
      DBL_Ul1.Left:=Lb_NmUl.Left+Lb_NmUl.Width+4;
      Lb_cross.Left:=DBL_Ul1.Left+DBL_Ul1.Width+4;
      Lb_Ndom.Visible:=false;
      Lb_cross.Visible:=true;
      Ed_Ndom.Enabled:=false;
      Ed_Ndom.Visible:=false;
      if (ZadvMode>0) and (not FReadOnly) then
         DBL_Ul2.Enabled:=true;
      DBL_Ul2.Visible:=true;
      DBL_Ul2.Left:=Lb_cross.Left+Lb_cross.Width+4;
      DBL_DopAdres.Enabled:=false;
      DBL_DopAdres.Visible:=false;
      //Qry_ul2.Open;
    end
  else if Qry_tadr['ID']=2 then
    begin
      lb_cross.Caption:='доп. адрес';
      Lb_NmUl.visible:=false;
      Lb_place.visible:=true;
      DBL_Ul1.Left:=Lb_place.Left+Lb_place.Width+4;
      Lb_cross.Left:=DBL_Ul1.Left+DBL_Ul1.Width+4;
      Lb_Ndom.Visible:=false;
      Lb_cross.Visible:=true;
      Ed_Ndom.Enabled:=false;
      Ed_Ndom.Visible:=false;
      DBL_Ul2.Enabled:=false;
      DBL_Ul2.Visible:=false;
      DBL_DopAdres.Visible:=true;
      DBL_DopAdres.Enabled:=((ZadvMode>0) and (not FReadOnly));
      DBL_DopAdres.Left:=Lb_cross.Left+Lb_cross.Width+4;
    end
  else
    begin
      Lb_NmUl.visible:=true;
      Lb_place.visible:=false;
      DBL_Ul1.Left:=Lb_NmUl.Left+Lb_NmUl.Width+4;
      Lb_Ndom.Left:=DBL_Ul1.Left+DBL_Ul1.Width+4;
      Lb_Ndom.Visible:=true;
      Lb_cross.Visible:=false;
      if (ZadvMode>0) and (not FReadOnly) then
         Ed_Ndom.Enabled:=true;
      Ed_Ndom.Visible:=true;
      Ed_Ndom.Left:=Lb_Ndom.Left+Lb_Ndom.Width+4;
      DBL_Ul2.Enabled:=false;
      DBL_Ul2.Visible:=false;
      DBL_DopAdres.Enabled:=false;
      DBL_DopAdres.Visible:=false;
    end;
  SwSave(true);
end;


procedure TFormClZadv.Qry_zadvCalcFields(DataSet: TDataSet);
var tt_str, ul:string;
begin
   //DataSet['FullName'] := DataSet['LASTNAME'] + ', ' + DataSet['FIRSTNAME'];
   Qry_Ul1.Locate('ID',DataSet['ID_UL1'],[]);
   tt_str:=trim(Qry_Ul1['NAME_R']);  ///Qry_Ul1.FieldByName('NAME_R').asString;
   if DataSet['UL_KOD']=0 then
    begin
      tt_str:=tt_str+','+trim(DataSet['ID_UL2']);
    end
   else if DataSet['UL_KOD']=1 then
    begin
      Qry_Ul2.Locate('ID',DataSet['ID_UL2'],[]);
      tt_str:=tt_str+' '+TrLangMSG(msgCross)+' '+trim(Qry_Ul2['NAME_R']);
    end
   else if DataSet['UL_KOD']=2 then
    begin
      Qry_DopAdres.Locate('ID', DataSet['ID_DOPADRES'],[]);

      if pos('', AnsiLowerCase(tt_str))=0 then ul:=trim(tt_str)
      else ul:='';
      tt_str:=TrLangMSG(msgPlaceShort)+':'+ul;
      if Qry_DopAdres['ID']<>-1 then
      begin
        if ul<>'' then
          tt_str:=tt_str+';';
        tt_str:=tt_str+trim(Qry_DopAdres['NAME_R']);
      end;
    end;
    DataSet['ADRES']:=tt_str;
  /////////////
   if F_isObj then
    begin
    tt_str:= '';
    tt_str := trim(DataSet.fieldbyname('ObjName').AsString);
    tt_str := tt_str + '; ' +trim(DataSet.fieldbyname('SoorName').AsString);
    tt_str := tt_str + '; ' +trim(DataSet.fieldbyname('OborName').AsString);
    DataSet['OBJECT']:=tt_str;
   end
   else
    DataSet['OBJECT']:='';
end;

procedure TFormClZadv.VosstanovlDorPokryt;
begin
  if (zAttach in [toaVoda,toaKanal,toaVRK,toaObjVoda,toaObjKanal]) and FVosstanovlDorPokryt_Flag then
  begin
   Label10.Visible:=True;
   DE_Rec.Visible:=True;
   TE_Rec.Visible:=True;
   DBL_BRREC.Visible:=True;
   //
   lbl_Gran.Visible := true;
   DE_Gran.Visible := true;
   TE_Gran.Visible := true;
   dbl_brGran.Visible := true;
  end;
end;

procedure TFormClZadv.FormCreate(Sender: TObject);
var
  ff:TField;
begin
  if FormZav.FltDel and not FormMain.DictNotHide.checked
  then begin
    SetFilterDelete(Qry_diam,true);
    SetFilterDelete(Qry_norm,true);
    SetFilterDelete(Qry_ul1,true);
    SetFilterDelete(Qry_ul2,true);
    SetFilterDelete(Qry_DopAdres, true);
    SetFilterDelete(Qry_brIn,true);
    SetFilterDelete(Qry_brOut,true);
    SetFilterDelete(Qry_brRec,true);
    SetFilterDelete(Qry_brGran, true);
    SetFilterDelete(Qry_brAct,true);
    SetFilterDelete(Qry_Remont,true);
    SetFilterDelete(Qry_Object,true);
    SetFilterDelete(Qry_Soorug,true);
    SetFilterDelete(Qry_ObjObor,true);
  end;


  if ZadAlias='zadv' then
  begin
     isZadv:=true;
     {nut anton}
{
     ff:=TIntegerField.Create(Qry_zadv);
     ff.name:='ID_PAD';
     ff.FieldName:='ID_PAD';
     ff.Origin:='ZADV.ID_PAD';
//     Qry_zadv.Fields.Add(ff);
     ff:=TIntegerField.Create(Qry_zadv);
     ff.name:='ID_WELL';
     ff.Origin:='ZADV.ID_WELL';
     ff.FieldName:='ID_Well';
//     Qry_zadv.Fields.Add(ff);
     ff:=TIntegerField.Create(qry_zadv);
     ff.name:='ID_BOLT';
     ff.FieldName:='ID_BOLT';
     ff.Origin:='ZADV.ID_BOLT';
//     Qry_zadv.Fields.Add(ff);
}
    Qry_zadv.Fields.Remove(Qry_zadv.FieldByName('ID_BRREC'));
    Qry_zadv.Fields.Remove(Qry_zadv.FieldByName('DT_REC'));
    Qry_zadv.Fields.Remove(Qry_zadv.FieldByName('PEREDANO'));
    Qry_zadv.Fields.Remove(Qry_zadv.FieldByName('DT_ACT'));
    Qry_zadv.Fields.Remove(Qry_zadv.FieldByName('ID_BRACT'));
    Qry_zadv.Fields.Remove(Qry_zadv.FieldByName('NEEDWORKS'));
    Qry_zadv.Fields.Remove(Qry_zadv.FieldByName('DT_GRAN'));
    Qry_zadv.Fields.Remove(Qry_zadv.FieldByName('ID_BRGRAN'));

    DopRaskopPanel.Hide;
  end
  else
    begin
     isZadv:=false;
     Qry_zadv.Fields.Remove(Qry_zadv.FieldByName('IS_PERVICH_VIEZD'));
     Qry_zadv.Fields.Remove(Qry_zadv.FieldByName('ID_PAD'));
     Qry_zadv.Fields.Remove(Qry_zadv.FieldByName('ID_WELL'));
     Qry_zadv.Fields.Remove(Qry_zadv.FieldByName('ID_BOLT'));
     Qry_zadv.Fields.Remove(Qry_zadv.FieldByName('ID_DIAM'));
     Qry_zadv.Fields.Remove(Qry_zadv.FieldByName('ID_REMONT'));
     Qry_zadv.Fields.Remove(Qry_zadv.FieldByName('DT_REMONT'));
     //
     Qry_zadv.Fields.Remove(Qry_zadv.FieldByName('ID_DISP_IN'));
     Qry_zadv.Fields.Remove(Qry_zadv.FieldByName('ID_DISP_OUT'));
     Qry_zadv.Fields.Remove(Qry_zadv.FieldByName('disp_in_look'));
     Qry_zadv.Fields.Remove(Qry_zadv.FieldByName('disp_out_look'));
     //
     Qry_zadv.Fields.Remove(Qry_zadv.FieldByName('ID_OBJECT'));
     Qry_zadv.Fields.Remove(Qry_zadv.FieldByName('ID_SOORUG'));
     Qry_zadv.Fields.Remove(Qry_zadv.FieldByName('ID_OBJOBOR'));
     //
     DBGr_zadv.Columns[3].Visible:=false;
     DBGr_zadv.Columns[6].Visible:=false;
     {}
     Label1.Visible:=false;
     DBL_Diam.Enabled:=false;
     DBL_Diam.Visible:=false;
     Label14.visible:=false;
     Label2.visible:=true;
     Label13.visible:=false;
     Label3.visible:=true;

     {Label8.Visible:=False;
     Label9.Visible:=False;
     Label7.Visible:=False;
     DBL_Pad.Enabled:=false;
     DBL_Pad.Visible:=false;
     DBL_Well.Enabled:=false;
     DBL_Well.Visible:=false;
     DBL_Bolt.Enabled:=false;
     DBL_Bolt.Visible:=false;}
     DopZadvPanel.Hide;

     AlignDopRaskopPanel;
     VosstanovlDorPokryt;


{
     BB_Open.Caption:=TrLangMSG(msgDoDiggRaskop);
     GrB_adres.Caption:=TrLangMSG(msgAddrRaskop);
     ChB_Exist.Caption:=TrLangMSG(msgDoAddRaskopFromZajav);
     DBGr_zadv.Columns[0].Title.Caption:=TrLangMSG(msgAddrRaskop);
     DBGr_zadv.Columns[1].Title.Caption:=TrLangMSG(msgDiggRaskop);
     DBGr_zadv.Columns[3].Title.Caption:=TrLangMSG(msgNoDiggRaskop);
}
    end;
  FormClZadv:=Self;
  UstColors(Self);
  NewZap:=false;
  AlienZav:=-1;
  Qry_tadr.Open;
  Qry_ul1.Open;
  Qry_ul2.Open;
  Qry_DopAdres.Open;
  if isZadv then
  begin
    Qry_diam.Open;
    Qry_pad.Open;
    Qry_norm.Open;
    if F_isObj then
      begin

        Qry_Object.Open;
        Qry_Object.First;
        Qry_Soorug.Open;
        Qry_ObjObor.Open;
      end;
//    Qry_well.Open;
//    Qry_bolt.Open;
  end else
    Qry_BrAct.Open;

  Qry_BrIn.Open;
  Qry_Remont.Open;
  Qry_BrOut.close; Qry_BrOut.Open;
  Qry_BrRec.close; Qry_BrRec.Open;
  Qry_brGran.Close; Qry_brGran.Open;
  ZadvUpdate(0);

  if (ZadvMode=0) or FReadOnly then
    begin
      DBL_ul1.Enabled:=false;
      DBL_ul2.Enabled:=false;
      DBL_DopAdres.Enabled:=false;
      DBL_BrIn.Enabled:=false;
      DBL_Remont.Enabled:=false;
      Ed_dopAdr.Enabled:=false;
      Ed_Ndom.Enabled:=false;
      DE_In.Enabled:=false;
      TE_In.Enabled:=false;
      //DBL_Diam.Enabled:=false;
      CB_tadr.Enabled:=false;
      BB_Add.Enabled:=false;
      BB_Copy.Enabled:=false;
      BB_Del.Enabled:=false;
      BB_Open.Enabled:=false;
      BB_Open.Visible:=false;
      ChB_Exist.Enabled:=false;
      //DE_Out.Enabled:=true;//false;
      DE_Rec.Enabled:=false;
      //Te_Out.Enabled:=true;//false;
      TE_Rec.Enabled:=false;
      //DBL_BrOut.Enabled:=true;//false;
      DBL_BRREC.Enabled:=false;

      DE_Gran.Enabled := false;
      TE_Gran.Enabled := false;
      DBL_brGran.Enabled := false;

      if (ZadAlias='raskop') and (not NewZap) then
      begin
        if ((DE_Out.Date=NullDate) and  (Trim(DBL_brOut.DisplayValue)='')) then
        begin
          DE_Out.Enabled:=true;
          Te_Out.Enabled:=true;
          DBL_BrOut.Enabled:=true;
          BB_Open.Enabled:=true;
          BB_Open.Visible:=true;
        end;

        if ((DE_Gran.Date=NullDate) and  (Trim(DBL_brGran.DisplayValue)='')) then
        begin
          DE_Gran.Enabled := true;
          TE_Gran.Enabled := true;
          DBL_brGran.Enabled := true;
        end;

        if ((DE_Rec.Date=NullDate) and  (Trim(DBL_brRec.DisplayValue)='')) and (zAttach in [toaVoda,toaKanal,toaVRK,toaObjVoda,toaObjKanal]) then
        begin
          DE_Rec.Enabled:=true;
          TE_Rec.Enabled:=true;
          DBL_BRREC.Enabled:=true;
        end;
      end;
    end;
    _SmartLightObject;
    _SmartLightBrigadir;
    _EnableCtrlsForZadvWithRemont;
end;

procedure TFormClZadv.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Qry_tadr.Close;
  Qry_ul1.Close;
  Qry_ul2.Close;
  Qry_DopAdres.Close;
  Qry_diam.Close;
  Qry_norm.Close;
  Qry_zadv.Close;
  Qry_BrIn.Close;
  Qry_BrOut.Close;
  Qry_BrRec.Close;
  Qry_brGran.Close;
  Qry_Remont.Open;
  Qry_DispIn.Close;
  Qry_DispOut.Close;
  Qry_BrAct.Close;
end;

procedure TFormClZadv.ZadvUpdate(seekId:integer);
var i:integer;
begin
  if isZadv
  then Caption:=format(TrLangMSG(msgCloseZadvCount),[CountZadv(false),CountZadv(true)])
  else Caption:=format(TrLangMSG(msgCloseRaskopCount),[CountZadv(false),CountZadv(true)]);

      TbC_zadv.Tabs.Clear;
      MyOpenSQL(Qry_tmp,'select count(id) mm from '+ZadAlias+' where id_zavin='+IntToStr(ZajvCod)+
                       ' or id_zavout='+IntToStr(ZajvCod)+
                       ' or id='+IntToStr(AlienZav));
      if Qry_tmp['MM']>0 then
       begin
        ZadvCount:=Qry_tmp['MM'];
        Qry_tmp.Close;
        Qry_Zadv.Close;
        if isZadv then
           Qry_zadv.SQL.text:='select ID, ID_ZAVIN, ID_NARIN, ID_ZAVOUT, ID_NAROUT, ID_UL1, ID_UL2, UL_KOD, DOP_ADR, ID_DIAM, DT_IN, ID_BRIN '+
                              ', DT_OUT, ID_BROUT, ID_WELL, ID_BOLT, ID_PAD, ID_DISP_IN, ID_DISP_OUT, ID_REMONT, DT_REMONT '+
                              ', IS_PERVICH_VIEZD, ID_DOPADRES, IS_SBROS, ID_NORMAL_STATE, ID_OBJECT, ID_SOORUG, ID_OBJOBOR '+
                              ' , (select so.name_r from s_object so where so.id = zadv.id_object) objname '+
                              ' , (select ss.name_r from s_soorug ss where ss.id = zadv.id_soorug) soorname '+
                              ' , (select soo.name_r from s_objobor soo where soo.id = zadv.id_objobor) oborname '+
                              ' from '+ZadAlias+' where id_zavin='+IntToStr(ZajvCod)+
                                                 ' or id_zavout='+IntToStr(ZajvCod)+
                                                 ' or id='+IntToStr(AlienZav)
        else
          begin
           Qry_zadv.SQL.text:='select id,id_zavin,id_narin,id_zavout,id_narout,'+
            'id_ul1,id_ul2,ul_kod,dop_adr,dt_in,id_brin,dt_out,id_brout,'+
            'id_brrec,dt_rec,id_brgran,dt_gran,peredano,dt_act,id_bract,needworks,id_DopAdres from '+
              ZadAlias+' where id_zavin='+IntToStr(ZajvCod)+
                       ' or id_zavout='+IntToStr(ZajvCod)+
                       ' or id='+IntToStr(AlienZav);
          end;                       
    try
        Qry_zadv.Open;
        Qry_zadv.First;
//        TbC_zadv.Tabs.Clear;
        for i:=0 to ZadvCount-1 do
          begin
              if Qry_zadv['ID']=AlienZav then
                 TbC_zadv.Tabs.Add('Чужая'+inttostr(i+1))
              else
                 TbC_zadv.Tabs.Add('N'+inttostr(i+1));
              Zadv2Cod[i]:=Qry_zadv['ID'];
            Qry_zadv.Next;
          end;
              if SeekId>0 then
                begin
                 Qry_zadv.Locate('ID',seekId,[])
                end
              else
                begin
                 Qry_zadv.First;
                end;
          TbC_zadv.TabIndex:=FindCod(Qry_zadv['ID']);
          RecUpdate(1);
    except
    on e:exception do
    begin
      BB_SaveClick(nil);  //uo  Пока не знаю почему
    end;
    end;
       end
      else
       begin
         TbC_zadv.Tabs.Clear;
         Qry_Zadv.Close;
         if not FReadOnly then
            BB_AddClick(Self);
       end;
  end;

procedure TFormClZadv.RecUpdate(isNew:integer);
var i_norm, _temp_id_soorug:integer;
begin
   if isNew=0 then
     begin
          {Qry_tadr.First;
          Qry_ul1.First;
          Ed_Ndom.Text:='';
          Ed_dopAdr.Text:='';}
          /// ??? может открою потом
            Qry_tadr.Locate('ID',FormZav.CB_tAdr.ItemIndex,[]);
            Qry_ul1.Locate('ID',FormZav.FDM_Zav.Qry_ul1.FieldByName('ID').asInteger,[]);
            if FormZav.FDM_Zav.Qry_ul2.Active then
              Qry_ul2.Locate('ID',FormZav.FDM_Zav.Qry_ul2.FieldByName('ID').asInteger,[]);
            if FormZav.FDM_Zav.qry_DopAdres.Active then
              Qry_DopAdres.Locate('ID', FormZav.FDM_Zav.qry_DopAdres.FieldByName('ID').AsInteger,[]);
            ///
            Ed_Ndom.Text:=FormZav.Ed_ndom.Text;
            Ed_dopAdr.Text:=FormZav.Ed_dopAdr.Text;

          Qry_BrIn.First;
          Qry_BrOut.First;
          Qry_Remont.First;
          if isZadv then
          begin
            Qry_diam.First;
            Qry_pad.First;
            Qry_norm.First;
//            Qry_well.First;
//            Qry_bolt.First;
          end
          else
          begin
            Qry_BrRec.First;
            Qry_brGran.First;
            Qry_BrAct.First;
            ed_Peredano.Text:='';
            mem_NeedWorks.Text:='';
            DE_Act.Text:='';
            TE_Act.Time:=0;
          end;

          DE_in.Date:=MyNow;
          TE_In.Time:=MyNow;
          DE_Out.Text:='';
          TE_Out.Time:=0; //Time2Str(Now);
          DE_Rec.Text:='';
          TE_Rec.Time:=0; //Time2Str(Now);
          DE_Gran.Text := '';
          TE_Gran.Time := 0;
          Lb_zavin.Caption:='';
          Lb_zavout.Caption:='';
          if isZadv then
            chb_IsPervichViezd.Checked:=true;
     end
   else if isNew=1 then
     begin
{
          if F_IsObj then
           begin
              Qry_Object.Locate('ID',Qry_Zadv.fieldbyname('id_object').AsInteger,[]);
              DBL_ObjectChange(nil);
              Qry_Soorug.Locate('ID',Qry_Zadv.fieldbyname('id_Soorug').AsInteger,[]);
              DBL_SoorugChange(nil);
              Qry_ObjObor.Locate('ID',Qry_Zadv.fieldbyname('id_ObjObor').AsInteger,[]);
           end;
 }

              Qry_ul1.Locate('ID',Qry_zadv['ID_UL1'],[]);
              if Qry_zadv['UL_KOD']=0 then
                 Ed_Ndom.Text:=Qry_zadv['ID_UL2']
              else if Qry_zadv['UL_KOD']=1 then
                 Qry_ul2.Locate('ID',Qry_zadv['ID_UL2'],[])
              else if Qry_zadv['UL_KOD']=2 then
                 Qry_DopAdres.Locate('ID', Qry_Zadv['id_DopAdres'],[]);
              Qry_tadr.Locate('ID',Qry_zadv['UL_KOD'],[]);
              Ed_dopAdr.Text:=Qry_zadv['DOP_ADR'];


          Qry_BrIn.Locate('ID',Qry_zadv['ID_BRIN'],[]);
          if isZadv then Qry_Remont.Locate('ID',Qry_zadv['ID_REMONT'],[]);
          Qry_BrOut.Locate('ID',Qry_zadv['ID_BROUT'],[]);
          if isZadv then
          begin
             Qry_diam.Locate('ID',Qry_zadv['ID_DIAM'],[]);
             Qry_norm.Locate('ID',Qry_zadv['ID_NORMAL_STATE'],[]);
             Qry_pad.Locate('ID',Qry_zadv.FieldByName('ID_PAD').AsInteger,[]);
             cb_is_sbros.Checked := (Qry_Zadv.FieldByName('is_sbros').AsInteger = 1);

//             Qry_pad.Locate('ID',Qry_zadv['ID_PAD'],[]);
//             Qry_well.Locate('ID',Qry_zadv['ID_WELL'],[]);
//             Qry_bolt.Locate('ID',Qry_zadv['ID_BOLT'],[]);
          end
          else
          begin
            Qry_BrRec.Locate('ID',Qry_zadv['ID_BRREC'],[]);
            Qry_brGran.Locate( 'ID', Qry_zadv['ID_BRGRAN'],[]);
            Qry_BrAct.Locate('ID',Qry_zadv['ID_BRACT'],[]);
          end;


          Ed_dopAdr.Text:=Qry_zadv['DOP_ADR'];
          DE_in.Date:=Qry_zadv.FieldByName('DT_IN').asDateTime;
          TE_In.Time:=Qry_zadv.FieldByName('DT_IN').asDateTime;
          DE_Out.Date:=Qry_zadv.FieldByName('DT_OUT').asDateTime;
          TE_Out.Time:=Qry_zadv.FieldByName('DT_OUT').asDateTime;
          if isZadv then
            begin
              DE_Remont.Date:=Qry_zadv.FieldByName('DT_REMONT').asDateTime;
              TE_Remont.Time:=Qry_zadv.FieldByName('DT_REMONT').asDateTime;
            end;
          if not isZadv then
          begin
            DE_Rec.Date:=Qry_zadv.FieldByName('DT_Rec').asDateTime;
            TE_Rec.Time:=Qry_zadv.FieldByName('DT_Rec').asDateTime;

            DE_Gran.Date:=Qry_zadv.FieldByName('DT_Gran').asDateTime;
            TE_Gran.Time:=Qry_zadv.FieldByName('DT_Gran').asDateTime;

            DE_Act.Date:=Qry_zadv.FieldByName('DT_Act').AsDateTime;
            TE_Act.Time:=Qry_zadv.FieldByName('DT_Act').AsDateTime;

            ed_Peredano.Text:=Qry_zadv.FieldByName('peredano').AsString;
            mem_NeedWorks.Text:=Qry_zadv.FieldByName('needworks').AsString;
          end;
          UstIzm;
          Lb_zavin.Caption:=ZapZav(Qry_zadv.FieldByName('ID_ZAVIN').asInteger);
          if Qry_zadv.FieldByName('ID_ZAVOUT').asInteger>0 then
            begin
             Lb_zakr.Caption:='';
             BB_Open.Enabled:=false;
             BB_Open.Visible:=false;
             Lb_zavout.Visible:=true;
             Lb_zavout.Caption:=ZapZav(Qry_zadv.FieldByName('ID_ZAVOUT').asInteger);
            end
          else
            begin
             if isZadv then
               Lb_zakr.Caption:=TrLangMSG(msgPereCloseZadv)+'!'
             else
               Lb_zakr.Caption:=TrLangMSG(msgDiggRaskop)+'!';
             {if ZadvMode<>0 then
              begin}
                if (not FReadOnly) then
                 begin
                  BB_Open.Enabled:=true;
                  BB_Open.Visible:=true;
                 end;
                Lb_zavout.Visible:=false;
              {end
             else
               Lb_zavout.Visible:=true}
            end;
          if isZadv then
            if Qry_zadv['IS_PERVICH_VIEZD']=1 then
              chb_IsPervichViezd.Checked:=true
            else
              chb_IsPervichViezd.Checked:=false;
     end
  else if isNew=2 then
    begin
      BB_Open.Visible:=true;
      BB_Open.Enabled:=false;
    end;

  if isZadv then
  begin
    DBL_diam.DisplayValue:=Qry_diam['DIAM'];
    DBL_norm.DisplayValue:=Qry_norm['NAME_R'];
    i_norm := Qry_norm.FieldByName('ID').AsInteger;
    if i_norm = 2 then
    begin
     //
      Label13.Caption := 'Перекрита';
      Label14.Caption := 'Відкрита';
      BB_Open.Caption := 'Відкрити';
    end
    else
    begin
      //
      Label13.Caption := 'Відкрита';
      Label14.Caption := 'Перекрита';
      BB_Open.Caption := 'Перекрити';
    end;

    cb_is_sbros.Checked := (Qry_Zadv.FieldByName('is_sbros').AsInteger = 1);
    DBL_pad.DisplayValue:=Qry_pad['NAME_R'];
//    DBL_well.DisplayValue:=Qry_well['NAME_R'];
//    DBL_bolt.DisplayValue:=Qry_bolt['NAME_R'];
  end
  else
  begin
    DBL_BrRec.DisplayValue:=Qry_BrRec['NAME_R'];
    DBL_BrGran.DisplayValue := Qry_brGran['NAME_R'];
    DBL_BrAct.DisplayValue:=Qry_BrAct['NAME_R'];
  end;

  if F_IsObj then
   begin
    //
    Qry_Object.Locate('ID',Qry_Zadv.fieldbyname('id_object').AsInteger,[]);
    DBL_Object.DisplayValue := Qry_Object.fieldbyname('NAME_R').AsString;
    Qry_Soorug.Locate('ID',Qry_Zadv.fieldbyname('id_Soorug').AsInteger,[]);
    DBL_Soorug.DisplayValue := Qry_Soorug.fieldbyname('NAME_R').AsString;
    Qry_ObjObor.Locate('ID',Qry_Zadv.fieldbyname('id_ObjObor').AsInteger,[]);
    DBL_ObjObor.DisplayValue := Qry_ObjObor.fieldbyname('NAME_R').AsString;
   end;
    //
    DBL_ul1.DisplayValue:=Qry_ul1['NAME_R'];
    DBL_ul2.DisplayValue:=Qry_ul2['NAME_R'];
    DBL_DopAdres.DisplayValue:=Qry_DopAdres['NAME_R'];
    CB_tadr.DisplayValue:=Qry_tadr['NAME_R'];
    CB_tAdrChange(Self);

  DBL_BrIn.DisplayValue:=Qry_BrIn['NAME_R'];
  if isZadv then DBL_Remont.DisplayValue:=Qry_Remont['NAME_R'];
  DBL_BrOut.DisplayValue:=Qry_BrOut['NAME_R'];


  SwSave(false);
{  if DE_Out.Date=0 then
    Lb_zakr.Caption:='Перекрыта !'
  else
    Lb_zakr.Caption:='';}
  if (ZadvMode<>0) and (not FReadOnly) then
  begin
   BB_Add.Enabled:= not NewZap;
   BB_Copy.Enabled:=not NewZap;
  end;
  _SmartLightBrigadir;
  _EnableCtrlsForZadvWithRemont;   
end;


procedure TFormClZadv.BB_AddClick(Sender: TObject);
var tt_str,s,_dop_where:string;
begin
 if ChB_Exist.Checked then
   begin
     // if isZadv
     //then
     _dop_where:='z.id_zavout=0 and u.id=z.id_ul1 and v.id=u.id_vidul '+
      ' and id_zavin in (select id from zavjav where (delz=0))';
     s:=TrLangMSG(msgSelCloseZadv);
     tt_str:=VvodOl(Self,10,'DBN_AVAR',s,
     'select u.name_r||" "||v.name_r||" от "||cast(z.dt_in as char(20)) vvod,z.id '+
     'from zadv z,s_ulic u,s_vidul v where '+_dop_where,_dop_where,
     {'select cast(nomer as char(6))||" "||cast(dt_in as char(20)) vvod,id from nzavjav order by nomer',}
     '1', toaNull, TRUE, NIL);
     if tt_str<>'' then
       begin
        AlienZav:=strtoint(tt_str);
        ZadvUpdate(AlienZav);
        BB_Add.Enabled:=false;
        BB_Copy.Enabled:=false;
        SwSave(true);
       end;
   end
 else
   begin
    TbC_zadv.Tabs.Add(TrLangMSG(msgNewW));
    TbC_zadv.TabIndex:=TbC_zadv.Tabs.Count-1;
    RecUpdate(0);
    NewZap:=true;
    BB_Add.Enabled:=false;
    BB_Copy.Enabled:=false;
    SwSave(true);
   end;
end;

procedure TFormClZadv.TbC_zadvChange(Sender: TObject);
begin
  if NewZap then
   begin
     if MessageDlg(TrLangMSG(msgExitWithSaveREC),
                 mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        begin
           TbC_zadv.Tabs.Delete(TbC_zadv.Tabs.Count-1);
           TbC_zadv.TabIndex:=TbC_zadv.Tabs.Count-1;
           Qry_zadv.Locate('ID',Zadv2Cod[TbC_zadv.TabIndex],[]);
           NewZap:=false;
           SwSave(false);
        end
     else
        begin
           TbC_zadv.TabIndex:=TbC_zadv.Tabs.Count-1;
           RecUpdate(0);
           exit;
        end;
   end
  else if BB_Save.Enabled then
   begin
     if MessageDlg(TrLangMSG(msgExitWithSave),
                 mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        begin
           {TbC_zadv.Tabs.Delete(TbC_zadv.Tabs.Count-1);
           TbC_zadv.TabIndex:=TbC_zadv.Tabs.Count-1;
           Qry_zadv.Locate('ID',Zadv2Cod[TbC_zadv.TabIndex],[]);
           NewZap:=false;}
           //AlienZap:=-1;
           SwSave(false);
        end
     else
        begin
           TbC_zadv.TabIndex:=FindCod(Qry_zadv['ID']);
           //RecUpdate(true);
           exit;
        end;

   end;
 Qry_zadv.Locate('ID',Zadv2Cod[TbC_zadv.TabIndex],[]);
 RecUpdate(1);
end;

procedure TFormClZadv.BB_SaveClick(Sender: TObject);
var ss:integer;
    tt_str,_rem_date:string;
begin
if ProvDate(DE_in.Date,DE_Out.Date,Time2Str(TE_in.Time),Time2Str(TE_out.Time))
 and ProvDate(DE_out.Date,DE_Gran.Date,Time2Str(TE_out.Time),Time2Str(TE_Gran.Time))
 and ProvDate(DE_Gran.Date,DE_Rec.Date,Time2Str(TE_Gran.Time),Time2Str(TE_rec.Time))
 //and ProvDate(DE_Rec.Date,DE_out.Date,Time2Str(TE_Rec.Time),Time2Str(TE_out.Time))
  then
 begin
  if NewZap then
    begin
//      tt_str:='insert into '+ZadAlias+'(id_zavin,id_zavout,id_ul1,id_ul2,ul_kod,dop_adr,id_dopadres,';
      tt_str:='insert into '+ZadAlias+'(id_zavin,id_zavout,';
      if F_isObj then
        tt_str:=tt_str+'id_object , id_soorug, id_objobor,';
//       else
        tt_str:=tt_str+'id_ul1,id_ul2,ul_kod,dop_adr,id_dopadres,';
      if isZadv then
        tt_str:=tt_str+'id_diam,id_pad,id_well,id_bolt, is_sbros, ID_NORMAL_STATE,'
      else
        if zAttach in [toaVoda,toaKanal,toaVRK,toaObjVoda,toaObjKanal] then tt_str:=tt_str+'dt_Rec,id_brrec,dt_gran,id_brgran,';
      //
      tt_str:=tt_str+'dt_in,dt_out,id_brin,id_brout';
      if isZadv then tt_str:=tt_str+',id_disp_in,id_remont,dt_remont,is_pervich_viezd'
      else tt_str:=tt_str+',peredano,dt_act,id_bract,needworks';
      tt_str:=tt_str+') values('+IntToStr(ZajvCod)+',0,';

      if F_isObj then
       begin
        if Qry_Object.FieldByName('id').AsInteger>0 then tt_str:=tt_str + Qry_Object.FieldByName('ID').asString+','
                                                     else tt_str:=tt_str + ' NULL,';
        if Qry_soorug.FieldByName('id').AsInteger>0 then tt_str:=tt_str + Qry_soorug.FieldByName('ID').asString+','
                                                     else tt_str:=tt_str + ' NULL,';
        if Qry_ObjObor.FieldByName('id').AsInteger>0 then tt_str:=tt_str + Qry_ObjObor.FieldByName('ID').asString+','
                                                     else tt_str:=tt_str + ' NULL,';
       end;
//       else
//       begin
          tt_str:=tt_str + Qry_ul1.FieldByName('ID').asString+',';
          if Qry_tadr['ID']=1 then
             tt_str:=tt_str+Qry_ul2.FieldByName('ID').asString
          else if Qry_tadr['ID']=2 then
             tt_str:=tt_str+'"0"'
          else
             tt_str:=tt_str+'"'+Strip('A','"',Ed_Ndom.Text)+'"';

          tt_str:=tt_str+','+Qry_tAdr.FieldByName('ID').asString+',"'+{Ed_dopAdr.Text+}'",';

          if Qry_tadr['ID']=2 then
            tt_str:=tt_str+Qry_DopAdres.FieldByName('ID').AsString+','
          else
            tt_str:=tt_str+'-1,';
//       end;

      if isZadv then
      begin
         tt_str:=tt_str+Qry_diam.FieldByName('ID').asString+','+
                 IntToStr(Qry_pad.FieldByName('ID').asInteger)+',';
        if Qry_well.Active then
          tt_str:=tt_str+ IntToStr(Qry_well.FieldByName('ID').asInteger)+','
        else
          tt_str:=tt_str+'0,';
        if Qry_Bolt.Active then
          tt_str:=tt_str+ IntToStr(Qry_bolt.FieldByName('ID').asInteger)+','
        else
          tt_str:=tt_str+'0,';

        if cb_is_sbros.Checked then tt_str:=tt_str+'1,'
          else tt_str:=tt_str+'0,';

        if Qry_norm.Active then
          tt_str:=tt_str+ IntToStr(Qry_norm.FieldByName('ID').asInteger)+','
        else
          tt_str:=tt_str+'0,';

      end
      else

        if zAttach in [toaVoda,toaKanal,toaVRK,toaObjVoda,toaObjKanal] then
        begin
          if DE_Rec.Date=0 then
            tt_str:=tt_str+'Null,'+
                  Qry_BrRec.FieldByName('ID').asString+','
          else
            tt_str:=tt_str+'"'+DateToStr(DE_Rec.Date)+' '+Time2Str(TE_Rec.Time)+'",'+
                  Qry_BrRec.FieldByName('ID').asString+',';

          if DE_Gran.Date=0 then
            tt_str:=tt_str+'Null,'+
                  Qry_BrGran.FieldByName('ID').asString+','
          else
            tt_str:=tt_str+'"'+DateToStr(DE_Gran.Date)+' '+Time2Str(TE_Gran.Time)+'",'+
                  Qry_BrGran.FieldByName('ID').asString+',';
        end;

      tt_str:=tt_str+'"'+DE_in.Text+' '+Time2Str(TE_In.Time)+'",';
      if DE_Out.Date=0 then
         tt_str:=tt_str+'NULL,'
      else
         tt_str:=tt_str+'"'+DE_Out.Text+' '+Time2Str(TE_Out.Time)+'",';
      if DE_Remont.Date=0 then _rem_date:='NULL'
        else _rem_date:='"'+DE_Remont.Text+' '+Time2Str(TE_Remont.Time)+'"';
      tt_str:=tt_str+Qry_BrIn.FieldByName('ID').asString+','+
                     Qry_BrOut.FieldByName('ID').asString;
      if isZadv then
      begin
        tt_str:=tt_str+' ,'+IntToStr(CodUser)+','+
        Qry_Remont.FieldByName('ID').AsString+','+_rem_date;
        if chb_IsPervichViezd.Checked then
          tt_str:=tt_str+',1)'
        else
          tt_str:=tt_str+',null)';
      end else
      begin
        if trim(ed_Peredano.Text)<>'' then
          tt_str:=tt_str+',"'+ed_Peredano.Text+'"'
        else
          tt_str:=tt_str+',null';

        if DE_Act.Date=0 then
          tt_str:=tt_str+',null,'+Qry_BrAct.FieldByName('ID').AsString
        else
          tt_str:=tt_str+',"'+DE_Act.Text+' '+Time2Str(TE_Act.Time)+'",'+
                        Qry_BrAct.FieldByName('ID').AsString;

        if trim(mem_NeedWorks.Text)<>'' then
          tt_str:=tt_str+',"'+mem_NeedWorks.Text+'")'
        else
          tt_str:=tt_str+',null)'
      end;
      MyExecSQL(Qry_tmp,tt_str);
      MyOpenSQL(Qry_tmp,'select max(id) mm from '+ZadAlias+' where id_zavin='+IntToStr(ZajvCod));
      ss:=Qry_tmp['MM'];
      MyExecSQL(Qry_tmp,'COMMIT');
      NewZap:=false;
      Text2Zadv(ss);
      ZadvUpdate(ss);
    end
  else
    begin
      tt_str:='update '+ZadAlias+' set ' {id_zavin='+IntToStr(ZajvCod)+} ;

      if F_isObj then
      begin
         tt_str := tt_str + 'id_object='+Qry_object.FieldByName('ID').asString+ ',';
         if Qry_Soorug.fieldbyname('id').asInteger >0 then
          tt_str := tt_str + ' id_soorug='+Qry_soorug.FieldByName('ID').asString+ ','
          else  tt_str:=tt_str+'id_soorug=0,';
         if Qry_ObjObor.fieldbyname('id').asInteger >0 then
          tt_str := tt_str + ' id_objobor='+Qry_objobor.FieldByName('ID').asString+ ','
           else tt_str:=tt_str+'id_objobor=0,';
      end;
//    else
//    begin
          tt_str := tt_str + 'id_ul1='+Qry_ul1.FieldByName('ID').asString+',id_ul2=';
          if Qry_tadr['ID']=1 then
             tt_str:=tt_str+Qry_ul2.FieldByName('ID').asString
          else if Qry_tadr['ID']=2 then
             tt_str:=tt_str+'"0"'
          else
             tt_str:=tt_str+'"'+Strip('A','"',Ed_Ndom.Text)+'"';

          tt_str:=tt_str+',ul_kod='+Qry_tAdr.FieldByName('ID').asString; {+
                  ',dop_adr="'+Ed_dopAdr.Text+'"';}
          if Qry_tadr['ID']=2 then
            tt_str:=tt_str+',id_DopAdres='+Qry_DopAdres.FieldByName('ID').AsString + ','
          else
            tt_str:=tt_str+',id_DopAdres=-1,';
//    end;

        if isZadv then
        begin
             tt_str:=tt_str+ 'id_diam='+Qry_diam.FieldByName('ID').asString+
             ', id_pad='+IntToStr(Qry_pad.FieldByName('ID').asInteger);

             if Qry_well.Active then
               tt_str:=tt_str+',id_well='+IntToStr(Qry_well.FieldByName('ID').asInteger)
             else
               tt_str:=tt_str+',id_well=0';
             if Qry_Bolt.Active then
               tt_str:=tt_str+',id_bolt='+IntToStr(Qry_bolt.FieldByName('ID').asInteger)
             else
               tt_str:=tt_str+',id_bolt=0';


            if cb_is_sbros.Checked then
                tt_str:=tt_str+',is_sbros = 1'
              else tt_str:=tt_str+',is_sbros = 0';

            if Qry_norm.Active then
              tt_str:=tt_str+ ',ID_NORMAL_STATE=' + IntToStr(Qry_norm.FieldByName('ID').asInteger)
            else
              tt_str:=tt_str+',ID_NORMAL_STATE = 0';


        end
        else
          if zAttach in [toaVoda,toaKanal,toaVRK,toaObjVoda,toaObjKanal] then
          begin
            if DE_Rec.Date=0 then
              tt_str:=tt_str+',dt_rec=Null,id_brrec='+
                    Qry_BrRec.FieldByName('ID').asString
            else
              tt_str:=tt_str+',dt_rec="'+DateToStr(DE_Rec.Date)+' '+Time2Str(TE_Rec.Time)+'",id_brrec='+
                    Qry_BrRec.FieldByName('ID').asString;

            if DE_Gran.Date=0 then
              tt_str:=tt_str+',dt_gran=Null,id_brgran='+
                    Qry_BrGran.FieldByName('ID').asString
            else
              tt_str:=tt_str+',dt_gran="'+DateToStr(DE_Gran.Date)+' '+Time2Str(TE_Gran.Time)+'",id_brgran='+
                    Qry_BrGran.FieldByName('ID').asString;
          end;


      tt_str:=tt_str+',dt_in="'+DE_in.Text+' '+Time2Str(TE_In.Time)+'",dt_out=';
      if DE_Out.Date=0 then
         tt_str:=tt_str+'NULL,id_brin='
      else
         tt_str:=tt_str+'"'+DE_Out.Text+' '+Time2Str(TE_Out.Time)+'",id_brin=';

      tt_str:=tt_str+Qry_BrIn.FieldByName('ID').asString+',id_brout='+
                     Qry_BrOut.FieldByName('ID').asString;

      if isZadv then
      begin
        tt_str:=tt_str+',id_disp_in='+IntToStr(CodUser)+
                ',id_remont='+Qry_Remont.FieldByName('ID').AsString+
                ',dt_remont="'+DateToStr(DE_Remont.Date)+' '+Time2Str(TE_Remont.Time)+'"';
        if chb_IsPervichViezd.Checked then
          tt_str:=tt_str+',is_pervich_viezd=1'
        else
          tt_str:=tt_str+',is_pervich_viezd=null';
      end else
      begin
        if trim(ed_Peredano.Text)<>'' then
          tt_str:=tt_str+',peredano="'+ed_Peredano.Text+'"'
        else
          tt_str:=tt_str+',peredano=null';

        if DE_Act.Date=0 then
          tt_str:=tt_str+',DT_Act=null, ID_BrAct='+Qry_BrAct.FieldByName('ID').AsString
        else
          tt_str:=tt_str+',DT_Act="'+DE_Act.Text+' '+Time2Str(TE_Act.Time)+'", ID_BrAct='+
                        Qry_BrAct.FieldByName('ID').AsString;

        if trim(mem_NeedWorks.Text)<>'' then
          tt_str:=tt_str+',NeedWorks="'+mem_NeedWorks.Text+'"'
        else
          tt_str:=tt_str+',NeedWorks=null'
      end;

      ss:=Qry_zadv.FieldByName('ID').asInteger;
      tt_str:=tt_str+' where id='+inttostr(ss);

      MyExecSQL(Qry_tmp,tt_str);
      MyExecSQL(Qry_tmp,'COMMIT');

      AlienZav:=-1;
      Text2Zadv(ss);
      ZadvUpdate(ss);
    end;
  SwSave(false);
 end;
end;

function TFormClZadv.FindCod(Cod:integer):integer;
var i:integer;
begin
  Result:=-1;
  for i:=0 to 29 do
   begin
     if Zadv2Cod[i]=Cod then
       begin
         Result:=i;
         exit;
       end;
   end;
end;

procedure TFormClZadv.Qry_zadvAfterScroll(DataSet: TDataSet);
begin
   TbC_zadv.TabIndex:=FindCod(Qry_zadv['ID']);
   //Qry_zadv.Locate('ID',Zadv2Cod[TbC_zadv.TabIndex],[]);
 //if FormClZadv.DBGr_zadv.Focused then
   RecUpdate(1);
end;

procedure TFormClZadv.DBL_ul1Change(Sender: TObject);
begin
  SwSave(true);
end;

procedure TFormClZadv.SwSave(st:boolean);
begin
  BB_Save.Enabled:=st and CheckFillClZ(false);
  BB_Open.Enabled:=(not st) and CheckFillClZ(true);
 { if st then
   begin
    Lb_save.Font.Color:=ErrCol;
    Lb_Save.Caption:=TrLangMSG(msgChangeNoSave)+' |';
   end
  else
   begin
    Lb_save.Font.Color:=TextCol;
    Lb_save.Caption:=TrLangMSG(msgNoChange);
   end}
end;

function TFormClZadv.CheckFillClZ(toClose:boolean):boolean;
  function _CheckFillUl:boolean;
  begin
    result:=FALSE;
      case Qry_tAdr.FieldByName('ID').AsInteger of
        0: begin result:=(Qry_Ul1.FieldByName('ID').AsInteger>-1) and (trim(ED_Ndom.Text)<>''); end;
        1: begin result:=(Qry_Ul1.FieldByName('ID').AsInteger>-1)
          and (Qry_Ul2.FieldByName('ID').AsInteger>-1) end;
        2: result:=TRUE;
      end;
  end;

  function _CheckFillObj:boolean;
  begin
    result:=FALSE;
    result:=((Qry_Object.FieldByName('ID').asInteger>0) and not(BB_Open.Visible))
      or BB_Open.Visible;
  end;


  function _CheckFillBr2:boolean;
  begin
    result:=((Qry_BrOut.FieldByName('ID').asInteger>0) and not(BB_Open.Visible))
      or BB_Open.Visible;
  end;

  function _CheckFill: boolean;
  begin
    if F_isObj then result := (_CheckFillObj or _CheckFillUl)
        else  result := _CheckFillUl;
  end;


var res1:boolean;
begin
  Result:=false;
  Res1:=false;
  if (Strip('A','. ',DE_in.Text)<>'') and
     (TE_in.Time<>0) and
     (Qry_BrIn.FieldByName('ID').asInteger>0) and
      (_CheckFill) and (( NewZap ) or (_CheckFillBr2)) then
         Res1:=true;
  if toClose and res1 then
    begin
    if (Strip('A','. ',DE_out.Text)<>'') and
       (TE_out.Time<>0) and
       (Qry_BrOut.FieldByName('ID').asInteger>0) and (_CheckFill)
       then
        begin
         Result:=true;
  {nut}
         if (zAttach in [toaVoda,toaKanal,toaVRK,toaObjVoda,toaObjKanal]) then
          begin
            if FVosstanovlDorPokryt_Flag then
               if not ((Strip('A','. ',DE_Rec.Text)<>'') and
                  (TE_Rec.Time<>0)) then Result:=False;
          end;
  {nut}
         if isZadv then
           Result:=(Qry_diam.FieldByName('ID').asInteger>0);
        end;
    end
  else
    Result:=res1;
  _SmartLightBrigadir;
end;

procedure TFormClZadv.BB_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TFormClZadv.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:=true;
  if BB_Save.Enabled then
    begin
      if MessageDlg(TrLangMSG(msgExitWithSave),
                 mtConfirmation, [mbYes, mbNo], 0) = mrNo then
        CanClose:=false;

    end;
end;

function TFormClZadv.CountZadv(isCl:boolean):integer;
begin
  Qry_tmp.Close;
  Qry_tmp.SQL.Clear;
  if isCl then
    Qry_tmp.SQL.Add('select count(id) mm from '+ZadAlias+' where id_zavin='+IntToStr(ZajvCod)+
                    ' and id_zavout<>0') //dt_out is not NULL')
  else
    Qry_tmp.SQL.Add('select count(id) mm from '+ZadAlias+' where id_zavin='+IntToStr(ZajvCod));

  Qry_tmp.Open;
  Result:=Qry_tmp['MM'];
  Qry_tmp.Close
end;
//'select count(id) mm from zadv where id_zav='+IntToStr(ZajvCod)+
//                    ' and dt_out is not NUL')
procedure TFormClZadv.BB_delClick(Sender: TObject);
begin
 if not NewZap then
  begin
   if MessageDlg(TrLangMSG(msgDeleteRecord),
                 mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
     MyExecSQL(Qry_tmp,'delete from '+ZadAlias+' where id='+intTostr(Qry_zadv['ID']));
     ZadvUpdate(0);
    end;
  end;
end;

procedure TFormClZadv.UstIzm;
var tt,tt1:boolean;
begin
  tt:=true;
  tt1:=(FReadOnly) or (Qry_zadv.FieldByName('ID_ZAVIN').asInteger<>ZajvCod);
  if tt1 or (ZadvMode=0) then
    begin
      tt:=false;
    end;
  DBL_Ul1.Enabled:=tt;
  DBL_Ul1.Enabled:=tt;
  CB_tadr.Enabled:=tt;
  Ed_dopAdr.Enabled:=tt;
  Ed_ndom.Enabled:=tt;
  if isZadv then
  begin
    //DBL_diam.Enabled:=tt;
    DBL_Remont.Enabled:=tt;
    DBL_pad.Enabled:=tt;
    DBL_well.Enabled:=tt;
    DBL_bolt.Enabled:=tt;
    chb_IsPervichViezd.Enabled:=tt;
  end else
  begin
    ed_Peredano.Enabled:=tt;
    DE_Act.Enabled:=tt;
    TE_Act.Enabled:=tt;
    DBL_BrAct.Enabled:=tt;
    mem_NeedWorks.Enabled:=tt;
  end;
  DE_In.Enabled:=tt;
  TE_In.Enabled:=tt;
  DBL_BrIn.Enabled:=tt;
  BB_Open.Enabled:=not(tt1); // and CheckFillClZ(true);
  BB_Del.Enabled:=tt;
  if not ((FReadOnly) or (ZadvMode=0)) then
  begin
     BB_Add.Enabled:=ChB_Exist.Checked;
     BB_Copy.Enabled:=ChB_Exist.Checked;
  end;
  _SmartLightBrigadir;
end;

function TFormClZadv.ZapZav(cod:integer):string;
begin
  Result:='';
  MyOpenSQL(Qry_tmp,'select * from nzavjav where (delz=0) and id='+inttostr(cod)+
            ' union select * from zavjav where (delz=0) and id='+inttostr(cod));
  if Qry_tmp.FieldByName('NOMER').asString<>'' then
      Result:='N'+Qry_tmp.FieldByName('NOMER').asString+' от '+
                  Qry_tmp.FieldByName('DT_IN').asString;
  Qry_tmp.Close;
end;

procedure TFormClZadv.BB_OpenClick(Sender: TObject);
var ss:integer;
    s:string;
begin
 if (strip('A','. ',DE_out.Text)<>'') and ((TE_out.Time<>0) {or (TE_out.Text<>'00:00')}) then
   begin
      ss:=Qry_zadv.FieldByName('ID').asInteger;
      if isZadv then s:=', id_disp_out='+IntToStr(CodUser) else s:='';
      MyExecSQL(Qry_tmp,'update '+ZadAlias+' set id_zavout='+IntToStr(ZajvCod)+
        s+' where id='+inttostr(ss));
      BB_SaveClick(nil);
   end
 else
   MessageDlg(TrLangMSG(msgNoDateTime), mtError,
      [mbOk], 0);
end;

procedure TFormClZadv.ChB_ExistClick(Sender: TObject);
begin
 UstIzm;
end;

procedure TFormClZadv.Text2Zadv(ss:integer);
begin
  if isZadv then
     MyOpenSQL(Qry_tmp2,'select * from zadv where id='+inttostr(ss))
  else
     MyOpenSQL(Qry_tmp2,'select * from raskop where id='+inttostr(ss));
  Qry_tmp2.Edit;
  Qry_tmp2.FieldByName('DOP_ADR').asString:=Ed_DopAdr.Text;
  Qry_tmp2.Post;
  if Qry_tmp2.UpdatesPending then
    begin
     Qry_tmp2.ApplyUpdates;
     Qry_tmp2.CommitUpdates;
    end;
  Qry_tmp2.Close;

end;

procedure TFormClZadv.Translate;
begin
  inherited;
  if isZadv then
    Caption:=TrLangMSG(msgCloseZadv)
  else
    Caption:=TrLangMSG(msgDigWorks);

  Label14.Caption:=TrLangMSG(msgPereCloseZadv);
  Label2.Caption:=TrLangMSG(msgDiggRaskop);
//  Label13.Caption:=TrLangMSG(msgVidOpenZadv);
  Label3.Caption:=TrLangMSG(msgNoDiggRaskop);
  Label1.Caption:=TrLangMSG(msgDiam);
  Lb_NmUl.Caption:=TrLangMSG(msgStreet);
  Lb_place.Caption:=TrLangMSG({msgPlace}msgStreet);
  Lb_Ndom.Caption:=TrLangMSG(msgNumDom);
  //Lb_cross.Caption:=TrLangMSG(msgCross);
  BB_Add.Caption:=TrLangMSG(msgAdd);
  BB_del.Caption:=TrLangMSG(msgDelete);
  BB_Save.Caption:=TrLangMSG(msgSave);
  BB_Exit.Caption:='&'+TrLangMSG(msgExit);
  DBGr_zadv.Columns[7].Title.Caption :=TrLangMSG(msgDopAddr);
  chb_IsPervichViezd.Caption:=TrLangMSG( msgFirstStep);
  cb_is_sbros.Caption:=TrLangMSG( msgRemoveZadv);//Сбросная задвижка
  Label19.Caption:=TrLangMSG(msgNormZadv);//   Нормальное состояние задвижки
  Label15.Caption:=TrLangMSG(msgREMONT);//   Выполнение ремонта  msgREMONT
  Label7.Caption:=TrLangMSG(msgNote);//    Планшет
  Label8.Caption:=TrLangMSG(msgNumKOl);//   № колодца
  Label9.Caption:=TrLangMSG(msgZadvOne);//  Задвижка
  BB_Copy.Caption:=TrLangMSG(msgCopy);// Копировать
  ChB_Exist.Caption:=TrLangMSG(msgAddZadvFromCloseOrder);
  if ZadAlias='zadv'
  then begin
     BB_Open.Caption:=TrLangMSG(msgDoOpenZadv);
     GrB_adres.Caption:=' '+TrLangMSG(msgAddrCloseZadv)+' ';
     ChB_Exist.Caption:=TrLangMSG(msgDoAddZadvFromZajav);
     DBGr_zadv.Columns[0].Title.Caption :=TrLangMSG(msgAddrCloseZadv);
     DBGr_zadv.Columns[2].Title.Caption :=TrLangMSG(msgStateChanged);
     DBGr_zadv.Columns[5].Title.Caption :=TrLangMSG(msgFirstSate);//5 Исходное состояние
     DBGr_zadv.Columns[8].Title.Caption :=TrLangMSG(msgDopAddr);//8 Дополнительный адрес

     Label13.Caption:=TrLangMSG(msgVidOpenZadv);
//     DBGr_zadv.Columns[1].Title.Caption :=TrLangMSG(msgPereCloseZadv); // REMed by Vadim 22_04_2009
//     DBGr_zadv.Columns[4].Title.Caption :=TrLangMSG(msgVidOpenZadv);
  end
  else begin
     BB_Open.Caption:=TrLangMSG(msgDoDiggRaskop);
     GrB_adres.Caption:=' '+TrLangMSG(msgAddrRaskop)+' ';
     ChB_Exist.Caption:=TrLangMSG(msgDoAddRaskopFromZajav);
     DBGr_zadv.Columns[0].Title.Caption:=TrLangMSG(msgAddrRaskop);
     DBGr_zadv.Columns[1].Title.Caption:=TrLangMSG(msgDiggRaskop);
     DBGr_zadv.Columns[4].Title.Caption:=TrLangMSG(msgNoDiggRaskop);
  end
end;

procedure TFormClZadv.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
   case key of
    vk_F2:begin
      FormMain.DictNotHide.checked:=true;
      SetFilterDelete(Qry_diam,false);
      SetFilterDelete(Qry_norm,false);
      SetFilterDelete(Qry_ul1,false);
      SetFilterDelete(Qry_ul2,false);
      SetFilterDelete(Qry_DopAdres,false);
      SetFilterDelete(Qry_brIn,false);
      SetFilterDelete(Qry_brOut,false);
      SetFilterDelete(Qry_BrRec,false);
      SetFilterDelete(Qry_BrGran,false);
      SetFilterDelete(Qry_BrAct,false);
      SetFilterDelete(Qry_Remont,false);
      ZadvUpdate(0)
    end;
  end;

end;

procedure TFormClZadv.DBL_PadChange(Sender: TObject);
begin
  if isZadv then
  begin
    Qry_well.Close;
    Qry_Well.ParamByName('att').asInteger:=Ord(zAttach)+1;
    Qry_Well.ParamByName('pad').asInteger:=Qry_pad.FieldByName('ID').AsInteger;
    Qry_well.Open;
//    if Qry_well.Locate('ID',Qry_zadv['ID_WELL'],[]) then
    if Qry_well.Locate('ID',Qry_zadv.FieldByName('ID_WELL').AsInteger,[]) then
      DBL_well.DisplayValue:=Qry_well['NAME_R']
    else
      Qry_well.First;
    DBL_WellChange(Sender);  
  end;

  DBL_ul1Change(Sender);
end;

procedure TFormClZadv.DBL_WellChange(Sender: TObject);
begin
  if isZadv then
  begin
    Qry_bolt.Close;
    Qry_bolt.ParamByName('well').asInteger:=Qry_well.FieldByName('ID').AsInteger;
    Qry_bolt.Open;
    if Qry_bolt.Locate('ID',Qry_zadv.FieldByName('ID_Bolt').AsInteger,[]) then
//    if Qry_bolt.Locate('ID',Qry_zadv['ID_Bolt'],[]) then
      DBL_bolt.DisplayValue:=Qry_bolt['NAME_R']
    else
      Qry_bolt.First;
  end;

  DBL_ul1Change(Sender);

end;

procedure TFormClZadv.DE_outButtonClick(Sender: TObject);
begin
  if (Sender is TDateEdit) then
    begin
      if (Sender as TDateEdit).Text='  .  .    ' then (Sender as TDateEdit).Date:=DE_In.Date;
    end;
  inherited;    
end;

procedure TFormClZadv.chb_IsPervichViezdClick(Sender: TObject);
begin
  SwSave(true);
end;

procedure TFormClZadv.AlignDopRaskopPanel;
begin
  DopRaskopPanel.Left:=DopZadvPanel.Left;
  DopRaskopPanel.Width:=DopZadvPanel.Width;
end;

procedure TFormClZadv.mem_NeedWorksKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    SelectNext(Sender as TWinControl, True, True );
    Key := #0;
  end;
end;

procedure TFormClZadv.BB_CopyClick(Sender: TObject);
begin
  TbC_zadv.Tabs.Add(TrLangMSG(msgNewW));
  TbC_zadv.TabIndex:=TbC_zadv.Tabs.Count-1;
  RecUpdate(2); // :)
  NewZap:=true;
  BB_Add.Enabled:=false;
  BB_Copy.Enabled:=false;
  SwSave(true);
end;

procedure TFormClZadv._EnableCtrlsForZadvWithRemont;
  procedure EnCtrls(val: boolean);
  begin
      DE_Out.Enabled:=val;
      Te_Out.Enabled:=val;
      DBL_BrOut.Enabled:=val;
      DBL_Diam.Enabled:=val;
      DE_Remont.Enabled:=val;
      TE_Remont.Enabled:=val;
  end;
begin
  if isZadv then
  begin
    if FReadOnly then
    begin
      EnCtrls(false);
    end else
    begin
      EnCtrls(true);
      if (ZadvMode=0) and (Qry_Remont.FieldByName('ID').AsInteger=-1) then
        EnCtrls(false);
    end;
  end else
  begin
    if FReadOnly then
      EnCtrls(false)
    else
      EnCtrls(true)
  end;
end;

procedure TFormClZadv.DBL_ObjectChange(Sender: TObject);
var _id_object: integer;
begin
  inherited;
  if Qry_Soorug.Active then Qry_Soorug.Close;
  _id_object := Qry_Object.FieldByName('id').AsInteger;
  Qry_Soorug.SQL.Text := ' SELECT s.id, s.Name_r, s.id_object,s.del '+
      ' FROM s_soorug s '+
      ' WHERE ( id = -1 ) '+
      ' or s.id_object = '+ inttostr(_id_object) +
      ' ORDER BY s.Name_r';
  Qry_Soorug.Open;
  DBL_ul1Change(nil);
end;

procedure TFormClZadv.DBL_SoorugChange(Sender: TObject);
var _id_object, _id_soorug: integer;
begin
  inherited;
  if Qry_ObjObor.Active then Qry_ObjObor.Close;
  _id_soorug := Qry_Soorug.FieldByName('id').AsInteger;
  Qry_ObjObor.SQL.Text := ' select id, name_r, id_object, id_obortype, id_soorug, id_diam, del '+
      ' FROM s_ObjObor s '+
      ' WHERE (id = -1) '+
//      ' and s.id_object = '+ inttostr(_id_object) +
//     ' or (s.id_soorug = '+ inttostr(_id_soorug) + ')'+
      ' or ( ( rtrim(upper(name_r)) starting with ''ЗАДВИЖКА'') and (s.id_soorug = '+ inttostr(_id_soorug) + '))'+
      ' ORDER BY s.Name_r';
  Qry_ObjObor.Open;
  DBL_ul1Change(nil);

end;

procedure TFormClZadv.FormShow(Sender: TObject);
var curid:integer;
begin
  inherited;
if  F_rayon>0 then
begin
   curid:= qry_ul1.fieldbyname('id').asinteger;
   qry_ul1.Filter:='ID_RAYON='+intToStr(F_rayon)+' or id=-1';
   qry_ul1.Filtered:=true;
   qry_ul2.Filter:='ID_RAYON='+intToStr(F_rayon)+' or id=-1';
   qry_ul2.Filtered:=true;
  if curid>0 then
    Qry_Ul1.Locate('ID',curid,[]);
end;
end;

end.
