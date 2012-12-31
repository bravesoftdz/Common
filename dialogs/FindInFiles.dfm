object FindInFilesDialog: TFindInFilesDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Find in Files'
  ClientHeight = 108
  ClientWidth = 446
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Padding.Left = 12
  Padding.Top = 12
  Padding.Right = 12
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ButtonPanel: TPanel
    Left = 350
    Top = 12
    Width = 84
    Height = 96
    Align = alRight
    BevelOuter = bvNone
    Padding.Left = 8
    TabOrder = 0
    object Panel10: TPanel
      Left = 8
      Top = 0
      Width = 76
      Height = 31
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alTop
      AutoSize = True
      BevelOuter = bvNone
      Padding.Bottom = 6
      TabOrder = 0
      object FindButton: TButton
        Left = 0
        Top = 0
        Width = 76
        Height = 25
        Align = alTop
        Caption = '&Find'
        Default = True
        Enabled = False
        ModalResult = 1
        TabOrder = 0
      end
    end
    object Panel11: TPanel
      Left = 8
      Top = 31
      Width = 76
      Height = 25
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alTop
      AutoSize = True
      BevelOuter = bvNone
      TabOrder = 1
      object CancelButton: TButton
        Left = 0
        Top = 0
        Width = 76
        Height = 25
        Align = alTop
        Cancel = True
        Caption = 'Cancel'
        ModalResult = 2
        TabOrder = 0
      end
    end
  end
  object Panel1: TPanel
    Left = 12
    Top = 12
    Width = 62
    Height = 96
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alLeft
    BevelOuter = bvNone
    Padding.Right = 9
    TabOrder = 1
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 53
      Height = 24
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alTop
      BevelOuter = bvNone
      Padding.Top = 2
      TabOrder = 0
      object FindWhatLabel: TLabel
        Left = 0
        Top = 2
        Width = 47
        Height = 22
        Align = alLeft
        Caption = 'Find what'
        ExplicitHeight = 13
      end
    end
    object Panel3: TPanel
      Left = 0
      Top = 24
      Width = 53
      Height = 25
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alTop
      BevelOuter = bvNone
      Padding.Top = 2
      TabOrder = 1
      object FileTypeLabel: TLabel
        Left = 0
        Top = 2
        Width = 41
        Height = 23
        Align = alLeft
        Caption = 'File type'
        ExplicitHeight = 13
      end
    end
    object Panel4: TPanel
      Left = 0
      Top = 49
      Width = 53
      Height = 24
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alTop
      BevelOuter = bvNone
      Padding.Top = 2
      TabOrder = 2
      object FolderLabel: TLabel
        Left = 0
        Top = 2
        Width = 30
        Height = 22
        Align = alLeft
        Caption = 'Folder'
        ExplicitHeight = 13
      end
    end
  end
  object Panel5: TPanel
    Left = 74
    Top = 12
    Width = 276
    Height = 96
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object Panel6: TPanel
      Left = 0
      Top = 0
      Width = 276
      Height = 24
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object FindWhatComboBox: TBCComboBox
        Left = 0
        Top = 0
        Width = 276
        Height = 21
        Align = alTop
        ReadOnly = False
        TabOrder = 0
        OnKeyUp = FindWhatComboBoxKeyUp
        EditColor = clInfoBk
        DeniedKeyStrokes = False
        DropDownFixedWidth = 0
      end
    end
    object Panel7: TPanel
      Left = 0
      Top = 24
      Width = 276
      Height = 24
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object FileTypeComboBox: TBCComboBox
        Left = 0
        Top = 0
        Width = 276
        Height = 21
        Align = alTop
        DropDownCount = 20
        ReadOnly = False
        TabOrder = 0
        Text = '*.*'
        EditColor = clInfoBk
        DeniedKeyStrokes = False
        DropDownFixedWidth = 0
      end
    end
    object Panel8: TPanel
      Left = 0
      Top = 48
      Width = 276
      Height = 21
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alTop
      AutoSize = True
      BevelOuter = bvNone
      TabOrder = 2
      object FolderBitBtn: TBitBtn
        Left = 256
        Top = 0
        Width = 20
        Height = 21
        Action = FolderButtonClickAction
        Align = alRight
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
        TabOrder = 0
      end
      object Panel12: TPanel
        Left = 0
        Top = 0
        Width = 256
        Height = 21
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        AutoSize = True
        BevelOuter = bvNone
        Padding.Right = 3
        TabOrder = 1
        object FolderEdit: TBCEdit
          Left = 0
          Top = 0
          Width = 253
          Height = 21
          Hint = 'Folder'
          Align = alTop
          TabOrder = 0
          OnlyNumbers = False
          NumbersWithDots = False
          NumbersWithSpots = False
          EditColor = clInfoBk
          NumbersAllowNegative = False
        end
      end
    end
    object Panel9: TPanel
      Left = 0
      Top = 69
      Width = 276
      Height = 21
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alTop
      AutoSize = True
      BevelOuter = bvNone
      Padding.Top = 4
      TabOrder = 3
      object CaseSensitiveCheckBox: TCheckBox
        Left = 0
        Top = 4
        Width = 109
        Height = 17
        Caption = ' C&ase sensitivity'
        TabOrder = 0
      end
      object LookInSubfoldersCheckBox: TCheckBox
        Left = 101
        Top = 4
        Width = 120
        Height = 17
        Caption = ' &Look in subfolders'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
    end
  end
  object ActionList: TActionList
    Left = 208
    Top = 30
    object FolderButtonClickAction: TAction
      OnExecute = FolderButtonClickActionExecute
    end
  end
end
