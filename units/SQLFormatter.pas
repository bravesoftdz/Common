unit SQLFormatter;

interface

uses
  SysUtils, RegularExpressions, Classes, Generics.Collections, SQLParseTree, OmniXML;

type
  TSQLFormatterState = class
  private
    FIndentString: string;
    FIndentLength: Integer;
    FMaxLineWidth: Integer;
    FStatementBreakExpected: Boolean;
    FBreakExpected: Boolean;
    FWordSeparatorExpected: Boolean;
    FSourceBreakPending: Boolean;
    FAdditionalBreakExpected: Boolean;
    FUnIndentInitialBreak: Boolean;
    FIndentLevel: Integer;
    FCurrentLineLength: Integer;
    FCurrentLineHasContent: Boolean;
    FStartsWithBreakChecker: TRegEx;
    FLineBreakMatcher: TRegEx;
    FRegionStartNode: IXMLNode;
    FMostRecentKeywordsAtEachLevel: TDictionary<Integer, string>;

    procedure WhiteSpaceBreakToNextLine;
  protected
    OutBuilder: TStringBuilder;
  public
//    constructor Create; overload;
    constructor Create(State: TSQLFormatterState); overload;
    constructor Create(IndentString: string; SpacesPerTab: Integer; MaxLineWidth: Integer;
      InitialIndentLevel: Integer); overload;
    destructor Destroy; override;

    procedure AddOutputContent(Content: string);
    procedure AddOutputLineBreak;
    procedure AddOutputSpace;
    function OutputToString: string;

    property IndentString: string read FIndentString write FIndentString;
    property StatementBreakExpected: Boolean read FStatementBreakExpected write FStatementBreakExpected;
    property BreakExpected: Boolean read FBreakExpected write FBreakExpected;
    property WordSeparatorExpected: Boolean read FWordSeparatorExpected write FWordSeparatorExpected;
    property SourceBreakPending: Boolean read FSourceBreakPending write FSourceBreakPending;
    property AdditionalBreakExpected: Boolean read FAdditionalBreakExpected write FAdditionalBreakExpected;

    property UnIndentInitialBreak: Boolean read FUnIndentInitialBreak write FUnIndentInitialBreak;
    property IndentLevel: Integer read FIndentLevel write FIndentLevel;
    property CurrentLineLength: Integer read FCurrentLineLength write FCurrentLineLength;
    property CurrentLineHasContent: Boolean read FCurrentLineHasContent write FCurrentLineHasContent;

    property RegionStartNode: IXMLNode read FRegionStartNode write FRegionStartNode;

    function StartsWithBreak: Boolean;
    procedure Indent(IndentLevel: Integer);

    function OutputContainsLineBreak: Boolean;

    procedure Assimilate(PartialState: TSQLFormatterState);

    function IncrementIndent: TSQLFormatterState;
    function DecrementIndent: TSQLFormatterState;

    procedure SetRecentKeyword(ElementName: string);

    function GetRecentKeyword: string;
    procedure ResetKeywords;
  end;

  TSqlFormatter = class
  private
    FIndentString: string;
    FSpacesPerTab: Integer;
    FMaxLineWidth: Integer;
    FExpandCommaLists: Boolean;
    FTrailingCommas: Boolean;
    FSpaceAfterExpandedComma: Boolean;
    FExpandBooleanExpressions: Boolean;
    FExpandCaseStatements: Boolean;
    FExpandBetweenConditions: Boolean;
    FUppercaseKeywords: Boolean;
    FBreakJoinOnSections: Boolean;
    procedure ProcessSqlNodeList(RootList: IXMLNodeList; State: TSQLFormatterState); //overload;
    procedure ProcessSqlNode(ContentElement: IXMLElement; State: TSQLFormatterState);
    function FormatKeyword(Keyword: string): string;
    function FormatOperator(OperatorValue: string): string;
    procedure WhiteSpaceSeparateStatements(ContentElement: IXMLElement; State: TSQLFormatterState);
    function FirstSemanticElementChild(ContentElement: IXMLElement): IXMLElement;
    procedure WhiteSpaceSeparateWords(State: TSQLFormatterState);
    procedure WhiteSpaceSeparateComment(ContentElement: IXMLElement; State: TSQLFormatterState);
    procedure WhiteSpaceBreakAsExpected(State: TSQLFormatterState);
  public
    constructor Create; overload;
    constructor Create(indentString: string; spacesPerTab: Integer; maxLineWidth: Integer;
      expandCommaLists: Boolean; trailingCommas: Boolean; spaceAfterExpandedComma: Boolean;
      expandBooleanExpressions: Boolean; expandCaseStatements: Boolean; expandBetweenConditions: Boolean;
      breakJoinOnSections: Boolean; uppercaseKeywords: Boolean; keywordStandardization: Boolean); overload;
    function FormatSQLTree(SQLParseTree: TSQLParseTree): string;

    property IndentString: string read FIndentString write FIndentString;
    property SpacesPerTab: Integer read FSpacesPerTab write FSpacesPerTab;
    property MaxLineWidth: Integer read FMaxLineWidth write FMaxLineWidth;
    property ExpandCommaLists: Boolean read FExpandCommaLists write FExpandCommaLists;
    property TrailingCommas: Boolean read FTrailingCommas write FTrailingCommas;
    property SpaceAfterExpandedComma: Boolean read FSpaceAfterExpandedComma write FSpaceAfterExpandedComma;
    property ExpandBooleanExpressions: Boolean read FExpandBooleanExpressions write FExpandBooleanExpressions;
    property ExpandCaseStatements: Boolean read FExpandCaseStatements write FExpandCaseStatements;
    property ExpandBetweenConditions: Boolean read FExpandBetweenConditions write FExpandBetweenConditions;
    property UppercaseKeywords: Boolean read FUppercaseKeywords write FUppercaseKeywords;
    property BreakJoinOnSections: Boolean read FBreakJoinOnSections write FBreakJoinOnSections;
  end;

  function FormatSQL(SQL: string): string;

