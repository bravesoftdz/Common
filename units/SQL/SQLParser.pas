unit SQLParser;

interface

uses
  SQLParseTree, RegularExpressions, Generics.Collections, SQLTokenizer, XMLIntf;

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
    function GetSignificantTokenPositions(SQLTokenList: TSQLTokenList; TokenID: Integer;
      SearchDistance: Integer): TSQLTokenPositionsList;
    function ExtractTokensString(SQLTokenList: TSQLTokenList; SignificantTokenPositions: TSQLTokenPositionsList): string;
    procedure AppendNodesWithMapping(SQLParseTree: TSQLParseTree; Tokens: TSQLTokenList; OtherTokenMappingName: string; TargetContainer: IXMLNode);
    procedure ProcessCompoundKeyword(SQLTokenList: TSQLTokenList; SQLParseTree: TSQLParseTree; TargetContainer: IXMLNode; var TokenID: Integer; SignificantTokenPositions: TSQLTokenPositionsList; KeywordCount: Integer);
    procedure ProcessCompoundKeywordWithError(SQLTokenList: TSQLTokenList; SQLParseTree: TSQLParseTree; CurrentContainerElement: IXMLNode; var TokenID: Integer; SignificantTokenPositions: TSQLTokenPositionsList; KeywordCount: Integer);
    function ContentStartsWithKeyword(ProvidedContainer: IXMLNode; ContentToMatch: string): Boolean;
    function IsLineBreakingWhiteSpaceOrComment(SQLToken: TSQLToken): Boolean;
    function IsFollowedByLineBreakingWhiteSpaceOrSingleLineCommentOrEnd(SQLTokenList: TSQLTokenList; TokenID: Integer): Boolean;
    function IsLatestTokenAComma(SQLParseTree: TSQLParseTree): Boolean;
    function IsStatementStarter(SQLToken: TSQLToken): Boolean;
    function IsClauseStarter(SQLToken: TSQLToken): Boolean;
    function GetEquivalentSQLName(SQLTokenType: TSQLTokenType): string;
  public
    constructor Create;
    function CreateSQLParseTree(SQL: string): TSQLParseTree;
  end;

implementation

uses
  Classes, Windows, SysUtils, StrUtils, SQLConstants, Common;

constructor TSQLParser.Create;
begin
  inherited;
  InitializeKeywordList;
  FJoinDetector := TRegEx.Create('^((RIGHT|INNER|LEFT|CROSS|FULL) )?(OUTER )?((HASH|LOOP|MERGE|REMOTE) )?(JOIN|APPLY) ');
  FCursorDetector := TRegEx.Create('^DECLARE [\p{L};0-9_\$\@\#]+ ((INSENSITIVE|SCROLL) ){0,2};CURSOR ');
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

{ Damn, I hate parsers... }
function TSQLParser.CreateSQLParseTree(SQL: string): TSQLParseTree;
var
  SQLTokenizer: TSQLTokenizer;
  i, TokenCount, TokenID: Integer;
  Token: TSQLToken;
  FirstNonCommentParensSibling: IXMLNode;
  IsInsertOrValuesClause: Boolean;
  SignificantTokenPositions: TSQLTokenPositionsList;
  SignificantTokensString: string;
  TriggerConditions: TMatch;
  TriggerConditionType: IXMLNode;
  TriggerConditionTypeSimpleText: string;
  TriggerConditionTypeNodeCount, TriggerConditionNodeCount: Integer;
  NextKeywordType, MatchedKeywordType: TKeywordType;
  IsDataTypeDefinition, StopSearching,
  SelectShouldntTryToStartNewStatement, IsPrecededByInsertStatement,
  ExistingSelectClauseFound, ExistingValuesClauseFound, ExistingExecClauseFound,
  IsCTESplitter: Boolean;
  NewTryBlock, TryContainerOpen, TryMultiContainer, NewCatchBlock, CatchContainerOpen,
  CatchMultiContainer, TryBlock, TryContainerClose, CatchBlock, CatchContainerClose,
  BeginBlock, BeginContainerClose, SQLRoot, BatchSeparator, UnionClause, NewWhileLoop,
  WhileContainerOpen, CurrentNode, FirstStatementClause, FirstEntryOfThisClause,
  FirstNonCommentSibling2, Node: IXMLNode;
  IsSprocArgument, ExecuteAsInWithOptions, ExecShouldntTryToStartNewStatement: Boolean;
  ExistingClauseCount, TargetKeywordCount: Integer;
  JoinText: string;
  NodeList, TempList: IXMLNodeList;
  NewName: string;
  NewRoot: IXMLNode;
