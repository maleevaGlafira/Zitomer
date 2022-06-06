inherited s_ObjectF: Ts_ObjectF
  Left = 253
  Top = 279
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1086#1073#1098#1077#1082#1090#1086#1074
  ClientWidth = 559
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 559
    inherited DataGrid_dgr: TRxDBGrid
      Width = 553
      DataSource = DM1.s_object_sur
      Columns = <
        item
          Expanded = False
          FieldName = 'NAME_R'
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Width = 293
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'lp_ATTACH'
          Title.Alignment = taCenter
          Title.Caption = #1055#1088#1080#1085#1072#1076#1083#1077#1078#1085#1086#1089#1090#1100
          Width = 182
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'look_revs'
          Title.Caption = #1062#1077#1093
          Visible = True
        end>
    end
    inherited Panel2: TPanel
      Width = 553
    end
    inherited Panel3: TPanel
      Width = 553
    end
  end
end
