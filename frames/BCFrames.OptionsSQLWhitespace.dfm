object Frame1: TFrame1
  Left = 0
  Top = 0
  Width = 320
  Height = 135
  TabOrder = 0
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 301
    Height = 131
    BevelOuter = bvNone
    TabOrder = 0
    object SpaceAroundOperatorCheckBox: TBCCheckBox
      Left = 4
      Top = 0
      Width = 282
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Space Around Operator of Arithmetric Expression'
      Checked = True
      State = cbChecked
      TabOrder = 0
      ReadOnly = False
    end
    object SpaceInsideCreateCheckBox: TBCCheckBox
      Left = 4
      Top = 20
      Width = 282
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Space Inside Parenthesis in Create Function/Procedure'
      TabOrder = 1
      ReadOnly = False
    end
    object SpaceInsideExpressionCheckBox: TBCCheckBox
      Left = 4
      Top = 40
      Width = 282
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Space Inside Parenthesis in Expression'
      TabOrder = 2
      ReadOnly = False
    end
    object SpaceInsideSubqueryCheckBox: TBCCheckBox
      Left = 4
      Top = 60
      Width = 282
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Space Inside Parenthesis in Subquery'
      TabOrder = 3
      ReadOnly = False
    end
    object SpaceInsideFunctionCheckBox: TBCCheckBox
      Left = 4
      Top = 80
      Width = 282
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Space Inside Parenthesis in Function Call'
      TabOrder = 4
      ReadOnly = False
    end
    object SpaceInsideTypenameCheckBox: TBCCheckBox
      Left = 4
      Top = 100
      Width = 282
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Space Inside Parenthesis of Typename in Create Table'
      TabOrder = 5
      ReadOnly = False
    end
  end
end
