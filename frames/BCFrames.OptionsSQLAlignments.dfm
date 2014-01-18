inherited OptionsSQLAlignmentsFrame: TOptionsSQLAlignmentsFrame
  Width = 282
  Height = 62
  ExplicitWidth = 282
  ExplicitHeight = 62
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 282
    Height = 62
    BevelOuter = bvNone
    TabOrder = 0
    object KeywordAlignLabel: TLabel
      Left = 6
      Top = 0
      Width = 68
      Height = 13
      Caption = 'Keyword Align'
    end
    object KeywordAlignmentLeftJustifyCheckBox: TBCCheckBox
      Left = 4
      Top = 41
      Width = 282
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Keyword Alignment Strict Left'
      Checked = True
      State = cbChecked
      TabOrder = 1
      ReadOnly = False
    end
    object KeywordAlignComboBox: TBCComboBox
      Left = 4
      Top = 16
      Width = 133
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
  end
end
