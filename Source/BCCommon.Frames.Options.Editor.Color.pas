unit BCCommon.Frames.Options.Editor.Color;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, JsonDataObjects,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sComboBox, BCControls.ComboBox, Vcl.ComCtrls,
  sComboBoxes, sGroupBox, Vcl.ExtCtrls, sPanel, BCControls.Panel, sCheckBox,
  BCControls.CheckBox, BCEditor.Editor.Base, BCEditor.Editor, Vcl.Buttons, sSpeedButton, BCControls.SpeedButton,
  BCControls.GroupBox, BCCommon.Frames.Options.Base, sFrameAdapter, System.Actions, Vcl.ActnList, BCControls.ScrollBox,
  sScrollBox, sDialogs, BCComponents.MultiStringHolder, sPageControl, BCControls.PageControl, sSplitter, sEdit,
  BCControls.Edit, Vcl.Mask, sMaskEdit, sCustomComboEdit, sToolEdit, BCControls.DateEdit, sLabel, BCControls.Labels;

type
  TOptionsEditorColorFrame = class(TBCOptionsBaseFrame)
    ActionAddColor: TAction;
    ActionList: TActionList;
    CheckBoxElementsAttributesBold: TBCCheckBox;
    CheckBoxElementsAttributesItalic: TBCCheckBox;
    CheckBoxElementsAttributesUnderline: TBCCheckBox;
    CheckBoxSkinActiveLineBackground: TBCCheckBox;
    CheckBoxSkinBackground: TBCCheckBox;
    CheckBoxSkinBookmarkPanelBackground: TBCCheckBox;
    CheckBoxSkinCodeFoldingBackground: TBCCheckBox;
    CheckBoxSkinCodeFoldingHintBackground: TBCCheckBox;
    CheckBoxSkinCompletionProposalBackground: TBCCheckBox;
    CheckBoxSkinCompletionProposalSelectionBackground: TBCCheckBox;
    CheckBoxSkinForeground: TBCCheckBox;
    CheckBoxSkinLeftMarginBackground: TBCCheckBox;
    CheckBoxSkinSelectionBackground: TBCCheckBox;
    CheckBoxSkinSelectionForeground: TBCCheckBox;
    ColorComboBoxEditorColor: TBCColorComboBox;
    ColorComboBoxElementsBackground: TBCColorComboBox;
    ColorComboBoxElementsForeground: TBCColorComboBox;
    ComboBoxColor: TBCComboBox;
    ComboBoxEditorElement: TBCComboBox;
    ComboBoxElementsName: TBCComboBox;
    ComboBoxHighlighter: TBCComboBox;
    DateEditDate: TBCDateEdit;
    EditEmail: TBCEdit;
    EditName: TBCEdit;
    Editor: TBCEditor;
    EditVersion: TBCEdit;
    GroupBoxAttributes: TBCGroupBox;
    LabelSkinDescription: TBCLabel;
    MultiStringHolder: TBCMultiStringHolder;
    PageControl: TBCPageControl;
    Panel: TBCPanel;
    SaveDialog: TsSaveDialog;
    ScrollBox: TBCScrollBox;
    SpeedButtonColor: TBCSpeedButton;
    Splitter: TsSplitter;
    TabSheetAuthor: TsTabSheet;
    TabSheetEditor: TsTabSheet;
    TabSheetElements: TsTabSheet;
    TabSheetGeneral: TsTabSheet;
    TabSheetSkin: TsTabSheet;
    procedure ActionAddColorExecute(Sender: TObject);
    procedure ComboBoxColorChange(Sender: TObject);
    procedure ColorComboBoxEditorColorChange(Sender: TObject);
    procedure ColorComboBoxElementsForegroundChange(Sender: TObject);
    procedure ColorComboBoxElementsBackgroundChange(Sender: TObject);
    procedure CheckBoxElementsAttributesClick(Sender: TObject);
    procedure ComboBoxHighlighterChange(Sender: TObject);
    procedure ComboBoxEditorElementChange(Sender: TObject);
    procedure ComboBoxElementsNameChange(Sender: TObject);
    procedure EditChange(Sender: TObject);
    procedure CheckBoxSkinValueClick(Sender: TObject);
  private
    FFileName: string;
    FJSONObject: TJsonObject;
    FModified: Boolean;
    function GetColorFileName: string;
    function GetElementDataValue: PJsonDataValue;
    procedure CreateJSONObject;
    procedure FreeJSONObject;
    procedure LoadColors;
    procedure SaveColor(ADoChange: Boolean = True);
    procedure SetSkinColors;
  protected
    procedure Init; override;
    procedure PutData; override;
    procedure GetData; override;
  public
    destructor Destroy; override;
  end;

