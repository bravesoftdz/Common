unit BCCommon.OptionsContainer;

interface

uses
  System.Classes, Vcl.ActnMenus, SynEdit;

type
  TOptionsContainer = class(TComponent)
  private
    FAnimationDuration: Integer;
    FAnimationStyle: TAnimationStyle;
    FAutoIndent: Boolean;
    FAutoSave: Boolean;
    FBeepIfSearchStringNotFound: Boolean;
    FColorBrightness: Integer;
    FCompletionProposalCaseSensitive: Boolean;
    FCompletionProposalEnabled: Boolean;
    FCompletionProposalShortcut: string;
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
    FEnableLineNumbers: Boolean;
    FEnableSelectionMode: Boolean;
    FEnableSpecialChars: Boolean;
    FEnableWordWrap: Boolean;
    FFilterOnTyping: Boolean;
    FFontName: string;
    FFontSize: Integer;
    FIgnoreBlanks: Boolean;
    FIgnoreCase: Boolean;
    FInsertCaret: TSynEditCaretType;
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
    FObjectFrameAlign: string;
    FOutputCloseTabByDblClick: Boolean;
    FOutputCloseTabByMiddleClick: Boolean;
    FOutputDoubleBuffered: Boolean;
    FOutputIndent: Integer;
    FOutputMultiLine: Boolean;
    FOutputRightClickSelect: Boolean;
    FOutputShowCloseButton: Boolean;
    FOutputShowImage: Boolean;
    FOutputShowTreeLines: Boolean;
    FPersistentHotKeys: Boolean;
    FPollingInterval: Integer;
    FPrintDateTime: Integer;
    FPrintDocumentName: Integer;
    FPrintPageNumber: Integer;
    FPrintPrintedBy: Integer;
    FPrintShowFooterLine: Boolean;
    FPrintShowHeaderLine: Boolean;
    FPrintShowLineNumbers: Boolean;
    FPrintWordWrapLine: Boolean;
    FSchemaBrowserAlign: string;
    FSchemaBrowserIndent: Integer;
    FSchemaBrowserShowTreeLines: Boolean;
    FScrollPastEof: Boolean;
    FScrollPastEol: Boolean;
    FShadows: Boolean;
    FShowSearchStringNotFound: Boolean;
    FShowDataSearchPanel: Boolean;
    FShowObjectCreationAndModificationTimestamp: Boolean;
    FSmartTabDelete: Boolean;
    FSmartTabs: Boolean;
    FStatusBarFontName: string;
    FStatusBarFontSize: Integer;
    FStatusBarUseSystemFont: Boolean;
    FTabsToSpaces: Boolean;
    FTabWidth: Integer;
    FTimeFormat: string;
    FToolBarCase: Boolean;
    FToolBarCommand: Boolean;
    FToolBarDBMS: Boolean;
    FToolBarExecute: Boolean;
    FToolBarExplainPlan: Boolean;
    FToolBarIndent: Boolean;
    FToolBarMode: Boolean;
    FToolBarPrint: Boolean;
    FToolBarSearch: Boolean;
    FToolBarSort: Boolean;
    FToolBarStandard: Boolean;
    FToolBarTools: Boolean;
    FToolBarTransaction: Boolean;
    FTrimTrailingSpaces: Boolean;
    FTripleClickRowSelect: Boolean;
    FUndoAfterSave: Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AssignTo(Dest: TPersistent); override;
  published
    property AnimationDuration: Integer read FAnimationDuration write FAnimationDuration default 150;
    property AnimationStyle: TAnimationStyle read FAnimationStyle write FAnimationStyle default asDefault;
    property AutoIndent: Boolean read FAutoIndent write FAutoIndent default True;
    property AutoSave: Boolean read FAutoSave write FAutoSave default False;
    property BeepIfSearchStringNotFound: Boolean read FBeepIfSearchStringNotFound write FBeepIfSearchStringNotFound default True;
    property ColorBrightness: Integer read FColorBrightness write FColorBrightness;
    property CompletionProposalCaseSensitive: Boolean read FCompletionProposalCaseSensitive write FCompletionProposalCaseSensitive default True;
    property CompletionProposalEnabled: Boolean read FCompletionProposalEnabled write FCompletionProposalEnabled default True;
    property CompletionProposalShortcut: string read FCompletionProposalShortcut write FCompletionProposalShortcut;
    property ConnectionCloseTabByDblClick: Boolean read FConnectionCloseTabByDblClick write FConnectionCloseTabByDblClick default False;
    property ConnectionCloseTabByMiddleClick: Boolean read FConnectionCloseTabByMiddleClick write FConnectionCloseTabByMiddleClick default False;
    property ConnectionDoubleBuffered: Boolean read FConnectionDoubleBuffered write FConnectionDoubleBuffered default True;
    property ConnectionMultiLine: Boolean read FConnectionMultiLine write FConnectionMultiLine default False;
    property ConnectionRightClickSelect: Boolean read FConnectionRightClickSelect write FConnectionRightClickSelect default True;
    property ConnectionShowCloseButton: Boolean read FConnectionShowCloseButton write FConnectionShowCloseButton default False;
    property ConnectionShowImage: Boolean read FConnectionShowImage write FConnectionShowImage default True;
    property DateFormat: string read FDateFormat write FDateFormat;
    property EditorCloseTabByDblClick: Boolean read FEditorCloseTabByDblClick write FEditorCloseTabByDblClick default False;
    property EditorCloseTabByMiddleClick: Boolean read FEditorCloseTabByMiddleClick write FEditorCloseTabByMiddleClick  default False;
    property EditorDoubleBuffered: Boolean read FEditorDoubleBuffered write FEditorDoubleBuffered default True;
    property EditorMultiLine: Boolean read FEditorMultiLine write FEditorMultiLine default False;
    property EditorRightClickSelect: Boolean read FEditorRightClickSelect write FEditorRightClickSelect default True;
    property EditorShowCloseButton: Boolean read FEditorShowCloseButton write FEditorShowCloseButton default False;
    property EditorShowImage: Boolean read FEditorShowImage write FEditorShowImage default True;
    property EnableLineNumbers: Boolean read FEnableLineNumbers write FEnableLineNumbers default True;
    property EnableSelectionMode: Boolean read FEnableSelectionMode write FEnableSelectionMode default False;
    property EnableSpecialChars: Boolean read FEnableSpecialChars write FEnableSpecialChars default False;
    property EnableWordWrap: Boolean read FEnableWordWrap write FEnableWordWrap default False;
    property FilterOnTyping: Boolean read FFilterOnTyping write FFilterOnTyping default True;
    property FontName: string read FFontName write FFontName;
    property FontSize: Integer read FFontSize write FFontSize default 9;
    property IgnoreBlanks: Boolean read FIgnoreBlanks write FIgnoreBlanks default True;
    property IgnoreCase: Boolean read FIgnoreCase write FIgnoreCase default True;
    property InsertCaret: TSynEditCaretType read FInsertCaret write FInsertCaret default ctVerticalLine;
    property LineSpacing: Integer read FLineSpacing write FLineSpacing default 0;
    property MainMenuFontName: string read FMainMenuFontName write FMainMenuFontName;
    property MainMenuFontSize: Integer read FMainMenuFontSize write FMainMenuFontSize default 8;
    property MainMenuSystemFontName: string read FMainMenuSystemFontName write FMainMenuSystemFontName;
    property MainMenuSystemFontSize: Integer read FMainMenuSystemFontSize write FMainMenuSystemFontSize;
    property MainMenuUseSystemFont: Boolean read FMainMenuUseSystemFont write FMainMenuUseSystemFont default False;
    property MarginFontName: string read FMarginFontName write FMarginFontName;
    property MarginFontSize: Integer read FMarginFontSize write FMarginFontSize default 9;
    property MarginInTens: Boolean read FMarginInTens write FMarginInTens default True;
    property MarginLeftMarginAutoSize: Boolean read FMarginLeftMarginAutoSize write FMarginLeftMarginAutoSize default True;
    property MarginLeftMarginWidth: Integer read FMarginLeftMarginWidth write FMarginLeftMarginWidth default 30;
    property MarginLeftMarginMouseMove: Boolean read FMarginLeftMarginMouseMove write FMarginLeftMarginMouseMove default True;
    property MarginLineModified: Boolean read FMarginLineModified write FMarginLineModified default False;
    property MarginModifiedColor: string read FMarginModifiedColor write FMarginModifiedColor;
    property MarginNormalColor: string read FMarginNormalColor write FMarginNormalColor;
    property MarginRightMargin: Integer read FMarginRightMargin write FMarginRightMargin default 80;
    property MarginShowBookmarks: Boolean read FMarginShowBookmarks write FMarginShowBookmarks default True;
    property MarginShowBookmarkPanel: Boolean read FMarginShowBookmarkPanel write FMarginShowBookmarkPanel default True;
    property MarginVisibleLeftMargin: Boolean read FMarginVisibleLeftMargin write FMarginVisibleLeftMargin default True;
    property MarginVisibleRightMargin: Boolean read FMarginVisibleRightMargin write FMarginVisibleRightMargin default True;
    property MarginZeroStart: Boolean read FMarginZeroStart write FMarginZeroStart default False;
    property MinimapFontName: string read FMinimapFontName write FMinimapFontName;
    property MinimapFontSize: Integer read FMinimapFontSize write FMinimapFontSize default 2;
    property MinimapWidth: Integer read FMinimapWidth write FMinimapWidth default 100;
    property NonblinkingCaret: Boolean read FNonblinkingCaret write FNonblinkingCaret default False;
    property NonblinkingCaretColor: string read FNonblinkingCaretColor write FNonblinkingCaretColor;
    property ObjectFrameAlign: string read FObjectFrameAlign write FObjectFrameAlign;
    property OutputCloseTabByDblClick: Boolean read FOutputCloseTabByDblClick write FOutputCloseTabByDblClick default False;
    property OutputCloseTabByMiddleClick: Boolean read FOutputCloseTabByMiddleClick write FOutputCloseTabByMiddleClick default False;
    property OutputDoubleBuffered: Boolean read FOutputDoubleBuffered write FOutputDoubleBuffered default True;
    property OutputIndent: Integer read FOutputIndent write FOutputIndent default 16;
    property OutputMultiLine: Boolean read FOutputMultiLine write FOutputMultiLine default False;
    property OutputRightClickSelect: Boolean read FOutputRightClickSelect write FOutputRightClickSelect default True;
    property OutputShowCloseButton: Boolean read FOutputShowCloseButton write FOutputShowCloseButton default False;
    property OutputShowImage: Boolean read FOutputShowImage write FOutputShowImage default True;
    property OutputShowTreeLines: Boolean read FOutputShowTreeLines write FOutputShowTreeLines default False;
    property PersistentHotKeys: Boolean read FPersistentHotKeys write FPersistentHotKeys default False;
    property PollingInterval: Integer read FPollingInterval write FPollingInterval default 1;
    property PrintDateTime: Integer read FPrintDateTime write FPrintDateTime default 1;
    property PrintDocumentName: Integer read FPrintDocumentName write FPrintDocumentName default 2;
    property PrintPageNumber: Integer read FPrintPageNumber write FPrintPageNumber default 3;
    property PrintPrintedBy: Integer read FPrintPrintedBy write FPrintPrintedBy default 0;
    property PrintShowFooterLine: Boolean read FPrintShowFooterLine write FPrintShowFooterLine default True;
    property PrintShowHeaderLine: Boolean read FPrintShowHeaderLine write FPrintShowHeaderLine default True;
    property PrintShowLineNumbers: Boolean read FPrintShowLineNumbers write FPrintShowLineNumbers default False;
    property PrintWordWrapLine: Boolean read FPrintWordWrapLine write FPrintWordWrapLine default False;
    property SchemaBrowserAlign: string read FSchemaBrowserAlign write FSchemaBrowserAlign;
    property SchemaBrowserIndent: Integer read FSchemaBrowserIndent write FSchemaBrowserIndent default 16;
    property SchemaBrowserShowTreeLines: Boolean read FSchemaBrowserShowTreeLines write FSchemaBrowserShowTreeLines default False;
    property ScrollPastEof: Boolean read FScrollPastEof write FScrollPastEof default False;
    property ScrollPastEol: Boolean read FScrollPastEol write FScrollPastEol default True;
    property Shadows: Boolean read FShadows write FShadows default True;
    property ShowSearchStringNotFound: Boolean read FShowSearchStringNotFound write FShowSearchStringNotFound default True;
    property ShowDataSearchPanel: Boolean read FShowDataSearchPanel write FShowDataSearchPanel default True;
    property ShowObjectCreationAndModificationTimestamp: Boolean read FShowObjectCreationAndModificationTimestamp write FShowObjectCreationAndModificationTimestamp default False;
    property SmartTabDelete: Boolean read FSmartTabDelete write FSmartTabDelete default False;
    property SmartTabs: Boolean read FSmartTabs write FSmartTabs default False;
    property StatusBarFontName: string read FStatusBarFontName write FStatusBarFontName;
    property StatusBarFontSize: Integer read FStatusBarFontSize write FStatusBarFontSize default 8;
    property StatusBarUseSystemFont: Boolean read FStatusBarUseSystemFont write FStatusBarUseSystemFont default False;
    property TabsToSpaces: Boolean read FTabsToSpaces write FTabsToSpaces default True;
    property TabWidth: Integer read FTabWidth write FTabWidth default 8;
    property TimeFormat: string read FTimeFormat write FTimeFormat;
    property ToolBarCase: Boolean read FToolBarCase write FToolBarCase default True;
    property ToolBarCommand: Boolean read FToolBarCommand write FToolBarCommand default True;
    property ToolBarDBMS: Boolean read FToolBarDBMS write FToolBarDBMS default True;
    property ToolBarExecute: Boolean read FToolBarExecute write FToolBarExecute default True;
    property ToolBarExplainPlan: Boolean read FToolBarExplainPlan write FToolBarExplainPlan default True;
    property ToolBarIndent: Boolean read FToolBarIndent write FToolBarIndent default True;
    property ToolBarMode: Boolean read FToolBarMode write FToolBarMode default True;
    property ToolBarPrint: Boolean read FToolBarPrint write FToolBarPrint default True;
    property ToolBarSearch: Boolean read FToolBarSearch write FToolBarSearch default True;
    property ToolBarSort: Boolean read FToolBarSort write FToolBarSort default True;
    property ToolBarStandard: Boolean read FToolBarStandard write FToolBarStandard default True;
    property ToolBarTools: Boolean read FToolBarTools write FToolBarTools default True;
    property ToolBarTransaction: Boolean read FToolBarTransaction write FToolBarTransaction default True;
    property TrimTrailingSpaces: Boolean read FTrimTrailingSpaces write FTrimTrailingSpaces default True;
    property TripleClickRowSelect: Boolean read FTripleClickRowSelect write FTripleClickRowSelect default True;
    property UndoAfterSave: Boolean read FUndoAfterSave write FUndoAfterSave default False;
  end;

  TOraBoneOptionsContainer = class(TOptionsContainer)

  end;

