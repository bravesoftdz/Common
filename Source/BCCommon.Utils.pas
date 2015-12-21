unit BCCommon.Utils;

interface

uses
  Winapi.Windows, System.Classes, System.Types, BCControls.ComboBox, Vcl.Controls;

function BrowseURL(const AURL: string; const ABrowserPath: string = ''): Boolean;
function GetOSInfo: string;
function InsertTextToCombo(ComboBox: TBCComboBox): Integer;
function SetFormInsideWorkArea(Left, Width: Integer): Integer;
function PostInc(var i: Integer): Integer; inline;
function RestoreIfRunning(const AAppHandle: THandle; AMaxInstances: Integer = 1): Boolean;
procedure InsertItemsToComboBox(AItems: TStrings; AComboBox: TBCComboBox);
procedure AlignSliders(AWinControl: TWinControl);

implementation

uses
  System.SysUtils, System.IOUtils, Winapi.ShellApi, Vcl.Forms, sLabel, BCCommon.StringUtils, JclSysInfo;

type
  PInstanceInfo = ^TInstanceInfo;
  TInstanceInfo = packed record
    PreviousHandle: THandle;
    RunCounter: Integer;
  end;

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

function PostInc(var i: Integer): Integer; inline;
begin
  Result := i;
  Inc(i)
end;

function RestoreIfRunning(const AAppHandle: THandle; AMaxInstances: Integer = 1): Boolean;
var
  MappingHandle: THandle;
  InstanceInfo: PInstanceInfo;
  MappingName: string;
begin
  Result := True;

  MappingName := StringReplace(ParamStr(0), '\', '', [rfReplaceAll, rfIgnoreCase]);
  MappingHandle := CreateFileMapping($FFFFFFFF, nil, PAGE_READWRITE, 0, SizeOf(TInstanceInfo), PChar(MappingName));

  if MappingHandle = 0 then
    RaiseLastOSError
  else
  begin
    if GetLastError <> ERROR_ALREADY_EXISTS then
    begin
      InstanceInfo := MapViewOfFile(MappingHandle, FILE_MAP_ALL_ACCESS, 0, 0, SizeOf(TInstanceInfo));

      InstanceInfo^.PreviousHandle := AAppHandle;
      InstanceInfo^.RunCounter := 1;

      Result := False;
    end
    else { already runing }
    begin
      MappingHandle := OpenFileMapping(FILE_MAP_ALL_ACCESS, False, PChar(MappingName));
      if MappingHandle <> 0 then
      begin
        InstanceInfo := MapViewOfFile(MappingHandle, FILE_MAP_ALL_ACCESS, 0, 0, SizeOf(TInstanceInfo));

        if InstanceInfo^.RunCounter >= AMaxInstances then
        begin
          if IsIconic(InstanceInfo^.PreviousHandle) then
            ShowWindow(InstanceInfo^.PreviousHandle, SW_RESTORE);
          SetForegroundWindow(InstanceInfo^.PreviousHandle);
        end
        else
        begin
          InstanceInfo^.PreviousHandle := AAppHandle;
          InstanceInfo^.RunCounter := 1 + InstanceInfo^.RunCounter;

          Result := False;
        end
      end;
    end;
  end;
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
