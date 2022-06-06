inherited S_MestF: TS_MestF
  Left = 252
  Top = 145
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1084#1077#1089#1090#1085#1086#1089#1090#1080' '#1087#1086#1074#1088#1077#1078#1076#1077#1085#1080#1081
  ClientHeight = 306
  ClientWidth = 448
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 448
    Height = 306
    inherited DataGrid_dgr: TRxDBGrid
      Width = 442
      Height = 226
      Columns = <
        item
          Expanded = False
          FieldName = 'NAME_R'
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
          Width = 323
          Visible = True
        end
        item
          DropDownRows = 5
          Expanded = False
          FieldName = 'VOSST_POKRYT'
          PickList.Strings = (
            #1053#1045#1042#1054#1057#1057#1058'.'
            #1042#1054#1057#1057#1058'.')
          Title.Caption = #1042#1086#1089#1089#1090'. '#1087#1086#1082#1088#1099#1090'.'
          Visible = True
        end>
    end
    inherited Panel2: TPanel
      Top = 267
      Width = 442
      inherited BExit: TSpeedButton
        Left = 407
      end
    end
    inherited Panel3: TPanel
      Width = 442
    end
  end
end
