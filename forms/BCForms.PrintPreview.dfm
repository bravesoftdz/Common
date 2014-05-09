object PrintPreviewDialog: TPrintPreviewDialog
  Left = 192
  Top = 148
  Caption = 'Print Preview'
  ClientHeight = 523
  ClientWidth = 726
  Color = clWindow
  ParentFont = True
  Icon.Data = {
    0000010001001010000001002000280400001600000028000000100000002000
    0000010020000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000BABA
    B9FFAFAFADFFAEAEABFFADADABFFADADABFFADADABFFAEAEABFFAEAEACFFAFAF
    ADFFAFAFADFFB0B0AEFFB6B3AFFFC7C1BBFF31699EFF396D9EFF00000000B0B0
    ADFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
    FFFFFFFFFFFFFFFFFFFFFFFFFFFF23629EFF25B0FFFF44C8FFFF3A83CCFFAEAE
    ABFFFFFFFFFFFDFDFDFFFCFCFDFFFDFDFDFFFEFEFEFFFFFFFFFFD3D3D4FF6E6F
    71FF58585CFF5A5A5DFF636060FF7D7068FF3AC6FFFF57DBFFFF3981C9FFADAD
    ABFFFFFFFFFFFAF8F8FFF9F8F8FFFAF9F9FFFFFDFEFFD1D1D2FF676463FFE3C3
    8CFFFFEBA4FFFFF3AFFFE7D3A1FF76706BFFA09085FF3280CFFF00000000ADAD
    ABFFFFFFFFFFF6F6F6FFF6F6F6FFF8F8F8FFFEFFFFFF777879FFE3BE84FFFFE6
    A5FFFFE7A6FFFFEFB3FFFFF9BBFFE9D6A2FF807875FF0000000000000000ADAD
    ABFFFFFFFFFFF4F4F3FFF4F4F3FFF6F6F5FFFDFEFEFF696A6DFFFFE09DFFFFEF
    CAFFFFE7B3FFFFE9ABFFFFEFB2FFFFF4AFFF787677FF0000000000000000ADAD
    ABFFFFFFFFFFF2F1F0FFF2F1F0FFF4F3F2FFFBFAFBFF6F6F72FFFFDD97FFFFF7
    E4FFFFEDC8FFFFE7B2FFFFE6A5FFFFECA5FF7C7B7EFF0000000000000000ADAD
    ABFFFFFFFFFFEFEFEEFFEFEFEEFFF0F1F0FFF6F7F7FF848587FFE7BB7CFFFFF5
    DBFFFFF7E4FFFFEECAFFFFE5A4FFEBCC95FF868587FF0000000000000000ADAD
    ABFFFFFFFFFFECEBEAFFEDECEBFFEEECEBFFF1F0F0FFCFCFD0FF83807DFFE8BC
    7DFFFFDC97FFFFDF9CFFEAC58BFF8C8887FF000000000000000000000000ADAD
    ABFFFFFFFFFFE9E9E8FFEAEAE9FFEAEAE9FFEBECEBFFEFEFEFFFD8D7D8FF9494
    96FF858588FF848487FF979698FFA9AAAAFF000000000000000000000000ADAE
    ABFFFFFFFFFFE7E5E4FFE8E7E6FFE8E7E6FFE8E7E6FFE8E7E6FFFFFFFFFFD3D3
    D3FFAFB0AFFFAEAFADFFFFFFFFFFB3B3B1FF000000000000000000000000AEAE
    ABFFFFFFFFFFE3E3E2FFE4E4E3FFE4E5E4FFE4E4E3FFE3E3E2FFFFFFFFFFA8A8
    A6FFEDEDECFFFFFFFFFFEAEAEAFFCACAC9FF000000000000000000000000AEAE
    ACFFFFFFFFFFE0DFDEFFE1DFDEFFE1E0DFFFE1DFDEFFE0DFDEFFFFFFFFFFA5A5
    A3FFFFFFFFFFE8E8E8FFCBCBC9FF00000000000000000000000000000000AFAF
    ADFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
    FFFFE9E9E9FFCACAC9FF0000000000000000000000000000000000000000B8B8
    B6FFB0B0ADFFAEAEACFFAEAEABFFAEAEABFFAEAEABFFADAEABFFAEAEABFFAFAF
    ADFFB7B7B5FF000000000000000000000000000000000000000000000000}
  OldCreateOrder = True
  Position = poMainFormCenter
  Scaled = False
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 504
    Width = 726
    Height = 19
    Panels = <
      item
        Width = 400
      end
      item
        Width = 100
      end>
    ParentShowHint = False
    ShowHint = True
  end
  object SynEditPrintPreview: TSynEditPrintPreview
    Left = 0
    Top = 27
    Width = 726
    Height = 477
    BorderStyle = bsNone
    Color = clWindow
    ScaleMode = pscWholePage
    OnMouseDown = SynEditPrintPreviewMouseDown
    OnPreviewPage = SynEditPrintPreviewPreviewPage
  end
  object ButtonPanel: TPanel
    Left = 0
    Top = 0
    Width = 726
    Height = 27
    Align = alTop
    AutoSize = True
    BevelOuter = bvNone
    Padding.Left = 2
    Padding.Top = 2
    Padding.Right = 2
    Padding.Bottom = 2
    ParentColor = True
    TabOrder = 1
    object Bevel7: TBevel
      AlignWithMargins = True
      Left = 156
      Top = 4
      Width = 4
      Height = 19
      Margins.Left = 6
      Margins.Top = 2
      Margins.Bottom = 2
      Align = alLeft
      Shape = bsLeftLine
    end
    object Bevel1: TBevel
      AlignWithMargins = True
      Left = 217
      Top = 4
      Width = 4
      Height = 19
      Margins.Left = 6
      Margins.Top = 2
      Margins.Bottom = 2
      Align = alLeft
      Shape = bsLeftLine
    end
    object Bevel2: TBevel
      AlignWithMargins = True
      Left = 104
      Top = 4
      Width = 4
      Height = 19
      Margins.Left = 6
      Margins.Top = 2
      Margins.Bottom = 2
      Align = alLeft
      Shape = bsLeftLine
    end
    object ToolBar: TBCToolBar
      Left = 2
      Top = 2
      Width = 96
      Height = 23
      Align = alLeft
      ButtonHeight = 23
      ButtonWidth = 24
      Caption = 'ToolBar'
      EdgeInner = esNone
      EdgeOuter = esNone
      Images = ImagesDataModule.ImageList
      TabOrder = 0
      object FirstToolButton: TToolButton
        Left = 0
        Top = 0
        Action = FirstAction
        ParentShowHint = False
        ShowHint = True
      end
      object PrevioustToolButton: TToolButton
        Left = 24
        Top = 0
        Action = PrevAction
        ParentShowHint = False
        ShowHint = True
      end
      object NextToolButton: TToolButton
        Left = 48
        Top = 0
        Action = NextAction
        ParentShowHint = False
        ShowHint = True
      end
      object LasttToolButton: TToolButton
        Left = 72
        Top = 0
        Action = LastAction
        ParentShowHint = False
        ShowHint = True
      end
    end
    object ZoomToolBar: TBCToolBar
      Left = 111
      Top = 2
      Width = 39
      Height = 23
      Align = alLeft
      AutoSize = True
      ButtonHeight = 23
      ButtonWidth = 24
      Caption = 'ZoomToolBar'
      Images = ImagesDataModule.ImageList
      TabOrder = 1
      object ZoomToolButton: TToolButton
        Left = 0
        Top = 0
        Action = ZoomAction
        DropdownMenu = PopupMenu
        Style = tbsDropDown
      end
    end
    object ModeToolBar: TBCToolBar
      Left = 163
      Top = 2
      Width = 48
      Height = 23
      Align = alLeft
      ButtonHeight = 23
      ButtonWidth = 24
      Images = ImagesDataModule.ImageList
      TabOrder = 2
      object LineNumbersToolButton: TToolButton
        Left = 0
        Top = 0
        Action = LineNumbersAction
        Style = tbsCheck
      end
      object WordWrapToolButton: TToolButton
        Left = 24
        Top = 0
        Action = WordWrapAction
        Style = tbsCheck
      end
    end
    object PrintToolBar: TBCToolBar
      Left = 224
      Top = 2
      Width = 48
      Height = 23
      Align = alLeft
      ButtonHeight = 23
      ButtonWidth = 24
      Images = ImagesDataModule.ImageList
      TabOrder = 3
      object PrintSetupToolButton: TToolButton
        Left = 0
        Top = 0
        Action = PrintSetupAction
      end
      object PrintToolButton: TToolButton
        Left = 24
        Top = 0
        Action = PrintAction
      end
    end
  end
  object ActionList: TActionList
    Images = ImagesDataModule.ImageList
    Left = 344
    Top = 131
    object FirstAction: TAction
      Caption = 'FirstCmd'
      Hint = 'First|Go to first page'
      ImageIndex = 183
      ShortCut = 32838
      OnExecute = FirstActionExecute
    end
    object PrevAction: TAction
      Caption = 'PrevCmd'
      Hint = 'Previous|Go to previous page'
      ImageIndex = 149
      ShortCut = 32848
      OnExecute = PrevActionExecute
    end
    object NextAction: TAction
      Caption = 'NextCmd'
      Hint = 'Next|Go to next page'
      ImageIndex = 133
      ShortCut = 32846
      OnExecute = NextActionExecute
    end
    object LastAction: TAction
      Caption = 'LastCmd'
      Hint = 'Last|Go to last page'
      ImageIndex = 75
      ShortCut = 32844
      OnExecute = LastActionExecute
    end
    object ZoomAction: TAction
      Caption = 'FitCmd'
      Hint = 'Zoom|Zoom In/Out'
      ImageIndex = 238
      ShortCut = 32858
      OnExecute = ZoomActionExecute
    end
    object PrintSetupAction: TAction
      Caption = 'PrintSetupAction'
      Hint = 'Print Setup|Setup printer'
      ImageIndex = 151
      ShortCut = 16467
      OnExecute = PrintSetupActionExecute
    end
    object PrintAction: TAction
      Caption = 'PrintCmd'
      Hint = 'Print|Print the document'
      ImageIndex = 150
      ShortCut = 16464
      OnExecute = PrintActionExecute
    end
    object LineNumbersAction: TAction
      Hint = 'Toggle line numbers'
      ImageIndex = 119
      OnExecute = LineNumbersActionExecute
    end
    object WordWrapAction: TAction
      Caption = 'WordWrapAction'
      ImageIndex = 237
      OnExecute = WordWrapActionExecute
    end
  end
  object PopupMenu: TBCPopupMenu
    Images = ImagesDataModule.ImageList
    Left = 180
    Top = 65
    object Percent25MenuItem: TMenuItem
      Tag = 25
      Caption = '25%'
      OnClick = PercentClick
    end
    object Percent50MenuItem: TMenuItem
      Tag = 50
      Caption = '50%'
      OnClick = PercentClick
    end
    object Percent100MenuItem: TMenuItem
      Tag = 100
      Caption = '100%'
      OnClick = PercentClick
    end
    object Percent200MenuItem: TMenuItem
      Tag = 200
      Caption = '200%'
      OnClick = PercentClick
    end
    object Percent400MenuItem: TMenuItem
      Tag = 400
      Caption = '400%'
      OnClick = PercentClick
    end
  end
  object ApplicationEvents: TApplicationEvents
    OnHint = ApplicationEventsHint
    Left = 345
    Top = 65
  end
end
