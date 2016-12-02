unit BCCommon.Messages;

interface

uses
  Vcl.Controls, System.UITypes;

function AskYesOrNo(const AMsg: string; const AOwner: TWinControl = nil): Boolean;
function AskYesOrNoAll(const AMsg: string): Integer;
function MessageDialog(const AMsg: string; ADlgType: TMsgDlgType; AButtons: TMsgDlgButtons;
  AButtonCaptions: array of string; const ACaption: string; const AOwner: TWinControl = nil): Integer;
function SaveChanges(IncludeCancel: Boolean = True): Integer;
procedure MessageBeep;
procedure ShowErrorMessage(const AMsg: string);
procedure ShowMessage(const AMsg: string);
procedure ShowWarningMessage(const AMsg: string);

implementation

uses
  Winapi.Windows, System.Math, System.Types, Vcl.ExtCtrls, Vcl.Graphics, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  BCCommon.Language.Strings, BCCommon.Utils;

type
  TButtonProxy = class(TButton)
  public
    function TextWidth(const AText: string): Integer;
  end;

{ TButtonProxy }

function TButtonProxy.TextWidth(const AText: string): Integer;
const
  WordBreak: array[Boolean] of Cardinal = (0, DT_WORDBREAK);
var
  LDC: HDC;
  LSize: TSize;
begin
  LDC := GetDC(Handle);
  try
    FillChar(LSize, SizeOf(TSize), 0);
    if GetTextExtentPoint32(LDC, AText, Length(AText), LSize) then
      Result := LSize.cX
    else
      Result := 0;
  finally
    ReleaseDC(Handle, LDC);
  end;
end;

procedure MessageBeep;
begin
  Winapi.Windows.MessageBeep(MB_ICONASTERISK);
end;

function MessageDialog(const AMsg: string; ADlgType: TMsgDlgType; AButtons: TMsgDlgButtons;
  AButtonCaptions: array of string; const ACaption: string; const AOwner: TWinControl = nil): Integer;

  function GetButtonCount: Integer;
  var
    LMsgDlgButton: TMsgDlgBtn;
  begin
    Result := 0;
    for LMsgDlgButton in AButtons do
      Inc(Result);
  end;

  function GetButtonWidth(const AForm: TCustomForm; const AButtonCaptions: array of string;
    const AMinButtonWidth: Integer; out AFirstButton: TButton): Integer;
  var
    i: Integer;
    LButtonCaption: string;
  begin
    for i := 0 to AForm.ComponentCount - 1 Do
    begin
      if AForm.Components[i] is TButton then
      begin
        AFirstButton := AForm.Components[i] as TButton;
        Break;
      end;
    end;

    if Assigned(AFirstButton) then
    begin
      Result := AMinButtonWidth;
      for LButtonCaption in AButtonCaptions do
        Result := Max(Result, TButtonProxy(AFirstButton).TextWidth(LButtonCaption));
    end
    else
      Result := AMinButtonWidth;
  end;

  function GetCaptionTextWidth(const ACanvas: TCanvas; const ACaption: string): Integer;
  var
    LNonClientMetrics: TNonClientMetrics;
    LCanvasFontName: TFontName;
    LCanvasFontHeight: Integer;
    LCanvasFontStyle: TFontStyles;
  begin
    LCanvasFontName := ACanvas.Font.Name;
    LCanvasFontHeight := ACanvas.Font.Height;
    LCanvasFontStyle := ACanvas.Font.Style;
    try
      LNonClientMetrics.cbSize := TNonClientMetrics.SizeOf;
      SystemParametersInfo(SPI_GETNONCLIENTMETRICS, TNonClientMetrics.SizeOf, @LNonClientMetrics, 0);
      ACanvas.Font.Height := LNonClientMetrics.lfCaptionFont.lfHeight;
      ACanvas.Font.Name := LNonClientMetrics.lfCaptionFont.lfFaceName;
      ACanvas.Font.Style := [];
      if LNonClientMetrics.lfCaptionFont.lfWeight > FW_REGULAR then
        ACanvas.Font.Style := [fsBold];
      Result := ACanvas.TextWidth(ACaption);
    finally
      ACanvas.Font.Name := LCanvasFontName;
      ACanvas.Font.Size := LCanvasFontHeight;
      ACanvas.Font.Style := LCanvasFontStyle;
    end;
  end;