begin
  Result := TSQLParseTree.Create; //(SQLConstants.ENAME_SQL_ROOT); //, '', nil); //SQLConstants.ENAME_SQL_ROOT);
 // Result.CurrentContainer := Result.SaveNewElement(SQLConstants.ENAME_SQL_ROOT, '', Result);
  //NewRoot := Result.CreateElement(SQLConstants.ENAME_SQL_ROOT, '');//Result.CreateElement(SQLConstants.ENAME_SQL_ROOT, '');
  //Result.DocumentElement := NewRoot; //Result.CreateNode(SQLConstants.ENAME_SQL_ROOT, ntElement, ''); //appendChild(NewRoot);
  //Result.CurrentContainer := NewRoot;
  Result.Active := True;
  NewRoot := Result.CreateElement(SQLConstants.ENAME_SQL_ROOT, '');//Result.CreateElement(SQLConstants.ENAME_SQL_ROOT, '');
  Result.DocumentElement := NewRoot; //Result.CreateNode(SQLConstants.ENAME_SQL_ROOT, ntElement, ''); //appendChild(NewRoot);
  Result.CurrentContainer := NewRoot;

  SQLTokenizer := TSQLTokenizer.Create(SQL);
  try
    Result.ErrorFound := SQLTokenizer.SQLTokenList.HasErrors;
    Result.StartNewStatement;
    TokenCount := SQLTokenizer.SQLTokenList.Count;
    TokenID := 0;
    while TokenID < TokenCount do
    begin
      Token := SQLTokenizer.SQLTokenList[TokenID];
      case Token.TokenType of
        ttOpenParens:
        begin
          FirstNonCommentParensSibling := Result.GetFirstNonWhitespaceNonCommentChildElement(Result.CurrentContainer);
          IsInsertOrValuesClause := Assigned(FirstNonCommentParensSibling) and
            ( (FirstNonCommentParensSibling.NodeName = SQLConstants.ENAME_OTHERKEYWORD) and
               StartsWith(FirstNonCommentParensSibling.NodeValue, 'INSERT') ) or
            ( (FirstNonCommentParensSibling.NodeName = SQLConstants.ENAME_COMPOUNDKEYWORD) and
              StartsWith(FirstNonCommentParensSibling.AttributeNodes.FindNode(SQLConstants.ANAME_SIMPLETEXT).NodeValue, 'INSERT ') ) or
            ( (FirstNonCommentParensSibling.NodeName = SQLConstants.ENAME_OTHERKEYWORD) and
              StartsWith(FirstNonCommentParensSibling.NodeValue, 'VALUES') );


          if (Result.CurrentContainer.NodeName = SQLConstants.ENAME_CTE_ALIAS) and
            (Result.CurrentContainer.ParentNode.NodeName = SQLConstants.ENAME_CTE_WITH_CLAUSE) then
            Result.CurrentContainer := Result.SaveNewElement(SQLConstants.ENAME_DDL_PARENS, '')
          else
          if (Result.CurrentContainer.NodeName = SQLConstants.ENAME_CONTAINER_GENERALCONTENT) and
             (Result.CurrentContainer.ParentNode.NodeName = SQLConstants.ENAME_CTE_AS_BLOCK) then
             Result.CurrentContainer := Result.SaveNewElement(SQLConstants.ENAME_SELECTIONTARGET_PARENS, '')
          else
          if not Assigned(FirstNonCommentParensSibling) and
            (Result.CurrentContainer.NodeName = SQLConstants.ENAME_SELECTIONTARGET) then
            Result.CurrentContainer := Result.SaveNewElement(SQLConstants.ENAME_SELECTIONTARGET_PARENS, '')
          else
          if Assigned(FirstNonCommentParensSibling) and
            (FirstNonCommentParensSibling.NodeName = SQLConstants.ENAME_SET_OPERATOR_CLAUSE) then
          begin
            Result.ConsiderStartingNewClause();
            Result.CurrentContainer := Result.SaveNewElement(SQLConstants.ENAME_SELECTIONTARGET_PARENS, '');
          end
          else
          if IsLatestTokenADDLDetailValue(Result) then
            Result.CurrentContainer := Result.SaveNewElement(SQLConstants.ENAME_DDLDETAIL_PARENS, '')
          else
          if (Result.CurrentContainer.NodeName = SQLConstants.ENAME_DDL_PROCEDURAL_BLOCK) or
            (Result.CurrentContainer.NodeName = SQLConstants.ENAME_DDL_OTHER_BLOCK) or
             IsInsertOrValuesClause then
            Result.CurrentContainer := Result.SaveNewElement(SQLConstants.ENAME_DDL_PARENS, '')
          else
          if IsLatestTokenAMiscName(Result) then
            Result.CurrentContainer := Result.SaveNewElement(SQLConstants.ENAME_FUNCTION_PARENS, '')
          else
            Result.CurrentContainer := Result.SaveNewElement(SQLConstants.ENAME_EXPRESSION_PARENS, '');
          end;

          ttCloseParens:
          begin
            //we're not likely to actually have a 'SingleStatement' in parens, but
            // we definitely want the side-effects (all the lower-level escapes)
            Result.EscapeAnySingleOrPartialStatementContainers;

            //check whether we expected to end the parens...
            if (Result.CurrentContainer.NodeName = SQLConstants.ENAME_DDLDETAIL_PARENS) or
              (Result.CurrentContainer.NodeName = SQLConstants.ENAME_DDL_PARENS) or
              (Result.CurrentContainer.NodeName = SQLConstants.ENAME_FUNCTION_PARENS) or
              (Result.CurrentContainer.NodeName = SQLConstants.ENAME_EXPRESSION_PARENS) or
              (Result.CurrentContainer.NodeName = SQLConstants.ENAME_SELECTIONTARGET_PARENS) then
              Result.MoveToAncestorContainer(1) //unspecified parent node...
            else
            if (Result.CurrentContainer.NodeName = SQLConstants.ENAME_SQL_CLAUSE) and
              (Result.CurrentContainer.ParentNode.NodeName = SQLConstants.ENAME_SELECTIONTARGET_PARENS) and
              (Result.CurrentContainer.ParentNode.ParentNode.NodeName = SQLConstants.ENAME_CONTAINER_GENERALCONTENT) and
              (Result.CurrentContainer.ParentNode.ParentNode.ParentNode.NodeName = SQLConstants.ENAME_CTE_AS_BLOCK) then
              begin
                Result.MoveToAncestorContainer(4, SQLConstants.ENAME_CTE_WITH_CLAUSE);
                Result.CurrentContainer := Result.SaveNewElement(SQLConstants.ENAME_CONTAINER_GENERALCONTENT, '');
              end
              else
              if (Result.CurrentContainer.NodeName = SQLConstants.ENAME_SQL_CLAUSE) and
                ( (Result.CurrentContainer.ParentNode.NodeName = SQLConstants.ENAME_EXPRESSION_PARENS) or
                  (Result.CurrentContainer.ParentNode.NodeName = SQLConstants.ENAME_SELECTIONTARGET_PARENS) ) then
                Result.MoveToAncestorContainer(2) //unspecified grandfather node.
              else
                Result.SaveNewElementWithError(SQLConstants.ENAME_OTHERNODE, ')');

          end;
          { other node }
          ttOtherNode:
          begin
            SignificantTokenPositions := GetSignificantTokenPositions(SQLTokenizer.SQLTokenList, TokenID, 7);
            SignificantTokensString := ExtractTokensString(SQLTokenizer.SQLTokenList, SignificantTokenPositions);

            if Result.PathNameMatches(0, SQLConstants.ENAME_PERMISSIONS_DETAIL) then
            begin
              //if we're in a permissions detail clause, we can expect all sorts of statements
              // starters and should ignore them all; the only possible keywords to escape are
              // 'ON' and 'TO'.
              if StartsWith(SignificantTokensString, 'ON ') then
              begin
                Result.MoveToAncestorContainer(1, SQLConstants.ENAME_PERMISSIONS_BLOCK);
                Result.StartNewContainer(SQLConstants.ENAME_PERMISSIONS_TARGET, Token.Value, SQLConstants.ENAME_CONTAINER_GENERALCONTENT);
              end
              else
              if StartsWith(SignificantTokensString, 'TO ') or StartsWith(SignificantTokensString, 'FROM ') then
              begin
                Result.MoveToAncestorContainer(1, SQLConstants.ENAME_PERMISSIONS_BLOCK);
                Result.StartNewContainer(SQLConstants.ENAME_PERMISSIONS_RECIPIENT, Token.Value, SQLConstants.ENAME_CONTAINER_GENERALCONTENT);
              end
              else
                //default to 'some classification of permission'
                Result.SaveNewElement(SQLConstants.ENAME_OTHERKEYWORD, Token.Value);
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
              Result.ConsiderStartingNewStatement();
              Result.CurrentContainer := Result.SaveNewElement(SQLConstants.ENAME_DDL_PROCEDURAL_BLOCK, '');
              Result.SaveNewElement(SQLConstants.ENAME_OTHERKEYWORD, Token.Value);
            end
            else
            if FCursorDetector.IsMatch(SignificantTokensString) then
            begin
              Result.ConsiderStartingNewStatement();
              Result.CurrentContainer := Result.SaveNewElement(SQLConstants.ENAME_CURSOR_DECLARATION, '');
              Result.SaveNewElement(SQLConstants.ENAME_OTHERKEYWORD, Token.Value);
            end
            else
            if Result.PathNameMatches(0, SQLConstants.ENAME_DDL_PROCEDURAL_BLOCK) and
              FTriggerConditionDetector.IsMatch(significantTokensString)  then
            begin
              //horrible complicated forward-search, to avoid having to keep a different 'Trigger Condition' state for Update, Insert and Delete statement-starting keywords
              TriggerConditions := FTriggerConditionDetector.Match(SignificantTokensString);
              Result.CurrentContainer := Result.SaveNewElement(SQLConstants.ENAME_TRIGGER_CONDITION, '');
              TriggerConditionType := Result.SaveNewElement(SQLConstants.ENAME_COMPOUNDKEYWORD, '');

              //first set the 'trigger condition type': FOR, INSTEAD OF, AFTER
              TriggerConditionTypeSimpleText := TriggerConditions.Groups[1].Value;
              TriggerConditionType.AttributeNodes.FindNode(SQLConstants.ANAME_SIMPLETEXT).NodeValue := TriggerConditionTypeSimpleText;
              TriggerConditionTypeNodeCount := WordCount(TriggerConditionTypeSimpleText); //TriggerConditionTypeSimpleText.Split(new char[] begin ' ' end;).Length; //there's probably a better way of counting words...
              AppendNodesWithMapping(Result, SQLTokenizer.SQLTokenList.GetRangeByIndex(SignificantTokenPositions[0], SignificantTokenPositions[triggerConditionTypeNodeCount - 1]), SQLConstants.ENAME_OTHERKEYWORD, triggerConditionType);

              //then get the count of conditions (INSERT, UPDATE, DELETE) and add those too...
              TriggerConditionNodeCount := WordCount(TriggerConditions.Groups[2].Value); //.Split(new char[] begin ' ' end;).Length - 2; //there's probably a better way of counting words...
              AppendNodesWithMapping(Result, SQLTokenizer.SQLTokenList.GetRangeByIndex(SignificantTokenPositions[triggerConditionTypeNodeCount - 1] + 1, SignificantTokenPositions[triggerConditionTypeNodeCount + triggerConditionNodeCount - 1]), SQLConstants.ENAME_OTHERKEYWORD, Result.CurrentContainer);
              TokenID := SignificantTokenPositions[triggerConditionTypeNodeCount + triggerConditionNodeCount - 1];
              Result.MoveToAncestorContainer(1, SQLConstants.ENAME_DDL_PROCEDURAL_BLOCK);
            end
            else
            if StartsWith(SignificantTokensString, 'FOR ') then
            begin
              Result.EscapeAnyBetweenConditions;
              Result.EscapeAnySelectionTarget;
              Result.EscapeJoinCondition;

              if Result.PathNameMatches(0, SQLConstants.ENAME_CURSOR_DECLARATION) then
              begin
                Result.StartNewContainer(SQLConstants.ENAME_CURSOR_FOR_BLOCK, Token.Value, SQLConstants.ENAME_CONTAINER_GENERALCONTENT);
                Result.StartNewStatement;
              end
              else
              if Result.PathNameMatches(0, SQLConstants.ENAME_SQL_CLAUSE) and
                Result.PathNameMatches(1, SQLConstants.ENAME_SQL_STATEMENT) and
                Result.PathNameMatches(2, SQLConstants.ENAME_CONTAINER_GENERALCONTENT) and
                Result.PathNameMatches(3, SQLConstants.ENAME_CURSOR_FOR_BLOCK) then
              begin
                Result.MoveToAncestorContainer(4, SQLConstants.ENAME_CURSOR_DECLARATION);
                Result.StartNewContainer(SQLConstants.ENAME_CURSOR_FOR_OPTIONS, Token.Value, SQLConstants.ENAME_CONTAINER_GENERALCONTENT);
              end
              else
              begin
                //Assume FOR clause if we're at clause level
                // (otherwise, eg in OPTIMIZE FOR UNKNOWN, this will just not do anything)
                Result.ConsiderStartingNewClause;

                Result.SaveNewElement(SQLConstants.ENAME_OTHERKEYWORD, Token.Value);
              end;
            end
            else
            if StartsWith(SignificantTokensString, 'CREATE ') or
              StartsWith(SignificantTokensString, 'ALTER ') or
              StartsWith(SignificantTokensString, 'DECLARE ') then
            begin
              Result.ConsiderStartingNewStatement;
              Result.CurrentContainer := Result.SaveNewElement(SQLConstants.ENAME_DDL_OTHER_BLOCK, '');
              Result.SaveNewElement(SQLConstants.ENAME_OTHERKEYWORD, Token.Value);
            end
            else
            if StartsWith(SignificantTokensString, 'GRANT ') or
              StartsWith(SignificantTokensString, 'DENY ') or
              StartsWith(SignificantTokensString, 'REVOKE ') then
            begin
              if StartsWith(SignificantTokensString, 'GRANT ') and
                Result.PathNameMatches(0, SQLConstants.ENAME_CONTAINER_GENERALCONTENT) and
                Result.PathNameMatches(1, SQLConstants.ENAME_DDL_WITH_CLAUSE) and
                Result.PathNameMatches(2, SQLConstants.ENAME_PERMISSIONS_BLOCK) and
                (Result.GetFirstNonWhitespaceNonCommentChildElement(Result.CurrentContainer) = nil) then
                //this MUST be a 'WITH GRANT OPTION' option...
                Result.SaveNewElement(SQLConstants.ENAME_OTHERKEYWORD, Token.Value)
              else
              begin
                Result.ConsiderStartingNewStatement;
                Result.StartNewContainer(SQLConstants.ENAME_PERMISSIONS_BLOCK, Token.Value, SQLConstants.ENAME_PERMISSIONS_DETAIL);
              end;
            end
            else
            if (Result.CurrentContainer.NodeName = SQLConstants.ENAME_DDL_PROCEDURAL_BLOCK) and
              StartsWith(SignificantTokensString, 'RETURNS ') then
              Result.SaveNewElement(SQLConstants.ENAME_OTHERKEYWORD, Token.Value, Result.SaveNewElement(SQLConstants.ENAME_DDL_RETURNS, ''))
            else
            if StartsWith(SignificantTokensString, 'AS ') then
            begin
              if Result.PathNameMatches(0, SQLConstants.ENAME_DDL_PROCEDURAL_BLOCK) then
              begin
                IsDataTypeDefinition := False;
                if (SignificantTokenPositions.Count > 1) and
                  FKeywordList.TryGetValue(SQLTokenizer.SQLTokenList[SignificantTokenPositions[1]].Value, NextKeywordType) then
                    if (NextKeywordType = ktDataTypeKeyword) then
                      IsDataTypeDefinition := True;

                if isDataTypeDefinition then
                    //this is actually a data type declaration (redundant 'AS'...), save as regular Token.
                  Result.SaveNewElement(SQLConstants.ENAME_OTHERKEYWORD, Token.Value)
                else
                begin
                  //this is the start of the object content definition
                  Result.StartNewContainer(SQLConstants.ENAME_DDL_AS_BLOCK, Token.Value, SQLConstants.ENAME_CONTAINER_GENERALCONTENT);
                  Result.StartNewStatement;
                end;
              end
              else
              if Result.PathNameMatches(0, SQLConstants.ENAME_CONTAINER_GENERALCONTENT) and
                Result.PathNameMatches(1, SQLConstants.ENAME_DDL_WITH_CLAUSE) and
                Result.PathNameMatches(2, SQLConstants.ENAME_DDL_PROCEDURAL_BLOCK) then
              begin
                Result.MoveToAncestorContainer(2, SQLConstants.ENAME_DDL_PROCEDURAL_BLOCK);
                Result.StartNewContainer(SQLConstants.ENAME_DDL_AS_BLOCK, Token.Value, SQLConstants.ENAME_CONTAINER_GENERALCONTENT);
                Result.StartNewStatement;
              end
              else
              if Result.PathNameMatches(0, SQLConstants.ENAME_CTE_ALIAS) and
                Result.PathNameMatches(1, SQLConstants.ENAME_CTE_WITH_CLAUSE) then
              begin
                Result.MoveToAncestorContainer(1, SQLConstants.ENAME_CTE_WITH_CLAUSE);
                Result.StartNewContainer(SQLConstants.ENAME_CTE_AS_BLOCK, Token.Value, SQLConstants.ENAME_CONTAINER_GENERALCONTENT);
              end
              else
                Result.SaveNewElement(SQLConstants.ENAME_OTHERKEYWORD, Token.Value);
            end
            else
            if StartsWith(SignificantTokensString, 'BEGIN DISTRIBUTED TRANSACTION ') or
              StartsWith(SignificantTokensString, 'BEGIN DISTRIBUTED TRAN ') then
            begin
              Result.ConsiderStartingNewStatement;
              ProcessCompoundKeyword(SQLTokenizer.SQLTokenList, Result, Result.SaveNewElement(SQLConstants.ENAME_BEGIN_TRANSACTION, ''), TokenID, SignificantTokenPositions, 3);
            end
            else
            if StartsWith(SignificantTokensString, 'BEGIN TRANSACTION ') or
              StartsWith(SignificantTokensString, 'BEGIN TRAN ') then
            begin
              Result.ConsiderStartingNewStatement;
              ProcessCompoundKeyword(SQLTokenizer.SQLTokenList, Result, Result.SaveNewElement(SQLConstants.ENAME_BEGIN_TRANSACTION, ''), TokenID, SignificantTokenPositions, 2);
            end
            else
            if StartsWith(SignificantTokensString, 'SAVE TRANSACTION ') or
              StartsWith(SignificantTokensString, 'SAVE TRAN ') then
            begin
              Result.ConsiderStartingNewStatement;
              ProcessCompoundKeyword(SQLTokenizer.SQLTokenList, Result, Result.SaveNewElement(SQLConstants.ENAME_SAVE_TRANSACTION, ''), TokenID, SignificantTokenPositions, 2);
            end
            else
            if StartsWith(SignificantTokensString, 'COMMIT TRANSACTION ') or
              StartsWith(SignificantTokensString, 'COMMIT TRAN ') or
              StartsWith(SignificantTokensString, 'COMMIT WORK ') then
            begin
              Result.ConsiderStartingNewStatement;
              ProcessCompoundKeyword(SQLTokenizer.SQLTokenList, Result, Result.SaveNewElement(SQLConstants.ENAME_COMMIT_TRANSACTION, ''), TokenID, SignificantTokenPositions, 2);
            end
            else
            if StartsWith(SignificantTokensString, 'COMMIT ') then
            begin
              Result.ConsiderStartingNewStatement;
              Result.SaveNewElement(SQLConstants.ENAME_OTHERKEYWORD, Token.Value, Result.SaveNewElement(SQLConstants.ENAME_COMMIT_TRANSACTION, Token.Value));
            end
            else
            if StartsWith(SignificantTokensString, 'ROLLBACK TRANSACTION ') or
              StartsWith(SignificantTokensString, 'ROLLBACK TRAN ') or
              StartsWith(SignificantTokensString, 'ROLLBACK WORK ') then
            begin
              Result.ConsiderStartingNewStatement;
              ProcessCompoundKeyword(SQLTokenizer.SQLTokenList, Result, Result.SaveNewElement(SQLConstants.ENAME_ROLLBACK_TRANSACTION, ''), TokenID, SignificantTokenPositions, 2);
            end
            else
            if StartsWith(SignificantTokensString, 'ROLLBACK ') then
            begin
              Result.ConsiderStartingNewStatement;
              Result.SaveNewElement(SQLConstants.ENAME_OTHERKEYWORD, Token.Value, Result.SaveNewElement(SQLConstants.ENAME_ROLLBACK_TRANSACTION, Token.Value));
            end
            else
            if StartsWith(SignificantTokensString, 'BEGIN TRY ') then
            begin
              Result.ConsiderStartingNewStatement;
              NewTryBlock := Result.SaveNewElement(SQLConstants.ENAME_TRY_BLOCK, '');
              TryContainerOpen := Result.SaveNewElement(SQLConstants.ENAME_CONTAINER_OPEN, '', NewTryBlock);
              ProcessCompoundKeyword(SQLTokenizer.SQLTokenList, Result, TryContainerOpen, TokenID, SignificantTokenPositions, 2);
              TryMultiContainer := Result.SaveNewElement(SQLConstants.ENAME_CONTAINER_MULTISTATEMENT, '', NewTryBlock);
              Result.StartNewStatement(TryMultiContainer);
            end
            else
            if StartsWith(SignificantTokensString, 'BEGIN CATCH ') then
            begin
              Result.ConsiderStartingNewStatement;
              NewCatchBlock := Result.SaveNewElement(SQLConstants.ENAME_CATCH_BLOCK, '');
              CatchContainerOpen := Result.SaveNewElement(SQLConstants.ENAME_CONTAINER_OPEN, '', NewCatchBlock);
              ProcessCompoundKeyword(SQLTokenizer.SQLTokenList, Result, CatchContainerOpen, TokenID, SignificantTokenPositions, 2);
              CatchMultiContainer := Result.SaveNewElement(SQLConstants.ENAME_CONTAINER_MULTISTATEMENT, '', NewCatchBlock);
              Result.StartNewStatement(CatchMultiContainer);
            end
            else if StartsWith(SignificantTokensString, 'BEGIN ') then
            begin
              Result.ConsiderStartingNewStatement;
              Result.StartNewContainer(SQLConstants.ENAME_BEGIN_END_BLOCK, Token.Value, SQLConstants.ENAME_CONTAINER_MULTISTATEMENT);
              Result.StartNewStatement;
            end
            else if StartsWith(SignificantTokensString, 'MERGE ') then
            begin
              //According to BOL, MERGE is a fully reserved keyword from compat 100 onwards, for the MERGE statement only.
              Result.ConsiderStartingNewStatement;
              Result.ConsiderStartingNewClause;
              Result.StartNewContainer(SQLConstants.ENAME_MERGE_CLAUSE, Token.Value, SQLConstants.ENAME_MERGE_TARGET);
            end
            else if StartsWith(SignificantTokensString, 'USING ') then
            begin
              if Result.PathNameMatches(0, SQLConstants.ENAME_MERGE_TARGET) then
              begin
                  Result.MoveToAncestorContainer(1, SQLConstants.ENAME_MERGE_CLAUSE);
                  Result.StartNewContainer(SQLConstants.ENAME_MERGE_USING, Token.Value, SQLConstants.ENAME_SELECTIONTARGET);
              end
              else
                  Result.SaveNewElementWithError(SQLConstants.ENAME_OTHERNODE, Token.Value);
            end
            else
            if StartsWith(SignificantTokensString, 'ON ') then
            begin
              Result.EscapeAnySelectionTarget;

              if Result.PathNameMatches(0, SQLConstants.ENAME_MERGE_USING) then
              begin
                  Result.MoveToAncestorContainer(1, SQLConstants.ENAME_MERGE_CLAUSE);
                  Result.StartNewContainer(SQLConstants.ENAME_MERGE_CONDITION, Token.Value, SQLConstants.ENAME_CONTAINER_GENERALCONTENT);
              end
              else
              if not Result.PathNameMatches(0, SQLConstants.ENAME_DDL_PROCEDURAL_BLOCK) and
                not Result.PathNameMatches(0, SQLConstants.ENAME_DDL_OTHER_BLOCK) and
                not Result.PathNameMatches(1, SQLConstants.ENAME_DDL_WITH_CLAUSE) and
                not Result.PathNameMatches(0, SQLConstants.ENAME_EXPRESSION_PARENS) and
                not ContentStartsWithKeyword(Result.CurrentContainer, 'SET') then
                Result.StartNewContainer(SQLConstants.ENAME_JOIN_ON_SECTION, Token.Value, SQLConstants.ENAME_CONTAINER_GENERALCONTENT)
              else
                Result.SaveNewElement(SQLConstants.ENAME_OTHERKEYWORD, Token.Value);
            end
            else
            if StartsWith(SignificantTokensString, 'CASE ') then
              Result.StartNewContainer(SQLConstants.ENAME_CASE_STATEMENT, Token.Value, SQLConstants.ENAME_CASE_INPUT)
            else
            if StartsWith(SignificantTokensString, 'WHEN ') then
            begin
              Result.EscapeMergeAction;

              if Result.PathNameMatches(0, SQLConstants.ENAME_CASE_INPUT) or
                (Result.PathNameMatches(0, SQLConstants.ENAME_CONTAINER_GENERALCONTENT) and
                 Result.PathNameMatches(1, SQLConstants.ENAME_CASE_THEN)) then
              begin
                if Result.PathNameMatches(0, SQLConstants.ENAME_CASE_INPUT) then
                  Result.MoveToAncestorContainer(1, SQLConstants.ENAME_CASE_STATEMENT)
                else
                  Result.MoveToAncestorContainer(3, SQLConstants.ENAME_CASE_STATEMENT);

                Result.StartNewContainer(SQLConstants.ENAME_CASE_WHEN, Token.Value, SQLConstants.ENAME_CONTAINER_GENERALCONTENT);
              end
              else
              if (Result.PathNameMatches(0, SQLConstants.ENAME_CONTAINER_GENERALCONTENT) and
                  Result.PathNameMatches(1, SQLConstants.ENAME_MERGE_CONDITION)) or
                  Result.PathNameMatches(0, SQLConstants.ENAME_MERGE_WHEN) then
              begin
                if Result.PathNameMatches(1, SQLConstants.ENAME_MERGE_CONDITION) then
                  Result.MoveToAncestorContainer(2, SQLConstants.ENAME_MERGE_CLAUSE)
                else
                  Result.MoveToAncestorContainer(1, SQLConstants.ENAME_MERGE_CLAUSE);

                Result.StartNewContainer(SQLConstants.ENAME_MERGE_WHEN, Token.Value, SQLConstants.ENAME_CONTAINER_GENERALCONTENT);
              end
              else
                Result.SaveNewElementWithError(SQLConstants.ENAME_OTHERNODE, Token.Value);
            end
            else
            if StartsWith(SignificantTokensString, 'THEN ') then
            begin
              Result.EscapeAnyBetweenConditions;

              if Result.PathNameMatches(0, SQLConstants.ENAME_CONTAINER_GENERALCONTENT) and
                Result.PathNameMatches(1, SQLConstants.ENAME_CASE_WHEN) then
              begin
                Result.MoveToAncestorContainer(1, SQLConstants.ENAME_CASE_WHEN);
                Result.StartNewContainer(SQLConstants.ENAME_CASE_THEN, Token.Value, SQLConstants.ENAME_CONTAINER_GENERALCONTENT);
              end
              else
              if Result.PathNameMatches(0, SQLConstants.ENAME_CONTAINER_GENERALCONTENT) and
                Result.PathNameMatches(1, SQLConstants.ENAME_MERGE_WHEN) then
              begin
                Result.MoveToAncestorContainer(1, SQLConstants.ENAME_MERGE_WHEN);
                Result.StartNewContainer(SQLConstants.ENAME_MERGE_THEN, Token.Value, SQLConstants.ENAME_MERGE_ACTION);
                Result.StartNewStatement;
              end
              else
                Result.SaveNewElementWithError(SQLConstants.ENAME_OTHERNODE, Token.Value);
            end
            else
            if StartsWith(SignificantTokensString, 'OUTPUT ') then
            begin
              //We're looking for sproc calls - they can't be nested inside anything else (as far as I know)
              IsSprocArgument := Result.PathNameMatches(0, SQLConstants.ENAME_SQL_CLAUSE) and
                Result.PathNameMatches(1, SQLConstants.ENAME_SQL_STATEMENT) and
                (ContentStartsWithKeyword(Result.CurrentContainer, 'EXEC') or
                 ContentStartsWithKeyword(Result.CurrentContainer, 'EXECUTE') or
                 ContentStartsWithKeyword(Result.CurrentContainer, ''));

              if not IsSprocArgument then
              begin
                Result.EscapeMergeAction;
                Result.ConsiderStartingNewClause;
              end;

              Result.SaveNewElement(SQLConstants.ENAME_OTHERKEYWORD, Token.Value);
            end
            else
            if StartsWith(SignificantTokensString, 'OPTION ') then
            begin
              if Result.PathNameMatches(0, SQLConstants.ENAME_CONTAINER_GENERALCONTENT) and
                 Result.PathNameMatches(1, SQLConstants.ENAME_DDL_WITH_CLAUSE) then
              begin
                  //'OPTION' keyword here is NOT indicative of a new clause.
              end
              else
              begin
                Result.EscapeMergeAction;
                Result.ConsiderStartingNewClause;
              end;
              Result.SaveNewElement(SQLConstants.ENAME_OTHERKEYWORD, Token.Value);
            end
            else
            if StartsWith(SignificantTokensString, 'END TRY ') then
            begin
              Result.EscapeAnySingleOrPartialStatementContainers;

              if Result.PathNameMatches(0, SQLConstants.ENAME_SQL_CLAUSE) and
                 Result.PathNameMatches(1, SQLConstants.ENAME_SQL_STATEMENT) and
                 Result.PathNameMatches(2, SQLConstants.ENAME_CONTAINER_MULTISTATEMENT) and
                 Result.PathNameMatches(3, SQLConstants.ENAME_TRY_BLOCK) then
              begin
                  //clause.statement.multicontainer.try
                  TryBlock := IXMLNode(Result.CurrentContainer.ParentNode.ParentNode.ParentNode);
                  TryContainerClose := Result.SaveNewElement(SQLConstants.ENAME_CONTAINER_CLOSE, '', tryBlock);
                  ProcessCompoundKeyword(SQLTokenizer.SQLTokenList, Result, tryContainerClose, TokenID, SignificantTokenPositions, 2);
                  Result.CurrentContainer := IXMLNode(TryBlock.ParentNode);
              end
              else
                ProcessCompoundKeywordWithError(SQLTokenizer.SQLTokenList, Result, Result.CurrentContainer, TokenID, SignificantTokenPositions, 2);
            end
            else
            if StartsWith(SignificantTokensString, 'END CATCH ') then
            begin
              Result.EscapeAnySingleOrPartialStatementContainers;

              if Result.PathNameMatches(0, SQLConstants.ENAME_SQL_CLAUSE) and
                 Result.PathNameMatches(1, SQLConstants.ENAME_SQL_STATEMENT) and
                 Result.PathNameMatches(2, SQLConstants.ENAME_CONTAINER_MULTISTATEMENT) and
                 Result.PathNameMatches(3, SQLConstants.ENAME_CATCH_BLOCK) then
              begin
                //clause.statement.multicontainer.catch
                CatchBlock := IXMLNode(Result.CurrentContainer.ParentNode.ParentNode.ParentNode);
                CatchContainerClose := Result.SaveNewElement(SQLConstants.ENAME_CONTAINER_CLOSE, '', CatchBlock);
                ProcessCompoundKeyword(SQLTokenizer.SQLTokenList, Result, CatchContainerClose, TokenID, SignificantTokenPositions, 2);
                Result.CurrentContainer := IXMLNode(CatchBlock.ParentNode);
              end
              else
                ProcessCompoundKeywordWithError(SQLTokenizer.SQLTokenList, Result, Result.CurrentContainer, TokenID, SignificantTokenPositions, 2);
            end
            else
            if StartsWith(SignificantTokensString, 'END ') then
            begin
              if Result.PathNameMatches(0, SQLConstants.ENAME_CONTAINER_GENERALCONTENT) and
                Result.PathNameMatches(1, SQLConstants.ENAME_CASE_THEN) then
              begin
                Result.MoveToAncestorContainer(3, SQLConstants.ENAME_CASE_STATEMENT);
                Result.SaveNewElement(SQLConstants.ENAME_OTHERKEYWORD, Token.Value, Result.SaveNewElement(SQLConstants.ENAME_CONTAINER_CLOSE, ''));
                Result.MoveToAncestorContainer(1); //unnamed container
              end
              else
              if Result.PathNameMatches(0, SQLConstants.ENAME_CONTAINER_GENERALCONTENT) and
                Result.PathNameMatches(1, SQLConstants.ENAME_CASE_ELSE) then
              begin
                Result.MoveToAncestorContainer(2, SQLConstants.ENAME_CASE_STATEMENT);
                Result.SaveNewElement(SQLConstants.ENAME_OTHERKEYWORD, Token.Value, Result.SaveNewElement(SQLConstants.ENAME_CONTAINER_CLOSE, ''));
                Result.MoveToAncestorContainer(1); //unnamed container
              end
              else
              begin
                //Begin/End block handling
                Result.EscapeAnySingleOrPartialStatementContainers;

                if Result.PathNameMatches(0, SQLConstants.ENAME_SQL_CLAUSE) and
                   Result.PathNameMatches(1, SQLConstants.ENAME_SQL_STATEMENT) and
                   Result.PathNameMatches(2, SQLConstants.ENAME_CONTAINER_MULTISTATEMENT) and
                   Result.PathNameMatches(3, SQLConstants.ENAME_BEGIN_END_BLOCK) then
                begin
                  BeginBlock := IXMLNode(Result.CurrentContainer.ParentNode.ParentNode.ParentNode);
                  BeginContainerClose := Result.SaveNewElement(SQLConstants.ENAME_CONTAINER_CLOSE, '', BeginBlock);
                  Result.SaveNewElement(SQLConstants.ENAME_OTHERKEYWORD, Token.Value, BeginContainerClose);
                  Result.CurrentContainer := IXMLNode(BeginBlock.ParentNode);
                end
                else
                  Result.SaveNewElementWithError(SQLConstants.ENAME_OTHERKEYWORD, Token.Value);
              end;
            end
            else
            if StartsWith(SignificantTokensString, 'GO ') then
            begin
              Result.EscapeAnySingleOrPartialStatementContainers;

              if ((TokenID = 0) or IsLineBreakingWhiteSpaceOrComment(SQLTokenizer.SQLTokenList[TokenID - 1])) and
                IsFollowedByLineBreakingWhiteSpaceOrSingleLineCommentOrEnd(SQLTokenizer.SQLTokenList, TokenID) then
              begin
                // we found a batch separator - were we supposed to?
                if Result.FindValidBatchEnd then
                begin
                  SQLRoot := Result.DocumentElement; // GetNamedNode(SQLConstants.ENAME_SQL_ROOT);
                  BatchSeparator := Result.SaveNewElement(SQLConstants.ENAME_BATCH_SEPARATOR, '', SQLRoot);
                  Result.SaveNewElement(SQLConstants.ENAME_OTHERKEYWORD, Token.Value, batchSeparator);
                  Result.StartNewStatement(SQLRoot);
                end
                else
                  Result.SaveNewElementWithError(SQLConstants.ENAME_OTHERKEYWORD, Token.Value);
              end
              else
                Result.SaveNewElement(SQLConstants.ENAME_OTHERKEYWORD, Token.Value);
            end
            else
            if StartsWith(SignificantTokensString, 'EXECUTE AS ') then
            begin
              ExecuteAsInWithOptions := Result.PathNameMatches(0, SQLConstants.ENAME_CONTAINER_GENERALCONTENT) and
                 Result.PathNameMatches(1, SQLConstants.ENAME_DDL_WITH_CLAUSE) and
                 (IsLatestTokenAComma(Result) or not Result.HasNonWhiteSpaceNonCommentContent(Result.CurrentContainer));

              if not ExecuteAsInWithOptions then
              begin
                  Result.ConsiderStartingNewStatement;
                  Result.ConsiderStartingNewClause;
              end;

              ProcessCompoundKeyword(SQLTokenizer.SQLTokenList, Result, Result.CurrentContainer, TokenID, SignificantTokenPositions, 2);
            end
            else
            if StartsWith(SignificantTokensString, 'EXEC ') or
               StartsWith(SignificantTokensString, 'EXECUTE ') then
            begin
              ExecShouldntTryToStartNewStatement := False;

              if Result.PathNameMatches(0, SQLConstants.ENAME_SQL_CLAUSE) and
                 Result.PathNameMatches(1, SQLConstants.ENAME_SQL_STATEMENT) and
                 (ContentStartsWithKeyword(Result.CurrentContainer, 'INSERT') or
                  ContentStartsWithKeyword(Result.CurrentContainer, 'INSERT INTO')) then
              begin
                TempList := SelectNodes(Result.CurrentContainer, Format('../%s;', [SQLConstants.ENAME_SQL_CLAUSE]));
                ExistingClauseCount := TempList.Count;
                if ExistingClauseCount = 1 then
                  ExecShouldntTryToStartNewStatement := True;
              end;

              if not ExecShouldntTryToStartNewStatement then
                Result.ConsiderStartingNewStatement;

              Result.ConsiderStartingNewClause;

              Result.SaveNewElement(SQLConstants.ENAME_OTHERKEYWORD, Token.Value);
            end
            else
            if FJoinDetector.IsMatch(SignificantTokensString) then
            begin
              Result.ConsiderStartingNewClause;
              JoinText := FJoinDetector.Match(SignificantTokensString).Value;
              TargetKeywordCount := WordCount(JoinText); //joinText.Split(new char[] { ' ' };, StringSplitOptions.RemoveEmptyEntries).Length;
              ProcessCompoundKeyword(SQLTokenizer.SQLTokenList, Result, Result.CurrentContainer, TokenID, SignificantTokenPositions, TargetKeywordCount);
              Result.CurrentContainer := Result.SaveNewElement(SQLConstants.ENAME_SELECTIONTARGET, '');
            end
            else
            if StartsWith(SignificantTokensString, 'UNION ALL ') then
            begin
              Result.ConsiderStartingNewClause;
              ProcessCompoundKeyword(SQLTokenizer.SQLTokenList, Result, Result.SaveNewElement(SQLConstants.ENAME_SET_OPERATOR_CLAUSE, ''), TokenID, SignificantTokenPositions, 2);
            end
            else
            if StartsWith(SignificantTokensString, 'UNION ') or
              StartsWith(SignificantTokensString, 'INTERSECT ') or
              StartsWith(SignificantTokensString, 'EXCEPT ') then
            begin
              Result.ConsiderStartingNewClause;
              UnionClause := Result.SaveNewElement(SQLConstants.ENAME_SET_OPERATOR_CLAUSE, '');
              Result.SaveNewElement(SQLConstants.ENAME_OTHERKEYWORD, Token.Value, unionClause);
            end
            else
            if StartsWith(SignificantTokensString, 'WHILE ') then
            begin
              Result.ConsiderStartingNewStatement;
              NewWhileLoop := Result.SaveNewElement(SQLConstants.ENAME_WHILE_LOOP, '');
              WhileContainerOpen := Result.SaveNewElement(SQLConstants.ENAME_CONTAINER_OPEN, '', NewWhileLoop);
              Result.SaveNewElement(SQLConstants.ENAME_OTHERKEYWORD, Token.Value, WhileContainerOpen);
              Result.CurrentContainer := Result.SaveNewElement(SQLConstants.ENAME_BOOLEAN_EXPRESSION, '', NewWhileLoop);
            end
            else
            if StartsWith(SignificantTokensString, 'IF ') then
            begin
              Result.ConsiderStartingNewStatement;
              Result.StartNewContainer(SQLConstants.ENAME_IF_STATEMENT, Token.Value, SQLConstants.ENAME_BOOLEAN_EXPRESSION);
            end
            else
            if StartsWith(SignificantTokensString, 'ELSE ') then
            begin
              Result.EscapeAnyBetweenConditions;
              Result.EscapeAnySelectionTarget;
              Result.EscapeJoinCondition;

              if Result.PathNameMatches(0, SQLConstants.ENAME_CONTAINER_GENERALCONTENT) and
                 Result.PathNameMatches(1, SQLConstants.ENAME_CASE_THEN) then
              begin
                Result.MoveToAncestorContainer(3, SQLConstants.ENAME_CASE_STATEMENT);
                Result.StartNewContainer(SQLConstants.ENAME_CASE_ELSE, Token.Value, SQLConstants.ENAME_CONTAINER_GENERALCONTENT);
              end
              else
              begin
                Result.EscapePartialStatementContainers;

                if Result.PathNameMatches(0, SQLConstants.ENAME_SQL_CLAUSE) and
                  Result.PathNameMatches(1, SQLConstants.ENAME_SQL_STATEMENT) and
                  Result.PathNameMatches(2, SQLConstants.ENAME_CONTAINER_SINGLESTATEMENT) then
                begin
                  //we need to pop up the single-statement containers stack to the next 'if' that doesn't have an 'else' (if any; else error).
                  // LOCAL SEARCH - we're not actually changing the 'CurrentContainer' until we decide to start a statement.
                  CurrentNode := IXMLNode(Result.CurrentContainer.ParentNode.ParentNode);
                  StopSearching := False;
                  while not StopSearching do
                  begin
                    if Result.PathNameMatches(CurrentNode, 1, SQLConstants.ENAME_IF_STATEMENT) then
                    begin
                      //if this is in an 'If', then the 'Else' must still be available - yay!
                      Result.CurrentContainer := IXMLNode(CurrentNode.ParentNode);
                      Result.StartNewContainer(SQLConstants.ENAME_ELSE_CLAUSE, Token.Value, SQLConstants.ENAME_CONTAINER_SINGLESTATEMENT);
                      Result.StartNewStatement;
                      StopSearching := True;
                    end
                    else
                    if Result.PathNameMatches(CurrentNode, 1, SQLConstants.ENAME_ELSE_CLAUSE) then
                    begin
                      //If this is in an 'Else', we should skip its parent 'IF' altogether, and go to the next singlestatementcontainer candidate.
                      //singlestatementcontainer.else.if.clause.statement.NEWCANDIDATE
                      CurrentNode := IXMLNode(CurrentNode.ParentNode.ParentNode.ParentNode.ParentNode.ParentNode);
                    end
                    else
                    if Result.PathNameMatches(CurrentNode, 1, SQLConstants.ENAME_WHILE_LOOP) then
                    begin
                      //If this is in a 'While', we should skip to the next singlestatementcontainer candidate.
                      //singlestatementcontainer.while.clause.statement.NEWCANDIDATE
                      CurrentNode := IXMLNode(CurrentNode.ParentNode.ParentNode.ParentNode.ParentNode);
                    end
                    else
                    begin
                      //if this isn't a known single-statement container, then we're lost.
                      Result.SaveNewElementWithError(SQLConstants.ENAME_OTHERKEYWORD, Token.Value);
                      StopSearching := True;
                    end;
                  end;
                end
                else
                  Result.SaveNewElementWithError(SQLConstants.ENAME_OTHERKEYWORD, Token.Value);
              end;
            end
            else
            if StartsWith(SignificantTokensString, 'INSERT INTO ') then
            begin
              Result.ConsiderStartingNewStatement;
              Result.ConsiderStartingNewClause;
              ProcessCompoundKeyword(SQLTokenizer.SQLTokenList, Result, Result.CurrentContainer, TokenID, SignificantTokenPositions, 2);
            end
            else
            if StartsWith(SignificantTokensString, 'NATIONAL CHARACTER VARYING ') then
              ProcessCompoundKeyword(SQLTokenizer.SQLTokenList, Result, Result.CurrentContainer, TokenID, SignificantTokenPositions, 3)
            else
            if StartsWith(SignificantTokensString, 'NATIONAL CHAR VARYING ') then
              ProcessCompoundKeyword(SQLTokenizer.SQLTokenList, Result, Result.CurrentContainer, TokenID, SignificantTokenPositions, 3)
            else
            if StartsWith(SignificantTokensString, 'BINARY VARYING ') then
            begin
              //TODO: Figure out how to handle 'Compound Keyword Datatypes' so they are still correctly highlighted
              ProcessCompoundKeyword(SQLTokenizer.SQLTokenList, Result, Result.CurrentContainer, TokenID, SignificantTokenPositions, 2);
            end
            else
            if StartsWith(SignificantTokensString, 'CHAR VARYING ') then
              ProcessCompoundKeyword(SQLTokenizer.SQLTokenList, Result, Result.CurrentContainer, TokenID, SignificantTokenPositions, 2)
            else
            if StartsWith(SignificantTokensString, 'CHARACTER VARYING ') then
              ProcessCompoundKeyword(SQLTokenizer.SQLTokenList, Result, Result.CurrentContainer, TokenID, SignificantTokenPositions, 2)
            else
            if StartsWith(SignificantTokensString, 'DOUBLE PRECISION ') then
              ProcessCompoundKeyword(SQLTokenizer.SQLTokenList, Result, Result.CurrentContainer, TokenID, SignificantTokenPositions, 2)
            else
            if StartsWith(SignificantTokensString, 'NATIONAL CHARACTER ') then
              ProcessCompoundKeyword(SQLTokenizer.SQLTokenList, Result, Result.CurrentContainer, TokenID, SignificantTokenPositions, 2)
            else
            if StartsWith(SignificantTokensString, 'NATIONAL CHAR ') then
              ProcessCompoundKeyword(SQLTokenizer.SQLTokenList, Result, Result.CurrentContainer, TokenID, SignificantTokenPositions, 2)
            else
            if StartsWith(SignificantTokensString, 'NATIONAL TEXT ') then
              ProcessCompoundKeyword(SQLTokenizer.SQLTokenList, Result, Result.CurrentContainer, TokenID, SignificantTokenPositions, 2)
            else
            if StartsWith(SignificantTokensString, 'INSERT ') then
            begin
              Result.ConsiderStartingNewStatement;
              Result.ConsiderStartingNewClause;
              Result.SaveNewElement(SQLConstants.ENAME_OTHERKEYWORD, Token.Value);
            end
            else
            if StartsWith(SignificantTokensString, 'BULK INSERT ') then
            begin
              Result.ConsiderStartingNewStatement;
              Result.ConsiderStartingNewClause;
              ProcessCompoundKeyword(SQLTokenizer.SQLTokenList, Result, Result.CurrentContainer, TokenID, SignificantTokenPositions, 2);
            end
            else
            if StartsWith(SignificantTokensString, 'SELECT ') then
            begin
              if Result.NewStatementDue then
                Result.ConsiderStartingNewStatement;

              SelectShouldntTryToStartNewStatement := False;

              if Result.PathNameMatches(0, SQLConstants.ENAME_SQL_CLAUSE) then
              begin
                FirstStatementClause := Result.GetFirstNonWhitespaceNonCommentChildElement(Result.CurrentContainer.ParentNode);

                IsPrecededByInsertStatement := False;

                NodeList := SelectNodes(Result.CurrentContainer.ParentNode, SQLConstants.ENAME_SQL_CLAUSE);

                for i := 0 to NodeList.Count - 1 do
                begin
                  Node := NodeList[i];
                  if ContentStartsWithKeyword(Node, 'INSERT') then
                  begin
                    IsPrecededByInsertStatement := True;
                    Break;
                  end;
                end;
                //NodeList.Free;

                if IsPrecededByInsertStatement then
                begin
                  ExistingSelectClauseFound := False;

                  NodeList := SelectNodes(Result.CurrentContainer.ParentNode, SQLConstants.ENAME_SQL_CLAUSE);
                  for i := 0 to NodeList.Count - 1 do
                  begin
                    Node := NodeList[i];
                    if ContentStartsWithKeyword(Node, 'SELECT') then
                    begin
                      ExistingSelectClauseFound := True;
                      Break;
                    end;
                  end;
                  //NodeList.Free;

                  ExistingValuesClauseFound := False;
                  NodeList := SelectNodes(Result.CurrentContainer.ParentNode, SQLConstants.ENAME_SQL_CLAUSE);
                  for i := 0 to NodeList.Count - 1 do
                  begin
                    Node := NodeList[i];
                    if ContentStartsWithKeyword(Node, 'VALUES') then
                    begin
                      ExistingValuesClauseFound := True;
                      Break;
                    end;
                  end;
                  //NodeList.Free;

                  ExistingExecClauseFound := False;
                  NodeList := SelectNodes(Result.CurrentContainer.ParentNode, SQLConstants.ENAME_SQL_CLAUSE);
                  for i := 0 to NodeList.Count - 1 do
                  begin
                    Node := NodeList[i];
                    if ContentStartsWithKeyword(Node, 'EXEC') or
                      ContentStartsWithKeyword(Node, 'EXECUTE') then
                    begin
                      ExistingExecClauseFound := True;
                      Break;
                    end;
                  end;
                  //NodeList.Free;

                  if not ExistingSelectClauseFound and not ExistingValuesClauseFound and
                    not ExistingExecClauseFound then
                      SelectShouldntTryToStartNewStatement := True;
                end;

                FirstEntryOfThisClause := Result.GetFirstNonWhitespaceNonCommentChildElement(Result.CurrentContainer);
                if Assigned(FirstEntryOfThisClause) and (FirstEntryOfThisClause.NodeName = SQLConstants.ENAME_SET_OPERATOR_CLAUSE) then
                  SelectShouldntTryToStartNewStatement := True;
              end;

              if not SelectShouldntTryToStartNewStatement then
                Result.ConsiderStartingNewStatement;

              Result.ConsiderStartingNewClause;

              Result.SaveNewElement(SQLConstants.ENAME_OTHERKEYWORD, Token.Value);
            end
            else
            if StartsWith(SignificantTokensString, 'UPDATE ') then
            begin
              if Result.NewStatementDue then
                Result.ConsiderStartingNewStatement;

              if not (Result.PathNameMatches(0, SQLConstants.ENAME_CONTAINER_GENERALCONTENT) and
                      Result.PathNameMatches(1, SQLConstants.ENAME_CURSOR_FOR_OPTIONS)) then
              begin
                Result.ConsiderStartingNewStatement;
                Result.ConsiderStartingNewClause;
              end;

              Result.SaveNewElement(SQLConstants.ENAME_OTHERKEYWORD, Token.Value);
            end
            else
            if StartsWith(SignificantTokensString, 'TO ') then
            begin
              if Result.PathNameMatches(0, SQLConstants.ENAME_CONTAINER_GENERALCONTENT) and
                 Result.PathNameMatches(1, SQLConstants.ENAME_PERMISSIONS_TARGET) then
              begin
                Result.MoveToAncestorContainer(2, SQLConstants.ENAME_PERMISSIONS_BLOCK);
                Result.StartNewContainer(SQLConstants.ENAME_PERMISSIONS_RECIPIENT, Token.Value, SQLConstants.ENAME_CONTAINER_GENERALCONTENT);
              end
              else
              begin
                  //I don't currently know whether there is any other place where 'TO' can be used in T-SQL...
                  // TODO: look into that.
                  // -> for now, we'll just save as a random keyword without raising an error.
                  Result.SaveNewElement(SQLConstants.ENAME_OTHERKEYWORD, Token.Value);
              end;
            end
            else
            if StartsWith(SignificantTokensString, 'FROM ') then
            begin
              if Result.PathNameMatches(0, SQLConstants.ENAME_CONTAINER_GENERALCONTENT) and
                 Result.PathNameMatches(1, SQLConstants.ENAME_PERMISSIONS_TARGET) then
              begin
                Result.MoveToAncestorContainer(2, SQLConstants.ENAME_PERMISSIONS_BLOCK);
                Result.StartNewContainer(SQLConstants.ENAME_PERMISSIONS_RECIPIENT, Token.Value, SQLConstants.ENAME_CONTAINER_GENERALCONTENT);
              end
              else
              begin
                Result.ConsiderStartingNewClause;
                Result.SaveNewElement(SQLConstants.ENAME_OTHERKEYWORD, Token.Value);
                Result.CurrentContainer := Result.SaveNewElement(SQLConstants.ENAME_SELECTIONTARGET, '');
              end;
            end
            else
            if StartsWith(SignificantTokensString, 'CASCADE ') and
              Result.PathNameMatches(0, SQLConstants.ENAME_CONTAINER_GENERALCONTENT) and
              Result.PathNameMatches(1, SQLConstants.ENAME_PERMISSIONS_RECIPIENT) then
            begin
              Result.MoveToAncestorContainer(2, SQLConstants.ENAME_PERMISSIONS_BLOCK);
              Result.CurrentContainer := Result.SaveNewElement(SQLConstants.ENAME_CONTAINER_GENERALCONTENT, '', Result.SaveNewElement(SQLConstants.ENAME_DDL_WITH_CLAUSE, ''));
              Result.SaveNewElement(SQLConstants.ENAME_OTHERKEYWORD, Token.Value);
            end
            else
            if StartsWith(SignificantTokensString, 'SET ') then
            begin
              FirstNonCommentSibling2 := Result.GetFirstNonWhitespaceNonCommentChildElement(Result.CurrentContainer);
              if not (
                      Assigned(FirstNonCommentSibling2) and
                      (FirstNonCommentSibling2.NodeName = SQLConstants.ENAME_OTHERKEYWORD) and
                      StartsWith(FirstNonCommentSibling2.NodeValue, 'UPDATE')
                      ) then
                  Result.ConsiderStartingNewStatement;

              Result.ConsiderStartingNewClause;
              Result.SaveNewElement(SQLConstants.ENAME_OTHERKEYWORD, Token.Value);
            end
            else
            if StartsWith(SignificantTokensString, 'BETWEEN ') then
            begin
              Result.CurrentContainer := Result.SaveNewElement(SQLConstants.ENAME_BETWEEN_CONDITION, '');
              Result.SaveNewElement(SQLConstants.ENAME_OTHERKEYWORD, Token.Value, Result.SaveNewElement(SQLConstants.ENAME_CONTAINER_OPEN, ''));
              Result.CurrentContainer := Result.SaveNewElement(SQLConstants.ENAME_BETWEEN_LOWERBOUND, '');
            end
            else
            if StartsWith(SignificantTokensString, 'AND ') then
            begin
              if Result.PathNameMatches(0, SQLConstants.ENAME_BETWEEN_LOWERBOUND) then
              begin
                  Result.MoveToAncestorContainer(1, SQLConstants.ENAME_BETWEEN_CONDITION);
                  Result.SaveNewElement(SQLConstants.ENAME_OTHERKEYWORD, Token.Value, Result.SaveNewElement(SQLConstants.ENAME_CONTAINER_CLOSE, ''));
                  Result.CurrentContainer := Result.SaveNewElement(SQLConstants.ENAME_BETWEEN_UPPERBOUND, '');
              end
              else
              begin
                  Result.EscapeAnyBetweenConditions;
                  Result.SaveNewElement(SQLConstants.ENAME_OTHERKEYWORD, Token.Value, Result.SaveNewElement(SQLConstants.ENAME_AND_OPERATOR, ''));
              end;
            end
            else
            if StartsWith(SignificantTokensString, 'OR ') then
            begin
              Result.EscapeAnyBetweenConditions;
              Result.SaveNewElement(SQLConstants.ENAME_OTHERKEYWORD, Token.Value, Result.SaveNewElement(SQLConstants.ENAME_OR_OPERATOR, ''));
            end
            else
            if StartsWith(SignificantTokensString, 'WITH ') then
            begin
              if Result.NewStatementDue then
                Result.ConsiderStartingNewStatement;

              if Result.PathNameMatches(0, SQLConstants.ENAME_SQL_CLAUSE) and
                 Result.PathNameMatches(1, SQLConstants.ENAME_SQL_STATEMENT) and
                 not Result.HasNonWhiteSpaceNonCommentContent(Result.CurrentContainer) then
              begin
                Result.CurrentContainer := Result.SaveNewElement(SQLConstants.ENAME_CTE_WITH_CLAUSE, '');
                Result.SaveNewElement(SQLConstants.ENAME_OTHERKEYWORD, Token.Value, Result.SaveNewElement(SQLConstants.ENAME_CONTAINER_OPEN, ''));
                Result.CurrentContainer := Result.SaveNewElement(SQLConstants.ENAME_CTE_ALIAS, '');
              end
              else
              if Result.PathNameMatches(0, SQLConstants.ENAME_CONTAINER_GENERALCONTENT) and
                 Result.PathNameMatches(1, SQLConstants.ENAME_PERMISSIONS_RECIPIENT) then
              begin
                Result.MoveToAncestorContainer(2, SQLConstants.ENAME_PERMISSIONS_BLOCK);
                Result.StartNewContainer(SQLConstants.ENAME_DDL_WITH_CLAUSE, Token.Value, SQLConstants.ENAME_CONTAINER_GENERALCONTENT);
              end
              else
              if Result.PathNameMatches(0, SQLConstants.ENAME_DDL_PROCEDURAL_BLOCK) or
                 Result.PathNameMatches(0, SQLConstants.ENAME_DDL_OTHER_BLOCK) then
                Result.StartNewContainer(SQLConstants.ENAME_DDL_WITH_CLAUSE, Token.Value, SQLConstants.ENAME_CONTAINER_GENERALCONTENT)
              else
              if Result.PathNameMatches(0, SQLConstants.ENAME_SELECTIONTARGET) then
                Result.SaveNewElement(SQLConstants.ENAME_OTHERKEYWORD, Token.Value)
              else
              begin
                Result.ConsiderStartingNewClause;
                Result.SaveNewElement(SQLConstants.ENAME_OTHERKEYWORD, Token.Value);
              end;
            end
            else
            if (SQLTokenizer.SQLTokenList.Count > TokenID + 1) and
               (SQLTokenizer.SQLTokenList[TokenID + 1].TokenType = ttColon) and
               not (SQLTokenizer.SQLTokenList.Count > TokenID + 2) and
               (SQLTokenizer.SQLTokenList[TokenID + 2].TokenType = ttColon) then
            begin
              Result.ConsiderStartingNewStatement;
              Result.SaveNewElement(SQLConstants.ENAME_LABEL, Token.Value + SQLTokenizer.SQLTokenList[TokenID + 1].Value);
              inc(TokenID);
            end
            else
            begin
              //miscellaneous single-word Tokens, which may or may not be statement starters and/or clause starters

              //check for statements starting...
              if IsStatementStarter(Token) or Result.NewStatementDue then
                Result.ConsiderStartingNewStatement;

              //check for statements starting...
              if IsClauseStarter(Token) then
                Result.ConsiderStartingNewClause;

              NewName := SQLConstants.ENAME_OTHERNODE;

              if FKeywordList.TryGetValue(Token.Value, MatchedKeywordType) then
              begin
                case MatchedKeywordType of
                  ktOperatorKeyword: NewName := SQLConstants.ENAME_ALPHAOPERATOR;
                  ktFunctionKeyword: NewName := SQLConstants.ENAME_FUNCTION_KEYWORD;
                  ktDataTypeKeyword: NewName := SQLConstants.ENAME_DATATYPE_KEYWORD;
                  ktOtherKeyword:
                  begin
                    Result.EscapeAnySelectionTarget;
                    newName := SQLConstants.ENAME_OTHERKEYWORD;
                  end
                  else
                    raise Exception.Create('Unrecognized Keyword Type!');
                end;
              end;

              Result.SaveNewElement(newName, Token.Value);
            end;
          end;

          ttSemicolon:
          begin
            Result.SaveNewElement(SQLConstants.ENAME_SEMICOLON, Token.Value);
            Result.NewStatementDue := True;
            break;
          end;

          ttColon:
          begin
            if (SQLTokenizer.SQLTokenList.Count > TokenID + 1) and
               (SQLTokenizer.SQLTokenList[TokenID + 1].TokenType = ttColon) then
            begin
              Result.SaveNewElement(SQLConstants.ENAME_SCOPERESOLUTIONOPERATOR, Token.Value + SQLTokenizer.SQLTokenList[TokenID + 1].Value);
              Inc(TokenID);
            end
            else
              Result.SaveNewElementWithError(SQLConstants.ENAME_OTHEROPERATOR, Token.Value);
          end;

          ttComma:
          begin
            IsCTESplitter := Result.PathNameMatches(0, SQLConstants.ENAME_CONTAINER_GENERALCONTENT) and
              Result.PathNameMatches(1, SQLConstants.ENAME_CTE_WITH_CLAUSE);

            Result.SaveNewElement(GetEquivalentSQLName(Token.TokenType), Token.Value);

            if isCTESplitter then
            begin
              Result.MoveToAncestorContainer(1, SQLConstants.ENAME_CTE_WITH_CLAUSE);
              Result.CurrentContainer := Result.SaveNewElement(SQLConstants.ENAME_CTE_ALIAS, '');
            end;
          end;

          ttMultiLineComment, ttSingleLineComment, ttWhiteSpace:
          begin
            //create in statement rather than clause if there are no siblings yet
            if Result.PathNameMatches(0, SQLConstants.ENAME_SQL_CLAUSE) and
               Result.PathNameMatches(1, SQLConstants.ENAME_SQL_STATEMENT) and
               not Result.CurrentContainer.hasChildNodes then
              Result.SaveNewElementAsPriorSibling(GetEquivalentSQLName(Token.TokenType), Token.Value, Result.CurrentContainer)
            else
              Result.SaveNewElement(GetEquivalentSQLName(Token.TokenType), Token.Value);
          end;

          ttBracketQuotedName, ttAsterisk, ttPeriod, ttNationalString, ttString, ttQuotedString,
          ttOtherOperator, ttNumber, ttBinaryValue, ttMonetaryValue, ttPseudoName:
            Result.SaveNewElement(GetEquivalentSQLName(Token.TokenType), Token.Value);
          else
            raise Exception.Create('Unrecognized Token type!');
      end;

      Inc(TokenID);
    end;
  finally
    {NodeList.Clear;
    NodeList.Free;
    TempList.Clear;
    TempList.Free;  }
    SQLTokenizer.Free;
  end;

  if not Result.FindValidBatchEnd then
    Result.ErrorFound := True;
