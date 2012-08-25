unit SQLConstants;

interface

const
  PARSING_ERRORS_FOUND = '-- Warning! Errors found during SQL parsing.';

  ENAME_SQL_ROOT = 'SqlRoot';
  ENAME_SQL_STATEMENT = 'SqlStatement';
  ENAME_SQL_CLAUSE = 'Clause';
  ENAME_SET_OPERATOR_CLAUSE = 'SetOperatorClause';
  ENAME_INSERT_CLAUSE = 'InsertClause';
  ENAME_BEGIN_END_BLOCK = 'BeginEndBlock';
  ENAME_TRY_BLOCK = 'TryBlock';
  ENAME_CATCH_BLOCK = 'CatchBlock';
  ENAME_BATCH_SEPARATOR = 'BatchSeparator';
  ENAME_CASE_STATEMENT = 'CaseStatement';
  ENAME_CASE_INPUT = 'Input';
  ENAME_CASE_WHEN = 'When';
  ENAME_CASE_THEN = 'Then';
  ENAME_CASE_ELSE = 'CaseElse';
  ENAME_IF_STATEMENT = 'IfStatement';
  ENAME_ELSE_CLAUSE = 'ElseClause';
  ENAME_BOOLEAN_EXPRESSION = 'BooleanExpression';
  ENAME_WHILE_LOOP = 'WhileLoop';
  ENAME_CURSOR_DECLARATION = 'CursorDeclaration';
  ENAME_CURSOR_FOR_BLOCK = 'CursorForBlock';
  ENAME_CURSOR_FOR_OPTIONS = 'CursorForOptions';
  ENAME_CTE_WITH_CLAUSE = 'CTEWithClause';
  ENAME_CTE_ALIAS = 'CTEAlias';
  ENAME_CTE_AS_BLOCK = 'CTEAsBlock';
  ENAME_BEGIN_TRANSACTION = 'BeginTransaction';
  ENAME_COMMIT_TRANSACTION = 'CommitTransaction';
  ENAME_ROLLBACK_TRANSACTION = 'RollbackTransaction';
  ENAME_SAVE_TRANSACTION = 'SaveTransaction';
  ENAME_DDL_PROCEDURAL_BLOCK = 'DDLProceduralBlock';
  ENAME_DDL_OTHER_BLOCK = 'DDLOtherBlock';
  ENAME_DDL_AS_BLOCK = 'DDLAsBlock';
  ENAME_DDL_PARENS = 'DDLParens';
  ENAME_DDL_SUBCLAUSE = 'DDLSubClause';
  ENAME_DDL_RETURNS = 'DDLReturns';
  ENAME_DDLDETAIL_PARENS = 'DDLDetailParens';
  ENAME_DDL_WITH_CLAUSE = 'DDLWith';
  ENAME_PERMISSIONS_BLOCK = 'PermissionsBlock';
  ENAME_PERMISSIONS_DETAIL = 'PermissionsDetail';
  ENAME_PERMISSIONS_TARGET = 'PermissionsTarget';
  ENAME_PERMISSIONS_RECIPIENT = 'PermissionsRecipient';
  ENAME_TRIGGER_CONDITION = 'TriggerCondition';
  ENAME_SELECTIONTARGET_PARENS = 'SelectionTargetParens';
  ENAME_EXPRESSION_PARENS = 'ExpressionParens';
  ENAME_FUNCTION_PARENS = 'FunctionParens';
  ENAME_FUNCTION_KEYWORD = 'FunctionKeyword';
  ENAME_DATATYPE_KEYWORD = 'DataTypeKeyword';
  ENAME_COMPOUNDKEYWORD = 'CompoundKeyword';
  ENAME_OTHERKEYWORD = 'OtherKeyword';
  ENAME_LABEL = 'Label';
  ENAME_CONTAINER_OPEN = 'ContainerOpen';
  ENAME_CONTAINER_MULTISTATEMENT = 'ContainerMultiStatementBody';
  ENAME_CONTAINER_SINGLESTATEMENT = 'ContainerSingleStatementBody';
  ENAME_CONTAINER_GENERALCONTENT = 'ContainerContentBody';
  ENAME_CONTAINER_CLOSE = 'ContainerClose';
  ENAME_SELECTIONTARGET = 'SelectionTarget';
  ENAME_MERGE_CLAUSE = 'MergeClause';
  ENAME_MERGE_TARGET = 'MergeTarget';
  ENAME_MERGE_USING = 'MergeUsing';
  ENAME_MERGE_CONDITION = 'MergeCondition';
  ENAME_MERGE_WHEN = 'MergeWhen';
  ENAME_MERGE_THEN = 'MergeThen';
  ENAME_MERGE_ACTION = 'MergeAction';
  ENAME_JOIN_ON_SECTION = 'JoinOn';

  ENAME_PSEUDONAME = 'PseudoName';
  ENAME_WHITESPACE = 'WhiteSpace';
  ENAME_OTHERNODE = 'Other';
  ENAME_COMMENT_SINGLELINE = 'SingleLineComment';
  ENAME_COMMENT_MULTILINE = 'MultiLineComment';
  ENAME_STRING = 'String';
  ENAME_NSTRING = 'NationalString';
  ENAME_QUOTED_STRING = 'QuotedString';
  ENAME_BRACKET_QUOTED_NAME = 'BracketQuotedName';
  ENAME_COMMA = 'Comma';
  ENAME_PERIOD = 'Period';
  ENAME_SEMICOLON = 'Semicolon';
  ENAME_SCOPERESOLUTIONOPERATOR = 'ScopeResolutionOperator';
  ENAME_ASTERISK = 'Asterisk';
  ENAME_ALPHAOPERATOR = 'AlphaOperator';
  ENAME_OTHEROPERATOR = 'OtherOperator';

  ENAME_AND_OPERATOR = 'And';
  ENAME_OR_OPERATOR = 'Or';
  ENAME_BETWEEN_CONDITION = 'Between';
  ENAME_BETWEEN_LOWERBOUND = 'LowerBound';
  ENAME_BETWEEN_UPPERBOUND = 'UpperBound';

  ENAME_NUMBER_VALUE = 'NumberValue';
  ENAME_MONETARY_VALUE = 'MonetaryValue';
  ENAME_BINARY_VALUE = 'BinaryValue';

        //attribute names
  ANAME_ERRORFOUND = 'errorFound';
  ANAME_DATALOSS = 'dataLossLimitation';
  ANAME_SIMPLETEXT = 'simpleText';

