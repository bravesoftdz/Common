unit BCCommon.Messages;

interface

uses
  System.UITypes;

function AskYesOrNo(Msg: string): Boolean;
function MessageDialog(const Msg: string; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; Captions: array of string): Integer;
function SaveChanges(IncludeCancel: Boolean = True): Integer;
procedure MessageBeep;
procedure ShowErrorMessage(Msg: string);
procedure ShowMessage(Msg: string);
procedure ShowWarningMessage(Msg: string);

implementation

uses
  Winapi.Windows, Vcl.Dialogs, Vcl.Forms, Vcl.StdCtrls, BCCommon.Language;

function AskYesOrNo(Msg: string): Boolean;
begin
  with CreateMessageDialog(Msg, mtConfirmation, [mbYes, mbNo]) do
  try
    HelpContext := 0;
    HelpFile := '';
    Position := poMainFormCenter;
    Result := ShowModal = mrYes;
  finally
    Free;
  end
end;

function MessageDialog(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; Captions: array of string): Integer;
var
  i: Integer;
  dlgButton: TButton;
  CaptionIndex: Integer;
begin
  { Create the Dialog }
  with CreateMessageDialog(Msg, DlgType, Buttons) do
  try
    HelpContext := 0;
    HelpFile := '';
    CaptionIndex := 0;
    { Loop through Objects in Dialog }
    for i := 0 to ComponentCount - 1 do
    begin
     { If the object is of type TButton, then }
      if (Components[i] is TButton) then
      begin
        dlgButton := TButton(Components[i]);
        if CaptionIndex > High(Captions) then Break;
        { Give a new caption from our Captions array}
        dlgButton.Caption := Captions[CaptionIndex];
        Inc(CaptionIndex);
      end;
    end;
    Position := poMainFormCenter;
    Result := ShowModal;
  finally
    Free;
  end;
end;

function SaveChanges(IncludeCancel: Boolean): Integer;
var
  Buttons: TMsgDlgButtons;
begin
  Buttons := [mbYes, mbNO];
  if IncludeCancel then
    Buttons := Buttons + [mbCancel];

  with CreateMessageDialog(LanguageDataModule.GetYesOrNo('SaveChanges'), mtConfirmation, Buttons) do
  try
    HelpContext := 0;
    HelpFile := '';
    Position := poMainFormCenter;
    Result := ShowModal;
  finally
    Free;
  end
end;

procedure MessageBeep;
begin
  Winapi.Windows.MessageBeep(MB_ICONASTERISK);
end;

procedure ShowMessage(Msg: string);
begin
  with CreateMessageDialog(Msg, mtInformation, [mbOK]) do
  try
    HelpContext := 0;
    HelpFile := '';
    Position := poMainFormCenter;
    ShowModal;
  finally
    Free;
  end
end;

procedure ShowErrorMessage(Msg: string);
begin
  with CreateMessageDialog(Msg, mtError, [mbOK]) do
  try
    HelpContext := 0;
    HelpFile := '';
    Position := poMainFormCenter;
    ShowModal;
  finally
    Free;
  end
end;

procedure ShowWarningMessage(Msg: string);
begin
  with CreateMessageDialog(Msg, mtWarning, [mbOK]) do
  try
    HelpContext := 0;
    HelpFile := '';
    Position := poMainFormCenter;
    ShowModal;
  finally
    Free;
  end
end;

end.
