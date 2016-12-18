inherited ReplaceDialog: TReplaceDialog
  Caption = 'Replace'
  ClientHeight = 440
  ClientWidth = 369
  Padding.Left = 6
  Padding.Top = 6
  Padding.Right = 6
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBoxOptions: TBCGroupBox [0]
    AlignWithMargins = True
    Left = 6
    Top = 124
    Width = 357
    Height = 129
    Margins.Left = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alTop
    Caption = ' Options'
    TabOrder = 4
    TabStop = True
    SkinData.SkinSection = 'GROUPBOX'
    object StickyLabelCaseSensitive: TsStickyLabel
      Left = 12
      Top = 23
      Width = 102
      Height = 13
      AutoSize = False
      Caption = 'Case sensitive'
      AttachTo = SliderCaseSensitive
      Gap = 8
    end
    object StickyLabelPromptOnReplace: TsStickyLabel
      Left = 12
      Top = 48
      Width = 102
      Height = 13
      AutoSize = False
      Caption = 'Prompt on replace'
      AttachTo = SliderPromptOnReplace
      Gap = 8
    end
    object StickyLabelSelectedOnly: TsStickyLabel
      Left = 12
      Top = 73
      Width = 102
      Height = 13
      AutoSize = False
      Caption = 'Selected only'
      AttachTo = SliderSelectedOnly
      Gap = 8
    end
    object StickyLabelWholeWordsOnly: TsStickyLabel
      Left = 12
      Top = 98
      Width = 102
      Height = 13
      AutoSize = False
      Caption = 'Whole words only'
      AttachTo = SliderWholeWordsOnly
      Gap = 8
    end
    object SliderCaseSensitive: TsSlider
      Left = 122
      Top = 19
      Width = 50
      AutoSize = True
      TabOrder = 0
      BoundLabel.Indent = 6
      ImageIndexOff = 0
      ImageIndexOn = 0
      FontOn.Charset = DEFAULT_CHARSET
      FontOn.Color = clWindowText
      FontOn.Height = -11
      FontOn.Name = 'Tahoma'
      FontOn.Style = []
      SliderCaptionOn = 'Yes'
      SliderCaptionOff = 'No'
      SliderOn = False
      KeepThumbAspectRatio = False
    end
    object SliderPromptOnReplace: TsSlider
      Left = 122
      Top = 44
      Width = 50
      AutoSize = True
      TabOrder = 1
      BoundLabel.Indent = 6
      ImageIndexOff = 0
      ImageIndexOn = 0
      FontOn.Charset = DEFAULT_CHARSET
      FontOn.Color = clWindowText
      FontOn.Height = -11
      FontOn.Name = 'Tahoma'
      FontOn.Style = []
      SliderCaptionOn = 'Yes'
      SliderCaptionOff = 'No'
      KeepThumbAspectRatio = False
    end
    object SliderSelectedOnly: TsSlider
      Left = 122
      Top = 69
      Width = 50
      AutoSize = True
      TabOrder = 2
      BoundLabel.Indent = 6
      ImageIndexOff = 0
      ImageIndexOn = 0
      FontOn.Charset = DEFAULT_CHARSET
      FontOn.Color = clWindowText
      FontOn.Height = -11
      FontOn.Name = 'Tahoma'
      FontOn.Style = []
      SliderCaptionOn = 'Yes'
      SliderCaptionOff = 'No'
      SliderOn = False
      KeepThumbAspectRatio = False
    end
    object SliderWholeWordsOnly: TsSlider
      Left = 122
      Top = 94
      Width = 50
      AutoSize = True
      TabOrder = 3
      BoundLabel.Indent = 6
      ImageIndexOff = 0
      ImageIndexOn = 0
      FontOn.Charset = DEFAULT_CHARSET
      FontOn.Color = clWindowText
      FontOn.Height = -11
      FontOn.Name = 'Tahoma'
      FontOn.Style = []
      SliderCaptionOn = 'Yes'
      SliderCaptionOff = 'No'
      SliderOn = False
      KeepThumbAspectRatio = False
    end
  end
  object PanelSearchForComboBox: TBCPanel [1]
    Left = 6
    Top = 6
    Width = 357
    Height = 42
    Align = alTop
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 0
    SkinData.SkinSection = 'CHECKBOX'
    object PanelSearchForClient: TBCPanel
      AlignWithMargins = True
      Left = 0
      Top = 0
      Width = 333
      Height = 42
      Margins.Left = 0
      Margins.Top = 0
      Margins.Bottom = 0
      Align = alClient
      AutoSize = True
      BevelOuter = bvNone
      TabOrder = 0
      SkinData.SkinSection = 'CHECKBOX'
      object ComboBoxSearchFor: TBCComboBox
        Left = 0
        Top = 21
        Width = 333
        Height = 21
        Align = alBottom
        Alignment = taLeftJustify
        BoundLabel.Active = True
        BoundLabel.Indent = 4
        BoundLabel.Caption = 'Search for'
        BoundLabel.Layout = sclTopLeft
        SkinData.SkinSection = 'COMBOBOX'
        VerticalAlignment = taAlignTop
        ItemIndex = -1
        TabOrder = 0
        OnChange = ComboBoxSearchForChange
        UseMouseWheel = False
      end
    end
    object PanelTextToFindRight: TBCPanel
      Left = 336
      Top = 0
      Width = 21
      Height = 42
      Align = alRight
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 1
      SkinData.SkinSection = 'CHECKBOX'
      object PanelTextToFindButton: TBCPanel
        Left = 0
        Top = 21
        Width = 21
        Height = 21
        Align = alBottom
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        SkinData.SkinSection = 'CHECKBOX'
        object SpeedButtonSearchEngine: TBCSpeedButton
          AlignWithMargins = True
          Left = 0
          Top = 0
          Width = 21
          Height = 21
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 6
          Margins.Bottom = 0
          Action = ActionSearchEngine
          Align = alLeft
          Flat = True
          SkinData.SkinSection = 'TOOLBUTTON'
          Images = ImagesDataModule.ImageListSmall
          ImageIndex = 143
        end
      end
    end
  end
  object PanelReplaceWith: TBCPanel [2]
    Left = 6
    Top = 48
    Width = 357
    Height = 26
    Align = alTop
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    SkinData.SkinSection = 'CHECKBOX'
    object RadioButtonReplaceWith: TBCRadioButton
      AlignWithMargins = True
      Left = 0
      Top = 0
      Width = 81
      Height = 26
      Margins.Left = 0
      Margins.Top = 0
      Margins.Bottom = 0
      Align = alLeft
      BiDiMode = bdLeftToRight
      Caption = 'Replace with'
      Checked = True
      ParentBiDiMode = False
      ParentColor = False
      TabOrder = 0
      TabStop = True
      OnClick = RadioButtonReplaceWithClick
      SkinData.SkinSection = 'CHECKBOX'
    end
  end
  object PanelReplaceWithComboBox: TBCPanel [3]
    Left = 6
    Top = 74
    Width = 357
    Height = 21
    Align = alTop
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 2
    SkinData.SkinSection = 'PANEL'
    object ComboBoxReplaceWith: TBCComboBox
      Left = 0
      Top = 0
      Width = 357
      Height = 21
      Align = alClient
      Alignment = taLeftJustify
      BoundLabel.Indent = 4
      BoundLabel.Layout = sclTopLeft
      SkinData.SkinSection = 'COMBOBOX'
      VerticalAlignment = taAlignTop
      ItemIndex = -1
      TabOrder = 0
      UseMouseWheel = False
    end
  end
  object PanelButtons: TBCPanel [4]
    AlignWithMargins = True
    Left = 9
    Top = 396
    Width = 354
    Height = 41
    Margins.Right = 0
    Align = alBottom
    BevelOuter = bvNone
    Padding.Top = 8
    Padding.Bottom = 8
    TabOrder = 6
    SkinData.SkinSection = 'CHECKBOX'
    object ButtonOK: TBCButton
      AlignWithMargins = True
      Left = 119
      Top = 8
      Width = 75
      Height = 25
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 5
      Margins.Bottom = 0
      Align = alRight
      Caption = 'OK'
      Default = True
      Enabled = False
      ModalResult = 1
      TabOrder = 0
      SkinData.SkinSection = 'BUTTON'
    end
    object ButtonReplaceAll: TBCButton
      AlignWithMargins = True
      Left = 199
      Top = 8
      Width = 75
      Height = 25
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 5
      Margins.Bottom = 0
      Align = alRight
      Caption = 'Replace all'
      Enabled = False
      ModalResult = 6
      TabOrder = 1
      SkinData.SkinSection = 'BUTTON'
    end
    object ButtonCancel: TBCButton
      Left = 279
      Top = 8
      Width = 75
      Height = 25
      Align = alRight
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 2
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object GroupBoxReplaceIn: TBCGroupBox [5]
    Left = 6
    Top = 323
    Width = 357
    Height = 70
    Align = alTop
    BiDiMode = bdLeftToRight
    Caption = ' Replace in'
    ParentBiDiMode = False
    TabOrder = 5
    TabStop = True
    SkinData.SkinSection = 'GROUPBOX'
    object RadioButtonWholeFile: TBCRadioButton
      Left = 12
      Top = 20
      Width = 67
      Height = 20
      Caption = 'Whole file'
      Checked = True
      TabOrder = 0
      TabStop = True
      SkinData.SkinSection = 'CHECKBOX'
    end
    object RadioButtonAllOpenFiles: TBCRadioButton
      Left = 12
      Top = 41
      Width = 80
      Height = 20
      Caption = 'All open files'
      TabOrder = 1
      SkinData.SkinSection = 'CHECKBOX'
    end
  end
  object PanelDeleteLine: TBCPanel [6]
    Left = 6
    Top = 95
    Width = 357
    Height = 26
    Align = alTop
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 3
    SkinData.SkinSection = 'CHECKBOX'
    object RadioButtonDeleteLine: TBCRadioButton
      AlignWithMargins = True
      Left = 0
      Top = 0
      Width = 70
      Height = 26
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alLeft
      BiDiMode = bdLeftToRight
      Caption = 'Delete line'
      ParentBiDiMode = False
      ParentColor = False
      TabOrder = 0
      TabStop = True
      OnClick = RadioButtonDeleteLineClick
      SkinData.SkinSection = 'CHECKBOX'
    end
  end
  object BCPanel1: TBCPanel [7]
    Left = 6
    Top = 253
    Width = 357
    Height = 70
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 7
    SkinData.SkinSection = 'CHECKBOX'
    object GroupBoxDirection: TBCGroupBox
      Left = 0
      Top = 0
      Width = 175
      Height = 70
      Align = alLeft
      Anchors = [akLeft, akTop, akRight, akBottom]
      BiDiMode = bdLeftToRight
      Caption = ' Direction '
      ParentBiDiMode = False
      TabOrder = 0
      TabStop = True
      SkinData.SkinSection = 'GROUPBOX'
      object RadioButtonDirectionForward: TBCRadioButton
        Left = 12
        Top = 20
        Width = 60
        Height = 20
        Caption = 'Forward'
        Checked = True
        TabOrder = 0
        TabStop = True
        SkinData.SkinSection = 'CHECKBOX'
      end
      object RadioButtonDirectionBackward: TBCRadioButton
        Left = 12
        Top = 41
        Width = 66
        Height = 20
        Caption = 'Backward'
        TabOrder = 1
        SkinData.SkinSection = 'CHECKBOX'
      end
    end
    object GroupBoxOrigin: TBCGroupBox
      Left = 182
      Top = 0
      Width = 175
      Height = 70
      Align = alRight
      BiDiMode = bdLeftToRight
      Caption = ' Origin '
      ParentBiDiMode = False
      TabOrder = 1
      TabStop = True
      SkinData.SkinSection = 'GROUPBOX'
      object RadioButtonOriginFromCursor: TBCRadioButton
        Left = 12
        Top = 20
        Width = 77
        Height = 20
        Caption = 'From cursor'
        TabOrder = 0
        SkinData.SkinSection = 'CHECKBOX'
      end
      object RadioButtonEntireScope: TBCRadioButton
        Left = 12
        Top = 41
        Width = 79
        Height = 20
        Caption = 'Entire scope'
        Checked = True
        TabOrder = 1
        TabStop = True
        SkinData.SkinSection = 'CHECKBOX'
      end
    end
  end
  object ActionList: TActionList
    Images = ImagesDataModule.ImageListSmall
    Left = 256
    Top = 78
    object ActionSearchEngine: TAction
      Hint = 'Select search engine'
      ImageIndex = 143
      OnExecute = ActionSearchEngineExecute
    end
  end
end
