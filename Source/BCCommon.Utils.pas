unit BCCommon.Utils;

interface

uses
  Winapi.Windows, System.Classes, System.Types, BCControls.ComboBox, Vcl.Controls;

function BrowseURL(const AURL: string; const ABrowserPath: string = ''): Boolean;
function GetOSInfo: string;
function InsertTextToCombo(ComboBox: TBCComboBox): Boolean;
function SetFormInsideWorkArea(Left, Width: Integer): Integer;
function PostInc(var i: Integer) : Integer; inline;
procedure InsertItemsToComboBox(AItems: TStrings; AComboBox: TBCComboBox);
procedure AlignSliders(AWinControl: TWinControl);

implementation

uses
  System.SysUtils, System.IOUtils, Winapi.ShellApi, Vcl.Forms, sLabel, BCCommon.StringUtils, JclSysInfo;

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

function InsertTextToCombo(ComboBox: TBCComboBox): Boolean;
var
  s: string;
  i: Integer;
begin
  Result := True;
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
        Result := False;
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
