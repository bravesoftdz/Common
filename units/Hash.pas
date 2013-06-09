unit Hash;

interface

uses
  System.AnsiStrings, System.SysUtils;

function HashLine(const Line: string; IgnoreCase, IgnoreBlanks: Boolean): PLongWord;
function FNV1aHash(const Line: AnsiString): LongWord;

implementation

function FNV1aHash(const Line: AnsiString): LongWord;
var
  i: Integer;
const
  FNV_offset_basis = 2166136261;
  FNV_prime = 16777619;
begin
  Result := FNV_offset_basis;
  for i := 1 to Length(Line) do
    Result := (Result xor Byte(Line[i])) * FNV_prime;
end;

function HashLine(const Line: string; IgnoreCase, IgnoreBlanks: Boolean): PLongWord;
var
  i, j, Len: Integer;
  s, l: AnsiString;
begin
  s := AnsiString(Line);
  l := AnsiString(Line);
  if IgnoreBlanks then
  begin
    i := 1;
    j := 1;
    Len := Length(Line);
    while i <= Len do
    begin
      if not CharInSet(l[i], [#9, #32]) then
      begin
        s[j] := l[i];
        Inc(j);
      end;
      Inc(i);
    end;
    SetLength(s, j - 1);
  end;
  if IgnoreCase then
    s := LowerCase(s);

  Result := PLongWord(FNV1aHash(s));
end;

end.
