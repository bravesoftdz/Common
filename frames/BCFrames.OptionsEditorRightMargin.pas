unit BCFrames.OptionsEditorRightMargin;

interface

uses
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.ExtCtrls, Vcl.StdCtrls, BCControls.CheckBox,
  BCControls.Edit, Vcl.Buttons, JvEdit, BCCommon.OptionsContainer, BCFrames.OptionsFrame, JvExStdCtrls, JvCheckBox;

type
  TOptionsEditorRightMarginFrame = class(TOptionsFrame)
    Panel: TPanel;
    PositionLabel: TLabel;
    PositionEdit: TBCEdit;
    VisibleCheckBox: TBCCheckBox;
    MouseMoveCheckBox: TBCCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
    destructor Destroy; override;
    procedure GetData; override;
    procedure PutData; override;
  end;

function OptionsEditorRightMarginFrame(AOwner: TComponent): TOptionsEditorRightMarginFrame;

implementation

{$R *.dfm}

uses
  System.SysUtils;

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
  OptionsContainer.MarginVisibleRightMargin := VisibleCheckBox.Checked;
  OptionsContainer.MarginRightMargin := StrToIntDef(PositionEdit.Text, 80);
  OptionsContainer.MarginLeftMarginMouseMove := MouseMoveCheckBox.Checked;
end;

procedure TOptionsEditorRightMarginFrame.GetData;
begin
  VisibleCheckBox.Checked := OptionsContainer.MarginVisibleRightMargin;
  PositionEdit.Text := IntToStr(OptionsContainer.MarginRightMargin);
  MouseMoveCheckBox.Checked := OptionsContainer.MarginLeftMarginMouseMove;
end;

end.
