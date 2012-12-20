unit SQLParser;

interface

uses
  SQLTokenizer, SQLParseTree, Generics.Collections, OmniXML, RegularExpressions;

type
  TKeywordType = (ktOperatorKeyword, ktFunctionKeyword, ktDataTypeKeyword, ktOtherKeyword);

  TSQLParser = class
  private
    FKeywordList: TDictionary<string, TKeywordType>;
    FJoinDetector: TRegEx;
    FCursorDetector: TRegEx;
    FTriggerConditionDetector: TRegEx;
    procedure InitializeKeywordList;
    function IsLatestTokenADDLDetailValue(SQLParseTree: TSQLParseTree): Boolean;
    function IsLatestTokenAMiscName(SQLParseTree: TSQLParseTree): Boolean;
    function GetSignificantTokenPositions(SQLTokenList: TSQLTokenList; TokenID: Integer; SearchDistance: Integer): TSQLTokenPositionsList;
    function ExtractTokensString(SQLTokenList: TSQLTokenList; SignificantTokenPositions: TSQLTokenPositionsList): string;
    procedure AppendNodesWithMapping(SQLParseTree: TSQLParseTree; Tokens: TSQLTokenList; OtherTokenMappingName: string; TargetContainer: IXMLElement);
    function GetEquivalentSQLName(SQLTokenType: TSQLTokenType): string;
    procedure ProcessCompoundKeywordWithError(SQLTokenList: TSQLTokenList; SQLParseTree: TSQLParseTree; CurrentContainerElement: IXMLElement; var TokenID: Integer; SignificantTokenPositions: TSQLTokenPositionsList; KeywordCount: Integer);
    procedure ProcessCompoundKeyword(SQLTokenList: TSQLTokenList; SQLParseTree: TSQLParseTree; TargetContainer: IXMLElement; var TokenID: Integer; SignificantTokenPositions: TSQLTokenPositionsList; KeywordCount: Integer);
    function ContentStartsWithKeyword(ProvidedContainer: IXMLElement; ContentToMatch: string): Boolean;
    function IsLineBreakingWhiteSpaceOrComment(SQLToken: TSQLToken): Boolean;
    function IsFollowedByLineBreakingWhiteSpaceOrSingleLineCommentOrEnd(SQLTokenList: TSQLTokenList; TokenID: Integer): Boolean;
    function IsLatestTokenAComma(SQLParseTree: TSQLParseTree): Boolean;
    function IsStatementStarter(SQLToken: TSQLToken): Boolean;
    function IsClauseStarter(SQLToken: TSQLToken): Boolean;
  public
    constructor Create;
    function Parse(SQLTokenList: TSQLTokenList): TSQLParseTree;
  end;

implementation

uses
  Windows, XMLConstants, System.SysUtils, System.StrUtils, Common;

constructor TSQLParser.Create;
begin
  inherited;
  InitializeKeywordList;
  FJoinDetector := TRegEx.Create('^((RIGHT|INNER|LEFT|CROSS|FULL) )?(OUTER )?((HASH|LOOP|MERGE|REMOTE) )?(JOIN|APPLY) ');
  FCursorDetector := TRegEx.Create('^DECLARE [\p{L}0-9_\$\@\#]+ ((INSENSITIVE|SCROLL) ){0,2}CURSOR ');
  FTriggerConditionDetector := TRegEx.Create('^(FOR|AFTER|INSTEAD OF)( (INSERT|UPDATE|DELETE) (, (INSERT|UPDATE|DELETE) )?(, (INSERT|UPDATE|DELETE) )?)');
end;

function StartsWith(const S, SubS: string): Boolean;
var
  LLen: Integer;

  P1, P2: PChar;
begin
  LLen := Length(SubS);
  Result := LLen <= Length(S);
  if Result then
  begin
    P1 := PChar(S);
    P2 := PChar(SubS);

    Result := CompareString(LOCALE_USER_DEFAULT, NORM_IGNORECASE, P1, LLen, P2, LLen) = 2;
  end;
end;

function TSQLParser.GetEquivalentSQLName(SQLTokenType: TSQLTokenType): string;
begin
  case SQLTokenType of
    ttWhiteSpace: Result := XMLConstants.XML_WHITESPACE;
    ttSingleLineComment: Result := XMLConstants.XML_COMMENT_SINGLELINE;
    ttMultiLineComment: Result := XMLConstants.XML_COMMENT_MULTILINE;
    ttBracketQuotedName: Result := XMLConstants.XML_BRACKET_QUOTED_NAME;
    ttAsterisk: Result := XMLConstants.XML_ASTERISK;
    ttComma: Result := XMLConstants.XML_COMMA;
    ttPeriod: Result := XMLConstants.XML_PERIOD;
    ttNationalString: Result := XMLConstants.XML_NSTRING;
    ttString: Result := XMLConstants.XML_STRING;
    ttQuotedString: Result := XMLConstants.XML_QUOTED_STRING;
    ttOtherOperator: Result := XMLConstants.XML_OTHEROPERATOR;
    ttNumber: Result := XMLConstants.XML_NUMBER_VALUE;
    ttMonetaryValue: Result := XMLConstants.XML_MONETARY_VALUE;
    ttBinaryValue: Result := XMLConstants.XML_BINARY_VALUE;
    ttPseudoName: Result := XMLConstants.XML_PSEUDONAME;
    else
      raise Exception.Create('Mapping not found for provided Token type.');
  end;
end;

function TSQLParser.IsLatestTokenADDLDetailValue(SQLParseTree: TSQLParseTree): Boolean;
var
  CurrentNode: IXMLNode;
  UppercaseText: string;
begin
  Result := False;
  CurrentNode := SQLParseTree.CurrentContainer.LastChild;
  while Assigned(CurrentNode) do
  begin
    if (CurrentNode.NodeName = XMLConstants.XML_OTHERKEYWORD) or
      (CurrentNode.NodeName = XMLConstants.XML_DATATYPE_KEYWORD) or
      (CurrentNode.NodeName = XMLConstants.XML_COMPOUNDKEYWORD) then
    begin
      UppercaseText := '';
      if CurrentNode.NodeName = XMLConstants.XML_COMPOUNDKEYWORD then
        UppercaseText := CurrentNode.Attributes[XMLConstants.XML_SIMPLETEXT]
      else
        UppercaseText := UpperCase(CurrentNode.Text);

      Result :=
        (UppercaseText = 'NVARCHAR') or
        (UppercaseText = 'VARCHAR') or
        (UppercaseText = 'DECIMAL') or
        (UppercaseText = 'DEC') or
        (UppercaseText = 'NUMERIC') or
        (UppercaseText = 'VARBINARY') or
        (UppercaseText = 'DEFAULT') or
        (UppercaseText = 'IDENTITY') or
        (UppercaseText = 'XML') or
        EndsText('VARYING', UppercaseText) or
        EndsText('CHAR', UppercaseText) or
        EndsText('CHARACTER', UppercaseText) or
        (UppercaseText = 'FLOAT') or
        (UppercaseText = 'DATETIMEOFFSET') or
        (UppercaseText = 'DATETIME2') or
        (UppercaseText = 'TIME');
      Break;
    end
    else
    if SQLParseTree.IsCommentOrWhiteSpace(CurrentNode.NodeName) then
      CurrentNode := CurrentNode.PreviousSibling
    else
      CurrentNode := nil;
  end;
end;

function TSQLParser.IsLatestTokenAMiscName(SQLParseTree: TSQLParseTree): Boolean;
var
  CurrentNode: IXMLNode;
  TestValue: string;
begin
  Result := False;
  CurrentNode := SQLParseTree.CurrentContainer.LastChild;
  while Assigned(CurrentNode) do
  begin
    TestValue := UpperCase(CurrentNode.Text);
    if (CurrentNode.NodeName = XMLConstants.XML_BRACKET_QUOTED_NAME) or
       ((CurrentNode.NodeName = XMLConstants.XML_OTHERNODE) or
        (CurrentNode.NodeName = XMLConstants.XML_FUNCTION_KEYWORD)) and
        not ((TestValue = 'AND') or
             (TestValue = 'OR') or
             (TestValue = 'NOT') or
             (TestValue = 'BETWEEN') or
             (TestValue = 'LIKE') or
             (TestValue = 'CONTAINS') or
             (TestValue = 'EXISTS') or
             (TestValue = 'FREETEXT') or
             (TestValue = 'IN') or
             (TestValue = 'ALL') or
             (TestValue = 'SOME') or
             (TestValue = 'ANY') or
             (TestValue = 'FROM') or
             (TestValue = 'JOIN') or
             EndsText(' JOIN', TestValue) or
             (TestValue = 'UNION') or
             (TestValue = 'UNION ALL') or
             (TestValue = 'USING') or
             (TestValue = 'AS') or
             EndsText(' APPLY', TestValue)) then
    begin
      Result := True;
      Break
    end
    else
    if SQLParseTree.IsCommentOrWhiteSpace(CurrentNode.NodeName) then
      CurrentNode := currentNode.PreviousSibling
    else
      CurrentNode := nil;
  end;
end;

function TSQLParser.GetSignificantTokenPositions(SQLTokenList: TSQLTokenList; TokenID: Integer; SearchDistance: Integer): TSQLTokenPositionsList;
var
  Id: Integer;
begin
  Result := TSQLTokenPositionsList.Create;
  //int originalTokenID = TokenID;
  Id := TokenID;

  while (Id < SQLTokenList.Count) and (Result.Count < SearchDistance) do
  begin
    if (SQLTokenList.Items[Id].TokenType = ttOtherNode) or
     (SQLTokenList.Items[Id].TokenType = ttBracketQuotedName) or
     (SQLTokenList.Items[Id].TokenType = ttComma) then
    begin
      Result.Add(Id);
      Inc(Id);

      //found a possible phrase component - skip past any upcoming whitespace or comments, keeping track.
      while (Id < SQLTokenList.Count) and
        ( (SQLTokenList.Items[Id].TokenType = ttWhiteSpace) or
        (SQLTokenList.Items[Id].TokenType = ttSingleLineComment) or
        (SQLTokenList.Items[Id].TokenType = ttMultiLineComment) ) do
        Inc(Id);
    end
    else
      //we're not interested in any other node types
      Break;
  end;
end;

function TSQLParser.ExtractTokensString(SQLTokenList: TSQLTokenList; SignificantTokenPositions: TSQLTokenPositionsList): string;
var
  i: Integer;
  KeywordSB: TStringBuilder;
begin
  KeywordSB := TStringBuilder.Create;
  for i := 0 to SignificantTokenPositions.Count - 1 do
  begin
    //grr, this could be more elegant.
    if SQLTokenList.Items[SignificantTokenPositions.Items[i]].TokenType = ttComma then
      KeywordSB.Append(',')
    else
      KeywordSB.Append(UpperCase(SQLTokenList.Items[SignificantTokenPositions.Items[i]].Value));
    KeywordSB.Append(' ');
  end;
  Result := KeywordSB.ToString;
end;

procedure TSQLParser.AppendNodesWithMapping(SQLParseTree: TSQLParseTree; Tokens: TSQLTokenList; OtherTokenMappingName: string; TargetContainer: IXMLElement);
var
  i: Integer;
  ElementName: string;
begin
  for i:= 0 to Tokens.Count - 1 do
  begin
    if Tokens.Items[i].TokenType = ttOtherNode then
      ElementName := otherTokenMappingName
    else
      ElementName := GetEquivalentSQLName(Tokens.Items[i].TokenType);

    SQLParseTree.SaveNewElement(ElementName, Tokens.Items[i].Value, TargetContainer);
  end;
end;

procedure TSQLParser.ProcessCompoundKeywordWithError(SQLTokenList: TSQLTokenList; SQLParseTree: TSQLParseTree; CurrentContainerElement: IXMLElement; var TokenID: Integer; SignificantTokenPositions: TSQLTokenPositionsList; KeywordCount: Integer);
begin
  ProcessCompoundKeyword(SQLTokenList, SQLParseTree, currentContainerElement, TokenID, SignificantTokenPositions, KeywordCount);
  SQLParseTree.ErrorFound := True;
end;

//TODO: move into parse tree
function TSQLParser.ContentStartsWithKeyword(ProvidedContainer: IXMLElement; ContentToMatch: string): Boolean;
var
  ParentDoc: TSQLParseTree;
  FirstEntryOfProvidedContainer: IXMLElement;
  KeywordUpperValue: string;
