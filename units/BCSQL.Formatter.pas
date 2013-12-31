unit BCSQL.Formatter;

interface

uses
  System.Classes, GSQLParser, LZBaseType, IniPersist;

type
  TSQLFormatter = class
  private
    FSQLParser: TGSQLParser;
  public
    constructor Create(SQL: TStrings; Vendor: TDBVendor = DBVOracle); overload;
    destructor Destroy; override;
    function GetFormattedSQL: string;
  end;

  TSQLFormatterOptionsWrapper = class(TPersistent)
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
    { Insert }
    function GetInsertColumnlistStyle: Integer;
    procedure SetInsertColumnlistStyle(Value: Integer);
    function GetInsertValuelistStyle: Integer;
    procedure SetInsertValuelistStyle(Value: Integer);
    function GetInsertParenthesisInSeparateLine: Boolean;
    procedure SetInsertParenthesisInSeparateLine(Value: Boolean);
    function GetInsertColumnsPerLine: Integer;
    procedure SetInsertColumnsPerLine(Value: Integer);
    { Update }
    function GetUpdateColumnlistStyle: Integer;
    procedure SetUpdateColumnlistStyle(Value: Integer);
    { Alignments }
    function GetKeywordAlign: Integer;
    procedure SetKeywordAlign(Value: Integer);
    function GetKeywordAlignmentLeftJustify: Boolean;
    procedure SetKeywordAlignmentLeftJustify(Value: Boolean);
  public
    destructor Destroy; override;
    procedure ReadIniFile;
    procedure WriteIniFile;
    { Select Column List }
    [IniValue('SQLFormatter','SelectColumnListStyle', '0')]
    property SelectColumnListStyle: Integer read GetSelectColumnListStyle write SetSelectColumnListStyle;
    [IniValue('SQLFormatter','SelectColumnListLineBreak', '0')]
    property SelectColumnListLineBreak: Integer read GetSelectColumnListLineBreak write SetSelectColumnListLineBreak;
    [IniValue('SQLFormatter','SelectColumnListColumnInNewLine', 'False')]
    property SelectColumnListColumnInNewLine: Boolean read GetSelectColumnListColumnInNewLine write SetSelectColumnListColumnInNewLine;
    [IniValue('SQLFormatter','SelectColumnListAlignAlias', 'True')]
    property SelectColumnListAlignAlias: Boolean read GetSelectColumnListAlignAlias write SetSelectColumnListAlignAlias;
    [IniValue('SQLFormatter','SelectColumnListTreatDistinctAsVirtualColumn', 'False')]
    property SelectColumnListTreatDistinctAsVirtualColumn: Boolean read GetSelectColumnListTreatDistinctAsVirtualColumn write SetSelectColumnListTreatDistinctAsVirtualColumn;
    { Select Subquery }
    [IniValue('SQLFormatter','SelectSubqueryNewLineAfterIn', 'False')]
    property SelectSubqueryNewLineAfterIn: Boolean read GetSelectSubqueryNewLineAfterIn write SetSelectSubqueryNewLineAfterIn;
    [IniValue('SQLFormatter','SelectSubqueryNewLineAfterExists', 'False')]
    property SelectSubqueryNewLineAfterExists: Boolean read GetSelectSubqueryNewLineAfterExists write SetSelectSubqueryNewLineAfterExists;
    [IniValue('SQLFormatter','SelectSubqueryNewLineAfterComparisonOperator', 'False')]
    property SelectSubqueryNewLineAfterComparisonOperator: Boolean read GetSelectSubqueryNewLineAfterComparisonOperator write SetSelectSubqueryNewLineAfterComparisonOperator;
    [IniValue('SQLFormatter','SelectSubqueryNewLineBeforeComparisonOperator', 'False')]
    property SelectSubqueryNewLineBeforeComparisonOperator: Boolean read GetSelectSubqueryNewLineBeforeComparisonOperator write SetSelectSubqueryNewLineBeforeComparisonOperator;
    { Select Into Clause }
    [IniValue('SQLFormatter','SelectIntoClauseInNewLine', 'False')]
    property SelectIntoClauseInNewLine: Boolean read GetSelectIntoClauseInNewLine write SetSelectIntoClauseInNewLine;
    { Select From/Join Clause }
    [IniValue('SQLFormatter','SelectFromClauseStyle', '0')]
    property SelectFromClauseStyle: Integer read GetSelectFromClauseStyle write SetSelectFromClauseStyle;
    [IniValue('SQLFormatter','SelectFromClauseInNewLine', 'False')]
    property SelectFromClauseInNewLine: Boolean read GetSelectFromClauseInNewLine write SetSelectFromClauseInNewLine;
    [IniValue('SQLFormatter','SelectJoinClauseInNewLine', 'True')]
    property SelectJoinClauseInNewLine: Boolean read GetSelectJoinClauseInNewLine write SetSelectJoinClauseInNewLine;
    [IniValue('SQLFormatter','SelectAlignJoinWithFromKeyword', 'False')]
    property SelectAlignJoinWithFromKeyword: Boolean read GetSelectAlignJoinWithFromKeyword write SetSelectAlignJoinWithFromKeyword;
    [IniValue('SQLFormatter','SelectAlignAndOrWithOnInJoinClause', 'False')]
    property SelectAlignAndOrWithOnInJoinClause: Boolean read GetSelectAlignAndOrWithOnInJoinClause write SetSelectAlignAndOrWithOnInJoinClause;
    [IniValue('SQLFormatter','SelectAlignAliasInFromClause', 'False')]
    property SelectAlignAliasInFromClause: Boolean read GetSelectAlignAliasInFromClause write SetSelectAlignAliasInFromClause;
    { Select And/Or Clause }
    [IniValue('SQLFormatter','SelectAndOrLineBreak', '0')]
    property SelectAndOrLineBreak: Integer read GetSelectAndOrLineBreak write SetSelectAndOrLineBreak;
    [IniValue('SQLFormatter','SelectAndOrUnderWhere', 'False')]
    property SelectAndOrUnderWhere: Boolean read GetSelectAndOrUnderWhere write SetSelectAndOrUnderWhere;
    [IniValue('SQLFormatter','SelectWhereClauseInNewline', 'False')]
    property SelectWhereClauseInNewline: Boolean read GetSelectWhereClauseInNewline write SetSelectWhereClauseInNewline;
    [IniValue('SQLFormatter','SelectWhereClauseAlignExpr', 'False')]
    property SelectWhereClauseAlignExpr: Boolean read GetSelectWhereClauseAlignExpr write SetSelectWhereClauseAlignExpr;
    { Select Group By Clause }
    [IniValue('SQLFormatter','SelectGroupByClauseStyle', '0')]
    property SelectGroupByClauseStyle: Integer read GetSelectGroupByClauseStyle write SetSelectGroupByClauseStyle;
    [IniValue('SQLFormatter','SelectGroupByClauseInNewLine', 'False')]
    property SelectGroupByClauseInNewLine: Boolean read GetSelectGroupByClauseInNewLine write SetSelectGroupByClauseInNewLine;
    { Select Having Clause }
    [IniValue('SQLFormatter','SelectHavingClauseInNewLine', 'False')]
    property SelectHavingClauseInNewLine: Boolean read GetSelectHavingClauseInNewLine write SetSelectHavingClauseInNewLine;
    { Select Order By Clause }
    [IniValue('SQLFormatter','SelectOrderByClauseStyle', '0')]
    property SelectOrderByClauseStyle: Integer read GetSelectOrderByClauseStyle write SetSelectOrderByClauseStyle;
    [IniValue('SQLFormatter','SelectOrderByClauseInNewLine', 'False')]
    property SelectOrderByClauseInNewLine: Boolean read GetSelectOrderByClauseInNewLine write SetSelectOrderByClauseInNewLine;
    { Insert }
    [IniValue('SQLFormatter','InsertColumnListStyle', '0')]
    property InsertColumnListStyle: Integer read GetInsertColumnListStyle write SetInsertColumnListStyle;
    [IniValue('SQLFormatter','InsertValueListStyle', '0')]
    property InsertValueListStyle: Integer read GetInsertValueListStyle write SetInsertValueListStyle;
    [IniValue('SQLFormatter','InsertParenthesisInSeparateLine', 'False')]
    property InsertParenthesisInSeparateLine: Boolean read GetInsertParenthesisInSeparateLine write SetInsertParenthesisInSeparateLine;
    [IniValue('SQLFormatter','InsertColumnsPerLine', '0')]
    property InsertColumnsPerLine: Integer read GetInsertColumnsPerLine write SetInsertColumnsPerLine;
    { Update }
    [IniValue('SQLFormatter','UpdateColumnListStyle', '0')]
    property UpdateColumnListStyle: Integer read GetUpdateColumnListStyle write SetUpdateColumnListStyle;
    { Alignments }
    [IniValue('SQLFormatter','KeywordAlign', '0')]
    property KeywordAlign: Integer read GetKeywordAlign write SetKeywordAlign;
    [IniValue('SQLFormatter','KeywordAlignmentLeftJustify', 'False')]
    property KeywordAlignmentLeftJustify: Boolean read GetKeywordAlignmentLeftJustify write SetKeywordAlignmentLeftJustify;
  end;

