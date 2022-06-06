unit gr_axis;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  fd_grf, Buttons, StdCtrls, Spin;

type
  TForm_Axis = class(TForm)
    Gr_Axis: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ChB_YAxis: TCheckBox;
    SpEd_Yc: TSpinEdit;
    SpEd_Ypo: TSpinEdit;
    ChB_XAxis: TCheckBox;
    SpEd_Xpo: TSpinEdit;
    SpEd_Xc: TSpinEdit;
    ChB_Grid: TCheckBox;
    BB_Cn: TBitBtn;
    BB_Ok: TBitBtn;
    GrB_Font: TGroupBox;
    SpEd_dlm: TSpinEdit;
    Label5: TLabel;
    Label6: TLabel;
    SpEd_tit: TSpinEdit;
    SpEd_LbSz: TSpinEdit;
    SpB_met: TSpeedButton;
    SpB_pod: TSpeedButton;
    Label4: TLabel;
    Label7: TLabel;
    FontDialog1: TFontDialog;
    GB_Title: TGroupBox;
    Ed_Title: TEdit;
    SpB_Tit: TSpeedButton;
    BB_Color: TBitBtn;
    ColorDialog1: TColorDialog;
    procedure FormCreate(Sender: TObject);
    procedure ChB_XAxisClick(Sender: TObject);
    procedure ChB_YAxisClick(Sender: TObject);
    procedure ChB_GridClick(Sender: TObject);
    procedure SpEd_XcChange(Sender: TObject);
    procedure SpEd_XpoChange(Sender: TObject);
    procedure SpEd_YcChange(Sender: TObject);
    procedure SpEd_YpoChange(Sender: TObject);
    procedure BB_OkClick(Sender: TObject);
    procedure BB_CnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpEd_dlmChange(Sender: TObject);
    procedure SpEd_titChange(Sender: TObject);
    procedure SpEd_LbSzChange(Sender: TObject);
    procedure SpB_metClick(Sender: TObject);
    procedure SpB_podClick(Sender: TObject);
    procedure SpB_TitClick(Sender: TObject);
    procedure Ed_TitleChange(Sender: TObject);
    procedure BB_ColorClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    isYAvt,isXAvt:boolean;
    Xmin,Xmax,Ymin,Ymax:double;
    Met_f,Tit_f,ATit_f:TFont;
    xTitle:string;
    Lb_sz:integer;
    ACol:TColor;
    procedure ChngYAxis;
    procedure ChngXAxis;
  end;

var
  Form_Axis: TForm_Axis;

implementation

{$R *.DFM}





procedure TForm_Axis.FormCreate(Sender: TObject);
begin
  Form_Axis:=Self;
  with GrafFForm do
  begin
    Met_f:=TFont.Create;
    Tit_f:=TFont.Create;
    ATit_f:=TFont.Create;
    SpEd_dlm.Value:=DBChartFed1.BottomAxis.LabelsFont.Size;
    SpEd_tit.Value:=DBChartFed1.BottomAxis.Title.Font.Size;
    SpEd_LbSz.Value:=DBChartFed1.LeftAxis.LabelsSize;
    Met_f.Assign(DBChartFed1.BottomAxis.LabelsFont);
    Tit_f.Assign(DBChartFed1.BottomAxis.Title.Font);
    ATit_f.Assign(DBChartFed1.Title.Font);
    xTitle:=DBChartFed1.Title.Text.Strings[0];
    Lb_sz:=SpEd_LbSz.Value;
    ACol:=DBChartFed1.Color;
    Ed_Title.Text:=GrafFForm.DBChartFed1.Title.Text.Strings[0];

    ChB_Grid.Checked:=GrafFForm.DBChartFed1.BottomAxis.Grid.Visible;
    isYAvt:=DBChartFed1.LeftAxis.Automatic;
    isXAvt:=DBChartFed1.BottomAxis.Automatic;

    ChB_YAxis.Checked:=DBChartFed1.LeftAxis.Automatic;
    ChB_XAxis.Checked:=DBChartFed1.BottomAxis.Automatic;
    SpEd_Yc.Value:=round(DBChartFed1.LeftAxis.Minimum);
    SpEd_Ypo.Value:=round(DBChartFed1.LeftAxis.Maximum);
    SpEd_Xc.Value:=round(DBChartFed1.BottomAxis.Minimum);
    SpEd_Xpo.Value:=round(DBChartFed1.BottomAxis.Maximum);

    Ymin:=SpEd_Yc.Value;
    Ymax:=SpEd_Ypo.Value;
    Xmin:=SpEd_Xc.Value;
    Xmax:=SpEd_Xpo.Value;

    ChngYAxis;
    ChngXAxis;
  end;
end;

procedure TForm_Axis.ChngYAxis;
begin
  SpEd_Yc.Enabled:=not ChB_YAxis.Checked;
  SpEd_Ypo.Enabled:=not ChB_YAxis.Checked;
end;

procedure TForm_Axis.ChngXAxis;
begin
  SpEd_Xc.Enabled:=not ChB_XAxis.Checked;
  SpEd_Xpo.Enabled:=not ChB_XAxis.Checked;
end;


procedure TForm_Axis.ChB_XAxisClick(Sender: TObject);
begin
with GrafFForm do
 begin
  ChngXAxis;
  if ChB_XAxis.Checked then
    begin
      SpEd_Xc.Value:=round(DBChartFed1.BottomAxis.Minimum);
      SpEd_Xpo.Value:=round(DBChartFed1.BottomAxis.Maximum);
    end;
  DBChartFed1.BottomAxis.Automatic:=ChB_XAxis.Checked;
 end;
end;

