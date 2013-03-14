object LanguageDataModule: TLanguageDataModule
  OldCreateOrder = False
  Height = 390
  Width = 229
  object YesOrNoMultiStringHolder: TBCMultiStringHolder
    MultipleStrings = <
      item
        Name = 'CloseDirectory'
        Strings.Strings = (
          'Close directory %s, are you sure?')
      end
      item
        Name = 'DocumentTimeChanged'
        Strings.Strings = (
          'Document %s'#39#39's time/date changed. Reload?')
      end
      item
        Name = 'RecordMacro'
        Strings.Strings = (
          'Record a new macro, are you sure?')
      end
      item
        Name = 'NewVersion'
        Strings.Strings = (
          
            'A new version %s of %s is available.%sWould you like to download' +
            ' it from the Internet?')
      end
      item
        Name = 'ReplaceOccurence'
        Strings.Strings = (
          'Replace this occurence of '#39#39'%s'#39#39'?')
      end
      item
        Name = 'SaveChanges'
        Strings.Strings = (
          'Save changes?')
      end
      item
        Name = 'SearchMatchNotFound'
        Strings.Strings = (
          
            'Search Match Not Found.%sRestart search from the beginning of th' +
            'e file?')
      end>
    Left = 92
    Top = 22
  end
  object MessageMultiStringHolder: TBCMultiStringHolder
    MultipleStrings = <
      item
        Name = 'LatestVersion'
        Strings.Strings = (
          'You are using the latest version.')
      end
      item
        Name = 'DocumentStatistics'
        Strings.Strings = (
          'Line count: %d%sWord count: %d%sCharacter count: %d')
      end
      item
        Name = 'CannotFindString'
        Strings.Strings = (
          'Cannot find the string '#39#39'%s'#39#39)
      end>
    Left = 90
    Top = 84
  end
  object ErrorMessageMultiStringHolder: TBCMultiStringHolder
    MultipleStrings = <
      item
        Name = 'EnterTabName'
        Strings.Strings = (
          'Enter Tab Name.')
      end>
    Left = 88
    Top = 142
  end
  object WarningMessageMultiStringHolder: TBCMultiStringHolder
    MultipleStrings = <>
    Left = 90
    Top = 202
  end
  object ConstantMultiStringHolder: TBCMultiStringHolder
    MultipleStrings = <
      item
        Name = 'AllFiles'
        Strings.Strings = (
          'All Files')
      end
      item
        Name = 'DownloadCancelling'
        Strings.Strings = (
          'Cancelling...')
      end
      item
        Name = 'DownloadDone'
        Strings.Strings = (
          'Done.')
      end
      item
        Name = 'EditDirectory'
        Strings.Strings = (
          'Edit Directory')
      end
      item
        Name = 'Insert'
        Strings.Strings = (
          'Insert')
      end
      item
        Name = 'InvalidName'
        Strings.Strings = (
          'Error - Invalid Name:')
      end
      item
        Name = 'Minute'
        Strings.Strings = (
          'min')
      end
      item
        Name = 'Modified'
        Strings.Strings = (
          'Modified')
      end
      item
        Name = 'OccurencesFound'
        Strings.Strings = (
          '%d occurence(s) have been found in %s')
      end
      item
        Name = 'Open'
        Strings.Strings = (
          'Open')
      end
      item
        Name = 'OpenDirectory'
        Strings.Strings = (
          'Open Directory')
      end
      item
        Name = 'Overwrite'
        Strings.Strings = (
          'Overwrite')
      end
      item
        Name = 'PreviewDocumentPage'
        Strings.Strings = (
          'Page: $PAGENUM$ of $PAGECOUNT$')
      end
      item
        Name = 'PreviewPage'
        Strings.Strings = (
          ' Page: %d')
      end
      item
        Name = 'PreviewPrintDocument'
        Strings.Strings = (
          'Print (%s)|Print the document on %s')
      end
      item
        Name = 'PrintedBy'
        Strings.Strings = (
          'Printed by %s')
      end
      item
        Name = 'Rename'
        Strings.Strings = (
          'Do you want to rename %s to %s?')
      end
      item
        Name = 'SaveAs'
        Strings.Strings = (
          'Save As')
      end
      item
        Name = 'SearchFor'
        Strings.Strings = (
          'Search for '#39#39'%s'#39#39)
      end
      item
        Name = 'SearchInProgress'
        Strings.Strings = (
          'Search in progress...')
      end
      item
        Name = 'Second'
        Strings.Strings = (
          's')
      end
      item
        Name = 'SelectRootDirectory'
        Strings.Strings = (
          'Select Root Directory')
      end
      item
        Name = 'VersionInfoNotFound'
        Strings.Strings = (
          'Version info not found.')
      end
      item
        Name = 'CompareFiles'
        Strings.Strings = (
          'Compare Files')
      end
      item
        Name = 'Document'
        Strings.Strings = (
          'Document')
      end
      item
        Name = 'InvalidHTMLTag'
        Strings.Strings = (
          'Invalid HTML tag '#39'%s'#39)
      end
      item
        Name = 'InvalidHTMLAttribute'
        Strings.Strings = (
          'Invalid HTML attribute '#39'%s'#39)
      end
      item
        Name = 'InvalidHTMLToken'
        Strings.Strings = (
          'Invalid HTML token '#39'%s'#39)
      end
      item
        Name = 'InvalidCSSSelector'
        Strings.Strings = (
          'Invalid CSS selector '#39'%s'#39)
      end
      item
        Name = 'InvalidCSSProperty'
        Strings.Strings = (
          'Invalid CSS property '#39'%s'#39)
      end
      item
        Name = 'InvalidCSSValue'
        Strings.Strings = (
          'Invalid CSS value '#39'%s'#39)
      end
      item
        Name = 'InvalidCSSToken'
        Strings.Strings = (
          'Invalid CSS token '#39'%s'#39)
      end
      item
        Name = 'InvalidJSToken'
        Strings.Strings = (
          'Invalid JS token '#39'%s'#39)
      end
      item
        Name = 'InvalidPHPToken'
        Strings.Strings = (
          'Invalid PHP token '#39'%s'#39)
      end
      item
        Name = 'SMsgDlgWarning'
        Strings.Strings = (
          'Warning')
      end
      item
        Name = 'SMsgDlgError'
        Strings.Strings = (
          'Error')
      end
      item
        Name = 'SMsgDlgInformation'
        Strings.Strings = (
          'Information')
      end
      item
        Name = 'SMsgDlgConfirm'
        Strings.Strings = (
          'Confirm')
      end
      item
        Name = 'SMsgDlgYes'
        Strings.Strings = (
          '&Yes')
      end
      item
        Name = 'SMsgDlgNo'
        Strings.Strings = (
          '&No')
      end
      item
        Name = 'SMsgDlgOK'
        Strings.Strings = (
          'OK')
      end
      item
        Name = 'SMsgDlgCancel'
        Strings.Strings = (
          'Cancel')
      end
      item
        Name = 'SMsgDlgHelp'
        Strings.Strings = (
          '&Help')
      end
      item
        Name = 'SMsgDlgHelpNone'
        Strings.Strings = (
          'No help available')
      end
      item
        Name = 'SMsgDlgHelpHelp'
        Strings.Strings = (
          'Help')
      end
      item
        Name = 'SMsgDlgAbort'
        Strings.Strings = (
          '&Abort')
      end
      item
        Name = 'SMsgDlgRetry'
        Strings.Strings = (
          '&Retry')
      end
      item
        Name = 'SMsgDlgIgnore'
        Strings.Strings = (
          '&Ignore')
      end
      item
        Name = 'SMsgDlgAll'
        Strings.Strings = (
          '&All')
      end
      item
        Name = 'SMsgDlgNoToAll'
        Strings.Strings = (
          'N&o to All')
      end
      item
        Name = 'SMsgDlgYesToAll'
        Strings.Strings = (
          'Yes to &All')
      end
      item
        Name = 'SMsgDlgClose'
        Strings.Strings = (
          '&Close')
      end
      item
        Name = 'SelectFile'
        Strings.Strings = (
          'Select File')
      end
      item
        Name = 'LanguageEditor'
        Strings.Strings = (
          'Language Editor - [%s]')
      end>
    Left = 88
    Top = 254
  end
  object FileTypesMultiStringHolder: TBCMultiStringHolder
    MultipleStrings = <
      item
        Name = '68HC11'
        Strings.Strings = (
          '68HC11 Assembler Files (*.hc11;*.asc)')
      end
      item
        Name = 'AWK'
        Strings.Strings = (
          'AWK Scripts (*.awk)')
      end
      item
        Name = 'Baan4GL'
        Strings.Strings = (
          'Baan 4GL Files (*.cln)')
      end
      item
        Name = 'CSharp'
        Strings.Strings = (
          'C# Files (*.cs)')
      end
      item
        Name = 'CPP'
        Strings.Strings = (
          'C/C++ Files (*.c;*.cpp;*.h;*.hpp)')
      end
      item
        Name = 'CAClipper'
        Strings.Strings = (
          'CA-Clipper Files (*.prg;*.ch;*.inc)')
      end
      item
        Name = 'Cache'
        Strings.Strings = (
          'Cache Files (*.mac;*.inc;*.int)')
      end
      item
        Name = 'CSS'
        Strings.Strings = (
          'Cascading Stylesheets (*.css)')
      end
      item
        Name = 'COBOL'
        Strings.Strings = (
          'COBOL Files (*.cbl;*.cob)')
      end
      item
        Name = 'CORBA'
        Strings.Strings = (
          'CORBA IDL Files (*.idl)')
      end
      item
        Name = 'CPM'
        Strings.Strings = (
          'CPM Reports (*.rdf;*.rif;*.rmf;*.rxf)')
      end
      item
        Name = 'DOT'
        Strings.Strings = (
          'DOT Graph Drawing Description (*.dot)')
      end
      item
        Name = 'DSP'
        Strings.Strings = (
          'DSP Files (*.dsp;*.inc)')
      end
      item
        Name = 'DWScript'
        Strings.Strings = (
          'DWScript Files (*.dws)')
      end
      item
        Name = 'Eiffel'
        Strings.Strings = (
          'Eiffel (*.e;*.ace)')
      end
      item
        Name = 'Fortran'
        Strings.Strings = (
          'Fortran Files (*.for)')
      end
      item
        Name = 'Foxpro'
        Strings.Strings = (
          'Foxpro Files (*.prg)')
      end
      item
        Name = 'Galaxy'
        Strings.Strings = (
          'Galaxy Files (*.gtv;*.galrep)')
      end
      item
        Name = 'GEMBASE'
        Strings.Strings = (
          'GEMBASE Files (*.dml;*.gem)')
      end
      item
        Name = 'GWTEL'
        Strings.Strings = (
          'GW-TEL Scripts (*.gws)')
      end
      item
        Name = 'Haskell'
        Strings.Strings = (
          'Haskell Files (*.hs;*.lhs)')
      end
      item
        Name = 'HP48'
        Strings.Strings = (
          'HP48 Files (*.s;*.sou;*.a;*.hp)')
      end
      item
        Name = 'HTML'
        Strings.Strings = (
          'HTML Files (*.html;*.htm)')
      end
      item
        Name = 'INI'
        Strings.Strings = (
          'INI Files (*.ini)')
      end
      item
        Name = 'Inno'
        Strings.Strings = (
          'Inno Setup Scripts (*.iss)')
      end
      item
        Name = 'Java'
        Strings.Strings = (
          'Java Files (*.java)')
      end
      item
        Name = 'Javascript'
        Strings.Strings = (
          'Javascript Files (*.js)')
      end
      item
        Name = 'KiXtart'
        Strings.Strings = (
          'KiXtart Scripts (*.kix)')
      end
      item
        Name = 'LEGO'
        Strings.Strings = (
          'LEGO LDraw Files (*.ldr)')
      end
      item
        Name = 'Modelica'
        Strings.Strings = (
          'Modelica Files (*.mo)')
      end
      item
        Name = 'Modula'
        Strings.Strings = (
          'Modula-3 Files (*.m3)')
      end
      item
        Name = 'Msg'
        Strings.Strings = (
          'Msg Files (*.msg)')
      end
      item
        Name = 'MSDOS'
        Strings.Strings = (
          'MS-DOS Batch Files (*.bat;*.cmd)')
      end
      item
        Name = 'Pascal'
        Strings.Strings = (
          'Pascal Files (*.pas;*.dfm;*.dpr;*.dproj)')
      end
      item
        Name = 'Perl'
        Strings.Strings = (
          'Perl Files (*.pl;*.pm;*.cgi)')
      end
      item
        Name = 'PHP'
        Strings.Strings = (
          'PHP Files (*.php;*.class;*.inc)')
      end
      item
        Name = 'Progress'
        Strings.Strings = (
          'Progress Files (*.w;*.p;*.i)')
      end
      item
        Name = 'Python'
        Strings.Strings = (
          'Python Files (*.py)')
      end
      item
        Name = 'Resource'
        Strings.Strings = (
          'Resource Files (*.rc)')
      end
      item
        Name = 'Ruby'
        Strings.Strings = (
          'Ruby Files (*.rb;*.rbw)')
      end
      item
        Name = 'Semanta'
        Strings.Strings = (
          'Semanta DD Files (*.sdd)')
      end
      item
        Name = 'SQL'
        Strings.Strings = (
          'SQL Files (*.sql)')
      end
      item
        Name = 'StandardML'
        Strings.Strings = (
          'Standard ML Files (*.sml)')
      end
      item
        Name = 'StructuredText'
        Strings.Strings = (
          'Structured Text Files (*.st)')
      end
      item
        Name = 'TclTk'
        Strings.Strings = (
          'Tcl/Tk Files (*.tcl)')
      end
      item
        Name = 'TeX'
        Strings.Strings = (
          'TeX Files (*.tex)')
      end
      item
        Name = 'Text'
        Strings.Strings = (
          'Text Files (*.txt)')
      end
      item
        Name = 'UNIX'
        Strings.Strings = (
          'UNIX Shell Scripts (*.sh)')
      end
      item
        Name = 'VB'
        Strings.Strings = (
          'Visual Basic Files (*.vb;*.bas)')
      end
      item
        Name = 'VBScript'
        Strings.Strings = (
          'VBScript Files (*.vbs)')
      end
      item
        Name = 'Vrml'
        Strings.Strings = (
          'Vrml97/X3D World (*.wrl;*.wrml;*.vrl;*.vrml;*.x3d)')
      end
      item
        Name = 'x86'
        Strings.Strings = (
          'x86 Assembly Files (*.asm)')
      end
      item
        Name = 'XML'
        Strings.Strings = (
          'XML Files (*.xml;*.xsd;*.xsl;*.xslt;*.dtd)')
      end
      item
        Name = 'Macro'
        Strings.Strings = (
          'Macro files (*.mcr)|*.mcr')
      end
      item
        Name = 'Zip'
        Strings.Strings = (
          'Zip Files (*.zip)|*.zip')
      end
      item
        Name = 'SQLNet'
        Strings.Strings = (
          'SQL*Net configuration files (*.ora)|*.ora')
      end
      item
        Name = 'Language'
        Strings.Strings = (
          'Language Files (*.lng)|*.lng')
      end>
    Left = 90
    Top = 314
  end
end
