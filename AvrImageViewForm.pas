unit AvrImageViewForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ImgList, StdCtrls, Buttons, DMAvrImage, ExtDlgs,
  DBCtrls, ComCtrls, ToolWin,frmLANG;

type
  Tfrm_AvrImageView = class(TFormLang)
    pnl_Btns: TPanel;
    OpenDlg: TOpenPictureDialog;
    sbar: TStatusBar;
    pnl_Img: TPanel;
    Image: TImage;
    sp_first: TSpeedButton;
    sp_prev: TSpeedButton;
    sp_last: TSpeedButton;
    sp_next: TSpeedButton;
    sp_add: TSpeedButton;
    sp_delete: TSpeedButton;
    sp_exit: TSpeedButton;
    sp_Print: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure sp_exitClick(Sender: TObject);
    procedure sp_firstClick(Sender: TObject);
    procedure sp_prevClick(Sender: TObject);
    procedure sp_nextClick(Sender: TObject);
    procedure sp_lastClick(Sender: TObject);
    procedure sp_addClick(Sender: TObject);
    procedure sp_deleteClick(Sender: TObject);
    procedure sp_PrintClick(Sender: TObject);
  private
    F_ID_Zav: integer;
    F_ReadOnly: boolean;
    F_DM_AvrImage: TDM_AvrImage;
    F_FileList: TStringList;
    procedure ReloadFileList;
    procedure MashtabImg;
  private
    F_ImageIndex: integer;
    procedure SetImageIndex(Index: integer);
    property ImageIndex: integer read F_ImageIndex write SetImageIndex;
  public
    constructor Create(AOwner: TComponent; AID_Zav: integer; AReadOnly: boolean);
    procedure Translate;override;
  end;



implementation

{$R *.dfm}


{ Tfrm_AvrImageView }
uses cntsLANG;


constructor Tfrm_AvrImageView.Create(AOwner: TComponent; AID_Zav: integer;
  AReadOnly: boolean);
begin
  F_ID_Zav:=AID_Zav;
  F_ReadOnly:=AReadOnly;
  inherited Create(AOwner);
end;

procedure Tfrm_AvrImageView.Translate;
begin
  Caption:=TrLangMSG(msgImage);
  sp_first.Hint:=TrLangMSG(msgFirstImage );//1-ое изображение
  sp_add.Hint:=TrLangMSG(msgAddImage );// Добавить изображение
  sp_delete.Hint:=TrLangMSG(msgDeleteImage );// Удалить изображение
  sp_exit.Hint:=TrLangMSG(msgExit );//  Выход
  sp_Print.Hint:=TrLangMSG(msgPrint );//   Печатать изображение
  sp_prev.Hint:=TrLangMSG(msgPrevImage );// Предыдущее изображение
  sp_last.Hint:=TrLangMSG(msgLastImage );// Последнее изображение
  sp_next.Hint:=TrLangMSG(msgNextImage);// Следующее изображение
end;

procedure Tfrm_AvrImageView.FormCreate(Sender: TObject);
begin
  F_DM_AvrImage:=TDM_AvrImage.Create(self, F_ID_Zav);

  F_FileList:=TStringList.Create;
  F_FileList.AddStrings(F_DM_AvrImage.FileList);

  ImageIndex:=0;
end;

procedure Tfrm_AvrImageView.FormDestroy(Sender: TObject);
begin
  F_DM_AvrImage.Free;

  F_FileList.Clear;
  F_FileList.Free;
end;


procedure Tfrm_AvrImageView.SetImageIndex(Index: integer);
var
  fl: boolean;
