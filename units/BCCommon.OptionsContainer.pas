unit BCCommon.OptionsContainer;

interface

uses
  System.Classes, Vcl.Forms, Vcl.ActnMenus, SynEdit, BCCommon.FileUtils, IniPersist{$ifdef EDITBONE}, Lib, SynHighlighterWebData,
  SynHighlighterWeb, SynHighlighterSQL{$endif};

type
  TOptionsContainer = class(TComponent)
  private
    FAnimationDuration: Integer;
    FAnimationStyle: Integer;
    FAutoIndent: Boolean;
    FAutoSave: Boolean;
    FBeepIfSearchStringNotFound: Boolean;
    FColorBrightness: Integer;
    FCompletionProposalCaseSensitive: Boolean;
    FCompletionProposalEnabled: Boolean;
    FCompletionProposalShortcut: string;
    FEnableLineNumbers: Boolean;
    FEnableSelectionMode: Boolean;
    FEnableSpecialChars: Boolean;
    FEnableWordWrap: Boolean;
    FFontName: string;
    FFontSize: Integer;
    FIgnoreBlanks: Boolean;
    FIgnoreCase: Boolean;
    FInsertCaret: Integer;
    FLineSpacing: Integer;
    FMainMenuFontName: string;
    FMainMenuFontSize: Integer;
    FMainMenuSystemFontName: string;
    FMainMenuSystemFontSize: Integer;
    FMainMenuUseSystemFont: Boolean;
    FMarginFontName: string;
    FMarginFontSize: Integer;
    FMarginInTens: Boolean;
    FMarginLeftMarginAutoSize: Boolean;
    FMarginLeftMarginWidth: Integer;
    FMarginLeftMarginMouseMove: Boolean;
    FMarginLineModified: Boolean;
    FMarginModifiedColor: string;
    FMarginNormalColor: string;
    FMarginRightMargin: Integer;
    FMarginShowBookmarks: Boolean;
    FMarginShowBookmarkPanel: Boolean;
    FMarginVisibleLeftMargin: Boolean;
    FMarginVisibleRightMargin: Boolean;
    FMarginZeroStart: Boolean;
    FMinimapFontName: string;
    FMinimapFontSize: Integer;
    FMinimapWidth: Integer;
    FNonblinkingCaret: Boolean;
    FNonblinkingCaretColor: string;
    FOutputIndent: Integer;
    FOutputShowTreeLines: Boolean;
    FPersistentHotKeys: Boolean;
    FPrintDateTime: Integer;
    FPrintDocumentName: Integer;
    FPrintPageNumber: Integer;
    FPrintPrintedBy: Integer;
    FPrintShowFooterLine: Boolean;
    FPrintShowHeaderLine: Boolean;
    FPrintShowLineNumbers: Boolean;
    FPrintWordWrapLine: Boolean;
    FScrollPastEof: Boolean;
    FScrollPastEol: Boolean;
    FShowScrollHint: Boolean;
    FShadows: Boolean;
    FShowSearchStringNotFound: Boolean;
    FSmartTabDelete: Boolean;
    FSmartTabs: Boolean;
    FStatusBarFontName: string;
    FStatusBarFontSize: Integer;
    FStatusBarUseSystemFont: Boolean;
    FTabsToSpaces: Boolean;
    FTabWidth: Integer;
    FToolBarCase: Boolean;
    FToolBarCommand: Boolean;
    FToolBarIndent: Boolean;
    FToolBarMode: Boolean;
    FToolBarPrint: Boolean;
    FToolBarSearch: Boolean;
    FToolBarSort: Boolean;
    FToolBarStandard: Boolean;
    FToolBarTools: Boolean;
    FTrimTrailingSpaces: Boolean;
    FTripleClickRowSelect: Boolean;
    FUndoAfterSave: Boolean;
  public
    destructor Destroy; override;
    procedure AssignTo(Dest: TPersistent); override;
    procedure ReadIniFile; virtual;
    procedure WriteIniFile; virtual;
  published
    [IniValue('Options', 'AnimationDuration', '150')]
    property AnimationDuration: Integer read FAnimationDuration write FAnimationDuration;
    [IniValue('Options', 'AnimationStyle', '1')]
    property AnimationStyle: Integer read FAnimationStyle write FAnimationStyle;
    [IniValue('Options', 'AutoIndent', True)]
    property AutoIndent: Boolean read FAutoIndent write FAutoIndent;
    [IniValue('Options', 'AutoSave', False)]
    property AutoSave: Boolean read FAutoSave write FAutoSave;
    [IniValue('Options', 'BeepIfSearchStringNotFound', True)]
    property BeepIfSearchStringNotFound: Boolean read FBeepIfSearchStringNotFound write FBeepIfSearchStringNotFound;
    [IniValue('Options', 'ActiveLineColorBrightness', '2')]
    property ColorBrightness: Integer read FColorBrightness write FColorBrightness;
    [IniValue('Options', 'CompletionProposalCaseSensitive', True)]
    property CompletionProposalCaseSensitive: Boolean read FCompletionProposalCaseSensitive write FCompletionProposalCaseSensitive;
    [IniValue('Options', 'CompletionProposalEnabled', True)]
    property CompletionProposalEnabled: Boolean read FCompletionProposalEnabled write FCompletionProposalEnabled;
    [IniValue('Options', 'CompletionProposalShortcut', 'Ctrl+Space')]
    property CompletionProposalShortcut: string read FCompletionProposalShortcut write FCompletionProposalShortcut;
    [IniValue('Options', 'EnableLineNumbers', True)]
    property EnableLineNumbers: Boolean read FEnableLineNumbers write FEnableLineNumbers;
    [IniValue('Options', 'EnableSelectionMode', False)]
    property EnableSelectionMode: Boolean read FEnableSelectionMode write FEnableSelectionMode;
    [IniValue('Options', 'EnableSpecialChars', False)]
    property EnableSpecialChars: Boolean read FEnableSpecialChars write FEnableSpecialChars;
    [IniValue('Options', 'EnableWordWrap', False)]
    property EnableWordWrap: Boolean read FEnableWordWrap write FEnableWordWrap;
    [IniValue('Options', 'FontName', 'Courier New')]
    property FontName: string read FFontName write FFontName;
    [IniValue('Options', 'FontSize', '9')]
    property FontSize: Integer read FFontSize write FFontSize;
    [IniValue('Options', 'IgnoreBlanks', True)]
    property IgnoreBlanks: Boolean read FIgnoreBlanks write FIgnoreBlanks;
    [IniValue('Options', 'IgnoreCase', True)]
    property IgnoreCase: Boolean read FIgnoreCase write FIgnoreCase;
    [IniValue('Options', 'InsertCaret', '0')]
    property InsertCaret: Integer read FInsertCaret write FInsertCaret;
    [IniValue('Options', 'LineSpacing', '0')]
    property LineSpacing: Integer read FLineSpacing write FLineSpacing;
    [IniValue('Options', 'MainMenuFontName', 'Tahoma')]
    property MainMenuFontName: string read FMainMenuFontName write FMainMenuFontName;
    [IniValue('Options', 'MainMenuFontSize', '8')]
    property MainMenuFontSize: Integer read FMainMenuFontSize write FMainMenuFontSize;
    property MainMenuSystemFontName: string read FMainMenuSystemFontName write FMainMenuSystemFontName;
    property MainMenuSystemFontSize: Integer read FMainMenuSystemFontSize write FMainMenuSystemFontSize;
    [IniValue('Options', 'MainMenuUseSystemFont', False)]
    property MainMenuUseSystemFont: Boolean read FMainMenuUseSystemFont write FMainMenuUseSystemFont;
    [IniValue('Options', 'MarginFontName', 'Courier New')]
    property MarginFontName: string read FMarginFontName write FMarginFontName;
    [IniValue('Options', 'MarginFontSize', '9')]
    property MarginFontSize: Integer read FMarginFontSize write FMarginFontSize;
    [IniValue('Options', 'MarginInTens', True)]
    property MarginInTens: Boolean read FMarginInTens write FMarginInTens;
    [IniValue('Options', 'MarginLeftMarginAutoSize', True)]
    property MarginLeftMarginAutoSize: Boolean read FMarginLeftMarginAutoSize write FMarginLeftMarginAutoSize;
    [IniValue('Options', 'MarginLeftMarginWidth', '57')]
    property MarginLeftMarginWidth: Integer read FMarginLeftMarginWidth write FMarginLeftMarginWidth;
    [IniValue('Options', 'MarginLeftMarginMouseMove', True)]
    property MarginLeftMarginMouseMove: Boolean read FMarginLeftMarginMouseMove write FMarginLeftMarginMouseMove;
    [IniValue('Options', 'MarginLineModified', True)]
    property MarginLineModified: Boolean read FMarginLineModified write FMarginLineModified;
    [IniValue('Options', 'MarginModifiedColor', 'clYellow')]
    property MarginModifiedColor: string read FMarginModifiedColor write FMarginModifiedColor;
    [IniValue('Options', 'MarginNormalColor', 'clGreen')]
    property MarginNormalColor: string read FMarginNormalColor write FMarginNormalColor;
    [IniValue('Options', 'RightMargin', '80')]
    property MarginRightMargin: Integer read FMarginRightMargin write FMarginRightMargin;
    [IniValue('Options', 'MarginShowBookmarks', True)]
    property MarginShowBookmarks: Boolean read FMarginShowBookmarks write FMarginShowBookmarks;
    [IniValue('Options', 'MarginShowBookmarkPanel', True)]
    property MarginShowBookmarkPanel: Boolean read FMarginShowBookmarkPanel write FMarginShowBookmarkPanel;
    [IniValue('Options', 'MarginVisibleLeftMargin', True)]
    property MarginVisibleLeftMargin: Boolean read FMarginVisibleLeftMargin write FMarginVisibleLeftMargin;
    [IniValue('Options', 'MarginVisibleRightMargin', True)]
    property MarginVisibleRightMargin: Boolean read FMarginVisibleRightMargin write FMarginVisibleRightMargin;
    [IniValue('Options', 'MarginZeroStart', False)]
    property MarginZeroStart: Boolean read FMarginZeroStart write FMarginZeroStart;
    [IniValue('Options', 'MinimapFontName', 'Courier New')]
    property MinimapFontName: string read FMinimapFontName write FMinimapFontName;
    [IniValue('Options', 'MinimapFontSize', '1')]
    property MinimapFontSize: Integer read FMinimapFontSize write FMinimapFontSize;
    [IniValue('Options', 'MinimapWidth', '100')]
    property MinimapWidth: Integer read FMinimapWidth write FMinimapWidth;
    [IniValue('Options', 'NonblinkingCaret', False)]
    property NonblinkingCaret: Boolean read FNonblinkingCaret write FNonblinkingCaret;
    [IniValue('Options', 'NonblinkingCaretColor', 'clBlack')]
    property NonblinkingCaretColor: string read FNonblinkingCaretColor write FNonblinkingCaretColor;
    [IniValue('Options', 'OutputIndent', '20')]
    property OutputIndent: Integer read FOutputIndent write FOutputIndent;
    [IniValue('Options', 'OutputShowTreeLines', False)]
    property OutputShowTreeLines: Boolean read FOutputShowTreeLines write FOutputShowTreeLines ;
    [IniValue('Options', 'PersistentHotKeys', False)]
    property PersistentHotKeys: Boolean read FPersistentHotKeys write FPersistentHotKeys;
    [IniValue('Options', 'PrintDateTime', '1')]
    property PrintDateTime: Integer read FPrintDateTime write FPrintDateTime;
    [IniValue('Options', 'PrintDocumentName', '2')]
    property PrintDocumentName: Integer read FPrintDocumentName write FPrintDocumentName;
    [IniValue('Options', 'PrintPageNumber', '3')]
    property PrintPageNumber: Integer read FPrintPageNumber write FPrintPageNumber;
    [IniValue('Options', 'PrintPrintedBy', '0')]
    property PrintPrintedBy: Integer read FPrintPrintedBy write FPrintPrintedBy;
    [IniValue('Options', 'PrintShowFooterLine', True)]
    property PrintShowFooterLine: Boolean read FPrintShowFooterLine write FPrintShowFooterLine;
    [IniValue('Options', 'PrintShowHeaderLine', True)]
    property PrintShowHeaderLine: Boolean read FPrintShowHeaderLine write FPrintShowHeaderLine;
    [IniValue('Options', 'PrintShowLineNumbers', False)]
    property PrintShowLineNumbers: Boolean read FPrintShowLineNumbers write FPrintShowLineNumbers;
    [IniValue('Options', 'PrintWordWrapLine', False)]
    property PrintWordWrapLine: Boolean read FPrintWordWrapLine write FPrintWordWrapLine;
    [IniValue('Options', 'ScrollPastEof', False)]
    property ScrollPastEof: Boolean read FScrollPastEof write FScrollPastEof;
    [IniValue('Options', 'ScrollPastEol', True)]
    property ScrollPastEol: Boolean read FScrollPastEol write FScrollPastEol;
    [IniValue('Options', 'Shadows', True)]
    property Shadows: Boolean read FShadows write FShadows;
    [IniValue('Options', 'ShowScrollHint', True)]
    property ShowScrollHint: Boolean read FShowScrollHint write FShowScrollHint;
    [IniValue('Options', 'ShowSearchStringNotFound', True)]
    property ShowSearchStringNotFound: Boolean read FShowSearchStringNotFound write FShowSearchStringNotFound;
    [IniValue('Options', 'SmartTabDelete', False)]
    property SmartTabDelete: Boolean read FSmartTabDelete write FSmartTabDelete;
    [IniValue('Options', 'SmartTabs', False)]
    property SmartTabs: Boolean read FSmartTabs write FSmartTabs;
    [IniValue('Options', 'StatusBarFontName', 'Tahoma')]
    property StatusBarFontName: string read FStatusBarFontName write FStatusBarFontName;
    [IniValue('Options', 'StatusBarFontSize', '8')]
    property StatusBarFontSize: Integer read FStatusBarFontSize write FStatusBarFontSize;
    [IniValue('Options', 'StatusBarUseSystemFont', False)]
    property StatusBarUseSystemFont: Boolean read FStatusBarUseSystemFont write FStatusBarUseSystemFont;
    [IniValue('Options', 'TabsToSpaces', True)]
    property TabsToSpaces: Boolean read FTabsToSpaces write FTabsToSpaces;
    [IniValue('Options', 'TabWidth', '2')]
    property TabWidth: Integer read FTabWidth write FTabWidth;
    [IniValue('ActionToolBar', 'Case', True)]
    property ToolBarCase: Boolean read FToolBarCase write FToolBarCase;
    [IniValue('ActionToolBar', 'Command', True)]
    property ToolBarCommand: Boolean read FToolBarCommand write FToolBarCommand;
    [IniValue('ActionToolBar', 'Print', True)]
    property ToolBarPrint: Boolean read FToolBarPrint write FToolBarPrint;
    [IniValue('ActionToolBar', 'Indent', True)]
    property ToolBarIndent: Boolean read FToolBarIndent write FToolBarIndent;
    [IniValue('ActionToolBar', 'Standard', True)]
    property ToolBarStandard: Boolean read FToolBarStandard write FToolBarStandard;
    [IniValue('ActionToolBar', 'Mode', True)]
    property ToolBarMode: Boolean read FToolBarMode write FToolBarMode;
    [IniValue('ActionToolBar', 'Search', True)]
    property ToolBarSearch: Boolean read FToolBarSearch write FToolBarSearch;
    [IniValue('ActionToolBar', 'Sort', True)]
    property ToolBarSort: Boolean read FToolBarSort write FToolBarSort;
    [IniValue('ActionToolBar', 'Tools', True)]
    property ToolBarTools: Boolean read FToolBarTools write FToolBarTools;
    [IniValue('Options', 'TrimTrailingSpaces', True)]
    property TrimTrailingSpaces: Boolean read FTrimTrailingSpaces write FTrimTrailingSpaces;
    [IniValue('Options', 'TripleClickRowSelect', True)]
    property TripleClickRowSelect: Boolean read FTripleClickRowSelect write FTripleClickRowSelect;
    [IniValue('Options', 'UnfoAfterSave', False)]
    property UndoAfterSave: Boolean read FUndoAfterSave write FUndoAfterSave;
  end;

  {$ifdef ORABONE}
  TOraBoneOptionsContainer = class(TOptionsContainer)
  private
    FConnectionCloseTabByDblClick: Boolean;
    FConnectionCloseTabByMiddleClick: Boolean;
    FConnectionDoubleBuffered: Boolean;
    FConnectionMultiLine: Boolean;
    FConnectionRightClickSelect: Boolean;
    FConnectionShowCloseButton: Boolean;
    FConnectionShowImage: Boolean;
    FDateFormat: string;
    FEditorCloseTabByDblClick: Boolean;
    FEditorCloseTabByMiddleClick: Boolean;
    FEditorDoubleBuffered: Boolean;
    FEditorMultiLine: Boolean;
    FEditorRightClickSelect: Boolean;
    FEditorShowCloseButton: Boolean;
    FEditorShowImage: Boolean;
    FFilterOnTyping: Boolean;
    FObjectFrameAlign: string;
    FOutputCloseTabByDblClick: Boolean;
    FOutputCloseTabByMiddleClick: Boolean;
    FOutputDoubleBuffered: Boolean;
    FOutputMultiLine: Boolean;
    FOutputRightClickSelect: Boolean;
    FOutputShowCloseButton: Boolean;
    FOutputShowImage: Boolean;
    FPollingInterval: Integer;
    FSchemaBrowserAlign: string;
    FSchemaBrowserIndent: Integer;
    FSchemaBrowserShowTreeLines: Boolean;
    FShowDataSearchPanel: Boolean;
    FShowObjectCreationAndModificationTimestamp: Boolean;
    FTimeFormat: string;
    FToolBarDBMS: Boolean;
    FToolBarExecute: Boolean;
    FToolBarExplainPlan: Boolean;
    FToolBarTransaction: Boolean;
  public
    procedure WriteIniFile; override;
  published
    [IniValue('Options', 'ConnectionCloseTabByDblClick', False)]
    property ConnectionCloseTabByDblClick: Boolean read FConnectionCloseTabByDblClick write FConnectionCloseTabByDblClick;
    [IniValue('Options', 'ConnectionCloseTabByMiddleClick', False)]
    property ConnectionCloseTabByMiddleClick: Boolean read FConnectionCloseTabByMiddleClick write FConnectionCloseTabByMiddleClick;
    [IniValue('Options', 'ConnectionDoubleBuffered', True)]
    property ConnectionDoubleBuffered: Boolean read FConnectionDoubleBuffered write FConnectionDoubleBuffered;
    [IniValue('Options', 'ConnectionMultiLine', False)]
    property ConnectionMultiLine: Boolean read FConnectionMultiLine write FConnectionMultiLine;
    [IniValue('Options', 'ConnectionRightClickSelect', True)]
    property ConnectionRightClickSelect: Boolean read FConnectionRightClickSelect write FConnectionRightClickSelect;
    [IniValue('Options', 'ConnectionShowCloseButton', False)]
    property ConnectionShowCloseButton: Boolean read FConnectionShowCloseButton write FConnectionShowCloseButton;
    [IniValue('Options', 'ConnectionShowImage', True)]
    property ConnectionShowImage: Boolean read FConnectionShowImage write FConnectionShowImage;
    [IniValue('Options', 'DateFormat', 'DD.MM.YYYY')]
    property DateFormat: string read FDateFormat write FDateFormat;
    [IniValue('Options', 'EditorCloseTabByDblClick', False)]
    property EditorCloseTabByDblClick: Boolean read FEditorCloseTabByDblClick write FEditorCloseTabByDblClick;
    [IniValue('Options', 'EditorCloseTabByMiddleClick', False)]
    property EditorCloseTabByMiddleClick: Boolean read FEditorCloseTabByMiddleClick write FEditorCloseTabByMiddleClick;
    [IniValue('Options', 'EditorDoubleBuffered', True)]
    property EditorDoubleBuffered: Boolean read FEditorDoubleBuffered write FEditorDoubleBuffered;
    [IniValue('Options', 'EditorMultiLine', False)]
    property EditorMultiLine: Boolean read FEditorMultiLine write FEditorMultiLine;
    [IniValue('Options', 'EditorRightClickSelect', True)]
    property EditorRightClickSelect: Boolean read FEditorRightClickSelect write FEditorRightClickSelect;
    [IniValue('Options', 'EditorShowCloseButton', False)]
    property EditorShowCloseButton: Boolean read FEditorShowCloseButton write FEditorShowCloseButton;
    [IniValue('Options', 'EditorShowImage', True)]
    property EditorShowImage: Boolean read FEditorShowImage write FEditorShowImage;
    [IniValue('Options', 'FilterOnTyping', True)]
    property FilterOnTyping: Boolean read FFilterOnTyping write FFilterOnTyping;
    [IniValue('Options', 'ObjectFrameAlign', 'Bottom')]
    property ObjectFrameAlign: string read FObjectFrameAlign write FObjectFrameAlign;
    [IniValue('Options', 'OutputCloseTabByDblClick', False)]
    property OutputCloseTabByDblClick: Boolean read FOutputCloseTabByDblClick write FOutputCloseTabByDblClick;
    [IniValue('Options', 'OutputCloseTabByMiddleClick', False)]
    property OutputCloseTabByMiddleClick: Boolean read FOutputCloseTabByMiddleClick write FOutputCloseTabByMiddleClick;
    [IniValue('Options', 'OutputDoubleBuffered', True)]
    property OutputDoubleBuffered: Boolean read FOutputDoubleBuffered write FOutputDoubleBuffered;
    [IniValue('Options', 'OutputMultiLine', False)]
    property OutputMultiLine: Boolean read FOutputMultiLine write FOutputMultiLine;
    [IniValue('Options', 'OutputRightClickSelect', True)]
    property OutputRightClickSelect: Boolean read FOutputRightClickSelect write FOutputRightClickSelect;
    [IniValue('Options', 'OutputShowCloseButton', False)]
    property OutputShowCloseButton: Boolean read FOutputShowCloseButton write FOutputShowCloseButton;
    [IniValue('Options', 'OutputShowImage', True)]
    property OutputShowImage: Boolean read FOutputShowImage write FOutputShowImage;
    [IniValue('Options', 'PollingInterval', '1')]
    property PollingInterval: Integer read FPollingInterval write FPollingInterval;
    [IniValue('Options', 'SchemaBrowserAlign', 'Bottom')]
    property SchemaBrowserAlign: string read FSchemaBrowserAlign write FSchemaBrowserAlign;
    [IniValue('Options', 'SchemaBrowserIndent', '16')]
    property SchemaBrowserIndent: Integer read FSchemaBrowserIndent write FSchemaBrowserIndent;
    [IniValue('Options', 'SchemaBrowserShowTreeLines', False)]
    property SchemaBrowserShowTreeLines: Boolean read FSchemaBrowserShowTreeLines write FSchemaBrowserShowTreeLines;
    [IniValue('Options', 'ShowDataSearchPanel', True)]
    property ShowDataSearchPanel: Boolean read FShowDataSearchPanel write FShowDataSearchPanel;
    [IniValue('Options', 'ShowObjectCreationAndModificationTimestamp', False)]
    property ShowObjectCreationAndModificationTimestamp: Boolean read FShowObjectCreationAndModificationTimestamp write FShowObjectCreationAndModificationTimestamp;
    [IniValue('Options', 'TimeFormat', 'HH24:MI:SS')]
    property TimeFormat: string read FTimeFormat write FTimeFormat;
    [IniValue('Options', 'ToolBarDBMS', True)]
    property ToolBarDBMS: Boolean read FToolBarDBMS write FToolBarDBMS;
    [IniValue('Options', 'ToolBarExecute', True)]
    property ToolBarExecute: Boolean read FToolBarExecute write FToolBarExecute;
    [IniValue('Options', 'ToolBarExplainPlan', True)]
    property ToolBarExplainPlan: Boolean read FToolBarExplainPlan write FToolBarExplainPlan;
    [IniValue('Options', 'ToolBarTransaction', True)]
    property ToolBarTransaction: Boolean read FToolBarTransaction write FToolBarTransaction;
  end;

  function OptionsContainer: TOraBoneOptionsContainer;
  {$endif}

  {$ifdef EDITBONE}
  TEditBoneOptionsContainer = class(TOptionsContainer)
  private
    FCPASHighlighter: Integer;
    FCSSVersion: Integer;
    FDefaultEncoding: Integer;
    FDefaultHighlighter: Integer;
    FDirCloseTabByDblClick: Boolean;
    FDirCloseTabByMiddleClick: Boolean;
    FDirDoubleBuffered: Boolean;
    FDirIndent: Integer;
    FDirMultiLine: Boolean;
    FDirRightClickSelect: Boolean;
    FDirSaveTabs: Boolean;
    FDirShowArchiveFiles: Boolean;
    FDirShowCloseButton: Boolean;
    FDirShowHiddenFiles: Boolean;
    FDirShowImage: Boolean;
    FDirShowSystemFiles: Boolean;
    FDirShowTreeLines: Boolean;
    FDocCloseTabByDblClick: Boolean;
    FDocCloseTabByMiddleClick: Boolean;
    FDocDoubleBuffered: Boolean;
    FDocMultiLine: Boolean;
    FDocRightClickSelect: Boolean;
    FDocSaveTabs: Boolean;
    FDocShowCloseButton: Boolean;
    FDocShowImage: Boolean;
    FFileTypes: TStrings;
    FHTMLErrorChecking: Boolean;
    FHTMLVersion: Integer;
    FOutputCloseTabByDblClick: Boolean;
    FOutputCloseTabByMiddleClick: Boolean;
    FOutputDoubleBuffered: Boolean;
    FOutputMultiLine: Boolean;
    FOutputRightClickSelect: Boolean;
    FOutputSaveTabs: Boolean;
    FOutputShowCloseButton: Boolean;
    FOutputShowImage: Boolean;
    FPHPVersion: Integer;
    FShowXMLTree: Boolean;
    FSQLDialect: Integer;
    FSupportedFileExts: string;
    FToolBarDirectory: Boolean;
    FToolBarDocument: Boolean;
    FToolBarMacro: Boolean;
    FToolBarVisible: Boolean;
    function GetExtensions: string;
    function GetFilterCount: Cardinal;
    function GetFilters: string;
  public
    constructor Create(AOwner: TComponent); override;
    function FileType(FileType: TFileType): string;
    function GetFilterExt(FilterIndex: Cardinal): string;
    function GetFilterIndex(FileExt: string): Cardinal;
    function SupportedFileExts(Refresh: Boolean = False): string;
    procedure AssignTo(Dest: TPersistent); override;
    procedure ReadIniFile; override;
  published
    [IniValue('Options', 'CPASHighlighter', '0')]
    property CPASHighlighter: Integer read FCPASHighlighter write FCPASHighlighter;
    [IniValue('Options', 'CSSVersion', '2')]
    property CSSVersion: Integer read FCSSVersion write FCSSVersion;
    [IniValue('Options', 'DefaultEncoding', '1')]
    property DefaultEncoding: Integer read FDefaultEncoding write FDefaultEncoding;
    [IniValue('Options', 'DefaultHighlighter', '52')]
    property DefaultHighlighter: Integer read FDefaultHighlighter write FDefaultHighlighter;
    [IniValue('Options', 'DirCloseTabByDblClick', False)]
    property DirCloseTabByDblClick: Boolean read FDirCloseTabByDblClick write FDirCloseTabByDblClick;
    [IniValue('Options', 'DirCloseTabByMiddleClick', False)]
    property DirCloseTabByMiddleClick: Boolean read FDirCloseTabByMiddleClick write FDirCloseTabByMiddleClick;
    [IniValue('Options', 'DirDoubleBuffered', True)]
    property DirDoubleBuffered: Boolean read FDirDoubleBuffered write FDirDoubleBuffered;
    [IniValue('Options', 'DirIndent', '20')]
    property DirIndent: Integer read FDirIndent write FDirIndent;
    [IniValue('Options', 'DirMultiLine', False)]
    property DirMultiLine: Boolean read FDirMultiLine write FDirMultiLine;
    [IniValue('Options', 'DirRightClickSelect', True)]
    property DirRightClickSelect: Boolean read FDirRightClickSelect write FDirRightClickSelect;
    [IniValue('Options', 'DirSaveTabs', True)]
    property DirSaveTabs: Boolean read FDirSaveTabs write FDirSaveTabs;
    [IniValue('Options', 'DirShowArchiveFiles', True)]
    property DirShowArchiveFiles: Boolean read FDirShowArchiveFiles write FDirShowArchiveFiles;
    [IniValue('Options', 'DirShowCloseButton', False)]
    property DirShowCloseButton: Boolean read FDirShowCloseButton write FDirShowCloseButton;
    [IniValue('Options', 'DirShowHiddenFiles', False)]
    property DirShowHiddenFiles: Boolean read FDirShowHiddenFiles write FDirShowHiddenFiles;
    [IniValue('Options', 'DirShowImage', True)]
    property DirShowImage: Boolean read FDirShowImage write FDirShowImage;
    [IniValue('Options', 'DirShowSystemFiles', False)]
    property DirShowSystemFiles: Boolean read FDirShowSystemFiles write FDirShowSystemFiles;
    [IniValue('Options', 'DirShowTreeLines', False)]
    property DirShowTreeLines: Boolean read FDirShowTreeLines write FDirShowTreeLines;
    [IniValue('Options', 'DocCloseTabByDblClick', False)]
    property DocCloseTabByDblClick: Boolean read FDocCloseTabByDblClick write FDocCloseTabByDblClick;
    [IniValue('Options', 'DocCloseTabByMiddleClick', False)]
    property DocCloseTabByMiddleClick: Boolean read FDocCloseTabByMiddleClick write FDocCloseTabByMiddleClick;
    [IniValue('Options', 'DocDoubleBuffered', True)]
    property DocDoubleBuffered: Boolean read FDocDoubleBuffered write FDocDoubleBuffered;
    [IniValue('Options', 'DocMultiLine', False)]
    property DocMultiLine: Boolean read FDocMultiLine write FDocMultiLine;
    [IniValue('Options', 'DocRightClickSelect', True)]
    property DocRightClickSelect: Boolean read FDocRightClickSelect write FDocRightClickSelect;
    [IniValue('Options', 'DocSaveTabs', True)]
    property DocSaveTabs: Boolean read FDocSaveTabs write FDocSaveTabs;
    [IniValue('Options', 'DocShowCloseButton', False)]
    property DocShowCloseButton: Boolean read FDocShowCloseButton write FDocShowCloseButton;
    [IniValue('Options', 'DocShowImage', True)]
    property DocShowImage: Boolean read FDocShowImage write FDocShowImage;
    property Extensions: string read GetExtensions;
    property FileTypes: TStrings read FFileTypes write FFileTypes;
    property FilterCount: Cardinal read GetFilterCount;
    property Filters: string read GetFilters;
    [IniValue('Options', 'HTMLErrorChecking', True)]
    property HTMLErrorChecking: Boolean read FHTMLErrorChecking write FHTMLErrorChecking;
    [IniValue('Options', 'HTMLVersion', '4')]
    property HTMLVersion: Integer read FHTMLVersion write FHTMLVersion;
    [IniValue('Options', 'OutputCloseTabByDblClick', False)]
    property OutputCloseTabByDblClick: Boolean read FOutputCloseTabByDblClick write FOutputCloseTabByDblClick;
    [IniValue('Options', 'OutputCloseTabByMiddleClick', False)]
    property OutputCloseTabByMiddleClick: Boolean read FOutputCloseTabByMiddleClick write FOutputCloseTabByMiddleClick;
    [IniValue('Options', 'OutputDoubleBuffered', True)]
    property OutputDoubleBuffered: Boolean read FOutputDoubleBuffered write FOutputDoubleBuffered;
    [IniValue('Options', 'OutputMultiLine', False)]
    property OutputMultiLine: Boolean read FOutputMultiLine write FOutputMultiLine;
    [IniValue('Options', 'OutputRightClickSelect', True)]
    property OutputRightClickSelect: Boolean read FOutputRightClickSelect write FOutputRightClickSelect;
    [IniValue('Options', 'OutputSaveTabs', True)]
    property OutputSaveTabs: Boolean read FOutputSaveTabs write FOutputSaveTabs;
    [IniValue('Options', 'OutputShowCloseButton', False)]
    property OutputShowCloseButton: Boolean read FOutputShowCloseButton write FOutputShowCloseButton;
    [IniValue('Options', 'OutputShowImage', True)]
    property OutputShowImage: Boolean read FOutputShowImage write FOutputShowImage;
    [IniValue('Options', 'PHPVersion', '1')]
    property PHPVersion: Integer read FPHPVersion write FPHPVersion;
    [IniValue('Options', 'ShowXMLTree', True)]
    property ShowXMLTree: Boolean read FShowXMLTree write FShowXMLTree;
    [IniValue('Options', 'SQLDialect', '0')]
    property SQLDialect: Integer read FSQLDialect write FSQLDialect;
    [IniValue('ActionToolBar', 'Directory', True)]
    property ToolBarDirectory: Boolean read FToolBarDirectory write FToolBarDirectory;
    [IniValue('ActionToolBar', 'Document', True)]
    property ToolBarDocument: Boolean read FToolBarDocument write FToolBarDocument;
    [IniValue('ActionToolBar', 'Macro', True)]
    property ToolBarMacro: Boolean read FToolBarMacro write FToolBarMacro;
    [IniValue('Options', 'ToolBarVisible', True)]
    property ToolBarVisible: Boolean read FToolBarVisible write FToolBarVisible;
  end;

  function OptionsContainer: TEditBoneOptionsContainer;
  {$endif}

