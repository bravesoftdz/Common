object ConfirmReplaceDialog: TConfirmReplaceDialog
  Left = 176
  Top = 158
  BorderStyle = bsDialog
  Caption = 'Confirm Replace'
  ClientHeight = 94
  ClientWidth = 333
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object BottomPanel: TPanel
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
    object CancelButton: TButton
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
    object YesToAllButton: TButton
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
    object TPanel
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
    end
    object YesButton: TButton
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
    object TPanel
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
    end
    object NoButton: TButton
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
    object TPanel
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
    end
  end
  object ClientPanel: TPanel
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
    object ConfirmationLabel: TLabel
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
