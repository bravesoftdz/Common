unit BCCommon.Frames.Options.Output;

interface

uses
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, BCControls.Edit,
  Vcl.ExtCtrls, BCCommon.Options.Container, BCCommon.Frames.Options.Base, sEdit, BCControls.Panel,
  sPanel, sFrameAdapter, acSlider, sLabel;

type
  TOptionsOutputFrame = class(TBCOptionsBaseFrame)
    Panel: TBCPanel;
    EditIndent: TBCEdit;
    StickyLabelShowTreeLines: TsStickyLabel;
    SliderShowCheckBox: TsSlider;
    StickyLabelShowCheckBox: TsStickyLabel;
    SliderShowTreeLines: TsSlider;
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
  OptionsContainer.OutputShowTreeLines := SliderShowTreeLines.SliderOn;
  OptionsContainer.OutputShowCheckBox:= SliderShowCheckBox.SliderOn;
  OptionsContainer.OutputIndent := StrToIntDef(EditIndent.Text, 16);
end;

procedure TOptionsOutputFrame.GetData;
begin
  SliderShowTreeLines.SliderOn := OptionsContainer.OutputShowTreeLines;
  SliderShowCheckBox.SliderOn := OptionsContainer.OutputShowCheckBox;
  EditIndent.Text := IntToStr(OptionsContainer.OutputIndent);
end;

end.
