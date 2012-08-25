unit SQLFormatter;

interface

uses
  SysUtils, RegularExpressions, Classes, Generics.Collections, SQLParseTree, XMLIntf;

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

//    KeywordMapping: TDictionary<string, string>;

    function GetIndentString: string;
    procedure SetIndentString(Value: string);
  //public
  //  KeywordMapping: IDictionary<GenericFormalParam, (2712-2718),GenericFormalParam, (2720-2726)>;
    procedure ProcessSqlNodeList(RootList: IXMLNodeList; State: TSQLFormatterState); //overload;
    //procedure ProcessSqlNodeList(RootList: TList; State: TSQLFormatterState); overload;
    procedure ProcessSqlNode(ContentElement: IXMLNode; State: TSQLFormatterState);
//    function ExtracIXMLBetween(StartingElement: IXMLNode; EndingElement: IXMLNode): IXMLNode;
    function FormatKeyword(Keyword: string): string;
    function FormatOperator(OperatorValue: string): string;
    procedure WhiteSpaceSeparateStatements(ContentElement: IXMLNode; State: TSQLFormatterState);
    function FirstSemanticElementChild(ContentElement: IXMLNode): IXMLNode;
    procedure WhiteSpaceSeparateWords(State: TSQLFormatterState);
    procedure WhiteSpaceSeparateComment(ContentElement: IXMLNode; State: TSQLFormatterState);
    procedure WhiteSpaceBreakAsExpected(State: TSQLFormatterState);
  public
    constructor Create; overload;
    constructor Create(indentString: string; spacesPerTab: Integer; maxLineWidth: Integer;
      expandCommaLists: Boolean; trailingCommas: Boolean; spaceAfterExpandedComma: Boolean;
      expandBooleanExpressions: Boolean; expandCaseStatements: Boolean; expandBetweenConditions: Boolean;
      breakJoinOnSections: Boolean; uppercaseKeywords: Boolean; keywordStandardization: Boolean); overload;
    function FormatSQL(SQL: string): string;

    property IndentString: string read GetIndentString write SetIndentString;
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

implementation

uses
  SQLParser, StrUtils, Common, SQLConstants;

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
  Create(CHR_TAB, 4, 999, True, False, False, True, True, True, False, True, False);
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

function TSQLFormatter.GetIndentString: string;
begin
  Result := FIndentString;
end;

procedure TSQLFormatter.SetIndentString(Value: string);
begin
  FIndentString := StringReplace(Value, '\t', CHR_TAB, [rfReplaceAll]);
end;

function TSQLFormatter.FormatSQL(SQL: string): string;
var
  SQLParser: TSQLParser;
  SQLParseTree: TSQLParseTree;
  //SkippedXML: IXMLNode;
  //TempFormatter: TSqlIdentityFormatter;
  RootList: IXMLNodeList;
  State: TSQLFormatterState;
  RootNode: IXMLNode;
begin
  SQLParser := TSQLParser.Create;
  SQLParseTree := SQLParser.CreateSQLParseTree(SQL);

  State := TSQLFormatterState.Create(FIndentString, FSpacesPerTab, FMaxLineWidth, 0);
  if SQLParseTree.ErrorFound then
    state.AddOutputContent(SQLConstants.PARSING_ERRORS_FOUND);

  RootNode := SQLParseTree.DocumentElement; // FindNamedNode(SQLConstants.ENAME_SQL_ROOT);
 //showmessage(RootNode.NodeName);
 // showmessage(RootNode.ChildNodes[0].NodeName);
 // showmessage(RootNode.ChildNodes[0].ChildNodes[1].NodeName);
  //RootNode.SelectNodes(Format('/{%s}/*', [SQLConstants.ENAME_SQL_ROOT]), RootList);
  RootList := SelectNodes(RootNode, Format('/%s/*', [SQLConstants.ENAME_SQL_ROOT]));

  ProcessSqlNodeList(RootList, State);
  WhiteSpaceBreakAsExpected(State);

  {SkippedXml := ExtracIXMLBetween(State.RegionStartNode, SQLParseTree.DocumentElement);
  TempFormatter := TSqlIdentityFormatter.Create;
  State.AddOutputContent(TempFormatter.FormatSQLTree(SkippedXml)); }

  Result := State.OutputToString;
end;

procedure TSQLFormatter.ProcessSqlNodeList(RootList: IXMLNodeList; State: TSQLFormatterState);
var
  i: Integer;
  Node: IXMLNode;
begin
  for i := 0 to RootList.Count - 1 do
  begin
    Node := RootList[i];
    ProcessSqlNode(Node, State);
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

procedure TSQLFormatter.ProcessSqlNode(ContentElement: IXMLNode; State: TSQLFormatterState);
var
  InitialIndent: Integer;
  InnerState: TSQLFormatterState;
  Regex: TRegex;
  OutValue: string;
  NodeList: IXMLNodeList;
  TempNode: IXMLNode;
