inherited S_RevsF: TS_RevsF
  Left = 260
  Top = 109
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1056#1069#1042#1057#1086#1074
  ClientHeight = 356
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Height = 356
    inherited DataGrid_dgr: TRxDBGrid
      Height = 276
      DataSource = DM1.S_Revs_sur
      Columns = <
        item
          Expanded = False
          FieldName = 'NAME_R'
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
          Width = 328
          Visible = True
        end>
    end
    inherited Panel2: TPanel
      Top = 317
    end
  end
end
