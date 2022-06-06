inherited S_RunwF: TS_RunwF
  Left = 261
  Top = 100
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1074#1099#1087#1086#1083#1085#1103#1102#1097#1080#1093' '#1088#1072#1073#1086#1090#1099
  ClientHeight = 383
  ClientWidth = 365
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 365
    Height = 383
    inherited DataGrid_dgr: TRxDBGrid
      Width = 359
      Height = 303
      DataSource = DM1.S_runw_sur
      Columns = <
        item
          Expanded = False
          FieldName = 'NAME_R'
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
          Width = 319
          Visible = True
        end>
    end
    inherited Panel2: TPanel
      Top = 344
      Width = 359
    end
    inherited Panel3: TPanel
      Width = 359
    end
  end
end
