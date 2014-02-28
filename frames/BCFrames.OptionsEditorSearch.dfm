inherited OptionsEditorSearchFrame: TOptionsEditorSearchFrame
  Width = 300
  Height = 41
  ExplicitWidth = 300
  ExplicitHeight = 41
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 300
    Height = 41
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
      Caption = ' Show Search String Not Found Message'
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
      Caption = ' Beep If Search String Not Found'
      Checked = True
      State = cbChecked
      TabOrder = 1
      ReadOnly = False
    end
  end
end
