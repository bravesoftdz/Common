unit SQLParseTree;

interface

uses
  Classes, XMLDoc, XMLIntf;

type
  //TXMLNode = IXMLNode;
  TSQLParseTree = class(TXMLDocument)
  private
    FOwner: TComponent;
    FCurrentContainer: IXMLNode;
    FNewStatementDue: Boolean;
    procedure EscapeCursorForBlock;
    function EscapeAndLocateNextStatementContainer(escapeEmptyContainer: Boolean): IXMLNode;
    procedure MigrateApplicableCommentsFromContainer(previousContainerElement: IXMLNode);
    function HasNonWhiteSpaceNonSingleCommentContent(ContainerNode: IXMLNode): Boolean;
    function GetCurrentContainer: IXMLNode;
    function GetNewStatementDue: Boolean;
    procedure SetCurrentContainer(Value: IXMLNode);
    procedure SetNewStatementDue(Value: Boolean);
    function GetErrorFound: Boolean;
    procedure SetErrorFound(Value: Boolean);
  public
    constructor Create; overload; //(RootName: string); overload;
    destructor Destroy; override;
    //function ToXMLDoc: TXMLDocument;
    procedure StartNewStatement; overload;
    function GetFirstNonWhitespaceNonCommentChildElement(TargetElement: IXMLNode): IXMLNode;
    function SaveNewElement(newElementName: string; newElementValue: string): IXMLNode; overload;
    function SaveNewElement(newElementName: string; newElementValue: string;
      targetNode: IXMLNode): IXMLNode; overload;
    procedure StartNewStatement(targetNode: IXMLNode); overload;
    procedure ConsiderStartingNewStatement;
    procedure EscapeAnySingleOrPartialStatementContainers;
    procedure ConsiderStartingNewClause;
    property CurrentContainer: IXMLNode read GetCurrentContainer write SetCurrentContainer;
    property ErrorFound: Boolean read GetErrorFound write SetErrorFound;
    property DocumentElement: IXMLNode read GetDocumentElement write SetDocumentElement;
    property NewStatementDue: Boolean read GetNewStatementDue write SetNewStatementDue;
    procedure MoveToAncestorContainer(LevelsUp: Integer); overload;
    procedure MoveToAncestorContainer(LevelsUp: Integer; targetContainerName: string); overload;
    function SaveNewElementWithError(NewElementName: string; NewElementValue: string): IXMLNode;
    function PathNameMatches(LevelsUp: Integer; NameToMatch: string): Boolean; overload;
    function PathNameMatches(TargetNode: IXMLNode; LevelsUp: Integer; NameToMatch: string): Boolean; overload;
    procedure StartNewContainer(newElementName: string; containerOpenValue: string;
      containerType: string);
    procedure EscapeAnyBetweenConditions;
    procedure EscapeMergeAction;
    procedure EscapePartialStatementContainers;
    procedure EscapeAnySelectionTarget;
    procedure EscapeJoinCondition;
    function FindValidBatchEnd: Boolean;
    function HasNonWhiteSpaceNonCommentContent(ContainerNode: IXMLNode): Boolean;
    function IsCommentOrWhiteSpace(TargetName: string): Boolean;
    function SaveNewElementAsPriorSibling(newElementName: string; newElementValue: string;
      nodeToSaveBefore: IXMLNode): IXMLNode;
  end;

function SelectNodes(const FocusNode: IXMLNode; const XPath: string): IXMLNodeList;
function SelectSingleNode(const FocusNode: IXMLNode; const XPath: string): IXMLNode;

implementation

uses
  SysUtils, Variants, SQLConstants, RegularExpressions, xmldom;

