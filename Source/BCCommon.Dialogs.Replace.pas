unit BCCommon.Dialogs.Replace;

interface

uses
  System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, BCCommon.Dialogs.Base, Vcl.ExtCtrls,
  BCControls.ComboBox, Vcl.StdCtrls, BCControls.CheckBox, BCControls.Panel,
  BCControls.RadioButton, BCEditor.Editor, BCEditor.Types, BCControls.Button, sButton, sComboBox,
  sPanel, sRadioButton, sCheckBox, sGroupBox, BCControls.GroupBox;

type
  TReplaceDialog = class(TBCBaseDialog)
    ButtonCancel: TBCButton;
    ButtonOK: TBCButton;
    ButtonReplaceAll: TBCButton;
    CheckBoxCaseSensitive: TBCCheckBox;
    CheckBoxPromptOnReplace: TBCCheckBox;
    CheckBoxRegularExpression: TBCCheckBox;
    CheckBoxSelectedOnly: TBCCheckBox;
    CheckBoxWholeWordsOnly: TBCCheckBox;
    CheckBoxWildCard: TBCCheckBox;
    ComboBoxReplaceWith: TBCComboBox;
    ComboBoxSearchFor: TBCComboBox;
    GroupBoxOptions: TBCGroupBox;
    GroupBoxReplaceIn: TBCGroupBox;
    PanelButtons: TBCPanel;
    PanelReplaceWith: TBCPanel;
    PanelReplaceWithComboBox: TBCPanel;
    PanelSearchForComboBox: TBCPanel;
    RadioButtonAllOpenFiles: TBCRadioButton;
    RadioButtonDeleteLine: TBCRadioButton;
    RadioButtonReplaceWith: TBCRadioButton;
    RadioButtonWholeFile: TBCRadioButton;
    procedure ComboBoxSearchForKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CheckBoxWildCardClick(Sender: TObject);
    procedure CheckBoxRegularExpressionClick(Sender: TObject);
  private
    function GetReplaceInWholeFile: Boolean;
    procedure ReadIniFile;
    procedure WriteIniFile;
  public
    procedure GetOptions(Editor: TBCEditor);
    property ReplaceInWholeFile: Boolean read GetReplaceInWholeFile;
  end;

function ReplaceDialog: TReplaceDialog;

implementation

{$R *.DFM}

uses
  System.Math, System.IniFiles, BCCommon.FileUtils, BCCommon.Utils;

var
  FReplaceDialog: TReplaceDialog;

function ReplaceDialog: TReplaceDialog;
begin
  if not Assigned(FReplaceDialog) then
    Application.CreateForm(TReplaceDialog, FReplaceDialog);
  Result := FReplaceDialog;
end;

procedure TReplaceDialog.GetOptions(Editor: TBCEditor);

  procedure SetOption(Enabled: Boolean; Option: TBCEditorReplaceOption);
  begin
    if Enabled then
      Editor.Replace.Options := Editor.Replace.Options + [Option]
    else
      Editor.Replace.Options := Editor.Replace.Options - [Option];
  end;

begin
  SetOption(CheckBoxCaseSensitive.Checked, roCaseSensitive);
  SetOption(CheckBoxPromptOnReplace.Checked, roPrompt);
  SetOption(CheckBoxSelectedOnly.Checked, roSelectedOnly);
  SetOption(CheckBoxWholeWordsOnly.Checked, roWholeWordsOnly);
  SetOption(ModalResult = mrYes, roReplaceAll);
  if RadioButtonReplaceWith.Checked then
    Editor.Replace.Action := eraReplace
  else
    Editor.Replace.Action := eraDeleteLine;
  if CheckBoxRegularExpression.Checked then
    Editor.Replace.Engine := seRegularExpression
  else
  if CheckBoxWildCard.Checked then
    Editor.Replace.Engine := seWildCard
  else
    Editor.Replace.Engine := seNormal;
end;

