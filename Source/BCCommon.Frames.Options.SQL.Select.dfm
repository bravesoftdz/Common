inherited OptionsSQLSelectFrame: TOptionsSQLSelectFrame
  Width = 451
  Height = 304
  Align = alClient
  object Panel: TBCPanel [0]
    Left = 0
    Top = 0
    Width = 451
    Height = 304
    Align = alClient
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    SkinData.SkinSection = 'CHECKBOX'
    object PageControl: TBCPageControl
      AlignWithMargins = True
      Left = 3
      Top = 0
      Width = 448
      Height = 304
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      ActivePage = TabSheetAndOrKeyword
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      MultiLine = True
      ParentFont = False
      TabHeight = 22
      TabOrder = 0
      TabMargin = 2
      SkinData.SkinSection = 'PAGECONTROL'
      ActivePageCaption = 'AND/OR keyword'
      HoldShiftToDragDrop = False
      TabDragDrop = False
      object TabSheetColumnList: TsTabSheet
        Caption = 'Column list'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        object ComboBoxColumnListStyle: TBCComboBox
          Left = 9
          Top = 20
          Width = 186
          Height = 22
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Alignment = taLeftJustify
          BoundLabel.Active = True
          BoundLabel.Caption = 'Style'
          BoundLabel.Indent = 4
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          BoundLabel.Layout = sclTopLeft
          BoundLabel.MaxWidth = 0
          BoundLabel.UseSkinColor = True
          DropDownCount = 9
          SkinData.SkinSection = 'COMBOBOX'
          VerticalAlignment = taAlignTop
          Style = csOwnerDrawFixed
          ItemIndex = -1
          TabOrder = 0
        end
        object ComboBoxColumnListLineBreak: TBCComboBox
          Left = 9
          Top = 65
          Width = 186
          Height = 22
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Alignment = taLeftJustify
          BoundLabel.Active = True
          BoundLabel.Caption = 'Line break'
          BoundLabel.Indent = 4
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          BoundLabel.Layout = sclTopLeft
          BoundLabel.MaxWidth = 0
          BoundLabel.UseSkinColor = True
          DropDownCount = 9
          SkinData.SkinSection = 'COMBOBOX'
          VerticalAlignment = taAlignTop
          Style = csOwnerDrawFixed
          ItemIndex = -1
          TabOrder = 1
        end
        object CheckBoxAlignAlias: TBCCheckBox
          Left = 9
          Top = 93
          Width = 67
          Height = 20
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'Align alias'
          Checked = True
          State = cbChecked
          TabOrder = 2
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object CheckBoxColumnInNewLine: TBCCheckBox
          Left = 9
          Top = 113
          Width = 113
          Height = 20
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'Columns in new line'
          Checked = True
          State = cbChecked
          TabOrder = 3
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object CheckBoxTreatDistinctAsVirtualColumn: TBCCheckBox
          Left = 9
          Top = 133
          Width = 179
          Height = 20
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'Treat DISTINCT as virtual column'
          Checked = True
          State = cbChecked
          TabOrder = 4
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
      end
      object TabSheetSubquery: TsTabSheet
        Caption = 'Subquery'
        ImageIndex = 1
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        object CheckBoxNewLineAfterIn: TBCCheckBox
          Left = 9
          Top = 5
          Width = 101
          Height = 20
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'New line after IN'
          Checked = True
          State = cbChecked
          TabOrder = 0
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object CheckBoxNewLineAfterExists: TBCCheckBox
          Left = 9
          Top = 25
          Width = 124
          Height = 20
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'New line after EXISTS'
          Checked = True
          State = cbChecked
          TabOrder = 1
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object CheckBoxNewlineAfterComparisonOperator: TBCCheckBox
          Left = 9
          Top = 45
          Width = 189
          Height = 20
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'New line after comparison operator'
          Checked = True
          State = cbChecked
          TabOrder = 2
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object CheckBoxNewlineBeforeComparisonOperator: TBCCheckBox
          Left = 9
          Top = 65
          Width = 197
          Height = 20
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'New line before comparison operator'
          Checked = True
          State = cbChecked
          TabOrder = 3
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
      end
      object TabSheetIntoClause: TsTabSheet
        Caption = 'INTO clause'
        ImageIndex = 2
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        object CheckBoxIntoClauseInNewLine: TBCCheckBox
          Left = 9
          Top = 5
          Width = 131
          Height = 20
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'INTO clause in new line'
          Checked = True
          State = cbChecked
          TabOrder = 0
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
      end
      object TabSheetFromJoinClause: TsTabSheet
        Caption = 'FROM/JOIN clause'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ImageIndex = 3
        ParentFont = False
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        object ComboBoxFromClauseStyle: TBCComboBox
          Left = 9
          Top = 23
          Width = 186
          Height = 22
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Alignment = taLeftJustify
          BoundLabel.Active = True
          BoundLabel.Caption = 'Style'
          BoundLabel.Indent = 4
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          BoundLabel.Layout = sclTopLeft
          BoundLabel.MaxWidth = 0
          BoundLabel.UseSkinColor = True
          DropDownCount = 9
          SkinData.SkinSection = 'COMBOBOX'
          VerticalAlignment = taAlignTop
          Style = csOwnerDrawFixed
          ItemIndex = -1
          TabOrder = 0
        end
        object CheckBoxFromClauseInNewLine: TBCCheckBox
          Left = 9
          Top = 52
          Width = 135
          Height = 20
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'FROM clause in new line'
          Checked = True
          State = cbChecked
          TabOrder = 1
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object CheckBoxJoinClauseInNewLine: TBCCheckBox
          Left = 9
          Top = 72
          Width = 130
          Height = 20
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'JOIN clause in new line'
          Checked = True
          State = cbChecked
          TabOrder = 2
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object CheckBoxAlignJoinWithFromKeyword: TBCCheckBox
          Left = 9
          Top = 92
          Width = 169
          Height = 20
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'Align JOIN with FROM keyword'
          Checked = True
          State = cbChecked
          TabOrder = 3
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object CheckBoxAlignAndOrWithOnInJoinClause: TBCCheckBox
          Left = 9
          Top = 112
          Width = 201
          Height = 20
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'Align AND/OR with ON in JOIN clause '
          Checked = True
          State = cbChecked
          TabOrder = 4
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object CheckBoxAlignAliasInFromClause: TBCCheckBox
          Left = 9
          Top = 132
          Width = 143
          Height = 20
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'Align alias in FROM clause'
          Checked = True
          State = cbChecked
          TabOrder = 5
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
      end
      object TabSheetAndOrKeyword: TsTabSheet
        Caption = 'AND/OR keyword'
        ImageIndex = 4
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        object ComboBoxAndOrLineBreak: TBCComboBox
          Left = 9
          Top = 23
          Width = 186
          Height = 22
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Alignment = taLeftJustify
          BoundLabel.Active = True
          BoundLabel.Caption = 'Line break'
          BoundLabel.Indent = 4
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          BoundLabel.Layout = sclTopLeft
          BoundLabel.MaxWidth = 0
          BoundLabel.UseSkinColor = True
          DropDownCount = 9
          SkinData.SkinSection = 'COMBOBOX'
          VerticalAlignment = taAlignTop
          Style = csOwnerDrawFixed
          ItemIndex = -1
          TabOrder = 0
        end
        object CheckBoxAndOrUnderWhere: TBCCheckBox
          Left = 9
          Top = 52
          Width = 124
          Height = 20
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'AND/OR under where'
          Checked = True
          State = cbChecked
          TabOrder = 1
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object CheckBoxWhereClauseInNewline: TBCCheckBox
          Left = 9
          Top = 72
          Width = 142
          Height = 20
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'WHERE clause in new line'
          Checked = True
          State = cbChecked
          TabOrder = 2
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object CheckBoxWhereClauseAlignExpr: TBCCheckBox
          Left = 9
          Top = 92
          Width = 139
          Height = 20
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'WHERE clause align expr'
          Checked = True
          State = cbChecked
          TabOrder = 3
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
      end
      object TabSheetGroupByClause: TsTabSheet
        Caption = 'GROUP BY clause'
        ImageIndex = 5
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        object ComboBoxGroupByClauseStyle: TBCComboBox
          Left = 9
          Top = 22
          Width = 186
          Height = 22
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Alignment = taLeftJustify
          BoundLabel.Active = True
          BoundLabel.Caption = 'Style'
          BoundLabel.Indent = 4
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          BoundLabel.Layout = sclTopLeft
          BoundLabel.MaxWidth = 0
          BoundLabel.UseSkinColor = True
          DropDownCount = 9
          SkinData.SkinSection = 'COMBOBOX'
          VerticalAlignment = taAlignTop
          Style = csOwnerDrawFixed
          ItemIndex = -1
          TabOrder = 0
        end
        object CheckBoxGroupByClauseInNewLine: TBCCheckBox
          Left = 9
          Top = 52
          Width = 156
          Height = 20
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'GROUP BY clause in new line'
          Checked = True
          State = cbChecked
          TabOrder = 1
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
      end
      object TabSheetHavingClause: TsTabSheet
        Caption = 'HAVING clause'
        ImageIndex = 6
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        object CheckBoxHavingClauseInNewLine: TBCCheckBox
          Left = 9
          Top = 5
          Width = 147
          Height = 20
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = ' HAVING clause in new line'
          Checked = True
          State = cbChecked
          TabOrder = 0
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
      end
      object TabSheetOrderByClause: TsTabSheet
        Caption = 'ORDER BY clause'
        ImageIndex = 7
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        object ComboBoxOrderByClauseStyle: TBCComboBox
          Left = 9
          Top = 23
          Width = 186
          Height = 22
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Alignment = taLeftJustify
          BoundLabel.Active = True
          BoundLabel.Caption = 'Style'
          BoundLabel.Indent = 4
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          BoundLabel.Layout = sclTopLeft
          BoundLabel.MaxWidth = 0
          BoundLabel.UseSkinColor = True
          DropDownCount = 9
          SkinData.SkinSection = 'COMBOBOX'
          VerticalAlignment = taAlignTop
          Style = csOwnerDrawFixed
          ItemIndex = -1
          TabOrder = 0
        end
        object CheckBoxOrderByClauseInNewLine: TBCCheckBox
          Left = 9
          Top = 52
          Width = 156
          Height = 20
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'ORDER BY clause in new line'
          Checked = True
          State = cbChecked
          TabOrder = 1
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
      end
    end
  end
end
