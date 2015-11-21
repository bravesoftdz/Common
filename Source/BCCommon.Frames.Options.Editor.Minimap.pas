unit BCCommon.Frames.Options.Editor.Minimap;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, BCControls.Edit,
  BCControls.Panel, BCCommon.Frames.Options.Base, acSlider, sLabel, sEdit, Vcl.ExtCtrls, sPanel, sFrameAdapter;

type
  TOptionsEditorMinimapFrame = class(TBCOptionsBaseFrame)
    EditWidth: TBCEdit;
    Panel: TBCPanel;
    StickyLabelVisible: TsStickyLabel;
    SliderVisible: TsSlider;
    StickyLabelShowIndentGuides: TsStickyLabel;
    SliderShowIndentGuides: TsSlider;
    SliderShowBookmarks: TsSlider;
    StickyLabelShowBookmarks: TsStickyLabel;
  protected
    procedure GetData; override;
    procedure PutData; override;
  public
    destructor Destroy; override;
  end;

function OptionsEditorMinimapFrame(AOwner: TComponent): TOptionsEditorMinimapFrame;

implementation

{$R *.dfm}

uses
  System.SysUtils, BCCommon.Options.Container, BCCommon.Utils;

var
  FOptionsEditorMinimapFrame: TOptionsEditorMinimapFrame;

function OptionsEditorMinimapFrame(AOwner: TComponent): TOptionsEditorMinimapFrame;
begin
  if not Assigned(FOptionsEditorMinimapFrame) then
    FOptionsEditorMinimapFrame := TOptionsEditorMinimapFrame.Create(AOwner);
  Result := FOptionsEditorMinimapFrame;
  AlignSliders(Result.Panel);
end;

destructor TOptionsEditorMinimapFrame.Destroy;
begin
  inherited;
  FOptionsEditorMinimapFrame := nil;
end;

procedure TOptionsEditorMinimapFrame.PutData;
begin
  OptionsContainer.MinimapVisible := SliderVisible.SliderOn;
  OptionsContainer.MinimapShowBookmarks := SliderShowBookmarks.SliderOn;
  OptionsContainer.MinimapShowIndentGuides := SliderShowIndentGuides.SliderOn;
  OptionsContainer.MinimapWidth := StrToIntDef(EditWidth.Text, 100);
end;

procedure TOptionsEditorMinimapFrame.GetData;
begin
  SliderVisible.SliderOn := OptionsContainer.MinimapVisible;
  SliderShowBookmarks.SliderOn := OptionsContainer.MinimapShowBookmarks;
  SliderShowIndentGuides.SliderOn := OptionsContainer.MinimapShowIndentGuides;
  EditWidth.Text := IntToStr(OptionsContainer.MinimapWidth);
end;

end.