implementation

uses
  SQLParser, SQLTokenizer, StrUtils, Common, XMLConstants;


function FormatSQL(SQL: string): string;
var
  SQLParser: TSQLParser;
  SQLFormatter: TSQLFormatter;
  SQLTokenizer: TSQLTokenizer;
  SQLParseTree: TSQLParseTree;
begin
  Result := SQL;
  SQLParser := TSQLParser.Create;
  SQLFormatter := TSQLFormatter.Create;
  SQLTokenizer := TSQLTokenizer.Create(SQL);
  try
    SQLParseTree := SQLParser.Parse(SQLTokenizer.SQLTokenList);
    if Assigned(SQLParseTree) then
    begin
      if Assigned(SQLParseTree.SelectSingleNode(System.SysUtils.Format('/%s/@%s[.=1]', [XMLConstants.XML_SQL_ROOT, XMLConstants.XML_ERRORFOUND]))) then
        Result := PARSING_ERRORS_FOUND + SQL
      else
        Result := SQLFormatter.FormatSQLTree(SQLParseTree);
    end;
  finally
    SQLTokenizer.Free;
    SQLFormatter.Free;
    SQLParser.Free;
  end;
end;

{ TSqlFormatterState }

constructor TSqlFormatterState.Create(State: TSQLFormatterState);
begin
  FIndentLevel := State.IndentLevel;
  FIndentString := State.IndentString;
  FIndentLength := State.FIndentLength;
  FMaxLineWidth := State.FMaxLineWidth;
  //TODO: find a way out of the cross-dependent wrapping maze...
  //CurrentLineLength = sourceState.CurrentLineLength;
  FCurrentLineLength := FIndentLevel * FIndentLength;
  FCurrentLineHasContent := State.CurrentLineHasContent;

  FStartsWithBreakChecker := TRegex.Create('^\s*(\r|\n)', [roNone]);
  FLineBreakMatcher := TRegex.Create('(\r|\n)+', [roCompiled]);
  FMostRecentKeywordsAtEachLevel := TDictionary<Integer, string>.Create;
  OutBuilder := TStringBuilder.Create;
end;

constructor TSqlFormatterState.Create(IndentString: string; SpacesPerTab: Integer;
  MaxLineWidth: Integer; InitialIndentLevel: Integer);
var
  tabExtraCharacters: Integer;
  tabCount: Integer;
begin
  inherited Create;
  FIndentLevel := InitialIndentLevel;
  FIndentString := IndentString;
  FMaxLineWidth := maxLineWidth;
  TabCount := Length(SplitString(IndentString, CHR_TAB)) - 1;
  TabExtraCharacters := (TabCount * (SpacesPerTab - 1));
  FIndentLength := Length(IndentString) + TabExtraCharacters;
  FStartsWithBreakChecker := TRegex.Create('^\s*(\r|\n)', [roNone]);
  FLineBreakMatcher := TRegex.Create('(\r|\n)+', [roCompiled]);
  FMostRecentKeywordsAtEachLevel := TDictionary<Integer, string>.Create;
  OutBuilder := TStringBuilder.Create;
end;

destructor TSqlFormatterState.Destroy;
begin
  OutBuilder.Free;
  inherited;
end;

procedure TSqlFormatterState.AddOutputContent(Content: string);
begin
  if FCurrentLineHasContent and (Length(Content) + FCurrentLineLength > FMaxLineWidth) then
    WhiteSpaceBreakToNextLine;
  OutBuilder.Append(Content);

  FCurrentLineHasContent := True;
  FCurrentLineLength := FCurrentLineLength + Length(Content);
end;

procedure TSqlFormatterState.AddOutputLineBreak;
begin
  OutBuilder.Append(CHR_ENTER);
  FCurrentLineLength := 0;
  FCurrentLineHasContent := False;
end;

procedure TSqlFormatterState.Indent(IndentLevel: Integer);
var
  i: Integer;
begin
  for i := 0 to IndentLevel - 1 do
  begin
    OutBuilder.Append(FIndentString);
    CurrentLineLength := CurrentLineLength + FIndentLength;
  end;
end;

function TSqlFormatterState.OutputToString: string;
begin
  Result := OutBuilder.ToString;
end;

function TSqlFormatterState.StartsWithBreak: Boolean;
begin
  Result := FStartsWithBreakChecker.IsMatch(OutBuilder.ToString);
end;

procedure TSqlFormatterState.AddOutputSpace;
begin
  OutBuilder.Append(' ');
end;

procedure TSqlFormatterState.WhiteSpaceBreakToNextLine;
begin
  AddOutputLineBreak;
  Indent(FIndentLevel);
  FBreakExpected := False;
  FSourceBreakPending := False;
  FWordSeparatorExpected := False;
end;

function TSqlFormatterState.OutputContainsLineBreak: Boolean;
begin
  Result := FLineBreakMatcher.IsMatch(OutBuilder.ToString);
end;

procedure TSqlFormatterState.Assimilate(PartialState: TSQLFormatterState);
begin
  FCurrentLineLength := FCurrentLineLength + PartialState.CurrentLineLength;
  FCurrentLineHasContent := FCurrentLineHasContent or PartialState.CurrentLineHasContent;
  OutBuilder.Append(PartialState.OutputToString);
