object BCBaseForm: TBCBaseForm
  Left = 0
  Top = 0
  Caption = 'BCBaseForm'
  ClientHeight = 280
  ClientWidth = 635
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TBCStatusBar
    Left = 0
    Top = 261
    Width = 635
    Height = 19
    Panels = <>
    SkinData.SkinSection = 'STATUSBAR'
  end
  object SkinManager: TBCSkinManager
    AnimEffects.DialogShow.Active = False
    AnimEffects.FormShow.Active = False
    AnimEffects.FormHide.Active = False
    AnimEffects.DialogHide.Active = False
    AnimEffects.Minimizing.Active = False
    AnimEffects.SkinChanging.Active = False
    ButtonsOptions.ShowFocusRect = False
    Active = False
    Saturation = 10
    InternalSkins = <>
    MenuSupport.IcoLineSkin = 'ICOLINE'
    MenuSupport.UseExtraLine = True
    MenuSupport.ExtraLineFont.Charset = DEFAULT_CHARSET
    MenuSupport.ExtraLineFont.Color = clWindowText
    MenuSupport.ExtraLineFont.Height = -13
    MenuSupport.ExtraLineFont.Name = 'Tahoma'
    MenuSupport.ExtraLineFont.Style = [fsBold]
    SkinDirectory = 'Skins'
    SkinName = 'MetroUI'
    SkinInfo = 'N/A'
    ThirdParty.ThirdEdits = 'TBCEditor'#13#10'TBCEditorPrintPreview'
    ThirdParty.ThirdButtons = 'TButton'
    ThirdParty.ThirdBitBtns = ' '
    ThirdParty.ThirdCheckBoxes = ' '
    ThirdParty.ThirdGroupBoxes = ' '
    ThirdParty.ThirdListViews = ' '
    ThirdParty.ThirdPanels = ' '
    ThirdParty.ThirdGrids = ' '
    ThirdParty.ThirdTreeViews = ' '
    ThirdParty.ThirdComboBoxes = ' '
    ThirdParty.ThirdWWEdits = ' '
    ThirdParty.ThirdVirtualTrees = ' '
    ThirdParty.ThirdGridEh = ' '
    ThirdParty.ThirdPageControl = ' '
    ThirdParty.ThirdTabControl = ' '
    ThirdParty.ThirdToolBar = ' '
    ThirdParty.ThirdStatusBar = ' '
    ThirdParty.ThirdSpeedButton = ' '
    ThirdParty.ThirdScrollControl = ' '
    ThirdParty.ThirdUpDown = ' '
    ThirdParty.ThirdScrollBar = ' '
    ThirdParty.ThirdStaticText = ' '
    ThirdParty.ThirdNativePaint = ' '
    Left = 38
    Top = 20
  end
  object TitleBar: TBCTitleBar
    Items = <>
    ShowCaption = False
    Left = 40
    Top = 76
  end
  object SkinProvider: TBCSkinProvider
    AddedTitle.Font.Charset = DEFAULT_CHARSET
    AddedTitle.Font.Color = clNone
    AddedTitle.Font.Height = -11
    AddedTitle.Font.Name = 'Tahoma'
    AddedTitle.Font.Style = []
    FormHeader.AdditionalHeight = 0
    SkinData.SkinSection = 'FORM'
    TitleBar = TitleBar
    TitleButtons = <>
    Left = 38
    Top = 136
  end
  object ApplicationEvents: TApplicationEvents
    Left = 128
    Top = 86
  end
  object ActionList: TActionList
    Left = 126
    Top = 142
    object ActionFileExit: TAction
      Caption = 'Exit'
      Hint = 'Quit the application'
      ImageIndex = 11
      ShortCut = 32883
      OnExecute = ActionFileExitExecute
    end
  end
  object MainMenu: TMainMenu
    Left = 39
    Top = 190
  end
end
