unit BCCommon.Dialogs.Replace;

interface

uses
  System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, BCCommon.Dialogs.Base, Vcl.ExtCtrls,
  BCControls.ComboBox, Vcl.StdCtrls, BCControls.Panel,
  BCControls.RadioButton, BCEditor.Editor, BCEditor.Types, BCControls.Button, sButton, sComboBox,
  sPanel, sRadioButton, sGroupBox, BCControls.GroupBox, sLabel, acSlider;

type
  TReplaceDialog = class(TBCBaseDialog)
    ButtonCancel: TBCButton;
    ButtonOK: TBCButton;
    ButtonReplaceAll: TBCButton;
    ComboBoxReplaceWith: TBCComboBox;
    ComboBoxSearchFor: TBCComboBox;
    GroupBoxOptions: TBCGroupBox;
    GroupBoxReplaceIn: TBCGroupBox;
    PanelButtons: TBCPanel;
    PanelReplaceWith: TBCPanel;
    PanelReplaceWithComboBox: TBCPanel;
    PanelSearchForComboBox: TBCPanel;
    RadioButtonAllOpenFiles: TBCRadioButton;
    RadioButtonReplaceWith: TBCRadioButton;
    RadioButtonWholeFile: TBCRadioButton;
    SliderCaseSensitive: TsSlider;
    StickyLabelCaseSensitive: TsStickyLabel;
    StickyLabelPromptOnReplace: TsStickyLabel;
    SliderPromptOnReplace: TsSlider;
    SliderRegularExpression: TsSlider;
    StickyLabelRegularExpression: TsStickyLabel;
    SliderSelectedOnly: TsSlider;
    StickyLabelSelectedOnly: TsStickyLabel;
    StickyLabelWholeWordsOnly: TsStickyLabel;
    SliderWholeWordsOnly: TsSlider;
    StickyLabelWildCard: TsStickyLabel;
    SliderWildCard: TsSlider;
    BCPanel1: TBCPanel;
    RadioButtonDeleteLine: TBCRadioButton;
    procedure ComboBoxSearchForKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RadioButtonDeleteLineClick(Sender: TObject);
    procedure RadioButtonReplaceWithClick(Sender: TObject);
    procedure SliderRegularExpressionClick(Sender: TObject);
    procedure SliderWildCardClick(Sender: TObject);
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
  System.Math, System.IniFiles, BCCommon.FileUtils, BCControls.Utils, BCCommon.Utils;

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
  SetOption(SliderCaseSensitive.SliderOn, roCaseSensitive);
  SetOption(SliderPromptOnReplace.SliderOn, roPrompt);
  SetOption(SliderSelectedOnly.SliderOn, roSelectedOnly);
  SetOption(SliderWholeWordsOnly.SliderOn, roWholeWordsOnly);
  SetOption(ModalResult = mrYes, roReplaceAll);
  if RadioButtonReplaceWith.Checked then
    Editor.Replace.Action := eraReplace
  else
    Editor.Replace.Action := eraDeleteLine;
  if SliderRegularExpression.SliderOn then
    Editor.Replace.Engine := seRegularExpression
  else
  if SliderWildCard.SliderOn then
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
  AlignSliders(GroupBoxOptions);
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

procedure TReplaceDialog.RadioButtonDeleteLineClick(Sender: TObject);
begin
  RadioButtonReplaceWith.Checked := False;
  ComboBoxReplaceWith.Text := '';
  ComboBoxReplaceWith.Enabled := False;
end;

procedure TReplaceDialog.RadioButtonReplaceWithClick(Sender: TObject);
begin
  RadioButtonDeleteLine.Checked := False;
  ComboBoxReplaceWith.Enabled := True;
end;

procedure TReplaceDialog.ReadIniFile;
begin
  with TIniFile.Create(GetIniFilename) do
  try
    RadioButtonReplaceWith.Checked := ReadBool('ReplaceOptions', 'ReplaceWith', True);
    RadioButtonDeleteLine.Checked := ReadBool('ReplaceOptions', 'DeleteLine', False);
    SliderCaseSensitive.SliderOn := ReadBool('ReplaceOptions', 'CaseSensitive', False);
    SliderPromptOnReplace.SliderOn := ReadBool('ReplaceOptions', 'PromptOnReplace', True);
    SliderRegularExpression.SliderOn := ReadBool('ReplaceOptions', 'RegularExpressions', False);
    SliderSelectedOnly.SliderOn := ReadBool('ReplaceOptions', 'SelectedOnly', False);
    SliderWholeWordsOnly.SliderOn := ReadBool('ReplaceOptions', 'WholeWordsOnly', False);
    SliderWildCard.SliderOn := ReadBool('ReplaceOptions', 'WildCard', False);
    RadioButtonWholeFile.Checked := ReadBool('ReplaceOptions', 'WholeFile', True);
    RadioButtonAllOpenFiles.Checked := ReadBool('ReplaceOptions', 'AllOpenFiles', False);
  finally
    Free;
  end;
end;

procedure TReplaceDialog.SliderRegularExpressionClick(Sender: TObject);
begin
  SliderWildCard.SliderOn := False
end;

procedure TReplaceDialog.SliderWildCardClick(Sender: TObject);
begin
  SliderRegularExpression.SliderOn := False;
end;

procedure TReplaceDialog.WriteIniFile;
begin
  with TIniFile.Create(GetIniFilename) do
  try
    WriteBool('ReplaceOptions', 'ReplaceWith', RadioButtonReplaceWith.Checked);
    WriteBool('ReplaceOptions', 'DeleteLine', RadioButtonDeleteLine.Checked);
    WriteBool('ReplaceOptions', 'CaseSensitive', SliderCaseSensitive.SliderOn);
    WriteBool('ReplaceOptions', 'PromptOnReplace', SliderPromptOnReplace.SliderOn);
    WriteBool('ReplaceOptions', 'RegularExpressions', SliderRegularExpression.SliderOn);
    WriteBool('ReplaceOptions', 'SelectedOnly', SliderSelectedOnly.SliderOn);
    WriteBool('ReplaceOptions', 'WholeWordsOnly', SliderWholeWordsOnly.SliderOn);
    WriteBool('ReplaceOptions', 'WildCard', SliderWildCard.SliderOn);
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

