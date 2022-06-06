inherited S_BrigF: TS_BrigF
  Left = 227
  Top = 123
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1076#1086#1083#1078#1085#1086#1089#1090#1085#1099#1093' '#1083#1080#1094
  ClientHeight = 252
  ClientWidth = 770
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 770
    Height = 252
    inherited DataGrid_dgr: TRxDBGrid
      Width = 764
      Height = 172
      DataSource = DM1.S_Brig_sur
      Columns = <
        item
          Color = clWhite
          Expanded = False
          FieldName = 'NAME_R'
          Title.Alignment = taCenter
          Title.Caption = #1060#1048#1054
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clBlack
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 336
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DOLGN'
          Title.Alignment = taCenter
          Title.Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100
          Width = 375
          Visible = True
        end>
    end
    inherited Panel2: TPanel
      Top = 213
      Width = 764
      inherited BExit: TSpeedButton
        Left = 327
      end
    end
    inherited Panel3: TPanel
      Width = 764
      inherited Find_ed: TEdit
        Width = 316
      end
    end
  end
end
