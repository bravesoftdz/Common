unit BCCommon.Dialogs.Options.Search;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, BCEditor.Types, BCEditor.Editor,
  BCCommon.Dialogs.Base, BCControls.Panel, BCControls.CheckBox, BCControls.Button, sButton, sPanel, sCheckBox;

type
  TSearchOptionsDialog = class(TBCBaseDialog)
    ButtonCancel: TBCButton;
    ButtonOK: TBCButton;
    CheckBoxBeepIfSearchStringNotFound: TBCCheckBox;
    CheckBoxCaseSensitive: TBCCheckBox;
    CheckBoxEntireScope: TBCCheckBox;
    CheckBoxHighlightResult: TBCCheckBox;
    CheckBoxRegularExpression: TBCCheckBox;
    CheckBoxSearchOnTyping: TBCCheckBox;
    CheckBoxSelectedOnly: TBCCheckBox;
    CheckBoxShowSearchStringNotFound: TBCCheckBox;
    CheckBoxWholeWordsOnly: TBCCheckBox;
    CheckBoxWildCard: TBCCheckBox;
    PanelButton: TBCPanel;
  private
    procedure SetOptions(Editor: TBCEditor);
    procedure GetOptions(Editor: TBCEditor);
    procedure WriteIniFile;
  public
    class procedure ClassShowModal(Editor: TBCEditor);
  end;

implementation

{$R *.dfm}

uses
  BigIni, BCCommon.FileUtils;

class procedure TSearchOptionsDialog.ClassShowModal(Editor: TBCEditor);
var
  FSearchOptionsDialog: TSearchOptionsDialog;
begin
  Application.CreateForm(TSearchOptionsDialog, FSearchOptionsDialog);

  FSearchOptionsDialog.SetOptions(Editor);
  if FSearchOptionsDialog.ShowModal = mrOk then
  begin
    FSearchOptionsDialog.GetOptions(Editor);
    FSearchOptionsDialog.WriteIniFile;
  end;

  FSearchOptionsDialog.Free;
  FSearchOptionsDialog := nil;
end;

procedure TSearchOptionsDialog.WriteIniFile;
begin
  with TBigIniFile.Create(GetIniFilename) do
  try
    WriteBool('Options', 'SearchBeepIfSearchStringNotFound', CheckBoxBeepIfSearchStringNotFound.Checked);
    WriteBool('Options', 'SearchCaseSensitive', CheckBoxCaseSensitive.Checked);
    WriteBool('Options', 'SearchEntireScope', CheckBoxEntireScope.Checked);
    WriteBool('Options', 'SearchHighlightResult', CheckBoxHighlightResult.Checked);
    WriteBool('Options', 'SearchRegularExpression', CheckBoxRegularExpression.Checked);
    WriteBool('Options', 'SearchOnTyping', CheckBoxSearchOnTyping.Checked);
    WriteBool('Options', 'SearchSelectedOnly', CheckBoxSelectedOnly.Checked);
    WriteBool('Options', 'SearchShowSearchStringNotFound', CheckBoxShowSearchStringNotFound.Checked);
    WriteBool('Options', 'SearchWildCard', CheckBoxWildCard.Checked);
    WriteBool('Options', 'SearchWholeWordsOnly', CheckBoxWholeWordsOnly.Checked);
  finally
    Free;
  end;
end;

procedure TSearchOptionsDialog.SetOptions(Editor: TBCEditor);
begin
  CheckBoxBeepIfSearchStringNotFound.Checked := soBeepIfStringNotFound in Editor.Search.Options;
  CheckBoxCaseSensitive.Checked := soCaseSensitive in Editor.Search.Options;
  CheckBoxEntireScope.Checked := soEntireScope in Editor.Search.Options;
  CheckBoxHighlightResult.Checked := soHighlightResults in Editor.Search.Options;
  CheckBoxRegularExpression.Checked := Editor.Search.Engine = seRegularExpression;
  CheckBoxSearchOnTyping.Checked := soSearchOnTyping in Editor.Search.Options;
  CheckBoxSelectedOnly.Checked := soSelectedOnly in Editor.Search.Options;
  CheckBoxShowSearchStringNotFound.Checked := soShowStringNotFound in Editor.Search.Options;
  CheckBoxWildCard.Checked := Editor.Search.Engine = seWildCard;
  CheckBoxWholeWordsOnly.Checked := soWholeWordsOnly in Editor.Search.Options;
end;

procedure TSearchOptionsDialog.GetOptions(Editor: TBCEditor);

  procedure SetOption(Enabled: Boolean; Option: TBCEditorSearchOption);
  begin
    if Enabled then
      Editor.Search.Options := Editor.Search.Options + [Option]
    else
      Editor.Search.Options := Editor.Search.Options - [Option];
  end;

begin
  SetOption(CheckBoxBeepIfSearchStringNotFound.Checked, soBeepIfStringNotFound);
  SetOption(CheckBoxCaseSensitive.Checked, soCaseSensitive);
  SetOption(CheckBoxEntireScope.Checked, soEntireScope);
  SetOption(CheckBoxHighlightResult.Checked, soHighlightResults);
  if CheckBoxRegularExpression.Checked then
    Editor.Search.Engine := seRegularExpression
  else
  if CheckBoxWildCard.Checked then
    Editor.Search.Engine := seWildCard
  else
    Editor.Search.Engine := seNormal;
  SetOption(CheckBoxSearchOnTyping.Checked, soSearchOnTyping);
  SetOption(CheckBoxSelectedOnly.Checked, soSelectedOnly);
  SetOption(CheckBoxShowSearchStringNotFound.Checked, soShowStringNotFound);
  SetOption(CheckBoxWholeWordsOnly.Checked, soWholeWordsOnly);
end;

end.
