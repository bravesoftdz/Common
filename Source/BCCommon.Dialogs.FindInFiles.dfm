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
  OnCreate = FormCreate
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
      Top = 61
      Width = 463
      Height = 40
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 2
      Align = alTop
      AutoSize = True
      BevelOuter = bvNone
      TabOrder = 0
      SkinData.SkinSection = 'CHECKBOX'
      object PanelDirectoryButton: TBCPanel
        Left = 442
        Top = 0
        Width = 21
        Height = 40
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 1
        SkinData.SkinSection = 'CHECKBOX'
        object SpeedButtonDirectory: TBCSpeedButton
          Left = 0
          Top = 19
          Width = 21
          Height = 21
          Action = ActionFolderButtonClick
          Align = alBottom
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
      end
      object PanelDirectoryComboBox: TBCPanel
        Left = 0
        Top = 0
        Width = 442
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
          Width = 439
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
          TabOrder = 0
        end
      end
    end
    object ComboBoxFileMask: TBCComboBox
      AlignWithMargins = True
      Left = 12
      Top = 37
      Width = 463
      Height = 21
      Margins.Left = 10
      Margins.Top = 22
      Margins.Right = 10
      Align = alTop
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
      TabOrder = 1
      Text = '*.*'
    end
    object BCPanel1: TBCPanel
      Left = 2
      Top = 103
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
    TabOrder = 3
    OnKeyUp = ComboBoxTextToFindKeyUp
  end
  object ActionList: TActionList
    Left = 434
    Top = 6
    object ActionFolderButtonClick: TAction
      ImageIndex = 0
      OnExecute = ActionFolderButtonClickExecute
    end
  end
end
