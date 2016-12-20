unit BCCommon.FileUtils;

interface

uses
  Winapi.Windows, System.Classes, System.Types;

function CountFilesInFolder(const AFolderText: string; const AFileTypeText: string; const AFileExtensions: string): Integer;
function DisplayContextMenu(const AHandle: THandle; const AFileName: string; APos: TPoint): Boolean;
function FormatFileName(const AFileName: string; const AModified: Boolean = False): string;
function GetClipboardHistoryFileName: string;
function GetColorLoadFileName(const AFileName: string): string;
function GetColorSaveFileName(const AOwner: TComponent; const AFileName: string): string;
function GetFileDateTime(const AFileName: string): TDateTime;
function GetFileNamesFromFolder(const Folder: string; const FileType: string = ''): TStrings;
function GetFiles(const APath, AMasks: string; const ALookInSubfolders: Boolean): TStringDynArray;
function GetFileVersion(const AFileName: string): string;
function GetHighlighters: TStringList;
function GetHighlighterColors: TStringList;
function GetOldIniFileName: string;
function GetOldOutFileName: string;
function GetIniFileName: string;
function GetUniIniFileName: string;
function GetOutFileName: string;
function GetUserAppDataPath(const AAppName: string): string;
function GetSQLFormatterDLLFileName: string;
function IsOriginalColor(const AColorName: string): Boolean;
function IsVirtualDrive(ADrive: Char): Boolean;
function SystemDir: string;
function VirtualDrivePath(const ADrive: Char): string;
procedure CreateVirtualDrive(const ADrive: Char; const APath: string);
procedure DeleteVirtualDrive(const ADrive: Char);
procedure FilePropertiesDialog(const AFileName: string);

var
  GApplicationIniPath: Boolean;

implementation

uses
  Winapi.ShellAPI, Winapi.ShlObj, Winapi.ActiveX, Winapi.Messages, System.SysUtils, System.AnsiStrings, Vcl.Forms,
  BCCommon.Language.Strings, BCControl.Utils, System.IOUtils, System.StrUtils, System.Masks, System.Math, sDialogs;

const
  AppDataFolder = '/';

function GetSpecialFolderPath(const AFolder: Integer; const APath: string = ''): string;
const
  SHGFP_TYPE_CURRENT = 0;
var
  LPath: array [0 .. MAX_PATH + 1] of Char;
begin
  if not Succeeded(SHGetFolderPath(0, AFolder, 0, SHGFP_TYPE_CURRENT, @LPath[0])) then
    raise Exception.Create('Path is missing.')
  else
  begin
    Result := LPath;
    if APath <> '' then
      Result := IncludeTrailingPathDelimiter(Result) + APath;

    if not System.SysUtils.DirectoryExists(Result) then
      if not System.SysUtils.ForceDirectories(Result) then
        raise Exception.Create('Can''t create path ' + Result);
  end;
end;

function GetUserAppDataPath(const AAppName: string): string;
begin
  Result := IncludeTrailingPathDelimiter(GetSpecialFolderPath(CSIDL_LOCAL_APPDATA, IncludeTrailingPathDelimiter(AAppName)));
end;

function DriveToPidlBind(const DriveName: string; out Folder: IShellFolder): PItemIdList;
var
  LAttributes, LChEaten: ULONG;
  LDesktopFolder: IShellFolder;
  LDrivesIdList: PItemIdList;
  LPath: PChar;
begin
  Result := nil;
  if Succeeded(SHGetDesktopFolder(LDesktopFolder)) then
  begin
    if Succeeded(SHGetSpecialFolderLocation(0, CSIDL_DRIVES, LDrivesIdList)) then
    begin
      if Succeeded(LDesktopFolder.BindToObject(LDrivesIdList, nil, IID_IShellFolder, Pointer(Folder))) then
      begin
        LPath := PChar(IncludeTrailingPathDelimiter(DriveName));
        LAttributes := 0;
        if Failed(Folder.ParseDisplayName(0, nil, LPath, LChEaten, Result, LAttributes)) then
        begin
          Folder := nil;
          // Failure probably means that this is not a drive. However, do not
          // call PathToPidlBind() because it may cause infinite recursion.
        end;
      end;
    end;
    CoTaskMemFree(LDrivesIdList);
  end;
