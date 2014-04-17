inherited OptionsSQLCapitalizationFrame: TOptionsSQLCapitalizationFrame
  Width = 190
  Height = 358
  AutoSize = True
  object Panel: TPanel
    AlignWithMargins = True
    Left = 4
    Top = 0
    Width = 186
    Height = 358
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
    object KeywordsLabel: TLabel
      Left = 2
      Top = 0
      Width = 55
      Height = 16
      Caption = 'Keywords'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object IdentifierLabel: TLabel
      Left = 2
      Top = 40
      Width = 44
      Height = 13
      Caption = 'Identifier'
    end
    object QuotedIdentifierLabel: TLabel
      Left = 2
      Top = 80
      Width = 81
      Height = 13
      Caption = 'Quoted identifier'
    end
    object TableNameLabel: TLabel
      Left = 2
      Top = 120
      Width = 55
      Height = 13
      Caption = 'Table name'
    end
    object ColumnNameLabel: TLabel
      Left = 2
      Top = 160
      Width = 64
      Height = 13
      Caption = 'Column name'
    end
    object AliasNameLabel: TLabel
      Left = 2
      Top = 200
      Width = 51
      Height = 13
      Caption = 'Alias name'
    end
    object VariableNameLabel: TLabel
      Left = 2
      Top = 240
      Width = 67
      Height = 13
      Caption = 'Variable name'
    end
    object FunctionNameLabel: TLabel
      Left = 2
      Top = 280
      Width = 70
      Height = 13
      Caption = 'Function name'
    end
    object DataTypeLabel: TLabel
      Left = 2
      Top = 320
      Width = 48
      Height = 13
      Caption = 'Data type'
    end
    object KeywordsComboBox: TBCComboBox
      Left = 0
      Top = 16
      Width = 186
      Height = 22
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Style = csOwnerDrawFixed
      DropDownCount = 9
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      DeniedKeyStrokes = True
      ReadOnly = False
      DropDownFixedWidth = 0
    end
    object IdentifierComboBox: TBCComboBox
      Left = 0
      Top = 56
      Width = 186
      Height = 22
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Style = csOwnerDrawFixed
      DropDownCount = 9
      TabOrder = 1
      DeniedKeyStrokes = True
      ReadOnly = False
      DropDownFixedWidth = 0
    end
    object QuotedIdentifierComboBox: TBCComboBox
      Left = 0
      Top = 96
      Width = 186
      Height = 22
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Style = csOwnerDrawFixed
      DropDownCount = 9
      TabOrder = 2
      DeniedKeyStrokes = True
      ReadOnly = False
      DropDownFixedWidth = 0
    end
    object TableNameComboBox: TBCComboBox
      Left = 0
      Top = 136
      Width = 186
      Height = 22
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Style = csOwnerDrawFixed
      DropDownCount = 9
      TabOrder = 3
      DeniedKeyStrokes = True
      ReadOnly = False
      DropDownFixedWidth = 0
    end
    object ColumnNameComboBox: TBCComboBox
      Left = 0
      Top = 176
      Width = 186
      Height = 22
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Style = csOwnerDrawFixed
      DropDownCount = 9
      TabOrder = 4
      DeniedKeyStrokes = True
      ReadOnly = False
      DropDownFixedWidth = 0
    end
    object AliasNameComboBox: TBCComboBox
      Left = 0
      Top = 216
      Width = 186
      Height = 22
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Style = csOwnerDrawFixed
      DropDownCount = 9
      TabOrder = 5
      DeniedKeyStrokes = True
      ReadOnly = False
      DropDownFixedWidth = 0
    end
    object VariableNameComboBox: TBCComboBox
      Left = 0
      Top = 256
      Width = 186
      Height = 22
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Style = csOwnerDrawFixed
      DropDownCount = 9
      TabOrder = 6
      DeniedKeyStrokes = True
      ReadOnly = False
      DropDownFixedWidth = 0
    end
    object FunctionNameComboBox: TBCComboBox
      Left = 0
      Top = 296
      Width = 186
      Height = 22
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Style = csOwnerDrawFixed
      DropDownCount = 9
      TabOrder = 7
      DeniedKeyStrokes = True
      ReadOnly = False
      DropDownFixedWidth = 0
    end
    object DataTypeComboBox: TBCComboBox
      Left = 0
      Top = 336
      Width = 186
      Height = 22
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Style = csOwnerDrawFixed
      DropDownCount = 9
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      DeniedKeyStrokes = True
      ReadOnly = False
      DropDownFixedWidth = 0
    end
  end
end
