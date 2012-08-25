object FindInFilesDialog: TFindInFilesDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Find in Files'
  ClientHeight = 113
  ClientWidth = 396
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object FindWhatLabel: TLabel
    Left = 8
    Top = 12
    Width = 47
    Height = 13
    Caption = 'Find what'
  end
  object FileTypeLabel: TLabel
    Left = 8
    Top = 36
    Width = 41
    Height = 13
    Caption = 'File type'
  end
  object FolderLabel: TLabel
    Left = 8
    Top = 60
    Width = 30
    Height = 13
    Caption = 'Folder'
  end
  object FindWhatComboBox: TBCComboBox
    Left = 76
    Top = 8
    Width = 228
    Height = 21
    ItemHeight = 13
    ReadOnly = False
    TabOrder = 0
    OnKeyUp = FindWhatComboBoxKeyUp
    EditColor = clInfoBk
    DeniedKeyStrokes = False
    DropDownFixedWidth = 0
  end
  object FileTypeComboBox: TBCComboBox
    Left = 76
    Top = 33
    Width = 228
    Height = 21
    DropDownCount = 20
    ItemHeight = 13
    ReadOnly = False
    TabOrder = 1
    Text = '*.*'
    EditColor = clInfoBk
    DeniedKeyStrokes = False
    DropDownFixedWidth = 0
  end
  object CaseSensitiveCheckBox: TCheckBox
    Left = 80
    Top = 84
    Width = 120
    Height = 17
    Caption = ' C&ase sensitivity'
    TabOrder = 4
  end
  object LookInSubfoldersCheckBox: TCheckBox
    Left = 196
    Top = 84
    Width = 120
    Height = 17
    Caption = ' &Look in subfolders'
    Checked = True
    State = cbChecked
    TabOrder = 5
  end
  object ButtonPanel: TPanel
    Left = 312
    Top = 0
    Width = 84
    Height = 113
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 6
    DesignSize = (
      84
      113)
    object FindButton: TButton
      Left = 1
      Top = 7
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Find'
      Default = True
      Enabled = False
      ModalResult = 1
      TabOrder = 0
    end
    object CancelButton: TButton
      Left = 1
      Top = 38
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object FolderEdit: TBCEdit
    Left = 76
    Top = 57
    Width = 205
    Height = 21
    Hint = 'Folder'
    TabOrder = 2
    OnlyNumbers = False
    NumbersWithDots = False
    NumbersWithSpots = False
    EditColor = clInfoBk
    NumbersAllowNegative = False
  end
  object FolderBitBtn: TBitBtn
    Left = 283
    Top = 57
    Width = 21
    Height = 21
    Action = FolderButtonClickAction
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      0274AC0274AC0274AC0274AC0274AC0274AC0274AC0274AC0274AC0274ACFF00
      FFFF00FFFF00FFFF00FFFF00FF0274AC138AC456B6E14BBFF74ABFF74ABFF74A
      BFF74ABFF64ABFF74ABFF62398CC0C81BAFF00FFFF00FFFF00FFFF00FF0274AC
      33AAE02392C454C7F854C7F753C7F854C7F754C7F854C7F854C7F8279DCEBAEB
      EF0274ACFF00FFFF00FFFF00FF0274AC57CAF80274AC5ED1FA5ED1FA5ED1FA5E
      D1FA5ED1FA5FD1FA5ED1F82CA1CEBAEBEF0274ACFF00FFFF00FFFF00FF0274AC
      68DAFB2BA4D196EBFB74E5FB74E5FB74E5FC74E5FC74E5FB74E5FC33A9CFBAEB
      EFBAEBEF0274ACFF00FFFF00FF0274AC70E3FB5CD1EFFEFFFFB8F4FCBAF4FCBA
      F4FCBAF4FEB8F4FEBAF4FC83C9DEE3FEFEC5EFF60274ACFF00FFFF00FF0274AC
      7AEBFE7AEBFC0274AC0274AC0274AC0274AC0274AC0274AC0274AC0274AC0274
      AC0274AC0274ACFF00FFFF00FF0274AC83F2FE82F3FE83F2FC83F3FE82F3FE83
      F2FE82F3FC83F2FE82F3FE036FA7FF00FFFF00FFFF00FFFF00FFFF00FF0274AC
      FEFEFE89FAFF89FAFE8AF8FE8AFAFE89F8FE8AFAFE8AFAFF89FAFF036FA7FF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FF0274ACFEFEFE8FFEFF8FFEFF0274AC02
      74AC0274AC0274AC0274ACFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FF0274AC0274AC0274ACFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
    TabOrder = 3
  end
  object ActionList: TActionList
    Left = 28
    Top = 76
    object FolderButtonClickAction: TAction
      OnExecute = FolderButtonClickActionExecute
    end
  end
end
