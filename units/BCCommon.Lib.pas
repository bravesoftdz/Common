unit BCCommon.Lib;

interface

uses
  Winapi.Windows, System.Classes, Vcl.ActnMenus, System.Types, BCControls.StringGrid, BCControls.ComboBox;

const
  CHR_ENTER = Chr(13) + Chr(10);
  CHR_DOUBLE_ENTER = CHR_ENTER + CHR_ENTER;
  CHR_TAB = '  ';

  BONECODE_URL = 'http://www.bonecode.com';

  OUTPUT_FILE_SEPARATOR = '@#/%&';

  TAnimationStyleStr: array[Low(TAnimationStyle)..High(TAnimationStyle)] of String = ('None',
    'Default', 'Unfold', 'Slide', 'Fade');
  TSynEditCaretTypeStr: array[0..3] of String =
    ('Vertical Line', 'Horizontal Line', 'Half Block', 'Block');

  ShortCuts: array[0..108] of TShortCut = (
    scNone,
    Byte('A') or scCtrl,
    Byte('B') or scCtrl,
    Byte('C') or scCtrl,
    Byte('D') or scCtrl,
    Byte('E') or scCtrl,
    Byte('F') or scCtrl,
    Byte('G') or scCtrl,
    Byte('H') or scCtrl,
    Byte('I') or scCtrl,
    Byte('J') or scCtrl,
    Byte('K') or scCtrl,
    Byte('L') or scCtrl,
    Byte('M') or scCtrl,
    Byte('N') or scCtrl,
    Byte('O') or scCtrl,
    Byte('P') or scCtrl,
    Byte('Q') or scCtrl,
    Byte('R') or scCtrl,
    Byte('S') or scCtrl,
    Byte('T') or scCtrl,
    Byte('U') or scCtrl,
    Byte('V') or scCtrl,
    Byte('W') or scCtrl,
    Byte('X') or scCtrl,
    Byte('Y') or scCtrl,
    Byte('Z') or scCtrl,
    Byte('A') or scCtrl or scAlt,
    Byte('B') or scCtrl or scAlt,
    Byte('C') or scCtrl or scAlt,
    Byte('D') or scCtrl or scAlt,
    Byte('E') or scCtrl or scAlt,
    Byte('F') or scCtrl or scAlt,
    Byte('G') or scCtrl or scAlt,
    Byte('H') or scCtrl or scAlt,
    Byte('I') or scCtrl or scAlt,
    Byte('J') or scCtrl or scAlt,
    Byte('K') or scCtrl or scAlt,
    Byte('L') or scCtrl or scAlt,
    Byte('M') or scCtrl or scAlt,
    Byte('N') or scCtrl or scAlt,
    Byte('O') or scCtrl or scAlt,
    Byte('P') or scCtrl or scAlt,
    Byte('Q') or scCtrl or scAlt,
    Byte('R') or scCtrl or scAlt,
    Byte('S') or scCtrl or scAlt,
    Byte('T') or scCtrl or scAlt,
    Byte('U') or scCtrl or scAlt,
    Byte('V') or scCtrl or scAlt,
    Byte('W') or scCtrl or scAlt,
    Byte('X') or scCtrl or scAlt,
    Byte('Y') or scCtrl or scAlt,
    Byte('Z') or scCtrl or scAlt,
    VK_F1,
    VK_F2,
    VK_F3,
    VK_F4,
    VK_F5,
    VK_F6,
    VK_F7,
    VK_F8,
    VK_F9,
    VK_F10,
    VK_F11,
    VK_F12,
    VK_F1 or scCtrl,
    VK_F2 or scCtrl,
    VK_F3 or scCtrl,
    VK_F4 or scCtrl,
    VK_F5 or scCtrl,
    VK_F6 or scCtrl,
    VK_F7 or scCtrl,
    VK_F8 or scCtrl,
    VK_F9 or scCtrl,
    VK_F10 or scCtrl,
    VK_F11 or scCtrl,
    VK_F12 or scCtrl,
    VK_F1 or scShift,
    VK_F2 or scShift,
    VK_F3 or scShift,
    VK_F4 or scShift,
    VK_F5 or scShift,
    VK_F6 or scShift,
    VK_F7 or scShift,
    VK_F8 or scShift,
    VK_F9 or scShift,
    VK_F10 or scShift,
    VK_F11 or scShift,
    VK_F12 or scShift,
    VK_F1 or scShift or scCtrl,
    VK_F2 or scShift or scCtrl,
    VK_F3 or scShift or scCtrl,
    VK_F4 or scShift or scCtrl,
    VK_F5 or scShift or scCtrl,
    VK_F6 or scShift or scCtrl,
    VK_F7 or scShift or scCtrl,
    VK_F8 or scShift or scCtrl,
    VK_F9 or scShift or scCtrl,
    VK_F10 or scShift or scCtrl,
    VK_F11 or scShift or scCtrl,
    VK_F12 or scShift or scCtrl,
    VK_INSERT,
    VK_INSERT or scShift,
    VK_INSERT or scCtrl,
    VK_DELETE,
    VK_DELETE or scShift,
    VK_DELETE or scCtrl,
    VK_BACK or scAlt,
    VK_BACK or scShift or scAlt);

