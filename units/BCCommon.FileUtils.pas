unit BCCommon.FileUtils;

interface

uses
  System.Classes;

type
  TFileType = (ftHC11, ftAWK, ftBaan, ftCS, ftCPP, ftCAC, ftCache, ftCss, ftCobol, ftIdl,
    ftCPM, ftDOT, ftADSP21xx, ftDWScript, ftEiffel, ftFortran, ftFoxpro, ftGalaxy, ftDml, ftGWScript, ftHaskell,
    ftHP48, ftHTML, ftIni, ftInno, ftJava, ftJScript, ftKix, ftLDR, ftLLVM, ftModelica, ftM3,
    ftMsg, ftBat, ftPas, ftPerl, ftPHP, ftProgress, ftPython, ftRC, ftRuby, ftSDD,
    ftSQL, ftSML, ftST, ftTclTk, ftTeX, ftText, ftUNIXShellScript, ftVB, ftVBScript, ftVrml97,
    ftWebIDL, ftAsm, ftXML, ftYAML);

function FormatFileName(FileName: string; Modified: Boolean = False): string;
function GetFileNamesFromFolder(Folder: string; FileType: string = ''): TStrings;
function GetFileType(FileName: string): TFileType;
function GetFileVersion(Path: string): string;
function GetINIFilename: string;
function IsExtInFileType(Ext: string; FileType: string): Boolean;

implementation

uses
  System.SysUtils, Winapi.Windows, BCCommon.LanguageStrings, BCCommon.StringUtils, Vcl.Forms;

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

function GetFileNamesFromFolder(Folder: string; FileType: string): TStrings;
var
  SearchRec: TSearchRec;
begin
  Result := TStringList.Create;
  {$WARNINGS OFF} { faHidden is specific to a platform }
  if FindFirst(AddSlash(Folder) + '*.*', faAnyFile - faHidden, SearchRec) = 0 then
  {$WARNINGS ON}
  begin
    repeat
      if SearchRec.Attr <> faDirectory then
        if (FileType = '') or (FileType = '*.*') or
          ((FileType <> '') and IsExtInFileType(ExtractFileExt(SearchRec.Name), FileType)) then
          Result.Add(AddSlash(Folder) + SearchRec.Name);
    until FindNext(SearchRec) <> 0;
    System.SysUtils.FindClose(SearchRec);
  end;
end;

function GetINIFilename: string;
begin
  Result := ChangeFileExt(Application.EXEName, '.ini');
end;

function IsExtInFileType(Ext: string; FileType: string): Boolean;
var
  s, FileTypes: string;
begin
  Ext := '*' + Ext;
  FileTypes := FileType;
  if Pos(';', FileTypes) <> 0 then
    while Pos(';', FileTypes) <> 0 do
    begin
      s := System.Copy(FileTypes, 1,  Pos(';', FileTypes) - 1);
      Result := LowerCase(Ext) = LowerCase(s);
      if Result then
        Exit;
      FileTypes := System.Copy(FileTypes, Pos(';', FileTypes) + 1, Length(FileTypes));
    end;
  Result := LowerCase(Ext) = LowerCase(FileTypes);
end;

function FormatFileName(FileName: string; Modified: Boolean): string;
begin
  Result := Trim(FileName);
  if Pos('~', Result) = Length(Result) then
    Result := System.Copy(FileName, 0, Length(FileName) - 1);
  if Modified then
    Result := Format('%s~', [Result]);
end;

end.
