inherited TableLogF: TTableLogF
  Left = 251
  Top = 163
  Caption = #1048#1089#1090#1086#1088#1080#1103' '#1080#1079#1084#1077#1085#1077#1085#1080#1081
  ClientHeight = 333
  ClientWidth = 585
  Menu = nil
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 585
    Height = 333
    object BDateFilter: TSpeedButton [0]
      Left = 357
      Top = 247
      Width = 37
      Height = 26
      Hint = #1055#1088#1080#1084#1077#1085#1080#1090#1100' '#1092#1080#1083#1100#1090#1088' '#1087#1086' '#1076#1072#1090#1077
      Flat = True
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = BDateFilterClick
    end
    inherited DataGrid_dgr: TRxDBGrid
      Width = 579
      Height = 200
      Align = alTop
      Columns = <
        item
          Expanded = False
          FieldName = 'USER_NAME'
          Title.Alignment = taCenter
          Title.Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
          Width = 96
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'OLD_VALUE'
          Title.Alignment = taCenter
          Title.Caption = #1057#1090#1072#1088#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077
          Width = 172
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NEW_VALUE'
          Title.Alignment = taCenter
          Title.Caption = #1053#1086#1074#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077
          Width = 183
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATE_CHANGE'
          Title.Alignment = taCenter
          Title.Caption = #1044#1072#1090#1072
          Width = 87
          Visible = True
        end>
    end
    inherited Panel2: TPanel
      Top = 294
      Width = 579
      inherited BDel: TSpeedButton
        Left = 120
        Visible = False
      end
      inherited BNew: TSpeedButton
        Left = 160
        Visible = False
      end
      inherited BHide: TSpeedButton
        Left = 200
        Visible = False
      end
      inherited Bevel2: TBevel
        Left = 37
      end
      inherited BAutoRefr: TSpeedButton
        Left = 256
        Visible = False
      end
      inherited BPrint: TSpeedButton
        Left = 410
      end
      inherited Finish_bv: TBevel
        Left = 78
      end
      inherited BExit: TSpeedButton
        Left = 541
      end
      object BClearDic: TSpeedButton [9]
        Left = 43
        Top = 6
        Width = 29
        Height = 26
        Hint = #1054#1095#1080#1089#1090#1080#1090#1100' '#1078#1091#1088#1085#1072#1083
        Flat = True
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500005000555
          555557777F777555F55500000000555055557777777755F75555005500055055
          555577F5777F57555555005550055555555577FF577F5FF55555500550050055
          5555577FF77577FF555555005050110555555577F757777FF555555505099910
          555555FF75777777FF555005550999910555577F5F77777775F5500505509990
          3055577F75F77777575F55005055090B030555775755777575755555555550B0
          B03055555F555757575755550555550B0B335555755555757555555555555550
          BBB35555F55555575F555550555555550BBB55575555555575F5555555555555
          50BB555555555555575F555555555555550B5555555555555575}
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = BClearDicClick
      end
      inherited DBNav_dn: TDBNavigator
        Left = 82
        Visible = False
      end
      object Users_lcb: TRxDBLookupCombo
        Left = 87
        Top = 8
        Width = 316
        Height = 22
        DropDownCount = 8
        DisplayEmpty = '< '#1074#1089#1077' >'
        LookupField = 'ID'
        LookupDisplay = 'NAME_R;DOLGN'
        LookupSource = DM1.Users_sur
        TabOrder = 1
        OnCloseUp = Users_lcbCloseUp
      end
    end
    inherited Panel3: TPanel
      Width = 579
      inherited Find_ed: TEdit
        Width = 514
      end
    end
    inline Frm_Dt: TFrm_Date
      Left = 3
      Top = 248
      Width = 350
      Height = 25
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      inherited Label1: TLabel
        Left = 2
        Top = 5
        Width = 7
        Height = 13
        Font.Height = -12
      end
      inherited Label2: TLabel
        Left = 174
        Top = 7
        Width = 12
        Height = 13
        Font.Height = -12
      end
      inherited DE_In: TDateEdit
        Left = 14
        Width = 81
        Height = 18
        Font.Height = -12
        ButtonWidth = 17
      end
      inherited Te_in: TDateTimePicker
        Left = 98
        Width = 72
        Height = 21
        Font.Height = -12
      end
      inherited DE_Out: TDateEdit
        Left = 190
        Width = 82
        Height = 18
        Font.Height = -12
        ButtonWidth = 17
      end
      inherited Te_Out: TDateTimePicker
        Left = 275
        Width = 65
        Height = 21
        Font.Height = -12
      end
    end
  end
end
