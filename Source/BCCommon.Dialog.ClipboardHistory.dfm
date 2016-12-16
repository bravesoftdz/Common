inherited ClipboardHistoryDialog: TClipboardHistoryDialog
  BorderStyle = bsSizeable
  Caption = 'Clipboard history'
  ClientHeight = 458
  ClientWidth = 471
  FormStyle = fsStayOnTop
  Icon.Data = {
    0000010001001010000001002000280400001600000028000000100000002000
    0000010020000000000000000000000000000000000000000000000000000000
    0000000000230000003300000033000000330000003300000033000000330000
    0033000000330000003300000033000000330000002300000000000000000000
    00003A6087C0406893FF3F6893FF406893FF406893FF406893FF406893FF4068
    93FF406893FF406893FF3F6893FF406893FF3A6087C000000000000000000000
    00003F6A94FF5588AEFF4C81ABFF4D81ABFF4D81ABFF4B7EA7FF4A7DA6FF4A7D
    A6FF4B7EA8FF4D81ABFF4C81ABFF5588AEFF3F6A94FF00000000000000000000
    00003F6A95FF6091B7FF4D83ADFF4E83ADFF416D90FF73797DFF777777FF7777
    77FF6D787FFF457499FF4D83ADFF6091B7FF3F6A95FF00000000000000000000
    0000406A96FF6C9BBFFF4C81ACFF60799EFFA49E9EFFC1BEBCFFBCB9B9FFBCB9
    B9FFC2BFBDFF959392FF4E7DA1FF6C9BBFFF406A96FF00000000000000000000
    00003F6C96FF74A0C0FF168061FF00924BFFC5C0C0FFCEC9CAFFFFFFFFFFFFFF
    FFFFBEBBBAFFC5C3C2FF7D8993FF78A4C6FF3F6C96FF00000000000000000000
    00003F6C96FF2B896FFF00CC8BFF00E29FFF018341FFD1E8DDFFE1E2E2FFFFFF
    FFFFFFFFFFFFA3A09EFFA6A3A1FF82ACCEFF3F6C96FF00000000000000000000
    00003F6E98FF24956DFF01A76BFF00CA8FFF2A8A54FFAADAC1FF7D797BFF7B7B
    7BFFAFAFAFFF93908EFFACAAA8FF8DB5D5FF3F6E98FF00000000000000000000
    0000406E99FF99BEDCFF057E46FF00BB84FF859A8AFFF2EDEFFFD0D0CFFFECED
    ECFFE6E5E4FFABA8A7FFB0AFAEFF99BEDCFF406E99FF00000000000000000000
    00003F7099FFA3C5E1FF3F8FA0FF00B885FF29A172FFCCB6B8FFBCB1B1FFC0BA
    BAFFB9B5B5FFD7D5D4FF7D9EBAFFA3C5E1FF3F7099FF00000000000000000000
    00003F709BFFADCDE7FF5996C8FF228E76FF01A479FF12B491FF9FD9CDFFCDE4
    D9FFDBD7D8FF9EACB6FF5996C8FFADCDE7FF3F709BFF00000000000000000000
    000040709CFFB7D4ECFF5B99CCFF5F9BCDFF4F98B5FF4795A8FF4792A4FF4C96
    AFFF71A0C8FF5F9BCDFF5B99CCFFB7D4ECFF40709CFF00000000000000000000
    00003F739DFFC2DDF4FF599CD3FF5B9DD4FF5A9DD4FF589AD1FF5699D0FF589A
    D1FF5A9DD4FF5B9DD4FF599CD3FFC2DDF4FF3F739DFF00000000000000000000
    000043769FFFA1CBEFFF9CAAB6FFA69E98FFA29C96FFF2ECE7FFF1EAE5FFF2EC
    E7FFA29C96FFA69E98FF9CAAB6FFA1CBEFFF43769FFF00000000000000000000
    0000467AA4B03D75A3FFA7A19CFFEEEBE9FFE0DDDBFFECECEBFFECEAEAFFECEB
    EBFFE1DFDDFFF2EFECFFA7A19BFF3D75A2FF467AA4B000000000000000000000
    0000000000000000000000000000000000008C8C8CA88F8F8FFF8F8F8FFF8F8F
    8FFF8C8C8CA8000000000000000000000000000000000000000000000000}
  OnClose = FormClose
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PanelTop: TBCPanel [0]
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
  object VirtualDrawTree: TVirtualDrawTree [1]
    Left = 0
    Top = 62
    Width = 471
    Height = 377
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
  object StatusBar: TBCStatusBar [2]
    Left = 0
    Top = 439
    Width = 471
    Height = 19
    Panels = <
      item
        Width = 150
      end>
    SkinData.SkinSection = 'STATUSBAR'
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
end
