inherited OptionsSQLUpdateFrame: TOptionsSQLUpdateFrame
  Width = 155
  Height = 47
  ExplicitWidth = 155
  ExplicitHeight = 47
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 155
    Height = 47
    BevelOuter = bvNone
    TabOrder = 0
    object ColumnListStyleLabel: TLabel
      Left = 6
      Top = 0
      Width = 81
      Height = 13
      Caption = 'Column List Style'
    end
    object ColumnListStyleComboBox: TBCComboBox
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
