object OptionsSQLAlignmentsFrame: TOptionsSQLAlignmentsFrame
  Left = 0
  Top = 0
  Width = 320
  Height = 240
  Align = alClient
  TabOrder = 0
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 320
    Height = 240
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object KeywordAlignLabel: TLabel
      Left = 11
      Top = 7
      Width = 68
      Height = 13
      Caption = 'Keyword Align'
    end
    object KeywordAlignmentLeftJustifyCheckBox: TBCCheckBox
      Left = 9
      Top = 48
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
      Left = 9
      Top = 23
      Width = 133
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Style = csDropDownList
      DropDownCount = 9
      TabOrder = 0
      DeniedKeyStrokes = True
      ReadOnly = False
      DropDownFixedWidth = 0
    end
  end
end
