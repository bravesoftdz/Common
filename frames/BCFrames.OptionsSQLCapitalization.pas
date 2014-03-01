unit BCFrames.OptionsSQLCapitalization;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, BCSQL.Formatter,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCFrames.OptionsFrame, Vcl.StdCtrls, BCControls.ComboBox,
  Vcl.ExtCtrls;

type
  TOptionsSQLCapitalizationFrame = class(TOptionsFrame)
    Panel: TPanel;
    KeywordsLabel: TLabel;
    KeywordsComboBox: TBCComboBox;
    IdentifierComboBox: TBCComboBox;
    IdentifierLabel: TLabel;
    QuotedIdentifierComboBox: TBCComboBox;
    QuotedIdentifierLabel: TLabel;
    TableNameComboBox: TBCComboBox;
    TableNameLabel: TLabel;
    ColumnNameComboBox: TBCComboBox;
    ColumnNameLabel: TLabel;
    AliasNameComboBox: TBCComboBox;
    AliasNameLabel: TLabel;
    VariableNameComboBox: TBCComboBox;
    VariableNameLabel: TLabel;
    FunctionNameLabel: TLabel;
    FunctionNameComboBox: TBCComboBox;
    DataTypeLabel: TLabel;
    DataTypeComboBox: TBCComboBox;
  public
    { Public declarations }
    destructor Destroy; override;
    procedure GetData; override;
    procedure Init; override;
    procedure PutData; override;
  end;

function OptionsSQLCapitalizationFrame(AOwner: TComponent): TOptionsSQLCapitalizationFrame;

implementation

{$R *.dfm}

uses
  BCCommon.LanguageStrings;

var
  FOptionsSQLCapitalizationFrame: TOptionsSQLCapitalizationFrame;

function OptionsSQLCapitalizationFrame(AOwner: TComponent): TOptionsSQLCapitalizationFrame;
begin
  if not Assigned(FOptionsSQLCapitalizationFrame) then
    FOptionsSQLCapitalizationFrame := TOptionsSQLCapitalizationFrame.Create(AOwner);
  Result := FOptionsSQLCapitalizationFrame;
end;

destructor TOptionsSQLCapitalizationFrame.Destroy;
begin
  inherited;
  FOptionsSQLCapitalizationFrame := nil;
end;

procedure TOptionsSQLCapitalizationFrame.Init;

  procedure AddCaseItems(ComboBox: TBCComboBox);
  begin
    with ComboBox.Items do
    begin
      Add(LanguageDatamodule.GetSQLFormatter('Uppercase'));
      Add(LanguageDatamodule.GetSQLFormatter('Lowercase'));
      Add(LanguageDatamodule.GetSQLFormatter('SentenceCase'));
      Add(LanguageDatamodule.GetSQLFormatter('NoChange'));
    end;
  end;

begin
  AddCaseItems(KeywordsComboBox);
  AddCaseItems(IdentifierComboBox);
  AddCaseItems(QuotedIdentifierComboBox);
  AddCaseItems(TableNameComboBox);
  AddCaseItems(ColumnNameComboBox);
  AddCaseItems(AliasNameComboBox);
  AddCaseItems(VariableNameComboBox);
  AddCaseItems(FunctionNameComboBox);
  AddCaseItems(DataTypeComboBox);
end;

procedure TOptionsSQLCapitalizationFrame.GetData;
begin
  KeywordsComboBox.ItemIndex := SQLFormatterOptions.CapitalizationKeywords;
  IdentifierComboBox.ItemIndex := SQLFormatterOptions.CapitalizationIdentifier;
  QuotedIdentifierComboBox.ItemIndex := SQLFormatterOptions.CapitalizationQuotedIdentifier;
  TableNameComboBox.ItemIndex := SQLFormatterOptions.CapitalizationTableName;
  ColumnNameComboBox.ItemIndex := SQLFormatterOptions.CapitalizationColumnName;
  AliasNameComboBox.ItemIndex := SQLFormatterOptions.CapitalizationAliasName;
  VariableNameComboBox.ItemIndex := SQLFormatterOptions.CapitalizationVariableName;
  FunctionNameComboBox.ItemIndex := SQLFormatterOptions.CapitalizationFuncname;
  DataTypeComboBox.ItemIndex := SQLFormatterOptions.CapitalizationDatatype;
end;

procedure TOptionsSQLCapitalizationFrame.PutData;
begin
  SQLFormatterOptions.CapitalizationKeywords := KeywordsComboBox.ItemIndex;
  SQLFormatterOptions.CapitalizationIdentifier := IdentifierComboBox.ItemIndex;
  SQLFormatterOptions.CapitalizationQuotedIdentifier := QuotedIdentifierComboBox.ItemIndex;
  SQLFormatterOptions.CapitalizationTableName := TableNameComboBox.ItemIndex;
  SQLFormatterOptions.CapitalizationColumnName := ColumnNameComboBox.ItemIndex;
  SQLFormatterOptions.CapitalizationAliasName := AliasNameComboBox.ItemIndex;
  SQLFormatterOptions.CapitalizationVariableName := VariableNameComboBox.ItemIndex;
  SQLFormatterOptions.CapitalizationFuncname := FunctionNameComboBox.ItemIndex;
  SQLFormatterOptions.CapitalizationDatatype := DataTypeComboBox.ItemIndex;
end;

end.
