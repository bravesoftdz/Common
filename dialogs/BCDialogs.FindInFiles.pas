unit BCDialogs.FindInFiles;

interface

uses
  System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, Vcl.ExtCtrls, JvToolEdit,
  BCControls.ComboBox, Vcl.Themes, Vcl.ActnList, Vcl.Buttons, BCDialogs.Dlg, System.Actions, BCControls.Edit,
  Vcl.ComCtrls, JvExControls, JvSpeedButton, BCControls.CheckBox, BCControls.LayoutPanel, BCControls.GroupBox;

type
  TFindInFilesDialog = class(TDialog)
    ActionList: TActionList;
    FolderButtonClickAction: TAction;
    FindWhatPanel: TPanel;
    TextToFindLabel: TLabel;
    FindWhatComboPanel: TPanel;
    FindWhatComboBox: TBCComboBox;
    OptionsGroupBox: TBCGroupBox;
    CaseSensitiveCheckBox: TBCCheckBox;
    SearchDirectoryOptionsGroupBox: TBCGroupBox;
    Panel1: TPanel;
    FileMaskLabel: TLabel;
    FileTypeComboPanel: TPanel;
    FileMaskComboBox: TBCComboBox;
    FolderPanel: TPanel;
    DirectoryLabel: TLabel;
    FolderEditPanel: TPanel;
    DirectorySpeedButton: TJvSpeedButton;
    FolderEdit2Panel: TPanel;
    DirectoryEdit: TBCEdit;
    CheckBoxPanel: TPanel;
    IncludeSubdirectoriesCheckBox: TBCCheckBox;
    ButtonsPanel: TPanel;
    FindButton: TButton;
    CancelButton: TButton;
    ButtonDivider1Panel: TPanel;
    procedure FindWhatComboBoxKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FolderButtonClickActionExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    function GetFileTypeText: string;
    function GetFindWhatText: string;
    function GetFolderText: string;
    function GetLookInSubfolders: Boolean;
    function GetSearchCaseSensitive: Boolean;
    procedure SetButtons;
    procedure SetExtensions(Value: string);
    procedure SetFolderText(Value: string);
  public
    { Public declarations }
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
  BCCommon.StyleUtils, System.Math, BCCommon.LanguageStrings, BCCommon.Lib, BCCommon.StringUtils,
  {$WARNINGS OFF}
  Vcl.FileCtrl; { warning: FileCtrl is specific to a platform }
  {$WARNINGS ON}

var
  FFindInFilesDialog: TFindInFilesDialog;

function FindInFilesDialog: TFindInFilesDialog;
begin
  if not Assigned(FFindInFilesDialog) then
  begin
    Application.CreateForm(TFindInFilesDialog, FFindInFilesDialog);
    if Assigned(TStyleManager.Engine) then
      TStyleManager.Engine.RegisterStyleHook(TJvDirectoryEdit, TEditStyleHook);
  end;
  Result := FFindInFilesDialog;
  SetStyledFormSize(Result);
end;

procedure TFindInFilesDialog.FormDestroy(Sender: TObject);
begin
  FFindInFilesDialog := nil;
end;

procedure TFindInFilesDialog.FormShow(Sender: TObject);
begin
  inherited;
  SetButtons;
  if FindWhatComboBox.CanFocus then
    FindWhatComboBox.SetFocus;
end;

function TFindInFilesDialog.GetFindWhatText: string;
begin
  Result := FindWhatComboBox.Text;
end;

function TFindInFilesDialog.GetFileTypeText: string;
begin
  Result := FileMaskComboBox.Text;
end;

function TFindInFilesDialog.GetFolderText: string;
begin
  Result := Trim(DirectoryEdit.Text);
  {$WARNINGS OFF} { IncludeTrailingBackslash is specific to a platform }
  if Result <> '' then
    Result := IncludeTrailingBackslash(Result);
  {$WARNINGS ON}
end;

procedure TFindInFilesDialog.SetFolderText(Value: string);
begin
  DirectoryEdit.Text := Value;
end;

function TFindInFilesDialog.GetSearchCaseSensitive: Boolean;
begin
  Result := CaseSensitiveCheckBox.Checked;
end;

function TFindInFilesDialog.GetLookInSubfolders: Boolean;
begin
  Result := IncludeSubdirectoriesCheckBox.Checked;
end;

procedure TFindInFilesDialog.SetButtons;
begin
  FindButton.Enabled := Trim(FindWhatComboBox.Text) <> '';
end;

procedure TFindInFilesDialog.FindWhatComboBoxKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  SetButtons;
end;

procedure TFindInFilesDialog.FolderButtonClickActionExecute(Sender: TObject);
var
  Dir: string;
begin
  Dir := DirectoryEdit.Text;
  if Vcl.FileCtrl.SelectDirectory(LanguageDataModule.GetConstant('SelectRootDirectory'), '', Dir, [sdNewFolder,
    sdShowShares, sdNewUI, sdValidateDir], Self) then
    DirectoryEdit.Text := Dir;
end;

procedure TFindInFilesDialog.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if ModalResult = mrOK then
    InsertTextToCombo(FindWhatComboBox);
end;

procedure TFindInFilesDialog.SetExtensions(Value: string);
var
  Temp: string;
begin
  Temp := Value;
  with FileMaskComboBox.Items do
  begin
    Clear;
    while Pos('|', Temp) <> 0 do
    begin
      Add(GetNextToken('|', Temp));
      Temp := RemoveTokenFromStart('|', Temp);
    end;
  end;
end;

end.
