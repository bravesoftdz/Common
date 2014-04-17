inherited OptionsEditorSearchFrame: TOptionsEditorSearchFrame
  Width = 212
  Height = 95
  AutoSize = True
  object Panel: TPanel
    AlignWithMargins = True
    Left = 4
    Top = 0
    Width = 208
    Height = 95
    Margins.Left = 4
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    AutoSize = True
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
    object ShowSearchStringNotFoundCheckBox: TBCCheckBox
      Left = 0
      Top = 0
      Width = 208
      Height = 15
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Show search string not found message'
      Checked = True
      State = cbChecked
      TabOrder = 0
      AutoSize = True
      ReadOnly = False
    end
    object BeepIfSearchStringNotFoundCheckBox: TBCCheckBox
      Left = 0
      Top = 20
      Width = 170
      Height = 15
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Beep if search string not found'
      Checked = True
      State = cbChecked
      TabOrder = 1
      AutoSize = True
      ReadOnly = False
    end
    object DocumentSpecificSearchCheckBox: TBCCheckBox
      Left = 0
      Top = 40
      Width = 144
      Height = 15
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Document-specific search'
      Checked = True
      State = cbChecked
      TabOrder = 2
      AutoSize = True
      ReadOnly = False
    end
    object ShowSearchMapCheckBox: TBCCheckBox
      Left = 0
      Top = 60
      Width = 106
      Height = 15
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Show search map'
      Checked = True
      State = cbChecked
      TabOrder = 3
      AutoSize = True
      ReadOnly = False
    end
    object ShowSearchHighlighterCheckBox: TBCCheckBox
      Left = 0
      Top = 80
      Width = 136
      Height = 15
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = ' Show search highlighter'
      Checked = True
      State = cbChecked
      TabOrder = 4
      AutoSize = True
      ReadOnly = False
    end
  end
end
