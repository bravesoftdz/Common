unit BCCommon.Dialogs.Options.ToolBarItems;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VirtualTrees, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ActnList,
  System.Generics.Collections, BCControls.Panel, sPanel, sSkinProvider;

type
  TOptionsToolBarItemsDialog = class(TForm)
    ButtonAdd: TButton;
    ButtonCancel: TButton;
    PanelButton: TBCPanel;
    SkinProvider: TsSkinProvider;
    VirtualDrawTreeAddItems: TVirtualDrawTree;
    procedure VirtualDrawTreeAddItemsDrawNode(Sender: TBaseVirtualTree; const PaintInfo: TVTPaintInfo);
    procedure VirtualDrawTreeAddItemsGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind;
      Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: Integer);
    procedure VirtualDrawTreeAddItemsGetNodeWidth(Sender: TBaseVirtualTree; HintCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; var NodeWidth: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure VirtualDrawTreeAddItemsFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
  private
    FActionList: TObjectList<TAction>;
  public
    constructor Create(AOwner: TComponent); override;
    function Open: Boolean;
    procedure GetToolBarItems;
    property ActionList: TObjectList<TAction> read FActionList write FActionList;
  end;

  PTreeData = ^TTreeData;
  TTreeData = record
    Action: TAction;
  end;

function OptionsToolBarItemsDialog(ActionList: TObjectList<TAction>): TOptionsToolBarItemsDialog;

implementation

{$R *.dfm}

uses
  BCCommon.Images, System.Types;

var
  FOptionsToolBarItemsDialog: TOptionsToolBarItemsDialog;

function OptionsToolBarItemsDialog(ActionList: TObjectList<TAction>): TOptionsToolBarItemsDialog;
begin
  if not Assigned(FOptionsToolBarItemsDialog) then
    Application.CreateForm(TOptionsToolBarItemsDialog, FOptionsToolBarItemsDialog);

  FOptionsToolBarItemsDialog.VirtualDrawTreeAddItems.NodeDataSize := SizeOf(TAction);
  FOptionsToolBarItemsDialog.VirtualDrawTreeAddItems.Images := ImagesDataModule.ImageList; { IDE can lose this }
  FOptionsToolBarItemsDialog.ActionList := ActionList;
  FOptionsToolBarItemsDialog.GetToolBarItems;

  Result := FOptionsToolBarItemsDialog;
end;

constructor TOptionsToolBarItemsDialog.Create(AOwner: TComponent);
begin
  inherited;
  { IDE is losing this }
  VirtualDrawTreeAddItems.Images := ImagesDataModule.ImageList;
end;

function TOptionsToolBarItemsDialog.Open: Boolean;
begin
  Result := ShowModal = mrOk;
end;

procedure TOptionsToolBarItemsDialog.FormDestroy(Sender: TObject);
begin
  FOptionsToolBarItemsDialog := nil;
end;

procedure TOptionsToolBarItemsDialog.VirtualDrawTreeAddItemsDrawNode(Sender: TBaseVirtualTree; const PaintInfo: TVTPaintInfo);
var
  Data: PTreeData;
  S: string;
  R: TRect;
  Format: Cardinal;
begin
  with Sender as TVirtualDrawTree, PaintInfo do
  begin
    Data := Sender.GetNodeData(Node);

    if not Assigned(Data) then
      Exit;

    if Assigned(SkinProvider.SkinData) and Assigned(SkinProvider.SkinData.SkinManager) then
      Canvas.Font.Color := SkinProvider.SkinData.SkinManager.GetActiveEditFontColor //clWindowText; //LColor;
    else
      Canvas.Font.Color := clWindowText;

    if vsSelected in PaintInfo.Node.States then
    begin
      if Assigned(SkinProvider.SkinData) and Assigned(SkinProvider.SkinData.SkinManager) then
      begin
        Canvas.Brush.Color := SkinProvider.SkinData.SkinManager.GetHighLightColor;
        Canvas.Font.Color := SkinProvider.SkinData.SkinManager.GetHighLightFontColor
      end
      else
      begin
        Canvas.Brush.Color := clHighlight;
        Canvas.Font.Color := clHighlightText;
      end;
    end;

    SetBKMode(Canvas.Handle, TRANSPARENT);

    R := ContentRect;
    InflateRect(R, -TextMargin, 0);
    Dec(R.Right);
    Dec(R.Bottom);
    S := Data^.Action.Caption;

    if Length(S) > 0 then
    begin
      Format := DT_TOP or DT_LEFT or DT_VCENTER or DT_SINGLELINE;
      DrawText(Canvas.Handle, S, Length(S), R, Format)
    end;
  end;
end;

procedure TOptionsToolBarItemsDialog.VirtualDrawTreeAddItemsFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  Data: PTreeData;
begin
  Data := Sender.GetNodeData(Node);
  Data^.Action := nil;
  //Finalize(Data^);
  inherited;
end;

procedure TOptionsToolBarItemsDialog.VirtualDrawTreeAddItemsGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: Integer);
var
  Data: PTreeData;
begin
  if Kind in [ikNormal, ikSelected] then
  begin
    Data := VirtualDrawTreeAddItems.GetNodeData(Node);
    if Assigned(Data) then
      ImageIndex := Data^.Action.ImageIndex;
  end;
end;

procedure TOptionsToolBarItemsDialog.VirtualDrawTreeAddItemsGetNodeWidth(Sender: TBaseVirtualTree; HintCanvas: TCanvas;
  Node: PVirtualNode; Column: TColumnIndex; var NodeWidth: Integer);
begin
  NodeWidth := VirtualDrawTreeAddItems.Width
end;

procedure TOptionsToolBarItemsDialog.GetToolBarItems;
var
  LAction: TAction;
  LNode: PVirtualNode;
  LData: PTreeData;
begin
  VirtualDrawTreeAddItems.BeginUpdate;
  VirtualDrawTreeAddItems.Clear;
  for LAction in FActionList do
  begin
    if LAction.Tag <> 1 then
    begin
      LNode := VirtualDrawTreeAddItems.AddChild(nil);
      LNode.CheckType := ctCheckBox;
      LData := VirtualDrawTreeAddItems.GetNodeData(LNode);
      LData^.Action := LAction;
    end;
  end;
  VirtualDrawTreeAddItems.EndUpdate;
end;

end.
