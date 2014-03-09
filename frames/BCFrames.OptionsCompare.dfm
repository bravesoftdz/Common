inherited OptionsCompareFrame: TOptionsCompareFrame
  Width = 282
  Height = 67
  Visible = False
  ExplicitWidth = 282
  ExplicitHeight = 67
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 282
    Height = 67
    BevelOuter = bvNone
    Color = clWindow
    Padding.Left = 4
    ParentBackground = False
    TabOrder = 0
    object IgnoreCaseCheckBox: TBCCheckBox
      Left = 4
      Top = 0
      Width = 276
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Ignore case'
      Checked = True
      State = cbChecked
      TabOrder = 0
      ReadOnly = False
    end
    object IgnoreBlanksCheckBox: TBCCheckBox
      Left = 4
      Top = 20
      Width = 282
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Ignore blanks'
      Checked = True
      State = cbChecked
      TabOrder = 1
      ReadOnly = False
    end
  end
end
