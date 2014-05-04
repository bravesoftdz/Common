object ReplaceDialog: TReplaceDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Replace'
  ClientHeight = 360
  ClientWidth = 369
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Padding.Left = 12
  Padding.Top = 12
  Padding.Right = 12
  OldCreateOrder = True
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object OptionsGroupBox: TBCGroupBox
    AlignWithMargins = True
    Left = 12
    Top = 124
    Width = 345
    Height = 123
    Margins.Left = 0
    Margins.Top = 6
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alTop
    ControlSpacing = 5
    LayoutManagerActive = False
    LayoutType = ltVertical
    LabelColor = clWindowText
    TabOrder = 0
    Caption = 'Options'
    CaptionFont.Charset = DEFAULT_CHARSET
    CaptionFont.Color = clWindowText
    CaptionFont.Height = -11
    CaptionFont.Name = 'Tahoma'
    CaptionFont.Style = []
    object CaseSensitiveCheckBox: TBCCheckBox
      Left = 8
      Top = 21
      Width = 91
      Height = 15
      Caption = ' Case sensitive'
      TabOrder = 0
      AutoSize = True
      ReadOnly = False
    end
    object WholeWordsCheckBox: TBCCheckBox
      Left = 8
      Top = 42
      Width = 107
      Height = 15
      Caption = ' Whole words only'
      TabOrder = 1
      AutoSize = True
      ReadOnly = False
    end
    object RegularExpressionsCheckBox: TBCCheckBox
      Left = 8
      Top = 63
      Width = 119
      Height = 15
      Caption = ' Regular expressions'
      TabOrder = 2
      AutoSize = True
      ReadOnly = False
    end
    object PromptOnReplaceCheckBox: TBCCheckBox
      Left = 8
      Top = 105
      Width = 109
      Height = 15
      Caption = ' Prompt on replace'
      Checked = True
      State = cbChecked
      TabOrder = 4
      AutoSize = True
      ReadOnly = False
    end
    object WildCardCheckBox: TBCCheckBox
      Left = 8
      Top = 84
      Width = 66
      Height = 15
      Caption = ' Wild card'
      TabOrder = 3
      AutoSize = True
      ReadOnly = False
    end
  end
  object ReplaceInGroupBox: TBCGroupBox
    AlignWithMargins = True
    Left = 12
    Top = 253
    Width = 345
    Height = 64
    Margins.Left = 0
    Margins.Top = 6
    Margins.Right = 0
    Align = alTop
    ControlSpacing = 5
    LayoutManagerActive = False
    LayoutType = ltVertical
    LabelColor = clWindowText
    TabOrder = 1
    Caption = 'Replace in'
    CaptionFont.Charset = DEFAULT_CHARSET
    CaptionFont.Color = clWindowText
    CaptionFont.Height = -11
    CaptionFont.Name = 'Tahoma'
    CaptionFont.Style = []
    object WholeFileRadioButton: TBCRadioButton
      Left = 8
      Top = 21
      Width = 69
      Height = 15
      BiDiMode = bdLeftToRight
      Caption = ' Whole file'
      Checked = True
      ParentBiDiMode = False
      TabOrder = 0
      TabStop = True
      AutoSize = True
      ReadOnly = False
    end
    object AllOpenFilesRadioButton: TBCRadioButton
      Left = 8
      Top = 42
      Width = 82
      Height = 15
      BiDiMode = bdLeftToRight
      Caption = ' All open files'
      ParentBiDiMode = False
      TabOrder = 1
      AutoSize = True
      ReadOnly = False
    end
  end
  object Controls1Panel: TPanel
    Left = 12
    Top = 12
    Width = 345
    Height = 16
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object SearchForLabel: TLabel
      Left = 0
      Top = 0
      Width = 50
      Height = 16
      Align = alLeft
      Caption = 'Search for'
    end
  end
  object Controls2Panel: TPanel
    Left = 12
    Top = 28
    Width = 345
    Height = 21
    Align = alTop
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 3
    object SearchForComboBox: TBCComboBox
      Left = 0
      Top = 0
      Width = 345
      Height = 21
      Align = alClient
      TabOrder = 0
      OnKeyUp = SearchForComboBoxKeyUp
      DeniedKeyStrokes = False
      ReadOnly = False
      DropDownFixedWidth = 0
    end
  end
  object Controls3Panel: TPanel
    Left = 12
    Top = 49
    Width = 345
    Height = 24
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 4
    object ReplaceWithRadioButton: TBCRadioButton
      Left = 0
      Top = 0
      Width = 345
      Height = 24
      Align = alClient
      BiDiMode = bdLeftToRight
      Caption = ' Replace with'
      Checked = True
      ParentBiDiMode = False
      TabOrder = 0
      TabStop = True
      AutoSize = True
      ReadOnly = False
    end
  end
  object Controls4Panel: TPanel
    Left = 12
    Top = 73
    Width = 345
    Height = 21
    Align = alTop
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 5
    object ReplaceWithComboBox: TBCComboBox
      Left = 0
      Top = 0
      Width = 345
      Height = 21
      Align = alClient
      TabOrder = 0
      DeniedKeyStrokes = False
      ReadOnly = False
      DropDownFixedWidth = 0
    end
  end
  object Controls5Panel: TPanel
    Left = 12
    Top = 94
    Width = 345
    Height = 24
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 6
    object DeleteLineRadioButton: TBCRadioButton
      Left = 0
      Top = 0
      Width = 345
      Height = 24
      Align = alClient
      BiDiMode = bdLeftToRight
      Caption = ' Delete line'
      ParentBiDiMode = False
      TabOrder = 0
      AutoSize = True
      ReadOnly = False
    end
  end
  object ButtonsPanel: TPanel
    AlignWithMargins = True
    Left = 15
    Top = 316
    Width = 339
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    Padding.Top = 8
    Padding.Bottom = 8
    TabOrder = 7
    object FindButton: TButton
      Left = 98
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
    object ReplaceAllButton: TButton
      Left = 181
      Top = 8
      Width = 75
      Height = 25
      Align = alRight
      Caption = '&Replace All'
      Enabled = False
      ModalResult = 6
      TabOrder = 1
    end
    object CancelButton: TButton
      Left = 264
      Top = 8
      Width = 75
      Height = 25
      Align = alRight
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 2
    end
    object ButtonDivider2Panel: TPanel
      Left = 256
      Top = 8
      Width = 8
      Height = 25
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 3
    end
    object ButtonDivider1Panel: TPanel
      Left = 173
      Top = 8
      Width = 8
      Height = 25
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 4
    end
  end
end
