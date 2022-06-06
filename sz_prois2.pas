unit sz_prois2;

interface

{$I !map_define.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, CheckLst,frm_srdb, Buttons, frm_dat, Spin, Db,
  DBTables, ExtCtrls, Placemnt, frmLANG, cntsLANG,StrUtils
  {$IFDEF MAP}
    ,ServiceFuncUnit,SendMessToAvarOnMap
  {$ENDIF};

type TSearBlock = record
   SForm:TFrm_SDb;
   OrigSQL:string;
   NRel:integer;
   RelTo:string;
end;

const MaxSear=29;

type
  TSz_proizv2 = class(TFormLang)
    OpenFl: TOpenDialog;
    Qry_tmp: TQuery;
    Debug_pl: TPanel;
    MemoSQL: TRichEdit;
    Panel1: TPanel;
    Baze_pl: TPanel;
    TbC_Sear: TTabControl;
    ChLB_2Sear: TCheckListBox;
    Panel2: TPanel;
    BB_Prov: TBitBtn;
    BB_dRun: TBitBtn;
    Panel3: TPanel;
    BB_Run: TBitBtn;
    BB_Open: TBitBtn;
    BB_Debug: TBitBtn;
    BB_Close: TBitBtn;
    Panel4: TPanel;
    Label2: TLabel;
    SE_NomIn: TSpinEdit;
    Label3: TLabel;
    SE_NomOut: TSpinEdit;
    DateZayav_rg: TRadioGroup;
    Frm_Dt: TFrm_Date;
    Splitter1: TSplitter;
    RB_Zav: TRadioButton;
    RB_Nzav: TRadioButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ChLB_2SearClick(Sender: TObject);
    procedure TbC_SearChange(Sender: TObject);
    procedure BB_RunClick(Sender: TObject);
    procedure BB_OpenClick(Sender: TObject);
    procedure BB_CloseClick(Sender: TObject);
    procedure BB_dRunClick(Sender: TObject);
    procedure BB_ProvClick(Sender: TObject);
    procedure BB_DebugClick(Sender: TObject);
    procedure BDateInClick(Sender: TObject);
    procedure DateZayav_rgClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ChLB_2SearClickCheck(Sender: TObject);
    procedure RB_ZavClick(Sender: TObject);
    procedure RB_NzavClick(Sender: TObject);
  private
    { Private declarations }
    StreetSel:Boolean;
    WorkSel:Boolean;
    procedure DBLC_MyChange(Sender: TObject);
    procedure SelectNeedTable;
    procedure MakeRunSQL;
  public
    { Public declarations }
    CountSear:integer;
    isNomer,isData:boolean;
    RunSQLstr,RunTitles,RunRun,Name,orderSQL:string;
    NmNomer,ResTitles:string;
    RunAdres:integer;
    SearForms: array [0..MaxSear] of TSearBlock;
    SpisFile:TStringList;
    out_file :string;
    procedure UpdTabC;
    procedure SRefresh;
    function GetRunSQL:string;
    procedure LoadScript;
    procedure Translate;override;
  end;

var
  Sz_proizv2: TSz_proizv2;

implementation
  uses inifiles,main,strtool,fresult, avartype;

const
 deltaHt = 5; // ds 38
 titleDateIn = 'Дат.пост.'; // ds
 titleDateOut = 'Дат.закр.'; // ds

{$R *.DFM}

procedure TSz_proizv2.MakeRunSQL;
var str1:string;
begin
  if trim(Frm_Dt.t_db)='' then Frm_Dt.t_db:='zavjav';
  if DateZayav_rg.Itemindex = 0 then str1:='z.dt_in'
                                else str1:='z.dt_out';
  if trim(Frm_Dt.t_db)='nzavjav' then str1:='z.dt_in';
  RunSQLstr:='select distinct z.id,id_ul1,z.id_ul2,z.kod_ul,z.dop_adr, z.id_attach attach, z.nomer pole0,'+
             'z.fyear pole1,'+str1+' pole2, d.diam pole4, pl.name_r pole5, sd.name_r pole6 from '+
              {10.10.2005}
              Frm_Dt.t_db+
              {/10.10.2005}
              ' z,s_diam d, s_place pl, s_sod sd where (delz=0) and z.id_diam=d.id and z.id_place=pl.id and z.id_comment=sd.id and z.id>0 ';
 Frm_Dt.t_db:='z';             

end;

procedure TSz_proizv2.SelectNeedTable;
var s:string;
begin
  if RB_Zav.Checked then
    begin
      Frm_Dt.t_db:='zavjav';
      s:=TrLangMSG(msgForClosed);
    end
      else
    begin
      Frm_Dt.t_db:='nzavjav';
      s:=TrLangMSG(msgForNotClosed);
    end;      
  Caption:=TrLangMSG(msgProizSearch)+' по '+s+' нарядам';
  MakeRunSQL;
end;

procedure TSz_proizv2.FormCreate(Sender: TObject);
var sr: TSearchRec;
    FileAttrs: Integer;
    str1 :string;
begin
  Debug_pl.Visible:=false; // ds
  out_file:=''; // ds
//  Debug_pl.Top:=0;
//  Baze_pl.Anchors:=Baze_pl.Anchors - [akBottom];
//  ClientHeight:=Baze_pl.Height;
//  Baze_pl.Anchors:=Baze_pl.Anchors + [akBottom];

