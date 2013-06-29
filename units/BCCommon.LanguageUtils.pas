unit BCCommon.LanguageUtils;

interface

uses
  Vcl.Forms;

function GetSelectedLanguage(Default: string = ''): string;
procedure UpdateLanguage(Form: TForm; SelectedLanguage: string = ''); overload;
procedure UpdateLanguage(Frame: TFrame; SelectedLanguage: string = ''); overload;

implementation

uses
  BigIni, BCCommon.Files, System.SysUtils, System.IniFiles, Vcl.StdCtrls, Vcl.ActnList, Vcl.Menus, Vcl.ComCtrls,
  Vcl.ExtCtrls, VirtualTrees;

function GetSelectedLanguage(Default: string): string;
begin
  with TBigIniFile.Create(GetINIFilename) do
  try
    Result := ReadString('Options', 'Language', Default);
  finally
    Free;
  end;
end;

procedure UpdateLanguage(Form: TForm; SelectedLanguage: string);
var
  i, j: Integer;
  s: string;
  LanguagePath: string;
begin
  if SelectedLanguage = '' then
    SelectedLanguage := GetSelectedLanguage;
  if SelectedLanguage = '' then
    Exit;
  LanguagePath := IncludeTrailingPathDelimiter(Format('%s%s', [ExtractFilePath(ParamStr(0)), 'Languages']));
  if not DirectoryExists(LanguagePath) then
    Exit;

  with TMemIniFile.Create(Format('%s%s.%s', [LanguagePath, SelectedLanguage, 'lng']), TEncoding.Unicode) do
  try
    s := ReadString(Form.Name, 'Caption', '');
    if s <> '' then
      Form.Caption := s;
    for i := 0 to Form.ComponentCount - 1 do
      if Form.Components[i] is TButton then
      begin
        s := ReadString(Form.Name, TButton(Form.Components[i]).Name, '');
        if s <> '' then
          TButton(Form.Components[i]).Caption := s
      end
      else
      if Form.Components[i] is TLabel then
      begin
        s := ReadString(Form.Name, TLabel(Form.Components[i]).Name, '');
        if s <> '' then
          TLabel(Form.Components[i]).Caption := s
      end
      else
      if Form.Components[i] is TCheckBox then
      begin
        s := ReadString(Form.Name, TCheckBox(Form.Components[i]).Name, '');
        if s <> '' then
          TCheckBox(Form.Components[i]).Caption := Format(' %s', [s]);
      end
      else
      if Form.Components[i] is TGroupBox then
      begin
        s := ReadString(Form.Name, TGroupBox(Form.Components[i]).Name, '');
        if s <> '' then
          TGroupBox(Form.Components[i]).Caption := Format(' %s ', [s])
      end
      else
      if Form.Components[i] is TAction then
      begin
        s := ReadString(Form.Name, TAction(Form.Components[i]).Name, '');
        if (TAction(Form.Components[i]).Caption <> '') and (s <> '') then
          TAction(Form.Components[i]).Caption := s;
        s := ReadString(Form.Name, Format('%s:s', [TAction(Form.Components[i]).Name]), '');
        if s <> '' then
          TAction(Form.Components[i]).ShortCut := TextToShortCut(s);
        s := ReadString(Form.Name, Format('%s:h', [TAction(Form.Components[i]).Name]), '');
        if s <> '' then
          TAction(Form.Components[i]).Hint := s
      end
      else
      if Form.Components[i] is TTabSheet then
      begin
        s := ReadString(Form.Name, TTabSheet(Form.Components[i]).Name, '');
        if s <> '' then
          TTabSheet(Form.Components[i]).Caption := s
      end
      else
      if Form.Components[i] is TRadioGroup then
      begin
        s := ReadString(Form.Name, TRadioGroup(Form.Components[i]).Name, '');
        if s <> '' then
        begin
          TRadioGroup(Form.Components[i]).Caption := s;
          TRadioGroup(Form.Components[i]).Items.Clear;
          j := 0;
          repeat
            s := ReadString(Form.Name, Format('%s%d', [TRadioGroup(Form.Components[i]).Name, j]), '');
            if s <> '' then
              begin
              TRadioGroup(Form.Components[i]).Items.Add(s);
              Inc(j);
            end;
          until s = '';
        end;
      end
      else
      if Form.Components[i] is TVirtualDrawTree then
      begin
        for j := 0 to TVirtualDrawTree(Form.Components[i]).Header.Columns.Count - 1 do
        begin
          s := ReadString(Form.Name, Format('%s:%d', [TVirtualDrawTree(Form.Components[i]).Name, j]), '');
          if s <> '' then
            TVirtualDrawTree(Form.Components[i]).Header.Columns[j].Text := s;
        end;
      end
  finally
    Free;
  end;
