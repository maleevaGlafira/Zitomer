inherited S_PumpF: TS_PumpF
  Left = 228
  Top = 134
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1084#1077#1090#1086#1076#1086#1074' '#1086#1090#1082#1072#1095#1082#1080
  ClientHeight = 343
  ClientWidth = 671
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 671
    Height = 343
    inherited DataGrid_dgr: TRxDBGrid
      Width = 665
      Height = 263
      Columns = <
        item
          Expanded = False
          FieldName = 'NAME_R'
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Width = 334
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'otv'
          Title.Caption = #1042#1110#1076#1087#1086#1074#1110#1076#1087#1083#1100#1085#1080#1081
          Width = 157
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'tel_otv'
          Title.Caption = #1058#1077#1083#1077#1092#1086#1085
          Width = 138
          Visible = True
        end>
    end
    inherited Panel2: TPanel
      Top = 304
      Width = 665
    end
    inherited Panel3: TPanel
      Width = 665
      inherited Find_ed: TEdit
        Width = 312
      end
    end
  end
end