end;

function TSqlFormatterState.IncrementIndent: TSQLFormatterState;
begin
  Inc(FIndentLevel);
  Result := Self;
end;

function TSqlFormatterState.DecrementIndent: TSQLFormatterState;
begin
  Dec(FIndentLevel);
  Result := Self;
end;

procedure TSqlFormatterState.SetRecentKeyword(ElementName: string);
begin
  if not FMostRecentKeywordsAtEachLevel.ContainsKey(FIndentLevel) then
    FMostRecentKeywordsAtEachLevel.Add(FIndentLevel, UpperCase(ElementName));
end;

function TSqlFormatterState.GetRecentKeyword: string;
var
  KeywordFound: string;
  Key, KeywordFoundAt: Integer;
begin
  KeywordFoundAt := -1;
  for Key in FMostRecentKeywordsAtEachLevel.Keys do
  begin
    if ((KeywordFoundAt = -1) or (KeywordFoundAt > Key)) and (Key >= FIndentLevel) then
    begin
      KeywordFoundAt := Key;
      KeywordFound := FMostRecentKeywordsAtEachLevel.Items[Key];
    end;
  end;
  Result := KeywordFound;
end;

procedure TSqlFormatterState.ResetKeywords;
var
  FDescendentLevelKeys: TList<Integer>;
  Key, DescKey: Integer;
begin
  FDescendentLevelKeys := TList<Integer>.Create;

  for Key in FMostRecentKeywordsAtEachLevel.Keys do
  begin
    if Key >= FIndentLevel then
    FDescendentLevelKeys.Add(Key);
    for DescKey in FDescendentLevelKeys do
      FMostRecentKeywordsAtEachLevel.Remove(DescKey);
  end;
end;

{ TSQLFormatter }

constructor TSQLFormatter.Create;
begin
  Create(CHR_TAB, 2, 999, False, False, False, True, True, True, False, True, False);
end;

constructor TSQLFormatter.Create(IndentString: string; SpacesPerTab: Integer;
  MaxLineWidth: Integer; ExpandCommaLists: Boolean; TrailingCommas: Boolean;
  SpaceAfterExpandedComma: Boolean; ExpandBooleanExpressions: Boolean; ExpandCaseStatements: Boolean;
  ExpandBetweenConditions: Boolean; BreakJoinOnSections: Boolean; UppercaseKeywords: Boolean;
  KeywordStandardization: Boolean);
begin
  inherited Create;

  FIndentString := indentString;
  FSpacesPerTab := spacesPerTab;
  FMaxLineWidth := maxLineWidth;
  FExpandCommaLists := expandCommaLists;
  FTrailingCommas := trailingCommas;
  FSpaceAfterExpandedComma := spaceAfterExpandedComma;
  FExpandBooleanExpressions := expandBooleanExpressions;
  FExpandBetweenConditions := expandBetweenConditions;
  FExpandCaseStatements := expandCaseStatements;
  FUppercaseKeywords := uppercaseKeywords;
  FBreakJoinOnSections := breakJoinOnSections;

  {if keywordStandardization then
    Self.KeywordMapping := StandardKeywordRemapping.Instance;
  Self.ErrorOutputPrefix := (Interfaces.MessagingConstants.FormatErrorDefaultMessage
    + Environment.NewLine);  }
end;

(*function TSQLFormatter.GetIndentString: string;
begin
  Result := FIndentString;
end;

procedure TSQLFormatter.SetIndentString(Value: string);
begin
  FIndentString := Value //StringReplace(Value, '\\s', ' ', [rfReplaceAll]);
  //FIndentString := StringReplace(FIndentString, '\\t', CHR_TAB, [rfReplaceAll]);
end;*)

function TSQLFormatter.FormatSQLTree(SQLParseTree: TSQLParseTree): string;
var
  RootList: IXMLNodeList;
  SQLFormatterState: TSQLFormatterState;
begin
  SQLFormatterState := TSQLFormatterState.Create(FIndentString, FSpacesPerTab, FMaxLineWidth, 0);
  if Assigned(SQLParseTree.SelectSingleNode(System.SysUtils.Format('/%s/@%s[.=1]', [XMLConstants.XML_SQL_ROOT, XMLConstants.XML_ERRORFOUND]))) then
 // if SQLParseTree.ErrorFound then
    SQLFormatterState.AddOutputContent(XMLConstants.PARSING_ERRORS_FOUND);

  RootList := SQLParseTree.SelectNodes(SysUtils.Format('/%s/*', [XMLConstants.XML_SQL_ROOT]));

  ProcessSqlNodeList(RootList, SQLFormatterState);
  WhiteSpaceBreakAsExpected(SQLFormatterState);

  Result := SQLFormatterState.OutputToString;
end;

procedure TSQLFormatter.ProcessSqlNodeList(RootList: IXMLNodeList; State: TSQLFormatterState);
var
  i: Integer;
  XMLElement: IXMLElement;
begin
  for i := 0 to RootList.Count - 1 do
  begin
    XMLElement := IXMLElement(RootList[i]);
    ProcessSqlNode(XMLElement, State);
  end;
end;
(*
procedure TSQLFormatter.ProcessSqlNodeList(RootList: TList; State: TSQLFormatterState);
var
  i: Integer;
begin
  for i := 0 to RootList.Count - 1 do
    ProcessSqlNode(IXMLNode(RootList[i]), State);
end; *)

