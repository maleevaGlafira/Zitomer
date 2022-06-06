inherited S_LeakF: TS_LeakF
  Left = 238
  Top = 131
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1074#1080#1076#1086#1074' '#1090#1077#1095#1080
  ClientHeight = 321
  ClientWidth = 378
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 378
    Height = 321
    inherited DataGrid_dgr: TRxDBGrid
      Width = 372
      Height = 241
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
      Top = 282
      Width = 372
    end
    inherited Panel3: TPanel
      Width = 372
      inherited Find_ed: TEdit
        Width = 312
      end
    end
  end
end
