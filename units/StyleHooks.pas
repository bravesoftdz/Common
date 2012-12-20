unit StyleHooks;

interface

uses
  Vcl.StdCtrls, Winapi.Messages, Vcl.Controls, SynEdit, Vcl.Styles, Vcl.Themes, Vcl.ComCtrls,
  Vcl.ExtCtrls, Vcl.Graphics, Vcl.Forms, JvProgressBar, SynHighlighterAWK, SynHighlighterCobol,
  SynHighlighterIdl, SynHighlighterCPM, SynHighlighterDOT, SynHighlighterADSP21xx,
  SynHighlighterDWS, SynHighlighterEiffel, SynHighlighterIni, SynHighlighterInno,
  SynHighlighterJava, SynHighlighterJScript, SynHighlighterLDraw, SynHighlighterMsg,
  SynHighlighterBat, SynHighlighterPerl, SynHighlighterProgress, SynHighlighterPython,
  SynHighlighterRuby, SynHighlighterSDD, SynHighlighterSML, SynHighlighterTclTk,
  SynHighlighterTex, SynHighlighterUNIXShellScript, SynHighlighterVB, SynHighlighterASM,
  SynHighlighterSQL, SynHighlighterWeb, Dlg;

const
  STYLENAME_WINDOWS = 'Windows';

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

  procedure SetStyledFormSize(Dialog: TDialog);
  procedure UpdateGutter(SynEdit: TSynEdit);
  function LightenColor(AColor: TColor; AFactor: Double = 0.2): TColor;
  procedure UpdateAWKSynColors(AWKSyn: TSynAWKSyn; WhiteBackground: Boolean);
  procedure UpdateCobolSynColors(CobolSyn: TSynCobolSyn; WhiteBackground: Boolean);
  procedure UpdateIdlSynColors(IdlSyn: TSynIdlSyn; WhiteBackground: Boolean);
  procedure UpdateCPMSynColors(CPMSyn: TSynCPMSyn; WhiteBackground: Boolean);
  procedure UpdateDOTSynColors(DOTSyn: TSynDOTSyn; WhiteBackground: Boolean);
  procedure UpdateADSP21xxSynColors(ADSP21xxSyn: TSynADSP21xxSyn; WhiteBackground: Boolean);
  procedure UpdateDWSSynColors(DWSSyn: TSynDWSSyn; WhiteBackground: Boolean);
  procedure UpdateEiffelSynColors(EiffelSyn: TSynEiffelSyn; WhiteBackground: Boolean);
  procedure UpdateIniSynColors(IniSyn: TSynIniSyn; WhiteBackground: Boolean);
  procedure UpdateInnoSynColors(InnoSyn: TSynInnoSyn; WhiteBackground: Boolean);
  procedure UpdateJavaSynColors(JavaSyn: TSynJavaSyn; WhiteBackground: Boolean);
  procedure UpdateJScriptSynColors(JScriptSyn: TSynJScriptSyn; WhiteBackground: Boolean);
  procedure UpdateLDRSynColors(LDRSyn: TSynLDRSyn; WhiteBackground: Boolean);
  procedure UpdateMsgSynColors(MsgSyn: TSynMsgSyn; WhiteBackground: Boolean);
  procedure UpdateBatSynColors(BatSyn: TSynBatSyn; WhiteBackground: Boolean);
  procedure UpdatePerlSynColors(PerlSyn: TSynPerlSyn; WhiteBackground: Boolean);
  procedure UpdateProgressSynColors(ProgressSyn: TSynProgressSyn; WhiteBackground: Boolean);
  procedure UpdatePythonSynColors(PythonSyn: TSynPythonSyn; WhiteBackground: Boolean);
  procedure UpdateRubySynColors(RubySyn: TSynRubySyn; WhiteBackground: Boolean);
  procedure UpdateSDDSynColors(SDDSyn: TSynSDDSyn; WhiteBackground: Boolean);
  procedure UpdateSQLSynColors(SQLSyn: TSynSQLSyn); overload;
  procedure UpdateSQLSynColors(SQLSyn: TSynSQLSyn; WhiteBackground: Boolean); overload;
  procedure UpdateSMLSynColors(SMLSyn: TSynSMLSyn; WhiteBackground: Boolean);
  procedure UpdateTclTkSynColors(TclTkSyn: TSynTclTkSyn; WhiteBackground: Boolean);
  procedure UpdateTexSynColors(TexSyn: TSynTexSyn; WhiteBackground: Boolean);
  procedure UpdateUNIXShellScriptSynColors(UNIXShellScriptSyn: TSynUNIXShellScriptSyn; WhiteBackground: Boolean);
  procedure UpdateVBSynColors(VBSyn: TSynVBSyn; WhiteBackground: Boolean);
  procedure UpdateASMSynColors(ASMSyn: TSynASMSyn; WhiteBackground: Boolean);
  procedure UpdateWebEngineColors(SynWebEngine: TSynWebEngine; WhiteBackground: Boolean);

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