end;

function PidlFree(var AIdList: PItemIdList): Boolean;
var
  Malloc: IMalloc;
begin
  Result := False;
  if not Assigned(AIdList) then
    Result := True
  else
  begin
    Malloc := nil;
    if Succeeded(SHGetMalloc(Malloc)) and (Malloc.DidAlloc(AIdList) > 0) then
    begin
      Malloc.Free(AIdList);
      AIdList := nil;
      Result := True;
    end;
  end;
end;

function PathToPidlBind(const AFileName: string; out AFolder: IShellFolder): PItemIdList;
var
  LAttributes, LChEaten: ULONG;
  LPathIdList: PItemIdList;
  LDesktopFolder: IShellFolder;
  LPath, LItemName: PWideChar;
begin
  Result := nil;
  LPath := PChar(ExtractFilePath(AFileName));
  LItemName := PChar(ExtractFileName(AFileName));

  if Succeeded(SHGetDesktopFolder(LDesktopFolder)) then
  begin
    LAttributes := 0;
    if Succeeded(LDesktopFolder.ParseDisplayName(0, nil, LPath, LChEaten, LPathIdList, LAttributes)) then
    begin
      if Succeeded(LDesktopFolder.BindToObject(LPathIdList, nil, IID_IShellFolder, Pointer(AFolder))) then
        if Failed(AFolder.ParseDisplayName(0, nil, LItemName, LChEaten, Result, LAttributes)) then
        begin
          AFolder := nil;
          Result := DriveToPidlBind(AFileName, AFolder);
        end;
      PidlFree(LPathIdList);
    end
    else
      Result := DriveToPidlBind(AFileName, AFolder);
  end;
end;

procedure ResetMemory(out AWndClass; AWndClassSize: Longint);
begin
  if AWndClassSize > 0 then
  begin
    Byte(AWndClass) := 0;
    FillChar(AWndClass, AWndClassSize, 0);
  end;
end;

function MenuCallback(Wnd: THandle; Msg: UINT; wParam: wParam; lParam: lParam): LRESULT; stdcall;
var
  LContextMenu2: IContextMenu2;
begin
  case Msg of
    WM_CREATE:
      begin
        LContextMenu2 := IContextMenu2(PCreateStruct(lParam).lpCreateParams);
        SetWindowLongPtr(Wnd, GWLP_USERDATA, LONG_PTR(LContextMenu2));
        Result := DefWindowProc(Wnd, Msg, wParam, lParam);
      end;
    WM_INITMENUPOPUP:
      begin
        LContextMenu2 := IContextMenu2(GetWindowLongPtr(Wnd, GWLP_USERDATA));
        LContextMenu2.HandleMenuMsg(Msg, wParam, lParam);
        Result := 0;
      end;
    WM_DRAWITEM, WM_MEASUREITEM:
      begin
        LContextMenu2 := IContextMenu2(GetWindowLongPtr(Wnd, GWLP_USERDATA));
        LContextMenu2.HandleMenuMsg(Msg, wParam, lParam);
        Result := 1;
      end;
  else
    Result := DefWindowProc(Wnd, Msg, wParam, lParam);
  end;
end;

function CreateMenuCallbackWnd(const AContextMenu: IContextMenu2): THandle;
const
  IcmCallbackWnd = 'ICMCALLBACKWND';
var
  LWndClass: TWndClass;
begin
  ResetMemory(LWndClass, SizeOf(LWndClass));
  LWndClass.lpszClassName := PChar(IcmCallbackWnd);
  LWndClass.lpfnWndProc := @MenuCallback;
  LWndClass.hInstance := hInstance;
  Winapi.Windows.RegisterClass(LWndClass);
  Result := CreateWindow(IcmCallbackWnd, IcmCallbackWnd, WS_POPUPWINDOW, 0, 0, 0, 0, 0, 0, hInstance,
    Pointer(AContextMenu));
end;

