unit BCCommon.Frames.Options.Editor.RightMargin;

interface

uses
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.ExtCtrls, Vcl.StdCtrls, BCControls.CheckBox,
  BCControls.Edit, Vcl.Buttons, BCCommon.Frames.Options.Base,
  sCheckBox, sEdit, BCControls.Panel, sPanel, sFrameAdapter, acSlider, sLabel;

type
  TOptionsEditorRightMarginFrame = class(TBCOptionsBaseFrame)
    CheckBoxMouseMove: TBCCheckBox;
    CheckBoxShowMovingHint: TBCCheckBox;
    EditPosition: TBCEdit;
    Panel: TBCPanel;
    StickyLabelVisible: TsStickyLabel;
    SliderVisible: TsSlider;
  protected
    procedure GetData; override;
    procedure PutData; override;
  public
    destructor Destroy; override;
  end;

function OptionsEditorRightMarginFrame(AOwner: TComponent): TOptionsEditorRightMarginFrame;

implementation

{$R *.dfm}

uses
  System.SysUtils, BCCommon.Options.Container;

var
  FOptionsEditorRightMarginFrame: TOptionsEditorRightMarginFrame;

function OptionsEditorRightMarginFrame(AOwner: TComponent): TOptionsEditorRightMarginFrame;
begin
  if not Assigned(FOptionsEditorRightMarginFrame) then
    FOptionsEditorRightMarginFrame := TOptionsEditorRightMarginFrame.Create(AOwner);
  Result := FOptionsEditorRightMarginFrame;
end;

destructor TOptionsEditorRightMarginFrame.Destroy;
begin
  inherited;
  FOptionsEditorRightMarginFrame := nil;
end;

procedure TOptionsEditorRightMarginFrame.PutData;
begin
  OptionsContainer.RightMarginVisible := SliderVisible.SliderOn;
  OptionsContainer.RightMarginMouseMove := CheckBoxMouseMove.Checked;
  OptionsContainer.RightMarginShowMovingHint := CheckBoxShowMovingHint.Checked;
  OptionsContainer.RightMarginPosition := StrToIntDef(EditPosition.Text, 80);
end;

procedure TOptionsEditorRightMarginFrame.GetData;
begin
  SliderVisible.SliderOn := OptionsContainer.RightMarginVisible;
  CheckBoxMouseMove.Checked := OptionsContainer.RightMarginMouseMove;
  CheckBoxShowMovingHint.Checked := OptionsContainer.RightMarginShowMovingHint;
  EditPosition.Text := IntToStr(OptionsContainer.RightMarginPosition);
end;

end.
