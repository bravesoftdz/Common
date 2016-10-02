inherited OptionsEditorWordWrapFrame: TOptionsEditorWordWrapFrame
  Width = 161
  Height = 39
  object Panel: TBCPanel [0]
    AlignWithMargins = True
    Left = 4
    Top = 0
    Width = 157
    Height = 39
    Margins.Left = 4
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    BevelOuter = bvNone
    Color = clWindow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
    SkinData.SkinSection = 'CHECKBOX'
    object ComboBoxWidth: TBCComboBox
      Left = 0
      Top = 17
      Width = 157
      Height = 22
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Alignment = taLeftJustify
      BoundLabel.Active = True
      BoundLabel.Caption = 'Width'
      BoundLabel.Indent = 4
      BoundLabel.Layout = sclTopLeft
      DropDownCount = 9
      SkinData.SkinSection = 'COMBOBOX'
      VerticalAlignment = taAlignTop
      Style = csOwnerDrawFixed
      ItemIndex = -1
      TabOrder = 0
      UseMouseWheel = False
    end
  end
end