function LightenMoreColor(AColor: TColor): TColor;
begin
  Result := LightenColor(AColor, 0.4);
end;

function LightenColor(AColor: TColor; AFactor: Double): TColor;
var
  r, g, b: Double;
  rgb: Longint;
begin
  rgb := ColorToRGB(AColor);
  r := rgb and $FF;
  g := (rgb shr 8) and $FF;
  b := (rgb shr 16) and $FF;

  r := r + (225 - r) * AFactor;
  g := g + (225 - g) * AFactor;
  b := b + (225 - b) * AFactor;

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
    SynEdit.SelectedColor.Background := LStyles.GetSystemColor(clHighlight);
    SynEdit.SelectedColor.Foreground := LStyles.GetSystemColor(clHighlightText);
    SynEdit.Gutter.Font.Color := LStyles.GetStyleFontColor(sfHeaderSectionTextNormal);
    SynEdit.Gutter.BorderColor := LStyles.GetStyleColor(scEdit);
    SynEdit.Gutter.Color := LStyles.GetStyleColor(scPanel);
    SynEdit.RightEdgeColor := LStyles.GetStyleColor(scPanel);
    SynEdit.Font.Color := LStyles.GetStyleFontColor(sfEditBoxTextNormal);
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
end;

procedure UpdateAWKSynColors(AWKSyn: TSynAWKSyn; WhiteBackground: Boolean);
begin
  if WhiteBackground then
  begin
    AWKSyn.CommentAttri.Foreground := clBlue;
    AWKSyn.InterFuncAttri.Foreground := $00408080;
  end
  else
  begin
    AWKSyn.CommentAttri.Foreground := clAqua;
    AWKSyn.InterFuncAttri.Foreground := clYellow;
  end
end;

procedure UpdateCobolSynColors(CobolSyn: TSynCobolSyn; WhiteBackground: Boolean);
begin
  if WhiteBackground then
  begin
    CobolSyn.AreaAIdentifierAttri.Foreground := clTeal;
    CobolSyn.BooleanAttri.Foreground := clGreen;
    CobolSyn.CommentAttri.Foreground := clGray;
    CobolSyn.PreprocessorAttri.Foreground := clMaroon;
    CobolSyn.StringAttri.Foreground := clBlue;
  end
  else
  begin
    CobolSyn.AreaAIdentifierAttri.Foreground := LightenColor(clTeal);
    CobolSyn.BooleanAttri.Foreground := clLime;
    CobolSyn.CommentAttri.Foreground := clSilver;
    CobolSyn.PreprocessorAttri.Foreground := clTeal;
    CobolSyn.StringAttri.Foreground := clAqua;
  end;
  { clGray }
  CobolSyn.DebugLinesAttri.Foreground := CobolSyn.CommentAttri.Foreground;
  CobolSyn.SequenceAttri.Foreground := CobolSyn.CommentAttri.Foreground;
  { clGreen }
  CobolSyn.NumberAttri.Foreground := CobolSyn.BooleanAttri.Foreground;
  { clMaroon }
  CobolSyn.TagAreaAttri.Foreground := CobolSyn.PreprocessorAttri.Foreground;
end;

procedure UpdateIdlSynColors(IdlSyn: TSynIdlSyn; WhiteBackground: Boolean);
begin
  if WhiteBackground then
  begin
    IdlSyn.CommentAttri.Foreground := clNavy;
    IdlSyn.DatatypeAttri.Foreground := clTeal;
    IdlSyn.NumberAttri.Foreground := clBlue;
  end
  else
  begin
    IdlSyn.CommentAttri.Foreground := clAqua;
    IdlSyn.DatatypeAttri.Foreground := LightenColor(clTeal);
    IdlSyn.NumberAttri.Foreground := clAqua;
  end;

  IdlSyn.StringAttri.Foreground := IdlSyn.NumberAttri.Foreground;
end;

procedure UpdateCPMSynColors(CPMSyn: TSynCPMSyn; WhiteBackground: Boolean);
begin
  if WhiteBackground then
  begin
    CPMSyn.CommentAttri.Foreground := clNavy;
    CPMSyn.KeyAttri.Foreground := clGreen;
    CPMSyn.SQLKeyAttri.Foreground := clTeal;
    CPMSyn.VariableAttri.Foreground := clMaroon;
  end
  else
  begin
    CPMSyn.CommentAttri.Foreground := clAqua;
    CPMSyn.KeyAttri.Foreground := clLime;
    CPMSyn.SQLKeyAttri.Foreground := LightenColor(clTeal);
    CPMSyn.VariableAttri.Foreground := clTeal;
  end
