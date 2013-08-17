unit BCCommon.LanguageStrings;

interface

uses
  System.SysUtils, System.Classes, BCControls.UnicodeStringHolder;

type
  TLanguageDataModule = class(TDataModule)
    ConstantMultiStringHolder: TBCMultiStringHolder;
    ErrorMessageMultiStringHolder: TBCMultiStringHolder;
    FileTypesMultiStringHolder: TBCMultiStringHolder;
    MessageMultiStringHolder: TBCMultiStringHolder;
    WarningMessageMultiStringHolder: TBCMultiStringHolder;
    YesOrNoMultiStringHolder: TBCMultiStringHolder;
    ConvertConstantMultiStringHolder: TBCMultiStringHolder;
  private
    { Private declarations }
  public
    { Public declarations }
    function GetConstant(Name: string): string;
    function GetConvertConstant(Name: string): string;
    function GetErrorMessage(Name: string): string;
    function GetFileTypes(Name: string): string;
    function GetMessage(Name: string): string;
    function GetPConstant(Name: string): PWideChar;
    function GetWarningMessage(Name: string): string;
    function GetYesOrNoMessage(Name: string): string;
  end;

procedure ReadLanguageFile(Language: string);

var
  LanguageDataModule: TLanguageDataModule;

implementation

{$R *.dfm}

uses
  Windows, Consts, Vcl.ActnList, Vcl.Menus, System.IniFiles;

procedure HookResourceString(aResStringRec: PResStringRec; aNewStr: PChar);
var
  OldProtect: DWORD;
begin
  VirtualProtect(aResStringRec, SizeOf(aResStringRec^), PAGE_EXECUTE_READWRITE, @OldProtect);
  aResStringRec^.Identifier := Integer(aNewStr);
  VirtualProtect(aResStringRec, SizeOf(aResStringRec^), OldProtect, @OldProtect);
end;

procedure ReadLanguageFile(Language: string);
var
  LanguagePath: string;
  BigIniFile: TMemIniFile;

  procedure SetStringHolder(MultiStringHolder: TBCMultiStringHolder; Section: string);
  var
    i: Integer;
    StringName: string;
    s: UnicodeString;
  begin
    for i := 0 to MultiStringHolder.MultipleStrings.Count - 1 do
    begin
      StringName := MultiStringHolder.MultipleStrings.Items[i].Name;
      s := BigIniFile.ReadString(Section, StringName, '');
      if s <> '' then
        MultiStringHolder.MultipleStrings.Items[i].Strings.Text := s;
    end;
  end;
begin
  if Language = '' then
    Exit;

  LanguagePath := IncludeTrailingPathDelimiter(Format('%s%s', [ExtractFilePath(ParamStr(0)), 'Languages']));
  if not DirectoryExists(LanguagePath) then
    Exit;

  BigIniFile := TMemIniFile.Create(Format('%s%s.%s', [LanguagePath, Language, 'lng']), TEncoding.Unicode);
  try
    SetStringHolder(LanguageDataModule.YesOrNoMultiStringHolder, 'AskYesOrNo');
    SetStringHolder(LanguageDataModule.MessageMultiStringHolder, 'Message');
    SetStringHolder(LanguageDataModule.ErrorMessageMultiStringHolder, 'ErrorMessage');
    SetStringHolder(LanguageDataModule.WarningMessageMultiStringHolder, 'WarningMessage');
    SetStringHolder(LanguageDataModule.ConstantMultiStringHolder, 'Constant');
    SetStringHolder(LanguageDataModule.FileTypesMultiStringHolder, 'FileTypes');
  finally
    BigIniFile.Free;
  end;

  { message dialog captions and buttons }
  HookResourceString(@SMsgDlgWarning, LanguageDataModule.GetPConstant('SMsgDlgWarning'));
  HookResourceString(@SMsgDlgError, LanguageDataModule.GetPConstant('SMsgDlgError'));
  HookResourceString(@SMsgDlgInformation, LanguageDataModule.GetPConstant('SMsgDlgInformation'));
  HookResourceString(@SMsgDlgConfirm, LanguageDataModule.GetPConstant('SMsgDlgConfirm'));
  HookResourceString(@SMsgDlgYes, LanguageDataModule.GetPConstant('SMsgDlgYes'));
  HookResourceString(@SMsgDlgNo, LanguageDataModule.GetPConstant('SMsgDlgNo'));
  HookResourceString(@SMsgDlgOK, LanguageDataModule.GetPConstant('SMsgDlgOK'));
  HookResourceString(@SMsgDlgCancel, LanguageDataModule.GetPConstant('SMsgDlgCancel'));
  HookResourceString(@SMsgDlgHelp, LanguageDataModule.GetPConstant('SMsgDlgHelp'));
  HookResourceString(@SMsgDlgHelpNone, LanguageDataModule.GetPConstant('SMsgDlgHelpNone'));
  HookResourceString(@SMsgDlgHelpHelp, LanguageDataModule.GetPConstant('SMsgDlgHelpHelp'));
  HookResourceString(@SMsgDlgAbort, LanguageDataModule.GetPConstant('SMsgDlgAbort'));
  HookResourceString(@SMsgDlgRetry, LanguageDataModule.GetPConstant('SMsgDlgRetry'));
  HookResourceString(@SMsgDlgIgnore, LanguageDataModule.GetPConstant('SMsgDlgIgnore'));
  HookResourceString(@SMsgDlgAll, LanguageDataModule.GetPConstant('SMsgDlgAll'));
  HookResourceString(@SMsgDlgNoToAll, LanguageDataModule.GetPConstant('SMsgDlgNoToAll'));
  HookResourceString(@SMsgDlgYesToAll, LanguageDataModule.GetPConstant('SMsgDlgYesToAll'));
  HookResourceString(@SMsgDlgClose, LanguageDataModule.GetPConstant('SMsgDlgClose'));
end;

function TLanguageDataModule.GetYesOrNoMessage(Name: string): string;
begin
  Result := Trim(YesOrNoMultiStringHolder.StringsByName[Name].Text);
end;

function TLanguageDataModule.GetMessage(Name: string): string;
begin
  Result := Trim(MessageMultiStringHolder.StringsByName[Name].Text);
end;

function TLanguageDataModule.GetErrorMessage(Name: string): string;
begin
  Result := Trim(ErrorMessageMultiStringHolder.StringsByName[Name].Text);
end;

function TLanguageDataModule.GetWarningMessage(Name: string): string;
begin
  Result := Trim(WarningMessageMultiStringHolder.StringsByName[Name].Text);
end;

function TLanguageDataModule.GetFileTypes(Name: string): string;
begin
  Result := Trim(FileTypesMultiStringHolder.StringsByName[Name].Text);
end;

function TLanguageDataModule.GetConstant(Name: string): string;
begin
  Result := Trim(ConstantMultiStringHolder.StringsByName[Name].Text);
end;

function TLanguageDataModule.GetConvertConstant(Name: string): string;
begin
  Result := Trim(ConvertConstantMultiStringHolder.StringsByName[Name].Text);
end;

function TLanguageDataModule.GetPConstant(Name: string): PWideChar;
var
  Constant: string;
begin
  Constant := GetConstant(Name);
  GetMem(Result, SizeOf(WideChar) * Succ(Length(Constant)));
  StringToWideChar(Constant, Result, Length(Constant) + 1);
end;

initialization

  LanguageDataModule := TLanguageDataModule.Create(nil);

finalization

  LanguageDataModule.Free;

end.
