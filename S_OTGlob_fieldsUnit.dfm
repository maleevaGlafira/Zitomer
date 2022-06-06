inherited S_OTGlob_fieldsF: TS_OTGlob_fieldsF
  Left = 240
  Top = 219
  Caption = 'S_OTGlob_fieldsF'
  ClientHeight = 292
  ClientWidth = 562
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 562
    Height = 292
    inherited DataGrid_dgr: TRxDBGrid
      Width = 556
      Height = 212
      Columns = <
        item
          Expanded = False
          FieldName = 'name_r'
          Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
          Width = 226
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MEASURE'
          Title.Caption = #1077#1076'.'#1080#1079#1084'.'
          Visible = True
        end>
    end
    inherited Panel2: TPanel
      Top = 253
      Width = 556
    end
    inherited Panel3: TPanel
      Width = 556
      inherited Label4: TLabel
        Left = 438
        Visible = False
      end
      object Label1: TLabel [1]
        Left = 11
        Top = 12
        Width = 58
        Height = 13
        Caption = #1054#1073#1086#1073#1097'. '#1090#1080#1087
      end
      inherited Find_ed: TEdit
        Left = 481
        Width = 56
        Visible = False
      end
      object dbl_OborTypeGlob: TRxDBLookupCombo
        Left = 80
        Top = 8
        Width = 233
        Height = 21
        DropDownCount = 8
        LookupField = 'ID'
        LookupDisplay = 'NAME_R'
        LookupSource = DM1.s_obortypeglob_sur
        TabOrder = 1
        OnChange = dbl_OborTypeGlobChange
      end
    end
  end
end
