inherited OptionsEditorRightMarginFrame: TOptionsEditorRightMarginFrame
  Width = 198
  Height = 81
  Visible = False
  ExplicitWidth = 198
  ExplicitHeight = 81
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 198
    Height = 81
    BevelOuter = bvNone
    TabOrder = 0
    object PositionLabel: TLabel
      Left = 6
      Top = 43
      Width = 37
      Height = 13
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Position'
    end
    object PositionEdit: TBCEdit
      Left = 4
      Top = 60
      Width = 64
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      TabOrder = 0
      Text = '80'
      EnterToTab = False
      OnlyNumbers = True
      NumbersWithDots = False
      NumbersWithSpots = False
      ErrorColor = 14803198
      NumbersAllowNegative = False
    end
    object VisibleCheckBox: TBCCheckBox
      Left = 4
      Top = 0
      Width = 198
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Visible'
      Checked = True
      State = cbChecked
      TabOrder = 2
      ReadOnly = False
    end
    object MouseMoveCheckBox: TBCCheckBox
      Left = 4
      Top = 20
      Width = 198
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Mouse Move'
      Checked = True
      State = cbChecked
      TabOrder = 1
      ReadOnly = False
    end
  end
end
