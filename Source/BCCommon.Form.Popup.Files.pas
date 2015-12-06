unit BCCommon.Form.Popup.Files;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VirtualTrees, Vcl.StdCtrls, Vcl.ExtCtrls, BCControls.ButtonedEdit, sSkinProvider,
  System.Actions, Vcl.ActnList;

type
  TSelectFileEvent = procedure(var APageIndex: Integer) of object;

  TPopupFilesForm = class(TForm)
    VirtualDrawTreeSearch: TVirtualDrawTree;
    SkinProvider: TsSkinProvider;
    ButtonedEdit: TBCButtonedEdit;
    ActionList: TActionList;
    ActionClear: TAction;
    ActionSearch: TAction;
    procedure FormShow(Sender: TObject);
    procedure ActionClearExecute(Sender: TObject);
    procedure ActionSearchExecute(Sender: TObject);
    procedure VirtualDrawTreeSearchCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode;
      Column: TColumnIndex; var Result: Integer);
    procedure VirtualDrawTreeSearchDblClick(Sender: TObject);
    procedure VirtualDrawTreeSearchDrawNode(Sender: TBaseVirtualTree; const PaintInfo: TVTPaintInfo);
    procedure VirtualDrawTreeSearchFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure VirtualDrawTreeSearchGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind;
      Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: Integer);
    procedure VirtualDrawTreeSearchGetNodeWidth(Sender: TBaseVirtualTree; HintCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; var NodeWidth: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FSelectFile: TSelectFileEvent;
    procedure SetVisibleRows;
    procedure WMActivate(var AMessage: TWMActivate); message WM_ACTIVATE;
  protected
    procedure CreateParams(var AParams: TCreateParams); override;
  public
    procedure Execute(AFiles: TStrings; ASelectedFile: string);
    property OnSelectFile: TSelectFileEvent read FSelectFile write FSelectFile;
  end;

implementation

{$R *.dfm}

uses
  System.Types, BCControls.Utils, sGraphUtils, sVclUtils, sDefaults;

type
  PSearchRec = ^TSearchRec;
  TSearchRec = packed record
    FileName: string;
    FilePath: string;
    ImageIndex: Integer;
    PageIndex: Integer;
  end;

procedure TPopupFilesForm.FormCreate(Sender: TObject);
var
  SysImageList: THandle;
begin
  VirtualDrawTreeSearch.NodeDataSize := SizeOf(TSearchRec);
  VirtualDrawTreeSearch.Images := TImageList.Create(Self);
  SysImageList := GetSysImageList;
  if SysImageList <> 0 then
  begin
    VirtualDrawTreeSearch.Images.Handle := SysImageList;
    VirtualDrawTreeSearch.Images.BkColor := clNone;
    VirtualDrawTreeSearch.Images.ShareImages := True;
  end;
end;

procedure TPopupFilesForm.Execute(AFiles: TStrings; ASelectedFile: string);
var
  i: Integer;
  Node: PVirtualNode;
  NodeData: PSearchRec;
  LFileName, LSelectedFile: string;
begin
  LSelectedFile := Copy(ASelectedFile, 2, Length(ASelectedFile) - 2); { Remove [] }
  for i := 0 to AFiles.Count - 1 do
  begin
    Node := VirtualDrawTreeSearch.AddChild(nil);
    NodeData := VirtualDrawTreeSearch.GetNodeData(Node);
    LFileName := AFiles[i];
    NodeData.FileName := ExtractFileName(LFileName);
    NodeData.FilePath := ExtractFilePath(LFileName);
    NodeData.ImageIndex := GetIconIndex(LFileName);
    if NodeData.ImageIndex = -1 then
      NodeData.ImageIndex := 0;
    NodeData.PageIndex := Integer(AFiles.Objects[i]);
    VirtualDrawTreeSearch.Selected[Node] := LSelectedFile = LFileName;
  end;
  {$WARNINGS ON}
  VirtualDrawTreeSearch.Sort(nil, 0, sdAscending, False);
  VirtualDrawTreeSearch.Invalidate;

  Visible := True;
end;

procedure TPopupFilesForm.FormDestroy(Sender: TObject);
begin
  VirtualDrawTreeSearch.Images.Free;
end;

procedure TPopupFilesForm.FormShow(Sender: TObject);
begin
  ButtonedEdit.SetFocus;
end;

procedure TPopupFilesForm.VirtualDrawTreeSearchCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode;
  Column: TColumnIndex; var Result: Integer);
var
  Data1, Data2: PSearchRec;
begin
  if Result = 0 then
  begin
    Data1 := VirtualDrawTreeSearch.GetNodeData(Node1);
    Data2 := VirtualDrawTreeSearch.GetNodeData(Node2);

    Result := -1;

    if not Assigned(Data1) or not Assigned(Data2) then
      Exit;

    Result := AnsiCompareText(Data1.FileName, Data2.FileName);
  end;
