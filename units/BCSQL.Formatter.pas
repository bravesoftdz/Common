unit BCSQL.Formatter;

interface

uses
  System.Classes, GSQLParser, LZBaseType;

type
  TSQLFormatter = class
  private
    FSQLParser: TGSQLParser;
  public
    constructor Create(SQL: TStrings; Vendor: TDBVendor = DBVOracle); overload;
    destructor Destroy; override;
    function GetFormattedSQL: string;
  end;

  TSQLFormatterOptionsWrapper = class
  private
    { Select Column List }
    function GetSelectColumnlistStyle: Integer;
    procedure SetSelectColumnlistStyle(Value: Integer);
    function GetSelectColumnListLineBreak: Integer;
    procedure SetSelectColumnListLineBreak(Value: Integer);
    function GetSelectColumnListColumnInNewLine: Boolean;
    procedure SetSelectColumnListColumnInNewLine(Value: Boolean);
    function GetSelectColumnListAlignAlias: Boolean;
    procedure SetSelectColumnListAlignAlias(Value: Boolean);
    function GetSelectColumnListTreatDistinctAsVirtualColumn: Boolean;
    procedure SetSelectColumnListTreatDistinctAsVirtualColumn(Value: Boolean);
    { Select Subquery }
    function GetSelectSubqueryNewLineAfterIn: Boolean;
    procedure SetSelectSubqueryNewLineAfterIn(Value: Boolean);
    function GetSelectSubqueryNewLineAfterExists: Boolean;
    procedure SetSelectSubqueryNewLineAfterExists(Value: Boolean);
    function GetSelectSubqueryNewLineAfterComparisonOperator: Boolean;
    procedure SetSelectSubqueryNewLineAfterComparisonOperator(Value: Boolean);
    function GetSelectSubqueryNewLineBeforeComparisonOperator: Boolean;
    procedure SetSelectSubqueryNewLineBeforeComparisonOperator(Value: Boolean);
    { Select Into Clause }
    function GetSelectIntoClauseInNewLine: Boolean;
    procedure SetSelectIntoClauseInNewLine(Value: Boolean);
    { Select From/Join Clause }
    function GetSelectFromClauseStyle: Integer;
    procedure SetSelectFromClauseStyle(Value: Integer);
    function GetSelectFromClauseInNewLine: Boolean;
    procedure SetSelectFromClauseInNewLine(Value: Boolean);
    function GetSelectJoinClauseInNewLine: Boolean;
    procedure SetSelectJoinClauseInNewLine(Value: Boolean);
    function GetSelectAlignJoinWithFromKeyword: Boolean;
    procedure SetSelectAlignJoinWithFromKeyword(Value: Boolean);
    function GetSelectAlignAndOrWithOnInJoinClause: Boolean;
    procedure SetSelectAlignAndOrWithOnInJoinClause(Value: Boolean);
    function GetSelectAlignAliasInFromClause: Boolean;
    procedure SetSelectAlignAliasInFromClause(Value: Boolean);
    { Select And/Or Clause }
    function GetSelectAndOrLineBreak: Integer;
    procedure SetSelectAndOrLineBreak(Value: Integer);
    function GetSelectAndOrUnderWhere: Boolean;
    procedure SetSelectAndOrUnderWhere(Value: Boolean);
    function GetSelectWhereClauseInNewline: Boolean;
    procedure SetSelectWhereClauseInNewline(Value: Boolean);
    function GetSelectWhereClauseAlignExpr: Boolean;
    procedure SetSelectWhereClauseAlignExpr(Value: Boolean);
    { Select Group By Clause }
    function GetSelectGroupByClauseStyle: Integer;
    procedure SetSelectGroupByClauseStyle(Value: Integer);
    function GetSelectGroupByClauseInNewLine: Boolean;
    procedure SetSelectGroupByClauseInNewLine(Value: Boolean);
    { Select Having Clause }
    function GetSelectHavingClauseInNewLine: Boolean;
    procedure SetSelectHavingClauseInNewLine(Value: Boolean);
    { Select Order By Clause }
    function GetSelectOrderByClauseStyle: Integer;
    procedure SetSelectOrderByClauseStyle(Value: Integer);
    function GetSelectOrderByClauseInNewLine: Boolean;
    procedure SetSelectOrderByClauseInNewLine(Value: Boolean);
    { Alignments }
    function GetKeywordAlign: Integer;
    procedure SetKeywordAlign(Value: Integer);
    function GetKeywordAlignmentLeftJustify: Boolean;
    procedure SetKeywordAlignmentLeftJustify(Value: Boolean);
  public
    { Select Column List }
    property SelectColumnListStyle: Integer read GetSelectColumnListStyle write SetSelectColumnListStyle;
    property SelectColumnListLineBreak: Integer read GetSelectColumnListLineBreak write SetSelectColumnListLineBreak;
    property SelectColumnListColumnInNewLine: Boolean read GetSelectColumnListColumnInNewLine write SetSelectColumnListColumnInNewLine;
    property SelectColumnListAlignAlias: Boolean read GetSelectColumnListAlignAlias write SetSelectColumnListAlignAlias;
    property SelectColumnListTreatDistinctAsVirtualColumn: Boolean read GetSelectColumnListTreatDistinctAsVirtualColumn write SetSelectColumnListTreatDistinctAsVirtualColumn;
    { Select Subquery }
    property SelectSubqueryNewLineAfterIn: Boolean read GetSelectSubqueryNewLineAfterIn write SetSelectSubqueryNewLineAfterIn;
    property SelectSubqueryNewLineAfterExists: Boolean read GetSelectSubqueryNewLineAfterExists write SetSelectSubqueryNewLineAfterExists;
    property SelectSubqueryNewLineAfterComparisonOperator: Boolean read GetSelectSubqueryNewLineAfterComparisonOperator write SetSelectSubqueryNewLineAfterComparisonOperator;
    property SelectSubqueryNewLineBeforeComparisonOperator: Boolean read GetSelectSubqueryNewLineBeforeComparisonOperator write SetSelectSubqueryNewLineBeforeComparisonOperator;
    { Select Into Clause }
    property SelectIntoClauseInNewLine: Boolean read GetSelectIntoClauseInNewLine write SetSelectIntoClauseInNewLine;
    { Select From/Join Clause }
    property SelectFromClauseStyle: Integer read GetSelectFromClauseStyle write SetSelectFromClauseStyle;
    property SelectFromClauseInNewLine: Boolean read GetSelectFromClauseInNewLine write SetSelectFromClauseInNewLine;
    property SelectJoinClauseInNewLine: Boolean read GetSelectJoinClauseInNewLine write SetSelectJoinClauseInNewLine;
    property SelectAlignJoinWithFromKeyword: Boolean read GetSelectAlignJoinWithFromKeyword write SetSelectAlignJoinWithFromKeyword;
    property SelectAlignAndOrWithOnInJoinClause: Boolean read GetSelectAlignAndOrWithOnInJoinClause write SetSelectAlignAndOrWithOnInJoinClause;
    property SelectAlignAliasInFromClause: Boolean read GetSelectAlignAliasInFromClause write SetSelectAlignAliasInFromClause;
    { Select And/Or Clause }
    property SelectAndOrLineBreak: Integer read GetSelectAndOrLineBreak write SetSelectAndOrLineBreak;
    property SelectAndOrUnderWhere: Boolean read GetSelectAndOrUnderWhere write SetSelectAndOrUnderWhere;
    property SelectWhereClauseInNewline: Boolean read GetSelectWhereClauseInNewline write SetSelectWhereClauseInNewline;
    property SelectWhereClauseAlignExpr: Boolean read GetSelectWhereClauseAlignExpr write SetSelectWhereClauseAlignExpr;
    { Select Group By Clause }
    property SelectGroupByClauseStyle: Integer read GetSelectGroupByClauseStyle write SetSelectGroupByClauseStyle;
    property SelectGroupByClauseInNewLine: Boolean read GetSelectGroupByClauseInNewLine write SetSelectGroupByClauseInNewLine;
    { Select Having Clause }
    property SelectHavingClauseInNewLine: Boolean read GetSelectHavingClauseInNewLine write SetSelectHavingClauseInNewLine;
    { Select Order By Clause }
    property SelectOrderByClauseStyle: Integer read GetSelectOrderByClauseStyle write SetSelectOrderByClauseStyle;
    property SelectOrderByClauseInNewLine: Boolean read GetSelectOrderByClauseInNewLine write SetSelectOrderByClauseInNewLine;
    { Alignments }
    property KeywordAlign: Integer read GetKeywordAlign write SetKeywordAlign;
    property KeywordAlignmentLeftJustify: Boolean read GetKeywordAlignmentLeftJustify write SetKeywordAlignmentLeftJustify;
  end;

