unit BCCommon.Frames.Options.Editor.LeftMargin;

interface

uses
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.ExtCtrls, Vcl.StdCtrls, BCControls.CheckBox,
  BCControls.Edit, Vcl.Buttons, BCCommon.Frames.Options.Base, BCControls.Panel,
  Vcl.ComCtrls, sEdit, sCheckBox, sGroupBox, sPanel, sFrameAdapter,
  BCControls.GroupBox;

type

  TOptionsEditorLeftMarginFrame = class(TBCOptionsBaseFrame)
    CheckBoxAutosize: TBCCheckBox;
    CheckBoxIShownTens: TBCCheckBox;
    CheckBoxShowAfterLastLine: TBCCheckBox;
    CheckBoxShowBookmarkPanel: TBCCheckBox;
    CheckBoxShowBookmarks: TBCCheckBox;
    CheckBoxShowLeadingZeros: TBCCheckBox;
    CheckBoxShowLineState: TBCCheckBox;
    CheckBoxVisible: TBCCheckBox;
    EditBookmarkPanelWidth: TBCEdit;
    EditWidth: TBCEdit;
    GroupBoxLineNumbers: TBCGroupBox;
    Panel: TBCPanel;
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
  System.SysUtils, BCCommon.Options.Container;

var
  FOptionsEditorLeftMarginFrame: TOptionsEditorLeftMarginFrame;

function OptionsEditorLeftMarginFrame(AOwner: TComponent): TOptionsEditorLeftMarginFrame;
begin
  if not Assigned(FOptionsEditorLeftMarginFrame) then
    FOptionsEditorLeftMarginFrame := TOptionsEditorLeftMarginFrame.Create(AOwner);
  Result := FOptionsEditorLeftMarginFrame;
end;

destructor TOptionsEditorLeftMarginFrame.Destroy;
begin
  inherited;
  FOptionsEditorLeftMarginFrame := nil;
end;

procedure TOptionsEditorLeftMarginFrame.PutData;
begin
  OptionsContainer.LeftMarginVisible := CheckBoxVisible.Checked;
  OptionsContainer.LeftMarginAutosize := CheckBoxAutosize.Checked;
  OptionsContainer.LeftMarginShowBookmarks := CheckBoxShowBookmarks.Checked;
  OptionsContainer.LeftMarginShowBookmarkPanel := CheckBoxShowBookmarkPanel.Checked;
  OptionsContainer.LeftMarginShowLineState := CheckBoxShowLineState.Checked;
  OptionsContainer.LeftMarginLineNumbersShowInTens := CheckBoxIShownTens.Checked;
  OptionsContainer.LeftMarginLineNumbersShowLeadingZeros := CheckBoxShowLeadingZeros.Checked;
  OptionsContainer.LeftMarginLineNumbersShowAfterLastLine := CheckBoxShowAfterLastLine.Checked;
  OptionsContainer.LeftMarginWidth := StrToIntDef(EditWidth.Text, 57);
  OptionsContainer.LeftMarginBookmarkPanelWidth := StrToIntDef(EditBookmarkPanelWidth.Text, 20);
end;

procedure TOptionsEditorLeftMarginFrame.GetData;
begin
  CheckBoxVisible.Checked := OptionsContainer.LeftMarginVisible;
  CheckBoxAutosize.Checked := OptionsContainer.LeftMarginAutosize;
  CheckBoxShowBookmarks.Checked := OptionsContainer.LeftMarginShowBookmarks;
  CheckBoxShowBookmarkPanel.Checked := OptionsContainer.LeftMarginShowBookmarkPanel;
  CheckBoxShowLineState.Checked := OptionsContainer.LeftMarginShowLineState;
  CheckBoxIShownTens.Checked := OptionsContainer.LeftMarginLineNumbersShowInTens;
  CheckBoxShowLeadingZeros.Checked := OptionsContainer.LeftMarginLineNumbersShowLeadingZeros;
  CheckBoxShowAfterLastLine.Checked := OptionsContainer.LeftMarginLineNumbersShowAfterLastLine;
  EditWidth.Text := IntToStr(OptionsContainer.LeftMarginWidth);
  EditBookmarkPanelWidth.Text := IntToStr(OptionsContainer.LeftMarginBookmarkPanelWidth);
end;

end.