function OptionsEditorColorFrame(AOwner: TComponent): TOptionsEditorColorFrame;

implementation

{$R *.dfm}

uses
  BCCommon.Options.Container, BCCommon.Language.Strings, BCCommon.StringUtils, BCEditor.Highlighter.Colors;

var
  FOptionsEditorColorFrame: TOptionsEditorColorFrame;

function OptionsEditorColorFrame(AOwner: TComponent): TOptionsEditorColorFrame;
begin
  if not Assigned(FOptionsEditorColorFrame) then
    FOptionsEditorColorFrame := TOptionsEditorColorFrame.Create(AOwner);
  Result := FOptionsEditorColorFrame;
end;

procedure TOptionsEditorColorFrame.FreeJSONObject;
begin
  if Assigned(FJSONObject) then
  begin
    FJSONObject.Free;
    FJSONObject := nil;
  end;
end;

destructor TOptionsEditorColorFrame.Destroy;
begin
  inherited;
  FreeJSONObject;
  FOptionsEditorColorFrame := nil;
end;

procedure TOptionsEditorColorFrame.EditChange(Sender: TObject);
begin
  inherited;
  FModified := True;
end;

procedure TOptionsEditorColorFrame.PutData;
begin
  OptionsContainer.SkinActiveLineBackground := CheckBoxSkinActiveLineBackground.Checked;
  OptionsContainer.SkinBackground := CheckBoxSkinBackground.Checked;
  OptionsContainer.SkinBookmarkPanelBackground := CheckBoxSkinBookmarkPanelBackground.Checked;
  OptionsContainer.SkinCodeFoldingBackground := CheckBoxSkinCodeFoldingBackground.Checked;
  OptionsContainer.SkinCodeFoldingHintBackground := CheckBoxSkinCodeFoldingHintBackground.Checked;
  OptionsContainer.SkinCompletionProposalBackground := CheckBoxSkinCompletionProposalBackground.Checked;
  OptionsContainer.SkinCompletionProposalSelectionBackground := CheckBoxSkinCompletionProposalSelectionBackground.Checked;
  OptionsContainer.SkinForeground := CheckBoxSkinForeground.Checked;
  OptionsContainer.SkinLeftMarginBackground := CheckBoxSkinLeftMarginBackground.Checked;
  OptionsContainer.SkinSelectionBackground := CheckBoxSkinSelectionBackground.Checked;
  OptionsContainer.SkinSelectionForeground := CheckBoxSkinSelectionForeground.Checked;
  SaveColor(False);
end;

procedure TOptionsEditorColorFrame.SaveColor(ADoChange: Boolean = True);
begin
  if Assigned(FJSONObject) then
  begin
    FJSONObject['Colors']['Info']['General']['Version'] := EditVersion.Text;
    FJSONObject['Colors']['Info']['General']['Date'] := DateToStr(DateEditDate.Date);
    FJSONObject['Colors']['Info']['Author']['Name'] := EditName.Text;
    FJSONObject['Colors']['Info']['Author']['Email'] := EditEmail.Text;

    JsonSerializationConfig.IndentChar := '    ';
    FJSONObject.SaveToFile(GetColorFileName, False);
    if ADoChange then
      ComboBoxColorChange(Self);
  end;
end;

procedure TOptionsEditorColorFrame.CheckBoxElementsAttributesClick(Sender: TObject);
var
  LStyle: string;
  LElementDataValue: PJsonDataValue;
