unit BCCommon;

interface

uses
  Vcl.ActnMenus, System.Types, BCControls.BCStringGrid, BCControls.BCComboBox;

const
  CHR_ENTER = Chr(13) + Chr(10);
  CHR_DOUBLE_ENTER = CHR_ENTER + CHR_ENTER;
  CHR_TAB = '  ';

  BONECODE_URL = 'http://www.bonecode.com';

  TAnimationStyleStr: array[Low(TAnimationStyle)..High(TAnimationStyle)] of String = ('None',
    'Default', 'Unfold', 'Slide', 'Fade');
  TSynEditCaretTypeStr: array[0..3] of String =
    ('Vertical Line', 'Horizontal Line', 'Half Block', 'Block');

function BinToInt(Value: String): LongInt;
function BrowseURL(const URL: string): Boolean;
function GetAppVersion(const Url:string):string;
function GetOSInfo: string;
function IntToBin(Value: LongInt; Digits: Integer): string;
function PointInRect(const P: TPoint; const R: TRect): Boolean;
procedure AutoSizeCol(Grid: TBCStringGrid; StartCol: Integer = 0);
procedure CheckForUpdates(AppName: string; AboutVersion: string);
procedure InsertTextToCombo(ComboBox: TBCComboBox);
procedure RunCommand(const Cmd, Params: String);

implementation

uses
  System.SysUtils, System.IOUtils, Winapi.Windows, Winapi.ShellApi, Winapi.WinInet, System.StrUtils, Vcl.Forms,
  System.UITypes, BCCommon.Messages, BCCommon.Language, BCDialogs.DownloadURL;

function BinToInt(Value: String): LongInt;
var
  i: Integer;
begin
  Result:=0;
  while Copy(Value,1,1) = '0' do
    Value := Copy(Value, 2, Length(Value) - 1);
  for i := Length(Value) downto 1 do
    if Copy(Value, i, 1) = '1' then
      Result := Result + (1 shl (Length(Value) - i));
end;

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

function IntToBin(Value: LongInt; Digits: Integer): string;
begin
  Result := StringOfChar('0', Digits);
  while Value > 0 do
  begin
    if (Value and 1) = 1 then
      Result[Digits] := '1';
    Dec(Digits);
    Value := Value shr 1;
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
      if AskYesOrNo(Format(LanguageDataModule.GetYesOrNo('NewVersion'), [Version, AppName, CHR_DOUBLE_ENTER])) then
      begin
        {$IFDEF WIN64}
        AppName := AppName + '64';
        {$ENDIF}
        DownloadURLDialog.Open(Format('%s.zip', [AppName]), Format('%s/downloads/%s.zip', [BONECODE_URL, AppName]))
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
    CmdLine := CmdLine + #32 + Params;
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

end.
