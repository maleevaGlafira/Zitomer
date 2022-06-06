unit NewDisconnections;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseGridForm, DB, IBCustomDataSet, IBDatabase, ComCtrls, Grids,
  DBGrids, StdCtrls, Buttons, Mask, DBCtrls, RxLookup, ExtCtrls,
  DBCtrlsEh, ToolEdit, RXDBCtrl,frmLANG,cntsLANG{testSetJson2};
const defaultDISCON_PERV_ID=3;

type
  Tfrm_DisconNew = class(Tfrm_BaseGrid)
    mem_Disconnections: TMemo;
    gb_DTTMExec: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    de_Discon  : TDBDateEdit;
    de_Con: TDBDateEdit;
    te_Discon: TDBDateTimeEditEh;
    te_Con: TDBDateTimeEditEh;
    dbl_Executor: TRxDBLookupCombo;
    dbl_BrigConnect: TRxDBLookupCombo;
    dset_executor: TIBDataSet;
    ds_Executor: TDataSource;
    dset_Brig_connect: TIBDataSet;
    ds_Brig_connect: TDataSource;
    dset_tmp: TIBDataSet;
    dset_mainID: TIntegerField;
    dset_mainID_ZAV: TIntegerField;
    dset_mainID_UL: TIntegerField;
    dset_mainHOUSE: TIBStringField;
    dset_mainCOMMENT: TIBStringField;
    dset_mainDTTM_DISCON: TDateTimeField;
    dset_mainDTTM_CON: TDateTimeField;
    dset_mainFK_DISCON_BRIG: TIntegerField;
    dset_mainFK_DISCON_BRIG_CONNECT: TIntegerField;
    dset_mainFK_DISCON_DISP_CONNECT: TIntegerField;
    dset_mainFK_DISCON_DISP_DISCONNECT: TIntegerField;
    dset_brigs_discon_as_disp: TIBDataSet;
    dset_brig_connect_as_disp: TIBDataSet;
    dset_mainName_discon_disp: TStringField;
    dset_mainName_Con_Disp: TStringField;
    ds_brigs_discon_as_disp: TDataSource;
    ds_brig_connect_as_disp: TDataSource;
    DBT_disp1: TDBText;
    DBT_disp2: TDBText;
    lbl_disp1: TLabel;
    lbl_disp2: TLabel;
    dset_mainlook_streets: TStringField;
    dset_mainlook_DISCON_BRIG: TStringField;
    dset_mainlook_BRIG_CONNECT: TStringField;
    dset_mainDTTM_CON_PLAN: TDateTimeField;
    dset_mainDTTM_DISCON_PLAN: TDateTimeField;
    dset_mainFK_DISCON_DISP_CONNECT_PLAN: TIntegerField;
    dset_mainFK_DISCON_DISP_DISCONNECT_PLAN: TIntegerField;
    dset_mainHOUSES_TO: TStringField;
    dset_mainTYP_HOUSE: TIntegerField;
    dbe_house_to: TDBEdit;
    dbc_typ_houses: TDBComboBoxEh;
    Label2: TLabel;
    Label3: TLabel;
    DBDateEdit1: TDBDateEdit;
    Label4: TLabel;
    DBDateTimeEditEh1: TDBDateTimeEditEh;
    Label5: TLabel;
    DBT_disp1plan: TDBText;
    Label6: TLabel;
    DBDateEdit2: TDBDateEdit;
    Label7: TLabel;
    DBDateTimeEditEh2: TDBDateTimeEditEh;
    Label12: TLabel;
    DBT_disp2plan: TDBText;
    dset_brigs_discon_as_disp_plan: TIBDataSet;
    dset_brig_connect_as_disp_plan: TIBDataSet;
    ds_brig_connect_as_disp_plan: TDataSource;
    ds_brigs_discon_as_disp_plan: TDataSource;
    dset_mainName_discon_disp_plan: TStringField;
    dset_mainName_Con_Disp_plan: TStringField;
    dset_mainmodifi: TSmallintField;
    dset_mainFK_DISCON_PERV_ID: TIntegerField;
    Panel1: TPanel;
    Label15: TLabel;
    dset_PERERV: TIBDataSet;
    ds_PERERV: TDataSource;
    dbl_perev: TRxDBLookupCombo;
    dset_mainADDCOMENTS: TIBStringField;
    dmem_addinfo: TDBMemo;
    dset_mainNOMER_DISCON: TFloatField;
    Label16: TLabel;
    dbn_NOMER_DISCON: TDBNumberEditEh;
    dset_mainhouseNums: TStringField;
   procedure btn_InsertClick(Sender: TObject);
   procedure btn_EditClick(Sender: TObject);       
   procedure FormCreate(Sender: TObject);
   procedure FormClose(Sender: TObject;  var Action: TCloseAction);
   procedure btn_PostClick(Sender: TObject);
   procedure FormShow(Sender: TObject);
    procedure dset_mainCalcFields(DataSet: TDataSet);
    procedure mem_DisconnectionsChange(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure dset_mainAfterScroll(DataSet: TDataSet);
    procedure dbl_BrigConnectChange(Sender: TObject);
    procedure dbl_ExecutorChange(Sender: TObject);
    procedure DBDateEdit1Change(Sender: TObject);
    procedure DBDateEdit2Change(Sender: TObject);
    procedure dset_mainAfterEdit(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure dset_mainAfterPost(DataSet: TDataSet);
    procedure dset_mainAfterDelete(DataSet: TDataSet);
    procedure dset_mainBeforeDelete(DataSet: TDataSet);
    procedure DBDateTimeEditEh1Change(Sender: TObject);
    procedure DBDateTimeEditEh2Change(Sender: TObject);
    procedure dbl_perevChange(Sender: TObject);
    procedure dmem_addinfoChange(Sender: TObject);
  protected
    class function GetGUID: string; override;
    procedure EnableCtrls(value: boolean); override;
    procedure Enable_ConnectTimeAllFill;
    procedure EnableOpenCtrls(value: boolean);
    function IsDateCorrect: boolean; override;
    function IsDataFieldsCorrect: boolean; override;
  private
    { Private declarations }
    F_DateShift: TDate;
    F_ResultString: string;
    F_ReadOnlyFrm: boolean;
  //  F_OrderID: integer;

    F_IsResStrChange: boolean;

     ischanges:boolean;
     //F_sentserv:TSentToServ;
     f_idDel:integer;
      F_rayon:integer;
     
  public
    { Public declarations }
    listdel:TStringlist;
    property ResultString: string read F_ResultString write F_ResultString;
    property ReadOnlyFrm: boolean read F_ReadOnlyFrm write F_ReadOnlyFrm;
    property OrderID: integer read F_OrderID write F_OrderID;
   // property RayonS: string read F_RayonS write F_RayonS;
    property DateShift: TDate write F_DateShift;
    procedure LoadData;
//    property sentserv:TSentToServ write F_sentserv;
    procedure Translate;override;


  end;

var
  frm_DisconNew: Tfrm_DisconNew;

implementation

{$R *.dfm}

uses main, avartype,zav;

procedure Tfrm_DisconNew.FormCreate(Sender: TObject);
begin
  inherited;
  F_IsResStrChange := false;
  EnableOpenCtrls(false);
  listdel:=TStringlist.Create;
  ischanges:=false;
end;

procedure Tfrm_DisconNew.Translate;
begin
 Caption:= TrLangMSG(msgDiscons);
 btn_insert.Caption:= TrLangMSG(msgAdd);
 btn_Cancel.Caption:= TrLangMSG(msgCancel);
 btn_Delete.Caption:= TrLangMSG(msgDelete);
 btn_Edit.Caption:= TrLangMSG(msgEdit);
 btn_Exit.Caption:= TrLangMSG(msgExit);
 btn_Post.Caption:= TrLangMSG(msgSave);
 pnl_Adres.Caption:= TrLangMSG(msgAddr);
 lbl_Street.Caption:= TrLangMSG(msgStreet);
 lbl_AddAdres.Caption:= TrLangMSG(msgAddInfShort);
 lbl_HouseNum.Caption:= TrLangMSG(msgNumDom); //Номер дома
 Label2.Caption:= TrLangMSG(msgToPo);//по
Label8.Caption:= TrLangMSG(msgDateDiscon); // Дата отключения
Label9.Caption:= TrLangMSG(msgDateCon); // Дата включения
Label10.Caption:= TrLangMSG(msgTimeDiscon);//Время  отключения
Label11.Caption:= TrLangMSG(msgTimeCon);//Время  включения
Label13.Caption:= TrLangMSG(msgDisconexecutor);//Исполнитель откл.
Label14.Caption:= TrLangMSG(msgRespons);//Ответственный за вкл.
Label3.Caption:= TrLangMSG(msgDtPlanDiscon);//Дата план  отключения
Label4.Caption:= TrLangMSG(msgTimePlanDiscon);//Время план отключения
Label6.Caption:= TrLangMSG(msgDtPlanCon);//Время план отключения
Label7.Caption:= TrLangMSG(msgTimePlanCon);//Время план  включения
Label15.Caption:= TrLangMSG(msgClassDiscon);//Класификация отключений
Label16.Caption:= TrLangMSG(msgNumDiscon);//№ откючения
//dbg_Main.Columns[0].Title.Caption:= TrLangMSG(№);
dbg_Main.Columns[1].Title.Caption:= TrLangMSG(msgStreet);
dbg_Main.Columns[2].Title.Caption:= TrLangMSG(msgnHouse);
dbg_Main.Columns[3].Title.Caption:= TrLangMSG(msgDopInfo);//Дополнительная информация
dbg_Main.Columns[4].Title.Caption:= TrLangMSG(msgnDiscon);  //Отключено
dbg_Main.Columns[5].Title.Caption:= TrLangMSG(msgDisconexecutor);//Исполнитель откл.
dbg_Main.Columns[6].Title.Caption:= TrLangMSG(msgCon);//Включено
dbg_Main.Columns[7].Title.Caption:= TrLangMSG(msgRespons);//Ответственный за вкл.


end;

procedure Tfrm_DisconNew.EnableCtrls(value: boolean);
begin
  dbe_house_to.Enabled:=value;
  dbc_typ_houses.Enabled:=value;
//  mem_Disconnections.Enabled:=value;
  de_Discon.Enabled := value;
  de_Con.Enabled := value;

  DBDateEdit1.Enabled:=value;
  DBDateTimeEditEh1.Enabled:=value;

  te_Discon.Enabled := value;
  te_Con.Enabled := value;

  dbl_Executor.Enabled := value;
  dbl_BrigConnect.Enabled := value;
  dbl_perev.Enabled:=value;
  dbn_nomer_discon.Enabled:=value;
//  bb_ConnectTimeAll.Enabled := value;
  DBDateEdit2.Enabled:=value;
  DBDateTimeEditEh2.Enabled:=value;
  dmem_addinfo.Enabled:=value;
  inherited EnableCtrls(value);
end;

procedure  Tfrm_DisconNew.Enable_ConnectTimeAllFill;
begin
   //

end;

procedure Tfrm_DisconNew.EnableOpenCtrls(value: boolean);
begin
  mem_Disconnections.Enabled:=value;
end;



procedure Tfrm_DisconNew.FormClose (Sender: TObject;  var Action: TCloseAction);
begin
  inherited;

  //DM_Disconnection.Free;
end;

class function Tfrm_DisconNew.GetGUID: string;
begin
  //Result:=DISCONNECTGUID;
  Result:='1';
end;


procedure Tfrm_DisconNew.LoadData;
begin
    //
//  dset_main.ParamByName('orderid').AsInteger := F_OrderID ;
//  DM_Disconnection.OrderID := F_OrderID;
//  DM_Disconnection.RayonS := F_RayonS;
//  DM_Disconnection.ds_Disconnections.Open;
//  DM_Disconnection.ds_Disconnections.First;

end;

procedure Tfrm_DisconNew.btn_PostClick(Sender: TObject);
begin
inherited;
 ResultString:=mem_Disconnections.Text;
  EnableOpenCtrls(false);
  Enable_ConnectTimeAllFill;
end;


procedure Tfrm_DisconNew.FormShow(Sender: TObject);
begin


 inherited;
//  LoadData;

 if  FormZav.FltDel and not FormMain.DictNotHide.checked
  then begin
    dset_executor.ParamByName('d').AsString:='x';
    dset_Brig_connect.ParamByName('d').AsString:='x';
  end
  else begin
    dset_executor.ParamByName('d').AsString:='d';
    dset_Brig_connect.ParamByName('d').AsString:='d';
  end;
  
  dset_executor.Open;
  dset_Brig_connect.Open;
  dset_brigs_discon_as_disp.Open;
  dset_brigs_discon_as_disp_plan.Open;
  dset_brig_connect_as_disp.Open ;
  dset_brig_connect_as_disp_plan.Open;
  dset_PERERV.Open;





  mem_Disconnections.Text := ResultString;
  mem_Disconnections.ReadOnly  := ReadOnlyFrm;

  F_IsResStrChange := false;

  if mem_Disconnections.Enabled then
    mem_Disconnections.SetFocus;

  Enable_ConnectTimeAllFill;
  dset_mainCalcFields(dset_main);
   F_CtrlsChange:=false;
end;

procedure Tfrm_DisconNew.btn_InsertClick(Sender: TObject);
begin
  inherited btn_InsertClick(Sender);
  dset_Main.FieldByName('ID_ZAV').AsInteger:=F_OrderID;
  dset_Main.FieldByName('ID_UL').AsInteger:=-1;
  dset_Main.FieldByName('DTTM_DISCON').AsDateTime := Int(Now);
  dset_main.FieldByName('FK_DISCON_DISP_DISCONNECT').AsInteger:=CodUser;
  dset_main.FieldByName('FK_DISCON_PERV_ID').AsInteger:=defaultDISCON_PERV_ID;
  EnableOpenCtrls(true);

  dbl_Street.SetFocus;
end;

procedure Tfrm_DisconNew.btn_EditClick(Sender: TObject);
begin
  inherited btn_EditClick(Sender);
  EnableOpenCtrls(true);
  if (dset_main.FieldByName('FK_DISCON_PERV_ID').IsNull) or
   ( dset_main.FieldByName('FK_DISCON_PERV_ID').AsInteger<0) then
   begin
    dset_main.FieldByName('FK_DISCON_PERV_ID').AsInteger:=defaultDISCON_PERV_ID;
    CtrlsChange(dbl_perev);
   end;
  dbl_Street.SetFocus;
end;

procedure Tfrm_DisconNew.dset_mainCalcFields(DataSet: TDataSet);
var house_types:string;
begin
  inherited;
 //DataSet.FieldByName('calc_rayon').AsString := F_RayonS;
 if not  Dataset.IsEmpty then
 begin


 Dataset.FieldByName('Name_discon_disp').AsString:='';
 if not Dataset.fieldbyname('FK_DISCON_DISP_DISCONNECT').IsNull then
  if dset_brigs_discon_as_disp.Active then
  if (Dataset.fieldbyname('FK_DISCON_DISP_DISCONNECT').AsInteger<=0)or
  (not(dset_brigs_discon_as_disp.Locate('ID',
                                    VarArrayOf([Dataset.fieldbyname('FK_DISCON_DISP_DISCONNECT').AsInteger]),
                                    [loCaseInsensitive])) )then
    Dataset.FieldByName('Name_discon_Disp').AsString:=TrLangMSG(msgAdmin)
   else
   begin
     Dataset.FieldByName('Name_discon_disp').AsString:=dset_brigs_discon_as_disp.fieldByname('name_r').AsString;
   end;

 Dataset.FieldByName('Name_discon_disp_plan').AsString:='';
 if not Dataset.fieldbyname('FK_DISCON_DISP_DISCONNECT_plan').IsNull then
  if dset_brigs_discon_as_disp_plan.Active then
  if (Dataset.fieldbyname('FK_DISCON_DISP_DISCONNECT_plan').AsInteger<=0)or
  (not(dset_brigs_discon_as_disp_plan.Locate('ID',
                                    VarArrayOf([Dataset.fieldbyname('FK_DISCON_DISP_DISCONNECT_plan').AsInteger]),
                                    [loCaseInsensitive])) )then
    Dataset.FieldByName('Name_discon_Disp_plan').AsString:=TrLangMSG(msgAdmin)
   else
   begin
     Dataset.FieldByName('Name_discon_disp_plan').AsString:=dset_brigs_discon_as_disp_plan.fieldByname('name_r').AsString;
   end;

 Dataset.FieldByName('Name_Con_Disp').AsString:='';
 if not Dataset.fieldbyname('DTTM_CON').IsNull then
 if  not Dataset.fieldbyname('FK_DISCON_DISP_CONNECT').IsNull then
 if dset_brig_connect_as_disp.Active then
  if (Dataset.fieldbyname('FK_DISCON_DISP_CONNECT').AsInteger<=0)or
  (not(dset_brig_connect_as_disp.Locate('ID',
                                    VarArrayOf([Dataset.fieldbyname('FK_DISCON_DISP_CONNECT').AsInteger]),
                                    [loCaseInsensitive])) )then
    Dataset.FieldByName('Name_Con_Disp').AsString:=TrLangMSG(msgAdmin)
   else
   begin
     Dataset.FieldByName('Name_Con_Disp').AsString:=dset_brig_connect_as_disp.fieldByname('name_r').AsString;
   end;


  Dataset.FieldByName('Name_Con_Disp_plan').AsString:='';
 if not Dataset.fieldbyname('DTTM_CON_plan').IsNull then
 if  not Dataset.fieldbyname('FK_DISCON_DISP_CONNECT_plan').IsNull then
 if dset_brig_connect_as_disp_plan.Active then
  if (Dataset.fieldbyname('FK_DISCON_DISP_CONNECT_plan').AsInteger<=0)or
  (not(dset_brig_connect_as_disp_plan.Locate('ID',
                                    VarArrayOf([Dataset.fieldbyname('FK_DISCON_DISP_CONNECT_plan').AsInteger]),
                                    [loCaseInsensitive])) )then
    Dataset.FieldByName('Name_Con_Disp_plan').AsString:=TrLangMSG(msgAdmin)
   else
   begin
     Dataset.FieldByName('Name_Con_Disp_plan').AsString:=dset_brig_connect_as_disp_plan.fieldByname('name_r').AsString;
   end;
   //houseNums
   Dataset.FieldByName('houseNums').AsString:='';
  if Dataset.fieldbyname('HOUSE').AsString<>'' then
  begin
   Dataset.FieldByName('houseNums').AsString:=trim(Dataset.fieldbyname('HOUSE').AsString);
   if Dataset.FieldByName('HOUSES_TO').AsString<>'' then
   begin
      case Dataset.FieldByName('TYP_HOUSE').asinteger  of
         1:house_types:='усі';
         2:house_types:='парні';
         3:house_types:=' непарні'
         else
         house_types:='усі';
     end;
     Dataset.FieldByName('houseNums').AsString:=format('з %s по %s (%s)',
                       [trim(Dataset.fieldbyname('HOUSE').AsString),
                       trim(Dataset.FieldByName('HOUSES_TO').AsString),
                       trim(house_types)
                       ]);



   end
  end
 end;



end;

procedure Tfrm_DisconNew.mem_DisconnectionsChange(Sender: TObject);
begin
  inherited;
   // F_CtrlsChange := true;
end;



function Tfrm_DisconNew.IsDateCorrect: boolean;
var _dttm_connect, _dttm_discon, _dttm_nextshift: TDatetime;
    _dttm_plan: TDatetime;
    _res:boolean;
begin
   //
   _res := true;
   _dttm_nextshift := F_DateShift + 1 + StrToTime('08:00:00');
   _dttm_connect := dset_main.FieldByName('DTTM_CON').AsDateTime;
   _dttm_discon := dset_main.FieldByName('DTTM_DISCON').AsDateTime;
   if ((_dttm_connect = 0) and ( dset_main.FieldByName('FK_DISCON_BRIG_CONNECT').AsInteger > 0))
     then
        begin
          MessageDlg({'Проверьте дату включения или нажмите "Отменить"'}
            TrLangMSG(msgCheckDtDiscon), mtError, [mbOk], 1);
          _res := false;
        end;

   if ((_dttm_connect > 0) and ( _dttm_discon >  _dttm_connect))
       then
        begin
          MessageDlg({'Дата включения должна быть больше даты отключения'}
          TrLangMSG(msgDtDiskoncon), mtError, [mbOk], 1);
          _res := false;
        end;

   if ((_dttm_connect >= _dttm_nextshift))
     then
        begin
          MessageDlg({'Время включения должно соответствовать дате смены '}
           TrLangMSG(msgConSmen), mtError, [mbOk], 1);
          _res := false;
        end;

   if ( _dttm_connect > Now)
     then
        begin
          MessageDlg({'Время включения больше текущей даты '}
          TrLangMSG(msgConDtNow), mtError, [mbOk], 1);
          _res := false;
        end;

{   if ((_dttm_discon >= _dttm_nextshift) or (_dttm_discon <= _dttm_nextshift-1) )
     then
        begin
          MessageDlg(//'Время выключения должно соответствовать дате смены '
            TrLangMSG(msgDisconSmen), mtError, [mbOk], 1);
          _res := false;
        end;
 }
   if ( _dttm_discon > Now)
     then
        begin
          MessageDlg({'Время выключения больше текущей даты '}
          TrLangMSG(msgDisconDtNow), mtError, [mbOk], 1);
          _res := false;
        end;
 Result := _res;
end;

function Tfrm_DisconNew.IsDataFieldsCorrect: boolean;
var _res: boolean;
begin
  //
  _res := false;
  if dset_main.FieldByName('id_ul').AsInteger<=0 then
  begin
   MessageDlg(TrLangMSG(msgNeedStreet),
                {'Не введёна улица!'} mtError, [mbOk], 1);
   dbl_Street.SetFocus;
   _Res := false;
  end
   else

  if dset_main.FieldByName('FK_DISCON_BRIG').AsInteger >0 then _res := true
   else
    begin
      MessageDlg({'Не введён исполнитель отключения'}
                TrLangMSG(msgNeedDisconExecutor), mtError, [mbOk], 1);
      _Res := false;
    end;
 if (dset_main.FieldByName('FK_DISCON_PERV_ID').IsNull)
    or (dset_main.FieldByName('FK_DISCON_PERV_ID').AsInteger<0)
    then
    begin
          MessageDlg({'Введите Класификация отключений  '}
          TrLangMSG(msgNeedClassDiscon), mtError, [mbOk], 1);
          _res := false;
        end;
 if _res then
  if  ((dset_main.FieldByName('DTTM_CON').AsDateTime = 0)
        or (dset_main.FieldByName('FK_DISCON_BRIG_CONNECT').AsInteger > 0)) then _res:= true
        else
          begin
          MessageDlg({'Не введён ответственный за включение'}
              TrLangMSG(msgResponseNeed), mtError, [mbOk], 1);
          _res:= false;
          end;

  Result:= _res;

end;

procedure Tfrm_DisconNew.btn_CancelClick(Sender: TObject);
var BMark: string;
begin
  inherited;
  Tr_main.RollbackRetaining;
  BMark:=dset_Main.Bookmark;
  dset_Main.Close;
  dset_Main.Open;
  dset_Main.Bookmark:=BMark;
  Enable_ConnectTimeAllFill;

end;

procedure Tfrm_DisconNew.dset_mainAfterScroll(DataSet: TDataSet);
begin
  inherited;
 Enable_ConnectTimeAllFill;
  dset_mainCalcFields(Dataset);
  f_idDel:=dset_main.fieldbyname('id').AsInteger;
end;

procedure Tfrm_DisconNew.dbl_BrigConnectChange(Sender: TObject);
begin
  inherited;
  if dset_main.State in [dsEdit, dsInsert] then
  if not  dset_main.FieldByName('DTTM_CON').IsNull then
     dset_main.FieldByName('FK_DISCON_DISP_CONNECT').AsInteger:=CodUser
  else
     dset_main.FieldByName('FK_DISCON_DISP_CONNECT').AsVariant:=0;
  CtrlsChange(Sender);
end;

procedure Tfrm_DisconNew.dbl_ExecutorChange(Sender: TObject);
begin
  inherited;
  if dset_main.State in [dsEdit, DsInsert] then
    dset_main.FieldByName('FK_DISCON_DISP_DISCONNECT').AsInteger:=CodUser;
 CtrlsChange(sender);
end;

procedure Tfrm_DisconNew.DBDateEdit1Change(Sender: TObject);
begin
  inherited;

  if dset_main.State in [dsEdit, dsInsert] then
  if not  dset_main.FieldByName('DTTM_DIsCON_plan').IsNull then
     dset_main.FieldByName('FK_DISCON_DISP_DISCONNECT_plan').AsInteger:=CodUser
  else
     dset_main.FieldByName('FK_DISCON_DISP_DISCONNECT_plan').AsVariant:=0;
  CtrlsChange(Sender);
end;

procedure Tfrm_DisconNew.DBDateEdit2Change(Sender: TObject);
begin
  inherited;
if dset_main.State in [dsEdit, dsInsert] then
  if not  dset_main.FieldByName('DTTM_CON_plan').IsNull then
     dset_main.FieldByName('FK_DISCON_DISP_CONNECT_plan').AsInteger:=CodUser
  else
     dset_main.FieldByName('FK_DISCON_DISP_CONNECT_plan').AsVariant:=0;
  CtrlsChange(Sender);
end;

procedure Tfrm_DisconNew.dset_mainAfterEdit(DataSet: TDataSet);
begin
  inherited;
dset_main.FieldByName('modifi').AsInteger:=1;
if dset_main.FieldByName('TYP_HOUSE').IsNull then
   dset_main.FieldByName('TYP_HOUSE').AsInteger:=1;
end;

procedure Tfrm_DisconNew.FormDestroy(Sender: TObject);
begin
  inherited;
    listdel.Free;
end;

procedure Tfrm_DisconNew.dset_mainAfterPost(DataSet: TDataSet);
var houses:string;
dt_d_p, dt_d_f, dt_c_p, dt_c_f:TDateTime;
begin
  inherited;
  //Отменим посылку  - некуда отсылать
  {houses:='';
  if not Dataset.FieldByName('house').IsNull then
  begin
    houses:=trim(Dataset.FieldByName('house').AsString);
    if not Dataset.FieldByName('houses_to').IsNull then
      houses:=houses+'-'+trim(Dataset.FieldByName('houses_to').AsString);
 end;

 case Dataset.FieldByName('TYP_HOUSE').AsInteger of
  0,1:houses:=houses+TrLangMSG(msgAllhouses);//' все дома';
  2:houses:=houses+TrLangMSG(msgEvenhouses);//' четные дома';
  3:houses:=houses+TrLangMSG(msgNotEvenHouses);//' нечетные дома';
 end;



//заполняем посілку
if not dataset.fieldbyname('DTTM_DISCON_Plan').IsNull    then
 dt_d_p:= dataset.fieldbyname('DTTM_DISCON_Plan').AsDateTime
else
 if not Dataset.fieldbyname('DTTM_DISCON').IsNull then
    dt_d_p:= dataset.fieldbyname('DTTM_DISCON').AsDateTime;

if not dataset.fieldbyname('DTTM_DISCON').IsNull    then
 dt_d_f:= dataset.fieldbyname('DTTM_DISCON').AsDateTime
else
 if not Dataset.fieldbyname('DTTM_DISCON_Plan').IsNull then
    dt_d_f:= dataset.fieldbyname('DTTM_DISCON_Plan').AsDateTime;

if not dataset.fieldbyname('DTTM_CON_PLAN').IsNull    then
 dt_c_p:= dataset.fieldbyname('DTTM_CON_PLAN').AsDateTime
else
 if not Dataset.fieldbyname('DTTM_CON').IsNull then
    dt_c_p:= dataset.fieldbyname('DTTM_CON').AsDateTime;

if not dataset.fieldbyname('DTTM_CON').IsNull    then
 dt_c_f:= dataset.fieldbyname('DTTM_CON').AsDateTime
else
 if not Dataset.fieldbyname('DTTM_CON_PLAN').IsNull then
    dt_c_f:= dataset.fieldbyname('DTTM_CON_PLAN').AsDateTime;

F_sentserv.AddPlace(dset_main.fieldbyname('id').AsInteger,Dataset.fieldbyname('look_streets').asstring,houses,
dataset.fieldbyname('DTTM_DISCON_Plan').AsDateTime,dataset.fieldbyname('DTTM_DISCON').AsDateTime,
dataset.fieldbyname('DTTM_CON_PLAN').AsDateTime,dataset.fieldbyname('DTTM_CON').AsDateTime);}

end;

procedure Tfrm_DisconNew.dset_mainAfterDelete(DataSet: TDataSet);
begin
  inherited;
  // Некуда отсылать заполняем посілку
  {F_sentserv.AddDel(f_idDel);}
end;

procedure Tfrm_DisconNew.dset_mainBeforeDelete(DataSet: TDataSet);
begin
  inherited;
  f_idDel:=dset_main.fieldbyname('id').AsInteger;
end;

procedure Tfrm_DisconNew.DBDateTimeEditEh1Change(Sender: TObject);
begin

DBDateEdit1Change(Sender);
  inherited;

end;

procedure Tfrm_DisconNew.DBDateTimeEditEh2Change(Sender: TObject);
begin
  inherited;
DBDateEdit2Change(Sender);

end;

procedure Tfrm_DisconNew.dbl_perevChange(Sender: TObject);
begin
  inherited;

 CtrlsChange(sender);
end;

procedure Tfrm_DisconNew.dmem_addinfoChange(Sender: TObject);
begin
  inherited;
  CtrlsChange(sender);
end;



end.