begin
  ParentDoc := TSQLParseTree(ProvidedContainer.OwnerDocument);
  FirstEntryOfProvidedContainer := ParentDoc.GetFirstNonWhitespaceNonCommentChildElement(ProvidedContainer);

  if Assigned(FirstEntryOfProvidedContainer) and
    (FirstEntryOfProvidedContainer.NodeName = XMLConstants.XML_OTHERKEYWORD) and
    (FirstEntryOfProvidedContainer.Text <> '') then
    KeywordUpperValue := UpperCase(FirstEntryOfProvidedContainer.Text);

  if Assigned(FirstEntryOfProvidedContainer) and
    (FirstEntryOfProvidedContainer.NodeName = XMLConstants.XML_COMPOUNDKEYWORD) then
    KeywordUpperValue := FirstEntryOfProvidedContainer.GetAttribute(XMLConstants.XML_SIMPLETEXT);

  if KeywordUpperValue <> '' then
    Result := (KeywordUpperValue = ContentToMatch) or StartsWith(KeywordUpperValue, ContentToMatch + ' ')
  else
    //if contentToMatch was passed in as null, means we were looking for a NON-keyword.
    Result := ContentToMatch = '';
end;

procedure TSQLParser.ProcessCompoundKeyword(SQLTokenList: TSQLTokenList; SQLParseTree: TSQLParseTree; TargetContainer: IXMLElement; var TokenID: Integer; SignificantTokenPositions: TSQLTokenPositionsList; KeywordCount: Integer);
var
  CompoundKeyword: IXMLElement;
  TargetText: string;
begin
  CompoundKeyword := SQLParseTree.SaveNewElement(XMLConstants.XML_COMPOUNDKEYWORD, '', targetContainer);
  TargetText := Trim(ExtractTokensString(SQLTokenList, SignificantTokenPositions.GetRange(0, KeywordCount)));
  CompoundKeyword.SetAttribute(XMLConstants.XML_SIMPLETEXT, targetText);
  AppendNodesWithMapping(SQLParseTree, SQLTokenList.GetRangeByIndex(SignificantTokenPositions[0],
    SignificantTokenPositions[keywordCount - 1]), XMLConstants.XML_OTHERKEYWORD, CompoundKeyword);
  TokenID := SignificantTokenPositions[keywordCount - 1];
end;

function TSQLParser.IsLineBreakingWhiteSpaceOrComment(SQLToken: TSQLToken): Boolean;
var
  Regex: TRegex;
begin
  Regex := TRegex.Create('(\r|\n)+');
  Result := ((SQLToken.TokenType = ttWhiteSpace) and Regex.IsMatch(SQLToken.Value)) or
    (SQLToken.TokenType = ttSingleLineComment);
end;

function TSQLParser.IsFollowedByLineBreakingWhiteSpaceOrSingleLineCommentOrEnd(SQLTokenList: TSQLTokenList; TokenID: Integer): Boolean;
var
  CurrTokenID: Integer;
  Regex: TRegex;
begin
  Result := False;
  CurrTokenID := TokenID + 1;
  Regex := TRegex.Create('(\r|\n)+');
  while SQLTokenList.Count >= currTokenID + 1 do
  begin
    if SQLTokenList[currTokenID].TokenType = ttSingleLineComment then
    begin
      Result := True;
      Break;
    end
    else
    if SQLTokenList[currTokenID].TokenType = ttWhiteSpace then
    begin
      if Regex.IsMatch(SQLTokenList[currTokenID].Value) then
      begin
        Result := True;
        Break;
      end
      else
        Inc(CurrTokenID);
    end
    else
    begin
      Result := False;
      Break;
    end;
  end;
end;

function TSQLParser.IsLatestTokenAComma(SQLParseTree: TSQLParseTree): Boolean;
var
  CurrentNode: IXMLNode;
begin
  Result := False;
  CurrentNode := SQLParseTree.CurrentContainer.LastChild;
  while Assigned(CurrentNode) do
  begin
    if CurrentNode.NodeName = XMLConstants.XML_COMMA then
    begin
      Result := True;
      Break;
    end
    else
    if SQLParseTree.IsCommentOrWhiteSpace(CurrentNode.NodeName) then
      CurrentNode := CurrentNode.PreviousSibling
    else
      CurrentNode := nil;
  end;
end;

function TSQLParser.Parse(SQLTokenList: TSQLTokenList): TSQLParseTree;
var
  i, TokenCount, TokenID, ExistingClauseCount, TriggerConditionTypeNodeCount,
    TriggerConditionNodeCount, TargetKeywordCount: Integer;
  SQLToken: TSQLToken;
  FirstNonCommentParensSibling, NewTryBlock, TryContainerOpen, TryMultiContainer, NewCatchBlock,
    CatchContainerOpen, CatchMultiContainer, TriggerConditionType, TryBlock,
    TryContainerClose, CatchBlock, CatchContainerClose, BeginBlock, BeginContainerClose, SQLRoot,
    BatchSeparator, UnionClause, NewWhileLoop, WhileContainerOpen, CurrentNode,
    FirstStatementClause, Node, FirstEntryOfThisClause, FirstNonCommentSibling2: IXMLElement;
  IsInsertOrValuesClause, IsDataTypeDefinition, IsSprocArgument, ExecuteAsInWithOptions,
    ExecShouldntTryToStartNewStatement, StopSearching, SelectShouldntTryToStartNewStatement,
    IsPrecededByInsertStatement, ExistingSelectClauseFound, ExistingValuesClauseFound,
    ExistingExecClauseFound, IsCTESplitter: Boolean;
  SignificantTokenPositions: TSQLTokenPositionsList;
  SignificantTokensString, TriggerConditionTypeSimpleText, JoinText, NewNodeName: string;
  TriggerConditions: TMatch;
  NextKeywordType, MatchedKeywordType: TKeywordType;
  NodeList: IXMLNodeList;