end;

procedure UpdateDOTSynColors(DOTSyn: TSynDOTSyn; WhiteBackground: Boolean);
begin
  if WhiteBackground then
  begin
    DOTSyn.CommentAttri.Foreground := clNavy;
    DOTSyn.SymbolAttri.Foreground := clGreen;
  end
  else
  begin
    DOTSyn.CommentAttri.Foreground := clAqua;
    DOTSyn.SymbolAttri.Foreground := clLime;
  end;
end;

procedure UpdateADSP21xxSynColors(ADSP21xxSyn: TSynADSP21xxSyn; WhiteBackground: Boolean);
begin
  if WhiteBackground then
  begin
    ADSP21xxSyn.CommentAttri.Foreground := clTeal;
    ADSP21xxSyn.NumberAttri.Foreground := clOlive;
  end
  else
  begin
    ADSP21xxSyn.CommentAttri.Foreground := clAqua;
    ADSP21xxSyn.NumberAttri.Foreground := clYellow;
  end;
end;

procedure UpdateDWSSynColors(DWSSyn: TSynDWSSyn; WhiteBackground: Boolean);
begin
  if WhiteBackground then
  begin
    DWSSyn.AsmAttri.Foreground := clMaroon;
    DWSSyn.CharAttri.Foreground := clBlue;
    DWSSyn.CommentAttri.Foreground := clGreen;
    DWSSyn.DirectiveAttri.Foreground := clTeal;
    DWSSyn.SymbolAttri.Foreground := clNavy
  end
  else
  begin
    DWSSyn.AsmAttri.Foreground := clTeal;
    DWSSyn.CharAttri.Foreground := clAqua;
    DWSSyn.CommentAttri.Foreground := clLime;
    DWSSyn.DirectiveAttri.Foreground := LightenColor(clTeal);
    DWSSyn.SymbolAttri.Foreground := clAqua
  end;
  { clBlue }
  DWSSyn.FloatAttri.Foreground := DWSSyn.CharAttri.Foreground;
  DWSSyn.HexAttri.Foreground := DWSSyn.CharAttri.Foreground;
  DWSSyn.NumberAttri.Foreground := DWSSyn.CharAttri.Foreground;
  DWSSyn.StringAttri.Foreground := DWSSyn.CharAttri.Foreground;
end;

procedure UpdateEiffelSynColors(EiffelSyn: TSynEiffelSyn; WhiteBackground: Boolean);
begin
  if WhiteBackground then
  begin
    EiffelSyn.BasicTypesAttri.Foreground := clBlue;
    EiffelSyn.CommentAttri.Foreground := clTeal;
    EiffelSyn.IdentifierAttri.Foreground := clMaroon;
    EiffelSyn.KeyAttri.Foreground := clNavy;
    EiffelSyn.OperatorAndSymbolsAttri.Foreground := clOlive;
    EiffelSyn.ResultValueAttri.Foreground := clPurple;
    EiffelSyn.StringAttri.Foreground := clGray
  end
  else
  begin
    EiffelSyn.BasicTypesAttri.Foreground := clAqua;
    EiffelSyn.CommentAttri.Foreground := LightenColor(clTeal);
    EiffelSyn.IdentifierAttri.Foreground := clTeal;
    EiffelSyn.KeyAttri.Foreground := clAqua;
    EiffelSyn.OperatorAndSymbolsAttri.Foreground := clYellow;
    EiffelSyn.ResultValueAttri.Foreground := clYellow;
    EiffelSyn.StringAttri.Foreground := clSilver
  end;
  { clNavy }
  EiffelSyn.LaceAttri.Foreground := EiffelSyn.KeyAttri.Foreground;
end;

procedure UpdateIniSynColors(IniSyn: TSynIniSyn; WhiteBackground: Boolean);
begin
  if WhiteBackground then
    IniSyn.CommentAttri.Foreground := clGreen
  else
    IniSyn.CommentAttri.Foreground := clLime
end;

