unit BCForms.SearchForFiles;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, Vcl.ImgList, BCControls.ImageList, Vcl.StdCtrls, VirtualTrees, BCControls.ProgressBar,
  Vcl.ComCtrls, BCControls.ButtonedEdit;

type
  TOpenFileEvent = procedure(var FileName: string);

  TSearchForFilesForm = class(TForm)
    SearchForEdit: TBCButtonedEdit;
    ActionList: TActionList;
    SearchVirtualDrawTree: TVirtualDrawTree;
    ImageList: TBCImageList;
    ClearAction: TAction;
    SearchAction: TAction;
    SearchingFilesPanel: TPanel;
    StatusBar: TStatusBar;
    procedure ClearActionExecute(Sender: TObject);
    procedure SearchActionExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SearchVirtualDrawTreeDrawNode(Sender: TBaseVirtualTree; const PaintInfo: TVTPaintInfo);
    procedure SearchVirtualDrawTreeGetNodeWidth(Sender: TBaseVirtualTree; HintCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; var NodeWidth: Integer);
    procedure SearchVirtualDrawTreeFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure SearchVirtualDrawTreeGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind;
      Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: Integer);
    procedure FormCreate(Sender: TObject);
    procedure SearchVirtualDrawTreeCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode;
      Column: TColumnIndex; var Result: Integer);
    procedure SearchVirtualDrawTreeDblClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FOpenFile: TOpenFileEvent;
    FProgressBar: TBCProgressBar;
    FFormClosing: Boolean;
    procedure ReadIniFile;
    procedure WriteIniFile;
    procedure ReadFiles(RootDirectory: string);
    procedure SetVisibleRows;
    procedure ResizeProgressBar;
    procedure CreateProgressBar;
  public
    { Public declarations }
    procedure Open(RootDirectory: string);
    property OnOpenFile: TOpenFileEvent read FOpenFile write FOpenFile;
  end;

function SearchForFilesForm: TSearchForFilesForm;

implementation

{$R *.dfm}

uses
  Winapi.CommCtrl, BCCommon.LanguageUtils, System.IniFiles, BCCommon.FileUtils, Vcl.Themes, Winapi.ShellAPI,
  BCCommon.Lib, BCCommon.LanguageStrings, System.Types;

type
  PSearchRec = ^TSearchRec;
  TSearchRec = packed record
    FileName: string;
    FilePath: string;
    ImageIndex: Integer;
  end;

var
  FSearchForFilesForm: TSearchForFilesForm;

function SearchForFilesForm: TSearchForFilesForm;
begin
  if not Assigned(FSearchForFilesForm) then
    Application.CreateForm(TSearchForFilesForm, FSearchForFilesForm);
  Result := FSearchForFilesForm;
  UpdateLanguage(FSearchForFilesForm, GetSelectedLanguage);
end;

procedure TSearchForFilesForm.ResizeProgressBar;
var
  R: TRect;
begin
  if Assigned(FProgressBar) then
  begin
    Statusbar.Perform(SB_GETRECT, 0, Integer(@R));
    FProgressBar.Top    := R.Top;
    FProgressBar.Left   := R.Left;
    FProgressBar.Width  := R.Right - R.Left;
    FProgressBar.Height := R.Bottom - R.Top;
  end;
end;

procedure TSearchForFilesForm.CreateProgressBar;
begin
  FProgressBar := TBCProgressBar.Create(StatusBar);
  FProgressBar.Hide;
  ResizeProgressBar;
  FProgressBar.Parent := Statusbar;
end;


procedure TSearchForFilesForm.SetVisibleRows;
var
  CurNode: PVirtualNode;
  Data: PSearchRec;
begin
  with SearchVirtualDrawTree do
  begin
    CurNode := GetFirst;
    while Assigned(CurNode) do
    begin
      Data := GetNodeData(CurNode);
      IsVisible[CurNode] := (Pos(UpperCase(SearchForEdit.Text), UpperCase(Data.FileName)) <> 0) or (SearchForEdit.Text = '');
      CurNode := CurNode.NextSibling;
    end;
  end;