begin
  InitialIndent := State.IndentLevel;
  if ContentElement.NodeName = SQLConstants.ENAME_SQL_STATEMENT then
  begin
    WhiteSpaceSeparateStatements(ContentElement, State);
    State.ResetKeywords();
    NodeList := SelectNodes(ContentElement, '*');
    ProcessSQLNodeList(NodeList, State);
    State.StatementBreakExpected := True;
  end
  else
  if ContentElement.NodeName = SQLConstants.ENAME_SQL_CLAUSE then
  begin
    State.UnIndentInitialBreak := True;
    ProcessSqlNodeList(ContentElement.ChildNodes, State.IncrementIndent);
    State.DecrementIndent;
    State.BreakExpected := True;
  end
  else
  if ContentElement.NodeName = SQLConstants.ENAME_SET_OPERATOR_CLAUSE then
  begin
    State.DecrementIndent;
    State.WhiteSpaceBreakToNextLine; //this is the one already recommended by the start of the clause
    State.WhiteSpaceBreakToNextLine; //this is the one we additionally want to apply
    NodeList.Clear;
    NodeList := SelectNodes(ContentElement, '*');
    ProcessSqlNodeList(NodeList, State.IncrementIndent);
    State.BreakExpected := True;
    State.AdditionalBreakExpected := True;
  end
  else
  if ContentElement.NodeName = SQLConstants.ENAME_BATCH_SEPARATOR then
  begin
    //newline regardless of whether previous element recommended a break or not.
    State.WhiteSpaceBreakToNextLine;
    NodeList.Clear;
    NodeList := SelectNodes(ContentElement, '*');
    ProcessSqlNodeList(NodeList, State);
    State.BreakExpected := True;
  end
  else
  if (ContentElement.NodeName = SQLConstants.ENAME_DDL_PROCEDURAL_BLOCK) or
     (ContentElement.NodeName = SQLConstants.ENAME_DDL_OTHER_BLOCK) or
     (ContentElement.NodeName = SQLConstants.ENAME_CURSOR_DECLARATION) or
     (ContentElement.NodeName = SQLConstants.ENAME_BEGIN_TRANSACTION) or
     (ContentElement.NodeName = SQLConstants.ENAME_SAVE_TRANSACTION) or
     (ContentElement.NodeName = SQLConstants.ENAME_COMMIT_TRANSACTION) or
     (ContentElement.NodeName = SQLConstants.ENAME_ROLLBACK_TRANSACTION) or
     (ContentElement.NodeName = SQLConstants.ENAME_CONTAINER_OPEN) or
     (ContentElement.NodeName = SQLConstants.ENAME_CONTAINER_CLOSE) or
     (ContentElement.NodeName = SQLConstants.ENAME_WHILE_LOOP) or
     (ContentElement.NodeName = SQLConstants.ENAME_IF_StateMENT) or
     (ContentElement.NodeName = SQLConstants.ENAME_SELECTIONTARGET) or
     (ContentElement.NodeName = SQLConstants.ENAME_CONTAINER_GENERALCONTENT) or
     (ContentElement.NodeName = SQLConstants.ENAME_CTE_WITH_CLAUSE) or
     (ContentElement.NodeName = SQLConstants.ENAME_PERMISSIONS_BLOCK) or
     (ContentElement.NodeName = SQLConstants.ENAME_PERMISSIONS_DETAIL) or
     (ContentElement.NodeName = SQLConstants.ENAME_MERGE_CLAUSE) or
     (ContentElement.NodeName = SQLConstants.ENAME_MERGE_TARGET) then
  begin
    NodeList.Clear;
    NodeList := SelectNodes(ContentElement, '*');
    ProcessSqlNodeList(NodeList, State)
  end
  else
  if (ContentElement.NodeName = SQLConstants.ENAME_CASE_INPUT) or
     (ContentElement.NodeName = SQLConstants.ENAME_BOOLEAN_EXPRESSION) or
     (ContentElement.NodeName = SQLConstants.ENAME_BETWEEN_LOWERBOUND) or
     (ContentElement.NodeName = SQLConstants.ENAME_BETWEEN_UPPERBOUND) then
  begin
    WhiteSpaceSeparateWords(State);
    NodeList.Clear;
    NodeList := SelectNodes(ContentElement, '*');
    ProcessSqlNodeList(NodeList, State);
  end
  else
  if (ContentElement.NodeName = SQLConstants.ENAME_CONTAINER_SINGLEStateMENT) or
     (ContentElement.NodeName = SQLConstants.ENAME_CONTAINER_MULTIStateMENT) or
     (ContentElement.NodeName = SQLConstants.ENAME_MERGE_ACTION) then
  begin
    State.BreakExpected := True;
    NodeList.Clear;
    NodeList := SelectNodes(ContentElement, '*');
    ProcessSqlNodeList(NodeList, State);
    State.StatementBreakExpected := False; //the responsibility for breaking will be with the OUTER Statement; there should be no consequence propagating out from Statements in this container;
    State.UnIndentInitialBreak := False; //if there was no word spacing after the last content Statement's clause starter, doesn't mean the unIndent should propagate to the following content!
  end
  else
  if (ContentElement.NodeName = SQLConstants.ENAME_PERMISSIONS_TARGET) or
     (ContentElement.NodeName = SQLConstants.ENAME_PERMISSIONS_RECIPIENT) or
     (ContentElement.NodeName = SQLConstants.ENAME_DDL_WITH_CLAUSE) or
     (ContentElement.NodeName = SQLConstants.ENAME_MERGE_CONDITION) or
     (ContentElement.NodeName = SQLConstants.ENAME_MERGE_THEN) then
  begin
    State.BreakExpected := True;
    State.UnIndentInitialBreak := True;
    NodeList.Clear;
    NodeList := SelectNodes(ContentElement, '*');
    ProcessSqlNodeList(NodeList, State.IncrementIndent);
    State.DecrementIndent;
  end
  else
  if ContentElement.NodeName = SQLConstants.ENAME_JOIN_ON_SECTION then
  begin
    if FBreakJoinOnSections then
      State.BreakExpected := True;
    NodeList.Clear;
    NodeList := SelectNodes(ContentElement, SQLConstants.ENAME_CONTAINER_OPEN);
    ProcessSqlNodeList(NodeList, State);
    if FBreakJoinOnSections then
      State.IncrementIndent;
    NodeList.Clear;
    NodeList := SelectNodes(ContentElement, SQLConstants.ENAME_CONTAINER_GENERALCONTENT);
    ProcessSqlNodeList(NodeList, State);
    if FBreakJoinOnSections then
      State.DecrementIndent;
  end
  else
  if ContentElement.NodeName = SQLConstants.ENAME_CTE_ALIAS then
  begin
    State.UnIndentInitialBreak := True;
    NodeList.Clear;
    NodeList := SelectNodes(ContentElement, '*');
    ProcessSqlNodeList(NodeList, State);
  end
  else
  if ContentElement.NodeName = SQLConstants.ENAME_ELSE_CLAUSE then
  begin
    NodeList := SelectNodes(ContentElement, SQLConstants.ENAME_CONTAINER_OPEN);
    ProcessSqlNodeList(NodeList, State.DecrementIndent);
    NodeList := SelectNodes(ContentElement, SQLConstants.ENAME_CONTAINER_SINGLESTATEMENT);
    ProcessSqlNodeList(NodeList, State.IncrementIndent);
  end
  else
  if (ContentElement.NodeName = SQLConstants.ENAME_DDL_AS_BLOCK) or
     (ContentElement.NodeName = SQLConstants.ENAME_CURSOR_FOR_BLOCK) then
  begin
    State.BreakExpected := True;
    NodeList.Clear;
    NodeList := SelectNodes(ContentElement, SQLConstants.ENAME_CONTAINER_OPEN);
    ProcessSqlNodeList(NodeList, State.DecrementIndent);
    State.BreakExpected := True;
    NodeList.Clear;
    NodeList := SelectNodes(ContentElement, SQLConstants.ENAME_CONTAINER_GENERALCONTENT);
    ProcessSqlNodeList(NodeList, State);
    State.IncrementIndent;
  end
  else
  if ContentElement.NodeName = SQLConstants.ENAME_TRIGGER_CONDITION then
  begin
    State.DecrementIndent;
    State.WhiteSpaceBreakToNextLine;
    NodeList.Clear;
    NodeList := SelectNodes(ContentElement, '*');
    ProcessSqlNodeList(NodeList, State.IncrementIndent);
  end
  else
  if (ContentElement.NodeName = SQLConstants.ENAME_CURSOR_FOR_OPTIONS) or
     (ContentElement.NodeName = SQLConstants.ENAME_CTE_AS_BLOCK) then
  begin
    State.BreakExpected := True;
    NodeList.Clear;
    NodeList := SelectNodes(ContentElement, SQLConstants.ENAME_CONTAINER_OPEN);
    ProcessSqlNodeList(NodeList, State.DecrementIndent);
    NodeList.Clear;
    NodeList := SelectNodes(ContentElement, SQLConstants.ENAME_CONTAINER_GENERALCONTENT);
    ProcessSqlNodeList(NodeList, State.IncrementIndent);
  end
  else
  if (ContentElement.NodeName = SQLConstants.ENAME_DDL_RETURNS) or
     (ContentElement.NodeName = SQLConstants.ENAME_MERGE_USING) or
     (ContentElement.NodeName = SQLConstants.ENAME_MERGE_WHEN) then
  begin
    State.BreakExpected := True;
    State.UnIndentInitialBreak := True;
    NodeList.Clear;
    NodeList := SelectNodes(ContentElement, '*');
    ProcessSqlNodeList(NodeList, State);
  end
  else
  if ContentElement.NodeName = SQLConstants.ENAME_BETWEEN_CONDITION then
  begin
    NodeList.Clear;
    NodeList := SelectNodes(ContentElement, SQLConstants.ENAME_CONTAINER_OPEN);
    ProcessSqlNodeList(NodeList, State);
    State.IncrementIndent;
    NodeList.Clear;
    NodeList := SelectNodes(ContentElement, SQLConstants.ENAME_BETWEEN_LOWERBOUND);
    ProcessSqlNodeList(NodeList, State.IncrementIndent);
    if FExpandBetweenConditions then
      State.BreakExpected := True;
    NodeList.Clear;
    NodeList := SelectNodes(ContentElement, SQLConstants.ENAME_CONTAINER_CLOSE);
    ProcessSqlNodeList(NodeList, State.DecrementIndent);
    NodeList.Clear;
    NodeList := SelectNodes(ContentElement, SQLConstants.ENAME_BETWEEN_UPPERBOUND);
    ProcessSqlNodeList(NodeList, State.IncrementIndent);
    State.DecrementIndent;
    State.DecrementIndent;
  end
  else
  if (ContentElement.NodeName = SQLConstants.ENAME_DDLDETAIL_PARENS) or
     (ContentElement.NodeName = SQLConstants.ENAME_FUNCTION_PARENS) then
  begin
    //simply process sub-nodes - don't add space or expect any linebreaks (but respect linebreaks if necessary)
    State.WordSeparatorExpected := False;
    WhiteSpaceBreakAsExpected(State);
    State.AddOutputContent(FormatOperator('('));
    NodeList.Clear;
    NodeList := SelectNodes(ContentElement, '*');
    ProcessSqlNodeList(NodeList, State.IncrementIndent);
    State.DecrementIndent;
    WhiteSpaceBreakAsExpected(State);
    State.AddOutputContent(FormatOperator(')'));
    State.WordSeparatorExpected := True;
  end
  else
  if (ContentElement.NodeName = SQLConstants.ENAME_DDL_PARENS) or
     (ContentElement.NodeName = SQLConstants.ENAME_EXPRESSION_PARENS) or
     (ContentElement.NodeName = SQLConstants.ENAME_SELECTIONTARGET_PARENS) then
  begin
    WhiteSpaceSeparateWords(State);
    if (ContentElement.NodeName = SQLConstants.ENAME_EXPRESSION_PARENS) then
      State.IncrementIndent;
    State.AddOutputContent(FormatOperator('('));
    InnerState := TSQLFormatterState.Create(State);
    NodeList.Clear;
    NodeList := SelectNodes(ContentElement, '*');
    ProcessSqlNodeList(NodeList, innerState);
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
    if (ContentElement.NodeName = SQLConstants.ENAME_EXPRESSION_PARENS) then
      State.DecrementIndent;
    State.WordSeparatorExpected := True;
  end
  else
  if (ContentElement.NodeName = SQLConstants.ENAME_BEGIN_END_BLOCK) or
     (ContentElement.NodeName = SQLConstants.ENAME_TRY_BLOCK) or
     (ContentElement.NodeName = SQLConstants.ENAME_CATCH_BLOCK) then
  begin
    if (ContentElement.ParentNode.NodeName = SQLConstants.ENAME_SQL_CLAUSE) and
       (ContentElement.ParentNode.ParentNode.NodeName = SQLConstants.ENAME_SQL_STATEMENT) and
       (ContentElement.ParentNode.ParentNode.ParentNode.NodeName = SQLConstants.ENAME_CONTAINER_SINGLEStateMENT) then
      State.DecrementIndent;
    NodeList.Clear;
    NodeList := SelectNodes(ContentElement, SQLConstants.ENAME_CONTAINER_OPEN);
    ProcessSqlNodeList(NodeList, State);
    NodeList.Clear;
    NodeList := SelectNodes(ContentElement, SQLConstants.ENAME_CONTAINER_MULTISTATEMENT);
    ProcessSqlNodeList(NodeList, State);
    State.DecrementIndent;
    State.BreakExpected := True;
    NodeList.Clear;
    NodeList := SelectNodes(ContentElement, SQLConstants.ENAME_CONTAINER_CLOSE);
    ProcessSqlNodeList(NodeList, State);
    State.IncrementIndent;
    if (ContentElement.ParentNode.NodeName = SQLConstants.ENAME_SQL_CLAUSE) and
       (ContentElement.ParentNode.ParentNode.NodeName = SQLConstants.ENAME_SQL_STATEMENT)  and
       (ContentElement.ParentNode.ParentNode.ParentNode.NodeName = SQLConstants.ENAME_CONTAINER_SINGLEStateMENT) then
      State.IncrementIndent;
  end
  else
  if ContentElement.NodeName = SQLConstants.ENAME_CASE_STATEMENT then
  begin
    NodeList.Clear;
    NodeList := SelectNodes(ContentElement, SQLConstants.ENAME_CONTAINER_OPEN);
    ProcessSqlNodeList(NodeList, State);
    State.IncrementIndent;
    NodeList.Clear;
    NodeList := SelectNodes(ContentElement, SQLConstants.ENAME_CASE_INPUT);
    ProcessSqlNodeList(NodeList, State);
    NodeList.Clear;
    NodeList := SelectNodes(ContentElement, SQLConstants.ENAME_CASE_WHEN);
    ProcessSqlNodeList(NodeList, State);
    NodeList.Clear;
    NodeList := SelectNodes(ContentElement, SQLConstants.ENAME_CASE_ELSE);
    ProcessSqlNodeList(NodeList, State);
    if FExpandCaseStatements then
        State.BreakExpected := True;
    NodeList.Clear;
    NodeList := SelectNodes(ContentElement, SQLConstants.ENAME_CONTAINER_CLOSE);
    ProcessSqlNodeList(NodeList, State);
    State.DecrementIndent;
  end
  else
  if (ContentElement.NodeName = SQLConstants.ENAME_CASE_WHEN) or
     (ContentElement.NodeName = SQLConstants.ENAME_CASE_THEN) or
     (ContentElement.NodeName = SQLConstants.ENAME_CASE_ELSE) then
  begin
    if FExpandCaseStatements then
      State.BreakExpected := True;
    NodeList.Clear;
    NodeList := SelectNodes(ContentElement, SQLConstants.ENAME_CONTAINER_OPEN);
    ProcessSqlNodeList(NodeList, State);
    NodeList.Clear;
    NodeList := SelectNodes(ContentElement, SQLConstants.ENAME_CONTAINER_GENERALCONTENT);
    ProcessSqlNodeList(NodeList, State.IncrementIndent);
    NodeList.Clear;
    NodeList := SelectNodes(ContentElement, SQLConstants.ENAME_CASE_THEN);
    ProcessSqlNodeList(NodeList, State);
    State.DecrementIndent;
  end
  else
  if (ContentElement.NodeName = SQLConstants.ENAME_AND_OPERATOR) or
     (ContentElement.NodeName = SQLConstants.ENAME_OR_OPERATOR) then
  begin
    if FExpandBooleanExpressions then
      State.BreakExpected := True;
    NodeList.Clear;
    NodeList := SelectNodes(ContentElement, '*');
    ProcessSqlNodeList(NodeList, State);
  end
  else
  if ContentElement.NodeName = SQLConstants.ENAME_COMMENT_MULTILINE then
  begin
    WhiteSpaceSeparateComment(ContentElement, State);
    State.AddOutputContent('/*' + ContentElement.NodeValue + '*/');
    RegEx := TRegEx.Create('(\r|\n)+');
    TempNode := ContentElement.NextSibling;
    if (ContentElement.ParentNode.NodeName = SQLConstants.ENAME_SQL_STATEMENT) or
       (not Assigned(TempNode) and
       (TempNode.NodeName = SQLConstants.ENAME_WHITESPACE) and
        Regex.IsMatch(TempNode.NodeValue)) then
        //if this block comment is at the start or end of a Statement, or if it was followed by a
        // linebreak before any following content, then break here.
      State.BreakExpected := True
    else
      State.WordSeparatorExpected := True;
  end
  else
  if ContentElement.NodeName = SQLConstants.ENAME_COMMENT_SINGLELINE then
  begin
    WhiteSpaceSeparateComment(ContentElement, State);
    State.AddOutputContent('--' + StringReplace(StringReplace(ContentElement.NodeValue, '\r', '', [rfReplaceAll]), '\n', '', [rfReplaceAll]));
    State.BreakExpected := True;
    State.SourceBreakPending := True;
  end
  else
  if (ContentElement.NodeName = SQLConstants.ENAME_STRING) or
     (ContentElement.NodeName = SQLConstants.ENAME_NSTRING) then
  begin
    WhiteSpaceSeparateWords(State);
    OutValue := '';
    if ContentElement.NodeName = SQLConstants.ENAME_NSTRING then
      OutValue := 'N';
    OutValue := OutValue + '''' + StringReplace(ContentElement.NodeValue, '''', '''''', [rfReplaceAll]) + '''';
    State.AddOutputContent(OutValue);
    State.WordSeparatorExpected := True;
  end
  else
  if ContentElement.NodeName = SQLConstants.ENAME_BRACKET_QUOTED_NAME then
  begin
    WhiteSpaceSeparateWords(State);
    State.AddOutputContent('[' + StringReplace(ContentElement.NodeValue, ']', ']]', [rfReplaceAll]) + ']');
    State.WordSeparatorExpected := True;
  end
  else
  if ContentElement.NodeName = SQLConstants.ENAME_QUOTED_STRING then
  begin
    WhiteSpaceSeparateWords(State);
    State.AddOutputContent('\"' + StringReplace(ContentElement.NodeValue, '\"', '\"\"', [rfReplaceAll]) + '\"');
    State.WordSeparatorExpected := True;
  end
  else
  if ContentElement.NodeName = SQLConstants.ENAME_COMMA then
  begin
    //comma always ignores requested word spacing
    if FTrailingCommas then
    begin
      WhiteSpaceBreakAsExpected(State);
      State.AddOutputContent(FormatOperator(','));

      if FExpandCommaLists and
        not ((ContentElement.ParentNode.NodeName = SQLConstants.ENAME_DDLDETAIL_PARENS) or
             (ContentElement.ParentNode.NodeName = SQLConstants.ENAME_FUNCTION_PARENS)) then
        State.BreakExpected := True
      else
        State.WordSeparatorExpected := True;
    end
    else
    begin
      if FExpandCommaLists and
        not ((ContentElement.ParentNode.NodeName = SQLConstants.ENAME_DDLDETAIL_PARENS) or
             (ContentElement.ParentNode.NodeName = SQLConstants.ENAME_FUNCTION_PARENS)) then
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
  if (ContentElement.NodeName = SQLConstants.ENAME_PERIOD) or
     (ContentElement.NodeName = SQLConstants.ENAME_SEMICOLON) or
     (ContentElement.NodeName = SQLConstants.ENAME_SCOPERESOLUTIONOPERATOR) then
  begin
    //always ignores requested word spacing, and doesn't request a following space either.
    State.WordSeparatorExpected := False;
    WhiteSpaceBreakAsExpected(State);
    State.AddOutputContent(FormatOperator(ContentElement.NodeValue));
  end
  else
  if (ContentElement.NodeName = SQLConstants.ENAME_ASTERISK) or
     (ContentElement.NodeName = SQLConstants.ENAME_ALPHAOPERATOR) or
     (ContentElement.NodeName = SQLConstants.ENAME_OTHEROPERATOR) then
  begin
    WhiteSpaceSeparateWords(State);
    State.AddOutputContent(FormatOperator(ContentElement.NodeValue));
    State.WordSeparatorExpected := True;
  end
  else
  if ContentElement.NodeName = SQLConstants.ENAME_COMPOUNDKEYWORD then
  begin
    WhiteSpaceSeparateWords(State);
    State.SetRecentKeyword(ContentElement.AttributeNodes.FindNode(SQLConstants.ANAME_SIMPLETEXT).NodeValue);
    State.AddOutputContent(FormatKeyword(ContentElement.AttributeNodes.FindNode(SQLConstants.ANAME_SIMPLETEXT).NodeValue));
    State.WordSeparatorExpected := True;
    NodeList.Clear;
    NodeList := SelectNodes(ContentElement, SQLConstants.ENAME_COMMENT_MULTILINE + ' | ' + SQLConstants.ENAME_COMMENT_SINGLELINE);
    ProcessSqlNodeList(NodeList, State.IncrementIndent);
    State.DecrementIndent;
    State.WordSeparatorExpected := True;
  end
  else
  if (ContentElement.NodeName = SQLConstants.ENAME_OTHERKEYWORD) or
     (ContentElement.NodeName = SQLConstants.ENAME_DATATYPE_KEYWORD) then
  begin
    WhiteSpaceSeparateWords(State);
    State.SetRecentKeyword(ContentElement.NodeValue);
    State.AddOutputContent(FormatKeyword(ContentElement.NodeValue));
    State.WordSeparatorExpected := True;
  end
  else
  if ContentElement.NodeName = SQLConstants.ENAME_PSEUDONAME then
  begin
    WhiteSpaceSeparateWords(State);
    State.AddOutputContent(FormatKeyword(ContentElement.NodeValue));
    State.WordSeparatorExpected := True;
  end
  else
  if ContentElement.NodeName = SQLConstants.ENAME_FUNCTION_KEYWORD then
  begin
    WhiteSpaceSeparateWords(State);
    State.SetRecentKeyword(ContentElement.NodeValue);
    State.AddOutputContent(ContentElement.NodeValue);
    State.WordSeparatorExpected := True;
  end
  else
  if (ContentElement.NodeName = SQLConstants.ENAME_OTHERNODE) or
     (ContentElement.NodeName = SQLConstants.ENAME_MONETARY_VALUE) or
     (ContentElement.NodeName = SQLConstants.ENAME_LABEL) then
  begin
    WhiteSpaceSeparateWords(State);
    State.AddOutputContent(ContentElement.NodeValue);
    State.WordSeparatorExpected := True;
  end
  else
  if ContentElement.NodeName = SQLConstants.ENAME_NUMBER_VALUE then
  begin
    WhiteSpaceSeparateWords(State);
    State.AddOutputContent(LowerCase(ContentElement.NodeValue));
    State.WordSeparatorExpected := True;
  end
  else
  if ContentElement.NodeName = SQLConstants.ENAME_BINARY_VALUE then
  begin
    WhiteSpaceSeparateWords(State);
    State.AddOutputContent('0x');
    State.AddOutputContent(UpperCase(Copy(ContentElement.NodeValue, 1, 2)));
    State.WordSeparatorExpected := True;
  end
  else
  if ContentElement.NodeName = SQLConstants.ENAME_WHITESPACE then
  begin
    //take note if it's a line-breaking space, but don't DO anything here
    if Regex.IsMatch(ContentElement.NodeValue, '(\r|\n)+') then
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