procedure UpdateInnoSynColors(InnoSyn: TSynInnoSyn; WhiteBackground: Boolean);
begin
  if WhiteBackground then
  begin
    InnoSyn.CommentAttri.Foreground := clGray;
    InnoSyn.ConstantAttri.Foreground := clTeal;
    InnoSyn.KeyAttri.Foreground := clNavy;
    InnoSyn.NumberAttri.Foreground := clMaroon;
    InnoSyn.ParameterAttri.Foreground := clOlive;
    InnoSyn.StringAttri.Foreground := clBlue;
  end
  else
  begin
    InnoSyn.CommentAttri.Foreground := clSilver;
    InnoSyn.ConstantAttri.Foreground := LightenColor(clTeal);
    InnoSyn.KeyAttri.Foreground := clAqua;
    InnoSyn.NumberAttri.Foreground := clTeal;
    InnoSyn.ParameterAttri.Foreground := clYellow;
    InnoSyn.StringAttri.Foreground := clAqua;
  end;
end;

procedure UpdateJavaSynColors(JavaSyn: TSynJavaSyn; WhiteBackground: Boolean);
begin
  if WhiteBackground then
  begin
    JavaSyn.CommentAttri.Foreground := clGreen;
    JavaSyn.DocumentAttri.Foreground := clGray;
    JavaSyn.KeyAttri.Foreground := clBlue;
    JavaSyn.StringAttri.Foreground := clPurple;
  end
  else
  begin
    JavaSyn.CommentAttri.Foreground := clLime;
    JavaSyn.DocumentAttri.Foreground := clSilver;
    JavaSyn.KeyAttri.Foreground := clAqua;
    JavaSyn.StringAttri.Foreground := clYellow;
  end;
end;

procedure UpdateJScriptSynColors(JScriptSyn: TSynJScriptSyn; WhiteBackground: Boolean);
begin
  if WhiteBackground then
  begin
    JScriptSyn.CommentAttri.Foreground := clGreen;
    JScriptSyn.KeyAttri.Foreground := clBlue;
    JScriptSyn.StringAttri.Foreground := clPurple;
  end
  else
  begin
    JScriptSyn.CommentAttri.Foreground := clLime;
    JScriptSyn.KeyAttri.Foreground := clAqua;
    JScriptSyn.StringAttri.Foreground := clYellow;
  end;
end;

procedure UpdateLDRSynColors(LDRSyn: TSynLDRSyn; WhiteBackground: Boolean);
begin
  if WhiteBackground then
  begin
    LDRSyn.ColorAttri.Foreground := clNavy;
    LDRSyn.CommentAttri.Foreground := clBlue;
    LDRSyn.FirstTriAttri.Foreground := $00496FCE;
    LDRSyn.FourthTriAttri.Foreground := $000C6336;
  end
  else
  begin
    LDRSyn.ColorAttri.Foreground := clAqua;
    LDRSyn.CommentAttri.Foreground := clAqua;
    LDRSyn.FirstTriAttri.Foreground := clYellow;
    LDRSyn.FourthTriAttri.Foreground := clLime;
  end;
  LDRSyn.SecondTriAttri.Foreground := LDRSyn.FourthTriAttri.Foreground;
  LDRSyn.ThirdTriAttri.Foreground := LDRSyn.FirstTriAttri.Foreground;
end;

procedure UpdateMsgSynColors(MsgSyn: TSynMsgSyn; WhiteBackground: Boolean);
begin
  if WhiteBackground then
    MsgSyn.CommentAttri.Foreground := clNavy
  else
    MsgSyn.CommentAttri.Foreground := clAqua
end;

procedure UpdateBatSynColors(BatSyn: TSynBatSyn; WhiteBackground: Boolean);
begin
  if WhiteBackground then
  begin
    BatSyn.CommentAttri.Foreground := clGreen;
    BatSyn.KeyAttri.Foreground := clBlue
  end
  else
  begin
    BatSyn.CommentAttri.Foreground := clLime;
    BatSyn.KeyAttri.Foreground := clAqua
  end;
  BatSyn.VariableAttri.Foreground := BatSyn.CommentAttri.Foreground;
end;

procedure UpdatePerlSynColors(PerlSyn: TSynPerlSyn; WhiteBackground: Boolean);
begin
  if WhiteBackground then
    PerlSyn.CommentAttri.Foreground := clGreen
  else
    PerlSyn.CommentAttri.Foreground := clLime;
end;

