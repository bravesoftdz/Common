unit Dlg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms;

type
  TDialog = class(TForm)
    procedure FormShow(Sender: TObject);
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
  Common;

constructor TDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FOrigWidth := Width;
  FOrigHeight := Height;
end;

procedure TDialog.FormShow(Sender: TObject);
begin
  Common.UpdateLanguage(Self);
end;

end.