  isNomer:=true;
  isData:=true;
//  Self.ClientHeight:=BB_Run.Top+BB_Run.Height+deltaHt;
  BDateInClick(self);
  MakeRunSQL;
  if DateZayav_rg.Itemindex = 0 then str1:=titleDateIn
                                else str1:=titleDateOut;
//  RunTitles:='Номер;'+TrLangMSG(msgYear)+';'+str1+';'+TrLangMSG(msgAddr);
    RunTitles:='Номер;'+TrLangMSG(msgYear)+';'+str1+';'+TrLangMSG(msgAddr)+';'+TrLangMSG(msgDiam)+';'+TrLangMSG(msgDmgPlace)+';'+TrLangMSG(msgContext){'Характер'};
  orderSQL:=' order by 7,6';
  RunAdres:=3;
  NmNomer:='z.nomer';
  SpisFile:=TStringList.Create;
  FileAttrs := faAnyFile;

  if FindFirst(CurrentDir+'\frm\*.prs', FileAttrs, sr) = 0 then
  begin
      if (sr.Attr and FileAttrs) = sr.Attr then
      begin
        SpisFile.Add(sr.Name);
      end;
      while FindNext(sr) = 0 do
      begin
        if (sr.Attr and FileAttrs) = sr.Attr then
        begin
         SpisFile.Add(sr.Name);
        end;
      end;
      FindClose(sr);
  end;
  CountSear:=SpisFile.Count-1;
  if CountSear>MaxSear then
     CountSear:=MaxSear;

  SRefresh;

end;


procedure TSz_proizv2.SRefresh;
var i,j,k:integer;
    mIni:TiniFile;
    us_db,tt_str:string;
begin
   ChLB_2Sear.Items.Clear;
   TbC_Sear.Tabs.Clear;
   for i:=0 to CountSear do
     begin
       if Assigned(SearForms[i].SForm) then
          SearForms[i].SForm.Free;
       SearForms[i].RelTo:='';
       SearForms[i].NRel:=-1;
       SearForms[i].OrigSQL:='';
     end;

   for i:=0 to CountSear do
     begin
        SearForms[i].SForm:=TFrm_SDb.CreateParented(TbC_Sear{Panel1}.Handle);
        SearForms[i].SForm.Parent:=TbC_Sear{Panel1};
        SearForms[i].SForm.Visible:=false;
        SearForms[i].SForm.Enabled:=false;
        SearForms[i].SForm.Left:=5;
        SearForms[i].SForm.Height:=SearForms[i].SForm.GrB_like.Top +
                                   SearForms[i].SForm.GrB_like.Height + deltaHt*2; // ds
        //SearForms[i].SForm.WIdth:=510;
        SearForms[i].SForm.Top:=TbC_Sear.Height - SearForms[i].SForm.Height - deltaHt*2;

