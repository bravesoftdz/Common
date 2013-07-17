unit BCSQL.ParseTree;

interface

uses
  System.SysUtils, OmniXML;

type
  { Note! For some reason TXMLNode in OmniXML does not add and release ref. This causes problems
    because the TXMLDocument will be destroyed as soon as possible.

    Fix this by adding _AddRef to TXMLNode.Create and _Release to TXMLNode.Free.  }
  TSQLParseTree = class(TXMLDocument)
  private
    FCurrentContainer: IXMLElement;
    FNewStatementDue: Boolean;
    procedure SetCurrentContainer(Value: IXMLElement);
    function HasNonWhiteSpaceNonSingleCommentContent(ContainerNode: IXMLElement): Boolean;
    procedure MigrateApplicableCommentsFromContainer(PreviousContainerElement: IXMLElement);
    procedure EscapeCursorForBlock;
    procedure SetErrorFound(Value: Boolean);
    function EscapeAndLocateNextStatementContainer(EscapeEmptyContainer: Boolean): IXMLElement;
  public
    constructor Create(RootName: string); reintroduce; overload;
    procedure StartNewStatement; overload;
    procedure StartNewStatement(TargetNode: IXMLElement); overload;
    function SaveNewElement(NewElementName: string; NewElementValue: string): IXMLElement; overload;
    function SaveNewElement(NewElementName: string; NewElementValue: string; TargetNode: IXMLElement): IXMLElement; overload;
    function GetFirstNonWhitespaceNonCommentChildElement(TargetElement: IXMLNode): IXMLElement;
    procedure ConsiderStartingNewClause;
    function IsCommentOrWhiteSpace(TargetNodeName: string): Boolean;
    procedure EscapeAnySingleOrPartialStatementContainers;
    procedure MoveToAncestorContainer(LevelsUp: Integer); overload;
    procedure MoveToAncestorContainer(LevelsUp: Integer; TargetContainerName: string); overload;
    function PathNameMatches(TargetNode: IXMLNode; LevelsUp: Integer; NameToMatch: string): Boolean; overload;
    function PathNameMatches(LevelsUp: Integer; NameToMatch: string): Boolean; overload;
    function SaveNewElementWithError(NewElementName: string; NewElementValue: string): IXMLElement;
    function SaveNewElementAsPriorSibling(NewElementName: string; NewElementValue: string; NodeToSaveBefore: IXMLElement): IXMLElement;
    procedure StartNewContainer(NewElementName: string; ContainerOpenValue: string; ContainerType: string);
    procedure ConsiderStartingNewStatement;
    procedure EscapeAnyBetweenConditions;
    procedure EscapeAnySelectionTarget;
    procedure EscapeJoinCondition;
    procedure EscapeMergeAction;
    procedure EscapePartialStatementContainers;
    function FindValidBatchEnd: Boolean;
    function HasNonWhiteSpaceNonCommentContent(ContainerNode: IXMLElement): Boolean;
    procedure SetError;
    property CurrentContainer: IXMLElement read FCurrentContainer write SetCurrentContainer;
    property NewStatementDue: Boolean read FNewStatementDue write FNewStatementDue;
    property ErrorFound: Boolean read FNewStatementDue write SetErrorFound;
  end;

implementation

uses
  BCSQL.XMLConstants, System.RegularExpressions;

constructor TSQLParseTree.Create(RootName: string);
var
  NewRoot: IXMLElement;
begin
  inherited Create;

  NewRoot := CreateElement(RootName);
  AppendChild(NewRoot);
  CurrentContainer := NewRoot;
end;

procedure TSQLParseTree.SetCurrentContainer(Value: IXMLElement);
begin
  if not Assigned(Value) then
    raise Exception.Create('SetCurrentContainer: value not assigned.');

  FCurrentContainer := Value;
end;

procedure TSQLParseTree.StartNewStatement;
begin
  StartNewStatement(CurrentContainer);
end;

procedure TSQLParseTree.StartNewStatement(TargetNode: IXMLElement);
var
  NewStatement: IXMLElement;
