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
    ButtonFind: TBCButton;
    ButtonReplaceAll: TBCButton;
    CheckBoxCaseSensitive: TBCCheckBox;
    CheckBoxPromptOnReplace: TBCCheckBox;
    CheckBoxRegularExpression: TBCCheckBox;
    CheckBoxSelectedOnly: TBCCheckBox;
    CheckBoxWholeWords: TBCCheckBox;
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
  private
    {$if Defined(EDITBONE) or Defined(ORABONE)}
    procedure ReadIniFile;
    procedure WriteIniFile;
    {$endif}
    procedure GetOptions(Editor: TBCEditor);
    procedure SetOptions(Editor: TBCEditor);
  public
    class procedure ClassShowModal(Editor: TBCEditor);
  end;

implementation

{$R *.DFM}

uses
  System.Math, System.IniFiles, BCCommon.FileUtils, BCCommon.Utils;

class procedure TReplaceDialog.ClassShowModal(Editor: TBCEditor);
var
  FReplaceDialog: TReplaceDialog;
begin
  Application.CreateForm(TReplaceDialog, FReplaceDialog);

  FReplaceDialog.SetOptions(Editor);
  if FReplaceDialog.ShowModal in [mrOk, mrYes] then
  begin
    FReplaceDialog.GetOptions(Editor);
    Editor.CaretZero;
    Editor.ReplaceText(FReplaceDialog.ComboBoxSearchFor.Text, FReplaceDialog.ComboBoxReplaceWith.Text);
  end;

  FReplaceDialog.Free;
  FReplaceDialog := nil;
end;

procedure TReplaceDialog.SetOptions(Editor: TBCEditor);
begin
  if Editor.SelectionAvailable then
    ComboBoxSearchFor.Text := Editor.SelectedText;
  CheckBoxCaseSensitive.Checked := roCaseSensitive in Editor.Replace.Options;
  CheckBoxWholeWords.Checked := roWholeWordsOnly in Editor.Replace.Options;
  CheckBoxPromptOnReplace.Checked := roPrompt in Editor.Replace.Options;
  CheckBoxSelectedOnly.Checked := roSelectedOnly in Editor.Replace.Options;
  RadioButtonReplaceWith.Checked := Editor.Replace.Action = eraReplace;
  RadioButtonDeleteLine.Checked := Editor.Replace.Action = eraDeleteLine;
  CheckBoxRegularExpression.Checked := Editor.Replace.Engine = seRegularExpression;
  CheckBoxWildCard.Checked := Editor.Replace.Engine = seWildCard;
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
  SetOption(CheckBoxWholeWords.Checked, roWholeWordsOnly);
  SetOption(CheckBoxPromptOnReplace.Checked, roPrompt);
  SetOption(ModalResult = mrYes, roReplaceAll);
  SetOption(CheckBoxSelectedOnly.Checked, roSelectedOnly);
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
  {$if Defined(EDITBONE) or Defined(ORABONE)}
  ReadIniFile;
  {$endif}
  if ComboBoxSearchFor.CanFocus then
    ComboBoxSearchFor.SetFocus;
end;

procedure TReplaceDialog.ComboBoxSearchForKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  ButtonFind.Enabled := ComboBoxSearchFor.Text <> '';
  ButtonReplaceAll.Enabled := ButtonFind.Enabled;
end;

procedure TReplaceDialog.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  {$if Defined(EDITBONE) or Defined(ORABONE)}
  WriteIniFile;
  {$endif}
  if ModalResult in [mrOK, mrYes] then
  begin
    InsertTextToCombo(ComboBoxSearchFor);
    InsertTextToCombo(ComboBoxReplaceWith);
  end;
end;

{$if Defined(EDITBONE) or Defined(ORABONE)}
procedure TReplaceDialog.ReadIniFile;
begin
  with TIniFile.Create(GetIniFilename) do
  try
    CheckBoxCaseSensitive.Checked := ReadBool('ReplaceOptions', 'CaseSensitive', False);
    CheckBoxWholeWords.Checked := ReadBool('ReplaceOptions', 'WholeWords', False);
    CheckBoxRegularExpression.Checked := ReadBool('ReplaceOptions', 'RegularExpressions', False);
    CheckBoxPromptOnReplace.Checked := ReadBool('ReplaceOptions', 'PromptOnReplace', True);
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
    WriteBool('ReplaceOptions', 'CaseSensitive', CheckBoxCaseSensitive.Checked);
    WriteBool('ReplaceOptions', 'WholeWords', CheckBoxWholeWords.Checked);
    WriteBool('ReplaceOptions', 'RegularExpressions', CheckBoxRegularExpression.Checked);
    WriteBool('ReplaceOptions', 'PromptOnReplace', CheckBoxPromptOnReplace.Checked);
    WriteBool('ReplaceOptions', 'WholeFile', RadioButtonWholeFile.Checked);
    WriteBool('ReplaceOptions', 'AllOpenFiles', RadioButtonAllOpenFiles.Checked);
  finally
    Free;
  end;
end;
{$endif}

end.

 