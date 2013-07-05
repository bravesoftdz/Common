unit BCCommon.DuplicateChecker;

interface

uses
  System.Classes, BCCommon.FileUtils;

type
  TSourceLine = class
  private
    FLine: string;
    FLineNumber: Integer;
    FHash: LongWord;
  public
    constructor Create(Line: string; LineNumber: Integer); overload;
    function IsEqual(Line: TSourceLine): Boolean;
    property Hash: LongWord read FHash;
    property Line: string read FLine;
    property LineNumber: Integer read FLineNumber;
  end;

  TSourceFile = class
  private
    FFileName: string;
    FFileType: TFileType;
    FMinChars: Word;
    FSourceLines: TList;
    function GetFilename: string;
    function IsSourceLine(Line: string): Boolean;
    function GetRowCount: Integer;
    procedure RemoveComments(var StringList: TStrings);
    procedure TrimLines(var StringList: TStrings);
  public
    constructor Create(FileName: string; MinChars: Word; RemoveComments: Boolean); overload;
    destructor Destroy; override;
    function GetLine(Index: Integer): TSourceLine;
    property FileName: string read GetFilename;
    property RowCount: Integer read GetRowCount;
  end;

  TDuplicateChecker = class
  private
    FFileNames: TStrings;
    FOutputFile: TextFile;
    FMinBlockSize: Byte;
    FMinChars: Byte;
    FRemoveComments: Boolean;
    FDuplicateLines: Integer;
    FTotalLineCount: Integer;
    function ProcessFiles(FileName1: string; FileName2: string): Integer;
    procedure WriteOutput(Line1: Integer; Line2: Integer; Count: Integer; SourceFile1, SourceFile2: TSourceFile);
  public
    constructor Create(InputFolder: string; FileType: string; OutputFileName: string; MinBlockSize: Byte; MinChars: Byte; RemoveComments: Boolean); overload;
    destructor Destroy; override;
    procedure Run;
  end;

implementation

uses
  System.SysUtils, System.Math, BCCommon.Hash, BCCommon.StringUtils;

{ TSourceLine }

constructor TSourceLine.Create(Line: string; LineNumber: Integer);
begin
  inherited Create;

  FLine := Line;
  FLineNumber := LineNumber;
  FHash := HashLine(FLine);
end;

function TSourceLine.IsEqual(Line: TSourceLine): Boolean;
begin
  Result := FHash = Line.Hash;
end;

{ TSourceFile }

constructor TSourceFile.Create(FileName: string; MinChars: Word; RemoveComments: Boolean);
var
  i: Integer;
  StringList: TStrings;
begin
  inherited Create;
  FFileName := FileName;
  FSourceLines := TList.Create;
  FFileType := GetFileType(FileName);
  { read file }
  StringList := TStringList.Create;
  try
    StringList.LoadFromFile(FileName);
    if RemoveComments then
      Self.RemoveComments(StringList);
    TrimLines(StringList);
    for i := 0 to StringList.Count - 1 do
      FSourceLines.Add(TSourceLine.Create(StringList.Strings[i], i));
  finally
    StringList.Free;
  end;
end;

destructor TSourceFile.Destroy;
var
  SourceLine: TSourceLine;
begin
  while FSourceLines.Count > 0 do
  begin
    SourceLine := TSourceLine(FSourceLines.Items[0]);
    FreeAndNil(SourceLine);
    FSourceLines.Delete(0);
  end;
  FSourceLines.Free;

  inherited;
end;

function TSourceFile.GetFilename: string;
begin
  Result := FFileName;
end;

procedure TSourceFile.TrimLines(var StringList: TStrings);
var
  i: Integer;
begin
  for i := StringList.Count - 1 downto 0 do
  begin
    if not IsSourceLine(StringList.Strings[i]) then
      StringList.delete(i)
    else
      StringList.Strings[i] := RemoveWhiteSpace(StringList.Strings[i]);
  end;
end;