procedure UpdateProgressSynColors(ProgressSyn: TSynProgressSyn; WhiteBackground: Boolean);
begin
  if WhiteBackground then
  begin
    ProgressSyn.EventAttri.Foreground := clOlive;
    ProgressSyn.IdentifierAttri.Foreground := clNavy;
    ProgressSyn.IncludeAttri.Foreground := clPurple;
    ProgressSyn.KeyAttri.Foreground := clMaroon;
    ProgressSyn.NonReservedKeyAttri.Foreground := clTeal;
    ProgressSyn.StringAttri.Foreground := clBlue;
  end
  else
  begin
    ProgressSyn.EventAttri.Foreground := clYellow;
    ProgressSyn.IdentifierAttri.Foreground := clAqua;
    ProgressSyn.IncludeAttri.Foreground := clYellow;
    ProgressSyn.KeyAttri.Foreground := clTeal;
    ProgressSyn.NonReservedKeyAttri.Foreground := LightenColor(clTeal);
    ProgressSyn.StringAttri.Foreground := clAqua;
  end;
  { clMaroon }
  ProgressSyn.NumberAttri.Foreground :=  ProgressSyn.KeyAttri.Foreground;
  { clPurple }
  ProgressSyn.PreprocessorAttri.Foreground := ProgressSyn.IncludeAttri.Foreground;
end;

procedure UpdatePythonSynColors(PythonSyn: TSynPythonSyn; WhiteBackground: Boolean);
begin
  if WhiteBackground then
  begin
    PythonSyn.FloatAttri.Foreground := clBlue;
    PythonSyn.FunctionNameAttri.Foreground := clTeal;
    PythonSyn.MultiLineStringAttri.Foreground := clOlive;
    PythonSyn.NonKeyAttri.Foreground := clNavy;
  end
  else
  begin
    PythonSyn.FloatAttri.Foreground := clAqua;
    PythonSyn.FunctionNameAttri.Foreground := LightenColor(clTeal);
    PythonSyn.MultiLineStringAttri.Foreground := clYellow;
    PythonSyn.NonKeyAttri.Foreground := clAqua;
  end;
  { clBlue }
  PythonSyn.HexAttri.Foreground := PythonSyn.FloatAttri.Foreground;
  PythonSyn.NumberAttri.Foreground := PythonSyn.FloatAttri.Foreground;
  PythonSyn.OctalAttri.Foreground := PythonSyn.FloatAttri.Foreground;
  PythonSyn.StringAttri.Foreground := PythonSyn.FloatAttri.Foreground;
end;

procedure UpdateRubySynColors(RubySyn: TSynRubySyn; WhiteBackground: Boolean);
begin
  if WhiteBackground then
  begin
    RubySyn.CommentAttri.Foreground := clMaroon;
    RubySyn.KeyAttri.Foreground := clBlue;
    RubySyn.NumberAttri.Foreground := clGreen;
    RubySyn.StringAttri.Foreground := clPurple;
  end
  else
  begin
    RubySyn.CommentAttri.Foreground := clTeal;
    RubySyn.KeyAttri.Foreground := clAqua;
    RubySyn.NumberAttri.Foreground := clLime;
    RubySyn.StringAttri.Foreground := clYellow;
  end;
  { clBlue }
  RubySyn.SymbolAttri.Foreground := RubySyn.KeyAttri.Foreground;
end;

procedure UpdateSDDSynColors(SDDSyn: TSynSDDSyn; WhiteBackground: Boolean);
begin
  if WhiteBackground then
  begin
    SDDSyn.CommentAttri.Foreground := clNavy;
    SDDSyn.DatatypeAttri.Foreground := clTeal;
    SDDSyn.KeyAttri.Foreground := clGreen;
    SDDSyn.NumberAttri.Foreground := clBlue;
  end
  else
  begin
    SDDSyn.CommentAttri.Foreground := clAqua;
    SDDSyn.DatatypeAttri.Foreground := LightenColor(clTeal);
    SDDSyn.KeyAttri.Foreground := clLime;
    SDDSyn.NumberAttri.Foreground := clAqua;
  end;
end;

procedure UpdateSQLSynColors(SQLSyn: TSynSQLSyn);
var
  LStyles: TCustomStyleServices;
  WhiteBackground: Boolean;
begin
  LStyles := StyleServices;
  if Assigned(LStyles) then
  begin
    WhiteBackground := (TStyleManager.ActiveStyle.Name = STYLENAME_WINDOWS) or (LStyles.GetStyleColor(scEdit) = clWhite);
    UpdateSQLSynColors(SQLSyn, WhiteBackground);
  end;
end;