implementation

uses
  BCCommon.Messages;

{ TSQLFormatterOptionsWrapper }

{ Select Column List }

function TSQLFormatterOptionsWrapper.GetSelectColumnListStyle: Integer;
begin
  case gFmtOpt.Select_ColumnList_Style of
    asStacked: Result := 0;
  else
    Result := 1 { asWrapped }
  end;
end;

procedure TSQLFormatterOptionsWrapper.SetSelectColumnListStyle(Value: Integer);
begin
  case Value of
    0: gFmtOpt.Select_ColumnList_Style := asStacked;
    1: gFmtOpt.Select_ColumnList_Style := asWrapped;
  end;
end;

function TSQLFormatterOptionsWrapper.GetSelectColumnListLineBreak: Integer;
begin
  case gFmtOpt.Select_ColumnList_Comma of
    lfAfterComma: Result := 0;
    lfBeforeComma: Result := 1;
    lfBeforeCommaWithSpace: Result := 2;
  else
    Result := 3 { lfNoLineBreakComma }
  end;
end;

procedure TSQLFormatterOptionsWrapper.SetSelectColumnListLineBreak(Value: Integer);
begin
  case Value of
    0: gFmtOpt.Select_ColumnList_Comma := lfAfterComma;
    1: gFmtOpt.Select_ColumnList_Comma := lfBeforeComma;
    2: gFmtOpt.Select_ColumnList_Comma := lfBeforeCommaWithSpace;
    3: gFmtOpt.Select_ColumnList_Comma := lfNoLineBreakComma;
  end;