procedure TSQLFormatter.ProcessSqlNode(ContentElement: IXMLElement; State: TSQLFormatterState);
var
  InitialIndent: Integer;
  InnerState: TSQLFormatterState;
  Regex: TRegex;
  OutValue: string;
  TempNode: IXMLNode;
begin
  InitialIndent := State.IndentLevel;

  if ContentElement.NodeName = XMLConstants.XML_SQL_STATEMENT then
  begin
    WhiteSpaceSeparateStatements(ContentElement, State);
    State.ResetKeywords();
    ProcessSqlNodeList(ContentElement.SelectNodes('*'), State);
    State.StatementBreakExpected := True;
  end
  else
  if ContentElement.NodeName = XMLConstants.XML_SQL_CLAUSE then
  begin
    State.UnIndentInitialBreak := True;
    ProcessSqlNodeList(ContentElement.ChildNodes, State.IncrementIndent);
    State.DecrementIndent;
    State.BreakExpected := True;
  end
  else
  if ContentElement.NodeName = XMLConstants.XML_SET_OPERATOR_CLAUSE then
  begin
    State.DecrementIndent;
    State.WhiteSpaceBreakToNextLine; //this is the one already recommended by the start of the clause
    State.WhiteSpaceBreakToNextLine; //this is the one we additionally want to apply
    ProcessSqlNodeList(ContentElement.SelectNodes('*'), State.IncrementIndent);
    State.BreakExpected := True;
    State.AdditionalBreakExpected := True;
  end
  else
  if ContentElement.NodeName = XMLConstants.XML_BATCH_SEPARATOR then
  begin
    //newline regardless of whether previous element recommended a break or not.
    State.WhiteSpaceBreakToNextLine;
    ProcessSqlNodeList(ContentElement.SelectNodes('*'), State);
    State.BreakExpected := True;
  end
  else
  if (ContentElement.NodeName = XMLConstants.XML_DDL_PROCEDURAL_BLOCK) or
     (ContentElement.NodeName = XMLConstants.XML_DDL_OTHER_BLOCK) or
     (ContentElement.NodeName = XMLConstants.XML_CURSOR_DECLARATION) or
     (ContentElement.NodeName = XMLConstants.XML_BEGIN_TRANSACTION) or
     (ContentElement.NodeName = XMLConstants.XML_SAVE_TRANSACTION) or
     (ContentElement.NodeName = XMLConstants.XML_COMMIT_TRANSACTION) or
     (ContentElement.NodeName = XMLConstants.XML_ROLLBACK_TRANSACTION) or
     (ContentElement.NodeName = XMLConstants.XML_CONTAINER_OPEN) or
     (ContentElement.NodeName = XMLConstants.XML_CONTAINER_CLOSE) or
     (ContentElement.NodeName = XMLConstants.XML_WHILE_LOOP) or
     (ContentElement.NodeName = XMLConstants.XML_IF_STATEMENT) or
     (ContentElement.NodeName = XMLConstants.XML_SELECTIONTARGET) or
     (ContentElement.NodeName = XMLConstants.XML_CONTAINER_GENERALCONTENT) or
     (ContentElement.NodeName = XMLConstants.XML_CTE_WITH_CLAUSE) or
     (ContentElement.NodeName = XMLConstants.XML_PERMISSIONS_BLOCK) or
     (ContentElement.NodeName = XMLConstants.XML_PERMISSIONS_DETAIL) or
     (ContentElement.NodeName = XMLConstants.XML_MERGE_CLAUSE) or
     (ContentElement.NodeName = XMLConstants.XML_MERGE_TARGET) then
  begin
    ProcessSqlNodeList(ContentElement.SelectNodes('*'), State)
  end
  else
  if (ContentElement.NodeName = XMLConstants.XML_CASE_INPUT) or
     (ContentElement.NodeName = XMLConstants.XML_BOOLEAN_EXPRESSION) or
     (ContentElement.NodeName = XMLConstants.XML_BETWEEN_LOWERBOUND) or
     (ContentElement.NodeName = XMLConstants.XML_BETWEEN_UPPERBOUND) then
  begin
    WhiteSpaceSeparateWords(State);
    ProcessSqlNodeList(ContentElement.SelectNodes('*'), State);
  end
  else
  if (ContentElement.NodeName = XMLConstants.XML_CONTAINER_SINGLESTATEMENT) or
     (ContentElement.NodeName = XMLConstants.XML_CONTAINER_MULTISTATEMENT) or
     (ContentElement.NodeName = XMLConstants.XML_MERGE_ACTION) then
  begin
    State.BreakExpected := True;
    ProcessSqlNodeList(ContentElement.SelectNodes('*'), State);
    State.StatementBreakExpected := False; //the responsibility for breaking will be with the OUTER Statement; there should be no consequence propagating out from Statements in this container;
    State.UnIndentInitialBreak := False; //if there was no word spacing after the last content Statement's clause starter, doesn't mean the unIndent should propagate to the following content!
  end
  else
  if (ContentElement.NodeName = XMLConstants.XML_PERMISSIONS_TARGET) or
     (ContentElement.NodeName = XMLConstants.XML_PERMISSIONS_RECIPIENT) or
     (ContentElement.NodeName = XMLConstants.XML_DDL_WITH_CLAUSE) or
     (ContentElement.NodeName = XMLConstants.XML_MERGE_CONDITION) or
     (ContentElement.NodeName = XMLConstants.XML_MERGE_THEN) then
  begin
    State.BreakExpected := True;
    State.UnIndentInitialBreak := True;
    ProcessSqlNodeList(ContentElement.SelectNodes('*'), State.IncrementIndent);
    State.DecrementIndent;
  end
  else
  if ContentElement.NodeName = XMLConstants.XML_JOIN_ON_SECTION then
  begin
    if FBreakJoinOnSections then
      State.BreakExpected := True;
    ProcessSqlNodeList(ContentElement.SelectNodes(XMLConstants.XML_CONTAINER_OPEN), State);
    if FBreakJoinOnSections then
      State.IncrementIndent;
    ProcessSqlNodeList(ContentElement.SelectNodes(XMLConstants.XML_CONTAINER_GENERALCONTENT), State);
    if FBreakJoinOnSections then
      State.DecrementIndent;
  end
  else
  if ContentElement.NodeName = XMLConstants.XML_CTE_ALIAS then
  begin
    State.UnIndentInitialBreak := True;
    ProcessSqlNodeList(ContentElement.SelectNodes('*'), State);
  end
  else
  if ContentElement.NodeName = XMLConstants.XML_ELSE_CLAUSE then
  begin
    ProcessSqlNodeList(ContentElement.SelectNodes(XMLConstants.XML_CONTAINER_OPEN), State.DecrementIndent);
    ProcessSqlNodeList(ContentElement.SelectNodes(XMLConstants.XML_CONTAINER_SINGLESTATEMENT), State.IncrementIndent);
  end
  else
  if (ContentElement.NodeName = XMLConstants.XML_DDL_AS_BLOCK) or
     (ContentElement.NodeName = XMLConstants.XML_CURSOR_FOR_BLOCK) then
  begin
    State.BreakExpected := True;
    ProcessSqlNodeList(ContentElement.SelectNodes(XMLConstants.XML_CONTAINER_OPEN), State.DecrementIndent);
    State.BreakExpected := True;
    ProcessSqlNodeList(ContentElement.SelectNodes(XMLConstants.XML_CONTAINER_GENERALCONTENT), State);
    State.IncrementIndent;
  end
  else
  if ContentElement.NodeName = XMLConstants.XML_TRIGGER_CONDITION then
  begin
    State.DecrementIndent;
    State.WhiteSpaceBreakToNextLine;
    ProcessSqlNodeList(ContentElement.SelectNodes('*'), State.IncrementIndent);
  end
  else
  if (ContentElement.NodeName = XMLConstants.XML_CURSOR_FOR_OPTIONS) or
     (ContentElement.NodeName = XMLConstants.XML_CTE_AS_BLOCK) then
  begin
    State.BreakExpected := True;
    ProcessSqlNodeList(ContentElement.SelectNodes(XMLConstants.XML_CONTAINER_OPEN), State.DecrementIndent);
    ProcessSqlNodeList(ContentElement.SelectNodes(XMLConstants.XML_CONTAINER_GENERALCONTENT), State.IncrementIndent);
  end
  else
  if (ContentElement.NodeName = XMLConstants.XML_DDL_RETURNS) or
     (ContentElement.NodeName = XMLConstants.XML_MERGE_USING) or
     (ContentElement.NodeName = XMLConstants.XML_MERGE_WHEN) then
  begin
    State.BreakExpected := True;
    State.UnIndentInitialBreak := True;
    ProcessSqlNodeList(ContentElement.SelectNodes('*'), State);
  end
  else
  if ContentElement.NodeName = XMLConstants.XML_BETWEEN_CONDITION then
  begin
    ProcessSqlNodeList(ContentElement.SelectNodes(XMLConstants.XML_CONTAINER_OPEN), State);
    State.IncrementIndent;
    ProcessSqlNodeList(ContentElement.SelectNodes(XMLConstants.XML_BETWEEN_LOWERBOUND), State.IncrementIndent);
    if FExpandBetweenConditions then
      State.BreakExpected := True;
    ProcessSqlNodeList(ContentElement.SelectNodes(XMLConstants.XML_CONTAINER_CLOSE), State.DecrementIndent);
    ProcessSqlNodeList(ContentElement.SelectNodes(XMLConstants.XML_BETWEEN_UPPERBOUND), State.IncrementIndent);
    State.DecrementIndent;
    State.DecrementIndent;
  end
  else
  if (ContentElement.NodeName = XMLConstants.XML_DDLDETAIL_PARENS) or
     (ContentElement.NodeName = XMLConstants.XML_FUNCTION_PARENS) then
  begin
    //simply process sub-nodes - don't add space or expect any linebreaks (but respect linebreaks if necessary)
    State.WordSeparatorExpected := False;
    WhiteSpaceBreakAsExpected(State);
    State.AddOutputContent(FormatOperator('('));
    ProcessSqlNodeList(ContentElement.SelectNodes('*'), State.IncrementIndent);
    State.DecrementIndent;
    WhiteSpaceBreakAsExpected(State);
    State.AddOutputContent(FormatOperator(')'));
    State.WordSeparatorExpected := True;
  end
  else
  if (ContentElement.NodeName = XMLConstants.XML_DDL_PARENS) or
     (ContentElement.NodeName = XMLConstants.XML_EXPRESSION_PARENS) or
     (ContentElement.NodeName = XMLConstants.XML_SELECTIONTARGET_PARENS) then
  begin
    WhiteSpaceSeparateWords(State);
    if (ContentElement.NodeName = XMLConstants.XML_EXPRESSION_PARENS) then
      State.IncrementIndent;
    State.AddOutputContent(FormatOperator('('));
    InnerState := TSQLFormatterState.Create(State);
    ProcessSqlNodeList(ContentElement.SelectNodes('*'), innerState);
    //if there was a linebreak in the parens content, or if it wanted one to follow, then put linebreaks before and after.
    if InnerState.BreakExpected or InnerState.OutputContainsLineBreak then
    begin
      if not InnerState.StartsWithBreak then
        State.WhiteSpaceBreakToNextLine;
      State.Assimilate(InnerState);
      State.WhiteSpaceBreakToNextLine;
    end
    else
      State.Assimilate(innerState);
    State.AddOutputContent(FormatOperator(')'));
    if (ContentElement.NodeName = XMLConstants.XML_EXPRESSION_PARENS) then
      State.DecrementIndent;
    State.WordSeparatorExpected := True;
  end
  else
  if (ContentElement.NodeName = XMLConstants.XML_BEGIN_END_BLOCK) or
     (ContentElement.NodeName = XMLConstants.XML_TRY_BLOCK) or
     (ContentElement.NodeName = XMLConstants.XML_CATCH_BLOCK) then
  begin
    if (ContentElement.ParentNode.NodeName = XMLConstants.XML_SQL_CLAUSE) and
       (ContentElement.ParentNode.ParentNode.NodeName = XMLConstants.XML_SQL_STATEMENT) and
       (ContentElement.ParentNode.ParentNode.ParentNode.NodeName = XMLConstants.XML_CONTAINER_SINGLEStateMENT) then
      State.DecrementIndent;
    ProcessSqlNodeList(ContentElement.SelectNodes(XMLConstants.XML_CONTAINER_OPEN), State);
    ProcessSqlNodeList(ContentElement.SelectNodes(XMLConstants.XML_CONTAINER_MULTISTATEMENT), State);
    State.DecrementIndent;
    State.BreakExpected := True;
    ProcessSqlNodeList(ContentElement.SelectNodes(XMLConstants.XML_CONTAINER_CLOSE), State);
    State.IncrementIndent;
    if (ContentElement.ParentNode.NodeName = XMLConstants.XML_SQL_CLAUSE) and
       (ContentElement.ParentNode.ParentNode.NodeName = XMLConstants.XML_SQL_STATEMENT)  and
       (ContentElement.ParentNode.ParentNode.ParentNode.NodeName = XMLConstants.XML_CONTAINER_SINGLEStateMENT) then
      State.IncrementIndent;
  end
  else
  if ContentElement.NodeName = XMLConstants.XML_CASE_STATEMENT then
  begin
    ProcessSqlNodeList(ContentElement.SelectNodes(XMLConstants.XML_CONTAINER_OPEN), State);
    State.IncrementIndent;
    ProcessSqlNodeList(ContentElement.SelectNodes(XMLConstants.XML_CASE_INPUT), State);
    ProcessSqlNodeList(ContentElement.SelectNodes(XMLConstants.XML_CASE_WHEN), State);
    ProcessSqlNodeList(ContentElement.SelectNodes(XMLConstants.XML_CASE_ELSE), State);
    if FExpandCaseStatements then
        State.BreakExpected := True;
    ProcessSqlNodeList(ContentElement.SelectNodes(XMLConstants.XML_CONTAINER_CLOSE), State);
    State.DecrementIndent;
  end
  else
  if (ContentElement.NodeName = XMLConstants.XML_CASE_WHEN) or
     (ContentElement.NodeName = XMLConstants.XML_CASE_THEN) or
     (ContentElement.NodeName = XMLConstants.XML_CASE_ELSE) then
  begin
    if FExpandCaseStatements then
      State.BreakExpected := True;
    ProcessSqlNodeList(ContentElement.SelectNodes(XMLConstants.XML_CONTAINER_OPEN), State);
    ProcessSqlNodeList(ContentElement.SelectNodes(XMLConstants.XML_CONTAINER_GENERALCONTENT), State.IncrementIndent);
    ProcessSqlNodeList(ContentElement.SelectNodes(XMLConstants.XML_CASE_THEN), State);
    State.DecrementIndent;
  end
  else
  if (ContentElement.NodeName = XMLConstants.XML_AND_OPERATOR) or
     (ContentElement.NodeName = XMLConstants.XML_OR_OPERATOR) then
  begin
    if FExpandBooleanExpressions then
      State.BreakExpected := True;
    ProcessSqlNodeList(ContentElement.SelectNodes('*'), State);
  end
  else
  if ContentElement.NodeName = XMLConstants.XML_COMMENT_MULTILINE then
  begin
    WhiteSpaceSeparateComment(ContentElement, State);
    State.AddOutputContent('/*' + ContentElement.Text + '*/');
    RegEx := TRegEx.Create('(\r|\n)+');
    TempNode := ContentElement.NextSibling;
    if (ContentElement.ParentNode.NodeName = XMLConstants.XML_SQL_STATEMENT) or
       ( Assigned(TempNode) and
        (TempNode.NodeName = XMLConstants.XML_WHITESPACE) and
        Regex.IsMatch(TempNode.Text) ) then
        //if this block comment is at the start or end of a Statement, or if it was followed by a
        // linebreak before any following content, then break here.
      State.BreakExpected := True
    else
      State.WordSeparatorExpected := True;
  end
  else
  if ContentElement.NodeName = XMLConstants.XML_COMMENT_SINGLELINE then
  begin
    WhiteSpaceSeparateComment(ContentElement, State);
    State.AddOutputContent('--' + ContentElement.Text); // StringReplace(StringReplace(ContentElement.Text, '\r', '', [rfReplaceAll]), '\n', '', [rfReplaceAll]));
    State.BreakExpected := True;
    State.SourceBreakPending := True;
  end
  else
  if (ContentElement.NodeName = XMLConstants.XML_STRING) or
     (ContentElement.NodeName = XMLConstants.XML_NSTRING) then
  begin
    WhiteSpaceSeparateWords(State);
    OutValue := '';
    if ContentElement.NodeName = XMLConstants.XML_NSTRING then
      OutValue := 'N';
    OutValue := OutValue + ContentElement.Text;
    State.AddOutputContent(OutValue);
    State.WordSeparatorExpected := True;
  end
  else
  if ContentElement.NodeName = XMLConstants.XML_BRACKET_QUOTED_NAME then
  begin
    WhiteSpaceSeparateWords(State);
    State.AddOutputContent(ContentElement.Text);
    State.WordSeparatorExpected := True;
  end
  else
  if ContentElement.NodeName = XMLConstants.XML_QUOTED_STRING then
  begin
    WhiteSpaceSeparateWords(State);
    State.AddOutputContent(ContentElement.Text);
    State.WordSeparatorExpected := True;
  end
  else
  if ContentElement.NodeName = XMLConstants.XML_COMMA then
  begin
    //comma always ignores requested word spacing
    if FTrailingCommas then
    begin
      WhiteSpaceBreakAsExpected(State);
      State.AddOutputContent(FormatOperator(','));

      if FExpandCommaLists and
        not (Assigned(ContentElement.ParentNode) and ((ContentElement.ParentNode.NodeName = XMLConstants.XML_DDLDETAIL_PARENS) or
             (ContentElement.ParentNode.NodeName = XMLConstants.XML_FUNCTION_PARENS))) then
        State.BreakExpected := True
      else
        State.WordSeparatorExpected := True;
    end
    else
    begin
      if FExpandCommaLists and
        not (Assigned(ContentElement.ParentNode) and ((ContentElement.ParentNode.NodeName = XMLConstants.XML_DDLDETAIL_PARENS) or
             (ContentElement.ParentNode.NodeName = XMLConstants.XML_FUNCTION_PARENS))) then
      begin
        State.WhiteSpaceBreakToNextLine;
        State.AddOutputContent(FormatOperator(','));
        if FSpaceAfterExpandedComma then
          State.WordSeparatorExpected := True;
      end
      else
      begin
        WhiteSpaceBreakAsExpected(State);
        State.AddOutputContent(FormatOperator(','));
        State.WordSeparatorExpected := True;
      end;
    end
  end
  else
  if (ContentElement.NodeName = XMLConstants.XML_PERIOD) or
     (ContentElement.NodeName = XMLConstants.XML_SEMICOLON) or
     (ContentElement.NodeName = XMLConstants.XML_SCOPERESOLUTIONOPERATOR) then
  begin
    //always ignores requested word spacing, and doesn't request a following space either.
    State.WordSeparatorExpected := False;
    WhiteSpaceBreakAsExpected(State);
    State.AddOutputContent(FormatOperator(ContentElement.Text));
  end
  else
  if (ContentElement.NodeName = XMLConstants.XML_ASTERISK) or
     (ContentElement.NodeName = XMLConstants.XML_EQUALSSIGN) or
     (ContentElement.NodeName = XMLConstants.XML_ALPHAOPERATOR) or
     (ContentElement.NodeName = XMLConstants.XML_OTHEROPERATOR) then
  begin
    WhiteSpaceSeparateWords(State);
    State.AddOutputContent(FormatOperator(ContentElement.Text));
    State.WordSeparatorExpected := True;
  end
  else
  if ContentElement.NodeName = XMLConstants.XML_COMPOUNDKEYWORD then
  begin
    WhiteSpaceSeparateWords(State);
    State.SetRecentKeyword(ContentElement.Attributes[XMLConstants.XML_SIMPLETEXT]);
    State.AddOutputContent(FormatKeyword(contentElement.Attributes[XMLConstants.XML_SIMPLETEXT]));

    State.WordSeparatorExpected := True;
    ProcessSqlNodeList(ContentElement.SelectNodes(XMLConstants.XML_COMMENT_MULTILINE + ' | ' + XMLConstants.XML_COMMENT_SINGLELINE), State.IncrementIndent);
    State.DecrementIndent;
    State.WordSeparatorExpected := True;
  end
  else
  if (ContentElement.NodeName = XMLConstants.XML_OTHERKEYWORD) or
     (ContentElement.NodeName = XMLConstants.XML_DATATYPE_KEYWORD) then
  begin
    WhiteSpaceSeparateWords(State);
    State.SetRecentKeyword(ContentElement.Text);
    State.AddOutputContent(FormatKeyword(ContentElement.Text));
    State.WordSeparatorExpected := True;
  end
  else
  if ContentElement.NodeName = XMLConstants.XML_PSEUDONAME then
  begin
    WhiteSpaceSeparateWords(State);
    State.AddOutputContent(FormatKeyword(ContentElement.Text));
    State.WordSeparatorExpected := True;
  end
  else
  if ContentElement.NodeName = XMLConstants.XML_FUNCTION_KEYWORD then
  begin
    WhiteSpaceSeparateWords(State);
    State.SetRecentKeyword(ContentElement.Text);
    State.AddOutputContent(ContentElement.Text);
    State.WordSeparatorExpected := True;
  end
  else
  if (ContentElement.NodeName = XMLConstants.XML_OTHERNODE) or
     (ContentElement.NodeName = XMLConstants.XML_MONETARY_VALUE) or
     (ContentElement.NodeName = XMLConstants.XML_LABEL) then
  begin
    WhiteSpaceSeparateWords(State);
    State.AddOutputContent(ContentElement.Text);
    State.WordSeparatorExpected := True;
  end
  else
  if ContentElement.NodeName = XMLConstants.XML_NUMBER_VALUE then
  begin
    WhiteSpaceSeparateWords(State);
    State.AddOutputContent(LowerCase(ContentElement.Text));
    State.WordSeparatorExpected := True;
  end
  else
  if ContentElement.NodeName = XMLConstants.XML_BINARY_VALUE then
  begin
    WhiteSpaceSeparateWords(State);
    State.AddOutputContent('0x');
    State.AddOutputContent(UpperCase(Copy(ContentElement.Text, 1, 2)));
    State.WordSeparatorExpected := True;
  end
  else
  if ContentElement.NodeName = XMLConstants.XML_WHITESPACE then
  begin
    //take note if it's a line-breaking space, but don't DO anything here
    if Regex.IsMatch(ContentElement.Text, '(\r|\n)+') then
        State.SourceBreakPending := True;
  end
  else
    raise Exception.Create('Unrecognized element in SQL XML!');

  if InitialIndent <> State.IndentLevel then
    raise Exception.Create('Messed up the indenting!');

