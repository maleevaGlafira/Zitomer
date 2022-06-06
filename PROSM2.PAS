unit Prosm2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Buttons, frmLANG, cntsLANG, ExtCtrls,FrPrintDM;

type
  TProsmForm2  = class(TFormLang)
    Memo1: TRichEdit;
    Panel1: TPanel;
    BB_Print: TBitBtn;
    BB_Close: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BB_PrintClick(Sender: TObject);       //TGridRect
  private
    { Private declarations }
//    Mas_Shir:array [0..49] of integer;
  public
    { Public declarations }
    Cols,Rows:integer;
    procedure Translate;override;
  end;

var
  ProsmForm2: TProsmForm2;

implementation

uses strtool,fm2pr;

{$R *.DFM}

procedure TProsmForm2.FormCreate(Sender: TObject);
//var //{ACol,Arow,Shir}:integer;
    //{s,}lin:string;
begin
  //ClearMas;
  ProsmForm2:=Self;
  Cols:=0;
  {for ARow:=0 to FormResult.StrGr_Res.RowCount-1 do begin
    for ACol:=0 to FormResult.StrGr_Res.ColCount-2 do
     begin
      if FormResult.StrGr_Res.colwidths[ACol]>2 then
        begin
          shir:=length(FormResult.StrGr_Res.cells[ACol,ARow]);
          if shir>mas_shir[ACol] then
             mas_shir[ACol]:=shir;
        end;
     end;
    end;

  Shir:=1;
  for ACol:=0 to FormResult.StrGr_Res.ColCount-2 do
   begin
    if FormResult.StrGr_Res.colwidths[ACol]>2 then
       shir:=shir+mas_shir[ACol]+1;
   end;
  Memo1.Lines.Add(FormResult.Lb_usl.Caption);
  Cols:=Shir;
  lin:=FillStr(shir,'-');
  Memo1.Lines.Add(lin);
  for ARow:=0 to FormResult.StrGr_Res.RowCount-1 do
   begin
    s:='|';
    for ACol:=0 to FormResult.StrGr_Res.ColCount-2 do
     begin
      if FormResult.StrGr_Res.colwidths[ACol]>2 then
        begin
         if ARow=0 then
          s:=s+PadCenter(FormResult.StrGr_Res.cells[ACol,ARow],mas_shir[ACol],' ')+'|'
         else
          s:=s+PadLeft(FormResult.StrGr_Res.cells[ACol,ARow],mas_shir[ACol],' ')+'|';
        end;
     end;
     Memo1.Lines.Add(s);
     if ARow=0 then
        Memo1.Lines.Add(lin);
   end;
   Memo1.Lines.Add(lin);
   Memo1.Lines.Add('Всего найдено:'+inttostr(FormResult.NumCols));}
   Rows:=Memo1.Lines.Count;

end;

procedure TProsmForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TProsmForm2.BB_PrintClick(Sender: TObject);
var Pr:TForm2Pr;
begin
  //FormResult.Save2HTML('tmp1.htm');
 // Pr:=TForm2Pr.Fm2Create(Self,TrLangMSG(msgLines)+':'+inttostr(Rows)+' '+TrLangMSG(msgCols)+':'+
                       //  inttostr(Cols));
  //Pr.ShowModal;
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

procedure TProsmForm2.Translate;
begin
  inherited;
  Caption:=TrLangMSG(msgShowResult);
  BB_Print.Caption:=TrLangMSG(msgPrint);
  BB_Close.Caption:=TrLangMSG(msgExit);
end;

end.
