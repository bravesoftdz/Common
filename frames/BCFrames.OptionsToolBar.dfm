inherited OptionsToolBarFrame: TOptionsToolBarFrame
  Width = 451
  Height = 305
  Align = alClient
  ExplicitWidth = 451
  ExplicitHeight = 305
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 451
    Height = 305
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object VirtualDrawTree: TVirtualDrawTree
      AlignWithMargins = True
      Left = 4
      Top = 0
      Width = 447
      Height = 305
      Hint = 
        'Use drag and drop to move menu items. Right click popup menu to ' +
        'insert and delete items.'
      Margins.Left = 4
      Margins.Top = 0
      Margins.Right = 0
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
      Images = ImagesDataModule.ImageList
      Indent = 0
      ParentCtl3D = False
      PopupMenu = PopupMenu
      SelectionBlendFactor = 255
      TabOrder = 0
      TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand]
      TreeOptions.PaintOptions = [toHideFocusRect, toShowButtons, toShowDropmark, toShowRoot, toThemeAware, toUseBlendedSelection]
      TreeOptions.SelectionOptions = [toFullRowSelect, toMiddleClickSelect]
      WantTabs = True
      OnDragAllowed = VirtualDrawTreeDragAllowed
      OnDragOver = VirtualDrawTreeDragOver
      OnDragDrop = VirtualDrawTreeDragDrop
      OnDrawNode = VirtualDrawTreeDrawNode
      OnFreeNode = VirtualDrawTreeFreeNode
      OnGetImageIndex = VirtualDrawTreeGetImageIndex
      OnGetNodeWidth = VirtualDrawTreeGetNodeWidth
      Columns = <
        item
          Options = [coEnabled, coParentBidiMode, coParentColor, coVisible, coAutoSpring]
          Position = 0
          Width = 443
          WideText = 'Menu Item'
        end>
    end
  end
  object MenuActionList: TActionList
    Images = ImagesDataModule.ImageList
    Left = 245
    Top = 173
    object AddItemAction: TAction
      Caption = 'Add Item'
      Hint = 'Add item'
      ImageIndex = 147
      OnExecute = AddItemActionExecute
    end
    object DeleteAction: TAction
      Caption = 'Delete'
      Hint = 'Delete'
      ImageIndex = 132
      OnExecute = DeleteActionExecute
    end
    object AddDividerAction: TAction
      Caption = 'Add Divider'
      Hint = 'Add divider'
      ImageIndex = 64
      OnExecute = AddDividerActionExecute
    end
    object ResetAction: TAction
      Caption = 'Reset'
      Hint = 'Reset menu items'
      ImageIndex = 164
      OnExecute = ResetActionExecute
    end
  end
  object PopupMenu: TPopupMenu
    Images = ImagesDataModule.ImageList
    Left = 280
    Top = 86
    object Additem1: TMenuItem
      Action = AddItemAction
    end
    object AddDivider1: TMenuItem
      Action = AddDividerAction
    end
    object DeleteItem1: TMenuItem
      Action = DeleteAction
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Reset1: TMenuItem
      Action = ResetAction
    end
  end
end