begin
  Result := TSQLParseTree.Create(XMLConstants.XML_SQL_ROOT);
  Result.StartNewStatement;

  TokenCount := SQLTokenList.Count;
  TokenID := 0;
  while TokenID < TokenCount do
  begin
    SQLToken := SQLTokenList[TokenID];

    case SQLToken.TokenType of
      ttOpenParens:
      begin
        FirstNonCommentParensSibling := Result.GetFirstNonWhitespaceNonCommentChildElement(Result.CurrentContainer);
        IsInsertOrValuesClause := Assigned(FirstNonCommentParensSibling) and
          ( (FirstNonCommentParensSibling.NodeName = XMLConstants.XML_OTHERKEYWORD) and
             StartsWith(FirstNonCommentParensSibling.Text, 'INSERT') or
            (FirstNonCommentParensSibling.NodeName = XMLConstants.XML_COMPOUNDKEYWORD) and
             StartsWith(FirstNonCommentParensSibling.GetAttribute(XMLConstants.XML_SIMPLETEXT), 'INSERT ') or
            (FirstNonCommentParensSibling.NodeName = XMLConstants.XML_OTHERKEYWORD) and
             StartsWith(FirstNonCommentParensSibling.Text, 'VALUES') );

        if (Result.CurrentContainer.NodeName = XMLConstants.XML_CTE_ALIAS) and
          (Result.CurrentContainer.ParentNode.NodeName = XMLConstants.XML_CTE_WITH_CLAUSE) then
          Result.CurrentContainer := Result.SaveNewElement(XMLConstants.XML_DDL_PARENS, '')
        else
        if (Result.CurrentContainer.NodeName = XMLConstants.XML_CONTAINER_GENERALCONTENT) and
          (Result.CurrentContainer.ParentNode.NodeName = XMLConstants.XML_CTE_AS_BLOCK) then
          Result.CurrentContainer := Result.SaveNewElement(XMLConstants.XML_SELECTIONTARGET_PARENS, '')
        else
        if not Assigned(FirstNonCommentParensSibling) and
          (Result.CurrentContainer.NodeName = XMLConstants.XML_SELECTIONTARGET) then
          Result.CurrentContainer := Result.SaveNewElement(XMLConstants.XML_SELECTIONTARGET_PARENS, '')
        else
        if Assigned(FirstNonCommentParensSibling) and
          (FirstNonCommentParensSibling.NodeName = XMLConstants.XML_SET_OPERATOR_CLAUSE) then
        begin
          Result.ConsiderStartingNewClause;
          Result.CurrentContainer := Result.SaveNewElement(XMLConstants.XML_SELECTIONTARGET_PARENS, '');
        end
        else
        if IsLatestTokenADDLDetailValue(Result) then
          Result.CurrentContainer := Result.SaveNewElement(XMLConstants.XML_DDLDETAIL_PARENS, '')
        else
        if (Result.CurrentContainer.NodeName = XMLConstants.XML_DDL_PROCEDURAL_BLOCK) or
           (Result.CurrentContainer.NodeName = XMLConstants.XML_DDL_OTHER_BLOCK) or
           (Result.CurrentContainer.NodeName = XMLConstants.XML_DDL_DECLARE_BLOCK) or
           (Result.CurrentContainer.NodeName = XMLConstants.XML_SQL_CLAUSE) and
           ( Assigned(FirstNonCommentParensSibling) and
            (FirstNonCommentParensSibling.NodeName = XMLConstants.XML_OTHERKEYWORD) and
             StartsWith(FirstNonCommentParensSibling.Text, 'OPTION') ) or
           IsInsertOrValuesClause then
           Result.CurrentContainer := Result.SaveNewElement(XMLConstants.XML_DDL_PARENS, '')
        else
        if IsLatestTokenAMiscName(Result) then
          Result.CurrentContainer := Result.SaveNewElement(XMLConstants.XML_FUNCTION_PARENS, '')
        else
          Result.CurrentContainer := Result.SaveNewElement(XMLConstants.XML_EXPRESSION_PARENS, '');
      end;

      ttCloseParens:
      begin
        //we're not likely to actually have a 'SingleStatement' in parens, but
        // we definitely want the side-effects (all the lower-level escapes)
        Result.EscapeAnySingleOrPartialStatementContainers;

        //check whether we expected to end the parens...
        if (Result.CurrentContainer.NodeName = XMLConstants.XML_DDLDETAIL_PARENS) or
          (Result.CurrentContainer.NodeName = XMLConstants.XML_DDL_PARENS) or
          (Result.CurrentContainer.NodeName = XMLConstants.XML_FUNCTION_PARENS) or
          (Result.CurrentContainer.NodeName = XMLConstants.XML_EXPRESSION_PARENS) or
          (Result.CurrentContainer.NodeName = XMLConstants.XML_SELECTIONTARGET_PARENS) then
            Result.MoveToAncestorContainer(1) //unspecified parent node...
        else
        if (Result.CurrentContainer.NodeName = XMLConstants.XML_SQL_CLAUSE) and
          (Result.CurrentContainer.ParentNode.NodeName = XMLConstants.XML_SELECTIONTARGET_PARENS) and
          (Result.CurrentContainer.ParentNode.ParentNode.NodeName = XMLConstants.XML_CONTAINER_GENERALCONTENT) and
          (Result.CurrentContainer.ParentNode.ParentNode.ParentNode.NodeName = XMLConstants.XML_CTE_AS_BLOCK) then
        begin
            Result.MoveToAncestorContainer(4, XMLConstants.XML_CTE_WITH_CLAUSE);
            Result.CurrentContainer := Result.SaveNewElement(XMLConstants.XML_CONTAINER_GENERALCONTENT, '');
        end
        else
        if (Result.CurrentContainer.NodeName = XMLConstants.XML_SQL_CLAUSE) and
          ( (Result.CurrentContainer.ParentNode.NodeName = XMLConstants.XML_EXPRESSION_PARENS) or
            (Result.CurrentContainer.ParentNode.NodeName = XMLConstants.XML_SELECTIONTARGET_PARENS) ) then
          Result.MoveToAncestorContainer(2) //unspecified grandfather node.
        else
          Result.SaveNewElementWithError(XMLConstants.XML_OTHERNODE, ')');
      end;

      ttOtherNode:
      begin
        //prepare multi-keyword detection by 'peeking' up to 7 keywords ahead
        SignificantTokenPositions := GetSignificantTokenPositions(SQLTokenList, TokenID, 7);
        SignificantTokensString := ExtractTokensString(SQLTokenList, SignificantTokenPositions);

        if Result.PathNameMatches(0, XMLConstants.XML_PERMISSIONS_DETAIL) then
        begin
          //if we're in a permissions detail clause, we can expect all sorts of statements
          // starters and should ignore them all; the only possible keywords to escape are
          // 'ON' and 'TO'.
          if StartsWith(SignificantTokensString, 'ON ') then
          begin
            Result.MoveToAncestorContainer(1, XMLConstants.XML_PERMISSIONS_BLOCK);
            Result.StartNewContainer(XMLConstants.XML_PERMISSIONS_TARGET, SQLToken.Value, XMLConstants.XML_CONTAINER_GENERALCONTENT);
          end
          else
          if StartsWith(SignificantTokensString, 'TO ') or
             StartsWith(SignificantTokensString, 'FROM ') then
          begin
            Result.MoveToAncestorContainer(1, XMLConstants.XML_PERMISSIONS_BLOCK);
            Result.StartNewContainer(XMLConstants.XML_PERMISSIONS_RECIPIENT, SQLToken.Value, XMLConstants.XML_CONTAINER_GENERALCONTENT);
          end
          else
            //default to 'some classification of permission'
            Result.SaveNewElement(XMLConstants.XML_OTHERKEYWORD, SQLToken.Value);
        end
        else
        if StartsWith(SignificantTokensString, 'CREATE PROC') or
           StartsWith(SignificantTokensString, 'CREATE FUNC') or
           StartsWith(SignificantTokensString, 'CREATE TRIGGER ') or
           StartsWith(SignificantTokensString, 'CREATE VIEW ') or
           StartsWith(SignificantTokensString, 'ALTER PROC') or
           StartsWith(SignificantTokensString, 'ALTER FUNC') or
           StartsWith(SignificantTokensString, 'ALTER TRIGGER ') or
           StartsWith(SignificantTokensString, 'ALTER VIEW ') then
        begin
          Result.ConsiderStartingNewStatement;
          Result.CurrentContainer := Result.SaveNewElement(XMLConstants.XML_DDL_PROCEDURAL_BLOCK, '');
          Result.SaveNewElement(XMLConstants.XML_OTHERKEYWORD, SQLToken.Value);
        end
        else
        if FCursorDetector.IsMatch(SignificantTokensString) then
        begin
          Result.ConsiderStartingNewStatement;
          Result.CurrentContainer := Result.SaveNewElement(XMLConstants.XML_CURSOR_DECLARATION, '');
          Result.SaveNewElement(XMLConstants.XML_OTHERKEYWORD, SQLToken.Value);
        end
        else
        if Result.PathNameMatches(0, XMLConstants.XML_DDL_PROCEDURAL_BLOCK) and
          FTriggerConditionDetector.IsMatch(significantTokensString) then
        begin
          //horrible complicated forward-search, to avoid having to keep a different 'Trigger Condition' state for Update, Insert and Delete statement-starting keywords
          TriggerConditions := FTriggerConditionDetector.Match(SignificantTokensString);
          Result.CurrentContainer := Result.SaveNewElement(XMLConstants.XML_TRIGGER_CONDITION, '');
          TriggerConditionType := Result.SaveNewElement(XMLConstants.XML_COMPOUNDKEYWORD, '');

          //first set the 'trigger condition type': FOR, INSTEAD OF, AFTER
          TriggerConditionTypeSimpleText := TriggerConditions.Groups[1].Value;
          TriggerConditionType.SetAttribute(XMLConstants.XML_SIMPLETEXT, TriggerConditionTypeSimpleText);
          TriggerConditionTypeNodeCount := WordCount(TriggerConditionTypeSimpleText); //TriggerConditionTypeSimpleText.Split(new char[] begin ' ' end;).Length; //there's probably a better way of counting words...
          AppendNodesWithMapping(Result, SQLTokenList.GetRangeByIndex(SignificantTokenPositions[0],
            SignificantTokenPositions[TriggerConditionTypeNodeCount - 1]),
            XMLConstants.XML_OTHERKEYWORD, triggerConditionType);

          //then get the count of conditions (INSERT, UPDATE, DELETE) and add those too...
          TriggerConditionNodeCount := WordCount(TriggerConditionTypeSimpleText); //TriggerConditions.Groups[2].Value.Split(new char[] begin ' ' end;).Length - 2; //there's probably a better way of counting words...
          AppendNodesWithMapping(Result, SQLTokenList.GetRangeByIndex(SignificantTokenPositions[TriggerConditionTypeNodeCount - 1] + 1,
            SignificantTokenPositions[TriggerConditionTypeNodeCount + triggerConditionNodeCount - 1]),
            XMLConstants.XML_OTHERKEYWORD, Result.CurrentContainer);
          TokenID := SignificantTokenPositions[TriggerConditionTypeNodeCount + TriggerConditionNodeCount - 1];
          Result.MoveToAncestorContainer(1, XMLConstants.XML_DDL_PROCEDURAL_BLOCK);
        end
        else
        if StartsWith(significantTokensString, 'FOR ') then
        begin
          Result.EscapeAnyBetweenConditions;
          Result.EscapeAnySelectionTarget;
          Result.EscapeJoinCondition;

          if Result.PathNameMatches(0, XMLConstants.XML_CURSOR_DECLARATION) then
          begin
            Result.StartNewContainer(XMLConstants.XML_CURSOR_FOR_BLOCK, SQLToken.Value, XMLConstants.XML_CONTAINER_GENERALCONTENT);
            Result.StartNewStatement;
          end
          else
          if Result.PathNameMatches(0, XMLConstants.XML_SQL_CLAUSE) and
            Result.PathNameMatches(1, XMLConstants.XML_SQL_STATEMENT) and
            Result.PathNameMatches(2, XMLConstants.XML_CONTAINER_GENERALCONTENT) and
            Result.PathNameMatches(3, XMLConstants.XML_CURSOR_FOR_BLOCK) then
          begin
            Result.MoveToAncestorContainer(4, XMLConstants.XML_CURSOR_DECLARATION);
            Result.StartNewContainer(XMLConstants.XML_CURSOR_FOR_OPTIONS, SQLToken.Value, XMLConstants.XML_CONTAINER_GENERALCONTENT);
          end
          else
          begin
            //Assume FOR clause if we're at clause level
            // (otherwise, eg in OPTIMIZE FOR UNKNOWN, this will just not do anything)
            Result.ConsiderStartingNewClause();

            Result.SaveNewElement(XMLConstants.XML_OTHERKEYWORD, SQLToken.Value);
          end;
        end
        else
        if StartsWith(SignificantTokensString, 'DECLARE ') then
        begin
          Result.ConsiderStartingNewStatement();
          Result.CurrentContainer := Result.SaveNewElement(XMLConstants.XML_DDL_DECLARE_BLOCK, '');
          Result.SaveNewElement(XMLConstants.XML_OTHERKEYWORD, SQLToken.Value);
        end
        else
        if StartsWith(SignificantTokensString, 'CREATE ') or StartsWith(SignificantTokensString, 'ALTER ') then
        begin
          Result.ConsiderStartingNewStatement;
          Result.CurrentContainer := Result.SaveNewElement(XMLConstants.XML_DDL_OTHER_BLOCK, '');
          Result.SaveNewElement(XMLConstants.XML_OTHERKEYWORD, SQLToken.Value);
        end
        else
        if StartsWith(SignificantTokensString, 'GRANT ') or
           StartsWith(SignificantTokensString, 'DENY ') or
           StartsWith(SignificantTokensString, 'REVOKE ') then
        begin
          if StartsWith(SignificantTokensString, 'GRANT ') and
            Result.PathNameMatches(0, XMLConstants.XML_CONTAINER_GENERALCONTENT) and
            Result.PathNameMatches(1, XMLConstants.XML_DDL_WITH_CLAUSE) and
            Result.PathNameMatches(2, XMLConstants.XML_PERMISSIONS_BLOCK) and
            not Assigned(Result.GetFirstNonWhitespaceNonCommentChildElement(Result.CurrentContainer)) then
              //this MUST be a 'WITH GRANT OPTION' option...
            Result.SaveNewElement(XMLConstants.XML_OTHERKEYWORD, SQLToken.Value)
          else
          begin
            Result.ConsiderStartingNewStatement;
            Result.StartNewContainer(XMLConstants.XML_PERMISSIONS_BLOCK, SQLToken.Value, XMLConstants.XML_PERMISSIONS_DETAIL);
          end;
        end
        else
        if (Result.CurrentContainer.NodeName = XMLConstants.XML_DDL_PROCEDURAL_BLOCK) and
          StartsWith(SignificantTokensString, 'RETURNS ') then
          Result.SaveNewElement(XMLConstants.XML_OTHERKEYWORD, SQLToken.Value, Result.SaveNewElement(XMLConstants.XML_DDL_RETURNS, ''))
        else
        if StartsWith(SignificantTokensString, 'AS ') then
        begin
          if Result.PathNameMatches(0, XMLConstants.XML_DDL_PROCEDURAL_BLOCK) then
          begin
            IsDataTypeDefinition := False;
            if (SignificantTokenPositions.Count > 1) and
              FKeywordList.TryGetValue(SQLTokenList[SignificantTokenPositions[1]].Value, NextKeywordType) then
                if NextKeywordType = ktDataTypeKeyword then
                  IsDataTypeDefinition := True;

            if IsDataTypeDefinition then
              //this is actually a data type declaration (redundant 'AS'...), save as regular token.
              Result.SaveNewElement(XMLConstants.XML_OTHERKEYWORD, SQLToken.Value)
            else
            begin
              //this is the start of the object content definition
              Result.StartNewContainer(XMLConstants.XML_DDL_AS_BLOCK, SQLToken.Value, XMLConstants.XML_CONTAINER_GENERALCONTENT);
              Result.StartNewStatement;
            end;
          end
          else
          if Result.PathNameMatches(0, XMLConstants.XML_CONTAINER_GENERALCONTENT) and
            Result.PathNameMatches(1, XMLConstants.XML_DDL_WITH_CLAUSE) and
            Result.PathNameMatches(2, XMLConstants.XML_DDL_PROCEDURAL_BLOCK) then
          begin
            Result.MoveToAncestorContainer(2, XMLConstants.XML_DDL_PROCEDURAL_BLOCK);
            Result.StartNewContainer(XMLConstants.XML_DDL_AS_BLOCK, SQLToken.Value, XMLConstants.XML_CONTAINER_GENERALCONTENT);
            Result.StartNewStatement;
          end
          else
          if Result.PathNameMatches(0, XMLConstants.XML_CTE_ALIAS) and
            Result.PathNameMatches(1, XMLConstants.XML_CTE_WITH_CLAUSE) then
          begin
            Result.MoveToAncestorContainer(1, XMLConstants.XML_CTE_WITH_CLAUSE);
            Result.StartNewContainer(XMLConstants.XML_CTE_AS_BLOCK, SQLToken.Value, XMLConstants.XML_CONTAINER_GENERALCONTENT);
          end
          else
            Result.SaveNewElement(XMLConstants.XML_OTHERKEYWORD, SQLToken.Value);
        end
        else
        if StartsWith(SignificantTokensString, 'BEGIN DISTRIBUTED TRANSACTION ') or
          StartsWith(SignificantTokensString, 'BEGIN DISTRIBUTED TRAN ') then
        begin
          Result.ConsiderStartingNewStatement;
          ProcessCompoundKeyword(SQLTokenList, Result, Result.SaveNewElement(XMLConstants.XML_BEGIN_TRANSACTION, ''), TokenID, SignificantTokenPositions, 3);
        end
        else
        if StartsWith(SignificantTokensString, 'BEGIN TRANSACTION ') or
          StartsWith(SignificantTokensString, 'BEGIN TRAN ') then
        begin
          Result.ConsiderStartingNewStatement;
          ProcessCompoundKeyword(SQLTokenList, Result, Result.SaveNewElement(XMLConstants.XML_BEGIN_TRANSACTION, ''), TokenID, SignificantTokenPositions, 2);
        end
        else
        if StartsWith(SignificantTokensString, 'SAVE TRANSACTION ') or
          StartsWith(SignificantTokensString, 'SAVE TRAN ') then
        begin
          Result.ConsiderStartingNewStatement;
          ProcessCompoundKeyword(SQLTokenList, Result, Result.SaveNewElement(XMLConstants.XML_SAVE_TRANSACTION, ''), TokenID, SignificantTokenPositions, 2);
        end
        else
        if StartsWith(SignificantTokensString, 'COMMIT TRANSACTION ') or
          StartsWith(SignificantTokensString, 'COMMIT TRAN ') or
          StartsWith(SignificantTokensString, 'COMMIT WORK ') then
        begin
          Result.ConsiderStartingNewStatement;
          ProcessCompoundKeyword(SQLTokenList, Result, Result.SaveNewElement(XMLConstants.XML_COMMIT_TRANSACTION, ''), TokenID, SignificantTokenPositions, 2);
        end
        else
        if StartsWith(SignificantTokensString, 'COMMIT ') then
        begin
          Result.ConsiderStartingNewStatement;
          Result.SaveNewElement(XMLConstants.XML_OTHERKEYWORD, SQLToken.Value, Result.SaveNewElement(XMLConstants.XML_COMMIT_TRANSACTION, SQLToken.Value));
        end
        else
        if StartsWith(SignificantTokensString, 'ROLLBACK TRANSACTION ') or
          StartsWith(SignificantTokensString, 'ROLLBACK TRAN ') or
          StartsWith(SignificantTokensString, 'ROLLBACK WORK ') then
        begin
          Result.ConsiderStartingNewStatement;
          ProcessCompoundKeyword(SQLTokenList, Result, Result.SaveNewElement(XMLConstants.XML_ROLLBACK_TRANSACTION, ''), TokenID, SignificantTokenPositions, 2);
        end
        else
        if StartsWith(SignificantTokensString, 'ROLLBACK ') then
        begin
          Result.ConsiderStartingNewStatement;
          Result.SaveNewElement(XMLConstants.XML_OTHERKEYWORD, SQLToken.Value, Result.SaveNewElement(XMLConstants.XML_ROLLBACK_TRANSACTION, SQLToken.Value));
        end
        else
        if StartsWith(SignificantTokensString, 'BEGIN TRY ') then
        begin
          Result.ConsiderStartingNewStatement;
          NewTryBlock := Result.SaveNewElement(XMLConstants.XML_TRY_BLOCK, '');
          TryContainerOpen := Result.SaveNewElement(XMLConstants.XML_CONTAINER_OPEN, '', newTryBlock);
          ProcessCompoundKeyword(SQLTokenList, Result, tryContainerOpen, TokenID, SignificantTokenPositions, 2);
          TryMultiContainer := Result.SaveNewElement(XMLConstants.XML_CONTAINER_MULTISTATEMENT, '', newTryBlock);
          Result.StartNewStatement(tryMultiContainer);
        end
        else
        if StartsWith(SignificantTokensString, 'BEGIN CATCH ') then
        begin
          Result.ConsiderStartingNewStatement;
          NewCatchBlock := Result.SaveNewElement(XMLConstants.XML_CATCH_BLOCK, '');
          CatchContainerOpen := Result.SaveNewElement(XMLConstants.XML_CONTAINER_OPEN, '', newCatchBlock);
          ProcessCompoundKeyword(SQLTokenList, Result, catchContainerOpen, TokenID, SignificantTokenPositions, 2);
          CatchMultiContainer := Result.SaveNewElement(XMLConstants.XML_CONTAINER_MULTISTATEMENT, '', newCatchBlock);
          Result.StartNewStatement(catchMultiContainer);
        end
        else
        if StartsWith(SignificantTokensString, 'BEGIN ') then
        begin
          Result.ConsiderStartingNewStatement;
          Result.StartNewContainer(XMLConstants.XML_BEGIN_END_BLOCK, SQLToken.Value, XMLConstants.XML_CONTAINER_MULTISTATEMENT);
          Result.StartNewStatement;
        end
        else
        if StartsWith(SignificantTokensString, 'MERGE ') then
        begin
          //According to BOL, MERGE is a fully reserved keyword from compat 100 onwards, for the MERGE statement only.
          Result.ConsiderStartingNewStatement;
          Result.ConsiderStartingNewClause;
          Result.StartNewContainer(XMLConstants.XML_MERGE_CLAUSE, SQLToken.Value, XMLConstants.XML_MERGE_TARGET);
        end
        else
        if StartsWith(SignificantTokensString, 'USING ') then
        begin
          if Result.PathNameMatches(0, XMLConstants.XML_MERGE_TARGET) then
          begin
            Result.MoveToAncestorContainer(1, XMLConstants.XML_MERGE_CLAUSE);
            Result.StartNewContainer(XMLConstants.XML_MERGE_USING, SQLToken.Value, XMLConstants.XML_SELECTIONTARGET);
          end
          else
            Result.SaveNewElementWithError(XMLConstants.XML_OTHERNODE, SQLToken.Value);
        end
        else
        if StartsWith(SignificantTokensString, 'ON ') then
        begin
          Result.EscapeAnySelectionTarget;

          if Result.PathNameMatches(0, XMLConstants.XML_MERGE_USING) then
          begin
            Result.MoveToAncestorContainer(1, XMLConstants.XML_MERGE_CLAUSE);
            Result.StartNewContainer(XMLConstants.XML_MERGE_CONDITION, SQLToken.Value, XMLConstants.XML_CONTAINER_GENERALCONTENT);
          end
          else
          if not Result.PathNameMatches(0, XMLConstants.XML_DDL_PROCEDURAL_BLOCK) and
            not Result.PathNameMatches(0, XMLConstants.XML_DDL_OTHER_BLOCK) and
            not Result.PathNameMatches(1, XMLConstants.XML_DDL_WITH_CLAUSE) and
            not Result.PathNameMatches(0, XMLConstants.XML_EXPRESSION_PARENS) and
            not ContentStartsWithKeyword(Result.CurrentContainer, 'SET') then
            Result.StartNewContainer(XMLConstants.XML_JOIN_ON_SECTION, SQLToken.Value, XMLConstants.XML_CONTAINER_GENERALCONTENT)
          else
            Result.SaveNewElement(XMLConstants.XML_OTHERKEYWORD, SQLToken.Value);
        end
        else
        if StartsWith(SignificantTokensString, 'CASE ') then
          Result.StartNewContainer(XMLConstants.XML_CASE_STATEMENT, SQLToken.Value, XMLConstants.XML_CASE_INPUT)
        else
        if StartsWith(SignificantTokensString, 'WHEN ') then
        begin
          Result.EscapeMergeAction;

          if Result.PathNameMatches(0, XMLConstants.XML_CASE_INPUT) or
            (Result.PathNameMatches(0, XMLConstants.XML_CONTAINER_GENERALCONTENT) and
             Result.PathNameMatches(1, XMLConstants.XML_CASE_THEN)) then
          begin
            if Result.PathNameMatches(0, XMLConstants.XML_CASE_INPUT) then
              Result.MoveToAncestorContainer(1, XMLConstants.XML_CASE_STATEMENT)
            else
              Result.MoveToAncestorContainer(3, XMLConstants.XML_CASE_STATEMENT);

            Result.StartNewContainer(XMLConstants.XML_CASE_WHEN, SQLToken.Value, XMLConstants.XML_CONTAINER_GENERALCONTENT);
          end
          else
          if (Result.PathNameMatches(0, XMLConstants.XML_CONTAINER_GENERALCONTENT) and
              Result.PathNameMatches(1, XMLConstants.XML_MERGE_CONDITION)) or
              Result.PathNameMatches(0, XMLConstants.XML_MERGE_WHEN) then
          begin
            if Result.PathNameMatches(1, XMLConstants.XML_MERGE_CONDITION) then
              Result.MoveToAncestorContainer(2, XMLConstants.XML_MERGE_CLAUSE)
            else
              Result.MoveToAncestorContainer(1, XMLConstants.XML_MERGE_CLAUSE);

            Result.StartNewContainer(XMLConstants.XML_MERGE_WHEN, SQLToken.Value, XMLConstants.XML_CONTAINER_GENERALCONTENT);
          end
          else
            Result.SaveNewElementWithError(XMLConstants.XML_OTHERNODE, SQLToken.Value);
        end
        else
        if StartsWith(SignificantTokensString, 'THEN ') then
        begin
          Result.EscapeAnyBetweenConditions;

          if Result.PathNameMatches(0, XMLConstants.XML_CONTAINER_GENERALCONTENT) and
            Result.PathNameMatches(1, XMLConstants.XML_CASE_WHEN) then
          begin
            Result.MoveToAncestorContainer(1, XMLConstants.XML_CASE_WHEN);
            Result.StartNewContainer(XMLConstants.XML_CASE_THEN, SQLToken.Value, XMLConstants.XML_CONTAINER_GENERALCONTENT);
          end
          else
          if Result.PathNameMatches(0, XMLConstants.XML_CONTAINER_GENERALCONTENT) and
            Result.PathNameMatches(1, XMLConstants.XML_MERGE_WHEN) then
          begin
            Result.MoveToAncestorContainer(1, XMLConstants.XML_MERGE_WHEN);
            Result.StartNewContainer(XMLConstants.XML_MERGE_THEN, SQLToken.Value, XMLConstants.XML_MERGE_ACTION);
            Result.StartNewStatement;
          end
          else
            Result.SaveNewElementWithError(XMLConstants.XML_OTHERNODE, SQLToken.Value);
        end
        else
        if StartsWith(SignificantTokensString, 'OUTPUT ') then
        begin
          IsSprocArgument := False;

          //We're looking for sproc calls - they can't be nested inside anything else (as far as I know)
          if Result.PathNameMatches(0, XMLConstants.XML_SQL_CLAUSE) and
            Result.PathNameMatches(1, XMLConstants.XML_SQL_STATEMENT) and
            (ContentStartsWithKeyword(Result.CurrentContainer, 'EXEC') or
             ContentStartsWithKeyword(Result.CurrentContainer, 'EXECUTE') or
             ContentStartsWithKeyword(Result.CurrentContainer, '')) then
            IsSprocArgument := True;

          //Also proc definitions - argument lists without parens
          if Result.PathNameMatches(0, XMLConstants.XML_DDL_PROCEDURAL_BLOCK) then
            IsSprocArgument := True;

          if not IsSprocArgument then
          begin
            Result.EscapeMergeAction;
            Result.ConsiderStartingNewClause;
          end;

          Result.SaveNewElement(XMLConstants.XML_OTHERKEYWORD, SQLToken.Value);
        end
        else
        if StartsWith(SignificantTokensString, 'OPTION ') then
        begin
          if Result.PathNameMatches(0, XMLConstants.XML_CONTAINER_GENERALCONTENT) and
            Result.PathNameMatches(1, XMLConstants.XML_DDL_WITH_CLAUSE) then
          begin
              //'OPTION' keyword here is NOT indicative of a new clause.
          end
          else
          begin
            Result.EscapeMergeAction;
            Result.ConsiderStartingNewClause;
          end;
          Result.SaveNewElement(XMLConstants.XML_OTHERKEYWORD, SQLToken.Value);
        end
        else
        if StartsWith(SignificantTokensString, 'END TRY ') then
        begin
          Result.EscapeAnySingleOrPartialStatementContainers;

          if Result.PathNameMatches(0, XMLConstants.XML_SQL_CLAUSE) and
            Result.PathNameMatches(1, XMLConstants.XML_SQL_STATEMENT) and
            Result.PathNameMatches(2, XMLConstants.XML_CONTAINER_MULTISTATEMENT) and
            Result.PathNameMatches(3, XMLConstants.XML_TRY_BLOCK) then
          begin
            //clause.statement.multicontainer.try
            TryBlock := IXMLElement(Result.CurrentContainer.ParentNode.ParentNode.ParentNode);
            TryContainerClose := Result.SaveNewElement(XMLConstants.XML_CONTAINER_CLOSE, '', tryBlock);
            ProcessCompoundKeyword(SQLTokenList, Result, tryContainerClose, TokenID, SignificantTokenPositions, 2);
            Result.CurrentContainer := IXMLElement(TryBlock.ParentNode);
          end
          else
            ProcessCompoundKeywordWithError(SQLTokenList, Result, Result.CurrentContainer, TokenID, SignificantTokenPositions, 2);
        end
        else
        if StartsWith(SignificantTokensString, 'END CATCH ') then
        begin
          Result.EscapeAnySingleOrPartialStatementContainers;

          if Result.PathNameMatches(0, XMLConstants.XML_SQL_CLAUSE) and
             Result.PathNameMatches(1, XMLConstants.XML_SQL_STATEMENT) and
             Result.PathNameMatches(2, XMLConstants.XML_CONTAINER_MULTISTATEMENT) and
             Result.PathNameMatches(3, XMLConstants.XML_CATCH_BLOCK) then
          begin
            //clause.statement.multicontainer.catch
            CatchBlock := IXMLElement(Result.CurrentContainer.ParentNode.ParentNode.ParentNode);
            CatchContainerClose := Result.SaveNewElement(XMLConstants.XML_CONTAINER_CLOSE, '', catchBlock);
            ProcessCompoundKeyword(SQLTokenList, Result, catchContainerClose, TokenID, SignificantTokenPositions, 2);
            Result.CurrentContainer := IXMLElement(CatchBlock.ParentNode);
          end
          else
            ProcessCompoundKeywordWithError(SQLTokenList, Result, Result.CurrentContainer, TokenID, SignificantTokenPositions, 2);
        end
        else
        if StartsWith(SignificantTokensString, 'END ') then
        begin
          if Result.PathNameMatches(0, XMLConstants.XML_CONTAINER_GENERALCONTENT) and
            Result.PathNameMatches(1, XMLConstants.XML_CASE_THEN) then
          begin
            Result.MoveToAncestorContainer(3, XMLConstants.XML_CASE_STATEMENT);
            Result.SaveNewElement(XMLConstants.XML_OTHERKEYWORD, SQLToken.Value, Result.SaveNewElement(XMLConstants.XML_CONTAINER_CLOSE, ''));
            Result.MoveToAncestorContainer(1); //unnamed container
          end
          else
          if Result.PathNameMatches(0, XMLConstants.XML_CONTAINER_GENERALCONTENT) and
            Result.PathNameMatches(1, XMLConstants.XML_CASE_ELSE) then
          begin
            Result.MoveToAncestorContainer(2, XMLConstants.XML_CASE_STATEMENT);
            Result.SaveNewElement(XMLConstants.XML_OTHERKEYWORD, SQLToken.Value, Result.SaveNewElement(XMLConstants.XML_CONTAINER_CLOSE, ''));
            Result.MoveToAncestorContainer(1); //unnamed container
          end
          else
          begin
            //Begin/End block handling
            Result.EscapeAnySingleOrPartialStatementContainers;

            if Result.PathNameMatches(0, XMLConstants.XML_SQL_CLAUSE) and
               Result.PathNameMatches(1, XMLConstants.XML_SQL_STATEMENT) and
               Result.PathNameMatches(2, XMLConstants.XML_CONTAINER_MULTISTATEMENT) and
               Result.PathNameMatches(3, XMLConstants.XML_BEGIN_END_BLOCK) then
            begin
              BeginBlock := IXMLElement(Result.CurrentContainer.ParentNode.ParentNode.ParentNode);
              BeginContainerClose := Result.SaveNewElement(XMLConstants.XML_CONTAINER_CLOSE, '', BeginBlock);
              Result.SaveNewElement(XMLConstants.XML_OTHERKEYWORD, SQLToken.Value, beginContainerClose);
              Result.CurrentContainer := IXMLElement(BeginBlock.ParentNode);
            end
            else
              Result.SaveNewElementWithError(XMLConstants.XML_OTHERKEYWORD, SQLToken.Value);
          end;
        end
        else
        if StartsWith(SignificantTokensString, 'GO ') then
        begin
          Result.EscapeAnySingleOrPartialStatementContainers;

          if ((TokenID = 0) or IsLineBreakingWhiteSpaceOrComment(SQLTokenList[tokenID - 1])) and
            IsFollowedByLineBreakingWhiteSpaceOrSingleLineCommentOrEnd(SQLTokenList, TokenID) then
          begin
            // we found a batch separator - were we supposed to?
            if Result.FindValidBatchEnd then
            begin
              SQLRoot := Result.DocumentElement;
              BatchSeparator := Result.SaveNewElement(XMLConstants.XML_BATCH_SEPARATOR, '', SQLRoot);
              Result.SaveNewElement(XMLConstants.XML_OTHERKEYWORD, SQLToken.Value, batchSeparator);
              Result.StartNewStatement(sqlRoot);
            end
            else
              Result.SaveNewElementWithError(XMLConstants.XML_OTHERKEYWORD, SQLToken.Value);
          end
          else
            Result.SaveNewElement(XMLConstants.XML_OTHERKEYWORD, SQLToken.Value);
        end
        else
        if StartsWith(SignificantTokensString, 'EXECUTE AS ') then
        begin
          ExecuteAsInWithOptions := False;
          if Result.PathNameMatches(0, XMLConstants.XML_CONTAINER_GENERALCONTENT) and
            Result.PathNameMatches(1, XMLConstants.XML_DDL_WITH_CLAUSE) and
            (IsLatestTokenAComma(Result) or
             not Result.HasNonWhiteSpaceNonCommentContent(Result.CurrentContainer)) then
            ExecuteAsInWithOptions := True;

          if not ExecuteAsInWithOptions then
          begin
            Result.ConsiderStartingNewStatement;
            Result.ConsiderStartingNewClause;
          end;

          ProcessCompoundKeyword(SQLTokenList, Result, Result.CurrentContainer, TokenID, SignificantTokenPositions, 2);
        end
        else
        if StartsWith(SignificantTokensString, 'EXEC ') or
           StartsWith(SignificantTokensString, 'EXECUTE ') then
        begin
          ExecShouldntTryToStartNewStatement := False;

          if Result.PathNameMatches(0, XMLConstants.XML_SQL_CLAUSE) and
             Result.PathNameMatches(1, XMLConstants.XML_SQL_STATEMENT) and
             (ContentStartsWithKeyword(Result.CurrentContainer, 'INSERT') or
              ContentStartsWithKeyword(Result.CurrentContainer, 'INSERT INTO')) then
          begin
            ExistingClauseCount := Result.CurrentContainer.SelectNodes(Format('../%s;', [XMLConstants.XML_SQL_CLAUSE])).Count;
            ExecShouldntTryToStartNewStatement := ExistingClauseCount = 1;
          end;

          if not ExecShouldntTryToStartNewStatement then
            Result.ConsiderStartingNewStatement;

          Result.ConsiderStartingNewClause;

          Result.SaveNewElement(XMLConstants.XML_OTHERKEYWORD, SQLToken.Value);
        end
        else
        if FJoinDetector.IsMatch(SignificantTokensString) then
        begin
          Result.ConsiderStartingNewClause;
          JoinText := FJoinDetector.Match(SignificantTokensString).Value;
          TargetKeywordCount :=  WordCount(JoinText); //joinText.Split(new char[] begin ' ' end;, StringSplitOptions.RemoveEmptyEntries).Length;
          ProcessCompoundKeyword(SQLTokenList, Result, Result.CurrentContainer, TokenID, SignificantTokenPositions, targetKeywordCount);
          Result.CurrentContainer := Result.SaveNewElement(XMLConstants.XML_SELECTIONTARGET, '');
        end
        else
        if StartsWith(SignificantTokensString, 'UNION ALL ') then
        begin
          Result.ConsiderStartingNewClause;
          ProcessCompoundKeyword(SQLTokenList, Result, Result.SaveNewElement(XMLConstants.XML_SET_OPERATOR_CLAUSE, ''), TokenID, SignificantTokenPositions, 2);
        end
        else
        if StartsWith(SignificantTokensString, 'UNION ') or
          StartsWith(SignificantTokensString, 'INTERSECT ') or
          StartsWith(SignificantTokensString, 'EXCEPT ') then
        begin
          Result.ConsiderStartingNewClause;
          UnionClause := Result.SaveNewElement(XMLConstants.XML_SET_OPERATOR_CLAUSE, '');
          Result.SaveNewElement(XMLConstants.XML_OTHERKEYWORD, SQLToken.Value, UnionClause);
        end
        else
        if StartsWith(SignificantTokensString, 'WHILE ') then
        begin
          Result.ConsiderStartingNewStatement;
          NewWhileLoop := Result.SaveNewElement(XMLConstants.XML_WHILE_LOOP, '');
          WhileContainerOpen := Result.SaveNewElement(XMLConstants.XML_CONTAINER_OPEN, '', NewWhileLoop);
          Result.SaveNewElement(XMLConstants.XML_OTHERKEYWORD, SQLToken.Value, WhileContainerOpen);
          Result.CurrentContainer := Result.SaveNewElement(XMLConstants.XML_BOOLEAN_EXPRESSION, '', NewWhileLoop);
        end
        else
        if StartsWith(SignificantTokensString, 'IF ') then
        begin
          Result.ConsiderStartingNewStatement;
          Result.StartNewContainer(XMLConstants.XML_IF_STATEMENT, SQLToken.Value, XMLConstants.XML_BOOLEAN_EXPRESSION);
        end
        else
        if StartsWith(SignificantTokensString, 'ELSE ') then
        begin
          Result.EscapeAnyBetweenConditions;
          Result.EscapeAnySelectionTarget;
          Result.EscapeJoinCondition;

          if Result.PathNameMatches(0, XMLConstants.XML_CONTAINER_GENERALCONTENT) and
            Result.PathNameMatches(1, XMLConstants.XML_CASE_THEN) then
          begin
            Result.MoveToAncestorContainer(3, XMLConstants.XML_CASE_STATEMENT);
            Result.StartNewContainer(XMLConstants.XML_CASE_ELSE, SQLToken.Value, XMLConstants.XML_CONTAINER_GENERALCONTENT);
          end
          else
          begin
            Result.EscapePartialStatementContainers;

            if Result.PathNameMatches(0, XMLConstants.XML_SQL_CLAUSE) and
              Result.PathNameMatches(1, XMLConstants.XML_SQL_STATEMENT) and
              Result.PathNameMatches(2, XMLConstants.XML_CONTAINER_SINGLESTATEMENT) then
            begin
              //we need to pop up the single-statement containers stack to the next 'if' that doesn't have an 'else' (if any; else error).
              // LOCAL SEARCH - we're not actually changing the 'CurrentContainer' until we decide to start a statement.
              CurrentNode := IXMLElement(Result.CurrentContainer.ParentNode.ParentNode);
              StopSearching := False;
              while not StopSearching do
              begin
                if Result.PathNameMatches(currentNode, 1, XMLConstants.XML_IF_STATEMENT) then
                begin
                  //if this is in an 'If', then the 'Else' must still be available - yay!
                  Result.CurrentContainer := IXMLElement(CurrentNode.ParentNode);
                  Result.StartNewContainer(XMLConstants.XML_ELSE_CLAUSE, SQLToken.Value, XMLConstants.XML_CONTAINER_SINGLESTATEMENT);
                  Result.StartNewStatement;
                  stopSearching := true;
                end
                else
                if Result.PathNameMatches(currentNode, 1, XMLConstants.XML_ELSE_CLAUSE) then
                  //If this is in an 'Else', we should skip its parent 'IF' altogether, and go to the next singlestatementcontainer candidate.
                  //singlestatementcontainer.else.if.clause.statement.NEWCANDIDATE
                  CurrentNode := IXMLElement(CurrentNode.ParentNode.ParentNode.ParentNode.ParentNode.ParentNode)
                else
                if Result.PathNameMatches(CurrentNode, 1, XMLConstants.XML_WHILE_LOOP) then
                  //If this is in a 'While', we should skip to the next singlestatementcontainer candidate.
                  //singlestatementcontainer.while.clause.statement.NEWCANDIDATE
                  CurrentNode := IXMLElement(CurrentNode.ParentNode.ParentNode.ParentNode.ParentNode)
                else
                begin
                  //if this isn't a known single-statement container, then we're lost.
                  Result.SaveNewElementWithError(XMLConstants.XML_OTHERKEYWORD, SQLToken.Value);
                  StopSearching := True;
                end;
              end;
            end
            else
              Result.SaveNewElementWithError(XMLConstants.XML_OTHERKEYWORD, SQLToken.Value);
          end;
        end
        else
        if StartsWith(SignificantTokensString, 'INSERT INTO ') then
        begin
          Result.ConsiderStartingNewStatement;
          Result.ConsiderStartingNewClause;
          ProcessCompoundKeyword(SQLTokenList, Result, Result.CurrentContainer, TokenID, SignificantTokenPositions, 2);
        end
        else
        if StartsWith(SignificantTokensString, 'NATIONAL CHARACTER VARYING ') then
          ProcessCompoundKeyword(SQLTokenList, Result, Result.CurrentContainer, TokenID, SignificantTokenPositions, 3)
        else
        if StartsWith(SignificantTokensString, 'NATIONAL CHAR VARYING ') then
          ProcessCompoundKeyword(SQLTokenList, Result, Result.CurrentContainer, TokenID, SignificantTokenPositions, 3)
        else
        if StartsWith(SignificantTokensString, 'BINARY VARYING ') then
          //TODO: Figure out how to handle 'Compound Keyword Datatypes' so they are still correctly highlighted
          ProcessCompoundKeyword(SQLTokenList, Result, Result.CurrentContainer, TokenID, SignificantTokenPositions, 2)
        else
        if StartsWith(SignificantTokensString, 'CHAR VARYING ') then
          ProcessCompoundKeyword(SQLTokenList, Result, Result.CurrentContainer, TokenID, SignificantTokenPositions, 2)
        else
        if StartsWith(SignificantTokensString, 'CHARACTER VARYING ') then
          ProcessCompoundKeyword(SQLTokenList, Result, Result.CurrentContainer, TokenID, SignificantTokenPositions, 2)
        else
        if StartsWith(SignificantTokensString, 'DOUBLE PRECISION ') then
          ProcessCompoundKeyword(SQLTokenList, Result, Result.CurrentContainer, TokenID, SignificantTokenPositions, 2)
        else
        if StartsWith(SignificantTokensString, 'NATIONAL CHARACTER ') then
          ProcessCompoundKeyword(SQLTokenList, Result, Result.CurrentContainer, TokenID, SignificantTokenPositions, 2)
        else
        if StartsWith(SignificantTokensString, 'NATIONAL CHAR ') then
          ProcessCompoundKeyword(SQLTokenList, Result, Result.CurrentContainer, TokenID, SignificantTokenPositions, 2)
        else
        if StartsWith(SignificantTokensString, 'NATIONAL TEXT ') then
          ProcessCompoundKeyword(SQLTokenList, Result, Result.CurrentContainer, TokenID, SignificantTokenPositions, 2)
        else
        if StartsWith(SignificantTokensString, 'INSERT ') then
        begin
          Result.ConsiderStartingNewStatement;
          Result.ConsiderStartingNewClause;
          Result.SaveNewElement(XMLConstants.XML_OTHERKEYWORD, SQLToken.Value);
        end
        else
        if StartsWith(SignificantTokensString, 'BULK INSERT ') then
        begin
          Result.ConsiderStartingNewStatement;
          Result.ConsiderStartingNewClause;
          ProcessCompoundKeyword(SQLTokenList, Result, Result.CurrentContainer, TokenID, SignificantTokenPositions, 2);
        end
        else
        if StartsWith(SignificantTokensString, 'SELECT ') then
        begin
          if Result.NewStatementDue then
            Result.ConsiderStartingNewStatement;

          SelectShouldntTryToStartNewStatement := False;

          if Result.PathNameMatches(0, XMLConstants.XML_SQL_CLAUSE) then
          begin
            FirstStatementClause := Result.GetFirstNonWhitespaceNonCommentChildElement(Result.CurrentContainer.ParentNode);

            IsPrecededByInsertStatement := False;

            Result.CurrentContainer.ParentNode.SelectNodes(XMLConstants.XML_SQL_CLAUSE, NodeList);
            for i := 0 to NodeList.Count - 1 do
            begin
              Node := IXMLElement(NodeList[i]);
              if ContentStartsWithKeyword(Node, 'INSERT') then
              begin
                IsPrecededByInsertStatement := True;
                Break;
              end;
            end;

            if isPrecededByInsertStatement then
            begin
              ExistingSelectClauseFound := False;
              Result.CurrentContainer.ParentNode.SelectNodes(XMLConstants.XML_SQL_CLAUSE, NodeList);
              for i := 0 to NodeList.Count - 1 do
              begin
                Node :=  IXMLElement(NodeList[i]);
                if ContentStartsWithKeyword(Node, 'SELECT') then
                begin
                  ExistingSelectClauseFound := True;
                  Break;
                end;
              end;

              ExistingValuesClauseFound := False;
              Result.CurrentContainer.ParentNode.SelectNodes(XMLConstants.XML_SQL_CLAUSE, NodeList);
              for i := 0 to NodeList.Count - 1 do
              begin
                Node :=  IXMLElement(NodeList[i]);
                if ContentStartsWithKeyword(Node, 'VALUES') then
                begin
                  ExistingValuesClauseFound := True;
                  Break;
                end;
              end;

              ExistingExecClauseFound := False;
              Result.CurrentContainer.ParentNode.SelectNodes(XMLConstants.XML_SQL_CLAUSE, NodeList);
              for i := 0 to NodeList.Count - 1 do
              begin
                Node :=  IXMLElement(NodeList[i]);
                if ContentStartsWithKeyword(Node, 'EXEC') or
                  ContentStartsWithKeyword(Node, 'EXECUTE') then
                begin
                  ExistingExecClauseFound := True;
                  Break;
                end;
              end;

              if not ExistingSelectClauseFound and
                 not ExistingValuesClauseFound and
                 not ExistingExecClauseFound then
                SelectShouldntTryToStartNewStatement := True;
            end;

            FirstEntryOfThisClause := Result.GetFirstNonWhitespaceNonCommentChildElement(Result.CurrentContainer);
            if Assigned(FirstEntryOfThisClause) and (FirstEntryOfThisClause.NodeName = XMLConstants.XML_SET_OPERATOR_CLAUSE) then
              SelectShouldntTryToStartNewStatement := True;
          end;

          if not SelectShouldntTryToStartNewStatement then
            Result.ConsiderStartingNewStatement;

          Result.ConsiderStartingNewClause;

          Result.SaveNewElement(XMLConstants.XML_OTHERKEYWORD, SQLToken.Value);
        end
        else
        if StartsWith(SignificantTokensString, 'UPDATE ') then
        begin
          if Result.NewStatementDue then
            Result.ConsiderStartingNewStatement;

          if not (Result.PathNameMatches(0, XMLConstants.XML_CONTAINER_GENERALCONTENT) and
                  Result.PathNameMatches(1, XMLConstants.XML_CURSOR_FOR_OPTIONS)) then
          begin
            Result.ConsiderStartingNewStatement;
            Result.ConsiderStartingNewClause;
          end;

          Result.SaveNewElement(XMLConstants.XML_OTHERKEYWORD, SQLToken.Value);
        end
        else
        if StartsWith(SignificantTokensString, 'TO ') then
        begin
          if Result.PathNameMatches(0, XMLConstants.XML_CONTAINER_GENERALCONTENT) and
            Result.PathNameMatches(1, XMLConstants.XML_PERMISSIONS_TARGET) then
          begin
            Result.MoveToAncestorContainer(2, XMLConstants.XML_PERMISSIONS_BLOCK);
            Result.StartNewContainer(XMLConstants.XML_PERMISSIONS_RECIPIENT, SQLToken.Value, XMLConstants.XML_CONTAINER_GENERALCONTENT);
          end
          else
          begin
            //I don't currently know whether there is any other place where 'TO' can be used in T-SQL...
            // TODO: look into that.
            // -> for now, we'll just save as a random keyword without raising an error.
            Result.SaveNewElement(XMLConstants.XML_OTHERKEYWORD, SQLToken.Value);
          end;
        end
        else
        if StartsWith(SignificantTokensString, 'FROM ') then
        begin
          if Result.PathNameMatches(0, XMLConstants.XML_CONTAINER_GENERALCONTENT) and
            Result.PathNameMatches(1, XMLConstants.XML_PERMISSIONS_TARGET) then
          begin
            Result.MoveToAncestorContainer(2, XMLConstants.XML_PERMISSIONS_BLOCK);
            Result.StartNewContainer(XMLConstants.XML_PERMISSIONS_RECIPIENT, SQLToken.Value, XMLConstants.XML_CONTAINER_GENERALCONTENT);
          end
          else
          begin
            Result.ConsiderStartingNewClause;
            Result.SaveNewElement(XMLConstants.XML_OTHERKEYWORD, SQLToken.Value);
            Result.CurrentContainer := Result.SaveNewElement(XMLConstants.XML_SELECTIONTARGET, '');
          end;
        end
        else
        if StartsWith(SignificantTokensString, 'CASCADE ') and
          Result.PathNameMatches(0, XMLConstants.XML_CONTAINER_GENERALCONTENT) and
          Result.PathNameMatches(1, XMLConstants.XML_PERMISSIONS_RECIPIENT) then
        begin
          Result.MoveToAncestorContainer(2, XMLConstants.XML_PERMISSIONS_BLOCK);
          Result.CurrentContainer := Result.SaveNewElement(XMLConstants.XML_CONTAINER_GENERALCONTENT, '', Result.SaveNewElement(XMLConstants.XML_DDL_WITH_CLAUSE, ''));
          Result.SaveNewElement(XMLConstants.XML_OTHERKEYWORD, SQLToken.Value);
        end
        else
        if StartsWith(SignificantTokensString, 'SET ') then
        begin
          FirstNonCommentSibling2 := Result.GetFirstNonWhitespaceNonCommentChildElement(Result.CurrentContainer);
          if not (Assigned(FirstNonCommentSibling2) and
                  (FirstNonCommentSibling2.NodeName = XMLConstants.XML_OTHERKEYWORD) and
                  StartsWith(FirstNonCommentSibling2.Text, 'UPDATE')) then
              Result.ConsiderStartingNewStatement;

          Result.ConsiderStartingNewClause;
          Result.SaveNewElement(XMLConstants.XML_OTHERKEYWORD, SQLToken.Value);
        end
        else
        if StartsWith(SignificantTokensString, 'BETWEEN ') then
        begin
          Result.CurrentContainer := Result.SaveNewElement(XMLConstants.XML_BETWEEN_CONDITION, '');
          Result.SaveNewElement(XMLConstants.XML_OTHERKEYWORD, SQLToken.Value, Result.SaveNewElement(XMLConstants.XML_CONTAINER_OPEN, ''));
          Result.CurrentContainer := Result.SaveNewElement(XMLConstants.XML_BETWEEN_LOWERBOUND, '');
        end
        else
        if StartsWith(SignificantTokensString, 'AND ') then
        begin
          if Result.PathNameMatches(0, XMLConstants.XML_BETWEEN_LOWERBOUND) then
          begin
            Result.MoveToAncestorContainer(1, XMLConstants.XML_BETWEEN_CONDITION);
            Result.SaveNewElement(XMLConstants.XML_OTHERKEYWORD, SQLToken.Value, Result.SaveNewElement(XMLConstants.XML_CONTAINER_CLOSE, ''));
            Result.CurrentContainer := Result.SaveNewElement(XMLConstants.XML_BETWEEN_UPPERBOUND, '');
          end
          else
          begin
            Result.EscapeAnyBetweenConditions;
            Result.SaveNewElement(XMLConstants.XML_OTHERKEYWORD, SQLToken.Value, Result.SaveNewElement(XMLConstants.XML_AND_OPERATOR, ''));
          end;
        end
        else
        if StartsWith(SignificantTokensString, 'OR ') then
        begin
          Result.EscapeAnyBetweenConditions;
          Result.SaveNewElement(XMLConstants.XML_OTHERKEYWORD, SQLToken.Value, Result.SaveNewElement(XMLConstants.XML_OR_OPERATOR, ''));
        end
        else
        if StartsWith(SignificantTokensString, 'WITH ') then
        begin
          if Result.NewStatementDue then
            Result.ConsiderStartingNewStatement;

          if Result.PathNameMatches(0, XMLConstants.XML_SQL_CLAUSE) and
            Result.PathNameMatches(1, XMLConstants.XML_SQL_STATEMENT) and
            not Result.HasNonWhiteSpaceNonCommentContent(Result.CurrentContainer) then
          begin
            Result.CurrentContainer := Result.SaveNewElement(XMLConstants.XML_CTE_WITH_CLAUSE, '');
            Result.SaveNewElement(XMLConstants.XML_OTHERKEYWORD, SQLToken.Value, Result.SaveNewElement(XMLConstants.XML_CONTAINER_OPEN, ''));
            Result.CurrentContainer := Result.SaveNewElement(XMLConstants.XML_CTE_ALIAS, '');
          end
          else
          if Result.PathNameMatches(0, XMLConstants.XML_CONTAINER_GENERALCONTENT) and
            Result.PathNameMatches(1, XMLConstants.XML_PERMISSIONS_RECIPIENT) then
          begin
            Result.MoveToAncestorContainer(2, XMLConstants.XML_PERMISSIONS_BLOCK);
            Result.StartNewContainer(XMLConstants.XML_DDL_WITH_CLAUSE, SQLToken.Value, XMLConstants.XML_CONTAINER_GENERALCONTENT);
          end
          else
          if Result.PathNameMatches(0, XMLConstants.XML_DDL_PROCEDURAL_BLOCK) or
            Result.PathNameMatches(0, XMLConstants.XML_DDL_OTHER_BLOCK) then
            Result.StartNewContainer(XMLConstants.XML_DDL_WITH_CLAUSE, SQLToken.Value, XMLConstants.XML_CONTAINER_GENERALCONTENT)
          else
          if Result.PathNameMatches(0, XMLConstants.XML_SELECTIONTARGET) then
            Result.SaveNewElement(XMLConstants.XML_OTHERKEYWORD, SQLToken.Value)
          else
          begin
            Result.ConsiderStartingNewClause;
            Result.SaveNewElement(XMLConstants.XML_OTHERKEYWORD, SQLToken.Value);
          end;
        end
        else
        if (SQLTokenList.Count > TokenID + 1) and
          (SQLTokenList[tokenID + 1].TokenType = ttColon) and
          not (SQLTokenList.Count > tokenID + 2) and
          (SQLTokenList[tokenID + 2].TokenType = ttColon) then
        begin
          Result.ConsiderStartingNewStatement;
          Result.SaveNewElement(XMLConstants.XML_LABEL, SQLToken.Value + SQLTokenList[tokenID + 1].Value);
          Inc(TokenID);
        end
        else
        begin
          //miscellaneous single-word tokens, which may or may not be statement starters and/or clause starters

          //check for statements starting...
          if IsStatementStarter(SQLToken) or Result.NewStatementDue then
            Result.ConsiderStartingNewStatement;

          //check for statements starting...
          if IsClauseStarter(SQLToken) then
            Result.ConsiderStartingNewClause;

          NewNodeName := XMLConstants.XML_OTHERNODE;

          if FKeywordList.TryGetValue(SQLToken.Value, MatchedKeywordType) then
          begin
            case MatchedKeywordType of
              ktOperatorKeyword: NewNodeName := XMLConstants.XML_ALPHAOPERATOR;
              ktFunctionKeyword: NewNodeName := XMLConstants.XML_FUNCTION_KEYWORD;
              ktDataTypeKeyword: NewNodeName := XMLConstants.XML_DATATYPE_KEYWORD;
              ktOtherKeyword:
              begin
                Result.EscapeAnySelectionTarget;
                NewNodeName := XMLConstants.XML_OTHERKEYWORD;
              end
              else
                raise Exception.Create('Unrecognized Keyword Type!');
            end;
          end;

          Result.SaveNewElement(newNodeName, SQLToken.Value);
        end;
      end;

      ttSemicolon:
      begin
        Result.SaveNewElement(XMLConstants.XML_SEMICOLON, SQLToken.Value);
        Result.NewStatementDue := true;
      end;

      ttColon:
      begin
        if (SQLTokenList.Count > TokenID + 1) and
          (SQLTokenList[tokenID + 1].TokenType = ttColon) then
        begin
          Result.SaveNewElement(XMLConstants.XML_SCOPERESOLUTIONOPERATOR, SQLToken.Value + SQLTokenList[tokenID + 1].Value);
          Inc(TokenID);
        end
        else
          Result.SaveNewElementWithError(XMLConstants.XML_OTHEROPERATOR, SQLToken.Value);
      end;

      ttComma:
      begin
        IsCTESplitter := Result.PathNameMatches(0, XMLConstants.XML_CONTAINER_GENERALCONTENT) and
          Result.PathNameMatches(1, XMLConstants.XML_CTE_WITH_CLAUSE);

        Result.SaveNewElement(GetEquivalentSQLName(SQLToken.TokenType), SQLToken.Value);

        if isCTESplitter then
        begin
          Result.MoveToAncestorContainer(1, XMLConstants.XML_CTE_WITH_CLAUSE);
          Result.CurrentContainer := Result.SaveNewElement(XMLConstants.XML_CTE_ALIAS, '');
        end;
      end;

      ttEqualsSign:
      begin
        Result.SaveNewElement(XMLConstants.XML_EQUALSSIGN, SQLToken.Value);
        if Result.PathNameMatches(0, XMLConstants.XML_DDL_DECLARE_BLOCK) then
          Result.CurrentContainer := Result.SaveNewElement(XMLConstants.XML_CONTAINER_GENERALCONTENT, '');
      end;

      ttMultiLineComment,
      ttSingleLineComment,
      ttWhiteSpace:
      begin
        //create in statement rather than clause if there are no siblings yet
        if Result.PathNameMatches(0, XMLConstants.XML_SQL_CLAUSE) and
          Result.PathNameMatches(1, XMLConstants.XML_SQL_STATEMENT) and
          not Assigned(Result.CurrentContainer.SelectSingleNode('*')) then
          Result.SaveNewElementAsPriorSibling(GetEquivalentSQLName(SQLToken.TokenType), SQLToken.Value, Result.CurrentContainer)
        else
          Result.SaveNewElement(GetEquivalentSQLName(SQLToken.TokenType), SQLToken.Value);
      end;

      ttBracketQuotedName,
      ttAsterisk,
      ttPeriod,
      ttOtherOperator,
      ttNationalString,
      ttString,
      ttQuotedString,
      ttNumber,
      ttBinaryValue,
      ttMonetaryValue,
      ttPseudoName:
        Result.SaveNewElement(GetEquivalentSQLName(SQLToken.TokenType), SQLToken.Value);
      else
        raise Exception.Create('Unrecognized element encountered!');
    end;

    Inc(TokenID);
  end;

  if SQLTokenList.HasUnfinishedToken then
    Result.SetError;

  if not Result.FindValidBatchEnd then
    Result.SetError;
