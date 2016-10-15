unit BCCommon.Frame.Options.Editor.LeftMargin;

interface

uses
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, BCControl.Edit,
  BCCommon.Frame.Options.Base, BCControl.Panel,
  BCControl.GroupBox, acSlider, sLabel, sGroupBox, sEdit, Vcl.ExtCtrls, sPanel, sFrameAdapter, Vcl.ComCtrls,
  sComboBoxes, BCControl.ComboBox;

type
  TOptionsEditorLeftMarginFrame = class(TBCOptionsBaseFrame)
    EditBookmarkPanelWidth: TBCEdit;
    EditWidth: TBCEdit;
    GroupBoxLineNumbers: TBCGroupBox;
    Panel: TBCPanel;
    StickyLabelVisible: TsStickyLabel;
    SliderVisible: TsSlider;
    StickyLabelAutosize: TsStickyLabel;
    SliderAutosize: TsSlider;
    StickyLabelShowBookmarks: TsStickyLabel;
    SliderShowBookmarks: TsSlider;
    StickyLabelShowBookmarkPanel: TsStickyLabel;
    SliderShowBookmarkPanel: TsSlider;
    StickyLabelShowLineState: TsStickyLabel;
    SliderShowLineState: TsSlider;
    StickyLabelShowInTens: TsStickyLabel;
    SliderShowInTens: TsSlider;
    StickyLabelShowLeadingZeros: TsStickyLabel;
    SliderShowLeadingZeros: TsSlider;
    StickyLabelShowAfterLastLine: TsStickyLabel;
    SliderShowAfterLastLine: TsSlider;
    EditLineNumbersStartFrom: TBCEdit;
    ColorComboBoxBookmarkLineColor: TBCColorComboBox;
  protected
    procedure GetData; override;
    procedure PutData; override;
  public
    destructor Destroy; override;
  end;

function OptionsEditorLeftMarginFrame(AOwner: TComponent): TOptionsEditorLeftMarginFrame;

implementation

{$R *.dfm}

uses
  System.SysUtils, BCCommon.Options.Container, BCCommon.Utils;

var
  FOptionsEditorLeftMarginFrame: TOptionsEditorLeftMarginFrame;

function OptionsEditorLeftMarginFrame(AOwner: TComponent): TOptionsEditorLeftMarginFrame;
begin
  if not Assigned(FOptionsEditorLeftMarginFrame) then
    FOptionsEditorLeftMarginFrame := TOptionsEditorLeftMarginFrame.Create(AOwner);
  Result := FOptionsEditorLeftMarginFrame;
  AlignSliders(Result.Panel);
  AlignSliders(Result.GroupBoxLineNumbers, 10);
  Result.GroupBoxLineNumbers.Width := Result.SliderShowInTens.Left + Result.SliderShowInTens.Width + 13;
  Result.AutoSize := False;
  Result.Panel.AutoSize := False;
  Result.Panel.AutoSize := True;
  Result.AutoSize := True;
end;

destructor TOptionsEditorLeftMarginFrame.Destroy;
begin
  inherited;
  FOptionsEditorLeftMarginFrame := nil;
end;

procedure TOptionsEditorLeftMarginFrame.PutData;
begin
  with OptionsContainer do
  begin
    LeftMarginVisible := SliderVisible.SliderOn;
    LeftMarginAutosize := SliderAutosize.SliderOn;
    LeftMarginShowBookmarks := SliderShowBookmarks.SliderOn;
    LeftMarginShowBookmarkPanel := SliderShowBookmarkPanel.SliderOn;
    LeftMarginShowLineState := SliderShowLineState.SliderOn;
    LeftMarginLineNumbersShowInTens := SliderShowInTens.SliderOn;
    LeftMarginLineNumbersShowLeadingZeros := SliderShowLeadingZeros.SliderOn;
    LeftMarginLineNumbersShowAfterLastLine := SliderShowAfterLastLine.SliderOn;
    LeftMarginLineNumbersStartFrom := StrToIntDef(EditLineNumbersStartFrom.Text, 1);
    LeftMarginWidth := StrToIntDef(EditWidth.Text, 57);
    LeftMarginBookmarkPanelWidth := StrToIntDef(EditBookmarkPanelWidth.Text, 20);
    LeftMarginBookmarkLineColor := ColorComboBoxBookmarkLineColor.ColorText;
  end;
end;

procedure TOptionsEditorLeftMarginFrame.GetData;
begin
  with OptionsContainer do
  begin
    SliderVisible.SliderOn := LeftMarginVisible;
    SliderAutosize.SliderOn := LeftMarginAutosize;
    SliderShowBookmarks.SliderOn := LeftMarginShowBookmarks;
    SliderShowBookmarkPanel.SliderOn := LeftMarginShowBookmarkPanel;
    SliderShowLineState.SliderOn := LeftMarginShowLineState;
    SliderShowInTens.SliderOn := LeftMarginLineNumbersShowInTens;
    SliderShowLeadingZeros.SliderOn := LeftMarginLineNumbersShowLeadingZeros;
    SliderShowAfterLastLine.SliderOn := LeftMarginLineNumbersShowAfterLastLine;
    EditLineNumbersStartFrom.Text := IntToStr(LeftMarginLineNumbersStartFrom);
    EditWidth.Text := IntToStr(LeftMarginWidth);
    EditBookmarkPanelWidth.Text := IntToStr(LeftMarginBookmarkPanelWidth);
    ColorComboBoxBookmarkLineColor.ColorText := LeftMarginBookmarkLineColor;
  end;
end;

end.
