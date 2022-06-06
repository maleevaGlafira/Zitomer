unit OptRepCloseExcavForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, StdCtrls, Buttons, SelDatePeriodFrame,
  BaseItemSelecterFrame, SelRevsFrame, SelMestFrame;

type
  Tfrm_RepClosedExcavOpt = class(Tfrm_BaseOption)
    frame_SelRevs1: Tframe_SelRevs;
    frame_SelDatePeriod1: Tframe_SelDatePeriod;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    frame_SelMest1: Tframe_SelMest;
    procedure frame_SelRevs1btn_SelItemClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure frame_SelMest1btn_SelItemClick(Sender: TObject);
  private
    { Private declarations }
    f_revsid,F_revnames:string;
    F_mestid, F_mestNames:string;
    F_startDate,F_endDate:TDate;
  public
    { Public declarations }
    property  revsid:string read  f_revsid;
    property revnames:string read F_revnames;
    property  mestid:string read F_mestid;
    property  mestNames:string read F_mestNames;
    property  startDate:TDate read F_startDate;
    property  endDate:TDate read F_endDate;
  end;

var
  frm_RepClosedExcavOpt: Tfrm_RepClosedExcavOpt;

implementation

{$R *.dfm}

procedure Tfrm_RepClosedExcavOpt.frame_SelRevs1btn_SelItemClick(Sender: TObject);
begin
  inherited;
frame_SelRevs1.btn_SelItemClick(Sender);
  f_revsid:=frame_SelRevs1.ItemSelecter.SelItemList.ItemsID;
  F_revnames:=frame_SelRevs1.ItemSelecter.SelItemList.ItemsName;
end;

procedure Tfrm_RepClosedExcavOpt.BitBtn1Click(Sender: TObject);
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

procedure Tfrm_RepClosedExcavOpt.frame_SelMest1btn_SelItemClick(Sender: TObject);
begin
  inherited;
  frame_SelMest1.btn_SelItemClick(Sender);
  F_mestid:=frame_SelMest1.ItemSelecter.SelItemList.ItemsID;
  F_mestNames:=frame_SelMest1.ItemSelecter.SelItemList.ItemsName;
end;

end.
