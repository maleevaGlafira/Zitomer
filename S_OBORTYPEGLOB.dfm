inherited S_OBORTYPEGLOBF: TS_OBORTYPEGLOBF
  Caption = 'S_OBORTYPEGLOB'
  ClientWidth = 504
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 504
    inherited DataGrid_dgr: TRxDBGrid
      Width = 498
      Columns = <
        item
          Expanded = False
          FieldName = 'name_r'
          Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
          Width = 172
          Visible = True
        end>
    end
    inherited Panel2: TPanel
      Width = 498
    end
    inherited Panel3: TPanel
      Width = 498
      object bb_Params: TBitBtn
        Left = 396
        Top = 5
        Width = 75
        Height = 25
        Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
        TabOrder = 1
        OnClick = bb_ParamsClick
      end
    end
  end
end
