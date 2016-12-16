unit BCCommon.Dialog.ClipboardHistory;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, BCEditor.Editor,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCCommon.Dialog.Base, Vcl.StdCtrls, sListBox, Vcl.Buttons, sSpeedButton,
  BCControl.SpeedButton, Vcl.ExtCtrls, sPanel, BCControl.Panel, System.Actions, Vcl.ActnList, VirtualTrees,
  System.Generics.Collections, sSkinProvider, Vcl.ComCtrls, sStatusBar, BCControl.StatusBar;

type
  TClipboardHistoryOnInsertInEditor =  procedure(var AText: string);

  TClipboardHistoryDialog = class(TBCBaseDialog)
    ActionList: TActionList;
    ActionCopyToClipboard: TAction;
    ActionClearAll: TAction;
    ActionInsertInEditor: TAction;
    PanelTop: TBCPanel;
    SpeedButtonDivider1: TBCSpeedButton;
    SpeedButtonCopyToClipboard: TBCSpeedButton;
    SpeedButtonClearAll: TBCSpeedButton;
    SpeedButtonInsertInEditor: TBCSpeedButton;
    VirtualDrawTree: TVirtualDrawTree;
    StatusBar: TBCStatusBar;
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure VirtualDrawTreeDrawNode(Sender: TBaseVirtualTree; const PaintInfo: TVTPaintInfo);
    procedure VirtualDrawTreeGetNodeWidth(Sender: TBaseVirtualTree; HintCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; var NodeWidth: Integer);
    procedure ActionCopyToClipboardExecute(Sender: TObject);
    procedure ActionInsertInEditorExecute(Sender: TObject);
    procedure VirtualDrawTreeFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure ActionClearAllExecute(Sender: TObject);
  private
    FClipboardHistoryItems: TList<string>;
    FOnInsertInEditor: TClipboardHistoryOnInsertInEditor;
    procedure ReadIniFile;
    procedure WriteIniFile;
  public
    procedure SetDrawTreeData;
    procedure Open(AClipboardHistoryItems: TList<string>);
    property OnInsertInEditor: TClipboardHistoryOnInsertInEditor read FOnInsertInEditor write FOnInsertInEditor;
  end;

function ClipboardHistoryDialog: TClipboardHistoryDialog;

implementation

{$R *.dfm}

uses
  System.IniFiles, System.Types, System.Math, Vcl.Clipbrd, BCCommon.Utils, BCCommon.FileUtils, BCCommon.Language.Utils;

type
  PTreeData = ^TTreeData;
  TTreeData = record
    Text: string;
  end;

var
  FClipboardHistoryDialog: TClipboardHistoryDialog;

function ClipboardHistoryDialog: TClipboardHistoryDialog;
begin
  if not Assigned(FClipboardHistoryDialog) then
    Application.CreateForm(TClipboardHistoryDialog, FClipboardHistoryDialog);
  Result := FClipboardHistoryDialog;
end;

procedure TClipboardHistoryDialog.ActionClearAllExecute(Sender: TObject);
begin
  inherited;
  FClipboardHistoryItems.Clear;
  SetDrawTreeData;
end;

procedure TClipboardHistoryDialog.ActionCopyToClipboardExecute(Sender: TObject);
var
  LCurrentNode: PVirtualNode;
  LData: PTreeData;
begin
  inherited;
  LCurrentNode := VirtualDrawTree.GetFirstSelected;
  LData := VirtualDrawTree.GetNodeData(LCurrentNode);
  Clipboard.AsText := LData^.Text;
end;

procedure TClipboardHistoryDialog.ActionInsertInEditorExecute(Sender: TObject);
var
  LCurrentNode: PVirtualNode;
  LData: PTreeData;
begin
  inherited;
  if Assigned(FOnInsertInEditor) then
  begin
    LCurrentNode := VirtualDrawTree.GetFirstSelected;
    LData := VirtualDrawTree.GetNodeData(LCurrentNode);
    FOnInsertInEditor(LData^.Text);
  end;
end;

procedure TClipboardHistoryDialog.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  WriteIniFile;
  Action := caFree;
end;

procedure TClipboardHistoryDialog.FormDestroy(Sender: TObject);
begin
  inherited;
  FClipboardHistoryDialog := nil;
end;

procedure TClipboardHistoryDialog.Open(AClipboardHistoryItems: TList<string>);
begin
  FClipboardHistoryItems := AClipboardHistoryItems;
  ReadIniFile;
  VirtualDrawTree.NodeDataSize := SizeOf(TTreeData);
  SetDrawTreeData;
  Show;
