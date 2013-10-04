unit BCForms.SearchForFiles;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, System.Actions, Vcl.ActnList, Vcl.ImgList, BCControls.ImageList,
  Vcl.StdCtrls, VirtualTrees;

type
  TSearchForFilesForm = class(TForm)
    SearchForEdit: TButtonedEdit;
    ActionList: TActionList;
    SearchVirtualDrawTree: TVirtualDrawTree;
    ImageList: TBCImageList;
    ClearAction: TAction;
    SearchAction: TAction;
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
  private
    { Private declarations }
    procedure ReadIniFile;
    procedure WriteIniFile;
    procedure ReadFiles(RootDirectory: string);
  public
    { Public declarations }
    procedure Open(RootDirectory: string);
  end;

function SearchForFilesForm: TSearchForFilesForm;

implementation

{$R *.dfm}

uses
  BCCommon.LanguageUtils, System.IniFiles, BCCommon.FileUtils, Vcl.Themes;

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
  if FSearchForFilesForm = nil then
    Application.CreateForm(TSearchForFilesForm, FSearchForFilesForm);
  Result := FSearchForFilesForm;
  UpdateLanguage(FSearchForFilesForm, GetSelectedLanguage);
end;

procedure TSearchForFilesForm.ClearActionExecute(Sender: TObject);
begin
  SearchForEdit.Text := '';
end;

procedure TSearchForFilesForm.SearchActionExecute(Sender: TObject);
begin
  SearchForEdit.RightButton.Visible := Trim(SearchForEdit.Text) <> '';
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

      DrawTextW(Canvas.Handle, PWideChar(S), Length(S), R, Format);
      R.Left := R.Left + Canvas.TextWidth(S);
      S := Format(' (%s)', [Data.FilePath]);
      if LStyles.Enabled then
        Canvas.Font.Color := LStyles.GetStyleFontColor(sfEditBoxTextDisabled)
      else
        Canvas.Font.Color := clBtnFace;
      DrawTextW(Canvas.Handle, PWideChar(S), Length(S), R, Format);
    end;
  end;
end;

procedure TSearchForFilesForm.SearchVirtualDrawTreeFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  Data: PSearchRec;
begin
  Data := Sender.GetNodeData(Node);

  if Assigned(Data) then
  begin
    Data^.Filename := '';
    Data^.FilePath := '';
  end;
end;

procedure TSearchForFilesForm.SearchVirtualDrawTreeGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: Integer);
begin
  // todo
end;

procedure TSearchForFilesForm.SearchVirtualDrawTreeGetNodeWidth(Sender: TBaseVirtualTree; HintCanvas: TCanvas;
  Node: PVirtualNode; Column: TColumnIndex; var NodeWidth: Integer);
var
  Data: PSearchRec;
  AMargin, BoldWidth: Integer;
  S: string;
begin
  with Sender as TVirtualDrawTree do
  begin
    AMargin := TextMargin;
    Data := Sender.GetNodeData(Node);
    NodeWidth := Canvas.TextWidth(Trim(Format('%s (%s)', [Data.FileName, Data.FilePath]))) + 2 * AMargin;
  end;
end;

procedure TSearchForFilesForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WriteIniFile;
  Action := caFree;
end;

procedure TSearchForFilesForm.FormDestroy(Sender: TObject);
begin
  FSearchForFilesForm := nil;
end;

procedure TSearchForFilesForm.Open(RootDirectory: string);
begin
  ReadIniFile;
  Show;
  ReadFiles(RootDirectory);
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
  {$WARNINGS OFF} { IncludeTrailingBackslash is specific to a platform }
  shFindFile := FindFirstFile(PChar(IncludeTrailingBackslash(RootDirectory) + '*.*'), sWin32FD);
  {$WARNINGS ON}
  if shFindFile <> INVALID_HANDLE_VALUE then
  try
    repeat
      Application.ProcessMessages;
      FName := StrPas(sWin32FD.cFileName);
      if (FName <> '.') and (FName <> '..') then
      begin
        if IsDirectory(sWin32FD) then
          {$WARNINGS OFF} { IncludeTrailingBackslash is specific to a platform }
          ReadFiles(IncludeTrailingBackslash(RootDirectory) + FName)
          {$WARNINGS ON}
        else
        begin
          Node := SearchVirtualDrawTree.AddChild(nil);
          NodeData := SearchVirtualDrawTree.GetNodeData(Node);
          NodeData.FileName := FName;
          NodeData.FilePath := RootDirectory;
        end;
      end;
    until not FindNextFile(shFindFile, sWin32FD);
  finally
    Winapi.Windows.FindClose(shFindFile);
  end;
end;

end.
