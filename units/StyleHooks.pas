unit StyleHooks;

interface

uses
  Vcl.StdCtrls, Winapi.Messages, Vcl.Controls, SynEdit, Vcl.Styles, Vcl.Themes, Vcl.ComCtrls,
  Vcl.ExtCtrls, Vcl.Graphics, Vcl.Forms, JvProgressBar;

type
  TSynEditStyleHook = class(TMemoStyleHook)
  strict private
    procedure UpdateColors;
    procedure WMEraseBkgnd(var Message: TMessage); message WM_ERASEBKGND;
  strict protected
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AControl: TWinControl); override;
  end;

  TProgressBarStyleHookMarquee = class(TProgressBarStyleHook)
  private
    Timer : TTimer;
    FStep : Integer;
    procedure TimerAction(Sender: TObject);
  protected
    procedure PaintBar(Canvas: TCanvas); override;
  public
    constructor Create(AControl: TWinControl); override;
    destructor Destroy; override;
  end;

  procedure UpdateGutter(SynEdit: TSynEdit);
  function LightenColor(AColor: TColor): TColor;

implementation

uses
  Winapi.Windows, Math;

{ TSynEditStyleHook }

constructor TSynEditStyleHook.Create(AControl: TWinControl);
begin
  inherited;
  OverridePaintNC := True;
  OverrideEraseBkgnd := True;
  UpdateColors;
end;

procedure TSynEditStyleHook.WMEraseBkgnd(var Message: TMessage);
begin
  Handled := True;
end;

procedure TSynEditStyleHook.UpdateColors;
const
  ColorStates: array[Boolean] of TStyleColor = (scEditDisabled, scEdit);
  FontColorStates: array[Boolean] of TStyleFont = (sfEditBoxTextDisabled, sfEditBoxTextNormal);
var
  LStyle: TCustomStyleServices;
begin
  LStyle := StyleServices;
  Brush.Color := LStyle.GetStyleColor(ColorStates[Control.Enabled]);
  FontColor := LStyle.GetStyleFontColor(FontColorStates[Control.Enabled]);
end;

procedure TSynEditStyleHook.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    CM_ENABLEDCHANGED:
      begin
        UpdateColors;
        Handled := False; // Allow control to handle message
      end
  else
    inherited WndProc(Message);
  end;
end;

function LightenColor(AColor: TColor): TColor;
var
  r, g, b: Double;
  rgb: Longint;
begin
  rgb := ColorToRGB(AColor);
  r := rgb and $FF;
  g := (rgb shr 8) and $FF;
  b := (rgb shr 16) and $FF;

  r := r + (225 - r) * 0.2;
  g := g + (225 - g) * 0.2;
  b := b + (225 - b) * 0.2;

  Result := TColor((Max(Min(Round(b), 255),0) shl 16)
                or (Max(Min(Round(g), 255),0) shl 8)
                or Max(Min(Round(r), 255),0));
end;

procedure UpdateGutter(SynEdit: TSynEdit);
var
  LStyles: TCustomStyleServices;
