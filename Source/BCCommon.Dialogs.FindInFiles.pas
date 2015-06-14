unit BCCommon.Dialogs.FindInFiles;

interface

uses
  System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, Vcl.ExtCtrls,
  BCControls.ComboBox, Vcl.ActnList, Vcl.Buttons, BCCommon.Dialogs.Base, System.Actions,
  Vcl.ComCtrls, sComboBox, sSpeedButton, BCControls.SpeedButton, BCControls.Panel, sPanel,
  sGroupBox, BCControls.GroupBox, sLabel, acSlider;

type
  TFindInFilesDialog = class(TBCBaseDialog)
    ActionDirectoryButtonClick: TAction;
    ActionList: TActionList;
    ButtonCancel: TButton;
    ButtonFind: TButton;
    ComboBoxDirectory: TBCComboBox;
    GroupBoxSearchDirectoryOptions: TBCGroupBox;
    GroupBoxSearchOptions: TBCGroupBox;
    PanelButtons: TBCPanel;
    PanelDirectoryComboBox: TBCPanel;
    PanelDirectoryComboBoxAndButton: TBCPanel;
    SpeedButtonDirectory: TBCSpeedButton;
    ComboBoxTextToFind: TBCComboBox;
    ComboBoxFileMask: TBCComboBox;
    SliderCaseSensitive: TsSlider;
    StickyLabelCaseSensitive: TsStickyLabel;
    BCPanel1: TBCPanel;
    StickyLabelIncludeSubdirectories: TsStickyLabel;
    SliderIncludeSubDirectories: TsSlider;
    BCPanel2: TBCPanel;
    BCPanel3: TBCPanel;
    BCSpeedButton1: TBCSpeedButton;
    ActionFileMaskItemsButtonClick: TAction;
    ActionDirectoryItemsButtonClick: TAction;
    procedure ComboBoxTextToFindKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ActionDirectoryButtonClickExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ActionFileMaskItemsButtonClickExecute(Sender: TObject);
    procedure ActionDirectoryItemsButtonClickExecute(Sender: TObject);
  private
    function GetFileTypeText: string;
    function GetFindWhatText: string;
    function GetFolderText: string;
    function GetLookInSubfolders: Boolean;
    function GetSearchCaseSensitive: Boolean;
    procedure SetButtons;
    procedure SetFolderText(Value: string);
    procedure ReadIniFile;
    procedure WriteIniFile;
  public
    function GetFileExtensions(AFileExtensions: string): string;
    property FileTypeText: string read GetFileTypeText;
    property FindWhatText: string read GetFindWhatText;
    property FolderText: string read GetFolderText write SetFolderText;
    property LookInSubfolders: Boolean read GetLookInSubfolders;
    property SearchCaseSensitive: Boolean read GetSearchCaseSensitive;
  end;

function FindInFilesDialog: TFindInFilesDialog;

implementation

{$R *.dfm}

uses
  System.Math, BCCommon.Language.Strings, BCCommon.Utils, BCCommon.StringUtils, System.IniFiles,
  {$WARNINGS OFF}
  Vcl.FileCtrl, { warning: FileCtrl is specific to a platform }
  {$WARNINGS ON}
  BCCommon.FileUtils, BCCommon.Dialogs.ItemList;

var
  FFindInFilesDialog: TFindInFilesDialog;

function FindInFilesDialog: TFindInFilesDialog;
begin
  if not Assigned(FFindInFilesDialog) then
    Application.CreateForm(TFindInFilesDialog, FFindInFilesDialog);
  Result := FFindInFilesDialog;
  Result.ReadIniFile;
end;

procedure TFindInFilesDialog.FormDestroy(Sender: TObject);
begin
  FFindInFilesDialog := nil;
end;

procedure TFindInFilesDialog.FormShow(Sender: TObject);
begin
  inherited;
  SetButtons;
  if ComboBoxTextToFind.CanFocus then
    ComboBoxTextToFind.SetFocus;
end;

function TFindInFilesDialog.GetFindWhatText: string;
begin
  Result := ComboBoxTextToFind.Text;
end;

function TFindInFilesDialog.GetFileExtensions(AFileExtensions: string): string;
var
  i: Integer;
  s, LFileExtension: string;

  procedure AddFileExtension;
  begin
    if Pos(LFileExtension, Result) = 0 then
      Result := Result + LFileExtension;
  end;

begin
  Result := AFileExtensions;
  for i := 1 to ComboBoxFileMask.Items.Count - 1 do { start from 1 because first is *.* }
  begin
    s := ComboBoxFileMask.Items[i];
    while Pos(';', s) <> 0 do
    begin
      LFileExtension := Copy(s, 1, Pos(';', s));
      AddFileExtension;
      s := Copy(s, Pos(';', s) + 1, Length(s));
    end;
    LFileExtension := s + ';';
    AddFileExtension;
  end;
end;

function TFindInFilesDialog.GetFileTypeText: string;
begin
  Result := ComboBoxFileMask.Text;
end;

function TFindInFilesDialog.GetFolderText: string;
begin
  Result := Trim(ComboBoxDirectory.Text);
  {$WARNINGS OFF} { IncludeTrailingBackslash is specific to a platform }
  if Result <> '' then
    Result := IncludeTrailingBackslash(Result);
  {$WARNINGS ON}
