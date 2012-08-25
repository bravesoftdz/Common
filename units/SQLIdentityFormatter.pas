unit SQLIdentityFormatter;

interface

uses
  SQLParseTree, xmldom, SQLFormatter, SQLTokenizer;

type
  TSqlIdentityFormatter = class
  private
    procedure ProcessSqlNodeList(State: TSQLFormatterState; RootList: IDOMNodeList);
    procedure ProcessSqlNode(State: TSQLFormatterState; ContentNode: IDOMNode);
  public
    function FormatSQLTree(SQLTreeDoc: TSQLParseTree): string; overload;
    function FormatSQLTree(SqlTreeFragment: IDOMNode): string; overload;
    function FormatSQLNodes(Nodes: IDOMNodeList; State: TSQLFormatterState): string;
    function FormatSQLTokens(SQLTokenList: TSQLTokenList): string;
  end;

implementation

uses
  SQLConstants, SysUtils;

function TSqlIdentityFormatter.FormatSQLTree(SQLTreeDoc: TSQLParseTree): string;
var
  //RootElement: string;
  State: TSQLFormatterState;
  RootList: IDOMNodeList;
begin
  //RootElement := SQLConstants.ENAME_SQL_ROOT;
  State := TSQLFormatterState.Create;

  if SQLTreeDoc.DocumentElement.getElementsByTagName(SQLConstants.ANAME_ERRORFOUND).length > 0 then //SelectSingleNode(string.Format("/{0}/@{}[.=1]", rootElement, SqlXmlConstants.ANAME_ERRORFOUND)) != null)
    State.AddOutputContent(SQLConstants.PARSING_ERRORS_FOUND);

  RootList := SQLTreeDoc.DocumentElement.getElementsByTagName(SQLConstants.ENAME_SQL_ROOT);  // .SelectNodes(string.Format("/{0}/*", rootElement));
  Result := FormatSQLNodes(RootList, State);
end;

function TSqlIdentityFormatter.FormatSQLTree(SQLTreeFragment: IDOMNode): string;
var
  State: TSQLFormatterState;
begin
  State := TSQLFormatterState.Create;
  Result := FormatSQLNodes(SQLTreeFragment.childNodes {.SelectNodes(".")}, State);
end;

function TSqlIdentityFormatter.FormatSQLNodes(Nodes: IDOMNodeList; State: TSQLFormatterState): string;
begin
  ProcessSqlNodeList(State, nodes);
  Result := State.OutputToString;
end;

procedure TSqlIdentityFormatter.ProcessSqlNodeList(State: TSQLFormatterState; RootList: IDOMNodeList);
var
  i: Integer;
begin
  for i := 0 to RootList.length - 1 do
    ProcessSqlNode(State, RootList[i]);
end;

procedure TSqlIdentityFormatter.ProcessSqlNode(State: TSQLFormatterState; ContentNode: IDOMNode);
var
  i: Integer;
