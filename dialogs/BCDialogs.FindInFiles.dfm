object FindInFilesDialog: TFindInFilesDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Find in Files'
  ClientHeight = 112
  ClientWidth = 499
  Color = clWindow
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
    Left = 404
    Top = 12
    Width = 83
    Height = 100
    Align = alRight
    BevelOuter = bvNone
    Padding.Left = 8
    TabOrder = 0
    object FindButtonPanel: TPanel
      Left = 8
      Top = 0
      Width = 75
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
        Width = 75
        Height = 25
        Align = alTop
        Caption = '&Find'
        Default = True
        Enabled = False
        ModalResult = 1
        TabOrder = 0
      end
    end
    object CancelButtonPanel: TPanel
      Left = 8
      Top = 31
      Width = 75
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
        Width = 75
        Height = 25
        Align = alTop
        Cancel = True
        Caption = 'Cancel'
        ModalResult = 2
        TabOrder = 0
      end
    end
  end
  object LeftPanel: TPanel
    Left = 12
    Top = 12
    Width = 59
    Height = 100
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alLeft
    BevelOuter = bvNone
    Padding.Right = 9
    TabOrder = 1
    object FindWhatPanel: TPanel
      Left = 0
      Top = 0
      Width = 50
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
    object FileTypePanel: TPanel
      Left = 0
      Top = 24
      Width = 50
      Height = 25
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alTop
      AutoSize = True
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
    object FolderPanel: TPanel
      Left = 0
      Top = 49
      Width = 50
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
  object MiddlePanel: TPanel
    Left = 71
    Top = 12
    Width = 333
    Height = 100
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object FindWhatComboPanel: TPanel
      Left = 0
      Top = 0
      Width = 333
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
        Width = 333
        Height = 21
        Align = alTop
        TabOrder = 0
        OnKeyUp = FindWhatComboBoxKeyUp
        DeniedKeyStrokes = False
        ReadOnly = False
        DropDownFixedWidth = 0
      end
    end
    object FileTypeComboPanel: TPanel
      Left = 0
      Top = 24
      Width = 333
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
        Width = 333
        Height = 21
        Align = alTop
        DropDownCount = 20
        TabOrder = 0
        Text = '*.*'
        DeniedKeyStrokes = False
        ReadOnly = False
        DropDownFixedWidth = 0
      end
    end
    object FolderEditPanel: TPanel
      Left = 0
      Top = 48
      Width = 333
      Height = 22
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      object BitBtn1: TJvSpeedButton
        Left = 312
        Top = 0
        Width = 21
        Height = 22
        Action = FolderButtonClickAction
        Align = alRight
        Flat = True
        Glyph.Data = {
          36060000424D3606000000000000360000002800000020000000100000000100
          18000000000000060000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FF68A4CE4396D14E9CD2FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAD
          ADADA3A3A3A6A6A6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FF68A4CF4092CE54ADDE66C4ED7AE0FE4295D0FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAEAEAE9E9E9EB6B6B6CB
          CBCBE3E3E3A2A2A2FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          4E9CD158B0DF6DC9EF7FE2FD7EE3FE7ADEFC80E2FF3F92CE4094CF4093CF4094
          D04D9CD2FF00FFFF00FFFF00FFFF00FFA8A8A8B8B8B8CFCFCFE4E4E4E5E5E5E1
          E1E1E4E4E49F9F9FA0A0A0A0A0A0A1A1A1A6A6A6FF00FFFF00FFFF00FFFF00FF
          4094CF92F1FF85E7FF80E1FD7ADEFB77DBFB85E2FF3B8DCB93F1FF96F3FF9FF9
          FF4094D0FF00FFFF00FFFF00FFFF00FFA1A1A1EFEFEFE7E7E7E3E3E3E1E1E1DF
          DFDFE5E5E59A9A9AEFEFEFF2F2F2F5F5F5A1A1A1FF00FFFF00FFFF00FFFF00FF
          3E92CE9AF0FF83E4FD7EDFFC7ADDFB76DAFA8AE2FE4EA9DD54ABDC8DEDFF9FF3
          FF3E92CFFF00FFFF00FFFF00FFFF00FF9E9E9EEFEFEFE6E6E6E1E1E1E0E0E0DE
          DEDEE4E4E4B2B2B2B3B3B3EDEDEDF2F2F29E9E9EFF00FFFF00FFFF00FFFF00FF
          3E92CEA3F1FF82E3FC7EDFFC7ADDFB76DAFA71D9FBA0E8FF368ACA87EBFFA3F2
          FF3E92CEFF00FFFF00FFFF00FFFF00FFA0A0A0F1F1F1E5E5E5E2E2E2E0E0E0DE
          DEDEDDDDDDEAEAEA989898ECECECF2F2F29E9E9EFF00FFFF00FFFF00FFFF00FF
          3D92CEADF3FF81E3FC7EDFFC7ADDFB76DAFA6FD8FAADEBFF358ACBB0F4FFABF4
          FF3F94D0FF00FFFF00FFFF00FFFF00FF9F9F9FF3F3F3E5E5E5E2E2E2E0E0E0DE
          DEDEDCDCDCEDEDED999999F3F3F3F3F3F3A1A1A1FF00FFFF00FFFF00FFFF00FF
          3C92CEB6F6FF80E3FC7DDFFC7ADDFB76DAFA6ED7FABAEFFF338BCBB5F7FF3A8F
          CD55A1D5FF00FFFF00FFFF00FFFF00FFA0A0A0F4F4F4E4E4E4E2E2E2E0E0E0DE
          DEDEDBDBDBF0F0F0989898F6F6F69C9C9CACACACFF00FFFF00FFFF00FFFF00FF
          3C91CEC0F8FF7FE2FC7DDFFC7ADDFB75DAFA6DD7FAC7F3FF338BCBBCF7FF3D92
          CFFF00FFFF00FFFF00FFFF00FFFF00FF9F9F9FF7F7F7E4E4E4E2E2E2DFDFDFDD
          DDDDDBDBDBF4F4F4999999F5F5F59F9F9FFF00FFFF00FFFF00FFFF00FFFF00FF
          3B91CEC9F9FF7EE2FC7CDEFC78DCFB72D9FA6AD6FAD4F7FF318ACBC1F8FF3D93
          CFFF00FFFF00FFFF00FFFF00FFFF00FF9F9F9FF8F8F8E4E4E4E0E0E0DFDFDFDD
          DDDDDADADAF7F7F7999999F7F7F7A0A0A0FF00FFFF00FFFF00FFFF00FFFF00FF
          3A91CED2FCFF7AE2FC77DDFC7FDFFB9BE6FCB4EDFFD8FAFF318ACBC6F8FF3D93
          CFFF00FFFF00FFFF00FFFF00FFFF00FF9E9E9EFAFAFAE4E4E4E0E0E0E2E2E2E7
          E7E7EEEEEEFAFAFA989898F6F6F69F9F9FFF00FFFF00FFFF00FFFF00FFFF00FF
          3991CFE9FFFFAFF0FFCEF7FFDAFAFFC5EBFB90C8EA66ADDB47A8DDCBF8FF3C92
          CFFF00FFFF00FFFF00FFFF00FFFF00FF9F9F9FFEFEFEF0F0F0F7F7F7F9F9F9EC
          ECECCDCDCDB6B6B6B2B2B2F8F8F89E9E9EFF00FFFF00FFFF00FFFF00FFFF00FF
          3C93D0E9FFFFA8DAF37BBDE44398D13493D146AAE053BDEB61D3FBCEF8FF3B92
          CFFF00FFFF00FFFF00FFFF00FFFF00FFA0A0A0FEFEFEDEDEDEC3C3C3A4A4A4A1
          A1A1B4B4B4C5C5C5D8D8D8F7F7F79E9E9EFF00FFFF00FFFF00FFFF00FFFF00FF
          4297D23B93D062ADDC93CDEDBBE7FAD9FCFFD9FAFFD7F9FFD7F9FFD9FBFF3D94
          D0FF00FFFF00FFFF00FFFF00FFFF00FFA4A4A4A0A0A0B7B7B7D2D2D2E9E9E9FB
          FBFBFAFAFAF8F8F8F8F8F8FAFAFAA0A0A0FF00FFFF00FFFF00FFFF00FFFF00FF
          51A0D64498D24197D13F95D13D94D03B93D03B92CF3B92CF3B92CF3D94D04F9E
          D5FF00FFFF00FFFF00FFFF00FFFF00FFABABABA5A5A5A3A3A3A1A1A1A2A2A2A0
          A0A09F9F9F9F9F9FA0A0A0A1A1A1AAAAAAFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        NumGlyphs = 2
      end
      object FolderEdit2Panel: TPanel
        Left = 0
        Top = 0
        Width = 312
        Height = 22
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        BevelOuter = bvNone
        Padding.Right = 3
        TabOrder = 0
        object FolderEdit: TBCEdit
          Left = 0
          Top = 0
          Width = 309
          Height = 21
          Align = alTop
          TabOrder = 0
          EnterToTab = False
          OnlyNumbers = False
          NumbersWithDots = False
          NumbersWithSpots = False
          ErrorColor = clBlack
          NumbersAllowNegative = False
        end
      end
    end
    object CheckBoxPanel: TPanel
      Left = 0
      Top = 70
      Width = 333
      Height = 21
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alTop
      BevelOuter = bvNone
      Padding.Top = 4
      TabOrder = 3
      object CaseSensitiveLabel: TLabel
        Left = 18
        Top = 4
        Width = 69
        Height = 17
        Align = alLeft
        Caption = 'C&ase sensitive'
        Layout = tlCenter
        ExplicitHeight = 13
      end
      object CaseSensitiveCheckBox: TCheckBox
        Left = 0
        Top = 4
        Width = 18
        Height = 17
        Align = alLeft
        TabOrder = 0
      end
      object LookInSubfoldersCheckBox: TCheckBox
        Left = 95
        Top = 4
        Width = 120
        Height = 17
        Align = alLeft
        Caption = ' &Look in subfolders'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
      object TPanel
        Left = 87
        Top = 4
        Width = 8
        Height = 17
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 2
      end
    end
  end
  object ActionList: TActionList
    Left = 208
    Top = 30
    object FolderButtonClickAction: TAction
      ImageIndex = 0
      OnExecute = FolderButtonClickActionExecute
    end
  end
end
