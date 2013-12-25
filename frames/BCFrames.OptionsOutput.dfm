inherited OptionsOutputFrame: TOptionsOutputFrame
  Width = 201
  Height = 63
  ExplicitWidth = 201
  ExplicitHeight = 63
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 201
    Height = 63
    BevelOuter = bvNone
    TabOrder = 0
    object IndentLabel: TLabel
      Left = 6
      Top = 25
      Width = 32
      Height = 13
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Indent'
    end
    object ShowTreeLinesCheckBox: TBCCheckBox
      Left = 4
      Top = 0
      Width = 201
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Show Tree Lines'
      TabOrder = 0
      ReadOnly = False
    end
    object IndentEdit: TBCEdit
      Left = 4
      Top = 42
      Width = 64
      Height = 21
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
