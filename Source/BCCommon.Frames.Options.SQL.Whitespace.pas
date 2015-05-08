unit BCCommon.Frames.Options.SQL.Whitespace;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, BCCommon.Options.Container.SQL.Formatter,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, BCControls.CheckBox, Vcl.ExtCtrls,
  BCCommon.Frames.Options.Base, sCheckBox, BCControls.Panel, sPanel, sFrameAdapter;

type
  TOptionsSQLWhitespaceFrame = class(TBCOptionsBaseFrame)
    CheckBoxSpaceAroundOperator: TBCCheckBox;
    CheckBoxSpaceInsideCreate: TBCCheckBox;
    CheckBoxSpaceInsideExpression: TBCCheckBox;
    CheckBoxSpaceInsideFunction: TBCCheckBox;
    CheckBoxSpaceInsideSubquery: TBCCheckBox;
    CheckBoxSpaceInsideTypename: TBCCheckBox;
    Panel: TBCPanel;
  protected
    procedure GetData; override;
    procedure PutData; override;
  public
    destructor Destroy; override;
  end;

function OptionsSQLWhitespaceFrame(AOwner: TComponent): TOptionsSQLWhitespaceFrame;

implementation

{$R *.dfm}

var
  FOptionsSQLWhitespaceFrame: TOptionsSQLWhitespaceFrame;

function OptionsSQLWhitespaceFrame(AOwner: TComponent): TOptionsSQLWhitespaceFrame;
begin
  if not Assigned(FOptionsSQLWhitespaceFrame) then
    FOptionsSQLWhitespaceFrame := TOptionsSQLWhitespaceFrame.Create(AOwner);
  Result := FOptionsSQLWhitespaceFrame;
end;

destructor TOptionsSQLWhitespaceFrame.Destroy;
begin
  inherited;
  FOptionsSQLWhitespaceFrame := nil;
end;

procedure TOptionsSQLWhitespaceFrame.GetData;
begin
  CheckBoxSpaceAroundOperator.Checked := SQLFormatterOptionsContainer.WhitespaceSpaceAroundOperator;
  CheckBoxSpaceInsideCreate.Checked := SQLFormatterOptionsContainer.WhitespaceSpaceInsideCreate;
  CheckBoxSpaceInsideExpression.Checked := SQLFormatterOptionsContainer.WhitespaceSpaceInsideExpression;
  CheckBoxSpaceInsideSubquery.Checked := SQLFormatterOptionsContainer.WhitespaceSpaceInsideSubquery;
  CheckBoxSpaceInsideFunction.Checked := SQLFormatterOptionsContainer.WhitespaceSpaceInsideFunction;
  CheckBoxSpaceInsideTypename.Checked := SQLFormatterOptionsContainer.WhitespaceSpaceInsideTypename;
end;

procedure TOptionsSQLWhitespaceFrame.PutData;
begin
  SQLFormatterOptionsContainer.WhitespaceSpaceAroundOperator := CheckBoxSpaceAroundOperator.Checked;
  SQLFormatterOptionsContainer.WhitespaceSpaceInsideCreate := CheckBoxSpaceInsideCreate.Checked;
  SQLFormatterOptionsContainer.WhitespaceSpaceInsideExpression := CheckBoxSpaceInsideExpression.Checked;
  SQLFormatterOptionsContainer.WhitespaceSpaceInsideSubquery := CheckBoxSpaceInsideSubquery.Checked;
  SQLFormatterOptionsContainer.WhitespaceSpaceInsideFunction := CheckBoxSpaceInsideFunction.Checked;
  SQLFormatterOptionsContainer.WhitespaceSpaceInsideTypename := CheckBoxSpaceInsideTypename.Checked;
end;

end.
