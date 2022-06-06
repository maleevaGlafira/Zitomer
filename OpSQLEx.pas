unit OpSQLEx;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Db, DBTables, ExtCtrls, ComCtrls, frmLANG, cntsLANG,
  ServiceFuncUnit;

type
  TFormOpSQL = class(TForm)
    BB_ESC: TBitBtn;
    Db_ESC: TDatabase;
    Qry_ESC: TQuery;
    Timer1: TTimer;
    Qry_exit: TQuery;
    Anim: TAnimate;
    Label1: TLabel;
    procedure BB_ESCClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    SQLstr,newSQLstr:string;
    qry_tmp:TQuery;
  end;

function OpenSQLEx(Ow:TComponent;qry_work:TQuery;al_,SQLs_:string):boolean;

var
  FormOpSQL: TFormOpSQL;
  ExRes:boolean;
  gen_name:string;

implementation
  uses main;
{$R *.DFM}

procedure TFormOpSQL.BB_ESCClick(Sender: TObject);
begin
  Anim.Visible:=false;
  Anim.Active:=false;
  Label1.Visible:=true;
  Label1.Refresh;
  DB_ESC.LoginPrompt:=False;
  DB_ESC.Connected:=False;
  Db_ESC.Params.Clear;
  Db_ESC.Params.Add(Format('USER NAME=%s',['SYSDBA']));
  Db_ESC.Params.Add(Format('PASSWORD=%s',['masterkey']));
  Db_ESC.Connected:=true;
  MyExecSQL(Qry_ESC,'set generator '+gen_name+' to 100');
  DB_ESC.Connected:=False;
  ExRes:=false;;
//
end;

function OpenSQLEx(Ow:TComponent;qry_work:TQuery;al_,SQLs_:string):boolean;
var ff:TFormOpSQL;
    {rnd_n,}i:integer;
  begin

//    Result:=true;
    ff:=TFormOpSQL.Create(Ow);
    ff.SQLstr:=SQLs_;
    ff.Db_ESC.AliasName:=al_;
    //ff.Db_ESC.DatabaseName:='ESC_al';
    ff.Qry_tmp:=Qry_work;
    ff.Qry_exit.DataBaseName:=ff.Qry_tmp.DataBaseName;
    ExRes:=true;
    //Randomize;
    //rnd_n:=Random(20000);
    gen_name:='ugn_'+TekUser;//inttostr(rnd_n);
    ff.Qry_exit.Close;
    ff.Qry_exit.SQL.Clear;
    ff.Qry_exit.SQL.Add('set generator '+gen_name+' to 0');
    try
       ff.Qry_exit.ExecSQL;
    except
      MyExecSQL(ff.Qry_exit,'create generator '+gen_name);
    end;
    MyExecSQL(ff.Qry_exit,'COMMIT');
    ff.newSQLstr:='';
    while ff.SQLstr<>'' do
      begin
        i:=pos('where',ff.SQLstr);
        if i>0 then
          begin
            ff.newSQLstr:=ff.newSQLstr+' '+
                 copy(ff.SQLstr,1,i+5)+' gen_id('+gen_name+',0)=0 and ';
                 delete(ff.SQLstr,1,i+5);
           end
        else
          begin
            ff.newSQLstr:=ff.newSQLstr+' '+ff.SQLstr;
            ff.SQLstr:='';
          end;
      end;
    ff.ShowModal;
    Result:=ExRes;
  end;

procedure TFormOpSQL.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  MyExecSQL(Qry_exit,
//  'DELETE FROM RDB$GENERATORS WHERE RDB$GENERATOR_NAME = "'+gen_name+'"');
  Action:=caFree;
end;

procedure TFormOpSQL.FormShow(Sender: TObject);
begin
  MyOpenSQL(Qry_tmp,newSQLstr);
  Timer1.Enabled:=true;
end;

procedure TFormOpSQL.Timer1Timer(Sender: TObject);
begin
  Close;
end;

procedure TFormOpSQL.FormCreate(Sender: TObject);
begin
  BB_Esc.Caption:=TrLangMSG(msgCancelRun)
end;

end.
