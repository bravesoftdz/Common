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
    property OrigWidth: Integer read FOrigWidth write FOrigWidth;
    property OrigHeight: Integer read FOrigHeight write FOrigHeight;
  end;

implementation

{$R *.dfm}

constructor TDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FOrigWidth := Width;
  FOrigHeight := Height;
end;

end.
