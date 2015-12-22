unit BCCommon.Utils;

interface

uses
  Winapi.Windows, System.Classes, System.Types, BCControls.ComboBox, Vcl.Controls;

function BrowseURL(const AURL: string; const ABrowserPath: string = ''): Boolean;
function GetOSInfo: string;
function InsertTextToCombo(ComboBox: TBCComboBox): Integer;
function SetFormInsideWorkArea(Left, Width: Integer): Integer;
function PostInc(var i: Integer): Integer; inline;
function RestoreIfRunning(const AAppHandle: THandle): Boolean;
procedure InsertItemsToComboBox(AItems: TStrings; AComboBox: TBCComboBox);
procedure AlignSliders(AWinControl: TWinControl);

implementation

uses
  System.SysUtils, System.IOUtils, Winapi.ShellApi, Vcl.Forms, sLabel, BCCommon.StringUtils, JclSysInfo;

type
  PInstanceInfo = ^TInstanceInfo;

  TInstanceInfo = packed record
    PreviousHandle: THandle;
  end;

var
  GMappingHandle: THandle = 0;
  GInstanceInfo: PInstanceInfo = nil;
  GCurrentAppHandle: THandle = 0;
  GRemoveMe: Boolean = True;

function BrowseURL(const AURL: string; const ABrowserPath: string = ''): Boolean;
begin
  if ABrowserPath = '' then
    Result := ShellExecute(0, 'open', PChar(AURL), nil, nil, SW_SHOWNORMAL) > 32
  else
    Result := ShellExecute(0, 'open', PChar(ABrowserPath), PChar(AURL), nil, SW_SHOWNORMAL) > 32
end;

{ TODO: Remove JclSysInfo }
function GetOSInfo: string;
begin
  Result := GetWindowsVersionString + ' ' + GetWindowsEditionString;
end;

procedure InsertItemsToComboBox(AItems: TStrings; AComboBox: TBCComboBox);
var
  i: Integer;
  s: string;
begin
  AComboBox.Clear;
  for i := AItems.Count - 1 downto 0 do
  begin
    s := GetTokenAfter('=', AItems.Strings[i]);
    if AComboBox.Items.IndexOf(s) = -1 then
      AComboBox.Items.Add(s);
  end;
end;

function InsertTextToCombo(ComboBox: TBCComboBox): Integer;
var
  s: string;
  i: Integer;
begin
  Result := -1;
  with ComboBox do
  begin
    s := Text;
    if s <> '' then
    begin
      i := Items.IndexOf(s);
      if i > -1 then
        Items.Delete(i);
      Items.Insert(0, s);
      Text := s;
      if i = -1 then
        Result := ComboBox.Items.Count - 1;
    end;
  end;
end;

function SetFormInsideWorkArea(Left, Width: Integer): Integer;
var
  i: Integer;
  ScreenPos: Integer;
  LMonitor: TMonitor;
begin
  Result := Left;
  { check if the application is outside left side }
  ScreenPos := 0;
  for i := 0 to Screen.MonitorCount - 1 do
  begin
    LMonitor := Screen.Monitors[i];
    if LMonitor.WorkareaRect.Left < ScreenPos then
      ScreenPos := LMonitor.WorkareaRect.Left;
  end;
  if Left + Width < ScreenPos then
    Result := (Screen.Width - Width) div 2;
  { check if the application is outside right side }
  ScreenPos := 0;
  for i := 0 to Screen.MonitorCount - 1 do
  begin
    LMonitor := Screen.Monitors[i];
    if LMonitor.WorkareaRect.Right > ScreenPos then
      ScreenPos := LMonitor.WorkareaRect.Right;
  end;
  if Left > ScreenPos then
    Result := (Screen.Width - Width) div 2;
end;

function PostInc(var i: Integer): Integer; inline;
begin
  Result := i;
  Inc(i)
end;

function RestoreIfRunning(const AAppHandle: THandle): Boolean;
var
  LMappingName: string;
  LAlreadyExists: Boolean;
begin
  Result := True;

  GCurrentAppHandle := AAppHandle;

  LMappingName := StringReplace(ParamStr(0), '\', '_', [rfReplaceAll, rfIgnoreCase]);
  GMappingHandle := CreateFileMapping(INVALID_HANDLE_VALUE, nil, PAGE_READWRITE, 0, SizeOf(TInstanceInfo),
    PChar(LMappingName));

  if GMappingHandle = 0 then
    RaiseLastOSError;

  LAlreadyExists := GetLastError = ERROR_ALREADY_EXISTS;

  GInstanceInfo := PInstanceInfo(MapViewOfFile(GMappingHandle, FILE_MAP_WRITE, 0, 0, SizeOf(TInstanceInfo)));
  if not Assigned(GInstanceInfo) then
    RaiseLastOSError;

  if LAlreadyExists then
  begin
    GRemoveMe := False;
    if GInstanceInfo^.PreviousHandle <> 0 then
    begin
      if IsIconic(GInstanceInfo^.PreviousHandle) then
        ShowWindow(GInstanceInfo^.PreviousHandle, SW_RESTORE);
      SetForegroundWindow(GInstanceInfo^.PreviousHandle);
    end;
    Exit;
  end
  else
    GInstanceInfo^.PreviousHandle := AAppHandle;

  Result := False;
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

initialization

finalization

  if Assigned(GInstanceInfo) then
  begin
    if GRemoveMe then
      if GInstanceInfo^.PreviousHandle = GCurrentAppHandle then
        GInstanceInfo^.PreviousHandle := 0;
    UnmapViewOfFile(GInstanceInfo);
    GInstanceInfo := nil;
  end;

  if GMappingHandle <> 0 then
  begin
    CloseHandle(GMappingHandle);
    GMappingHandle := 0;
  end;

end.
