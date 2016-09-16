unit BCCommon.Dialog.Popup.SearchEngine;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sRadioButton, BCControl.RadioButton;

type
  TBCPopupSearchEngineDialog = class(TForm)
    procedure BCRadioButton1Click(Sender: TObject);
  private
    { Private declarations }
    procedure WMActivate(var AMessage: TWMActivate); message WM_ACTIVATE;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TBCPopupSearchEngineDialog.BCRadioButton1Click(Sender: TObject);
begin
  Close
end;

procedure TBCPopupSearchEngineDialog.WMActivate(var AMessage: TWMActivate);
begin
  if AMessage.Active <> WA_INACTIVE then
    SendMessage(Self.PopupParent.Handle, WM_NCACTIVATE, WPARAM(True), -1);

  inherited;
end;

end.