constructor TSQLParseTree.Create; //(RootName: string);
//var
//  NewRoot: IXMLNode;
begin
  FOwner := TComponent.Create(nil);
  inherited Create(FOwner);
  Options := [doNodeAutoCreate, doNodeAutoIndent, doAttrNull, doAutoPrefix, doNamespaceDecl];
  DOMVendor := GetDOMVendor('MSXML');
{  Active := True;
  NewRoot := CreateElement(RootName, '');
  SetDocumentElement(NewRoot); //appendChild(NewRoot);
  FCurrentContainer := NewRoot;  }
end;

destructor TSQLParseTree.Destroy;
begin
  FOwner.Free;
  inherited;
end;

function TSQLParseTree.GetCurrentContainer: IXMLNode;
begin
  Result := FCurrentContainer;
end;

function TSQLParseTree.GetNewStatementDue: Boolean;
begin
  Result := FNewStatementDue;
end;

procedure TSQLParseTree.SetCurrentContainer(Value: IXMLNode);
begin
  if Value = nil then
    raise Exception.Create('Value Null: CurrentContainer');
  //if Value.OwnerDocument. = Self then //(Self) = False then
  //  raise Exception.Create('Current Container node can only be set to an element in the current document.');
  FCurrentContainer := Value;
end;

procedure TSQLParseTree.SetNewStatementDue(Value: Boolean);
begin
  FNewStatementDue := Value;
end;

{function TSQLParseTree.ToXmlDoc: TXMLDocument;
begin
  Result := Self;
end; }

function TSQLParseTree.SaveNewElement(newElementName: string; NewElementValue: string): IXMLNode;
begin
  Result := SaveNewElement(newElementName, newElementValue, FCurrentContainer);
end;

function TSQLParseTree.SaveNewElement(NewElementName: string; NewElementValue: string;
  TargetNode: IXMLNode): IXMLNode;
begin
  //Result := CreateElement(NewElementName, '');
  //Result.NodeValue := NewElementValue;
 (* if Assigned(TargetNode) then
  begin
    Result := CreateNode(NewElementName);
   // Result := TargetNode.AddChild(NewElementName);
    Result.NodeValue := NewElementValue;
  end    *)
  // AppendChild(Result);
  Result := CreateElement(NewElementName, '');
  Result.NodeValue := NewElementValue;
  //Result.Text := newElementValue;
  TargetNode.ChildNodes.Add(Result);
end;

function TSQLParseTree.SaveNewElementAsPriorSibling(NewElementName: string; NewElementValue: string;
  NodeToSaveBefore: IXMLNode): IXMLNode;
begin
  //NewElement := CreateElement(NewElementName);
  //NewElement.NodeValue := NewElementValue;
  //Result := IXMLNode.Create(NewElementName, NewElementValue, NodeToSaveBefore.ParentNode);
  //NodeToSaveBefore.ParentNode.Nodes.Add(Result);
  Result := CreateElement(newElementName, '');
  Result.Text := newElementValue;
  NodeToSaveBefore.ParentNode.ChildNodes.Add(Result); // InsertBefore(newElement, nodeToSaveBefore);
end;

procedure TSQLParseTree.StartNewContainer(NewElementName: string; ContainerOpenValue: string;
  ContainerType: string);
var
  ContainerOpen: IXMLNode;
begin
  FCurrentContainer := SaveNewElement(NewElementName, '');
  ContainerOpen := SaveNewElement(SQLConstants.ENAME_CONTAINER_OPEN, '');
  SaveNewElement(SQLConstants.ENAME_OTHERKEYWORD, ContainerOpenValue, ContainerOpen);
  FCurrentContainer := SaveNewElement(ContainerType, '');
end;

procedure TSQLParseTree.StartNewStatement;
begin
  StartNewStatement(FCurrentContainer);
end;

procedure TSQLParseTree.StartNewStatement(TargetNode: IXMLNode);
var
  NewStatement: IXMLNode;
begin
  FNewStatementDue := False;
  NewStatement := SaveNewElement(SQLConstants.ENAME_SQL_STATEMENT, '', TargetNode);
  FCurrentContainer := SaveNewElement(SQLConstants.ENAME_SQL_CLAUSE, '', NewStatement);
