object OptionsCompareFrame: TOptionsCompareFrame
  Left = 0
  Top = 0
  Width = 282
  Height = 41
  TabOrder = 0
  Visible = False
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 282
    Height = 41
    BevelOuter = bvNone
    Padding.Left = 4
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
      Caption = ' Ignore Case'
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
      Caption = ' Ignore Blanks'
      Checked = True
      State = cbChecked
      TabOrder = 1
      ReadOnly = False
    end
  end
end