implementation

uses
  System.SysUtils, Vcl.ComCtrls, Vcl.Graphics, Vcl.Menus, SynEditTypes, SynCompletionProposal,
  BCCommon.StringUtils, BCCommon.LanguageStrings, BigIni;

{$ifdef ORABONE}
var
  FOptionsContainer: TOraBoneOptionsContainer;

function OptionsContainer: TOraBoneOptionsContainer;
begin
  if not Assigned(FOptionsContainer) then
    FOptionsContainer := TOraBoneOptionsContainer.Create(nil);
  Result := FOptionsContainer;
end;
{$endif}
{$ifdef EDITBONE}
var
  FOptionsContainer: TEditBoneOptionsContainer;

function OptionsContainer: TEditBoneOptionsContainer;
begin
  if not Assigned(FOptionsContainer) then
    FOptionsContainer := TEditBoneOptionsContainer.Create(nil);
  Result := FOptionsContainer;
end;
{$endif}

procedure TOptionsContainer.ReadIniFile;
begin
  TIniPersist.Load(GetIniFilename, Self);

  with TBigIniFile.Create(GetIniFilename) do
  try
    { OS-dependent options }
    FMainMenuSystemFontName := ReadString('Options', 'MainMenuSystemFontName', Screen.MenuFont.Name);
    FMainMenuSystemFontSize := StrToInt(ReadString('Options', 'MainMenuSystemFontSize', IntToStr(Screen.MenuFont.Size)));
  finally
    Free;
  end;
