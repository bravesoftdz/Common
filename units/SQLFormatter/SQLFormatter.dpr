library SQLFormatter;

uses
  GSQLParser,
  LZBaseType,
  System.SysUtils,
  FormatterOptions in 'FormatterOptions.pas',
  BCSQL.Consts in '..\BCSQL.Consts.pas';

{$R *.res}

{ Vendor:
  0 = MSSql; 1 = Oracle; 2 = MySQL; 3 = Access; 4 = Generic; 5 = DB2; 6 = Sybase; 7 = Informix; 8 = PostgreSQL;
  9 = Firebird; 10 = Mdx }

function FormatSQL(SQL: PWideChar; Vendor: Integer): PWideChar; stdcall;
var
  Rslt: Integer;
  ValidCall: Boolean;
  DBVendor: TDBVendor;
  GSQLParser: TGSQLParser;
  s, IniFileName: string;
begin
  ValidCall := True;
  if FileExists('EditBone.exe') then
    IniFileName := 'EditBone.ini'
  else
  if FileExists('OraBone.exe') then
    IniFileName := 'OraBone.ini'
  else
  begin
    s := '-- SQLFormatter.dll works only with EditBone.exe and OraBone.exe' + #10#13 + SQL;
    ValidCall := False;
  end;

  if ValidCall then
  begin
    if (Vendor >= 0) and (Vendor <= 10) then
      DBVendor := TDBVendor(Vendor)
    else
      DBVendor := TDBVendor(4); { generic }

    GSQLParser := TGSQLParser.Create(DBVendor);
    try
      GSQLParser.SQLText.Text := SQL;
      ReadFormatOptions(IniFileName);
      Rslt := GSQLParser.PrettyPrint;
      if Rslt > 0 then
        s := '-- not a valid SQL clause' + #10#13 + SQL
      else
        s := GSQLParser.FormattedSQLText.Text;
    finally
      GSQLParser.Free;
    end;
  end;

  Result := StrAlloc(Length(s) + 1);
  StrPCopy(Result, s);
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
