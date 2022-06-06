unit Prosm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Buttons, frmLANG, cntsLANG, ExtCtrls,FrPrintDM;

type
  TProsmForm = class(TFormLang)
    Memo1: TRichEdit;
    Panel1: TPanel;
    BB_Print: TBitBtn;
    BB_Close: TBitBtn;
    Panel2: TPanel;
    MarkPagePanel: TPanel;
    MarkPage80Label: TLabel;
    MarkPage136Label: TLabel;
    MarkPage136_2Label: TLabel;
    Panel3: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Panel4: TPanel;
    Label4: TLabel;
    CheckBox1: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BB_PrintClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);       //TGridRect
  private
    { Private declarations }
    Mas_Shir:array [0..49] of integer;
    Fm_Vis:TObject;
    FWidthCheck:TWidthCheck;
    procedure MakeSheet;
  public
    { Public declarations }
    Cols,Rows,noId:integer;
    constructor ProsmCreate(AOwner: TComponent; Frn:TObject);
    procedure ClearMas;
    procedure Translate;override;
    property WidthCheck:TWidthCheck read FWidthCheck write FWidthCheck;
  end;

var
  ProsmForm: TProsmForm;
  tFm_Vit:TObject;

  function IsThereITOGO(s:string):boolean;

implementation

uses fresult,grids,strtool,fm2pr,main;

{$R *.DFM}

procedure TProsmForm.MakeSheet;
//
function FindMaxShir(var _count_symb_max,_count_symb_max_before:integer):integer;
var ACol:integer;
  _l:integer;
begin
  result:=0;
  _l:=0;
  _count_symb_max:=0;
  _count_symb_max_before:=0;
  for ACol:=0 to TFormResult(Fm_Vis).StrGr_Res.ColCount-noId do
    begin
      if TFormResult(Fm_Vis).StrGr_Res.colwidths[ACol]>2 then
        begin
          _l:=mas_shir[ACol];
          if (_l>_count_symb_max) and (ACol>0) then
            begin
              _count_symb_max_before:=_count_symb_max;
              _count_symb_max:=_l;
              result:=ACol;
            end
              else
            begin
              if (_l>_count_symb_max_before) and (_l<_count_symb_max) and (ACol>0)
                then _count_symb_max_before:=_l;
            end;
        end;
    end;
end;
//
function CountObshShir:integer;
var ACol:integer;
begin
 {считаем общую ширину}
 result:=1;
 for ACol:=0 to TFormResult(Fm_Vis).StrGr_Res.ColCount-noId do
   begin
    if (TFormResult(Fm_Vis).StrGr_Res.colwidths[ACol])>2 then
       result:=result+mas_shir[ACol]+1;
   end;
end;
//
var ACol,Arow,Shir,_l,_i,_c_m,_c_m_b:integer;
    s,lin,s1:string;
    fl_vs:boolean;
    p:integer;
begin
  Memo1.Clear;
  ProsmForm:=Self;
  ClearMas;
  Cols:=0;
  Fm_Vis:=tFm_Vit; //Sender;
  if TFormResult(Fm_Vis).isIdView then
    noId:=1
  else
    noId:=2;

  {заполняет массив с шириной столбцов. При этом используется ширина
  самой широкой ячейки в столбце}
  for ARow:=0 to TFormResult(Fm_Vis).StrGr_Res.RowCount-1 do begin
   for ACol:=0 to TFormResult(Fm_Vis).StrGr_Res.ColCount-noId do
     begin
      if TFormResult(Fm_Vis).StrGr_Res.colwidths[ACol]>2 then
        begin
          shir:=length(TFormResult(Fm_Vis).StrGr_Res.cells[ACol,ARow]);
          if shir>mas_shir[ACol] then
             mas_shir[ACol]:=shir;
          //mas_shir[ACol]:=5;
        end;
     end;
    end;
 {считаем общую ширину}
  Shir:=CountObshShir;
  {теперь посмотрим, если у нас ограничение на ширину, например
  надо впихнуть на лист A4, то проверим это FWidthCheck=twcA4
  и }
  case FWidthCheck of
    twcA4:
      begin
        {посчитаем на сколько символов мы залазим за пределы строки}
        _l:=shir-A4_WIDTH;
        if (_l>0) then
          begin
            {надо найти два самых длинных слова. То которое длиннее, укоротить
            до размеров того, которое короче}
                _i:=FindMaxShir(_c_m,_c_m_b);
                While (_l>0) and (_c_m>3) do
                  begin
                    mas_shir[_i]:=_c_m_b;
                    Shir:=CountObshShir;
                    _l:=shir-A4_WIDTH;
                    _i:=FindMaxShir(_c_m,_c_m_b);
                  end;
                if _l<0 then
                  begin
                    mas_shir[_i]:=_c_m_b-_l;
                  end;
            //
          end;
      end;
  end;
