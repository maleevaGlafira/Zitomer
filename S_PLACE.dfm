inherited S_PlaceF: TS_PlaceF
  Left = 257
  Top = 141
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1084#1077#1089#1090' '#1087#1086#1074#1088#1077#1078#1076#1077#1085#1080#1081
  ClientHeight = 297
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Height = 297
    inherited DataGrid_dgr: TRxDBGrid
      Height = 217
      DataSource = DM1.S_Place_sur
      Columns = <
        item
          Expanded = False
          FieldName = 'NAME_R'
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
          Width = 320
          Visible = True
        end>
    end
    inherited Panel2: TPanel
      Top = 258
    end
  end
end