procedure TSQLFormatter.WhiteSpaceSeparateStatements(ContentElement: IXMLNode; State: TSQLFormatterState);
var
  ThisClauseStarter: IXMLNode;
begin
  if State.StatementBreakExpected then
  begin
    //check whether this is a DECLARE/SET clause with similar precedent, and therefore exempt from double-linebreak.
    ThisClauseStarter := FirstSemanticElementChild(ContentElement);
    if not (Assigned(ThisClauseStarter) and
        (ThisClauseStarter.NodeName = SQLConstants.ENAME_OTHERKEYWORD) and
        (State.GetRecentKeyword <> '') and
        ( ((UpperCase(ThisClauseStarter.NodeValue) = 'SET') and (State.GetRecentKeyword = 'SET')) or
          ((UpperCase(ThisClauseStarter.NodeValue) = 'DECLARE') and (State.GetRecentKeyword = 'DECLARE')) or
          ((UpperCase(ThisClauseStarter.NodeValue) = 'PRINT') and (State.GetRecentKeyword = 'PRINT')) ) ) then
      State.AddOutputLineBreak;

    State.AddOutputLineBreak;
    State.Indent(State.IndentLevel);
    State.BreakExpected := False;
    State.SourceBreakPending := False;
    State.StatementBreakExpected := False;
    State.WordSeparatorExpected := False;
  end;
