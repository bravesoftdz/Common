unit BCCommon.Frames.Options.Editor.CompletionProposal;

interface

uses
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, BCControls.CheckBox, Vcl.ExtCtrls,
  BCControls.ComboBox, BCCommon.Options.Container, BCCommon.Frames.Options.Base, sComboBox, BCControls.Panel,
  sCheckBox, sPanel, sFrameAdapter;

type
  TOptionsEditorCompletionProposalFrame = class(TBCOptionsBaseFrame)
    CheckBoxCaseSensitive: TBCCheckBox;
    CheckBoxEnabled: TBCCheckBox;
    ComboBoxShortcut: TBCComboBox;
    Panel: TBCPanel;
  protected
    procedure Init; override;
    procedure GetData; override;
    procedure PutData; override;
  public
    destructor Destroy; override;
  end;

function OptionsEditorCompletionProposalFrame(AOwner: TComponent): TOptionsEditorCompletionProposalFrame;

implementation

{$R *.dfm}

uses
  Vcl.Menus, BCCommon.Consts;

var
  FOptionsEditorCompletionProposalFrame: TOptionsEditorCompletionProposalFrame;

function OptionsEditorCompletionProposalFrame(AOwner: TComponent): TOptionsEditorCompletionProposalFrame;
begin
  if not Assigned(FOptionsEditorCompletionProposalFrame) then
    FOptionsEditorCompletionProposalFrame := TOptionsEditorCompletionProposalFrame.Create(AOwner);
  Result := FOptionsEditorCompletionProposalFrame;
end;

destructor TOptionsEditorCompletionProposalFrame.Destroy;
begin
  inherited;
  FOptionsEditorCompletionProposalFrame := nil;
end;

procedure TOptionsEditorCompletionProposalFrame.Init;
var
  i: Integer;
begin
  for i := 1 to High(ShortCuts) do
    ComboBoxShortcut.Items.Add(ShortCutToText(ShortCuts[i]));
end;

procedure TOptionsEditorCompletionProposalFrame.PutData;
begin
  OptionsContainer.CompletionProposalEnabled := CheckBoxEnabled.Checked;
  OptionsContainer.CompletionProposalCaseSensitive := CheckBoxCaseSensitive.Checked;
  OptionsContainer.CompletionProposalShortcut := ComboBoxShortcut.Text;
end;

procedure TOptionsEditorCompletionProposalFrame.GetData;
begin
  CheckBoxEnabled.Checked := OptionsContainer.CompletionProposalEnabled;
  CheckBoxCaseSensitive.Checked := OptionsContainer.CompletionProposalCaseSensitive;
  ComboBoxShortcut.ItemIndex := ComboBoxShortcut.Items.IndexOf(OptionsContainer.CompletionProposalShortcut);
end;

end.
