inherited S_OborF: TS_OborF
  Left = 236
  Top = 125
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1084#1077#1093#1072#1085#1080#1079#1084#1086#1074
  ClientHeight = 279
  ClientWidth = 390
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 390
    Height = 279
    inherited DataGrid_dgr: TRxDBGrid
      Width = 384
      Height = 199
      Columns = <
        item
          Expanded = False
          FieldName = 'NAME_R'
          Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FIO'
          Title.Caption = #8470
          Width = 100
          Visible = True
        end>
    end
    inherited Panel2: TPanel
      Top = 240
      Width = 384
    end
    inherited Panel3: TPanel
      Width = 384
    end
  end
end
