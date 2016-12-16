unit BCCommon.Dialog.Popup.Encoding;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VirtualTrees, Vcl.ExtCtrls, sSkinProvider,
  System.Actions, Vcl.ActnList;

type
  TSelectEncodingEvent = procedure(const AIndex: Integer) of object;

  TPopupEncodingDialog = class(TForm)
    VirtualDrawTree: TVirtualDrawTree;
    SkinProvider: TsSkinProvider;
    procedure VirtualDrawTreeDblClick(Sender: TObject);
    procedure VirtualDrawTreeDrawNode(Sender: TBaseVirtualTree; const PaintInfo: TVTPaintInfo);
    procedure VirtualDrawTreeFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure VirtualDrawTreeGetNodeWidth(Sender: TBaseVirtualTree; HintCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; var NodeWidth: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FSelectEncoding: TSelectEncodingEvent;
    procedure WMActivate(var AMessage: TWMActivate); message WM_ACTIVATE;
  public
    procedure Execute(const ASelectedEncoding: string);
    property OnSelectEncoding: TSelectEncodingEvent read FSelectEncoding write FSelectEncoding;
  end;

implementation

{$R *.dfm}

uses
  System.Types, BCControl.Utils, BCCommon.Utils, BCCommon.Encoding, sGraphUtils, sVclUtils, System.Math, acPopupController;

type
  PEncodingRec = ^TEncodingRec;
  TEncodingRec = packed record
    Index: Integer;
    Name: string;
  end;

procedure TPopupEncodingDialog.FormCreate(Sender: TObject);
begin
  VirtualDrawTree.NodeDataSize := SizeOf(TEncodingRec);
end;

procedure TPopupEncodingDialog.FormShow(Sender: TObject);
begin
  VirtualDrawTree.SetFocus;
end;

procedure TPopupEncodingDialog.Execute(const ASelectedEncoding: string);
var
  i: Integer;
  LWidth, LMaxWidth: Integer;

  procedure AddEncoding(const AIndex: Integer; const AName: string);
  var
    LNode: PVirtualNode;
    LNodeData: PEncodingRec;
  begin
    LNode := VirtualDrawTree.AddChild(nil);
    LNodeData := VirtualDrawTree.GetNodeData(LNode);

    LWidth := VirtualDrawTree.Canvas.TextWidth(AName);
    if LWidth > LMaxWidth then
      LMaxWidth := LWidth;

    LNodeData.Index := AIndex;
    LNodeData.Name := AName;
    VirtualDrawTree.Selected[LNode] := ASelectedEncoding = AName;
  end;

begin
  LMaxWidth := 0;

  VirtualDrawTree.Clear;
  VirtualDrawTree.DefaultNodeHeight := Max(VirtualDrawTree.Canvas.TextHeight('Tg'), 18);

  for i := Low(ENCODING_CAPTIONS) to High(ENCODING_CAPTIONS) do
    AddEncoding(i, ENCODING_CAPTIONS[i]);

  VirtualDrawTree.Invalidate;

  Width := LMaxWidth + 80;

  Height := Min(Integer(VirtualDrawTree.DefaultNodeHeight) * 7 + VirtualDrawTree.BorderWidth * 2 + 2, TForm(Self.PopupParent).Height);

  ShowPopupForm(Self, Point(Left, Top + 2));
end;

procedure TPopupEncodingDialog.VirtualDrawTreeDblClick(Sender: TObject);
var
  LNode: PVirtualNode;
  LData: PEncodingRec;
begin
  LNode := VirtualDrawTree.GetFirstSelected;
  LData := VirtualDrawTree.GetNodeData(LNode);
  Hide;
  if Assigned(LData) then
    if Assigned(FSelectEncoding) then
      FSelectEncoding(LData.Index);
end;

procedure TPopupEncodingDialog.VirtualDrawTreeDrawNode(Sender: TBaseVirtualTree; const PaintInfo: TVTPaintInfo);
var
  LData: PEncodingRec;
  LName: string;
  LRect: TRect;
begin
  with Sender as TVirtualDrawTree, PaintInfo do
  begin
    LData := Sender.GetNodeData(Node);

    if not Assigned(LData) then
      Exit;

    Canvas.Font.Color := SkinProvider.SkinData.SkinManager.GetActiveEditFontColor;

    if vsSelected in PaintInfo.Node.States then
      Canvas.Font.Color := SkinProvider.SkinData.SkinManager.GetHighLightFontColor;

    SetBKMode(Canvas.Handle, TRANSPARENT);

    LRect := ContentRect;
    InflateRect(LRect, -TextMargin, 0);
    Dec(LRect.Right);
    Dec(LRect.Bottom);

    LName := LData.Name;

    if Length(LName) > 0 then
      DrawText(Canvas.Handle, LName, Length(LName), LRect, DT_TOP or DT_LEFT or DT_VCENTER or DT_SINGLELINE);
  end;
end;

procedure TPopupEncodingDialog.WMActivate(var AMessage: TWMActivate);
begin
  if AMessage.Active <> WA_INACTIVE then
    SendMessage(Self.PopupParent.Handle, WM_NCACTIVATE, WPARAM(True), -1);

  inherited;
end;

procedure TPopupEncodingDialog.VirtualDrawTreeFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  LData: PEncodingRec;
begin
  LData := Sender.GetNodeData(Node);
  Finalize(LData^);

  inherited;
end;

procedure TPopupEncodingDialog.VirtualDrawTreeGetNodeWidth(Sender: TBaseVirtualTree; HintCanvas: TCanvas;
  Node: PVirtualNode; Column: TColumnIndex; var NodeWidth: Integer);
var
  LData: PEncodingRec;
  LMargin: Integer;
begin
  with Sender as TVirtualDrawTree do
  begin
    LMargin := TextMargin;
    LData := GetNodeData(Node);
    if Assigned(LData) then
      NodeWidth := Canvas.TextWidth(LData.Name) + 2 * LMargin;
  end;
end;

end.