end;

procedure TPopupFilesForm.VirtualDrawTreeSearchDblClick(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PSearchRec;
begin
  Node := VirtualDrawTreeSearch.GetFirstSelected;
  Data := VirtualDrawTreeSearch.GetNodeData(Node);
  if Assigned(Data) then
    if Assigned(FSelectFile) then
      FSelectFile(Data.PageIndex);
end;

procedure TPopupFilesForm.VirtualDrawTreeSearchDrawNode(Sender: TBaseVirtualTree; const PaintInfo: TVTPaintInfo);
var
  Data: PSearchRec;
  S: string;
  R: TRect;
  Format: Cardinal;
begin
  with Sender as TVirtualDrawTree, PaintInfo do
  begin
    Data := Sender.GetNodeData(Node);

    if not Assigned(Data) then
      Exit;

    Canvas.Font.Color := SkinProvider.SkinData.SkinManager.GetActiveEditFontColor;

    if vsSelected in PaintInfo.Node.States then
    begin
      Canvas.Brush.Color := SkinProvider.SkinData.SkinManager.GetHighLightColor;
      Canvas.Font.Color := SkinProvider.SkinData.SkinManager.GetHighLightFontColor
    end;

    SetBKMode(Canvas.Handle, TRANSPARENT);

    R := ContentRect;
    InflateRect(R, -TextMargin, 0);
    Dec(R.Right);
    Dec(R.Bottom);

    S := Data.Filename;

    if Length(S) > 0 then
    begin
      Format := DT_TOP or DT_LEFT or DT_VCENTER or DT_SINGLELINE;

      DrawText(Canvas.Handle, S, Length(S), R, Format);
      if Data.FilePath <> '' then
      begin
        R.Left := R.Left + Canvas.TextWidth(S);
        S := System.SysUtils.Format(' (%s)', [Data.FilePath]);
        Canvas.Font.Color := MixColors(ColorToRGB(Font.Color), GetControlColor(Parent), DefDisabledBlend);
        DrawText(Canvas.Handle, S, Length(S), R, Format);
      end;
    end;
  end;
end;

procedure TPopupFilesForm.WMActivate(var AMessage: TWMActivate);
begin
  if AMessage.Active <> WA_INACTIVE then
    SendMessage(Self.PopupParent.Handle, WM_NCACTIVATE, WPARAM(True), -1);

  inherited;

  if AMessage.Active = WA_INACTIVE then
    Release;
end;

procedure TPopupFilesForm.ActionClearExecute(Sender: TObject);
begin
  ButtonedEdit.Text := '';
end;

procedure TPopupFilesForm.ActionSearchExecute(Sender: TObject);
begin
  ButtonedEdit.RightButton.Visible := Trim(ButtonedEdit.Text) <> '';
  SetVisibleRows;
end;

procedure TPopupFilesForm.CreateParams(var AParams: TCreateParams);
begin
  inherited CreateParams(AParams);

  with AParams do
    if ((Win32Platform and VER_PLATFORM_WIN32_NT) <> 0) and (Win32MajorVersion > 4) and (Win32MinorVersion > 0) then
      WindowClass.Style := WindowClass.Style or CS_DROPSHADOW;
end;

procedure TPopupFilesForm.SetVisibleRows;
var
  CurNode: PVirtualNode;
  Data: PSearchRec;
begin
  with VirtualDrawTreeSearch do
  begin
    CurNode := GetFirst;
    while Assigned(CurNode) do
    begin
      Data := GetNodeData(CurNode);
      IsVisible[CurNode] := (Pos(UpperCase(ButtonedEdit.Text), UpperCase(Data.FileName)) <> 0) or (ButtonedEdit.Text = '');
      CurNode := CurNode.NextSibling;
    end;
  end;
end;

procedure TPopupFilesForm.VirtualDrawTreeSearchFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  Data: PSearchRec;
begin
  Data := Sender.GetNodeData(Node);
  Finalize(Data^);
  inherited;
end;

procedure TPopupFilesForm.VirtualDrawTreeSearchGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: Integer);
var
  Data: PSearchRec;
begin
  Data := VirtualDrawTreeSearch.GetNodeData(Node);
  if Assigned(Data) then
    ImageIndex := Data.ImageIndex;
end;

procedure TPopupFilesForm.VirtualDrawTreeSearchGetNodeWidth(Sender: TBaseVirtualTree; HintCanvas: TCanvas;
  Node: PVirtualNode; Column: TColumnIndex; var NodeWidth: Integer);
var
  Data: PSearchRec;
  AMargin: Integer;
begin
  with Sender as TVirtualDrawTree do
  begin
    AMargin := TextMargin;
    Data := GetNodeData(Node);
    if Assigned(Data) then
      NodeWidth := Canvas.TextWidth(Format('%s (%s)', [Data.FileName, Data.FilePath])) + 2 * AMargin;
  end;
end;

end.