end;

function TSQLFormatterOptionsWrapper.GetSelectColumnListColumnInNewLine: Boolean;
begin
  Result := gFmtOpt.SelectItemInNewLine;
end;

procedure TSQLFormatterOptionsWrapper.SetSelectColumnListColumnInNewLine(Value: Boolean);
begin
  gFmtOpt.SelectItemInNewLine := Value;
end;

function TSQLFormatterOptionsWrapper.GetSelectColumnListAlignAlias: Boolean;
begin
  Result := gFmtOpt.AlignAliasInSelectList;
end;

procedure TSQLFormatterOptionsWrapper.SetSelectColumnListAlignAlias(Value: Boolean);
begin
  gFmtOpt.AlignAliasInSelectList := Value;
end;

function TSQLFormatterOptionsWrapper.GetSelectColumnListTreatDistinctAsVirtualColumn: Boolean;
begin
  Result := gFmtOpt.TreatDistinctAsVirtualColumn;
end;

procedure TSQLFormatterOptionsWrapper.SetSelectColumnListTreatDistinctAsVirtualColumn(Value: Boolean);
begin
  gFmtOpt.TreatDistinctAsVirtualColumn := Value;
end;

{ SubQuery }

function TSQLFormatterOptionsWrapper.GetSelectSubqueryNewLineAfterIn: Boolean;
begin
  Result := gFmtOpt.Subquery_NewLine_After_IN;
end;

procedure TSQLFormatterOptionsWrapper.SetSelectSubqueryNewLineAfterIn(Value: Boolean);
begin
  gFmtOpt.Subquery_NewLine_After_IN := Value;
end;

function TSQLFormatterOptionsWrapper.GetSelectSubqueryNewLineAfterExists: Boolean;
begin
  Result := gFmtOpt.Subquery_NewLine_After_EXISTS;
end;

procedure TSQLFormatterOptionsWrapper.SetSelectSubqueryNewLineAfterExists(Value: Boolean);
begin
  gFmtOpt.Subquery_NewLine_After_EXISTS := Value;
end;

function TSQLFormatterOptionsWrapper.GetSelectSubqueryNewLineAfterComparisonOperator: Boolean;
begin
  Result := gFmtOpt.Subquery_NewLine_After_ComparisonOperator;
end;