procedure TForm_Axis.ChB_YAxisClick(Sender: TObject);
begin
with GrafFForm do
 begin
  ChngYAxis;
  if ChB_YAxis.Checked then
    begin
      SpEd_Yc.Value:=round(DBChartFed1.LeftAxis.Minimum);
      SpEd_Ypo.Value:=round(DBChartFed1.LeftAxis.Maximum);
    end;
  DBChartFed1.LeftAxis.Automatic:=ChB_YAxis.Checked;
 end;
end;

procedure TForm_Axis.ChB_GridClick(Sender: TObject);
begin
  GrafFForm.DBChartFed1.BottomAxis.Grid.Visible:=ChB_Grid.Checked;
  GrafFForm.DBChartFed1.LeftAxis.Grid.Visible:=ChB_Grid.Checked;
end;

procedure TForm_Axis.SpEd_XcChange(Sender: TObject);
begin
   GrafFForm.DBChartFed1.BottomAxis.Minimum:=SpEd_Xc.Value;
end;

procedure TForm_Axis.SpEd_XpoChange(Sender: TObject);
begin
  GrafFForm.DBChartFed1.BottomAxis.Maximum:=SpEd_Xpo.Value;
end;

procedure TForm_Axis.SpEd_YcChange(Sender: TObject);
begin
  GrafFForm.DBChartFed1.LeftAxis.Minimum:=SpEd_Yc.Value;
end;

procedure TForm_Axis.SpEd_YpoChange(Sender: TObject);
begin
  GrafFForm.DBChartFed1.LeftAxis.Maximum:=SpEd_Ypo.Value;
end;

procedure TForm_Axis.BB_OkClick(Sender: TObject);
begin
  Close;
end;

procedure TForm_Axis.BB_CnClick(Sender: TObject);
begin
with GrafFForm do
begin
 DBChartFed1.BottomAxis.LabelsFont.Assign(Met_f);
 DBChartFed1.BottomAxis.Title.Font.Assign(Tit_f);
 DBChartFed1.LeftAxis.LabelsFont.Assign(Met_f);
 DBChartFed1.LeftAxis.Title.Font.Assign(Tit_f);
 DBChartFed1.Title.Font.Assign(ATit_f);
 DBChartFed1.Title.Text.Strings[0]:=xTitle;
 DBChartFed1.LeftAxis.LabelsSize:=Lb_sz;
 DBChartFed1.Color:=ACol;
 DBChartFed1.LeftAxis.Automatic:=isYAvt;
 DBChartFed1.BottomAxis.Automatic:=isXAvt;
 if not isYAvt then
   begin
    DBChartFed1.LeftAxis.Minimum:=Ymin;
    DBChartFed1.LeftAxis.Maximum:=Ymax;
   end;
 if not isXAvt then
   begin
    DBChartFed1.BottomAxis.Minimum:=Xmin;
    DBChartFed1.BottomAxis.Maximum:=Xmax;
   end;
end;
 Close;
end;

procedure TForm_Axis.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Met_f.Free;
  Tit_f.Free;
  Action:=caFree;
end;

procedure TForm_Axis.SpEd_dlmChange(Sender: TObject);
begin
   GrafFForm.DBChartFed1.BottomAxis.LabelsFont.Size:=SpEd_dlm.Value;
   GrafFForm.DBChartFed1.LeftAxis.LabelsFont.Size:=SpEd_dlm.Value;
end;

procedure TForm_Axis.SpEd_titChange(Sender: TObject);
begin
   GrafFForm.DBChartFed1.BottomAxis.Title.Font.Size:=SpEd_tit.Value;
   GrafFForm.DBChartFed1.LeftAxis.Title.Font.Size:=SpEd_tit.Value;
end;

procedure TForm_Axis.SpEd_LbSzChange(Sender: TObject);
begin
   GrafFForm.DBChartFed1.BottomAxis.LabelsSize:=SpEd_LbSz.Value;
   GrafFForm.DBChartFed1.LeftAxis.LabelsSize:=SpEd_LbSz.Value;
end;

procedure TForm_Axis.SpB_metClick(Sender: TObject);
begin
 FontDialog1.Font.Assign(GrafFForm.DBChartFed1.BottomAxis.LabelsFont);
 FontDialog1.Execute;
 GrafFForm.DBChartFed1.BottomAxis.LabelsFont.Assign(FontDialog1.Font);
 GrafFForm.DBChartFed1.LeftAxis.LabelsFont.Assign(FontDialog1.Font);
end;

procedure TForm_Axis.SpB_podClick(Sender: TObject);
begin
 FontDialog1.Font.Assign(GrafFForm.DBChartFed1.BottomAxis.Title.Font);
 FontDialog1.Execute;
 GrafFForm.DBChartFed1.BottomAxis.Title.Font.Assign(FontDialog1.Font);
 GrafFForm.DBChartFed1.LeftAxis.Title.Font.Assign(FontDialog1.Font);
end;

procedure TForm_Axis.SpB_TitClick(Sender: TObject);
begin
 FontDialog1.Font.Assign(GrafFForm.DBChartFed1.Title.Font);
 FontDialog1.Execute;
 GrafFForm.DBChartFed1.Title.Font.Assign(FontDialog1.Font);
end;

procedure TForm_Axis.Ed_TitleChange(Sender: TObject);
begin
  GrafFForm.DBChartFed1.Title.Text.Strings[0]:=Ed_Title.Text;
  GrafFForm.DBChartFed1.Title.Repaint;
end;

procedure TForm_Axis.BB_ColorClick(Sender: TObject);
begin
 ColorDialog1.Color:=GrafFForm.DBChartFed1.Color;
 ColorDialog1.Execute;
 GrafFForm.DBChartFed1.Color:=ColorDialog1.Color;
end;

end.
