unit BCCommon.Utils;

interface

uses
  Winapi.Windows, System.Classes, System.Types, BCControl.ComboBox, Vcl.Controls, Vcl.ValEdit, Vcl.Graphics;

function BrowseURL(const AURL: string; const ABrowserPath: string = ''): Boolean;
function GetOSInfo: string;
function InsertTextToCombo(ComboBox: TBCComboBox): Integer;
function PostInc(var AValue: Integer): Integer; inline;
function ScaleSize(const ASize: Integer): Integer;
function SetFormInsideWorkArea(const ALeft, AWidth: Integer): Integer;
procedure AlignSliders(AWinControl: TWinControl; const ALeftMargin: Integer = 0);
procedure InsertItemsToComboBox(AValueListEditor: TValueListEditor; AComboBox: TBCComboBox);

implementation

uses
  System.SysUtils, System.IOUtils, Winapi.ShellApi, Vcl.Forms, acSlider, sLabel, BCCommon.StringUtils,
  BCCommon.WindowsInfo;

function BrowseURL(const AURL: string; const ABrowserPath: string = ''): Boolean;
begin
  if ABrowserPath = '' then
    Result := ShellExecute(0, nil, PChar(AURL), nil, nil, SW_SHOWNORMAL) > 32
  else
    Result := ShellExecute(0, nil, PChar(ABrowserPath), PChar(AURL), nil, SW_SHOWNORMAL) > 32
end;

function GetOSInfo: string;
begin
  Result := GetWindowsVersionString + ' ' + GetWindowsEditionString;
end;

procedure InsertItemsToComboBox(AValueListEditor: TValueListEditor; AComboBox: TBCComboBox);
var
  LIndex: Integer;
  LValue: string;
begin
  AComboBox.Clear;
  for LIndex := AValueListEditor.Strings.Count - 1 downto 0 do
  begin
    LValue := AValueListEditor.Values[IntToStr(LIndex)];
    if AComboBox.Items.IndexOf(LValue) = -1 then
      AComboBox.Items.Add(LValue);
  end;
end;

function InsertTextToCombo(ComboBox: TBCComboBox): Integer;
var
  LText: string;
  LIndex: Integer;
begin
  Result := -1;
  with ComboBox do
  begin
    LText := Text;
    if LText <> '' then
    begin
      LIndex := Items.IndexOf(LText);
      if LIndex > -1 then
        Items.Delete(LIndex);
      Items.Insert(0, LText);
      Text := LText;
      //if LIndex = -1 then
      Result := ComboBox.Items.Count - 1;
    end;
  end;
end;

function ScaleSize(const ASize: Integer): Integer;
begin
  Result := Round(ASize * (Screen.PixelsPerInch / 96));
end;

function SetFormInsideWorkArea(const ALeft, AWidth: Integer): Integer;
var
  LIndex: Integer;
  LScreenPos: Integer;
  LMonitor: TMonitor;
begin
  Result := ALeft;
  { check if the application is outside left side }
  LScreenPos := 0;
  for LIndex := 0 to Screen.MonitorCount - 1 do
  begin
    LMonitor := Screen.Monitors[LIndex];
    if LMonitor.WorkareaRect.Left < LScreenPos then
      LScreenPos := LMonitor.WorkareaRect.Left;
  end;
  if ALeft + AWidth < LScreenPos then
    Result := (Screen.Width - AWidth) div 2;
  { check if the application is outside right side }
  LScreenPos := 0;
  for LIndex := 0 to Screen.MonitorCount - 1 do
  begin
    LMonitor := Screen.Monitors[LIndex];
    if LMonitor.WorkareaRect.Right > LScreenPos then
      LScreenPos := LMonitor.WorkareaRect.Right;
  end;
  if ALeft > LScreenPos then
    Result := (Screen.Width - AWidth) div 2;
end;

function PostInc(var AValue: Integer): Integer; inline;
begin
  Result := AValue;
  Inc(AValue)
end;

procedure AlignSliders(AWinControl: TWinControl; const ALeftMargin: Integer = 0);
var
  LIndex: Integer;
  LMaxLength: Integer;
  LMaxSliderLeft: Integer;
  LLabel: TsStickyLabel;
  LSlider: TsSlider;
begin
  LMaxLength := 0;
  LMaxSliderLeft := 0;
  for LIndex := 0 to AWinControl.ControlCount - 1 do
  if AWinControl.Controls[LIndex] is TsStickyLabel then
  begin
    LLabel := AWinControl.Controls[LIndex] as TsStickyLabel;

    LLabel.AutoSize := True;
    if LLabel.Width > LMaxLength then
    begin
      LSlider := LLabel.AttachTo as TsSlider;
      LMaxSliderLeft := LSlider.Left - LLabel.Left;
      LMaxLength := LLabel.Width;
    end;
    LLabel.AutoSize := False;
  end;
  for LIndex := 0 to AWinControl.ControlCount - 1 do
  if AWinControl.Controls[LIndex] is TsStickyLabel then
  begin
    LLabel := AWinControl.Controls[LIndex] as TsStickyLabel;
    LLabel.Width := LMaxLength;
    LSlider := LLabel.AttachTo as TsSlider;
    LSlider.Left := LMaxSliderLeft + ALeftMargin;
  end;
end;

end.
