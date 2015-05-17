unit BCCommon.Dialogs.FindInFiles;

interface

uses
  System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, Vcl.ExtCtrls,
  BCControls.ComboBox, Vcl.ActnList, Vcl.Buttons, BCCommon.Dialogs.Base, System.Actions,
  Vcl.ComCtrls, sComboBox, sSpeedButton, BCControls.SpeedButton, BCControls.Panel, sPanel,
  sGroupBox, BCControls.GroupBox, sLabel, acSlider;

type
  TFindInFilesDialog = class(TBCBaseDialog)
    ActionFolderButtonClick: TAction;
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
    SliderIncludeSubdirectories: TsSlider;
    procedure ComboBoxTextToFindKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ActionFolderButtonClickExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    function GetFileTypeText: string;
    function GetFindWhatText: string;
    function GetFolderText: string;
    function GetLookInSubfolders: Boolean;
    function GetSearchCaseSensitive: Boolean;
    procedure SetButtons;
    procedure SetExtensions(Value: string);
    procedure SetFolderText(Value: string);
    procedure ReadIniFile;
    procedure WriteIniFile;
  public
    property Extensions: string write SetExtensions;
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
  BCCommon.FileUtils;

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

procedure TFindInFilesDialog.ComboBoxTextToFindKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  SetButtons;
end;

procedure TFindInFilesDialog.ActionFolderButtonClickExecute(Sender: TObject);
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
  WriteIniFile;
  if ModalResult = mrOK then
  begin
    InsertTextToCombo(ComboBoxTextToFind);
    InsertTextToCombo(ComboBoxDirectory);
  end;
end;

procedure TFindInFilesDialog.FormCreate(Sender: TObject);
begin
  ReadIniFile;
end;

procedure TFindInFilesDialog.SetExtensions(Value: string);
var
  Temp: string;
begin
  Temp := Value;
  with ComboBoxFileMask.Items do
  begin
    Clear;
    while Pos('|', Temp) <> 0 do
    begin
      Add(GetNextToken('|', Temp));
      Temp := RemoveTokenFromStart('|', Temp);
    end;
  end;
end;

procedure TFindInFilesDialog.ReadIniFile;
begin
  with TIniFile.Create(GetIniFilename) do
  try
    SliderCaseSensitive.SliderOn := ReadBool('FindInFilesOptions', 'CaseSensitive', False);
  finally
    Free;
  end;
end;

procedure TFindInFilesDialog.WriteIniFile;
begin
  with TIniFile.Create(GetIniFilename) do
  try
    WriteBool('FindInFilesOptions', 'CaseSensitive', SliderCaseSensitive.SliderOn);
  finally
    Free;
  end;
end;

end.
