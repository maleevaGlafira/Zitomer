unit StackUnit;

interface

uses
  SysUtils, Classes, DB, DBTables, ServiceFuncUnit,Windows,datam;

type
  TStackZav=class
    public
      zav_cbAttach_id, zav_DBL_Raon_id, zav_DBL_Revs_id, zav_DBL_Zav_id,
      zav_DBL_owner_id,zav_DBL_WhatMatter_id,zav_CB_tAdr_id,
      zav_DBL_Ul1_id,zav_DBL_Ul2_id,zav_DBL_tzav_id,zav_DBL_Place_id,
      zav_DBL_Sod_id,zav_DBL_vrk_id,zav_DBL_MatPipe_id,zav_DBL_Diam_id,zav_DBL_Mest_id,
      zav_DBL_Sdal_id, zav_DBL_BrPoluch_id:integer;
      zav_ED_DopAdr_txt,zav_EdDop_Inf_txt:string;
  end;

  TStackPervViezd=class
    public
      IDZav,IDNar,IDBrig:integer;
      NaradTableName,ZavTableName:string;
  end;

  TStackPeoplesOfPervViezd=class
    public
  end;

  TDMStack = class(TDataModule)
    Qry_tmp: TQuery;
    Qry_Tmp1: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FStackPervViezd:TStackPervViezd;
  public
    StackZav:TStackZav;
    StackPeoplesOfPervViezd:TStackPeoplesOfPervViezd;
    function SavePervViezdID(_id_zav:integer):integer;
    function LoadPervViezd(_new_id_zav:integer):integer;
  end;

var
  DMStack: TDMStack;
  arrDMStack: array [1..16] of TDMStack;
  DMStackCounter:integer;
  
procedure CreateStack;
procedure FreeStack;
function CurrentStack:TDMStack;

implementation

{$R *.dfm}

function CurrentStack:TDMStack;
begin
  result:=arrDMStack[DMStackCounter];
end;

procedure CreateStack;
begin
  try
    inc(DMStackCounter);
    arrDMStack[DMStackCounter]:=TDMStack.Create(nil);
  finally
  end;
end;

procedure FreeStack;
begin
  if DMStackCounter>0 then
    begin
      try
        arrDMStack[DMStackCounter].Free;
      finally
        dec(DMStackCounter);
      end;
    end;      
end;

function TDMStack.LoadPervViezd(_new_id_zav:integer):integer;
var _add_people:integer;
    _sign:string;
begin
  result:=-1;
  try
    if (FStackPervViezd.IDNar>0) and (_new_id_zav>0) then
      begin
        if not DM1.DB_Avar.InTransaction then DM1.DB_Avar.StartTransaction;
        try
          MyExecSQL(Qry_Tmp,
            ' insert into nnarad '+
            ' (id_zav, '+
            ' nomer,dt_in, dt_out, '+
            ' id_work, id_brig,dop_inf, '+
            ' id_disin, id_disout, id_brig2 ,'+
            '  numbert, numteam, id_local , dt_dep) ' +
            ' select  id_zav, '+
            ' nomer,dt_in, dt_out, '+
            ' id_work, id_brig,dop_inf, '+
            ' id_disin, id_disout, id_brig2 ,'+
            '  numbert, numteam, id_local, dt_dep from '+FStackPervViezd.NaradTableName+
            ' where id='+IntToStr(FStackPervViezd.IDNar));
          MyOpenSQL(Qry_Tmp,' select max(id) from nnarad ');
          result:=Qry_Tmp.Fields[0].AsInteger;          
          //
          if result>0 then
            begin
              MyExecSQL(Qry_Tmp,
                ' update nnarad '+
                ' set id_zav='+IntToStr(_new_id_zav)+
                ' where id='+IntToStr(result));
              {Теперь скопируем людей на выезде}
              MyOpenSQL(Qry_Tmp,
                          ' select add_people,sign from ord_people '+
                          ' where id_work='+IntToStr(FStackPervViezd.IDNar));
              Qry_Tmp.First;
              while not Qry_Tmp.Eof do
                begin
                  _add_people:=Qry_Tmp.Fields[0].AsInteger;
                  _sign:=Qry_Tmp.Fields[1].AsString;
                  MyExecSQL(Qry_Tmp1,
                    ' insert into ord_people '+
                    ' (id_zav, id_work, id_team, add_people, sign) '+
                    ' values ( '+IntToStr(_new_id_zav)+', '+
                      IntToStr(result)+', '+
                      IntToStr(FStackPervViezd.IDBrig)+', '+
                      IntToStr(_add_people)+', "'+_sign+'"'+
                    ' )');
                  Qry_Tmp.Next;
                end;
              {/}
            end;
          if DM1.DB_Avar.InTransaction then DM1.DB_Avar.Commit;
        finally
          Qry_Tmp.Close;
        end;
      end;
  except
    on E:Exception do
      begin
        if DM1.DB_Avar.InTransaction then DM1.DB_Avar.Rollback;
        MessageBox(0,PChar('TDM_Stack.SetPervViezd: '+#13+E.Message),'Диспетчер АВР',MB_OK or MB_ICONWARNING);
      end;
  end;
end;

function TDMStack.SavePervViezdID(_id_zav:integer):integer;
var s:string;
begin
  result:=-1;
  try
    s:='';
    //
    MyOpenSQL(Qry_tmp,'select * from nzavjav where (delz=0) and id='+IntToStr(_id_zav));
    if Qry_tmp.eof then
      begin
        MyOpenSQL(Qry_tmp,'select * from zavjav where (delz=0) and id='+IntToStr(_id_zav));
        if not Qry_tmp.eof then
          begin
            FStackPervViezd.ZavTableName:='zavjav';
            s:='narad';
          end;
      end
        else
      begin
        FStackPervViezd.ZavTableName:='nzavjav';
        s:='nnarad';
      end;  
      //
      if s<>'' then
        begin
          MyOpenSQL(Qry_tmp,'select id,id_brig '+
                            ' from '+s+
                            ' where (id_zav='+IntToStr(_id_zav)+')'+
                            ' order by id asc ');
          result:=Qry_tmp.Fields[0].AsInteger;
          FStackPervViezd.IDBrig:=Qry_tmp.Fields[1].AsInteger;
          FStackPervViezd.IDZav:=_id_zav;
        end;
  finally
    Qry_Tmp.Close;
    FStackPervViezd.IDNar:=result;
    FStackPervViezd.NaradTableName:=s;
  end;
end;
  
procedure TDMStack.DataModuleCreate(Sender: TObject);
begin
    StackZav:=TStackZav.Create;
    FStackPervViezd:=TStackPervViezd.Create;
    StackPeoplesOfPervViezd:=TStackPeoplesOfPervViezd.Create;
end;

procedure TDMStack.DataModuleDestroy(Sender: TObject);
begin
    StackZav.Free;
    FStackPervViezd.Free;
    StackPeoplesOfPervViezd.Free;
end;

initialization
  DMStackCounter:=0;

end.