procedure TSQLFormatterOptionsWrapper.SetSelectSubqueryNewLineAfterComparisonOperator(Value: Boolean);
begin
  gFmtOpt.Subquery_NewLine_After_ComparisonOperator := Value;
end;

function TSQLFormatterOptionsWrapper.GetSelectSubqueryNewLineBeforeComparisonOperator: Boolean;
begin
  Result := gFmtOpt.Subquery_NewLine_Before_ComparisonOperator;
end;

procedure TSQLFormatterOptionsWrapper.SetSelectSubqueryNewLineBeforeComparisonOperator(Value: Boolean);
begin
  gFmtOpt.Subquery_NewLine_Before_ComparisonOperator := Value;
end;

{ Into Clause }

function TSQLFormatterOptionsWrapper.GetSelectIntoClauseInNewLine: Boolean;
begin
  Result := gFmtOpt.IntoClauseInNewline;
end;

procedure TSQLFormatterOptionsWrapper.SetSelectIntoClauseInNewLine(Value: Boolean);
begin
  gFmtOpt.IntoClauseInNewline := Value;
end;

{ Select From/Join Clause }

function TSQLFormatterOptionsWrapper.GetSelectFromClauseStyle: Integer;
begin
  Result := Ord(gFmtOpt.Select_fromclause_Style);
end;

procedure TSQLFormatterOptionsWrapper.SetSelectFromClauseStyle(Value: Integer);
begin
  gFmtOpt.Select_fromclause_Style := TAlignStyle(Value);
end;

function TSQLFormatterOptionsWrapper.GetSelectFromClauseInNewLine: Boolean;
begin
  Result := gFmtOpt.Select_FromclauseInNewLine;
end;

procedure TSQLFormatterOptionsWrapper.SetSelectFromClauseInNewLine(Value: Boolean);
begin
  gFmtOpt.Select_FromclauseInNewLine := Value;
end;

function TSQLFormatterOptionsWrapper.GetSelectJoinClauseInNewLine: Boolean;
begin
  Result := gFmtOpt.Select_FromclauseJoinOnInNewline;
end;

procedure TSQLFormatterOptionsWrapper.SetSelectJoinClauseInNewLine(Value: Boolean);
begin
  gFmtOpt.Select_FromclauseJoinOnInNewline := Value;
end;

function TSQLFormatterOptionsWrapper.GetSelectAlignJoinWithFromKeyword: Boolean;
begin
  Result := gFmtOpt.AlignJoinWithFromKeyword;
end;

procedure TSQLFormatterOptionsWrapper.SetSelectAlignJoinWithFromKeyword(Value: Boolean);
begin
  gFmtOpt.AlignJoinWithFromKeyword := Value;
end;

function TSQLFormatterOptionsWrapper.GetSelectAlignAndOrWithOnInJoinClause: Boolean;
begin
  Result := gFmtOpt.AlignAndOrWithOnInJoinClause;
end;

procedure TSQLFormatterOptionsWrapper.SetSelectAlignAndOrWithOnInJoinClause(Value: Boolean);
begin
  gFmtOpt.AlignAndOrWithOnInJoinClause := Value;
end;

function TSQLFormatterOptionsWrapper.GetSelectAlignAliasInFromClause: Boolean;
begin
  Result := gFmtOpt.AlignAliasInFromClause;
end;

procedure TSQLFormatterOptionsWrapper.SetSelectAlignAliasInFromClause(Value: Boolean);
begin
  gFmtOpt.AlignAliasInFromClause := Value;
end;

{ Select And/Or Clause }

function TSQLFormatterOptionsWrapper.GetSelectAndOrLineBreak: Integer;
begin
  Result := Ord(gFmtOpt.LinefeedsAndOr_option);
end;

procedure TSQLFormatterOptionsWrapper.SetSelectAndOrLineBreak(Value: Integer);
begin
  gFmtOpt.LinefeedsAndOr_option := TLineFeedsAndOrOption(Value);
end;

function TSQLFormatterOptionsWrapper.GetSelectAndOrUnderWhere: Boolean;
begin
  Result := gFmtOpt.AndOrUnderWhere;
end;

procedure TSQLFormatterOptionsWrapper.SetSelectAndOrUnderWhere(Value: Boolean);
begin
  gFmtOpt.AndOrUnderWhere := Value;
