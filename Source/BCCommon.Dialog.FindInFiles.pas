unit BCCommon.Dialog.FindInFiles;

interface

uses
  System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, BCControl.ComboBox,
  Vcl.ActnList, BCCommon.Dialog.Base, sComboBox, BCControl.SpeedButton, BCControl.Panel, BCControl.GroupBox, sLabel,
  acSlider, System.Actions, Vcl.Buttons, sSpeedButton, sGroupBox, Vcl.ExtCtrls, sPanel, sRadioButton,
  BCEditor.Types, BCControl.RadioButton, sSkinProvider, BCCommon.Dialog.Popup.SearchEngine;

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
    PanelDirectoryComboBoxClient: TBCPanel;
    PanelDirectoryComboBoxAndButton: TBCPanel;
    SpeedButtonDirectory: TBCSpeedButton;
    ComboBoxFileMask: TBCComboBox;
    SliderCaseSensitive: TsSlider;
    StickyLabelCaseSensitive: TsStickyLabel;
    PanelIncludeSubdirectories: TBCPanel;
    StickyLabelIncludeSubdirectories: TsStickyLabel;
    SliderIncludeSubDirectories: TsSlider;
    PanelFileMaskComboBoxRight: TBCPanel;
    PanelFileMaskButton: TBCPanel;
    SpeedButtonFileMask: TBCSpeedButton;
    ActionFileMaskItemsButtonClick: TAction;
    ActionDirectoryItemsButtonClick: TAction;
    PanelTextToFind: TBCPanel;
    PanelTextToFindRight: TBCPanel;
    PanelTextToFindButton: TBCPanel;
    SpeedButtonTextToFind: TBCSpeedButton;
    PanelTextToFindClient: TBCPanel;
    ComboBoxTextToFind: TBCComboBox;
    ActionTextToFindItemsButtonClick: TAction;
    ActionFind: TAction;
    StickyLabelWholeWordsOnly: TsStickyLabel;
    SliderWholeWordsOnly: TsSlider;
    SpeedButtonSearchEngine: TBCSpeedButton;
    ActionSearchEngine: TAction;
    procedure ActionDirectoryButtonClickExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ActionFileMaskItemsButtonClickExecute(Sender: TObject);
    procedure ActionDirectoryItemsButtonClickExecute(Sender: TObject);
    procedure ComboBoxTextToFindChange(Sender: TObject);
    procedure ActionTextToFindItemsButtonClickExecute(Sender: TObject);
    procedure ActionFindUpdate(Sender: TObject);
    procedure ActionFindExecute(Sender: TObject);
    procedure ActionSearchEngineExecute(Sender: TObject);
  private
    FPopupSearchEngineDialog: TBCPopupSearchEngineDialog;
    FSearchEngine: TBCEditorSearchEngine;
    function GetFileTypeText: string;
    function GetFindWhatText: string;
    function GetFolderText: string;
    function GetLookInSubfolders: Boolean;
    function GetSearchCaseSensitive: Boolean;
    function GetWholeWordsOnly: Boolean;
    procedure SelectedSearchEngineClick(const ASearchEngine: TBCEditorSearchEngine);
    procedure SetButtons;
    procedure SetFindWhatText(const AValue: string);
    procedure SetFolderText(const AValue: string);
    procedure ReadIniFile;
    procedure UpdateCaption;
    procedure WriteIniFile;
    procedure WriteSection(const ASection: string; AStrings: TStrings; AIncludeTrailingPathDelimeter: Boolean = False);
  public
    function GetFileExtensions(const AFileExtensions: string): string;
    property FileTypeText: string read GetFileTypeText;
    property FindWhatText: string read GetFindWhatText write SetFindWhatText;
    property FolderText: string read GetFolderText write SetFolderText;
    property LookInSubfolders: Boolean read GetLookInSubfolders;
    property SearchEngine: TBCEditorSearchEngine read FSearchEngine;
    property SearchCaseSensitive: Boolean read GetSearchCaseSensitive;
    property WholeWordsOnly: Boolean read GetWholeWordsOnly;
  end;

function FindInFilesDialog: TFindInFilesDialog;

implementation

{$R *.dfm}

uses
  BCCommon.Language.Strings, BCCommon.Utils, System.IniFiles, System.Math,
  {$WARNINGS OFF}
  Vcl.FileCtrl, { warning: FileCtrl is specific to a platform }
  {$WARNINGS ON}
  Vcl.ValEdit, BCCommon.FileUtils, BCCommon.Dialog.ItemList;