end;

procedure TSQLParseTree.EscapeAnyBetweenConditions;
begin
  if (PathNameMatches(0, SQLConstants.ENAME_BETWEEN_UPPERBOUND) and PathNameMatches(1,
      SQLConstants.ENAME_BETWEEN_CONDITION)) then
    MoveToAncestorContainer(2);
end;

procedure TSQLParseTree.EscapeMergeAction;
begin
  if (((PathNameMatches(0, SQLConstants.ENAME_SQL_CLAUSE) and PathNameMatches(1,
      SQLConstants.ENAME_SQL_STATEMENT)) and PathNameMatches(2, SQLConstants.ENAME_MERGE_ACTION))
    and HasNonWhiteSpaceNonCommentContent(Self.CurrentContainer)) then
    MoveToAncestorContainer(4);
end;

procedure TSQLParseTree.EscapePartialStatementContainers;
begin
  if (PathNameMatches(0, SQLConstants.ENAME_DDL_PROCEDURAL_BLOCK) or PathNameMatches(0,
      SQLConstants.ENAME_DDL_OTHER_BLOCK)) then
    MoveToAncestorContainer(1)
  else
    if (PathNameMatches(0, SQLConstants.ENAME_CONTAINER_GENERALCONTENT) and
      PathNameMatches(1, SQLConstants.ENAME_CURSOR_FOR_OPTIONS)) then
      MoveToAncestorContainer(3)
    else
      if (PathNameMatches(0, SQLConstants.ENAME_CONTAINER_GENERALCONTENT)
        and PathNameMatches(1, SQLConstants.ENAME_PERMISSIONS_RECIPIENT)) then
        MoveToAncestorContainer(3)
      else
        if ((PathNameMatches(0, SQLConstants.ENAME_CONTAINER_GENERALCONTENT)
          and PathNameMatches(1, SQLConstants.ENAME_DDL_WITH_CLAUSE)) and
          ((PathNameMatches(2, SQLConstants.ENAME_PERMISSIONS_BLOCK) or PathNameMatches(2,
            SQLConstants.ENAME_DDL_PROCEDURAL_BLOCK)) or PathNameMatches(2,
            SQLConstants.ENAME_DDL_OTHER_BLOCK))) then
          MoveToAncestorContainer(3)
        else
          if PathNameMatches(0, SQLConstants.ENAME_MERGE_WHEN) then
            MoveToAncestorContainer(2)
          else
            if (PathNameMatches(0, SQLConstants.ENAME_CONTAINER_GENERALCONTENT)
              and PathNameMatches(1, SQLConstants.ENAME_CTE_WITH_CLAUSE)) then
              MoveToAncestorContainer(2);
end;

procedure TSQLParseTree.EscapeAnySingleOrPartialStatementContainers;
var
  CurrentSingleContainer: IXMLNode;
begin
  EscapeAnyBetweenConditions;
  EscapeAnySelectionTarget;
  EscapeJoinCondition;
  if HasNonWhiteSpaceNonCommentContent(Self.CurrentContainer) then
  begin
    EscapeCursorForBlock;
    EscapeMergeAction;
    EscapePartialStatementContainers;
    while True do
    begin
      if ((PathNameMatches(0, SQLConstants.ENAME_SQL_CLAUSE) and PathNameMatches(1,
          SQLConstants.ENAME_SQL_STATEMENT)) and PathNameMatches(2, SQLConstants.ENAME_CONTAINER_SINGLESTATEMENT)) then
      begin
        currentSingleContainer := Self.CurrentContainer.ParentNode.ParentNode;
        if PathNameMatches(currentSingleContainer, 1, SQLConstants.ENAME_ELSE_CLAUSE) then
          FCurrentContainer := (IXMLNode(currentSingleContainer.ParentNode.ParentNode.ParentNode))
        else
          FCurrentContainer := (IXMLNode(currentSingleContainer.ParentNode.ParentNode));
      end
      else
        break
      ;
    end;
  end;
