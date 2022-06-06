inherited S_WorkF: TS_WorkF
  Left = 180
  Top = 323
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1088#1072#1073#1086#1090
  ClientHeight = 378
  ClientWidth = 906
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 906
    Height = 378
    inherited DataGrid_dgr: TRxDBGrid
      Width = 900
      Height = 298
      OnDblClick = DataGrid_dgrDblClick
      OnMouseDown = DataGrid_dgrMouseDown
      Columns = <
        item
          Expanded = False
          FieldName = 'NAME_R'
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
          Width = 286
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ED_IZM'
          Title.Alignment = taCenter
          Title.Caption = #1045#1076'. '#1080#1079#1084'.'
          Width = 89
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'List_Place'
          Title.Alignment = taCenter
          Title.Caption = #1052#1077#1089#1090#1086
          Width = 147
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'list_WORK_TYPE'
          Title.Alignment = taCenter
          Title.Caption = #1058#1080#1087' '#1088#1072#1073#1086#1090#1099
          Width = 181
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'look_obortypeglob'
          Title.Alignment = taCenter
          Title.Caption = #1054#1073#1086#1073#1097#1105#1085#1085#1099#1081' '#1090#1080#1087' '#1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1103
          Width = 192
          Visible = True
        end>
    end
    inherited Panel2: TPanel
      Top = 339
      Width = 900
      inherited BExit: TSpeedButton
        Left = 479
      end
      object S_Place_lcb: TRxDBLookupCombo
        Left = 307
        Top = 9
        Width = 166
        Height = 22
        Hint = #1060#1080#1083#1100#1090#1088' '#1087#1086' '#1082#1072#1090#1077#1075#1086#1088#1080#1103#1084' (Del '#1080#1083#1080' BackSpace - '#1086#1095#1080#1089#1090#1082#1072' '#1092#1080#1083#1100#1088#1072')'
        DropDownCount = 8
        Anchors = [akLeft, akBottom]
        LookupField = 'ID'
        LookupDisplay = 'NAME_R'
        LookupSource = DM1.S_Place_sur
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = S_Place_lcbClick
        OnCloseUp = S_Place_lcbClick
        OnKeyDown = S_Place_lcbKeyDown
      end
    end
    inherited Panel3: TPanel
      Width = 900
    end
  end
  object ExtPMenu_pm: TPopupMenu
    Left = 220
    Top = 148
    object N1_mi: TMenuItem
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1084#1077#1089#1090' '#1087#1086#1074#1088#1077#1078#1076#1077#1085#1080#1081
      OnClick = N1_miClick
    end
  end
end