function SQLFormatterOptionsWrapper: TSQLFormatterOptionsWrapper;

implementation

uses
  BCCommon.Messages, BCCommon.FileUtils, System.SysUtils;

var
  FSQLFormatterOptionsWrapper: TSQLFormatterOptionsWrapper;

function SQLFormatterOptionsWrapper: TSQLFormatterOptionsWrapper;
begin
  if not Assigned(FSQLFormatterOptionsWrapper) then
    FSQLFormatterOptionsWrapper := TSQLFormatterOptionsWrapper.Create;
  Result := FSQLFormatterOptionsWrapper;
end;

destructor TSQLFormatterOptionsWrapper.Destroy;
begin
  FreeAndNil(FSQLFormatterOptionsWrapper);
  inherited;
end;

{ TSQLFormatterOptionsWrapper }

procedure TSQLFormatterOptionsWrapper.ReadIniFile;
begin
  TIniPersist.Load(GetIniFilename, Self);
end;

procedure TSQLFormatterOptionsWrapper.WriteIniFile;
begin
  TIniPersist.Save(GetIniFilename, Self);
end;

{ Select Column List }

function TSQLFormatterOptionsWrapper.GetSelectColumnListStyle: Integer;
begin
  Result := Ord(gFmtOpt.Select_ColumnList_Style);