end;

// todo: move into TSQLParseTree?
function TSQLParser.ContentStartsWithKeyword(ProvidedContainer: IXMLNode; ContentToMatch: string): Boolean;
var
  ParentDoc: TSQLParseTree;
  FirstEntryOfProvidedContainer: IXMLNode;
  KeywordUpperValue: string;
begin
  ParentDoc := TSQLParseTree(ProvidedContainer.ParentNode); // OwnerDocument;
  FirstEntryOfProvidedContainer := ParentDoc.GetFirstNonWhitespaceNonCommentChildElement(ProvidedContainer);

  KeywordUpperValue := '';
  if Assigned(FirstEntryOfProvidedContainer) and
    (FirstEntryOfProvidedContainer.NodeName = SQLConstants.ENAME_OTHERKEYWORD) and
    (FirstEntryOfProvidedContainer.NodeValue <> '') then
    KeywordUpperValue := UpperCase(FirstEntryOfProvidedContainer.NodeValue);

  if Assigned(FirstEntryOfProvidedContainer) and
    (FirstEntryOfProvidedContainer.NodeName = SQLConstants.ENAME_COMPOUNDKEYWORD) then
    KeywordUpperValue := UpperCase(FirstEntryOfProvidedContainer.AttributeNodes.FindNode(SQLConstants.ANAME_SIMPLETEXT).NodeValue);

  if KeywordUpperValue <> '' then
    Result := (KeywordUpperValue = ContentToMatch) or StartsWith(KeywordUpperValue, ContentToMatch + ' ')
  else
    //if contentToMatch was passed in as null, means we were looking for a NON-keyword.
    Result := ContentToMatch = '';
