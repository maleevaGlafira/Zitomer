inherited S_RemontF: TS_RemontF
  Left = 365
  Top = 308
  Caption = #1042#1099#1087#1086#1083#1085#1077#1085#1080#1077' '#1088#1077#1084#1086#1085#1090#1072
  ClientWidth = 518
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 518
    inherited DataGrid_dgr: TRxDBGrid
      Width = 512
      DataSource = DM1.s_remont_sur
      Columns = <
        item
          Expanded = False
          FieldName = 'NAME_R'
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Width = 256
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'lp_REMONT_TYPE'
          Title.Alignment = taCenter
          Title.Caption = #1058#1080#1087
          Width = 186
          Visible = True
        end>
    end
    inherited Panel2: TPanel
      Width = 512
    end
    inherited Panel3: TPanel
      Width = 512
    end
  end
end
