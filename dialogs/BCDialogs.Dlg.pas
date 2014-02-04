unit BCDialogs.Dlg;

interface

uses
  System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms;

type
  TDialogType = (dtOpen, dtEdit);

  TDialog = class(TForm)
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FOrigHeight: Integer;
    FOrigWidth: Integer;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    property OrigHeight: Integer read FOrigHeight write FOrigHeight;
    property OrigWidth: Integer read FOrigWidth write FOrigWidth;
  end;

implementation

{$R *.dfm}

uses
  BCCommon.LanguageUtils;

constructor TDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FOrigWidth := Width;
  FOrigHeight := Height;
end;

procedure TDialog.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0; { no beep }
    Close;
  end;
end;

procedure TDialog.FormShow(Sender: TObject);
begin
  BCCommon.LanguageUtils.UpdateLanguage(Self);
end;

end.
