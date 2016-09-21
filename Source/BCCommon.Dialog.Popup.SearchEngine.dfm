object BCPopupSearchEngineDialog: TBCPopupSearchEngineDialog
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'BCPopupSearchEngineDialog'
  ClientHeight = 135
  ClientWidth = 186
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object VirtualDrawTree: TVirtualDrawTree
    Left = 0
    Top = 0
    Width = 186
    Height = 135
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
    OnDblClick = VirtualDrawTreeDblClick
    OnDrawNode = VirtualDrawTreeDrawNode
    OnFreeNode = VirtualDrawTreeFreeNode
    OnGetNodeWidth = VirtualDrawTreeGetNodeWidth
    Columns = <>
  end
  object SkinProvider: TsSkinProvider
    AllowExtBorders = False
    AllowBlendOnMoving = False
    SkinData.SkinSection = 'FORM'
    TitleButtons = <>
    Left = 24
    Top = 24
  end
end
