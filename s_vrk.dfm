inherited S_VRK_F: TS_VRK_F
  Left = 511
  Top = 183
  Caption = 'S_VRK_F'
  ClientHeight = 243
  ClientWidth = 567
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 567
    Height = 243
    inherited DataGrid_dgr: TRxDBGrid
      Width = 561
      Height = 163
      Columns = <
        item
          Expanded = False
          FieldName = 'listULIC'
          Title.Alignment = taCenter
          Title.Caption = #1059#1083#1080#1094#1072
          Width = 209
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NUM_DOM'
          Title.Alignment = taCenter
          Title.Caption = #1053#1086#1084#1077#1088' '#1076#1086#1084#1072
          Width = 82
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'listTVRK'
          Title.Alignment = taCenter
          Title.Caption = #1058#1080#1087
          Width = 104
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'listOPLACHENO'
          Title.Alignment = taCenter
          Title.Caption = #1054#1087#1083#1072#1095#1077#1085#1086
          Width = 61
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'N_VRK'
          Title.Alignment = taCenter
          Title.Caption = #8470' '#1082#1086#1083#1086#1085#1082#1080
          Visible = True
        end>
    end
    inherited Panel2: TPanel
      Top = 204
      Width = 561
    end
    inherited Panel3: TPanel
      Width = 561
    end
  end
end