end;

procedure TSQLParser.ProcessCompoundKeywordWithError(SQLTokenList: TSQLTokenList; SQLParseTree: TSQLParseTree; CurrentContainerElement: IXMLNode; var TokenID: Integer; SignificantTokenPositions: TSQLTokenPositionsList; KeywordCount: Integer);
begin
  ProcessCompoundKeyword(SQLTokenList, SQLParseTree, currentContainerElement, TokenID, SignificantTokenPositions, KeywordCount);
  SQLParseTree.ErrorFound := True;
end;

procedure TSQLParser.ProcessCompoundKeyword(SQLTokenList: TSQLTokenList; SQLParseTree: TSQLParseTree; TargetContainer: IXMLNode; var TokenID: Integer; SignificantTokenPositions: TSQLTokenPositionsList; KeywordCount: Integer);
var
  CompoundKeyword: IXMLNode;
  TargetText: string;
begin
  CompoundKeyword := SQLParseTree.SaveNewElement(SQLConstants.ENAME_COMPOUNDKEYWORD, '', targetContainer);
  TargetText := Trim(ExtractTokensString(SQLTokenList, SignificantTokenPositions.GetRange(0, KeywordCount)));
  compoundKeyword.AttributeNodes.FindNode(SQLConstants.ANAME_SIMPLETEXT).NodeValue := targetText;
  AppendNodesWithMapping(SQLParseTree, SQLTokenList.GetRangeByIndex(SignificantTokenPositions[0], SignificantTokenPositions[keywordCount - 1]), SQLConstants.ENAME_OTHERKEYWORD, CompoundKeyword);
  TokenID := SignificantTokenPositions[keywordCount - 1];
