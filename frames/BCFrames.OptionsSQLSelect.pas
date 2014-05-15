unit BCFrames.OptionsSQLSelect;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, BCSQL.Formatter,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, BCControls.CheckBox, Vcl.ExtCtrls,
  BCControls.ComboBox, BCControls.Edit, Vcl.ComCtrls, JvExComCtrls, JvComCtrls, BCControls.PageControl,
  BCFrames.OptionsFrame, JvExStdCtrls, JvCheckBox;

type
  TOptionsSQLSelectFrame = class(TOptionsFrame)
    Panel: TPanel;
    PageControl: TBCPageControl;
    ColumnListTabSheet: TTabSheet;
    ColumnListStyleLabel: TLabel;
    ColumnListStyleComboBox: TBCComboBox;
    ColumnListLineBreakLabel: TLabel;
    ColumnListLineBreakComboBox: TBCComboBox;
    AlignAliasCheckBox: TBCCheckBox;
    ColumnInNewLineCheckBox: TBCCheckBox;
    TreatDistinctAsVirtualColumnCheckBox: TBCCheckBox;
    SubqueryTabSheet: TTabSheet;
    NewLineAfterInCheckBox: TBCCheckBox;
    NewLineAfterExistsCheckBox: TBCCheckBox;
    NewlineAfterComparisonOperatorCheckBox: TBCCheckBox;
    NewlineBeforeComparisonOperatorCheckBox: TBCCheckBox;
    IntoClauseTabSheet: TTabSheet;
    FromJoinClauseTabSheet: TTabSheet;
    AndOrKeywordTabSheet: TTabSheet;
    GroupByClauseTabSheet: TTabSheet;
    HavingClauseTabSheet: TTabSheet;
    OderByClauseTabSheet: TTabSheet;
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
    destructor Destroy; override;
    procedure GetData; override;
    procedure Init; override;
    procedure PutData; override;
  end;

function OptionsSQLSelectFrame(AOwner: TComponent): TOptionsSQLSelectFrame;

implementation

{$R *.dfm}

uses
  BCCommon.LanguageStrings;

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

procedure TOptionsSQLSelectFrame.GetData;
begin
  { Column List }
  ColumnListStyleComboBox.ItemIndex := SQLFormatterOptions.SelectColumnListStyle;
  ColumnListLineBreakComboBox.ItemIndex := SQLFormatterOptions.SelectColumnListLineBreak;
  ColumnInNewLineCheckBox.Checked := SQLFormatterOptions.SelectColumnListColumnInNewLine;
  AlignAliasCheckBox.Checked := SQLFormatterOptions.SelectColumnListAlignAlias;
  TreatDistinctAsVirtualColumnCheckBox.Checked := SQLFormatterOptions.SelectColumnListTreatDistinctAsVirtualColumn;
  { Subquery }
  NewLineAfterInCheckBox.Checked := SQLFormatterOptions.SelectSubqueryNewLineAfterIn;
  NewLineAfterExistsCheckBox.Checked := SQLFormatterOptions.SelectSubqueryNewLineAfterExists;
  NewlineAfterComparisonOperatorCheckBox.Checked := SQLFormatterOptions.SelectSubqueryNewLineAfterComparisonOperator;
  NewlineBeforeComparisonOperatorCheckBox.Checked := SQLFormatterOptions.SelectSubqueryNewLineBeforeComparisonOperator;
  { Into Clause }
  IntoClauseInNewLineCheckBox.Checked := SQLFormatterOptions.SelectIntoClauseInNewLine;
  { Select From/Join Clause }
  FromClauseStyleComboBox.ItemIndex := SQLFormatterOptions.SelectFromClauseStyle;
  FromClauseInNewLineCheckBox.Checked := SQLFormatterOptions.SelectFromClauseInNewLine;
  JoinClauseInNewLineCheckBox.Checked := SQLFormatterOptions.SelectJoinClauseInNewLine;
  AlignJoinWithFromKeywordCheckBox.Checked := SQLFormatterOptions.SelectAlignJoinWithFromKeyword;
  AlignAndOrWithOnInJoinClauseCheckBox.Checked := SQLFormatterOptions.SelectAlignAndOrWithOnInJoinClause;
  AlignAliasInFromClauseCheckBox.Checked := SQLFormatterOptions.SelectAlignAliasInFromClause;
  { And/Or Keyword }
  AndOrLineBreakComboBox.ItemIndex := SQLFormatterOptions.SelectAndOrLineBreak;
  AndOrUnderWhereCheckBox.Checked := SQLFormatterOptions.SelectAndOrUnderWhere;
  WhereClauseInNewlineCheckBox.Checked := SQLFormatterOptions.SelectWhereClauseInNewline;
  WhereClauseAlignExprCheckBox.Checked := SQLFormatterOptions.SelectWhereClauseAlignExpr;
  { Group By Clause }
  GroupByClauseStyleComboBox.ItemIndex := SQLFormatterOptions.SelectGroupByClauseStyle;
  GroupByClauseInNewLineCheckBox.Checked := SQLFormatterOptions.SelectGroupByClauseInNewLine;
  { Having Clause }
  HavingClauseInNewLineCheckBox.Checked := SQLFormatterOptions.SelectHavingClauseInNewLine;
  { Order By Clause }
  OrderByClauseStyleComboBox.ItemIndex := SQLFormatterOptions.SelectOrderByClauseStyle;
  OrderByClauseInNewLineCheckBox.Checked := SQLFormatterOptions.SelectOrderByClauseInNewLine;
