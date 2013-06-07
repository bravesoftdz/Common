unit DuplicateChecker;

interface

uses
  System.Classes;

type
  { Based on Duplo 0.2.0 (C++) - duplicate source code block finder
    by Christian M. Ammann (cammann@giants.ch) }
  TDuplicateChecker = class
  private
    FFileNames: TStrings;
    FMinBlockSize: Word;
    FMinChars: Word;
  public
    constructor Create(FileNames: TStrings; MinBlockSize: Word; MinChars: Word);
    procedure Run(OutputFileName: string);
  end;

implementation

constructor TDuplicateChecker.Create(FileNames: TStrings; MinBlockSize: Word; MinChars: Word);
begin
  inherited Create;

  FFileNames := FileNames;
  FMinBlockSize := MinBlockSize;
  FMinChars := MinChars;
end;

procedure TDuplicateChecker.Run(OutputFileName: string);
begin
  //
end;

end.