end;

procedure TOptionsContainer.WriteIniFile;
begin
  with TBigIniFile.Create(GetIniFilename) do
  try
    { deprecated options }
    DeleteKey('Options', 'ExtraLineSpacing');
    DeleteKey('Options', 'MarginAutoSize');
    DeleteKey('Options', 'MarginWidth');
    DeleteKey('Options', 'MarginVisible');
    DeleteKey('Options', 'MinimapFontFactor');
    DeleteKey('Options', 'UseSystemFont');
  finally
    Free;
  end;

  TIniPersist.Save(GetIniFilename, Self);
end;

procedure TOptionsContainer.AssignTo(Dest: TPersistent);
begin
  if Assigned(Dest) and (Dest is TCustomSynEdit) then
  begin
    TCustomSynEdit(Dest).Font.Name := FFontName;
    TCustomSynEdit(Dest).Font.Size := FFontSize;
    TCustomSynEdit(Dest).Gutter.Visible := FMarginVisibleLeftMargin;
    TCustomSynEdit(Dest).Gutter.Font.Name := FMarginFontName;
    TCustomSynEdit(Dest).Gutter.Font.Size := FMarginFontSize;
    TCustomSynEdit(Dest).LineSpacing := FLineSpacing;
    TCustomSynEdit(Dest).RightEdge.Visible := FMarginVisibleRightMargin;
    TCustomSynEdit(Dest).Gutter.AutoSize := FMarginLeftMarginAutoSize;
    TCustomSynEdit(Dest).Gutter.Width := FMarginLeftMarginWidth;
    TCustomSynEdit(Dest).Gutter.Intens := FMarginInTens;
    TCustomSynEdit(Dest).Gutter.ZeroStart := FMarginZeroStart;
    TCustomSynEdit(Dest).Gutter.ShowLineModified := FMarginLineModified;
    TCustomSynEdit(Dest).Gutter.ShowBookmarks := FMarginShowBookmarks;
    TCustomSynEdit(Dest).Gutter.ShowBookmarkPanel := FMarginShowBookmarkPanel;
    TCustomSynEdit(Dest).Gutter.LineModifiedColor := StringToColor(FMarginModifiedColor);
    TCustomSynEdit(Dest).Gutter.LineNormalColor := StringToColor(FMarginNormalColor);
    TCustomSynEdit(Dest).TabWidth := FTabWidth;
    TCustomSynEdit(Dest).InsertCaret := TSynEditCaretType(FInsertCaret);
    TCustomSynEdit(Dest).NonBlinkingCaretColor := StringToColor(FNonblinkingCaretColor);
    if FAutoIndent then
      TCustomSynEdit(Dest).Options := TCustomSynEdit(Dest).Options + [eoAutoIndent]
    else
      TCustomSynEdit(Dest).Options := TCustomSynEdit(Dest).Options - [eoAutoIndent];
    if FScrollPastEof then
      TCustomSynEdit(Dest).Options := TCustomSynEdit(Dest).Options + [eoScrollPastEof]
    else
      TCustomSynEdit(Dest).Options := TCustomSynEdit(Dest).Options - [eoScrollPastEof];
    if FScrollPastEol then
      TCustomSynEdit(Dest).Options := TCustomSynEdit(Dest).Options + [eoScrollPastEol]
    else
      TCustomSynEdit(Dest).Options := TCustomSynEdit(Dest).Options - [eoScrollPastEol];
    if FShowScrollHint then
      TCustomSynEdit(Dest).Options := TCustomSynEdit(Dest).Options + [eoShowScrollHint]
    else
      TCustomSynEdit(Dest).Options := TCustomSynEdit(Dest).Options - [eoShowScrollHint];
    if FTabsToSpaces then
      TCustomSynEdit(Dest).Options := TCustomSynEdit(Dest).Options + [eoTabsToSpaces]
    else
      TCustomSynEdit(Dest).Options := TCustomSynEdit(Dest).Options - [eoTabsToSpaces];
    if FSmartTabs then
      TCustomSynEdit(Dest).Options := TCustomSynEdit(Dest).Options + [eoSmartTabs]
    else
      TCustomSynEdit(Dest).Options := TCustomSynEdit(Dest).Options - [eoSmartTabs];
    if FSmartTabDelete then
      TCustomSynEdit(Dest).Options := TCustomSynEdit(Dest).Options + [eoSmartTabDelete]
    else
      TCustomSynEdit(Dest).Options := TCustomSynEdit(Dest).Options - [eoSmartTabDelete];
    if FTrimTrailingSpaces then
      TCustomSynEdit(Dest).Options := TCustomSynEdit(Dest).Options + [eoTrimTrailingSpaces]
    else
      TCustomSynEdit(Dest).Options := TCustomSynEdit(Dest).Options - [eoTrimTrailingSpaces];
    if FTripleClickRowSelect then
      TCustomSynEdit(Dest).Options := TCustomSynEdit(Dest).Options + [eoTripleClicks]
    else
      TCustomSynEdit(Dest).Options := TCustomSynEdit(Dest).Options - [eoTripleClicks];
    if FNonblinkingCaret then
      TCustomSynEdit(Dest).Options := TCustomSynEdit(Dest).Options + [eoNonblinkingCaret]
    else
      TCustomSynEdit(Dest).Options := TCustomSynEdit(Dest).Options - [eoNonblinkingCaret];

    TCustomSynEdit(Dest).WordWrap.Enabled := FEnableWordWrap;
    TCustomSynEdit(Dest).Gutter.ShowLineNumbers := FEnableLineNumbers;

    if FEnableSpecialChars then
      TCustomSynEdit(Dest).Options := TCustomSynEdit(Dest).Options + [eoShowSpecialChars]
    else
      TCustomSynEdit(Dest).Options := TCustomSynEdit(Dest).Options - [eoShowSpecialChars];

    if FEnableSelectionMode then
      TCustomSynEdit(Dest).SelectionMode := smColumn
    else
      TCustomSynEdit(Dest).SelectionMode := smNormal;

    TCustomSynEdit(Dest).RightEdge.Visible := FMarginVisibleRightMargin;
    TCustomSynEdit(Dest).RightEdge.MouseMove := FMarginLeftMarginMouseMove;
    TCustomSynEdit(Dest).RightEdge.Position := FMarginRightMargin;

    TCustomSynEdit(Dest).Minimap.Font.Name := FMinimapFontName;
    TCustomSynEdit(Dest).Minimap.Font.Size := FMinimapFontSize;
    TCustomSynEdit(Dest).Minimap.Width := FMinimapWidth;
  end
  else
  if Assigned(Dest) and (Dest is TActionMainMenuBar) then
  begin
    TActionMainMenuBar(Dest).PersistentHotKeys := FPersistentHotKeys;
    TActionMainMenuBar(Dest).Shadows := FShadows;
    TActionMainMenuBar(Dest).UseSystemFont := FMainMenuUseSystemFont;
    if FMainMenuUseSystemFont then
    begin
      Screen.MenuFont.Name := FMainMenuSystemFontName;
      Screen.MenuFont.Size := FMainMenuSystemFontSize;
    end
    else
    begin
      Screen.MenuFont.Name := FMainMenuFontName;
      Screen.MenuFont.Size := FMainMenuFontSize;
    end;
    TActionMainMenuBar(Dest).AnimationStyle := TAnimationStyle(FAnimationStyle);
    TActionMainMenuBar(Dest).AnimateDuration := FAnimationDuration;
  end
  else
  if Assigned(Dest) and (Dest is TStatusBar) then
  begin
    TStatusBar(Dest).UseSystemFont := FStatusBarUseSystemFont;
    if not FStatusBarUseSystemFont then
    begin
      TStatusBar(Dest).Font.Name := FStatusBarFontName;
      TStatusBar(Dest).Font.Size := FStatusBarFontSize;
      TStatusBar(Dest).Height := FStatusBarFontSize + 11;
    end;
  end
  else
  if Assigned(Dest) and (Dest is TSynCompletionProposal) then
  begin
    if not FCompletionProposalEnabled then
      TSynCompletionProposal(Dest).ShortCut := TextToShortCut('')
    else
      TSynCompletionProposal(Dest).ShortCut := TextToShortCut(FCompletionProposalShortcut);
    if FCompletionProposalCaseSensitive then
      TSynCompletionProposal(Dest).Options := TSynCompletionProposal(Dest).Options + [scoCaseSensitive]
    else
      TSynCompletionProposal(Dest).Options := TSynCompletionProposal(Dest).Options - [scoCaseSensitive];
  end
  else
    inherited;