{$ifdef ORABONE}
function OptionsContainer: TOraBoneOptionsContainer;
{$endif}

implementation

uses
  Vcl.Forms, Vcl.ComCtrls, Vcl.Graphics, Vcl.Menus, SynEditTypes, SynCompletionProposal;

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
    TCustomSynEdit(Dest).InsertCaret := FInsertCaret;
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

    TCustomSynEdit(Dest).Gutter.ShowBookmarks := FMarginShowBookmarks;
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
    TActionMainMenuBar(Dest).AnimationStyle := FAnimationStyle;
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

constructor TOptionsContainer.Create(AOwner: TComponent);
begin
  { default values }
  FCompletionProposalShortCut := 'Ctrl+Space';
  FDateFormat := 'DD.MM.YYYY';
  FFontName := 'Courier New';
  FNonblinkingCaretColor := 'clBlack';
  FMainMenuFontName := 'Tahoma';
  FMainMenuSystemFontName := Screen.MenuFont.Name;
  FMainMenuSystemFontSize := Screen.MenuFont.Size;
  FMarginFontName := 'Courier New';
  FMarginModifiedColor := 'clYellow';
  FMarginNormalColor := 'clGreen';
  FObjectFrameAlign := 'Bottom';
  FSchemaBrowserAlign := 'Bottom';
  FStatusBarFontName := 'Tahoma';
  FTimeFormat := 'HH24:MI:SS';
end;

destructor TOptionsContainer.Destroy;
begin
  FOptionsContainer := nil;
  inherited;
end;

end.
