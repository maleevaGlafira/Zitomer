unit fReport;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, ComCtrls, Buttons, RxLookup, CheckLst;

type
  TfrmReport = class(TForm)
    lbRep: TListBox;
    dtBegin: TDateTimePicker;
    tmBegin: TDateTimePicker;
    dtEnd: TDateTimePicker;
    tmEnd: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    bBegin: TBitBtn;
    cbRayon: TRxDBLookupCombo;
    qRayon: TQuery;
    Label4: TLabel;
    dsRayon: TDataSource;
    cbRKS: TRxDBLookupCombo;
    qRKS: TQuery;
    Label5: TLabel;
    dsRKS: TDataSource;
    cbDiam: TRxDBLookupCombo;
    qDiam: TQuery;
    Label6: TLabel;
    dsDiam: TDataSource;
    cbULIC: TRxDBLookupCombo;
    qULIC: TQuery;
    Label7: TLabel;
    dsULIC: TDataSource;
    BB_Exit: TBitBtn;
    ckRKS: TCheckListBox;
    ckRayon: TCheckListBox;
    ckDiam: TCheckListBox;
    procedure FormCreate(Sender: TObject);
    procedure lbRepClick(Sender: TObject);
    procedure bBeginClick(Sender: TObject);
    procedure BB_ExitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    AR:array[0..100] of record
         name:string;
         fld:string;
    end;
  end;

var
  frmReport: TfrmReport;

implementation
uses datam, support, reportex, fPreview;

{$R *.DFM}

procedure TfrmReport.FormCreate(Sender: TObject);
var i:integer;
    s:string;
begin
//  ShortDateFormat:='dd.mm.yyyy';
  dtBegin.Date:=date-1;
  dtEnd.Date:=date;
  chdir(ExePathSlash);
  lbRep.items.LoadFromFile('report\report.txt');
  for i:=0 to lbRep.items.count-1 do begin
    s:=trim(lbRep.items[i]);
    lbRep.items[i]:=trim(CutWord(s,'|'));
    AR[i].name:=trim(CutWord(s,'|'));
    AR[i].fld:=trim(s);
  end;
  lbRep.itemindex:=0;
  lbRepClick(nil);
end;

procedure TfrmReport.lbRepClick(Sender: TObject);
begin
  dtBegin.Visible:=pos('0',AR[lbRep.itemindex].fld)>0;
  tmBegin.Visible:=pos('1',AR[lbRep.itemindex].fld)>0;
  dtEnd.Visible:=pos('2',AR[lbRep.itemindex].fld)>0;
  tmEnd.Visible:=pos('3',AR[lbRep.itemindex].fld)>0;
  cbRayon.Visible:=pos('4',AR[lbRep.itemindex].fld)>0;
  cbRKS.Visible:=pos('5',AR[lbRep.itemindex].fld)>0;
  cbDiam.Visible:=pos('6',AR[lbRep.itemindex].fld)>0;
  cbULIC.Visible:=pos('7',AR[lbRep.itemindex].fld)>0;
  ckRayon.Visible:=pos('8',AR[lbRep.itemindex].fld)>0;
  ckRKS.Visible:=pos('9',AR[lbRep.itemindex].fld)>0;

  label3.visible:=dtBegin.Visible or tmBegin.Visible;
  label2.visible:=dtEnd.Visible or tmEnd.Visible;
  label1.visible:=label3.visible or label2.visible;
  label4.visible:=cbRayon.Visible or ckRayon.Visible;
  label5.visible:=cbRKS.Visible or ckRKS.Visible;
  label6.visible:=cbDiam.Visible;
  label7.visible:=cbULIC.Visible;

  qULIC.active:=cbULIC.Visible;
  qRKS.active:=cbRKS.Visible or ckRKS.Visible;
  qDiam.active:=cbDiam.Visible;
  qRayon.active:=cbRayon.Visible or ckRayon.Visible;

  if ckRayon.Visible and (ckRayon.Items.Count=0)
  then begin
    qRayon.First;
    while not qRayon.eof do begin
      ckRayon.Items.AddObject(qRayon.fieldbyname('name_r').asstring,pointer(qRayon.fieldbyname('id').asInteger));
      qRayon.next
    end
  end;
  if ckRKS.Visible and (ckRKS.Items.Count=0)
  then begin
    qRKS.First;
    while not qRKS.eof do begin
      ckRKS.Items.AddObject(qRKS.fieldbyname('name_r').asstring,pointer(qRKS.fieldbyname('id').asInteger));
      qRKS.next
    end
  end;

end;

procedure TfrmReport.bBeginClick(Sender: TObject);
var i:dword;
    s:string;
    j:integer;
begin
  frmPreview:=TfrmPreview.Create(self);
  with frmPreview do begin
    show;
    RP.ClearScript;
    RP.LoadScript('report\'+AR[lbRep.itemindex].name);
    RP.Evaluate(format('@0 %s',[datetimetostr(dtBegin.date,'dd.mm.yyyy')]));
    RP.Evaluate(format('@1 %s',[datetimetostr(tmBegin.time,'hh:mm')]));
    RP.Evaluate(format('@2 %s',[datetimetostr(dtEnd.date,'dd.mm.yyyy')]));
    RP.Evaluate(format('@3 %s',[datetimetostr(tmEnd.time,'hh:mm')]));
    if qRayon.active
    then RP.Evaluate(format('@4 %d',[qRayon.FieldByName('id').asInteger]));
    if qRKS.active
    then RP.Evaluate(format('@5 =%d',[qRKS.FieldByName('id').asInteger]));
    if qDiam.active
    then RP.Evaluate(format('@6 %d',[qDiam.FieldByName('id').asInteger]));
    if qULIC.active
    then RP.Evaluate(format('@7 %d',[qULIC.FieldByName('id').asInteger]));

    if ckRKS.Visible
    then begin
      s:='';
      for j:=0 to ckRKS.items.count-1 do
      if ckRKS.Checked[j]
      then s:=s+','+inttostr(integer(ckRKS.Items.Objects[j]));
      delete(s,1,1);
      if s<>''
      then RP.Evaluate(format('@5 ''in (%s)''',[s]))
      else  RP.Evaluate('@5 <>-1');
    end;

    if ckRayon.Visible
    then begin
      s:='';
      for j:=0 to ckRayon.items.count-1 do
      if ckRayon.Checked[j]
      then s:=s+','+inttostr(integer(ckRayon.Items.Objects[j]));
      delete(s,1,1);
      if s<>''
      then RP.Evaluate(format('@4 ''in (%s)''',[s]))
      else  RP.Evaluate('@4 <>-1');
    end;

    i:=gettickcount;
    RP.Print;
    showpage(1);
    i:=gettickcount-i;
    caption:=frmPreview.caption+format(' (גûהאם חא %1.1f סוך.)',[i/1000]);
    hide;
    showmodal
  end
end;

procedure TfrmReport.BB_ExitClick(Sender: TObject);
begin
 CLOSE
end;

procedure TfrmReport.FormShow(Sender: TObject);
begin
  Caption:='־עקועû';
end;

end.