procedure TReplaceDialog.FormShow(Sender: TObject);
begin
  inherited;
  ReadIniFile;
  if ComboBoxSearchFor.CanFocus then
    ComboBoxSearchFor.SetFocus;
end;

procedure TReplaceDialog.CheckBoxRegularExpressionClick(Sender: TObject);
begin
  CheckBoxWildCard.Checked := False;
end;

procedure TReplaceDialog.CheckBoxWildCardClick(Sender: TObject);
begin
  CheckBoxRegularExpression.Checked := False;
end;

procedure TReplaceDialog.ComboBoxSearchForKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  ButtonOK.Enabled := ComboBoxSearchFor.Text <> '';
  ButtonReplaceAll.Enabled := ButtonOK.Enabled;
end;

procedure TReplaceDialog.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  WriteIniFile;
  if ModalResult in [mrOK, mrYes] then
  begin
    InsertTextToCombo(ComboBoxSearchFor);
    InsertTextToCombo(ComboBoxReplaceWith);
  end;
end;

procedure TReplaceDialog.FormDestroy(Sender: TObject);
begin
  FReplaceDialog := nil;
end;

procedure TReplaceDialog.ReadIniFile;
begin
  with TIniFile.Create(GetIniFilename) do
  try
    RadioButtonReplaceWith.Checked := ReadBool('ReplaceOptions', 'ReplaceWith', True);
    RadioButtonDeleteLine.Checked := ReadBool('ReplaceOptions', 'DeleteLine', False);
    CheckBoxCaseSensitive.Checked := ReadBool('ReplaceOptions', 'CaseSensitive', False);
    CheckBoxPromptOnReplace.Checked := ReadBool('ReplaceOptions', 'PromptOnReplace', True);
    CheckBoxRegularExpression.Checked := ReadBool('ReplaceOptions', 'RegularExpressions', False);
    CheckBoxSelectedOnly.Checked := ReadBool('ReplaceOptions', 'SelectedOnly', False);
    CheckBoxWholeWordsOnly.Checked := ReadBool('ReplaceOptions', 'WholeWordsOnly', False);
    CheckBoxWildCard.Checked := ReadBool('ReplaceOptions', 'WildCard', False);
    RadioButtonWholeFile.Checked := ReadBool('ReplaceOptions', 'WholeFile', True);
    RadioButtonAllOpenFiles.Checked := ReadBool('ReplaceOptions', 'AllOpenFiles', False);
  finally
    Free;
  end;
end;

procedure TReplaceDialog.WriteIniFile;
begin
  with TIniFile.Create(GetIniFilename) do
  try
    WriteBool('ReplaceOptions', 'ReplaceWith', RadioButtonReplaceWith.Checked);
    WriteBool('ReplaceOptions', 'DeleteLine', RadioButtonDeleteLine.Checked);
    WriteBool('ReplaceOptions', 'CaseSensitive', CheckBoxCaseSensitive.Checked);
    WriteBool('ReplaceOptions', 'PromptOnReplace', CheckBoxPromptOnReplace.Checked);
    WriteBool('ReplaceOptions', 'RegularExpressions', CheckBoxRegularExpression.Checked);
    WriteBool('ReplaceOptions', 'SelectedOnly', CheckBoxSelectedOnly.Checked);
    WriteBool('ReplaceOptions', 'WholeWordsOnly', CheckBoxWholeWordsOnly.Checked);
    WriteBool('ReplaceOptions', 'WildCard', CheckBoxWildCard.Checked);
    WriteBool('ReplaceOptions', 'WholeFile', RadioButtonWholeFile.Checked);
    WriteBool('ReplaceOptions', 'AllOpenFiles', RadioButtonAllOpenFiles.Checked);
  finally
    Free;
  end;
end;

function TReplaceDialog.GetReplaceInWholeFile: Boolean;
begin
  Result := RadioButtonWholeFile.Checked;
end;

end.

