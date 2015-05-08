unit BCCommon.Dialogs.ConfirmReplace;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, Vcl.ExtCtrls,
  BCCommon.Dialogs.Base, BCControls.Panel, sPanel;

type
  TConfirmReplaceDialog = class(TBCBaseDialog)
    ButtonCancel: TButton;
    ButtonNo: TButton;
    ButtonYes: TButton;
    ButtonYesToAll: TButton;
    Image: TImage;
    LabelConfirmation: TLabel;
    PanelBottom: TBCPanel;
    PanelClient: TBCPanel;
    procedure FormCreate(Sender: TObject);
  public
    class function ClassShowModal(AOwner: TComponent; AConfirmText: string): Integer;
  end;

implementation

{$R *.DFM}

class function TConfirmReplaceDialog.ClassShowModal(AOwner: TComponent; AConfirmText: string): Integer;
begin
  with TConfirmReplaceDialog.Create(AOwner) do
  try
    LabelConfirmation.Caption := AConfirmText;
    Result := ShowModal;
  finally
    Free;
  end;
end;

procedure TConfirmReplaceDialog.FormCreate(Sender: TObject);
begin
  Image.Picture.Icon.Handle := LoadIcon(0, IDI_QUESTION);
end;

end.
