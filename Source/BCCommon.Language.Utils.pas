unit BCCommon.Language.Utils;

interface

uses
  Vcl.Forms;

function GetSelectedLanguage(Default: string = ''): string;
procedure UpdateLanguage(Form: TForm; SelectedLanguage: string = ''); overload;

implementation

uses
  BigIni, BCCommon.FileUtils, System.SysUtils, System.IniFiles, Vcl.StdCtrls, Vcl.ActnList, Vcl.Menus, Vcl.ComCtrls,
  Vcl.ExtCtrls, VirtualTrees, BCCommon.Language.Strings, BCControls.CheckBox, sPageControl,
  BCControls.GroupBox, BCControls.RadioButton, BCControls.Panel, BCControls.Edit,
  BCControls.DateEdit, BCControls.ComboBox;

function GetSelectedLanguage(Default: string): string;
begin
  with TBigIniFile.Create(GetIniFilename) do
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
      if Form.Components[i] is TBCCheckBox then
      begin
        s := ReadString(Form.Name, TBCCheckBox(Form.Components[i]).Name, '');
        if s <> '' then
          TBCCheckBox(Form.Components[i]).Caption := Format(' %s', [s]);
      end
      else
      if Form.Components[i] is TBCRadioButton then
      begin
        s := ReadString(Form.Name, TBCRadioButton(Form.Components[i]).Name, '');
        if s <> '' then
          TBCRadioButton(Form.Components[i]).Caption := Format(' %s', [s]);
      end
      else
      if Form.Components[i] is TBCGroupBox then
      begin
        s := ReadString(Form.Name, TGroupBox(Form.Components[i]).Name, '');
        if s <> '' then
          TGroupBox(Form.Components[i]).Caption := s;
      end
      else
      if Form.Components[i] is TBCPanel then
      begin
        s := ReadString(Form.Name, TBCPanel(Form.Components[i]).Name, '');
        if s <> '' then
          TBCPanel(Form.Components[i]).Caption := Format(' %s ', [s])
      end
      else
      if Form.Components[i] is TBCEdit then
      begin
        s := ReadString(Form.Name, TBCEdit(Form.Components[i]).Name, '');
        if s <> '' then
          TBCEdit(Form.Components[i]).Caption := s
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
      if Form.Components[i] is TsTabSheet then
      begin
        s := ReadString(Form.Name, TsTabSheet(Form.Components[i]).Name, '');
        if s <> '' then
          TsTabSheet(Form.Components[i]).Caption := s
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
        s := ReadString(Form.Name, Format('%s:h', [TVirtualDrawTree(Form.Components[i]).Name]), '');
        if s <> '' then
          TVirtualDrawTree(Form.Components[i]).Hint := s;
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

end.

