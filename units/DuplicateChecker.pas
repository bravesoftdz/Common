unit DuplicateChecker;

interface

uses
  System.Classes;

type
  TSourceLine = class
  private
    FLine: string;
    FLineNumber: Integer;
	  FHashHigh: Int64;
    FHashLow: Int64;
  public
    constructor Create(Line: string; LineNumber: Integer);
    function Equals(Line: TSourceLine): Boolean;
    property Line: string read FLine;
    property LineNumber: Integer read FLineNumber;
  end;

  TSourceFile = class
  private
    FFileType: string;
    FMinChars: Word;
    FSourceLines: TList;
   	function IsSourceLine(Line: string): Boolean;
   	function GetCleanLine(Line: string): string;
  public
    constructor Create(FileName: string; MinChars: Word);
    function Count: Integer;
    function GetLine(Index: Integer): TSourceLine;
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
  System.SysUtils, Common;

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
