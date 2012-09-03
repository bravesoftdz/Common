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

  TVirtualTreeStyleHook = class(TScrollingStyleHook) //TListBoxStyleHook)
  strict private
    procedure UpdateColors;
    procedure WMEraseBkgnd(var Message: TMessage); message WM_ERASEBKGND;
  strict protected
    procedure WndProc(var Message: TMessage); override;
    procedure WMSetFocus(var Message: TMessage); message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TMessage); message WM_KILLFOCUS;
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

implementation

uses
  Winapi.Windows;

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

{ TListBoxStyleHook }

constructor TVirtualTreeStyleHook.Create(AControl: TWinControl);
begin
  inherited;
  OverrideEraseBkgnd := True;
  UpdateColors;
end;

procedure TVirtualTreeStyleHook.WMEraseBkgnd(var Message: TMessage);
begin
  Handled := True;
end;

procedure TVirtualTreeStyleHook.WMSetFocus(var Message: TMessage);
begin
  inherited;
  CallDefaultProc(Message);
  RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_UPDATENOW);
  Handled := True;
end;

procedure TVirtualTreeStyleHook.WndProc(var Message: TMessage);
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

procedure TVirtualTreeStyleHook.UpdateColors;
const
  ColorStates: array[Boolean] of TStyleColor = (scListBoxDisabled, scListBox);
  FontColorStates: array[Boolean] of TStyleFont = (sfListItemTextDisabled, sfListItemTextNormal);
var
  LStyle: TCustomStyleServices;
begin
  LStyle := StyleServices;
  Brush.Color := LStyle.GetStyleColor(ColorStates[Control.Enabled]);
  FontColor := LStyle.GetStyleFontColor(FontColorStates[Control.Enabled]);
end;

procedure TVirtualTreeStyleHook.WMKillFocus(var Message: TMessage);
begin
  inherited;
  CallDefaultProc(Message);
  RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_UPDATENOW);
  Handled := True;
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
    SynEdit.SelectedColor.Background := LStyles.GetSystemColor(clHighlight);
    SynEdit.SelectedColor.Foreground := LStyles.GetSystemColor(clHighlightText);

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
  SynEdit.ActiveLineColor := SynEdit.Color;
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
