unit BCCommon.StringUtils;

interface

uses
  SynEdit, SynCompletionProposal;

  function AnsiInitCap(Str: string): string;
  function DecryptString(Data: string): string;
  function EncryptString(Data: string): string;
  function FormatXML(XML: string): string;
  function GetNextToken(Separator: string; Text: string): string;
  function RemoveTokenFromStart(Separator: string; Text: string): string;
  function RemoveWhiteSpace(const s: string): string;
  function StringBetween(Str: string; SubStr1: string; SunStr2: string): string;
  function WideUpperCase(const S: WideString): WideString;
  function WordCount(s: string): Integer;

  function SplitTextIntoWords(SynCompletionProposal: TSynCompletionProposal; SynEdit: TSynEdit; CaseSensitive: Boolean): string;

implementation

uses
  Winapi.Windows, System.Classes, System.SysUtils, System.Character, Xml.XMLDoc;

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

function GetNextToken(Separator: string; Text: string): string;
var
  i: Integer;
begin
  i := Pos(Separator, Text);
  if i <> 0 then
    Result := System.Copy(Text, 1, i - 1)
  else
    Result := Text;
end;

function RemoveTokenFromStart(Separator: string; Text: string): string;
var
  i: Integer;
begin
  i := Pos(Separator, Text);
  if i <> 0 then
    Result := System.Copy(Text, i + Length(Separator), Length(Text))
  else
    Result := '';
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

function SplitTextIntoWords(SynCompletionProposal: TSynCompletionProposal; SynEdit: TSynEdit; CaseSensitive: Boolean): string;
var
  i: Integer;
  S, Word: string;
  StringList: TStringList;
  startpos, endpos: Integer;
  KeywordStringList: TStrings;
begin
  Result := '';
  S := SynEdit.Text;
  SynCompletionProposal.ItemList.Clear;
  startpos := 1;
  KeywordStringList := TStringList.Create;
  StringList := TStringList.Create;
  StringList.CaseSensitive := CaseSensitive;
  try
    { add document words }
    while startpos <= Length(S) do
    begin
      while (startpos <= Length(S)) and not IsCharAlpha(S[startpos]) do
        Inc(startpos);
      if startpos <= Length(S) then
      begin
        endpos := startpos + 1;
        while (endpos <= Length(S)) and IsCharAlpha(S[endpos]) do
          Inc(endpos);
        Word := Copy(S, startpos, endpos - startpos);
        if endpos - startpos > Length(Result) then
          Result := Word;
        if StringList.IndexOf(Word) = -1 then { no duplicates }
          StringList.Add(Word);
        startpos := endpos + 1;
      end;
    end;
    { add highlighter keywords }
    SynEdit.Highlighter.AddKeywords(KeywordStringList);
    for i := 0 to KeywordStringList.Count - 1 do
    begin
      Word := KeywordStringList.Strings[i];
      if Length(Word) > Length(Result) then
        Result := Word;
      if StringList.IndexOf(Word) = -1 then { no duplicates }
        StringList.Add(Word);
    end;
  finally
    StringList.Sort;
    SynCompletionProposal.ItemList.Assign(StringList);
    StringList.Free;
    if Assigned(KeywordStringList) then
      KeywordStringList.Free;
  end;
end;

end.