end;

// todo: this ain't right!!!
function TSQLFormatter.FirstSemanticElementChild(ContentElement: IXMLNode): IXMLNode;
var
  Temp: IXMLNodeList;
begin
  Result := nil;
  while Assigned(ContentElement) do
  begin
    Temp := SelectNodes(ContentElement, Format('*[local-name != ''%s'' and local-name != ''%s'' and local-name != ''%s'']',
      [SQLConstants.ENAME_WHITESPACE, SQLConstants.ENAME_COMMENT_MULTILINE, SQLConstants.ENAME_COMMENT_SINGLELINE]));
    if Assigned(Temp) then
    begin
      Result := Temp.First;

      if Assigned(Result) and
        ( (Result.NodeName = SQLConstants.ENAME_SQL_CLAUSE) or
          (Result.NodeName = SQLConstants.ENAME_DDL_PROCEDURAL_BLOCK) or
          (Result.NodeName = SQLConstants.ENAME_DDL_OTHER_BLOCK) ) then
        ContentElement := Result
      else
        ContentElement := nil;
    end;
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

procedure TSQLFormatter.WhiteSpaceSeparateComment(ContentElement: IXMLNode; State: TSQLFormatterState);
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

(*
private XmlNode ExtracIXMLBetween(XmlNode startingElement, XmlNode endingElement)
        {
            XmlNode currentNode = startingElement;
            XmlNode previousNode = null;
            XmlNode remainder = null;
            XmlNode remainderPosition = null;

            while (currentNode != null)
            {
                if (currentNode.Equals(endingElement))
                    break;

                if (previousNode != null)
                {
                    XmlNode copyOfThisNode = currentNode.OwnerDocument.CreateNode(currentNode.NodeType, currentNode.NodeName, currentNode.NodeNamespaceURI);
                    if (currentNode.Value != null)
                        copyOfThisNode.Value = currentNode.Value;
                    if (currentNode.Attributes != null)
                        foreach (XmlAttribute attribute in currentNode.Attributes)
                        {
                            XmlAttribute newAttribute = currentNode.OwnerDocument.CreateAttribute(attribute.Prefix, attribute.LocalName, attribute.NodeNamespaceURI);
                            newAttribute.Value = attribute.Value;
                            copyOfThisNode.Attributes.Append(newAttribute);
                        }

                    if (remainderPosition == null)
                    {
                        remainderPosition = copyOfThisNode;
                        remainder = copyOfThisNode;
                    }
                    else if (currentNode.Equals(previousNode.ParentNode) and remainderPosition.ParentNode != null)
                    {
                        remainderPosition = remainderPosition.ParentNode;
                    }
                    else if (currentNode.Equals(previousNode.ParentNode) and remainderPosition.ParentNode == null)
                    {
                        copyOfThisNode.AppendChild(remainderPosition);
                        remainderPosition = copyOfThisNode;
                        remainder = copyOfThisNode;
                    }
                    else if (currentNode.Equals(previousNode.NextSibling) and remainderPosition.ParentNode != null)
                    {
                        remainderPosition.ParentNode.AppendChild(copyOfThisNode);
                        remainderPosition = copyOfThisNode;
                    }
                    else if (currentNode.Equals(previousNode.NextSibling) and remainderPosition.ParentNode == null)
                    {
                        XmlNode copyOfThisNodesParent = currentNode.OwnerDocument.CreateNode(currentNode.ParentNode.NodeType, currentNode.ParentNode.NodeName, currentNode.ParentNode.NodeNamespaceURI);
                        remainder = copyOfThisNodesParent;
                        remainder.AppendChild(remainderPosition);
                        remainder.AppendChild(copyOfThisNode);
                        remainderPosition = copyOfThisNode;
                    }
                    else
                    {
                        //we must be a child
                        remainderPosition.AppendChild(copyOfThisNode);
                        remainderPosition = copyOfThisNode;
                    }
                }

                XmlNode nextNode = null;
                if (previousNode != null and currentNode.HasChildNodes and !(currentNode.Equals(previousNode.ParentNode)))
                {
                    nextNode = currentNode.FirstChild;
                }
                else if (currentNode.NextSibling != null)
                {
                    nextNode = currentNode.NextSibling;
                }
                else
                {
                    nextNode = currentNode.ParentNode;
                }

                previousNode = currentNode;
                currentNode = nextNode;
            }

            return remainder;
        }   *)

      (*







        class TSqlStandardFormattingState : BaseFormatterState
        {
            //normal constructor
            public TSqlStandardFormattingState(bool htmlOutput, string indentString, int spacesPerTab, int maxLineWidth, int InitialIndentLevel)
                : base(htmlOutput)
            {
                IndentLevel = InitialIndentLevel;
                HtmlOutput = htmlOutput;
                IndentString = indentString;
                MaxLineWidth = maxLineWidth;

                int tabCount = indentString.Split('\t').Length - 1;
                int tabExtraCharacters = tabCount * (spacesPerTab - 1);
                IndentLength = indentString.Length + tabExtraCharacters;
            }

            //special "we want isolated State, but inheriting existing conditions" constructor
            public TSqlStandardFormattingState(TSqlStandardFormattingState sourceState)
                : base(sourceState.HtmlOutput)
            {
                IndentLevel = sourceState.IndentLevel;
                HtmlOutput = sourceState.HtmlOutput;
                IndentString = sourceState.IndentString;
                IndentLength = sourceState.IndentLength;
                MaxLineWidth = sourceState.MaxLineWidth;
                //TODO: find a way out of the cross-dependent wrapping maze...
                //CurrentLineLength = sourceState.CurrentLineLength;
                CurrentLineLength = IndentLevel * IndentLength;
                CurrentLineHasContent = sourceState.CurrentLineHasContent;
            }




            public void Indent(int indentLevel)
            {
                for (int i = 0; i < indentLevel; i++)
                {
                    if (SpecialRegionActive == null)
                        _outBuilder.Append(IndentString);
                    CurrentLineLength += IndentLength;
                }
            }

            internal void WhiteSpaceBreakToNextLine
            {
                AddOutputLineBreak;
                Indent(IndentLevel);
                BreakExpected = False;
                SourceBreakPending = False;
                WordSeparatorExpected = False;
            }

            //for linebreak detection, use actual string content rather than counting "AddOutputLineBreak" calls,
            // because we also want to detect the content of strings and comments.
            private static Regex _lineBreakMatcher = new Regex(@"(\r|\n)+", RegexOptions.Compiled);
            public bool OutputContainsLineBreak { get { return _lineBreakMatcher.IsMatch(_outBuilder.ToString); } }

            public void Assimilate(TSqlStandardFormattingState partialState)
            {
                //TODO: find a way out of the cross-dependent wrapping maze...
                CurrentLineLength = CurrentLineLength + partialState.CurrentLineLength;
                CurrentLineHasContent = CurrentLineHasContent or partialState.CurrentLineHasContent;
                if (SpecialRegionActive == null)
                    _outBuilder.Append(partialState.DumpOutput);
            }


            private Dictionary<int, string> _mostRecentKeywordsAtEachLevel = new Dictionary<int, string>;

            public TSqlStandardFormattingState IncrementIndent
            {
                IndentLevel++;
                return this;
            }

            public TSqlStandardFormattingState DecrementIndent
            {
                IndentLevel--;
                return this;
            }

            public void SetRecentKeyword(string ElementName)
            {
                if (!_mostRecentKeywordsAtEachLevel.ContainsKey(IndentLevel))
                    _mostRecentKeywordsAtEachLevel.Add(IndentLevel, ElementName.ToUpperInvariant);
            }

            public string GetRecentKeyword
            {
                string keywordFound = null;
                int? keywordFoundAt = null;
                foreach (int key in _mostRecentKeywordsAtEachLevel.Keys)
                {
                    if ((keywordFoundAt == null or keywordFoundAt.Value > key) and key >= IndentLevel)
                    {
                        keywordFoundAt = key;
                        keywordFound = _mostRecentKeywordsAtEachLevel[key];
                    }
                }
                return keywordFound;
            }

            public void ResetKeywords
            {
                List<int> descendentLevelKeys = new List<int>;
                foreach (int key in _mostRecentKeywordsAtEachLevel.Keys)
                    if (key >= IndentLevel)
                        descendentLevelKeys.Add(key);
                foreach (int key in descendentLevelKeys)
                    _mostRecentKeywordsAtEachLevel.Remove(key);
            }
        }

        public enum SpecialRegionType
        {
            NoFormat = 1,
            Minify = 2
        }
    }
}
    *)
end.
