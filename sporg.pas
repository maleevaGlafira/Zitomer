unit sporg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Db, DBTables, frmLang, cntsLANG;

type
  TFormOrg = class(TFormLang)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Ed_name: TEdit;
    Ed_tf: TEdit;
    Ed_Fam: TEdit;
    BB_Ok: TBitBtn;
    BB_ESC: TBitBtn;
    procedure BB_ESCClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Ed_nameChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BB_OkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    isChange:boolean;
    procedure Translate;override;
  end;

function Vvod_Org(Ow:TComponent;var Name,Tf,Fam:string):boolean;

{var
  FormOrg: TFormOrg;}


implementation

{$R *.DFM}

procedure TFormOrg.BB_ESCClick(Sender: TObject);
begin
     isChange:=false;
     Close;
end;

function Vvod_Org(Ow:TComponent;var Name,Tf,Fam:string):boolean;
var Org:TFormOrg;
begin
  Org:=TFormOrg.Create(Ow);
  //Org.id2Find:=tut_id;
  Org.isChange:=false;
  Org.Ed_Name.Text:=Name;
  Org.Ed_Tf.Text:=Tf;
  Org.Ed_Fam.Text:=Fam;
  Org.ShowModal;
  if Org.isChange then
   begin
    Name:=Org.Ed_Name.Text;
    Tf:=Org.Ed_Tf.Text;
    Fam:=Org.Ed_Fam.Text;
   end;
  Result:=Org.isChange;
end;

procedure TFormOrg.FormCreate(Sender: TObject);
begin
 {  Ret:=0;
   if id2Find>0 then
     begin
       Qry_Org.SQL.Clear;
       Qry_Org.SQL.Add('select * from s_org where id='+inttostr(id2Find));
       Qry_Org.Open;
       Ed_Name.Text:=Qry_Org.FieldByName('NAME_R').asString;
       Ed_tf.Text:=Qry_Org.FieldByName('TF').asString;
       Ed_Fam.Text:=Qry_Org.FieldByName('FAMIL').asString;
       Qry_Org.Close;
     end
   else
     Lb_stat.Caption:='Новая';}
end;

procedure TFormOrg.Ed_nameChange(Sender: TObject);
begin
  isChange:=true;
//  Lb_stat.Caption:='Изменения не сохранены';
end;

procedure TFormOrg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
{  Name:=Org.Ed_Name.Text;
  Tf:=Org.Ed_Tf.Text;
  Fam:=Org.Ed_Fam.Text;}
  Action:=caFree;
end;

procedure TFormOrg.BB_OkClick(Sender: TObject);
begin
  { if id2Find>0 then
     begin
       Qry_Org.SQL.Clear;
       Qry_Org.SQL.Add('update s_org set name_r="'+
       Ed_Name.Text+'",tf="'+Ed_tf.Text+'",famil="'+Ed_Fam.Text+
       '" where id='+inttostr(id2Find));
       Qry_Org.ExecSQL;
       Ret:=id2Find;
     end
   else
     begin
       Qry_Org.SQL.Clear;
       Qry_Org.SQL.Add('insert into s_org(name_r,tf,famil) values("'+
       Ed_Name.Text+'","'+Ed_tf.Text+'","'+Ed_Fam.Text+
       '")');
       Qry_Org.ExecSQL;
       Qry_Org.SQL.Clear;
       Qry_Org.SQL.Add('select max(id) mm from s_org');
       Qry_Org.Open;
       Ret:=Qry_Org.FieldByName('MM').asInteger;
       Qry_Org.Close;
     end;
   Qry_Org.SQL.Clear;
   Qry_Org.SQL.Add('COMMIT');
   Qry_Org.ExecSQL;}
end;

procedure TFormOrg.Translate;
begin
  inherited;
  Caption:=TrLangMSG(msgCompany);
  Label1.Caption:=TrLangMSG(msgDesign);
  Label3.Caption:=TrLangMSG(msgSurname);
  BB_Ok.Caption:=TrLangMSG(msgApply);
  BB_ESC.Caption:=TrLangMSG(msgCancel);
end;

end.
