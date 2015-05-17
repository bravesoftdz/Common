unit BCCommon.Frames.Options.Editor.Search;

interface

uses
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  BCCommon.Frames.Options.Base, BCControls.Panel, sPanel, sFrameAdapter, acSlider, sLabel;

type
  TOptionsEditorSearchFrame = class(TBCOptionsBaseFrame)
    Panel: TBCPanel;
    StickyLabelDocumentSpecificSearch: TsStickyLabel;
    SliderDocumentSpecificSearch: TsSlider;
    StickyLabelHighlightResults: TsStickyLabel;
    SliderHighlightResults: TsSlider;
    StickyLabelShowSearchMap: TsStickyLabel;
    SliderShowSearchMap: TsSlider;
  protected
    procedure GetData; override;
    procedure PutData; override;
  public
    destructor Destroy; override;
  end;

function OptionsEditorSearchFrame(AOwner: TComponent): TOptionsEditorSearchFrame;

implementation

{$R *.dfm}

uses
  BCCommon.Options.Container, BCCommon.Utils;

var
  FOptionsEditorSearchFrame: TOptionsEditorSearchFrame;

function OptionsEditorSearchFrame(AOwner: TComponent): TOptionsEditorSearchFrame;
begin
  if not Assigned(FOptionsEditorSearchFrame) then
    FOptionsEditorSearchFrame := TOptionsEditorSearchFrame.Create(AOwner);
  Result := FOptionsEditorSearchFrame;
  AlignSliders(Result.Panel);
end;

destructor TOptionsEditorSearchFrame.Destroy;
begin
  inherited;
  FOptionsEditorSearchFrame := nil;
end;

procedure TOptionsEditorSearchFrame.PutData;
begin
  OptionsContainer.DocumentSpecificSearch := SliderDocumentSpecificSearch.SliderOn;
  OptionsContainer.ShowSearchMap := SliderShowSearchMap.SliderOn;
  OptionsContainer.ShowSearchHighlighter := SliderHighlightResults.SliderOn;
end;

procedure TOptionsEditorSearchFrame.GetData;
begin
  SliderDocumentSpecificSearch.SliderOn := OptionsContainer.DocumentSpecificSearch;
  SliderShowSearchMap.SliderOn := OptionsContainer.ShowSearchMap;
  SliderHighlightResults.SliderOn := OptionsContainer.ShowSearchHighlighter;
end;

end.
