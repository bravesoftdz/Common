inherited OptionsEditorSearchFrame: TOptionsEditorSearchFrame
  Width = 211
  Height = 97
  AutoSize = True
  ExplicitWidth = 211
  ExplicitHeight = 97
  object Panel: TPanel
    AlignWithMargins = True
    Left = 4
    Top = 0
    Width = 207
    Height = 97
    Margins.Left = 4
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    BevelOuter = bvNone
    Color = clWindow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
    object ShowSearchStringNotFoundCheckBox: TBCCheckBox
      Left = 0
      Top = 0
      Width = 207
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Show search string not found message'
      Checked = True
      State = cbChecked
      TabOrder = 0
      LinkedControls = <>
    end
    object BeepIfSearchStringNotFoundCheckBox: TBCCheckBox
      Left = 0
      Top = 20
      Width = 169
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Beep if search string not found'
      Checked = True
      State = cbChecked
      TabOrder = 1
      LinkedControls = <>
    end
    object DocumentSpecificSearchCheckBox: TBCCheckBox
      Left = 0
      Top = 40
      Width = 143
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Document-specific search'
      Checked = True
      State = cbChecked
      TabOrder = 2
      LinkedControls = <>
    end
    object ShowSearchMapCheckBox: TBCCheckBox
      Left = 0
      Top = 60
      Width = 105
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Show search map'
      Checked = True
      State = cbChecked
      TabOrder = 3
      LinkedControls = <>
    end
    object ShowSearchHighlighterCheckBox: TBCCheckBox
      Left = 0
      Top = 80
      Width = 135
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Show search highlighter'
      Checked = True
      State = cbChecked
      TabOrder = 4
      LinkedControls = <>
    end
  end
end
