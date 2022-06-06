unit Fd_grf;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, TeeProcs, TeEngine, Chart, DBChart, StdCtrls, Buttons, Db,
  DBTables, Series, RXCtrls, Spin, Menus;

type
  TGrafFForm = class(TForm)
    DBChartFed1: TDBChart;
    Tb_res: TTable;
    Tb_set: TTable;
    Db_graf: TDatabase;
    PM_Set: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    ClrDlg: TColorDialog;
    GrB_Cont: TGroupBox;
    SpB_Line: TSpeedButton;
    SpB_Bar: TSpeedButton;
    SpB_Pie: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ChLtB_VibSer: TRxCheckListBox;
    ChB_Marks: TCheckBox;
    ChB_Legend: TCheckBox;
    BB_Close: TBitBtn;
    BB_Axis: TBitBtn;
    BB_Print: TBitBtn;
    N3: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BB_CloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ChLtB_VibSerClickCheck(Sender: TObject);
    procedure ChB_MarksClick(Sender: TObject);
    procedure ChB_LegendClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure BB_AxisClick(Sender: TObject);
    procedure SpB_LineClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure BB_PrintClick(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure PM_SetPopup(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    SerCount:integer;
    TmpSer:array [0..19] of TChartSeries;
//    class function MyCreate(DbP:string): TForm;
    constructor GrCreate(AOwner: TComponent;DbP:string);
    procedure CreateSeries(SerType,NumSer:integer);
    procedure ReChart;
    procedure ChartRedraw;
  end;

function FindAlias(AlName:string):string;
function CreateRes(cr_Path:string;CounField:integer):boolean;
function AddSet(DbPath,Name,Tit:string):boolean;
function AddRes(DbPath:string;Values: array of const):boolean;
var
  GrafFForm: TGrafFForm;
  DbPath:string;

implementation
uses gr_set,gr_axis,gr_print;
{$R *.DFM}

constructor TGrafFForm.GrCreate(AOwner: TComponent;DbP:string);
begin
  DbPath:=DbP;
  inherited Create(AOwner);
//  DbPath:=DbP;
end;

procedure TGrafFForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action:=caFree;
end;

procedure TGrafFForm.BB_CloseClick(Sender: TObject);
begin
{for i:=0 to DBChartFed1.SeriesCount-1 do
     DBChartFed1.Series[i].Active:=false;

DBChartFed1.RemoveAllSeries;

for i:=0 to SerCount do
    begin
     if TmpSer[i]<>nil then
        TmpSer[i].Free;
    end;}
  Tb_set.Close;
  Tb_res.Close;
  Db_graf.Connected:=false;
  Close;
end;

procedure TGrafFForm.FormCreate(Sender: TObject);
var //MyStringList:TStringList;
    //i:integer;
    tut_path:string;
    isWorking:boolean;
begin
  GrafFForm:=Self;
  tut_path:=FindAlias(DbPath);
  {CreateRes(tut_path,3);
  AddSet(tut_path,'Name','Yes');
  AddRes(tut_path,[1,'Name',2,3,4]);}
  isWorking:=true;
  Db_graf.Params.Strings[0]:='PATH='+tut_path;
{  MyStringList := TStringList.Create;
  Session.GetAliasNames(MyStringList); //список алиасов
  i:=MyStringList.indexof(DbPath);
  if i>=0 then
   begin
    Session.GetAliasParams(DbPath, MyStringList);
    tut_path := MyStringList.Values['PATH'];
    Db_graf.Params.Strings[0]:='PATH='+tut_path;
   end
  else
   begin
    Db_graf.Params.Strings[0]:='PATH='+DbPath;
   end;}
   try
     Db_graf.Connected:=true;
   except
     isWorking:=false;
     MessageDlg('Неправильный путь или алиас:'+DbPath, mtError,
      [mbOk], 0);
   end;
   if IsWorking then
     begin
       try
         Tb_res.Open;
         Tb_res.Close;
       except
         isWorking:=false;
         MessageDlg('Ошибка открытия файла tb_res.db, алиас:'+DbPath, mtError,
         [mbOk], 0);
       end;
     end;
   if IsWorking then
     begin
       try
         Tb_set.Open;
         Tb_set.Close;
       except
         isWorking:=false;
         MessageDlg('Ошибка открытия файла tb_set.db, алиас:'+DbPath, mtError,
         [mbOk], 0);
       end;
     end;
   if IsWorking then
    begin
     Tb_res.Open;
     SerCount:=Tb_res.FieldCount-3;
     if SerCount>19 then
        SerCount:=19;
     Tb_res.Close;
     Tb_set.Open;
     if not (SerCount>=0) then
      { begin
        if (Tb_set.RecordCount-1)<>SerCount then
         begin
           isWorking:=false;
           MessageDlg('Несоответствие файлов gr_res.db и gr_set.db', mtError,
                     [mbOk], 0);
         end;
       end
     else}
       begin
         isWorking:=false;
         MessageDlg('Неправильный файл gr_res.db', mtError,
                   [mbOk], 0);
       end;
    end;
   if isWorking then
      ReChart
   else
      BB_CloseClick(Self);

end;
procedure TGrafFForm.CreateSeries(SerType,NumSer:integer);
var i:integer;
    isLabel:boolean;
begin
  isLabel:=false;
  ChLtB_VibSer.Items.Clear;
  ChLtB_VibSer.CheckKind:=ckCheckBoxes;
  for i:=0 to DBChartFed1.SeriesCount-1 do
     DBChartFed1.Series[i].Active:=false;
  DBChartFed1.RemoveAllSeries;
  for i:=0 to SerCount do
    begin
     if TmpSer[i]<>nil then
        TmpSer[i].Free;
    end;
  Tb_set.Open;
  DBChartFed1.Title.Text.Clear;
  if Tb_set.Locate('F_Name','GR_LABEL',[loCaseInsensitive]) then
    begin
      isLabel:=true;
      DBChartFed1.Title.Text.Add(Tb_Set.FieldByName('TITLE').AsString);
    end
  else if Tb_set.Locate('F_Name','GR_VALUE',[loCaseInsensitive]) then
      DBChartFed1.Title.Text.Add(Tb_Set.FieldByName('TITLE').AsString)
  else
      DBChartFed1.Title.Text.Add('График');

  if Tb_set.Locate('F_Name','X_AXIS',[loCaseInsensitive]) then
    begin
      DBChartFed1.BottomAxis.Title.Caption:=Tb_Set.FieldByName('TITLE').AsString;
    end;
  if Tb_set.Locate('F_Name','Y_AXIS',[loCaseInsensitive]) then
    begin
      DBChartFed1.LeftAxis.Title.Caption:=Tb_Set.FieldByName('TITLE').AsString;
    end;

  for i:=0 to NumSer do
    begin
     case SerType of
        1:TmpSer[i]:=TBarSeries.Create(Self);
        2:TmpSer[i]:=TPieSeries.Create(Self);
     else
        TmpSer[i]:=TLineSeries.Create(Self);
     end;

     TmpSer[i].ParentChart:=DBChartFed1;
     TmpSer[i].DataSource:=tb_res;
     if isLabel then
        TmpSer[i].XLabelsSource:='NAZV';

     TmpSer[i].YValues.ValueSource := 'POLE'+IntToStr(i) ;
     TmpSer[i].XValues.ValueSource := 'NOMER';
     if Tb_set.Locate('F_Name',TmpSer[i].YValues.ValueSource,[loCaseInsensitive]) then
      begin
        TmpSer[i].Title:=Tb_Set.FieldByName('TITLE').AsString;
      end
     else
        TmpSer[i].Title:= 'POLE'+IntToStr(i) ;
     

     TmpSer[i].Marks.Visible:=ChB_Marks.Checked;
     TmpSer[i].Marks.Style:=smsValue;
     ChLtB_VibSer.Items.Add(TmpSer[i].Title);
     if (i=0) or (SerType<>2) then
        ChLtB_VibSer.Checked[ChLtB_VibSer.Items.Count-1]:=true;


   end;
   if SerType=2 then
     begin
      ChLtB_VibSer.CheckKind:=ckRadioButtons;
      DBChartFed1.BottomAxis.Visible:=false;
      DBChartFed1.LeftAxis.Visible:=false;
     end
   else
     begin
      ChLtB_VibSer.CheckKind:=ckCheckBoxes;
      DBChartFed1.BottomAxis.Visible:=true;
      DBChartFed1.LeftAxis.Visible:=true;
     end;

   {for i:=0 to SerCount do
     DBChartFed1.Series[i].Active:=true;}
   ChLtB_VibSer.ItemIndex:=0;
   Tb_set.Close;
//   ChB_GridClick(Self);
   ChartRedraw;
end;
procedure TGrafFForm.ReChart;

begin
  Tb_res.Close;
{  if RB_Line.Checked then
     CreateSeries(0,SerCount)
  else if RB_Bar.Checked then
     CreateSeries(1,SerCount)
  else if RB_Pie.Checked then
     CreateSeries(2,SerCount);}
  if SpB_Line.Down then
     CreateSeries(0,SerCount)
  else if SpB_Bar.Down then
     CreateSeries(1,SerCount)
  else if SpB_Pie.Down then
     CreateSeries(2,SerCount);
  Tb_res.Open;
  DBChartFed1.Update;
end;
procedure TGrafFForm.ChLtB_VibSerClickCheck(Sender: TObject);
begin
  ChartRedraw;
end;

procedure TGrafFForm.ChartRedraw;
var i:integer;
begin
  for i:=0 to DBChartFed1.SeriesCount-1 do
     DBChartFed1.Series[i].Active:=ChLtB_VibSer.Checked[i];
  DBChartFed1.Update;
end;
procedure TGrafFForm.ChB_MarksClick(Sender: TObject);
var i:integer;
begin
  for i:=0 to DBChartFed1.SeriesCount-1 do
     DBChartFed1.Series[i].Marks.Visible:=ChB_Marks.Checked;
end;

function CreateRes(cr_Path:string;CounField:integer):boolean;
var res1,res2:boolean;
    i:integer;
    //tt_str:string;
    Tb_tmpSt:Ttable;
begin
    {BaseWorking:=false;
    ZvonForm.Label4.Caption:='ВОССТАНОВЛЕНИЕ ИНДЕКСОВ...';
    ZvonForm.Label4.Update;}
    res1:=true;
    res2:=true;
    cr_Path:=FindAlias(cr_Path);
    Tb_tmpSt:=Ttable.Create(Nil);
    try
         with Tb_tmpSt do
         begin
           TableName := 'gr_res';
           TableType := ttParadox;
           databasename:=cr_path;
           with FieldDefs do
             begin
               Clear;
               Add('NOMER', ftFloat, 0, True);
               Add('NAZV', ftSTRING, 20, True);
               for i:=0 to CounField-1 do
                  Add('POLE'+IntToStr(i), ftFloat, 0, True);
             end;

           {with IndexDefs do
             begin
               Clear;
               Add('', 'C_STREET', [ixPrimary]);
               Add('IN_STREET', 'N_STREET', [ixCaseInsensitive]);
             end;}
           Tb_tmpSt.CreateTable;
           //Tb_tmpSt.indexname:='IN_STREET';
         end;
         Tb_tmpSt.Close;
       except
         res1:=False;
       end;
       Tb_tmpSt.Free;
       Tb_tmpSt:=Ttable.Create(Nil);

       try
         with Tb_tmpSt do
         begin
           TableName := 'gr_set';
           TableType := ttParadox;
           databasename:=cr_path;
           with FieldDefs do
             begin
               Clear;
               Add('F_NAME', ftString, 20, True);
               Add('TITLE', ftString, 30, True);
             end;

           {with IndexDefs do
             begin
               Clear;
               //Add('', 'ID_HOUSE', [ixPrimary]);
               Add('NAME', 'F_NAME', [ixCaseInsensitive]);
             end;}
           Tb_tmpSt.CreateTable;
           //Tb_tmpSt.indexname:='NAME';
         end;
         Tb_tmpSt.Close;
       except
         res2:=False;
       end;
       Tb_tmpSt.Free;
   Result:=res1 and res2;
end;

function AddSet(DbPath,Name,Tit:string):boolean;
var Tb_tmpRes:Ttable;
begin
  DbPath:=FindAlias(DbPath);
  Tb_tmpRes:=Ttable.Create(Nil);
  with Tb_tmpRes do
    begin
      TableName := 'gr_set';
      TableType := ttParadox;
      databasename:=DbPath;
      ReadOnly:=false;
    end;
  try
    Tb_tmpRes.Open;
    Tb_TmpRes.AppendRecord([Name,Tit]);
    Tb_TmpRes.Close;
    Result:=true;
  except
    Result:=False;
  end;
  Tb_TmpRes.Free;
end;

function AddRes(DbPath:string;Values: array of const):boolean;
var Tb_tmpRes:Ttable;
begin
  DbPath:=FindAlias(DbPath);
  Tb_tmpRes:=Ttable.Create(Nil);
  with Tb_tmpRes do
    begin
      TableName := 'gr_res';
      TableType := ttParadox;
      databasename:=DbPath;
      ReadOnly:=false;
    end;
  try
    Tb_tmpRes.Open;
    Tb_TmpRes.AppendRecord(Values);
    Tb_TmpRes.Close;
    Result:=true;
  except
    Result:=False;
  end;
  Tb_TmpRes.Free;
end;


function FindAlias(AlName:string):string;
var MyStringList:TStringList;
    i:integer;
begin
  MyStringList := TStringList.Create;
  Session.GetAliasNames(MyStringList); //список алиасов
  i:=MyStringList.indexof(AlName);
  if i>=0 then
   begin
    Session.GetAliasParams(AlName, MyStringList);
    Result:= MyStringList.Values['PATH'];
   end
  else
   begin
    Result:=AlName;
   end;
end;

procedure TGrafFForm.ChB_LegendClick(Sender: TObject);
begin
   DBChartFed1.Legend.Visible:=ChB_Legend.Checked;
end;

procedure TGrafFForm.N1Click(Sender: TObject);
begin
  ClrDlg.Color:=DBChartFed1.Series[ChLtB_VibSer.ItemIndex].SeriesColor;
  ClrDlg.Execute;
  DBChartFed1.Series[ChLtB_VibSer.ItemIndex].SeriesColor:=ClrDlg.Color;
end;

procedure TGrafFForm.N2Click(Sender: TObject);
var SetForm:TForm_grset;
begin
  SetForm:=TForm_grset.Create(Self);
  SetForm.ShowModal;

end;


procedure TGrafFForm.BB_AxisClick(Sender: TObject);
var AxForm:TForm_Axis;
begin
  AxForm:=TForm_Axis.Create(Self);
  AxForm.ShowModal;

end;




procedure TGrafFForm.SpB_LineClick(Sender: TObject);
begin
  if SpB_Line.Down then
     PM_Set.Items[1].Caption:='Ширина'
  else
     PM_Set.Items[1].Caption:='Стиль';
  ReChart;

end;





procedure TGrafFForm.FormResize(Sender: TObject);
begin
 GrB_Cont.Top:=GrafFForm.Height-GrB_Cont.Height-38;
 DBChartFed1.Top:=4;
 DBChartFed1.Left:=4;
 DBChartFed1.Height:=GrB_Cont.Top-11;
 DBChartFed1.Width:=GrafFForm.Width-16;

end;

procedure TGrafFForm.BB_PrintClick(Sender: TObject);
var PrForm:TFormGPrint;
begin
  PrForm:=TFormGPrint.Create(Self);
  PrForm.ShowModal;

end;

procedure TGrafFForm.N3Click(Sender: TObject);
begin
   N3.Checked:= not N3.Checked;
   DBChartFed1.Series[ChLtB_VibSer.ItemIndex].Marks.Visible:=N3.Checked;
//   DBChartFed1.Series[ChLtB_VibSer.ItemIndex].SeriesColor:=ClrDlg.Color;
end;

procedure TGrafFForm.PM_SetPopup(Sender: TObject);
begin
 PM_Set.Items[2].Checked:=DBChartFed1.Series[ChLtB_VibSer.ItemIndex].Marks.Visible;
end;

end.


(*
Описание файла GR_SET

поле F_NAME:

'GR_LABEL' - по оси Х метки
             название графика в поле TITLE
'GR_VALUE' - по оси Х значения
             название графика в поле TITLE
'X_AXIS'   - в поле TITLE: название оси X
'Y_AXIS'   - в поле TITLE: название оси Y
'POLE0'...'POLEn' - в поле TITLE: название
                    соответствующего графика
*)
