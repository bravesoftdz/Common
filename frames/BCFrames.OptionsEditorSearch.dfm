inherited OptionsEditorSearchFrame: TOptionsEditorSearchFrame
  Width = 300
  Height = 64
  AutoSize = True
  ExplicitWidth = 300
  ExplicitHeight = 64
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 300
    Height = 64
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object ShowSearchStringNotFoundCheckBox: TBCCheckBox
      Left = 4
      Top = 0
      Width = 331
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Show search string not found message'
      Checked = True
      State = cbChecked
      TabOrder = 0
      ReadOnly = False
    end
    object BeepIfSearchStringNotFoundCheckBox: TBCCheckBox
      Left = 4
      Top = 20
      Width = 335
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Beep if search string not found'
      Checked = True
      State = cbChecked
      TabOrder = 1
      ReadOnly = False
    end
    object DocumentSpecificSearchCheckBox: TBCCheckBox
      Left = 4
      Top = 40
      Width = 280
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Document-specific search'
      Checked = True
      State = cbChecked
      TabOrder = 2
      ReadOnly = False
    end
  end
end
