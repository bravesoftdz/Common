unit DuplicateChecker;

interface

uses
  System.Classes;

type
  TDuplicateChecker = class
  private
    FFileNames: TStrings;
    FMinBlockSize: Byte;
    FMinChars: Byte;
  public
    constructor Create(Folder: string; MinBlockSize: Byte; MinChars: Byte);
    destructor Destroy; override;
    procedure Run(OutputFileName: string);
  end;

implementation

uses
  Common;

constructor TDuplicateChecker.Create(Folder: string; MinBlockSize: Byte; MinChars: Byte);
begin
  inherited Create;

  FMinBlockSize := MinBlockSize;
  FMinChars := MinChars;
  FFileNames := Common.GetFileNamesFromFolder(Folder);
end;

destructor TDuplicateChecker.Destroy;
begin
  inherited Destroy;

  FFileNames.Free;
end;

procedure TDuplicateChecker.Run(OutputFileName: string);
begin

end;

end.
