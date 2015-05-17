inherited OptionsEditorCodeFoldingFrame: TOptionsEditorCodeFoldingFrame
  Width = 307
  Height = 358
  AutoSize = False
  object Panel: TBCPanel [0]
    AlignWithMargins = True
    Left = 4
    Top = 0
    Width = 273
    Height = 321
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
    object StickyLabelVisible: TsStickyLabel
      Left = 0
      Top = 4
      Width = 120
      Height = 13
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      AutoSize = False
      Caption = 'Visible'
      ParentColor = False
      AttachTo = SliderVisible
      Gap = 8
    end
    object CheckBoxFoldMultilineComments: TBCCheckBox
      Left = 0
      Top = 20
      Width = 135
      Height = 20
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Fold multiline comments'
      TabOrder = 0
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object CheckBoxHighlightIndenGuides: TBCCheckBox
      Left = 0
      Top = 42
      Width = 131
      Height = 20
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Highlight indent guides'
      Checked = True
      State = cbChecked
      TabOrder = 1
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object CheckBoxHighlightMatchingPair: TBCCheckBox
      Left = 0
      Top = 64
      Width = 131
      Height = 20
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Highlight matching pair'
      Checked = True
      State = cbChecked
      TabOrder = 2
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object CheckBoxShowCollapsedCodeHint: TBCCheckBox
      Left = 0
      Top = 86
      Width = 143
      Height = 20
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Show collapsed code hint'
      Checked = True
      State = cbChecked
      TabOrder = 3
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object CheckBoxShowCollapsedLine: TBCCheckBox
      Left = 0
      Top = 108
      Width = 115
      Height = 20
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Show collapsed line'
      TabOrder = 4
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object CheckBoxShowIndentGuides: TBCCheckBox
      Left = 0
      Top = 130
      Width = 116
      Height = 20
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Show indent guides'
      Checked = True
      State = cbChecked
      TabOrder = 5
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object CheckBoxUncollapseByHintClick: TBCCheckBox
      Left = 0
      Top = 152
      Width = 132
      Height = 20
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Uncollapse by hint click'
      Checked = True
      State = cbChecked
      TabOrder = 6
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object ComboBoxMarkStyle: TBCComboBox
      Left = 0
      Top = 231
      Width = 133
      Height = 22
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Alignment = taLeftJustify
      BoundLabel.Active = True
      BoundLabel.Caption = 'Mark style'
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
      TabOrder = 7
    end
    object SliderVisible: TsSlider
      Left = 128
      Top = 0
      Width = 50
      AutoSize = True
      TabOrder = 8
      BoundLabel.Indent = 0
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clWindowText
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'Tahoma'
      BoundLabel.Font.Style = []
      BoundLabel.Layout = sclLeft
      BoundLabel.MaxWidth = 0
      BoundLabel.UseSkinColor = True
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
