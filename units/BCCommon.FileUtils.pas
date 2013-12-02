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

const
  FILE_READ_DATA         = $0001; // file & pipe
  FILE_LIST_DIRECTORY    = $0001; // directory
  FILE_WRITE_DATA        = $0002; // file & pipe
  FILE_ADD_FILE          = $0002; // directory
  FILE_APPEND_DATA       = $0004; // file
  FILE_ADD_SUBDIRECTORY  = $0004; // directory
  FILE_CREATE_PIPE_INSTANCE = $0004; // named pipe
  FILE_READ_EA           = $0008; // file & directory
  FILE_WRITE_EA          = $0010; // file & directory
  FILE_EXECUTE           = $0020; // file
  FILE_TRAVERSE          = $0020; // directory
  FILE_DELETE_CHILD      = $0040; // directory
  FILE_READ_ATTRIBUTES   = $0080; // all
  FILE_WRITE_ATTRIBUTES  = $0100; // all
  FILE_ALL_ACCESS        = STANDARD_RIGHTS_REQUIRED or SYNCHRONIZE or $1FF;
  FILE_GENERIC_READ      = STANDARD_RIGHTS_READ or FILE_READ_DATA or FILE_READ_ATTRIBUTES or FILE_READ_EA or SYNCHRONIZE;
  FILE_GENERIC_WRITE     = STANDARD_RIGHTS_WRITE or FILE_WRITE_DATA or FILE_WRITE_ATTRIBUTES or FILE_WRITE_EA or
    FILE_APPEND_DATA or SYNCHRONIZE;
  FILE_GENERIC_EXECUTE   = STANDARD_RIGHTS_EXECUTE or FILE_READ_ATTRIBUTES or FILE_EXECUTE or SYNCHRONIZE;

  function FormatFileName(FileName: string; Modified: Boolean = False): string;
  function GetFileDateTime(FileName: string): TDateTime;
  function GetFileNamesFromFolder(Folder: string; FileType: string = ''): TStrings;
  function GetFileType(FileName: string): TFileType;
  function GetFileVersion(Path: string): string;
  function GetIconIndex(Path: string; Flags: Cardinal = 0): Integer;
  function GetIniFilename: string;
  function GetOutFilename: string;
  function FileIconInit(FullInit: BOOL): BOOL; stdcall;
  function IsExtInFileType(Ext: string; FileType: string): Boolean;
  function CheckAccessToFile(DesiredAccess: DWORD; const FileName: WideString): Boolean;
  function RemoveDirectory(const Directory: String): Boolean;

implementation

uses
  System.SysUtils, Winapi.ShellAPI, BCCommon.LanguageStrings, Vcl.Forms;

function RemoveDirectory(const Directory: String): Boolean;
var
  s: String;
  Rec: TSearchRec;
begin
  Result := True;
  {$WARNINGS OFF} { IncludeTrailingPathDelimiter is specific to a platform }
  s := IncludeTrailingPathDelimiter(Directory);
  {$WARNINGS ON}
  if FindFirst(s + '*.*', faAnyFile, Rec) = 0 then
  try
    repeat
      if (Rec.Attr and faDirectory) = faDirectory then
      begin
        if (Rec.Name <> '.') and (Rec.Name <> '..') then
          RemoveDirectory(s + Rec.Name);
      end
      else
        Result := DeleteFile(s + Rec.Name);
    until Result and (FindNext(Rec) <> 0);
  finally
    FindClose(Rec);
  end;
  if Result then
    Result := RemoveDir(s);
end;

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

function GetFileDateTime(FileName: string): TDateTime;
var
  SearchRec: TSearchRec;
begin
  FindFirst(FileName, faAnyFile, SearchRec);
  Result := SearchRec.TimeStamp;
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
  if FindFirst(IncludeTrailingBackslash(Folder) + '*.*', faAnyFile - faHidden, SearchRec) = 0 then
  {$WARNINGS ON}
  begin
    repeat
      if SearchRec.Attr <> faDirectory then
        if (FileType = '') or (FileType = '*.*') or
          ((FileType <> '') and IsExtInFileType(ExtractFileExt(SearchRec.Name), FileType)) then
          {$WARNINGS OFF} { IncludeTrailingBackslash is specific to a platform }
          Result.Add(IncludeTrailingBackslash(Folder) + SearchRec.Name);
          {$WARNINGS ON}
    until FindNext(SearchRec) <> 0;
    System.SysUtils.FindClose(SearchRec);
  end;
end;

function GetIniFilename: string;
begin
  Result := ChangeFileExt(Application.EXEName, '.ini');
end;

function GetOutFilename: string;
begin
  Result := ChangeFileExt(Application.EXEName, '.out');
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

function CheckAccessToFile(DesiredAccess: DWORD; const FileName: WideString): Boolean;
const
  GenericFileMapping     : TGenericMapping = (
    GenericRead: FILE_GENERIC_READ;
    GenericWrite: FILE_GENERIC_WRITE;
    GenericExecute: FILE_GENERIC_EXECUTE;
    GenericAll: FILE_ALL_ACCESS
    );
var
  LastError              : DWORD;
  LengthNeeded           : DWORD;
  SecurityDescriptor     : PSecurityDescriptor;
  ClientToken            : THandle;
  AccessMask             : DWORD;
  PrivilegeSet           : TPrivilegeSet;
  PrivilegeSetLength     : DWORD;
  GrantedAccess          : DWORD;
  AccessStatus           : BOOL;
begin
  Result := False;
  LastError := GetLastError;
  if not GetFileSecurityW(PWideChar(FileName), OWNER_SECURITY_INFORMATION or
    GROUP_SECURITY_INFORMATION or DACL_SECURITY_INFORMATION, nil, 0,
    LengthNeeded) and (GetLastError <> ERROR_INSUFFICIENT_BUFFER) then
    Exit;
  SetLastError(LastError);
  Inc(LengthNeeded, $1000);
  SecurityDescriptor := PSecurityDescriptor(LocalAlloc(LPTR, LengthNeeded));
  if not Assigned(SecurityDescriptor) then
    Exit;
  try
    if not GetFileSecurityW(PWideChar(FileName), OWNER_SECURITY_INFORMATION or
      GROUP_SECURITY_INFORMATION or DACL_SECURITY_INFORMATION,
      SecurityDescriptor, LengthNeeded, LengthNeeded) then
      Exit;
    if not ImpersonateSelf(SecurityImpersonation) then
      Exit;
    try
      if not OpenThreadToken(GetCurrentThread, TOKEN_QUERY or
        TOKEN_IMPERSONATE or TOKEN_DUPLICATE, False, ClientToken) then
        Exit;
      try
        AccessMask := DesiredAccess;
        MapGenericMask(AccessMask, GenericFileMapping);
        PrivilegeSetLength := SizeOf(TPrivilegeSet);
        if AccessCheck(SecurityDescriptor, ClientToken, AccessMask,
          GenericFileMapping, PrivilegeSet, PrivilegeSetLength, GrantedAccess,
          AccessStatus) then
          Result := AccessStatus;
      finally
        CloseHandle(ClientToken);
      end;
    finally
      RevertToSelf;
    end;
  finally
    LocalFree(HLOCAL(SecurityDescriptor));
  end;
end;

end.
