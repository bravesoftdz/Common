unit BCFrames.OptionsEditorSearch;

interface

uses
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, BCControls.CheckBox, Vcl.ExtCtrls,
  BCCommon.OptionsContainer, BCFrames.OptionsFrame, JvExStdCtrls, JvCheckBox;

type
  TOptionsEditorSearchFrame = class(TOptionsFrame)
    Panel: TPanel;
    ShowSearchStringNotFoundCheckBox: TBCCheckBox;
    BeepIfSearchStringNotFoundCheckBox: TBCCheckBox;
    DocumentSpecificSearchCheckBox: TBCCheckBox;
    ShowSearchMapCheckBox: TBCCheckBox;
    ShowSearchHighlighterCheckBox: TBCCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
    destructor Destroy; override;
    procedure GetData; override;
    procedure PutData; override;
  end;

function OptionsEditorSearchFrame(AOwner: TComponent): TOptionsEditorSearchFrame;

implementation

{$R *.dfm}

var
  FOptionsEditorSearchFrame: TOptionsEditorSearchFrame;

function OptionsEditorSearchFrame(AOwner: TComponent): TOptionsEditorSearchFrame;
begin
  if not Assigned(FOptionsEditorSearchFrame) then
    FOptionsEditorSearchFrame := TOptionsEditorSearchFrame.Create(AOwner);
  Result := FOptionsEditorSearchFrame;
end;

destructor TOptionsEditorSearchFrame.Destroy;
begin
  inherited;
  FOptionsEditorSearchFrame := nil;
end;

procedure TOptionsEditorSearchFrame.PutData;
begin
  OptionsContainer.ShowSearchStringNotFound := ShowSearchStringNotFoundCheckBox.Checked;
  OptionsContainer.BeepIfSearchStringNotFound := BeepIfSearchStringNotFoundCheckBox.Checked;
  OptionsContainer.DocumentSpecificSearch := DocumentSpecificSearchCheckBox.Checked;
  OptionsContainer.ShowSearchMap := ShowSearchMapCheckBox.Checked;
  OptionsContainer.ShowSearchHighlighter := ShowSearchHighlighterCheckBox.Checked;
end;

procedure TOptionsEditorSearchFrame.GetData;
begin
  ShowSearchStringNotFoundCheckBox.Checked := OptionsContainer.ShowSearchStringNotFound;
  BeepIfSearchStringNotFoundCheckBox.Checked := OptionsContainer.BeepIfSearchStringNotFound;
  DocumentSpecificSearchCheckBox.Checked := OptionsContainer.DocumentSpecificSearch;
  ShowSearchMapCheckBox.Checked := OptionsContainer.ShowSearchMap;
  ShowSearchHighlighterCheckBox.Checked := OptionsContainer.ShowSearchHighlighter;
end;

end.