end;

procedure TSQLParser.AppendNodesWithMapping(SQLParseTree: TSQLParseTree; Tokens: TSQLTokenList; OtherTokenMappingName: string; TargetContainer: IXMLNode);
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

function TSQLParser.GetEquivalentSQLName(SQLTokenType: TSQLTokenType): string;
begin
  case SQLTokenType of
    ttWhiteSpace: Result := SQLConstants.ENAME_WHITESPACE;
    ttSingleLineComment: Result := SQLConstants.ENAME_COMMENT_SINGLELINE;
    ttMultiLineComment: Result := SQLConstants.ENAME_COMMENT_MULTILINE;
    ttBracketQuotedName: Result := SQLConstants.ENAME_BRACKET_QUOTED_NAME;
    ttAsterisk: Result := SQLConstants.ENAME_ASTERISK;
    ttComma: Result := SQLConstants.ENAME_COMMA;
    ttPeriod: Result := SQLConstants.ENAME_PERIOD;
    ttNationalString: Result := SQLConstants.ENAME_NSTRING;
    ttString: Result := SQLConstants.ENAME_STRING;
    ttQuotedString: Result := SQLConstants.ENAME_QUOTED_STRING;
    ttOtherOperator: Result := SQLConstants.ENAME_OTHEROPERATOR;
    ttNumber: Result := SQLConstants.ENAME_NUMBER_VALUE;
    ttMonetaryValue: Result := SQLConstants.ENAME_MONETARY_VALUE;
    ttBinaryValue: Result := SQLConstants.ENAME_BINARY_VALUE;
    ttPseudoName: Result := SQLConstants.ENAME_PSEUDONAME;
    else
      raise Exception.Create('Mapping not found for provided Token type.');
  end;
