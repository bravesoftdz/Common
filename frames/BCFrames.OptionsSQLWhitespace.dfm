inherited OptionsSQLWhitespaceFrame: TOptionsSQLWhitespaceFrame
  Width = 316
  Height = 117
  ExplicitWidth = 316
  ExplicitHeight = 117
  object Panel: TPanel
    AlignWithMargins = True
    Left = 4
    Top = 0
    Width = 312
    Height = 117
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
    object SpaceAroundOperatorCheckBox: TBCCheckBox
      Left = 0
      Top = 0
      Width = 254
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Space around operator of arithmetric expression'
      Checked = True
      State = cbChecked
      TabOrder = 0
      LinkedControls = <>
    end
    object SpaceInsideCreateCheckBox: TBCCheckBox
      Left = 0
      Top = 20
      Width = 312
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Space inside parenthesis in CREATE FUNCTION/PROCEDURE'
      TabOrder = 1
      LinkedControls = <>
    end
    object SpaceInsideExpressionCheckBox: TBCCheckBox
      Left = 0
      Top = 40
      Width = 205
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Space inside parenthesis in expression'
      TabOrder = 2
      LinkedControls = <>
    end
    object SpaceInsideSubqueryCheckBox: TBCCheckBox
      Left = 0
      Top = 60
      Width = 198
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Space inside parenthesis in subquery'
      TabOrder = 3
      LinkedControls = <>
    end
    object SpaceInsideFunctionCheckBox: TBCCheckBox
      Left = 0
      Top = 80
      Width = 210
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Space inside parenthesis in function call'
      TabOrder = 4
      LinkedControls = <>
    end
    object SpaceInsideTypenameCheckBox: TBCCheckBox
      Left = 0
      Top = 100
      Width = 289
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Space inside parenthesis of typename in CREATE TABLE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      LinkedControls = <>
    end
  end
end
