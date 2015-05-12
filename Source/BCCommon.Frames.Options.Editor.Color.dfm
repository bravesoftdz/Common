inherited OptionsEditorColorFrame: TOptionsEditorColorFrame
  Width = 610
  Height = 429
  Align = alClient
  object Panel: TBCPanel [0]
    AlignWithMargins = True
    Left = 4
    Top = 0
    Width = 606
    Height = 429
    Margins.Left = 4
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alClient
    BevelOuter = bvNone
    Color = clWindow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
    SkinData.SkinSection = 'CHECKBOX'
    object Splitter: TsSplitter
      Left = 0
      Top = 199
      Width = 606
      Height = 6
      Cursor = crVSplit
      Align = alTop
      ShowGrip = True
      SkinData.SkinSection = 'SPLITTER'
    end
    object PanelTop: TBCPanel
      Left = 0
      Top = 0
      Width = 606
      Height = 41
      Align = alTop
      BevelOuter = bvNone
      Color = clWindow
      ParentBackground = False
      TabOrder = 0
      SkinData.SkinSection = 'CHECKBOX'
      object ScrollBox: TBCScrollBox
        Left = 0
        Top = 0
        Width = 606
        Height = 41
        Align = alClient
        BorderStyle = bsNone
        ParentColor = False
        TabOrder = 0
        SkinData.SkinSection = 'CHECKBOX'
        object SpeedButtonColor: TBCSpeedButton
          Left = 226
          Top = 14
          Width = 21
          Height = 21
          Action = ActionAddColor
          Flat = True
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000FFFFFF000000
            000000000000000000000000000A000000250000003300000033000000330000
            0033000000250000000A000000000000000000000000FFFFFF00FFFFFF000000
            00000000000000000022004F2B5C008347C9008C4BFF008B4AFF008B4AFF008C
            4BFF008347C9004F2B5C0000001E0000000000000000FFFFFF00FFFFFF000000
            00000000001E008046BB009050FF01A169FF00AA76FF00AB77FF00AB77FF00AA
            76FF01A169FF009050FF007C44AA0000001E00000000FFFFFF00FFFFFF000000
            000A007C43AA009152FF02AC77FF00C38CFF00D699FF18DEA8FF18DEA8FF00D6
            99FF00C38CFF01AB76FF009253FF007C44AA0000000AFFFFFF00FFFFFF000059
            3151009051FF0FB483FF02D299FF00D69BFF00D193FFFFFFFFFFFFFFFFFF00D1
            93FF00D69BFF00D198FF01AB76FF009050FF005A3151FFFFFF00FFFFFF000083
            45C916AB78FF11C997FF00D49AFF00D297FF00CD8EFFFFFFFFFFFFFFFFFF00CD
            8EFF00D297FF00D59BFF00C18CFF01A169FF008447C9FFFFFF00FFFFFF00008A
            48FF38C49CFF00D198FF00CD92FF00CB8EFF00C787FFFFFFFFFFFFFFFFFF00C7
            87FF00CB8EFF00CE93FF00D09AFF00AB76FF008C4BFFFFFFFF00FFFFFF000089
            46FF51D2AFFF12D4A3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFF00CF97FF00AD78FF008B4AFFFFFFFF00FFFFFF000088
            45FF66DDBEFF10D0A2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFF00CD97FF00AD78FF008B4AFFFFFFFF00FFFFFF000088
            46FF76E0C5FF00CA98FF00C590FF00C48EFF00C187FFFFFFFFFFFFFFFFFF00C1
            87FF00C48EFF00C793FF00CB99FF00AB76FF008C4BFFFFFFFF00FFFFFF000088
            46BE59C9A4FF49DEBCFF00C794FF00C794FF00C38EFFFFFFFFFFFFFFFFFF00C3
            8EFF00C896FF00CB9AFF06C190FF00A168FF008B4BBFFFFFFF00FFFFFF00008C
            4B330A9458FFADF8E9FF18D0A7FF00C494FF00C290FFFFFFFFFFFFFFFFFF00C3
            91FF00C799FF05C89BFF18B787FF009050FF008E4D33FFFFFF00FFFFFF000000
            0000008A48AA199C63FFBCFFF7FF5DE4C9FF00C397FF00BF90FF00C091FF00C4
            98FF22CAA2FF31C297FF039355FF008D4C9500000000FFFFFF00FFFFFF000000
            000000000000008A48950E9659FF74D5B6FF9FF3E0FF92EFDAFF79E5CAFF5DD6
            B5FF2EB586FF039152FF008C4CAA0000000000000000FFFFFF00FFFFFF000000
            00000000000000000000008C4A33008946BB008744FF008743FF008744FF0089
            46FF008B49BB008D4C33000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
          SkinData.SkinSection = 'TOOLBUTTON'
        end
        object ComboBoxColor: TBCComboBox
          Left = 0
          Top = 14
          Width = 219
          Height = 22
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Alignment = taLeftJustify
          BoundLabel.Active = True
          BoundLabel.Caption = 'Color'
          BoundLabel.Indent = 4
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          BoundLabel.Layout = sclTopLeft
          BoundLabel.MaxWidth = 0
          BoundLabel.UseSkinColor = True
          DropDownCount = 9
          SkinData.SkinSection = 'COMBOBOX'
          VerticalAlignment = taAlignTop
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemIndex = -1
          ParentFont = False
          TabOrder = 0
          OnChange = ComboBoxColorChange
        end
        object ComboBoxHighlighter: TBCComboBox
          Left = 256
          Top = 14
          Width = 241
          Height = 22
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Alignment = taLeftJustify
          BoundLabel.Active = True
          BoundLabel.Caption = 'Highlighter'
          BoundLabel.Indent = 4
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          BoundLabel.Layout = sclTopLeft
          BoundLabel.MaxWidth = 0
          BoundLabel.UseSkinColor = True
          DropDownCount = 9
          SkinData.SkinSection = 'COMBOBOX'
          VerticalAlignment = taAlignTop
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemIndex = -1
          ParentFont = False
          TabOrder = 1
          OnChange = ComboBoxHighlighterChange
        end
      end
    end
    object Editor: TBCEditor
      Left = 0
      Top = 205
      Width = 606
      Height = 224
      Cursor = crIBeam
      Margins.Left = 0
      Margins.Top = 5
      Margins.Right = 0
      Margins.Bottom = 0
      ActiveLine.Indicator.Visible = False
      Align = alClient
      Caret.NonBlinking.Enabled = False
      Caret.Options = []
      CodeFolding.Hint.Font.Charset = DEFAULT_CHARSET
      CodeFolding.Hint.Font.Color = clWindowText
      CodeFolding.Hint.Font.Height = -11
      CodeFolding.Hint.Font.Name = 'Courier New'
      CodeFolding.Hint.Font.Style = []
      CompletionProposal.CloseChars = '()[]. '
      CompletionProposal.Columns = <>
      CompletionProposal.Font.Charset = DEFAULT_CHARSET
      CompletionProposal.Font.Color = clWindowText
      CompletionProposal.Font.Height = -11
      CompletionProposal.Font.Name = 'Courier New'
      CompletionProposal.Font.Style = []
      CompletionProposal.ShortCut = 16416
      CompletionProposal.Trigger.Chars = '.'
      CompletionProposal.Trigger.Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      LeftMargin.Font.Charset = DEFAULT_CHARSET
      LeftMargin.Font.Color = 13408665
      LeftMargin.Font.Height = -11
      LeftMargin.Font.Name = 'Courier New'
      LeftMargin.Font.Style = []
      LeftMargin.Width = 55
      Lines.Strings = (
        '')
      LineSpacing.Rule = lsSpecified
      LineSpacing.Spacing = 0
      MatchingPair.Enabled = True
      Minimap.Font.Charset = DEFAULT_CHARSET
      Minimap.Font.Color = clWindowText
      Minimap.Font.Height = -4
      Minimap.Font.Name = 'Courier New'
      Minimap.Font.Style = []
      RightMargin.Position = 80
      RightMargin.Visible = True
      SpecialChars.Style = scsDot
      TabOrder = 1
      WordWrap.Enabled = False
      WordWrap.Position = 80
      WordWrap.Style = wwsClientWidth
    end
    object PageControl: TBCPageControl
      Left = 0
      Top = 41
      Width = 606
      Height = 158
      ActivePage = TabSheetSkin
      Align = alTop
      TabOrder = 2
      SkinData.SkinSection = 'PAGECONTROL'
      ActivePageCaption = 'Skin'
      HoldShiftToDragDrop = False
      TabDragDrop = False
      object TabSheetEditor: TsTabSheet
        Caption = 'Editor'
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        object ComboBoxEditorElement: TBCComboBox
          Left = 6
          Top = 22
          Width = 240
          Height = 22
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Alignment = taLeftJustify
          BoundLabel.Active = True
          BoundLabel.Caption = 'Element'
          BoundLabel.Indent = 4
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          BoundLabel.Layout = sclTopLeft
          BoundLabel.MaxWidth = 0
          BoundLabel.UseSkinColor = True
          DropDownCount = 9
          SkinData.SkinSection = 'COMBOBOX'
          VerticalAlignment = taAlignTop
          Style = csOwnerDrawFixed
          ItemIndex = 0
          TabOrder = 0
          Text = 'Active line'
          OnChange = ComboBoxEditorElementChange
          Items.Strings = (
            'Active line'
            'Background'
            'Code folding background'
            'Code folding collapsed line'
            'Code folding folding line'
            'Code folding hint background'
            'Code folding hint border'
            'Code folding hint text'
            'Code folding indent highlight'
            'Completion proposal background'
            'Completion proposal border'
            'Completion proposal foreground'
            'Completion proposal selected background'
            'Completion proposal selected text'
            'Left margin background'
            'Left margin bookmark panel'
            'Left margin line numbers'
            'Left margin line state modified'
            'Left margin line state normal'
            'Matching pair matched'
            'Matching pair unmatched'
            'Right margin'
            'Right moving edge'
            'Search highlighter background'
            'Search highlighter foreground'
            'Search map activeLine'
            'Search map background'
            'Search map foreground'
            'Selection background'
            'Selection foreground')
        end
        object ColorComboBoxEditorColor: TBCColorComboBox
          Left = 6
          Top = 64
          Width = 240
          Height = 22
          BoundLabel.Active = True
          BoundLabel.Caption = 'Color'
          BoundLabel.Indent = 4
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          BoundLabel.Layout = sclTopLeft
          BoundLabel.MaxWidth = 0
          BoundLabel.UseSkinColor = True
          SkinData.SkinSection = 'COMBOBOX'
          Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor]
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnChange = ColorComboBoxEditorColorChange
          Text = 'clWindow'
        end
      end
      object TabSheetElements: TsTabSheet
        Caption = 'Elements'
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        object ComboBoxElementsName: TBCComboBox
          Left = 6
          Top = 19
          Width = 240
          Height = 22
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Alignment = taLeftJustify
          BoundLabel.Active = True
          BoundLabel.Caption = 'Name'
          BoundLabel.Indent = 4
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          BoundLabel.Layout = sclTopLeft
          BoundLabel.MaxWidth = 0
          BoundLabel.UseSkinColor = True
          DropDownCount = 9
          SkinData.SkinSection = 'COMBOBOX'
          VerticalAlignment = taAlignTop
          Style = csOwnerDrawFixed
          ItemIndex = 0
          TabOrder = 0
          Text = 'Assembler comment'
          OnChange = ComboBoxElementsNameChange
          Items.Strings = (
            'Assembler comment'
            'Assembler reserved word'
            'Attribute'
            'Character'
            'Comment'
            'Directive'
            'Editor'
            'Hex number'
            'Highlighted block'
            'Number'
            'Reserved word'
            'String'
            'Symbol')
        end
        object ColorComboBoxElementsForeground: TBCColorComboBox
          Left = 6
          Top = 60
          Width = 240
          Height = 22
          BoundLabel.Active = True
          BoundLabel.Caption = 'Foreground'
          BoundLabel.Indent = 4
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          BoundLabel.Layout = sclTopLeft
          BoundLabel.MaxWidth = 0
          BoundLabel.UseSkinColor = True
          SkinData.SkinSection = 'COMBOBOX'
          Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor]
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnChange = ColorComboBoxElementsForegroundChange
          Text = 'clWindow'
        end
        object ColorComboBoxElementsBackground: TBCColorComboBox
          Left = 6
          Top = 102
          Width = 240
          Height = 22
          BoundLabel.Active = True
          BoundLabel.Caption = 'Background'
          BoundLabel.Indent = 4
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          BoundLabel.Layout = sclTopLeft
          BoundLabel.MaxWidth = 0
          BoundLabel.UseSkinColor = True
          SkinData.SkinSection = 'COMBOBOX'
          Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor]
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnChange = ColorComboBoxElementsBackgroundChange
          Text = 'clWindow'
        end
        object GroupBoxAttributes: TBCGroupBox
          Left = 253
          Top = 44
          Width = 178
          Height = 83
          Caption = ' Attributes'
          TabOrder = 3
          SkinData.SkinSection = 'GROUPBOX'
          Checked = False
          object CheckBoxElementsAttributesBold: TBCCheckBox
            Left = 12
            Top = 19
            Width = 43
            Height = 20
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Caption = ' Bold'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnClick = CheckBoxElementsAttributesClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object CheckBoxElementsAttributesItalic: TBCCheckBox
            Left = 12
            Top = 37
            Width = 46
            Height = 20
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Caption = ' Italic'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnClick = CheckBoxElementsAttributesClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
          object CheckBoxElementsAttributesUnderline: TBCCheckBox
            Left = 12
            Top = 55
            Width = 68
            Height = 20
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Caption = ' Underline'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            OnClick = CheckBoxElementsAttributesClick
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
          end
        end
      end
      object TabSheetGeneral: TsTabSheet
        Caption = 'General'
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        object EditVersion: TBCEdit
          Left = 8
          Top = 18
          Width = 90
          Height = 21
          TabOrder = 0
          OnChange = EditChange
          SkinData.SkinSection = 'EDIT'
          BoundLabel.Active = True
          BoundLabel.Caption = 'Version'
          BoundLabel.Indent = 4
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          BoundLabel.Layout = sclTopLeft
          BoundLabel.MaxWidth = 0
          BoundLabel.UseSkinColor = True
          EnterToTab = False
          OnlyNumbers = False
          NumbersWithDots = False
          NumbersWithSpots = False
          ErrorColor = 14803455
          NumbersAllowNegative = False
        end
        object DateEditDate: TBCDateEdit
          Left = 8
          Top = 60
          Width = 90
          Height = 21
          AutoSize = False
          EditMask = '!99/99/9999;1; '
          MaxLength = 10
          TabOrder = 1
          Text = '  .  .    '
          OnChange = EditChange
          CheckOnExit = True
          BoundLabel.Active = True
          BoundLabel.Caption = 'Date'
          BoundLabel.Indent = 4
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          BoundLabel.Layout = sclTopLeft
          BoundLabel.MaxWidth = 0
          BoundLabel.UseSkinColor = True
          SkinData.SkinSection = 'EDIT'
          GlyphMode.Blend = 0
          GlyphMode.Grayed = False
        end
      end
      object TabSheetAuthor: TsTabSheet
        Caption = 'Author'
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        object EditName: TBCEdit
          Left = 6
          Top = 20
          Width = 237
          Height = 21
          TabOrder = 0
          OnChange = EditChange
          SkinData.SkinSection = 'EDIT'
          BoundLabel.Active = True
          BoundLabel.Caption = 'Name'
          BoundLabel.Indent = 4
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          BoundLabel.Layout = sclTopLeft
          BoundLabel.MaxWidth = 0
          BoundLabel.UseSkinColor = True
          EnterToTab = False
          OnlyNumbers = False
          NumbersWithDots = False
          NumbersWithSpots = False
          ErrorColor = 14803455
          NumbersAllowNegative = False
        end
        object EditEmail: TBCEdit
          Left = 6
          Top = 60
          Width = 237
          Height = 21
          TabOrder = 1
          OnChange = EditChange
          SkinData.SkinSection = 'EDIT'
          BoundLabel.Active = True
          BoundLabel.Caption = 'Email'
          BoundLabel.Indent = 4
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -11
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          BoundLabel.Layout = sclTopLeft
          BoundLabel.MaxWidth = 0
          BoundLabel.UseSkinColor = True
          EnterToTab = False
          OnlyNumbers = False
          NumbersWithDots = False
          NumbersWithSpots = False
          ErrorColor = 14803455
          NumbersAllowNegative = False
        end
      end
      object TabSheetSkin: TsTabSheet
        Caption = 'Skin'
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        object LabelSkinDescription: TBCLabel
          Left = 6
          Top = 3
          Width = 171
          Height = 13
          Caption = 'Use skin color for selected elements'
        end
        object CheckBoxSkinActiveLineBackground: TBCCheckBox
          Left = 6
          Top = 19
          Width = 131
          Height = 20
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = ' Active line background'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = CheckBoxSkinValueClick
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object CheckBoxSkinBackground: TBCCheckBox
          Left = 252
          Top = 37
          Width = 79
          Height = 20
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = ' Background'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnClick = CheckBoxSkinValueClick
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object CheckBoxSkinCodeFoldingBackground: TBCCheckBox
          Left = 6
          Top = 91
          Width = 142
          Height = 20
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = ' Code folding background'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
          OnClick = CheckBoxSkinValueClick
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object CheckBoxSkinCodeFoldingHintBackground: TBCCheckBox
          Left = 252
          Top = 91
          Width = 163
          Height = 20
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = ' Code folding hint background'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
          OnClick = CheckBoxSkinValueClick
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object CheckBoxSkinCompletionProposalBackground: TBCCheckBox
          Left = 6
          Top = 109
          Width = 179
          Height = 20
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = ' Completion proposal background'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 9
          OnClick = CheckBoxSkinValueClick
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object CheckBoxSkinCompletionProposalSelectionBackground: TBCCheckBox
          Left = 252
          Top = 109
          Width = 224
          Height = 20
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = ' Completion proposal selection background'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 10
          OnClick = CheckBoxSkinValueClick
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object CheckBoxSkinLeftMarginBackground: TBCCheckBox
          Left = 6
          Top = 73
          Width = 136
          Height = 20
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = ' Left margin background'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          OnClick = CheckBoxSkinValueClick
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object CheckBoxSkinBookmarkPanelBackground: TBCCheckBox
          Left = 252
          Top = 73
          Width = 157
          Height = 20
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = ' Bookmark panel background'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          OnClick = CheckBoxSkinValueClick
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object CheckBoxSkinSelectionForeground: TBCCheckBox
          Left = 6
          Top = 55
          Width = 123
          Height = 20
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = ' Selection foreground'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnClick = CheckBoxSkinValueClick
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object CheckBoxSkinSelectionBackground: TBCCheckBox
          Left = 252
          Top = 55
          Width = 125
          Height = 20
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = ' Selection background'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          OnClick = CheckBoxSkinValueClick
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
        object CheckBoxSkinForeground: TBCCheckBox
          Left = 6
          Top = 37
          Width = 79
          Height = 20
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = ' Foreground'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = CheckBoxSkinValueClick
          SkinData.SkinSection = 'CHECKBOX'
          ImgChecked = 0
          ImgUnchecked = 0
        end
      end
    end
  end
  inherited FrameAdapter: TsFrameAdapter
    Left = 368
    Top = 24
  end
  object ActionList: TActionList
    Left = 252
    Top = 226
    object ActionAddColor: TAction
      OnExecute = ActionAddColorExecute
    end
  end
  object SaveDialog: TsSaveDialog
    DefaultExt = 'json'
    Left = 438
    Top = 79
  end
  object MultiStringHolder: TBCMultiStringHolder
    MultipleStrings = <
      item
        Name = 'DefaultJSON'
        Strings.Strings = (
          '{'
          '    "Colors": {'
          '        "Info": {'
          '            "General": {'
          '                "Version": "1.0",'
          '                "Date": "1.5.2015"'
          '            },'
          '            "Author": {'
          '                "Name": "Lasse Rautiainen",'
          '                "Mail": "lasse@bonecode.com"'
          '            }'
          '        },'
          '        "Editor": {'
          '            "Colors": {'
          '                "Background": "clWindow",'
          '                "ActiveLine": "$00E6FAFF",'
          '                "CodeFoldingBackground": "clWhite",'
          '                "CodeFoldingCollapsedLine": "$00CC9999",'
          '                "CodeFoldingFoldingLine": "$00CC9999",'
          '                "CodeFoldingIndentHighlight": "$00CC9999",'
          '                "CodeFoldingHintBackground": "clWindow",'
          '                "CodeFoldingHintBorder": "$00CC9999",'
          '                "CodeFoldingHintText": "clNone",'
          '                "CompletionProposalBackground": "clWindow",'
          '                "CompletionProposalForeground": "clNone",'
          '                "CompletionProposalBorder": "$00CC9999",'
          
            '                "CompletionProposalSelectedBackground": "clHighl' +
            'ight",'
          
            '                "CompletionProposalSelectedText": "clHighlightTe' +
            'xt",'
          '                "LeftMarginBackground": "clWhite",'
          '                "LeftMarginLineNumbers": "$00CC9999",'
          '                "LeftMarginLineStateModified": "clYellow",'
          '                "LeftMarginLineStateNormal": "clLime",'
          '                "LeftMarginBookmarkPanel": "clWhite",'
          '                "MatchingPairMatched": "clAqua",'
          '                "MatchingPairUnmatched": "clYellow",'
          '                "RightMargin": "clSilver",'
          '                "RightMovingEdge": "clSilver",'
          '                "SearchHighlighterBackground": "$0078AAFF",'
          '                "SearchHighlighterForeground": "clWindowText",'
          '                "SearchMapActiveLine": "$00F0F0F0",'
          '                "SearchMapBackground": "$00F4F4F4",'
          '                "SearchMapForeground": "$0078AAFF",'
          '                "SelectionBackground": "$00A56D53",'
          '                "SelectionForeground": "clHighlightText"'
          '            },'
          '            "Fonts": {'
          '                "LineNumbers": "Courier New",'
          '                "Text": "Courier New",'
          '                "Minimap": "Courier New",'
          '                "CodeFoldingHint": "Courier New",'
          '                "CompletionProposal": "Courier New"'
          '            },'
          '            "FontSizes": {'
          '                "LineNumbers": "8",'
          '                "Text": "9",'
          '                "Minimap": "3",'
          '                "CodeFoldingHint": "8",'
          '                "CompletionProposal": "8"'
          '            }'
          '        },'
          '        "Elements": ['
          '            {'
          '                "Name": "Editor",'
          '                "Foreground": "clWindowText",'
          '                "Background": "clWindow"'
          '            },'
          '            {'
          '                "Name": "Comment",'
          '                "Foreground": "clGreen",'
          '                "Background": "clWindow",'
          '                "Style": "Italic"'
          '            },'
          '            {'
          '                "Name": "String",'
          '                "Foreground": "clBlue",'
          '                "Background": "clWindow"'
          '            },'
          '            {'
          '                "Name": "Directive",'
          '                "Foreground": "clTeal",'
          '                "Background": "clWindow"'
          '            },'
          '            {'
          '                "Name": "Character",'
          '                "Foreground": "clPurple",'
          '                "Background": "clWindow"'
          '            },'
          '            {'
          '                "Name": "ReservedWord",'
          '                "Foreground": "clNavy",'
          '                "Background": "clWindow",'
          '                "Style": "Bold"'
          '            },'
          '            {'
          '                "Name": "Symbol",'
          '                "Foreground": "clNavy",'
          '                "Background": "clWindow"'
          '            },'
          '            {'
          '                "Name": "Number",'
          '                "Foreground": "clBlue",'
          '                "Background": "clWindow"'
          '            },'
          '            {'
          '                "Name": "HexNumber",'
          '                "Foreground": "clBlue",'
          '                "Background": "clWindow"'
          '            },'
          '            {'
          '                "Name": "HighlightedBlock",'
          '                "Foreground": "clBlack",'
          '                "Background": "$00EEFFFF"'
          '            },'
          '            {'
          '                "Name": "AssemblerComment",'
          '                "Foreground": "clGreen",'
          '                "Background": "$00EEFFFF",'
          '                "Style": "Italic"'
          '            },'
          '            {'
          '                "Name": "AssemblerReservedWord",'
          '                "Foreground": "clNavy",'
          '                "Background": "$00EEFFFF",'
          '                "Style": "Bold"'
          '            },'
          '            {'
          '                "Name": "Attribute",'
          '                "Foreground": "clMaroon",'
          '                "Background": "clWindow"'
          '            }'
          '        ]'
          '    }'
          '}')
      end>
    Left = 364
    Top = 225
  end
end