begin
  if ((Index>F_FileList.Count-1) or (Index<0)) and (Index<>0)then exit;

  F_ImageIndex:=Index;

  {Енеблим}
  sp_delete.Enabled:=(not F_ReadOnly) and (F_FileList.Count<>0);
  sp_add.Enabled:=not F_ReadOnly;
  sp_print.Enabled:=(F_FileList.Count<>0);

  if (Index=0) and (F_FileList.Count=0) then
  begin
    sp_delete.Enabled:=false;
    sp_first.Enabled:=false;
    sp_prev.Enabled:=false;
    sp_last.Enabled:=false;
    sp_next.Enabled:=false;
    sp_print.Enabled:=false;
    exit;
  end;

  if Index=0 then fl:=false
  else fl:=true;
  sp_first.Enabled:=fl;
  sp_prev.Enabled:=fl;

  if Index=F_FileList.Count-1 then fl:=false
  else fl:=true;
  sp_last.Enabled:=fl;
  sp_next.Enabled:=fl;
  {/Енеблим}

  {Грузим и масштабируем}
  Image.Picture.LoadFromFile(F_FileList.Strings[Index]);
  Image.Visible:=true;
  MashtabImg;
  {/Грузим и масштабируем}

  sbar.SimpleText:=TrLangMSG(msgImageSize){'Размер изображения: '}+IntToStr(Image.Picture.Width)+'x'+IntToStr(Image.Picture.Height);
  Caption:=TrLangMSG(msgImageTitle){'Изображения аварии - '+'изображение №'}+IntToStr(ImageIndex+1)+' з '+IntToStr(F_FileList.Count);
end;

procedure Tfrm_AvrImageView.ReloadFileList;
begin
  F_FileList.Clear;
  F_FileList.AddStrings(F_DM_AvrImage.FileList);
end;

procedure Tfrm_AvrImageView.MashtabImg;
var
  prop_pnl, prop_img: double;
begin
  if F_FileList.Count=0 then exit;

  prop_pnl:=pnl_Img.Height/pnl_Img.Width;
  prop_img:=Image.Picture.Height/Image.Picture.Width;
  if prop_img<=prop_pnl then
  begin
    Image.Left:=2;
    Image.Width:=pnl_img.Width-4;
    Image.Height:=Round(prop_img*pnl_Img.Width)-2;
    Image.Top:=((pnl_Img.Height-Image.Height) div 2)-2;
  end else
  begin
    Image.Top:=2;
    Image.Height:=pnl_Img.Height-4;
    Image.Width:=Round(Image.Height/prop_img)-2;
    Image.Left:=((pnl_Img.Width-Image.Width) div 2)-2;
  end;
end;

procedure Tfrm_AvrImageView.FormResize(Sender: TObject);
begin
  MashtabImg;
end;

procedure Tfrm_AvrImageView.sp_exitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_AvrImageView.sp_firstClick(Sender: TObject);
begin
  ImageIndex:=0;
end;

procedure Tfrm_AvrImageView.sp_prevClick(Sender: TObject);
begin
  ImageIndex:=ImageIndex-1;
end;

procedure Tfrm_AvrImageView.sp_nextClick(Sender: TObject);
begin
  ImageIndex:=ImageIndex+1;
end;

procedure Tfrm_AvrImageView.sp_lastClick(Sender: TObject);
begin
  ImageIndex:=F_FileList.Count-1;
end;

procedure Tfrm_AvrImageView.sp_addClick(Sender: TObject);
begin
  if not OpenDlg.Execute then exit;

  F_DM_AvrImage.SaveFileToDB(OpenDlg.FileName);

  ReloadFileList;
  ImageIndex:=F_FileList.Count-1;
end;

procedure Tfrm_AvrImageView.sp_deleteClick(Sender: TObject);
var
  index: integer;
begin
  if {Application.MessageBox('Вы уверены, что хотите удалить изображение?',}
     MessageDlg(
          TrLangMSG(msgConfirmDel), mtConfirmation, [mbYes, mbNo],0)<>IDYES	then exit;

  if ImageIndex=F_FileList.Count-1 then
    index:=ImageIndex-1
  else
    index:=ImageIndex;

  F_DM_AvrImage.DeleteImgFromDB(integer(F_FileList.Objects[ImageIndex]));

  Image.Visible:=false;

  ReloadFileList;

  if F_FileList.Count<>0 then ImageIndex:=index
  else ImageIndex:=0;
end;

procedure Tfrm_AvrImageView.sp_PrintClick(Sender: TObject);
begin
  F_DM_AvrImage.PrintAvrImage(F_FileList.Strings[ImageIndex]);
end;

end.
