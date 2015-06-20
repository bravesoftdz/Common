object SearchForFilesForm: TSearchForFilesForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Search for Files'
  ClientHeight = 401
  ClientWidth = 383
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Icon.Data = {
    0000010001001010000001002000280400001600000028000000100000002000
    0000010020000000000000000000000000000000000000000000000000000000
    0000AEAEABFFAEAEABFFAEAEABFFAEAEABFFAEAEABFFAEAEABFFAEAEABFFAEAE
    ABFFAEAEABFFAEAEABFFAEAEABFFAEAEABFFAEAEABFF00000000000000000000
    0000AEAEABFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAEAEABFF00000000000000000000
    0000AEAEABFFFFFFFFFFFDFDFDFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFC
    FCFFFCFCFCFFFCFCFCFFFDFDFDFFFFFFFFFFAEAEABFF00000000000000000000
    0000AEAEABFFFFFFFFFFFAF9F9FFF9F8F8FFF9F8F8FFF9F8F8FFF9F8F8FFF9F8
    F8FFF9F8F8FFF9F8F8FFFAF9F9FFFFFFFFFFAEAEABFF00000000000000000000
    0000AEAEABFFFFFFFFFFF6F6F6FFF6F6F6FFF6F6F6FFF6F6F6FFF6F6F6FFF6F6
    F6FFF6F6F6FFF6F6F6FFF6F6F6FFFFFFFFFFAEAEABFF00000000000000000000
    0000AEAEABFFFFFFFFFFF4F4F3FFF4F4F3FFF4F4F3FFF4F4F3FFF4F4F3FFF4F4
    F3FFF4F4F3FFF4F4F3FFF4F4F3FFFFFFFFFFAEAEABFF00000000000000000000
    0000AEAEABFFFFFFFFFFF2F1F0FFF2F1F0FFF2F1F0FFF2F1F0FFF2F1F0FFF2F1
    F0FFF2F1F0FFF2F1F0FFF2F1F0FFFFFFFFFFAEAEABFF00000000000000000000
    0000AEAEABFFFFFFFFFFEFEFEEFFEFEFEEFFEFEFEEFFEFEFEEFFEFEFEEFFEFEF
    EEFFEFEFEEFFEEEEEDFFEEEFEEFFFFFFFFFFAEAEABFF00000000000000000000
    0000AEAEABFFFFFFFFFFEDEBEAFFEDECEBFFEDECEBFFEDECEBFFEDECEBFFECEB
    EAFFECEBE9FFEBEAE9FFECEAE9FFFFFFFFFFAEAEABFF00000000000000000000
    0000AEAEABFFFFFFFFFFE9E9E8FFEAEAE9FFEAEAE9FFEAEAE9FFE9E9E8FFF4F4
    F2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAEAEABFF00000000000000000000
    0000AEAEABFFFFFFFFFFE7E6E5FFE8E7E6FFE8E7E6FFE8E7E6FFE6E5E4FFFFFF
    FFFFCBCCCBFFA5A5A3FFA5A5A3FFFFFFFFFFAEAEABFF00000000000000000000
    0000AEAEABFFFFFFFFFFE3E3E2FFE4E4E3FFE4E5E4FFE4E4E3FFE3E3E2FFFFFF
    FFFFA5A5A3FFEBEBEAFFFFFFFFFFEAEAEAFFAEAEABFF00000000000000000000
    0000AEAEABFFFFFFFFFFE0DFDDFFE0DFDEFFE0DFDEFFE0DFDEFFDFDEDCFFFFFF
    FFFFA5A5A3FFFFFFFFFFE9E9E9FFAEAEABFF0000000000000000000000000000
    0000AEAEABFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
    FFFFFFFFFFFFEAEAEAFFAEAEABFF000000000000000000000000000000000000
    0000B3B3B1FFAEAEABFFAEAEABFFAEAEABFFAEAEABFFAEAEABFFAEAEABFFAEAE
    ABFFAEAEABFFAEAEABFF00000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000}
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelSearchingFiles: TBCPanel
    Left = 0
    Top = 29
    Width = 383
    Height = 353
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Searching files...'
    ParentColor = True
    TabOrder = 2
    Visible = False
    SkinData.SkinSection = 'CHECKBOX'
  end
  object EditSearchFor: TBCButtonedEdit
    AlignWithMargins = True
    Left = 0
    Top = 6
    Width = 383
    Height = 21
    Margins.Left = 0
    Margins.Top = 6
    Margins.Right = 0
    Margins.Bottom = 2
    Align = alTop
    DoubleBuffered = True
    LeftButton.Enabled = False
    ParentDoubleBuffered = False
    RightButton.HotImageIndex = 1
    RightButton.ImageIndex = 0
    RightButton.PressedImageIndex = 2
    TabOrder = 0
    OnChange = ActionSearchExecute
    OnRightButtonClick = ActionClearExecute
  end
  object VirtualDrawTreeSearch: TVirtualDrawTree
    AlignWithMargins = True
    Left = 0
    Top = 32
    Width = 383
    Height = 345
    Margins.Left = 0
    Margins.Right = 0
    Margins.Bottom = 5
    Align = alClient
    Header.AutoSizeIndex = 0
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'Tahoma'
    Header.Font.Style = []
    Header.MainColumn = -1
    Indent = 0
    TabOrder = 1
    TreeOptions.MiscOptions = [toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning]
    TreeOptions.PaintOptions = [toShowRoot, toThemeAware]
    OnCompareNodes = VirtualDrawTreeSearchCompareNodes
    OnDblClick = VirtualDrawTreeSearchDblClick
    OnDrawNode = VirtualDrawTreeSearchDrawNode
    OnFreeNode = VirtualDrawTreeSearchFreeNode
    OnGetImageIndex = VirtualDrawTreeSearchGetImageIndex
    OnGetNodeWidth = VirtualDrawTreeSearchGetNodeWidth
    Columns = <>
  end
  object StatusBar: TBCStatusBar
    Left = 0
    Top = 382
    Width = 383
    Height = 19
    Panels = <
      item
        Width = 300
      end>
    SkinData.SkinSection = 'STATUSBAR'
  end
  object ActionList: TActionList
    Left = 196
    Top = 104
    object ActionClear: TAction
      Caption = 'ActionClear'
      OnExecute = ActionClearExecute
    end
    object ActionSearch: TAction
      Caption = 'ActionSearch'
      OnExecute = ActionSearchExecute
    end
  end
  object Taskbar: TTaskbar
    TaskBarButtons = <>
    ProgressMaxValue = 100
    TabProperties = []
    Left = 203
    Top = 191
  end
  object SkinProvider: TsSkinProvider
    AddedTitle.Font.Charset = DEFAULT_CHARSET
    AddedTitle.Font.Color = clNone
    AddedTitle.Font.Height = -11
    AddedTitle.Font.Name = 'Tahoma'
    AddedTitle.Font.Style = []
    FormHeader.AdditionalHeight = 0
    SkinData.SkinSection = 'FORM'
    TitleButtons = <>
    Left = 44
    Top = 84
  end
end
