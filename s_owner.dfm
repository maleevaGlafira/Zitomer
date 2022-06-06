inherited S_OwnerF: TS_OwnerF
  Left = 292
  Top = 214
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1087#1088#1080#1085#1072#1076#1083#1077#1078#1085#1086#1089#1090#1080' '#1079#1072#1103#1074#1082#1080
  ClientHeight = 321
  ClientWidth = 491
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 491
    Height = 321
    inherited DataGrid_dgr: TRxDBGrid
      Width = 485
      Height = 241
      DataSource = DM1.s_owner_sur
      Columns = <
        item
          Expanded = False
          FieldName = 'NAME_R'
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Width = 180
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'list_OWNER_TYPE'
          Title.Alignment = taCenter
          Title.Caption = #1058#1080#1087
          Width = 85
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FOR_VEDOM'
          Title.Alignment = taCenter
          Title.Caption = #1042#1080#1076
          Width = 180
          Visible = True
        end>
    end
    inherited Panel2: TPanel
      Top = 282
      Width = 485
    end
    inherited Panel3: TPanel
      Width = 485
      inherited Find_ed: TEdit
        Width = 312
      end
    end
  end
end
