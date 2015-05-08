unit BCCommon.Frames.Options.Editor.Scroll;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  sCheckBox, BCControls.CheckBox, Vcl.ExtCtrls, sPanel,
  BCControls.Panel, BCCommon.Frames.Options.Base, sFrameAdapter;

type
  TOptionsEditorScrollFrame = class(TBCOptionsBaseFrame)
    CheckBoxAutosizeMaxWidth: TBCCheckBox;
    CheckBoxHalfPage: TBCCheckBox;
    CheckBoxHintFollows: TBCCheckBox;
    CheckBoxPastEndOfFile: TBCCheckBox;
    CheckBoxPastEndOfLineMarker: TBCCheckBox;
    CheckBoxShowHint: TBCCheckBox;
    Panel: TBCPanel;
  protected
    procedure GetData; override;
    procedure PutData; override;
  public
    destructor Destroy; override;
  end;

function OptionsEditorScrollFrame(AOwner: TComponent): TOptionsEditorScrollFrame;

implementation

{$R *.dfm}

uses
  BCCommon.Options.Container;

var
  FOptionsEditorScrollFrame: TOptionsEditorScrollFrame;

function OptionsEditorScrollFrame(AOwner: TComponent): TOptionsEditorScrollFrame;
begin
  if not Assigned(FOptionsEditorScrollFrame) then
    FOptionsEditorScrollFrame := TOptionsEditorScrollFrame.Create(AOwner);
  Result := FOptionsEditorScrollFrame;
end;

destructor TOptionsEditorScrollFrame.Destroy;
begin
  inherited;
  FOptionsEditorScrollFrame := nil;
end;

procedure TOptionsEditorScrollFrame.PutData;
begin
  OptionsContainer.ScrollAutosizeMaxWidth := CheckBoxAutosizeMaxWidth.Checked;
  OptionsContainer.ScrollHalfPage := CheckBoxHalfPage.Checked;
  OptionsContainer.ScrollHintFollows := CheckBoxHintFollows.Checked;
  OptionsContainer.ScrollPastEndOfFile := CheckBoxPastEndOfFile.Checked;
  OptionsContainer.ScrollPastEndOfLineMarker := CheckBoxPastEndOfLineMarker.Checked;
  OptionsContainer.ScrollShowHint := CheckBoxShowHint.Checked;
end;

procedure TOptionsEditorScrollFrame.GetData;
begin
  CheckBoxAutosizeMaxWidth.Checked := OptionsContainer.ScrollAutosizeMaxWidth;
  CheckBoxHalfPage.Checked := OptionsContainer.ScrollHalfPage;
  CheckBoxHintFollows.Checked := OptionsContainer.ScrollHintFollows;
  CheckBoxPastEndOfFile.Checked := OptionsContainer.ScrollPastEndOfFile;
  CheckBoxPastEndOfLineMarker.Checked := OptionsContainer.ScrollPastEndOfLineMarker;
  CheckBoxShowHint.Checked := OptionsContainer.ScrollShowHint;
end;

end.
