unit BCCommon.Messages;

interface

uses
  System.UITypes, Vcl.Dialogs;

function AskYesOrNo(Msg: string): Boolean;
function MessageDialog(const Msg: string; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons): Integer;
function SaveChanges(IncludeCancel: Boolean = True): Integer;
procedure MessageBeep;
procedure ShowErrorMessage(Msg: string);
procedure ShowMessage(Msg: string; MsgDlgType: TMsgDlgType = mtInformation);
procedure ShowWarningMessage(Msg: string);

implementation

uses
  Winapi.Windows, Vcl.Forms, Vcl.StdCtrls, BCCommon.LanguageStrings;

procedure MessageBeep;
begin
  Winapi.Windows.MessageBeep(MB_ICONASTERISK);
end;

function MessageDialog(const Msg: string; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons): Integer;
begin
  { Create the Dialog }
  with CreateMessageDialog(Msg, DlgType, Buttons) do
  try
    HelpContext := 0;
    HelpFile := '';
    Position := poMainFormCenter;
    Result := ShowModal;
  finally
    Free;
  end;
end;

function AskYesOrNo(Msg: string): Boolean;
begin
  Result := MessageDialog(Msg, mtConfirmation, [mbYes, mbNo]) = mrYes;
end;

function SaveChanges(IncludeCancel: Boolean): Integer;
var
  Buttons: TMsgDlgButtons;
begin
  Buttons := [mbYes, mbNO];
  if IncludeCancel then
    Buttons := Buttons + [mbCancel];

  Result := MessageDialog(LanguageDataModule.GetYesOrNo('SaveChanges'), mtConfirmation, Buttons);
end;

procedure ShowMessage(Msg: string; MsgDlgType: TMsgDlgType);
begin
  MessageDialog(Msg, mtInformation, [mbOK]);
end;

procedure ShowErrorMessage(Msg: string);
begin
  MessageDialog(Msg, mtError, [mbOK]);
end;

procedure ShowWarningMessage(Msg: string);
begin
  MessageDialog(Msg, mtWarning, [mbOK]);
end;

end.
