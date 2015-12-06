object PopupFilesForm: TPopupFilesForm
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsNone
  BorderWidth = 1
  ClientHeight = 277
  ClientWidth = 334
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PopupMode = pmExplicit
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object VirtualDrawTreeSearch: TVirtualDrawTree
    AlignWithMargins = True
    Left = 3
    Top = 27
    Width = 328
    Height = 247
    Margins.Top = 0
    Align = alClient
    Header.AutoSizeIndex = 0
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'Tahoma'
    Header.Font.Style = []
    Header.MainColumn = -1
    Indent = 0
    TabOrder = 0
    TreeOptions.MiscOptions = [toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning]
    TreeOptions.PaintOptions = [toHideFocusRect, toShowRoot, toThemeAware]
    TreeOptions.SelectionOptions = [toFullRowSelect]
    OnCompareNodes = VirtualDrawTreeSearchCompareNodes
    OnDblClick = VirtualDrawTreeSearchDblClick
    OnDrawNode = VirtualDrawTreeSearchDrawNode
    OnFreeNode = VirtualDrawTreeSearchFreeNode
    OnGetImageIndex = VirtualDrawTreeSearchGetImageIndex
    OnGetNodeWidth = VirtualDrawTreeSearchGetNodeWidth
    Columns = <>
  end
  object ButtonedEdit: TBCButtonedEdit
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 328
    Height = 21
    Align = alTop
    DoubleBuffered = True
    LeftButton.Enabled = False
    ParentDoubleBuffered = False
    RightButton.HotImageIndex = 1
    RightButton.ImageIndex = 0
    RightButton.PressedImageIndex = 2
    TabOrder = 1
    OnChange = ActionSearchExecute
    OnRightButtonClick = ActionClearExecute
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
end
