unit BackUpRestoreForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,BackUpUnit, StdCtrls, ExtCtrls, Mask, ToolEdit, Buttons;

const ARCH_CAPTION='Для архівування бази натисніть кнопку "Пуск"';
  
type

  TArchMode=(tamBackup,tamRestore);

  TBRForm = class(TForm)
    Panel1: TPanel;
    Memo1: TMemo;
    BitBtn1: TBitBtn;
    ListBox1: TListBox;
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    FMyBackUp:TMyBackUp;
    FArchMode:TArchMode;
    procedure ReadFromConsole(Sender:TObject);
    procedure OnEndProcess(Sender:TObject);
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner:TComponent; ArchMode:TArchMode; Alias:string); reintroduce;
  end;

var
  BRForm: TBRForm;

implementation

{$R *.dfm}
uses frmLANG,cntsLANG;

constructor TBRForm.Create(AOwner:TComponent; ArchMode:TArchMode; Alias:string);
begin
  inherited Create(AOwner);
  //
  FArchMode:=ArchMode;
  FMyBackUp:=TMyBackUp.Create;
  Memo1.Lines.Clear;
  FMyBackUp.TargetFile:=FMyBackUp.GetPathOfAliasIB(Alias);
  FMyBackUp.MyConsole.OnCallBackConsole:=ReadFromConsole;
  FMyBackUp.MyConsole.OnEndProcess:=OnEndProcess;
  //
  if (ArchMode=tamBackUp) then
    begin
      Caption:=TrLangMSG(msgArhiv);//'Архівурование';
      ListBox1.Hide;
      Memo1.Show;
      Memo1.Lines.Clear;
      Memo1.Lines.Add(ARCH_CAPTION);
    end
      else
    begin
      Caption:=TrLangMSG(msqRestore);//'Восстановление';
      Memo1.Hide;
      ListBox1.Show;
      FMyBackUp.LoadBackupsList;
      ListBox1.Items:=FMyBackUp.BackupsList;
    end;        
end;

procedure TBRForm.OnEndProcess(Sender:TObject);
begin
  if FArchMode=tamBackUp then MessageBox(handle,'Ок','Архивирование',MB_OK or MB_ICONINFORMATION)
    else
      begin
        MessageDlg(TrLangMSG(msqRestore),mtInformation, [mbOk], 0);
       // MessageBox(handle,'Ок','Восстановление',MB_OK or MB_ICONINFORMATION);
        ListBox1.Show;
      end;
  BitBtn1.Enabled:=true;
  Memo1.Lines.Clear;
  Close;  
end;

procedure TBRForm.ReadFromConsole(Sender:TObject);
var p:TPoint;
  i,k:integer;
begin
  i:=FMyBackUp.MyConsole.Console.Count;
  k:=5;
  if (i>0) then
    begin
      if (i>k) then
        begin
          if (Memo1.Lines.Count=i-k) then Memo1.Lines[i-1-k]:=FMyBackUp.MyConsole.Console[i-1]
            else Memo1.Lines.Add(FMyBackUp.MyConsole.Console[i-1]);
        end;            
    end
      else Memo1.Lines.Clear;        
  Application.ProcessMessages;
end;

procedure TBRForm.FormDestroy(Sender: TObject);
begin
  FMyBackUp.Free;
end;

procedure TBRForm.BitBtn1Click(Sender: TObject);
begin
  if (FArchMode=tamRestore) and (ListBox1.ItemIndex=-1) then
    begin
      MessageDlg(TrLangMSG(msgNeedChArhiv),mtWarning, [mbOk], 0);
      //MessageBox(handle,'Надо выбрать архив','Восстановление',MB_OK or MB_ICONWARNING);
      exit;
    end;
  BitBtn1.Enabled:=false;
  //
  if (FArchMode=tamBackUp) then FMyBackUp.BackUpNow
    else
      begin
         if MessageDlg(TrLangMSG(msgConfirmArhivReplace),mtInformation,[mbOk],0)
         {MessageBox(handle,'Вы уверены, что хотите заменить исходные файлы, на файлы из архива?',
          'Восстановление',MB_OK or MB_ICONINFORMATION or MB_OKCANCEL)}=IDOK then
          begin
            ListBox1.Hide;
            Memo1.Show;
            FMyBackUp.RestoreNow(ListBox1.Items[ListBox1.ItemIndex]);
          end
            else
          begin
            BitBtn1.Enabled:=true;
          end;
      end;
end;

end.
