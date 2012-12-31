unit Common;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Dlg, BCStringGrid,
  BCComboBox, Vcl.Dialogs, Vcl.ActnMan, Vcl.ActnMenus, Winapi.WinInet, System.Types;

const
  CHR_ENTER = Chr(13) + Chr(10);
  CHR_DOUBLE_ENTER = CHR_ENTER + CHR_ENTER;
  CHR_TAB = Chr(9);

  BONECODE_URL = 'http://www.bonecode.com';

function BrowseURL(const URL: string): Boolean;
function GetOSInfo: string;
function StringBetween(Str: string; SubStr1: string; SunStr2: string): string;
function AnsiInitCap(Str: string): string;
function SaveChanges(IncludeCancel: Boolean = True): Integer;
function AskYesOrNo(Msg: string): Boolean;
function MessageDialog(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; Captions: array of string): Integer;
procedure ShowMessage(Msg: string);
procedure ShowErrorMessage(Msg: string);
procedure ShowWarningMessage(Msg: string);
procedure AutoSizeCol(Grid: TBCStringGrid; StartCol: Integer = 0);
function AddSlash(Path: string): string;
procedure InsertTextToCombo(ComboBox: TBCComboBox);
function IsAsciiFile(Filename: string): Boolean;
function WideUpperCase(const S: WideString): WideString;
function GetINIFilename: string;
function EncryptString(Data: string): string;
function DecryptString(Data: string): string;
function WordCount(s: string): Integer;
function GetAppVersion(const Url:string):string;
function PointInRect(const P: TPoint; const R: TRect): Boolean;
function GetFileVersion(Path: string): string;
function GetNextToken(Separator: char; Text: string): string;
function RemoveTokenFromStart(Separator: char; Text: string): string;
function GetTextAfterChar(Separator: char; Text: string): string;
procedure CheckForUpdates(AppName: string);
function GetSelectedLanguage(Default: string = ''): string;

implementation

uses
  Winapi.Windows, Winapi.ShellAPI, Vcl.StdCtrls, DownloadURL, Vcl.Menus,
  System.Character, Vcl.ActnList, System.StrUtils, About, BigINI, Language;

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
  Win32Check(CreateProcess(nil, PChar(CmdLine), nil, nil, False, 0, nil, nil, SI, PI));
  //Wait until process has started its main message loop
  WaitForInputIdle(PI.hProcess, Infinite);
  //Close process and thread handles
  CloseHandle(PI.hThread);
  CloseHandle(PI.hProcess);
end;

function BrowseURL(const URL: string): Boolean;
var
  TempFileName: string;
  Path: array[0..255] of char;
  tmp : PChar;
begin
  Result := True;
  tmp := StrAlloc(255);
  GetTempPath(255,tmp);
  TempFileName := Format('%s%s', [tmp, 'bonecode-default.html']);
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

function AnsiInitCap(Str: string): string;
begin
  Result := Concat(AnsiUpperCase(Copy(Str, 1, 1)), AnsiLowerCase(Copy(Str, 2, Length(Str))));
end;

function StringBetween(Str: string; SubStr1: string; SunStr2: string): string;
begin
  Result := Str;
  Result := Copy(Result, Pos(SubStr1, Result) + 1, Length(Result));
  Result := Copy(Result, 1, Pos(SunStr2, Result) - 1);
end;

function SaveChanges(IncludeCancel: Boolean): Integer;
var
  Buttons: TMsgDlgButtons;
begin
  Buttons := [mbYes, mbNO];
  if IncludeCancel then
    Buttons := Buttons + [mbCancel];

  with CreateMessageDialog(LanguageDataModule.YesOrNoMultiStringHolder.StringsByName['SaveChanges'].Text, mtConfirmation, Buttons) do
  try
    HelpContext := 0;
    HelpFile := '';
    Position := poMainFormCenter;
    Result := ShowModal;
  finally
    Free;
  end
end;

function AskYesOrNo(Msg: string): Boolean;
begin
  with CreateMessageDialog(Msg, mtConfirmation, [mbYes, mbNo]) do
  try
    HelpContext := 0;
    HelpFile := '';
    Position := poMainFormCenter;
    Result := ShowModal = mrYes;
  finally
    Free;
  end
end;

procedure ShowMessage(Msg: string);
begin
  with CreateMessageDialog(Msg, mtInformation, [mbOK]) do
  try
    HelpContext := 0;
    HelpFile := '';
    Position := poMainFormCenter;
    ShowModal;
  finally
    Free;
  end
end;

procedure ShowErrorMessage(Msg: string);
begin
  with CreateMessageDialog(Msg, mtError, [mbOK]) do
  try
    HelpContext := 0;
    HelpFile := '';
    Position := poMainFormCenter;
    ShowModal;
  finally
    Free;
  end
end;

procedure ShowWarningMessage(Msg: string);
begin
  with CreateMessageDialog(Msg, mtWarning, [mbOK]) do
  try
    HelpContext := 0;
    HelpFile := '';
    Position := poMainFormCenter;
    ShowModal;
  finally
    Free;
  end
end;

function MessageDialog(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; Captions: array of string): Integer;
var
  i: Integer;
  dlgButton: TButton;
  CaptionIndex: Integer;
