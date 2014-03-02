inherited OptionsSQLWhitespaceFrame: TOptionsSQLWhitespaceFrame
  Width = 329
  Height = 131
  ExplicitWidth = 329
  ExplicitHeight = 131
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 329
    Height = 131
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
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
      Caption = ' Space around operator of arithmetric expression'
      Checked = True
      State = cbChecked
      TabOrder = 0
      ReadOnly = False
    end
    object SpaceInsideCreateCheckBox: TBCCheckBox
      Left = 4
      Top = 20
      Width = 325
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Space inside parenthesis in CREATE FUNCTION/PROCEDURE'
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
      Caption = ' Space inside parenthesis in expression'
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
      Caption = ' Space inside parenthesis in subquery'
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
      Caption = ' Space inside parenthesis in function call'
      TabOrder = 4
      ReadOnly = False
    end
    object SpaceInsideTypenameCheckBox: TBCCheckBox
      Left = 4
      Top = 100
      Width = 309
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Space inside parenthesis of typename in CREATE TABLE'
      TabOrder = 5
      ReadOnly = False
    end
  end
end