begin
  NewStatementDue := False;
  NewStatement := SaveNewElement(BCSQL.XMLConstants.XML_SQL_STATEMENT, '', TargetNode);
  CurrentContainer := SaveNewElement(BCSQL.XMLConstants.XML_SQL_CLAUSE, '', NewStatement);
end;

function TSQLParseTree.SaveNewElement(NewElementName: string; NewElementValue: string): IXMLElement;
begin
  Result := SaveNewElement(newElementName, newElementValue, CurrentContainer);
end;

function TSQLParseTree.SaveNewElement(NewElementName: string; NewElementValue: string; TargetNode: IXMLElement): IXMLElement;
var
  NewElement: IXMLElement;
begin
  NewElement := CreateElement(NewElementName);
  NewElement.Text := NewElementValue;
  TargetNode.AppendChild(NewElement);
  Result := NewElement;
end;

function TSQLParseTree.SaveNewElementAsPriorSibling(NewElementName: string; NewElementValue: string; NodeToSaveBefore: IXMLElement): IXMLElement;
begin
  Result := CreateElement(newElementName);
  Result.Text := NewElementValue;
  NodeToSaveBefore.ParentNode.InsertBefore(Result, NodeToSaveBefore);
end;

function TSQLParseTree.IsCommentOrWhiteSpace(TargetNodeName: string): Boolean;
begin
  Result := (TargetNodeName = BCSQL.XMLConstants.XML_WHITESPACE) or
            (TargetNodeName = BCSQL.XMLConstants.XML_COMMENT_SINGLELINE) or
            (TargetNodeName = BCSQL.XMLConstants.XML_COMMENT_MULTILINE);
end;

function TSQLParseTree.GetFirstNonWhitespaceNonCommentChildElement(TargetElement: IXMLNode): IXMLElement;
var
  CurrentNode: IXMLNode;
begin
  Result := nil;
  CurrentNode := TargetElement.FirstChild;
  while Assigned(CurrentNode) do
  begin
    if (CurrentNode.NodeType <> ELEMENT_NODE) or IsCommentOrWhiteSpace(CurrentNode.NodeName) then
      CurrentNode := CurrentNode.NextSibling
    else
    begin
      Result := IXMLElement(CurrentNode);
      Break;
    end;
  end;
end;

function TSQLParseTree.PathNameMatches(TargetNode: IXMLNode; LevelsUp: Integer; NameToMatch: string): Boolean;
var
  CurrentNode: IXMLNode;
begin
  CurrentNode := TargetNode;
  while LevelsUp > 0 do
  begin
    CurrentNode := CurrentNode.ParentNode;
    Dec(LevelsUp);
  end;
  Result := CurrentNode.NodeName = NameToMatch;
end;

function TSQLParseTree.PathNameMatches(LevelsUp: Integer; NameToMatch: string): Boolean;
begin
  Result := PathNameMatches(CurrentContainer, levelsUp, nameToMatch);
end;


procedure TSQLParseTree.EscapeAnySelectionTarget;
begin
  if PathNameMatches(0, BCSQL.XMLConstants.XML_SELECTIONTARGET) then
    CurrentContainer := IXMLElement(CurrentContainer.ParentNode);
end;

procedure TSQLParseTree.EscapeAnyBetweenConditions;
begin
  if PathNameMatches(0, BCSQL.XMLConstants.XML_BETWEEN_UPPERBOUND) and
    PathNameMatches(1, BCSQL.XMLConstants.XML_BETWEEN_CONDITION) then
    //we just ended the upper bound of a "BETWEEN" condition, need to pop back to the enclosing context
    MoveToAncestorContainer(2);
end;

