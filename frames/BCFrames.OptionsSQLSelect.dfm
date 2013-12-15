object OptionsSQLSelectFrame: TOptionsSQLSelectFrame
  Left = 0
  Top = 0
  Width = 405
  Height = 503
  TabOrder = 0
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 405
    Height = 503
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object PageControl1: TPageControl
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 399
      Height = 497
      ActivePage = TabSheet1
      Align = alClient
      MultiLine = True
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = 'Column List'
        object ColumnListStyleLabel: TLabel
          Left = 11
          Top = 7
          Width = 24
          Height = 13
          Caption = 'Style'
        end
        object LineBreakLabel: TLabel
          Left = 11
          Top = 49
          Width = 49
          Height = 13
          Caption = 'Line Break'
        end
        object ColumnListStyleComboBox: TBCComboBox
          Left = 9
          Top = 23
          Width = 133
          Height = 21
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Style = csDropDownList
          DropDownCount = 9
          TabOrder = 0
          DeniedKeyStrokes = True
          ReadOnly = False
          DropDownFixedWidth = 0
        end
        object LineBreakComboBox: TBCComboBox
          Left = 9
          Top = 65
          Width = 133
          Height = 21
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Style = csDropDownList
          DropDownCount = 9
          TabOrder = 1
          DeniedKeyStrokes = True
          ReadOnly = False
          DropDownFixedWidth = 0
        end
        object AlignAliasCheckBox: TBCCheckBox
          Left = 9
          Top = 89
          Width = 276
          Height = 21
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = ' Align Alias'
          Checked = True
          State = cbChecked
          TabOrder = 2
          ReadOnly = False
        end
        object ColumnInNewLineCheckBox: TBCCheckBox
          Left = 9
          Top = 109
          Width = 282
          Height = 21
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = ' Columns In New Line'
          Checked = True
          State = cbChecked
          TabOrder = 3
          ReadOnly = False
        end
        object TreatDistinctAsVirtualColumnCheckBox: TBCCheckBox
          Left = 9
          Top = 129
          Width = 276
          Height = 21
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = ' Treat Distinct As Virtual Column'
          Checked = True
          State = cbChecked
          TabOrder = 4
          ReadOnly = False
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Subquery'
        ImageIndex = 1
        object NewLineAfterInCheckBox: TBCCheckBox
          Left = 11
          Top = 7
          Width = 282
          Height = 21
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = ' New Line After IN'
          Checked = True
          State = cbChecked
          TabOrder = 0
          ReadOnly = False
        end
        object NewLineAfterExistsCheckBox: TBCCheckBox
          Left = 11
          Top = 27
          Width = 276
          Height = 21
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = ' New Line After EXISTS'
          Checked = True
          State = cbChecked
          TabOrder = 1
          ReadOnly = False
        end
        object NewlineAfterComparisonOperatorCheckBox: TBCCheckBox
          Left = 11
          Top = 47
          Width = 276
          Height = 21
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = ' New Line After Comparison Operator'
          Checked = True
          State = cbChecked
          TabOrder = 2
          ReadOnly = False
        end
        object NewlineBeforeComparisonOperatorCheckBox: TBCCheckBox
          Left = 11
          Top = 67
          Width = 276
          Height = 21
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = ' New Line Before Comparison Operator'
          Checked = True
          State = cbChecked
          TabOrder = 3
          ReadOnly = False
        end
      end
      object TabSheet3: TTabSheet
        Caption = 'Into Clause'
        ImageIndex = 2
      end
      object TabSheet4: TTabSheet
        Caption = 'From/Join Clause'
        ImageIndex = 3
      end
      object TabSheet5: TTabSheet
        Caption = 'And/Or Keyword'
        ImageIndex = 4
      end
      object TabSheet6: TTabSheet
        Caption = 'Group By Clause'
        ImageIndex = 5
      end
      object TabSheet7: TTabSheet
        Caption = 'Having Clause'
        ImageIndex = 6
      end
      object TabSheet8: TTabSheet
        Caption = 'Order By Clause'
        ImageIndex = 7
      end
    end
  end
end