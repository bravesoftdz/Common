inherited OptionsOutputFrame: TOptionsOutputFrame
  Width = 162
  Height = 111
  object Panel: TBCPanel [0]
    AlignWithMargins = True
    Left = 4
    Top = 0
    Width = 158
    Height = 111
    Margins.Left = 4
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    SkinData.SkinSection = 'CHECKBOX'
    object StickyLabelShowTreeLines: TsStickyLabel
      Left = 0
      Top = 4
      Width = 100
      Height = 13
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      AutoSize = False
      Caption = 'Show tree lines'
      ParentColor = False
      AttachTo = SliderShowTreeLines
      Gap = 8
    end
    object StickyLabelShowCheckBox: TsStickyLabel
      Left = 0
      Top = 27
      Width = 100
      Height = 13
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      AutoSize = False
      Caption = 'Show check box'
      ParentColor = False
      AttachTo = SliderShowCheckBox
      Gap = 8
    end
    object StickyLabelUseExplorerTheme: TsStickyLabel
      Left = 0
      Top = 50
      Width = 100
      Height = 13
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      AutoSize = False
      Caption = 'Use explorer theme'
      AttachTo = SliderUseExplorerTheme
      Gap = 8
    end
    object EditIndent: TBCEdit
      Left = 0
      Top = 90
      Width = 64
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      TabOrder = 3
      Text = '20'
      SkinData.SkinSection = 'EDIT'
      BoundLabel.Active = True
      BoundLabel.Caption = 'Indent'
      BoundLabel.Indent = 4
      BoundLabel.Layout = sclTopLeft
      EnterToTab = False
      OnlyNumbers = True
      NumbersWithDots = False
      NumbersWithSpots = False
      ErrorColor = 14803198
      NumbersAllowMinus = False
      NumbersAllowPlus = False
    end
    object SliderShowCheckBox: TsSlider
      Left = 108
      Top = 23
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
    object SliderShowTreeLines: TsSlider
      Left = 108
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
    end
    object SliderUseExplorerTheme: TsSlider
      Left = 108
      Top = 46
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
    end
  end
end