procedure TSQLParseTree.EscapePartialStatementContainers;
begin
  if PathNameMatches(0, BCSQL.XMLConstants.XML_DDL_PROCEDURAL_BLOCK) or
    PathNameMatches(0, BCSQL.XMLConstants.XML_DDL_OTHER_BLOCK) or
    PathNameMatches(0, BCSQL.XMLConstants.XML_DDL_DECLARE_BLOCK) then
    MoveToAncestorContainer(1)
  else
  if PathNameMatches(0, BCSQL.XMLConstants.XML_CONTAINER_GENERALCONTENT) and
    PathNameMatches(1, BCSQL.XMLConstants.XML_CURSOR_FOR_OPTIONS) then
    MoveToAncestorContainer(3)
  else
  if PathNameMatches(0, BCSQL.XMLConstants.XML_CONTAINER_GENERALCONTENT) and
    PathNameMatches(1, BCSQL.XMLConstants.XML_PERMISSIONS_RECIPIENT) then
    MoveToAncestorContainer(3)
  else
  if PathNameMatches(0, BCSQL.XMLConstants.XML_CONTAINER_GENERALCONTENT) and
    PathNameMatches(1, BCSQL.XMLConstants.XML_DDL_WITH_CLAUSE) and
    (PathNameMatches(2, BCSQL.XMLConstants.XML_PERMISSIONS_BLOCK) or
     PathNameMatches(2, BCSQL.XMLConstants.XML_DDL_PROCEDURAL_BLOCK) or
     PathNameMatches(2, BCSQL.XMLConstants.XML_DDL_OTHER_BLOCK) or
     PathNameMatches(2, BCSQL.XMLConstants.XML_DDL_DECLARE_BLOCK)) then
    MoveToAncestorContainer(3)
  else
  if PathNameMatches(0, BCSQL.XMLConstants.XML_MERGE_WHEN) then
    MoveToAncestorContainer(2)
  else
  if PathNameMatches(0, BCSQL.XMLConstants.XML_CONTAINER_GENERALCONTENT) and
    (PathNameMatches(1, BCSQL.XMLConstants.XML_CTE_WITH_CLAUSE) or
     PathNameMatches(1, BCSQL.XMLConstants.XML_DDL_DECLARE_BLOCK)) then
    MoveToAncestorContainer(2);
end;

procedure TSQLParseTree.MoveToAncestorContainer(LevelsUp: Integer);
begin
  MoveToAncestorContainer(LevelsUp, '');
end;

procedure TSQLParseTree.MoveToAncestorContainer(LevelsUp: Integer; TargetContainerName: string);
var
  CandidateContainer: IXMLElement;
begin
  CandidateContainer := CurrentContainer;
  while LevelsUp > 0 do
  begin
    CandidateContainer := IXMLElement(CandidateContainer.ParentNode);
    Dec(LevelsUp);
  end;

  if (TargetContainerName = '') or (CandidateContainer.NodeName = TargetContainerName) then
    CurrentContainer := CandidateContainer
  else
   raise Exception.Create('Ancestor node does not match expected name!');
end;

procedure TSQLParseTree.EscapeJoinCondition;
begin
  if PathNameMatches(0, BCSQL.XMLConstants.XML_CONTAINER_GENERALCONTENT) and
    PathNameMatches(1, BCSQL.XMLConstants.XML_JOIN_ON_SECTION) then
    MoveToAncestorContainer(2);
end;

function TSQLParseTree.HasNonWhiteSpaceNonSingleCommentContent(ContainerNode: IXMLElement): Boolean;
var
  i: Integer;
  Regex: TRegEx;
  XMLNodeList: IXMLNodeList;
begin
  Result := False;
  Regex := TRegex.Create('(\r|\n)+');

  ContainerNode.SelectNodes('*', XMLNodeList);
  for i := 0 to XMLNodeList.Count - 1 do
    if (XMLNodeList.Item[i].NodeName <> BCSQL.XMLConstants.XML_WHITESPACE) and
       (XMLNodeList.Item[i].NodeName <> BCSQL.XMLConstants.XML_COMMENT_SINGLELINE) and
       ( (XMLNodeList.Item[i].NodeName <> BCSQL.XMLConstants.XML_COMMENT_MULTILINE) or
         Regex.IsMatch(XMLNodeList.Item[i].Text) ) then
    begin
      Result := True;
      Break;
    end;
end;

