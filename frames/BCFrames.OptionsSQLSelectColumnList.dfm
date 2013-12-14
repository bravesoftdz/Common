object OptionsSQLSelectColumnListFrame: TOptionsSQLSelectColumnListFrame
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
    object ColumnListStyleLabel: TLabel
      Left = 11
      Top = 7
      Width = 81
      Height = 13
      Caption = 'Column List Style'
    end
    object ColumnListCommaLabel: TLabel
      Left = 11
      Top = 49
      Width = 92
      Height = 13
      Caption = 'Column List Comma'
    end
    object AlignAliasCheckBox: TBCCheckBox
      Left = 9
      Top = 110
      Width = 276
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Align Alias'
      Checked = True
      State = cbChecked
      TabOrder = 0
      ReadOnly = False
    end
    object ItemInNewLineCheckBox: TBCCheckBox
      Left = 9
      Top = 89
      Width = 282
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Item In New Line'
      Checked = True
      State = cbChecked
      TabOrder = 1
      ReadOnly = False
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
      TabOrder = 2
      DeniedKeyStrokes = True
      ReadOnly = False
      DropDownFixedWidth = 0
    end
    object ColumnListCommaComboBox: TBCComboBox
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
      TabOrder = 3
      DeniedKeyStrokes = True
      ReadOnly = False
      DropDownFixedWidth = 0
    end
    object TreatDistinctAsVirtualColumnCheckBox: TBCCheckBox
      Left = 9
      Top = 131
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
end
