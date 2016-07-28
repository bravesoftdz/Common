inherited OptionsEditorSpecialCharsFrame: TOptionsEditorSpecialCharsFrame
  Width = 223
  Height = 375
  ExplicitWidth = 223
  ExplicitHeight = 375
  object Panel: TBCPanel [0]
    AlignWithMargins = True
    Left = 4
    Top = 0
    Width = 219
    Height = 375
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
    object StickyLabelUseTextColor: TsStickyLabel
      Left = 0
      Top = 4
      Width = 77
      Height = 13
      AutoSize = False
      Caption = 'Use text color'
      AttachTo = SliderUseTextColor
      Gap = 8
    end
    object StickyLabelUseMiddleColor: TsStickyLabel
      Left = 0
      Top = 30
      Width = 77
      Height = 13
      AutoSize = False
      Caption = 'Use middle color'
      AttachTo = SliderUseMiddleColor
      Gap = 8
    end
    object GroupBoxSelection: TBCGroupBox
      Left = 0
      Top = 282
      Width = 219
      Height = 93
      Caption = ' Selection'
      TabOrder = 5
      SkinData.SkinSection = 'GROUPBOX'
      object StickyLabelSelectionVisible: TsStickyLabel
        Left = 12
        Top = 24
        Width = 29
        Height = 13
        Caption = 'Visible'
        AttachTo = SliderSelectionVisible
        Gap = 8
      end
      object ColorComboBoxSelectionColor: TBCColorComboBox
        Left = 10
        Top = 59
        Width = 200
        Height = 22
        BoundLabel.Active = True
        BoundLabel.Caption = 'Color'
        BoundLabel.Indent = 4
        BoundLabel.Layout = sclTopLeft
        SkinData.SkinSection = 'COMBOBOX'
        Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor]
        Selected = clWindow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        ColorText = 'clWindow'
      end
      object SliderSelectionVisible: TsSlider
        Left = 49
        Top = 20
        Width = 50
        AutoSize = True
        TabOrder = 1
        ImageIndexOff = 0
        ImageIndexOn = 0
        FontOn.Charset = DEFAULT_CHARSET
        FontOn.Color = clWindowText
        FontOn.Height = -11
        FontOn.Name = 'Tahoma'
        FontOn.Style = []
        SliderCaptionOn = 'Yes'
        SliderCaptionOff = 'No'
        SliderOn = False
      end
    end
    object ColorComboBoxColor: TBCColorComboBox
      Left = 0
      Top = 69
      Width = 200
      Height = 22
      BoundLabel.Active = True
      BoundLabel.Caption = 'Color'
      BoundLabel.Indent = 4
      BoundLabel.Layout = sclTopLeft
      SkinData.SkinSection = 'COMBOBOX'
      Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor]
      Selected = clWindow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      ColorText = 'clWindow'
    end
    object ComboBoxStyle: TBCComboBox
      Left = 0
      Top = 113
      Width = 133
      Height = 22
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Alignment = taLeftJustify
      BoundLabel.Active = True
      BoundLabel.Caption = 'Style'
      BoundLabel.Indent = 4
      BoundLabel.Layout = sclTopLeft
      DropDownCount = 9
      SkinData.SkinSection = 'COMBOBOX'
      VerticalAlignment = taAlignTop
      Style = csOwnerDrawFixed
      ItemIndex = -1
      TabOrder = 3
      UseMouseWheel = False
    end
    object GroupBoxEndOfLine: TBCGroupBox
      Left = 0
      Top = 142
      Width = 219
      Height = 137
      Caption = ' End of line'
      TabOrder = 4
      SkinData.SkinSection = 'GROUPBOX'
      object StickyEndOfLineVisible: TsStickyLabel
        Left = 10
        Top = 22
        Width = 29
        Height = 13
        Caption = 'Visible'
        AttachTo = SliderEndOfLineVisible
        Gap = 8
      end
      object ColorComboBoxEndOfLineColor: TBCColorComboBox
        Left = 10
        Top = 59
        Width = 200
        Height = 22
        BoundLabel.Active = True
        BoundLabel.Caption = 'Color'
        BoundLabel.Indent = 4
        BoundLabel.Layout = sclTopLeft
        SkinData.SkinSection = 'COMBOBOX'
        Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor]
        Selected = clWindow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        ColorText = 'clWindow'
      end
      object ComboBoxEndOfLineStyle: TBCComboBox
        Left = 10
        Top = 104
        Width = 133
        Height = 22
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Alignment = taLeftJustify
        BoundLabel.Active = True
        BoundLabel.Caption = 'Style'
        BoundLabel.Indent = 4
        BoundLabel.Layout = sclTopLeft
        DropDownCount = 9
        SkinData.SkinSection = 'COMBOBOX'
        VerticalAlignment = taAlignTop
        Style = csOwnerDrawFixed
        ItemIndex = -1
        TabOrder = 1
        UseMouseWheel = False
      end
      object SliderEndOfLineVisible: TsSlider
        Left = 47
        Top = 18
        Width = 50
        AutoSize = True
        TabOrder = 2
        ImageIndexOff = 0
        ImageIndexOn = 0
        FontOn.Charset = DEFAULT_CHARSET
        FontOn.Color = clWindowText
        FontOn.Height = -11
        FontOn.Name = 'Tahoma'
        FontOn.Style = []
        SliderCaptionOn = 'Yes'
        SliderCaptionOff = 'No'
        SliderOn = False
      end
    end
    object SliderUseTextColor: TsSlider
      Left = 85
      Top = 0
      Width = 50
      AutoSize = True
      TabOrder = 0
      ImageIndexOff = 0
      ImageIndexOn = 0
      FontOn.Charset = DEFAULT_CHARSET
      FontOn.Color = clWindowText
      FontOn.Height = -11
      FontOn.Name = 'Tahoma'
      FontOn.Style = []
      SliderCaptionOn = 'Yes'
      SliderCaptionOff = 'No'
      SliderOn = False
    end
    object SliderUseMiddleColor: TsSlider
      Left = 85
      Top = 26
      Width = 50
      AutoSize = True
      TabOrder = 1
      ImageIndexOff = 0
      ImageIndexOn = 0
      FontOn.Charset = DEFAULT_CHARSET
      FontOn.Color = clWindowText
      FontOn.Height = -11
      FontOn.Name = 'Tahoma'
      FontOn.Style = []
      SliderCaptionOn = 'Yes'
      SliderCaptionOff = 'No'
    end
  end
end