end;

procedure TSQLFormatterOptionsWrapper.SetSelectColumnListStyle(Value: Integer);
begin
  gFmtOpt.Select_ColumnList_Style := TAlignStyle(Value);
end;

function TSQLFormatterOptionsWrapper.GetSelectColumnListLineBreak: Integer;
begin
  Result := Ord(gFmtOpt.Select_ColumnList_Comma);
end;

procedure TSQLFormatterOptionsWrapper.SetSelectColumnListLineBreak(Value: Integer);
begin
  gFmtOpt.Select_ColumnList_Comma := TLineFeedsCommaOption(Value);
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

{ Insert }

function TSQLFormatterOptionsWrapper.GetInsertColumnListStyle: Integer;
begin
  Result := Ord(gFmtOpt.Insert_Columnlist_Style);
end;

procedure TSQLFormatterOptionsWrapper.SetInsertColumnListStyle(Value: Integer);
begin
  gFmtOpt.Insert_Columnlist_Style := TAlignStyle(Value);
end;

function TSQLFormatterOptionsWrapper.GetInsertValueListStyle: Integer;
begin
  Result := Ord(gFmtOpt.Insert_Valuelist_Style);
end;

procedure TSQLFormatterOptionsWrapper.SetInsertValueListStyle(Value: Integer);
begin
  gFmtOpt.Insert_Valuelist_Style := TAlignStyle(Value);
end;

function TSQLFormatterOptionsWrapper.GetInsertParenthesisInSeparateLine: Boolean;
begin
  Result := gFmtOpt.Insert_Parenthesis_in_separate_line;
end;

procedure TSQLFormatterOptionsWrapper.SetInsertParenthesisInSeparateLine(Value: Boolean);
begin
  gFmtOpt.Insert_Parenthesis_in_separate_line := Value;
end;

function TSQLFormatterOptionsWrapper.GetInsertColumnsPerLine: Integer;
begin
  Result := gFmtOpt.Insert_Columns_Per_line
end;

procedure TSQLFormatterOptionsWrapper.SetInsertColumnsPerLine(Value: Integer);
begin
  gFmtOpt.Insert_Columns_Per_line := Value;
end;

{ Update }

function TSQLFormatterOptionsWrapper.GetUpdateColumnListStyle: Integer;
begin
  Result := Ord(gFmtOpt.Update_Columnlist_Style);
end;

procedure TSQLFormatterOptionsWrapper.SetUpdateColumnListStyle(Value: Integer);
begin
  gFmtOpt.Update_Columnlist_Style := TAlignStyle(Value);
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