end;

procedure TSQLParser.InitializeKeywordList;
begin
  { http://www.oracle.com/pls/db92/db92.sql_keywords }
  FKeywordList := TDictionary<string, TKeywordType>.Create;
  with FKeywordList do
  begin
    { % }
    Add('%BULK_EXCEPTIONS', ktOtherKeyword);
    Add('%BULK_ROWCOUNT', ktOtherKeyword);
    Add('%FOUND', ktOtherKeyword);
    Add('%ISOPEN', ktOtherKeyword);
    Add('%NOTFOUND', ktOtherKeyword);
    Add('%ROWCOUNT', ktOtherKeyword);
    Add('%ROWTYPE', ktOtherKeyword);
    Add('%TYPE', ktOtherKeyword);
    { A }
    Add('ABORT', ktFunctionKeyword);
    Add('ABS', ktFunctionKeyword);
    Add('ACOS', ktFunctionKeyword);
    Add('ADD_MONTHS', ktFunctionKeyword);
    Add('ALL', ktOperatorKeyword);
    Add('ALTER', ktOtherKeyword);
    Add('ANALYZE', ktOtherKeyword);
    Add('ANY', ktOperatorKeyword);
    Add('AND', ktOperatorKeyword);
    Add('ASCII', ktFunctionKeyword);
    Add('ASCIISTR', ktFunctionKeyword);
    Add('ASIN', ktFunctionKeyword);
    Add('ASSOCIATE', ktOtherKeyword);
    Add('ATAN', ktFunctionKeyword);
    Add('ATAN2', ktFunctionKeyword);
    Add('AUDIT', ktOtherKeyword);
    Add('AVG', ktFunctionKeyword);
    { B }
    Add('BETWEEN', ktOperatorKeyword);
    Add('BFILE', ktDataTypeKeyword);
    Add('BFILENAME', ktFunctionKeyword);
    Add('BIN_TO_NUM', ktFunctionKeyword);
    Add('BINARY_INTEGER', ktDataTypeKeyword);
    Add('BITAND', ktFunctionKeyword);
    Add('BLOB', ktDataTypeKeyword);
    Add('BODY', ktOtherKeyword);
    Add('BOOLEAN', ktDataTypeKeyword);
    { C }
    Add('CALL', ktOtherKeyword);
    Add('CASE', ktFunctionKeyword);
    Add('CAST', ktFunctionKeyword);
    Add('CEIL', ktFunctionKeyword);
    Add('CHAR', ktDataTypeKeyword);
    Add('CHARACTER', ktDataTypeKeyword);
    Add('CHARTOROWID', ktFunctionKeyword);
    Add('CHR', ktFunctionKeyword);
    Add('CLOB', ktDataTypeKeyword);
    Add('CLUSTER', ktOtherKeyword);
    Add('COALESCE', ktFunctionKeyword);
    Add('COMMENT', ktOtherKeyword);
    Add('COMMIT', ktOtherKeyword);
    Add('COMPOSE', ktFunctionKeyword);
    Add('CONCAT', ktFunctionKeyword);
    Add('CONSTRAINT', ktOtherKeyword);
    Add('CONTEXT', ktOtherKeyword);
    Add('CONTROLFILE', ktOtherKeyword);
    Add('CONVERT', ktFunctionKeyword);
    Add('CORR', ktFunctionKeyword);
    Add('COS', ktFunctionKeyword);
    Add('COSH', ktFunctionKeyword);
    Add('COST', ktOtherKeyword);
    Add('COUNT', ktFunctionKeyword);
    Add('COVAR_POP', ktFunctionKeyword);
    Add('COVAR_SAMP', ktFunctionKeyword);
    Add('CREATE', ktOtherKeyword);
    Add('CUME_DIST', ktFunctionKeyword);
    Add('CURRENT_DATE', ktFunctionKeyword);
    Add('CURRENT_TIMESTAMP', ktFunctionKeyword);
    Add('CURSOR', ktFunctionKeyword);
    { D }
    Add('DATABASE', ktOtherKeyword);
    Add('DATE', ktDataTypeKeyword);
    Add('DBTIMEZONE', ktFunctionKeyword);
    Add('DEC', ktDataTypeKeyword);
    Add('DECIMAL', ktDataTypeKeyword);
    Add('DECODE', ktFunctionKeyword);
    Add('DECOMPOSE', ktFunctionKeyword);
    Add('DELETE', ktOtherKeyword);
    Add('DENSE_RANK', ktFunctionKeyword);
    Add('DEPTH', ktFunctionKeyword);
    Add('DEREF', ktFunctionKeyword);
    Add('DIMENSION', ktOtherKeyword);
    Add('DIRECTORY', ktOtherKeyword);
    Add('DISSAOCIATE', ktOtherKeyword);
    Add('DOUBLE', ktDataTypeKeyword);
    Add('DROP', ktOtherKeyword);
    Add('DUMP', ktFunctionKeyword);
    { E }
    Add('EMPTY_BLOB', ktFunctionKeyword);
    Add('EMPTY_CLOB', ktFunctionKeyword);
    Add('EQUALS_PATH', ktFunctionKeyword);
    Add('EXISTS', ktOperatorKeyword);
    Add('EXISTSNODE', ktFunctionKeyword);
    Add('EXP', ktFunctionKeyword);
    Add('EXPLAIN', ktOtherKeyword);
    Add('EXTRACT', ktFunctionKeyword);
    Add('EXTRACTVALUE', ktFunctionKeyword);
    { F }
    Add('FIRST', ktFunctionKeyword);
    Add('FIRST_VALUE', ktFunctionKeyword);
    Add('FLOAT', ktDataTypeKeyword);
    Add('FLOOR', ktFunctionKeyword);
    Add('FROM_TZ', ktFunctionKeyword);
    Add('FUNCTION', ktOtherKeyword);
    { G }
    Add('GRANT', ktOtherKeyword);
    Add('GREATEST', ktFunctionKeyword);
    Add('GROUPING', ktFunctionKeyword);
    Add('GROUPING_ID', ktFunctionKeyword);
    Add('GROUP_ID', ktFunctionKeyword);
    { H }
    Add('HEXTORAW', ktFunctionKeyword);
    { I }
    Add('INDEX', ktOtherKeyword);
    Add('INDEXTYPE', ktOtherKeyword);
    Add('INITCAP', ktFunctionKeyword);
    Add('INSERT', ktOtherKeyword);
    Add('INSTR', ktFunctionKeyword);
    Add('IN', ktOperatorKeyword);
    Add('INT', ktDataTypeKeyword);
    Add('INTEGER', ktDataTypeKeyword);
    Add('INTERSECT', ktOperatorKeyword);
    Add('INTERVAL', ktFunctionKeyword);
    { J }
    Add('JAVA', ktOtherKeyword);
    { L }
    Add('LAG', ktFunctionKeyword);
    Add('LAST', ktFunctionKeyword);
    Add('LAST_DAY', ktFunctionKeyword);
    Add('LAST_VALUE', ktFunctionKeyword);
    Add('LEAD', ktFunctionKeyword);
    Add('LEAST', ktFunctionKeyword);
    Add('LENGTH', ktFunctionKeyword);
    Add('LIBRARY', ktOtherKeyword);
    Add('LIKE', ktOperatorKeyword);
    Add('LINK', ktOtherKeyword);
    Add('LN', ktFunctionKeyword);
    Add('LOCALTIMESTAMP', ktFunctionKeyword);
    Add('LOCK', ktOtherKeyword);
    Add('LOG', ktFunctionKeyword);
    Add('LONG', ktDataTypeKeyword);
    Add('LOWER', ktFunctionKeyword);
    Add('LPAD', ktFunctionKeyword);
    Add('LTRIM', ktFunctionKeyword);
    { M }
    Add('MAKE_REF', ktFunctionKeyword);
    Add('MATERIALIZED', ktOtherKeyword);
    Add('MAX', ktFunctionKeyword);
    Add('MERGE', ktOtherKeyword);
    Add('MIN', ktFunctionKeyword);
    Add('MINUS', ktOperatorKeyword);
    Add('MOD', ktFunctionKeyword);
    Add('MONTHS_BETWEEN', ktFunctionKeyword);
    { N }
    Add('NATURAL', ktDataTypeKeyword);
    Add('NATURALN', ktDataTypeKeyword);
    Add('NCHAR', ktDataTypeKeyword);
    Add('NCHR', ktFunctionKeyword);
    Add('NCLOB', ktDataTypeKeyword);
    Add('NEW_TIME', ktFunctionKeyword);
    Add('NEXT_DAY', ktFunctionKeyword);
    Add('NLSSORT', ktFunctionKeyword);
    Add('NLS_CHARSET_DECL_LEN', ktFunctionKeyword);
    Add('NLS_CHARSET_ID', ktFunctionKeyword);
    Add('NLS_CHARSET_NAME', ktFunctionKeyword);
    Add('NLS_INITCAP', ktFunctionKeyword);
    Add('NLS_LOWER', ktFunctionKeyword);
    Add('NLS_UPPER', ktFunctionKeyword);
    Add('NOAUDIT', ktOtherKeyword);
    Add('NOT', ktOperatorKeyword);
    Add('NTILE', ktFunctionKeyword);
    Add('NULLIF', ktFunctionKeyword);
    Add('NUMBER', ktDataTypeKeyword);
    Add('NUMERIC', ktDataTypeKeyword);
    Add('NUMTODSINTERVAL', ktFunctionKeyword);
    Add('NUMTOYMINTERVAL', ktFunctionKeyword);
    Add('NVARCHAR2', ktDataTypeKeyword);
    Add('NVL', ktFunctionKeyword);
    Add('NVL2', ktFunctionKeyword);
    { O }
    Add('OPERATOR', ktOtherKeyword);
    Add('OR', ktOperatorKeyword);
    Add('OUTLINE', ktOtherKeyword);
    { P }
    Add('PACKAGE', ktOtherKeyword);
    Add('PATH', ktFunctionKeyword);
    Add('PERCENTILE_CONT', ktFunctionKeyword);
    Add('PRECENTILE_DISC', ktFunctionKeyword);
    Add('PERCENT_RANK', ktFunctionKeyword);
    Add('PFILE', ktOtherKeyword);
    Add('PLAN', ktOtherKeyword);
    Add('PLS_INTEGER', ktDataTypeKeyword);
    Add('POSITIVE', ktDataTypeKeyword);
    Add('POSITIVEN', ktDataTypeKeyword);
    Add('POWER', ktFunctionKeyword);
    Add('PROCEDURE', ktOtherKeyword);
    Add('PROFILE', ktOtherKeyword);
    { R }
    Add('RANK', ktFunctionKeyword);
    Add('RATIO_TO_REPORT', ktFunctionKeyword);
    Add('RAW', ktDataTypeKeyword);
    Add('RAWTOHEX', ktFunctionKeyword);
    Add('RAWTONHEX', ktFunctionKeyword);
    Add('RECORD', ktDataTypeKeyword);
    Add('REAL', ktDataTypeKeyword);
    Add('REF', ktFunctionKeyword);
    Add('REFTOHEX', ktFunctionKeyword);
    Add('REGR_', ktFunctionKeyword);
    Add('RENAME', ktOtherKeyword);
    Add('REPLACE', ktFunctionKeyword);
    Add('RESOURCE', ktOtherKeyword);
    Add('REVOKE', ktOtherKeyword);
    Add('ROLE', ktOtherKeyword);
    Add('ROLLBACK', ktOtherKeyword);
    Add('ROUND', ktFunctionKeyword);
    Add('ROWID', ktDataTypeKeyword);
    Add('ROWIDTOCHAR', ktFunctionKeyword);
    Add('ROWIDTONCHAR', ktFunctionKeyword);
    Add('ROW_NUMBER', ktFunctionKeyword);
    Add('RPAD', ktFunctionKeyword);
    Add('RTRIM', ktFunctionKeyword);
    { S }
    Add('SAVEPOINT', ktOtherKeyword);
    Add('SCHEMA', ktOtherKeyword);
    Add('SEGMENT', ktOtherKeyword);
    Add('SELECT', ktOtherKeyword);
    Add('SEQUENCE', ktOtherKeyword);
    Add('SESSION', ktOtherKeyword);
    Add('SESSIONTIMEZONE', ktFunctionKeyword);
    Add('SET', ktOtherKeyword);
    Add('SIGN', ktFunctionKeyword);
    Add('SIGNTYPE', ktDataTypeKeyword);
    Add('SIN', ktFunctionKeyword);
    Add('SINH', ktFunctionKeyword);
    Add('SMALLINT', ktDataTypeKeyword);
    Add('SOME', ktOperatorKeyword);
    Add('SOUNDEX', ktFunctionKeyword);
    Add('SPFILE', ktOtherKeyword);
    Add('SQL', ktFunctionKeyword);
    Add('SQRT', ktFunctionKeyword);
    Add('STATISTICS', ktOtherKeyword);
    Add('STDDEV', ktFunctionKeyword);
    Add('STDDEV_POP', ktFunctionKeyword);
    Add('STDDEC_SAMP', ktFunctionKeyword);
    Add('STRING', ktDataTypeKeyword);
    Add('SUBSTR', ktFunctionKeyword);
    Add('SUM', ktFunctionKeyword);
    Add('SYNONYM', ktOtherKeyword);
    Add('SYSDATE', ktFunctionKeyword);
    Add('SYSTEM', ktOtherKeyword);
    Add('SYSTIMESTAMP', ktFunctionKeyword);
    Add('SYS_CONNECT_BY_PATH', ktFunctionKeyword);
    Add('SYS_CONTEXT', ktFunctionKeyword);
    Add('SYS_DBURIGEN', ktFunctionKeyword);
    Add('SYS_EXTRACT_UTC', ktFunctionKeyword);
    Add('SYS_GUID', ktFunctionKeyword);
    Add('SYS_TYPEID', ktFunctionKeyword);
    Add('SYS_XMLAGG', ktFunctionKeyword);
    Add('SYS_XMLGEN', ktFunctionKeyword);
    { T }
    Add('TABLE', ktOtherKeyword);
    Add('TABLESPACE', ktOtherKeyword);
    Add('TAN', ktFunctionKeyword);
    Add('TANH', ktFunctionKeyword);
    Add('TEMPORARY', ktOtherKeyword);
    Add('TIMESTAMP', ktDataTypeKeyword);
    Add('TO_CHAR', ktFunctionKeyword);
    Add('TO_CLOB', ktFunctionKeyword);
    Add('TO_DATE', ktFunctionKeyword);
    Add('TO_DSINTERVAL', ktFunctionKeyword);
    Add('TO_LOB', ktFunctionKeyword);
    Add('TO_MULTI_BYTE', ktFunctionKeyword);
    Add('TO_NCHAR', ktFunctionKeyword);
    Add('TO_NCLOB', ktFunctionKeyword);
    Add('TO_NUMBER', ktFunctionKeyword);
    Add('TO_SINGLE_BYTE', ktFunctionKeyword);
    Add('TO_TIMESTAMP', ktFunctionKeyword);
    Add('TO_TIMESTAMP_TZ', ktFunctionKeyword);
    Add('TO_YMINTERVAL', ktFunctionKeyword);
    Add('TRANSACTION', ktOtherKeyword);
    Add('TRANSLATE', ktFunctionKeyword);
    Add('TREAT', ktFunctionKeyword);
    Add('TRIGGER', ktOtherKeyword);
    Add('TRIM', ktFunctionKeyword);
    Add('TRUNC', ktFunctionKeyword);
    Add('TRUNCATE', ktOtherKeyword);
    Add('TYPE', ktOtherKeyword);
    Add('TZ_OFFSET', ktFunctionKeyword);
    { U }
    Add('UID', ktFunctionKeyword);
    Add('UNDER_PATH', ktFunctionKeyword);
    Add('UNION', ktOperatorKeyword);
    Add('UNISTR', ktFunctionKeyword);
    Add('UPDATE', ktOtherKeyword);
    Add('UPDATEXML', ktFunctionKeyword);
    Add('UPPER', ktFunctionKeyword);
    Add('UROWID', ktDataTypeKeyword);
    Add('USER', ktFunctionKeyword);
    Add('USERENV', ktFunctionKeyword);
    { V }
    Add('VALUE', ktFunctionKeyword);
    Add('VAR_POP', ktFunctionKeyword);
    Add('VAR_SAMP', ktFunctionKeyword);
    Add('VARCHAR', ktDataTypeKeyword);
    Add('VARCHAR2', ktDataTypeKeyword);
    Add('VARIANCE', ktFunctionKeyword);
    Add('VARRAY', ktDataTypeKeyword);
    Add('VIEW', ktOtherKeyword);
    Add('VSIZE', ktFunctionKeyword);
    { W }
    Add('WIDTH_BUCKET', ktFunctionKeyword);
    { X }
    Add('XMLAGG', ktFunctionKeyword);
    Add('XMLCOLATTVAL', ktFunctionKeyword);
    Add('XMLELEMENT', ktFunctionKeyword);
    Add('XMLFOREST', ktFunctionKeyword);
    Add('XMLSEQUENCE', ktFunctionKeyword);
    Add('XMLTRANSFORM', ktFunctionKeyword);
  end;
end;

function TSQLParser.IsStatementStarter(SQLToken: TSQLToken): Boolean;
var
  UppercaseValue: string;
begin
  //List created from experience, and augmented with individual sections of MSDN:
  // http://msdn.microsoft.com/en-us/library/ff848799.aspx
  // http://msdn.microsoft.com/en-us/library/ff848727.aspx
  // http://msdn.microsoft.com/en-us/library/ms174290.aspx
  // etc...
  UppercaseValue := UpperCase(SQLToken.Value);
  Result := (SQLToken.TokenType = ttOtherNode) and
    ( (UppercaseValue = 'ALTER') or
      (UppercaseValue = 'BACKUP') or
      (UppercaseValue = 'BREAK') or
      (UppercaseValue = 'CLOSE') or
      (UppercaseValue = 'CHECKPOINT') or
      (UppercaseValue = 'COMMIT') or
      (UppercaseValue = 'CONTINUE') or
      (UppercaseValue = 'CREATE') or
      (UppercaseValue = 'DBCC') or
      (UppercaseValue = 'DEALLOCATE') or
      (UppercaseValue = 'DELETE') or
      (UppercaseValue = 'DECLARE') or
      (UppercaseValue = 'DENY') or
      (UppercaseValue = 'DROP') or
      (UppercaseValue = 'EXEC') or
      (UppercaseValue = 'EXECUTE') or
      (UppercaseValue = 'FETCH') or
      (UppercaseValue = 'GOTO') or
      (UppercaseValue = 'GRANT') or
      (UppercaseValue = 'IF') or
      (UppercaseValue = 'INSERT') or
      (UppercaseValue = 'KILL') or
      (UppercaseValue = 'MERGE') or
      (UppercaseValue = 'OPEN') or
      (UppercaseValue = 'PRINT') or
      (UppercaseValue = 'RAISERROR') or
      (UppercaseValue = 'RECONFIGURE') or
      (UppercaseValue = 'RESTORE') or
      (UppercaseValue = 'RETURN') or
      (UppercaseValue = 'REVERT') or
      (UppercaseValue = 'REVOKE') or
      (UppercaseValue = 'SELECT') or
      (UppercaseValue = 'SET') or
      (UppercaseValue = 'SETUSER') or
      (UppercaseValue = 'SHUTDOWN') or
      (UppercaseValue = 'TRUNCATE') or
      (UppercaseValue = 'UPDATE') or
      (UppercaseValue = 'USE') or
      (UppercaseValue = 'WAITFOR') or
      (UppercaseValue = 'WHILE')
    );
end;

function TSQLParser.IsClauseStarter(SQLToken: TSQLToken): Boolean;
var
  UppercaseValue: string;
begin
  //Note: some clause starters are handled separately: Joins, RETURNS clauses, etc.
  UppercaseValue := UpperCase(SQLToken.Value);
  Result := (SQLToken.TokenType = ttOtherNode) and
      ( (UppercaseValue = 'DELETE') or
        (UppercaseValue = 'EXCEPT') or
        (UppercaseValue = 'FOR') or
        (UppercaseValue = 'FROM') or
        (UppercaseValue = 'GROUP') or
        (UppercaseValue = 'HAVING') or
        (UppercaseValue = 'INNER') or
        (UppercaseValue = 'INTERSECT') or
        (UppercaseValue = 'INTO') or
        (UppercaseValue = 'INSERT') or
        (UppercaseValue = 'MERGE') or
        (UppercaseValue = 'ORDER') or
        (UppercaseValue = 'OUTPUT') or //this is complicated... in sprocs output means something else!
        (UppercaseValue = 'PIVOT') or
        (UppercaseValue = 'RETURNS') or
        (UppercaseValue = 'SELECT') or
        (UppercaseValue = 'UNION') or
        (UppercaseValue = 'UNPIVOT') or
        (UppercaseValue = 'UPDATE') or
        (UppercaseValue = 'USING') or
        (UppercaseValue = 'VALUES') or
        (UppercaseValue = 'WHERE') or
        (UppercaseValue = 'WITH')
      );
end;

end.
