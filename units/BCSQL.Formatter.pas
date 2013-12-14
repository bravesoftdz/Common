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
    { Select From/Join Clause }
    { Select And/Or Clause }
    { Select Group By Clause }
    { Select Having Clause }
    { Select Order By Clause }

    { Alignments }
    function GetSelectKeywordsAlign: Integer;
    procedure SetSelectKeywordsAlign(Value: Integer);
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
    { Select From/Join Clause }
    { Select And/Or Clause }
    { Select Group By Clause }
    { Select Having Clause }
    { Select Order By Clause }

    { Alignments }
    property SelectKeywordsAlign: Integer read GetSelectKeywordsAlign write SetSelectKeywordsAlign;
  end;

implementation

uses
  BCCommon.Messages;

{ TSQLFormatterOptionsWrapper }

function TSQLFormatterOptionsWrapper.GetSelectKeywordsAlign: Integer;
begin
  case gFmtOpt.Select_keywords_alignOption of
    aloLeft: Result := 0;
    aloRight: Result := 1
  else
    Result := 2; { aloNone }
  end;
end;

{ Select Column List }

function TSQLFormatterOptionsWrapper.GetSelectColumnListStyle: Integer;
begin
  //Result := gFmtOpt.Select_ListitemFitInOneLine;
  case gFmtOpt.Select_ColumnList_Style of
    asStacked: Result := 0;
  else
    Result := 1 { asWrapped }
  end;
end;

procedure TSQLFormatterOptionsWrapper.SetSelectColumnListStyle(Value: Integer);
begin
  //gFmtOpt.Select_ListitemFitInOneLine := Value;
  case Value of
    0: gFmtOpt.Select_ColumnList_Style := asStacked; //Select_ColumnList_Style
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

{ Alignments }

procedure TSQLFormatterOptionsWrapper.SetSelectKeywordsAlign(Value: Integer);
begin
  case Value of
    0: gFmtOpt.Select_keywords_alignOption := aloLeft;
    1: gFmtOpt.Select_keywords_alignOption := aloRight;
    2: gFmtOpt.Select_keywords_alignOption := aloNone;
  end;
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
