object OptionsSQLSelectSubqueryFrame: TOptionsSQLSelectSubqueryFrame
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
    object NewLineAfterExistsCheckBox: TBCCheckBox
      Left = 11
      Top = 27
      Width = 276
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' New Line After EXISTS'
      Checked = True
      State = cbChecked
      TabOrder = 0
      ReadOnly = False
    end
    object NewLineAfterInCheckBox: TBCCheckBox
      Left = 11
      Top = 7
      Width = 282
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' New Line After IN'
      Checked = True
      State = cbChecked
      TabOrder = 1
      ReadOnly = False
    end
    object NewlineAfterComparisonOperatorCheckBox: TBCCheckBox
      Left = 11
      Top = 47
      Width = 276
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' New Line After Comparison Operator'
      Checked = True
      State = cbChecked
      TabOrder = 2
      ReadOnly = False
    end
    object NewlineBeforeComparisonOperatorCheckBox: TBCCheckBox
      Left = 11
      Top = 67
      Width = 276
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' New Line Before Comparison Operator'
      Checked = True
      State = cbChecked
      TabOrder = 3
      ReadOnly = False
    end
  end
end
