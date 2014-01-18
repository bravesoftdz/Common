unit BCFrames.OptionsSQLWhitespace;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, BCSQL.Formatter,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, BCControls.CheckBox, Vcl.ExtCtrls,
  BCFrames.OptionsFrame;

type
  TOptionsSQLWhitespaceFrame = class(TOptionsFrame)
    Panel: TPanel;
    SpaceAroundOperatorCheckBox: TBCCheckBox;
    SpaceInsideCreateCheckBox: TBCCheckBox;
    SpaceInsideExpressionCheckBox: TBCCheckBox;
    SpaceInsideSubqueryCheckBox: TBCCheckBox;
    SpaceInsideFunctionCheckBox: TBCCheckBox;
    SpaceInsideTypenameCheckBox: TBCCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
    destructor Destroy; override;
    procedure GetData; override;
    procedure PutData; override;
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
  SpaceAroundOperatorCheckBox.Checked := SQLFormatterOptions.WhitespaceSpaceAroundOperator;
  SpaceInsideCreateCheckBox.Checked := SQLFormatterOptions.WhitespaceSpaceInsideCreate;
  SpaceInsideExpressionCheckBox.Checked := SQLFormatterOptions.WhitespaceSpaceInsideExpression;
  SpaceInsideSubqueryCheckBox.Checked := SQLFormatterOptions.WhitespaceSpaceInsideSubquery;
  SpaceInsideFunctionCheckBox.Checked := SQLFormatterOptions.WhitespaceSpaceInsideFunction;
  SpaceInsideTypenameCheckBox.Checked := SQLFormatterOptions.WhitespaceSpaceInsideTypename;
end;

procedure TOptionsSQLWhitespaceFrame.PutData;
begin
  SQLFormatterOptions.WhitespaceSpaceAroundOperator := SpaceAroundOperatorCheckBox.Checked;
  SQLFormatterOptions.WhitespaceSpaceInsideCreate := SpaceInsideCreateCheckBox.Checked;
  SQLFormatterOptions.WhitespaceSpaceInsideExpression := SpaceInsideExpressionCheckBox.Checked;
  SQLFormatterOptions.WhitespaceSpaceInsideSubquery := SpaceInsideSubqueryCheckBox.Checked;
  SQLFormatterOptions.WhitespaceSpaceInsideFunction := SpaceInsideFunctionCheckBox.Checked;
  SQLFormatterOptions.WhitespaceSpaceInsideTypename := SpaceInsideTypenameCheckBox.Checked;
end;

end.
