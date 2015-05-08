inherited OptionsEditorCaretFrame: TOptionsEditorCaretFrame
  Width = 223
  Height = 306
  object Panel: TBCPanel [0]
    AlignWithMargins = True
    Left = 4
    Top = 0
    Width = 219
    Height = 306
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
    object GroupBoxNonBlinkingCaret: TBCGroupBox
      Left = 0
      Top = 43
      Width = 219
      Height = 142
      Caption = ' Non-blinking caret'
      TabOrder = 2
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      object CheckBoxNonblinkingCaretEnabled: TBCCheckBox
        Left = 10
        Top = 20
        Width = 61
        Height = 20
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = ' Enabled'
        TabOrder = 0
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
      object ColorBoxNonblinkingCaretBackground: TBCColorComboBox
        Left = 10
        Top = 60
        Width = 200
        Height = 22
        BoundLabel.Active = True
        BoundLabel.Caption = 'Background color'
        BoundLabel.Indent = 4
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -11
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
        BoundLabel.Layout = sclTopLeft
        BoundLabel.MaxWidth = 0
        BoundLabel.UseSkinColor = True
        SkinData.SkinSection = 'COMBOBOX'
        Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Text = 'clWindow'
      end
      object ColorBoxNonblinkingCaretForeground: TBCColorComboBox
        Left = 10
        Top = 105
        Width = 200
        Height = 22
        BoundLabel.Active = True
        BoundLabel.Caption = 'Foreground color'
        BoundLabel.Indent = 4
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -11
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
        BoundLabel.Layout = sclTopLeft
        BoundLabel.MaxWidth = 0
        BoundLabel.UseSkinColor = True
        SkinData.SkinSection = 'COMBOBOX'
        Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor]
        Selected = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        Text = 'clWindow'
      end
    end
    object CheckBoxVisible: TBCCheckBox
      Left = 0
      Top = 0
      Width = 52
      Height = 20
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Visible'
      Checked = True
      State = cbChecked
      TabOrder = 0
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object GroupBoxStyles: TBCGroupBox
      Left = 0
      Top = 187
      Width = 219
      Height = 119
      Caption = ' Styles'
      TabOrder = 3
      SkinData.SkinSection = 'GROUPBOX'
      Checked = False
      object ComboBoxStylesInsertCaret: TBCComboBox
        Left = 10
        Top = 37
        Width = 133
        Height = 22
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Alignment = taLeftJustify
        BoundLabel.Active = True
        BoundLabel.Caption = 'Insert'
        BoundLabel.Indent = 4
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -11
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
        BoundLabel.Layout = sclTopLeft
        BoundLabel.MaxWidth = 0
        BoundLabel.UseSkinColor = True
        DropDownCount = 9
        SkinData.SkinSection = 'COMBOBOX'
        VerticalAlignment = taAlignTop
        Style = csOwnerDrawFixed
        ItemIndex = -1
        TabOrder = 0
      end
      object ComboBoxStylesOverwriteCaret: TBCComboBox
        Left = 10
        Top = 83
        Width = 133
        Height = 22
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Alignment = taLeftJustify
        BoundLabel.Active = True
        BoundLabel.Caption = 'Overwrite'
        BoundLabel.Indent = 4
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -11
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
        BoundLabel.Layout = sclTopLeft
        BoundLabel.MaxWidth = 0
        BoundLabel.UseSkinColor = True
        DropDownCount = 9
        SkinData.SkinSection = 'COMBOBOX'
        VerticalAlignment = taAlignTop
        Style = csOwnerDrawFixed
        ItemIndex = -1
        TabOrder = 1
      end
    end
    object CheckBoxRightMouseClickMovesCaret: TBCCheckBox
      Left = 0
      Top = 20
      Width = 166
      Height = 20
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Right mouse click moves caret'
      TabOrder = 1
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
  end
end
