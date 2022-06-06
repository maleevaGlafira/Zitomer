inherited S_SodF: TS_SodF
  Left = 219
  Top = 108
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1089#1086#1076#1077#1088#1078#1072#1085#1080#1103' '#1079#1072#1103#1074#1086#1082
  ClientHeight = 346
  ClientWidth = 763
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 763
    Height = 346
    inherited DataGrid_dgr: TRxDBGrid
      Width = 757
      Height = 266
      OnMouseDown = DataGrid_dgrMouseDown
      Columns = <
        item
          Expanded = False
          FieldName = 'NAME_R'
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Width = 243
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'listTYPE'
          Title.Alignment = taCenter
          Title.Caption = #1058#1080#1087
          Width = 112
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'listPLACE'
          Title.Alignment = taCenter
          Title.Caption = #1052#1077#1089#1090#1086
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'listZAYAVL'
          Title.Alignment = taCenter
          Title.Caption = #1055#1088#1080#1085#1072#1076#1083#1077#1078#1085#1086#1089#1090#1100
          Width = 126
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'look_obortypeglob'
          Title.Alignment = taCenter
          Title.Caption = #1058#1080#1087' '#1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1103
          Visible = False
        end>
    end
    inherited Panel2: TPanel
      Top = 307
      Width = 757
      inherited BExit: TSpeedButton
        Left = 471
      end
      object S_Sah_lcb: TRxDBLookupCombo
        Left = 307
        Top = 10
        Width = 159
        Height = 21
        Hint = #1060#1080#1083#1100#1090#1088' '#1087#1086' '#1082#1072#1090#1077#1075#1086#1088#1080#1103#1084' (Del '#1080#1083#1080' BackSpace - '#1086#1095#1080#1089#1090#1082#1072' '#1092#1080#1083#1100#1088#1072')'
        DropDownCount = 8
        Anchors = [akLeft, akBottom]
        LookupField = 'ID'
        LookupDisplay = 'NAME_R'
        LookupSource = DM1.S_Sah_sur
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        Visible = False
        OnClick = S_Sah_lcbCloseUp
        OnCloseUp = S_Sah_lcbCloseUp
        OnKeyDown = S_Sah_lcbKeyDown
      end
    end
    inherited Panel3: TPanel
      Width = 757
      inherited Find_ed: TEdit
        Width = 456
      end
    end
  end
end
