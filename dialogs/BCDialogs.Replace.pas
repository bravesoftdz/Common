unit BCDialogs.Replace;

{$I SynEdit.inc}

interface

uses
  System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, BCDialogs.Dlg, Vcl.ExtCtrls,
  BCControls.ComboBox, Vcl.StdCtrls, BCControls.CheckBox, BCControls.LayoutPanel, BCControls.GroupBox,
  BCControls.RadioButton;

type
  TReplaceDialog = class(TDialog)
    OptionsGroupBox: TBCGroupBox;
    CaseSensitiveCheckBox: TBCCheckBox;
    WholeWordsCheckBox: TBCCheckBox;
    RegularExpressionsCheckBox: TBCCheckBox;
    PromptOnReplaceCheckBox: TBCCheckBox;
    ReplaceInGroupBox: TBCGroupBox;
    WholeFileRadioButton: TBCRadioButton;
    AllOpenFilesRadioButton: TBCRadioButton;
    Controls1Panel: TPanel;
    SearchForLabel: TLabel;
    Controls2Panel: TPanel;
    SearchForComboBox: TBCComboBox;
    Controls3Panel: TPanel;
    ReplaceWithRadioButton: TBCRadioButton;
    Controls4Panel: TPanel;
    ReplaceWithComboBox: TBCComboBox;
    Controls5Panel: TPanel;
    DeleteLineRadioButton: TBCRadioButton;
    ButtonsPanel: TPanel;
    FindButton: TButton;
    ReplaceAllButton: TButton;
    CancelButton: TButton;
    ButtonDivider2Panel: TPanel;
    ButtonDivider1Panel: TPanel;
    WildCardCheckBox: TBCCheckBox;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SearchForComboBoxKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    function GetPromptOnReplace: Boolean;
    function GetRegularExpressions: Boolean;
    function GetReplaceInWholeFile: Boolean;
    function GetReplace: Boolean;
    function GetReplaceText: string;
    function GetSearchCaseSensitive: Boolean;
    function GetSearchText: string;
    function GetSearchWholeWords: Boolean;
    function GetWildCard: Boolean;
    procedure ReadIniFile;
    procedure WriteIniFile;
  public
    property PromptOnReplace: Boolean read GetPromptOnReplace;
    property RegularExpressions: Boolean read GetRegularExpressions;
    property Replace: Boolean read GetReplace;
    property ReplaceInWholeFile: Boolean read GetReplaceInWholeFile;
    property ReplaceText: string read GetReplaceText;
    property SearchCaseSensitive: Boolean read GetSearchCaseSensitive;
    property SearchText: string read GetSearchText;
    property SearchWholeWords: Boolean read GetSearchWholeWords;
    property WildCard: Boolean read GetWildCard;
  end;

function ReplaceDialog: TReplaceDialog;

implementation

{$R *.DFM}

uses
  BCCommon.StyleUtils, System.Math, BCCommon.Lib, System.IniFiles, BCCommon.FileUtils;

var
  FReplaceDialog: TReplaceDialog;

function ReplaceDialog: TReplaceDialog;
begin
  if not Assigned(FReplaceDialog) then
    Application.CreateForm(TReplaceDialog, FReplaceDialog);
  Result := FReplaceDialog;
  Result.ReadIniFile;
end;

procedure TReplaceDialog.FormDestroy(Sender: TObject);
begin
  FReplaceDialog := nil;
end;

procedure TReplaceDialog.FormShow(Sender: TObject);
begin
  inherited;

  if SearchForComboBox.CanFocus then
    SearchForComboBox.SetFocus;
end;

function TReplaceDialog.GetPromptOnReplace: Boolean;
begin
  Result := PromptOnReplaceCheckBox.Checked;
end;

function TReplaceDialog.GetRegularExpressions: Boolean;
begin
  Result := RegularExpressionsCheckBox.Checked;
end;

function TReplaceDialog.GetReplace: Boolean;
begin
  Result := ReplaceWithRadioButton.Checked;
end;

function TReplaceDialog.GetReplaceText: string;
begin
  Result := ReplaceWithComboBox.Text;
end;

function TReplaceDialog.GetSearchCaseSensitive: Boolean;
begin
  Result := CaseSensitiveCheckBox.Checked;
end;

function TReplaceDialog.GetSearchText: string;
begin
  Result := SearchForComboBox.Text;
end;

function TReplaceDialog.GetSearchWholeWords: Boolean;
begin
  Result := WholeWordsCheckBox.Checked;
end;

function TReplaceDialog.GetWildCard: Boolean;
begin
  Result := WildCardCheckBox.Checked;
end;

procedure TReplaceDialog.SearchForComboBoxKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  FindButton.Enabled := SearchForComboBox.Text <> '';
  ReplaceAllButton.Enabled := FindButton.Enabled;
end;

function TReplaceDialog.GetReplaceInWholeFile: Boolean;
begin
  Result := WholeFileRadioButton.Checked;
end;

procedure TReplaceDialog.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  WriteIniFile;
  if ModalResult = mrOK then
  begin
    InsertTextToCombo(SearchForComboBox);
    InsertTextToCombo(ReplaceWithComboBox);
  end;
end;

procedure TReplaceDialog.ReadIniFile;
begin
  with TMemIniFile.Create(GetIniFilename) do
  try
    CaseSensitiveCheckBox.Checked := ReadBool('ReplaceOptions', 'CaseSensitive', False);
    WholeWordsCheckBox.Checked := ReadBool('ReplaceOptions', 'WholeWords', False);
    RegularExpressionsCheckBox.Checked := ReadBool('ReplaceOptions', 'RegularExpressions', False);
    PromptOnReplaceCheckBox.Checked := ReadBool('ReplaceOptions', 'PromptOnReplace', True);
    WholeFileRadioButton.Checked := ReadBool('ReplaceOptions', 'WholeFile', True);
    AllOpenFilesRadioButton.Checked := ReadBool('ReplaceOptions', 'AllOpenFiles', False);
  finally
    Free;
  end;
end;

procedure TReplaceDialog.WriteIniFile;
begin
  with TMemIniFile.Create(GetIniFilename) do
  try
    WriteBool('ReplaceOptions', 'CaseSensitive', CaseSensitiveCheckBox.Checked);
    WriteBool('ReplaceOptions', 'WholeWords', WholeWordsCheckBox.Checked);
    WriteBool('ReplaceOptions', 'RegularExpressions', RegularExpressionsCheckBox.Checked);
    WriteBool('ReplaceOptions', 'PromptOnReplace', PromptOnReplaceCheckBox.Checked);
    WriteBool('ReplaceOptions', 'WholeFile', WholeFileRadioButton.Checked);
    WriteBool('ReplaceOptions', 'AllOpenFiles', AllOpenFilesRadioButton.Checked);
  finally
    Free;
  end;
end;

end.

 