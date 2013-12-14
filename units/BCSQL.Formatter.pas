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
    { Select }
    function GetSelectKeywordsAlign: Integer;
    procedure SetSelectKeywordsAlign(Value: Integer);
  public
    { Select }
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
