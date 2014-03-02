inherited OptionsSQLIndentationFrame: TOptionsSQLIndentationFrame
  Width = 207
  Height = 335
  ParentFont = False
  ExplicitWidth = 207
  ExplicitHeight = 335
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 207
    Height = 335
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object IndentLengthLabel: TLabel
      Left = 6
      Top = 0
      Width = 65
      Height = 13
      Caption = 'Indent length'
    end
    object TabSizeLabel: TLabel
      Left = 6
      Top = 64
      Width = 39
      Height = 13
      Caption = 'Tab size'
    end
    object FunctionBodyIndentLabel: TLabel
      Left = 6
      Top = 106
      Width = 101
      Height = 13
      Caption = 'Function body indent'
    end
    object BlockLeftIndentSizeLabel: TLabel
      Left = 6
      Top = 170
      Width = 97
      Height = 13
      Caption = 'Block left indent size'
    end
    object BlockRightIndentSizeLabel: TLabel
      Left = 6
      Top = 212
      Width = 103
      Height = 13
      Caption = 'Block right indent size'
    end
    object BlockIndentSizeLabel: TLabel
      Left = 6
      Top = 254
      Width = 78
      Height = 13
      Caption = 'Block indent size'
    end
    object SingleStatementIndentLabel: TLabel
      Left = 6
      Top = 296
      Width = 173
      Height = 13
      Caption = 'IF/ELSE single statement indent size'
    end
    object UseTabCheckBox: TBCCheckBox
      Left = 6
      Top = 41
      Width = 282
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Use tab'
      TabOrder = 0
      ReadOnly = False
    end
    object IndentLengthEdit: TBCEdit
      Left = 4
      Top = 16
      Width = 64
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      AutoSize = False
      TabOrder = 1
      Text = '2'
      EnterToTab = False
      OnlyNumbers = True
      NumbersWithDots = False
      NumbersWithSpots = False
      ErrorColor = 14803198
      NumbersAllowNegative = False
    end
    object TabSizeEdit: TBCEdit
      Left = 4
      Top = 80
      Width = 64
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      AutoSize = False
      TabOrder = 2
      Text = '2'
      EnterToTab = False
      OnlyNumbers = True
      NumbersWithDots = False
      NumbersWithSpots = False
      ErrorColor = 14803198
      NumbersAllowNegative = False
    end
    object FunctionBodyIndentEdit: TBCEdit
      Left = 4
      Top = 122
      Width = 64
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      AutoSize = False
      TabOrder = 3
      Text = '2'
      EnterToTab = False
      OnlyNumbers = True
      NumbersWithDots = False
      NumbersWithSpots = False
      ErrorColor = 14803198
      NumbersAllowNegative = False
    end
    object BlockOnNewLineCheckBox: TBCCheckBox
      Left = 6
      Top = 147
      Width = 282
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Block on new line'
      TabOrder = 4
      ReadOnly = False
    end
    object BlockLeftIndentSizeEdit: TBCEdit
      Left = 4
      Top = 186
      Width = 64
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      AutoSize = False
      TabOrder = 5
      Text = '2'
      EnterToTab = False
      OnlyNumbers = True
      NumbersWithDots = False
      NumbersWithSpots = False
      ErrorColor = 14803198
      NumbersAllowNegative = False
    end
    object BlockRightIndentSizeEdit: TBCEdit
      Left = 4
      Top = 228
      Width = 64
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      AutoSize = False
      TabOrder = 6
      Text = '2'
      EnterToTab = False
      OnlyNumbers = True
      NumbersWithDots = False
      NumbersWithSpots = False
      ErrorColor = 14803198
      NumbersAllowNegative = False
    end
    object BlockIndentSizeEdit: TBCEdit
      Left = 4
      Top = 270
      Width = 64
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      AutoSize = False
      TabOrder = 7
      Text = '2'
      EnterToTab = False
      OnlyNumbers = True
      NumbersWithDots = False
      NumbersWithSpots = False
      ErrorColor = 14803198
      NumbersAllowNegative = False
    end
    object SingleStatementIndentEdit: TBCEdit
      Left = 4
      Top = 312
      Width = 64
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      AutoSize = False
      TabOrder = 8
      Text = '2'
      EnterToTab = False
      OnlyNumbers = True
      NumbersWithDots = False
      NumbersWithSpots = False
      ErrorColor = 14803198
      NumbersAllowNegative = False
    end
  end
end
