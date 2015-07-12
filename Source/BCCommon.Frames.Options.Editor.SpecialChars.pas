unit BCCommon.Frames.Options.Editor.SpecialChars;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  sPanel, BCControls.Panel, sComboBox, BCControls.ComboBox, Vcl.ComCtrls, sComboBoxes,
  sGroupBox, BCControls.GroupBox, BCCommon.Frames.Options.Base, sFrameAdapter, acSlider, sLabel;

type
  TOptionsEditorSpecialCharsFrame = class(TBCOptionsBaseFrame)
    ColorComboBoxColor: TBCColorComboBox;
    ColorComboBoxEndOfLineColor: TBCColorComboBox;
    ColorComboBoxSelectionColor: TBCColorComboBox;
    ComboBoxEndOfLineStyle: TBCComboBox;
    ComboBoxStyle: TBCComboBox;
    GroupBoxEndOfLine: TBCGroupBox;
    GroupBoxSelection: TBCGroupBox;
    Panel: TBCPanel;
    StickyLabelUseTextColor: TsStickyLabel;
    SliderUseTextColor: TsSlider;
    StickyEndOfLineVisible: TsStickyLabel;
    SliderEndOfLineVisible: TsSlider;
    StickyLabelSelectionVisible: TsStickyLabel;
    SliderSelectionVisible: TsSlider;
  protected
    procedure Init; override;
    procedure GetData; override;
    procedure PutData; override;
    public
    destructor Destroy; override;
  end;

function OptionsEditorSpecialCharsFrame(AOwner: TComponent): TOptionsEditorSpecialCharsFrame;

implementation

{$R *.dfm}

uses
  BCCommon.Options.Container, BCCommon.Language.Strings;

var
  FOptionsEditorSpecialCharsFrame: TOptionsEditorSpecialCharsFrame;

function OptionsEditorSpecialCharsFrame(AOwner: TComponent): TOptionsEditorSpecialCharsFrame;
begin
  if not Assigned(FOptionsEditorSpecialCharsFrame) then
    FOptionsEditorSpecialCharsFrame := TOptionsEditorSpecialCharsFrame.Create(AOwner);
  Result := FOptionsEditorSpecialCharsFrame;
end;

destructor TOptionsEditorSpecialCharsFrame.Destroy;
begin
  inherited;
  FOptionsEditorSpecialCharsFrame := nil;
end;

procedure TOptionsEditorSpecialCharsFrame.Init;
begin
  inherited;

  with ComboBoxStyle.Items do
  begin
    Clear;
    Add(LanguageDatamodule.GetConstant('Dot'));
    Add(LanguageDatamodule.GetConstant('Solid'));
  end;
  with ComboBoxEndOfLineStyle.Items do
  begin
    Clear;
    Add(LanguageDatamodule.GetConstant('Arrow'));
    Add(LanguageDatamodule.GetConstant('Enter'));
    Add(LanguageDatamodule.GetConstant('Pilcrow'));
  end;
end;

procedure TOptionsEditorSpecialCharsFrame.PutData;
begin
  OptionsContainer.SpecialCharsUseTextColor := SliderUseTextColor.SliderOn;
  OptionsContainer.SpecialCharsStyle := ComboBoxStyle.ItemIndex;
  OptionsContainer.SpecialEndOfLineVisible := SliderEndOfLineVisible.SliderOn;
  OptionsContainer.SpecialEndOfLineColor := ColorComboBoxEndOfLineColor.ColorText;
  OptionsContainer.SpecialCharsEndOfLineStyle := ComboBoxEndOfLineStyle.ItemIndex;
  OptionsContainer.SpecialCharsSelectionVisible := SliderSelectionVisible.SliderOn;
  OptionsContainer.SpecialSelectionColor := ColorComboBoxSelectionColor.ColorText;
end;

procedure TOptionsEditorSpecialCharsFrame.GetData;
begin
  SliderUseTextColor.SliderOn := OptionsContainer.SpecialCharsUseTextColor;
  ComboBoxStyle.ItemIndex := OptionsContainer.SpecialCharsStyle;
  SliderEndOfLineVisible.SliderOn := OptionsContainer.SpecialEndOfLineVisible;
  ColorComboBoxEndOfLineColor.ColorText := OptionsContainer.SpecialEndOfLineColor;
  ComboBoxEndOfLineStyle.ItemIndex := OptionsContainer.SpecialCharsEndOfLineStyle;
  SliderSelectionVisible.SliderOn := OptionsContainer.SpecialCharsSelectionVisible;
  ColorComboBoxSelectionColor.ColorText := OptionsContainer.SpecialSelectionColor;
end;

end.
