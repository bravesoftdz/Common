inherited OptionsEditorOptionsFrame: TOptionsEditorOptionsFrame
  Width = 260
  Height = 412
  ExplicitWidth = 260
  ExplicitHeight = 412
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 260
    Height = 432
    BevelOuter = bvNone
    TabOrder = 0
    object LineSpacingLabel: TLabel
      Left = 6
      Top = 245
      Width = 59
      Height = 13
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Line Spacing'
    end
    object TabWidthLabel: TLabel
      Left = 6
      Top = 285
      Width = 49
      Height = 13
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Tab Width'
    end
    object InsertCaretLabel: TLabel
      Left = 6
      Top = 327
      Width = 59
      Height = 13
      Caption = 'Insert Caret'
    end
    object NonblinkingCaretColorLabel: TLabel
      Left = 6
      Top = 370
      Width = 116
      Height = 13
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Non-blinking Caret Color'
    end
    object AutoIndentCheckBox: TBCCheckBox
      Left = 4
      Top = 0
      Width = 300
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Auto Indent'
      Checked = True
      State = cbChecked
      TabOrder = 0
      ReadOnly = False
    end
    object TrimTrailingSpacesCheckBox: TBCCheckBox
      Left = 4
      Top = 180
      Width = 300
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Trim Trailing Spaces'
      Checked = True
      State = cbChecked
      TabOrder = 9
      ReadOnly = False
    end
    object ScrollPastEofCheckBox: TBCCheckBox
      Left = 4
      Top = 60
      Width = 300
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Scroll Past End of File'
      TabOrder = 3
      ReadOnly = False
    end
    object ScrollPastEolCheckBox: TBCCheckBox
      Left = 4
      Top = 80
      Width = 300
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Scroll Past End of Line'
      Checked = True
      State = cbChecked
      TabOrder = 4
      ReadOnly = False
    end
    object LineSpacingEdit: TBCEdit
      Left = 4
      Top = 260
      Width = 64
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      AutoSize = False
      TabOrder = 12
      Text = '0'
      EnterToTab = False
      OnlyNumbers = True
      NumbersWithDots = False
      NumbersWithSpots = False
      ErrorColor = 14803198
      NumbersAllowNegative = False
    end
    object TabWidthEdit: TBCEdit
      Left = 4
      Top = 300
      Width = 64
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      AutoSize = False
      TabOrder = 13
      Text = '2'
      EnterToTab = False
      OnlyNumbers = True
      NumbersWithDots = False
      NumbersWithSpots = False
      ErrorColor = clBlack
      NumbersAllowNegative = False
    end
    object TabsToSpacesCheckBox: TBCCheckBox
      Left = 4
      Top = 160
      Width = 300
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Tabs to Spaces'
      Checked = True
      State = cbChecked
      TabOrder = 8
      ReadOnly = False
    end
    object AutoSaveCheckBox: TBCCheckBox
      Left = 4
      Top = 20
      Width = 300
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Auto Save'
      TabOrder = 1
      ReadOnly = False
    end
    object InsertCaretComboBox: TBCComboBox
      Left = 4
      Top = 343
      Width = 133
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Style = csDropDownList
      DropDownCount = 9
      TabOrder = 14
      DeniedKeyStrokes = True
      ReadOnly = False
      DropDownFixedWidth = 0
    end
    object UndoAfterSaveCheckBox: TBCCheckBox
      Left = 4
      Top = 220
      Width = 300
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Undo After Save'
      TabOrder = 11
      ReadOnly = False
    end
    object SmartTabsCheckBox: TBCCheckBox
      Left = 4
      Top = 120
      Width = 300
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Smart Tabs'
      TabOrder = 6
      ReadOnly = False
    end
    object SmartTabDeleteCheckBox: TBCCheckBox
      Left = 4
      Top = 140
      Width = 300
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Smart Tab Delete'
      TabOrder = 7
      ReadOnly = False
    end
    object TripleClickRowSelectCheckBox: TBCCheckBox
      Left = 4
      Top = 200
      Width = 300
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Triple-Click Row Select'
      Checked = True
      State = cbChecked
      TabOrder = 10
      ReadOnly = False
    end
    object NonblinkingCaretCheckBox: TBCCheckBox
      Left = 4
      Top = 40
      Width = 300
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Non-blinking Caret'
      TabOrder = 2
      ReadOnly = False
    end
    object NonblinkingCaretColorBox: TColorBox
      Left = 4
      Top = 386
      Width = 200
      Height = 22
      Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor, cbPrettyNames]
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 15
    end
    object ShowScrollHintCheckBox: TBCCheckBox
      Left = 4
      Top = 100
      Width = 300
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Show Scroll Hint'
      Checked = True
      State = cbChecked
      TabOrder = 5
      ReadOnly = False
    end
  end
end
