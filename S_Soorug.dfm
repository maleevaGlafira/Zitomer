inherited S_SOORUGF: TS_SOORUGF
  Left = 341
  Top = 174
  Caption = 'S_SOORUGF'
  ClientHeight = 467
  ClientWidth = 715
  DefaultMonitor = dmMainForm
  FormStyle = fsStayOnTop
  OldCreateOrder = True
  Visible = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 715
    Height = 467
    inherited DataGrid_dgr: TRxDBGrid
      Width = 709
      Height = 387
      DataSource = DM1.s_soorug_sur
      OnTitleClick = DataGrid_dgrTitleClick
      Columns = <
        item
          Expanded = False
          FieldName = 'NAME_R'
          Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
          Width = 359
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'look_object'
          Title.Caption = #1054#1073#1100#1077#1082#1090
          Width = 304
          Visible = True
        end>
    end
    inherited Panel2: TPanel
      Top = 428
      Width = 709
    end
    inherited Panel3: TPanel
      Width = 709
    end
  end
end
