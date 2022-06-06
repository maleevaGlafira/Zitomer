inherited S_FillF: TS_FillF
  Left = 220
  Top = 141
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1074#1080#1076#1086#1074' '#1079#1072#1089#1099#1087#1082#1080
  ClientHeight = 316
  ClientWidth = 377
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 377
    Height = 316
    inherited DataGrid_dgr: TRxDBGrid
      Width = 371
      Height = 236
      Columns = <
        item
          Expanded = False
          FieldName = 'NAME_R'
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Width = 334
          Visible = True
        end>
    end
    inherited Panel2: TPanel
      Top = 277
      Width = 371
    end
    inherited Panel3: TPanel
      Width = 371
      inherited Find_ed: TEdit
        Width = 312
      end
    end
  end
end
