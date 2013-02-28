unit FindInFiles;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask, JvExMask, JvToolEdit,
  BCComboBox, JvExStdCtrls, JvCombobox, Vcl.Themes, Vcl.ActnList, Vcl.Buttons, JvEdit, BCEdit, Dlg;

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
    FolderBitBtn: TBitBtn;
    FolderButtonClickAction: TAction;
    FolderEdit: TBCEdit;
    FolderLabel: TLabel;
    LeftPanel: TPanel;
    LookInSubfoldersCheckBox: TCheckBox;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
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
  Common, StyleHooks, System.Math, Language,
  {$WARNINGS OFF}
  Vcl.FileCtrl; { warning: FileCtrl is specific to a platform }
  {$WARNINGS ON}

var
  FFindInFilesDialog: TFindInFilesDialog;

function FindInFilesDialog: TFindInFilesDialog;
begin
  if FFindInFilesDialog = nil then
  begin
    Application.CreateForm(TFindInFilesDialog, FFindInFilesDialog);
    TStyleManager.Engine.RegisterStyleHook(TJvDirectoryEdit, TEditStyleHook);
  end;
  Result := FFindInFilesDialog;
  StyleHooks.SetStyledFormSize(Result);
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
  Result := Common.AddSlash(FolderEdit.Text);
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
  if Vcl.FileCtrl.SelectDirectory(LanguageDataModule.GetConstant('SelectRootDirectory'), '', Dir, [sdNewFolder, sdShowShares,
    sdNewUI, sdValidateDir], Self) then
    FolderEdit.Text := Dir;
end;

procedure TFindInFilesDialog.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if ModalResult = mrOK then
    Common.InsertTextToCombo(FindWhatComboBox);
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
      Add(Copy(Temp, 1, Pos('|', Temp) - 1));
      Temp := Copy(Temp, Pos('|', Temp) + 1, Length(Temp));
    end;
  end;
end;

end.