end;

{function TSQLParser.GetKeywordMatchPhrase(SQLTokenList: TSQLTokenList; TokenID: Integer; var List<string> rawKeywordParts, ref List<int> TokenCounts, ref List<List<IToken>> overflowNodes)
begin
  string phrase = '';
  int phraseComponentsFound = 0;
  rawKeywordParts = new List<string>;
  overflowNodes = new List<List<IToken>>;
  TokenCounts = new List<int>;
  string precedingWhitespace = '';
  int originalTokenID = TokenID;

  while (TokenID < TokenList.Count and phraseComponentsFound < 7)
  begin
      if (SQLTokenList[TokenID].Type == ttOtherNode
          or TokenList[TokenID].Type == ttBracketQuotedName
          or TokenList[TokenID].Type == ttComma
          )
      begin
          phrase += TokenList[TokenID].NodeValue.ToUpperInvariant + ' ';
          phraseComponentsFound++;
          rawKeywordParts.Add(precedingWhitespace + TokenList[TokenID].NodeValue);

          TokenID++;
          TokenCounts.Add(TokenID - originalTokenID);

          //found a possible phrase component - skip past any upcoming whitespace or comments, keeping track.
          overflowNodes.Add(new List<IToken>);
          precedingWhitespace = '';
          while (TokenID < TokenList.Count
              and (SQLTokenList[TokenID].Type == ttWhiteSpace
                  or TokenList[TokenID].Type == ttSingleLineComment
                  or TokenList[TokenID].Type == ttMultiLineComment
                  )
              )
          begin
              if (SQLTokenList[TokenID].Type == ttWhiteSpace)
                  precedingWhitespace += TokenList[TokenID].NodeValue;
              else
                  overflowNodes[phraseComponentsFound-1].Add(SQLTokenList[TokenID]);

              TokenID++;
          end;
      end;
      else
          //we're not interested in any other node types
          break;
  end;

  Result := phrase;
end; }

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

{private XmlElement ProcessCompoundKeyword(ParseTree Result, string newElementName, ref int TokenID, XmlElement currentContainerElement, int compoundKeywordCount, List<int> compoundKeywordTokenCounts, List<string> compoundKeywordRawStrings)
begin
  XmlElement newElement = Result.CreateElement(newElementName);
  newElement.InnerText = GetCompoundKeyword(TokenID, compoundKeywordCount, compoundKeywordTokenCounts, compoundKeywordRawStrings);
  Result.CurrentContainer.AppendChild(newElement);
  Result := newElement;
end;

private string GetCompoundKeyword(ref int TokenID, int compoundKeywordCount, List<int> compoundKeywordTokenCounts, List<string> compoundKeywordRawStrings)
begin
  TokenID += compoundKeywordTokenCounts[compoundKeywordCount - 1] - 1;
  string outString = '';
  for (int i = 0; i < compoundKeywordCount; i++)
      outString += compoundKeywordRawStrings[i];
  Result := outString;
end; }

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

function TSQLParser.IsLatestTokenADDLDetailValue(SQLParseTree: TSQLParseTree): Boolean;
var
  CurrentNode: IXMLNode;
  UppercaseText: string;
begin
  Result := False;
  CurrentNode := SQLParseTree.CurrentContainer.ChildNodes.Last;
  while Assigned(CurrentNode) do
  begin
    if (currentNode.NodeName = SQLConstants.ENAME_OTHERKEYWORD) or
      (currentNode.NodeName = SQLConstants.ENAME_DATATYPE_KEYWORD) or
      (currentNode.NodeName = SQLConstants.ENAME_COMPOUNDKEYWORD) then
    begin
      UppercaseText := '';
      if CurrentNode.NodeName = SQLConstants.ENAME_COMPOUNDKEYWORD then
        UppercaseText := UpperCase(CurrentNode.AttributeNodes.FindNode(SQLConstants.ANAME_SIMPLETEXT).NodeValue)
      else
        UppercaseText := UpperCase(CurrentNode.NodeValue);

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
    end
    else
    if SQLParseTree.IsCommentOrWhiteSpace(CurrentNode.NodeName) then
      CurrentNode := CurrentNode.PreviousSibling
    else
      CurrentNode := nil;
  end;
end;

function TSQLParser.IsLatestTokenAComma(SQLParseTree: TSQLParseTree): Boolean;
var
  CurrentNode: IXMLNode;
begin
  Result := False;
  CurrentNode := SQLParseTree.CurrentContainer.ChildNodes.Last;
  while Assigned(CurrentNode) do
  begin
    if CurrentNode.NodeName = SQLConstants.ENAME_COMMA then
      Result := True
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
  CurrentNode := SQLParseTree.CurrentContainer.ChildNodes.Last;
  while Assigned(CurrentNode) do
  begin
      TestValue := UpperCase(CurrentNode.NodeValue);
      if ( (CurrentNode.NodeName = SQLConstants.ENAME_BRACKET_QUOTED_NAME) or
           (CurrentNode.NodeName = SQLConstants.ENAME_OTHERNODE) or
           (CurrentNode.NodeName = SQLConstants.ENAME_FUNCTION_KEYWORD) ) and
        not ((TestValue = 'AND') or (TestValue = 'OR') or (TestValue = 'NOT') or
             (TestValue = 'BETWEEN') or (TestValue = 'LIKE') or (TestValue = 'CONTAINS') or
             (TestValue = 'EXISTS') or (TestValue = 'FREETEXT') or (TestValue = 'IN') or
             (TestValue = 'ALL') or (TestValue = 'SOME') or (TestValue = 'ANY') or
             (TestValue = 'FROM') or (TestValue = 'JOIN') or EndsText(' JOIN', TestValue) or
             (TestValue = 'UNION') or (TestValue = 'UNION ALL') or (TestValue = 'USING') or
             (TestValue = 'AS') or EndsText(' APPLY', TestValue) ) then
        Result := True
      else
      if SQLParseTree.IsCommentOrWhiteSpace(CurrentNode.NodeName) then
        CurrentNode := CurrentNode.PreviousSibling
      else
        CurrentNode := nil;
  end;
end;

function TSQLParser.IsLineBreakingWhiteSpaceOrComment(SQLToken: TSQLToken): Boolean;
var
  Regex: TRegex;
begin
  Regex := TRegex.Create('(\r|\n)+');
  Result := (SQLToken.TokenType = ttWhiteSpace) and
    Regex.IsMatch(SQLToken.Value) or (SQLToken.TokenType = ttSingleLineComment);
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
      Result := True
    else
    if SQLTokenList[currTokenID].TokenType = ttWhiteSpace then
    begin
      if Regex.IsMatch(SQLTokenList[currTokenID].Value) then
        Result := True
      else
        Inc(CurrTokenID);
    end
  end;
  //Result := True;
end;

