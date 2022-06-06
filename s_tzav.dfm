inherited S_TzavF: TS_TzavF
  Left = 515
  Top = 145
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1090#1080#1087#1086#1074' '#1079#1072#1103#1074#1086#1082
  ClientHeight = 278
  ClientWidth = 364
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 364
    Height = 278
    inherited DataGrid_dgr: TRxDBGrid
      Width = 358
      Height = 198
      DataSource = DM1.S_tzav_sur
      Columns = <
        item
          Expanded = False
          FieldName = 'NAME_R'
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
          Width = 228
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ISVIEZD'
          Title.Alignment = taCenter
          Title.Caption = #1042#1099#1077#1079#1076
          Width = 91
          Visible = True
        end>
    end
    inherited Panel2: TPanel
      Top = 239
      Width = 358
    end
    inherited Panel3: TPanel
      Width = 358
    end
  end
  inherited FindFd_pm: TPopupMenu
    Left = 160
    Top = 112
  end
  inherited FormPlacement2: TFormPlacement
    Left = 72
    Top = 92
  end
end
