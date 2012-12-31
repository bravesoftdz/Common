unit Language;

interface

uses
  System.SysUtils, System.Classes, JvStringHolder, Vcl.ActnMenus;

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

procedure ReadLanguageFile(Language: string; ActionMainMenuBar: TActionMainMenuBar);

var
  LanguageDataModule: TLanguageDataModule;

implementation

{$R *.dfm}

uses
  Vcl.ActnList, Vcl.Menus, BigINI;

procedure ReadLanguageFile(Language: string; ActionMainMenuBar: TActionMainMenuBar);
var
  i, j, k: Integer;
  BigIniFile: TBigIniFile;
  Action: TContainedAction;

  procedure ReadMenuItem(Key: string);
  var
    MenuItem, ShortCut, Hint: string;
  begin
    if not Assigned(Action) then
      Exit;
    MenuItem := BigIniFile.ReadString('MainMenu', Key, '');
    if MenuItem <> '' then
      TAction(Action).Caption := MenuItem;
    ShortCut := BigIniFile.ReadString('MainMenu', Format('%ss', [Key]), '');
    if ShortCut <> '' then
      TAction(Action).ShortCut := TextToShortCut(ShortCut);
    Hint := BigIniFile.ReadString('MainMenu', Format('%sh', [Key]), '');
    if Hint <> '' then
      TAction(Action).Hint := Hint;
  end;

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

  BigIniFile := TBigIniFile.Create(Format('%sLanguages\%s.%s', [ExtractFilePath(ParamStr(0)), Language, 'lng']));
  try
    { main menu  }
    for i := 0 to ActionMainMenuBar.ActionClient.Items.Count - 1 do
    begin
      ActionMainMenuBar.ActionClient.Items[i].Caption := BigIniFile.ReadString('MainMenu', IntToStr(i), '');
      for j := 0 to ActionMainMenuBar.ActionClient.Items[i].Items.Count - 1 do
      begin
        Action := ActionMainMenuBar.ActionClient.Items[i].Items[j].Action;
        ReadMenuItem(Format('%d:%d', [i, j]));
        for k := 0 to ActionMainMenuBar.ActionClient.Items[i].Items[j].Items.Count - 1 do
        begin
          Action := ActionMainMenuBar.ActionClient.Items[i].Items[j].Items[k].Action;
          ReadMenuItem(Format('%d:%d:%d', [i, j, k]));
        end;
      end;
    end;
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
