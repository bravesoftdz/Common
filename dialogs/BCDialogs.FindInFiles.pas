unit BCDialogs.FindInFiles;

interface

uses
  System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, Vcl.ExtCtrls, JvToolEdit,
  BCControls.ComboBox, Vcl.Themes, Vcl.ActnList, Vcl.Buttons, BCDialogs.Dlg, System.Actions, BCControls.Edit,
  Vcl.ComCtrls, JvExControls, JvSpeedButton;

type
  TFindInFilesDialog = class(TDialog)
    ActionList: TActionList;
    ButtonPanel: TPanel;
    CancelButton: TButton;
    CaseSensitiveCheckBox: TCheckBox;
    CaseSensitiveLabel: TLabel;
    FileTypeComboBox: TBCComboBox;
    FileTypeLabel: TLabel;
    FindButton: TButton;
    FindWhatComboBox: TBCComboBox;
    FindWhatLabel: TLabel;
    FolderButtonClickAction: TAction;
    FolderEdit: TBCEdit;
    FolderLabel: TLabel;
    LeftPanel: TPanel;
    LookInSubfoldersCheckBox: TCheckBox;
    FindButtonPanel: TPanel;
    CancelButtonPanel: TPanel;
    FolderEdit2Panel: TPanel;
    FindWhatPanel: TPanel;
    FileTypePanel: TPanel;
    FolderPanel: TPanel;
    MiddlePanel: TPanel;
    FindWhatComboPanel: TPanel;
    FileTypeComboPanel: TPanel;
    FolderEditPanel: TPanel;
    CheckBoxPanel: TPanel;
    BitBtn1: TJvSpeedButton;
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
  LeftPanel.Width := Max(Max(FindWhatLabel.Width + 12, FileTypeLabel.Width + 12), FolderLabel.Width + 12);
  ButtonPanel.Width := Max(Max(Canvas.TextWidth(FindButton.Caption), Canvas.TextWidth(CancelButton.Caption)) + 10, 83);
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
  Result := FileTypeComboBox.Text;
end;

function TFindInFilesDialog.GetFolderText: string;
begin
  Result := Trim(FolderEdit.Text);
  {$WARNINGS OFF} { IncludeTrailingBackslash is specific to a platform }
  if Result <> '' then
    Result := IncludeTrailingBackslash(Result);
  {$WARNINGS ON}
end;

procedure TFindInFilesDialog.SetFolderText(Value: string);
begin
  FolderEdit.Text := Value;
end;

function TFindInFilesDialog.GetSearchCaseSensitive: Boolean;
begin
  Result := CaseSensitiveCheckBox.Checked;
end;

function TFindInFilesDialog.GetLookInSubfolders: Boolean;
begin
  Result := LookInSubfoldersCheckBox.Checked;
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
  Dir := FolderEdit.Text;
  if Vcl.FileCtrl.SelectDirectory(LanguageDataModule.GetConstant('SelectRootDirectory'), '', Dir, [sdNewFolder,
    sdShowShares, sdNewUI, sdValidateDir], Self) then
    FolderEdit.Text := Dir;
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
  with FileTypeComboBox.Items do
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
