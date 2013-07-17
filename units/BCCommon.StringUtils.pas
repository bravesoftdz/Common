unit BCCommon.StringUtils;

interface

function AddSlash(Path: string): string;
function AnsiInitCap(Str: string): string;
function DecryptString(Data: string): string;
function EncryptString(Data: string): string;
function FormatXML(XML: string): string;
function GetNextToken(Separator: char; Text: string): string;
function GetTextAfterChar(Separator: char; Text: string): string;
function RemoveTokenFromStart(Separator: char; Text: string): string;
function RemoveWhiteSpace(const s: string): string;
function StringBetween(Str: string; SubStr1: string; SunStr2: string): string;
function WideUpperCase(const S: WideString): WideString;
function WordCount(s: string): Integer;

implementation

uses
  System.SysUtils, System.Character, Xml.XMLDoc;

function AnsiInitCap(Str: string): string;
begin
  Result := Concat(AnsiUpperCase(Copy(Str, 1, 1)), AnsiLowerCase(Copy(Str, 2, Length(Str))));
end;

function StringBetween(Str: string; SubStr1: string; SunStr2: string): string;
begin
  Result := Str;
  Result := Copy(Result, Pos(SubStr1, Result) + 1, Length(Result));
  Result := Copy(Result, 1, Pos(SunStr2, Result) - 1);
end;

function AddSlash(Path: string): string;
begin
  if Path = '' then
    Exit;
  if Path[Length(Path)] <> '\' then
    Result := Format('%s\', [Path])
  else
    Result := Path;
end;

function WideUpperCase(const S: WideString): WideString;
var
  I, Len: Integer;
  DstP, SrcP: PChar;
  Ch: Char;
begin
  Len := Length(S);
  SetLength(Result, Len);
  if Len > 0 then
  begin
    DstP := PChar(Pointer(Result));
    SrcP := PChar(Pointer(S));
    for I := Len downto 1 do
    begin
      Ch := SrcP^;
      case Ch of
        'a'..'z':
          Ch := Char(Word(Ch) xor $0020);
      end;
      DstP^ := Ch;
      Inc(DstP);
      Inc(SrcP);
    end;
  end;
end;

function DecryptString(Data: string): string;
var
  i: Integer;
begin
  Result := '';
  if Length(Data) > 0 Then
    for i := 1 to Length(Data) do
    begin
      if Ord(Data[i]) <> 0 Then
        Result:= Result + Chr(Ord(Data[i]) - 1)
      else
        Result:= Result + Chr(255)
    end;
end;

function EncryptString(Data: string): string;
var
  i: Integer;
begin
  Result := '';
  if Length(Data) > 0 then
    for i := 1 to Length(Data) do
    begin
      if Ord(Data[i]) <> 255 Then
        Result := Result + Chr(Ord(Data[i]) + 1)
      else
        Result := Result + Chr(0)
    end;
end;

function GetNextToken(Separator: char; Text: string): string;
begin
  Result := System.Copy(Text, 1, Pos(Separator, Text) - 1);
end;

function RemoveTokenFromStart(Separator: char; Text: string): string;
begin
  Result := System.Copy(Text, Pos(Separator, Text) + 1, Length(Text));
end;

function GetTextAfterChar(Separator: char; Text: string): string;
begin
  Result := System.Copy(Text, Pos(Separator, Text) + 1, Length(Text));
end;

function RemoveWhiteSpace(const s: string): string;
var
  i, j: Integer;
begin
  SetLength(Result, Length(s));
  j := 0;
  for i := 1 to Length(s) do
    if not s[i].IsWhiteSpace then
    begin
      inc(j);
      Result[j] := s[i];
    end;
  SetLength(Result, j);
end;

{ Note! The default encoding for XML files is UTF-8, so if no encoding attribute is found UTF-8 is
  assumed. If encoding is UTF-8, FormatXMLData function will remove the encoding attribute. }
function FormatXML(XML: string): string;
var
  XMLDocument: TXMLDocument;
begin
  XMLDocument := TXMLDocument.Create(nil);
  try
    XMLDocument.LoadFromXML(XML);
    XMLDocument.XML.Text := FormatXMLData(XMLDocument.XML.Text);
    Result := XMLDocument.XML.Text;
  finally
    XMLDocument.Free;
  end;
end;

function WordCount(s: string): Integer;
var
  i: Integer;
  IsWhite, IsWhiteOld: boolean;
begin
  IsWhiteOld := True;
  Result := 0;
  for i := 0 to Length(s) - 1 do
  begin
    IsWhite := s[i].IsWhiteSpace;
    if IsWhiteOld and not IsWhite then
      Inc(Result);
    IsWhiteOld := IsWhite;
  end;
end;

end.
