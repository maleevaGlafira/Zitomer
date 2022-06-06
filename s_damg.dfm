inherited S_DamgF: TS_DamgF
  Left = 152
  Top = 83
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1090#1080#1087#1086#1074' '#1087#1086#1074#1088#1077#1078#1076#1077#1085#1080#1081
  ClientHeight = 349
  ClientWidth = 521
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 521
    Height = 349
    inherited DataGrid_dgr: TRxDBGrid
      Width = 515
      Height = 269
      DataSource = DM1.S_Damg_sur
      Columns = <
        item
          Expanded = False
          FieldName = 'NAME_R'
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Width = 326
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'list_PLACE'
          Title.Alignment = taCenter
          Title.Caption = #1052#1077#1089#1090#1086
          Width = 147
          Visible = True
        end>
    end
    inherited Panel2: TPanel
      Top = 310
      Width = 515
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
        OnCloseUp = S_Place_lcbCloseUp
        OnKeyDown = S_Place_lcbKeyDown
      end
    end
    inherited Panel3: TPanel
      Width = 515
    end
  end
end