end;

procedure TSQLParseTree.EscapeCursorForBlock;
begin
  if ((((PathNameMatches(0, SQLConstants.ENAME_SQL_CLAUSE) and PathNameMatches(1,
      SQLConstants.ENAME_SQL_STATEMENT)) and PathNameMatches(2, SQLConstants.ENAME_CONTAINER_GENERALCONTENT))
    and PathNameMatches(3, SQLConstants.ENAME_CURSOR_FOR_BLOCK)) and HasNonWhiteSpaceNonCommentContent(Self.CurrentContainer)) then
    MoveToAncestorContainer(5);
end;

function TSQLParseTree.EscapeAndLocateNextStatementContainer(escapeEmptyContainer: Boolean): IXMLNode;
begin
  EscapeAnySingleOrPartialStatementContainers;
  if (PathNameMatches(0, SQLConstants.ENAME_BOOLEAN_EXPRESSION) and (PathNameMatches(1,
      SQLConstants.ENAME_IF_STATEMENT) or PathNameMatches(1, SQLConstants.ENAME_WHILE_LOOP))) then
    begin
      Result := SaveNewElement(SQLConstants.ENAME_CONTAINER_SINGLESTATEMENT,
          '', (IXMLNode(FCurrentContainer.ParentNode)));
      Exit;
    end
  else
    if ((PathNameMatches(0, SQLConstants.ENAME_SQL_CLAUSE) and PathNameMatches(1,
        SQLConstants.ENAME_SQL_STATEMENT)) and (escapeEmptyContainer or HasNonWhiteSpaceNonSingleCommentContent(Self.CurrentContainer))) then
      begin
        Result := (IXMLNode(FCurrentContainer.ParentNode.ParentNode));
        Exit;
      end
    else
      begin
        Result := nil;
        Exit;
      end;
end;

procedure TSQLParseTree.MigrateApplicableCommentsFromContainer(PreviousContainerElement: IXMLNode);
var
  MovingNode: IXMLNode;
  InsertBeforeNode: IXMLNode;
  MigrationCandidate: IXMLNode;
  MigrationContext: IXMLNode;
  Regex: TRegEx;
begin
  Regex := TRegEx.Create('(\r|\n)+');
  MigrationContext := PreviousContainerElement; //.DOMNode;
  MigrationCandidate := PreviousContainerElement.ChildNodes.Last;
  InsertBeforeNode := CurrentContainer;
  while Assigned(MigrationCandidate) do
  begin
    if {(MigrationCandidate.NodeType = NODETYPE_WHITESPACE) or} (MigrationCandidate.NodeName = SQLConstants.ENAME_WHITESPACE) then
    begin
      MigrationCandidate := MigrationCandidate.PreviousSibling;
      Continue
    end
    else
    begin
      if Assigned(MigrationCandidate.PreviousSibling) and
        ((MigrationCandidate.NodeName = SQLConstants.ENAME_COMMENT_SINGLELINE) or
         (MigrationCandidate.NodeName = SQLConstants.ENAME_COMMENT_MULTILINE)) and
        ({(MigrationCandidate.PreviousSibling.NodeType = NODETYPE_WHITESPACE)
        or} (MigrationCandidate.PreviousSibling.NodeName = SQLConstants.ENAME_WHITESPACE)
        or (MigrationCandidate.PreviousSibling.NodeName = SQLConstants.ENAME_COMMENT_SINGLELINE)
        or (MigrationCandidate.PreviousSibling.NodeName = SQLConstants.ENAME_COMMENT_MULTILINE)) then
      begin
        if ({(MigrationCandidate.PreviousSibling.NodeType = NODETYPE_WHITESPACE) or
         } (MigrationCandidate.PreviousSibling.NodeName = SQLConstants.ENAME_WHITESPACE))
          and Regex.IsMatch(MigrationCandidate.PreviousSibling.NodeValue) then
        begin
          while MigrationContext.ChildNodes.Last <> MigrationCandidate do
          begin
            MovingNode := MigrationContext.ChildNodes.Last;
            FCurrentContainer.ParentNode.ChildNodes.Insert(FCurrentContainer.ParentNode.ChildNodes.IndexOf(MovingNode), InsertBeforeNode); // DOMNode.InsertBefore(MovingNode, InsertBeforeNode);
            InsertBeforeNode := MovingNode;
          end;
          FCurrentContainer.ParentNode.ChildNodes.Insert(FCurrentContainer.ParentNode.ChildNodes.IndexOf(MigrationCandidate), InsertBeforeNode); //DOMNode.InsertBefore(MigrationCandidate, insertBeforeNode);
          InsertBeforeNode := MigrationCandidate;
          MigrationCandidate := MigrationCandidate.ChildNodes.Last; // MigrationContext.LastChild;
        end
        else
          MigrationCandidate := MigrationCandidate.PreviousSibling
      end
      else
      begin
        if ((MigrationCandidate.NodeType = ntText) and (MigrationCandidate.NodeValue <> '')) then
          MigrationCandidate := nil
        else
        begin
          MigrationContext := MigrationCandidate;
          MigrationCandidate := MigrationCandidate.ChildNodes.Last;
        end;
      end;
    end;
  end;
