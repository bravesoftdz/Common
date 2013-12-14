unit BCFrames.OptionsSQLSelectColumnList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, BCSQL.Formatter,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, BCControls.CheckBox, Vcl.ExtCtrls,
  BCControls.ComboBox, BCControls.Edit;

type
  TOptionsSQLSelectColumnListFrame = class(TFrame)
    Panel: TPanel;
    AlignAliasCheckBox: TBCCheckBox;
    ColumnInNewLineCheckBox: TBCCheckBox;
    ColumnListStyleLabel: TLabel;
    ColumnListStyleComboBox: TBCComboBox;
    LineBreakComboBox: TBCComboBox;
    LineBreakLabel: TLabel;
    TreatDistinctAsVirtualColumnCheckBox: TBCCheckBox;
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

constructor TOptionsSQLSelectColumnListFrame.Create(AOwner: TComponent);
begin
  inherited;
  with ColumnListStyleComboBox.Items do
  begin
    Add(LanguageDatamodule.GetSQLFormatter('Stacked'));
    Add(LanguageDatamodule.GetSQLFormatter('Wrapped'));
  end;
  with LineBreakComboBox.Items do
  begin
    Add(LanguageDatamodule.GetSQLFormatter('AfterComma'));
    Add(LanguageDatamodule.GetSQLFormatter('BeforeComma'));
    Add(LanguageDatamodule.GetSQLFormatter('BeforeCommaWithSpace'));
    Add(LanguageDatamodule.GetSQLFormatter('NoLineBreak'));
  end;
end;

procedure TOptionsSQLSelectColumnListFrame.GetData(SQLFormatterOptionsWrapper: TSQLFormatterOptionsWrapper);
begin
  ColumnListStyleComboBox.ItemIndex := SQLFormatterOptionsWrapper.SelectColumnListStyle;
  LineBreakComboBox.ItemIndex := SQLFormatterOptionsWrapper.SelectColumnListLineBreak;
  ColumnInNewLineCheckBox.Checked := SQLFormatterOptionsWrapper.SelectColumnListColumnInNewLine;
  AlignAliasCheckBox.Checked := SQLFormatterOptionsWrapper.SelectColumnListAlignAlias;
  TreatDistinctAsVirtualColumnCheckBox.Checked := SQLFormatterOptionsWrapper.SelectColumnListTreatDistinctAsVirtualColumn;
end;

procedure TOptionsSQLSelectColumnListFrame.PutData(var SQLFormatterOptionsWrapper: TSQLFormatterOptionsWrapper);
begin
  SQLFormatterOptionsWrapper.SelectColumnListStyle := ColumnListStyleComboBox.ItemIndex;
  SQLFormatterOptionsWrapper.SelectColumnListLineBreak := LineBreakComboBox.ItemIndex;
  SQLFormatterOptionsWrapper.SelectColumnListColumnInNewLine := ColumnInNewLineCheckBox.Checked;
  SQLFormatterOptionsWrapper.SelectColumnListAlignAlias := AlignAliasCheckBox.Checked;
  SQLFormatterOptionsWrapper.SelectColumnListTreatDistinctAsVirtualColumn := TreatDistinctAsVirtualColumnCheckBox.Checked;
end;

end.