procedure TSQLParseTree.MigrateApplicableCommentsFromContainer(PreviousContainerElement: IXMLElement);
var
  MigrationContext, MigrationCandidate: IXMLNode;
  InsertBeforeNode, MovingNode: IXMLElement;
  Regex: TRegEx;
begin
  MigrationContext := PreviousContainerElement;
  MigrationCandidate := PreviousContainerElement.LastChild;
  Regex := TRegex.Create('(\r|\n)+');

  //keep track of where we're going to be prepending - this will change as we go moving stuff.
  InsertBeforeNode := CurrentContainer;

  while Assigned(MigrationCandidate) do
  begin
    if //(MigrationCandidate.NodeType = XmlNodeType.Whitespace
       MigrationCandidate.NodeName = BCSQL.XMLConstants.XML_WHITESPACE then
    begin
      MigrationCandidate := MigrationCandidate.PreviousSibling;
      Continue;
    end
    else
    if Assigned(MigrationCandidate.PreviousSibling) and
      ( (MigrationCandidate.NodeName = BCSQL.XMLConstants.XML_COMMENT_SINGLELINE) or
        (MigrationCandidate.NodeName = BCSQL.XMLConstants.XML_COMMENT_MULTILINE) ) and
      ( //(MigrationCandidate.PreviousSibling.NodeType = XmlNodeType.Whitespace)
        (MigrationCandidate.PreviousSibling.NodeName = BCSQL.XMLConstants.XML_WHITESPACE) or
        (MigrationCandidate.PreviousSibling.NodeName = BCSQL.XMLConstants.XML_COMMENT_SINGLELINE) or
        (MigrationCandidate.PreviousSibling.NodeName = BCSQL.XMLConstants.XML_COMMENT_MULTILINE) ) then
    begin
      if //(migrationCandidate.PreviousSibling.NodeType == XmlNodeType.Whitespace or
        (MigrationCandidate.PreviousSibling.NodeName = BCSQL.XMLConstants.XML_WHITESPACE) and
        Regex.IsMatch(MigrationCandidate.PreviousSibling.Text) then
      begin
        //we have a match, so migrate everything considered so far (backwards from the end). need to keep track of where we're inserting.
        while migrationContext.LastChild <> MigrationCandidate do
        begin
          MovingNode := IXMLElement(MigrationContext.LastChild);
          CurrentContainer.ParentNode.InsertBefore(MovingNode, InsertBeforeNode);
          InsertBeforeNode := MovingNode;
        end;
        CurrentContainer.ParentNode.InsertBefore(MigrationCandidate, InsertBeforeNode);
        InsertBeforeNode := IXMLElement(MigrationCandidate);

        //move on to the next candidate element for consideration.
        MigrationCandidate := MigrationContext.LastChild;
      end
      else
        //this one wasn't properly separated from the previous node/entry, keep going in case there's a linebreak further up.
        MigrationCandidate := MigrationCandidate.PreviousSibling;
    end
    else
    if (migrationCandidate.NodeType = TEXT_NODE) and (MigrationCandidate.Text <> '') then
    begin
      //we found a non-whitespace non-comment node with text content. Stop trying to migrate comments.
      MigrationCandidate := nil;
    end
    else
    begin
      //walk up the last found node, in case the comment got trapped in some substructure.
      MigrationContext := MigrationCandidate;
      MigrationCandidate := MigrationCandidate.LastChild;
    end;
  end;
end;

procedure TSQLParseTree.ConsiderStartingNewClause;
var
  PreviousContainerElement: IXMLElement;
