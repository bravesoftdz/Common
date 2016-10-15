inherited ClipboardHistoryDialog: TClipboardHistoryDialog
  Caption = 'Clipboard history'
  ClientHeight = 358
  ClientWidth = 408
  OnClose = FormClose
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PanelTop: TBCPanel
    Left = 0
    Top = 0
    Width = 408
    Height = 62
    Align = alTop
    BevelOuter = bvNone
    Padding.Left = 2
    Padding.Top = 2
    Padding.Right = 2
    Padding.Bottom = 2
    ParentColor = True
    TabOrder = 0
    SkinData.SkinSection = 'CHECKBOX'
    object SpeedButtonDivider1: TBCSpeedButton
      AlignWithMargins = True
      Left = 142
      Top = 6
      Width = 10
      Height = 50
      Margins.Left = 0
      Margins.Top = 4
      Margins.Right = 0
      Margins.Bottom = 4
      Align = alLeft
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      ButtonStyle = tbsDivider
      SkinData.SkinSection = 'SPEEDBUTTON'
      ImageIndex = 1
    end
    object SpeedButtonDelete: TBCSpeedButton
      Left = 152
      Top = 2
      Width = 60
      Height = 58
      Action = ActionDelete
      Align = alLeft
      AllowAllUp = True
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Segoe UI'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      ButtonStyle = tbsCheck
      SkinData.SkinSection = 'TOOLBUTTON'
      Images = ImagesDataModule.ImageList
      ImageIndex = 22
    end
    object SpeedButtonInsert: TBCSpeedButton
      Left = 2
      Top = 2
      Width = 80
      Height = 58
      Action = ActionCopyToClipboard
      Align = alLeft
      AllowAllUp = True
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Segoe UI'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      ButtonStyle = tbsCheck
      SkinData.SkinSection = 'TOOLBUTTON'
      Images = ImagesDataModule.ImageList
      ImageIndex = 15
    end
    object SpeedButtonClear: TBCSpeedButton
      Left = 212
      Top = 2
      Width = 60
      Height = 58
      Action = ActionClearAll
      Align = alLeft
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Segoe UI'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      ButtonStyle = tbsTextButton
      SkinData.SkinSection = 'TOOLBUTTON'
      Images = ImagesDataModule.ImageList
      ImageIndex = 65
    end
    object BCSpeedButton1: TBCSpeedButton
      Left = 82
      Top = 2
      Width = 60
      Height = 58
      Action = ActionInsertInEditor
      Align = alLeft
      AllowAllUp = True
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Segoe UI'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      ButtonStyle = tbsCheck
      SkinData.SkinSection = 'TOOLBUTTON'
      Images = ImagesDataModule.ImageList
      ImageIndex = 18
    end
  end
  object PanelButtons: TBCPanel
    AlignWithMargins = True
    Left = 3
    Top = 314
    Width = 399
    Height = 41
    Margins.Right = 6
    Align = alBottom
    BevelOuter = bvNone
    Padding.Top = 8
    Padding.Bottom = 8
    TabOrder = 1
    SkinData.SkinSection = 'CHECKBOX'
    object ButtonFind: TButton
      Left = 244
      Top = 8
      Width = 75
      Height = 25
      Align = alRight
      Caption = '&OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object ButtonCancel: TButton
      AlignWithMargins = True
      Left = 324
      Top = 8
      Width = 75
      Height = 25
      Margins.Left = 5
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alRight
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object VirtualDrawTree: TVirtualDrawTree
    AlignWithMargins = True
    Left = 4
    Top = 62
    Width = 400
    Height = 249
    Hint = 
      'Use drag and drop to move menu items. Right click popup menu to ' +
      'insert and delete items.'
    Margins.Left = 4
    Margins.Top = 0
    Margins.Right = 4
    Margins.Bottom = 0
    Align = alClient
    Ctl3D = True
    DragOperations = []
    EditDelay = 0
    Header.AutoSizeIndex = 0
    Header.DefaultHeight = 20
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'Tahoma'
    Header.Font.Style = []
    Header.Height = 20
    Header.Options = [hoAutoResize, hoShowSortGlyphs, hoVisible, hoAutoSpring]
    Images = ImagesDataModule.ImageListSmall
    Indent = 0
    ParentCtl3D = False
    SelectionBlendFactor = 255
    TabOrder = 2
    TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toDisableAutoscrollOnFocus, toAutoChangeScale]
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning]
    TreeOptions.PaintOptions = [toHideFocusRect, toShowButtons, toShowDropmark, toShowRoot, toThemeAware]
    TreeOptions.SelectionOptions = [toFullRowSelect, toMiddleClickSelect, toAlwaysSelectNode]
    WantTabs = True
    Columns = <
      item
        Options = [coEnabled, coParentBidiMode, coParentColor, coVisible, coAutoSpring]
        Position = 0
        Width = 142
        WideText = 'Date'
      end
      item
        Position = 1
        Width = 254
        WideText = 'Text'
      end>
  end
  object ActionList: TActionList
    Images = ImagesDataModule.ImageList
    Left = 190
    Top = 104
    object ActionCopyToClipboard: TAction
      Caption = 'Copy to clipboard'
      ImageIndex = 15
    end
    object ActionClearAll: TAction
      Caption = 'Clear all'
      ImageIndex = 65
    end
    object ActionDelete: TAction
      Caption = 'Delete'
      ImageIndex = 22
    end
    object ActionInsertInEditor: TAction
      Caption = 'Insert in editor'
      ImageIndex = 18
    end
  end
end
