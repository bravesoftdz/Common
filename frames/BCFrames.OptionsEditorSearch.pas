unit BCFrames.OptionsEditorSearch;

interface

uses
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, BCControls.CheckBox, Vcl.ExtCtrls,
  BCCommon.OptionsContainer, BCFrames.OptionsFrame;

type
  TOptionsEditorSearchFrame = class(TOptionsFrame)
    Panel: TPanel;
    ShowSearchStringNotFoundCheckBox: TBCCheckBox;
    BeepIfSearchStringNotFoundCheckBox: TBCCheckBox;
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
end;

procedure TOptionsEditorSearchFrame.GetData;
begin
  ShowSearchStringNotFoundCheckBox.Checked := OptionsContainer.ShowSearchStringNotFound;
  BeepIfSearchStringNotFoundCheckBox.Checked := OptionsContainer.BeepIfSearchStringNotFound;
end;

end.
