inherited OptionsPrintFrame: TOptionsPrintFrame
  Width = 201
  Height = 256
  ExplicitWidth = 201
  ExplicitHeight = 256
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 201
    Height = 256
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object DateTimeLabel: TLabel
      Left = 6
      Top = 131
      Width = 49
      Height = 13
      Caption = 'Date time '
    end
    object PrintedByLabel: TLabel
      Left = 6
      Top = 87
      Width = 49
      Height = 13
      Caption = 'Printed by'
    end
    object DocumentNameLabel: TLabel
      Left = 6
      Top = 0
      Width = 77
      Height = 13
      Caption = 'Document name'
    end
    object PageNumberLabel: TLabel
      Left = 6
      Top = 44
      Width = 63
      Height = 13
      Caption = 'Page number'
    end
    object DateTimeComboBox: TBCComboBox
      Left = 4
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
      Left = 4
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
      Left = 4
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
      Left = 4
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
      Left = 4
      Top = 175
      Width = 201
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Show header line'
      Checked = True
      State = cbChecked
      TabOrder = 4
      ReadOnly = False
    end
    object ShowFooterLineCheckBox: TBCCheckBox
      Left = 4
      Top = 195
      Width = 201
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Show footer line'
      Checked = True
      State = cbChecked
      TabOrder = 5
      ReadOnly = False
    end
    object ShowLineNumbersCheckBox: TBCCheckBox
      Left = 4
      Top = 215
      Width = 201
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Show line numbers'
      TabOrder = 6
      ReadOnly = False
    end
    object WordWrapCheckBox: TBCCheckBox
      Left = 4
      Top = 235
      Width = 201
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Word wrap'
      TabOrder = 7
      ReadOnly = False
    end
  end
end