end;

procedure TSearchForFilesForm.ClearActionExecute(Sender: TObject);
begin
  SearchForEdit.Text := '';
end;

procedure TSearchForFilesForm.SearchActionExecute(Sender: TObject);
begin
  SearchForEdit.RightButton.Visible := Trim(SearchForEdit.Text) <> '';
  SetVisibleRows;
end;

procedure TSearchForFilesForm.SearchVirtualDrawTreeCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode;
  Column: TColumnIndex; var Result: Integer);
var
  Data1, Data2: PSearchRec;
begin
  if Result = 0 then
  begin
    Data1 := SearchVirtualDrawTree.GetNodeData(Node1);
    Data2 := SearchVirtualDrawTree.GetNodeData(Node2);

    Result := -1;

    if not Assigned(Data1) or not Assigned(Data2) then
      Exit;

    Result := AnsiCompareText(Data1.FileName, Data2.FileName);
  end;
end;

procedure TSearchForFilesForm.SearchVirtualDrawTreeDblClick(Sender: TObject);
var
  S: string;
  Node: PVirtualNode;
  Data: PSearchRec;
begin
  Node := SearchVirtualDrawTree.GetFirstSelected;
  Data := SearchVirtualDrawTree.GetNodeData(Node);
  if Assigned(Data) then
    if Assigned(FOpenFile) then
    begin
      {$WARNINGS OFF} { IncludeTrailingBackslash is specific to a platform }
      S := IncludeTrailingBackslash(Data.FilePath) + Data.FileName;
      {$WARNINGS ON}
      FOpenFile(S);
    end;
end;

procedure TSearchForFilesForm.SearchVirtualDrawTreeDrawNode(Sender: TBaseVirtualTree; const PaintInfo: TVTPaintInfo);
var
  Data: PSearchRec;
  S: UnicodeString;
  R: TRect;
  Format: Cardinal;
  LStyles: TCustomStyleServices;
  LDetails: TThemedElementDetails;
  LColor: TColor;
begin
  LStyles := StyleServices;
  with Sender as TVirtualDrawTree, PaintInfo do
  begin
    Data := Sender.GetNodeData(Node);

    if not Assigned(Data) then
      Exit;

    if LStyles.Enabled then
      Color := LStyles.GetStyleColor(scEdit);

    if LStyles.Enabled and (vsSelected in PaintInfo.Node.States) then
    begin
      R := ContentRect;
      R.Right := R.Left + NodeWidth;

      LDetails := LStyles.GetElementDetails(tgCellSelected);
      LStyles.DrawElement(Canvas.Handle, LDetails, R);
    end;

    if not LStyles.GetElementColor(LStyles.GetElementDetails(tgCellNormal), ecTextColor, LColor) or  (LColor = clNone) then
      LColor := LStyles.GetSystemColor(clWindowText);
    //get and set the background color
    Canvas.Brush.Color := LStyles.GetStyleColor(scEdit);
    Canvas.Font.Color := LColor;

    if LStyles.Enabled and (vsSelected in PaintInfo.Node.States) then
    begin
       Canvas.Brush.Color := LStyles.GetSystemColor(clHighlight);
       Canvas.Font.Color := LStyles.GetStyleFontColor(sfMenuItemTextSelected);// GetSystemColor(clHighlightText);
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

    S := Data.Filename;

    if Length(S) > 0 then
    begin
      Format := DT_TOP or DT_LEFT or DT_VCENTER or DT_SINGLELINE;

      DrawText(Canvas.Handle, S, Length(S), R, Format);
      R.Left := R.Left + Canvas.TextWidth(S);
      S := System.SysUtils.Format(' (%s)', [Data.FilePath]);
      if LStyles.Enabled then
        Canvas.Font.Color := LStyles.GetStyleFontColor(sfEditBoxTextDisabled)
      else
        Canvas.Font.Color := clBtnFace;
      DrawText(Canvas.Handle, S, Length(S), R, Format);
    end;
  end;
