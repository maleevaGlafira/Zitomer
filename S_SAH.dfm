inherited S_SahF: TS_SahF
  Left = 265
  Top = 137
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1082#1086#1083#1086#1085#1086#1082' '#1096#1072#1093#1084#1072#1090#1082#1080
  ClientHeight = 318
  ClientWidth = 370
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 370
    Height = 318
    inherited DataGrid_dgr: TRxDBGrid
      Width = 364
      Height = 238
      DataSource = DM1.S_Sah_sur
      Columns = <
        item
          Expanded = False
          FieldName = 'NAME_R'
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
          Width = 324
          Visible = True
        end>
    end
    inherited Panel2: TPanel
      Top = 279
      Width = 364
      inherited BHide: TSpeedButton
        Visible = False
      end
    end
    inherited Panel3: TPanel
      Width = 364
    end
  end
end
