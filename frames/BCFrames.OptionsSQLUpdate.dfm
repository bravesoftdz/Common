inherited OptionsSQLUpdateFrame: TOptionsSQLUpdateFrame
  Width = 190
  Height = 38
  ExplicitWidth = 190
  ExplicitHeight = 38
  object Panel: TPanel
    AlignWithMargins = True
    Left = 4
    Top = 0
    Width = 186
    Height = 38
    Margins.Left = 4
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object ColumnListStyleLabel: TLabel
      Left = 2
      Top = 0
      Width = 77
      Height = 13
      Caption = 'Column list style'
    end
    object ColumnListStyleComboBox: TBCComboBox
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
