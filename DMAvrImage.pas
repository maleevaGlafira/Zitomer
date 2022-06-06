unit DMAvrImage;

interface

uses
  SysUtils, Classes, DMMain, IBDatabase, DB, IBCustomDataSet, Forms,
  ShellApi, Windows, DBTables, IBSQL, FR_Class, FR_E_GR_RS, FR_E_JPG_RS;

const
  TMP_DIR_NAME='TMP_AVR_IMG';  

type
  TActionName=(anGetAllBlobs, anSaveFile, anDeleteImg);

  TDM_AvrImage = class(TDataModule)
    tran_image: TIBTransaction;
    dset_image: TIBDataSet;
    dset_imageID: TIntegerField;
    dset_imageID_ZAV: TIntegerField;
    dset_imageIMAGE: TBlobField;
    dset_tmp: TIBDataSet;
    sql_tmp: TIBSQL;
    frReport: TfrReport;
    dset_zav: TIBDataSet;
    tran_zav: TIBTransaction;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    F_TMP_Dir: string;
    F_FileList: TStringList;
    F_ID_Zav: integer;
    F_SaveFileName: string;
    F_DeleteImgID: integer;
    F_GetImgCount: integer;
    procedure Create_TMP_Dir;
    procedure Delete_TMP_Dir;
    procedure SaveBlobToFile(Field: TField; ID: integer);
    procedure DoAction(ActionName: TActionName);
    procedure GetAllBlobs;
    procedure SaveFile;
    procedure DeleteImg;
    procedure GetZavNomerDtAdres(var nomer, dt, adres: string);
  public
    property FileList: TStringList read F_FileList;
    constructor Create(AOwner: TComponent; AID_Zav: integer);
    function SaveFileToDB(FileName: string):boolean;
    procedure DeleteImgFromDB(ID_Img: integer);
    procedure PrintAvrImage(FileName: string);
  end;


implementation

{$R *.dfm}

uses ServiceFuncUnit, datam;


function DeleteDir(dir: string): boolean;
var
  fos: TSHFileOpStruct;