begin
  LElementDataValue := GetElementDataValue;
  if Assigned(LElementDataValue) then
  begin
    FModified := True;
    LStyle := '';
    if CheckBoxElementsAttributesBold.Checked then
      LStyle := 'Bold';
    if CheckBoxElementsAttributesItalic.Checked then
    begin
      if LStyle <> '' then
        LStyle := LStyle + ';';
      LStyle := LStyle + 'Italic';
    end;
    if CheckBoxElementsAttributesUnderline.Checked then
    begin
      if LStyle <> '' then
        LStyle := LStyle + ';';
      LStyle := LStyle + 'Underline';
    end;
    LElementDataValue.ObjectValue['Style'] := LStyle;
    SaveColor;
  end;
end;

procedure TOptionsEditorColorFrame.CheckBoxSkinValueClick(Sender: TObject);
begin
  inherited;

  LoadColors;
  SetSkinColors;
end;

procedure TOptionsEditorColorFrame.SetSkinColors;
var
  i: Integer;
  LColor: TColor;
begin
  LColor := FrameAdapter.SkinData.SkinManager.GetActiveEditColor;
  if CheckBoxSkinActiveLineBackground.Checked then
    Editor.ActiveLine.Color := FrameAdapter.SkinData.SkinManager.GetHighLightColor(False);
  if CheckBoxSkinBackground.Checked then
    Editor.BackgroundColor := LColor;
  if CheckBoxSkinCodeFoldingBackground.Checked then
    Editor.CodeFolding.Colors.Background := LColor;
  if CheckBoxSkinCodeFoldingHintBackground.Checked then
    Editor.CodeFolding.Hint.Colors.Background := LColor;
  if CheckBoxSkinCompletionProposalBackground.Checked then
    Editor.CompletionProposal.Colors.Background := LColor;
  if CheckBoxSkinCompletionProposalSelectionBackground.Checked then
    Editor.CompletionProposal.Colors.SelectedBackground := LColor;
  if CheckBoxSkinLeftMarginBackground.Checked then
    Editor.LeftMargin.Color := LColor;
  if CheckBoxSkinBookmarkPanelBackground.Checked then
    Editor.LeftMargin.Bookmarks.Panel.Color := LColor;
  if CheckBoxSkinSelectionForeground.Checked then
    Editor.Selection.Colors.Foreground := FrameAdapter.SkinData.SkinManager.GetHighLightFontColor;
  if CheckBoxSkinSelectionBackground.Checked then
    Editor.Selection.Colors.Background := FrameAdapter.SkinData.SkinManager.GetHighLightColor;
  for i := 0 to Editor.Highlighter.Colors.Styles.Count - 1 do
  if PBCEditorHighlighterElement(Editor.Highlighter.Colors.Styles.Items[i])^.Name = 'Editor' then
  begin
    if CheckBoxSkinForeground.Checked then
      PBCEditorHighlighterElement(Editor.Highlighter.Colors.Styles.Items[i])^.ForeGround := FrameAdapter.SkinData.SkinManager.GetActiveEditFontColor;
    if CheckBoxSkinBackground.Checked then
      PBCEditorHighlighterElement(Editor.Highlighter.Colors.Styles.Items[i])^.Background := LColor;
    Break;
  end;
  Editor.Highlighter.UpdateColors;
end;

procedure TOptionsEditorColorFrame.GetData;
begin
  CheckBoxSkinActiveLineBackground.Checked := OptionsContainer.SkinActiveLineBackground;
  CheckBoxSkinBackground.Checked := OptionsContainer.SkinBackground;
  CheckBoxSkinBookmarkPanelBackground.Checked := OptionsContainer.SkinBookmarkPanelBackground;
  CheckBoxSkinCodeFoldingBackground.Checked := OptionsContainer.SkinCodeFoldingBackground;
  CheckBoxSkinCodeFoldingHintBackground.Checked := OptionsContainer.SkinCodeFoldingHintBackground;
  CheckBoxSkinCompletionProposalBackground.Checked := OptionsContainer.SkinCompletionProposalBackground;
  CheckBoxSkinCompletionProposalSelectionBackground.Checked := OptionsContainer.SkinCompletionProposalSelectionBackground;
  CheckBoxSkinForeground.Checked := OptionsContainer.SkinForeground;
  CheckBoxSkinLeftMarginBackground.Checked := OptionsContainer.SkinLeftMarginBackground;
  CheckBoxSkinSelectionBackground.Checked := OptionsContainer.SkinSelectionBackground;
  CheckBoxSkinSelectionForeground.Checked := OptionsContainer.SkinSelectionForeground;
