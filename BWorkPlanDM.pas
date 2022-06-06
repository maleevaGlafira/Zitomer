unit BWorkPlanDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BWorkDM, IBCustomDataSet, DB, IBDatabase;

type
  Tdm_BWorkPlan = class(Tdm_BWork)
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
   procedure SetSQL; override;
  end;

const tableName='BWORKS_PLAN';

var
  dm_BWorkPlan: Tdm_BWorkPlan;

implementation

{$R *.dfm}

procedure  Tdm_BWorkPlan.SetSQL;
var _SQL, _addSQL: string;

   function GetIdObjOborSTR: string;
     begin
         if F_IdObjObor > 0 then
           Result := ' and ( w.id_objobor = '+ inttostr( F_IdObjObor )+ ')'
           else
           Result := ' and ( (w.id_objobor = -1) or (w.id_objobor is null)) ';
     end;

begin
setTableName();

 if F_IsObjZav then
    _addSQL := ' and bw.id in (select distinct w.bworks_id from works_plan w '+
              ' where ( w.id_zav = :pZavID ) and  ( w.id_nar = :pNarID ) '+
              GetIdObjOborSTR + ' and ( w.bworks_id is not null ))'
  else
     _addSQL := '';

     _SQL := ' select bw.id, bw.id_zav, bw.id_nar, bw.id_bwork '+
    'from bworks_plan bw '+
    'left join s_bwork sbw on sbw.id = bw.id_bwork '+
    'where ( bw.id_zav = :pZavID ) and '+
    '( bw.id_nar = :pNarID ) '+ _addSQL +
    'order by sbw.name_r ';

    dset_BWork.SelectSQL.Text := _SQL;


end;

procedure Tdm_BWorkPlan.DataModuleCreate(Sender: TObject);
begin
  inherited;
f_tableName:= tableName;
end;

end.
