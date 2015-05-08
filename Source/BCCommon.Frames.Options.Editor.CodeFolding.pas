unit BCCommon.Frames.Options.Editor.CodeFolding;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sCheckBox, BCControls.CheckBox, Vcl.ExtCtrls,
  sPanel, BCControls.Panel, sComboBox, BCControls.ComboBox, BCCommon.Frames.Options.Base, sFrameAdapter;

type
  TOptionsEditorCodeFoldingFrame = class(TBCOptionsBaseFrame)
    CheckBoxFoldMultilineComments: TBCCheckBox;
    CheckBoxHighlightIndenGuides: TBCCheckBox;
    CheckBoxHighlightMatchingPair: TBCCheckBox;
    CheckBoxShowCollapsedCodeHint: TBCCheckBox;
    CheckBoxShowCollapsedLine: TBCCheckBox;
    CheckBoxShowIndentGuides: TBCCheckBox;
    CheckBoxUncollapseByHintClick: TBCCheckBox;
    CheckBoxVisible: TBCCheckBox;
    ComboBoxMarkStyle: TBCComboBox;
    Panel: TBCPanel;
  protected
    procedure Init; override;
    procedure GetData; override;
    procedure PutData; override;
  public
    destructor Destroy; override;
  end;

function OptionsEditorCodeFoldingFrame(AOwner: TComponent): TOptionsEditorCodeFoldingFrame;

implementation

{$R *.dfm}

uses
  BCCommon.Options.Container, BCCommon.Language.Strings;

var
  FOptionsEditorCodeFoldingFrame: TOptionsEditorCodeFoldingFrame;

function OptionsEditorCodeFoldingFrame(AOwner: TComponent): TOptionsEditorCodeFoldingFrame;
begin
  if not Assigned(FOptionsEditorCodeFoldingFrame) then
    FOptionsEditorCodeFoldingFrame := TOptionsEditorCodeFoldingFrame.Create(AOwner);
  Result := FOptionsEditorCodeFoldingFrame;
end;

destructor TOptionsEditorCodeFoldingFrame.Destroy;
begin
  inherited;
  FOptionsEditorCodeFoldingFrame := nil;
end;

procedure TOptionsEditorCodeFoldingFrame.Init;
begin
  inherited;
  with ComboBoxMarkStyle.Items do
  begin
    Clear;
    Add(LanguageDatamodule.GetConstant('Square'));
    Add(LanguageDatamodule.GetConstant('Circle'));
  end;
end;

procedure TOptionsEditorCodeFoldingFrame.PutData;
begin
  OptionsContainer.ShowCodeFolding := CheckBoxVisible.Checked;
  OptionsContainer.FoldMultilineComments := CheckBoxFoldMultilineComments.Checked;
  OptionsContainer.HighlightIndentGuides := CheckBoxShowIndentGuides.Checked;
  OptionsContainer.HighlightMatchingPair := CheckBoxHighlightMatchingPair.Checked;
  OptionsContainer.ShowCollapsedCodeHint := CheckBoxShowCollapsedCodeHint.Checked;
  OptionsContainer.ShowCollapsedLine := CheckBoxShowCollapsedLine.Checked;
  OptionsContainer.ShowIndentGuides := CheckBoxShowIndentGuides.Checked;
  OptionsContainer.UncollapseByHintClick := CheckBoxUncollapseByHintClick.Checked;
  OptionsContainer.CodeFoldingMarkStyle := ComboBoxMarkStyle.ItemIndex;
end;

procedure TOptionsEditorCodeFoldingFrame.GetData;
begin
  CheckBoxVisible.Checked := OptionsContainer.ShowCodeFolding;
  CheckBoxFoldMultilineComments.Checked := OptionsContainer.FoldMultilineComments;
  CheckBoxShowIndentGuides.Checked := OptionsContainer.HighlightIndentGuides;
  CheckBoxHighlightMatchingPair.Checked := OptionsContainer.HighlightMatchingPair;
  CheckBoxShowCollapsedCodeHint.Checked := OptionsContainer.ShowCollapsedCodeHint;
  CheckBoxShowCollapsedLine.Checked := OptionsContainer.ShowCollapsedLine;
  CheckBoxShowIndentGuides.Checked := OptionsContainer.ShowIndentGuides;
  CheckBoxUncollapseByHintClick.Checked := OptionsContainer.UncollapseByHintClick;
  ComboBoxMarkStyle.ItemIndex := OptionsContainer.CodeFoldingMarkStyle;
end;

end.