end;

procedure TSearchForFilesForm.SearchVirtualDrawTreeFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  Data: PSearchRec;
begin
  Data := Sender.GetNodeData(Node);
  Finalize(Data^);
  inherited;
end;

procedure TSearchForFilesForm.SearchVirtualDrawTreeGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: Integer);
var
  Data: PSearchRec;
begin
  Data := SearchVirtualDrawTree.GetNodeData(Node);
  if Assigned(Data) then
    ImageIndex := Data.ImageIndex;
end;

procedure TSearchForFilesForm.SearchVirtualDrawTreeGetNodeWidth(Sender: TBaseVirtualTree; HintCanvas: TCanvas;
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

procedure TSearchForFilesForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WriteIniFile;
  FFormClosing := True;
  Application.ProcessMessages;
  Action := caFree;
end;

procedure TSearchForFilesForm.FormCreate(Sender: TObject);
var
  SHFileInfo: TSHFileInfo;
  PathInfo: String;
  SysImageList: THandle;
begin
  FFormClosing := False;
  SearchVirtualDrawTree.NodeDataSize := SizeOf(TSearchRec);
  SearchVirtualDrawTree.Images := TBCImageList.Create(Self);
  SysImageList := SHGetFileInfo(PChar(PathInfo), 0, SHFileInfo, SizeOf(SHFileInfo), SHGFI_SYSICONINDEX or SHGFI_SMALLICON);
  if SysImageList <> 0 then
  begin
    SearchVirtualDrawTree.Images.Handle := SysImageList;
    SearchVirtualDrawTree.Images.BkColor := ClNone;
    SearchVirtualDrawTree.Images.ShareImages := True;
  end;
end;

procedure TSearchForFilesForm.FormDestroy(Sender: TObject);
begin
  FProgressBar.Free;
  SearchVirtualDrawTree.Images.Free;
  FSearchForFilesForm := nil;
end;

procedure TSearchForFilesForm.FormResize(Sender: TObject);
begin
  ResizeProgressBar;
end;

procedure TSearchForFilesForm.FormShow(Sender: TObject);
begin
  CreateProgressBar;
end;

procedure TSearchForFilesForm.Open(RootDirectory: string);
var
  T1, T2: TTime;
  Min, Secs: Integer;
  TimeDifference: string;
begin
  SearchingFilesPanel.Visible := True;
  SearchForEdit.ReadOnly := True;
  ReadIniFile;
  Show;
  SearchVirtualDrawTree.BeginUpdate;
  Screen.Cursor := crHourGlass;
  try
    StatusBar.Panels[0].Text := LanguageDataModule.GetConstant('CountingFiles');
    Application.ProcessMessages;
    FProgressBar.Count := CountFilesInFolder(RootDirectory);
  finally
    Screen.Cursor := crDefault;
  end;
  FProgressBar.Show;
  T1 := Now;
  try
    ReadFiles(RootDirectory);
  finally
    FProgressBar.Hide;
    if not FFormClosing then
    begin
      T2 := Now;
      Min := StrToInt(FormatDateTime('n', T2 - T1));
      Secs := Min * 60 + StrToInt(FormatDateTime('s', T2 - T1));
      if Secs < 60 then
        TimeDifference := FormatDateTime(Format('s.zzz "%s"', [LanguageDataModule.GetConstant('Second')]), T2 - T1)
      else
        TimeDifference := FormatDateTime(Format('n "%s" s.zzz "%s"', [LanguageDataModule.GetConstant('Minute'), LanguageDataModule.GetConstant('Second')]), T2 - T1);
      StatusBar.Panels[0].Text := Format(LanguageDataModule.GetConstant('FilesFound'), [FProgressBar.Count, TimeDifference]);
      SearchVirtualDrawTree.Sort(nil, 0, sdAscending, False);

      SearchVirtualDrawTree.EndUpdate;
      SearchingFilesPanel.Visible := False;
      SearchForEdit.ReadOnly := False;
    end;
  end;
end;

procedure TSearchForFilesForm.ReadIniFile;
begin
  with TMemIniFile.Create(GetIniFilename) do
  try
    { Size }
    Width := ReadInteger('SearchForFilesSize', 'Width', Width);
    Height := ReadInteger('SearchForFilesSize', 'Height', Height);
    { Position }
    Left := ReadInteger('SearchForFilesPosition', 'Left', (Screen.Width - Width) div 2);
    Top := ReadInteger('SearchForFilesPosition', 'Top', (Screen.Height - Height) div 2);
    { Check if the form is outside the workarea }
    Left := SetFormInsideWorkArea(Left, Width);
  finally
    Free;
  end;
end;

procedure TSearchForFilesForm.WriteIniFile;
begin
  if Windowstate = wsNormal then
  with TMemIniFile.Create(GetIniFilename) do
  try
    { Size }
    WriteInteger('SearchForFilesSize', 'Width', Width);
    WriteInteger('SearchForFilesSize', 'Height', Height);
    { Position }
    WriteInteger('SearchForFilesPosition', 'Left', Left);
    WriteInteger('SearchForFilesPosition', 'Top', Top);
  finally
    UpdateFile;
    Free;
  end;
end;

procedure TSearchForFilesForm.ReadFiles(RootDirectory: string);
var
  Node: PVirtualNode;
  NodeData: PSearchRec;
  shFindFile: THandle;
  sWin32FD: TWin32FindData;
  FName: string;

  function IsDirectory(dWin32FD: TWin32FindData): Boolean;
  var
    TmpAttr: DWORD;
  begin
    with dWin32FD do
    begin
      TmpAttr := dwFileAttributes and (FILE_ATTRIBUTE_READONLY or FILE_ATTRIBUTE_HIDDEN or FILE_ATTRIBUTE_SYSTEM or FILE_ATTRIBUTE_ARCHIVE or FILE_ATTRIBUTE_NORMAL or FILE_ATTRIBUTE_DIRECTORY);

      Result := (TmpAttr and FILE_ATTRIBUTE_DIRECTORY = FILE_ATTRIBUTE_DIRECTORY);
    end;
  end;
begin
  if FFormClosing then
    Exit;
  {$WARNINGS OFF} { IncludeTrailingBackslash is specific to a platform }
  shFindFile := FindFirstFile(PChar(IncludeTrailingBackslash(RootDirectory) + '*.*'), sWin32FD);
  {$WARNINGS ON}
  if shFindFile <> INVALID_HANDLE_VALUE then
  try
    repeat
      if FFormClosing then
        Exit;
      FName := StrPas(sWin32FD.cFileName);
      if (FName <> '.') and (FName <> '..') then
      begin
        if IsDirectory(sWin32FD) then
          {$WARNINGS OFF} { IncludeTrailingBackslash is specific to a platform }
          ReadFiles(IncludeTrailingBackslash(RootDirectory) + FName)
          {$WARNINGS ON}
        else
        begin
          FProgressBar.StepIt;
          Application.ProcessMessages;
          if not FFormClosing then
          begin
            Node := SearchVirtualDrawTree.AddChild(nil);
            NodeData := SearchVirtualDrawTree.GetNodeData(Node);
            NodeData.FileName := FName;
            {$WARNINGS OFF} { ExcludeTrailingBackslash is specific to a platform }
            NodeData.FilePath := ExcludeTrailingBackslash(RootDirectory);
            NodeData.ImageIndex := GetIconIndex(IncludeTrailingBackslash(RootDirectory) + FName);
            {$WARNINGS ON}
          end;
        end;
      end;
    until not FindNextFile(shFindFile, sWin32FD) and not FFormClosing;
  finally
    Winapi.Windows.FindClose(shFindFile);
  end;
end;

end.