end;

destructor TOptionsContainer.Destroy;
begin
  FOptionsContainer := nil;
  inherited;
end;

{ TOraBoneOptionsContainer }

{$ifdef ORABONE}
procedure TOraBoneOptionsContainer.WriteIniFile;
begin
  inherited;
  with TBigIniFile.Create(GetINIFilename) do
  try
    { deprecated }
    DeleteKey('Options', 'MarginLineNumbers');
    DeleteKey('Options', 'ObjectCreationAndModificationTimestamp');
  finally
    Free
  end;
end;
{$endif}

{ TEditBoneOptionsContainer }
{$ifdef EDITBONE}
procedure TEditBoneOptionsContainer.ReadIniFile;
var
  i, j: Integer;
  s: string;
  FileTypes: TStrings;
begin
  inherited;
  FileTypes := TStringList.Create;
  with TBigIniFile.Create(GetIniFilename) do
  try
    { FileTypes }
    ReadSectionValues('FileTypes', FileTypes);
    for i := 0 to FileTypes.Count - 1 do
    begin
      j := Pos('=', FileTypes.Strings[i]);
      s := System.Copy(FileTypes.Strings[i], j + 1, Pos('(', FileTypes.Strings[i]) - j - 2);
      { search file type }
      for j := 0 to FFileTypes.Count - 1 do
        if Pos(s, FFileTypes.Strings[j]) = 1 then
        begin
          FFileTypes.Strings[j] := System.Copy(FileTypes.Strings[i],
            Pos('=', FileTypes.Strings[i]) + 1, Length(FileTypes.Strings[i]));
          Break;
        end;
    end;
  finally
    FileTypes.Free;
    Free;
  end;
