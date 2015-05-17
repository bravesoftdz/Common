inherited OptionsEditorSelectionFrame: TOptionsEditorSelectionFrame
  Width = 133
  Height = 80
  object Panel: TBCPanel [0]
    AlignWithMargins = True
    Left = 4
    Top = 0
    Width = 129
    Height = 80
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
    object CheckBoxALTSetsColumnMode: TBCCheckBox
      Left = 0
      Top = 20
      Width = 129
      Height = 20
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' ALT sets column mode'
      Checked = True
      State = cbChecked
      TabOrder = 1
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object CheckBoxTripleClickRowSelect: TBCCheckBox
      Left = 0
      Top = 60
      Width = 124
      Height = 20
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Triple-click row select'
      Checked = True
      State = cbChecked
      TabOrder = 3
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
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
    object CheckBoxHighlightSimilarTerms: TBCCheckBox
      Left = 0
      Top = 40
      Width = 126
      Height = 20
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Highlight similar terms'
      Checked = True
      State = cbChecked
      TabOrder = 2
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
  end
end
