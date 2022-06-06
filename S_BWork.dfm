inherited S_BWorkF: TS_BWorkF
  Left = 355
  Top = 208
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1089#1083#1086#1078#1085#1099#1093' '#1088#1072#1073#1086#1090
  ClientHeight = 474
  ClientWidth = 549
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 549
    Height = 474
    inherited DataGrid_dgr: TRxDBGrid
      Width = 543
      Height = 162
      Align = alTop
      Columns = <
        item
          Expanded = False
          FieldName = 'name_r'
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Width = 319
          Visible = True
        end>
    end
    inherited Panel2: TPanel
      Top = 203
      Width = 543
      Height = 42
      Align = alTop
      inherited BExit: TSpeedButton
        Left = 495
      end
    end
    inherited Panel3: TPanel
      Width = 543
    end
    inline frame_BworkShief: Tframe_BworkShief
      Left = 3
      Top = 245
      Width = 543
      Height = 226
      Align = alClient
      TabOrder = 3
      inherited gb_Detail: TGroupBox
        Top = 5
        Width = 531
        Height = 212
        inherited sb_Add: TSpeedButton
          Left = 14
          Top = 177
          Width = 43
          Height = 26
          Anchors = [akLeft, akBottom]
        end
        inherited sb_Del: TSpeedButton
          Left = 54
          Top = 177
          Width = 40
          Height = 26
          Anchors = [akLeft, akBottom]
        end
        inherited pc_Detail: TPageControl
          Left = 6
          Top = 28
          Width = 517
          Height = 146
          inherited ts_Works: TTabSheet
            inherited dbg_Works: TDBGridEh
              Width = 509
              Height = 115
              Columns = <
                item
                  FieldName = 'WORK_NAME'
                  Footers = <>
                  Title.Caption = #1056#1072#1073#1086#1090#1072
                  Width = 201
                end
                item
                  FieldName = 'ED_IZM'
                  Footers = <>
                  Title.Caption = #1045#1076#1080#1085#1080#1094#1072' '#1080#1079#1084#1077#1088#1077#1085#1080#1103
                end
                item
                  FieldName = 'PLACE'
                  Footers = <>
                  Title.Caption = #1052#1077#1089#1090#1086
                end
                item
                  FieldName = 'DIAM'
                  Footers = <>
                  Title.Caption = #1044#1080#1072#1084#1077#1090#1088
                end>
            end
          end
          inherited ts_Maters: TTabSheet
            inherited dbg_Maters: TDBGridEh
              Width = 509
              Height = 115
              Columns = <
                item
                  FieldName = 'mater'
                  Footers = <>
                  Title.Caption = #1052#1072#1090#1077#1088#1080#1072#1083
                  Width = 228
                end
                item
                  FieldName = 'diam'
                  Footers = <>
                  Title.Caption = #1044#1080#1072#1084#1077#1090#1088
                  Width = 75
                end>
            end
          end
        end
      end
      inherited ds_Works: TDataSource
        Top = 88
      end
    end
  end
end
