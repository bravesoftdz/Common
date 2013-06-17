unit DuplicateChecker;

interface

uses
  System.Classes, Common;

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
    FFileType: TFileType;
    FMinChars: Word;
    FSourceLines: TList;
    function IsSourceLine(Line: string): Boolean;
    function GetRowCount: Integer;
    procedure RemoveComments(var StringList: TStrings);
    procedure TrimLines(var StringList: TStrings);
  public
    constructor Create(FileName: string; MinChars: Word; RemoveComments: Boolean); overload;
    destructor Destroy; override;
    function GetLine(Index: Integer): TSourceLine;
    property RowCount: Integer read GetRowCount;
  end;

  TDuplicateChecker = class
  private
    FFileNames: TStrings;
    FOutputFile: TextFile;
    FMinBlockSize: Byte;
    FMinChars: Byte;
    FRemoveComments: Boolean;
    function ProcessFiles(FileName1: string; FileName2: string): Integer;
  public
    constructor Create(InputFolder: string; OutputFileName: string; MinBlockSize: Byte; MinChars: Byte; RemoveComments: Boolean); overload;
    destructor Destroy; override;
    procedure Run;
  end;

implementation

uses
  System.SysUtils, Hash;

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
  end;
  FSourceLines.Free;

  inherited;
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

constructor TDuplicateChecker.Create(InputFolder: string; OutputFileName: string; MinBlockSize: Byte; MinChars: Byte;
  RemoveComments: Boolean);
begin
  inherited Create;

  FMinBlockSize := MinBlockSize;
  FMinChars := MinChars;
  FRemoveComments := RemoveComments;
  FFileNames := Common.GetFileNamesFromFolder(InputFolder);
  AssignFile(FOutputFile, OutputFileName);
end;

destructor TDuplicateChecker.Destroy;
begin
  inherited Destroy;

  if Assigned(FFileNames) then
    FFileNames.Free;
end;

function TDuplicateChecker.ProcessFiles(FileName1: string; FileName2: string): Integer;
var
  SourceFile1, SourceFile2: TSourceFile;
begin
  { Create source files }
  SourceFile1 := TSourceFile.Create(FileName1, FMinChars, FRemoveComments);
  SourceFile2 := TSourceFile.Create(FileName2, FMinChars, FRemoveComments);
  try
    { Compute matrix }
    (*
    for(int y=0; y<m; y++){
	    SourceLine* pSLine = pSource1->getLine(y);
        for(int x=0; x<n; x++){
            if(pSLine->equals(pSource2->getLine(x))){
                m_pMatrix[x+n*y] = MATCH;
            }
        }
    } *)
    { Scan vertical part }

    { Scan horizontal part }

  finally
    SourceFile1.Free;
    SourceFile2.Free;
  end;
end;

procedure TDuplicateChecker.Run;
var
  i, j, BlockCount: Integer;
  StartTime: TDateTime;
begin
  StartTime := Now;
  try
    ReWrite(FOutputFile);
    { Compare each file with each other }
    for i := 0 to FFileNames.Count - 1 do
      for j := 0 to FFileNames.Count - 1 do
        if i <> j then
        begin
          BlockCount := ProcessFiles(FFileNames[i], FFileNames[j]);
          if BlockCount > 0 then
            WriteLn(FOutputFile, Format('Found %d block(s).', [BlockCount]))
          else
            WriteLn(FOutputFile, 'Nothing found.');
          WriteLn(FOutputFile, Format('Time Elapsed: %s', [System.SysUtils.FormatDateTime('hh:nn:ss.zzz', Now - StartTime)]));
        end;
  finally
    CloseFile(FOutputFile);
  end;
end;

end.
