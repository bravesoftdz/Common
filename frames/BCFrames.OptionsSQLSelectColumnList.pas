unit BCFrames.OptionsSQLSelectColumnList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, BCSQL.Formatter,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, BCControls.CheckBox, Vcl.ExtCtrls,
  BCControls.ComboBox;

type
  TOptionsSQLSelectColumnListFrame = class(TFrame)
    Panel: TPanel;
    AlignAliasCheckBox: TBCCheckBox;
    ItemInNewLineCheckBox: TBCCheckBox;
    ColumnListStyleLabel: TLabel;
    ColumnListStyleComboBox: TBCComboBox;
    ColumnListCommaComboBox: TBCComboBox;
    ColumnListCommaLabel: TLabel;
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
  with ColumnListCommaComboBox.Items do
  begin
    Add(LanguageDatamodule.GetSQLFormatter('AfterComma'));
    Add(LanguageDatamodule.GetSQLFormatter('BeforeComma'));
    Add(LanguageDatamodule.GetSQLFormatter('BeforeCommaWithSpace'));
    Add(LanguageDatamodule.GetSQLFormatter('NoLineBreakComma'));
  end;
end;

procedure TOptionsSQLSelectColumnListFrame.GetData(SQLFormatterOptionsWrapper: TSQLFormatterOptionsWrapper);
begin
  ColumnListStyleComboBox.ItemIndex := SQLFormatterOptionsWrapper.SelectColumnListStyle;
  ColumnListCommaComboBox.ItemIndex := SQLFormatterOptionsWrapper.SelectColumnListComma;
  ItemInNewLineCheckBox.Checked := SQLFormatterOptionsWrapper.SelectItemInNewLine;
  AlignAliasCheckBox.Checked := SQLFormatterOptionsWrapper.AlignAliasInSelectList;
  TreatDistinctAsVirtualColumnCheckBox.Checked := SQLFormatterOptionsWrapper.TreatDistinctAsVirtualColumn;
end;

procedure TOptionsSQLSelectColumnListFrame.PutData(var SQLFormatterOptionsWrapper: TSQLFormatterOptionsWrapper);
begin
  SQLFormatterOptionsWrapper.SelectColumnListStyle := ColumnListStyleComboBox.ItemIndex;
  SQLFormatterOptionsWrapper.SelectColumnListComma := ColumnListCommaComboBox.ItemIndex;
  SQLFormatterOptionsWrapper.SelectItemInNewLine := ItemInNewLineCheckBox.Checked;
  SQLFormatterOptionsWrapper.AlignAliasInSelectList := AlignAliasCheckBox.Checked;
  SQLFormatterOptionsWrapper.TreatDistinctAsVirtualColumn := TreatDistinctAsVirtualColumnCheckBox.Checked;
end;

end.
