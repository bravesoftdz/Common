unit BCCommon.Frames.Options.Editor.SpecialChars;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sCheckBox, BCControls.CheckBox, Vcl.ExtCtrls,
  sPanel, BCControls.Panel, sComboBox, BCControls.ComboBox, Vcl.ComCtrls, sComboBoxes, BCControls.ColorComboBox,
  sGroupBox, BCControls.GroupBox, BCCommon.Frames.Options.Base, sFrameAdapter;

type
  TOptionsEditorSpecialCharsFrame = class(TBCOptionsBaseFrame)
    CheckBoxEndOfLineVisible: TBCCheckBox;
    CheckBoxSelectionVisible: TBCCheckBox;
    CheckBoxUseTextColor: TBCCheckBox;
    ColorComboBoxColor: TBCColorComboBox;
    ColorComboBoxEndOfLineColor: TBCColorComboBox;
    ColorComboBoxSelectionColor: TBCColorComboBox;
    ComboBoxEndOfLineStyle: TBCComboBox;
    ComboBoxStyle: TBCComboBox;
    GroupBoxEndOfLine: TBCGroupBox;
    GroupBoxSelection: TBCGroupBox;
    Panel: TBCPanel;
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
    Add(LanguageDatamodule.GetConstant('Pilcrow'));
  end;
end;

procedure TOptionsEditorSpecialCharsFrame.PutData;
begin
  OptionsContainer.SpecialCharsUseTextColor := CheckBoxUseTextColor.Checked;
  OptionsContainer.SpecialCharsStyle := ComboBoxStyle.ItemIndex;
  OptionsContainer.SpecialEndOfLineVisible := CheckBoxEndOfLineVisible.Checked;
  OptionsContainer.SpecialEndOfLineColor := ColorComboBoxEndOfLineColor.Text;
  OptionsContainer.SpecialCharsEndOfLineStyle := ComboBoxEndOfLineStyle.ItemIndex;
  OptionsContainer.SpecialCharsSelectionVisible := CheckBoxSelectionVisible.Checked;
  OptionsContainer.SpecialSelectionColor := ColorComboBoxSelectionColor.Text;
end;

procedure TOptionsEditorSpecialCharsFrame.GetData;
begin
  CheckBoxUseTextColor.Checked := OptionsContainer.SpecialCharsUseTextColor;
  ComboBoxStyle.ItemIndex := OptionsContainer.SpecialCharsStyle;
  CheckBoxEndOfLineVisible.Checked := OptionsContainer.SpecialEndOfLineVisible;
  ColorComboBoxEndOfLineColor.Text := OptionsContainer.SpecialEndOfLineColor;
  ComboBoxEndOfLineStyle.ItemIndex := OptionsContainer.SpecialCharsEndOfLineStyle;
  CheckBoxSelectionVisible.Checked := OptionsContainer.SpecialCharsSelectionVisible;
  ColorComboBoxSelectionColor.Text := OptionsContainer.SpecialSelectionColor;
end;

end.
