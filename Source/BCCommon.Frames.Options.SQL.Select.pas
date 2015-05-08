unit BCCommon.Frames.Options.SQL.Select;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, BCCommon.Options.Container.SQL.Formatter,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, BCControls.CheckBox, Vcl.ExtCtrls,
  BCControls.ComboBox, Vcl.ComCtrls, BCControls.PageControl, BCControls.Panel,
  BCCommon.Frames.Options.Base, sCheckBox, sComboBox, sPageControl, sPanel, sFrameAdapter;

type
  TOptionsSQLSelectFrame = class(TBCOptionsBaseFrame)
    CheckBoxAlignAlias: TBCCheckBox;
    CheckBoxAlignAliasInFromClause: TBCCheckBox;
    CheckBoxAlignAndOrWithOnInJoinClause: TBCCheckBox;
    CheckBoxAlignJoinWithFromKeyword: TBCCheckBox;
    CheckBoxAndOrUnderWhere: TBCCheckBox;
    CheckBoxColumnInNewLine: TBCCheckBox;
    CheckBoxFromClauseInNewLine: TBCCheckBox;
    CheckBoxGroupByClauseInNewLine: TBCCheckBox;
    CheckBoxHavingClauseInNewLine: TBCCheckBox;
    CheckBoxIntoClauseInNewLine: TBCCheckBox;
    CheckBoxJoinClauseInNewLine: TBCCheckBox;
    CheckBoxNewlineAfterComparisonOperator: TBCCheckBox;
    CheckBoxNewLineAfterExists: TBCCheckBox;
    CheckBoxNewLineAfterIn: TBCCheckBox;
    CheckBoxNewlineBeforeComparisonOperator: TBCCheckBox;
    CheckBoxOrderByClauseInNewLine: TBCCheckBox;
    CheckBoxTreatDistinctAsVirtualColumn: TBCCheckBox;
    CheckBoxWhereClauseAlignExpr: TBCCheckBox;
    CheckBoxWhereClauseInNewline: TBCCheckBox;
    ComboBoxAndOrLineBreak: TBCComboBox;
    ComboBoxColumnListLineBreak: TBCComboBox;
    ComboBoxColumnListStyle: TBCComboBox;
    ComboBoxFromClauseStyle: TBCComboBox;
    ComboBoxGroupByClauseStyle: TBCComboBox;
    ComboBoxOrderByClauseStyle: TBCComboBox;
    PageControl: TBCPageControl;
    Panel: TBCPanel;
    TabSheetAndOrKeyword: TsTabSheet;
    TabSheetColumnList: TsTabSheet;
    TabSheetFromJoinClause: TsTabSheet;
    TabSheetGroupByClause: TsTabSheet;
    TabSheetHavingClause: TsTabSheet;
    TabSheetIntoClause: TsTabSheet;
    TabSheetOrderByClause: TsTabSheet;
    TabSheetSubquery: TsTabSheet;
  protected
    procedure GetData; override;
    procedure Init; override;
    procedure PutData; override;
  public
    destructor Destroy; override;
  end;

function OptionsSQLSelectFrame(AOwner: TComponent): TOptionsSQLSelectFrame;

implementation

{$R *.dfm}

uses
  BCCommon.Language.Strings;

var
  FOptionsSQLSelectFrame: TOptionsSQLSelectFrame;

function OptionsSQLSelectFrame(AOwner: TComponent): TOptionsSQLSelectFrame;
begin
  if not Assigned(FOptionsSQLSelectFrame) then
    FOptionsSQLSelectFrame := TOptionsSQLSelectFrame.Create(AOwner);
  Result := FOptionsSQLSelectFrame;
end;

destructor TOptionsSQLSelectFrame.Destroy;
begin
  inherited;
  FOptionsSQLSelectFrame := nil;
end;

