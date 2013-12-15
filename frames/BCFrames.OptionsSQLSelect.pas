unit BCFrames.OptionsSQLSelect;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, BCSQL.Formatter,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, BCControls.CheckBox, Vcl.ExtCtrls,
  BCControls.ComboBox, BCControls.Edit, Vcl.ComCtrls, JvExComCtrls, JvComCtrls, BCControls.PageControl;

type
  TOptionsSQLSelectFrame = class(TFrame)
    Panel: TPanel;
    PageControl: TBCPageControl;
    TabSheet1: TTabSheet;
    ColumnListStyleLabel: TLabel;
    ColumnListStyleComboBox: TBCComboBox;
    ColumnListLineBreakLabel: TLabel;
    ColumnListLineBreakComboBox: TBCComboBox;
    AlignAliasCheckBox: TBCCheckBox;
    ColumnInNewLineCheckBox: TBCCheckBox;
    TreatDistinctAsVirtualColumnCheckBox: TBCCheckBox;
    TabSheet2: TTabSheet;
    NewLineAfterInCheckBox: TBCCheckBox;
    NewLineAfterExistsCheckBox: TBCCheckBox;
    NewlineAfterComparisonOperatorCheckBox: TBCCheckBox;
    NewlineBeforeComparisonOperatorCheckBox: TBCCheckBox;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    IntoClauseInNewLineCheckBox: TBCCheckBox;
    FromClauseStyleLabel: TLabel;
    FromClauseStyleComboBox: TBCComboBox;
    FromClauseInNewLineCheckBox: TBCCheckBox;
    JoinClauseInNewLineCheckBox: TBCCheckBox;
    AlignJoinWithFromKeywordCheckBox: TBCCheckBox;
    AlignAndOrWithOnInJoinClauseCheckBox: TBCCheckBox;
    AlignAliasInFromClauseCheckBox: TBCCheckBox;
    AndOrLineBreakLabel: TLabel;
    AndOrLineBreakComboBox: TBCComboBox;
    AndOrUnderWhereCheckBox: TBCCheckBox;
    WhereClauseInNewlineCheckBox: TBCCheckBox;
    WhereClauseAlignExprCheckBox: TBCCheckBox;
    GroupByClauseStyleLabel: TLabel;
    GroupByClauseStyleComboBox: TBCComboBox;
    GroupByClauseInNewLineCheckBox: TBCCheckBox;
    HavingClauseInNewLineCheckBox: TBCCheckBox;
    OrderByClauseStyleLabel: TLabel;
    OrderByClauseStyleComboBox: TBCComboBox;
    OrderByClauseInNewLineCheckBox: TBCCheckBox;
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

constructor TOptionsSQLSelectFrame.Create(AOwner: TComponent);
begin
  inherited;
  with ColumnListStyleComboBox.Items do
  begin
    Add(LanguageDatamodule.GetSQLFormatter('Stacked'));
    Add(LanguageDatamodule.GetSQLFormatter('Wrapped'));
  end;
  with ColumnListLineBreakComboBox.Items do
  begin
    Add(LanguageDatamodule.GetSQLFormatter('AfterComma'));
    Add(LanguageDatamodule.GetSQLFormatter('BeforeComma'));
    Add(LanguageDatamodule.GetSQLFormatter('BeforeCommaWithSpace'));
    Add(LanguageDatamodule.GetSQLFormatter('NoLineBreak'));
  end;
  with FromClauseStyleComboBox.Items do
  begin
    Add(LanguageDatamodule.GetSQLFormatter('Stacked'));
    Add(LanguageDatamodule.GetSQLFormatter('Wrapped'));
  end;
  with AndOrLineBreakComboBox.Items do
  begin
    Add(LanguageDatamodule.GetSQLFormatter('BeforeAndor'));
    Add(LanguageDatamodule.GetSQLFormatter('AfterAndOr'));
    Add(LanguageDatamodule.GetSQLFormatter('NoLineBreak'));
  end;
  with GroupByClauseStyleComboBox.Items do
  begin
    Add(LanguageDatamodule.GetSQLFormatter('Stacked'));
    Add(LanguageDatamodule.GetSQLFormatter('Wrapped'));
  end;
  with OrderByClauseStyleComboBox.Items do
  begin
    Add(LanguageDatamodule.GetSQLFormatter('Stacked'));
    Add(LanguageDatamodule.GetSQLFormatter('Wrapped'));
  end;
  { Set default page }
  PageControl.TabIndex := 0;
