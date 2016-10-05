unit BCCommon.Frame.Options.Editor.Search;

interface

uses
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  BCCommon.Frame.Options.Base, BCControl.Panel, acSlider, sLabel, Vcl.StdCtrls, Vcl.ExtCtrls, sPanel, sFrameAdapter,
  sComboBox, BCControl.ComboBox;

type
  TOptionsEditorSearchFrame = class(TBCOptionsBaseFrame)
    Panel: TBCPanel;
    StickyLabelDocumentSpecificSearch: TsStickyLabel;
    SliderDocumentSpecificSearch: TsSlider;
    StickyLabelShowSearchMap: TsStickyLabel;
    SliderShowSearchMap: TsSlider;
    StickyLabelVisible: TsStickyLabel;
    SliderVisible: TsSlider;
    ComboBoxAlign: TBCComboBox;
    SliderClearWhenClosed: TsSlider;
    StickyLabelClearWhenClosed: TsStickyLabel;
  protected
    procedure GetData; override;
    procedure Init; override;
    procedure PutData; override;
  public
    destructor Destroy; override;
  end;

function OptionsEditorSearchFrame(AOwner: TComponent): TOptionsEditorSearchFrame;

implementation

{$R *.dfm}

uses
  BCCommon.Options.Container, BCCommon.Utils, BCCommon.Language.Strings;

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

procedure TOptionsEditorSearchFrame.Init;
begin
  with ComboBoxAlign.Items do
  begin
    Add(LanguageDatamodule.GetSQLFormatter('Left'));
    Add(LanguageDatamodule.GetSQLFormatter('Right'));
  end;
end;

procedure TOptionsEditorSearchFrame.PutData;
begin
  with OptionsContainer do
  begin
    SearchVisible := SliderVisible.SliderOn;
    SearchClearWhenClosed := SliderClearWhenClosed.SliderOn;
    DocumentSpecificSearch := SliderDocumentSpecificSearch.SliderOn;
    ShowSearchMap := SliderShowSearchMap.SliderOn;
    SearchMapAlign := ComboBoxAlign.ItemIndex;
  end;
end;

procedure TOptionsEditorSearchFrame.GetData;
begin
  with OptionsContainer do
  begin
    SliderVisible.SliderOn := SearchVisible;
    SliderClearWhenClosed.SliderOn := SearchClearWhenClosed;
    SliderDocumentSpecificSearch.SliderOn := DocumentSpecificSearch;
    SliderShowSearchMap.SliderOn := ShowSearchMap;
    ComboBoxAlign.ItemIndex := SearchMapAlign;
  end;
end;

end.
