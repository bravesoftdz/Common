inherited OptionsSQLIndentationFrame: TOptionsSQLIndentationFrame
  Width = 179
  Height = 333
  AutoSize = True
  object Panel: TPanel
    AlignWithMargins = True
    Left = 4
    Top = 0
    Width = 175
    Height = 333
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
    object IndentLengthLabel: TLabel
      Left = 2
      Top = 0
      Width = 65
      Height = 13
      Caption = 'Indent length'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object TabSizeLabel: TLabel
      Left = 2
      Top = 64
      Width = 39
      Height = 13
      Caption = 'Tab size'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object FunctionBodyIndentLabel: TLabel
      Left = 2
      Top = 106
      Width = 101
      Height = 13
      Caption = 'Function body indent'
    end
    object BlockLeftIndentSizeLabel: TLabel
      Left = 2
      Top = 170
      Width = 97
      Height = 13
      Caption = 'Block left indent size'
    end
    object BlockRightIndentSizeLabel: TLabel
      Left = 2
      Top = 212
      Width = 103
      Height = 13
      Caption = 'Block right indent size'
    end
    object BlockIndentSizeLabel: TLabel
      Left = 2
      Top = 254
      Width = 78
      Height = 13
      Caption = 'Block indent size'
    end
    object SingleStatementIndentLabel: TLabel
      Left = 2
      Top = 296
      Width = 173
      Height = 13
      Caption = 'IF/ELSE single statement indent size'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object UseTabCheckBox: TBCCheckBox
      Left = 2
      Top = 41
      Width = 59
      Height = 15
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Use tab'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      AutoSize = True
      ReadOnly = False
    end
    object IndentLengthEdit: TBCEdit
      Left = 0
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
      Left = 0
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
      Left = 0
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
      Left = 2
      Top = 147
      Width = 103
      Height = 15
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Block on new line'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      AutoSize = True
      ReadOnly = False
    end
    object BlockLeftIndentSizeEdit: TBCEdit
      Left = 0
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
      Left = 0
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
      Left = 0
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
      Left = 0
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