end;

procedure TOptionsSQLSelectFrame.GetData(SQLFormatterOptionsWrapper: TSQLFormatterOptionsWrapper);
begin
  { Column List }
  ColumnListStyleComboBox.ItemIndex := SQLFormatterOptionsWrapper.SelectColumnListStyle;
  ColumnListLineBreakComboBox.ItemIndex := SQLFormatterOptionsWrapper.SelectColumnListLineBreak;
  ColumnInNewLineCheckBox.Checked := SQLFormatterOptionsWrapper.SelectColumnListColumnInNewLine;
  AlignAliasCheckBox.Checked := SQLFormatterOptionsWrapper.SelectColumnListAlignAlias;
  TreatDistinctAsVirtualColumnCheckBox.Checked := SQLFormatterOptionsWrapper.SelectColumnListTreatDistinctAsVirtualColumn;
  { Subquery }
  NewLineAfterInCheckBox.Checked := SQLFormatterOptionsWrapper.SelectSubqueryNewLineAfterIn;
  NewLineAfterExistsCheckBox.Checked := SQLFormatterOptionsWrapper.SelectSubqueryNewLineAfterExists;
  NewlineAfterComparisonOperatorCheckBox.Checked := SQLFormatterOptionsWrapper.SelectSubqueryNewLineAfterComparisonOperator;
  NewlineBeforeComparisonOperatorCheckBox.Checked := SQLFormatterOptionsWrapper.SelectSubqueryNewLineBeforeComparisonOperator;
  { Into Clause }
  IntoClauseInNewLineCheckBox.Checked := SQLFormatterOptionsWrapper.SelectIntoClauseInNewLine;
  { Select From/Join Clause }
  FromClauseStyleComboBox.ItemIndex := SQLFormatterOptionsWrapper.SelectFromClauseStyle;
  FromClauseInNewLineCheckBox.Checked := SQLFormatterOptionsWrapper.SelectFromClauseInNewLine;
  JoinClauseInNewLineCheckBox.Checked := SQLFormatterOptionsWrapper.SelectJoinClauseInNewLine;
  AlignJoinWithFromKeywordCheckBox.Checked := SQLFormatterOptionsWrapper.SelectAlignJoinWithFromKeyword;
  AlignAndOrWithOnInJoinClauseCheckBox.Checked := SQLFormatterOptionsWrapper.SelectAlignAndOrWithOnInJoinClause;
  AlignAliasInFromClauseCheckBox.Checked := SQLFormatterOptionsWrapper.SelectAlignAliasInFromClause;
  { And/Or Keyword }
  AndOrLineBreakComboBox.ItemIndex := SQLFormatterOptionsWrapper.SelectAndOrLineBreak;
  AndOrUnderWhereCheckBox.Checked := SQLFormatterOptionsWrapper.SelectAndOrUnderWhere;
  WhereClauseInNewlineCheckBox.Checked := SQLFormatterOptionsWrapper.SelectWhereClauseInNewline;
  WhereClauseAlignExprCheckBox.Checked := SQLFormatterOptionsWrapper.SelectWhereClauseAlignExpr;
  { Group By Clause }
  GroupByClauseStyleComboBox.ItemIndex := SQLFormatterOptionsWrapper.SelectGroupByClauseStyle;
  GroupByClauseInNewLineCheckBox.Checked := SQLFormatterOptionsWrapper.SelectGroupByClauseInNewLine;
  { Having Clause }
  HavingClauseInNewLineCheckBox.Checked := SQLFormatterOptionsWrapper.SelectHavingClauseInNewLine;
  { Order By Clause }
  OrderByClauseStyleComboBox.ItemIndex := SQLFormatterOptionsWrapper.SelectOrderByClauseStyle;
  OrderByClauseInNewLineCheckBox.Checked := SQLFormatterOptionsWrapper.SelectOrderByClauseInNewLine;
