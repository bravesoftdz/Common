unit BCCommon.FileUtils;

interface

uses
  Winapi.Windows, System.Classes;

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
function GetIconIndex(Path: string; Flags: Cardinal = 0): Integer;
function GetINIFilename: string;
function FileIconInit(FullInit: BOOL): BOOL; stdcall;
function IsExtInFileType(Ext: string; FileType: string): Boolean;

implementation

uses
  System.SysUtils, Winapi.ShellAPI, BCCommon.LanguageStrings, BCCommon.StringUtils, Vcl.Forms;

function GetIconIndex(Path: string; Flags: Cardinal): Integer;
var
  SHFileInfo: TSHFileInfo;
begin
  if SHGetFileInfo(PChar(Path), 0, SHFileInfo, SizeOf(SHFileInfo), SHGFI_SYSICONINDEX or SHGFI_SMALLICON or Flags) = 0 then
    Result := -1
  else
    Result := SHFileInfo.iIcon;
end;

function FileIconInit(FullInit: BOOL): BOOL; stdcall;
type
  TFileIconInit = function(FullInit: BOOL): BOOL; stdcall;
var
  ShellDLL: HMODULE;
  PFileIconInit: TFileIconInit;
begin
  Result := False;
  if Win32Platform = VER_PLATFORM_WIN32_NT then
  begin
    ShellDLL := LoadLibrary(PChar('shell32.dll'));
    PFileIconInit := GetProcAddress(ShellDLL, PChar(660));
    if Assigned(PFileIconInit) then
      Result := PFileIconInit(FullInit);
  end;
end;

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
    Result := System.Copy(Result, 0, Length(Result) - 1);
  if Modified then
    Result := Format('%s~', [Result]);
end;

end.
