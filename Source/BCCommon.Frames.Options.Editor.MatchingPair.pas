unit BCCommon.Frames.Options.Editor.MatchingPair;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  sPanel, BCControls.Panel, BCCommon.Frames.Options.Base, sFrameAdapter, sLabel, acSlider;

type
  TOptionsEditorMatchingPairFrame = class(TBCOptionsBaseFrame)
    Panel: TBCPanel;
    SliderEnabled: TsSlider;
    StickyLabelEnabled: TsStickyLabel;
    StickyLabelHighlightAfterToken: TsStickyLabel;
    SliderHighlightAfterToken: TsSlider;
    StickyLabelHighlightUnmatched: TsStickyLabel;
    SliderHighlightUnmatched: TsSlider;
  protected
    procedure GetData; override;
    procedure PutData; override;
  public
    destructor Destroy; override;
  end;

function OptionsEditorMatchingPairFrame(AOwner: TComponent): TOptionsEditorMatchingPairFrame;

implementation

{$R *.dfm}

uses
  BCCommon.Options.Container, BCCommon.Utils;

var
  FOptionsEditorMatchingPairFrame: TOptionsEditorMatchingPairFrame;

function OptionsEditorMatchingPairFrame(AOwner: TComponent): TOptionsEditorMatchingPairFrame;
begin
  if not Assigned(FOptionsEditorMatchingPairFrame) then
    FOptionsEditorMatchingPairFrame := TOptionsEditorMatchingPairFrame.Create(AOwner);
  Result := FOptionsEditorMatchingPairFrame;
  AlignSliders(Result.Panel);
end;

destructor TOptionsEditorMatchingPairFrame.Destroy;
begin
  inherited;
  FOptionsEditorMatchingPairFrame := nil;
end;

procedure TOptionsEditorMatchingPairFrame.PutData;
begin
  OptionsContainer.MatchingPairEnabled := SliderEnabled.SliderOn;
  OptionsContainer.MatchingPairHighlightAfterToken := SliderHighlightAfterToken.SliderOn;
  OptionsContainer.MatchingPairHighlightUnmatched := SliderHighlightUnmatched.SliderOn;
end;

procedure TOptionsEditorMatchingPairFrame.GetData;
begin
  SliderEnabled.SliderOn := OptionsContainer.MatchingPairEnabled;
  SliderHighlightAfterToken.SliderOn := OptionsContainer.MatchingPairHighlightAfterToken;
  SliderHighlightUnmatched.SliderOn := OptionsContainer.MatchingPairHighlightUnmatched;
end;

end.
