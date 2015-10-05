inherited DownloadURLDialog: TDownloadURLDialog
  BorderStyle = bsToolWindow
  Caption = 'Download'
  ClientHeight = 116
  ClientWidth = 364
  Color = clActiveBorder
  Position = poMainFormCenter
  Visible = True
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PanelTop: TBCPanel
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
    StyleElements = []
    SkinData.SkinSection = 'CHECKBOX'
    object LabelInformation: TLabel
      Left = 11
      Top = 19
      Width = 342
      Height = 13
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = 'LabelInformation'
    end
    object ProgressBar: TBCProgressBar
      Left = 11
      Top = 46
      Width = 342
      Height = 17
      Align = alBottom
      SkinData.SkinSection = 'GAUGE'
      ForeColor = clBlack
      Suffix = '%'
    end
  end
  object PanelProgress: TBCPanel
    Left = 0
    Top = 74
    Width = 364
    Height = 42
    Align = alClient
    BevelOuter = bvNone
    Ctl3D = True
    ParentBackground = False
    ParentCtl3D = False
    TabOrder = 1
    SkinData.SkinSection = 'CHECKBOX'
    DesignSize = (
      364
      42)
    object ButtonCancel: TButton
      Left = 147
      Top = 7
      Width = 69
      Height = 25
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Action = ActionCancel
      Anchors = [akLeft, akRight]
      Cancel = True
      Default = True
      ModalResult = 2
      TabOrder = 0
    end
  end
  object ActionList: TActionList
    Left = 300
    Top = 20
    object ActionCancel: TAction
      Caption = 'Cancel'
      OnExecute = ActionCancelExecute
    end
    object ActionOK: TAction
      Caption = '&OK'
      OnExecute = ActionOKExecute
    end
  end
  object SaveDialog: TsSaveDialog
    Left = 30
    Top = 56
  end
end
