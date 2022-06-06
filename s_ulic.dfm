inherited s_ulicF: Ts_ulicF
  Left = 310
  Top = 187
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1091#1083#1080#1094
  ClientHeight = 379
  ClientWidth = 501
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 501
    Height = 379
    inherited DataGrid_dgr: TRxDBGrid
      Width = 495
      Height = 299
      DataSource = DM1.s_ulic_sur
      OnDblClick = DataGrid_dgrDblClick
      OnMouseDown = DataGrid_dgrMouseDown
      Columns = <
        item
          Expanded = False
          FieldName = 'NAME_R'
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
          Width = 236
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'List_Place'
          Title.Alignment = taCenter
          Title.Caption = #1042#1080#1076
          Width = 82
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'List_Rayon'
          Title.Caption = #1052#1110#1089#1090#1086'/'#1057#1077#1083#1080#1097#1077
          Visible = True
        end>
    end
    inherited Panel2: TPanel
      Top = 340
      Width = 495
      inherited Finish_bv: TBevel
        Width = 156
      end
      inherited BExit: TSpeedButton
        Left = 459
      end
      inherited DBNav_dn: TDBNavigator
        BeforeAction = DBNav_dnBeforeAction
        OnClick = nil
      end
    end
    inherited Panel3: TPanel
      Width = 495
    end
  end
  object ExtPMenu_pm: TPopupMenu
    Left = 220
    Top = 148
    object N1_mi: TMenuItem
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1074#1080#1076#1086#1074' '#1091#1083#1080#1094
      OnClick = N1_miClick
    end
  end
end
