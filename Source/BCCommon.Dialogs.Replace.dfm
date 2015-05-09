object ReplaceDialog: TReplaceDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Replace'
  ClientHeight = 364
  ClientWidth = 369
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Padding.Left = 6
  Padding.Top = 6
  Padding.Right = 6
  OldCreateOrder = True
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBoxOptions: TBCGroupBox
    AlignWithMargins = True
    Left = 6
    Top = 91
    Width = 357
    Height = 156
    Margins.Left = 0
    Margins.Right = 0
    Align = alTop
    Caption = ' Options'
    TabOrder = 5
    SkinData.SkinSection = 'GROUPBOX'
    Checked = False
    object CheckBoxCaseSensitive: TBCCheckBox
      Left = 12
      Top = 20
      Width = 92
      Height = 20
      Caption = ' Case sensitive'
      TabOrder = 0
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object CheckBoxWholeWords: TBCCheckBox
      Left = 12
      Top = 104
      Width = 108
      Height = 20
      Caption = ' Whole words only'
      TabOrder = 4
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object CheckBoxRegularExpression: TBCCheckBox
      Left = 12
      Top = 62
      Width = 120
      Height = 20
      Caption = ' Regular expressions'
      TabOrder = 2
      OnClick = CheckBoxRegularExpressionClick
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object CheckBoxPromptOnReplace: TBCCheckBox
      Left = 12
      Top = 41
      Width = 110
      Height = 20
      Caption = ' Prompt on replace'
      Checked = True
      State = cbChecked
      TabOrder = 1
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object CheckBoxWildCard: TBCCheckBox
      Left = 12
      Top = 126
      Width = 67
      Height = 20
      Caption = ' Wild card'
      TabOrder = 5
      OnClick = CheckBoxWildCardClick
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object CheckBoxSelectedOnly: TBCCheckBox
      Left = 12
      Top = 83
      Width = 87
      Height = 20
      Caption = ' Selected only'
      TabOrder = 3
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
  end
  object PanelSearchForComboBox: TBCPanel
    Left = 6
    Top = 6
    Width = 357
    Height = 38
    Align = alTop
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 1
    SkinData.SkinSection = 'CHECKBOX'
    object ComboBoxSearchFor: TBCComboBox
      Left = 0
      Top = 17
      Width = 357
      Height = 21
      Align = alBottom
      Alignment = taLeftJustify
      BoundLabel.Active = True
      BoundLabel.Caption = 'Search for'
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
      OnKeyUp = ComboBoxSearchForKeyUp
    end
  end
  object PanelReplaceWith: TBCPanel
    Left = 6
    Top = 44
    Width = 357
    Height = 23
    Align = alTop
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 2
    SkinData.SkinSection = 'CHECKBOX'
    object RadioButtonReplaceWith: TBCRadioButton
      AlignWithMargins = True
      Left = 2
      Top = 0
      Width = 81
      Height = 23
      Margins.Left = 2
      Margins.Top = 0
      Margins.Bottom = 0
      Align = alLeft
      Alignment = taLeftJustify
      BiDiMode = bdLeftToRight
      Caption = 'Replace with'
      Checked = True
      ParentBiDiMode = False
      ParentColor = False
      TabOrder = 0
      TabStop = True
      SkinData.SkinSection = 'CHECKBOX'
    end
    object RadioButtonDeleteLine: TBCRadioButton
      AlignWithMargins = True
      Left = 285
      Top = 0
      Width = 70
      Height = 23
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 2
      Margins.Bottom = 0
      Align = alRight
      Alignment = taLeftJustify
      BiDiMode = bdLeftToRight
      Caption = 'Delete line'
      ParentBiDiMode = False
      ParentColor = False
      TabOrder = 1
      SkinData.SkinSection = 'CHECKBOX'
    end
  end
  object PanelReplaceWithComboBox: TBCPanel
    Left = 6
    Top = 67
    Width = 357
    Height = 21
    Align = alTop
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 4
    SkinData.SkinSection = 'PANEL'
    object ComboBoxReplaceWith: TBCComboBox
      Left = 0
      Top = 0
      Width = 357
      Height = 21
      Align = alClient
      Alignment = taLeftJustify
      BoundLabel.Indent = 0
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clWindowText
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'Tahoma'
      BoundLabel.Font.Style = []
      BoundLabel.Layout = sclLeft
      BoundLabel.MaxWidth = 0
      BoundLabel.UseSkinColor = True
      SkinData.SkinSection = 'COMBOBOX'
      VerticalAlignment = taAlignTop
      ItemIndex = -1
      TabOrder = 0
    end
  end
  object PanelButtons: TBCPanel
    AlignWithMargins = True
    Left = 9
    Top = 320
    Width = 354
    Height = 41
    Margins.Right = 0
    Align = alBottom
    BevelOuter = bvNone
    Padding.Top = 8
    Padding.Bottom = 8
    TabOrder = 3
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
  object GroupBoxReplaceIn: TBCGroupBox
    Left = 6
    Top = 250
    Width = 357
    Height = 70
    Align = alTop
    BiDiMode = bdLeftToRight
    Caption = ' Replace in'
    ParentBiDiMode = False
    TabOrder = 0
    SkinData.SkinSection = 'GROUPBOX'
    Checked = False
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
end
