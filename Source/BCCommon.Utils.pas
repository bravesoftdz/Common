unit BCCommon.Utils;

interface

uses
  Winapi.Windows, System.Classes, System.Types, {BCControls.StringGrid,} BCControls.ComboBox, Vcl.Controls;

function BrowseURL(const URL: string): Boolean;
function GetOSInfo: string;
function SetFormInsideWorkArea(Left, Width: Integer): Integer;
function PostInc(var i: Integer) : Integer; inline;
procedure InsertItemsToComboBox(AItems: TStrings; AComboBox: TBCComboBox);
procedure InsertTextToCombo(ComboBox: TBCComboBox);
procedure RunCommand(const Cmd, Params: String);
procedure AlignSliders(AWinControl: TWinControl);

implementation

uses
  System.SysUtils, System.IOUtils, Winapi.ShellApi, Vcl.Forms, BCCommon.Language.Strings, sLabel, BCCommon.StringUtils;

function BrowseURL(const URL: string): Boolean;
var
  TempFileName: string;
  Path: array[0..255] of char;
begin
  TempFileName := Format('%s%s', [TPath.GetTempPath, 'bonecode-default.html']);
  CloseHandle(CreateFile(PWideChar(TempFileName), GENERIC_WRITE, FILE_SHARE_WRITE, nil, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0));
  FindExecutable(PWideChar(TempFileName), nil, Path); //Find the executable (default browser) associated with the html file.
  DeleteFile(PWideChar(TempFileName));
  if Path = '' then
    Exit(False);

  RunCommand(Path, URL);

  Result := True;
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
      else
      if (OS.dwMajorVersion = 4) and (OS.dwMinorVersion = 10) then
        Result := Format('Windows 98 (Build %d.%d.%d) %s', [OS.dwMajorVersion, OS.dwMinorVersion,
          LoWord(OS.dwBuildNumber), OS.szCSDVersion]);
    VER_PLATFORM_WIN32_NT:
      if (OS.dwMajorVersion = 5) and (OS.dwMinorVersion = 0) then
        Result := Format('Windows 2000 (Build %d) %s', [OS.dwBuildNumber, OS.szCSDVersion])
      else
      if (OS.dwMajorVersion = 5) and (OS.dwMinorVersion = 1) then
        Result := Format('Windows XP (Build %d) %s', [OS.dwBuildNumber, OS.szCSDVersion])
      else
        Result := Format('Windows NT %d.%d (Build %d) %s', [OS.dwMajorVersion, OS.dwMinorVersion,
          OS.dwBuildNumber, OS.szCSDVersion])
    else
      Result := Format('Windows %d.%d %s', [OS.dwMajorVersion, OS.dwMinorVersion, OS.szCSDVersion]);
  end;
end;

procedure InsertItemsToComboBox(AItems: TStrings; AComboBox: TBCComboBox);
var
  i: Integer;
  s: string;
begin
  if AItems.Count > 0 then
  begin
    AComboBox.Clear;
    for i := 0 to AItems.Count - 1 do
    begin
      s := GetTokenAfter('=', AItems.Strings[i]);
      if AComboBox.Items.IndexOf(s) = -1 then
        AComboBox.Items.Add(s);
    end;
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
      begin
        i := 0;
        if Sorted then
        while (i < Items.Count) and (Items[i] < s) do
          Inc(i);
        Items.Insert(i, s);
      end
    end;
  end;
end;

procedure RunCommand(const Cmd, Params: String);
var
  StartupInfo: TStartupInfo;
  ProcessInformation: TProcessInformation;
  CmdLine: String;
begin
  { Fill record with zero byte values }
  FillChar(StartupInfo, SizeOf(StartupInfo), 0);
  { Set mandatory record field }
  StartupInfo.cb := SizeOf(StartupInfo);
  { Ensure Windows mouse cursor reflects launch progress }
  StartupInfo.dwFlags := StartF_ForceOnFeedback;
  { Set up command line }
  CmdLine := Cmd;
  if Length(Params) > 0 then
    CmdLine := CmdLine + #32 + '"' + Params + '"';
  { Try and launch child process. Raise exception on failure }
  {$WARNINGS OFF}
  Win32Check(CreateProcess(nil, PChar(CmdLine), nil, nil, False, 0, nil, nil, StartupInfo, ProcessInformation));
  {$WARNINGS ON}
  { Wait until process has started its main message loop }
  WaitForInputIdle(ProcessInformation.hProcess, Infinite);
  { Close process and thread handles }
  CloseHandle(ProcessInformation.hThread);
  CloseHandle(ProcessInformation.hProcess);
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

function PostInc(var i: Integer) : Integer; inline;
begin
  Result := i;
  Inc(i)
end;

procedure AlignSliders(AWinControl: TWinControl);
var
  i: Integer;
  LMaxLength: Integer;
  LLabel: TsStickyLabel;
begin
  LMaxLength := 0;
  for i := 0 to AWinControl.ControlCount - 1 do
  if AWinControl.Controls[i] is TsStickyLabel then
  begin
    LLabel := AWinControl.Controls[i] as TsStickyLabel;
    LLabel.AutoSize := True;
    if LLabel.Width > LMaxLength then
      LMaxLength := LLabel.Width;
    LLabel.AutoSize := False;
  end;
  for i := 0 to AWinControl.ControlCount - 1 do
    if AWinControl.Controls[i] is TsStickyLabel then
    begin
      LLabel := AWinControl.Controls[i] as TsStickyLabel;
      LLabel.Width := LMaxLength;
    end;
end;

end.