end;

function TSQLFormatter.FormatKeyword(Keyword: string): string;
begin
  //if not KeywordMapping.TryGetValue(Keyword, Result)) then
  Result := Keyword;

  if FUppercaseKeywords then
    Result := UpperCase(Result)
  else
    Result := LowerCase(Result);
end;

function TSQLFormatter.FormatOperator(OperatorValue: string): string;
begin
  Result := OperatorValue;
  if FUppercaseKeywords then
    Result := UpperCase(Result)
  else
    Result := LowerCase(Result);
end;

procedure TSQLFormatter.WhiteSpaceSeparateStatements(ContentElement: IXMLElement; State: TSQLFormatterState);
var
  ThisClauseStarter: IXMLElement;
begin
  if State.StatementBreakExpected then
  begin
    //check whether this is a DECLARE/SET clause with similar precedent, and therefore exempt from double-linebreak.
    ThisClauseStarter := FirstSemanticElementChild(ContentElement);
    if not (Assigned(ThisClauseStarter) and
        (ThisClauseStarter.NodeName = XMLConstants.XML_OTHERKEYWORD) and
        (State.GetRecentKeyword <> '') and
        ( ((UpperCase(ThisClauseStarter.Text) = 'SET') and (State.GetRecentKeyword = 'SET')) or
          ((UpperCase(ThisClauseStarter.Text) = 'DECLARE') and (State.GetRecentKeyword = 'DECLARE')) or
          ((UpperCase(ThisClauseStarter.Text) = 'PRINT') and (State.GetRecentKeyword = 'PRINT')) ) ) then
      State.AddOutputLineBreak;

    State.AddOutputLineBreak;
    State.Indent(State.IndentLevel);
    State.BreakExpected := False;
    State.SourceBreakPending := False;
    State.StatementBreakExpected := False;
    State.WordSeparatorExpected := False;
  end;
