unit BCFrames.OptionsEditorOptions;

interface

uses
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, BCControls.ComboBox,
  BCControls.CheckBox, BCControls.Edit, Vcl.ComCtrls, JvEdit, BCCommon.OptionsContainer;

type
  TOptionsEditorOptionsFrame = class(TFrame)
    Panel: TPanel;
    AutoIndentCheckBox: TBCCheckBox;
    TrimTrailingSpacesCheckBox: TBCCheckBox;
    ScrollPastEofCheckBox: TBCCheckBox;
    ScrollPastEolCheckBox: TBCCheckBox;
    LineSpacingLabel: TLabel;
    LineSpacingEdit: TBCEdit;
    TabWidthLabel: TLabel;
    TabWidthEdit: TBCEdit;
    BrightnessTrackBar: TTrackBar;
    ActiveLineColorBrightnessLabel: TLabel;
    TabsToSpacesCheckBox: TBCCheckBox;
    AutoSaveCheckBox: TBCCheckBox;
    InsertCaretLabel: TLabel;
    InsertCaretComboBox: TBCComboBox;
    UndoAfterSaveCheckBox: TBCCheckBox;
    SmartTabsCheckBox: TBCCheckBox;
    SmartTabDeleteCheckBox: TBCCheckBox;
    TripleClickRowSelectCheckBox: TBCCheckBox;
    NonblinkingCaretCheckBox: TBCCheckBox;
    NonblinkingCaretColorLabel: TLabel;
    NonblinkingCaretColorBox: TColorBox;
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure GetData(OptionsContainer: TOptionsContainer);
    procedure PutData(OptionsContainer: TOptionsContainer);
  end;

implementation

{$R *.dfm}

uses
  System.SysUtils, SynEdit, BCCommon.LanguageStrings;

constructor TOptionsEditorOptionsFrame.Create(AOwner: TComponent);
begin
  inherited;
  with InsertCaretComboBox.Items do
  begin
    Add(LanguageDatamodule.GetConstant('VerticalLine'));
    Add(LanguageDatamodule.GetConstant('HorizontalLine'));
    Add(LanguageDatamodule.GetConstant('HalfBlock'));
    Add(LanguageDatamodule.GetConstant('Block'));
  end;
end;

procedure TOptionsEditorOptionsFrame.PutData(OptionsContainer: TOptionsContainer);
begin
  OptionsContainer.AutoIndent := AutoIndentCheckBox.Checked;
  OptionsContainer.AutoSave := AutoSaveCheckBox.Checked;
  OptionsContainer.NonblinkingCaret := NonblinkingCaretCheckBox.Checked;
  OptionsContainer.UndoAfterSave := UndoAfterSaveCheckBox.Checked;
  OptionsContainer.TrimTrailingSpaces := TrimTrailingSpacesCheckBox.Checked;
  OptionsContainer.TripleClickRowSelect := TripleClickRowSelectCheckBox.Checked;
  OptionsContainer.ScrollPastEof := ScrollPastEofCheckBox.Checked;
  OptionsContainer.ScrollPastEol := ScrollPastEolCheckBox.Checked;
  OptionsContainer.TabsToSpaces := TabsToSpacesCheckBox.Checked;
  OptionsContainer.SmartTabs := SmartTabsCheckBox.Checked;
  OptionsContainer.SmartTabDelete := SmartTabDeleteCheckBox.Checked;
  OptionsContainer.LineSpacing := StrToIntDef(LineSpacingEdit.Text, 0);
  OptionsContainer.TabWidth := StrToIntDef(TabWidthEdit.Text, 8);
  OptionsContainer.ColorBrightness := BrightnessTrackBar.Position;
  OptionsContainer.InsertCaret := InsertCaretComboBox.ItemIndex;
  OptionsContainer.NonblinkingCaretColor := ColorToString(NonblinkingCaretColorBox.Selected);
end;

procedure TOptionsEditorOptionsFrame.GetData(OptionsContainer: TOptionsContainer);
begin
  AutoIndentCheckBox.Checked := OptionsContainer.AutoIndent;
  AutoSaveCheckBox.Checked := OptionsContainer.AutoSave;
  NonblinkingCaretCheckBox.Checked := OptionsContainer.NonblinkingCaret;
  UndoAfterSaveCheckBox.Checked := OptionsContainer.UndoAfterSave;
  TrimTrailingSpacesCheckBox.Checked := OptionsContainer.TrimTrailingSpaces;
  TripleClickRowSelectCheckBox.Checked := OptionsContainer.TripleClickRowSelect;
  ScrollPastEofCheckBox.Checked := OptionsContainer.ScrollPastEof;
  ScrollPastEolCheckBox.Checked := OptionsContainer.ScrollPastEol;
  TabsToSpacesCheckBox.Checked := OptionsContainer.TabsToSpaces;
  SmartTabsCheckBox.Checked := OptionsContainer.SmartTabs;
  SmartTabDeleteCheckBox.Checked := OptionsContainer.SmartTabDelete;
  LineSpacingEdit.Text := IntToStr(OptionsContainer.LineSpacing);
  TabWidthEdit.Text := IntToStr(OptionsContainer.TabWidth);
  BrightnessTrackBar.Position := OptionsContainer.ColorBrightness;
  InsertCaretComboBox.ItemIndex := Ord(OptionsContainer.InsertCaret);
  NonblinkingCaretColorBox.Selected := StringToColor(OptionsContainer.NonblinkingCaretColor);
end;

end.