end;

procedure TFindInFilesDialog.SetFolderText(Value: string);
begin
  ComboBoxDirectory.Text := Value;
end;

function TFindInFilesDialog.GetSearchCaseSensitive: Boolean;
begin
  Result := SliderCaseSensitive.SliderOn;
end;

function TFindInFilesDialog.GetLookInSubfolders: Boolean;
begin
  Result := SliderIncludeSubdirectories.SliderOn;
end;

procedure TFindInFilesDialog.SetButtons;
begin
  ButtonFind.Enabled := Trim(ComboBoxTextToFind.Text) <> '';
end;

procedure TFindInFilesDialog.ActionDirectoryItemsButtonClickExecute(Sender: TObject);
begin
  with TItemListDialog.Create(Self) do
  try
    Caption := LanguageDataModule.GetConstant('DirectoryItems');
    ListBox.Items.Assign(ComboBoxDirectory.Items);
    if ShowModal = mrOk then
      ComboBoxDirectory.Items.Assign(ListBox.Items);
  finally
    Free;
  end;
end;

procedure TFindInFilesDialog.ActionFileMaskItemsButtonClickExecute(Sender: TObject);
begin
  with TItemListDialog.Create(Self) do
  try
    Caption := LanguageDataModule.GetConstant('FileMaskItems');
    ListBox.Items.Assign(ComboBoxFileMask.Items);
    if ShowModal = mrOk then
      ComboBoxFileMask.Items.Assign(ListBox.Items);
  finally
    Free;
  end;
end;

procedure TFindInFilesDialog.ComboBoxTextToFindKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  SetButtons;
end;

procedure TFindInFilesDialog.ActionDirectoryButtonClickExecute(Sender: TObject);
var
  Dir: string;
begin
  Dir := ComboBoxDirectory.Text;
  if Vcl.FileCtrl.SelectDirectory(LanguageDataModule.GetConstant('SelectRootDirectory'), '', Dir, [sdNewFolder,
    sdShowShares, sdNewUI, sdValidateDir], Self) then
    ComboBoxDirectory.Text := Dir;
end;

procedure TFindInFilesDialog.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if ModalResult = mrOK then
  begin
    InsertTextToCombo(ComboBoxTextToFind);
    InsertTextToCombo(ComboBoxDirectory);
    InsertTextToCombo(ComboBoxFileMask);
  end;
  WriteIniFile;
end;

procedure TFindInFilesDialog.ReadIniFile;
var
  LItems: TStrings;

  procedure InsertItemsToComboBox(AComboBox: TBCComboBox);
  var
    i: Integer;
    s: string;
  begin
    if LItems.Count > 0 then
    begin
      AComboBox.Clear;
      for i := 0 to LItems.Count - 1 do
      begin
        s := GetTokenAfter('=', LItems.Strings[i]);
        if AComboBox.Items.IndexOf(s) = -1 then
          AComboBox.Items.Add(s);
      end;
    end;
  end;

begin
  LItems := TStringList.Create;
  with TIniFile.Create(GetIniFilename) do
  try
    SliderCaseSensitive.SliderOn := ReadBool('FindInFilesOptions', 'CaseSensitive', False);
    SliderIncludeSubDirectories.SliderOn := ReadBool('FindInFilesOptions', 'IncludeSubDirectories', True);

    ReadSectionValues('FindInFilesFileMasks', LItems);
    InsertItemsToComboBox(ComboBoxFileMask);
    ReadSectionValues('FindInFilesDirectories', LItems);
    InsertItemsToComboBox(ComboBoxDirectory);

    ComboBoxFileMask.ItemIndex := ComboBoxFileMask.Items.IndexOf(ReadString('FindInFilesOptions', 'FileMask', '*.*'));
    ComboBoxDirectory.ItemIndex := ComboBoxDirectory.Items.IndexOf(ReadString('FindInFilesOptions', 'Directory', ''));
  finally
    LItems.Free;
    Free;
  end;
end;

procedure TFindInFilesDialog.WriteIniFile;
var
  i: Integer;
begin
  with TIniFile.Create(GetIniFilename) do
  try
    WriteBool('FindInFilesOptions', 'CaseSensitive', SliderCaseSensitive.SliderOn);
    WriteBool('FindInFilesOptions', 'IncludeSubDirectories', SliderIncludeSubDirectories.SliderOn);

    EraseSection('FindInFilesFileMasks');
    for i := 0 to ComboBoxFileMask.Items.Count - 1 do
      WriteString('FindInFilesFileMasks', IntToStr(i), ComboBoxFileMask.Items[i]);
    EraseSection('FindInFilesDirectories');
    for i := 0 to ComboBoxDirectory.Items.Count - 1 do
      WriteString('FindInFilesDirectories', IntToStr(i), IncludeTrailingPathDelimiter(ComboBoxDirectory.Items[i]));

    WriteString('FindInFilesOptions', 'FileMask', ComboBoxFileMask.Text);
    WriteString('FindInFilesOptions', 'Directory', ComboBoxDirectory.Text);
  finally
    Free;
  end;
end;

end.
