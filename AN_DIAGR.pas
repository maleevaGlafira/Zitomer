unit AN_DIAGR;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DB, DBTables, DbLook, Grids, DBGrids, Spin, Buttons, Mask, Diagram,
  ExtCtrls, frmLANG, cntsLANG, RxLookup, OperAttFormUnit, CheckLst;

const nRange=20;
      nYear=10;
type
  TQueryForm = class(TOperAttForm)
    lbSreet: TLabel;
    gbNum: TGroupBox;
    seNum1: TSpinEdit;
    seNum2: TSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    gbYear: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    seYear1: TSpinEdit;
    seYear2: TSpinEdit;
    btDiagram: TBitBtn;
    Label5: TLabel;
    gbGraph: TGroupBox;
    rbMatrix: TRadioButton;
    rbAdd: TRadioButton;
    rbDinam: TRadioButton;
    Bevel1: TBevel;
    BitBtn1: TBitBtn;
    DBL_ul1: TRxDBLookupCombo;
    DBL_Diam: TRxDBLookupCombo;
    Qry_Zavjav: TQuery;
    DS_ul1: TDataSource;
    Qry_ul1: TQuery;
    chb_tzav: TCheckListBox;
    procedure dblStreetChoiceExit(Sender: TObject);
    procedure edDiamKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btDiagramClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Changing(Sender: TObject);
    procedure rbGraphClick(Sender: TObject);
    procedure dblStreetExit(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure dblStreetEnter(Sender: TObject);
    procedure seYear1Enter(Sender: TObject);
    procedure seYear1Exit(Sender: TObject);
    procedure seYear2Exit(Sender: TObject);
    procedure seYear2Enter(Sender: TObject);
    procedure seNum1Enter(Sender: TObject);
    procedure seNum1Exit(Sender: TObject);
    procedure seNum2Exit(Sender: TObject);
    procedure seNum2Enter(Sender: TObject);
    procedure rbDinamExit(Sender: TObject);
    procedure rbDinamEnter(Sender: TObject);
    procedure rbMatrixEnter(Sender: TObject);
    procedure rbMatrixExit(Sender: TObject);
    procedure rbAddEnter(Sender: TObject);
    procedure rbAddExit(Sender: TObject);
    procedure edDiamEnter(Sender: TObject);
    procedure edDiamExit(Sender: TObject);
    procedure edDiamchange(Sender: TObject);
  private
    { Private declarations }
    Changed:boolean;
    procedure EnableBtn;
    procedure FillTZavList;
  public
    Count:PDoubleArr;
    sRange:Double;
    _MinValue,_MaxValue:double;
    Year1,Year2:TDateTime;
    nYear1,nYear2:Word;
    Num1,Num2:word;
  end;

var
  QueryForm: TQueryForm;
  Streetcode:Longint;

implementation

uses DgrForm, DataM;
{$R *.DFM}

procedure TQueryForm.dblStreetChoiceExit(Sender: TObject);
begin
   StreetCode:=Qry_ul1.FieldByName('id').AsInteger;
//  StreetCode:=tbEnumsNum_Val.asInteger;
  Changed:=True
end;

procedure TQueryForm.EnableBtn;
var
  i: integer;
  check: boolean;
begin
  check:=false;
  for i:=0 to chb_tzav.Count-1 do
    if chb_tzav.Checked[i] then
    begin
      check:=true;
      break;
    end;

  btDiagram.Enabled:=(Trim(DBL_ul1.Text)<>'')  and  check
end;

procedure TQueryForm.edDiamKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_Return
    then begin
      EnableBtn;
      Key:=0
    end
end;

procedure TQueryForm.btDiagramClick(Sender: TObject);
var i,j:integer;
    p:^Double;
    s:string;
    k:longint;
    diam:integer;
    kpovr:set of byte;
    CodeStr:string;
    strAttach:string;
begin
  ShortDateFormat := 'dd.mm.yy';
  longDateFormat := 'dd.mm.yy';
  diam:=-1;
  Year1:=StrToDate('01.01.'+seYear1.Text);
  Year2:=StrToDate('01.01.'+seYear2.Text);
  nYear1:=StrToInt(seYear1.Text);
  nYear2:=StrToInt(seYear2.Text);
  Num1:=StrToInt(seNum1.Text);
  Num2:=StrToInt(seNum2.Text);
  kPovr:=[];
  for i:=0 to chb_tzav.Count-1 do
    if chb_tzav.Checked[i] then
      kPovr:=kPovr+[integer(chb_tzav.Items.Objects[i])];
  sRange:=(Num2-Num1+1)/nRange;
  if sRange<1.0
    then exit;
  If DBL_Diam.Text<>'<пусто>' Then diam:=DM1.S_Diam_q.FieldByName('id').AsInteger;
  If DBL_ul1.Text<>'<пусто>' Then CodeStr:=Qry_ul1.FieldByName('id').AsString;
  strAttach:=' and (id_attach='+IntToStr(ord(OperateAttach))+')';
//  strAttach:='';

  Qry_Zavjav.SQL.Clear;
  Qry_Zavjav.SQL.Text:='select * from zavjav where (delz=0) and (fyear>='+seYear1.Text+' and fyear<='+seYear2.Text+') and (id_ul1='+CodeStr+') and (kod_ul=0)'+StrAttach;
  Qry_Zavjav.Open;
  if Changed
    then with Qry_Zavjav do
      begin
        for i:=0 to nYear-1 do
          for j:=0 to nRange-1 do
            Count^[i*nRange+j]:=0.0;
        _MinValue:=0; _MaxValue:=0;
//        SetRange([IntToStr(StreetCode),'1'],[IntToStr(StreetCode),'1']);
        First;
        while not Eof do
          try
            if ((diam=-1) or (FieldByName('ID_DIAM').asInteger=diam)) and
               (FieldByName('ID_TZAV').asInteger in kpovr)
              then begin
                s:=Trim(FieldByName('id_Ul2').AsString);
                if s<>''
                  then begin
                    i:=1;
                    while (i<Length(s)) and (s[i] in ['0'..'9']) do inc(i);
                    if not (s[i] in ['0'..'9'])
                      then SetLength(s,i-1);
                    j:=trunc((StrToInt(Trim(s))-Num1)/sRange);
                    if (j<nRange) and (j>=0)
                      then begin
{
                        s:=DateToStr(FieldByName('DT_IN').asDateTime-Year1);
                        i:=pos('.',s);
                        while i<>0 do
                          begin
                            System.Delete(s,1,i);
                            i:=pos('.',s);
                          end;
                        i:=StrToInt(Trim(s));
}
                        i:=FieldByName('FYear').asInteger-seYear1.Value;
                        if (i<nYear) and (i>=0)
                          then begin
                            k:=(i*nRange+j)*sizeof(double);
                            p:=Pointer(Longint(Count)+k);
                            p^:=p^+1.0;
                            if p^>_MaxValue
                              then _MaxValue:=p^;
                          end
                      end
                  end;
              end;
            Next
          except
            Next;
            Continue
          end
      end;
   //создание формы с диаграммой
   Graph:=TGraph.Create(Self);
   Graph.Caption:=DBL_ul1.Text;
   Graph.ShowModal;
   Changed:=False;
   Qry_Zavjav.Close;
end;

procedure TQueryForm.FormCreate(Sender: TObject);
var Year, Month, Day : Word;
begin
  inherited;
  GetMem(Count,nRange*nYear*sizeof(Double));
  DM1.S_Diam_q.Active:=True;
  Qry_ul1.Active:=True;
  DecodeDate(Date, Year, Month, Day);
  seYear2.Value:=Year;
  If (seYear2.Value-seYear1.Value)>9 Then seYear1.Value:=seYear2.Value-9;
  FillTZavList;
end;

procedure TQueryForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
  DM1.S_Diam_q.Active:=FAlse;
  Qry_ul1.Active:=False;
  FreeMem(Count,nRange*nYear*sizeof(Double));
  ShortDateFormat := 'dd.mm.yyyy';
  longDateFormat := 'dd.mm.yyyy';
end;

procedure TQueryForm.Changing(Sender: TObject);
begin
  Changed:=True;
  EnableBtn
end;

procedure TQueryForm.rbGraphClick(Sender: TObject);
begin
  gbGraph.Tag:=TRadioButton(Sender).Tag;
  EnableBtn
end;

procedure TQueryForm.dblStreetExit(Sender: TObject);
begin
  DBL_ul1.Color:=Old_Col;
  EnableBtn;
end;

procedure TQueryForm.BitBtn1Click(Sender: TObject);
begin
 Close;
end;

procedure TQueryForm.dblStreetEnter(Sender: TObject);
begin
  inherited;
  DBL_ul1.Color:=New_Col;
end;

procedure TQueryForm.seYear1Enter(Sender: TObject);
begin
  inherited;
  seYear1.Color:=New_Col;
end;

procedure TQueryForm.seYear1Exit(Sender: TObject);
begin
  inherited;
  seYear1.Color:=Old_Col;
  If (seYear2.Value-seYear1.Value)>9 Then seYear1.Value:=seYear2.Value-9;
end;

procedure TQueryForm.seYear2Exit(Sender: TObject);
begin
  inherited;
  seYear2.Color:=OLD_Col;
  If (seYear2.Value-seYear1.Value)>9 Then seYear1.Value:=seYear2.Value-9;
end;

procedure TQueryForm.seYear2Enter(Sender: TObject);
begin
  inherited;
  seYear2.Color:=New_Col;
end;

procedure TQueryForm.seNum1Enter(Sender: TObject);
begin
  inherited;
  seNum1.Color:=New_Col;
end;

procedure TQueryForm.seNum1Exit(Sender: TObject);
begin
  inherited;
  seNum1.Color:=OLD_Col;
end;

procedure TQueryForm.seNum2Exit(Sender: TObject);
begin
  inherited;
  seNum2.Color:=OLD_Col;
end;

procedure TQueryForm.seNum2Enter(Sender: TObject);
begin
  inherited;
  seNum2.Color:=New_Col;
end;

procedure TQueryForm.rbDinamExit(Sender: TObject);
begin
  inherited;
  rbDinam.Color:=OLD_Col;
end;

procedure TQueryForm.rbDinamEnter(Sender: TObject);
begin
  inherited;
  rbDinam.Color:=New_Col;
end;

procedure TQueryForm.rbMatrixEnter(Sender: TObject);
begin
  inherited;
  rbMatrix.Color:=New_Col;
end;

procedure TQueryForm.rbMatrixExit(Sender: TObject);
begin
  inherited;
  rbMatrix.Color:=OLD_Col;
end;

procedure TQueryForm.rbAddEnter(Sender: TObject);
begin
  inherited;
  rbAdd.Color:=New_Col;
end;

procedure TQueryForm.rbAddExit(Sender: TObject);
begin
  inherited;
  rbAdd.Color:=Old_Col;
end;

procedure TQueryForm.edDiamEnter(Sender: TObject);
begin
  inherited;
  DBL_Diam.Color:=New_Col;
end;

procedure TQueryForm.edDiamExit(Sender: TObject);
begin
  inherited;
  DBL_Diam.Color:=OLD_Col;
end;

procedure TQueryForm.edDiamchange(Sender: TObject);
begin
  inherited;
  Changed:=True;
end;

procedure TQueryForm.FillTZavList;
var
  i: integer;
begin
  chb_tzav.Clear;

  with Qry_zavjav do
  begin
    Close;
    SQL.Clear;
    SQL.Text:='select id, name_r from s_tzav where (del=''-'') and (id>0) order by name_r';
    Open;

    First;
    while not Eof do
    begin
      chb_tzav.AddItem(FieldByName('name_r').AsString, ptr(FieldByName('id').AsInteger));
      Next;
    end;
    Close;
  end;

  for i:=0 to chb_tzav.Count-1 do
    chb_tzav.Checked[i]:=true;
end;

end.
