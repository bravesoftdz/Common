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
    constructor Create(Line: string; LineNumber: Integer);
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
  public
    constructor Create(FileName: string; MinChars: Word);
    function GetLine(Index: Integer): TSourceLine;
    property RowCount: Integer read GetRowCount;
  end;

  TDuplicateChecker = class
  private
    FFileNames: TStrings;
    FOutputFile: TextFile;
    FMinBlockSize: Byte;
    FMinChars: Byte;
    function ProcessFiles(FileName1: string; FileName2: string): Integer;
  public
    constructor Create(InputFolder: string; OutputFileName: string; MinBlockSize: Byte; MinChars: Byte);
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

  FLine := RemoveWhiteSpace(Line);
  FLineNumber := LineNumber;
  FHash := HashLine(FLine);
end;

function TSourceLine.IsEqual(Line: TSourceLine): Boolean;
begin
  Result := FHash = Line.Hash;
end;

{ TSourceFile }

constructor TSourceFile.Create(FileName: string; MinChars: Word);
begin
  inherited Create;

  FFileType := GetFileType(FileName);
  { read file and remove comments }
end;

function TSourceFile.IsSourceLine(Line: string): Boolean;
begin
  Result := Length(Line) >= FMinChars;
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

constructor TDuplicateChecker.Create(InputFolder: string; OutputFileName: string; MinBlockSize: Byte; MinChars: Byte);
begin
  inherited Create;

  FMinBlockSize := MinBlockSize;
  FMinChars := MinChars;
  FFileNames := Common.GetFileNamesFromFolder(InputFolder);
  AssignFile(FOutputFile, OutputFileName);
end;

destructor TDuplicateChecker.Destroy;
begin
  inherited Destroy;

  if Assigned(FFileNames) then
    FFileNames.Free;
end;
 {
function LoadFileToStr(const FileName: TFileName): AnsiString;
var
  FileStream : TFileStream;
begin
  FileStream:= TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    if FileStream.Size>0 then
    begin
      SetLength(Result, FileStream.Size);
      FileStream.Read(Pointer(Result)^, FileStream.Size);
    end;
  finally
    FileStream.Free;
  end;
end;  }

function TDuplicateChecker.ProcessFiles(FileName1: string; FileName2: string): Integer;
var
  SourceFile1, SourceFile2: TSourceFile;
begin
  { Create source files }
  SourceFile1 := TSourceFile.Create(FileName1, FMinChars);
  SourceFile2 := TSourceFile.Create(FileName2, FMinChars);
  try
    { Compute matrix }

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