end;

procedure TOptionsSQLSelectFrame.PutData;
begin
  { Column List }
  SQLFormatterOptions.SelectColumnListStyle := ColumnListStyleComboBox.ItemIndex;
  SQLFormatterOptions.SelectColumnListLineBreak := ColumnListLineBreakComboBox.ItemIndex;
  SQLFormatterOptions.SelectColumnListColumnInNewLine := ColumnInNewLineCheckBox.Checked;
  SQLFormatterOptions.SelectColumnListAlignAlias := AlignAliasCheckBox.Checked;
  SQLFormatterOptions.SelectColumnListTreatDistinctAsVirtualColumn := TreatDistinctAsVirtualColumnCheckBox.Checked;
  { Subquery }
  SQLFormatterOptions.SelectSubqueryNewLineAfterIn := NewLineAfterInCheckBox.Checked;
  SQLFormatterOptions.SelectSubqueryNewLineAfterExists := NewLineAfterExistsCheckBox.Checked;
  SQLFormatterOptions.SelectSubqueryNewLineAfterComparisonOperator := NewlineAfterComparisonOperatorCheckBox.Checked;
  SQLFormatterOptions.SelectSubqueryNewLineBeforeComparisonOperator := NewlineBeforeComparisonOperatorCheckBox.Checked;
  { Into Clause }
  SQLFormatterOptions.SelectIntoClauseInNewLine := IntoClauseInNewLineCheckBox.Checked;
  { Select From/Join Clause }
  SQLFormatterOptions.SelectFromClauseStyle := FromClauseStyleComboBox.ItemIndex;
  SQLFormatterOptions.SelectFromClauseInNewLine := FromClauseInNewLineCheckBox.Checked;
  SQLFormatterOptions.SelectJoinClauseInNewLine := JoinClauseInNewLineCheckBox.Checked;
  SQLFormatterOptions.SelectAlignJoinWithFromKeyword := AlignJoinWithFromKeywordCheckBox.Checked;
  SQLFormatterOptions.SelectAlignAndOrWithOnInJoinClause := AlignAndOrWithOnInJoinClauseCheckBox.Checked;
  SQLFormatterOptions.SelectAlignAliasInFromClause := AlignAliasInFromClauseCheckBox.Checked;
  { And/Or Keyword }
  SQLFormatterOptions.SelectAndOrLineBreak := AndOrLineBreakComboBox.ItemIndex;
  SQLFormatterOptions.SelectAndOrUnderWhere := AndOrUnderWhereCheckBox.Checked;
  SQLFormatterOptions.SelectWhereClauseInNewline := WhereClauseInNewlineCheckBox.Checked;
  SQLFormatterOptions.SelectWhereClauseAlignExpr := WhereClauseAlignExprCheckBox.Checked;
  { Group By Clause }
  SQLFormatterOptions.SelectGroupByClauseStyle := GroupByClauseStyleComboBox.ItemIndex;
  SQLFormatterOptions.SelectGroupByClauseInNewLine := GroupByClauseInNewLineCheckBox.Checked;
  { Having Clause }
  SQLFormatterOptions.SelectHavingClauseInNewLine := HavingClauseInNewLineCheckBox.Checked;
  { Order By Clause }
  SQLFormatterOptions.SelectOrderByClauseStyle := OrderByClauseStyleComboBox.ItemIndex;
  SQLFormatterOptions.SelectOrderByClauseInNewLine := OrderByClauseInNewLineCheckBox.Checked;
end;

end.
