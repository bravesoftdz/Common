unit BCCommon.Frames.Options.Output;

interface

uses
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, BCControls.Edit,
  BCControls.CheckBox, Vcl.ExtCtrls, BCCommon.Options.Container, BCCommon.Frames.Options.Base, sEdit, sCheckBox, BCControls.Panel,
  sPanel, sFrameAdapter;

type
  TOptionsOutputFrame = class(TBCOptionsBaseFrame)
    Panel: TBCPanel;
    CheckBoxShowTreeLines: TBCCheckBox;
    EditIndent: TBCEdit;
    CheckBoxShowCheckBox: TBCCheckBox;
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
  System.SysUtils;

var
  FOptionsOutputFrame: TOptionsOutputFrame;

function OptionsOutputFrame(AOwner: TComponent): TOptionsOutputFrame;
begin
  if not Assigned(FOptionsOutputFrame) then
    FOptionsOutputFrame := TOptionsOutputFrame.Create(AOwner);
  Result := FOptionsOutputFrame;
end;

destructor TOptionsOutputFrame.Destroy;
begin
  inherited;
  FOptionsOutputFrame := nil;
end;

procedure TOptionsOutputFrame.PutData;
begin
  OptionsContainer.OutputShowTreeLines := CheckBoxShowTreeLines.Checked;
  OptionsContainer.OutputShowCheckBox := CheckBoxShowCheckBox.Checked;
  OptionsContainer.OutputIndent := StrToIntDef(EditIndent.Text, 16);
end;

procedure TOptionsOutputFrame.GetData;
begin
  CheckBoxShowTreeLines.Checked := OptionsContainer.OutputShowTreeLines;
  CheckBoxShowCheckBox.Checked := OptionsContainer.OutputShowCheckBox;
  EditIndent.Text := IntToStr(OptionsContainer.OutputIndent);
end;

end.