function DisplayContextMenuPidl(const AHandle: THandle; const AFolder: IShellFolder; AItem: PItemIdList;
  Pos: TPoint): Boolean;
var
  LCommand: Cardinal;
  LContextMenu: IContextMenu;
  LContextMenu2: IContextMenu2;
  LMenu: HMENU;
  LCommandInfo: TCMInvokeCommandInfo;
  LCallbackWindow: THandle;
begin
  Result := False;
  if not Assigned(AItem) or not Assigned(AFolder) then
    Exit;
  AFolder.GetUIObjectOf(AHandle, 1, AItem, IID_IContextMenu, nil, Pointer(LContextMenu));
  if LContextMenu <> nil then
  begin
    LMenu := CreatePopupMenu;
    if LMenu <> 0 then
    begin
      if Succeeded(LContextMenu.QueryContextMenu(LMenu, 0, 1, $7FFF, CMF_EXPLORE)) then
      begin
        LCallbackWindow := 0;
        if Succeeded(LContextMenu.QueryInterface(IContextMenu2, LContextMenu2)) then
          LCallbackWindow := CreateMenuCallbackWnd(LContextMenu2);
        ClientToScreen(AHandle, Pos);
        LCommand := Cardinal(TrackPopupMenu(LMenu, TPM_LEFTALIGN or TPM_LEFTBUTTON or TPM_RIGHTBUTTON or TPM_RETURNCMD, Pos.X,
          Pos.Y, 0, LCallbackWindow, nil));
        if LCommand <> 0 then
        begin
          ResetMemory(LCommandInfo, SizeOf(LCommandInfo));
          LCommandInfo.cbSize := SizeOf(TCMInvokeCommandInfo);
          LCommandInfo.hwnd := AHandle;
          LCommandInfo.lpVerb := MakeIntResourceA(LCommand - 1);
          LCommandInfo.nShow := SW_SHOWNORMAL;
          Result := Succeeded(LContextMenu.InvokeCommand(LCommandInfo));
        end;
        if LCallbackWindow <> 0 then
          DestroyWindow(LCallbackWindow);
      end;
      DestroyMenu(LMenu);
    end;
  end;
end;

function DisplayContextMenu(const AHandle: THandle; const AFileName: string; APos: TPoint): Boolean;
var
  LItemIdList: PItemIdList;
  LFolder: IShellFolder;
begin
  Result := False;
  LItemIdList := PathToPidlBind(AFileName, LFolder);
  if LItemIdList <> nil then
  begin
    Result := DisplayContextMenuPidl(AHandle, LFolder, LItemIdList, APos);
    PidlFree(LItemIdList);
  end;
end;

function GetColorLoadFileName(const AFileName: string): string;
begin
  Result := Format('%sColors\%s.json', [ExtractFilePath(Application.ExeName), AFileName]);
end;

function IsOriginalColor(const AColorName: string): Boolean;
begin
  Result := (AColorName = 'Blue') or (AColorName = 'Classic') or (AColorName = 'Default') or (AColorName = 'Monokai') or
    (AColorName = 'Ocean') or (AColorName = 'Purple') or (AColorName = 'Twilight') or (AColorName = 'Visual Studio [TM]')
end;

function GetColorSaveFileName(const AOwner: TComponent; const AFileName: string): string;
var
  LSaveDialog: TsSaveDialog;
