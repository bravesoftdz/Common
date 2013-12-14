object OptionsSQLSelectGroupByClauseFrame: TOptionsSQLSelectGroupByClauseFrame
  Left = 0
  Top = 0
  Width = 405
  Height = 503
  TabOrder = 0
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 405
    Height = 503
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object IgnoreCaseCheckBox: TBCCheckBox
      Left = 13
      Top = 110
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
      Left = 13
      Top = 89
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
