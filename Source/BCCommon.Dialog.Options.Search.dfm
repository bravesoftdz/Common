inherited SearchOptionsDialog: TSearchOptionsDialog
  Caption = 'Search options'
  ClientHeight = 234
  ClientWidth = 253
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel: TBCPanel [0]
    Left = 0
    Top = 0
    Width = 253
    Height = 202
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    SkinData.SkinSection = 'CHECKBOX'
    object StickyLabelBeepIfSearchStringNotFound: TsStickyLabel
      Left = 9
      Top = 12
      Width = 178
      Height = 13
      AutoSize = False
      Caption = 'Beep if search string not found'
      AttachTo = SliderBeepIfSearchStringNotFound
      Gap = 8
    end
    object StickyLabelWholeWordsOnly: TsStickyLabel
      Left = 9
      Top = 150
      Width = 178
      Height = 13
      AutoSize = False
      Caption = 'Whole words only'
      AttachTo = SliderWholeWordsOnly
      Gap = 8
    end
    object StickyLabelSearchOnTyping: TsStickyLabel
      Left = 9
      Top = 81
      Width = 178
      Height = 13
      AutoSize = False
      Caption = 'Search on typing'
      AttachTo = SliderSearchOnTyping
      Gap = 8
    end
    object StickyLabelEntireScope: TsStickyLabel
      Left = 9
      Top = 35
      Width = 178
      Height = 13
      AutoSize = False
      Caption = 'Entire scope'
      AttachTo = SliderEntireScope
      Gap = 8
    end
    object StickyLabelHighlightResult: TsStickyLabel
      Left = 9
      Top = 58
      Width = 178
      Height = 13
      AutoSize = False
      Caption = 'Highlight results'
      AttachTo = SliderHighlightResult
      Gap = 8
    end
    object StickyLabelShowSearchStringNotFound: TsStickyLabel
      Left = 9
      Top = 127
      Width = 178
      Height = 13
      AutoSize = False
      Caption = 'Show search string not found'
      AttachTo = SliderShowSearchStringNotFound
      Gap = 8
    end
    object StickyLabelShowSearchMatchNotFound: TsStickyLabel
      Left = 9
      Top = 104
      Width = 178
      Height = 13
      AutoSize = False
      Caption = 'Show search match not found'
      AttachTo = SliderShowSearchMatchNotFound
      Gap = 8
    end
    object StickyLabelWrapAround: TsStickyLabel
      Left = 9
      Top = 173
      Width = 178
      Height = 13
      AutoSize = False
      Caption = 'Wrap around'
      AttachTo = SliderWrapAround
      Gap = 8
    end
    object SliderBeepIfSearchStringNotFound: TsSlider
      Left = 195
      Top = 8
      Width = 50
      AutoSize = True
      TabOrder = 0
      BoundLabel.Indent = 6
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
      KeepThumbAspectRatio = False
    end
    object SliderEntireScope: TsSlider
      Left = 195
      Top = 31
      Width = 50
      AutoSize = True
      TabOrder = 1
      BoundLabel.Indent = 6
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
      KeepThumbAspectRatio = False
    end
    object SliderHighlightResult: TsSlider
      Left = 195
      Top = 54
      Width = 50
      AutoSize = True
      TabOrder = 2
      BoundLabel.Indent = 6
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
      KeepThumbAspectRatio = False
    end
    object SliderSearchOnTyping: TsSlider
      Left = 195
      Top = 77
      Width = 50
      AutoSize = True
      TabOrder = 3
      BoundLabel.Indent = 6
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
      KeepThumbAspectRatio = False
    end
    object SliderShowSearchStringNotFound: TsSlider
      Left = 195
      Top = 123
      Width = 50
      AutoSize = True
      TabOrder = 5
      BoundLabel.Indent = 6
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
      KeepThumbAspectRatio = False
    end
    object SliderWholeWordsOnly: TsSlider
      Left = 195
      Top = 146
      Width = 50
      AutoSize = True
      TabOrder = 6
      BoundLabel.Indent = 6
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
      KeepThumbAspectRatio = False
    end
    object SliderShowSearchMatchNotFound: TsSlider
      Left = 195
      Top = 100
      Width = 50
      AutoSize = True
      TabOrder = 4
      BoundLabel.Indent = 6
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
      KeepThumbAspectRatio = False
    end
    object SliderWrapAround: TsSlider
      Left = 195
      Top = 169
      Width = 50
      AutoSize = True
      TabOrder = 7
      BoundLabel.Indent = 6
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
      KeepThumbAspectRatio = False
    end
  end
  object PanelButton: TBCPanel [1]
    Left = 0
    Top = 202
    Width = 253
    Height = 32
    Align = alBottom
    BevelOuter = bvNone
    Padding.Left = 8
    Padding.Right = 8
    Padding.Bottom = 8
    TabOrder = 1
    SkinData.SkinSection = 'CHECKBOX'
    object ButtonOK: TBCButton
      Left = 90
      Top = 0
      Width = 75
      Height = 24
      Align = alRight
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
      SkinData.SkinSection = 'BUTTON'
    end
    object ButtonCancel: TBCButton
      AlignWithMargins = True
      Left = 170
      Top = 0
      Width = 75
      Height = 24
      Margins.Left = 5
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alRight
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
      SkinData.SkinSection = 'BUTTON'
    end
  end
end