end;

function TSQLFormatter.FirstSemanticElementChild(ContentElement: IXMLElement): IXMLElement;
begin
  Result := nil;
  while Assigned(ContentElement) do
  begin
    Result := IXMLElement(ContentElement.SelectSingleNode(SysUtils.Format('*[local-name != ''%s'' and local-name != ''%s'' and local-name != ''%s'']',
      [XMLConstants.XML_WHITESPACE, XMLConstants.XML_COMMENT_MULTILINE, XMLConstants.XML_COMMENT_SINGLELINE])));

    if Assigned(Result) and
      ( (Result.NodeName = XMLConstants.XML_SQL_CLAUSE) or
        (Result.NodeName = XMLConstants.XML_DDL_PROCEDURAL_BLOCK) or
        (Result.NodeName = XMLConstants.XML_DDL_OTHER_BLOCK) or
        (Result.NodeName = XMLConstants.XML_DDL_DECLARE_BLOCK)) then
      ContentElement := Result
    else
      ContentElement := nil;
  end;
end;

procedure TSQLFormatter.WhiteSpaceSeparateWords(State: TSQLFormatterState);
var
  WasUnIndent: Boolean;
begin
  if State.BreakExpected or State.AdditionalBreakExpected then
  begin
    WasUnIndent := State.UnIndentInitialBreak;
    if WasUnIndent then
      State.DecrementIndent;
    WhiteSpaceBreakAsExpected(State);
    if WasUnIndent then
      State.IncrementIndent;
  end
  else
  if State.WordSeparatorExpected then
    State.AddOutputSpace;
  State.UnIndentInitialBreak := False;
  State.SourceBreakPending := False;
  State.WordSeparatorExpected := False;
end;

procedure TSQLFormatter.WhiteSpaceSeparateComment(ContentElement: IXMLElement; State: TSQLFormatterState);
begin
  if State.CurrentLineHasContent and State.SourceBreakPending then
  begin
    State.BreakExpected := True;
    WhiteSpaceBreakAsExpected(State);
  end
  else
  if State.WordSeparatorExpected then
    State.AddOutputSpace;
  State.SourceBreakPending := False;
  State.WordSeparatorExpected := False;
end;

procedure TSQLFormatter.WhiteSpaceBreakAsExpected(State: TSQLFormatterState);
begin
  if State.BreakExpected then
    State.WhiteSpaceBreakToNextLine;
  if State.AdditionalBreakExpected then
  begin
    State.WhiteSpaceBreakToNextLine;
    State.AdditionalBreakExpected := False;
  end;
end;

end.