begin
  Result := Format('%sColors\%s.json', [ExtractFilePath(Application.ExeName), AFileName]);
  if IsOriginalColor(AFileName) then
  begin
    LSaveDialog := TsSaveDialog.Create(AOwner);
    LSaveDialog.Filter := Trim(StringReplace(LanguageDataModule.GetFileTypes('JSON'), '|', #0, [rfReplaceAll])) + #0#0;
    LSaveDialog.Title := LanguageDataModule.GetConstant('SaveAs');
    LSaveDialog.InitialDir := Format('%sColors\', [ExtractFilePath(Application.ExeName)]);
    try
      if LSaveDialog.Execute then
        Result := ChangeFileExt(LSaveDialog.FileName, '.json');
    finally
      LSaveDialog.Free;
    end;
  end
end;

function GetFiles(const APath, AMasks: string; const ALookInSubfolders: Boolean): TStringDynArray;
var
  LMaskArray: TStringDynArray;
  LPredicate: TDirectory.TFilterPredicate;
  LSearchOption: TSearchOption;
begin
  if ALookInSubfolders then
    LSearchOption := System.IOUtils.TSearchOption.soAllDirectories
  else
    LSearchOption := System.IOUtils.TSearchOption.soTopDirectoryOnly;

  LMaskArray := SplitString(AMasks, ';');
  LPredicate :=
    function(const APath: string; const ASearchRec: TSearchRec): Boolean
    var
      LMask: string;
    begin
      for LMask in LMaskArray do
        if MatchesMask(ASearchRec.Name, LMask) then
          Exit(True);
      Exit(False);
    end;
  Result := TDirectory.GetFiles(APath, LSearchOption, LPredicate);
end;

function CountFilesInFolder(const AFolderText: string; const AFileTypeText: string; const AFileExtensions: string): Integer;
var
  LName: string;
begin
  Result := 0;
  for LName in GetFiles(AFolderText, AFileTypeText, True) do
  if (AFileExtensions = '*.*') or
    (AFileTypeText = '*.*') and IsExtInFileType(ExtractFileExt(LName), AFileExtensions) or
    IsExtInFileType(ExtractFileExt(LName), AFileTypeText) then
    Inc(Result);
end;

function GetFileDateTime(const AFileName: string): TDateTime;
var
  LSearchRec: TSearchRec;
begin
  FindFirst(AFileName, faAnyFile, LSearchRec);
  Result := LSearchRec.TimeStamp;
end;

function GetFileVersion(const AFileName: string): string;
var
  LVersionInfo: Pointer;
  LFixedFileInfo: PVSFixedFileInfo;
  LInfoSize: Cardinal;
  LValueSize: Cardinal;
  LDummy: Cardinal;
  LTempPath: PChar;
begin
  if Trim(AFileName) = EmptyStr then
    LTempPath := PChar(ParamStr(0))
  else
    LTempPath := PChar(AFileName);

  LInfoSize := GetFileVersionInfoSize(LTempPath, LDummy);

  if LInfoSize = 0 then
    Exit(LanguageDataModule.GetConstant('VersionInfoNotFound'));

  GetMem(LVersionInfo, LInfoSize);
  GetFileVersionInfo(LTempPath, 0, LInfoSize, LVersionInfo);
  VerQueryValue(LVersionInfo, '\', Pointer(LFixedFileInfo), LValueSize);

  with LFixedFileInfo^ do
    Result := Format('%d.%d.%d', [dwFileVersionMS shr 16, dwFileVersionMS and $FFFF, dwFileVersionLS shr 16]);
  FreeMem(LVersionInfo, LInfoSize);
end;

function GetFileNamesFromFolder(const Folder: string; const FileType: string): TStrings;
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

function GetOldIniFileName: string;
begin
  Result := ChangeFileExt(Application.EXEName, '.ini');
end;

function GetOldOutFileName: string;
begin
  Result := ChangeFileExt(Application.EXEName, '.out');
end;

function GetAppName: string;
begin
  {$ifdef EDITBONE}
  Result := 'EditBone';
  {$endif}
end;

function GetClipboardHistoryFileName: string;
begin
  if GApplicationIniPath then
    Result := ChangeFileExt(Application.EXEName, 'ClipboardHistory.ini')
  else
    Result := GetUserAppDataPath(GetAppName) + ChangeFileExt(ExtractFileName(Application.EXEName), 'ClipboardHistory.ini');
end;

function GetIniFileName: string;
begin
  if GApplicationIniPath then
    Result := ChangeFileExt(Application.EXEName, '.ini')
  else
    Result := GetUserAppDataPath(GetAppName) + ChangeFileExt(ExtractFileName(Application.EXEName), '.ini');
end;

function GetUniIniFileName: string;
begin
  if GApplicationIniPath then
    Result := ChangeFileExt(Application.EXEName, 'Uni.ini')
  else
    Result := GetUserAppDataPath(GetAppName) + ChangeFileExt(ExtractFileName(Application.EXEName), 'Uni.ini');
end;

function GetOutFileName: string;
begin
  if GApplicationIniPath then
    Result := ChangeFileExt(Application.EXEName, '.out')
  else
    Result := GetUserAppDataPath(GetAppName) + ChangeFileExt(ExtractFileName(Application.EXEName), '.out');
end;

function GetSQLFormatterDLLFileName: string;
begin
{$WARNINGS OFF} { IncludeTrailingPathDelimiter is specific to a platform }
  Result := IncludeTrailingPathDelimiter(ExtractFilePath(Application.EXEName)) + 'SQLFormatter.dll';
{$WARNINGS ON}
end;

function FormatFileName(const AFileName: string; const AModified: Boolean): string;
begin
  Result := Trim(AFileName);
  if Pos('~', Result, Max(Pos('.', Result), 1)) = Length(Result) then
    Result := System.Copy(Result, 0, Length(Result) - 1);
  if AModified then
    Result := Format('%s~', [Result]);
end;

function IsVirtualDrive(ADrive: Char): Boolean;
var
  LDeviceName, LTargetPath: string;
begin
  LTargetPath := ADrive + ':';
  SetLength(LDeviceName, Max_Path + 1);
  SetLength(LDeviceName, QueryDosDevice(PChar(LTargetPath), PChar(LDeviceName), Length(LDeviceName)));
  Result := Pos('\??\', LDeviceName) = 1;
end;

function VirtualDrivePath(const ADrive: Char): string;
var
  LDeviceName, LTargetPath: string;
begin
  LTargetPath := ADrive + ':';
  SetLength(LDeviceName, Max_Path + 1);
  SetLength(LDeviceName, QueryDosDevice(PChar(LTargetPath), PChar(LDeviceName), Length(LDeviceName)));
  if Pos('\??\', LDeviceName) = 1 then
    Result := Trim(Copy(LDeviceName, 5, Length(LDeviceName)))
  else
    Result := '';
end;

function SystemDir: string;
begin
  SetLength(Result, Max_Path);
  GetSystemDirectory(@Result[1], Max_Path);
end;

procedure CreateVirtualDrive(const ADrive: Char; const APath: string);
var
  LParam: string;
begin
  LParam := Format('%s: "%s"', [ADrive, APath]);
  ShellExecute(1, nil, 'subst', PChar(LParam), PChar(SystemDir), SW_HIDE);
end;

procedure DeleteVirtualDrive(const ADrive: Char);
var
  LParam: string;
begin
  LParam := Format('%s: /d', [ADrive]);
  ShellExecute(1, nil, 'subst', PChar(LParam), PChar(SystemDir), SW_HIDE);
end;

procedure FilePropertiesDialog(const AFileName: string);
var
  LShellExecuteInfo: TShellExecuteInfo;
begin
  if AFileName = '' then
    Exit;
  FillChar(LShellExecuteInfo, SizeOf(LShellExecuteInfo), 0);
  LShellExecuteInfo.cbSize := SizeOf(LShellExecuteInfo);
  LShellExecuteInfo.lpFile := PChar(AFileName);
  LShellExecuteInfo.lpVerb := 'properties';
  LShellExecuteInfo.fMask  := SEE_MASK_INVOKEIDLIST;
  ShellExecuteEx(@LShellExecuteInfo);
end;

function GetHighlighters: TStringList;
var
  LFileName, LName: string;
begin
  Result := TStringList.Create;
  for LFileName in GetFiles(ExtractFilePath(Application.ExeName) + '\Highlighters\', '*.json', False) do
  begin
    LName := ChangeFileExt(ExtractFileName(LFileName), '');
    Result.Add(LName);
  end;
end;

function GetHighlighterColors: TStringList;
var
  LFileName, LName: string;
begin
  Result := TStringList.Create;
  for LFileName in GetFiles(ExtractFilePath(Application.ExeName) + '\Colors\', '*.json', False) do
  begin
    LName := ChangeFileExt(ExtractFileName(LFileName), '');
    Result.Add(LName);
  end;
end;

end.
