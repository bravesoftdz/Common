inherited OptionsPrintFrame: TOptionsPrintFrame
  Width = 190
  Height = 253
  AutoSize = True
  object Panel: TPanel
    AlignWithMargins = True
    Left = 4
    Top = 0
    Width = 186
    Height = 253
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
      Width = 59
      Height = 16
      Caption = 'Date time '
    end
    object PrintedByLabel: TLabel
      Left = 2
      Top = 87
      Width = 57
      Height = 16
      Caption = 'Printed by'
    end
    object DocumentNameLabel: TLabel
      Left = 2
      Top = 0
      Width = 93
      Height = 16
      Caption = 'Document name'
    end
    object PageNumberLabel: TLabel
      Left = 2
      Top = 44
      Width = 76
      Height = 16
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
      Width = 133
      Height = 18
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Show header line'
      Checked = True
      State = cbChecked
      TabOrder = 4
      AutoSize = True
      ReadOnly = False
    end
    object ShowFooterLineCheckBox: TBCCheckBox
      Left = 0
      Top = 195
      Width = 127
      Height = 18
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Show footer line'
      Checked = True
      State = cbChecked
      TabOrder = 5
      AutoSize = True
      ReadOnly = False
    end
    object ShowLineNumbersCheckBox: TBCCheckBox
      Left = 0
      Top = 215
      Width = 143
      Height = 18
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Show line numbers'
      TabOrder = 6
      AutoSize = True
      ReadOnly = False
    end
    object WordWrapCheckBox: TBCCheckBox
      Left = 0
      Top = 235
      Width = 97
      Height = 18
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Word wrap'
      TabOrder = 7
      AutoSize = True
      ReadOnly = False
    end
  end
end