procedure TSQLParser.InitializeKeywordList;
begin
  // TODO: check oracle keywords
  FKeywordList := TDictionary<string, TKeywordType>.Create;
  with FKeywordList do
  begin
    Add('@@CONNECTIONS', ktFunctionKeyword);
    Add('@@CPU_BUSY', ktFunctionKeyword);
    Add('@@CURSOR_ROWS', ktFunctionKeyword);
    Add('@@DATEFIRST', ktFunctionKeyword);
    Add('@@DBTS', ktFunctionKeyword);
    Add('@@ERROR', ktFunctionKeyword);
    Add('@@FETCH_STATUS', ktFunctionKeyword);
    Add('@@IDENTITY', ktFunctionKeyword);
    Add('@@IDLE', ktFunctionKeyword);
    Add('@@IO_BUSY', ktFunctionKeyword);
    Add('@@LANGID', ktFunctionKeyword);
    Add('@@LANGUAGE', ktFunctionKeyword);
    Add('@@LOCK_TIMEOUT', ktFunctionKeyword);
    Add('@@MAX_CONNECTIONS', ktFunctionKeyword);
    Add('@@MAX_PRECISION', ktFunctionKeyword);
    Add('@@NESTLEVEL', ktFunctionKeyword);
    Add('@@OPTIONS', ktFunctionKeyword);
    Add('@@PACKET_ERRORS', ktFunctionKeyword);
    Add('@@PACK_RECEIVED', ktFunctionKeyword);
    Add('@@PACK_SENT', ktFunctionKeyword);
    Add('@@PROCID', ktFunctionKeyword);
    Add('@@REMSERVER', ktFunctionKeyword);
    Add('@@ROWCOUNT', ktFunctionKeyword);
    Add('@@SERVERNAME', ktFunctionKeyword);
    Add('@@SERVICENAME', ktFunctionKeyword);
    Add('@@SPID', ktFunctionKeyword);
    Add('@@TEXTSIZE', ktFunctionKeyword);
    Add('@@TIMETICKS', ktFunctionKeyword);
    Add('@@TOTAL_ERRORS', ktFunctionKeyword);
    Add('@@TOTAL_READ', ktFunctionKeyword);
    Add('@@TOTAL_WRITE', ktFunctionKeyword);
    Add('@@TRANCOUNT', ktFunctionKeyword);
    Add('@@VERSION', ktFunctionKeyword);
    Add('ABS', ktFunctionKeyword);
    Add('ACOS', ktFunctionKeyword);
    Add('ACTIVATION', ktOtherKeyword);
    Add('ADD', ktOtherKeyword);
    Add('ALL', ktOperatorKeyword);
    Add('ALTER', ktOtherKeyword);
    Add('AND', ktOperatorKeyword);
    Add('ANSI_DEFAULTS', ktOtherKeyword);
    Add('ANSI_NULLS', ktOtherKeyword);
    Add('ANSI_NULL_DFLT_OFF', ktOtherKeyword);
    Add('ANSI_NULL_DFLT_ON', ktOtherKeyword);
    Add('ANSI_PADDING', ktOtherKeyword);
    Add('ANSI_WARNINGS', ktOtherKeyword);
    Add('ANY', ktOperatorKeyword);
    Add('APP_NAME', ktFunctionKeyword);
    Add('ARITHABORT', ktOtherKeyword);
    Add('ARITHIGNORE', ktOtherKeyword);
    Add('AS', ktOtherKeyword);
    Add('ASC', ktOtherKeyword);
    Add('ASCII', ktFunctionKeyword);
    Add('ASIN', ktFunctionKeyword);
    Add('ATAN', ktFunctionKeyword);
    Add('ATN2', ktFunctionKeyword);
    Add('AUTHORIZATION', ktOtherKeyword);
    Add('AVG', ktFunctionKeyword);
    Add('BACKUP', ktOtherKeyword);
    Add('BEGIN', ktOtherKeyword);
    Add('BETWEEN', ktOperatorKeyword);
    Add('BIGINT', ktDataTypeKeyword);
    Add('BINARY', ktDataTypeKeyword);
    Add('BIT', ktDataTypeKeyword);
    Add('BREAK', ktOtherKeyword);
    Add('BROWSE', ktOtherKeyword);
    Add('BULK', ktOtherKeyword);
    Add('BY', ktOtherKeyword);
    Add('CALLER', ktOtherKeyword);
    Add('CASCADE', ktOtherKeyword);
    Add('CASE', ktFunctionKeyword);
    Add('CAST', ktFunctionKeyword);
    Add('CATALOG', ktOtherKeyword);
    Add('CEILING', ktFunctionKeyword);
    Add('CHAR', ktDataTypeKeyword);
    Add('CHARACTER', ktDataTypeKeyword);
    Add('CHARINDEX', ktFunctionKeyword);
    Add('CHECK', ktOtherKeyword);
    Add('CHECKALLOC', ktOtherKeyword);
    Add('CHECKCATALOG', ktOtherKeyword);
    Add('CHECKCONSTRAINTS', ktOtherKeyword);
    Add('CHECKDB', ktOtherKeyword);
    Add('CHECKFILEGROUP', ktOtherKeyword);
    Add('CHECKIDENT', ktOtherKeyword);
    Add('CHECKPOINT', ktOtherKeyword);
    Add('CHECKSUM', ktFunctionKeyword);
    Add('CHECKSUM_AGG', ktFunctionKeyword);
    Add('CHECKTABLE', ktOtherKeyword);
    Add('CLEANTABLE', ktOtherKeyword);
    Add('CLOSE', ktOtherKeyword);
    Add('CLUSTERED', ktOtherKeyword);
    Add('COALESCE', ktFunctionKeyword);
    Add('COLLATIONPROPERTY', ktFunctionKeyword);
    Add('COLLECTION', ktOtherKeyword);
    Add('COLUMN', ktOtherKeyword);
    Add('COLUMNPROPERTY', ktFunctionKeyword);
    Add('COL_LENGTH', ktFunctionKeyword);
    Add('COL_NAME', ktFunctionKeyword);
    Add('COMMIT', ktOtherKeyword);
    Add('COMMITTED', ktOtherKeyword);
    Add('COMPUTE', ktOtherKeyword);
    Add('CONCAT', ktOtherKeyword);
    Add('CONCAT_NULL_YIELDS_NULL', ktOtherKeyword);
    Add('CONCURRENCYVIOLATION', ktOtherKeyword);
    Add('CONFIRM', ktOtherKeyword);
    Add('CONSTRAINT', ktOtherKeyword);
    Add('CONTAINS', ktOtherKeyword);
    Add('CONTAINSTABLE', ktFunctionKeyword);
    Add('CONTINUE', ktOtherKeyword);
    Add('CONTROL', ktOtherKeyword);
    Add('CONTROLROW', ktOtherKeyword);
    Add('CONVERT', ktFunctionKeyword);
    Add('COS', ktFunctionKeyword);
    Add('COT', ktFunctionKeyword);
    Add('COUNT', ktFunctionKeyword);
    Add('COUNT_BIG', ktFunctionKeyword);
    Add('CREATE', ktOtherKeyword);
    Add('CROSS', ktOtherKeyword);
    Add('CURRENT', ktOtherKeyword);
    Add('CURRENT_DATE', ktOtherKeyword);
    Add('CURRENT_TIME', ktOtherKeyword);
    Add('CURRENT_TIMESTAMP', ktFunctionKeyword);
    Add('CURRENT_USER', ktFunctionKeyword);
    Add('CURSOR', ktOtherKeyword);
    Add('CURSOR_CLOSE_ON_COMMIT', ktOtherKeyword);
    Add('CURSOR_STATUS', ktFunctionKeyword);
    Add('DATABASE', ktOtherKeyword);
    Add('DATABASEPROPERTY', ktFunctionKeyword);
    Add('DATABASEPROPERTYEX', ktFunctionKeyword);
    Add('DATALENGTH', ktFunctionKeyword);
    Add('DATEADD', ktFunctionKeyword);
    Add('DATEDIFF', ktFunctionKeyword);
    Add('DATEFIRST', ktOtherKeyword);
    Add('DATEFORMAT', ktOtherKeyword);
    Add('DATENAME', ktFunctionKeyword);
    Add('DATE', ktDataTypeKeyword);
    Add('DATEPART', ktFunctionKeyword);
    Add('DATETIME', ktDataTypeKeyword);
    Add('DATETIME2', ktDataTypeKeyword);
    Add('DATETIMEOFFSET', ktDataTypeKeyword);
    Add('DAY', ktFunctionKeyword);
    Add('DBCC', ktOtherKeyword);
    Add('DBREINDEX', ktOtherKeyword);
    Add('DBREPAIR', ktOtherKeyword);
    Add('DB_ID', ktFunctionKeyword);
    Add('DB_NAME', ktFunctionKeyword);
    Add('DEADLOCK_PRIORITY', ktOtherKeyword);
    Add('DEALLOCATE', ktOtherKeyword);
    Add('DEC', ktDataTypeKeyword);
    Add('DECIMAL', ktDataTypeKeyword);
    Add('DECLARE', ktOtherKeyword);
    Add('DEFAULT', ktOtherKeyword);
    Add('DEFINITION', ktOtherKeyword);
    Add('DEGREES', ktFunctionKeyword);
    Add('DELAY', ktOtherKeyword);
    Add('DELETE', ktOtherKeyword);
    Add('DENY', ktOtherKeyword);
    Add('DESC', ktOtherKeyword);
    Add('DIFFERENCE', ktFunctionKeyword);
    Add('DISABLE_DEF_CNST_CHK', ktOtherKeyword);
    Add('DISK', ktOtherKeyword);
    Add('DISTINCT', ktOtherKeyword);
    Add('DISTRIBUTED', ktOtherKeyword);
    Add('DOUBLE', ktDataTypeKeyword);
    Add('DROP', ktOtherKeyword);
    Add('DROPCLEANBUFFERS', ktOtherKeyword);
    Add('DUMMY', ktOtherKeyword);
    Add('DUMP', ktOtherKeyword);
    Add('DYNAMIC', ktOtherKeyword);
    Add('ELSE', ktOtherKeyword);
    Add('ENCRYPTION', ktOtherKeyword);
    Add('ERRLVL', ktOtherKeyword);
    Add('ERROREXIT', ktOtherKeyword);
    Add('ESCAPE', ktOtherKeyword);
    Add('EXCEPT', ktOtherKeyword);
    Add('EXEC', ktOtherKeyword);
    Add('EXECUTE', ktOtherKeyword);
    Add('EXISTS', ktOperatorKeyword);
    Add('EXIT', ktOtherKeyword);
    Add('EXP', ktFunctionKeyword);
    Add('EXPAND', ktOtherKeyword);
    Add('EXTERNAL', ktOtherKeyword);
    Add('FAST', ktOtherKeyword);
    Add('FAST_FORWARD', ktOtherKeyword);
    Add('FASTFIRSTROW', ktOtherKeyword);
    Add('FETCH', ktOtherKeyword);
    Add('FILE', ktOtherKeyword);
    Add('FILEGROUPPROPERTY', ktFunctionKeyword);
    Add('FILEGROUP_ID', ktFunctionKeyword);
    Add('FILEGROUP_NAME', ktFunctionKeyword);
    Add('FILEPROPERTY', ktFunctionKeyword);
    Add('FILE_ID', ktFunctionKeyword);
    Add('FILE_IDEX', ktFunctionKeyword);
    Add('FILE_NAME', ktFunctionKeyword);
    Add('FILLFACTOR', ktOtherKeyword);
    Add('FIPS_FLAGGER', ktOtherKeyword);
    Add('FLOAT', ktDataTypeKeyword);
    Add('FLOOR', ktFunctionKeyword);
    Add('FLOPPY', ktOtherKeyword);
    Add('FMTONLY', ktOtherKeyword);
    Add('FOR', ktOtherKeyword);
    Add('FORCE', ktOtherKeyword);
    Add('FORCED', ktOtherKeyword);
    Add('FORCEPLAN', ktOtherKeyword);
    Add('FOREIGN', ktOtherKeyword);
    Add('FORMATMESSAGE', ktFunctionKeyword);
    Add('FORWARD_ONLY', ktOtherKeyword);
    Add('FREEPROCCACHE', ktOtherKeyword);
    Add('FREESESSIONCACHE', ktOtherKeyword);
    Add('FREESYSTEMCACHE', ktOtherKeyword);
    Add('FREETEXT', ktOtherKeyword);
    Add('FREETEXTTABLE', ktFunctionKeyword);
    Add('FROM', ktOtherKeyword);
    Add('FULL', ktOtherKeyword);
    Add('FULLTEXT', ktOtherKeyword);
    Add('FULLTEXTCATALOGPROPERTY', ktFunctionKeyword);
    Add('FULLTEXTSERVICEPROPERTY', ktFunctionKeyword);
    Add('FUNCTION', ktOtherKeyword);
    Add('GEOGRAPHY', ktDataTypeKeyword);
    Add('GETANCESTOR', ktFunctionKeyword);
    Add('GETANSINULL', ktFunctionKeyword);
    Add('GETDATE', ktFunctionKeyword);
    Add('GETDESCENDANT', ktFunctionKeyword);
    Add('GETLEVEL', ktFunctionKeyword);
    Add('GETREPARENTEDVALUE', ktFunctionKeyword);
    Add('GETROOT', ktFunctionKeyword);
    Add('GLOBAL', ktOtherKeyword);
    Add('GO', ktOtherKeyword);
    Add('GOTO', ktOtherKeyword);
    Add('GRANT', ktOtherKeyword);
    Add('GROUP', ktOtherKeyword);
    Add('GROUPING', ktFunctionKeyword);
    Add('HASH', ktOtherKeyword);
    Add('HAVING', ktOtherKeyword);
    Add('HELP', ktOtherKeyword);
    Add('HIERARCHYID', ktDataTypeKeyword);
    Add('HOLDLOCK', ktOtherKeyword);
    Add('HOST_ID', ktFunctionKeyword);
    Add('HOST_NAME', ktFunctionKeyword);
    Add('IDENTITY', ktFunctionKeyword);
    Add('IDENTITYCOL', ktOtherKeyword);
    Add('IDENTITY_INSERT', ktOtherKeyword);
    Add('IDENT_CURRENT', ktFunctionKeyword);
    Add('IDENT_INCR', ktFunctionKeyword);
    Add('IDENT_SEED', ktFunctionKeyword);
    Add('IF', ktOtherKeyword);
    Add('IGNORE_CONSTRAINTS', ktOtherKeyword);
    Add('IGNORE_TRIGGERS', ktOtherKeyword);
    Add('IMAGE', ktDataTypeKeyword);
    Add('IMPLICIT_TRANSACTIONS', ktOtherKeyword);
    Add('IN', ktOperatorKeyword);
    Add('INDEX', ktOtherKeyword);
    Add('INDEXDEFRAG', ktOtherKeyword);
    Add('INDEXKEY_PROPERTY', ktFunctionKeyword);
    Add('INDEXPROPERTY', ktFunctionKeyword);
    Add('INDEX_COL', ktFunctionKeyword);
    Add('INNER', ktOtherKeyword);
    Add('INPUTBUFFER', ktOtherKeyword);
    Add('INSENSITIVE', ktDataTypeKeyword);
    Add('INSERT', ktOtherKeyword);
    Add('INT', ktDataTypeKeyword);
    Add('INTEGER', ktDataTypeKeyword);
    Add('INTERSECT', ktOtherKeyword);
    Add('INTO', ktOtherKeyword);
    Add('IO', ktOtherKeyword);
    Add('IS', ktOtherKeyword);
    Add('ISDATE', ktFunctionKeyword);
    Add('ISDESCENDANTOF', ktFunctionKeyword);
    Add('ISNULL', ktFunctionKeyword);
    Add('ISNUMERIC', ktFunctionKeyword);
    Add('ISOLATION', ktOtherKeyword);
    Add('IS_MEMBER', ktFunctionKeyword);
    Add('IS_SRVROLEMEMBER', ktFunctionKeyword);
    Add('JOIN', ktOtherKeyword);
    Add('KEEP', ktOtherKeyword);
    Add('KEEPDEFAULTS', ktOtherKeyword);
    Add('KEEPFIXED', ktOtherKeyword);
    Add('KEEPIDENTITY', ktOtherKeyword);
    Add('KEY', ktOtherKeyword);
    Add('KEYSET', ktOtherKeyword);
    Add('KILL', ktOtherKeyword);
    Add('LANGUAGE', ktOtherKeyword);
    Add('LEFT', ktFunctionKeyword);
    Add('LEN', ktFunctionKeyword);
    Add('LEVEL', ktOtherKeyword);
    Add('LIKE', ktOperatorKeyword);
    Add('LINENO', ktOtherKeyword);
    Add('LOAD', ktOtherKeyword);
    Add('LOCAL', ktOtherKeyword);
    Add('LOCK_TIMEOUT', ktOtherKeyword);
    Add('LOG', ktFunctionKeyword);
    Add('LOG10', ktFunctionKeyword);
    Add('LOGIN', ktOtherKeyword);
    Add('LOOP', ktOtherKeyword);
    Add('LOWER', ktFunctionKeyword);
    Add('LTRIM', ktFunctionKeyword);
    Add('MATCHED', ktOtherKeyword);
    Add('MAX', ktFunctionKeyword);
    Add('MAX_QUEUE_READERS', ktOtherKeyword);
    Add('MAXDOP', ktOtherKeyword);
    Add('MAXRECURSION', ktOtherKeyword);
    Add('MERGE', ktOtherKeyword);
    Add('MIN', ktFunctionKeyword);
    Add('MIRROREXIT', ktOtherKeyword);
    Add('MODIFY', ktFunctionKeyword);
    Add('MONEY', ktDataTypeKeyword);
    Add('MONTH', ktFunctionKeyword);
    Add('MOVE', ktOtherKeyword);
    Add('NAME', ktOtherKeyword);
    Add('NATIONAL', ktDataTypeKeyword);
    Add('NCHAR', ktDataTypeKeyword);
    Add('NEWID', ktFunctionKeyword);
    Add('NEXT', ktOtherKeyword);
    Add('NOCHECK', ktOtherKeyword);
    Add('NOCOUNT', ktOtherKeyword);
    Add('NODES', ktFunctionKeyword);
    Add('NOEXEC', ktOtherKeyword);
    Add('NOEXPAND', ktOtherKeyword);
    Add('NOLOCK', ktOtherKeyword);
    Add('NONCLUSTERED', ktOtherKeyword);
    Add('NOT', ktOperatorKeyword);
    Add('NOWAIT', ktOtherKeyword);
    Add('NTEXT', ktDataTypeKeyword);
    Add('NTILE', ktFunctionKeyword);
    Add('NULL', ktOtherKeyword);
    Add('NULLIF', ktFunctionKeyword);
    Add('NUMERIC', ktDataTypeKeyword);
    Add('NUMERIC_ROUNDABORT', ktOtherKeyword);
    Add('NVARCHAR', ktDataTypeKeyword);
    Add('OBJECTPROPERTY', ktFunctionKeyword);
    Add('OBJECTPROPERTYEX', ktFunctionKeyword);
    Add('OBJECT', ktOtherKeyword);
    Add('OBJECT_ID', ktFunctionKeyword);
    Add('OBJECT_NAME', ktFunctionKeyword);
    Add('OF', ktOtherKeyword);
    Add('OFF', ktOtherKeyword);
    Add('OFFSETS', ktOtherKeyword);
    Add('ON', ktOtherKeyword);
    Add('ONCE', ktOtherKeyword);
    Add('ONLY', ktOtherKeyword);
    Add('OPEN', ktOtherKeyword);
    Add('OPENDATASOURCE', ktOtherKeyword);
    Add('OPENQUERY', ktFunctionKeyword);
    Add('OPENROWSET', ktFunctionKeyword);
    Add('OPENTRAN', ktOtherKeyword);
    Add('OPTIMIZE', ktOtherKeyword);
    Add('OPTIMISTIC', ktOtherKeyword);
    Add('OPTION', ktOtherKeyword);
    Add('OR', ktOperatorKeyword);
    Add('ORDER', ktOtherKeyword);
    Add('OUTER', ktOtherKeyword);
    Add('OUTPUT', ktOtherKeyword);
    Add('OUTPUTBUFFER', ktOtherKeyword);
    Add('OVER', ktOtherKeyword);
    Add('OWNER', ktOtherKeyword);
    Add('PAGLOCK', ktOtherKeyword);
    Add('PARAMETERIZATION', ktOtherKeyword);
    Add('PARSE', ktFunctionKeyword);
    Add('PARSENAME', ktFunctionKeyword);
    Add('PARSEONLY', ktOtherKeyword);
    Add('PARTITION', ktOtherKeyword);
    Add('PATINDEX', ktFunctionKeyword);
    Add('PERCENT', ktOtherKeyword);
    Add('PERM', ktOtherKeyword);
    Add('PERMANENT', ktOtherKeyword);
    Add('PERMISSIONS', ktFunctionKeyword);
    Add('PI', ktFunctionKeyword);
    Add('PINTABLE', ktOtherKeyword);
    Add('PIPE', ktOtherKeyword);
    Add('PLAN', ktOtherKeyword);
    Add('POWER', ktFunctionKeyword);
    Add('PREPARE', ktOtherKeyword);
    Add('PRIMARY', ktOtherKeyword);
    Add('PRINT', ktOtherKeyword);
    Add('PRIVILEGES', ktOtherKeyword);
    Add('PROC', ktOtherKeyword);
    Add('PROCCACHE', ktOtherKeyword);
    Add('PROCEDURE', ktOtherKeyword);
    Add('PROCEDURE_NAME', ktOtherKeyword);
    Add('PROCESSEXIT', ktOtherKeyword);
    Add('PROCID', ktOtherKeyword);
    Add('PROFILE', ktOtherKeyword);
    Add('PUBLIC', ktOtherKeyword);
    Add('QUERY', ktFunctionKeyword);
    Add('QUERY_GOVERNOR_COST_LIMIT', ktOtherKeyword);
    Add('QUEUE', ktOtherKeyword);
    Add('QUOTED_IDENTIFIER', ktOtherKeyword);
    Add('QUOTENAME', ktFunctionKeyword);
    Add('RADIANS', ktFunctionKeyword);
    Add('RAISERROR', ktOtherKeyword);
    Add('RAND', ktFunctionKeyword);
    Add('READ', ktOtherKeyword);
    Add('READCOMMITTED', ktOtherKeyword);
    Add('READCOMMITTEDLOCK', ktOtherKeyword);
    Add('READPAST', ktOtherKeyword);
    Add('READTEXT', ktOtherKeyword);
    Add('READUNCOMMITTED', ktOtherKeyword);
    Add('READ_ONLY', ktOtherKeyword);
    Add('REAL', ktDataTypeKeyword);
    Add('RECOMPILE', ktOtherKeyword);
    Add('RECONFIGURE', ktOtherKeyword);
    Add('REFERENCES', ktOtherKeyword);
    Add('REMOTE_PROC_TRANSACTIONS', ktOtherKeyword);
    Add('REPEATABLE', ktOtherKeyword);
    Add('REPEATABLEREAD', ktOtherKeyword);
    Add('REPLACE', ktFunctionKeyword);
    Add('REPLICATE', ktFunctionKeyword);
    Add('REPLICATION', ktOtherKeyword);
    Add('RESTORE', ktOtherKeyword);
    Add('RESTRICT', ktOtherKeyword);
    Add('RETURN', ktOtherKeyword);
    Add('RETURNS', ktOtherKeyword);
    Add('REVERSE', ktFunctionKeyword);
    Add('REVERT', ktOtherKeyword);
    Add('REVOKE', ktOtherKeyword);
    Add('RIGHT', ktFunctionKeyword);
    Add('ROBUST', ktOtherKeyword);
    Add('ROLE', ktOtherKeyword);
    Add('ROLLBACK', ktOtherKeyword);
    Add('ROUND', ktFunctionKeyword);
    Add('ROWCOUNT', ktOtherKeyword);
    Add('ROWGUIDCOL', ktOtherKeyword);
    Add('ROWLOCK', ktOtherKeyword);
    Add('ROWVERSION', ktDataTypeKeyword);
    Add('RTRIM', ktFunctionKeyword);
    Add('RULE', ktOtherKeyword);
    Add('SAVE', ktOtherKeyword);
    Add('SCHEMA', ktOtherKeyword);
    Add('SCHEMA_ID', ktFunctionKeyword);
    Add('SCHEMA_NAME', ktFunctionKeyword);
    Add('SCOPE_IDENTITY', ktFunctionKeyword);
    Add('SCROLL', ktOtherKeyword);
    Add('SCROLL_LOCKS', ktOtherKeyword);
    Add('SELECT', ktOtherKeyword);
    Add('SELF', ktOtherKeyword);
    Add('SERIALIZABLE', ktOtherKeyword);
    Add('SERVER', ktOtherKeyword);
    Add('SERVERPROPERTY', ktFunctionKeyword);
    Add('SESSIONPROPERTY', ktFunctionKeyword);
    Add('SESSION_USER', ktFunctionKeyword);
    Add('SET', ktOtherKeyword);
    Add('SETUSER', ktOtherKeyword);
    Add('SHOWCONTIG', ktOtherKeyword);
    Add('SHOWPLAN_ALL', ktOtherKeyword);
    Add('SHOWPLAN_TEXT', ktOtherKeyword);
    Add('SHOW_STATISTICS', ktOtherKeyword);
    Add('SHRINKDATABASE', ktOtherKeyword);
    Add('SHRINKFILE', ktOtherKeyword);
    Add('SHUTDOWN', ktOtherKeyword);
    Add('SIGN', ktFunctionKeyword);
    Add('SIMPLE', ktOtherKeyword);
    Add('SIN', ktFunctionKeyword);
    Add('SMALLDATETIME', ktDataTypeKeyword);
    Add('SMALLINT', ktDataTypeKeyword);
    Add('SMALLMONEY', ktDataTypeKeyword);
    Add('SOME', ktOperatorKeyword);
    Add('SOUNDEX', ktFunctionKeyword);
    Add('SPACE', ktFunctionKeyword);
    Add('SQLPERF', ktOtherKeyword);
    Add('SQL_VARIANT', ktDataTypeKeyword);
    Add('SQL_VARIANT_PROPERTY', ktFunctionKeyword);
    Add('SQRT', ktFunctionKeyword);
    Add('SQUARE', ktFunctionKeyword);
    Add('STATE', ktOtherKeyword);
    Add('STATISTICS', ktOtherKeyword);
    Add('STATIC', ktOtherKeyword);
    Add('STATS_DATE', ktFunctionKeyword);
    Add('STATUS', ktOtherKeyword);
    Add('STDEV', ktFunctionKeyword);
    Add('STDEVP', ktFunctionKeyword);
    Add('STOPLIST', ktOtherKeyword);
    Add('STR', ktFunctionKeyword);
    Add('STUFF', ktFunctionKeyword);
    Add('SUBSTRING', ktFunctionKeyword);
    Add('SUM', ktFunctionKeyword);
    Add('SUSER_ID', ktFunctionKeyword);
    Add('SUSER_NAME', ktFunctionKeyword);
    Add('SUSER_SID', ktFunctionKeyword);
    Add('SUSER_SNAME', ktFunctionKeyword);
    Add('SYNONYM', ktOtherKeyword);
    Add('SYSNAME', ktDataTypeKeyword);
    Add('SYSTEM_USER', ktFunctionKeyword);
    Add('TABLE', ktOtherKeyword);
    Add('TABLOCK', ktOtherKeyword);
    Add('TABLOCKX', ktOtherKeyword);
    Add('TAN', ktFunctionKeyword);
    Add('TAPE', ktOtherKeyword);
    Add('TEMP', ktOtherKeyword);
    Add('TEMPORARY', ktOtherKeyword);
    Add('TEXT', ktDataTypeKeyword);
    Add('TEXTPTR', ktFunctionKeyword);
    Add('TEXTSIZE', ktOtherKeyword);
    Add('TEXTVALID', ktFunctionKeyword);
    Add('THEN', ktOtherKeyword);
    Add('TIME', ktDataTypeKeyword); //not strictly-speaking True, can also be keyword in WAITFOR TIME
    Add('TIMESTAMP', ktDataTypeKeyword);
    Add('TINYINT', ktDataTypeKeyword);
    Add('TO', ktOtherKeyword);
    Add('TOP', ktOtherKeyword);
    Add('TOSTRING', ktFunctionKeyword);
    Add('TRACEOFF', ktOtherKeyword);
    Add('TRACEON', ktOtherKeyword);
    Add('TRACESTATUS', ktOtherKeyword);
    Add('TRAN', ktOtherKeyword);
    Add('TRANSACTION', ktOtherKeyword);
    Add('TRIGGER', ktOtherKeyword);
    Add('TRUNCATE', ktOtherKeyword);
    Add('TSEQUAL', ktOtherKeyword);
    Add('TYPEPROPERTY', ktFunctionKeyword);
    Add('TYPE_ID', ktFunctionKeyword);
    Add('TYPE_NAME', ktFunctionKeyword);
    Add('TYPE_WARNING', ktOtherKeyword);
    Add('UNCOMMITTED', ktOtherKeyword);
    Add('UNICODE', ktFunctionKeyword);
    Add('UNION', ktOtherKeyword);
    Add('UNIQUE', ktOtherKeyword);
    Add('UNIQUEIDENTIFIER', ktDataTypeKeyword);
    Add('UNKNOWN', ktOtherKeyword);
    Add('UNPINTABLE', ktOtherKeyword);
    Add('UPDATE', ktOtherKeyword);
    Add('UPDATETEXT', ktOtherKeyword);
    Add('UPDATEUSAGE', ktOtherKeyword);
    Add('UPDLOCK', ktOtherKeyword);
    Add('UPPER', ktFunctionKeyword);
    Add('USE', ktOtherKeyword);
    Add('USER', ktFunctionKeyword);
    Add('USEROPTIONS', ktOtherKeyword);
    Add('USER_ID', ktFunctionKeyword);
    Add('USER_NAME', ktFunctionKeyword);
    Add('USING', ktOtherKeyword);
    Add('VALUE', ktFunctionKeyword);
    Add('VALUES', ktOtherKeyword);
    Add('VAR', ktFunctionKeyword);
    Add('VARBINARY', ktDataTypeKeyword);
    Add('VARCHAR', ktDataTypeKeyword);
    Add('VARP', ktFunctionKeyword);
    Add('VARYING', ktOtherKeyword);
    Add('VIEW', ktOtherKeyword);
    Add('VIEWS', ktOtherKeyword);
    Add('WAITFOR', ktOtherKeyword);
    Add('WHEN', ktOtherKeyword);
    Add('WHERE', ktOtherKeyword);
    Add('WHILE', ktOtherKeyword);
    Add('WITH', ktOtherKeyword);
    Add('WORK', ktOtherKeyword);
    Add('WRITE', ktFunctionKeyword);
    Add('WRITETEXT', ktOtherKeyword);
    Add('XACT_ABORT', ktOtherKeyword);
    Add('XLOCK', ktOtherKeyword);
    Add('XML', ktDataTypeKeyword);
    Add('YEAR', ktFunctionKeyword);
  end;
end;

end.
