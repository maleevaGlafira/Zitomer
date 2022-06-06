unit pr_obor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, Buttons, Mask, RxLookup, ComCtrls, Spin,
  ToolEdit, CurrEdit, ExtCtrls, frmLANG, cntsLANG,
  ServiceFuncUnit, OperAttFormUnit;

type
  TFormPrOb = class(TFormLang)
    TbC_Vib: TTabControl;
    Panel1: TPanel;
    lbl_Name: TLabel;
    Bevel1: TBevel;
    BB_Next: TBitBtn;
    B_Next: TButton;
    B_Prev: TButton;
    BB_ESC: TBitBtn;
    Obor_lcb: TRxDBLookupCombo;
    PlanObor_lcb: TRxDBLookupCombo;
    Qry_tmp: TQuery;
    Instrum_lcb: TRxDBLookupCombo;
    ObjObor_lcb: TRxDBLookupCombo;
    procedure TbC_VibChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure DBLC_placeChange(Sender: TObject);
    procedure DBLC_placeKeyPress(Sender: TObject; var Key: Char);
    procedure SpB_NextClick(Sender: TObject);
    procedure SpB_PrevClick(Sender: TObject);
    procedure BB_ESCClick(Sender: TObject);
    procedure BB_NextClick(Sender: TObject);
    procedure Obor_lcbChange(Sender: TObject);
    procedure PlanObor_lcbChange(Sender: TObject);
    procedure Instrum_lcbChange(Sender: TObject);
    procedure ObjObor_lcbChange(Sender: TObject);

  private
    Baze_SWorkLookupDisplay :string;
    F_IsShowObjobor: boolean;
    procedure SetIsShowObjobor(const Value: boolean);
  public
    { Public declarations }
    procedure RefreshSWork;
    procedure SaveNew;
    procedure Translate;override;
    property IsShowObjobor: boolean read F_IsShowObjobor write SetIsShowObjobor;
  end;

var
  FormPrOb: TFormPrOb;

implementation
   uses main,obor,strtool, datam, avartype, zav;
{$R *.DFM}

procedure TFormPrOb.TbC_VibChange(Sender: TObject);
var
  OperAtt:TOperAtt;
begin
   OperAtt:=OperAttDetectFromMenuItem(nil);
   RefreshSWork;
end;

procedure TFormPrOb.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TFormPrOb.FormCreate(Sender: TObject);
begin
  F_IsShowObjobor := false;
  Top:=FormObor.Top+15;
  Left:=FormObor.Left+FormObor.Width-Width;
  TbC_VibChange(Self);
end;

procedure TFormPrOb.RefreshSWork;
var
 tt_str:string;
 look_displ :string;
begin
 look_displ:=Baze_SWorkLookupDisplay; // ds
 Obor_lcb.Visible:=(TbC_Vib.TabIndex=0);
 PlanObor_lcb.Visible:=(TbC_Vib.TabIndex=1);
 Instrum_lcb.Visible:=(TbC_Vib.TabIndex=2);
 ObjObor_lcb.Visible := (TbC_Vib.TabIndex=3);


  if TbC_Vib.TabIndex=0 then
    begin
     Obor_lcb.DisplayValue:=dm1.S_Obor_q.FieldByName('Name_r').asString;
     lbl_Name.Caption := 'Механизм';
    end
 else if TbC_Vib.TabIndex=1 then
    begin
      PlanObor_lcb.DisplayValue:=dm1.S_PlanObor_q.FieldByName('Name_r').asString;
      lbl_Name.Caption := 'Механизм';
    end
 else if TbC_Vib.TabIndex=2 then
    begin
      Instrum_lcb.DisplayValue:=dm1.S_Instrum_q.FieldByName('Name_r').asString;
      lbl_Name.Caption := 'Инструмент';
    end
 else if TbC_Vib.TabIndex=3 then
    begin
      ObjObor_lcb.DisplayValue := FormObor.s_objobor_q.FieldByName('Name_r').AsString;
      lbl_Name.Caption := 'Оборуд.';
    end
end;


procedure TFormPrOb.DBLC_placeChange(Sender: TObject);
begin
  RefreshSWork;
end;

procedure TFormPrOb.DBLC_placeKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = #13 then
  begin
    SelectNext(Sender as TWinControl, True, True );
    Key := #0;
  end;
end;