end;

procedure TOptionsSQLSelectFrame.PutData(var SQLFormatterOptionsWrapper: TSQLFormatterOptionsWrapper);
begin
  { Column List }
  SQLFormatterOptionsWrapper.SelectColumnListStyle := ColumnListStyleComboBox.ItemIndex;
  SQLFormatterOptionsWrapper.SelectColumnListLineBreak := ColumnListLineBreakComboBox.ItemIndex;
  SQLFormatterOptionsWrapper.SelectColumnListColumnInNewLine := ColumnInNewLineCheckBox.Checked;
  SQLFormatterOptionsWrapper.SelectColumnListAlignAlias := AlignAliasCheckBox.Checked;
  SQLFormatterOptionsWrapper.SelectColumnListTreatDistinctAsVirtualColumn := TreatDistinctAsVirtualColumnCheckBox.Checked;
  { Subquery }
  SQLFormatterOptionsWrapper.SelectSubqueryNewLineAfterIn := NewLineAfterInCheckBox.Checked;
  SQLFormatterOptionsWrapper.SelectSubqueryNewLineAfterExists := NewLineAfterExistsCheckBox.Checked;
  SQLFormatterOptionsWrapper.SelectSubqueryNewLineAfterComparisonOperator := NewlineAfterComparisonOperatorCheckBox.Checked;
  SQLFormatterOptionsWrapper.SelectSubqueryNewLineBeforeComparisonOperator := NewlineBeforeComparisonOperatorCheckBox.Checked;
  { Into Clause }
  SQLFormatterOptionsWrapper.SelectIntoClauseInNewLine := IntoClauseInNewLineCheckBox.Checked;
  { Select From/Join Clause }
  SQLFormatterOptionsWrapper.SelectFromClauseStyle := FromClauseStyleComboBox.ItemIndex;
  SQLFormatterOptionsWrapper.SelectFromClauseInNewLine := FromClauseInNewLineCheckBox.Checked;
  SQLFormatterOptionsWrapper.SelectJoinClauseInNewLine := JoinClauseInNewLineCheckBox.Checked;
  SQLFormatterOptionsWrapper.SelectAlignJoinWithFromKeyword := AlignJoinWithFromKeywordCheckBox.Checked;
  SQLFormatterOptionsWrapper.SelectAlignAndOrWithOnInJoinClause := AlignAndOrWithOnInJoinClauseCheckBox.Checked;
  SQLFormatterOptionsWrapper.SelectAlignAliasInFromClause := AlignAliasInFromClauseCheckBox.Checked;
  { And/Or Keyword }
  SQLFormatterOptionsWrapper.SelectAndOrLineBreak := AndOrLineBreakComboBox.ItemIndex;
  SQLFormatterOptionsWrapper.SelectAndOrUnderWhere := AndOrUnderWhereCheckBox.Checked;
  SQLFormatterOptionsWrapper.SelectWhereClauseInNewline := WhereClauseInNewlineCheckBox.Checked;
  SQLFormatterOptionsWrapper.SelectWhereClauseAlignExpr := WhereClauseAlignExprCheckBox.Checked;
  { Group By Clause }
  SQLFormatterOptionsWrapper.SelectGroupByClauseStyle := GroupByClauseStyleComboBox.ItemIndex;
  SQLFormatterOptionsWrapper.SelectGroupByClauseInNewLine := GroupByClauseInNewLineCheckBox.Checked;
  { Having Clause }
  SQLFormatterOptionsWrapper.SelectHavingClauseInNewLine := HavingClauseInNewLineCheckBox.Checked;
  { Order By Clause }
  SQLFormatterOptionsWrapper.SelectOrderByClauseStyle := OrderByClauseStyleComboBox.ItemIndex;
  SQLFormatterOptionsWrapper.SelectOrderByClauseInNewLine := OrderByClauseInNewLineCheckBox.Checked;
end;

end.
