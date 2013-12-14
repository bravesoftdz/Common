unit BCFrames.OptionsSQLSelectSubquery;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, BCSQL.Formatter,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, BCControls.CheckBox, Vcl.ExtCtrls;

type
  TOptionsSQLSelectSubqueryFrame = class(TFrame)
    Panel: TPanel;
    NewLineAfterExistsCheckBox: TBCCheckBox;
    NewLineAfterInCheckBox: TBCCheckBox;
    NewlineAfterComparisonOperatorCheckBox: TBCCheckBox;
    NewlineBeforeComparisonOperatorCheckBox: TBCCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GetData(SQLFormatterOptionsWrapper: TSQLFormatterOptionsWrapper);
    procedure PutData(var SQLFormatterOptionsWrapper: TSQLFormatterOptionsWrapper);
  end;

implementation

{$R *.dfm}

procedure TOptionsSQLSelectSubqueryFrame.GetData(SQLFormatterOptionsWrapper: TSQLFormatterOptionsWrapper);
begin
  NewLineAfterInCheckBox.Checked := SQLFormatterOptionsWrapper.SelectSubqueryNewLineAfterIn;
  NewLineAfterExistsCheckBox.Checked := SQLFormatterOptionsWrapper.SelectSubqueryNewLineAfterExists;
  NewlineAfterComparisonOperatorCheckBox.Checked := SQLFormatterOptionsWrapper.SelectSubqueryNewLineAfterComparisonOperator;
  NewlineBeforeComparisonOperatorCheckBox.Checked := SQLFormatterOptionsWrapper.SelectSubqueryNewLineBeforeComparisonOperator;
end;

procedure TOptionsSQLSelectSubqueryFrame.PutData(var SQLFormatterOptionsWrapper: TSQLFormatterOptionsWrapper);
begin
  SQLFormatterOptionsWrapper.SelectSubqueryNewLineAfterIn := NewLineAfterInCheckBox.Checked;
  SQLFormatterOptionsWrapper.SelectSubqueryNewLineAfterExists := NewLineAfterExistsCheckBox.Checked;
  SQLFormatterOptionsWrapper.SelectSubqueryNewLineAfterComparisonOperator := NewlineAfterComparisonOperatorCheckBox.Checked;
  SQLFormatterOptionsWrapper.SelectSubqueryNewLineBeforeComparisonOperator := NewlineBeforeComparisonOperatorCheckBox.Checked;
end;

end.
