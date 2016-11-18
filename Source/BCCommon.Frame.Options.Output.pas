unit BCCommon.Frame.Options.Output;

interface

uses
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, BCControl.Edit,
  BCCommon.Options.Container, BCCommon.Frame.Options.Base, BCControl.Panel,
  acSlider, sLabel, sEdit, Vcl.ExtCtrls, sPanel, sFrameAdapter;

type
  TOptionsOutputFrame = class(TBCOptionsBaseFrame)
    Panel: TBCPanel;
    EditIndent: TBCEdit;
    StickyLabelShowTreeLines: TsStickyLabel;
    SliderShowCheckBox: TsSlider;
    StickyLabelShowCheckBox: TsStickyLabel;
    SliderShowTreeLines: TsSlider;
    StickyLabelUseExplorerTheme: TsStickyLabel;
    SliderUseExplorerTheme: TsSlider;
  protected
    procedure GetData; override;
    procedure PutData; override;
  public
    destructor Destroy; override;
  end;

function OptionsOutputFrame(AOwner: TComponent): TOptionsOutputFrame;

implementation

{$R *.dfm}

uses
  System.SysUtils, BCCommon.Utils;

var
  FOptionsOutputFrame: TOptionsOutputFrame;

function OptionsOutputFrame(AOwner: TComponent): TOptionsOutputFrame;
begin
  if not Assigned(FOptionsOutputFrame) then
    FOptionsOutputFrame := TOptionsOutputFrame.Create(AOwner);
  Result := FOptionsOutputFrame;
  AlignSliders(Result.Panel);
end;

destructor TOptionsOutputFrame.Destroy;
begin
  inherited;
  FOptionsOutputFrame := nil;
end;

procedure TOptionsOutputFrame.PutData;
begin
  with OptionsContainer do
  begin
    OutputShowTreeLines := SliderShowTreeLines.SliderOn;
    OutputShowCheckBox := SliderShowCheckBox.SliderOn;
    OutputUseExplorerTheme := SliderUseExplorerTheme.SliderOn;
    OutputIndent := StrToIntDef(EditIndent.Text, 20);
  end;
end;

procedure TOptionsOutputFrame.GetData;
begin
  with OptionsContainer do
  begin
    SliderShowTreeLines.SliderOn := OutputShowTreeLines;
    SliderShowCheckBox.SliderOn := OutputShowCheckBox;
    SliderUseExplorerTheme.SliderOn := OutputUseExplorerTheme;
    EditIndent.Text := IntToStr(OutputIndent);
  end;
end;

end.
