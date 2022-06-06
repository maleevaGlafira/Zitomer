unit gr_set;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Spin, Series, fd_grf;

type
  TForm_grset = class(TForm)
    SpEd_Width: TSpinEdit;
    Label1: TLabel;
    ChB_3D: TCheckBox;
    ChB_Patt: TCheckBox;
    CmB_St: TComboBox;
    BB_Ok: TBitBtn;
    BB_Cn: TBitBtn;
    procedure BB_OkClick(Sender: TObject);
    procedure BB_CnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ChB_3DClick(Sender: TObject);
    procedure SpEd_WidthChange(Sender: TObject);
    procedure ChB_PattClick(Sender: TObject);
    procedure CmB_StChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    tmpWidth:integer;
    tmpLineStyle:TPenStyle;
    tmpis3D,tmpisPattern:boolean;
    tmpPattern:TBrushStyle;
    SerType:integer;
  end;    // TBrush bsFDiagonal tpen;

var
  Form_grset: TForm_grset;

implementation

{$R *.DFM}

procedure TForm_grset.BB_OkClick(Sender: TObject);
begin
 Close;
end;

procedure TForm_grset.BB_CnClick(Sender: TObject);
begin
 with GrafFForm do
  begin
   DBChartFed1.View3D:=tmpis3D;
   if SerType=0 then
     with DBChartFed1.Series[ChLtB_VibSer.ItemIndex] as TLineSeries do
      begin
        LinePen.Width:=tmpWidth;
        LinePen.Style:=tmpLineStyle;
      end
   else if SerType=1 then
      with DBChartFed1.Series[ChLtB_VibSer.ItemIndex] as TBarSeries do
      begin
        BarPen.Width:=tmpWidth;
        BarBrush.Style:=tmpPattern;
      end
   else if SerType=2 then
      with DBChartFed1.Series[ChLtB_VibSer.ItemIndex] as TPieSeries do
      begin
        PiePen.Width:=tmpWidth;
        UsePatterns:=tmpisPattern;
      end;
  end;
  Close;
end;

