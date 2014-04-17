inherited OptionsSQLAlignmentsFrame: TOptionsSQLAlignmentsFrame
  Width = 200
  Height = 59
  AutoSize = True
  object Panel: TPanel
    AlignWithMargins = True
    Left = 4
    Top = 0
    Width = 196
    Height = 59
    Margins.Left = 4
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    AutoSize = True
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object KeywordAlignLabel: TLabel
      Left = 2
      Top = 0
      Width = 80
      Height = 16
      Caption = 'Keyword align'
    end
    object KeywordAlignmentLeftJustifyCheckBox: TBCCheckBox
      Left = 0
      Top = 41
      Width = 196
      Height = 18
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Keyword alignment strict left'
      Checked = True
      State = cbChecked
      TabOrder = 1
      AutoSize = True
      ReadOnly = False
    end
    object KeywordAlignComboBox: TBCComboBox
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
  end
end