begin
  { Create the Dialog }
  with CreateMessageDialog(Msg, DlgType, Buttons) do
  try
    HelpContext := 0;
    HelpFile := '';
    CaptionIndex := 0;
    { Loop through Objects in Dialog }
    for i := 0 to ComponentCount - 1 do
    begin
     { If the object is of type TButton, then }
      if (Components[i] is TButton) then
      begin
        dlgButton := TButton(Components[i]);
        if CaptionIndex > High(Captions) then Break;
        { Give a new caption from our Captions array}
        dlgButton.Caption := Captions[CaptionIndex];
        Inc(CaptionIndex);
      end;
    end;
    Position := poMainFormCenter;
    Result := ShowModal;
  finally
    Free;
  end;
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

function AddSlash(Path: string): string;
begin
  if Path = '' then
    Exit;
  if Path[Length(Path)] <> '\' then
    Result := Format('%s\', [Path])
  else
    Result := Path;
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

function IsAsciiFile(Filename: string): Boolean;
const
  Sett = 2048;
var
  i: Integer;
  F: file;
  TotalSize, IncSize, ReadSize: Integer;
  c: array[0..Sett] of Byte;
begin
  {$I-}
  try
    AssignFile(F, Filename);
    Reset(F, 1);
    TotalSize := FileSize(F);

    IncSize := 0;
    Result := true;

    while (IncSize < TotalSize) and Result do
    begin
      ReadSize := Sett;
      if IncSize + ReadSize > TotalSize then
        ReadSize := TotalSize - IncSize;
      IncSize := IncSize + ReadSize;
      BlockRead(F, c, ReadSize);
      for i := 0 to ReadSize - 1 do
        if (c[i]<32) and (not (c[i] in [9, 10, 13, 26])) then
        begin
          Result := False;
          Exit;
        end;
    end;
  finally
    CloseFile(F);
    {$I+}
    if IOResult <> 0 then
      Result := False
  end;
end;

function WideUpperCase(const S: WideString): WideString;
var
  I, Len: Integer;
  DstP, SrcP: PChar;
  Ch: Char;
begin
  Len := Length(S);
  SetLength(Result, Len);
  if Len > 0 then
  begin
    DstP := PChar(Pointer(Result));
    SrcP := PChar(Pointer(S));
    for I := Len downto 1 do
    begin
      Ch := SrcP^;
      case Ch of
        'a'..'z':
          Ch := Char(Word(Ch) xor $0020);
      end;
      DstP^ := Ch;
      Inc(DstP);
      Inc(SrcP);
    end;
  end;
end;

function GetINIFilename: string;
begin
  Result := ChangeFileExt(Application.EXEName, '.ini');
end;

function DecryptString(Data: string): string;
var
  i: Integer;
begin
  Result := '';
  if Length(Data) > 0 Then
    for i := 1 to Length(Data) do
    begin
      if Ord(Data[i]) <> 0 Then
        Result:= Result + Chr(Ord(Data[i]) - 1)
      else
        Result:= Result + Chr(255)
    end;
end;

function EncryptString(Data: string): string;
var
  i: Integer;
begin
  Result := '';
  if Length(Data) > 0 then
    for i := 1 to Length(Data) do
    begin
      if Ord(Data[i]) <> 255 Then
        Result := Result + Chr(Ord(Data[i]) + 1)
      else
        Result := Result + Chr(0)
    end;
end;

function WordCount(s: string): Integer;
var
  i: Integer;
  IsWhite, IsWhiteOld: boolean;
begin
  IsWhiteOld := True;
  Result := 0;
  for i := 0 to Length(s) - 1 do
  begin
    IsWhite := IsWhiteSpace(s[i]);
    if IsWhiteOld and not IsWhite then
      Inc(Result);
    IsWhiteOld := IsWhite;
  end;
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

function PointInRect(const P: TPoint; const R: TRect): Boolean;
begin
  with R do
    Result := (Left <= P.X) and (Top <= P.Y) and (Right >= P.X) and (Bottom >= P.Y);
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
    Result := LanguageDataModule.ConstantMultiStringHolder.StringsByName['VersionInfoNotFound'].Text;
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

function GetNextToken(Separator: char; Text: string): string;
begin
  Result := System.Copy(Text, 1, Pos(Separator, Text) - 1);
end;

function RemoveTokenFromStart(Separator: char; Text: string): string;
begin
  Result := System.Copy(Text, Pos(Separator, Text) + 1, Length(Text));
end;

function GetTextAfterChar(Separator: char; Text: string): string;
begin
  Result := System.Copy(Text, Pos(Separator, Text) + 1, Length(Text));
end;

procedure CheckForUpdates(AppName: string);
var
  Version: string;
begin
  try
    try
      Screen.Cursor := crHourGlass;
      Version := GetAppVersion(Format('%s/newversioncheck.php?a=%s&v=%s', [BONECODE_URL, LowerCase(AppName), AboutDialog.Version]));
    finally
      Screen.Cursor := crDefault;
    end;

    if (Trim(Version) <> '') and (Version <> AboutDialog.Version) then
    begin
      if Common.AskYesOrNo(Format(LanguageDataModule.YesOrNoMultiStringHolder.StringsByName['NewVersion'].Text, [Version, AppName, CHR_DOUBLE_ENTER])) then
        DownloadURLDialog.Open(Format('%s.zip', [AppName]), Format('%s/downloads/%s.zip', [BONECODE_URL, AppName]))
    end
    else
      Common.ShowMessage(LanguageDataModule.MessageMultiStringHolder.StringsByName['LatestVersion'].Text);
  except
    on E: Exception do
      Common.ShowErrorMessage(E.Message);
  end;
end;

function GetSelectedLanguage(Default: string): string;
begin
  with TBigIniFile.Create(Common.GetINIFilename) do
  try
    Result := ReadString('Preferences', 'Language', Default);
  finally
    Free;
  end;
end;

end.
