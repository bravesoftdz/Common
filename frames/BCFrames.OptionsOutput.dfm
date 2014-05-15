inherited OptionsOutputFrame: TOptionsOutputFrame
  Width = 103
  Height = 75
  AutoSize = True
  ExplicitWidth = 103
  ExplicitHeight = 75
  object Panel: TPanel
    AlignWithMargins = True
    Left = 4
    Top = 0
    Width = 99
    Height = 75
    Margins.Left = 4
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object IndentLabel: TLabel
      Left = 2
      Top = 37
      Width = 32
      Height = 13
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Indent'
    end
    object ShowTreeLinesCheckBox: TBCCheckBox
      Left = 0
      Top = 0
      Width = 94
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Show tree lines'
      TabOrder = 0
      LinkedControls = <>
    end
    object IndentEdit: TBCEdit
      Left = 0
      Top = 54
      Width = 64
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      TabOrder = 2
      Text = '20'
      EnterToTab = False
      OnlyNumbers = True
      NumbersWithDots = False
      NumbersWithSpots = False
      ErrorColor = 14803198
      NumbersAllowNegative = False
    end
    object ShowCheckBoxCheckBox: TBCCheckBox
      Left = 0
      Top = 18
      Width = 98
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Show check box'
      TabOrder = 1
      LinkedControls = <>
    end
  end
end
