inherited FindInFilesDialog: TFindInFilesDialog
  Caption = 'Find in Files'
  ClientHeight = 296
  ClientWidth = 499
  Padding.Left = 6
  Padding.Top = 6
  Padding.Right = 6
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PanelButtons: TBCPanel
    AlignWithMargins = True
    Left = 9
    Top = 252
    Width = 484
    Height = 41
    Margins.Right = 0
    Align = alBottom
    BevelOuter = bvNone
    Padding.Top = 8
    Padding.Bottom = 8
    TabOrder = 0
    SkinData.SkinSection = 'CHECKBOX'
    object ButtonFind: TButton
      Left = 329
      Top = 8
      Width = 75
      Height = 25
      Action = ActionFind
      Align = alRight
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object ButtonCancel: TButton
      AlignWithMargins = True
      Left = 409
      Top = 8
      Width = 75
      Height = 25
      Margins.Left = 5
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alRight
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object GroupBoxSearchOptions: TBCGroupBox
    Left = 6
    Top = 54
    Width = 487
    Height = 50
    Align = alTop
    Caption = ' Options'
    TabOrder = 1
    SkinData.SkinSection = 'GROUPBOX'
    object StickyLabelCaseSensitive: TsStickyLabel
      Left = 12
      Top = 23
      Width = 69
      Height = 13
      Caption = 'Case sensitive'
      AttachTo = SliderCaseSensitive
      Gap = 8
    end
    object SliderCaseSensitive: TsSlider
      Left = 89
      Top = 19
      Width = 50
      AutoSize = True
      TabOrder = 0
      ImageIndexOff = 0
      ImageIndexOn = 0
      FontOn.Charset = DEFAULT_CHARSET
      FontOn.Color = clWindowText
      FontOn.Height = -11
      FontOn.Name = 'Tahoma'
      FontOn.Style = []
      SliderCaptionOn = 'Yes'
      SliderCaptionOff = 'No'
      SliderOn = False
    end
  end
  object GroupBoxSearchDirectoryOptions: TBCGroupBox
    AlignWithMargins = True
    Left = 6
    Top = 107
    Width = 487
    Height = 142
    Margins.Left = 0
    Margins.Right = 0
    Align = alTop
    Caption = ' Search directory options '
    TabOrder = 2
    SkinData.SkinSection = 'GROUPBOX'
    object PanelDirectoryComboBoxAndButton: TBCPanel
      AlignWithMargins = True
      Left = 12
      Top = 62
      Width = 463
      Height = 40
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 2
      Align = alTop
      AutoSize = True
      BevelOuter = bvNone
      TabOrder = 1
      SkinData.SkinSection = 'CHECKBOX'
      object PanelDirectoryComboBoxRight: TBCPanel
        Left = 421
        Top = 0
        Width = 42
        Height = 40
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 1
        SkinData.SkinSection = 'CHECKBOX'
        object PanelDirectoryButton: TBCPanel
          Left = 0
          Top = 19
          Width = 42
          Height = 21
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 0
          SkinData.SkinSection = 'CHECKBOX'
          object SpeedButtonDirectory: TBCSpeedButton
            Left = 0
            Top = 0
            Width = 21
            Height = 21
            Action = ActionDirectoryButtonClick
            Align = alLeft
            Flat = True
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000300000
              0033000000330000003300000033000000330000003300000033000000330000
              00330000003300000033000000330000002F00000000000000004598D1F24398
              D2FF4094D0FF3E92CFFF3E92CEFF3F92CEFF3F92CEFF3F92CEFF3F92CEFF3F92
              CEFF3F92CEFF3F92CEFF3F93CFFF4194CEF00000000E469AD3004499D2FF3F94
              D0FFABFBFFFF9BF3FFFF92F1FFFF93F1FFFF93F1FFFF93F1FFFF93F1FFFF93F1
              FFFF93F1FFFF93F1FFFFA6F8FFFF65B8E3FF31709D5F469AD3004398D2FF4FA6
              D9FF8EDAF5FFA2EEFFFF82E5FEFF84E5FEFF84E5FEFF85E6FEFF85E6FEFF85E6
              FEFF85E6FEFF84E6FEFF96EBFFFF8CD8F5FF3985BCB84499D2004296D1FF6BBE
              E8FF6DBDE6FFBBF2FFFF75DEFDFF77DEFCFF78DEFCFF7BDFFCFF7DDFFCFF7DDF
              FCFF7DDFFCFF7CDFFCFF80E0FDFFADF0FFFF4D9DD3FF0000000E4095D0FF8AD7
              F5FF44A1D8FFDDFDFFFFDAFAFFFFDBFAFFFFDEFAFFFF74DCFCFF76DBFAFF75DA
              FAFF74DAFAFF74DAFAFF72D9FAFFA1E8FFFF7CBFE6FF306F9C5E3E94D0FFABF0
              FFFF449DD6FF368CCBFF368CCBFF368CCBFF378BCBFF5CBEEAFF6FD9FBFF6AD6
              FAFF68D5F9FF67D4F9FF66D4F9FF82DEFCFFAAE0F6FF3885BCB93D92CFFFB9F4
              FFFF73DBFBFF6BCCF2FF6CCDF3FF6CCEF3FF6DCEF3FF479CD4FF56BAE9FFDAF8
              FFFFD7F6FFFFD6F6FFFFD5F6FFFFD5F7FFFFDBFCFFFF3E94D0FF3C92CFFFC0F3
              FFFF71DAFBFF74DBFBFF75DBFCFF75DBFCFF76DCFCFF73DAFAFF449CD4FF378C
              CBFF368CCBFF358CCCFF348DCCFF3890CEFF3D94D0FF4398D2EB3B92CFFFCAF6
              FFFF69D5F9FF6CD5F9FF6BD5F9FF69D5F9FF69D5FAFF6AD7FBFF68D4FAFF5EC7
              F1FF5EC7F2FF5DC8F2FFB4E3F8FF3D94D0FF3F8FC669469AD3003B92CFFFD5F7
              FFFF60D1F9FF61D0F8FFB4EBFDFFD9F6FFFFDAF8FFFFDAF8FFFFDBF9FFFFDCFA
              FFFFDCFAFFFFDCFBFFFFE0FFFFFF3E95D0FF4599D333469AD3003D94D0FFDCFC
              FFFFD8F7FFFFD8F7FFFFDBFAFFFF358ECDFF3991CEFF3A92CFFF3A92CFFF3A92
              CFFF3A92CFFF3B92CFFF3D94D0FF4398D2D7469AD300469AD3004398D2B03D94
              D0FF3A92CFFF3A92CFFF3D94D0FF4197D1D24398D2004498D2004498D2004498
              D2004498D2004499D2004499D300459AD300469AD300469AD300FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
            SkinData.SkinSection = 'TOOLBUTTON'
            ImageIndex = 0
          end
          object SpeedButtonDirectory2: TBCSpeedButton
            Left = 21
            Top = 0
            Width = 21
            Height = 21
            Action = ActionDirectoryItemsButtonClick
            Align = alRight
            Flat = True
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000000000300000
              0033000000330000003300000033000000330000005C0000005C0000005C0000
              0033000000330000003000000000000000000000000000000000B6A494F2B5A3
              93FFB5A292FFB5A292FFB5A292FFB5A292FF5A6C7CFF4A6784FF5291D9FF9081
              74FFB5A393FFB6A494F200000000000000000000000000000000B5A393FFFFFF
              FFFFF3E8DFFFF3E8E0FFF3E9E0FFF3E9E0FF60859FFF82A7B6FF90D6FFFF376A
              9BFFCCCCCCFFB5A393FF00000000000000000000000000000000B5A292FFFFFF
              FFFFF5ECE5FFF5ECE5FFF5EDE6FFF5EDE6FF4FB2F0FF90E7FFFF81D4FFFF159B
              FFFF3D6D9BFF908174FF00000000000000000000000000000000B6A394FFB19D
              8CFFAF9A89FFAE9A89FFAE9A89FFAE9A89FFAE9A89FF3378C4FF45C8FFFF2CAB
              FFFF1B9EFFFF3C6D9BFF00000033000000000000000000000000B5A393FFFFFF
              FFFFF9F5F0FFF9F5F0FFF9F5F0FFF9F5F0FFF9F5F0FFF9F5F0FF397DC5FF4BCA
              FFFF2EACFFFF179DFFFF316BA2FF000000330000000000000000B5A59BFFFFFF
              FFFFFBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFF3A7F
              C6FF48CAFFFF22ABFFFF84B1D7FF7F7971FF0000003300000000B87F38FFB277
              2EFFAF732AFFAE732AFFAE732AFFAE732AFFAE732AFFAE732AFFAE732AFFAF73
              2AFF337EC9FFB4DEF1FF938980FFC1BFB8FF777C6EFF00000033B67F3CFFFFF4
              D8FFFDE5C3FFFDE5C2FFFDE5C3FFFDE5C3FFFDE5C3FFFDE5C3FFFDE5C2FFFDE5
              C3FFFFF4D8FF93867AFFEEEBE6FF898C83FFBA7AB6FF9869CAFFB57E3BFFFFF1
              D4FFF6D3A8FFF5D3A7FFF5D3A7FFF5D3A7FFF5D3A7FFF5D3A7FFF5D3A7FFF6D3
              A8FFFFF1D4FFB57D38FF878780FFE3B3E2FFCB96C6FFAE7DCEFFB67F3CFFFFF4
              D8FFFFEED1FFFFEDD0FFFFEDD0FFFFEDD0FFFFEDD0FFFFEDD0FFFFEDD0FFFFEE
              D1FFFFF4D7FFB67C36FF00000033C48BD9FFBF8AD3FF00000023B87F38FFB277
              2EFFAF7329FFAE7229FFAE7229FFAE7229FFAE7229FFAE7229FFAE7229FFAF73
              29FFB2762DFFB67B31FFB7A69BFFB7A596FFB7A596FFAA988BC0B5A69BFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFB2A194FFE8DFD4FFE8DED2FFE9DFD3FFB7A495FFB5A394FFF2ED
              E8FFF2E9E2FFF1E9E1FFF1E9E1FFF1E9E1FFF1E9E1FFF1E9E1FFF1E9E1FFF2E9
              E2FFF2ECE7FFB19D8DFFF6F2ECFF73706DFFF9F4EEFFB6A393FFB7A494FFE3DD
              D7FFE1D9D4FFE0D9D3FFE0D9D3FFE0D9D3FFE0D9D3FFE0D9D3FFE0D9D3FFE1D9
              D4FFE3DCD7FFB39F8EFFFFFFFFFFFFFFFFFFFFFFFFFFB6A393FFB9A697EFB7A4
              95FFB6A393FFB6A393FFB6A393FFB6A393FFB6A393FFB6A393FFB6A393FFB6A3
              93FFB7A494FFB7A595FFB5A292FFB4A191FFBBA99AFFB8A696B0}
            SkinData.SkinSection = 'TOOLBUTTON'
          end
        end
      end
      object PanelDirectoryComboBoxClient: TBCPanel
        Left = 0
        Top = 0
        Width = 421
        Height = 40
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        BevelOuter = bvNone
        Padding.Right = 3
        TabOrder = 0
        SkinData.SkinSection = 'CHECKBOX'
        object ComboBoxDirectory: TBCComboBox
          Left = 0
          Top = 19
          Width = 418
          Height = 21
          Align = alBottom
          Alignment = taLeftJustify
          BoundLabel.Active = True
          BoundLabel.Caption = 'Directory'
          BoundLabel.Indent = 4
          BoundLabel.Layout = sclTopLeft
          SkinData.SkinSection = 'COMBOBOX'
          VerticalAlignment = taAlignTop
          ItemIndex = -1
          TabOrder = 0
          UseMouseWheel = False
        end
      end
    end
    object PanelFileMaskComboBoxAndButton: TBCPanel
      AlignWithMargins = True
      Left = 12
      Top = 19
      Width = 463
      Height = 41
      Margins.Left = 10
      Margins.Top = 4
      Margins.Right = 10
      Margins.Bottom = 2
      Align = alTop
      AutoSize = True
      BevelOuter = bvNone
      TabOrder = 0
      SkinData.SkinSection = 'CHECKBOX'
      object PanelFileMaskComboBoxClient: TBCPanel
        Left = 0
        Top = 0
        Width = 442
        Height = 41
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        BevelOuter = bvNone
        Padding.Right = 3
        TabOrder = 0
        SkinData.SkinSection = 'CHECKBOX'
        object ComboBoxFileMask: TBCComboBox
          Left = 0
          Top = 20
          Width = 439
          Height = 21
          Margins.Left = 10
          Margins.Top = 22
          Margins.Right = 10
          Align = alBottom
          Alignment = taLeftJustify
          BoundLabel.Active = True
          BoundLabel.Caption = 'File mask'
          BoundLabel.Indent = 4
          BoundLabel.Layout = sclTopLeft
          DropDownCount = 20
          SkinData.SkinSection = 'COMBOBOX'
          VerticalAlignment = taAlignTop
          ItemIndex = -1
          TabOrder = 0
          Text = '*.*'
          UseMouseWheel = False
        end
      end
      object PanelFileMaskComboBoxRight: TBCPanel
        Left = 442
        Top = 0
        Width = 21
        Height = 41
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 1
        SkinData.SkinSection = 'CHECKBOX'
        object PanelFileMaskButton: TBCPanel
          Left = 0
          Top = 20
          Width = 21
          Height = 21
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 0
          SkinData.SkinSection = 'CHECKBOX'
          object SpeedButtonFileMask: TBCSpeedButton
            Left = 0
            Top = 0
            Width = 21
            Height = 21
            Action = ActionFileMaskItemsButtonClick
            Align = alLeft
            Flat = True
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000000000300000
              0033000000330000003300000033000000330000005C0000005C0000005C0000
              0033000000330000003000000000000000000000000000000000B6A494F2B5A3
              93FFB5A292FFB5A292FFB5A292FFB5A292FF5A6C7CFF4A6784FF5291D9FF9081
              74FFB5A393FFB6A494F200000000000000000000000000000000B5A393FFFFFF
              FFFFF3E8DFFFF3E8E0FFF3E9E0FFF3E9E0FF60859FFF82A7B6FF90D6FFFF376A
              9BFFCCCCCCFFB5A393FF00000000000000000000000000000000B5A292FFFFFF
              FFFFF5ECE5FFF5ECE5FFF5EDE6FFF5EDE6FF4FB2F0FF90E7FFFF81D4FFFF159B
              FFFF3D6D9BFF908174FF00000000000000000000000000000000B6A394FFB19D
              8CFFAF9A89FFAE9A89FFAE9A89FFAE9A89FFAE9A89FF3378C4FF45C8FFFF2CAB
              FFFF1B9EFFFF3C6D9BFF00000033000000000000000000000000B5A393FFFFFF
              FFFFF9F5F0FFF9F5F0FFF9F5F0FFF9F5F0FFF9F5F0FFF9F5F0FF397DC5FF4BCA
              FFFF2EACFFFF179DFFFF316BA2FF000000330000000000000000B5A59BFFFFFF
              FFFFFBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFF3A7F
              C6FF48CAFFFF22ABFFFF84B1D7FF7F7971FF0000003300000000B87F38FFB277
              2EFFAF732AFFAE732AFFAE732AFFAE732AFFAE732AFFAE732AFFAE732AFFAF73
              2AFF337EC9FFB4DEF1FF938980FFC1BFB8FF777C6EFF00000033B67F3CFFFFF4
              D8FFFDE5C3FFFDE5C2FFFDE5C3FFFDE5C3FFFDE5C3FFFDE5C3FFFDE5C2FFFDE5
              C3FFFFF4D8FF93867AFFEEEBE6FF898C83FFBA7AB6FF9869CAFFB57E3BFFFFF1
              D4FFF6D3A8FFF5D3A7FFF5D3A7FFF5D3A7FFF5D3A7FFF5D3A7FFF5D3A7FFF6D3
              A8FFFFF1D4FFB57D38FF878780FFE3B3E2FFCB96C6FFAE7DCEFFB67F3CFFFFF4
              D8FFFFEED1FFFFEDD0FFFFEDD0FFFFEDD0FFFFEDD0FFFFEDD0FFFFEDD0FFFFEE
              D1FFFFF4D7FFB67C36FF00000033C48BD9FFBF8AD3FF00000023B87F38FFB277
              2EFFAF7329FFAE7229FFAE7229FFAE7229FFAE7229FFAE7229FFAE7229FFAF73
              29FFB2762DFFB67B31FFB7A69BFFB7A596FFB7A596FFAA988BC0B5A69BFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFB2A194FFE8DFD4FFE8DED2FFE9DFD3FFB7A495FFB5A394FFF2ED
              E8FFF2E9E2FFF1E9E1FFF1E9E1FFF1E9E1FFF1E9E1FFF1E9E1FFF1E9E1FFF2E9
              E2FFF2ECE7FFB19D8DFFF6F2ECFF73706DFFF9F4EEFFB6A393FFB7A494FFE3DD
              D7FFE1D9D4FFE0D9D3FFE0D9D3FFE0D9D3FFE0D9D3FFE0D9D3FFE0D9D3FFE1D9
              D4FFE3DCD7FFB39F8EFFFFFFFFFFFFFFFFFFFFFFFFFFB6A393FFB9A697EFB7A4
              95FFB6A393FFB6A393FFB6A393FFB6A393FFB6A393FFB6A393FFB6A393FFB6A3
              93FFB7A494FFB7A595FFB5A292FFB4A191FFBBA99AFFB8A696B0}
            SkinData.SkinSection = 'TOOLBUTTON'
          end
        end
      end
    end
    object PanelIncludeSubdirectories: TBCPanel
      Left = 2
      Top = 104
      Width = 483
      Height = 27
      Align = alTop
      AutoSize = True
      BevelOuter = bvNone
      Padding.Top = 6
      TabOrder = 2
      SkinData.SkinSection = 'CHECKBOX'
      object StickyLabelIncludeSubdirectories: TsStickyLabel
        Left = 10
        Top = 10
        Width = 105
        Height = 13
        Caption = 'Include subdirectories'
        AttachTo = SliderIncludeSubDirectories
        Gap = 8
      end
      object SliderIncludeSubDirectories: TsSlider
        Left = 123
        Top = 6
        Width = 50
        AutoSize = True
        TabOrder = 0
        ImageIndexOff = 0
        ImageIndexOn = 0
        FontOn.Charset = DEFAULT_CHARSET
        FontOn.Color = clWindowText
        FontOn.Height = -11
        FontOn.Name = 'Tahoma'
        FontOn.Style = []
        SliderCaptionOn = 'Yes'
        SliderCaptionOff = 'No'
      end
    end
  end
  object PanelTextToFind: TBCPanel
    AlignWithMargins = True
    Left = 9
    Top = 6
    Width = 481
    Height = 42
    Margins.Top = 0
    Margins.Bottom = 6
    Align = alTop
    BevelOuter = bvNone
    Color = clWindow
    TabOrder = 3
    SkinData.SkinSection = 'CHECKBOX'
    object PanelTextToFindRight: TBCPanel
      Left = 460
      Top = 0
      Width = 21
      Height = 42
      Align = alRight
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      SkinData.SkinSection = 'CHECKBOX'
      object PanelTextToFindButton: TBCPanel
        Left = 0
        Top = 21
        Width = 21
        Height = 21
        Align = alBottom
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        SkinData.SkinSection = 'CHECKBOX'
        object SpeedButtonTextToFind: TBCSpeedButton
          Left = 0
          Top = 0
          Width = 21
          Height = 21
          Action = ActionTextToFindItemsButtonClick
          Align = alLeft
          Flat = True
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000300000
            0033000000330000003300000033000000330000005C0000005C0000005C0000
            0033000000330000003000000000000000000000000000000000B6A494F2B5A3
            93FFB5A292FFB5A292FFB5A292FFB5A292FF5A6C7CFF4A6784FF5291D9FF9081
            74FFB5A393FFB6A494F200000000000000000000000000000000B5A393FFFFFF
            FFFFF3E8DFFFF3E8E0FFF3E9E0FFF3E9E0FF60859FFF82A7B6FF90D6FFFF376A
            9BFFCCCCCCFFB5A393FF00000000000000000000000000000000B5A292FFFFFF
            FFFFF5ECE5FFF5ECE5FFF5EDE6FFF5EDE6FF4FB2F0FF90E7FFFF81D4FFFF159B
            FFFF3D6D9BFF908174FF00000000000000000000000000000000B6A394FFB19D
            8CFFAF9A89FFAE9A89FFAE9A89FFAE9A89FFAE9A89FF3378C4FF45C8FFFF2CAB
            FFFF1B9EFFFF3C6D9BFF00000033000000000000000000000000B5A393FFFFFF
            FFFFF9F5F0FFF9F5F0FFF9F5F0FFF9F5F0FFF9F5F0FFF9F5F0FF397DC5FF4BCA
            FFFF2EACFFFF179DFFFF316BA2FF000000330000000000000000B5A59BFFFFFF
            FFFFFBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFFFBFBFCFF3A7F
            C6FF48CAFFFF22ABFFFF84B1D7FF7F7971FF0000003300000000B87F38FFB277
            2EFFAF732AFFAE732AFFAE732AFFAE732AFFAE732AFFAE732AFFAE732AFFAF73
            2AFF337EC9FFB4DEF1FF938980FFC1BFB8FF777C6EFF00000033B67F3CFFFFF4
            D8FFFDE5C3FFFDE5C2FFFDE5C3FFFDE5C3FFFDE5C3FFFDE5C3FFFDE5C2FFFDE5
            C3FFFFF4D8FF93867AFFEEEBE6FF898C83FFBA7AB6FF9869CAFFB57E3BFFFFF1
            D4FFF6D3A8FFF5D3A7FFF5D3A7FFF5D3A7FFF5D3A7FFF5D3A7FFF5D3A7FFF6D3
            A8FFFFF1D4FFB57D38FF878780FFE3B3E2FFCB96C6FFAE7DCEFFB67F3CFFFFF4
            D8FFFFEED1FFFFEDD0FFFFEDD0FFFFEDD0FFFFEDD0FFFFEDD0FFFFEDD0FFFFEE
            D1FFFFF4D7FFB67C36FF00000033C48BD9FFBF8AD3FF00000023B87F38FFB277
            2EFFAF7329FFAE7229FFAE7229FFAE7229FFAE7229FFAE7229FFAE7229FFAF73
            29FFB2762DFFB67B31FFB7A69BFFB7A596FFB7A596FFAA988BC0B5A69BFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFB2A194FFE8DFD4FFE8DED2FFE9DFD3FFB7A495FFB5A394FFF2ED
            E8FFF2E9E2FFF1E9E1FFF1E9E1FFF1E9E1FFF1E9E1FFF1E9E1FFF1E9E1FFF2E9
            E2FFF2ECE7FFB19D8DFFF6F2ECFF73706DFFF9F4EEFFB6A393FFB7A494FFE3DD
            D7FFE1D9D4FFE0D9D3FFE0D9D3FFE0D9D3FFE0D9D3FFE0D9D3FFE0D9D3FFE1D9
            D4FFE3DCD7FFB39F8EFFFFFFFFFFFFFFFFFFFFFFFFFFB6A393FFB9A697EFB7A4
            95FFB6A393FFB6A393FFB6A393FFB6A393FFB6A393FFB6A393FFB6A393FFB6A3
            93FFB7A494FFB7A595FFB5A292FFB4A191FFBBA99AFFB8A696B0}
          SkinData.SkinSection = 'TOOLBUTTON'
        end
      end
    end
    object PanelTextToFindClient: TBCPanel
      AlignWithMargins = True
      Left = 0
      Top = 0
      Width = 457
      Height = 42
      Margins.Left = 0
      Margins.Top = 0
      Margins.Bottom = 0
      Align = alClient
      BevelOuter = bvNone
      Color = clWindow
      TabOrder = 1
      SkinData.SkinSection = 'CHECKBOX'
      object ComboBoxTextToFind: TBCComboBox
        Left = 0
        Top = 21
        Width = 457
        Height = 21
        Margins.Left = 0
        Margins.Top = 20
        Margins.Right = 0
        Align = alBottom
        Alignment = taLeftJustify
        BoundLabel.Active = True
        BoundLabel.Caption = 'Text to find'
        BoundLabel.Indent = 4
        BoundLabel.Layout = sclTopLeft
        SkinData.SkinSection = 'COMBOBOX'
        VerticalAlignment = taAlignTop
        ItemIndex = -1
        TabOrder = 0
        OnChange = ComboBoxTextToFindChange
        UseMouseWheel = False
      end
    end
  end
  object ActionList: TActionList
    Left = 378
    Top = 6
    object ActionTextToFindItemsButtonClick: TAction
      OnExecute = ActionTextToFindItemsButtonClickExecute
    end
    object ActionFileMaskItemsButtonClick: TAction
      OnExecute = ActionFileMaskItemsButtonClickExecute
    end
    object ActionDirectoryButtonClick: TAction
      ImageIndex = 0
      OnExecute = ActionDirectoryButtonClickExecute
    end
    object ActionDirectoryItemsButtonClick: TAction
      OnExecute = ActionDirectoryItemsButtonClickExecute
    end
    object ActionFind: TAction
      Caption = 'Find'
      OnExecute = ActionFindExecute
      OnUpdate = ActionFindUpdate
    end
  end
end
