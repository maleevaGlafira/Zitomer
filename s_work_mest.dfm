inherited s_work_mestF: Ts_work_mestF
  Left = 328
  Top = 309
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1086#1073#1103#1079#1072#1090#1077#1083#1100#1085#1099#1093' '#1088#1072#1073#1086#1090' '#1087#1086' '#1073#1083#1072#1075#1086#1091#1090#1088#1086#1081#1089#1090#1074#1091
  ClientHeight = 286
  ClientWidth = 591
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 591
    Height = 286
    inherited DataGrid_dgr: TRxDBGrid
      Width = 585
      Height = 206
      Columns = <
        item
          Expanded = False
          FieldName = 'list_MEST'
          Title.Alignment = taCenter
          Title.Caption = #1052#1077#1089#1090#1085#1086#1089#1090#1100
          Width = 241
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'listWORK'
          Title.Alignment = taCenter
          Title.Caption = #1056#1072#1073#1086#1090#1072
          Width = 311
          Visible = True
        end>
    end
    inherited Panel2: TPanel
      Top = 247
      Width = 585
    end
    inherited Panel3: TPanel
      Width = 585
    end
  end
end
