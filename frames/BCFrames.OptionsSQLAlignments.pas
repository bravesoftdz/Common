unit BCFrames.OptionsSQLAlignments;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, BCSQL.Formatter,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, BCControls.CheckBox, Vcl.ExtCtrls,
  BCControls.ComboBox;

type
  TOptionsSQLAlignmentsFrame = class(TFrame)
    Panel: TPanel;
    KeywordAlignmentLeftJustifyCheckBox: TBCCheckBox;
    KeywordAlignLabel: TLabel;
    KeywordAlignComboBox: TBCComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure GetData(SQLFormatterOptionsWrapper: TSQLFormatterOptionsWrapper);
    procedure PutData(var SQLFormatterOptionsWrapper: TSQLFormatterOptionsWrapper);
  end;

implementation

{$R *.dfm}

uses
  BCCommon.LanguageStrings;

constructor TOptionsSQLAlignmentsFrame.Create(AOwner: TComponent);
begin
  inherited;
  with KeywordAlignComboBox.Items do
  begin
    Add(LanguageDatamodule.GetSQLFormatter('Left'));
    Add(LanguageDatamodule.GetSQLFormatter('Right'));
    Add(LanguageDatamodule.GetSQLFormatter('None'));
  end;
end;

procedure TOptionsSQLAlignmentsFrame.GetData(SQLFormatterOptionsWrapper: TSQLFormatterOptionsWrapper);
begin
  KeywordAlignComboBox.ItemIndex := SQLFormatterOptionsWrapper.KeywordAlign;
  KeywordAlignmentLeftJustifyCheckBox.Checked := SQLFormatterOptionsWrapper.KeywordAlignmentLeftJustify;
end;

procedure TOptionsSQLAlignmentsFrame.PutData(var SQLFormatterOptionsWrapper: TSQLFormatterOptionsWrapper);
begin
  SQLFormatterOptionsWrapper.KeywordAlign := KeywordAlignComboBox.ItemIndex;
  SQLFormatterOptionsWrapper.KeywordAlignmentLeftJustify := KeywordAlignmentLeftJustifyCheckBox.Checked;
end;

end.
