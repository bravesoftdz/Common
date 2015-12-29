inherited ConfirmReplaceDialog: TConfirmReplaceDialog
  Left = 176
  Top = 158
  Caption = 'Confirm Replace'
  ClientHeight = 94
  ClientWidth = 333
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PanelBottom: TBCPanel
    Left = 0
    Top = 55
    Width = 333
    Height = 39
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    BevelOuter = bvNone
    Padding.Left = 8
    Padding.Top = 6
    Padding.Right = 6
    Padding.Bottom = 8
    TabOrder = 0
    SkinData.SkinSection = 'CHECKBOX'
    object ButtonCancel: TButton
      Left = 170
      Top = 6
      Width = 75
      Height = 25
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alLeft
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 0
    end
    object ButtonYesToAll: TButton
      Left = 251
      Top = 6
      Width = 75
      Height = 25
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alLeft
      Caption = 'Yes to &all'
      ModalResult = 14
      TabOrder = 1
    end
    object TBCPanel
      Left = 245
      Top = 6
      Width = 6
      Height = 25
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 2
      SkinData.SkinSection = 'CHECKBOX'
    end
    object ButtonYes: TButton
      Left = 8
      Top = 6
      Width = 75
      Height = 25
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alLeft
      Caption = '&Yes'
      Default = True
      ModalResult = 6
      TabOrder = 3
    end
    object TBCPanel
      Left = 83
      Top = 6
      Width = 6
      Height = 25
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 4
      SkinData.SkinSection = 'CHECKBOX'
    end
    object ButtonNo: TButton
      Left = 89
      Top = 6
      Width = 75
      Height = 25
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alLeft
      Caption = '&No'
      ModalResult = 7
      TabOrder = 5
    end
    object TBCPanel
      Left = 164
      Top = 6
      Width = 6
      Height = 25
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 6
      SkinData.SkinSection = 'CHECKBOX'
    end
  end
  object PanelClient: TBCPanel
    Left = 0
    Top = 0
    Width = 333
    Height = 55
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    SkinData.SkinSection = 'CHECKBOX'
    object Image: TImage
      Left = 9
      Top = 11
      Width = 39
      Height = 39
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
    end
    object LabelConfirmation: TLabel
      Left = 52
      Top = 11
      Width = 274
      Height = 39
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      AutoSize = False
      WordWrap = True
    end
  end
end
