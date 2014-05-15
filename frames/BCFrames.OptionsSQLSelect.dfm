inherited OptionsSQLSelectFrame: TOptionsSQLSelectFrame
  Width = 451
  Height = 304
  Align = alClient
  ExplicitWidth = 451
  ExplicitHeight = 304
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 451
    Height = 304
    Align = alClient
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object PageControl: TBCPageControl
      AlignWithMargins = True
      Left = 3
      Top = 0
      Width = 448
      Height = 304
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      ActivePage = AndOrKeywordTabSheet
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      MultiLine = True
      ParentFont = False
      TabOrder = 0
      ActivePageCaption = 'AND/OR keyword'
      TabDragDrop = False
      HoldShiftToDragDrop = False
      ShowCloseButton = False
      object ColumnListTabSheet: TTabSheet
        Caption = 'Column list'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        object ColumnListStyleLabel: TLabel
          Left = 11
          Top = 7
          Width = 24
          Height = 13
          Caption = 'Style'
        end
        object ColumnListLineBreakLabel: TLabel
          Left = 11
          Top = 49
          Width = 49
          Height = 13
          Caption = 'Line break'
        end
        object ColumnListStyleComboBox: TBCComboBox
          Left = 9
          Top = 21
          Width = 186
          Height = 22
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Style = csOwnerDrawFixed
          DropDownCount = 9
          TabOrder = 0
          DeniedKeyStrokes = True
          ReadOnly = False
          DropDownFixedWidth = 0
        end
        object ColumnListLineBreakComboBox: TBCComboBox
          Left = 9
          Top = 65
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
        object AlignAliasCheckBox: TBCCheckBox
          Left = 9
          Top = 93
          Width = 68
          Height = 17
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'Align alias'
          Checked = True
          State = cbChecked
          TabOrder = 2
          LinkedControls = <>
        end
        object ColumnInNewLineCheckBox: TBCCheckBox
          Left = 9
          Top = 113
          Width = 114
          Height = 17
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'Columns in new line'
          Checked = True
          State = cbChecked
          TabOrder = 3
          LinkedControls = <>
        end
        object TreatDistinctAsVirtualColumnCheckBox: TBCCheckBox
          Left = 9
          Top = 133
          Width = 180
          Height = 17
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'Treat DISTINCT as virtual column'
          Checked = True
          State = cbChecked
          TabOrder = 4
          LinkedControls = <>
        end
      end
      object SubqueryTabSheet: TTabSheet
        Caption = 'Subquery'
        ImageIndex = 1
        object NewLineAfterInCheckBox: TBCCheckBox
          Left = 9
          Top = 5
          Width = 102
          Height = 17
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'New line after IN'
          Checked = True
          State = cbChecked
          TabOrder = 0
          LinkedControls = <>
        end
        object NewLineAfterExistsCheckBox: TBCCheckBox
          Left = 9
          Top = 25
          Width = 125
          Height = 17
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'New line after EXISTS'
          Checked = True
          State = cbChecked
          TabOrder = 1
          LinkedControls = <>
        end
        object NewlineAfterComparisonOperatorCheckBox: TBCCheckBox
          Left = 9
          Top = 45
          Width = 190
          Height = 17
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'New line after comparison operator'
          Checked = True
          State = cbChecked
          TabOrder = 2
          LinkedControls = <>
        end
        object NewlineBeforeComparisonOperatorCheckBox: TBCCheckBox
          Left = 9
          Top = 65
          Width = 198
          Height = 17
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'New line before comparison operator'
          Checked = True
          State = cbChecked
          TabOrder = 3
          LinkedControls = <>
        end
      end
      object IntoClauseTabSheet: TTabSheet
        Caption = 'INTO clause'
        ImageIndex = 2
        object IntoClauseInNewLineCheckBox: TBCCheckBox
          Left = 9
          Top = 5
          Width = 132
          Height = 17
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'INTO clause in new line'
          Checked = True
          State = cbChecked
          TabOrder = 0
          LinkedControls = <>
        end
      end
      object FromJoinClauseTabSheet: TTabSheet
        Caption = 'FROM/JOIN clause'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ImageIndex = 3
        ParentFont = False
        object FromClauseStyleLabel: TLabel
          Left = 11
          Top = 7
          Width = 24
          Height = 13
          Caption = 'Style'
        end
        object FromClauseStyleComboBox: TBCComboBox
          Left = 9
          Top = 23
          Width = 186
          Height = 22
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Style = csOwnerDrawFixed
          DropDownCount = 9
          TabOrder = 0
          DeniedKeyStrokes = True
          ReadOnly = False
          DropDownFixedWidth = 0
        end
        object FromClauseInNewLineCheckBox: TBCCheckBox
          Left = 9
          Top = 52
          Width = 136
          Height = 17
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'FROM clause in new line'
          Checked = True
          State = cbChecked
          TabOrder = 1
          LinkedControls = <>
        end
        object JoinClauseInNewLineCheckBox: TBCCheckBox
          Left = 9
          Top = 72
          Width = 131
          Height = 17
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'JOIN clause in new line'
          Checked = True
          State = cbChecked
          TabOrder = 2
          LinkedControls = <>
        end
        object AlignJoinWithFromKeywordCheckBox: TBCCheckBox
          Left = 9
          Top = 92
          Width = 170
          Height = 17
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'Align JOIN with FROM keyword'
          Checked = True
          State = cbChecked
          TabOrder = 3
          LinkedControls = <>
        end
        object AlignAndOrWithOnInJoinClauseCheckBox: TBCCheckBox
          Left = 9
          Top = 112
          Width = 202
          Height = 17
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'Align AND/OR with ON in JOIN clause '
          Checked = True
          State = cbChecked
          TabOrder = 4
          LinkedControls = <>
        end
        object AlignAliasInFromClauseCheckBox: TBCCheckBox
          Left = 9
          Top = 132
          Width = 144
          Height = 17
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'Align alias in FROM clause'
          Checked = True
          State = cbChecked
          TabOrder = 5
          LinkedControls = <>
        end
      end
      object AndOrKeywordTabSheet: TTabSheet
        Caption = 'AND/OR keyword'
        ImageIndex = 4
        object AndOrLineBreakLabel: TLabel
          Left = 11
          Top = 7
          Width = 49
          Height = 13
          Caption = 'Line break'
        end
        object AndOrLineBreakComboBox: TBCComboBox
          Left = 9
          Top = 23
          Width = 186
          Height = 22
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Style = csOwnerDrawFixed
          DropDownCount = 9
          TabOrder = 0
          DeniedKeyStrokes = True
          ReadOnly = False
          DropDownFixedWidth = 0
        end
        object AndOrUnderWhereCheckBox: TBCCheckBox
          Left = 9
          Top = 52
          Width = 125
          Height = 17
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'AND/OR under where'
          Checked = True
          State = cbChecked
          TabOrder = 1
          LinkedControls = <>
        end
        object WhereClauseInNewlineCheckBox: TBCCheckBox
          Left = 9
          Top = 72
          Width = 143
          Height = 17
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'WHERE clause in new line'
          Checked = True
          State = cbChecked
          TabOrder = 2
          LinkedControls = <>
        end
        object WhereClauseAlignExprCheckBox: TBCCheckBox
          Left = 9
          Top = 92
          Width = 140
          Height = 17
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'WHERE clause align expr'
          Checked = True
          State = cbChecked
          TabOrder = 3
          LinkedControls = <>
        end
      end
      object GroupByClauseTabSheet: TTabSheet
        Caption = 'GROUP BY clause'
        ImageIndex = 5
        object GroupByClauseStyleLabel: TLabel
          Left = 11
          Top = 7
          Width = 24
          Height = 13
          Caption = 'Style'
        end
        object GroupByClauseStyleComboBox: TBCComboBox
          Left = 9
          Top = 22
          Width = 186
          Height = 22
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Style = csOwnerDrawFixed
          DropDownCount = 9
          TabOrder = 0
          DeniedKeyStrokes = True
          ReadOnly = False
          DropDownFixedWidth = 0
        end
        object GroupByClauseInNewLineCheckBox: TBCCheckBox
          Left = 9
          Top = 52
          Width = 157
          Height = 17
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'GROUP BY clause in new line'
          Checked = True
          State = cbChecked
          TabOrder = 1
          LinkedControls = <>
        end
      end
      object HavingClauseTabSheet: TTabSheet
        Caption = 'HAVING clause'
        ImageIndex = 6
        object HavingClauseInNewLineCheckBox: TBCCheckBox
          Left = 9
          Top = 5
          Width = 145
          Height = 17
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'HAVING clause in new line'
          Checked = True
          State = cbChecked
          TabOrder = 0
          LinkedControls = <>
        end
      end
      object OderByClauseTabSheet: TTabSheet
        Caption = 'ORDER BY clause'
        ImageIndex = 7
        object OrderByClauseStyleLabel: TLabel
          Left = 11
          Top = 7
          Width = 24
          Height = 13
          Caption = 'Style'
        end
        object OrderByClauseStyleComboBox: TBCComboBox
          Left = 9
          Top = 23
          Width = 186
          Height = 22
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Style = csOwnerDrawFixed
          DropDownCount = 9
          TabOrder = 0
          DeniedKeyStrokes = True
          ReadOnly = False
          DropDownFixedWidth = 0
        end
        object OrderByClauseInNewLineCheckBox: TBCCheckBox
          Left = 9
          Top = 52
          Width = 157
          Height = 17
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'ORDER BY clause in new line'
          Checked = True
          State = cbChecked
          TabOrder = 1
          LinkedControls = <>
        end
      end
    end
  end
end