end;

function TEditBoneOptionsContainer.FileType(FileType: TFileType): string;
begin
  if FileType = ftHC11 then
    Result := FFileTypes.Strings[0]
  else
  if FileType = ftAWK then
    Result := FFileTypes.Strings[1]
  else
  if FileType = ftBaan then
    Result := FFileTypes.Strings[2]
  else
  if FileType = ftCS then
    Result := FFileTypes.Strings[3]
  else
  if FileType = ftCPP then
    Result := FFileTypes.Strings[4]
  else
  if FileType = ftCAC then
    Result := FFileTypes.Strings[5]
  else
  if FileType = ftCache then
    Result := FFileTypes.Strings[6]
  else
  if FileType = ftCss then
    Result := FFileTypes.Strings[7]
  else
  if FileType = ftCobol then
    Result := FFileTypes.Strings[8]
  else
  if FileType = ftIdl then
    Result := FFileTypes.Strings[9]
  else
  if FileType = ftCPM then
    Result := FFileTypes.Strings[10]
  else
  if FileType = ftDOT then
    Result := FFileTypes.Strings[11]
  else
  if FileType = ftADSP21xx then
    Result := FFileTypes.Strings[12]
   else
  if FileType = ftDWScript then
    Result := FFileTypes.Strings[13]
  else
  if FileType = ftEiffel then
    Result := FFileTypes.Strings[14]
  else
  if FileType = ftFortran then
    Result := FFileTypes.Strings[15]
  else
  if FileType = ftFoxpro then
    Result := FFileTypes.Strings[16]
  else
  if FileType = ftGalaxy then
    Result := FFileTypes.Strings[17]
  else
  if FileType = ftDml then
    Result := FFileTypes.Strings[18]
  else
  if FileType = ftGWScript then
    Result := FFileTypes.Strings[19]
  else
  if FileType = ftHaskell then
    Result := FFileTypes.Strings[20]
  else
  if FileType = ftHP48 then
    Result := FFileTypes.Strings[21]
  else
  if FileType = ftHTML then
    Result := FFileTypes.Strings[22]
  else
  if FileType = ftIni then
    Result := FFileTypes.Strings[23]
  else
  if FileType = ftInno then
    Result := FFileTypes.Strings[24]
  else
  if FileType = ftJava then
    Result := FFileTypes.Strings[25]
  else
  if FileType = ftJScript then
    Result := FFileTypes.Strings[26]
  else
  if FileType = ftKix then
    Result := FFileTypes.Strings[27]
  else
  if FileType = ftLDR then
    Result := FFileTypes.Strings[28]
  else
  if FileType = ftLLVM then
    Result := FFileTypes.Strings[29]
  else
  if FileType = ftModelica then
    Result := FFileTypes.Strings[30]
  else
  if FileType = ftM3 then
    Result := FFileTypes.Strings[31]
  else
  if FileType = ftMsg then
    Result := FFileTypes.Strings[32]
  else
  if FileType = ftBat then
    Result := FFileTypes.Strings[33]
  else
  if FileType = ftPas then
    Result := FFileTypes.Strings[34]
  else
  if FileType = ftPerl then
    Result := FFileTypes.Strings[35]
  else
  if FileType = ftPHP then
    Result := FFileTypes.Strings[36]
  else
  if FileType = ftProgress then
    Result := FFileTypes.Strings[37]
  else
  if FileType = ftPython then
    Result := FFileTypes.Strings[38]
  else
  if FileType = ftRC then
    Result := FFileTypes.Strings[39]
  else
  if FileType = ftRuby then
    Result := FFileTypes.Strings[40]
  else
  if FileType = ftSDD then
    Result := FFileTypes.Strings[41]
  else
  if FileType = ftSQL then
    Result := FFileTypes.Strings[42]
  else
  if FileType = ftSML then
    Result := FFileTypes.Strings[43]
  else
  if FileType = ftST then
    Result := FFileTypes.Strings[44]
  else
  if FileType = ftTclTk then
    Result := FFileTypes.Strings[45]
  else
  if FileType = ftTeX then
    Result := FFileTypes.Strings[46]
  else
  if FileType = ftText then
    Result := FFileTypes.Strings[47]
  else
  if FileType = ftUNIXShellScript then
    Result := FFileTypes.Strings[48]
  else
  if FileType = ftVB then
    Result := FFileTypes.Strings[49]
  else
  if FileType = ftVBScript then
    Result := FFileTypes.Strings[50]
  else
  if FileType = ftVrml97 then
    Result := FFileTypes.Strings[51]
  else
  if FileType = ftWebIDL then
    Result := FFileTypes.Strings[52]
  else
  if FileType = ftAsm then
    Result := FFileTypes.Strings[53]
  else
  if FileType = ftXML then
    Result := FFileTypes.Strings[54]
  else
  if FileType = ftYAML then
    Result := FFileTypes.Strings[55];

  Result := UpperCase(StringBetween(Result, '(', ')'));
