unit fm2pr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, sfexec, Spin, Gauges, ComCtrls, ExtCtrls, frmLANG, cntsLANG,
  FrPrintDM;

type
  TForm2Pr = class(TFormLang)
    SaveF: TSaveDialog;
    GrB_Export: TGroupBox;
    BB_Save: TBitBtn;
    ChB_Dos: TCheckBox;
    GrB_Print: TGroupBox;
    BB_Close: TBitBtn;
    Lb_stat: TLabel;
    Gg: TGauge;
    ChB_PrDos: TCheckBox;
    GrB_List: TGroupBox;
    RB_All: TRadioButton;
    RB_Str: TRadioButton;
    CB_str: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    CB_Col: TComboBox;
    Label1: TLabel;
    SpEd_Col: TSpinEdit;
    Label2: TLabel;
    SpEd_Row: TSpinEdit;
    ChB_Con: TCheckBox;
    Label5: TLabel;
    SpEd_COn: TSpinEdit;
    Label6: TLabel;
    SpEd_COff: TSpinEdit;
    BB_Print: TBitBtn;
    MatrixCheckBox: TCheckBox;
    procedure BB_SaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CB_strChange(Sender: TObject);
    procedure SpEd_ColChange(Sender: TObject);
    procedure RB_StrClick(Sender: TObject);
    procedure BB_CloseClick(Sender: TObject);
    procedure ChB_ConClick(Sender: TObject);
    procedure BB_PrintClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    {PCharH,}strCount:integer;
    StrBE: array [1..100,1..2] of integer;
    colCount: array [1..100] of integer;
    colRotate: array [1..100] of boolean;
    PrintPath:string;
    BegPr,EndPr,BegPage,EndPage:string;
    DosStr:TStringList;
  public
    { Public declarations }
    fl_exit:boolean;
    constructor Fm2Create(AOwner: TComponent;FCap:string);
    procedure GetSTR;
    procedure FillCB;
    function RazborPr(inStr:string):string;
    procedure Translate;override;
  end;

var
  Form2Pr: TForm2Pr;
  OwnerForm:TForm;
  Memo_tut:TMemo;

implementation

uses inifiles,main,strtool,printers, avartype;

{$R *.DFM}


constructor TForm2Pr.Fm2Create(AOwner: TComponent;FCap:string);
var i:integer;
begin
 OwnerForm:=TForm(AOwner);
 for i:=0 to OwnerForm.ComponentCount-1 do
   begin
     if OwnerForm.Components[i].Name='Memo1' then
       begin
        Memo_tut:=TMemo(OwnerForm.Components[i]);
        break;
       end;
   end;
 inherited Create(AOwner);
 Caption:=Caption+' '+FCap;
end;