end;

procedure TOptionsEditorColorFrame.ColorComboBoxEditorColorChange(Sender: TObject);
begin
  FModified := True;
  FJSONObject['Colors']['Editor']['Colors'][CapitalizeText(ComboBoxEditorElement.Text)] := ColorToString(ColorComboBoxEditorColor.Selected);
  SaveColor;
end;

procedure TOptionsEditorColorFrame.ColorComboBoxElementsBackgroundChange(Sender: TObject);
var
  LElementDataValue: PJsonDataValue;
begin
  LElementDataValue := GetElementDataValue;
  if Assigned(LElementDataValue) then
  begin
    FModified := True;
    LElementDataValue.ObjectValue['Background'] := StringToColor(ColorComboBoxElementsBackground.Text);
    SaveColor;
  end;
end;

procedure TOptionsEditorColorFrame.ColorComboBoxElementsForegroundChange(Sender: TObject);
var
  LElementDataValue: PJsonDataValue;
begin
  LElementDataValue := GetElementDataValue;
  if Assigned(LElementDataValue) then
  begin
    FModified := True;
    LElementDataValue.ObjectValue['Foreground'] := StringToColor(ColorComboBoxElementsForeground.Text);
    SaveColor;
  end;
end;

function TOptionsEditorColorFrame.GetColorFileName: string;
begin
  Result := Format('%sColors\%s.json', [ExtractFilePath(Application.ExeName), FFileName]);
end;

procedure TOptionsEditorColorFrame.LoadColors;
var
  LFileName: string;
begin
  LFileName := GetColorFileName;
  with Editor do
  begin
    Highlighter.Colors.LoadFromFile(LFileName);
    Invalidate;
  end;
end;

procedure TOptionsEditorColorFrame.CreateJSONObject;
var
  LFileName: string;
begin
  LFileName := GetColorFileName;
  FreeJSONObject;
  FJSONObject := TJsonObject.ParseFromFile(LFileName) as TJsonObject;
end;

procedure TOptionsEditorColorFrame.ComboBoxColorChange(Sender: TObject);
begin
  if FModified then
    SaveColor(False);

  FFileName := ComboBoxColor.Text;
  LoadColors;
  CreateJSONObject;
  FModified := False;

  ComboBoxEditorElementChange(Self);
  ComboBoxElementsNameChange(Self);
  EditVersion.Text := FJSONObject['Colors']['Info']['General']['Version'];
  DateEditDate.Date := StrToDate(FJSONObject['Colors']['Info']['General']['Date']);
  EditName.Text := FJSONObject['Colors']['Info']['Author']['Name'];
  EditEmail.Text := FJSONObject['Colors']['Info']['Author']['Email'];
end;

procedure TOptionsEditorColorFrame.ComboBoxEditorElementChange(Sender: TObject);
begin
  ColorComboBoxEditorColor.Selected := clNone;
  ColorComboBoxEditorColor.Selected := StringToColor(FJSONObject['Colors']['Editor']['Colors'][CapitalizeText(ComboBoxEditorElement.Text)]);
end;

function TOptionsEditorColorFrame.GetElementDataValue: PJsonDataValue;
var
  i: Integer;
  LElement: string;
  LElementArray: TJsonArray;
begin
  Result := nil;
  LElement := CapitalizeText(ComboBoxElementsName.Text);
  LElementArray := FJSONObject['Colors']['Elements'].ArrayValue;
  for i := 0 to LElementArray.Count - 1 do
    if LElementArray.Items[i].ObjectValue['Name'] = LElement then
      Exit(LElementArray.Items[i])