const
  CMIN_BUTTON_WIDTH: Integer = 80;
  CBUTTON_SPACING = 4;
var
  I, LCaptionIndex, LButtonLeft: Integer;
  LButtonWidth: Integer;
  LButton: TButton;
  LButtonCount: Integer;
  LButtonsWidthNeeded: Integer;
  LButtonMinOuterMargin: Integer;
  LCaptionMargin: Integer;
  LButtonBottom: Integer;
  LFormWidth: Integer;
  LForm: TForm;
begin
  LForm := CreateMessageDialog(AMsg, ADlgType, AButtons, mbCancel);
  with LForm do
  try
    Caption := ACaption;
    Color := clWindow;
    LCaptionIndex := 0;
    LButtonCount := GetButtonCount;
    LButtonWidth := GetButtonWidth(LForm, AButtonCaptions, CMIN_BUTTON_WIDTH, LButton);

    if Assigned(AOwner) then
    begin
      Left := AOwner.Left + (AOwner.Width - Width) div 2;
      Top := AOwner.Top + (AOwner.Height - Height) div 2;
    end
    else
      Position := poMainFormCenter;

    for I := 0 to ControlCount - 1 do
      if Controls[I].Name = 'Image' then
      begin
        TImage(Controls[I]).Stretch := True;
        Break;
      end;

    LButtonBottom := LButton.Top + LButton.Height;
    LButtonMinOuterMargin := ClientHeight - LButtonBottom;
    LButtonsWidthNeeded := LButtonWidth * LButtonCount + CBUTTON_SPACING * (LButtonCount - 1);
    LFormWidth := Max(ClientWidth, LButtonsWidthNeeded + LButtonMinOuterMargin * 2);
    LCaptionMargin := GetSystemMetrics(SM_CXSIZE) + GetSystemMetrics(SM_CXFIXEDFRAME);
    LFormWidth := Max(LFormWidth, GetCaptionTextWidth(Canvas, ACaption) + LCaptionMargin);
    ClientWidth := LFormWidth;
    ClientHeight := Max(ClientHeight, LButtonMinOuterMargin + LButtonBottom);

    LButtonLeft := (ClientWidth - LButtonsWidthNeeded) div 2;
    for I := 0 to ComponentCount - 1 Do
    if Components[I] is TButton then
    begin
      LButton := TButton(Components[I]);
      LButton.Width := LButtonWidth;
      LButton.SetBounds(LButtonLeft, LButton.Top, LButton.Width, LButton.Height);
      Inc(LButtonLeft, LButton.Width + CBUTTON_SPACING);
      if LCaptionIndex <= High(AButtonCaptions) then
        LButton.Caption := AButtonCaptions[LCaptionIndex];
      Inc(LCaptionIndex);
    end;
    Result := Showmodal;
  finally
    Free;
  end;
end;

function AskYesOrNo(const AMsg: string; const AOwner: TWinControl = nil): Boolean;
begin
  Result := MessageDialog(AMsg, mtConfirmation, [mbYes, mbNo], [], LanguageDataModule.GetConstant('Confirmation'), AOwner) = mrYes;
end;

function AskYesOrNoAll(const AMsg: string): Integer;
begin
  Result := MessageDialog(AMsg, mtConfirmation, [mbYes, mbYesToAll, mbNo, mbNoToAll], [], LanguageDataModule.GetConstant('Confirmation'));
end;

function SaveChanges(IncludeCancel: Boolean): Integer;
var
  Buttons: TMsgDlgButtons;
begin
  Buttons := [mbYes, mbNO];
  if IncludeCancel then
    Buttons := Buttons + [mbCancel];

  Result := MessageDialog(LanguageDataModule.GetYesOrNoMessage('SaveChanges'), mtConfirmation, Buttons,
    [], LanguageDataModule.GetConstant('Confirmation'));
end;

procedure ShowMessage(const AMsg: string);
begin
  MessageDialog(AMsg, mtInformation, [mbOK], [], LanguageDataModule.GetConstant('Information'));
end;

procedure ShowErrorMessage(const AMsg: string);
begin
  MessageDialog(AMsg, mtError, [mbOK], [], LanguageDataModule.GetConstant('Error'));
end;

procedure ShowWarningMessage(const AMsg: string);
begin
  MessageDialog(AMsg, mtWarning, [mbOK], [], LanguageDataModule.GetConstant('Warning'));
end;

end.