procedure TOptionsSQLSelectFrame.Init;
begin
  with ComboBoxColumnListStyle.Items do
  begin
    Add(LanguageDatamodule.GetSQLFormatter('Stacked'));
    Add(LanguageDatamodule.GetSQLFormatter('Wrapped'));
  end;
  with ComboBoxColumnListLineBreak.Items do
  begin
    Add(LanguageDatamodule.GetSQLFormatter('AfterComma'));
    Add(LanguageDatamodule.GetSQLFormatter('BeforeComma'));
    Add(LanguageDatamodule.GetSQLFormatter('BeforeCommaWithSpace'));
    Add(LanguageDatamodule.GetSQLFormatter('NoLineBreak'));
  end;
  with ComboBoxFromClauseStyle.Items do
  begin
    Add(LanguageDatamodule.GetSQLFormatter('Stacked'));
    Add(LanguageDatamodule.GetSQLFormatter('Wrapped'));
  end;
  with ComboBoxAndOrLineBreak.Items do
  begin
    Add(LanguageDatamodule.GetSQLFormatter('BeforeAndor'));
    Add(LanguageDatamodule.GetSQLFormatter('AfterAndOr'));
    Add(LanguageDatamodule.GetSQLFormatter('NoLineBreak'));
  end;
  with ComboBoxGroupByClauseStyle.Items do
  begin
    Add(LanguageDatamodule.GetSQLFormatter('Stacked'));
    Add(LanguageDatamodule.GetSQLFormatter('Wrapped'));
  end;
  with ComboBoxOrderByClauseStyle.Items do
  begin
    Add(LanguageDatamodule.GetSQLFormatter('Stacked'));
    Add(LanguageDatamodule.GetSQLFormatter('Wrapped'));
  end;
  { Set default page }
  PageControl.TabIndex := 0;
end;

procedure TOptionsSQLSelectFrame.GetData;
begin
  { Column List }
  ComboBoxColumnListStyle.ItemIndex := SQLFormatterOptionsContainer.SelectColumnListStyle;
  ComboBoxColumnListLineBreak.ItemIndex := SQLFormatterOptionsContainer.SelectColumnListLineBreak;
  CheckBoxColumnInNewLine.Checked := SQLFormatterOptionsContainer.SelectColumnListColumnInNewLine;
  CheckBoxAlignAlias.Checked := SQLFormatterOptionsContainer.SelectColumnListAlignAlias;
  CheckBoxTreatDistinctAsVirtualColumn.Checked := SQLFormatterOptionsContainer.SelectColumnListTreatDistinctAsVirtualColumn;
  { Subquery }
  CheckBoxNewLineAfterIn.Checked := SQLFormatterOptionsContainer.SelectSubqueryNewLineAfterIn;
  CheckBoxNewLineAfterExists.Checked := SQLFormatterOptionsContainer.SelectSubqueryNewLineAfterExists;
  CheckBoxNewlineAfterComparisonOperator.Checked := SQLFormatterOptionsContainer.SelectSubqueryNewLineAfterComparisonOperator;
  CheckBoxNewlineBeforeComparisonOperator.Checked := SQLFormatterOptionsContainer.SelectSubqueryNewLineBeforeComparisonOperator;
  { Into Clause }
  CheckBoxIntoClauseInNewLine.Checked := SQLFormatterOptionsContainer.SelectIntoClauseInNewLine;
  { Select From/Join Clause }
  ComboBoxFromClauseStyle.ItemIndex := SQLFormatterOptionsContainer.SelectFromClauseStyle;
  CheckBoxFromClauseInNewLine.Checked := SQLFormatterOptionsContainer.SelectFromClauseInNewLine;
  CheckBoxJoinClauseInNewLine.Checked := SQLFormatterOptionsContainer.SelectJoinClauseInNewLine;
  CheckBoxAlignJoinWithFromKeyword.Checked := SQLFormatterOptionsContainer.SelectAlignJoinWithFromKeyword;
  CheckBoxAlignAndOrWithOnInJoinClause.Checked := SQLFormatterOptionsContainer.SelectAlignAndOrWithOnInJoinClause;
  CheckBoxAlignAliasInFromClause.Checked := SQLFormatterOptionsContainer.SelectAlignAliasInFromClause;
  { And/Or Keyword }
  ComboBoxAndOrLineBreak.ItemIndex := SQLFormatterOptionsContainer.SelectAndOrLineBreak;
  CheckBoxAndOrUnderWhere.Checked := SQLFormatterOptionsContainer.SelectAndOrUnderWhere;
  CheckBoxWhereClauseInNewline.Checked := SQLFormatterOptionsContainer.SelectWhereClauseInNewline;
  CheckBoxWhereClauseAlignExpr.Checked := SQLFormatterOptionsContainer.SelectWhereClauseAlignExpr;
  { Group By Clause }
  ComboBoxGroupByClauseStyle.ItemIndex := SQLFormatterOptionsContainer.SelectGroupByClauseStyle;
  CheckBoxGroupByClauseInNewLine.Checked := SQLFormatterOptionsContainer.SelectGroupByClauseInNewLine;
  { Having Clause }
  CheckBoxHavingClauseInNewLine.Checked := SQLFormatterOptionsContainer.SelectHavingClauseInNewLine;
  { Order By Clause }
  ComboBoxOrderByClauseStyle.ItemIndex := SQLFormatterOptionsContainer.SelectOrderByClauseStyle;
  CheckBoxOrderByClauseInNewLine.Checked := SQLFormatterOptionsContainer.SelectOrderByClauseInNewLine;
