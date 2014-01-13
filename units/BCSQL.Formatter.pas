unit BCSQL.Formatter;

interface

uses
  System.Classes, IniPersist, BCSQL.Consts;

type
  TSQLFormatterOptions = class(TPersistent)
  private
    { Select Column List }
    FSelectColumnListStyle: Integer;
    FSelectColumnListLineBreak: Integer;
    FSelectColumnListColumnInNewLine: Boolean;
    FSelectColumnListAlignAlias: Boolean;
    FSelectColumnListTreatDistinctAsVirtualColumn: Boolean;
    { Select Subquery }
    FSelectSubqueryNewLineAfterIn: Boolean;
    FSelectSubqueryNewLineAfterExists: Boolean;
    FSelectSubqueryNewLineAfterComparisonOperator: Boolean;
    FSelectSubqueryNewLineBeforeComparisonOperator: Boolean;
    { Select Into Clause }
    FSelectIntoClauseInNewLine: Boolean;
    { Select From/Join Clause }
    FSelectFromClauseStyle: Integer;
    FSelectFromClauseInNewLine: Boolean;
    FSelectJoinClauseInNewLine: Boolean;
    FSelectAlignJoinWithFromKeyword: Boolean;
    FSelectAlignAndOrWithOnInJoinClause: Boolean;
    FSelectAlignAliasInFromClause: Boolean;
    { Select And/Or Clause }
    FSelectAndOrLineBreak: Integer;
    FSelectAndOrUnderWhere: Boolean;
    FSelectWhereClauseInNewline: Boolean;
    FSelectWhereClauseAlignExpr: Boolean;
    { Select Group By Clause }
    FSelectGroupByClauseStyle: Integer;
    FSelectGroupByClauseInNewLine: Boolean;
    { Select Having Clause }
    FSelectHavingClauseInNewLine: Boolean;
    { Select Order By Clause }
    FSelectOrderByClauseStyle: Integer;
    FSelectOrderByClauseInNewLine: Boolean;
    { Insert }
    FInsertColumnlistStyle: Integer;
    FInsertValuelistStyle: Integer;
    FInsertParenthesisInSeparateLine: Boolean;
    FInsertColumnsPerLine: Integer;
    { Update }
    FUpdateColumnlistStyle: Integer;
    { Alignments }
    FKeywordAlign: Integer;
    FKeywordAlignmentLeftJustify: Boolean;
  public
    destructor Destroy; override;
    procedure ReadIniFile;
    procedure WriteIniFile;
    { Select Column List }
    [IniValue(SQLFORMATTER, SELECTCOLUMNLISTSTYLE, '0')]
    property SelectColumnListStyle: Integer read FSelectColumnListStyle write FSelectColumnListStyle;
    [IniValue(SQLFORMATTER, SELECTCOLUMNLISTLINEBREAK, '0')]
    property SelectColumnListLineBreak: Integer read FSelectColumnListLineBreak write FSelectColumnListLineBreak;
    [IniValue(SQLFORMATTER, SELECTCOLUMNLISTCOLUMNINNEWLINE, 'False')]
    property SelectColumnListColumnInNewLine: Boolean read FSelectColumnListColumnInNewLine write FSelectColumnListColumnInNewLine;
    [IniValue(SQLFORMATTER, SELECTCOLUMNLISTALIGNALIAS, 'True')]
    property SelectColumnListAlignAlias: Boolean read FSelectColumnListAlignAlias write FSelectColumnListAlignAlias;
    [IniValue(SQLFORMATTER, SELECTCOLUMNLISTTREATDISTINCTASVIRTUALCOLUMN, 'False')]
    property SelectColumnListTreatDistinctAsVirtualColumn: Boolean read FSelectColumnListTreatDistinctAsVirtualColumn write FSelectColumnListTreatDistinctAsVirtualColumn;
    { Select Subquery }
    [IniValue(SQLFORMATTER, SELECTSUBQUERYNEWLINEAFTERIN, 'False')]
    property SelectSubqueryNewLineAfterIn: Boolean read FSelectSubqueryNewLineAfterIn write FSelectSubqueryNewLineAfterIn;
    [IniValue(SQLFORMATTER, SELECTSUBQUERYNEWLINEAFTEREXISTS, 'False')]
    property SelectSubqueryNewLineAfterExists: Boolean read FSelectSubqueryNewLineAfterExists write FSelectSubqueryNewLineAfterExists;
    [IniValue(SQLFORMATTER, SELECTSUBQUERYNEWLINEAFTERCOMPARISONOPERATOR, 'False')]
    property SelectSubqueryNewLineAfterComparisonOperator: Boolean read FSelectSubqueryNewLineAfterComparisonOperator write FSelectSubqueryNewLineAfterComparisonOperator;
    [IniValue(SQLFORMATTER, SELECTSUBQUERYNEWLINEBEFORECOMPARISONOPERATOR, 'False')]
    property SelectSubqueryNewLineBeforeComparisonOperator: Boolean read FSelectSubqueryNewLineBeforeComparisonOperator write FSelectSubqueryNewLineBeforeComparisonOperator;
    { Select Into Clause }
    [IniValue(SQLFORMATTER, SELECTINTOCLAUSEINNEWLINE, 'False')]
    property SelectIntoClauseInNewLine: Boolean read FSelectIntoClauseInNewLine write FSelectIntoClauseInNewLine;
    { Select From/Join Clause }
    [IniValue(SQLFORMATTER, SELECTFROMCLAUSESTYLE, '0')]
    property SelectFromClauseStyle: Integer read FSelectFromClauseStyle write FSelectFromClauseStyle;
    [IniValue(SQLFORMATTER, SELECTFROMCLAUSEINNEWLINE, 'False')]
    property SelectFromClauseInNewLine: Boolean read FSelectFromClauseInNewLine write FSelectFromClauseInNewLine;
    [IniValue(SQLFORMATTER, SELECTJOINCLAUSEINNEWLINE, 'True')]
    property SelectJoinClauseInNewLine: Boolean read FSelectJoinClauseInNewLine write FSelectJoinClauseInNewLine;
    [IniValue(SQLFORMATTER, SELECTALIGNJOINWITHFROMKEYWORD, 'False')]
    property SelectAlignJoinWithFromKeyword: Boolean read FSelectAlignJoinWithFromKeyword write FSelectAlignJoinWithFromKeyword;
    [IniValue(SQLFORMATTER, SELECTALIGNANDORWITHONINJOINCLAUSE, 'False')]
    property SelectAlignAndOrWithOnInJoinClause: Boolean read FSelectAlignAndOrWithOnInJoinClause write FSelectAlignAndOrWithOnInJoinClause;
    [IniValue(SQLFORMATTER, SELECTALIGNALIASINFROMCLAUSE, 'False')]
    property SelectAlignAliasInFromClause: Boolean read FSelectAlignAliasInFromClause write FSelectAlignAliasInFromClause;
    { Select And/Or Clause }
    [IniValue(SQLFORMATTER, SELECTANDORLINEBREAK, '0')]
    property SelectAndOrLineBreak: Integer read FSelectAndOrLineBreak write FSelectAndOrLineBreak;
    [IniValue(SQLFORMATTER, SELECTANDORUNDERWHERE, 'False')]
    property SelectAndOrUnderWhere: Boolean read FSelectAndOrUnderWhere write FSelectAndOrUnderWhere;
    [IniValue(SQLFORMATTER, SELECTWHERECLAUSEINNEWLINE, 'False')]
    property SelectWhereClauseInNewline: Boolean read FSelectWhereClauseInNewline write FSelectWhereClauseInNewline;
    [IniValue(SQLFORMATTER, SELECTWHERECLAUSEALIGNEXPR, 'False')]
    property SelectWhereClauseAlignExpr: Boolean read FSelectWhereClauseAlignExpr write FSelectWhereClauseAlignExpr;
    { Select Group By Clause }
    [IniValue(SQLFORMATTER, SELECTGROUPBYCLAUSESTYLE, '0')]
    property SelectGroupByClauseStyle: Integer read FSelectGroupByClauseStyle write FSelectGroupByClauseStyle;
    [IniValue(SQLFORMATTER, SELECTGROUPBYCLAUSEINNEWLINE, 'False')]
    property SelectGroupByClauseInNewLine: Boolean read FSelectGroupByClauseInNewLine write FSelectGroupByClauseInNewLine;
    { Select Having Clause }
    [IniValue(SQLFORMATTER, SELECTHAVINGCLAUSEINNEWLINE, 'False')]
    property SelectHavingClauseInNewLine: Boolean read FSelectHavingClauseInNewLine write FSelectHavingClauseInNewLine;
    { Select Order By Clause }
    [IniValue(SQLFORMATTER, SELECTORDERBYCLAUSESTYLE, '0')]
    property SelectOrderByClauseStyle: Integer read FSelectOrderByClauseStyle write FSelectOrderByClauseStyle;
    [IniValue(SQLFORMATTER, SELECTORDERBYCLAUSEINNEWLINE, 'False')]
    property SelectOrderByClauseInNewLine: Boolean read FSelectOrderByClauseInNewLine write FSelectOrderByClauseInNewLine;
    { Insert }
    [IniValue(SQLFORMATTER, INSERTCOLUMNLISTSTYLE, '0')]
    property InsertColumnListStyle: Integer read FInsertColumnListStyle write FInsertColumnListStyle;
    [IniValue(SQLFORMATTER, INSERTVALUELISTSTYLE, '0')]
    property InsertValueListStyle: Integer read FInsertValueListStyle write FInsertValueListStyle;
    [IniValue(SQLFORMATTER, INSERTPARENTHESISINSEPARATELINE, 'False')]
    property InsertParenthesisInSeparateLine: Boolean read FInsertParenthesisInSeparateLine write FInsertParenthesisInSeparateLine;
    [IniValue(SQLFORMATTER, INSERTCOLUMNSPERLINE, '0')]
    property InsertColumnsPerLine: Integer read FInsertColumnsPerLine write FInsertColumnsPerLine;
    { Update }
    [IniValue(SQLFORMATTER, UPDATECOLUMNLISTSTYLE, '0')]
    property UpdateColumnListStyle: Integer read FUpdateColumnListStyle write FUpdateColumnListStyle;
    { Alignments }
    [IniValue(SQLFORMATTER, KEYWORDALIGN, '0')]
    property KeywordAlign: Integer read FKeywordAlign write FKeywordAlign;
    [IniValue(SQLFORMATTER, KEYWORDALIGNMENTLEFTJUSTIFY, 'False')]
    property KeywordAlignmentLeftJustify: Boolean read FKeywordAlignmentLeftJustify write FKeywordAlignmentLeftJustify;
  end;

function FormatSQL(SQL: PWideChar; Vendor: Integer): PWideChar; stdcall; external 'SQLFormatter.dll';
procedure FreeAString(AStr: PWideChar); stdcall; external 'SQLFormatter.dll';

function SQLFormatterOptions: TSQLFormatterOptions;

implementation

uses
  BCCommon.Messages, BCCommon.FileUtils, System.SysUtils;

var
  FSQLFormatterOptions: TSQLFormatterOptions;

function SQLFormatterOptions: TSQLFormatterOptions;
begin
  if not Assigned(FSQLFormatterOptions) then
    FSQLFormatterOptions := TSQLFormatterOptions.Create;
  Result := FSQLFormatterOptions;
end;

destructor TSQLFormatterOptions.Destroy;
begin
  FreeAndNil(FSQLFormatterOptions);
  inherited;
end;

{ TSQLFormatterOptions }

procedure TSQLFormatterOptions.ReadIniFile;
begin
  TIniPersist.Load(GetIniFilename, Self);
end;

procedure TSQLFormatterOptions.WriteIniFile;
begin
  TIniPersist.Save(GetIniFilename, Self);
end;

end.
