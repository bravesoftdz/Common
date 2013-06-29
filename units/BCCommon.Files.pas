unit BCCommon.Files;

interface

function GetFileNamesFromFolder(Folder: string): TStrings;
function GetFileType(FileName: string): TFileType;
function GetFileVersion(Path: string): string;
function GetINIFilename: string;

implementation

function GetFileType(FileName: string): TFileType;
var
  FileExt: string;
begin
  FileExt := ExtractFileExt(FileName);

  if (FileExt = '.c') or (FileExt = '.cpp') or (FileExt = '.h') or (FileExt = '.hpp') then
    Result := ftCPP
  else
  if FileExt = '.cs' then
    Result := ftCS
  else
  if FileExt = '.java' then
    Result := ftJava
  else
  if (FileExt = '.pas') or (FileExt = '.dfm') or (FileExt = '.dpr') or (FileExt = '.dproj') then
    Result := ftPas
  else
  if (FileExt = '.vb') or (FileExt = '.bas') then
    Result := ftVB
  else
    Result := ftText
end;

function GetFileVersion(Path: string): string;
var
  VerInfo: Pointer;
  VerValue: PVSFixedFileInfo;
  InfoSize: Cardinal;
  ValueSize: Cardinal;
  Dummy: Cardinal;
  TempPath: PChar;
begin
  if Trim(Path) = EmptyStr then
    TempPath := PChar(ParamStr(0))
  else
    TempPath := PChar(Path);

  InfoSize := GetFileVersionInfoSize(TempPath, Dummy);

  if InfoSize = 0 then
  begin
    Result := LanguageDataModule.GetConstant('VersionInfoNotFound');
    Exit;
  end;

  GetMem(VerInfo, InfoSize);
  GetFileVersionInfo(TempPath, 0, InfoSize, VerInfo);
  VerQueryValue(VerInfo, '\', pointer(VerValue), ValueSize);

  with VerValue^ do
    Result := Format('%d.%d.%d', [dwFileVersionMS shr 16, dwFileVersionMS and $FFFF,
      dwFileVersionLS shr 16]);
  FreeMem(VerInfo, InfoSize);
end;

function GetFileNamesFromFolder(Folder: string): TStrings;
var
  SearchRec: TSearchRec;
begin
  Result := TStringList.Create;
  if FindFirst(AddSlash(Folder) + '*.*', faAnyFile, SearchRec) = 0 then
  begin
    repeat
      if SearchRec.Attr <> faDirectory then
        Result.Add(AddSlash(Folder) + SearchRec.Name);
    until FindNext(SearchRec) <> 0;
    System.SysUtils.FindClose(SearchRec);
  end;
end;

function GetINIFilename: string;
begin
  Result := ChangeFileExt(Application.EXEName, '.ini');
end;

end.
