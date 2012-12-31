unit Dlg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TDialog = class(TForm)
  private
    { Private declarations }
    FOrigWidth: Integer;
    FOrigHeight: Integer;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure UpdateLanguage;
    property OrigWidth: Integer read FOrigWidth write FOrigWidth;
    property OrigHeight: Integer read FOrigHeight write FOrigHeight;
  end;

implementation

{$R *.dfm}

uses
  Vcl.StdCtrls, Common, BigINI;

constructor TDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FOrigWidth := Width;
  FOrigHeight := Height;
end;

procedure TDialog.UpdateLanguage;
var
  i: Integer;
  s: string;
  SelectedLanguage, LanguagePath: string;
begin
  SelectedLanguage := Common.GetSelectedLanguage;
  if SelectedLanguage = '' then
    Exit;
  LanguagePath := IncludeTrailingPathDelimiter(Format('%s%s', [ExtractFilePath(ParamStr(0)), 'Languages']));
  if not DirectoryExists(LanguagePath) then
    Exit;

  with TBigIniFile.Create(Format('%s%s.%s', [LanguagePath, SelectedLanguage, 'lng'])) do
  try
    Caption := ReadString(Self.Name, 'Caption', '');
    for i := 0 to Self.ComponentCount - 1 do
      if Self.Components[i] is TButton then
      begin
        s := ReadString(Self.Name, TButton(Self.Components[i]).Name, '');
        if s <> '' then
          TButton(Self.Components[i]).Caption := s
      end
      else
      if Self.Components[i] is TLabel then
      begin
        s := ReadString(Self.Name, TLabel(Self.Components[i]).Name, '');
        if s <> '' then
          TLabel(Self.Components[i]).Caption := s
      end
  finally
    Free;
  end;
end;

end.