implementation
{
uses XMLDoc, XMLIntf, xmldom;

function CreateXMLDocument( var Owner1: TComponent): TXMLDocument;
begin
Owner1 := TComponent.Create( nil);
result  := TXMLDocument.Create( Owner1);
result.Options := [doNodeAutoCreate, doNodeAutoIndent, doAttrNull,
                   doAutoPrefix, doNamespaceDecl];
result.DOMVendor := GetDOMVendor( 'MSXML');
end;

function XPATHSelect( const FocusNode: IXMLNode; const sXPath: string): TArray<IXMLNode>;
var
  DomNodeSelect: IDomNodeSelect;
  DOMNode      : IDomNode;
  DocAccess    : IXmlDocumentAccess;
  Doc          : TXmlDocument;
  DOMNodes     : IDOMNodeList;
  iDOMNode     : integer;
begin
SetLength( result, 0);
if assigned( FocusNode) and
   Supports( FocusNode.DOMNode, IDomNodeSelect, DomNodeSelect) then
    DOMNodes := DomNodeSelect.SelectNodes( sXPath);
if not assigned( DOMNodes) then exit;
SetLength( result, DOMNodes.Length);
for iDOMNode := 0 to DOMNodes.Length - 1 do
  begin
  Doc := nil;
  DOMNode := DOMNodes.item[iDOMNode];
  if Supports( DOMNode, IXmlDocumentAccess, DocAccess) then
    Doc := DocAccess.DocumentObject;
  result[ iDOMNode] := TXmlNode.Create( DOMNode, nil, Doc) as IXMLNode;
  end
end;


function XPATHSelectFirst( const FocusNode: IXMLNode; const sXPath: string; var SelectedNode: IXMLNode): boolean;
var
  DomNodeSelect: IDomNodeSelect;
  DOMNode      : IDomNode;
  DocAccess    : IXmlDocumentAccess;
  Doc          : TXmlDocument;
begin
SelectedNode := nil;
if assigned( FocusNode) and
   Supports( FocusNode.DOMNode, IDomNodeSelect, DomNodeSelect) then
  DOMNode := DomNodeSelect.selectNode( sXPath);
if assigned( DOMNode) and
   Supports( DOMNode.OwnerDocument, IXmlDocumentAccess, DocAccess) then
  Doc := DocAccess.DocumentObject;
if Assigned( DOMNode) then
  SelectedNode := TXmlNode.Create( DOMNode, nil, Doc);
result := assigned( SelectedNode)
end;

procedure TForm2.btn1Click(Sender: TObject);
const
  DocumentSource =  'http://softez.pp.ua/gg.xml';
var
  Doc: IXMLDocument;
  DocOwner: TComponent;
  RowNode, PhraseNode, UrlNode: IXMLNode;

  procedure PutLn( const LineFmt: string; const Args: array of const);
  begin
  memo2.Lines.Add( Format( LineFmt, Args))
  end;

begin
memo2.Clear;
Doc := CreateXMLDocument( DocOwner);
Doc.LoadFromFile( DocumentSource);
for RowNode in XPATHSelect( Doc.DocumentElement, '//row[phrase]') do
  begin
  if not XPATHSelectFirst( RowNode, 'phrase', PhraseNode) then continue;
  PutLn( 'phrase=%s', [PhraseNode.NodeValue]);
  for UrlNode in XPATHSelect( RowNode, 'search_engines/search_engine/se_url') do
    PutLn( 'url=%s', [UrlNode.NodeValue]);
  PutLn('--------------',[])
  end;
DocOwner.Free;
end;
           }
end.


