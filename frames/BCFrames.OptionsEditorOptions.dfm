inherited OptionsEditorOptionsFrame: TOptionsEditorOptionsFrame
  Width = 204
  Height = 452
  ExplicitWidth = 204
  ExplicitHeight = 452
  object Panel: TPanel
    AlignWithMargins = True
    Left = 4
    Top = 0
    Width = 200
    Height = 452
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
    object LineSpacingLabel: TLabel
      Left = 2
      Top = 245
      Width = 58
      Height = 13
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Line spacing'
    end
    object TabWidthLabel: TLabel
      Left = 2
      Top = 285
      Width = 47
      Height = 13
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Tab width'
    end
    object InsertCaretLabel: TLabel
      Left = 2
      Top = 327
      Width = 57
      Height = 13
      Caption = 'Insert caret'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object NonblinkingCaretColorLabel: TLabel
      Left = 2
      Top = 370
      Width = 171
      Height = 13
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Non-blinking caret background color'
    end
    object NonblinkingCaretFontColorLabel: TLabel
      Left = 2
      Top = 414
      Width = 135
      Height = 13
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Non-blinking caret font color'
    end
    object AutoIndentCheckBox: TBCCheckBox
      Left = 0
      Top = 0
      Width = 77
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Auto indent'
      Checked = True
      State = cbChecked
      TabOrder = 0
      LinkedControls = <>
    end
    object TrimTrailingSpacesCheckBox: TBCCheckBox
      Left = 0
      Top = 180
      Width = 112
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Trim trailing spaces'
      Checked = True
      State = cbChecked
      TabOrder = 9
      LinkedControls = <>
    end
    object ScrollPastEofCheckBox: TBCCheckBox
      Left = 0
      Top = 60
      Width = 121
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Scroll past end of file'
      TabOrder = 3
      LinkedControls = <>
    end
    object ScrollPastEolCheckBox: TBCCheckBox
      Left = 0
      Top = 80
      Width = 123
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Scroll past end of line'
      Checked = True
      State = cbChecked
      TabOrder = 4
      LinkedControls = <>
    end
    object LineSpacingEdit: TBCEdit
      Left = 0
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
      Left = 0
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
      Left = 0
      Top = 160
      Width = 93
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Tabs to spaces'
      Checked = True
      State = cbChecked
      TabOrder = 8
      LinkedControls = <>
    end
    object AutoSaveCheckBox: TBCCheckBox
      Left = 0
      Top = 20
      Width = 70
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Auto save'
      TabOrder = 1
      LinkedControls = <>
    end
    object InsertCaretComboBox: TBCComboBox
      Left = 0
      Top = 343
      Width = 133
      Height = 22
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Style = csOwnerDrawFixed
      DropDownCount = 9
      TabOrder = 14
      DeniedKeyStrokes = True
      ReadOnly = False
      DropDownFixedWidth = 0
    end
    object UndoAfterSaveCheckBox: TBCCheckBox
      Left = 0
      Top = 220
      Width = 99
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Undo after save'
      TabOrder = 11
      LinkedControls = <>
    end
    object SmartTabsCheckBox: TBCCheckBox
      Left = 0
      Top = 120
      Width = 73
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Smart tabs'
      TabOrder = 6
      LinkedControls = <>
    end
    object SmartTabDeleteCheckBox: TBCCheckBox
      Left = 0
      Top = 140
      Width = 101
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Smart tab delete'
      TabOrder = 7
      LinkedControls = <>
    end
    object TripleClickRowSelectCheckBox: TBCCheckBox
      Left = 0
      Top = 200
      Width = 122
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Triple-click row select'
      Checked = True
      State = cbChecked
      TabOrder = 10
      LinkedControls = <>
    end
    object NonblinkingCaretCheckBox: TBCCheckBox
      Left = 0
      Top = 40
      Width = 107
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Non-blinking caret'
      TabOrder = 2
      LinkedControls = <>
    end
    object NonblinkingCaretBackgroundColorBox: TBCColorComboBox
      Left = 0
      Top = 386
      Width = 200
      Height = 22
      ColorDialogText = 'Custom...'
      ColorWidth = 13
      DroppedDownWidth = 200
      NewColorText = 'Custom'
      Options = [coText, coStdColors, coSysColors, coCustomColors]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 15
    end
    object ShowScrollHintCheckBox: TBCCheckBox
      Left = 0
      Top = 100
      Width = 95
      Height = 17
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Show scroll hint'
      Checked = True
      State = cbChecked
      TabOrder = 5
      LinkedControls = <>
    end
    object NonblinkingCaretFontColorBox: TBCColorComboBox
      Left = 0
      Top = 430
      Width = 200
      Height = 22
      ColorValue = clWhite
      ColorDialogText = 'Custom...'
      ColorWidth = 13
      DroppedDownWidth = 200
      NewColorText = 'Custom'
      Options = [coText, coStdColors, coSysColors, coCustomColors]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 16
    end
  end
end
