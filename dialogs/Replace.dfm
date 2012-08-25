object ReplaceDialog: TReplaceDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Replace'
  ClientHeight = 137
  ClientWidth = 398
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object ReplaceWithLabel: TLabel
    Left = 8
    Top = 41
    Width = 61
    Height = 13
    Caption = 'Replace with'
  end
  object SearchForLabel: TLabel
    Left = 8
    Top = 14
    Width = 50
    Height = 13
    Caption = 'Search for'
  end
  object ReplaceWithComboBox: TBCComboBox
    Left = 76
    Top = 37
    Width = 228
    Height = 21
    ItemHeight = 13
    ReadOnly = False
    TabOrder = 1
    EditColor = clInfoBk
    DeniedKeyStrokes = False
    DropDownFixedWidth = 0
  end
  object SearchForComboBox: TBCComboBox
    Left = 76
    Top = 10
    Width = 228
    Height = 21
    ItemHeight = 13
    ReadOnly = False
    TabOrder = 0
    OnKeyUp = SearchForComboBoxKeyUp
    EditColor = clInfoBk
    DeniedKeyStrokes = False
    DropDownFixedWidth = 0
  end
  object OptionsGroupBox: TGroupBox
    Left = 8
    Top = 64
    Width = 145
    Height = 65
    Caption = ' Options '
    TabOrder = 2
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
  object ReplaceInRadioGroup: TRadioGroup
    Left = 159
    Top = 64
    Width = 145
    Height = 65
    Caption = ' Replace in '
    ItemIndex = 0
    Items.Strings = (
      ' Whole file'
      ' All open files')
    TabOrder = 3
  end
  object Panel1: TPanel
    Left = 314
    Top = 0
    Width = 84
    Height = 137
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 4
    object FindButton: TButton
      Left = 0
      Top = 7
      Width = 75
      Height = 25
      Caption = '&Find'
      Default = True
      Enabled = False
      ModalResult = 1
      TabOrder = 0
    end
    object ReplaceAllButton: TButton
      Left = 0
      Top = 38
      Width = 75
      Height = 25
      Caption = '&Replace All'
      Enabled = False
      ModalResult = 6
      TabOrder = 1
    end
    object CancelButton: TButton
      Left = 0
      Top = 69
      Width = 75
      Height = 25
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 2
    end
  end
end