end;

procedure TClipboardHistoryDialog.ReadIniFile;
begin
  with TMemIniFile.Create(GetIniFilename) do
  try
    { Size }
    Width := ReadInteger('ClipboardHistorySize', 'Width', Width);
    Height := ReadInteger('ClipboardHistorySize', 'Height', Height);
    { Position }
    Left := ReadInteger('ClipboardHistoryPosition', 'Left', (Screen.Width - Width) div 2);
    Top := ReadInteger('ClipboardHistoryPosition', 'Top', (Screen.Height - Height) div 2);
    { Check if the form is outside the workarea }
    Left := SetFormInsideWorkArea(Left, Width);
  finally
    Free;
  end;
end;

procedure TClipboardHistoryDialog.VirtualDrawTreeDrawNode(Sender: TBaseVirtualTree; const PaintInfo: TVTPaintInfo);
var
  LData: PTreeData;
  LFormat: Cardinal;
  LRect: TRect;
begin
  with Sender as TVirtualDrawTree, PaintInfo do
  begin
    LData := Sender.GetNodeData(Node);

    if not Assigned(LData) then
      Exit;

    if Assigned(SkinProvider.SkinData) and Assigned(SkinProvider.SkinData.SkinManager) then
      Canvas.Font.Color := SkinProvider.SkinData.SkinManager.GetActiveEditFontColor
    else
      Canvas.Font.Color := clWindowText;

    if vsSelected in PaintInfo.Node.States then
    begin
      if Assigned(SkinProvider.SkinData) and Assigned(SkinProvider.SkinData.SkinManager) then
        Canvas.Font.Color := SkinProvider.SkinData.SkinManager.GetHighLightFontColor
      else
        Canvas.Font.Color := clHighlightText;
    end;

    SetBKMode(Canvas.Handle, TRANSPARENT);

    LRect := ContentRect;
    if Length(LData^.Text) > 0 then
    begin
      LFormat := DT_TOP or DT_LEFT or DT_VCENTER or DT_SINGLELINE;
      DrawText(Canvas.Handle, LData^.Text, Length(LData^.Text), LRect, LFormat)
    end;
  end;
end;

procedure TClipboardHistoryDialog.VirtualDrawTreeFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  LData: PTreeData;
begin
  LData := VirtualDrawTree.GetNodeData(Node);
  Finalize(LData^);
  inherited;
end;

procedure TClipboardHistoryDialog.VirtualDrawTreeGetNodeWidth(Sender: TBaseVirtualTree; HintCanvas: TCanvas;
  Node: PVirtualNode; Column: TColumnIndex; var NodeWidth: Integer);
var
  LData: PTreeData;
begin
  with Sender as TVirtualDrawTree do
  begin
    LData := Sender.GetNodeData(Node);
    if Assigned(LData) then
      NodeWidth := Canvas.TextWidth(LData^.Text);
  end;
end;

procedure TClipboardHistoryDialog.WriteIniFile;
begin
  if Windowstate = wsNormal then
  with TMemIniFile.Create(GetIniFilename) do
  try
    { Size }
    WriteInteger('ClipboardHistorySize', 'Width', Width);
    WriteInteger('ClipboardHistorySize', 'Height', Height);
    { Position }
    WriteInteger('ClipboardHistoryPosition', 'Left', Left);
    WriteInteger('ClipboardHistoryPosition', 'Top', Top);
  finally
    UpdateFile;
    Free;
  end;
end;

procedure TClipboardHistoryDialog.SetDrawTreeData;
var
  LIndex: Integer;
  LNode: PVirtualNode;
  LData: PTreeData;
begin
  VirtualDrawTree.BeginUpdate;
  VirtualDrawTree.Clear;
  VirtualDrawTree.DefaultNodeHeight := Max(VirtualDrawTree.Canvas.TextHeight('Tg'), 18);
  for LIndex := 0 to FClipboardHistoryItems.Count - 1 do
  begin
    LNode := VirtualDrawTree.AddChild(nil);
    LData := VirtualDrawTree.GetNodeData(LNode);
    LData^.Text := FClipboardHistoryItems[LIndex];
  end;
  LNode := VirtualDrawTree.GetFirst;
  if Assigned(LNode) then
    VirtualDrawTree.Selected[LNode] := True;
  VirtualDrawTree.EndUpdate;
end;

end.