function BrowseURL(const URL: string): Boolean;
function GetAppVersion(const Url:string):string;
function GetOSInfo: string;
function PointInRect(const P: TPoint; const R: TRect): Boolean;
procedure AutoSizeCol(Grid: TBCStringGrid; StartCol: Integer = 0);
procedure CheckForUpdates(AppName: string; AboutVersion: string);
procedure InsertTextToCombo(ComboBox: TBCComboBox);
procedure RunCommand(const Cmd, Params: String);
function SetFormInsideWorkArea(Left, Width: Integer): Integer;

implementation

uses
  System.SysUtils, System.IOUtils, Winapi.ShellApi, Winapi.WinInet, System.StrUtils, Vcl.Forms,
  System.UITypes, BCCommon.Messages, BCCommon.LanguageStrings, BCDialogs.DownloadURL;

function BrowseURL(const URL: string): Boolean;
var
  TempFileName: string;
  Path: array[0..255] of char;
  //tmp : PChar;
begin
  Result := True;
  //tmp := StrAlloc(255);
  //GetTempPath(255, tmp);
  TempFileName := Format('%s%s', [TPath.GetTempPath, 'bonecode-default.html']);
  CloseHandle(CreateFile(PWideChar(TempFileName), GENERIC_WRITE, FILE_SHARE_WRITE, nil, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0));
  FindExecutable(PWideChar(TempFileName), nil, Path); //Find the executable (default browser) associated with the html file.
  DeleteFile(PWideChar(TempFileName));
  if Path = '' then
  begin
    Result := False;
    Exit;
  end;

  RunCommand(Path, URL);
end;

function GetAppVersion(const Url:string):string;
const
  BuffSize = 64*1024;
  TitleTagBegin = '<p>';
  TitleTagEnd = '</p>';
var
  hInter: HINTERNET;
  UrlHandle: HINTERNET;
  BytesRead: Cardinal;
  Buffer: Pointer;
  i,f: Integer;
