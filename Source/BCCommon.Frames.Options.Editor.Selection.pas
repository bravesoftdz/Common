unit BCCommon.Frames.Options.Editor.Selection;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  sPanel, BCControls.Panel, BCCommon.Frames.Options.Base, sFrameAdapter, acSlider, sLabel;

type
  TOptionsEditorSelectionFrame = class(TBCOptionsBaseFrame)
    Panel: TBCPanel;
    StickyLabelTripleClickRowSelect: TsStickyLabel;
    SliderTripleClickRowSelect: TsSlider;
    StickyLabelHighlightSimilarTerms: TsStickyLabel;
    SliderHighlightSimilarTerms: TsSlider;
    StickyLabelVisible: TsStickyLabel;
    SliderVisible: TsSlider;
    StickyLabelALTSetsColumnMode: TsStickyLabel;
    SliderALTSetsColumnMode: TsSlider;
    StickyLabelToEndOfLine: TsStickyLabel;
    SliderToEndOfLine: TsSlider;
  protected
    procedure GetData; override;
    procedure PutData; override;
  public
    destructor Destroy; override;
  end;

function OptionsEditorSelectionFrame(AOwner: TComponent): TOptionsEditorSelectionFrame;

implementation

{$R *.dfm}

uses
  BCCommon.Options.Container, BCCommon.Utils;

var
  FOptionsEditorSelectionFrame: TOptionsEditorSelectionFrame;

function OptionsEditorSelectionFrame(AOwner: TComponent): TOptionsEditorSelectionFrame;
begin
  if not Assigned(FOptionsEditorSelectionFrame) then
    FOptionsEditorSelectionFrame := TOptionsEditorSelectionFrame.Create(AOwner);
  Result := FOptionsEditorSelectionFrame;
  AlignSliders(Result.Panel);
end;

destructor TOptionsEditorSelectionFrame.Destroy;
begin
  inherited;
  FOptionsEditorSelectionFrame := nil;
end;

procedure TOptionsEditorSelectionFrame.PutData;
begin
  OptionsContainer.SelectionVisible := SliderVisible.SliderOn;
  OptionsContainer.ALTSetsColumnMode := SliderALTSetsColumnMode.SliderOn;
  OptionsContainer.HighlightSimilarTerms := SliderHighlightSimilarTerms.SliderOn;
  OptionsContainer.SelectionToEndOfLine := SliderToEndOfLine.SliderOn;
  OptionsContainer.TripleClickRowSelect := SliderTripleClickRowSelect.SliderOn;
end;

procedure TOptionsEditorSelectionFrame.GetData;
begin
  SliderVisible.SliderOn := OptionsContainer.SelectionVisible;
  SliderALTSetsColumnMode.SliderOn := OptionsContainer.ALTSetsColumnMode;
  SliderHighlightSimilarTerms.SliderOn := OptionsContainer.HighlightSimilarTerms;
  SliderToEndOfLine.SliderOn := OptionsContainer.SelectionToEndOfLine;
  SliderTripleClickRowSelect.SliderOn := OptionsContainer.TripleClickRowSelect;
end;

end.
