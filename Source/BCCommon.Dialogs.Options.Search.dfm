object SearchOptionsDialog: TSearchOptionsDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Search options'
  ClientHeight = 279
  ClientWidth = 206
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object CheckBoxCaseSensitive: TBCCheckBox
    Left = 8
    Top = 31
    Width = 92
    Height = 20
    Caption = ' Case sensitive'
    ParentColor = False
    TabOrder = 1
    SkinData.SkinSection = 'CHECKBOX'
    ImgChecked = 0
    ImgUnchecked = 0
  end
  object CheckBoxWholeWordsOnly: TBCCheckBox
    Left = 8
    Top = 215
    Width = 108
    Height = 20
    Caption = ' Whole words only'
    TabOrder = 9
    SkinData.SkinSection = 'CHECKBOX'
    ImgChecked = 0
    ImgUnchecked = 0
  end
  object CheckBoxRegularExpression: TBCCheckBox
    Left = 8
    Top = 100
    Width = 115
    Height = 20
    Caption = ' Regular expression'
    TabOrder = 4
    SkinData.SkinSection = 'CHECKBOX'
    ImgChecked = 0
    ImgUnchecked = 0
  end
  object CheckBoxWildCard: TBCCheckBox
    Left = 8
    Top = 192
    Width = 64
    Height = 20
    Caption = ' Wildcard'
    TabOrder = 8
    SkinData.SkinSection = 'CHECKBOX'
    ImgChecked = 0
    ImgUnchecked = 0
  end
  object CheckBoxBeepIfSearchStringNotFound: TBCCheckBox
    Left = 8
    Top = 8
    Width = 171
    Height = 20
    Caption = ' Beep if search string not found'
    Checked = True
    State = cbChecked
    TabOrder = 0
    SkinData.SkinSection = 'CHECKBOX'
    ImgChecked = 0
    ImgUnchecked = 0
  end
  object CheckBoxSearchOnTyping: TBCCheckBox
    Left = 8
    Top = 123
    Width = 104
    Height = 20
    Caption = ' Search on typing'
    Checked = True
    State = cbChecked
    TabOrder = 5
    SkinData.SkinSection = 'CHECKBOX'
    ImgChecked = 0
    ImgUnchecked = 0
  end
  object CheckBoxEntireScope: TBCCheckBox
    Left = 8
    Top = 54
    Width = 82
    Height = 20
    Caption = ' Entire scope'
    TabOrder = 2
    SkinData.SkinSection = 'CHECKBOX'
    ImgChecked = 0
    ImgUnchecked = 0
  end
  object CheckBoxHighlightResult: TBCCheckBox
    Left = 8
    Top = 77
    Width = 99
    Height = 20
    Caption = ' Highlight results'
    Checked = True
    State = cbChecked
    TabOrder = 3
    SkinData.SkinSection = 'CHECKBOX'
    ImgChecked = 0
    ImgUnchecked = 0
  end
  object CheckBoxSelectedOnly: TBCCheckBox
    Left = 8
    Top = 146
    Width = 87
    Height = 20
    Caption = ' Selected only'
    TabOrder = 6
    SkinData.SkinSection = 'CHECKBOX'
    ImgChecked = 0
    ImgUnchecked = 0
  end
  object CheckBoxShowSearchStringNotFound: TBCCheckBox
    Left = 8
    Top = 169
    Width = 164
    Height = 20
    Caption = ' Show search string not found'
    TabOrder = 7
    SkinData.SkinSection = 'CHECKBOX'
    ImgChecked = 0
    ImgUnchecked = 0
  end
  object PanelButton: TBCPanel
    Left = 0
    Top = 247
    Width = 206
    Height = 32
    Align = alBottom
    BevelOuter = bvNone
    Padding.Left = 8
    Padding.Right = 8
    Padding.Bottom = 8
    TabOrder = 10
    SkinData.SkinSection = 'CHECKBOX'
    object ButtonOK: TBCButton
      Left = 43
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
      Left = 123
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
