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

implementation

uses
  BCCommon.Messages;

constructor TSQLFormatter.Create(SQL: TStrings; Vendor: TDBVendor);
begin
  FSQLParser := TGSQLParser.Create(Vendor);
  FSQLParser.SQLText.Assign(SQL);

  gFmtOpt.Select_keywords_alignOption := aloRight;
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
