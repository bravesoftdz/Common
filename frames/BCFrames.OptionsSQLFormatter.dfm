inherited OptionsSQLFormatterFrame: TOptionsSQLFormatterFrame
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
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object VendorLabel: TLabel
      Left = 6
      Top = 0
      Width = 34
      Height = 13
      Caption = 'Vendor'
    end
    object SQLVendorComboBox: TBCComboBox
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