procedure TSourceFile.RemoveComments(var StringList: TStrings);
var
  i: Integer;
  s: string;

  procedure RemoveRowComment(Index: Integer; CommentChars: string);
  var
    p: Integer;
  begin
    p := Pos(CommentChars, StringList[i]);
    if p > 0 then
      StringList[Index] := Copy(StringList[Index], 1, p - 1);
  end;

  procedure RemoveBlockComments(var Text: string; BeginChars: string; EndChars: string);
  var
    p, e: Integer;
  begin
    p := Pos(BeginChars, Text);
    while p > 0 do
    begin
      e := Pos(EndChars, Text);
      Text := Copy(Text, 1, p - 1) + Copy(Text, e + Length(BeginChars), Length(Text) - e - Length(EndChars) + 1);
      p := Pos(BeginChars, Text);
    end;
  end;

begin
  { remove row comments }
  for i := 0 to StringList.Count - 1 do
  begin
    if FFileType in [ftVB] then
      RemoveRowComment(i, '''');
    if FFileType in [ftCPP, ftCS, ftJava, ftPas] then
      RemoveRowComment(i, '//');
  end;

  { remove block comments }
  s := StringList.Text;

  if FFileType in [ftPas] then
  begin
    RemoveBlockComments(s, '{', '}');
    RemoveBlockComments(s, '(*', '*)');
  end;
  if FFileType in [ftCPP, ftCS, ftJava, ftPas] then
    RemoveBlockComments(s, '/*', '*/');

  StringList.Text := s;
end;

function TSourceFile.IsSourceLine(Line: string): Boolean;
begin
  Result := (Length(Line) >= FMinChars) and (Trim(Line) <> '');
end;

function TSourceFile.GetRowCount: Integer;
begin
  Result := 0;
  if Assigned(FSourceLines) then
    Result := FSourceLines.Count;
end;

function TSourceFile.GetLine(Index: Integer): TSourceLine;
begin
  Result := nil;
  if Assigned(FSourceLines) then
    if (FSourceLines.Count > 0) and (Index >= 0) and (Index < FSourceLines.Count) then
      Result := TSourceLine(FSourceLines.Items[Index]);
end;

{ TDuplicateChecker }

constructor TDuplicateChecker.Create(InputFolder: string; FileType: string; OutputFileName: string; MinBlockSize: Byte; MinChars: Byte;
  RemoveComments: Boolean);
begin
  inherited Create;

  FMinBlockSize := MinBlockSize;
  FMinChars := MinChars;
  FRemoveComments := RemoveComments;
  FFileNames := GetFileNamesFromFolder(InputFolder, FileType);
  FDuplicateLines := 0;
  FTotalLineCount := 0;
  AssignFile(FOutputFile, OutputFileName);
end;

destructor TDuplicateChecker.Destroy;
begin
  inherited Destroy;

  if Assigned(FFileNames) then
    FFileNames.Free;
end;

procedure TDuplicateChecker.WriteOutput(Line1: Integer; Line2: Integer; Count: Integer;
  SourceFile1, SourceFile2: TSourceFile);
var
  i: Integer;
begin
  WriteLn(FOutputFile, Format('%s (%d)', [SourceFile1.FileName, SourceFile1.GetLine(Line1).LineNumber]));
  WriteLn(FOutputFile, Format('%s (%d)', [SourceFile2.FileName, SourceFile2.GetLine(Line2).LineNumber]));

  for i := 0 to Count - 1 do
  begin
    WriteLn(FOutputFile, SourceFile1.GetLine(i + Line1).Line);
    Inc(FDuplicateLines);
	end;
end;

function TDuplicateChecker.ProcessFiles(FileName1: string; FileName2: string): Integer;
var
  SourceFile1, SourceFile2: TSourceFile;
  i, x, y, Count1, Count2, SequenceLength, MaxX, MaxY: Integer;
  MatchArray: array of Boolean;
  SourceLine: TSourceLine;
begin
  { Create source files }
  SourceFile1 := TSourceFile.Create(FileName1, FMinChars, FRemoveComments);
  SourceFile2 := TSourceFile.Create(FileName2, FMinChars, FRemoveComments);
  try
    Count1 := SourceFile1.GetRowCount;
    Count2 := SourceFile2.GetRowCount;
    FTotalLineCount := FTotalLineCount + Count1 + Count2;
    SetLength(MatchArray, Count1 * Count2);

    { Reset match array }
    for i := 0 to Length(MatchArray) - 1 do
      MatchArray[i] := False;
    { Compute match array }
    for y := 0 to Count1 - 1 do
    begin
      SourceLine := SourceFile1.GetLine(y);
      for x := 0 to Count2 - 1 do
        if SourceLine.Equals(SourceFile2.GetLine(x)) then
          MatchArray[x + Count2 * y] := True;
    end;

    Result := 0;
    { Scan vertical part }
    for y := 0 to Count1 - 1 do
    begin
      SequenceLength := 0;
      MaxX := Min(Count2, Count1 - y);
      for x := 0 to MaxX - 1 do
      begin
        if MatchArray[x + Count2 * (y + x)] then
          Inc(SequenceLength)
        else
        begin
          if SequenceLength >= FMinBlockSize then
          begin
            WriteOutput(y + x - SequenceLength, x - SequenceLength, SequenceLength, SourceFile1,
              SourceFile2);
            Inc(Result);
          end;
          SequenceLength := 0;
        end;
      end;
      if SequenceLength >= FMinBlockSize then
      begin
        WriteOutput(Count1 - SequenceLength, Count2 - SequenceLength, SequenceLength,
          SourceFile1, SourceFile2);
        Inc(Result);
      end;
    end;

    { Scan horizontal part }
    for x := 1 to Count2 - 1 do
    begin
      SequenceLength := 0;
      MaxY := Min(Count1, Count2 - x);
      for y := 0 to MaxY - 1 do
      begin
        if MatchArray[x + y + Count2 * y] then
          Inc(SequenceLength)
        else
        begin
          if SequenceLength >= FMinBlockSize then
          begin
            WriteOutput(y - SequenceLength, x + y - SequenceLength, SequenceLength, SourceFile1,
              SourceFile2);
            Inc(Result);
          end;
          SequenceLength := 0;
        end;
      end;
      if SequenceLength >= FMinBlockSize then
      begin
        WriteOutput(Count1 - SequenceLength, Count2 - SequenceLength, SequenceLength,
          SourceFile1, SourceFile2);
        Inc(Result);
      end;
    end;
  finally
    SourceFile1.Free;
    SourceFile2.Free;
    SetLength(MatchArray, 0);
  end;
end;

procedure TDuplicateChecker.Run;
var
  i, j, BlockCount: Integer;
  StartTime: TDateTime;
begin
  StartTime := Now;
  BlockCount := 0;
  try
    ReWrite(FOutputFile);
    WriteLn(FOutputFile, '--- Duplicate Checker ---');
    WriteLn(FOutputFile, '');
    { Compare each file with each other }
    for i := 0 to FFileNames.Count - 1 do
      for j := 0 to FFileNames.Count - 1 do
        if i <> j then
        begin
          WriteLn(FOutputFile, Format('Checking Files: %s and %s', [FFileNames[i], FFileNames[j]]));
          BlockCount := ProcessFiles(FFileNames[i], FFileNames[j]);
          if BlockCount > 0 then
            WriteLn(FOutputFile, Format('Found %d duplicate block(s).', [BlockCount]))
          else
            WriteLn(FOutputFile, 'Nothing found.');
          WriteLn(FOutputFile, Format('Time Elapsed: %s', [System.SysUtils.FormatDateTime('hh:nn:ss.zzz', Now - StartTime)]));
          WriteLn(FOutputFile, '');
        end;
    { Statistics }
    WriteLn(FOutputFile, '--- Summary ---');
    WriteLn(FOutputFile, Format('Duplicate Blocks: %d', [BlockCount]));
    WriteLn(FOutputFile, Format('Duplicate Lines of Code: %d', [FDuplicateLines]));
    WriteLn(FOutputFile, Format('Total Lines of Code: %d', [FTotalLineCount]));
    WriteLn(FOutputFile, Format('Time Elapsed: %s', [System.SysUtils.FormatDateTime('hh:nn:ss.zzz', Now - StartTime)]));
  finally
    CloseFile(FOutputFile);
  end;
end;

end.