begin
  Result:='';
  hInter := InternetOpen('', INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
  if Assigned(hInter) then
  begin
    GetMem(Buffer,BuffSize);
    try
       UrlHandle := InternetOpenUrl(hInter, PChar(Url), nil, 0, INTERNET_FLAG_RELOAD,0);
       try
        if Assigned(UrlHandle) then
        begin
          InternetReadFile(UrlHandle, Buffer, BuffSize, BytesRead);
          if BytesRead > 0 then
          begin
            SetString(Result, PAnsiChar(Buffer), BytesRead);
            i := Pos(TitleTagBegin,Result);
            if i > 0 then
            begin
              f := PosEx(TitleTagEnd,Result,i+Length(TitleTagBegin));
              Result := Copy(Result,i+Length(TitleTagBegin),f-i-Length(TitleTagBegin));
            end;
          end;
        end;
       finally
         InternetCloseHandle(UrlHandle);
       end;
    finally
      FreeMem(Buffer);
    end;
    InternetCloseHandle(hInter);
  end
end;

function GetOSInfo: string;
var
  OS: TOSVersionInfo;
begin
  OS.dwOSVersionInfoSize := SizeOf(OS);
  GetVersionEx(OS);
  case OS.dwPlatformID of
    VER_PLATFORM_WIN32_WINDOWS:
      if (OS.dwMajorVersion = 4) and (OS.dwMinorVersion = 0) then
        Result := Format('Windows 95 (Build %d.%d.%d) %s', [OS.dwMajorVersion, OS.dwMinorVersion,
          LoWord(OS.dwBuildNumber), OS.szCSDVersion])
      else if (OS.dwMajorVersion = 4) and (OS.dwMinorVersion = 10) then
        Result := Format('Windows 98 (Build %d.%d.%d) %s', [OS.dwMajorVersion, OS.dwMinorVersion,
          LoWord(OS.dwBuildNumber), OS.szCSDVersion]);
    VER_PLATFORM_WIN32_NT:
      if (OS.dwMajorVersion = 5) and (OS.dwMinorVersion = 0) then
        Result := Format('Windows 2000 (Build %d) %s', [OS.dwBuildNumber, OS.szCSDVersion])
      else if (OS.dwMajorVersion = 5) and (OS.dwMinorVersion = 1) then
        Result := Format('Windows XP (Build %d) %s', [OS.dwBuildNumber, OS.szCSDVersion])
      else
        Result := Format('Windows NT %d.%d (Build %d) %s', [OS.dwMajorVersion, OS.dwMinorVersion,
          OS.dwBuildNumber, OS.szCSDVersion])
    else
      Result := Format('Windows %d.%d %s', [OS.dwMajorVersion, OS.dwMinorVersion, OS.szCSDVersion]);
  end;
end;

function PointInRect(const P: TPoint; const R: TRect): Boolean;
begin
  with R do
    Result := (Left <= P.X) and (Top <= P.Y) and (Right >= P.X) and (Bottom >= P.Y);
end;

procedure AutoSizeCol(Grid: TBCStringGrid; StartCol: Integer);
var
  i, W, WMax, Column: Integer;
begin
  Screen.Cursor := crHourglass;
  for Column := StartCol to Grid.ColCount - 1 do
  begin
    if not Grid.IsHidden(Column, 0) then
    begin
      WMax := 0;
      for i := 0 to Grid.RowCount - 1 do
      begin
        W := Grid.Canvas.TextWidth(Grid.Cells[Column, i]);
        if W > WMax then
          WMax := W;
      end;
      Grid.ColWidths[Column] := WMax + 7;
    end;
  end;

  Grid.Width := Grid.ColWidths[0] + Grid.ColWidths[1] + 2;
  Grid.Visible := True;
  Screen.Cursor := crDefault;
end;

procedure CheckForUpdates(AppName: string; AboutVersion: string);
var
  Version: string;
  FileName: string;
begin
  try
    try
      Screen.Cursor := crHourGlass;
      Version := GetAppVersion(Format('%s/newversioncheck.php?a=%s&v=%s', [BONECODE_URL, LowerCase(AppName), AboutVersion]));
    finally
      Screen.Cursor := crDefault;
    end;

    if (Trim(Version) <> '') and (Version <> AboutVersion) then
    begin
      if AskYesOrNo(Format(LanguageDataModule.GetYesOrNoMessage('NewVersion'), [Version, AppName, CHR_DOUBLE_ENTER])) then
      begin
        {$IFDEF WIN64}
        AppName := AppName + '64';
        {$ENDIF}
        FileName := DownloadURLDialog.Open(Format('%s.zip', [AppName]), Format('%s/downloads/%s.zip', [BONECODE_URL, AppName]));
        ShellExecute(Application.Handle, PChar('explore'), nil, nil, PChar(ExtractFilePath(FileName)), SW_SHOWNORMAL);
      end;
    end
    else
      ShowMessage(LanguageDataModule.GetMessage('LatestVersion'));
  except
    on E: Exception do
      ShowErrorMessage(E.Message);
  end;
end;

procedure InsertTextToCombo(ComboBox: TBCComboBox);
var
  s: string;
  i: Integer;
begin
  with ComboBox do
  begin
    s := Text;
    if s <> '' then
    begin
      i := Items.IndexOf(s);
      if i > -1 then
      begin
        Items.Delete(i);
        Items.Insert(0, s);
        Text := s;
      end
      else
        Items.Insert(0, s);
    end;
  end;
end;

procedure RunCommand(const Cmd, Params: String);
var
  SI: TStartupInfo;
  PI: TProcessInformation;
  CmdLine: String;
begin
  //Fill record with zero byte values
  FillChar(SI, SizeOf(SI), 0);
  //Set mandatory record field
  SI.cb := SizeOf(SI);
  //Ensure Windows mouse cursor reflects launch progress
  SI.dwFlags := StartF_ForceOnFeedback;
  //Set up command line
  CmdLine := Cmd;
  if Length(Params) > 0 then
    CmdLine := CmdLine + #32 + '"' + Params + '"';
  //Try and launch child process. Raise exception on failure
  {$WARNINGS OFF}
  Win32Check(CreateProcess(nil, PChar(CmdLine), nil, nil, False, 0, nil, nil, SI, PI));
  {$WARNINGS ON}
  //Wait until process has started its main message loop
  WaitForInputIdle(PI.hProcess, Infinite);
  //Close process and thread handles
  CloseHandle(PI.hThread);
  CloseHandle(PI.hProcess);
end;

function SetFormInsideWorkArea(Left, Width: Integer): Integer;
var
  i: Integer;
  ScreenPos: Integer;
begin
  Result := Left;
  { check if the application is outside left side }
  ScreenPos := 0;
  for i := 0 to Screen.MonitorCount - 1 do
    if Screen.Monitors[i].WorkareaRect.Left < ScreenPos then
      ScreenPos := Screen.Monitors[i].WorkareaRect.Left;
  if Left + Width < ScreenPos then
    Result := (Screen.Width - Width) div 2;
  { check if the application is outside right side }
  ScreenPos := 0;
  for i := 0 to Screen.MonitorCount - 1 do
    if Screen.Monitors[i].WorkareaRect.Right > ScreenPos then
      ScreenPos := Screen.Monitors[i].WorkareaRect.Right;
  if Left > ScreenPos then
    Result := (Screen.Width - Width) div 2;
end;

end.