end;

function TSQLFormatterOptionsWrapper.GetSelectWhereClauseInNewline: Boolean;
begin
  Result := gFmtOpt.WhereClauseInNewline;
end;

procedure TSQLFormatterOptionsWrapper.SetSelectWhereClauseInNewline(Value: Boolean);
begin
  gFmtOpt.WhereClauseInNewline := Value;
end;

function TSQLFormatterOptionsWrapper.GetSelectWhereClauseAlignExpr: Boolean;
begin
  Result := gFmtOpt.WhereClauseAlignExpr;
end;

procedure TSQLFormatterOptionsWrapper.SetSelectWhereClauseAlignExpr(Value: Boolean);
begin
  gFmtOpt.WhereClauseAlignExpr := Value;
end;

{ Select Group By Clause }

function TSQLFormatterOptionsWrapper.GetSelectGroupByClauseStyle: Integer;
begin
  Result := Ord(gFmtOpt.Select_Groupby_Style);
end;

procedure TSQLFormatterOptionsWrapper.SetSelectGroupByClauseStyle(Value: Integer);
begin
  gFmtOpt.Select_Groupby_Style := TAlignStyle(Value);
end;

function TSQLFormatterOptionsWrapper.GetSelectGroupByClauseInNewLine: Boolean;
begin
  Result := gFmtOpt.GroupByClauseInNewline;
end;

procedure TSQLFormatterOptionsWrapper.SetSelectGroupByClauseInNewLine(Value: Boolean);
begin
  gFmtOpt.GroupByClauseInNewline := Value;
end;

{ Having Clause }

function TSQLFormatterOptionsWrapper.GetSelectHavingClauseInNewLine: Boolean;
begin
  Result := gFmtOpt.HavingClauseInNewline;
end;

procedure TSQLFormatterOptionsWrapper.SetSelectHavingClauseInNewLine(Value: Boolean);
begin
  gFmtOpt.HavingClauseInNewline := Value;
end;

{ Select Order By Clause }

function TSQLFormatterOptionsWrapper.GetSelectOrderByClauseStyle: Integer;
begin
  Result := Ord(gFmtOpt.Select_Orderby_Style);
end;

procedure TSQLFormatterOptionsWrapper.SetSelectOrderByClauseStyle(Value: Integer);
begin
  gFmtOpt.Select_Orderby_Style := TAlignStyle(Value);
end;

function TSQLFormatterOptionsWrapper.GetSelectOrderByClauseInNewLine: Boolean;
begin
  Result := gFmtOpt.OrderByClauseInNewline;
end;

procedure TSQLFormatterOptionsWrapper.SetSelectOrderByClauseInNewLine(Value: Boolean);
begin
  gFmtOpt.OrderByClauseInNewline := Value;
end;

{ Alignments }

function TSQLFormatterOptionsWrapper.GetKeywordAlign: Integer;
begin
  Result := Ord(gFmtOpt.Select_keywords_alignOption);
end;

procedure TSQLFormatterOptionsWrapper.SetKeywordAlign(Value: Integer);
begin
  gFmtOpt.Select_keywords_alignOption := TAlignOption(Value);
end;

function TSQLFormatterOptionsWrapper.GetKeywordAlignmentLeftJustify: Boolean;
begin
  Result := gfmtopt.TrueLeft;
end;

procedure TSQLFormatterOptionsWrapper.SetKeywordAlignmentLeftJustify(Value: Boolean);
begin
  gfmtopt.TrueLeft := Value;
end;

{ TSQLFormatter }

constructor TSQLFormatter.Create(SQL: TStrings; Vendor: TDBVendor);
begin
  FSQLParser := TGSQLParser.Create(Vendor);
  FSQLParser.SQLText.Assign(SQL);
end;

function TSQLFormatter.GetFormattedSQL: string;
var
  Rslt: Integer;
begin
  Rslt := FSQLParser.PrettyPrint;
  if Rslt > 0 then
  begin
    ShowErrorMessage('Invalid SQL');
    Result := FSQLParser.SqlText.Text
  end
  else
    Result := FSQLParser.FormattedSQLText.Text;
end;

destructor TSQLFormatter.Destroy;
begin
  FSQLParser.Free;
  inherited;
end;

end.
