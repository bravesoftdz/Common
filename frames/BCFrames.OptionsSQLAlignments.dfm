inherited OptionsSQLAlignmentsFrame: TOptionsSQLAlignmentsFrame
  Width = 200
  Height = 59
  AutoSize = True
  ExplicitWidth = 200
  ExplicitHeight = 59
  object Panel: TPanel
    AlignWithMargins = True
    Left = 4
    Top = 0
    Width = 186
    Height = 58
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
      Width = 67
      Height = 13
      Caption = 'Keyword align'
    end
    object KeywordAlignmentLeftJustifyCheckBox: TBCCheckBox
      Left = 0
      Top = 41
      Width = 158
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Keyword alignment strict left'
      Checked = True
      State = cbChecked
      TabOrder = 1
      LinkedControls = <>
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
