object DownloadURLDialog: TDownloadURLDialog
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Download'
  ClientHeight = 116
  ClientWidth = 364
  Color = clActiveBorder
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object TopPanel: TPanel
    Left = 0
    Top = 0
    Width = 364
    Height = 74
    Align = alTop
    BevelEdges = []
    BevelOuter = bvNone
    BorderWidth = 1
    Color = clWhite
    Ctl3D = True
    Padding.Left = 10
    Padding.Top = 18
    Padding.Right = 10
    Padding.Bottom = 10
    ParentBackground = False
    ParentCtl3D = False
    TabOrder = 0
    object InformationLabel: TLabel
      Left = 11
      Top = 19
      Width = 342
      Height = 13
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = 'InformationLabel'
      ExplicitLeft = -4
      ExplicitTop = 18
      ExplicitWidth = 372
    end
    object ProgressBar: TJvProgressBar
      Left = 11
      Top = 46
      Width = 342
      Height = 17
      Align = alBottom
      DoubleBuffered = False
      ParentDoubleBuffered = False
      TabOrder = 0
    end
  end
  object ProgressPanel: TPanel
    Left = 0
    Top = 75
    Width = 364
    Height = 41
    Align = alClient
    BevelOuter = bvNone
    Ctl3D = True
    ParentBackground = False
    ParentCtl3D = False
    TabOrder = 1
    DesignSize = (
      364
      41)
    object Button: TButton
      Left = 147
      Top = 7
      Width = 69
      Height = 25
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Action = CancelAction
      Anchors = [akLeft, akRight]
      Cancel = True
      Default = True
      ModalResult = 2
      TabOrder = 0
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 74
    Width = 364
    Height = 1
    Align = alTop
    TabOrder = 2
  end
  object ActionList: TActionList
    Left = 300
    Top = 20
    object CancelAction: TAction
      Caption = 'Cancel'
      OnExecute = CancelActionExecute
    end
    object OKAction: TAction
      Caption = '&OK'
      OnExecute = OKActionExecute
    end
  end
end