begin
  EscapeAnySelectionTarget;
  EscapeAnyBetweenConditions;
  EscapePartialStatementContainers;
  EscapeJoinCondition;

  if (CurrentContainer.NodeName = BCSQL.XMLConstants.XML_SQL_CLAUSE) and
    HasNonWhiteSpaceNonSingleCommentContent(CurrentContainer) then
  begin
    //complete current clause, start a new one in the same container
    PreviousContainerElement := CurrentContainer;
    CurrentContainer := SaveNewElement(BCSQL.XMLConstants.XML_SQL_CLAUSE, '', IXMLElement(CurrentContainer.ParentNode));
    MigrateApplicableCommentsFromContainer(PreviousContainerElement);
  end
  else
  if (CurrentContainer.NodeName = BCSQL.XMLConstants.XML_EXPRESSION_PARENS) or
    (CurrentContainer.NodeName = BCSQL.XMLConstants.XML_SELECTIONTARGET_PARENS) or
    (CurrentContainer.NodeName = BCSQL.XMLConstants.XML_SQL_STATEMENT) then
    //create new clause and set context to it.
    CurrentContainer := SaveNewElement(BCSQL.XMLConstants.XML_SQL_CLAUSE, '');
end;

function TSQLParseTree.HasNonWhiteSpaceNonCommentContent(ContainerNode: IXMLElement): Boolean;
var
  i: Integer;
  XMLNodeList: IXMLNodeList;
begin
  Result := False;
  ContainerNode.SelectNodes('*', XMLNodeList);

  for i := 0 to XMLNodeList.Count - 1 do
  if not IsCommentOrWhiteSpace(XMLNodeList.Item[i].NodeName) then
  begin
    Result := True;
    Break;
  end;
end;

procedure TSQLParseTree.EscapeCursorForBlock;
begin
  if PathNameMatches(0, BCSQL.XMLConstants.XML_SQL_CLAUSE) and
     PathNameMatches(1, BCSQL.XMLConstants.XML_SQL_STATEMENT) and
     PathNameMatches(2, BCSQL.XMLConstants.XML_CONTAINER_GENERALCONTENT) and
     PathNameMatches(3, BCSQL.XMLConstants.XML_CURSOR_FOR_BLOCK) and
     HasNonWhiteSpaceNonCommentContent(CurrentContainer) then
      //we just ended the one select statement in a cursor declaration, and need to pop out to the same level as the cursor
      MoveToAncestorContainer(5);
end;

procedure TSQLParseTree.EscapeMergeAction;
begin
  if PathNameMatches(0, BCSQL.XMLConstants.XML_SQL_CLAUSE) and
    PathNameMatches(1, BCSQL.XMLConstants.XML_SQL_STATEMENT) and
    PathNameMatches(2, BCSQL.XMLConstants.XML_MERGE_ACTION) and
    HasNonWhiteSpaceNonCommentContent(CurrentContainer) then
    MoveToAncestorContainer(4);
end;

procedure TSQLParseTree.EscapeAnySingleOrPartialStatementContainers;
var
  CurrentSingleContainer: IXMLNode;
begin
  EscapeAnyBetweenConditions;
  EscapeAnySelectionTarget;
  EscapeJoinCondition;

  if HasNonWhiteSpaceNonCommentContent(CurrentContainer) then
  begin
    EscapeCursorForBlock;
    EscapeMergeAction;
    EscapePartialStatementContainers;

    while True do
    begin
      if PathNameMatches(0, BCSQL.XMLConstants.XML_SQL_CLAUSE) and
         PathNameMatches(1, BCSQL.XMLConstants.XML_SQL_STATEMENT) and
         PathNameMatches(2, BCSQL.XMLConstants.XML_CONTAINER_SINGLESTATEMENT) then
      begin
        CurrentSingleContainer := CurrentContainer.ParentNode.ParentNode;
        if PathNameMatches(CurrentSingleContainer, 1, BCSQL.XMLConstants.XML_ELSE_CLAUSE) then
        //we just ended the one and only statement in an else clause, and need to pop out to the same level as its parent if
        // singleContainer.else.if.CANDIDATE
          CurrentContainer := IXMLElement(CurrentSingleContainer.ParentNode.ParentNode.ParentNode)
        else
        //we just ended the one statement of an if or while, and need to pop out the same level as that if or while
        // singleContainer.(if or while).CANDIDATE
          CurrentContainer := IXMLElement(CurrentSingleContainer.ParentNode.ParentNode)
      end
      else
        Break;
    end;
  end;
end;