var
  LFindInFilesDialog: TFindInFilesDialog;

function FindInFilesDialog: TFindInFilesDialog;
begin
  if not Assigned(LFindInFilesDialog) then
    Application.CreateForm(TFindInFilesDialog, LFindInFilesDialog);
  Result := LFindInFilesDialog;
  Result.ReadIniFile;
  AlignSliders(Result.GroupBoxSearchOptions, 12);
  AlignSliders(Result.GroupBoxSearchDirectoryOptions, 12);
end;

procedure TFindInFilesDialog.FormDestroy(Sender: TObject);
begin
  LFindInFilesDialog := nil;
end;

procedure TFindInFilesDialog.FormShow(Sender: TObject);
begin
  inherited;
  SetButtons;
  if ComboBoxTextToFind.CanFocus then
    ComboBoxTextToFind.SetFocus;
  UpdateCaption;
end;

procedure TFindInFilesDialog.UpdateCaption;
begin
  Caption := Format('%s (%s)', [OrigCaption, SearchEngineToString(FSearchEngine)]);
end;

function TFindInFilesDialog.GetFindWhatText: string;
begin
  Result := ComboBoxTextToFind.Text;
end;

procedure TFindInFilesDialog.SetFindWhatText(const AValue: string);
begin
  ComboBoxTextToFind.Text := AValue;
  SetButtons;
end;

function TFindInFilesDialog.GetFileExtensions(const AFileExtensions: string): string;
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
  if Trim(ComboBoxFileMask.Text) = '' then
    Result := '*.*'
  else
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

procedure TFindInFilesDialog.SetFolderText(const AValue: string);
begin
  ComboBoxDirectory.Text := AValue;
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

procedure TFindInFilesDialog.WriteSection(const ASection: string; AStrings: TStrings; AIncludeTrailingPathDelimeter: Boolean = False);
var
  i: Integer;
  LString: string;
begin
  with TMemIniFile.Create(GetUniIniFilename, TEncoding.Unicode) do
  try
    EraseSection(ASection);
    for i := 0 to AStrings.Count - 1 do
    begin
      LString := AStrings[i];
      if AIncludeTrailingPathDelimeter then
        LString := IncludeTrailingPathDelimiter(LString);

      WriteString(ASection, IntToStr(i), LString);
    end;
    UpdateFile;
  finally
    Free;
  end;
end;

procedure TFindInFilesDialog.ActionDirectoryItemsButtonClickExecute(Sender: TObject);
begin
  with TItemListDialog.Create(Self) do
  try
    Caption := LanguageDataModule.GetConstant('DirectoryItems');
    ListBox.Items.Assign(ComboBoxDirectory.Items);
    if ShowModal = mrOk then
    begin
      ComboBoxDirectory.Items.Assign(ListBox.Items);
      WriteSection('FindInFilesDirectories', ListBox.Items, True);
    end;
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
    begin
      ComboBoxFileMask.Items.Assign(ListBox.Items);
      WriteSection('FindInFilesFileMasks', ListBox.Items);
    end;
  finally
    Free;
  end;
end;

procedure TFindInFilesDialog.ActionFindExecute(Sender: TObject);
begin
  inherited;
  ModalResult := mrOk;
end;

procedure TFindInFilesDialog.ActionFindUpdate(Sender: TObject);
begin
  inherited;
  ActionFind.Enabled := (Trim(ComboBoxTextToFind.Text) <> '') and (Trim(ComboBoxDirectory.Text) <> '')
end;

procedure TFindInFilesDialog.ActionSearchEngineExecute(Sender: TObject);
begin
  inherited;
  if not Assigned(FPopupSearchEngineDialog) then
  begin
    FPopupSearchEngineDialog := TBCPopupSearchEngineDialog.Create(Self);
    FPopupSearchEngineDialog.PopupParent := Self;
    FPopupSearchEngineDialog.OnSelectSearchEngine := SelectedSearchEngineClick;
  end;
  LockPaint;
  FPopupSearchEngineDialog.Execute(FSearchEngine);
  UnlockPaint;
end;

procedure TFindInFilesDialog.SelectedSearchEngineClick(const ASearchEngine: TBCEditorSearchEngine);
begin
  FSearchEngine := ASearchEngine;
  UpdateCaption;
