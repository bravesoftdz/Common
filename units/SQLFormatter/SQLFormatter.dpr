library SQLFormatter;

uses
  GSQLParser, LZBaseType, System.SysUtils;

{$R *.res}

{ Vendor:
  0 = MSSql; 1 = Oracle; 2 = MySQL; 3 = Access; 4 = Generic; 5 = DB2; 6 = Sybase; 7 = Informix; 8 = PostgreSQL;
  9 = Firebird; 10 = Mdx }

function FormatSQL(SQL: PWideChar; Vendor: Integer): PWideChar; stdcall;
var
  Rslt: Integer;
  DBVendor: TDBVendor;
  GSQLParser: TGSQLParser;
  s: string;
begin
  if (Vendor >= 0) and (Vendor <= 10) then
    DBVendor := TDBVendor(Vendor)
  else
    DBVendor := TDBVendor(4); { generic }

  GSQLParser := TGSQLParser.Create(DBVendor);
  try
    GSQLParser.SQLText.Text := SQL;
    Rslt := GSQLParser.PrettyPrint;
    if Rslt > 0 then
      Result := nil
    else
    begin
      s := GSQLParser.FormattedSQLText.Text;
      Result := StrAlloc(Length(s)+1);
      StrPCopy(Result, s);
    end;
  finally
    GSQLParser.Free;
  end;
end;

procedure FreeAString(AStr: PWideChar); stdcall;
begin
  StrDispose(AStr);
end;

exports
  FormatSQL,
  FreeAString;

begin
end.
