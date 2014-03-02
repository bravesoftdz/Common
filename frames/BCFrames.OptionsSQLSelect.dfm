inherited OptionsSQLSelectFrame: TOptionsSQLSelectFrame
  Width = 451
  Height = 302
  Align = alClient
  ExplicitWidth = 451
  ExplicitHeight = 302
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 451
    Height = 302
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
      Height = 302
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      ActivePage = FromJoinClauseTabSheet
      Align = alClient
      MultiLine = True
      TabOrder = 0
      ActivePageCaption = 'FROM/JOIN clause'
      TabDragDrop = False
      HoldShiftToDragDrop = False
      ShowCloseButton = False
      object ColumnListTabSheet: TTabSheet
        Caption = 'Column list'
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
          Width = 276
          Height = 21
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = ' Align alias'
          Checked = True
          State = cbChecked
          TabOrder = 2
          ReadOnly = False
        end
        object ColumnInNewLineCheckBox: TBCCheckBox
          Left = 9
          Top = 113
          Width = 282
          Height = 21
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = ' Columns in new line'
          Checked = True
          State = cbChecked
          TabOrder = 3
          ReadOnly = False
        end
        object TreatDistinctAsVirtualColumnCheckBox: TBCCheckBox
          Left = 9
          Top = 133
          Width = 276
          Height = 21
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = ' Treat distinct as virtual column'
          Checked = True
          State = cbChecked
          TabOrder = 4
          ReadOnly = False
        end
      end
      object SubqueryTabSheet: TTabSheet
        Caption = 'Subquery'
        ImageIndex = 1
        object NewLineAfterInCheckBox: TBCCheckBox
          Left = 9
          Top = 5
          Width = 282
          Height = 21
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = ' New line after IN'
          Checked = True
          State = cbChecked
          TabOrder = 0
          ReadOnly = False
        end
        object NewLineAfterExistsCheckBox: TBCCheckBox
          Left = 9
          Top = 25
          Width = 276
          Height = 21
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = ' New line after EXISTS'
          Checked = True
          State = cbChecked
          TabOrder = 1
          ReadOnly = False
        end
        object NewlineAfterComparisonOperatorCheckBox: TBCCheckBox
          Left = 9
          Top = 45
          Width = 276
          Height = 21
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = ' New line after comparison operator'
          Checked = True
          State = cbChecked
          TabOrder = 2
          ReadOnly = False
        end
        object NewlineBeforeComparisonOperatorCheckBox: TBCCheckBox
          Left = 9
          Top = 65
          Width = 276
          Height = 21
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = ' New line before comparison operator'
          Checked = True
          State = cbChecked
          TabOrder = 3
          ReadOnly = False
        end
      end
      object IntoClauseTabSheet: TTabSheet
        Caption = 'INTO clause'
        ImageIndex = 2
        object IntoClauseInNewLineCheckBox: TBCCheckBox
          Left = 9
          Top = 5
          Width = 282
          Height = 21
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = ' Into clause in new line'
          Checked = True
          State = cbChecked
          TabOrder = 0
          ReadOnly = False
        end
      end
      object FromJoinClauseTabSheet: TTabSheet
        Caption = 'FROM/JOIN clause'
        ImageIndex = 3
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
          Width = 282
          Height = 21
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = ' From clause in new line'
          Checked = True
          State = cbChecked
          TabOrder = 1
          ReadOnly = False
        end
        object JoinClauseInNewLineCheckBox: TBCCheckBox
          Left = 9
          Top = 72
          Width = 282
          Height = 21
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = ' Join clause in new line'
          Checked = True
          State = cbChecked
          TabOrder = 2
          ReadOnly = False
        end
        object AlignJoinWithFromKeywordCheckBox: TBCCheckBox
          Left = 9
          Top = 92
          Width = 282
          Height = 21
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = ' Align join with FROM keyword'
          Checked = True
          State = cbChecked
          TabOrder = 3
          ReadOnly = False
        end
        object AlignAndOrWithOnInJoinClauseCheckBox: TBCCheckBox
          Left = 9
          Top = 112
          Width = 282
          Height = 21
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = ' Align AND/OR with ON in join clause '
          Checked = True
          State = cbChecked
          TabOrder = 4
          ReadOnly = False
        end
        object AlignAliasInFromClauseCheckBox: TBCCheckBox
          Left = 9
          Top = 132
          Width = 282
          Height = 21
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = ' Align alias in FROM clause'
          Checked = True
          State = cbChecked
          TabOrder = 5
          ReadOnly = False
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
          Width = 276
          Height = 21
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = ' AND/OR under where'
          Checked = True
          State = cbChecked
          TabOrder = 1
          ReadOnly = False
        end
        object WhereClauseInNewlineCheckBox: TBCCheckBox
          Left = 9
          Top = 72
          Width = 276
          Height = 21
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = ' Where clause in new line'
          Checked = True
          State = cbChecked
          TabOrder = 2
          ReadOnly = False
        end
        object WhereClauseAlignExprCheckBox: TBCCheckBox
          Left = 9
          Top = 92
          Width = 276
          Height = 21
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = ' Where clause align expr'
          Checked = True
          State = cbChecked
          TabOrder = 3
          ReadOnly = False
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
          Width = 282
          Height = 21
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = ' GROUP BY clause in new line'
          Checked = True
          State = cbChecked
          TabOrder = 1
          ReadOnly = False
        end
      end
      object HavingClauseTabSheet: TTabSheet
        Caption = 'HAVING clause'
        ImageIndex = 6
        object HavingClauseInNewLineCheckBox: TBCCheckBox
          Left = 9
          Top = 5
          Width = 282
          Height = 21
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = ' Having clause in new line'
          Checked = True
          State = cbChecked
          TabOrder = 0
          ReadOnly = False
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
          Width = 282
          Height = 21
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = ' ORDER BY clause in new line'
          Checked = True
          State = cbChecked
          TabOrder = 1
          ReadOnly = False
        end
      end
    end
  end
end
