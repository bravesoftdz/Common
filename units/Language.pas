unit Language;

interface

uses
  System.SysUtils, System.Classes, JvStringHolder;

type
  TLanguageDataModule = class(TDataModule)
    YesOrNoMultiStringHolder: TJvMultiStringHolder;
    MessageMultiStringHolder: TJvMultiStringHolder;
    ErrorMessageMultiStringHolder: TJvMultiStringHolder;
    WarningMessageMultiStringHolder: TJvMultiStringHolder;
    ConstantMultiStringHolder: TJvMultiStringHolder;
    FileTypesMultiStringHolder: TJvMultiStringHolder;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure ReadLanguageFile(Language: string);

var
  LanguageDataModule: TLanguageDataModule;

implementation

{$R *.dfm}

uses
  Vcl.ActnList, Vcl.Menus, BigINI;

procedure ReadLanguageFile(Language: string);
var
  LanguagePath: string;
  BigIniFile: TBigIniFile;

  procedure SetStringHolder(MultiStringHolder: TJvMultiStringHolder; Section: string);
  var
    i: Integer;
    StringName, s: string;
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

  BigIniFile := TBigIniFile.Create(Format('%s%s.%s', [LanguagePath, Language, 'lng']));
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
end;

initialization

  LanguageDataModule := TLanguageDataModule.Create(Nil);

end.