end;

procedure TOptionsSQLSelectFrame.PutData;
begin
  { Column List }
  SQLFormatterOptionsContainer.SelectColumnListStyle := ComboBoxColumnListStyle.ItemIndex;
  SQLFormatterOptionsContainer.SelectColumnListLineBreak := ComboBoxColumnListLineBreak.ItemIndex;
  SQLFormatterOptionsContainer.SelectColumnListColumnInNewLine := CheckBoxColumnInNewLine.Checked;
  SQLFormatterOptionsContainer.SelectColumnListAlignAlias := CheckBoxAlignAlias.Checked;
  SQLFormatterOptionsContainer.SelectColumnListTreatDistinctAsVirtualColumn := CheckBoxTreatDistinctAsVirtualColumn.Checked;
  { Subquery }
  SQLFormatterOptionsContainer.SelectSubqueryNewLineAfterIn := CheckBoxNewLineAfterIn.Checked;
  SQLFormatterOptionsContainer.SelectSubqueryNewLineAfterExists := CheckBoxNewLineAfterExists.Checked;
  SQLFormatterOptionsContainer.SelectSubqueryNewLineAfterComparisonOperator := CheckBoxNewlineAfterComparisonOperator.Checked;
  SQLFormatterOptionsContainer.SelectSubqueryNewLineBeforeComparisonOperator := CheckBoxNewlineBeforeComparisonOperator.Checked;
  { Into Clause }
  SQLFormatterOptionsContainer.SelectIntoClauseInNewLine := CheckBoxIntoClauseInNewLine.Checked;
  { Select From/Join Clause }
  SQLFormatterOptionsContainer.SelectFromClauseStyle := ComboBoxFromClauseStyle.ItemIndex;
  SQLFormatterOptionsContainer.SelectFromClauseInNewLine := CheckBoxFromClauseInNewLine.Checked;
  SQLFormatterOptionsContainer.SelectJoinClauseInNewLine := CheckBoxJoinClauseInNewLine.Checked;
  SQLFormatterOptionsContainer.SelectAlignJoinWithFromKeyword := CheckBoxAlignJoinWithFromKeyword.Checked;
  SQLFormatterOptionsContainer.SelectAlignAndOrWithOnInJoinClause := CheckBoxAlignAndOrWithOnInJoinClause.Checked;
  SQLFormatterOptionsContainer.SelectAlignAliasInFromClause := CheckBoxAlignAliasInFromClause.Checked;
  { And/Or Keyword }
  SQLFormatterOptionsContainer.SelectAndOrLineBreak := ComboBoxAndOrLineBreak.ItemIndex;
  SQLFormatterOptionsContainer.SelectAndOrUnderWhere := CheckBoxAndOrUnderWhere.Checked;
  SQLFormatterOptionsContainer.SelectWhereClauseInNewline := CheckBoxWhereClauseInNewline.Checked;
  SQLFormatterOptionsContainer.SelectWhereClauseAlignExpr := CheckBoxWhereClauseAlignExpr.Checked;
  { Group By Clause }
  SQLFormatterOptionsContainer.SelectGroupByClauseStyle := ComboBoxGroupByClauseStyle.ItemIndex;
  SQLFormatterOptionsContainer.SelectGroupByClauseInNewLine := CheckBoxGroupByClauseInNewLine.Checked;
  { Having Clause }
  SQLFormatterOptionsContainer.SelectHavingClauseInNewLine := CheckBoxHavingClauseInNewLine.Checked;
  { Order By Clause }
  SQLFormatterOptionsContainer.SelectOrderByClauseStyle := ComboBoxOrderByClauseStyle.ItemIndex;
  SQLFormatterOptionsContainer.SelectOrderByClauseInNewLine := CheckBoxOrderByClauseInNewLine.Checked;
end;

end.
