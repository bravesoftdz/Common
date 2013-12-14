unit BCFrames.OptionsEditorCompletionProposal;

interface

uses
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, BCControls.CheckBox, Vcl.ExtCtrls,
  BCControls.ComboBox, BCCommon.OptionsContainer;

type
  TOptionsEditorCompletionProposalFrame = class(TFrame)
    Panel: TPanel;
    EnabledCheckBox: TBCCheckBox;
    CaseSensitiveCheckBox: TBCCheckBox;
    ShortcutLabel: TLabel;
    ShortcutComboBox: TBCComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure GetData(OptionsContainer: TOptionsContainer);
    procedure PutData(OptionsContainer: TOptionsContainer);
  end;

implementation

{$R *.dfm}

uses
  Vcl.Menus, BCCommon.Lib;

constructor TOptionsEditorCompletionProposalFrame.Create(AOwner: TComponent);
var
  i: Integer;
begin
  inherited;
  for i := 1 to High(ShortCuts) do
    ShortcutComboBox.Items.Add(ShortCutToText(ShortCuts[i]));
end;

procedure TOptionsEditorCompletionProposalFrame.PutData(OptionsContainer: TOptionsContainer);
begin
  OptionsContainer.CompletionProposalEnabled := EnabledCheckBox.Checked;
  OptionsContainer.CompletionProposalCaseSensitive := CaseSensitiveCheckBox.Checked;
  OptionsContainer.CompletionProposalShortcut := ShortcutComboBox.Text;
end;

procedure TOptionsEditorCompletionProposalFrame.GetData(OptionsContainer: TOptionsContainer);
begin
  EnabledCheckBox.Checked := OptionsContainer.CompletionProposalEnabled;
  CaseSensitiveCheckBox.Checked := OptionsContainer.CompletionProposalCaseSensitive;
  ShortcutComboBox.Text := OptionsContainer.CompletionProposalShortcut;
end;

end.