begin
  if (ContentNode.nodeName = SQLConstants.ENAME_DDLDETAIL_PARENS) or
     (ContentNode.nodeName = SQLConstants.ENAME_DDL_PARENS) or
     (ContentNode.nodeName = SQLConstants.ENAME_FUNCTION_PARENS) or
     (ContentNode.nodeName = SQLConstants.ENAME_EXPRESSION_PARENS) or
     (ContentNode.nodeName = SQLConstants.ENAME_SELECTIONTARGET_PARENS) then
  begin
    State.AddOutputContent('(');
    ProcessSqlNodeList(State, ContentNode.childNodes);
    State.AddOutputContent(')');
  end
  else
  if (ContentNode.nodeName = SQLConstants.ENAME_SQL_ROOT) or
     (ContentNode.nodeName = SQLConstants.ENAME_SQL_STATEMENT) or
     (ContentNode.nodeName = SQLConstants.ENAME_SQL_CLAUSE) or
     (ContentNode.nodeName = SQLConstants.ENAME_BOOLEAN_EXPRESSION) or
     (ContentNode.nodeName = SQLConstants.ENAME_DDL_PROCEDURAL_BLOCK) or
     (ContentNode.nodeName = SQLConstants.ENAME_DDL_OTHER_BLOCK) or
     (ContentNode.nodeName = SQLConstants.ENAME_CURSOR_DECLARATION) or
     (ContentNode.nodeName = SQLConstants.ENAME_BEGIN_END_BLOCK) or
     (ContentNode.nodeName = SQLConstants.ENAME_TRY_BLOCK) or
     (ContentNode.nodeName = SQLConstants.ENAME_CATCH_BLOCK) or
     (ContentNode.nodeName = SQLConstants.ENAME_CASE_STATEMENT) or
     (ContentNode.nodeName = SQLConstants.ENAME_CASE_INPUT) or
     (ContentNode.nodeName = SQLConstants.ENAME_CASE_WHEN) or
     (ContentNode.nodeName = SQLConstants.ENAME_CASE_THEN) or
     (ContentNode.nodeName = SQLConstants.ENAME_CASE_ELSE) or
     (ContentNode.nodeName = SQLConstants.ENAME_IF_STATEMENT) or
     (ContentNode.nodeName = SQLConstants.ENAME_ELSE_CLAUSE) or
     (ContentNode.nodeName = SQLConstants.ENAME_WHILE_LOOP) or
     (ContentNode.nodeName = SQLConstants.ENAME_DDL_AS_BLOCK) or
     (ContentNode.nodeName = SQLConstants.ENAME_BETWEEN_CONDITION) or
     (ContentNode.nodeName = SQLConstants.ENAME_BETWEEN_LOWERBOUND) or
     (ContentNode.nodeName = SQLConstants.ENAME_BETWEEN_UPPERBOUND) or
     (ContentNode.nodeName = SQLConstants.ENAME_CTE_WITH_CLAUSE) or
     (ContentNode.nodeName = SQLConstants.ENAME_CTE_ALIAS) or
     (ContentNode.nodeName = SQLConstants.ENAME_CTE_AS_BLOCK) or
     (ContentNode.nodeName = SQLConstants.ENAME_CURSOR_FOR_BLOCK) or
     (ContentNode.nodeName = SQLConstants.ENAME_CURSOR_FOR_OPTIONS) or
     (ContentNode.nodeName = SQLConstants.ENAME_TRIGGER_CONDITION) or
     (ContentNode.nodeName = SQLConstants.ENAME_COMPOUNDKEYWORD) or
     (ContentNode.nodeName = SQLConstants.ENAME_BEGIN_TRANSACTION) or
     (ContentNode.nodeName = SQLConstants.ENAME_ROLLBACK_TRANSACTION) or
     (ContentNode.nodeName = SQLConstants.ENAME_SAVE_TRANSACTION) or
     (ContentNode.nodeName = SQLConstants.ENAME_COMMIT_TRANSACTION) or
     (ContentNode.nodeName = SQLConstants.ENAME_BATCH_SEPARATOR) or
     (ContentNode.nodeName = SQLConstants.ENAME_SET_OPERATOR_CLAUSE) or
     (ContentNode.nodeName = SQLConstants.ENAME_CONTAINER_OPEN) or
     (ContentNode.nodeName = SQLConstants.ENAME_CONTAINER_MULTISTATEMENT) or
     (ContentNode.nodeName = SQLConstants.ENAME_CONTAINER_SINGLESTATEMENT) or
     (ContentNode.nodeName = SQLConstants.ENAME_CONTAINER_GENERALCONTENT) or
     (ContentNode.nodeName = SQLConstants.ENAME_CONTAINER_CLOSE) or
     (ContentNode.nodeName = SQLConstants.ENAME_SELECTIONTARGET) or
     (ContentNode.nodeName = SQLConstants.ENAME_PERMISSIONS_BLOCK) or
     (ContentNode.nodeName = SQLConstants.ENAME_PERMISSIONS_DETAIL) or
     (ContentNode.nodeName = SQLConstants.ENAME_PERMISSIONS_TARGET) or
     (ContentNode.nodeName = SQLConstants.ENAME_PERMISSIONS_RECIPIENT) or
     (ContentNode.nodeName = SQLConstants.ENAME_DDL_WITH_CLAUSE) or
     (ContentNode.nodeName = SQLConstants.ENAME_MERGE_CLAUSE) or
     (ContentNode.nodeName = SQLConstants.ENAME_MERGE_TARGET) or
     (ContentNode.nodeName = SQLConstants.ENAME_MERGE_USING) or
     (ContentNode.nodeName = SQLConstants.ENAME_MERGE_CONDITION) or
     (ContentNode.nodeName = SQLConstants.ENAME_MERGE_WHEN) or
     (ContentNode.nodeName = SQLConstants.ENAME_MERGE_THEN) or
     (ContentNode.nodeName = SQLConstants.ENAME_MERGE_ACTION) or
     (ContentNode.nodeName = SQLConstants.ENAME_JOIN_ON_SECTION) then
  begin
    for i := 0 to ContentNode.childNodes.length - 1 do
      case ContentNode.childNodes.item[i].nodeType of
        NODETYPE_ELEMENT: ProcessSqlNode(state, ContentNode.childNodes.item[i]);
        NODETYPE_TEXT,
        NODETYPE_COMMENT: ; //ignore; valid text is in appropriate containers, displayable T-SQL comments are elements.
        else
          raise Exception.Create('Unexpected xml node type encountered!');
     end
  end
  else
  if ContentNode.nodeName = SQLConstants.ENAME_COMMENT_MULTILINE then
    State.AddOutputContent('/*' + ContentNode.nodeValue + '*/')
  else
  if ContentNode.nodeName = SQLConstants.ENAME_COMMENT_SINGLELINE then
    State.AddOutputContent('--' + ContentNode.nodeValue)
  else
  if ContentNode.nodeName = SQLConstants.ENAME_STRING then
    State.AddOutputContent(AnsiQuotedStr(AnsiDequotedStr(ContentNode.nodeValue, ''''), ''''))
  else
  if ContentNode.nodeName = SQLConstants.ENAME_NSTRING then
    State.AddOutputContent('N' + AnsiQuotedStr(AnsiDequotedStr(ContentNode.nodeValue, ''''), ''''))
  else
  if ContentNode.nodeName = SQLConstants.ENAME_QUOTED_STRING then
    State.AddOutputContent('\''' + StringReplace(ContentNode.nodeValue, '\''', '\''\''', [rfReplaceAll]) + '\''')
  else
  if ContentNode.nodeName = SQLConstants.ENAME_BRACKET_QUOTED_NAME then
    State.AddOutputContent('[' + StringReplace(ContentNode.nodeValue, ']', ']]', [rfReplaceAll]) + ']')
  else
  if (ContentNode.nodeName = SQLConstants.ENAME_COMMA) or
     (ContentNode.nodeName = SQLConstants.ENAME_PERIOD) or
     (ContentNode.nodeName = SQLConstants.ENAME_SEMICOLON) or
     (ContentNode.nodeName = SQLConstants.ENAME_ASTERISK) or
     (ContentNode.nodeName = SQLConstants.ENAME_SCOPERESOLUTIONOPERATOR) or
     (ContentNode.nodeName = SQLConstants.ENAME_AND_OPERATOR) or
     (ContentNode.nodeName = SQLConstants.ENAME_OR_OPERATOR) or
     (ContentNode.nodeName = SQLConstants.ENAME_ALPHAOPERATOR) or
     (ContentNode.nodeName = SQLConstants.ENAME_OTHEROPERATOR) then
    State.AddOutputContent(ContentNode.nodeValue)
  else
  if ContentNode.nodeName = SQLConstants.ENAME_FUNCTION_KEYWORD then
    State.AddOutputContent(ContentNode.nodeValue)
  else
  if (ContentNode.nodeName = SQLConstants.ENAME_OTHERKEYWORD) or
     (ContentNode.nodeName = SQLConstants.ENAME_DATATYPE_KEYWORD) or
     (ContentNode.nodeName = SQLConstants.ENAME_DDL_RETURNS) or
     (ContentNode.nodeName = SQLConstants.ENAME_PSEUDONAME) then
    State.AddOutputContent(ContentNode.nodeValue)
  else
  if (ContentNode.nodeName = SQLConstants.ENAME_OTHERNODE) or
     (ContentNode.nodeName = SQLConstants.ENAME_WHITESPACE) or
     (ContentNode.nodeName = SQLConstants.ENAME_NUMBER_VALUE) or
     (ContentNode.nodeName = SQLConstants.ENAME_MONETARY_VALUE) or
     (ContentNode.nodeName = SQLConstants.ENAME_BINARY_VALUE) or
     (ContentNode.nodeName = SQLConstants.ENAME_LABEL) then
    State.AddOutputContent(ContentNode.nodeValue)
  else
    raise Exception.Create('Unrecognized element in SQL Xml!');
end;

function TSqlIdentityFormatter.FormatSQLTokens(SQLTokenList: TSQLTokenList): string;
var
  i: Integer;
  OutString: TStringBuilder;
begin
  OutString := TStringBuilder.Create;

  if SQLTokenList.HasErrors then
    OutString.Append(SQLConstants.PARSING_ERRORS_FOUND);

  for i := 0 to SQLTokenList.Count - 1 do
    case SQLTokenList.Items[i].TokenType of
      ttMultiLineComment:
      begin
        OutString.Append('/*');
        OutString.Append(SQLTokenList.Items[i].Value);
        OutString.Append('*/');
      end;
      ttSingleLineComment:
      begin
        OutString.Append('--');
        OutString.Append(SQLTokenList.Items[i].Value);
      end;
      ttString:
      begin
        OutString.Append('''');
        OutString.Append(AnsiDequotedStr(SQLTokenList.Items[i].Value, ''''));
        OutString.Append('''');
      end;
      ttNationalString:
      begin
        OutString.Append('N''');
        OutString.Append(AnsiDequotedStr(SQLTokenList.Items[i].Value, ''''));
        OutString.Append('''');
      end;
      ttQuotedString:
      begin
        OutString.Append('\''');
        OutString.Append(StringReplace(SQLTokenList.Items[i].Value, '\''', '\''\''', [rfReplaceAll]));
        OutString.Append('\''');
      end;
      ttBracketQuotedName:
      begin
        OutString.Append('[');
        OutString.Append(StringReplace(SQLTokenList.Items[i].Value, ']', ']]', [rfReplaceAll]));
        OutString.Append(']');
      end;
      ttOpenParens, ttCloseParens, ttComma,  ttPeriod, ttSemicolon, ttColon, ttAsterisk,
      ttOtherNode, ttWhiteSpace, ttOtherOperator, ttNumber, ttBinaryValue, ttMonetaryValue,
      ttPseudoName:
        OutString.Append(SQLTokenList.Items[i].Value);
      else
        raise Exception.Create('Unrecognized Token Type in Token List!');
  end;
  Result := OutString.ToString;
end;

end.
