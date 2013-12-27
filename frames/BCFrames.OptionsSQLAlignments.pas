unit BCFrames.OptionsSQLAlignments;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, BCSQL.Formatter,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, BCControls.CheckBox, Vcl.ExtCtrls,
  BCControls.ComboBox, BCFrames.OptionsFrame;

type
  TOptionsSQLAlignmentsFrame = class(TOptionsFrame)
    Panel: TPanel;
    KeywordAlignmentLeftJustifyCheckBox: TBCCheckBox;
    KeywordAlignLabel: TLabel;
    KeywordAlignComboBox: TBCComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
    destructor Destroy; override;
    procedure GetData; override;
    procedure Init; override;
    procedure PutData; override;
  end;

function OptionsSQLAlignmentsFrame(AOwner: TComponent): TOptionsSQLAlignmentsFrame;

implementation

{$R *.dfm}

uses
  BCCommon.LanguageStrings;

var
  FOptionsSQLAlignmentsFrame: TOptionsSQLAlignmentsFrame;

function OptionsSQLAlignmentsFrame(AOwner: TComponent): TOptionsSQLAlignmentsFrame;
begin
  if not Assigned(FOptionsSQLAlignmentsFrame) then
    FOptionsSQLAlignmentsFrame := TOptionsSQLAlignmentsFrame.Create(AOwner);
  Result := FOptionsSQLAlignmentsFrame;
end;

destructor TOptionsSQLAlignmentsFrame.Destroy;
begin
  inherited;
  FOptionsSQLAlignmentsFrame := nil;
end;

procedure TOptionsSQLAlignmentsFrame.Init;
begin
  with KeywordAlignComboBox.Items do
  begin
    Add(LanguageDatamodule.GetSQLFormatter('Left'));
    Add(LanguageDatamodule.GetSQLFormatter('Right'));
    Add(LanguageDatamodule.GetSQLFormatter('None'));
  end;
end;

procedure TOptionsSQLAlignmentsFrame.GetData;
begin
  KeywordAlignComboBox.ItemIndex := SQLFormatterOptionsWrapper.KeywordAlign;
  KeywordAlignmentLeftJustifyCheckBox.Checked := SQLFormatterOptionsWrapper.KeywordAlignmentLeftJustify;
end;

procedure TOptionsSQLAlignmentsFrame.PutData;
begin
  SQLFormatterOptionsWrapper.KeywordAlign := KeywordAlignComboBox.ItemIndex;
  SQLFormatterOptionsWrapper.KeywordAlignmentLeftJustify := KeywordAlignmentLeftJustifyCheckBox.Checked;
end;

end.