procedure TForm_grset.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TForm_grset.FormCreate(Sender: TObject);
begin
 with GrafFForm do
  begin
    SerType:=0;
    tmpisPattern:=false;
    tmpis3D:=DBChartFed1.View3D;
    ChB_3D.Checked:=tmpis3D;
    if SpB_Line.Down then
       with DBChartFed1.Series[ChLtB_VibSer.ItemIndex] as TLineSeries do
        begin
         tmpWidth:=LinePen.Width;
         tmpLineStyle:=LinePen.Style;
         ChB_Patt.Caption:='Расш.линии';
         CmB_st.Items.Add('--  --  --  --');
         CmB_st.Items.Add('.  .  .  .  . ');
         CmB_st.Items.Add('-- . -- . -- .');
         CmB_st.Items.Add('-- . . -- . . ');
         if tmpLineStyle=psSolid then
            tmpisPattern:=false
         else
            //tmpisPattern:=true;
            begin
            tmpisPattern:=true;
            case tmpLineStyle of
              psDash:CmB_St.ItemIndex:=0;
              psDot:CmB_St.ItemIndex:=1;
              psDashDot:CmB_St.ItemIndex:=2;
              psDashDotDot:CmB_St.ItemIndex:=3;
              psInsideFrame:CmB_St.ItemIndex:=4;
            end;
           end;
        end
    else if SpB_Bar.Down then
       with DBChartFed1.Series[ChLtB_VibSer.ItemIndex] as TBarSeries do
        begin
         SerType:=1;
         tmpWidth:=BarPen.Width;
         tmpPattern:=BarBrush.Style;
         CmB_st.Items.Add('Диагональ /');
         CmB_st.Items.Add('Диагональ \');
         CmB_st.Items.Add('Пересечение');
         CmB_st.Items.Add('Диаг. пересечение');
         CmB_st.Items.Add('Горизонталь');
         CmB_st.Items.Add('Вертикаль');

         if tmpPattern=bsSolid then
            tmpisPattern:=false
         else
           begin
            tmpisPattern:=true;
            case tmpPattern of
              bsBDiagonal:CmB_St.ItemIndex:=0;
              bsFDiagonal:CmB_St.ItemIndex:=1;
              bsCross:    CmB_St.ItemIndex:=2;
              bsDiagCross:CmB_St.ItemIndex:=3;
              bsHorizontal:CmB_St.ItemIndex:=4;
              bsVertical:CmB_St.ItemIndex:=5;
            end;
           end;
        end
    else if SpB_Pie.Down then
       with DBChartFed1.Series[ChLtB_VibSer.ItemIndex] as TPieSeries do
        begin
         SerType:=2;
         tmpWidth:=PiePen.Width;
         tmpisPattern:=UsePatterns;
        end;

    SpEd_Width.Value:=tmpWidth;
    ChB_Patt.Checked:=tmpisPattern;
    CmB_St.Enabled:=tmpisPattern; // and ChB_Patt.Enabled;
    {if CmB_St.Enabled then
     begin
        case tmpPattern of
          bsBDiagonal:CmB_St.ItemIndex:=0;
          bsFDiagonal:CmB_St.ItemIndex:=1;
          bsCross:    CmB_St.ItemIndex:=2;
          bsDiagCross:CmB_St.ItemIndex:=3;
          bsHorizontal:CmB_St.ItemIndex:=4;
          bsVertical:CmB_St.ItemIndex:=5;
        end;
     end;}
  end;
end;

{
bsSolid		2 bsCross
bsClear		3 bsDiagCross
0 bsBDiagonal /	4 bsHorizontal
1 bsFDiagonal \	5 bsVertical

psSolid
psDash	        0 -----
psDot	        1 .....
psDashDot	2 -.-.-
psDashDotDot	3 -..-.
psClear	No line  is drawn (used to omit the line around shapes that draw an outline using the current pen).
psInsideFrame	4 A solid line, but one that may use a dithered color if Width is greater than 1.




}
procedure TForm_grset.ChB_3DClick(Sender: TObject);
begin
 GrafFForm.DBChartFed1.View3D:=ChB_3D.Checked;
end;

procedure TForm_grset.SpEd_WidthChange(Sender: TObject);
begin
with GrafFForm do
  begin
   if SerType=0 then
     with DBChartFed1.Series[ChLtB_VibSer.ItemIndex] as TLineSeries do
      begin
        LinePen.Width:=SpEd_Width.Value;
      end
   else if SerType=1 then
      with DBChartFed1.Series[ChLtB_VibSer.ItemIndex] as TBarSeries do
      begin
        BarPen.Width:=SpEd_Width.Value;
      end
   else if SerType=2 then
      with DBChartFed1.Series[ChLtB_VibSer.ItemIndex] as TPieSeries do
      begin
        PiePen.Width:=SpEd_Width.Value;
      end;
  end;
end;

procedure TForm_grset.ChB_PattClick(Sender: TObject);
begin
  CmB_St.Enabled:=false;
  with GrafFForm do
  begin
   if SerType=0 then
      with DBChartFed1.Series[ChLtB_VibSer.ItemIndex] as TLineSeries do
      begin
        CmB_St.Enabled:=ChB_Patt.Checked;
        if ChB_Patt.Checked then
          begin
           LinePen.Style:=psDash;
           CmB_St.ItemIndex:=0;
          end
        else
           LinePen.Style:=psSolid;
      end
   else if SerType=1 then
      with DBChartFed1.Series[ChLtB_VibSer.ItemIndex] as TBarSeries do
      begin
        CmB_St.Enabled:=ChB_Patt.Checked;
        if ChB_Patt.Checked then
          begin
           BarBrush.Style:=bsBDiagonal;
           CmB_St.ItemIndex:=0;
          end
        else
           BarBrush.Style:=bsSolid;
      end
   else if SerType=2 then
      with DBChartFed1.Series[ChLtB_VibSer.ItemIndex] as TPieSeries do
      begin
        UsePatterns:=ChB_Patt.Checked;
      end;
  end;

end;

procedure TForm_grset.CmB_StChange(Sender: TObject);
begin
with GrafFForm do
 begin
  if SerType=0 then
   begin
    with DBChartFed1.Series[ChLtB_VibSer.ItemIndex] as TLineSeries do
      begin
        case CmB_St.ItemIndex of
          0:LinePen.Style:=psDash;
          1:LinePen.Style:=psDot;
          2:LinePen.Style:=psDashDot;
          3:LinePen.Style:=psDashDotDot;
          4:LinePen.Style:=psInsideFrame;
        end;
      end;
   end
  else if SerType=1 then
   begin
    with DBChartFed1.Series[ChLtB_VibSer.ItemIndex] as TBarSeries do
      begin
        case CmB_St.ItemIndex of
          0:BarBrush.Style:=bsBDiagonal;
          1:BarBrush.Style:=bsFDiagonal;
          2:BarBrush.Style:=bsCross;
          3:BarBrush.Style:=bsDiagCross;
          4:BarBrush.Style:=bsHorizontal;
          5:BarBrush.Style:=bsVertical;
        end;
      end;
   end;
 end;
end;

end.
