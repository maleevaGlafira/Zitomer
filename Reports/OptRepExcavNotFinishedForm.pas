unit OptRepExcavNotFinishedForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, StdCtrls, Buttons, BaseItemSelecterFrame,
  SelRevsFrame, SelDatePeriodFrame;

type
  Tfrm_OptRepExcavNotFinished = class(Tfrm_BaseOption)
    frame_SelDatePeriod1: Tframe_SelDatePeriod;
    frame_SelRevs1: Tframe_SelRevs;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure frame_SelRevs1btn_SelItemClick(Sender: TObject);
  private
    { Private declarations }
    f_revsid,F_revnames:String;
    F_startDate,f_endDate:TDate;
  public
    { Public declarations }
    property revnames:string read F_revnames;
    property revsid:string read f_revsid;
    property startDate:tDate read f_startDate;
    property endDate:TDate read f_endDate;

  end;

var
  frm_OptRepExcavNotFinished: Tfrm_OptRepExcavNotFinished;

implementation

{$R *.dfm}

procedure Tfrm_OptRepExcavNotFinished.BitBtn1Click(Sender: TObject);
begin
  inherited;
 if   frame_SelDatePeriod1.IsDatesCorrect then
 begin

  F_startDate:=frame_SelDatePeriod1.BeginDate;
  F_endDate:=frame_SelDatePeriod1.EndDate;
  if F_endDate-F_startDate>92 then
  begin
        Application.MessageBox( 'Можно выбрать период не более 3-х месяцев!!',
      'Внимание', MB_OK + MB_ICONWARNING );
 
  end
   else
  ModalResult := mrOk;
 end;
end;

procedure Tfrm_OptRepExcavNotFinished.BitBtn2Click(Sender: TObject);
begin
  inherited;
Close;
end;

procedure Tfrm_OptRepExcavNotFinished.frame_SelRevs1btn_SelItemClick(
  Sender: TObject);
begin
  inherited;
  frame_SelRevs1.btn_SelItemClick(Sender);
  f_revsid:=frame_SelRevs1.ItemSelecter.SelItemList.ItemsID;
  F_revnames:=frame_SelRevs1.ItemSelecter.SelItemList.ItemsName;

end;

end.