//  Memo1.Lines.Add(Strip('B',' ',TFormResult(Fm_Vis).Lb_usl.Caption));
  Memo1.Lines.Add(FormatMemo(RepChar('.','/',Upper(TFormResult(Fm_Vis).Lb_usl.Caption)),shir));
  Cols:=Shir;
  lin:=FillStr(shir,'-');
  Memo1.Lines.Add(lin);
  fl_vs:=true;
  for ARow:=0 to TFormResult(Fm_Vis).StrGr_Res.RowCount-1 do
   begin
    s:='|';
  for ACol:=0 to TFormResult(Fm_Vis).StrGr_Res.ColCount-noId do
     begin
      if TFormResult(Fm_Vis).StrGr_Res.colwidths[ACol]>2 then
        begin
         if ARow=0 then
         begin
          s1:=PadCenter(TFormResult(Fm_Vis).StrGr_Res.cells[ACol,ARow],mas_shir[ACol],' ');
          p:=pos(#13,s1);
          if p>0 then begin
          delete (s1,p,1);
          s1:=s1+' ';
          end;
          s:=s+s1+'|';//PadCenter(TFormResult(Fm_Vis).StrGr_Res.cells[ACol,ARow],mas_shir[ACol],' ')+'|'

         end
         else
          s:=s+PadLeft(TFormResult(Fm_Vis).StrGr_Res.cells[ACol,ARow],mas_shir[ACol],' ')+'|';
        end;
     end;
     Memo1.Lines.Add(s);

     if IsThereITOGO(s) {uo pos('ИТОГО',s)>0 }
     then fl_vs:=false;

     if ARow=TFormResult(Fm_Vis).StrGr_Res.FixedRows-1 then
        Memo1.Lines.Add(lin);
   end;
   Memo1.Lines.Add(lin);
   if fl_vs then
      Memo1.Lines.Add(TrLangMSG(msgAllCount)+':'+inttostr(TFormResult(Fm_Vis).NumCols{StrGr_Res.RowCount-1}));

   Memo1.Lines.Add(TrLangMSG(msgCreate)+':'+DateToStr(Now)+' '+TimeToStr(Now));
   Rows:=Memo1.Lines.Count;
end;

constructor TProsmForm.ProsmCreate(AOwner: TComponent; Frn:TObject);
begin
   tFm_Vit:=Frn;
   inherited Create(AOwner);
end;

// проверяет есть ли в строке 'ИТОГО'
function IsThereITOGO(s:string):boolean;
var p:integer;
begin
   p:=pos(TrLangMSG(msgITOGO),s);
   result:=(p>0)
           and((p=1)or not(s[p-1]in ['А'..'Я']))
           and((length(s)=p+4)or not(s[p+5]in ['А'..'Я']))
end;

procedure TProsmForm.FormCreate(Sender: TObject);
begin
  //FWidthCheck:=twcA4;
  FWidthCheck:=twcNull;
  MakeSheet;
end;

procedure TProsmForm.ClearMas;
var i:integer;
begin
 for i:=0 to 49 do
   Mas_Shir[i]:=0;

end;


procedure TProsmForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TProsmForm.BB_PrintClick(Sender: TObject);
var Pr:TForm2Pr;
begin
  TFormResult(Fm_Vis).Save2HTML('tmp1.htm');
{  Pr:=TForm2Pr.Fm2Create(Self,TrLangMSG(msgLines)+':'+inttostr(Rows)+' '+TrLangMSG(msgCols)+':'+
                         inttostr(Cols));
  Pr.ShowModal;}
  //  печать сразу
     begin
      DM_Print:=TDM_Print.Create(nil);
      try
        DM_Print.PrintStrings:=Memo1.Lines;
        DM_Print.ShowReport;
      finally
        DM_Print.Free;
      end;
     end;
end;

procedure TProsmForm.Translate;
begin
  inherited;
  Caption:=TrLangMSG(msgShowResult);
  BB_Print.Caption:=TrLangMSG(msgPrint);
  BB_Close.Caption:=TrLangMSG(msgExit);
end;

procedure TProsmForm.CheckBox1Click(Sender: TObject);
begin
  inherited;
  if CheckBox1.Checked then FWidthCheck:=twcA4
    else FWidthCheck:=twcNull;
  MakeSheet;
end;

procedure TProsmForm.FormShow(Sender: TObject);
begin
  inherited;
  Caption:='Просмотр результата';
end;

end.