      {  if (SearForms[i].SForm.Top < (-TbC_Sear.font.height)*2) then
           SearForms[i].SForm.Top:=(-TbC_Sear.font.height)*2;}

           {(-TbC_Sear.font.height)*2 +
             Trunc((TbC_Sear.Height - SearForms[i].SForm.Height)/2); // ds + 60;}
        SearForms[i].SForm.Anchors:=[akLeft, akBottom]; // ds
        SearForms[i].SForm.align:=alClient;
        
        mIni:=TIniFile.Create(CurrentDir+'\frm\'+SpisFile[i]);
        SearForms[i].SForm.Text:=mIni.ReadString('Main','Text','');
        SearForms[i].SForm.SQLStr:=mIni.ReadString('Main','SQLStr','');
        SearForms[i].SForm.MainSQlStr:=mIni.ReadString('Main','MainSQLStr','');
        SearForms[i].SForm.n_field:=mIni.ReadString('Main','n_field','');
        SearForms[i].SForm.SQLField:=mIni.ReadString('Main','SQLField','');
        SearForms[i].SForm.isLike:=mIni.ReadInteger('Main','isLike',1);
        SearForms[i].SForm.isUpper:=mIni.ReadInteger('Main','isUpper',0);
        SearForms[i].SForm.DbName:=mIni.ReadString('Main','DBName','');
        SearForms[i].SForm.L_field:=mIni.ReadString('Main','L_Field','');
        SearForms[i].SForm.Like_field:=mIni.ReadString('Main','Like_Field','');
        SearForms[i].SForm.DBLC_sear.OnChange:=DBLC_MyChange;
        SearForms[i].OrigSQL:=SearForms[i].SForm.SQLStr;
        ChLB_2Sear.Items.Add(SearForms[i].SForm.Text);
        SearForms[i].RelTo:=mIni.ReadString('Main','RelTo','');

        mIni.Free;
     end;

   for i:=0 to CountSear do
     begin
       if SearForms[i].RelTo<>'' then
          begin
             us_db:=ExtractWordsx_(2,1,SearForms[i].RelTo,';',false);
             for j:=0 to CountSear do
               begin
                 if j<>i then
                   begin
                      tt_str:=SearForms[j].SForm.SQLStr;
                      k:=pos('where',tt_str);
                      if k>0 then
                        tt_str:=copy(tt_str,1,k);
                      k:=pos(us_db,tt_str);
                      if k>0 then
                        begin
                          SearForms[i].NRel:=j;
                          break;
                        end;
                   end;
               end;
          end;
     end;
end;


procedure TSz_proizv2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
// FormPlacement1.IniFileName:=FullPathIniFlParams; // ds
 SpisFile.Free;
 Action:=caFree;
end;

procedure TSz_proizv2.UpdTabC;
var i:integer;
begin
  for i:=0 to CountSear do
     begin
       if (SearForms[i].NRel>-1) and (not ChLB_2Sear.Checked[i]) then
         begin
              SearForms[SearForms[i].NRel].SForm.SQLStr:=
                       SearForms[SearForms[i].NRel].OrigSQL;

             //SearForms[i].SForm.SQLStr:=SearForms[i].OrigSQL;
         end;
     end;


   TbC_Sear.Tabs.Clear;
   Application.ProcessMessages;
   for i:=0 to CountSear do
     begin
       if ChLB_2Sear.Checked[i] then
        begin
          TbC_Sear.Tabs.AddObject(ChLB_2Sear.Items.Strings[i],TObject(i));
        end;          
     end;
end;

procedure TSz_proizv2.ChLB_2SearClick(Sender: TObject);
begin
  //TbC_Sear.Visible:=false;
//  UpdTabC;
//  TbC_SearChange(Self);
  //TbC_Sear.Visible:=true;
end;

procedure TSz_proizv2.TbC_SearChange(Sender: TObject);
var i,nom:integer;

begin
   for i:=0 to CountSear do
     begin
      SearForms[i].SForm.Close;
      SearForms[i].SForm.Visible:=false;
      SearForms[i].SForm.Enabled:=false;
     end;
  if TbC_Sear.TabIndex>-1 then
   begin
    nom:=integer(TbC_Sear.Tabs.Objects[TbC_Sear.TabIndex]);
      {if SearForms[nom].SQLDopUsl<>'' then
        begin
          us_db:=ExtractWordsx_(1,1,SearForms[nom].SQLDopUsl,';',false);
          us_fld:=ExtractWordsx_(2,1,SearForms[nom].SQLDopUsl,';',false);
          us_dob:=ExtractWordsx_(3,1,SearForms[nom].SQLDopUsl,';',false);
          for i:=0 to CountSear do
           begin
              if (i<>nom) and (pos(us_db,SearForms[i].Qry_sear.SQL[0]>0) then
                 begin
                   SearForms[i].Open;
                   us_fld:=SearForms[i].Qry_sear.FieldByName(us_fld).asString;
                   SearForms[i].Close;
                   us_dob:=us_dob+'="'+us_fld+'"';
                   i:=10000;
                 end;
           end;
     end;}

    SearForms[nom].SForm.Visible:=true;
    SearForms[nom].SForm.Enabled:=true;
    SearForms[nom].SForm.Open;
   end;
end;


procedure TSz_proizv2.DBLC_MyChange(Sender: TObject);
var us_fld,us_dob,us_znach:string;
    i,nom:integer;
begin
 nom:=integer(TbC_Sear.Tabs.Objects[TbC_Sear.TabIndex]);
 if SearForms[nom].NRel>-1 then
    begin
        us_fld:=ExtractWordsx_(1,1,SearForms[nom].RelTo,';',false);
        us_dob:=ExtractWordsx_(3,1,SearForms[nom].RelTo,';',false);
        us_znach:=SearForms[nom].SForm.
                      Qry_sear.FieldByName(us_fld).asString;
        if strtointdef(us_znach,-1)>0 then
           begin
              i:=pos('#',us_dob);
              if i>0 then
                begin
                  us_dob:=repchar('#',' ',us_dob);
                  insert(us_znach,us_dob,i);
                end;
              SearForms[SearForms[nom].NRel].SForm.SQLStr:=us_dob;
           end
        else
              SearForms[SearForms[nom].NRel].SForm.SQLStr:=
                       SearForms[SearForms[nom].NRel].OrigSQL;

    end;
end;

procedure TSz_proizv2.BB_RunClick(Sender: TObject);
var FRes:TFormResult;
    sTit:TstringList;
    tt_str:string;
    fstr, dstr :string;
    out_fl: TextFile;
    i:integer;
    str1:string;
    MyorderSQL,MyRunSQLstr:string;
    _k,_i:integer;
begin
  MyorderSQL:=orderSQL;
  MyRunSQLstr:=RunSQLstr;
  StreetSel:=False;
  WorkSel:=false;
  for i:=0 to ChLB_2Sear.Count-1 do
    if (ChLB_2Sear.Checked[i]) then
    begin
      if (Lower(ChLb_2Sear.Items[i])='вулиця') then
      begin
        StreetSel:=True;
      end;
      if Lower(ChLb_2Sear.Items[i])='роботи' then
        WorkSel:=true;
    end;
    if  WorkSel then
  begin
     Insert(', sw.name_r pole7,w.kol_work pole8',MyRunSQLStr,Pos('from',Lower(MyRunSQLStr))-1);
     Insert(', works w, s_work sw',MyRunSQLStr,Pos('where ',Lower(MyRunSQLStr))-1);
     if MyOrderSQL='' then
      MyOrderSQL:='and w.id_zav=z.id and w.id_work=sw.id '
    else
      MyOrderSQL:='and w.id_zav=z.id and w.id_work=sw.id'+MyOrderSQL;
  end;


  if StreetSel then
  begin
    Insert(', s_ulic ss',MyRunSQLStr,Pos('where',Lower(MyRunSQLStr))-1);
    if MyOrderSQL='' then
      MyOrderSQL:=' and ss.id=z.id_ul1 order by ss.name_r,z.id_ul2'
    else
      MyOrderSQL:=' and ss.id=z.id_ul1 order by ss.name_r,z.id_ul2,'+Copy(MyOrderSQL,Pos('order by',LowerCase(MyOrderSQL))+8,Length(MyOrderSQL)-Pos('order by',LowerCase(MyOrderSQL))-7);
  end;

  GetRunSQL;
  ///
  {$IFDEF MAP}
  if MAP_IS_WORK then
    begin
      _k:=POS('select ',MyRunSQLStr);
      if _k>0 then
        begin
          Insert(MAP_SELECT_SQL+', ',MyRunSQLStr,7);
        end;
    end;
  {$ENDIF}
  //MAP_SELECT_SQL
  ///
  MemoSQL.Text:=MyRunSQLStr+RunRun+MyorderSQL;
  if BB_Debug.Caption='>>' then
   begin
     sTit:=TStringList.Create;
     sTit.Clear;
     tt_str:=RepChar(';',#13,RunTitles);
     if Worksel then  begin
       tt_str:=tt_str+#13+'Работи';
       tt_str:=tt_str+#13+'Кіл-ість';
      end;
     sTit.SetText(pchar(tt_str));
     // если в sTit была titleDateIn(BDateIn.Down=false),
     // то заменяем на titleDateOut и наоборот
     if DateZayav_rg.Itemindex = 0 then
                          begin
                           fstr:=titleDateOut;
                           dstr:=titleDateIn;
                          end
                     else begin
                           fstr:=titleDateIn;
                           dstr:=titleDateOut;
                          end;
     if sTit.IndexOf(fstr) >= 0
        then sTit.Strings[sTit.IndexOf(fstr)]:=dstr;

     if out_file = '' then
       begin
        FRes:=TFormResult.ResCreate(Self,true,'dbn_avar','Результат',ResTitles,
              MyRunSQLStr+RunRun+MyorderSQL,sTit,RunAdres,{NIL}NN9,false);
        Fres.ShowModal;
        sTit.Free;
       end // if Show_res_form ...
         else begin
                AssignFile(out_fl, out_file);
                Rewrite(out_fl);
                Write(out_fl, MemoSQL.Text);
                CloseFile(out_fl);
                ModalResult:=mrOk;
              end;
   end;
end;

function TSz_proizv2.GetRunSQL:string;
var i,k:integer;
begin
   RunRun:='';
   ResTitles:=Self.Caption+'- наряда:';
   if isNomer then
    begin
     if SE_NomIn.Value>0 then
       begin
          ResTitles:=ResTitles+' номер >="'+SE_NomIn.Text+'"';
          RunRun:=RunRun+' and '+NmNomer+'>='+SE_NomIn.Text;
       end;
     if SE_NomOut.Value>0 then
       begin
          ResTitles:=ResTitles+' номер <="'+SE_NomOut.Text+'"';
          RunRun:=RunRun+' and '+NmNomer+'<='+SE_NomOut.Text;
       end;
    end;

   if isData then
    begin
     RunRun:=RunRun+Frm_Dt.SQLStr;
     ResTitles:=ResTitles+Frm_Dt.TitStr+' ';
    end;


   for i:=0 to CountSear do
     begin
       if ChLB_2Sear.Checked[i] then
         begin

          SearForms[i].SForm.Open;
          RunRun:=RunRun+' '+SearForms[i].SForm.GetSQL;
          ResTitles:=ResTitles+SearForms[i].SForm.GetTit;
          if integer(TbC_Sear.Tabs.Objects[TbC_Sear.TabIndex])<>i then
             SearForms[i].SForm.Close;
         end;
     end;
   //
   if RB_NZav.Checked then
    begin
     k:=1;
     i:=POSEX(' narad',RunRun,k);
     while i>0 do
      begin
        Delete(RunRun,i,length(' narad'));
        Insert(' nnarad',RunRun,i);
        k:=i+1;
        i:=POSEX(' narad',RunRun,k)
      end;
    end;      
   //
   Result:=RunRun;
end;

procedure TSz_proizv2.LoadScript;
var   mIni:TiniFile;
      tt_str:string;
      i:integer;
begin
    OpenFl.InitialDir:=CurrentDir+'\frm ';
    if OpenFl.Execute then
      begin
        mIni:=TIniFile.Create(OpenFl.FileName);
        Name:=mIni.ReadString('Main','Name','');
        NmNomer:=mIni.ReadString('Main','NmNomer','z.nomer');
        Frm_Dt.Min_Dt:=mIni.ReadString('Main','DtMin','dt_in');
        Frm_Dt.Max_Dt:=mIni.ReadString('Main','DtMax','dt_in');
        Frm_Dt.t_db:=mIni.ReadString('Main','Dt_DB','zavjav');
        {10.10.2005}
        SelectNeedTable;
        {/10.10.2005}
        RunSQLStr:=mIni.ReadString('Main','RunSQL','');
        orderSQL:=mIni.ReadString('Main','orderSQL','');
        RunTitles:=mIni.ReadString('Main','RunTit','');
        isNomer:=mIni.ReadBool('Main','isNomer',true);
        isData:=mIni.ReadBool('Main','isData',true);
        RunAdres:=mIni.ReadInteger('Main','RunAdres',-1);
        tt_str:=mIni.ReadString('Main','Spis','');
        mIni.Free;
        SE_NomIn.Enabled:=isNomer;
        SE_NomOut.Enabled:=isNomer;
        Frm_Dt.DE_In.Enabled:=isData;
        Frm_Dt.DE_Out.Enabled:=isData;
       if tt_str<>'' then
         begin
          Self.Caption:=Name;
          SpisFile.Clear;
          tt_str:=RepChar(';',#13,tt_str);
          SpisFile.SetText(pchar(tt_str));
          CountSear:=SpisFile.Count-1;
          if CountSear>MaxSear then
            CountSear:=MaxSear;
          for i:=0 to CountSear do
            SpisFile.Strings[i]:=trim(SpisFile.Strings[i])+'.prs';

          SRefresh;
         end;
    end;
end;

procedure TSz_proizv2.BB_OpenClick(Sender: TObject);
begin
   LoadScript;
end;

procedure TSz_proizv2.BB_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TSz_proizv2.BB_dRunClick(Sender: TObject);
var FRes:TFormResult;
    sTit:TstringList;
    tt_str:string;
begin
   sTit:=TStringList.Create;
   sTit.Clear;
   tt_str:=RepChar(';',#13,RunTitles);
   sTit.SetText(pchar(tt_str));

   FRes:=TFormResult.ResCreate(Self,true,'dbn_avar','Результат',ResTitles,
         MemoSQL.Text,sTit,RunAdres,NIL,false);
   Fres.ShowModal;
   sTit.Free;
end;

procedure TSz_proizv2.BB_ProvClick(Sender: TObject);
begin
  Qry_tmp.SQL.Clear;
  Qry_tmp.SQL.Add(MemoSQL.Text);
  try
    Qry_tmp.Open;
    Qry_tmp.Close;
    MessageDlg(TrLangMSG(msgQueryExec), mtInformation,
      [mbOk], 0);

  except
     on E: Exception do
        begin
         E.Message:=E.Message+#13#10+MemoSQL.Text;
         application.ShowException(E);
//         FormMain.AppErr.WriteException(FormMain,E);
        end;
  end;

end;

procedure TSz_proizv2.BB_DebugClick(Sender: TObject);
begin
  if BB_Debug.Caption='>>' then
    begin
      BB_Debug.Caption:='<<';
//      Height:=height+Debug_pl.height;
      Debug_pl.Visible:=true;
       // ds
{      Baze_pl.Anchors:=Baze_pl.Anchors - [akBottom];
      ClientHeight:=ClientHeight + Debug_pl.Height + deltaHt;
      Debug_pl.Top:=Baze_pl.Top + Baze_pl.Height + deltaHt;
      Baze_pl.Anchors:=Baze_pl.Anchors + [akBottom];
}     { Debug_pl.Top:=Self.ClientHeight;
      Debug_pl.Visible:=true;
      Self.ClientHeight:=Debug_pl.Top+Debug_pl.Height+deltaHt;}
    end
  else
    begin
      BB_Debug.Caption:='>>';
      Debug_pl.Visible:=false; // ds
//      Height:=height-Debug_pl.height;
{      Debug_pl.Top:=0;
      Baze_pl.Anchors:=Baze_pl.Anchors - [akBottom];
      ClientHeight:=Baze_pl.Height;
      Baze_pl.Anchors:=Baze_pl.Anchors + [akBottom];}

     { Debug_pl.Top:=0;
      Self.ClientHeight:=BB_Run.Top+BB_Run.Height+deltaHt;}
    end;
  Self.Position:=poScreenCenter;
  //Self.Update;
end;

// ds *******************************************************************
procedure TSz_proizv2.BDateInClick(Sender: TObject);
//var
 //str1 :string;
begin
end;

// ds *******************************************************************
procedure TSz_proizv2.DateZayav_rgClick(Sender: TObject);
var
 str1 :string;
begin
 with Frm_Dt do
  begin
   if DateZayav_rg.Itemindex = 0 then
    begin
     Min_dt:='dt_in';
     Max_dt:='dt_in';
     str1:='dt_out';
    end
     else begin
           Min_dt:='dt_out';
           Max_dt:='dt_out';
           str1:='dt_in';
          end;
   if Pos('z.'+str1, RunSQLstr) > 0 then
      begin
       Insert('z.'+Min_dt, RunSQLstr, Pos('z.'+str1, RunSQLstr));
       Delete(RunSQLstr, Pos('z.'+str1, RunSQLstr), length('z.'+str1));
      end;
  end; // with
end;

procedure TSz_proizv2.FormShow(Sender: TObject);
begin
 setforegroundwindow(handle);
end;

procedure TSz_proizv2.Translate;
var s:string;
begin
  inherited;
  if RB_Zav.Checked then s:=TrLangMSG(msgForClosed) else s:=TrLangMSG(msgNotClosed);
  Caption:=TrLangMSG(msgProizSearch)+' по '+s+' нарядам';
  BB_dRun.Hint:=TrLangMSG(msgExec)+' '+TrLangMSG(msgQuery);
  BB_Prov.Hint:=TrLangMSG(msgCheck)+' '+TrLangMSG(msgQuery);
  Label2.Caption:='Номер '+ansilowercase(TrLangMSG(msgFrom));
  RB_Zav.Caption:=TrLangMSG(msgClosed);
  RB_Nzav.Caption:=TrLangMSG(msgNotClosed);
  DateZayav_rg.Items[0]:=TrLangMSG(msgDateOpen);
  DateZayav_rg.Items[1]:=TrLangMSG(msgDateClose);
  BB_Run.Hint:=TrLangMSG(msgExec)+' '+TrLangMSG(msgQuery);
  BB_Run.Caption:=TrLangMSG(msgApply);
  BB_Open.Hint:=TrLangMSG(msgLoad)+' форму';
  BB_Open.Caption:=TrLangMSG(msgVedom);
  BB_Debug.Hint:=TrLangMSG(msgDebug);
  BB_Close.Hint:=TrLangMSG(msgExit);
  BB_Close.Caption:=TrLangMSG(msgExit);
  OpenFl.Filter:=TrLangMSG(msgForms)+'|*.frm';
end;

procedure TSz_proizv2.ChLB_2SearClickCheck(Sender: TObject);
begin
  inherited;
  UpdTabC;
  TbC_SearChange(Self);
end;

procedure TSz_proizv2.RB_ZavClick(Sender: TObject);
begin
  inherited;
  DateZayav_RG.Enabled:=RB_Zav.Checked;
  RB_NZav.Checked:=not(RB_Zav.Checked);
  SelectNeedTable;
end;

procedure TSz_proizv2.RB_NzavClick(Sender: TObject);
begin
  inherited;
  DateZayav_RG.Enabled:=RB_Zav.Checked;
  RB_Zav.Checked:=not(RB_NZav.Checked);
  SelectNeedTable;
end;

end.