end;

procedure TSQLParseTree.ConsiderStartingNewStatement;
var
  inBetweenContainerElement: IXMLNode;
  nextStatementContainer: IXMLNode;
  previousContainerElement: IXMLNode;
begin
  EscapeAnyBetweenConditions;
  EscapeAnySelectionTarget;
  EscapeJoinCondition;
  previousContainerElement := FCurrentContainer;
  nextStatementContainer := EscapeAndLocateNextStatementContainer(False);
  if (nextStatementContainer <> nil) then
  begin
    inBetweenContainerElement := FCurrentContainer;
    StartNewStatement(nextStatementContainer);
    if inBetweenContainerElement <> previousContainerElement then
      MigrateApplicableCommentsFromContainer(inBetweenContainerElement);
    MigrateApplicableCommentsFromContainer(previousContainerElement);
  end;
end;

procedure TSQLParseTree.ConsiderStartingNewClause;
var
  previousContainerElement: IXMLNode;
begin
  EscapeAnySelectionTarget;
  EscapeAnyBetweenConditions;
  EscapePartialStatementContainers;
  EscapeJoinCondition;
  if not Assigned(FCurrentContainer) then
    Exit;
  if (FCurrentContainer.NodeName = SQLConstants.ENAME_SQL_CLAUSE) and
    HasNonWhiteSpaceNonSingleCommentContent(FCurrentContainer) then
  begin
    previousContainerElement := FCurrentContainer;
    FCurrentContainer := SaveNewElement(SQLConstants.ENAME_SQL_CLAUSE,
        '', (IXMLNode(FCurrentContainer.ParentNode)));
    MigrateApplicableCommentsFromContainer(previousContainerElement);
  end
  else
    if (FCurrentContainer.NodeName = SQLConstants.ENAME_EXPRESSION_PARENS)
      or (FCurrentContainer.NodeName = SQLConstants.ENAME_SELECTIONTARGET_PARENS)
      or (FCurrentContainer.NodeName = SQLConstants.ENAME_SQL_STATEMENT)then
      FCurrentContainer := SaveNewElement(SQLConstants.ENAME_SQL_CLAUSE, '');
end;

procedure TSQLParseTree.EscapeAnySelectionTarget;
begin
  if PathNameMatches(0, SQLConstants.ENAME_SELECTIONTARGET) then
    FCurrentContainer := (IXMLNode(FCurrentContainer.ParentNode));
end;

