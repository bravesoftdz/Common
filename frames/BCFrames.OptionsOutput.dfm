inherited OptionsOutputFrame: TOptionsOutputFrame
  Width = 126
  Height = 66
  AutoSize = True
  object Panel: TPanel
    AlignWithMargins = True
    Left = 4
    Top = 0
    Width = 122
    Height = 66
    Margins.Left = 4
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    AutoSize = True
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object IndentLabel: TLabel
      Left = 2
      Top = 25
      Width = 36
      Height = 16
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Indent'
    end
    object ShowTreeLinesCheckBox: TBCCheckBox
      Left = 0
      Top = 0
      Width = 122
      Height = 18
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Show tree lines'
      TabOrder = 0
      AutoSize = True
      ReadOnly = False
    end
    object IndentEdit: TBCEdit
      Left = 0
      Top = 42
      Width = 64
      Height = 24
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      TabOrder = 1
      Text = '20'
      EnterToTab = False
      OnlyNumbers = True
      NumbersWithDots = False
      NumbersWithSpots = False
      ErrorColor = 14803198
      NumbersAllowNegative = False
    end
  end
end
