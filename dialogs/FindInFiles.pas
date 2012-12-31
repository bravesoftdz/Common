unit FindInFiles;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask, JvExMask, JvToolEdit,
  BCComboBox, JvExStdCtrls, JvCombobox, Vcl.Themes, Vcl.ActnList, Vcl.Buttons, JvEdit, BCEdit, Dlg;

type
  TFindInFilesDialog = class(TDialog)
    ButtonPanel: TPanel;
    ActionList: TActionList;
    FolderButtonClickAction: TAction;
    Panel1: TPanel;
    Panel2: TPanel;
    FindWhatLabel: TLabel;
    Panel3: TPanel;
    FileTypeLabel: TLabel;
    Panel4: TPanel;
    FolderLabel: TLabel;
    Panel5: TPanel;
    Panel6: TPanel;
    FindWhatComboBox: TBCComboBox;
    Panel7: TPanel;
    FileTypeComboBox: TBCComboBox;
    Panel8: TPanel;
    Panel9: TPanel;
    CaseSensitiveCheckBox: TCheckBox;
    LookInSubfoldersCheckBox: TCheckBox;
    Panel10: TPanel;
    FindButton: TButton;
    Panel11: TPanel;
    CancelButton: TButton;
    FolderBitBtn: TBitBtn;
    Panel12: TPanel;
    FolderEdit: TBCEdit;
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FindWhatComboBoxKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FolderButtonClickActionExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure SetButtons;
    function GetFindWhatText: string;
    function GetFileTypeText: string;
    function GetFolderText: string;
    procedure SetFolderText(Value: string);
    function GetSearchCaseSensitive: Boolean;
    function GetLookInSubfolders: Boolean;
    procedure SetExtensions(Value: string);
  public
    { Public declarations }
    property FindWhatText: string read GetFindWhatText;
    property FileTypeText: string read GetFileTypeText;
    property FolderText: string read GetFolderText write SetFolderText;
    property SearchCaseSensitive: Boolean read GetSearchCaseSensitive;
    property LookInSubfolders: Boolean read GetLookInSubfolders;
    property Extensions: string write SetExtensions;
  end;

function FindInFilesDialog: TFindInFilesDialog;

implementation

{$R *.dfm}

uses
  Common, StyleHooks,
  {$WARNINGS OFF}
  Vcl.FileCtrl, Language; { warning: FileCtrl is specific to a platform }
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
  SetButtons;
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
  if Vcl.FileCtrl.SelectDirectory(LanguageDataModule.ConstantMultiStringHolder.StringsByName['SelectRootDirectory'].Text, '', Dir, [sdNewFolder, sdShowShares,
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
