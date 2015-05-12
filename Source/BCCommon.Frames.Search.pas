unit BCCommon.Frames.Search;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, BCCommon.Frames.Base,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCEditor.Editor, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, System.Actions, Vcl.ActnList, BCControls.Panel, BCControls.ComboBox, BCControls.SpeedButton,
  Vcl.ComCtrls, BCCommon.Images, BCControls.Splitter, BCControls.Labels,
  sLabel, sPanel, sComboBox, sSplitter, sSpeedButton, sFrameAdapter;

type
  TBCSearchFrame = class(TBCBaseFrame)
    ActionClose: TAction;
    ActionFindNext: TAction;
    ActionFindPrevious: TAction;
    ActionList: TActionList;
    ActionOptions: TAction;
    ComboBoxSearchText: TBCComboBox;
    LabelSearchResultCount: TBCLabelFX;
    PanelRight: TBCPanel;
    PanelToolBar: TBCPanel;
    SpeedButtonSearchClose: TBCSpeedButton;
    Splitter: TBCSplitter;
    SpeedButtonFindPrevious: TBCSpeedButton;
    SpeedButtonFindNext: TBCSpeedButton;
    SpeedButtonDivider: TBCSpeedButton;
    SpeedButtonOptions: TBCSpeedButton;
    procedure ActionCloseExecute(Sender: TObject);
    procedure ActionFindNextExecute(Sender: TObject);
    procedure ActionFindPreviousExecute(Sender: TObject);
    procedure ActionOptionsExecute(Sender: TObject);
    procedure ComboBoxSearchTextChange(Sender: TObject);
    procedure ComboBoxSearchTextKeyPress(Sender: TObject; var Key: Char);
  private
    FEditor: TBCEditor;
    procedure SetMatchesFound;
  public
    procedure ClearText;
  published
    property Editor: TBCEditor read FEditor write FEditor;
  end;

implementation

{$R *.dfm}

uses
  BCCommon.Language.Strings, BCCommon.Dialogs.Options.Search, BCEditor.Types;

procedure TBCSearchFrame.ActionCloseExecute(Sender: TObject);
begin
  if Assigned(Editor) then
    Editor.Search.Enabled := False;
end;

procedure TBCSearchFrame.ActionFindNextExecute(Sender: TObject);
begin
  if Assigned(Editor) then
    Editor.FindNext;
end;

procedure TBCSearchFrame.ActionFindPreviousExecute(Sender: TObject);
begin
  if Assigned(Editor) then
    Editor.FindPrevious;
end;

procedure TBCSearchFrame.ActionOptionsExecute(Sender: TObject);
begin
  if Assigned(Editor) then
    TSearchOptionsDialog.ClassShowModal(Editor);
end;

procedure TBCSearchFrame.ComboBoxSearchTextChange(Sender: TObject);
begin
  if soSearchOnTyping in Editor.Search.Options then
  begin
    if Assigned(Editor) then
      Editor.Search.SearchText := ComboBoxSearchText.Text;
    SetMatchesFound;
  end;
end;

procedure TBCSearchFrame.SetMatchesFound;
var
  s: string;
begin
  s := '';

  if Assigned(Editor) and (Editor.SearchResultCount > 1) then
    s := LanguageDataModule.GetConstant('MatchFoundPluralExtension');
  if Assigned(Editor) and (Editor.SearchResultCount > 0) then
    s := Format(LanguageDataModule.GetConstant('MatchFound'), [Editor.SearchResultCount, s]);

  LabelSearchResultCount.Caption := s;
end;

procedure TBCSearchFrame.ClearText;
begin
  ComboBoxSearchText.Text := '';
  if Assigned(Editor) then
    Editor.Search.SearchText := '';
  SetMatchesFound;
end;

procedure TBCSearchFrame.ComboBoxSearchTextKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) or (Key = #10) then
  begin
    if Assigned(Editor) then
      if Editor.CanFocus then
         Editor.SetFocus;
    if ComboBoxSearchText.Items.IndexOf(ComboBoxSearchText.Text) = -1 then
      ComboBoxSearchText.Items.Add(ComboBoxSearchText.Text);
    Key := #0;
  end;
end;

end.
