unit BCCommon.Frames.Options.Editor.MatchingPair;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sCheckBox, BCControls.CheckBox, Vcl.ExtCtrls,
  sPanel, BCControls.Panel, BCCommon.Frames.Options.Base, sFrameAdapter;

type
  TOptionsEditorMatchingPairFrame = class(TBCOptionsBaseFrame)
    CheckBoxEnabled: TBCCheckBox;
    CheckBoxHighlightAfterToken: TBCCheckBox;
    CheckBoxHighlightUnmatched: TBCCheckBox;
    Panel: TBCPanel;
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
  BCCommon.Options.Container;

var
  FOptionsEditorMatchingPairFrame: TOptionsEditorMatchingPairFrame;

function OptionsEditorMatchingPairFrame(AOwner: TComponent): TOptionsEditorMatchingPairFrame;
begin
  if not Assigned(FOptionsEditorMatchingPairFrame) then
    FOptionsEditorMatchingPairFrame := TOptionsEditorMatchingPairFrame.Create(AOwner);
  Result := FOptionsEditorMatchingPairFrame;
end;

destructor TOptionsEditorMatchingPairFrame.Destroy;
begin
  inherited;
  FOptionsEditorMatchingPairFrame := nil;
end;

procedure TOptionsEditorMatchingPairFrame.PutData;
begin
  OptionsContainer.MatchingPairEnabled := CheckBoxEnabled.Checked;
  OptionsContainer.MatchingPairHighlightAfterToken := CheckBoxHighlightAfterToken.Checked;
  OptionsContainer.MatchingPairHighlightUnmatched := CheckBoxHighlightUnmatched.Checked;
end;

procedure TOptionsEditorMatchingPairFrame.GetData;
begin
  CheckBoxEnabled.Checked := OptionsContainer.MatchingPairEnabled;
  CheckBoxHighlightAfterToken.Checked := OptionsContainer.MatchingPairHighlightAfterToken;
  CheckBoxHighlightUnmatched.Checked := OptionsContainer.MatchingPairHighlightUnmatched;
end;

end.