end;

{ Avoid OnClick event when checked property is set... damn. }
procedure SetCheckedState(const ACheckBox: TBCCheckBox; const AChecked: Boolean);
var
  LOnClickHandler: TNotifyEvent;
begin
  with ACheckBox do
  begin
    LOnClickHandler := OnClick;
    OnClick := nil;
    Checked := AChecked;
    OnClick := LOnClickHandler;
  end;
end;

procedure TOptionsEditorColorFrame.ComboBoxElementsNameChange(Sender: TObject);
var
  LStyle: string;
  LElementDataValue: PJsonDataValue;
begin
  LElementDataValue := GetElementDataValue;
  if Assigned(LElementDataValue) then
  begin
    ColorComboBoxElementsForeground.Selected := clNone;
    ColorComboBoxElementsForeground.Selected := StringToColor(LElementDataValue.ObjectValue['Foreground']);
    ColorComboBoxElementsBackground.Selected := clNone;
    ColorComboBoxElementsBackground.Selected := StringToColor(LElementDataValue.ObjectValue['Background']);
    LStyle := LElementDataValue.ObjectValue['Style'];
    SetCheckedState(CheckBoxElementsAttributesBold, Pos('Bold', LStyle) <> 0);
    SetCheckedState(CheckBoxElementsAttributesItalic, Pos('Italic', LStyle) <> 0);
    SetCheckedState(CheckBoxElementsAttributesUnderline, Pos('Underline', LStyle) <> 0);
  end;
end;

procedure TOptionsEditorColorFrame.ComboBoxHighlighterChange(Sender: TObject);
begin
  with Editor do
  begin
    Highlighter.LoadFromFile(Format('%s.json', [ComboBoxHighlighter.Text]));
    ClearCodeFolding;
    Lines.Text := Highlighter.Info.General.Sample;
    InitCodeFolding;
    if Highlighter.CodeFoldingRegions.Count > 0 then
      CodeFolding.Visible := OptionsContainer.ShowCodeFolding;
    Invalidate;
  end;
end;

procedure TOptionsEditorColorFrame.Init;
begin
  PageControl.ActivePage := TabSheetEditor;
  FModified := False;
  ComboBoxHighlighter.Items := OptionsContainer.HighlighterStrings;
  ComboBoxHighlighter.ItemIndex := ComboBoxHighlighter.Items.IndexOf(OptionsContainer.DefaultHighlighter);
  ComboBoxHighlighterChange(Self);
  ComboBoxColor.Items := OptionsContainer.ColorStrings;
  ComboBoxColor.ItemIndex := ComboBoxColor.Items.IndexOf(OptionsContainer.DefaultColor);
  FFileName := ComboBoxColor.Text;
  ComboBoxColorChange(Self);
  ComboBoxEditorElementChange(Self);
  ComboBoxElementsNameChange(Self);
end;

procedure TOptionsEditorColorFrame.ActionAddColorExecute(Sender: TObject);
var
  LColorName: string;
begin
  SaveDialog.Filter := Trim(StringReplace(LanguageDataModule.GetFileTypes('JSON')
        , '|', #0, [rfReplaceAll])) + #0#0;
  SaveDialog.Title := LanguageDataModule.GetConstant('SaveAs');
  SaveDialog.InitialDir := Format('%sColors\', [ExtractFilePath(Application.ExeName)]);
  SaveDialog.FileName := '';
  if SaveDialog.Execute(Handle) then
  begin
    LColorName :=  ChangeFileExt(ExtractFileName(SaveDialog.FileName), '');
    ComboBoxColor.Items.Add(LColorName);
    ComboBoxColor.ItemIndex := ComboBoxColor.IndexOf(LColorName);
    FreeJSONObject;
    FJSONObject := TJsonObject.Parse(MultiStringHolder.StringsByName['DefaultJSON'].Text) as TJsonObject;
    SaveColor;
    ComboBoxColorChange(Self);
  end;
end;

end.