begin
  LStyles := StyleServices;
  SynEdit.Gutter.Gradient := False;
  if LStyles.Enabled then
  begin
    //SynEdit.SelectedColor.Background := LStyles.GetSystemColor(clHighlight);
    //SynEdit.SelectedColor.Foreground := LStyles.GetSystemColor(clHighlightText); //sfMenuItemTextSelected);
   // StyleServices.GetElementColor(StyleServices.GetElementDetails(tgClassicCellSelected), ecTextColor, HighlightTextColor);
   // StyleServices.GetElementColor(StyleServices.GetElementDetails(tgClassicCellSelected), ecFillColor, HighlightColor);

    SynEdit.SelectedColor.Background := LStyles.GetSystemColor(clHighlight);
    SynEdit.SelectedColor.Foreground := LStyles.GetSystemColor(clHighlightText);
    //SynEdit.SelectedColor.Background := HighlightColor;
    //SynEdit.SelectedColor.Foreground := HighlightTextColor;

    SynEdit.Gutter.Font.Color := LStyles.GetStyleFontColor(sfHeaderSectionTextNormal); //sfEditBoxTextNormal);
    SynEdit.Gutter.BorderColor := LStyles.GetStyleColor(scEdit); //SynEdit.Color;
    SynEdit.Gutter.Color := LStyles.GetStyleColor(scPanel); // LStyles.GetStyleColor(scGenericGradientEnd);
    SynEdit.RightEdgeColor := LStyles.GetStyleColor(scPanel);
    SynEdit.Font.Color := LStyles.GetStyleFontColor(sfEditBoxTextNormal); //LStyles.GetSystemColor(SynEdit.Font.Color);
    SynEdit.Color := LStyles.GetStyleColor(scEdit);
  end
  else
  begin
    SynEdit.Gutter.GradientStartColor := clWindow;
    SynEdit.Gutter.GradientEndColor := clBtnFace;
    SynEdit.Gutter.Font.Color := clWindowText;
    SynEdit.Gutter.BorderColor := clWindow;
    SynEdit.Gutter.Color := clBtnFace;
    SynEdit.Color := clWindow;
  end;
  //if not LStyles.GetElementColor(LStyles.GetElementDetails(tgCellNormal), ecBorderColor, LColor) or  (LColor = clNone) then
  //  LColor := SynEdit.Color;

  SynEdit.ActiveLineColor := SynEdit.Color; //LColor

  {if LStyles.Enabled then
  begin
    SynEdit.Gutter.GradientStartColor := LStyles.GetStyleColor(scEdit); //scGenericGradientEnd);
    SynEdit.Gutter.GradientEndColor := LStyles.GetStyleColor(scPanel); //scGenericGradientBase);
    SynEdit.Gutter.Font.Color := LStyles.GetStyleFontColor(sfEditBoxTextNormal);
    SynEdit.Gutter.BorderColor := LStyles.GetStyleColor(scBorder); //SynEdit.Color;
    SynEdit.Gutter.Color := LStyles.GetStyleColor(scPanel); // LStyles.GetStyleColor(scGenericGradientEnd);
  end
  else
  begin
    SynEdit.Gutter.GradientStartColor := clBtnFace;
    SynEdit.Gutter.GradientEndColor := clWindow;
    SynEdit.Gutter.Font.Color := clWindowText;
    SynEdit.Gutter.BorderColor := clWindow;
    SynEdit.Gutter.Color := clBtnFace;
  end;}
end;

{ TProgressBarStyleHookMarquee }

constructor TProgressBarStyleHookMarquee.Create(AControl: TWinControl);
begin
  inherited;
  FStep := 0;
  Timer := TTimer.Create(nil);
  Timer.Interval := 100;//TProgressBar(Control).MarqueeInterval;
  Timer.OnTimer := TimerAction;
  Timer.Enabled := TJvProgressBar(Control).Marquee;
end;

destructor TProgressBarStyleHookMarquee.Destroy;
begin
  Timer.Free;
  inherited;
end;

procedure TProgressBarStyleHookMarquee.PaintBar(Canvas: TCanvas);
var
  FillR, R: TRect;
  W, Pos: Integer;
  Details: TThemedElementDetails;
begin
  if (TJvProgressBar(Control).Marquee) and StyleServices.Available  then
  begin
    R := BarRect;
    InflateRect(R, -1, -1);
    if Orientation = pbHorizontal then
      W := R.Width
    else
      W := R.Height;

    Pos := Round(W * 0.1);
    FillR := R;
    if Orientation = pbHorizontal then
    begin
      FillR.Right := FillR.Left + Pos;
      Details := StyleServices.GetElementDetails(tpChunk);
    end
    else
    begin
      FillR.Top := FillR.Bottom - Pos;
      Details := StyleServices.GetElementDetails(tpChunkVert);
    end;

    FillR.SetLocation(FStep*FillR.Width, FillR.Top);
    StyleServices.DrawElement(Canvas.Handle, Details, FillR);
    Inc(FStep, 1);
    if FStep mod 10=0 then
      FStep := 0;
  end
  else
  inherited;
end;

procedure TProgressBarStyleHookMarquee.TimerAction(Sender: TObject);
var
  Canvas: TCanvas;
begin
  if StyleServices.Available and (TJvProgressBar(Control).Marquee) and Control.Visible  then
  begin
    Canvas := TCanvas.Create;
    try
      Canvas.Handle := GetWindowDC(Control.Handle);
      PaintFrame(Canvas);
      PaintBar(Canvas);
    finally
      ReleaseDC(Handle, Canvas.Handle);
      Canvas.Handle := 0;
      Canvas.Free;
    end;
  end
  else
  Timer.Enabled := False;
end;

end.
