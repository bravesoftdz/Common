unit BCFrames.OptionsToolBar;

interface

uses
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, BCControls.CheckBox,
  BCCommon.OptionsContainer, BCFrames.OptionsFrame, Vcl.ComCtrls, Vcl.ImgList, Vcl.ToolWin, BCControls.ToolBar,
  System.Actions, Vcl.ActnList, System.Generics.Collections, System.Types, VirtualTrees, Winapi.ActiveX, Vcl.Menus,
  BCCommon.Images;

type
  TOptionsToolBarFrame = class(TOptionsFrame)
    Panel: TPanel;
    MenuActionList: TActionList;
    AddItemAction: TAction;
    DeleteAction: TAction;
    AddDividerAction: TAction;
    VirtualDrawTree: TVirtualDrawTree;
    PopupMenu: TPopupMenu;
    Additem1: TMenuItem;
    DeleteItem1: TMenuItem;
    AddDivider1: TMenuItem;
    ResetAction: TAction;
    N1: TMenuItem;
    Reset1: TMenuItem;
    procedure VirtualDrawTreeDrawNode(Sender: TBaseVirtualTree; const PaintInfo: TVTPaintInfo);
    procedure VirtualDrawTreeGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind;
      Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: Integer);
    procedure VirtualDrawTreeGetNodeWidth(Sender: TBaseVirtualTree; HintCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; var NodeWidth: Integer);
    procedure VirtualDrawTreeFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure VirtualDrawTreeDragAllowed(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
      var Allowed: Boolean);
    procedure VirtualDrawTreeDragOver(Sender: TBaseVirtualTree; Source: TObject; Shift: TShiftState; State: TDragState;
      Pt: TPoint; Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
    procedure VirtualDrawTreeDragDrop(Sender: TBaseVirtualTree; Source: TObject; DataObject: IDataObject;
      Formats: TFormatArray; Shift: TShiftState; Pt: TPoint; var Effect: Integer; Mode: TDropMode);
    procedure AddItemActionExecute(Sender: TObject);
    procedure DeleteActionExecute(Sender: TObject);
    procedure AddDividerActionExecute(Sender: TObject);
    procedure ResetActionExecute(Sender: TObject);
  private
    { Private declarations }
    FActionList: TObjectList<TAction>;
    FIsChanged: Boolean;
    function FindItemByName(ItemName: string): TAction;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure GetToolBarItems;
    procedure PutData; override;
    property ActionList: TObjectList<TAction> read FActionList write FActionList;
  end;

  PTreeData = ^TTreeData;
  TTreeData = record
    Action: TAction;
  end;

function OptionsToolBarFrame(AOwner: TComponent; ActionList: TObjectList<TAction>): TOptionsToolBarFrame;

implementation

{$R *.dfm}

uses
  Winapi.Windows, Winapi.CommCtrl, BigIni, BCCommon.FileUtils, Vcl.Themes, BCDialogs.OptionsToolBarItems,
  System.SysUtils, BCCommon.Lib;

var
  FOptionsToolBarFrame: TOptionsToolBarFrame;

function OptionsToolBarFrame(AOwner: TComponent; ActionList: TObjectList<TAction>): TOptionsToolBarFrame;
begin
  if not Assigned(FOptionsToolBarFrame) then
    FOptionsToolBarFrame := TOptionsToolBarFrame.Create(AOwner);

  FOptionsToolBarFrame.VirtualDrawTree.NodeDataSize := SizeOf(TTreeData);
  FOptionsToolBarFrame.VirtualDrawTree.Images := ImagesDataModule.ImageList; { IDE can lose this }
  FOptionsToolBarFrame.ActionList := ActionList;
  FOptionsToolBarFrame.GetToolBarItems;

  Result := FOptionsToolBarFrame;
end;

constructor TOptionsToolBarFrame.Create(AOwner: TComponent);
begin
  inherited;
  { IDE is losing these }
  MenuActionList.Images := ImagesDataModule.ImageList;
  PopupMenu.Images := ImagesDataModule.ImageList;
  VirtualDrawTree.Images := ImagesDataModule.ImageList;
end;

procedure TOptionsToolBarFrame.AddDividerActionExecute(Sender: TObject);
var
  NewNode, CurrentNode: PVirtualNode;
  NewData: PTreeData;
begin
  inherited;
  CurrentNode := VirtualDrawTree.GetFirstSelected;
  if Assigned(CurrentNode) then
    NewNode := VirtualDrawTree.InsertNode(CurrentNode, amInsertAfter)
  else
    NewNode := VirtualDrawTree.AddChild(nil);
  NewData := VirtualDrawTree.GetNodeData(NewNode);
  NewData^.Action := TAction.Create(nil);
  NewData^.Action.Caption := '-';
  FIsChanged := True;
end;

procedure TOptionsToolBarFrame.AddItemActionExecute(Sender: TObject);
var
  Node, NewNode, CurrentNode: PVirtualNode;
  Data, NewData: PTreeData;
begin
  inherited;
   with OptionsToolBarItemsDialog(ActionList) do
   try
     if Open then
     begin
       { insert selected items }
       Node := AddItemsVirtualDrawTree.GetFirst;
       while Assigned(Node) do
       begin
         if Node.CheckState = csCheckedNormal then
         begin
           Data := AddItemsVirtualDrawTree.GetNodeData(Node);
           CurrentNode := VirtualDrawTree.GetFirstSelected;
           if Assigned(CurrentNode) then
             NewNode := VirtualDrawTree.InsertNode(CurrentNode, amInsertAfter)
           else
             NewNode := VirtualDrawTree.AddChild(nil);
           NewData := VirtualDrawTree.GetNodeData(NewNode);
           NewData^.Action := Data^.Action;
           NewData^.Action.Tag := 1;
           VirtualDrawTree.Selected[NewNode] := True;
           FIsChanged := True;
         end;
         Node := AddItemsVirtualDrawTree.GetNext(Node);
       end;
     end;
   finally
     Free;
   end;
end;

procedure TOptionsToolBarFrame.DeleteActionExecute(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PTreeData;
begin
  inherited;
  Node := VirtualDrawTree.GetFirstSelected;
  Data := VirtualDrawTree.GetNodeData(Node);
  Data^.Action.Tag := 0;
  VirtualDrawTree.DeleteNode(Node);
  FIsChanged := True;
end;

destructor TOptionsToolBarFrame.Destroy;
begin
  inherited;
  FOptionsToolBarFrame := nil;
end;

function TOptionsToolBarFrame.FindItemByName(ItemName: string): TAction;
begin
  Result := nil;
  if Assigned(FActionList) then
  for Result in FActionList do
    if Result.Name = ItemName then
      Exit;
end;

procedure TOptionsToolBarFrame.GetToolBarItems;
var
  i: Integer;
  s: string;
  ToolBarItems: TStrings;
  Action: TAction;
  Node: PVirtualNode;
  Data: PTreeData;
begin
  { read from ini }
  ToolBarItems := TStringList.Create;
  with TBigIniFile.Create(GetIniFilename) do
  try
    { read items from ini }
    ReadSectionValues('ToolBarItems', ToolBarItems);
    { add items to action bar }
    VirtualDrawTree.BeginUpdate;
    VirtualDrawTree.Clear;
    for i := 0 to ToolBarItems.Count - 1 do
    begin
      Node := VirtualDrawTree.AddChild(nil);
      Data := VirtualDrawTree.GetNodeData(Node);

      s := System.Copy(ToolBarItems.Strings[i], Pos('=', ToolBarItems.Strings[i]) + 1, Length(ToolBarItems.Strings[i]));
      if s <> '-' then
      begin
        Action := FindItemByName(s);
        if Assigned(Action) then
          Action.Tag := 1;
      end
      else
      begin
        Action := TAction.Create(nil);
        Action.Caption := '-';
      end;
      Data^.Action := Action;
    end;
    Node := VirtualDrawTree.GetFirst;
    if Assigned(Node) then
      VirtualDrawTree.Selected[Node] := True;
    VirtualDrawTree.EndUpdate;
  finally
    Free;
    ToolBarItems.Free;
  end;
end;

procedure TOptionsToolBarFrame.PutData;
var
  i: Integer;
  Value: string;
  Node: PVirtualNode;
  Data: PTreeData;
begin
  { write to ini }
  if FIsChanged then
  begin
    with TBigIniFile.Create(GetIniFilename) do
    try
      WriteBool('ToolBarItemsChanged', 'Changed', True);
      i := 0;
      EraseSection('ToolBarItems');
      Node := VirtualDrawTree.GetFirst;
      while Assigned(Node) do
      begin
        Data := VirtualDrawTree.GetNodeData(Node);
        if Data^.Action.Caption <> '-' then
          Value := Data^.Action.Name
        else
          Value := '-';
        WriteString('ToolBarItems', IntToStr(PostInc(i)), Value);
        Node := VirtualDrawTree.GetNext(Node);
      end;
    finally
      Free;
    end;
  end;
end;

procedure TOptionsToolBarFrame.ResetActionExecute(Sender: TObject);
var
  Node: PVirtualNode;

  procedure DeleteNodes;
  var
    Node, TmpNode: PVirtualNode;
  begin
    Node := VirtualDrawTree.GetLast;
    while Assigned(Node) do
    begin
      TmpNode := VirtualDrawTree.GetPrevious(Node);
      VirtualDrawTree.DeleteNode(Node);
      Node := TmpNode;
    end;
  end;

  procedure AddNode(ActionName: string);
  var
    Data: PTreeData;
    Action: TAction;
  begin
    Node := VirtualDrawTree.AddChild(nil);
    Data := VirtualDrawTree.GetNodeData(Node);
    if ActionName <> '-' then
    begin
      Action := FindItemByName(ActionName);
      if Assigned(Action) then
        Action.Tag := 1;
    end
    else
    begin
      Action := TAction.Create(nil);
      Action.Caption := '-';
    end;
    Data^.Action := Action;
  end;

begin
  inherited;
  VirtualDrawTree.BeginUpdate;
  DeleteNodes;
  {$ifdef EDITBONE}
  AddNode('FileNewAction');
  AddNode('FileOpenAction');
  AddNode('-');
  AddNode('FileSaveAction');
  AddNode('FileSaveAsAction');
  AddNode('FileSaveAllAction');
  AddNode('FileCloseAction');
  AddNode('FileCloseAllAction');
  AddNode('-');
  AddNode('FilePrintAction');
  AddNode('FilePrintPreviewAction');
  AddNode('-');
  AddNode('ViewOpenDirectoryAction');
  AddNode('ViewCloseDirectoryAction');
  AddNode('ViewEditDirectoryAction');
  AddNode('-');
  AddNode('EditIncreaseIndentAction');
  AddNode('EditDecreaseIndentAction');
  AddNode('-');
  AddNode('EditSortAscAction');
  AddNode('EditSortDescAction');
  AddNode('-');
  AddNode('EditToggleCaseAction');
  AddNode('-');
  AddNode('EditUndoAction');
  AddNode('EditRedoAction');
  AddNode('-');
  AddNode('SearchAction');
  AddNode('SearchReplaceAction');
  AddNode('SearchFindInFilesAction');
  AddNode('-');
  AddNode('ViewWordWrapAction');
  AddNode('ViewLineNumbersAction');
  AddNode('ViewSpecialCharsAction');
  AddNode('ViewSelectionModeAction');
  AddNode('-');
  AddNode('CompareFilesAction');
  AddNode('-');
  AddNode('MacroRecordPauseAction');
  AddNode('MacroStopAction');
  AddNode('MacroPlaybackAction');
  AddNode('MacroOpenAction');
  AddNode('MacroSaveAsAction');
  AddNode('-');
  AddNode('ToolsWordCountAction');
  AddNode('ViewInBrowserAction');
  {$endif}
  {$ifdef ORABONE}
  AddNode('ExecuteStatementAction');
  AddNode('ExecuteCurrentStatementAction');
  AddNode('ExecuteScriptAction');
  AddNode('-');
  AddNode('DatabaseCommitAction');
  AddNode('DatabaseRollbackAction');
  AddNode('-');
  AddNode('DBMSOutputAction');
  AddNode('-');
  AddNode('ExplainPlanAction');
  AddNode('-');
  AddNode('FileNewAction');
  AddNode('FileOpenAction');
  AddNode('-');
  AddNode('FileSaveAction');
  AddNode('FileSaveAsAction');
  AddNode('FileSaveAllAction');
  AddNode('FileCloseAction');
  AddNode('FileCloseAllAction');
  AddNode('-');
  AddNode('FilePrintAction');
  AddNode('FilePrintPreviewAction');
  AddNode('-');
  AddNode('EditIncreaseIndentAction');
  AddNode('EditDecreaseIndentAction');
  AddNode('-');
  AddNode('EditSortAscAction');
  AddNode('EditSortDescAction');
  AddNode('-');
  AddNode('EditToggleCaseAction');
  AddNode('-');
  AddNode('EditUndoAction');
  AddNode('EditRedoAction');
  AddNode('-');
  AddNode('SearchAction');
  AddNode('SearchReplaceAction');
  AddNode('SearchFindInFilesAction');
  AddNode('-');
  AddNode('ViewWordWrapAction');
  AddNode('ViewLineNumbersAction');
  AddNode('ViewSpecialCharsAction');
  AddNode('ViewSelectionModeAction');
  AddNode('-');
  AddNode('ToolsCompareFilesAction');
  {$endif}
  Node := VirtualDrawTree.GetFirst;
  if Assigned(Node) then
    VirtualDrawTree.Selected[Node] := True;
  VirtualDrawTree.EndUpdate;
  FIsChanged := True;
end;

procedure TOptionsToolBarFrame.VirtualDrawTreeDragAllowed(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; var Allowed: Boolean);
begin
  inherited;
  Allowed := True;
end;

procedure TOptionsToolBarFrame.VirtualDrawTreeDragDrop(Sender: TBaseVirtualTree; Source: TObject;
  DataObject: IDataObject; Formats: TFormatArray; Shift: TShiftState; Pt: TPoint; var Effect: Integer; Mode: TDropMode);
var
  pSource, pTarget: PVirtualNode;
  attMode: TVTNodeAttachMode;
begin
  pSource := TVirtualStringTree(Source).FocusedNode;
  pTarget := Sender.DropTargetNode;

  if pTarget.Index > pSource.Index then
    attMode := amInsertAfter
  else
  if pTarget.Index < pSource.Index then
    attMode := amInsertBefore
  else
    attMode := amNoWhere;

  Sender.MoveTo(pSource, pTarget, attMode, False);
  FIsChanged := True;
end;

procedure TOptionsToolBarFrame.VirtualDrawTreeDragOver(Sender: TBaseVirtualTree; Source: TObject; Shift: TShiftState;
  State: TDragState; Pt: TPoint; Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
begin
  inherited;
  Accept := Source = Sender;
end;

procedure TOptionsToolBarFrame.VirtualDrawTreeDrawNode(Sender: TBaseVirtualTree; const PaintInfo: TVTPaintInfo);
var
  Data: PTreeData;
  S: UnicodeString;
  R: TRect;
  Format: Cardinal;
  LStyles: TCustomStyleServices;
  LColor: TColor;
  i, HyphenCount: Integer;
begin
  LStyles := StyleServices;
  with Sender as TVirtualDrawTree, PaintInfo do
  begin
    Data := Sender.GetNodeData(Node);

    if not Assigned(Data) then
      Exit;

    if not LStyles.GetElementColor(LStyles.GetElementDetails(tgCellNormal), ecTextColor, LColor) or  (LColor = clNone) then
      LColor := LStyles.GetSystemColor(clWindowText);
    //get and set the background color
    Canvas.Brush.Color := LStyles.GetStyleColor(scEdit);
    Canvas.Font.Color := LColor;

    if LStyles.Enabled and (vsSelected in PaintInfo.Node.States) then
    begin
       Colors.FocusedSelectionColor := LStyles.GetSystemColor(clHighlight);
       Colors.FocusedSelectionBorderColor := LStyles.GetSystemColor(clHighlight);
       Colors.UnfocusedSelectionColor := LStyles.GetSystemColor(clHighlight);
       Colors.UnfocusedSelectionBorderColor := LStyles.GetSystemColor(clHighlight);
       Canvas.Brush.Color := LStyles.GetSystemColor(clHighlight);
       Canvas.Font.Color := LStyles.GetStyleFontColor(sfMenuItemTextSelected);
    end
    else
    if not LStyles.Enabled and (vsSelected in PaintInfo.Node.States) then
    begin
      Canvas.Brush.Color := clHighlight;
      Canvas.Font.Color := clHighlightText;
    end;

    SetBKMode(Canvas.Handle, TRANSPARENT);

    R := ContentRect;
    InflateRect(R, -TextMargin, 0);
    Dec(R.Right);
    Dec(R.Bottom);
    S := Data^.Action.Caption;
    if S = '-' then
    begin
      with R do
        HyphenCount := (Right - Left) div Canvas.TextWidth(S);
      for i := 0 to HyphenCount  do
        S := S + '-';
    end;

    if Length(S) > 0 then
    begin
      Format := DT_TOP or DT_LEFT or DT_VCENTER or DT_SINGLELINE;
      DrawText(Canvas.Handle, S, Length(S), R, Format)
    end;
  end;
end;

procedure TOptionsToolBarFrame.VirtualDrawTreeFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  Data: PTreeData;
begin
  Data := VirtualDrawTree.GetNodeData(Node);
  if Assigned(Data) then
    if Data^.Action.Caption = '-' then
      Data^.Action.Free;
  //Finalize(Data^);
  inherited;
end;

procedure TOptionsToolBarFrame.VirtualDrawTreeGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: Integer);
var
  Data: PTreeData;
begin
  if Kind in [ikNormal, ikSelected] then
  begin
    Data := VirtualDrawTree.GetNodeData(Node);
    if Assigned(Data) then
      ImageIndex := Data^.Action.ImageIndex;
  end;
end;

procedure TOptionsToolBarFrame.VirtualDrawTreeGetNodeWidth(Sender: TBaseVirtualTree; HintCanvas: TCanvas;
  Node: PVirtualNode; Column: TColumnIndex; var NodeWidth: Integer);
begin
  NodeWidth := VirtualDrawTree.Width
end;

end.
