inherited S_MatF: TS_MatF
  Left = 253
  Top = 154
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074
  ClientHeight = 230
  ClientWidth = 395
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 395
    Height = 230
    inherited DataGrid_dgr: TRxDBGrid
      Width = 389
      Height = 150
      DataSource = DM1.S_mat_sur
      Columns = <
        item
          Expanded = False
          FieldName = 'NAME_R'
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
          Width = 222
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ED_IZM'
          Title.Alignment = taCenter
          Title.Caption = #1045#1076'. '#1080#1079#1084'.'
          Width = 54
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ListDIAMPRESENT'
          Title.Alignment = taCenter
          Title.Caption = #1044#1080#1072#1084#1077#1090#1088
          Width = 72
          Visible = True
        end>
    end
    inherited Panel2: TPanel
      Top = 191
      Width = 389
    end
    inherited Panel3: TPanel
      Width = 389
    end
  end
end