procedure UpdateSQLSynColors(SQLSyn: TSynSQLSyn; WhiteBackground: Boolean);
begin
  if WhiteBackground then
  begin
    SQLSyn.CommentAttri.Foreground := clGreen;
    SQLSyn.KeyAttri.Foreground := clBlue;
    SQLSyn.StringAttri.Foreground := clPurple;
    SQLSyn.TableNameAttri.Foreground := clOlive;
    SQLSyn.VariableAttri.Foreground := clNavy;
  end
  else
  begin
    SQLSyn.CommentAttri.Foreground := clLime;
    SQLSyn.KeyAttri.Foreground := clAqua;
    SQLSyn.StringAttri.Foreground := clYellow;
    SQLSyn.TableNameAttri.Foreground := clYellow;
    SQLSyn.VariableAttri.Foreground := clAqua;
  end;
  { clBlue }
  SQLSyn.DelimitedIdentifierAttri.Foreground := SQLSyn.KeyAttri.Foreground;
  SQLSyn.FunctionAttri.Foreground := SQLSyn.KeyAttri.Foreground;
  SQLSyn.PLSQLAttri.Foreground := SQLSyn.KeyAttri.Foreground;
  SQLSyn.SQLPlusAttri.Foreground := SQLSyn.KeyAttri.Foreground;
  { clGreen }
  SQLSyn.ConditionalCommentAttri.Foreground := SQLSyn.CommentAttri.Foreground;
  SQLSyn.KeyAttri.Style := [];
end;

procedure UpdateSMLSynColors(SMLSyn: TSynSMLSyn; WhiteBackground: Boolean);
begin
  if WhiteBackground then
  begin
    SMLSyn.CharacterAttri.Foreground := clBlue;
    SMLSyn.CommentAttri.Foreground := clNavy;
    SMLSyn.KeyAttri.Foreground := clGreen;
    SMLSyn.OperatorAttri.Foreground := clMaroon;
  end
  else
  begin
    SMLSyn.CharacterAttri.Foreground := clAqua;
    SMLSyn.CommentAttri.Foreground := clAqua;
    SMLSyn.KeyAttri.Foreground := clLime;
    SMLSyn.OperatorAttri.Foreground := clTeal;
  end;
  { clBlue }
  SMLSyn.StringAttri.Foreground := SMLSyn.CharacterAttri.Foreground;
end;

procedure UpdateTclTkSynColors(TclTkSyn: TSynTclTkSyn; WhiteBackground: Boolean);
begin
  if WhiteBackground then
    TclTkSyn.CommentAttri.Foreground := clGreen
  else
    TclTkSyn.CommentAttri.Foreground := clLime;
end;

procedure UpdateTexSynColors(TexSyn: TSynTexSyn; WhiteBackground: Boolean);
begin
  if WhiteBackground then
  begin
    TexSyn.BraceAttri.Foreground := clPurple;
    TexSyn.CommentAttri.Foreground := clTeal;
    TexSyn.ControlSequenceAttri.Foreground := clBlue;
    TexSyn.MathmodeAttri.Foreground := clOlive;
  end
  else
  begin
    TexSyn.BraceAttri.Foreground := clYellow;
    TexSyn.CommentAttri.Foreground := LightenColor(clTeal);
    TexSyn.ControlSequenceAttri.Foreground := clAqua;
    TexSyn.MathmodeAttri.Foreground := clYellow;
  end;
end;

procedure UpdateUNIXShellScriptSynColors(UNIXShellScriptSyn: TSynUNIXShellScriptSyn; WhiteBackground: Boolean);
begin
  if WhiteBackground then
  begin
    UNIXShellScriptSyn.CommentAttri.Foreground := clGreen;
    UNIXShellScriptSyn.KeyAttri.Foreground := clNavy;
    UNIXShellScriptSyn.NumberAttri.Foreground := clBlue;
    UNIXShellScriptSyn.StringAttri.Foreground := clMaroon;
    UNIXShellScriptSyn.VarAttri.Foreground := clPurple;
  end
  else
  begin
    UNIXShellScriptSyn.CommentAttri.Foreground := clLime;
    UNIXShellScriptSyn.KeyAttri.Foreground := clAqua;
    UNIXShellScriptSyn.NumberAttri.Foreground := clAqua;
    UNIXShellScriptSyn.StringAttri.Foreground := clTeal;
    UNIXShellScriptSyn.VarAttri.Foreground := clYellow;
  end
end;

procedure UpdateVBSynColors(VBSyn: TSynVBSyn; WhiteBackground: Boolean);
begin
  if WhiteBackground then
  begin
    VBSyn.CommentAttri.Foreground := clGreen;
    VBSyn.KeyAttri.Foreground := clBlue;
    VBSyn.StringAttri.Foreground := clPurple;
  end
  else
  begin
    VBSyn.CommentAttri.Foreground := clLime;
    VBSyn.KeyAttri.Foreground := clAqua;
    VBSyn.StringAttri.Foreground := clYellow;
  end;
end;