function TSQLParseTree.SaveNewElementWithError(NewElementName: string; NewElementValue: string): IXMLElement;
begin
  Result := SaveNewElement(NewElementName, NewElementValue);
  SetError;
end;

procedure TSQLParseTree.SetError;
begin
  CurrentContainer.SetAttribute(BCSQL.XMLConstants.XML_HASERROR, '1');
  ErrorFound := True;
end;

procedure TSQLParseTree.SetErrorFound(Value: Boolean);
begin
  if Value then
    DocumentElement.SetAttribute(BCSQL.XMLConstants.XML_ERRORFOUND, '1')
  else
    DocumentElement.RemoveAttribute(BCSQL.XMLConstants.XML_ERRORFOUND);
end;

procedure TSQLParseTree.StartNewContainer(NewElementName: string; ContainerOpenValue: string; ContainerType: string);
var
  ContainerOpen: IXMLElement;
begin
  CurrentContainer := SaveNewElement(newElementName, '');
  ContainerOpen := SaveNewElement(BCSQL.XMLConstants.XML_CONTAINER_OPEN, '');
  SaveNewElement(BCSQL.XMLConstants.XML_OTHERKEYWORD, ContainerOpenValue, ContainerOpen);
  CurrentContainer := SaveNewElement(containerType, '');
end;

function TSQLParseTree.EscapeAndLocateNextStatementContainer(EscapeEmptyContainer: Boolean): IXMLElement;
begin
  EscapeAnySingleOrPartialStatementContainers;

  if PathNameMatches(0, BCSQL.XMLConstants.XML_BOOLEAN_EXPRESSION) and
    (PathNameMatches(1, BCSQL.XMLConstants.XML_IF_STATEMENT) or PathNameMatches(1, BCSQL.XMLConstants.XML_WHILE_LOOP)) then
    //we just ended the boolean clause of an if or while, and need to pop to the single-statement container.
    Result := SaveNewElement(BCSQL.XMLConstants.XML_CONTAINER_SINGLESTATEMENT, '', IXMLElement(CurrentContainer.ParentNode))
  else
  if PathNameMatches(0, BCSQL.XMLConstants.XML_SQL_CLAUSE) and
     PathNameMatches(1, BCSQL.XMLConstants.XML_SQL_STATEMENT) and
     (EscapeEmptyContainer or HasNonWhiteSpaceNonSingleCommentContent(CurrentContainer)) then
    Result := IXMLElement(CurrentContainer.ParentNode.ParentNode)
  else
    Result := nil;
end;

procedure TSQLParseTree.ConsiderStartingNewStatement;
var
  PreviousContainerElement, NextStatementContainer, InBetweenContainerElement: IXMLElement;
begin
  EscapeAnyBetweenConditions;
  EscapeAnySelectionTarget;
  EscapeJoinCondition;

  //before single-statement-escaping
  PreviousContainerElement := CurrentContainer;

  //context might change AND suitable ancestor selected
  NextStatementContainer := EscapeAndLocateNextStatementContainer(False);

  //if suitable ancestor found, start statement and migrate in-between comments to the new statement
  if Assigned(NextStatementContainer) then
  begin
    InBetweenContainerElement := CurrentContainer;
    StartNewStatement(NextStatementContainer);
    if InBetweenContainerElement <> PreviousContainerElement then
      MigrateApplicableCommentsFromContainer(inBetweenContainerElement);
    MigrateApplicableCommentsFromContainer(previousContainerElement);
  end;
end;

function TSQLParseTree.FindValidBatchEnd: Boolean;
var
  NextStatementContainer: IXMLElement;
begin
  NextStatementContainer := EscapeAndLocateNextStatementContainer(True);
  Result := Assigned(NextStatementContainer) and (
    (NextStatementContainer.NodeName = BCSQL.XMLConstants.XML_SQL_ROOT) or
    ( (NextStatementContainer.NodeName = BCSQL.XMLConstants.XML_CONTAINER_GENERALCONTENT) and
      (NextStatementContainer.ParentNode.NodeName = BCSQL.XMLConstants.XML_DDL_AS_BLOCK) ) );
end;

end.
