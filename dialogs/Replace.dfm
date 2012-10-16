object ReplaceDialog: TReplaceDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Replace'
  ClientHeight = 137
  ClientWidth = 502
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Padding.Left = 12
  Padding.Top = 12
  Padding.Right = 12
  OldCreateOrder = True
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 407
    Top = 12
    Width = 83
    Height = 125
    Align = alRight
    BevelOuter = bvNone
    Padding.Left = 8
    TabOrder = 0
    ExplicitLeft = 419
    ExplicitTop = 0
    ExplicitHeight = 184
    object CancelButton: TButton
      Left = 8
      Top = 62
      Width = 75
      Height = 25
      Align = alTop
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 0
      ExplicitLeft = 0
      ExplicitTop = 69
    end
    object Panel10: TPanel
      Left = 8
      Top = 0
      Width = 75
      Height = 31
      Align = alTop
      BevelOuter = bvNone
      Padding.Bottom = 6
      TabOrder = 1
      object FindButton: TButton
        Left = 0
        Top = 0
        Width = 75
        Height = 25
        Align = alTop
        Caption = '&Find'
        Default = True
        Enabled = False
        ModalResult = 1
        TabOrder = 0
        ExplicitTop = 7
      end
    end
    object Panel11: TPanel
      Left = 8
      Top = 31
      Width = 75
      Height = 31
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Panel11'
      Padding.Bottom = 6
      TabOrder = 2
      object ReplaceAllButton: TButton
        Left = 0
        Top = 0
        Width = 75
        Height = 25
        Align = alTop
        Caption = '&Replace All'
        Enabled = False
        ModalResult = 6
        TabOrder = 0
        ExplicitTop = 16
      end
    end
  end
  object Panel2: TPanel
    Left = 12
    Top = 12
    Width = 76
    Height = 125
    Align = alLeft
    BevelOuter = bvNone
    Padding.Right = 9
    TabOrder = 1
    ExplicitHeight = 172
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 67
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      Padding.Top = 2
      TabOrder = 0
      object SearchForLabel: TLabel
        Left = 0
        Top = 2
        Width = 50
        Height = 23
        Align = alLeft
        Caption = 'Search for'
        ExplicitTop = 12
        ExplicitHeight = 13
      end
    end
    object Panel5: TPanel
      Left = 0
      Top = 25
      Width = 67
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      Padding.Top = 2
      TabOrder = 1
      object ReplaceWithLabel: TLabel
        Left = 0
        Top = 2
        Width = 61
        Height = 23
        Align = alLeft
        Caption = 'Replace with'
        ExplicitLeft = 1
        ExplicitTop = 3
        ExplicitHeight = 25
      end
    end
  end
  object Panel4: TPanel
    Left = 88
    Top = 12
    Width = 319
    Height = 125
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitLeft = 94
    ExplicitTop = 5
    ExplicitWidth = 315
    ExplicitHeight = 144
    object Panel6: TPanel
      Left = 0
      Top = 0
      Width = 319
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 313
      object SearchForComboBox: TBCComboBox
        Left = 0
        Top = 0
        Width = 319
        Height = 21
        Align = alTop
        ItemHeight = 13
        ReadOnly = False
        TabOrder = 0
        OnKeyUp = SearchForComboBoxKeyUp
        EditColor = clInfoBk
        DeniedKeyStrokes = False
        DropDownFixedWidth = 0
        ExplicitLeft = 1
        ExplicitTop = 1
        ExplicitWidth = 183
      end
    end
    object Panel7: TPanel
      Left = 0
      Top = 25
      Width = 319
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitLeft = 1
      ExplicitTop = 26
      ExplicitWidth = 313
      object ReplaceWithComboBox: TBCComboBox
        Left = 0
        Top = 0
        Width = 319
        Height = 21
        Align = alTop
        ItemHeight = 13
        ReadOnly = False
        TabOrder = 0
        EditColor = clInfoBk
        DeniedKeyStrokes = False
        DropDownFixedWidth = 0
        ExplicitLeft = 84
        ExplicitTop = 4
        ExplicitWidth = 229
      end
    end
    object Panel8: TPanel
      Left = 0
      Top = 50
      Width = 319
      Height = 75
      Align = alClient
      BevelOuter = bvNone
      Padding.Bottom = 10
      TabOrder = 2
      ExplicitLeft = 40
      ExplicitTop = 72
      ExplicitWidth = 185
      ExplicitHeight = 41
      object OptionsGroupBox: TGroupBox
        Left = 0
        Top = 0
        Width = 145
        Height = 65
        Align = alLeft
        Caption = ' Options '
        TabOrder = 0
        ExplicitLeft = 12
        ExplicitTop = 13
        object CaseSensitiveCheckBox: TCheckBox
          Left = 8
          Top = 16
          Width = 120
          Height = 17
          Caption = ' Case sensitivity'
          TabOrder = 0
        end
        object WholeWordsCheckBox: TCheckBox
          Left = 8
          Top = 39
          Width = 120
          Height = 17
          Caption = ' Whole words only'
          TabOrder = 1
        end
      end
      object Panel9: TPanel
        Left = 145
        Top = 0
        Width = 174
        Height = 65
        Align = alClient
        BevelOuter = bvNone
        Padding.Left = 8
        TabOrder = 1
        ExplicitLeft = 196
        ExplicitTop = 30
        ExplicitWidth = 185
        ExplicitHeight = 41
        object ReplaceInRadioGroup: TRadioGroup
          Left = 8
          Top = 0
          Width = 166
          Height = 65
          Align = alClient
          Caption = ' Replace in '
          ItemIndex = 0
          Items.Strings = (
            ' Whole file'
            ' All open files')
          TabOrder = 0
          ExplicitLeft = 20
          ExplicitTop = 25
          ExplicitWidth = 146
        end
      end
    end
  end
end