procedure TSQLParseTree.EscapeJoinCondition;
begin
  if (PathNameMatches(0, SQLConstants.ENAME_CONTAINER_GENERALCONTENT) and
    PathNameMatches(1, SQLConstants.ENAME_JOIN_ON_SECTION)) then
    MoveToAncestorContainer(2);
end;

function TSQLParseTree.FindValidBatchEnd: Boolean;
var
  nextStatementContainer: IXMLNode;
begin
  nextStatementContainer := EscapeAndLocateNextStatementContainer(True);
  Result := ((nextStatementContainer <> nil) and (nextStatementContainer.NodeName = SQLConstants.ENAME_SQL_ROOT)
    or (nextStatementContainer.NodeName = SQLConstants.ENAME_CONTAINER_GENERALCONTENT)
    and (nextStatementContainer.ParentNode.NodeName = SQLConstants.ENAME_DDL_AS_BLOCK));
end;

function TSQLParseTree.PathNameMatches(levelsUp: Integer; nameToMatch: string): Boolean;
begin
  Result := PathNameMatches(FCurrentContainer, levelsUp, nameToMatch);
end;

function TSQLParseTree.PathNameMatches(TargetNode: IXMLNode; LevelsUp: Integer; NameToMatch: string): Boolean;
var
  CurrentNode: IXMLNode;
begin
  Result := False;
  if Assigned(TargetNode) then
  begin
    CurrentNode := TargetNode;
    while LevelsUp > 0 do
    begin
      CurrentNode := CurrentNode.ParentNode;
      Dec(LevelsUp);
    end;
    Result := CurrentNode.NodeName = NameToMatch;
  end;
end;

function TSQLParseTree.HasNonWhiteSpaceNonSingleCommentContent(ContainerNode: IXMLNode): Boolean;
var
  i: Integer;
  Regex: TRegEx;
  NodeList: IXMLNodeList;
  Node: IXMLNode;
begin
  Result := False;
  Regex := TRegex.Create('(\r|\n)+');

  NodeList := SelectNodes(ContainerNode, '*');
  for i := 0 to NodeList.Count - 1 do
  begin
    Node := NodeList[i];
    if (not (Node.NodeName = SQLConstants.ENAME_WHITESPACE) ) and
      (not (Node.NodeName = SQLConstants.ENAME_COMMENT_SINGLELINE) ) and
      ((not (Node.NodeName = SQLConstants.ENAME_COMMENT_MULTILINE)) or
      Regex.IsMatch(Node.NodeValue)) then
      begin
        Result := True;
        Exit;
      end;
  end;
  // todo: NodeList.SetLength(0); ??
end;

function TSQLParseTree.HasNonWhiteSpaceNonCommentContent(ContainerNode: IXMLNode): Boolean;
var
  i: Integer;
  NodeList: IXMLNodeList;
  Node: IXMLNode;
begin
  Result := False;
  if Assigned(ContainerNode) then
  begin
    NodeList := SelectNodes(ContainerNode, '*');
    for i := 0 to NodeList.Count - 1 do
    begin
      Node := NodeList[i];
      if not IsCommentOrWhiteSpace(Node.NodeName) then
      begin
        Result := True;
        Exit;
      end;
    end;
  end;
end;

function TSQLParseTree.IsCommentOrWhiteSpace(TargetName: string): Boolean;
begin
  Result := (TargetName = SQLConstants.ENAME_WHITESPACE) or
    (TargetName = SQLConstants.ENAME_COMMENT_SINGLELINE) or
    (TargetName = SQLConstants.ENAME_COMMENT_MULTILINE);
end;

function TSQLParseTree.GetFirstNonWhitespaceNonCommentChildElement(TargetElement: IXMLNode): IXMLNode;
var
  CurrentNode: IXMLNode;
begin
  Result := nil;
  if Assigned(TargetElement) then
    if TargetElement.HasChildNodes then
    begin
      CurrentNode := TargetElement.ChildNodes.First;
      while Assigned(CurrentNode) do
      begin
        if (currentNode.NodeType <> ntElement) or IsCommentOrWhiteSpace(CurrentNode.NodeName) then
          CurrentNode := CurrentNode.NextSibling
        else
        begin
          Result := CurrentNode;
          Exit;
        end;
      end;
    end;
