inherited OptionsEditorLeftMarginFrame: TOptionsEditorLeftMarginFrame
  Width = 296
  Height = 299
  Visible = False
  ExplicitWidth = 296
  ExplicitHeight = 299
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 296
    Height = 299
    BevelOuter = bvNone
    TabOrder = 0
    object WidthLabel: TLabel
      Left = 6
      Top = 250
      Width = 28
      Height = 13
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Width'
    end
    object LineModifiedColorLabel: TLabel
      Left = 6
      Top = 164
      Width = 90
      Height = 13
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Line Modified Color'
    end
    object LineNormalColorLabel: TLabel
      Left = 6
      Top = 206
      Width = 83
      Height = 13
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Line Normal Color'
    end
    object VisibleCheckBox: TBCCheckBox
      Left = 4
      Top = 0
      Width = 294
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Visible'
      Checked = True
      State = cbChecked
      TabOrder = 0
      ReadOnly = False
    end
    object AutoSizeCheckBox: TBCCheckBox
      Left = 4
      Top = 20
      Width = 276
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Auto Size'
      Checked = True
      State = cbChecked
      TabOrder = 1
      ReadOnly = False
    end
    object LeftMarginWidthEdit: TBCEdit
      Left = 4
      Top = 267
      Width = 64
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      TabOrder = 10
      Text = '48'
      EnterToTab = False
      OnlyNumbers = True
      NumbersWithDots = False
      NumbersWithSpots = False
      ErrorColor = 14803198
      NumbersAllowNegative = False
    end
    object ShowLineModifiedCheckBox: TBCCheckBox
      Left = 4
      Top = 120
      Width = 296
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Show Line Modified'
      Checked = True
      State = cbChecked
      TabOrder = 6
      ReadOnly = False
    end
    object LineModifiedColorBox: TColorBox
      Left = 4
      Top = 180
      Width = 200
      Height = 22
      Selected = clYellow
      Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor, cbPrettyNames]
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 8
    end
    object LineNormalColorBox: TColorBox
      Left = 4
      Top = 222
      Width = 200
      Height = 22
      Selected = clGreen
      Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor, cbPrettyNames]
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 9
    end
    object InTensCheckBox: TBCCheckBox
      Left = 4
      Top = 40
      Width = 296
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Line Numbers In Tens'
      Checked = True
      State = cbChecked
      TabOrder = 2
      ReadOnly = False
    end
    object ZeroStartCheckBox: TBCCheckBox
      Left = 4
      Top = 60
      Width = 268
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Line Numbers Zero Start'
      Checked = True
      State = cbChecked
      TabOrder = 3
      ReadOnly = False
    end
    object ShowBookmarkPanelCheckBox: TBCCheckBox
      Left = 4
      Top = 100
      Width = 296
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Show Bookmark Panel'
      Checked = True
      State = cbChecked
      TabOrder = 5
      ReadOnly = False
    end
    object ShowBookmarksCheckBox: TBCCheckBox
      Left = 4
      Top = 80
      Width = 296
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Show Bookmarks'
      Checked = True
      State = cbChecked
      TabOrder = 4
      ReadOnly = False
    end
    object ShowLineNumbersAfterLastLineCheckBox: TBCCheckBox
      Left = 4
      Top = 140
      Width = 296
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Show Line Numbers After Last Line'
      Checked = True
      State = cbChecked
      TabOrder = 7
      ReadOnly = False
    end
  end
end