procedure UpdateASMSynColors(ASMSyn: TSynASMSyn; WhiteBackground: Boolean);
begin
  if WhiteBackground then
  begin
    ASMSyn.CommentAttri.Foreground := clGreen;
    ASMSyn.KeyAttri.Foreground := clBlue;
    ASMSyn.StringAttri.Foreground := clPurple;
  end
  else
  begin
    ASMSyn.CommentAttri.Foreground := clLime;
    ASMSyn.KeyAttri.Foreground := clAqua;
    ASMSyn.StringAttri.Foreground := clYellow;
  end;
end;

procedure UpdateWebEngineColors(SynWebEngine: TSynWebEngine; WhiteBackground: Boolean);
begin
  if WhiteBackground then
  begin
    { CSS }
    SynWebEngine.CssCommentAttri.Foreground := clMedGray;
    SynWebEngine.CssPropAttri.Foreground := clMaroon;
    SynWebEngine.CssRulesetWhitespaceAttri.Background := clInfoBk;
    SynWebEngine.CssSelectorAttri.Foreground := clNavy;
    SynWebEngine.CssSelectorClassAttri.Foreground := clBlue;
    SynWebEngine.CssSelectorIdAttri.Foreground := clGreen;
    SynWebEngine.CssSymbolAttri.Foreground := clBlack;
    SynWebEngine.CssValAttri.Foreground := clPurple;
    SynWebEngine.CssValStringAttri.Foreground := clFuchsia;
    SynWebEngine.CssWhitespaceAttri.Background := $00F0FFFF;
    SynWebEngine.EsWhitespaceAttri.Background := $00FFF0F0;
    SynWebEngine.InactiveAttri.Foreground := clInactiveCaptionText;
    SynWebEngine.MLEscapeAttri.Foreground := clTeal;
    SynWebEngine.PhpMethodAttri.Foreground := $00FF8000;
    SynWebEngine.PhpWhitespaceAttri.Background := $00F5F5F5;
    SynWebEngine.PhpStringSpecialAttri.Background := $00EAEAEA;
  end
  else
  begin
    { CSS }
    SynWebEngine.CssCommentAttri.Foreground := LightenColor(clMedGray);
    SynWebEngine.CssPropAttri.Foreground := clTeal;
    SynWebEngine.CssRulesetWhitespaceAttri.Background := LightenColor(clBlack);
    SynWebEngine.CssSelectorAttri.Foreground := clAqua;
    SynWebEngine.CssSelectorClassAttri.Foreground := clAqua;
    SynWebEngine.CssSelectorIdAttri.Foreground := clLime;
    SynWebEngine.CssSymbolAttri.Foreground := clSilver;
    SynWebEngine.CssValAttri.Foreground := clYellow;
    SynWebEngine.CssValStringAttri.Foreground := clYellow;
    SynWebEngine.CssWhitespaceAttri.Background := LightenColor(clBlack);
    SynWebEngine.EsWhitespaceAttri.Background := LightenColor(clBlack);
    SynWebEngine.InactiveAttri.Foreground := LightenMoreColor(clInactiveCaptionText);
    SynWebEngine.MLEscapeAttri.Foreground := LightenColor(clTeal);
    SynWebEngine.PhpMethodAttri.Foreground := LightenColor($00FF8000);
    SynWebEngine.PhpWhitespaceAttri.Background := LightenColor(clBlack);
    SynWebEngine.PhpStringSpecialAttri.Background := LightenMoreColor(clBlack);
  end;
  { clMaroon }
  SynWebEngine.CssPropUndefAttri.Foreground := SynWebEngine.CssPropAttri.Foreground;
  SynWebEngine.MLTagKeyAttri.Foreground := SynWebEngine.CssPropAttri.Foreground;
  SynWebEngine.PhpIdentifierAttri.Foreground := SynWebEngine.CssPropAttri.Foreground;
  { clBlue }
  SynWebEngine.CssSelectorUndefAttri.Foreground := SynWebEngine.CssSelectorClassAttri.Foreground;
  SynWebEngine.EsIdentifierAttri.Foreground := SynWebEngine.CssSelectorClassAttri.Foreground;
  SynWebEngine.MLTagNameAttri.Foreground := SynWebEngine.CssSelectorClassAttri.Foreground;
  SynWebEngine.MLTagNameUndefAttri.Foreground := SynWebEngine.CssSelectorClassAttri.Foreground;
  SynWebEngine.PhpDocCommentTagAttri.Foreground := SynWebEngine.CssSelectorClassAttri.Foreground;
  SynWebEngine.PhpKeyAttri.Foreground := SynWebEngine.CssSelectorClassAttri.Foreground;
  SynWebEngine.PhpVariableAttri.Foreground := SynWebEngine.CssSelectorClassAttri.Foreground;
  { clNavy }
  SynWebEngine.CssSpecialAttri.Foreground := SynWebEngine.CssSelectorAttri.Foreground;
  SynWebEngine.MLTagAttri.Foreground := SynWebEngine.CssSelectorAttri.Foreground;
  SynWebEngine.SpecialAttri.PhpMarker.Foreground := SynWebEngine.CssSelectorAttri.Foreground;
  { clGreen }
  SynWebEngine.EsCommentAttri.Foreground := SynWebEngine.CssSelectorIdAttri.Foreground;
  SynWebEngine.PhpCommentAttri.Foreground := SynWebEngine.CssSelectorIdAttri.Foreground;
  SynWebEngine.PhpDocCommentAttri.Foreground := SynWebEngine.CssSelectorIdAttri.Foreground;
  { clFuchsia }
  SynWebEngine.EsNumberAttri.Foreground := SynWebEngine.CssValStringAttri.Foreground;
  { clMedGray }
  SynWebEngine.MLCommentAttri.Foreground := SynWebEngine.CssCommentAttri.Foreground;
  { clBlack }
  SynWebEngine.MLSymbolAttri.Foreground := SynWebEngine.CssSymbolAttri.Foreground;
  SynWebEngine.PhpConstAttri.Foreground := SynWebEngine.CssSymbolAttri.Foreground;
  { clPurple }
  SynWebEngine.MLTagKeyValueAttri.Foreground := SynWebEngine.CssValAttri.Foreground;
  SynWebEngine.MLTagKeyValueQuotedAttri.Foreground := SynWebEngine.CssValAttri.Foreground;
  SynWebEngine.PhpStringAttri.Foreground := SynWebEngine.CssValAttri.Foreground;
  SynWebEngine.PhpStringSpecialAttri.Foreground := SynWebEngine.CssValAttri.Foreground;