end;

constructor TEditBoneOptionsContainer.Create(AOwner: TComponent);
var
  i: Integer;
begin
  inherited;
  FFileTypes := TStringList.Create;
  for i := 0 to 55 do
    FFileTypes.Add(LanguageDataModule.FileTypesMultiStringHolder.MultipleStrings.Items[i].Strings.Text);
end;

function TEditBoneOptionsContainer.GetFilterCount: Cardinal;
begin
  Result := FFileTypes.Count;
end;

function TEditBoneOptionsContainer.GetFilterExt(FilterIndex: Cardinal): string;
begin
  { -2 because filter index is not 0-based and there's all files (in save dialog) first }
  Result := StringBetween(FFileTypes.Strings[FilterIndex - 2], '(', ')');
  Result := StringReplace(Result, '*', '', []);
  if Pos(';', Result) <> 0 then
    Result := Copy(Result, 1, Pos(';', Result) - 1);
end;

function TEditBoneOptionsContainer.GetFilterIndex(FileExt: string): Cardinal;
var
  i: Integer;
begin
  Result := 1;
  for i := 0 to FFileTypes.Count - 1 do
    if IsExtInFileType(FileExt, FFileTypes.Strings[i]) then
    begin
      Result := i + 2;
      Break;
    end;
end;

function TEditBoneOptionsContainer.GetFilters: string;
var
  i: Integer;
begin
  Result := Format('%s'#0'*.*'#0, [LanguageDataModule.GetConstant('AllFiles')]);
  i := 0;
  while i < FFileTypes.Count do
  begin
    Result := Format('%s%s'#0'%s', [Result, LanguageDataModule.FileTypesMultiStringHolder.MultipleStrings.Items[i].Strings.Text,
      StringBetween(FFileTypes.Strings[i], '(', ')')]);
    Inc(i);
    if i < FFileTypes.Count then
      Result := Format('%s'#0, [Result]);
  end;
  Result := Format('%s'#0#0, [Result]);
end;

function TEditBoneOptionsContainer.GetExtensions: string;
var
  i: Integer;
begin
  Result := '*.*|';
  for i := 0 to FFileTypes.Count - 1 do
    Result := Format('%s%s|', [Result, StringBetween(FFileTypes.Strings[i], '(', ')')]);
end;

function TEditBoneOptionsContainer.SupportedFileExts(Refresh: Boolean): string;
var
  i: Integer;
begin
  if (FSupportedFileExts = '') or Refresh then
    for i := 0 to FFileTypes.Count - 1 do
      FSupportedFileExts := Format('%s%s;', [FSupportedFileExts, StringBetween(FFileTypes.Strings[i], '(', ')')]);
  Result := FSupportedFileExts;
end;

procedure TEditBoneOptionsContainer.AssignTo(Dest: TPersistent);
begin
  inherited;
  if Assigned(Dest) and (Dest is TCustomSynEdit) then
  begin
    if TCustomSynEdit(Dest).Highlighter is TSynWebHtmlSyn then
    begin
      TSynWebHtmlSyn(TCustomSynEdit(Dest).Highlighter).Engine.Options.HtmlVersion := TSynWebHtmlVersion(FHTMLVersion);
      TSynWebHtmlSyn(TCustomSynEdit(Dest).Highlighter).Engine.Options.CssVersion := TSynWebCssVersion(FCSSVersion);
      TSynWebHtmlSyn(TCustomSynEdit(Dest).Highlighter).Engine.Options.PhpVersion := TSynWebPhpVersion(FPHPVersion);
    end;
    if TCustomSynEdit(Dest).Highlighter is TSynSQLSyn then
      TSynSQLSyn(TCustomSynEdit(Dest).Highlighter).SQLDialect := TSQLDialect(FSQLDialect);
  end;
end;
{$endif}

end.
