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
    function GetSelectColumnlistComma: Integer;
    procedure SetSelectColumnlistComma(Value: Integer);
    function GetSelectItemInNewLine: Boolean;
    procedure SetSelectItemInNewLine(Value: Boolean);
    function GetAlignAliasInSelectList: Boolean;
    procedure SetAlignAliasInSelectList(Value: Boolean);
    function GetTreatDistinctAsVirtualColumn: Boolean;
    procedure SetTreatDistinctAsVirtualColumn(Value: Boolean);
    { Select Subquery }
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
    property SelectColumnListComma: Integer read GetSelectColumnListComma write SetSelectColumnListComma;
    property SelectItemInNewLine: Boolean read GetSelectItemInNewLine write SetSelectItemInNewLine;
    property AlignAliasInSelectList: Boolean read GetAlignAliasInSelectList write SetAlignAliasInSelectList;
    property TreatDistinctAsVirtualColumn: Boolean read GetTreatDistinctAsVirtualColumn write SetTreatDistinctAsVirtualColumn;
    { Select Subquery }
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

procedure TSQLFormatterOptionsWrapper.SetSelectColumnListStyle(Value: Integer);
begin
  case Value of
    0: gFmtOpt.Select_ColumnList_Style := asStacked;
    1: gFmtOpt.Select_ColumnList_Style := asWrapped;
  end;
end;

function TSQLFormatterOptionsWrapper.GetSelectColumnListComma: Integer;
begin
  case gFmtOpt.Select_ColumnList_Comma of
    lfAfterComma: Result := 0;
    lfBeforeComma: Result := 1;
    lfBeforeCommaWithSpace: Result := 2;
  else
    Result := 3 { lfNoLineBreakComma }
  end;
end;

procedure TSQLFormatterOptionsWrapper.SetSelectColumnListComma(Value: Integer);
begin
  case Value of
    0: gFmtOpt.Select_ColumnList_Comma := lfAfterComma;
    1: gFmtOpt.Select_ColumnList_Comma := lfBeforeComma;
    2: gFmtOpt.Select_ColumnList_Comma := lfBeforeCommaWithSpace;
    3: gFmtOpt.Select_ColumnList_Comma := lfNoLineBreakComma;
  end;
end;

function TSQLFormatterOptionsWrapper.GetSelectItemInNewLine: Boolean;
begin
  Result := gFmtOpt.SelectItemInNewLine;
end;

procedure TSQLFormatterOptionsWrapper.SetSelectItemInNewLine(Value: Boolean);
begin
  gFmtOpt.SelectItemInNewLine := Value;
end;

function TSQLFormatterOptionsWrapper.GetAlignAliasInSelectList: Boolean;
begin
  Result := gFmtOpt.AlignAliasInSelectList;
end;

procedure TSQLFormatterOptionsWrapper.SetAlignAliasInSelectList(Value: Boolean);
begin
  gFmtOpt.AlignAliasInSelectList := Value;
end;

function TSQLFormatterOptionsWrapper.GetTreatDistinctAsVirtualColumn: Boolean;
begin
  Result := gFmtOpt.TreatDistinctAsVirtualColumn;
end;

procedure TSQLFormatterOptionsWrapper.SetTreatDistinctAsVirtualColumn(Value: Boolean);
begin
  gFmtOpt.TreatDistinctAsVirtualColumn := Value;
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

function TSQLFormatterOptionsWrapper.GetSelectColumnListStyle: Integer;
begin
  case gFmtOpt.Select_ColumnList_Style of
    asStacked: Result := 0;
  else
    Result := 1 { asWrapped }
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
