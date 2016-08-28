unit BCCommon.Frame.Options.Editor.Selection;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  BCControl.Panel, BCCommon.Frame.Options.Base, acSlider, sLabel, Vcl.StdCtrls, Vcl.ExtCtrls, sPanel, sFrameAdapter;

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
    SliderTermsCaseSensitive: TsSlider;
    StickyLabelTermsCaseSensitive: TsStickyLabel;
    SliderExpandRealNumbers: TsSlider;
    StickyLabelExpandRealNumbers: TsStickyLabel;
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
  OptionsContainer.SelectionExpandRealNumbers := SliderExpandRealNumbers.SliderOn;
  OptionsContainer.HighlightSimilarTerms := SliderHighlightSimilarTerms.SliderOn;
  OptionsContainer.SelectionTermsCaseSensitive := SliderTermsCaseSensitive.SliderOn;
  OptionsContainer.TripleClickRowSelect := SliderTripleClickRowSelect.SliderOn;
end;

procedure TOptionsEditorSelectionFrame.GetData;
begin
  SliderVisible.SliderOn := OptionsContainer.SelectionVisible;
  SliderALTSetsColumnMode.SliderOn := OptionsContainer.ALTSetsColumnMode;
  SliderExpandRealNumbers.SliderOn := OptionsContainer.SelectionExpandRealNumbers;
  SliderHighlightSimilarTerms.SliderOn := OptionsContainer.HighlightSimilarTerms;
  SliderTermsCaseSensitive.SliderOn := OptionsContainer.SelectionTermsCaseSensitive;
  SliderTripleClickRowSelect.SliderOn := OptionsContainer.TripleClickRowSelect;
end;

end.