end;

{ TProgressBarStyleHookMarquee }

constructor TProgressBarStyleHookMarquee.Create(AControl: TWinControl);
begin
  inherited;
  FStep := 0;
  Timer := TTimer.Create(nil);
  Timer.Interval := 100;
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

procedure SetStyledFormSize(Dialog: TDialog);
var
  w, h: Integer;
//  StyleName: string;
begin
 (* w := 0;
  h := 0;
  if Assigned(TStyleManager.ActiveStyle) then
  begin
    StyleName := TStyleManager.ActiveStyle.Name;

    if (StyleName = STYLENAME_AURIC) or (StyleName = STYLENAME_AMAKRITS) then
    with Dialog do
    begin
      w := 6;
      h := 7;
    end
    else
    if (StyleName = STYLENAME_AMETHYST_KAMRI) or (StyleName = STYLENAME_AQUA_GRAPHITE) or
      (StyleName = STYLENAME_AQUA_LIGHT_SLATE) or (StyleName = STYLENAME_CHARCOAL_DARK_SLATE) or
      (StyleName = STYLENAME_COBALT_XEMEDIA) or (StyleName = STYLENAME_CYAN_DUSK) or
      (StyleName = STYLENAME_CYAN_NIGHT) or (StyleName = STYLENAME_EMERALD_LIGHT_SLATE) or
      (StyleName = STYLENAME_GOLDEN_GRAPHITE) or (StyleName = STYLENAME_RUBY_GRAPHITE) or
      (StyleName = STYLENAME_SAPPHIRE_KAMRI) or (StyleName = STYLENAME_SMOKEY_QUARTZ_KAMRI) then
    with Dialog do
    begin
      w := 8;
      h := 7;
    end
    else
    if StyleName = STYLENAME_CARBON then
    with Dialog do
    begin
      w := 4;
      h := 5;
    end
    else
    if (StyleName = STYLENAME_ICEBERG_CLASSICO) or (StyleName = STYLENAME_LAVENDER_CLASSICO) or (StyleName = STYLENAME_SLATE_CLASSICO) then
    with Dialog do
    begin
      w := 8;
      h := 8;
    end
    else
    if (StyleName = STYLENAME_METRO_BLACK) or (StyleName = STYLENAME_METRO_BLUE) or (StyleName = STYLENAME_METRO_GREEN) or
      (StyleName = STYLENAME_TURUOISE_GRAY) then
    with Dialog do
    begin
      w := 10;
      h := 10;
    end;
  end; *)
  w := 0;
  h := 0;
  if Assigned(TStyleManager.ActiveStyle) then
  begin
    if TStyleManager.ActiveStyle.Name <> STYLENAME_WINDOWS then
    begin
      w := 10;
      h := 0;
    end;
  end;
  with Dialog do
  begin
    Width :=  Dialog.OrigWidth + w;
    Height := Dialog.OrigHeight + h;
  end;
end;

end.
