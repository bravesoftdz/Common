unit BCFrames.OptionsCompare;

interface

uses
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, BCControls.CheckBox,
  BCCommon.OptionsContainer, BCFrames.OptionsFrame, JvExStdCtrls, JvCheckBox;

type
  TOptionsCompareFrame = class(TOptionsFrame)
    Panel: TPanel;
    IgnoreCaseCheckBox: TBCCheckBox;
    IgnoreBlanksCheckBox: TBCCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
    destructor Destroy; override;
    procedure GetData; override;
    procedure PutData; override;
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
  OptionsContainer.IgnoreCase := IgnoreCaseCheckBox.Checked;
  OptionsContainer.IgnoreBlanks := IgnoreBlanksCheckBox.Checked;
end;

procedure TOptionsCompareFrame.GetData;
begin
  IgnoreCaseCheckBox.Checked := OptionsContainer.IgnoreCase;
  IgnoreBlanksCheckBox.Checked := OptionsContainer.IgnoreBlanks;
end;

end.