end;

procedure UpdateLanguage(Frame: TFrame; SelectedLanguage: string);
var
  i, j: Integer;
  s: string;
  LanguagePath: string;
begin
  if not Assigned(Frame) then
    Exit;
  if SelectedLanguage = '' then
    SelectedLanguage := GetSelectedLanguage;
  if SelectedLanguage = '' then
    Exit;
  LanguagePath := IncludeTrailingPathDelimiter(Format('%s%s', [ExtractFilePath(ParamStr(0)), 'Languages']));
  if not DirectoryExists(LanguagePath) then
    Exit;

  with TMemIniFile.Create(Format('%s%s.%s', [LanguagePath, SelectedLanguage, 'lng']), TEncoding.Unicode) do
  try
    for i := 0 to Frame.ComponentCount - 1 do
      if Frame.Components[i] is TButton then
      begin
        s := ReadString(Frame.Name, TButton(Frame.Components[i]).Name, '');
        if s <> '' then
          TButton(Frame.Components[i]).Caption := s
      end
      else
      if Frame.Components[i] is TLabel then
      begin
        s := ReadString(Frame.Name, TLabel(Frame.Components[i]).Name, '');
        if s <> '' then
          TLabel(Frame.Components[i]).Caption := s
      end
      else
      if Frame.Components[i] is TCheckBox then
      begin
        s := ReadString(Frame.Name, TCheckBox(Frame.Components[i]).Name, '');
        if s <> '' then
          TCheckBox(Frame.Components[i]).Caption := Format(' %s', [s]);
      end
      else
      if Frame.Components[i] is TGroupBox then
      begin
        s := ReadString(Frame.Name, TGroupBox(Frame.Components[i]).Name, '');
        if s <> '' then
          TGroupBox(Frame.Components[i]).Caption := Format(' %s ', [s])
      end
      else
      if Frame.Components[i] is TAction then
      begin
        s := ReadString(Frame.Name, TAction(Frame.Components[i]).Name, '');
        if (TAction(Frame.Components[i]).Caption <> '') and (s <> '') then
          TAction(Frame.Components[i]).Caption := s;
        s := ReadString(Frame.Name, Format('%s:s', [TAction(Frame.Components[i]).Name]), '');
        if s <> '' then
          TAction(Frame.Components[i]).ShortCut := TextToShortCut(s);
        s := ReadString(Frame.Name, Format('%s:h', [TAction(Frame.Components[i]).Name]), '');
        if s <> '' then
          TAction(Frame.Components[i]).Hint := s
      end
      else
      if Frame.Components[i] is TTabSheet then
      begin
        s := ReadString(Frame.Name, TTabSheet(Frame.Components[i]).Name, '');
        if s <> '' then
          TTabSheet(Frame.Components[i]).Caption := s
      end
      else
      if Frame.Components[i] is TRadioGroup then
      begin
        s := ReadString(Frame.Name, TRadioGroup(Frame.Components[i]).Name, '');
        if s <> '' then
        begin
          TRadioGroup(Frame.Components[i]).Caption := s;
          TRadioGroup(Frame.Components[i]).Items.Clear;
          j := 0;
          repeat
            s := ReadString(Frame.Name, Format('%s%d', [TRadioGroup(Frame.Components[i]).Name, j]), '');
            if s <> '' then
            begin
              TRadioGroup(Frame.Components[i]).Items.Add(s);
              Inc(j);
            end;
          until s = '';
        end
      end
      else
      if Frame.Components[i] is TVirtualDrawTree then
      begin
        for j := 0 to TVirtualDrawTree(Frame.Components[i]).Header.Columns.Count - 1 do
        begin
          s := ReadString(Frame.Name, Format('%s:%d', [TVirtualDrawTree(Frame.Components[i]).Name, j]), '');
          if s <> '' then
            TVirtualDrawTree(Frame.Components[i]).Header.Columns[j].Text := s;
        end;
      end
  finally
    Free;
  end;
end;


end.