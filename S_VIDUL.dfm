inherited s_vidulF: Ts_vidulF
  Left = 197
  Top = 72
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1074#1080#1076#1086#1074' '#1091#1083#1080#1094
  ClientHeight = 392
  ClientWidth = 371
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 371
    Height = 392
    inherited DataGrid_dgr: TRxDBGrid
      Width = 365
      Height = 312
      Columns = <
        item
          Expanded = False
          FieldName = 'NAME_R'
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Width = 329
          Visible = True
        end>
    end
    inherited Panel2: TPanel
      Top = 353
      Width = 365
    end
    inherited Panel3: TPanel
      Width = 365
      inherited Find_ed: TEdit
        Width = 312
      end
    end
  end
end
