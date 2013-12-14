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
    SQLFormatterMultiStringHolder: TBCMultiStringHolder;
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
    function GetSQLFormatter(Name: string): string;
  end;

procedure ReadLanguageFile(Language: string);

var
  LanguageDataModule: TLanguageDataModule;

implementation

{$R *.dfm}

uses
  Windows, Consts, Vcl.ActnList, System.IniFiles;

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
    SetStringHolder(LanguageDataModule.ConvertConstantMultiStringHolder, 'ConvertConstant');
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

  HookResourceString(@SColorBoxCustomCaption, LanguageDataModule.GetPConstant('SColorBoxCustomCaption'));
  HookResourceString(@SNameBlack, LanguageDataModule.GetPConstant('SNameBlack'));
  HookResourceString(@SNameMaroon, LanguageDataModule.GetPConstant('SNameMaroon'));
  HookResourceString(@SNameGreen, LanguageDataModule.GetPConstant('SNameGreen'));
  HookResourceString(@SNameOlive, LanguageDataModule.GetPConstant('SNameOlive'));
  HookResourceString(@SNameNavy, LanguageDataModule.GetPConstant('SNameNavy'));
  HookResourceString(@SNamePurple, LanguageDataModule.GetPConstant('SNamePurple'));
  HookResourceString(@SNameTeal, LanguageDataModule.GetPConstant('SNameTeal'));
  HookResourceString(@SNameGray, LanguageDataModule.GetPConstant('SNameGray'));
  HookResourceString(@SNameSilver, LanguageDataModule.GetPConstant('SNameSilver'));
  HookResourceString(@SNameRed, LanguageDataModule.GetPConstant('SNameRed'));
  HookResourceString(@SNameLime, LanguageDataModule.GetPConstant('SNameLime'));
  HookResourceString(@SNameYellow, LanguageDataModule.GetPConstant('SNameYellow'));
  HookResourceString(@SNameBlue, LanguageDataModule.GetPConstant('SNameBlue'));
  HookResourceString(@SNameFuchsia, LanguageDataModule.GetPConstant('SNameFuchsia'));
  HookResourceString(@SNameAqua, LanguageDataModule.GetPConstant('SNameAqua'));
  HookResourceString(@SNameWhite, LanguageDataModule.GetPConstant('SNameWhite'));
  HookResourceString(@SNameMoneyGreen, LanguageDataModule.GetPConstant('SNameMoneyGreen'));
  HookResourceString(@SNameSkyBlue, LanguageDataModule.GetPConstant('SNameSkyBlue'));
  HookResourceString(@SNameCream, LanguageDataModule.GetPConstant('SNameCream'));
  HookResourceString(@SNameMedGray, LanguageDataModule.GetPConstant('SNameMedGray'));
  HookResourceString(@SNameActiveBorder, LanguageDataModule.GetPConstant('SNameActiveBorder'));
  HookResourceString(@SNameActiveCaption, LanguageDataModule.GetPConstant('SNameActiveCaption'));
  HookResourceString(@SNameAppWorkSpace, LanguageDataModule.GetPConstant('SNameAppWorkSpace'));
  HookResourceString(@SNameBackground, LanguageDataModule.GetPConstant('SNameBackground'));
  HookResourceString(@SNameBtnFace, LanguageDataModule.GetPConstant('SNameBtnFace'));
  HookResourceString(@SNameBtnHighlight, LanguageDataModule.GetPConstant('SNameBtnHighlight'));
  HookResourceString(@SNameBtnShadow, LanguageDataModule.GetPConstant('SNameBtnShadow'));
  HookResourceString(@SNameBtnText, LanguageDataModule.GetPConstant('SNameBtnText'));
  HookResourceString(@SNameCaptionText, LanguageDataModule.GetPConstant('SNameCaptionText'));
  HookResourceString(@SNameDefault, LanguageDataModule.GetPConstant('SNameDefault'));
  HookResourceString(@SNameGradientActiveCaption, LanguageDataModule.GetPConstant('SNameGradientActiveCaption'));
  HookResourceString(@SNameGradientInactiveCaption, LanguageDataModule.GetPConstant('SNameGradientInactiveCaption'));
  HookResourceString(@SNameGrayText, LanguageDataModule.GetPConstant('SNameGrayText'));
  HookResourceString(@SNameHighlight, LanguageDataModule.GetPConstant('SNameHighlight'));
  HookResourceString(@SNameHighlightText, LanguageDataModule.GetPConstant('SNameHighlightText'));
  HookResourceString(@SNameHotLight, LanguageDataModule.GetPConstant('SNameHotLight'));
  HookResourceString(@SNameInactiveBorder, LanguageDataModule.GetPConstant('SNameInactiveBorder'));
  HookResourceString(@SNameInactiveCaption, LanguageDataModule.GetPConstant('SNameInactiveCaption'));
  HookResourceString(@SNameInactiveCaptionText, LanguageDataModule.GetPConstant('SNameInactiveCaptionText'));
  HookResourceString(@SNameInfoBk, LanguageDataModule.GetPConstant('SNameInfoBk'));
  HookResourceString(@SNameInfoText, LanguageDataModule.GetPConstant('SNameInfoText'));
  HookResourceString(@SNameMenu, LanguageDataModule.GetPConstant('SNameMenu'));
  HookResourceString(@SNameMenuBar, LanguageDataModule.GetPConstant('SNameMenuBar'));
  HookResourceString(@SNameMenuHighlight, LanguageDataModule.GetPConstant('SNameMenuHighlight'));
  HookResourceString(@SNameMenuText, LanguageDataModule.GetPConstant('SNameMenuText'));
  HookResourceString(@SNameNone, LanguageDataModule.GetPConstant('SNameNone'));
  HookResourceString(@SNameScrollBar, LanguageDataModule.GetPConstant('SNameScrollBar'));
  HookResourceString(@SName3DDkShadow, LanguageDataModule.GetPConstant('SName3DDkShadow'));
  HookResourceString(@SName3DLight, LanguageDataModule.GetPConstant('SName3DLight'));
  HookResourceString(@SNameWindow, LanguageDataModule.GetPConstant('SNameWindow'));
  HookResourceString(@SNameWindowFrame, LanguageDataModule.GetPConstant('SNameWindowFrame'));
  HookResourceString(@SNameWindowText, LanguageDataModule.GetPConstant('SNameWindowText'));
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

function TLanguageDataModule.GetSQLFormatter(Name: string): string;
begin
  Result := Trim(SQLFormatterMultiStringHolder.StringsByName[Name].Text);
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
