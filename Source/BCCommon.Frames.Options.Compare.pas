unit BCCommon.Frames.Options.Compare;

interface

uses
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, BCControls.CheckBox,
  BCCommon.Options.Container, BCCommon.Frames.Options.Base, sCheckBox, BCControls.Panel, sPanel, sFrameAdapter;

type
  TOptionsCompareFrame = class(TBCOptionsBaseFrame)
    Panel: TBCPanel;
    IgnoreCaseCheckBox: TBCCheckBox;
    IgnoreBlanksCheckBox: TBCCheckBox;
  protected
    procedure GetData; override;
    procedure PutData; override;
  public
    destructor Destroy; override;
  end;

function OptionsCompareFrame(AOwner: TComponent): TOptionsCompareFrame;

implementation

{$R *.dfm}

var
  FOptionsCompareFrame: TOptionsCompareFrame;

function OptionsCompareFrame(AOwner: TComponent): TOptionsCompareFrame;
begin
  if not Assigned(FOptionsCompareFrame) then
    FOptionsCompareFrame := TOptionsCompareFrame.Create(AOwner);
  Result := FOptionsCompareFrame;
end;

destructor TOptionsCompareFrame.Destroy;
begin
  inherited;
  FOptionsCompareFrame := nil;
end;

procedure TOptionsCompareFrame.PutData;
begin
  OptionsContainer.CompareIgnoreCase := IgnoreCaseCheckBox.Checked;
  OptionsContainer.CompareIgnoreBlanks := IgnoreBlanksCheckBox.Checked;
end;

procedure TOptionsCompareFrame.GetData;
begin
  IgnoreCaseCheckBox.Checked := OptionsContainer.CompareIgnoreCase;
  IgnoreBlanksCheckBox.Checked := OptionsContainer.CompareIgnoreBlanks;
end;

end.