procedure TFormPrOb.SpB_NextClick(Sender: TObject);
begin
  if TbC_Vib.TabIndex < TbC_Vib.Tabs.Count-1 then
     TbC_Vib.TabIndex:=TbC_Vib.TabIndex+1
  else
     TbC_Vib.TabIndex:=0;

TbC_VibChange(Self);
end;

procedure TFormPrOb.SpB_PrevClick(Sender: TObject);
begin
  if TbC_Vib.TabIndex>0 then
     TbC_Vib.TabIndex:=TbC_Vib.TabIndex-1
  else
     TbC_Vib.TabIndex:=TbC_Vib.Tabs.Count-1;

TbC_VibChange(Self);
end;

procedure TFormPrOb.BB_ESCClick(Sender: TObject);
begin
  Close;
end;

procedure TFormPrOb.SaveNew;
var
 tt_str:string;
begin
   if TbC_Vib.TabIndex=0 then
     begin
      //ds  ActiveControl:=DBLC_swork;
        tt_str:='insert into obors (id_zav,id_nar,ID_OBOR) values ('+
                        inttostr(ObZav)+','+inttostr(ObNar)+','+
                        {Qry_swork}dm1.S_Obor_q.FieldByName('ID').asString+')';
     end
   else if TbC_Vib.TabIndex=1 then
     begin
        tt_str:='insert into planobors (id_zav,id_nar,ID_OBOR) values ('+
                        inttostr(ObZav)+','+inttostr(ObNar)+','+
                        dm1.S_PlanObor_q.FieldByName('ID').asString+')';
     end
   else if TbC_Vib.TabIndex=2 then
     begin
        tt_str:='insert into instrum (id_zav,id_nar,id_instrum) values ('+
                        inttostr(ObZav)+','+inttostr(ObNar)+','+
                        dm1.S_instrum_q.FieldByName('ID').asString+')';
     end
   else if TbC_Vib.TabIndex=3 then
     begin
        tt_str:='insert into objobor (id_zav,id_nar,id_objobor) values ('+
                        inttostr(ObZav)+','+inttostr(ObNar)+','+
                        FormObor.s_objobor_q.FieldByName('ID').AsString+')';
     end;


   MyExecSQL(Qry_tmp,tt_str);

   if TbC_Vib.TabIndex=0 then
     begin
       FormObor.RefreshBase(FormObor.{Qry_obor}Obors_q);
     end
   else if TbC_Vib.TabIndex=1 then
     begin
       FormObor.RefreshBase(FormObor.Planobors_q);
     end
   else if TbC_Vib.TabIndex=2 then
     begin
       FormObor.RefreshBase(FormObor.Instrum_q);
     end
   else if TbC_Vib.TabIndex=3 then
     begin
       FormObor.RefreshBase(FormObor.ObjObor_q);
     end;
end;

procedure TFormPrOb.BB_NextClick(Sender: TObject);
begin
 SaveNew;
end;


//*******************************************************************
procedure TFormPrOb.Obor_lcbChange(Sender: TObject);
begin
 BB_Next.Enabled:=(DM1.S_Obor_q.FieldByName('ID').asInteger > 0);
end;

//*******************************************************************
procedure TFormPrOb.Translate;
begin
  inherited;
  Caption:=TrLangMSG(msgQuickAdd);
  BB_Next.Caption:=TrLangMSG(msgAdd);
  BB_ESC.Caption:=TrLangMSG(msgExit);

  TbC_Vib.Tabs[0]:=TrLangMSG(msgMechan);
  TbC_Vib.Tabs[1]:=TrLangMSG(msgPlanmechan);
end;

procedure TFormPrOb.PlanObor_lcbChange(Sender: TObject);
begin
  BB_Next.Enabled:=(DM1.S_PlanObor_q.FieldByName('ID').asInteger > 0);
end;

procedure TFormPrOb.Instrum_lcbChange(Sender: TObject);
begin
  BB_Next.Enabled:=(DM1.S_Instrum_q.FieldByName('ID').asInteger > 0);
end;

procedure TFormPrOb.ObjObor_lcbChange(Sender: TObject);
begin
  BB_Next.Enabled:=(FormObor.s_objobor_q.FieldByName('ID').asInteger > 0);
end;

procedure TFormPrOb.SetIsShowObjobor(const Value: boolean);
begin
  F_IsShowObjobor := Value;
  if not F_IsShowObjobor then
    TbC_Vib.Tabs.Delete( 3 );
end;

end.