begin
  ZeroMemory(@fos, SizeOf(fos));
  with fos do
  begin
    wFunc  := FO_DELETE;
    fFlags := FOF_SILENT or FOF_NOCONFIRMATION;
    pFrom  := PChar(dir + #0);
  end;
  Result := (0 = ShFileOperation(fos));
end;

{ TDM_AvrImage }

procedure TDM_AvrImage.SaveBlobToFile(Field: TField; ID: integer);
var
  full_file_name: string;
  FileS: TFileStream;
  BlobS: TStream;
begin
  full_file_name:=F_TMP_Dir+'\'+IntToStr(ID)+'.jpg';
  if FileExists(full_file_name) then SysUtils.DeleteFile(full_file_name);

  BlobS:=Field.DataSet.CreateBlobStream(Field, bmRead);
  try
    FileS:=TFileStream.Create(full_file_name, fmCreate);
    try
      FileS.CopyFrom(BlobS, BlobS.Size);
    finally
      FileS.Free;
    end;
  finally
    BlobS.Free;
  end;

  F_FileList.AddObject(full_file_name, ptr(ID));
end;

procedure TDM_AvrImage.DataModuleCreate(Sender: TObject);
begin
  F_FileList:=TStringList.Create;

  F_TMP_Dir:=ExtractFileDir(Application.ExeName)+'\'+TMP_DIR_NAME;
  Create_TMP_Dir;
  DoAction(anGetAllBlobs);
end;

procedure TDM_AvrImage.DataModuleDestroy(Sender: TObject);
begin
  F_FileList.Clear;
  F_FileList.Free;

  Delete_TMP_Dir;
end;

procedure TDM_AvrImage.Create_TMP_Dir;
begin
  if not DirectoryExists(F_TMP_Dir) then
    CreateDir(F_TMP_Dir);
end;

procedure TDM_AvrImage.Delete_TMP_Dir;
begin
  if DirectoryExists(F_TMP_Dir) then
    DeleteDir(F_TMP_Dir);
end;

function TDM_AvrImage.SaveFileToDB(FileName: string): boolean;
begin
  F_SaveFileName:=FileName;
  DoAction(anSaveFile);
end;

constructor TDM_AvrImage.Create(AOwner: TComponent; AID_Zav: integer);
begin
  F_ID_Zav:=AID_Zav;
  inherited Create(AOwner);
end;

procedure TDM_AvrImage.DoAction(ActionName: TActionName);
begin
  if tran_image.InTransaction then
    tran_image.Rollback;
  tran_image.StartTransaction;
  try
    case ActionName of
      anGetAllBlobs: GetAllBlobs;
      anSaveFile: SaveFile;
      anDeleteImg: DeleteImg;
    end;
  tran_image.Commit;  
  except
    on E: Exception do
    begin
      tran_image.Rollback;
      raise Exception.Create('DoAction; '+E.Message);
    end;
  end;
end;

procedure TDM_AvrImage.GetAllBlobs;
var
  saved_file_name: string;
begin
  F_FileList.Clear;
  IBOpenSQL(dset_tmp, 'select * from avr_image where id_zav='+IntToStr(F_ID_Zav)+' order by id');
  while not dset_tmp.Eof do
  begin
    SaveBlobToFile(dset_tmp.FieldByName('image'), dset_tmp.FieldByName('id').AsInteger);
    dset_tmp.Next;
  end;
end;

procedure TDM_AvrImage.SaveFile;
var fs:TFileStream;
    blob:TStream;
    id_img:string;
begin
  if not FileExists(F_SaveFileName) then exit;

  dset_image.Open;
  dset_image.Insert;
  dset_image.FieldByName('id_zav').AsInteger:=F_ID_Zav;
  blob:=dset_image.CreateBlobStream(dset_image.FieldByName('image'), bmWrite);
  try
    blob.Seek(0, soFromBeginning);
    fs:=TFileStream.Create(F_SaveFileName, fmOpenRead or fmShareDenyWrite);
    try
      blob.CopyFrom(fs, fs.Size);
    finally
      fs.Free;
    end;
  finally
    blob.Free;
  end;
  dset_image.Post;

  IBOpenSQL(dset_tmp, 'select max(id) id_img from avr_image where id_zav='+IntToStr(F_ID_Zav));
  id_img:=dset_tmp.FieldByName('id_img').AsString;
  IBOpenSQL(dset_tmp, 'select * from avr_image where id='+id_img);
  SaveBlobToFile(dset_tmp.FieldByName('image'),dset_tmp.FieldByName('id').AsInteger);
  dset_tmp.Close;
end;

procedure TDM_AvrImage.DeleteImg;
var
  i: integer;
begin
  IBExecSQL(sql_tmp, 'delete from avr_image where id='+IntToStr(F_DeleteImgID));

  for i:=0 to F_FileList.Count-1 do
    if integer(F_FileList.Objects[i])=F_DeleteImgID then
    begin
      F_FileList.Delete(i);
      break;
    end;
end;

procedure TDM_AvrImage.DeleteImgFromDB(ID_Img: integer);
begin
  F_DeleteImgID:=ID_Img;
  DoAction(anDeleteImg);
end;

procedure TDM_AvrImage.PrintAvrImage(FileName: string);
var
  frPic: TfrPictureView;
  nomer, dt, adres: string;
begin
  frPic:=(frReport.FindObject('AvrPicture') as TfrPictureView);
  if not Assigned(frPic) then exit;
  frPic.Picture.LoadFromFile(FileName);

  GetZavNomerDtAdres(nomer, dt, adres);
  frVariables['nomer']:=nomer;
  frVariables['dt']:=dt;
  frVariables['adres']:=adres;

  frReport.PrepareReport;
  frReport.ShowReport;
end;

procedure TDM_AvrImage.GetZavNomerDtAdres(var nomer, dt, adres: string);
const
  SEL_SQL=
    ' select z.dt_in, z.nomer,'+
    ' (select adres from get_adres(z.id_ul1,z.id_ul2,z.kod_ul,z.dop_adr,z.id_dopadres)) adres'+
    ' from %s z where z.id=%d';
begin
  nomer:=''; dt:=''; adres:='';

  if tran_zav.InTransaction then
    tran_zav.Rollback;
  tran_zav.StartTransaction;
  try
    IBOpenSQL(dset_zav, Format(SEL_SQL, ['nzavjav', F_ID_Zav]));
    if dset_zav.Eof then
      IBOpenSQL(dset_zav, Format(SEL_SQL, ['zavjav', F_ID_Zav]));
    if not dset_zav.Eof then
    begin
      nomer:=dset_zav.FieldByName('nomer').AsString;
      dt:=dset_zav.FieldByName('dt_in').AsString;
      adres:=dset_zav.FieldByName('adres').AsString;
    end;
    tran_zav.Commit;
  except
    on E: Exception do
    begin
      tran_zav.Rollback;
      raise Exception.Create(E.Message+'(TDM_AvrImage.GetZavNomerDtAdres)');
    end;
  end;
end;

end.
