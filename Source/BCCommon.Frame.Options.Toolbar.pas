unit BCCommon.Frame.Options.Toolbar;

interface

uses
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCCommon.Frame.Options.Base,
  System.Actions, Vcl.ActnList, System.Generics.Collections, System.Types, VirtualTrees, Winapi.ActiveX,
  Vcl.Menus, BCCommon.Images, BCControl.Panel, sPanel, sFrameAdapter, System.UITypes,
  BCControl.SpeedButton, Vcl.StdCtrls, sRadioButton, Vcl.Buttons, sSpeedButton, Vcl.ExtCtrls;

type
  TOptionsToolbarFrame = class(TBCOptionsBaseFrame)
    ActionAddDivider: TAction;
    ActionAddItem: TAction;
    ActionDelete: TAction;
    ActionReset: TAction;
    MenuActionList: TActionList;
    MenuItemAddDivider: TMenuItem;
    MenuItemAddItem: TMenuItem;
    MenuItemDeleteItem: TMenuItem;
    MenuItemDivider: TMenuItem;
    MenuItemReset: TMenuItem;
    Panel: TBCPanel;
    PopupActionBar: TPopupMenu;
    VirtualDrawTree: TVirtualDrawTree;
    PanelButtons: TBCPanel;
    SpeedButtonDivider1: TBCSpeedButton;
    SpeedButtonDivider2: TBCSpeedButton;
    SpeedButtonDelete: TBCSpeedButton;
    SpeedButtonAddDivider: TBCSpeedButton;
    SpeedButtonAddItem: TBCSpeedButton;
    SpeedButtonReset: TBCSpeedButton;
    SpeedButtonMoveDown: TBCSpeedButton;
    SpeedButtonMoveUp: TBCSpeedButton;
    ActionMoveUp: TAction;
    ActionMoveDown: TAction;
    PanelBottom: TsPanel;
    RadioButtonLargeIcons: TsRadioButton;
    RadioButtonSmallIcons: TsRadioButton;
    ActionLargeIcons: TAction;
    ActionSmallIcons: TAction;
    procedure ActionAddDividerExecute(Sender: TObject);
    procedure ActionAddItemExecute(Sender: TObject);
    procedure ActionDeleteExecute(Sender: TObject);
    procedure ActionResetExecute(Sender: TObject);
    procedure VirtualDrawTreeDragAllowed(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
    procedure VirtualDrawTreeDragDrop(Sender: TBaseVirtualTree; Source: TObject; DataObject: IDataObject; Formats: TFormatArray; Shift: TShiftState; Pt: TPoint; var Effect: Integer; Mode: TDropMode);
    procedure VirtualDrawTreeDragOver(Sender: TBaseVirtualTree; Source: TObject; Shift: TShiftState; State: TDragState; Pt: TPoint; Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
    procedure VirtualDrawTreeDrawNode(Sender: TBaseVirtualTree; const PaintInfo: TVTPaintInfo);
    procedure VirtualDrawTreeGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: TImageIndex);
    procedure VirtualDrawTreeGetNodeWidth(Sender: TBaseVirtualTree; HintCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; var NodeWidth: Integer);
    procedure ActionMoveUpExecute(Sender: TObject);
    procedure ActionMoveDownExecute(Sender: TObject);
    procedure ActionLargeIconsExecute(Sender: TObject);
    procedure ActionSmallIconsExecute(Sender: TObject);
  private
    FActionList: TObjectList<TAction>;
    FIsChanged: Boolean;
    function FindItemByName(const AItemName: string): TAction;
    procedure MoveSelectedNodesDown;
    procedure MoveSelectedNodesUp;
    procedure SetNodeHeight;
  protected
    procedure PutData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure GetToolbarItems;
    property ActionList: TObjectList<TAction> read FActionList write FActionList;
  end;

  PTreeData = ^TTreeData;
  TTreeData = record
    Action: TAction;
  end;

function OptionsToolbarFrame(AOwner: TComponent; ActionList: TObjectList<TAction>): TOptionsToolbarFrame;

implementation

{$R *.dfm}

uses
  Winapi.Windows, BCCommon.FileUtils, BCCommon.Dialog.Options.ToolbarItems, BCCommon.Consts,
  System.SysUtils, System.IniFiles, BCCommon.Utils, BCCommon.Options.Container;

var
  FOptionsToolbarFrame: TOptionsToolbarFrame;

function OptionsToolbarFrame(AOwner: TComponent; ActionList: TObjectList<TAction>): TOptionsToolbarFrame;
begin
  if not Assigned(FOptionsToolbarFrame) then
    FOptionsToolbarFrame := TOptionsToolbarFrame.Create(AOwner);

  FOptionsToolbarFrame.VirtualDrawTree.NodeDataSize := SizeOf(TTreeData);
  if OptionsContainer.ToolbarIconSizeSmall then
  begin
    FOptionsToolbarFrame.RadioButtonSmallIcons.Checked := True;
    FOptionsToolbarFrame.VirtualDrawTree.Images := ImagesDataModule.ImageListSmall { IDE can lose this }
  end
  else
  begin
    FOptionsToolbarFrame.RadioButtonLargeIcons.Checked := True;
    FOptionsToolbarFrame.VirtualDrawTree.Images := ImagesDataModule.ImageList;
  end;
  FOptionsToolbarFrame.ActionList := ActionList;
  FOptionsToolbarFrame.GetToolbarItems;

  Result := FOptionsToolbarFrame;
end;

constructor TOptionsToolbarFrame.Create(AOwner: TComponent);
begin
  inherited;
  { IDE is losing these }
  MenuActionList.Images := ImagesDataModule.ImageListSmall;
  PopupActionBar.Images := ImagesDataModule.ImageListSmall;
  VirtualDrawTree.Images := ImagesDataModule.ImageListSmall;
end;

procedure TOptionsToolbarFrame.ActionAddDividerExecute(Sender: TObject);
var
  LNewNode, LCurrentNode: PVirtualNode;
  LNewData: PTreeData;
begin
  inherited;
  LCurrentNode := VirtualDrawTree.GetFirstSelected;
  if Assigned(LCurrentNode) then
    LNewNode := VirtualDrawTree.InsertNode(LCurrentNode, amInsertAfter)
  else
    LNewNode := VirtualDrawTree.AddChild(nil);
  LNewData := VirtualDrawTree.GetNodeData(LNewNode);
  LNewData^.Action := nil;
  FIsChanged := True;
end;

procedure TOptionsToolbarFrame.ActionAddItemExecute(Sender: TObject);
var
  LNode, LNewNode, LCurrentNode: PVirtualNode;
  LData, LNewData: PTreeData;
begin
  inherited;
   with OptionsToolbarItemsDialog(ActionList) do
   try
     if Open then
     begin
       { insert selected items }
       LNode := VirtualDrawTreeAddItems.GetFirst;
       while Assigned(LNode) do
       begin
         if LNode.CheckState = csCheckedNormal then
         begin
           LData := VirtualDrawTreeAddItems.GetNodeData(LNode);
           LCurrentNode := VirtualDrawTree.GetFirstSelected;
           if Assigned(LCurrentNode) then
             LNewNode := VirtualDrawTree.InsertNode(LCurrentNode, amInsertAfter)
           else
             LNewNode := VirtualDrawTree.AddChild(nil);
           LNewData := VirtualDrawTree.GetNodeData(LNewNode);
           LNewData^.Action := LData^.Action;
           LNewData^.Action.Tag := 1;
           VirtualDrawTree.Selected[LNewNode] := True;
           VirtualDrawTree.NodeHeight[LNewNode] := VirtualDrawTree.Images.Height + 2;
           FIsChanged := True;
         end;
         LNode := VirtualDrawTreeAddItems.GetNext(LNode);
       end;
     end;
   finally
     Free;
   end;
end;

procedure TOptionsToolbarFrame.ActionDeleteExecute(Sender: TObject);
var
  LNode: PVirtualNode;
  LData: PTreeData;
begin
  inherited;
  LNode := VirtualDrawTree.GetFirstSelected;
  if Assigned(LNode) then
  begin
    LData := VirtualDrawTree.GetNodeData(LNode);
    if Assigned(LData^.Action) then
      LData^.Action.Tag := 0;
    VirtualDrawTree.DeleteNode(LNode);
    FIsChanged := True;
  end;
end;

procedure TOptionsToolbarFrame.SetNodeHeight;
var
  LNode: PVirtualNode;
  LData: PTreeData;
begin
  LNode := VirtualDrawTree.GetFirst;
  while Assigned(LNode) do
  begin
    LData := VirtualDrawTree.GetNodeData(LNode);
    if Assigned(LData) then
      if Assigned(LData^.Action) then
        VirtualDrawTree.NodeHeight[LNode] := VirtualDrawTree.Images.Height + 2;
    LNode := VirtualDrawTree.GetNext(LNode);
  end;
end;

procedure TOptionsToolbarFrame.ActionLargeIconsExecute(Sender: TObject);
begin
  inherited;
  VirtualDrawTree.Images := ImagesDataModule.ImageList;
  SetNodeHeight;
  FIsChanged := True;
end;

procedure TOptionsToolbarFrame.ActionMoveDownExecute(Sender: TObject);
begin
  FIsChanged := True;
  MoveSelectedNodesDown;
end;

procedure TOptionsToolbarFrame.ActionMoveUpExecute(Sender: TObject);
begin
  FIsChanged := True;
  MoveSelectedNodesUp
end;

destructor TOptionsToolbarFrame.Destroy;
begin
  inherited;

  FOptionsToolbarFrame := nil;
end;

function TOptionsToolbarFrame.FindItemByName(const AItemName: string): TAction;
begin
  Result := nil;
  if Assigned(FActionList) then
  for Result in FActionList do
    if Result.Name = AItemName then
      Exit;
end;

procedure TOptionsToolbarFrame.GetToolbarItems;
var
  i: Integer;
  s: string;
  LToolbarItems: TStrings;
  LAction: TAction;
  LNode: PVirtualNode;
  LData: PTreeData;
begin
  { read from ini }
  LToolbarItems := TStringList.Create;
  with TIniFile.Create(GetIniFilename) do
  try
    { read items from ini }
    ReadSectionValues('ToolbarItems', LToolbarItems);
    { add items to action bar }
    VirtualDrawTree.BeginUpdate;
    VirtualDrawTree.Clear;
    for i := 0 to LToolbarItems.Count - 1 do
    begin
      LNode := VirtualDrawTree.AddChild(nil);
      LData := VirtualDrawTree.GetNodeData(LNode);

      s := System.Copy(LToolbarItems.Strings[i], Pos('=', LToolbarItems.Strings[i]) + 1, Length(LToolbarItems.Strings[i]));
      if s <> '-' then
      begin
        LAction := FindItemByName(s);
        if Assigned(LAction) then
          LAction.Tag := 1;
        VirtualDrawTree.NodeHeight[LNode] := VirtualDrawTree.Images.Height + 2;
      end
      else
        LAction := nil;
      LData^.Action := LAction;
    end;
    LNode := VirtualDrawTree.GetFirst;
    if Assigned(LNode) then
      VirtualDrawTree.Selected[LNode] := True;
    VirtualDrawTree.EndUpdate;
  finally
    Free;
    LToolbarItems.Free;
  end;
end;

procedure TOptionsToolbarFrame.PutData;
var
  i: Integer;
  Value: string;
  Node: PVirtualNode;
  Data: PTreeData;
begin
  { write to ini }
  if FIsChanged then
  begin
    OptionsContainer.ToolbarIconSizeSmall := RadioButtonSmallIcons.Checked;
    with TIniFile.Create(GetIniFilename) do
    try
      WriteBool('ToolbarItemsChanged', 'Changed', True);
      i := 0;
      EraseSection('ToolbarItems');
      Node := VirtualDrawTree.GetFirst;
      while Assigned(Node) do
      begin
        Data := VirtualDrawTree.GetNodeData(Node);
        if Assigned(Data^.Action) then
          Value := Data^.Action.Name
        else
          Value := '-';
        WriteString('ToolbarItems', IntToStr(PostInc(i)), Value);
        Node := VirtualDrawTree.GetNext(Node);
      end;
    finally
      Free;
    end;
  end;
end;

procedure TOptionsToolbarFrame.ActionResetExecute(Sender: TObject);
var
  i: Integer;
  LNode: PVirtualNode;

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
    LData: PTreeData;
    LAction: TAction;
  begin
    LNode := VirtualDrawTree.AddChild(nil);
    LData := VirtualDrawTree.GetNodeData(LNode);
    if ActionName <> '-' then
    begin
      LAction := FindItemByName(ActionName);
      if Assigned(LAction) then
        LAction.Tag := 1;
      VirtualDrawTree.NodeHeight[LNode] := VirtualDrawTree.Images.Height + 2;
    end
    else
      LAction := nil;
    LData^.Action := LAction;
  end;

begin
  inherited;
  VirtualDrawTree.BeginUpdate;
  DeleteNodes;
  {$ifdef EDITBONE}
  for i := 1 to Length(ToolbarItemsArray) do
    AddNode(ToolbarItemsArray[i]);
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
  LNode := VirtualDrawTree.GetFirst;
  if Assigned(LNode) then
    VirtualDrawTree.Selected[LNode] := True;
  VirtualDrawTree.EndUpdate;
  FIsChanged := True;
end;

procedure TOptionsToolbarFrame.ActionSmallIconsExecute(Sender: TObject);
begin
  inherited;
  VirtualDrawTree.Images := ImagesDataModule.ImageListSmall;
  SetNodeHeight;
  FIsChanged := True;
end;

procedure TOptionsToolbarFrame.VirtualDrawTreeDragAllowed(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; var Allowed: Boolean);
begin
  inherited;
  Allowed := True;
end;

procedure TOptionsToolbarFrame.VirtualDrawTreeDragDrop(Sender: TBaseVirtualTree; Source: TObject;
  DataObject: IDataObject; Formats: TFormatArray; Shift: TShiftState; Pt: TPoint; var Effect: Integer; Mode: TDropMode);
var
  LSourceNode, LTargetNode: PVirtualNode;
  LNodeAttachMode: TVTNodeAttachMode;
begin
  LSourceNode := TVirtualStringTree(Source).FocusedNode;
  LTargetNode := Sender.DropTargetNode;

  if LTargetNode.Index > LSourceNode.Index then
    LNodeAttachMode := amInsertAfter
  else
  if LTargetNode.Index < LSourceNode.Index then
    LNodeAttachMode := amInsertBefore
  else
    LNodeAttachMode := amNoWhere;

  Sender.MoveTo(LSourceNode, LTargetNode, LNodeAttachMode, False);
  FIsChanged := True;
end;

procedure TOptionsToolbarFrame.MoveSelectedNodesUp;
var
  i: Integer;
  Node, PrevNode: PVirtualNode;
begin
  with VirtualDrawTree do
  begin
    if SelectedCount = 0 then
      Exit;
    Node := GetFirstSelected;
    for i := 0 to SelectedCount - 1 do
    begin
      PrevNode := GetPrevious(Node,false);
      MoveTo(Node,PrevNode,amInsertBefore,false);
      Node := GetNextSelected(Node,false);
    end;
  end;
end;

procedure TOptionsToolbarFrame.MoveSelectedNodesDown;
var
  Node, Next: PVirtualNode;
begin
  with VirtualDrawTree do
  begin
    Node := GetLast;
    while Assigned(Node) do
    begin
      if vsSelected in Node.States then
      begin
        Next := GetNext(Node);
        if Assigned(Next) and not (vsSelected in Next.States) then
          MoveTo(Node, Next, amInsertAfter, False);
      end;
      Node := GetPrevious(Node);
    end;
  end;
end;

procedure TOptionsToolbarFrame.VirtualDrawTreeDragOver(Sender: TBaseVirtualTree; Source: TObject; Shift: TShiftState;
  State: TDragState; Pt: TPoint; Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
begin
  inherited;
  Accept := Source = Sender;
end;

procedure TOptionsToolbarFrame.VirtualDrawTreeDrawNode(Sender: TBaseVirtualTree; const PaintInfo: TVTPaintInfo);
var
  LData: PTreeData;
  LText: string;
  LRect: TRect;
  LFormat: Cardinal;
  i, LHyphenCount: Integer;
begin
  with Sender as TVirtualDrawTree, PaintInfo do
  begin
    LData := Sender.GetNodeData(Node);

    if not Assigned(LData) then
      Exit;

    if Assigned(FrameAdapter.SkinData) and Assigned(FrameAdapter.SkinData.SkinManager) then
      Canvas.Font.Color := FrameAdapter.SkinData.SkinManager.GetActiveEditFontColor
    else
      Canvas.Font.Color := clWindowText;

    if vsSelected in PaintInfo.Node.States then
    begin
      if Assigned(FrameAdapter.SkinData) and Assigned(FrameAdapter.SkinData.SkinManager) then
        Canvas.Font.Color := FrameAdapter.SkinData.SkinManager.GetHighLightFontColor
      else
        Canvas.Font.Color := clHighlightText;
    end;

    SetBKMode(Canvas.Handle, TRANSPARENT);

    LRect := ContentRect;
    InflateRect(LRect, -TextMargin, 0);
    Dec(LRect.Right);
    Dec(LRect.Bottom);
    if Assigned(LData^.Action) then
      LText := LData^.Action.Caption
    else
      LText := '-';
    if LText = '-' then
    begin
      LHyphenCount := (LRect.Right - LRect.Left) div Canvas.TextWidth(LText);
      for i := 0 to LHyphenCount do
        LText := LText + '-';
    end;

    if Length(LText) > 0 then
    begin
      LFormat := DT_TOP or DT_LEFT or DT_VCENTER or DT_SINGLELINE;
      DrawText(Canvas.Handle, LText, Length(LText), LRect, LFormat)
    end;
  end;
end;

procedure TOptionsToolbarFrame.VirtualDrawTreeGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: TImageIndex);
var
  LData: PTreeData;
begin
  if Kind = ikState then
    Exit;
  LData := VirtualDrawTree.GetNodeData(Node);
  if Assigned(LData) then
    if Assigned(LData^.Action) then
      ImageIndex := LData^.Action.ImageIndex;
end;

procedure TOptionsToolbarFrame.VirtualDrawTreeGetNodeWidth(Sender: TBaseVirtualTree; HintCanvas: TCanvas;
  Node: PVirtualNode; Column: TColumnIndex; var NodeWidth: Integer);
begin
  NodeWidth := VirtualDrawTree.Width;
end;

end.
