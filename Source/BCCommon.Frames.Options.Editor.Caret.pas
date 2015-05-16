unit BCCommon.Frames.Options.Editor.Caret;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, sComboBoxes, BCControls.ComboBox, Vcl.StdCtrls,
  sComboBox, sCheckBox, BCControls.CheckBox, Vcl.ExtCtrls, sPanel,
  BCControls.Panel, sGroupBox, BCControls.GroupBox, BCCommon.Frames.Options.Base, sFrameAdapter;

type
  TOptionsEditorCaretFrame = class(TBCOptionsBaseFrame)
    CheckBoxNonblinkingCaretEnabled: TBCCheckBox;
    CheckBoxRightMouseClickMovesCaret: TBCCheckBox;
    CheckBoxVisible: TBCCheckBox;
    ColorBoxNonblinkingCaretBackground: TBCColorComboBox;
    ColorBoxNonblinkingCaretForeground: TBCColorComboBox;
    ComboBoxStylesInsertCaret: TBCComboBox;
    ComboBoxStylesOverwriteCaret: TBCComboBox;
    GroupBoxNonBlinkingCaret: TBCGroupBox;
    GroupBoxStyles: TBCGroupBox;
    Panel: TBCPanel;
  public
    destructor Destroy; override;
    procedure Init; override;
    procedure GetData; override;
    procedure PutData; override;
  end;

function OptionsEditorCaretFrame(AOwner: TComponent): TOptionsEditorCaretFrame;

implementation

{$R *.dfm}

uses
  BCCommon.Options.Container, BCCommon.Language.Strings;

var
  FOptionsEditorCaretFrame: TOptionsEditorCaretFrame;

function OptionsEditorCaretFrame(AOwner: TComponent): TOptionsEditorCaretFrame;
begin
  if not Assigned(FOptionsEditorCaretFrame) then
    FOptionsEditorCaretFrame := TOptionsEditorCaretFrame.Create(AOwner);
  Result := FOptionsEditorCaretFrame;
end;

destructor TOptionsEditorCaretFrame.Destroy;
begin
  inherited;
  FOptionsEditorCaretFrame := nil;
end;

procedure TOptionsEditorCaretFrame.Init;

  procedure AddComboItems(AComboBox: TBCComboBox);
  begin
    with AComboBox.Items do
    begin
      Clear;
      Add(LanguageDatamodule.GetConstant('VerticalLine'));
      Add(LanguageDatamodule.GetConstant('ThinVerticalLine'));
      Add(LanguageDatamodule.GetConstant('HorizontalLine'));
      Add(LanguageDatamodule.GetConstant('ThinHorizontalLine'));
      Add(LanguageDatamodule.GetConstant('HalfBlock'));
      Add(LanguageDatamodule.GetConstant('Block'));
    end;
  end;

begin
  inherited;

  AddComboItems(ComboBoxStylesInsertCaret);
  AddComboItems(ComboBoxStylesOverwriteCaret);
end;

procedure TOptionsEditorCaretFrame.PutData;
begin
  OptionsContainer.ShowCaret := CheckBoxVisible.Checked;
  OptionsContainer.RightMouseClickMovesCaret := CheckBoxRightMouseClickMovesCaret.Checked;
  OptionsContainer.ShowNonblinkingCaret := CheckBoxNonblinkingCaretEnabled.Checked;
  OptionsContainer.NonblinkingCaretBackgroundColor := ColorBoxNonblinkingCaretBackground.Text;
  OptionsContainer.NonblinkingCaretForegroundColor := ColorBoxNonblinkingCaretForeground.Text;
  OptionsContainer.InsertCaret := ComboBoxStylesInsertCaret.ItemIndex;
  OptionsContainer.OverwriteCaret := ComboBoxStylesOverwriteCaret.ItemIndex;
end;

procedure TOptionsEditorCaretFrame.GetData;
begin
  CheckBoxVisible.Checked := OptionsContainer.ShowCaret;
  CheckBoxRightMouseClickMovesCaret.Checked := OptionsContainer.RightMouseClickMovesCaret;
  ColorBoxNonblinkingCaretBackground.Text := OptionsContainer.NonblinkingCaretBackgroundColor;
  ColorBoxNonblinkingCaretForeground.Text := OptionsContainer.NonblinkingCaretForegroundColor;
  ComboBoxStylesInsertCaret.ItemIndex := OptionsContainer.InsertCaret;
  ComboBoxStylesOverwriteCaret.ItemIndex := OptionsContainer.OverwriteCaret;
end;

end.
