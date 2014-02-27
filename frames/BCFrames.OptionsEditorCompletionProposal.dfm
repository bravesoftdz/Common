inherited OptionsEditorCompletionProposalFrame: TOptionsEditorCompletionProposalFrame
  Width = 201
  Height = 101
  ExplicitWidth = 201
  ExplicitHeight = 101
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 201
    Height = 101
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object ShortcutLabel: TLabel
      Left = 6
      Top = 43
      Width = 41
      Height = 13
      Caption = 'Shortcut'
    end
    object EnabledCheckBox: TBCCheckBox
      Left = 4
      Top = 0
      Width = 201
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Enabled'
      Checked = True
      State = cbChecked
      TabOrder = 0
      ReadOnly = False
    end
    object CaseSensitiveCheckBox: TBCCheckBox
      Left = 4
      Top = 20
      Width = 201
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Case Sensitive'
      Checked = True
      State = cbChecked
      TabOrder = 1
      ReadOnly = False
    end
    object ShortcutComboBox: TBCComboBox
      Left = 4
      Top = 59
      Width = 160
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
  end
end
