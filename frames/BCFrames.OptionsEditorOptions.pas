unit BCFrames.OptionsEditorOptions;

interface

uses
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, BCControls.ComboBox,
  BCControls.CheckBox, BCControls.Edit, Vcl.ComCtrls, JvEdit, BCCommon.OptionsContainer, BCFrames.OptionsFrame;

type
  TOptionsEditorOptionsFrame = class(TOptionsFrame)
    Panel: TPanel;
    AutoIndentCheckBox: TBCCheckBox;
    TrimTrailingSpacesCheckBox: TBCCheckBox;
    ScrollPastEofCheckBox: TBCCheckBox;
    ScrollPastEolCheckBox: TBCCheckBox;
    LineSpacingLabel: TLabel;
    LineSpacingEdit: TBCEdit;
    TabWidthLabel: TLabel;
    TabWidthEdit: TBCEdit;
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
    ShowScrollHintCheckBox: TBCCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure GetData(OptionsContainer: TOptionsContainer); override;
    procedure PutData(OptionsContainer: TOptionsContainer); override;
  end;

function OptionsEditorOptionsFrame(AOwner: TComponent): TOptionsEditorOptionsFrame;

implementation

{$R *.dfm}

uses
  System.SysUtils, SynEdit, BCCommon.LanguageStrings, BCCommon.LanguageUtils;

var
  FOptionsEditorOptionsFrame: TOptionsEditorOptionsFrame;

function OptionsEditorOptionsFrame(AOwner: TComponent): TOptionsEditorOptionsFrame;
begin
  if not Assigned(FOptionsEditorOptionsFrame) then
    FOptionsEditorOptionsFrame := TOptionsEditorOptionsFrame.Create(AOwner);
  Result := FOptionsEditorOptionsFrame;
end;

destructor TOptionsEditorOptionsFrame.Destroy;
begin
  inherited;
  FOptionsEditorOptionsFrame := nil;
end;

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
  OptionsContainer.ShowScrollHint := ShowScrollHintCheckBox.Checked;
  OptionsContainer.TabsToSpaces := TabsToSpacesCheckBox.Checked;
  OptionsContainer.SmartTabs := SmartTabsCheckBox.Checked;
  OptionsContainer.SmartTabDelete := SmartTabDeleteCheckBox.Checked;
  OptionsContainer.LineSpacing := StrToIntDef(LineSpacingEdit.Text, 0);
  OptionsContainer.TabWidth := StrToIntDef(TabWidthEdit.Text, 8);
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
  ShowScrollHintCheckBox.Checked := OptionsContainer.ShowScrollHint;
  TabsToSpacesCheckBox.Checked := OptionsContainer.TabsToSpaces;
  SmartTabsCheckBox.Checked := OptionsContainer.SmartTabs;
  SmartTabDeleteCheckBox.Checked := OptionsContainer.SmartTabDelete;
  LineSpacingEdit.Text := IntToStr(OptionsContainer.LineSpacing);
  TabWidthEdit.Text := IntToStr(OptionsContainer.TabWidth);
  InsertCaretComboBox.ItemIndex := Ord(OptionsContainer.InsertCaret);
  NonblinkingCaretColorBox.Selected := StringToColor(OptionsContainer.NonblinkingCaretColor);
end;

end.
