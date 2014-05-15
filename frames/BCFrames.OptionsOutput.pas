unit BCFrames.OptionsOutput;

interface

uses
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, BCControls.Edit,
  BCControls.CheckBox, Vcl.ExtCtrls, BCCommon.OptionsContainer, BCFrames.OptionsFrame, JvExStdCtrls, JvCheckBox;

type
  TOptionsOutputFrame = class(TOptionsFrame)
    Panel: TPanel;
    IndentLabel: TLabel;
    ShowTreeLinesCheckBox: TBCCheckBox;
    IndentEdit: TBCEdit;
    ShowCheckBoxCheckBox: TBCCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
    destructor Destroy; override;
    procedure GetData; override;
    procedure PutData; override;
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
  OptionsContainer.OutputShowTreeLines := ShowTreeLinesCheckBox.Checked;
  OptionsContainer.OutputShowCheckBox := ShowCheckBoxCheckBox.Checked;
  OptionsContainer.OutputIndent := StrToIntDef(IndentEdit.Text, 16);
end;

procedure TOptionsOutputFrame.GetData;
begin
  ShowTreeLinesCheckBox.Checked := OptionsContainer.OutputShowTreeLines;
  ShowCheckBoxCheckBox.Checked := OptionsContainer.OutputShowCheckBox;
  IndentEdit.Text := IntToStr(OptionsContainer.OutputIndent);
end;

end.
