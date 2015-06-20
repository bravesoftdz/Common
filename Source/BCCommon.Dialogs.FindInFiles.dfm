object FindInFilesDialog: TFindInFilesDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Find in Files'
  ClientHeight = 290
  ClientWidth = 499
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Padding.Left = 6
  Padding.Top = 6
  Padding.Right = 6
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelButtons: TBCPanel
    AlignWithMargins = True
    Left = 9
    Top = 246
    Width = 484
    Height = 41
    Margins.Right = 0
    Align = alBottom
    BevelOuter = bvNone
    Padding.Top = 8
    Padding.Bottom = 8
    TabOrder = 0
    SkinData.SkinSection = 'CHECKBOX'
    object ButtonFind: TButton
      Left = 329
      Top = 8
      Width = 75
      Height = 25
      Align = alRight
      Caption = '&Find'
      Default = True
      Enabled = False
      ModalResult = 1
      TabOrder = 0
    end
    object ButtonCancel: TButton
      AlignWithMargins = True
      Left = 409
      Top = 8
      Width = 75
      Height = 25
      Margins.Left = 5
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alRight
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object GroupBoxSearchOptions: TBCGroupBox
    Left = 6
    Top = 50
    Width = 487
    Height = 50
    Align = alTop
    Caption = ' Options'
    TabOrder = 1
    SkinData.SkinSection = 'GROUPBOX'
    Checked = False
    object StickyLabelCaseSensitive: TsStickyLabel
      Left = 12
      Top = 23
      Width = 69
      Height = 13
      Caption = 'Case sensitive'
      AttachTo = SliderCaseSensitive
      Gap = 8
    end
    object SliderCaseSensitive: TsSlider
      Left = 89
      Top = 19
      Width = 50
      AutoSize = True
      TabOrder = 0
      BoundLabel.Indent = 0
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clWindowText
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'Tahoma'
      BoundLabel.Font.Style = []
      BoundLabel.Layout = sclLeft
      BoundLabel.MaxWidth = 0
      BoundLabel.UseSkinColor = True
      ImageIndexOff = 0
      ImageIndexOn = 0
      FontOn.Charset = DEFAULT_CHARSET
      FontOn.Color = clWindowText
      FontOn.Height = -11
      FontOn.Name = 'Tahoma'
      FontOn.Style = []
      SliderOn = False
      SliderCaptionOn = 'Yes'
      SliderCaptionOff = 'No'
    end
  end
  object GroupBoxSearchDirectoryOptions: TBCGroupBox
    AlignWithMargins = True
    Left = 6
    Top = 103
    Width = 487
    Height = 142
    Margins.Left = 0
    Margins.Right = 0
    Align = alTop
    Caption = ' Search directory options '
    TabOrder = 2
    SkinData.SkinSection = 'GROUPBOX'
    Checked = False
    object PanelDirectoryComboBoxAndButton: TBCPanel
      AlignWithMargins = True
      Left = 12
      Top = 62
      Width = 463
      Height = 40
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 2
      Align = alTop
      AutoSize = True
      BevelOuter = bvNone
      TabOrder = 1
      SkinData.SkinSection = 'CHECKBOX'
      object PanelDirectoryButton: TBCPanel
        Left = 421
        Top = 0
        Width = 42
        Height = 40
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 1
        SkinData.SkinSection = 'CHECKBOX'
        object PanelDirectoryButton2: TBCPanel
          Left = 0
          Top = 19
          Width = 42
          Height = 21
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 0
          SkinData.SkinSection = 'CHECKBOX'
          object SpeedButtonDirectory: TBCSpeedButton
            Left = 0
            Top = 0
            Width = 21
            Height = 21
            Action = ActionDirectoryButtonClick
            Align = alLeft
            Flat = True
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000300000
              0033000000330000003300000033000000330000003300000033000000330000
              00330000003300000033000000330000002F00000000000000004598D1F24398
              D2FF4094D0FF3E92CFFF3E92CEFF3F92CEFF3F92CEFF3F92CEFF3F92CEFF3F92
              CEFF3F92CEFF3F92CEFF3F93CFFF4194CEF00000000E469AD3004499D2FF3F94
              D0FFABFBFFFF9BF3FFFF92F1FFFF93F1FFFF93F1FFFF93F1FFFF93F1FFFF93F1
              FFFF93F1FFFF93F1FFFFA6F8FFFF65B8E3FF31709D5F469AD3004398D2FF4FA6
              D9FF8EDAF5FFA2EEFFFF82E5FEFF84E5FEFF84E5FEFF85E6FEFF85E6FEFF85E6
              FEFF85E6FEFF84E6FEFF96EBFFFF8CD8F5FF3985BCB84499D2004296D1FF6BBE
              E8FF6DBDE6FFBBF2FFFF75DEFDFF77DEFCFF78DEFCFF7BDFFCFF7DDFFCFF7DDF
              FCFF7DDFFCFF7CDFFCFF80E0FDFFADF0FFFF4D9DD3FF0000000E4095D0FF8AD7
              F5FF44A1D8FFDDFDFFFFDAFAFFFFDBFAFFFFDEFAFFFF74DCFCFF76DBFAFF75DA
              FAFF74DAFAFF74DAFAFF72D9FAFFA1E8FFFF7CBFE6FF306F9C5E3E94D0FFABF0
              FFFF449DD6FF368CCBFF368CCBFF368CCBFF378BCBFF5CBEEAFF6FD9FBFF6AD6
              FAFF68D5F9FF67D4F9FF66D4F9FF82DEFCFFAAE0F6FF3885BCB93D92CFFFB9F4
              FFFF73DBFBFF6BCCF2FF6CCDF3FF6CCEF3FF6DCEF3FF479CD4FF56BAE9FFDAF8
              FFFFD7F6FFFFD6F6FFFFD5F6FFFFD5F7FFFFDBFCFFFF3E94D0FF3C92CFFFC0F3
              FFFF71DAFBFF74DBFBFF75DBFCFF75DBFCFF76DCFCFF73DAFAFF449CD4FF378C
              CBFF368CCBFF358CCCFF348DCCFF3890CEFF3D94D0FF4398D2EB3B92CFFFCAF6
              FFFF69D5F9FF6CD5F9FF6BD5F9FF69D5F9FF69D5FAFF6AD7FBFF68D4FAFF5EC7
              F1FF5EC7F2FF5DC8F2FFB4E3F8FF3D94D0FF3F8FC669469AD3003B92CFFFD5F7
              FFFF60D1F9FF61D0F8FFB4EBFDFFD9F6FFFFDAF8FFFFDAF8FFFFDBF9FFFFDCFA
              FFFFDCFAFFFFDCFBFFFFE0FFFFFF3E95D0FF4599D333469AD3003D94D0FFDCFC
              FFFFD8F7FFFFD8F7FFFFDBFAFFFF358ECDFF3991CEFF3A92CFFF3A92CFFF3A92
              CFFF3A92CFFF3B92CFFF3D94D0FF4398D2D7469AD300469AD3004398D2B03D94
              D0FF3A92CFFF3A92CFFF3D94D0FF4197D1D24398D2004498D2004498D2004498
              D2004498D2004499D2004499D300459AD300469AD300469AD300FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
            SkinData.SkinSection = 'TOOLBUTTON'
            ImageIndex = 0
          end
          object SpeedButtonDirectory2: TBCSpeedButton
            Left = 21
            Top = 0
            Width = 21
            Height = 21
            Action = ActionDirectoryItemsButtonClick
            Align = alRight
            Flat = True
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000FFFFFF000000
              0000000000000000000000000000000000000000000000000033000000330000
              0033000000000000000000000000000000000000000000000000FFFFFF000000
              00000000000000000024000000230000000000000000757371FF73716FFF7573
              71FF00000000000000000000002F000000230000000000000000FFFFFF000000
              0000000000236D6B69C16C6A69BF0000002F00000033716F6DFFEEECEBFF716F
              6DFF0000003300000033747270F16C6A69C00000002400000000FFFFFF000000
              00006F6D6BBFA19F9DFF9E9C9AFF706E6CEF716F6DFF898785FFE1DFDEFF8987
              85FF716F6DFF72706EFE9F9D9BFFA19F9DFF716F6DBD00000000FFFFFF000000
              00007A7876ED9F9D9BFFDFDDDBFFB8B6B4FFDBD9D7FFD8D6D4FFD6D4D2FFD8D6
              D4FFDBD9D7FFB8B6B4FFDFDDDBFF9F9D9BFF7A7876AF00000000FFFFFF000000
              000000000000767572FEB7B3B3FFD2D0CFFFD1CFCFFFD3D1D0FFD3D1D0FFD3D1
              D0FFD1CFCFFFD2D0CFFFB7B3B3FF757371EF0000000000000000FFFFFF000000
              003300000033787674FFD2D0CEFFCECCCAFFBEBCBAFF92908EFF8D8B89FF9290
              8EFFBEBCBAFFCECCCAFFD2D0CEFF787674FF0000003300000033FFFFFF00817F
              7DFF7C7A78FF9D9B99FFCCC9C8FFCCC9C8FF93918FFF7A78769C7E7C7A227A78
              769C93918FFFCCC9C8FFCCC9C8FF9D9B99FF7C7A78FF817F7DFFFFFFFF00817F
              7DFFE3E1DFFFDCDAD8FFC6C5C2FFC8C6C4FF8F8D8BFF4847463D000000074847
              463D8F8D8BFFC8C6C4FFC6C5C2FFDCDAD8FFE3E1DFFF817F7DFFFFFFFF008482
              80FF807E7CFF949492FFD0CECCFFC3C0BFFF93918FFF72716FAD3A39384E7271
              6FAD939290FFC3C0BFFFD0CECCFF949492FF807E7CFF848280FFFFFFFF000000
              000000000000807E7CFFDAD9D8FFBEBBB9FFBCB9B7FF94918EFF928F8DFF9491
              8FFFB3B2B0FFBEBBB9FFDBD9D8FF807E7CFF0000000000000000FFFFFF000000
              000000000023827F7DEFACAAA8FFC7C5C3FFBBB8B7FFBAB7B6FFBBB8B7FFBBB8
              B7FFBBB8B7FFC7C5C3FFACAAA8FF817F7DEF0000002300000000FFFFFF000000
              000082807EBAA4A2A0FFDAD8D7FFC6C4C2FFE4E3E1FFDBD9D7FFC2BFBEFFD7D5
              D4FFE4E3E1FFC5C4C2FFDAD8D7FFA4A2A0FF82807EBA00000000FFFFFF000000
              00008B8987B2B2B1AFFFAFAEACFF858381EB868482FF9A9897FFBCBAB7FF9A98
              97FF868482FF858381FEAFAEACFFB2B1AFFF8B8987B200000000FFFFFF000000
              0000000000008D8B89B28D8B89AF00000000000000008B8987FFE9E7E7FF8B89
              87FF00000000000000008C8A88ED8D8B89B00000000000000000FFFFFF000000
              00000000000000000000000000000000000000000000908E8CFF8F8D8BFF908E
              8CFF000000000000000000000000000000000000000000000000}
            SkinData.SkinSection = 'TOOLBUTTON'
            ExplicitLeft = 28
          end
        end
      end
      object PanelDirectoryComboBox: TBCPanel
        Left = 0
        Top = 0
        Width = 421
        Height = 40
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        BevelOuter = bvNone
        Padding.Right = 3
        TabOrder = 0
        SkinData.SkinSection = 'CHECKBOX'
        object ComboBoxDirectory: TBCComboBox
          Left = 0
          Top = 19
          Width = 418
          Height = 21
          Align = alBottom
          Alignment = taLeftJustify
          BoundLabel.Active = True
          BoundLabel.Caption = 'Directory'
          BoundLabel.Indent = 4
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          BoundLabel.Layout = sclTopLeft
          BoundLabel.MaxWidth = 0
          BoundLabel.UseSkinColor = True
          SkinData.SkinSection = 'COMBOBOX'
          VerticalAlignment = taAlignTop
          ItemIndex = -1
          Sorted = True
          TabOrder = 0
        end
      end
    end
    object PanelFileMaskComboBoxAndButton: TBCPanel
      AlignWithMargins = True
      Left = 12
      Top = 19
      Width = 463
      Height = 41
      Margins.Left = 10
      Margins.Top = 4
      Margins.Right = 10
      Margins.Bottom = 2
      Align = alTop
      AutoSize = True
      BevelOuter = bvNone
      TabOrder = 0
      SkinData.SkinSection = 'CHECKBOX'
      object PanelFileMaskComboBox: TBCPanel
        Left = 0
        Top = 0
        Width = 442
        Height = 41
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        BevelOuter = bvNone
        Padding.Right = 3
        TabOrder = 0
        SkinData.SkinSection = 'CHECKBOX'
        object ComboBoxFileMask: TBCComboBox
          Left = 0
          Top = 20
          Width = 439
          Height = 21
          Margins.Left = 10
          Margins.Top = 22
          Margins.Right = 10
          Align = alBottom
          Alignment = taLeftJustify
          BoundLabel.Active = True
          BoundLabel.Caption = 'File mask'
          BoundLabel.Indent = 4
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          BoundLabel.Layout = sclTopLeft
          BoundLabel.MaxWidth = 0
          BoundLabel.UseSkinColor = True
          DropDownCount = 20
          SkinData.SkinSection = 'COMBOBOX'
          VerticalAlignment = taAlignTop
          ItemIndex = -1
          Sorted = True
          TabOrder = 0
          Text = '*.*'
        end
      end
      object BCPanel2: TBCPanel
        Left = 442
        Top = 0
        Width = 21
        Height = 41
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 1
        SkinData.SkinSection = 'CHECKBOX'
        object BCPanel3: TBCPanel
          Left = 0
          Top = 20
          Width = 21
          Height = 21
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 0
          SkinData.SkinSection = 'CHECKBOX'
          object BCSpeedButton1: TBCSpeedButton
            Left = 0
            Top = 0
            Width = 21
            Height = 21
            Action = ActionFileMaskItemsButtonClick
            Align = alLeft
            Flat = True
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000FFFFFF000000
              0000000000000000000000000000000000000000000000000033000000330000
              0033000000000000000000000000000000000000000000000000FFFFFF000000
              00000000000000000024000000230000000000000000757371FF73716FFF7573
              71FF00000000000000000000002F000000230000000000000000FFFFFF000000
              0000000000236D6B69C16C6A69BF0000002F00000033716F6DFFEEECEBFF716F
              6DFF0000003300000033747270F16C6A69C00000002400000000FFFFFF000000
              00006F6D6BBFA19F9DFF9E9C9AFF706E6CEF716F6DFF898785FFE1DFDEFF8987
              85FF716F6DFF72706EFE9F9D9BFFA19F9DFF716F6DBD00000000FFFFFF000000
              00007A7876ED9F9D9BFFDFDDDBFFB8B6B4FFDBD9D7FFD8D6D4FFD6D4D2FFD8D6
              D4FFDBD9D7FFB8B6B4FFDFDDDBFF9F9D9BFF7A7876AF00000000FFFFFF000000
              000000000000767572FEB7B3B3FFD2D0CFFFD1CFCFFFD3D1D0FFD3D1D0FFD3D1
              D0FFD1CFCFFFD2D0CFFFB7B3B3FF757371EF0000000000000000FFFFFF000000
              003300000033787674FFD2D0CEFFCECCCAFFBEBCBAFF92908EFF8D8B89FF9290
              8EFFBEBCBAFFCECCCAFFD2D0CEFF787674FF0000003300000033FFFFFF00817F
              7DFF7C7A78FF9D9B99FFCCC9C8FFCCC9C8FF93918FFF7A78769C7E7C7A227A78
              769C93918FFFCCC9C8FFCCC9C8FF9D9B99FF7C7A78FF817F7DFFFFFFFF00817F
              7DFFE3E1DFFFDCDAD8FFC6C5C2FFC8C6C4FF8F8D8BFF4847463D000000074847
              463D8F8D8BFFC8C6C4FFC6C5C2FFDCDAD8FFE3E1DFFF817F7DFFFFFFFF008482
              80FF807E7CFF949492FFD0CECCFFC3C0BFFF93918FFF72716FAD3A39384E7271
              6FAD939290FFC3C0BFFFD0CECCFF949492FF807E7CFF848280FFFFFFFF000000
              000000000000807E7CFFDAD9D8FFBEBBB9FFBCB9B7FF94918EFF928F8DFF9491
              8FFFB3B2B0FFBEBBB9FFDBD9D8FF807E7CFF0000000000000000FFFFFF000000
              000000000023827F7DEFACAAA8FFC7C5C3FFBBB8B7FFBAB7B6FFBBB8B7FFBBB8
              B7FFBBB8B7FFC7C5C3FFACAAA8FF817F7DEF0000002300000000FFFFFF000000
              000082807EBAA4A2A0FFDAD8D7FFC6C4C2FFE4E3E1FFDBD9D7FFC2BFBEFFD7D5
              D4FFE4E3E1FFC5C4C2FFDAD8D7FFA4A2A0FF82807EBA00000000FFFFFF000000
              00008B8987B2B2B1AFFFAFAEACFF858381EB868482FF9A9897FFBCBAB7FF9A98
              97FF868482FF858381FEAFAEACFFB2B1AFFF8B8987B200000000FFFFFF000000
              0000000000008D8B89B28D8B89AF00000000000000008B8987FFE9E7E7FF8B89
              87FF00000000000000008C8A88ED8D8B89B00000000000000000FFFFFF000000
              00000000000000000000000000000000000000000000908E8CFF8F8D8BFF908E
              8CFF000000000000000000000000000000000000000000000000}
            SkinData.SkinSection = 'TOOLBUTTON'
          end
        end
      end
    end
    object BCPanel1: TBCPanel
      Left = 2
      Top = 104
      Width = 483
      Height = 27
      Align = alTop
      AutoSize = True
      BevelOuter = bvNone
      Padding.Top = 6
      TabOrder = 2
      SkinData.SkinSection = 'CHECKBOX'
      object StickyLabelIncludeSubdirectories: TsStickyLabel
        Left = 10
        Top = 10
        Width = 105
        Height = 13
        Caption = 'Include subdirectories'
        AttachTo = SliderIncludeSubDirectories
        Gap = 8
      end
      object SliderIncludeSubDirectories: TsSlider
        Left = 123
        Top = 6
        Width = 50
        AutoSize = True
        TabOrder = 0
        BoundLabel.Indent = 0
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -11
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
        BoundLabel.Layout = sclLeft
        BoundLabel.MaxWidth = 0
        BoundLabel.UseSkinColor = True
        ImageIndexOff = 0
        ImageIndexOn = 0
        FontOn.Charset = DEFAULT_CHARSET
        FontOn.Color = clWindowText
        FontOn.Height = -11
        FontOn.Name = 'Tahoma'
        FontOn.Style = []
        SliderCaptionOn = 'Yes'
        SliderCaptionOff = 'No'
      end
    end
  end
  object ComboBoxTextToFind: TBCComboBox
    AlignWithMargins = True
    Left = 6
    Top = 26
    Width = 487
    Height = 21
    Margins.Left = 0
    Margins.Top = 20
    Margins.Right = 0
    Align = alTop
    Alignment = taLeftJustify
    BoundLabel.Active = True
    BoundLabel.Caption = 'Text to find'
    BoundLabel.Indent = 4
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'Tahoma'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclTopLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
    SkinData.SkinSection = 'COMBOBOX'
    VerticalAlignment = taAlignTop
    ItemIndex = -1
    Sorted = True
    TabOrder = 3
    OnChange = ComboBoxTextToFindChange
  end
  object ActionList: TActionList
    Left = 434
    Top = 6
    object ActionDirectoryButtonClick: TAction
      ImageIndex = 0
      OnExecute = ActionDirectoryButtonClickExecute
    end
    object ActionFileMaskItemsButtonClick: TAction
      OnExecute = ActionFileMaskItemsButtonClickExecute
    end
    object ActionDirectoryItemsButtonClick: TAction
      OnExecute = ActionDirectoryItemsButtonClickExecute
    end
  end
end