procedure TForm2Pr.BB_SaveClick(Sender: TObject);
var i,stCount:integer;
begin
  if ChB_Dos.Checked then
   begin
     gg.MinValue:=-1000000;
     gg.MaxValue:=1000000;
     gg.Progress:=0;
     DosStr.Clear;
     stCount:=Memo_tut.Lines.Count-1;
     gg.MaxValue:=stCount;
     gg.MinValue:=0;
     Lb_Stat.Caption:='Win->Dos';
     Lb_Stat.Update;
     for i:=0 to stCount do
      begin
         gg.Progress:=i;
         DosStr.Add(WinToDos(Strip('A',#13#10,Memo_tut.Lines.Strings[i])));
      end;
     Lb_Stat.Caption:='';
     gg.Progress:=0;
     if SaveF.Execute then
        DosStr.SaveToFile(SaveF.FileName);
   end
  else
   begin
    if SaveF.Execute then
     Memo_tut.Lines.SaveToFile(SaveF.FileName);
   end;
end;


procedure TForm2Pr.FormCreate(Sender: TObject);
var mIni:TIniFile;
begin
   Form2Pr:=Self;
   DosStr:=TStringList.Create;
   mIni:=TIniFile.Create(FullPathIniFlAvar{CurrentDir+'\avar.ini'});
   ChB_Con.Checked:=mIni.ReadBool('Print','Condensed',false);
   ChB_PrDos.Checked:=mIni.ReadBool('Print','DosPrinter',true);
   ChB_Dos.Checked:=mIni.ReadBool('Print','DosFile',false);
   PrintPath:=mIni.ReadString('Print','Path','aaa.txt');
   SpEd_COn.Value:=mIni.ReadInteger('Print','CondOn',15);
   SpEd_COff.Value:=mIni.ReadInteger('Print','CondOff',18);

   BegPr:=RazborPr(mIni.ReadString('Print','BeginPrint',''));
   EndPr:=RazborPr(mIni.ReadString('Print','EndPrint',''));
   BegPage:=RazborPr(mIni.ReadString('Print','BeginPage',''));
   EndPage:=RazborPr(mIni.ReadString('Print','EndPage',''));

   mIni.Free;
   ChB_ConClick(Self);
   GetStr;
   FillCB;
   CB_strChange(Self);
end;

procedure TForm2Pr.FormClose(Sender: TObject; var Action: TCloseAction);
var mIni:TIniFile;
begin
   mIni:=TIniFile.Create(FullPathIniFlAvar{CurrentDir+'\avar.ini'});
   mIni.WriteBool('Print','Condensed',ChB_Con.Checked);
   mIni.WriteBool('Print','DosPrinter',ChB_PrDos.Checked);
   mIni.WriteBool('Print','DosFile',ChB_Dos.Checked);
   mIni.WriteString('Print','Path',PrintPath);
   mIni.WriteInteger('Print','CondOn',SpEd_COn.Value);

   if ChB_Con.Checked then
     begin
       mIni.WriteInteger('Print','CStrLen',SpEd_Col.Value);
       mIni.WriteInteger('Print','CStrCount',SpEd_Row.Value);
     end
   else
     begin
       mIni.WriteInteger('Print','StrLen',SpEd_Col.Value);
       mIni.WriteInteger('Print','StrCount',SpEd_Row.Value);
     end;
   mIni.Free;
   Action:=caFree;
end;


procedure TForm2Pr.GetSTR;
var i,j,i1,stCount:integer;
    tekInStr,MaxInStr,MaxRow,MaxCol:integer;
begin

  tekInStr:=0;
  MaxInStr:=1;
  strCount:=0;
   for i:=1 to 100 do
    begin
     colCount[i]:=0;
     colRotate[i]:=false;
     StrBE[i][1]:=0;
     StrBE[i][2]:=0;
    end;
StrBE[1][1]:=0;
if (spEd_Row.Text<>'') and (spEd_Col.Text<>'') then
 begin
     MaxRow:=spEd_Row.Value;
     MaxCol:=spEd_Col.Value;

       stCount:=Memo_tut.Lines.Count-1;
       for i:=1 to stCount do
         begin
            i1:=strlen(pchar(Memo_tut.Lines.Strings[i]));
            if i1>MaxInStr then
               MaxInStr:=i1;
            j:=pos(#12,Memo_tut.Lines.Strings[i]);
            if (j>0) or (tekInStr>MaxRow) or (i=stCount) then
             begin
              {if (MaxInStr>MaxCol) and ChB_AutoR.Enabled and ChB_AutoR.Checked then
                 begin
                   if (MaxInStr<=LCols) and (TekInStr<=LRows) then
                    begin
                      colCount[StrCount+1]:=(MaxInStr div LCols)+1;
                      colRotate[StrCount+1]:=true;
                    end;
                 end
              else}
                 colCount[StrCount+1]:=(MaxInStr div MaxCol)+1;

              StrBE[StrCount+1][2]:=i;
              StrBE[StrCount+2][1]:=i+1;
              tekInStr:=1;
              MaxInStr:=1;
              if colCount[StrCount+1]<=0 then
                 colCount[StrCount+1]:=1;
              inc(StrCount);
             end
            else
              inc(tekInStr);
         end;

 end;
end;

procedure TForm2Pr.FillCB;
var i:integer;
begin
  CB_Str.Items.Clear;
  For i:=1 to StrCount do
   begin
      CB_Str.Items.Add(inttostr(i));
   end;
   CB_Str.ItemIndex:=0;
end;

procedure TForm2Pr.CB_strChange(Sender: TObject);
var i:integer;
begin
 if CB_Str.ItemIndex>=0 then
  begin
   if ColCount[CB_Str.ItemIndex+1]>0 then
     begin
        if ColCount[CB_Str.ItemIndex+1]>1 then
         CB_Col.Enabled:=true
        else
         CB_Col.Enabled:=false;
         CB_Col.Items.Clear;
         for i:=1 to ColCount[CB_Str.ItemIndex+1] do
           begin
             if ColRotate[CB_Str.ItemIndex+1] then
               CB_Col.Items.Add(inttostr(i)+'*')
             else
               CB_Col.Items.Add(inttostr(i));
           end;
         CB_Col.ItemIndex:=0;
     end
   else
     CB_Col.Enabled:=false;
  end;
end;

procedure TForm2Pr.SpEd_ColChange(Sender: TObject);
begin
  GetStr;
  FillCB;
  CB_strChange(Self);
end;

procedure TForm2Pr.RB_StrClick(Sender: TObject);
begin
   CB_Str.Enabled:=RB_Str.Checked;
   CB_col.Enabled:=RB_Str.Checked;
   CB_strChange(Self);
end;


procedure TForm2Pr.BB_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TForm2Pr.ChB_ConClick(Sender: TObject);
var mIni:TIniFile;
begin
  SpEd_Con.Enabled:=ChB_Con.Checked;
  SpEd_COff.Enabled:=ChB_Con.Checked;
  Label5.Enabled:=ChB_Con.Checked;
  Label6.Enabled:=ChB_Con.Checked;
  mIni:=TIniFile.Create(FullPathIniFlAvar{CurrentDir+'\avar.ini'});
  if ChB_Con.Checked then
     begin
       SpEd_Col.Value:=mIni.ReadInteger('Print','CStrLen',100);
       SpEd_Row.Value:=mIni.ReadInteger('Print','CStrCount',60);
     end
   else
     begin
       SpEd_Col.Value:=mIni.ReadInteger('Print','StrLen',62);
       SpEd_Row.Value:=mIni.ReadInteger('Print','StrCount',60);
     end;
  mIni.Free;
end;

procedure TForm2Pr.BB_PrintClick(Sender: TObject);
var i,j,{i1,}j1{,dob}:integer;
    tf:TextFile;
begin
   Assignfile(tf,PrintPath);
   if fileexists(PrintPath) then
      Append(tf)
   else
      ReWrite(tf);

   Write(tf,BegPr);
   if ChB_Con.Checked then
       Write(tf,chr(SpEd_COn.Value));
   fl_exit:=false;

   for i:=1 to StrCount do
     begin
     Write(tf,BegPage);

     if fl_exit then
       exit;
     for j1:=1 to ColCount[i] do
      begin
       if RB_All.Checked or
          ((i=StrToInt(CB_Str.Items.Strings[CB_Str.ItemIndex])) and
          (j1=StrToInt(Strip('A','*',CB_Col.Items.Strings[CB_Col.ItemIndex])))) then
        begin
         Lb_stat.Caption:=TrLangMSG(msgPage)+' '+inttostr(i)+'-'+inttostr(j1);
         Lb_stat.Update;
         gg.MinValue:=-1000000;
         gg.MaxValue:=1000000;
         gg.Progress:=StrBE[i][1];
         gg.MinValue:=StrBE[i][1];
         gg.MaxValue:=StrBE[i][2];
//         dob:=PCharH;

         for j:=StrBE[i][1] to StrBE[i][2] do
           begin
              gg.Progress:=j;
              Application.ProcessMessages;
                if ChB_PrDos.Checked then
                   WriteLn(tf,WinToDos(Strip('A',#13#10,Copy(Memo_tut.Lines.Strings[j],
                            1+SpEd_Col.Value*(j1-1),SpEd_Col.Value))))
                else
                  WriteLn(tf,Strip('A',#13#10,Copy(Memo_tut.Lines.Strings[j],
                           1+SpEd_Col.Value*(j1-1),SpEd_Col.Value)));

                {if j=StrBE[i][2] then
                 begin
                  i1:=pos(#12,Memo_tut.Lines.Strings[j]);
                  if i1<=0 then
                    WriteLn(tf,#12);
                 end;}

           end;
        end;
      end;
      Write(tf,EndPage);
     end;
   if ChB_Con.Checked then
       WriteLn(tf,chr(SpEd_COff.Value));
   Write(tf,EndPr);
   CloseFile(tf);

   gg.MinValue:=-1000000;
   gg.MaxValue:=1000000;
   gg.Progress:=-1000000;
   Lb_Stat.Caption:='';
end;

procedure TForm2Pr.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=VK_ESCAPE then
     fl_exit:=true;
end;

function TForm2Pr.RazborPr(inStr:string):string;
var ret,tt_str:string;
    i:integer;
begin
  ret:='';
  tt_str:='';
  i:=1;
  repeat
     tt_str:=ExtractWordsx_(i,1,inStr,';',false);
     if tt_str<>'' then
        ret:=ret+chr(strtointdef(tt_str,0));
     inc(i);
  until tt_str='';
  Result:=ret;
end;

procedure TForm2Pr.Translate;
begin
  inherited;
  Caption:=TrLangMSG(msgPrint)+' результата';
  GrB_Export.Caption:=TrLangMSG(msgSave);
  ChB_Dos.Caption:=TrLangMSG(msgCoder)+' DOS';
  GrB_Print.Caption:=TrLangMSG(msgPrintText);
  Label1.Caption:=TrLangMSG(msgCountSymPage);
  Label2.Caption:=TrLangMSG(msgCountLinePage);
  Label5.Caption:=TrLangMSG(msgON);
  Label6.Caption:=TrLangMSG(msgOFF);
  ChB_PrDos.Caption:=TrLangMSG(msgCoder)+' DOS';
  ChB_Con.Caption:=TrLangMSG(msgCondensedFont)+' :';
  BB_Close.Caption:=TrLangMSG(msgExit);
  GrB_List.Caption:=TrLangMSG(msgPrint);
  Label3.Caption:=TrLangMSG(msgPage);
  Label4.Caption:=TrLangMSG(msgPart);
  RB_All.Caption:=TrLangMSG(msgAll);
  RB_Str.Caption:=TrLangMSG(msgOnPage);
  BB_Print.Caption:=TrLangMSG(msgPrint);
end;

procedure TForm2Pr.BitBtn1Click(Sender: TObject);
begin
  inherited;
  if MatrixCheckBox.Checked then
    begin
      BB_PrintClick(nil);
    end
      else
    begin
      DM_Print:=TDM_Print.Create(nil);
      try
        DM_Print.PrintStrings:=Memo_tut.Lines;
        DM_Print.ShowReport;
      finally
        DM_Print.Free;
      end;        
    end;      
end;

end.
