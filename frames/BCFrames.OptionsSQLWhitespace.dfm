inherited OptionsSQLWhitespaceFrame: TOptionsSQLWhitespaceFrame
  Width = 317
  Height = 115
  AutoSize = True
  object Panel: TPanel
    AlignWithMargins = True
    Left = 4
    Top = 0
    Width = 313
    Height = 115
    Margins.Left = 4
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    AutoSize = True
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
    object SpaceAroundOperatorCheckBox: TBCCheckBox
      Left = 0
      Top = 0
      Width = 255
      Height = 15
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Space around operator of arithmetric expression'
      Checked = True
      State = cbChecked
      TabOrder = 0
      AutoSize = True
      ReadOnly = False
    end
    object SpaceInsideCreateCheckBox: TBCCheckBox
      Left = 0
      Top = 20
      Width = 313
      Height = 15
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Space inside parenthesis in CREATE FUNCTION/PROCEDURE'
      TabOrder = 1
      AutoSize = True
      ReadOnly = False
    end
    object SpaceInsideExpressionCheckBox: TBCCheckBox
      Left = 0
      Top = 40
      Width = 206
      Height = 15
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Space inside parenthesis in expression'
      TabOrder = 2
      AutoSize = True
      ReadOnly = False
    end
    object SpaceInsideSubqueryCheckBox: TBCCheckBox
      Left = 0
      Top = 60
      Width = 199
      Height = 15
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Space inside parenthesis in subquery'
      TabOrder = 3
      AutoSize = True
      ReadOnly = False
    end
    object SpaceInsideFunctionCheckBox: TBCCheckBox
      Left = 0
      Top = 80
      Width = 211
      Height = 15
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Space inside parenthesis in function call'
      TabOrder = 4
      AutoSize = True
      ReadOnly = False
    end
    object SpaceInsideTypenameCheckBox: TBCCheckBox
      Left = 0
      Top = 100
      Width = 290
      Height = 15
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Space inside parenthesis of typename in CREATE TABLE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      AutoSize = True
      ReadOnly = False
    end
  end
end
