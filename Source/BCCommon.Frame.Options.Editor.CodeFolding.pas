unit BCCommon.Frame.Options.Editor.CodeFolding;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, BCControl.Panel, sComboBox, BCControl.ComboBox, BCCommon.Frame.Options.Base,
  acSlider, sLabel, BCControl.Edit, sEdit, Vcl.ExtCtrls, sPanel, sFrameAdapter;

type
  TOptionsEditorCodeFoldingFrame = class(TBCOptionsBaseFrame)
    ComboBoxMarkStyle: TBCComboBox;
    EditHintRowCount: TBCEdit;
    Panel: TBCPanel;
    SliderFoldMultilineComments: TsSlider;
    SliderHighlightIndentGuides: TsSlider;
    SliderHighlightMatchingPair: TsSlider;
    SliderShowCollapsedCodeHint: TsSlider;
    SliderShowCollapsedLine: TsSlider;
    SliderShowIndentGuides: TsSlider;
    SliderShowTreeLine: TsSlider;
    SliderUncollapseByHintClick: TsSlider;
    SliderVisible: TsSlider;
    StickyLabelFoldMultilineComments: TsStickyLabel;
    StickyLabelHighlightIndentGuides: TsStickyLabel;
    StickyLabelHighlightMatchingPair: TsStickyLabel;
    StickyLabelShowCollapsedCodeHint: TsStickyLabel;
    StickyLabelShowCollapsedLine: TsStickyLabel;
    StickyLabelShowIndentGuides: TsStickyLabel;
    StickyLabelShowTreeLine: TsStickyLabel;
    StickyLabelUncollapseByHintClick: TsStickyLabel;
    StickyLabelVisible: TsStickyLabel;
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
  BCCommon.Options.Container, BCCommon.Language.Strings, BCCommon.Utils;

var
  FOptionsEditorCodeFoldingFrame: TOptionsEditorCodeFoldingFrame;

function OptionsEditorCodeFoldingFrame(AOwner: TComponent): TOptionsEditorCodeFoldingFrame;
begin
  if not Assigned(FOptionsEditorCodeFoldingFrame) then
    FOptionsEditorCodeFoldingFrame := TOptionsEditorCodeFoldingFrame.Create(AOwner);
  Result := FOptionsEditorCodeFoldingFrame;
  AlignSliders(Result.Panel);
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
    Add(LanguageDatamodule.GetConstant('Circle'));
    Add(LanguageDatamodule.GetConstant('Square'));
    Add(LanguageDatamodule.GetConstant('Triangle'));
  end;
end;

procedure TOptionsEditorCodeFoldingFrame.PutData;
begin
  with OptionsContainer do
  begin
    ShowCodeFolding := SliderVisible.SliderOn;
    FoldMultilineComments := SliderFoldMultilineComments.SliderOn;
    HighlightIndentGuides := SliderHighlightIndentGuides.SliderOn;
    HighlightMatchingPair := SliderHighlightMatchingPair.SliderOn;
    ShowCollapsedCodeHint := SliderShowCollapsedCodeHint.SliderOn;
    ShowCollapsedLine := SliderShowCollapsedLine.SliderOn;
    ShowIndentGuides := SliderShowIndentGuides.SliderOn;
    ShowTreeLine := SliderShowTreeLine.SliderOn;
    UncollapseByHintClick := SliderUncollapseByHintClick.SliderOn;
    CodeFoldingMarkStyle := ComboBoxMarkStyle.ItemIndex;
    CodeFoldingHintRowCount := StrToIntDef(EditHintRowCount.Text, 40);
  end;
end;

procedure TOptionsEditorCodeFoldingFrame.GetData;
begin
  with OptionsContainer do
  begin
    SliderVisible.SliderOn := ShowCodeFolding;
    SliderFoldMultilineComments.SliderOn := FoldMultilineComments;
    SliderHighlightIndentGuides.SliderOn := HighlightIndentGuides;
    SliderHighlightMatchingPair.SliderOn := HighlightMatchingPair;
    SliderShowCollapsedCodeHint.SliderOn := ShowCollapsedCodeHint;
    SliderShowCollapsedLine.SliderOn := ShowCollapsedLine;
    SliderShowIndentGuides.SliderOn := ShowIndentGuides;
    SliderShowTreeLine.SliderOn := ShowTreeLine;
    SliderUncollapseByHintClick.SliderOn := UncollapseByHintClick;
    ComboBoxMarkStyle.ItemIndex := CodeFoldingMarkStyle;
    EditHintRowCount.Text := IntToStr(CodeFoldingHintRowCount);
  end;
end;

end.
