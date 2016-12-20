inherited OptionsTitleBarFrame: TOptionsTitleBarFrame
  Width = 182
  Height = 164
  object Panel: TBCPanel [0]
    AlignWithMargins = True
    Left = 4
    Top = 0
    Width = 178
    Height = 164
    Margins.Left = 4
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    SkinData.SkinSection = 'CHECKBOX'
    object StickyLabelUseSystemFontName: TsStickyLabel
      Left = 0
      Top = 4
      Width = 120
      Height = 13
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      AutoSize = False
      Caption = 'Use system font name'
      ParentColor = False
      AttachTo = SliderUseSystemFontName
      Gap = 8
    end
    object StickyLabelUseSystemSize: TsStickyLabel
      Left = 0
      Top = 28
      Width = 120
      Height = 13
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      AutoSize = False
      Caption = 'Use system size'
      ParentColor = False
      AttachTo = SliderUseSystemSize
      Gap = 8
    end
    object StickyLabelUseSystemStyle: TsStickyLabel
      Left = 0
      Top = 52
      Width = 120
      Height = 13
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      AutoSize = False
      Caption = 'Use system style'
      ParentColor = False
      AttachTo = SliderUseSystemStyle
      Gap = 8
    end
    object FontComboBoxFont: TBCFontComboBox
      Left = 0
      Top = 94
      Width = 160
      Height = 22
      Alignment = taLeftJustify
      BoundLabel.Active = True
      BoundLabel.Indent = 4
      BoundLabel.Caption = 'Font'
      BoundLabel.Layout = sclTopLeft
      VerticalAlignment = taAlignTop
      TabOrder = 3
    end
    object EditFontSize: TBCEdit
      Left = 0
      Top = 143
      Width = 64
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      Text = '0'
      SkinData.SkinSection = 'EDIT'
      BoundLabel.Active = True
      BoundLabel.Indent = 4
      BoundLabel.Caption = 'Font size'
      BoundLabel.Layout = sclTopLeft
      EnterToTab = False
      OnlyNumbers = True
      NumbersWithDots = False
      NumbersWithSpots = False
      ErrorColor = 14803198
      NumbersAllowMinus = False
      NumbersAllowPlus = False
    end
    object SliderUseSystemFontName: TsSlider
      Left = 128
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
      KeepThumbAspectRatio = False
    end
    object SliderUseSystemSize: TsSlider
      Left = 128
      Top = 24
      Width = 50
      AutoSize = True
      TabOrder = 1
      BoundLabel.Caption = 'Show'
      ImageIndexOff = 0
      ImageIndexOn = 0
      FontOn.Charset = DEFAULT_CHARSET
      FontOn.Color = clWindowText
      FontOn.Height = -11
      FontOn.Name = 'Tahoma'
      FontOn.Style = []
      SliderCaptionOn = 'Yes'
      SliderCaptionOff = 'No'
      KeepThumbAspectRatio = False
    end
    object SliderUseSystemStyle: TsSlider
      Left = 128
      Top = 48
      Width = 50
      AutoSize = True
      TabOrder = 2
      BoundLabel.Caption = 'Show'
      ImageIndexOff = 0
      ImageIndexOn = 0
      FontOn.Charset = DEFAULT_CHARSET
      FontOn.Color = clWindowText
      FontOn.Height = -11
      FontOn.Name = 'Tahoma'
      FontOn.Style = []
      SliderCaptionOn = 'Yes'
      SliderCaptionOff = 'No'
      KeepThumbAspectRatio = False
    end
  end
  inherited FrameAdapter: TsFrameAdapter
    Left = 120
    Top = 116
  end
end
