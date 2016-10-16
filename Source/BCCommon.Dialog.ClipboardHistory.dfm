inherited ClipboardHistoryDialog: TClipboardHistoryDialog
  BorderStyle = bsSizeToolWin
  Caption = 'Clipboard history'
  ClientHeight = 458
  ClientWidth = 471
  OnClose = FormClose
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PanelTop: TBCPanel
    Left = 0
    Top = 0
    Width = 471
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
    object SpeedButtonCopyToClipboard: TBCSpeedButton
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
    object SpeedButtonClearAll: TBCSpeedButton
      Left = 152
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
    object SpeedButtonInsertInEditor: TBCSpeedButton
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
      ImageIndex = 16
    end
  end
  object VirtualDrawTree: TVirtualDrawTree
    AlignWithMargins = True
    Left = 4
    Top = 62
    Width = 463
    Height = 392
    Margins.Left = 4
    Margins.Top = 0
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alClient
    Ctl3D = True
    DragOperations = []
    EditDelay = 0
    Header.AutoSizeIndex = -1
    Header.DefaultHeight = 20
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'Tahoma'
    Header.Font.Style = []
    Header.Height = 20
    Header.MainColumn = -1
    Header.Options = [hoAutoResize, hoShowSortGlyphs, hoAutoSpring]
    Indent = 0
    ParentCtl3D = False
    SelectionBlendFactor = 255
    TabOrder = 1
    TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toDisableAutoscrollOnFocus, toAutoChangeScale]
    TreeOptions.MiscOptions = [toFullRepaintOnResize, toInitOnSave, toWheelPanning]
    TreeOptions.PaintOptions = [toHideFocusRect, toShowRoot, toThemeAware]
    TreeOptions.SelectionOptions = [toFullRowSelect, toMiddleClickSelect, toAlwaysSelectNode]
    WantTabs = True
    OnDrawNode = VirtualDrawTreeDrawNode
    OnFreeNode = VirtualDrawTreeFreeNode
    OnGetNodeWidth = VirtualDrawTreeGetNodeWidth
    Columns = <>
  end
  object ActionList: TActionList
    Images = ImagesDataModule.ImageList
    Left = 370
    Top = 14
    object ActionCopyToClipboard: TAction
      Caption = 'Copy to clipboard'
      ImageIndex = 15
      OnExecute = ActionCopyToClipboardExecute
    end
    object ActionInsertInEditor: TAction
      Caption = 'Insert in editor'
      ImageIndex = 16
      OnExecute = ActionInsertInEditorExecute
    end
    object ActionClearAll: TAction
      Caption = 'Clear all'
      ImageIndex = 65
      OnExecute = ActionClearAllExecute
    end
  end
  object SkinProvider: TsSkinProvider
    SkinData.SkinSection = 'FORM'
    SkinData.OuterEffects.Visibility = ovAlways
    TitleButtons = <>
    Left = 30
    Top = 80
  end
end