end;

procedure TFindInFilesDialog.ActionTextToFindItemsButtonClickExecute(Sender: TObject);
begin
  with TItemListDialog.Create(Self) do
  try
    Caption := LanguageDataModule.GetConstant('TextToFindItems');
    ListBox.Items.Assign(ComboBoxTextToFind.Items);
    if ShowModal = mrOk then
    begin
      ComboBoxTextToFind.Items.Assign(ListBox.Items);
      WriteSection('TextToFindItems', ListBox.Items);
    end;
  finally
    Free;
  end;
end;

procedure TFindInFilesDialog.ComboBoxTextToFindChange(Sender: TObject);
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
    WriteIniFile;
end;

procedure TFindInFilesDialog.ReadIniFile;
var
  LValueListEditor: TValueListEditor;
begin
  LValueListEditor := TValueListEditor.Create(nil);
  with TMemIniFile.Create(GetUniIniFilename, TEncoding.Unicode) do
  try
    FSearchEngine := TBCEditorSearchEngine(ReadInteger('FindInFiles', 'Engine', 0));

    SliderCaseSensitive.SliderOn := ReadBool('FindInFilesOptions', 'CaseSensitive', False);
    SliderIncludeSubDirectories.SliderOn := ReadBool('FindInFilesOptions', 'IncludeSubDirectories', True);

    ReadSectionValues('TextToFindItems', LValueListEditor.Strings);
    InsertItemsToComboBox(LValueListEditor, ComboBoxTextToFind);

    ReadSectionValues('FindInFilesFileMasks', LValueListEditor.Strings);
    InsertItemsToComboBox(LValueListEditor, ComboBoxFileMask);

    ReadSectionValues('FindInFilesDirectories', LValueListEditor.Strings);
    InsertItemsToComboBox(LValueListEditor, ComboBoxDirectory);

    ComboBoxTextToFind.ItemIndex := ComboBoxTextToFind.Items.IndexOf(ReadString('FindInFilesOptions', 'TextToFind', ''));
    ComboBoxFileMask.ItemIndex := ComboBoxFileMask.Items.IndexOf(ReadString('FindInFilesOptions', 'FileMask', ''));
    if ComboBoxFileMask.Text = '' then
      ComboBoxFileMask.Text := '*.*';
    ComboBoxDirectory.ItemIndex := ComboBoxDirectory.Items.IndexOf(ReadString('FindInFilesOptions', 'Directory', ''));
  finally
    LValueListEditor.Free;
    Free;
  end;
end;

procedure TFindInFilesDialog.WriteIniFile;
var
  LIndex: Integer;
begin
  with TMemIniFile.Create(GetUniIniFilename, TEncoding.Unicode) do
  try
    WriteInteger('FindInFiles', 'Engine', Integer(FSearchEngine));
    WriteBool('FindInFilesOptions', 'CaseSensitive', SliderCaseSensitive.SliderOn);
    WriteBool('FindInFilesOptions', 'IncludeSubDirectories', SliderIncludeSubDirectories.SliderOn);

    LIndex := InsertTextToCombo(ComboBoxTextToFind);
    if LIndex <> -1 then
      WriteString('TextToFindItems', IntToStr(LIndex), ComboBoxTextToFind.Items[0]);

    LIndex := InsertTextToCombo(ComboBoxFileMask);
    if LIndex <> -1 then
      WriteString('FindInFilesFileMasks', IntToStr(LIndex), ComboBoxFileMask.Items[0]);

    LIndex := InsertTextToCombo(ComboBoxDirectory);
    if LIndex <> -1 then
      WriteString('FindInFilesDirectories', IntToStr(LIndex), IncludeTrailingPathDelimiter(ComboBoxDirectory.Items[0]));

    WriteString('FindInFilesOptions', 'TextToFind', ComboBoxTextToFind.Text);
    WriteString('FindInFilesOptions', 'FileMask', ComboBoxFileMask.Text);
    WriteString('FindInFilesOptions', 'Directory', IncludeTrailingPathDelimiter(ComboBoxDirectory.Text));
    UpdateFile;
  finally
    Free;
  end;
end;

function TFindInFilesDialog.GetWholeWordsOnly: Boolean;
begin
  Result := SliderWholeWordsOnly.SliderOn;
end;

end.