end;

procedure TSQLParseTree.MoveToAncestorContainer(levelsUp: Integer);
begin
  MoveToAncestorContainer(levelsUp);
end;

procedure TSQLParseTree.MoveToAncestorContainer(LevelsUp: Integer; TargetContainerName: string);
var
  CandidateContainer: IXMLNode;
begin
  CandidateContainer := FCurrentContainer;
  while LevelsUp > 0 do
  begin
    CandidateContainer := IXMLNode(candidateContainer.ParentNode);
    Dec(LevelsUp);
  end;
  if (TargetContainerName = '') or (CandidateContainer.NodeName = TargetContainerName) then
    FCurrentContainer := CandidateContainer
  else
    raise Exception.Create('Ancestor node does not match expected name!');
end;

function TSQLParseTree.SaveNewElementWithError(NewElementName: string; NewElementValue: string): IXMLNode;
var
  NewElement: IXMLNode;
begin
  NewElement := SaveNewElement(newElementName, NewElementValue);
  ErrorFound := True;
  Result := NewElement;
end;

function TSQLParseTree.GetErrorFound: Boolean;
begin
  Result := FNewStatementDue;
end;

procedure TSQLParseTree.SetErrorFound(Value: Boolean);
var
  Node: IXMLNode;
begin
  Node := DocumentElement.AttributeNodes.FindNode(SQLConstants.ANAME_ERRORFOUND);
  if Value then
    Node.NodeValue := '1'
  else
  if Assigned(Node) then
    DocumentElement.AttributeNodes.Remove(Node);
end;

function SelectNodes(const FocusNode: IXMLNode; const XPath: string): IXMLNodeList;
var
  DomNodeSelect: IDomNodeSelect;
  //DOMNode: IDomNode;
//  DocAccess: IXmlDocumentAccess;
 // Doc: TXmlDocument;
  DOMNodes: IDOMNodeList;
  i: integer;
begin
  Result := TXMLNodeList.Create(TXMLNode(FocusNode), '', nil);
  if Assigned(FocusNode) and Supports(FocusNode.DOMNode, IDomNodeSelect, DomNodeSelect) then
    DOMNodes := DomNodeSelect.SelectNodes(XPath);
  if not Assigned(DOMNodes) then
    Exit;

  //Doc := TXMLDocument(FocusNode.OwnerDocument);
//SetLength( result, DOMNodes.Length);
  for i := 0 to DOMNodes.Length - 1 do
  begin
    //Doc := nil;
    //DOMNode := DOMNodes.Item[i];
    //if Supports(DOMNode, IXmlDocumentAccess, DocAccess) then
    //  Doc := DocAccess.DocumentObject;
    //Result.
    Result.Add(IXMLNode(TXMLNode.Create(DOMNodes.Item[i], nil, TXMLDocument(FocusNode.OwnerDocument))));
  end
end;

function SelectSingleNode(const FocusNode: IXMLNode; const XPath: string): IXMLNode;
var
  DomNodeSelect: IDomNodeSelect;
  DOMNode: IDomNode;
  DocAccess: IXmlDocumentAccess;
  Doc: TXmlDocument;
begin
  Result := nil;
  Doc := nil;
  if Assigned(FocusNode) and Supports(FocusNode.DOMNode, IDomNodeSelect, DomNodeSelect) then
    DOMNode := DomNodeSelect.SelectNode(XPath);
  if Assigned(DOMNode) and Supports(DOMNode.OwnerDocument, IXmlDocumentAccess, DocAccess) then
    Doc := DocAccess.DocumentObject;
  if Assigned(DOMNode) then
    Result := TXMLNode.Create(DOMNode, nil, Doc);
end;

end.
