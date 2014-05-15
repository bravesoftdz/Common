inherited OptionsPrintFrame: TOptionsPrintFrame
  Width = 190
  Height = 253
  AutoSize = True
  ExplicitWidth = 190
  ExplicitHeight = 253
  object Panel: TPanel
    AlignWithMargins = True
    Left = 4
    Top = 0
    Width = 186
    Height = 252
    Margins.Left = 4
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    AutoSize = True
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object DateTimeLabel: TLabel
      Left = 2
      Top = 131
      Width = 49
      Height = 13
      Caption = 'Date time '
    end
    object PrintedByLabel: TLabel
      Left = 2
      Top = 87
      Width = 49
      Height = 13
      Caption = 'Printed by'
    end
    object DocumentNameLabel: TLabel
      Left = 2
      Top = 0
      Width = 77
      Height = 13
      Caption = 'Document name'
    end
    object PageNumberLabel: TLabel
      Left = 2
      Top = 44
      Width = 63
      Height = 13
      Caption = 'Page number'
    end
    object DateTimeComboBox: TBCComboBox
      Left = 0
      Top = 146
      Width = 186
      Height = 22
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Style = csOwnerDrawFixed
      DropDownCount = 9
      TabOrder = 3
      DeniedKeyStrokes = True
      ReadOnly = False
      DropDownFixedWidth = 0
    end
    object PrintedByComboBox: TBCComboBox
      Left = 0
      Top = 103
      Width = 186
      Height = 22
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Style = csOwnerDrawFixed
      DropDownCount = 9
      TabOrder = 2
      DeniedKeyStrokes = True
      ReadOnly = False
      DropDownFixedWidth = 0
    end
    object DocumentNameComboBox: TBCComboBox
      Left = 0
      Top = 16
      Width = 186
      Height = 22
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Style = csOwnerDrawFixed
      DropDownCount = 9
      TabOrder = 0
      DeniedKeyStrokes = True
      ReadOnly = False
      DropDownFixedWidth = 0
    end
    object PageNumberComboBox: TBCComboBox
      Left = 0
      Top = 59
      Width = 186
      Height = 22
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Style = csOwnerDrawFixed
      DropDownCount = 9
      TabOrder = 1
      DeniedKeyStrokes = True
      ReadOnly = False
      DropDownFixedWidth = 0
    end
    object ShowHeaderLineCheckBox: TBCCheckBox
      Left = 0
      Top = 175
      Width = 103
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Show header line'
      Checked = True
      State = cbChecked
      TabOrder = 4
      LinkedControls = <>
    end
    object ShowFooterLineCheckBox: TBCCheckBox
      Left = 0
      Top = 195
      Width = 99
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Show footer line'
      Checked = True
      State = cbChecked
      TabOrder = 5
      LinkedControls = <>
    end
    object ShowLineNumbersCheckBox: TBCCheckBox
      Left = 0
      Top = 215
      Width = 110
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Show line numbers'
      TabOrder = 6
      LinkedControls = <>
    end
    object WordWrapCheckBox: TBCCheckBox
      Left = 0
      Top = 235
      Width = 74
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Word wrap'
      TabOrder = 7
      LinkedControls = <>
    end
  end
end
