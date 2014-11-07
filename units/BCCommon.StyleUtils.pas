unit BCCommon.StyleUtils;

interface

uses
  Vcl.Controls, SynEdit, Vcl.Styles, Vcl.Themes, Vcl.ComCtrls, Vcl.Graphics, Vcl.Forms,
  SynHighlighterHC11, SynHighlighterBaan, SynHighlighterCAC, SynHighlighterCache, SynHighlighterFortran,
  SynHighlighterAWK, SynHighlighterCobol, SynHighlighterFoxpro, SynHighlighterGalaxy,
  SynHighlighterGWS, SynHighlighterHaskell, SynHighlighterKix, SynHighlighterModelica,
  SynHighlighterM3, SynHighlighterRC, SynHighlighterST, SynHighlighterVBScript,
  SynHighlighterIdl, SynHighlighterCPM, SynHighlighterDOT, SynHighlighterADSP21xx,
  SynHighlighterDWS, SynHighlighterEiffel, SynHighlighterIni, SynHighlighterInno,
  SynHighlighterJava, SynHighlighterJScript, SynHighlighterLDraw, SynHighlighterMsg,
  SynHighlighterBat, SynHighlighterPerl, SynHighlighterProgress, SynHighlighterPython,
  SynHighlighterRuby, SynHighlighterSDD, SynHighlighterSML, SynHighlighterTclTk, SynHighlighterYAML,
  SynHighlighterTex, SynHighlighterUNIXShellScript, SynHighlighterVB, SynHighlighterASM,
  SynHighlighterSQL, SynHighlighterWeb, SynHighlighterURI, BCDialogs.Dlg, BCControls.SynEdit,
  SynHighlighterWebIDL, SynHighlighterLLVM, SynHighlighterVrml97;

const
  STYLENAME_WINDOWS = 'Windows';

  function GetRightPadding: Integer;
  function GetSplitterSize: Integer;
  function LightenColor(AColor: TColor; AFactor: Double = 0.2): TColor;
  procedure SetStyledFormSize(Dialog: TDialog);
  procedure UpdateHC11SynColors(HC11Syn: TSynHC11Syn; WhiteBackground: Boolean);
  procedure UpdateADSP21xxSynColors(ADSP21xxSyn: TSynADSP21xxSyn; WhiteBackground: Boolean);
  procedure UpdateASMSynColors(ASMSyn: TSynASMSyn; WhiteBackground: Boolean);
  procedure UpdateAWKSynColors(AWKSyn: TSynAWKSyn; WhiteBackground: Boolean);
  procedure UpdateBaanSynColors(BaanSyn: TSynBaanSyn; WhiteBackground: Boolean);
  procedure UpdateBatSynColors(BatSyn: TSynBatSyn; WhiteBackground: Boolean);
  procedure UpdateCACSynColors(CACSyn: TSynCACSyn; WhiteBackground: Boolean);
  procedure UpdateCacheSynColors(CacheSyn: TSynCacheSyn; WhiteBackground: Boolean);
  procedure UpdateCobolSynColors(CobolSyn: TSynCobolSyn; WhiteBackground: Boolean);
  procedure UpdateCPMSynColors(CPMSyn: TSynCPMSyn; WhiteBackground: Boolean);
  procedure UpdateDOTSynColors(DOTSyn: TSynDOTSyn; WhiteBackground: Boolean);
  procedure UpdateDWSSynColors(DWSSyn: TSynDWSSyn; WhiteBackground: Boolean);
  procedure UpdateEiffelSynColors(EiffelSyn: TSynEiffelSyn; WhiteBackground: Boolean);
  procedure UpdateFortranSynColors(FortranSyn: TSynFortranSyn; WhiteBackground: Boolean);
  procedure UpdateFoxproSynColors(FoxproSyn: TSynFoxproSyn; WhiteBackground: Boolean);
  procedure UpdateGalaxySynColors(GalaxySyn: TSynGalaxySyn; WhiteBackground: Boolean);
  procedure UpdateMargin(SynEdit: TSynEdit);
  procedure UpdateGWScriptSynColors(GWScriptSyn: TSynGWScriptSyn; WhiteBackground: Boolean);
  procedure UpdateHaskellSynColors(HaskellSyn: TSynHaskellSyn; WhiteBackground: Boolean);
  procedure UpdateIdlSynColors(IdlSyn: TSynIdlSyn; WhiteBackground: Boolean);
  procedure UpdateIniSynColors(IniSyn: TSynIniSyn; WhiteBackground: Boolean);
  procedure UpdateInnoSynColors(InnoSyn: TSynInnoSyn; WhiteBackground: Boolean);
  procedure UpdateJavaSynColors(JavaSyn: TSynJavaSyn; WhiteBackground: Boolean);
  procedure UpdateJScriptSynColors(JScriptSyn: TSynJScriptSyn; WhiteBackground: Boolean);
  procedure UpdateKixSynColors(KixSyn: TSynKixSyn; WhiteBackground: Boolean);
  procedure UpdateLDRSynColors(LDRSyn: TSynLDRSyn; WhiteBackground: Boolean);
  procedure UpdateLLVMSynColors(LLVMSyn: TSynLLVMIRSyn; WhiteBackground: Boolean);
  procedure UpdateModelicaSynColors(ModelicaSyn: TSynModelicaSyn; WhiteBackground: Boolean);
  procedure UpdateM3SynColors(M3Syn: TSynM3Syn; WhiteBackground: Boolean);
  procedure UpdateMsgSynColors(MsgSyn: TSynMsgSyn; WhiteBackground: Boolean);
  procedure UpdatePerlSynColors(PerlSyn: TSynPerlSyn; WhiteBackground: Boolean);
  procedure UpdateProgressSynColors(ProgressSyn: TSynProgressSyn; WhiteBackground: Boolean);
  procedure UpdatePythonSynColors(PythonSyn: TSynPythonSyn; WhiteBackground: Boolean);
  procedure UpdateRCSynColors(RCSyn: TSynRCSyn; WhiteBackground: Boolean);
  procedure UpdateRubySynColors(RubySyn: TSynRubySyn; WhiteBackground: Boolean);
  procedure UpdateSDDSynColors(SDDSyn: TSynSDDSyn; WhiteBackground: Boolean);
  procedure UpdateSMLSynColors(SMLSyn: TSynSMLSyn; WhiteBackground: Boolean);
  procedure UpdateSQLSynColors(SQLSyn: TSynSQLSyn); overload;
  procedure UpdateSQLSynColors(SQLSyn: TSynSQLSyn; WhiteBackground: Boolean); overload;
  procedure UpdateSTSynColors(STSyn: TSynSTSyn; WhiteBackground: Boolean);
  procedure UpdateTclTkSynColors(TclTkSyn: TSynTclTkSyn; WhiteBackground: Boolean);
  procedure UpdateTexSynColors(TexSyn: TSynTexSyn; WhiteBackground: Boolean);
  procedure UpdateUNIXShellScriptSynColors(UNIXShellScriptSyn: TSynUNIXShellScriptSyn; WhiteBackground: Boolean);
  procedure UpdateURISynColors(UriSyn: TSynUriSyn; WhiteBackground: Boolean);
  procedure UpdateVBSynColors(VBSyn: TSynVBSyn; WhiteBackground: Boolean);
  procedure UpdateVBScriptSynColors(VBScriptSyn: TSynVBScriptSyn; WhiteBackground: Boolean);
  procedure UpdateVrmlSynColors(VrmlSyn: TSynVrml97Syn; WhiteBackground: Boolean);
  procedure UpdateYAMLSynColors(YAMLSyn: TSynYAMLSyn; WhiteBackground: Boolean);
  procedure UpdateWebIDLSynColors(WebIDLSyn: TSynWebIDLSyn; WhiteBackground: Boolean);
  procedure UpdateWebEngineColors(SynWebEngine: TSynWebEngine; WhiteBackground: Boolean);

  procedure UpdateMarginAndColors(SynEdit: TBCSynEdit);

implementation

uses
  Math, WinApi.Windows, System.SysUtils, SynEditHighlighter, SynEditMiscClasses;

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

procedure UpdateMargin(SynEdit: TSynEdit);
var
  LStyles: TCustomStyleServices;
  EditColor: TColor;
begin
  LStyles := StyleServices;
  SynEdit.Gutter.Gradient := False;
  SynEdit.Gutter.BorderStyle := gbsNone;
  if LStyles.Enabled then
  begin
    SynEdit.Font.Color := LStyles.GetStyleFontColor(sfEditBoxTextNormal);
    SynEdit.Color := LStyles.GetStyleColor(scEdit);
    EditColor := SynEdit.Color;
    if (TStyleManager.ActiveStyle.Name <> STYLENAME_WINDOWS) and
       (GetRValue(EditColor) + GetGValue(EditColor) + GetBValue(EditColor) > 500) then
      EditColor := clWindowText
    else
      EditColor := LStyles.GetStyleFontColor(sfEditBoxTextNormal);
    SynEdit.SelectedColor.Background := LStyles.GetSystemColor(clHighlight);
    SynEdit.SelectedColor.Foreground := LStyles.GetSystemColor(clHighlightText);
    SynEdit.Gutter.Font.Color := LightenColor(EditColor); //LStyles.GetStyleFontColor(sfEditBoxTextNormal);
    SynEdit.Gutter.BorderColor := LStyles.GetStyleColor(scEdit);
    SynEdit.Gutter.Color := SynEdit.Color;
    if EditColor = clWindowText then
      SynEdit.Gutter.Color := LightenColor(SynEdit.Color, 0.2);
    SynEdit.Gutter.BookmarkPanelColor := LStyles.GetStyleColor(scPanel);
    SynEdit.RightEdge.Color := LStyles.GetStyleColor(scPanel);
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
  SynEdit.SearchHighlightColor := SynEdit.RightEdge.Color;
  SynEdit.ActiveLineColor := SynEdit.Color;
end;

procedure UpdateHC11SynColors(HC11Syn: TSynHC11Syn; WhiteBackground: Boolean);
begin
  if WhiteBackground then
  begin
    HC11Syn.CommentAttri.Foreground := clGreen;
    HC11Syn.KeyAttri.Foreground := clBlue;
    HC11Syn.StringAttri.Foreground := clPurple;
  end
  else
  begin
    HC11Syn.CommentAttri.Foreground := clLime;
    HC11Syn.KeyAttri.Foreground := clAqua;
    HC11Syn.StringAttri.Foreground := clYellow;
  end;
end;

procedure UpdateBaanSynColors(BaanSyn: TSynBaanSyn; WhiteBackground: Boolean);
begin
  if WhiteBackground then
  begin
    BaanSyn.CommentAttri.Foreground := clGreen;
    BaanSyn.KeyAttri.Foreground := clBlue;
    BaanSyn.StringAttri.Foreground := clPurple;
  end
  else
  begin
    BaanSyn.CommentAttri.Foreground := clLime;
    BaanSyn.KeyAttri.Foreground := clAqua;
    BaanSyn.StringAttri.Foreground := clYellow;
  end;
end;

procedure UpdateCACSynColors(CACSyn: TSynCACSyn; WhiteBackground: Boolean);
begin
  if WhiteBackground then
  begin
    CACSyn.CommentAttri.Foreground := clGreen;
    CACSyn.KeyAttri.Foreground := clBlue;
    CACSyn.StringAttri.Foreground := clPurple;
  end
  else
  begin
    CACSyn.CommentAttri.Foreground := clLime;
    CACSyn.KeyAttri.Foreground := clAqua;
    CACSyn.StringAttri.Foreground := clYellow;
  end;
end;

procedure UpdateCacheSynColors(CacheSyn: TSynCacheSyn; WhiteBackground: Boolean);
begin
  if WhiteBackground then
  begin
    CacheSyn.CommentAttri.Foreground := clGreen;
    CacheSyn.KeyAttri.Foreground := clBlue;
    CacheSyn.StringAttri.Foreground := clPurple;
  end
  else
  begin
    CacheSyn.CommentAttri.Foreground := clLime;
    CacheSyn.KeyAttri.Foreground := clAqua;
    CacheSyn.StringAttri.Foreground := clYellow;
  end;
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

procedure UpdateFortranSynColors(FortranSyn: TSynFortranSyn; WhiteBackground: Boolean);
begin
  if WhiteBackground then
  begin
    FortranSyn.CommentAttri.Foreground := clGreen;
    FortranSyn.KeyAttri.Foreground := clBlue;
    FortranSyn.StringAttri.Foreground := clPurple;
  end
  else
  begin
    FortranSyn.CommentAttri.Foreground := clLime;
    FortranSyn.KeyAttri.Foreground := clAqua;
    FortranSyn.StringAttri.Foreground := clYellow;
  end;
end;

procedure UpdateFoxproSynColors(FoxproSyn: TSynFoxproSyn; WhiteBackground: Boolean);
begin
  if WhiteBackground then
  begin
    FoxproSyn.CommentAttri.Foreground := clGreen;
    FoxproSyn.KeyAttri.Foreground := clBlue;
    FoxproSyn.StringAttri.Foreground := clPurple;
  end
  else
  begin
    FoxproSyn.CommentAttri.Foreground := clLime;
    FoxproSyn.KeyAttri.Foreground := clAqua;
    FoxproSyn.StringAttri.Foreground := clYellow;
  end;
end;

procedure UpdateGalaxySynColors(GalaxySyn: TSynGalaxySyn; WhiteBackground: Boolean);
begin
  if WhiteBackground then
  begin
    GalaxySyn.CommentAttri.Foreground := clGreen;
    GalaxySyn.KeyAttri.Foreground := clBlue;
  end
  else
  begin
    GalaxySyn.CommentAttri.Foreground := clLime;
    GalaxySyn.KeyAttri.Foreground := clAqua;
  end;
end;

procedure UpdateGWScriptSynColors(GWScriptSyn: TSynGWScriptSyn; WhiteBackground: Boolean);
begin
  if WhiteBackground then
  begin
    GWScriptSyn.CommentAttri.Foreground := clGreen;
    GWScriptSyn.KeyAttri.Foreground := clBlue;
    GWScriptSyn.StringAttri.Foreground := clPurple;
  end
  else
  begin
    GWScriptSyn.CommentAttri.Foreground := clLime;
    GWScriptSyn.KeyAttri.Foreground := clAqua;
    GWScriptSyn.StringAttri.Foreground := clYellow;
  end;
end;

procedure UpdateHaskellSynColors(HaskellSyn: TSynHaskellSyn; WhiteBackground: Boolean);
begin
  if WhiteBackground then
  begin
    HaskellSyn.CommentAttri.Foreground := clGreen;
    HaskellSyn.KeyAttri.Foreground := clBlue;
    HaskellSyn.StringAttri.Foreground := clPurple;
  end
  else
  begin
    HaskellSyn.CommentAttri.Foreground := clLime;
    HaskellSyn.KeyAttri.Foreground := clAqua;
    HaskellSyn.StringAttri.Foreground := clYellow;
  end;
end;

procedure UpdateKixSynColors(KixSyn: TSynKixSyn; WhiteBackground: Boolean);
begin
  if WhiteBackground then
  begin
    KixSyn.CommentAttri.Foreground := clGreen;
    KixSyn.KeyAttri.Foreground := clBlue;
    KixSyn.StringAttri.Foreground := clPurple;
  end
  else
  begin
    KixSyn.CommentAttri.Foreground := clLime;
    KixSyn.KeyAttri.Foreground := clAqua;
    KixSyn.StringAttri.Foreground := clYellow;
  end;
end;

procedure UpdateModelicaSynColors(ModelicaSyn: TSynModelicaSyn; WhiteBackground: Boolean);
begin
  if WhiteBackground then
  begin
    ModelicaSyn.CommentAttri.Foreground := clGreen;
    ModelicaSyn.KeyAttri.Foreground := clBlue;
    ModelicaSyn.StringAttri.Foreground := clPurple;
  end
  else
  begin
    ModelicaSyn.CommentAttri.Foreground := clLime;
    ModelicaSyn.KeyAttri.Foreground := clAqua;
    ModelicaSyn.StringAttri.Foreground := clYellow;
  end;
end;

procedure UpdateM3SynColors(M3Syn: TSynM3Syn; WhiteBackground: Boolean);
begin
  if WhiteBackground then
  begin
    M3Syn.CommentAttri.Foreground := clGreen;
    M3Syn.KeyAttri.Foreground := clBlue;
    M3Syn.StringAttri.Foreground := clPurple;
  end
  else
  begin
    M3Syn.CommentAttri.Foreground := clLime;
    M3Syn.KeyAttri.Foreground := clAqua;
    M3Syn.StringAttri.Foreground := clYellow;
  end;
end;

procedure UpdateRCSynColors(RCSyn: TSynRCSyn; WhiteBackground: Boolean);
begin
  if WhiteBackground then
  begin
    RCSyn.CommentAttri.Foreground := clGreen;
    RCSyn.KeyAttri.Foreground := clBlue;
    RCSyn.StringAttri.Foreground := clPurple;
  end
  else
  begin
    RCSyn.CommentAttri.Foreground := clLime;
    RCSyn.KeyAttri.Foreground := clAqua;
    RCSyn.StringAttri.Foreground := clYellow;
  end;
end;

procedure UpdateSTSynColors(STSyn: TSynSTSyn; WhiteBackground: Boolean);
begin
  if WhiteBackground then
  begin
    STSyn.CommentAttri.Foreground := clGreen;
    STSyn.KeyAttri.Foreground := clBlue;
    STSyn.StringAttri.Foreground := clPurple;
  end
  else
  begin
    STSyn.CommentAttri.Foreground := clLime;
    STSyn.KeyAttri.Foreground := clAqua;
    STSyn.StringAttri.Foreground := clYellow;
  end;
end;

procedure UpdateVBScriptSynColors(VBScriptSyn: TSynVBScriptSyn; WhiteBackground: Boolean);
begin
  if WhiteBackground then
  begin
    VBScriptSyn.CommentAttri.Foreground := clGreen;
    VBScriptSyn.KeyAttri.Foreground := clBlue;
    VBScriptSyn.StringAttri.Foreground := clPurple;
  end
  else
  begin
    VBScriptSyn.CommentAttri.Foreground := clLime;
    VBScriptSyn.KeyAttri.Foreground := clAqua;
    VBScriptSyn.StringAttri.Foreground := clYellow;
  end;
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

procedure UpdateLLVMSynColors(LLVMSyn: TSynLLVMIRSyn; WhiteBackground: Boolean);
begin
  if WhiteBackground then
  begin
    LLVMSyn.BooleanAttribute.Foreground := clNavy;
    LLVMSyn.CommentAttribute.Foreground := $00B0A060;
    LLVMSyn.ConstantAttribute.Foreground := clNavy;
    LLVMSyn.IdentifierAttribute.Foreground := $00D560BB;
    LLVMSyn.InstructionAttribute.Foreground := $00207000;
    LLVMSyn.KeywordAttribute.Foreground := $00207000;
    LLVMSyn.LabelAttribute.Foreground := $00702000;
    LLVMSyn.NumberAttribute.Foreground := $0070A040;
    LLVMSyn.StringAttribute.Foreground := $00A07040;
    LLVMSyn.TypesAttribute.Foreground := $00002090;
  end
  else
  begin
    LLVMSyn.BooleanAttribute.Foreground := clAqua;
    LLVMSyn.CommentAttribute.Foreground := LightenColor($00B0A060);
    LLVMSyn.ConstantAttribute.Foreground := clAqua;
    LLVMSyn.IdentifierAttribute.Foreground := LightenColor($00D560BB);
    LLVMSyn.InstructionAttribute.Foreground := LightenColor($00207000);
    LLVMSyn.KeywordAttribute.Foreground := LightenColor($00207000);
    LLVMSyn.LabelAttribute.Foreground := LightenColor($00702000);
    LLVMSyn.NumberAttribute.Foreground := LightenColor($0070A040);
    LLVMSyn.StringAttribute.Foreground := LightenColor($00A07040);
    LLVMSyn.TypesAttribute.Foreground := LightenColor($00002090);
  end;
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
  begin
    TclTkSyn.CommentAttri.Foreground := clGreen;
    TclTkSyn.KeyAttri.Foreground := clBlue;
    TclTkSyn.StringAttri.Foreground := clPurple;
  end
  else
  begin
    TclTkSyn.CommentAttri.Foreground := clLime;
    TclTkSyn.KeyAttri.Foreground := clAqua;
    TclTkSyn.StringAttri.Foreground := clYellow;
  end;
end;

procedure UpdateURISynColors(UriSyn: TSynUriSyn; WhiteBackground: Boolean);
begin
  if WhiteBackground then
  begin
    UriSyn.URIAttri.Foreground := clBlue;
    UriSyn.VisitedURIAttri.Foreground := clPurple;
  end
  else
  begin
    UriSyn.URIAttri.Foreground := clAqua;
    UriSyn.VisitedURIAttri.Foreground := clYellow;
  end
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

procedure UpdateWebIDLSynColors(WebIDLSyn: TSynWebIDLSyn; WhiteBackground: Boolean);
begin
  if WhiteBackground then
  begin
    WebIDLSyn.ArgumentsAttri.Foreground := clNavy;
    WebIDLSyn.CommentAttri.Foreground := clGreen;
    WebIDLSyn.ExtendedAttri.Foreground := clMaroon;
    WebIDLSyn.KeyAttri.Foreground := clNavy;
    WebIDLSyn.NumberAttri.Foreground := clBlue;
    WebIDLSyn.StringAttri.Foreground := clPurple;
    WebIDLSyn.SymbolAttri.Foreground := clMaroon;
    WebIDLSyn.TypesAttri.Foreground := clNavy;
  end
  else
  begin
    WebIDLSyn.ArgumentsAttri.Foreground := clAqua;
    WebIDLSyn.CommentAttri.Foreground := clLime;
    WebIDLSyn.ExtendedAttri.Foreground := clTeal;
    WebIDLSyn.KeyAttri.Foreground := clAqua;
    WebIDLSyn.NumberAttri.Foreground := clAqua;
    WebIDLSyn.StringAttri.Foreground := clYellow;
    WebIDLSyn.SymbolAttri.Foreground := clTeal;
    WebIDLSyn.TypesAttri.Foreground := clAqua;
  end;
end;

procedure UpdateYAMLSynColors(YAMLSyn: TSynYAMLSyn; WhiteBackground: Boolean);
begin
  if WhiteBackground then
  begin
    YAMLSyn.AnchorAttri.Foreground := clMaroon;
    YAMLSyn.CommentAttri.Foreground := clGray;
    YAMLSyn.DirectiveAttri.Foreground := clGreen;
    YAMLSyn.DocDelimiterAttri.Background := clPurple;
    YAMLSyn.DocDelimiterAttri.Foreground := clWhite;
    YAMLSyn.KeyAttri.Foreground := clTeal;
    YAMLSyn.NumericValueAttri.Foreground := $00000058;
    YAMLSyn.StringAttri.Foreground := clBlue;
    YAMLSyn.SymbolAttri.Foreground := clBlue;
    YAMLSyn.TagAttri.Foreground := clNavy;
  end
  else
  begin
    YAMLSyn.AnchorAttri.Foreground := clTeal;
    YAMLSyn.CommentAttri.Foreground := clSilver;
    YAMLSyn.DirectiveAttri.Foreground := clLime;
    YAMLSyn.DocDelimiterAttri.Background := clYellow;
    YAMLSyn.DocDelimiterAttri.Foreground := clBlack;
    YAMLSyn.KeyAttri.Foreground := LightenColor(clTeal);
    YAMLSyn.NumericValueAttri.Foreground := clTeal;
    YAMLSyn.StringAttri.Foreground := clAqua;
    YAMLSyn.SymbolAttri.Foreground := clAqua;
    YAMLSyn.TagAttri.Foreground := clAqua;
  end;
end;

procedure UpdateVrmlSynColors(VrmlSyn: TSynVrml97Syn; WhiteBackground: Boolean);
begin
  if WhiteBackground then
  begin
    VrmlSyn.CommentAttri.Foreground := clGray;
    VrmlSyn.EcmaScriptEventAttri.Foreground := clNavy;
    VrmlSyn.IdentifierAttri.Foreground := clNavy;
    VrmlSyn.NonReservedKeyAttri.Foreground := clBlack;
    VrmlSyn.SpaceAttri.Foreground := clNavy;
    VrmlSyn.StringAttri.Foreground := clNavy;
    VrmlSyn.SymbolAttri.Foreground := clNavy;
    VrmlSyn.VrmlAppearanceAttri.Foreground := clGray;
    VrmlSyn.VrmlAttributeAttri.Foreground := clNavy;
    VrmlSyn.VrmlGroupingAttri.Foreground := clNavy;
    VrmlSyn.VrmlLightAttri.Foreground := clTeal;
    VrmlSyn.VrmlNodeAttri.Foreground := clGreen;
    VrmlSyn.VrmlSensorAttri.Foreground := clOlive;
    VrmlSyn.VrmlShapeAttri.Foreground := clPurple;
    VrmlSyn.VrmlShape_HintAttri.Foreground := clPurple;
    VrmlSyn.VrmlTime_dependentAttri.Foreground := clOlive;
    VrmlSyn.VrmlViewpointAttri.Foreground := clGreen;
    VrmlSyn.VrmlWorldInfoAttri.Foreground := clMaroon;
    VrmlSyn.X3DDocTypeAttri.Foreground := clMaroon;
    VrmlSyn.X3DHeaderAttri.Foreground := clMaroon;
  end
  else
  begin
    VrmlSyn.CommentAttri.Foreground := clSilver;
    VrmlSyn.EcmaScriptEventAttri.Foreground := clAqua;
    VrmlSyn.IdentifierAttri.Foreground := clAqua;
    VrmlSyn.NonReservedKeyAttri.Foreground := clWhite;
    VrmlSyn.SpaceAttri.Foreground := clAqua;
    VrmlSyn.StringAttri.Foreground := clAqua;
    VrmlSyn.SymbolAttri.Foreground := clAqua;
    VrmlSyn.VrmlAppearanceAttri.Foreground := clSilver;
    VrmlSyn.VrmlAttributeAttri.Foreground := clAqua;
    VrmlSyn.VrmlGroupingAttri.Foreground := clAqua;
    VrmlSyn.VrmlLightAttri.Foreground := LightenColor(clTeal);
    VrmlSyn.VrmlNodeAttri.Foreground := clLime;
    VrmlSyn.VrmlSensorAttri.Foreground := clYellow;
    VrmlSyn.VrmlShapeAttri.Foreground := clYellow;
    VrmlSyn.VrmlShape_HintAttri.Foreground := clYellow;
    VrmlSyn.VrmlTime_dependentAttri.Foreground := clYellow;
    VrmlSyn.VrmlViewpointAttri.Foreground := clLime;
    VrmlSyn.VrmlWorldInfoAttri.Foreground := clTeal;
    VrmlSyn.X3DDocTypeAttri.Foreground := clTeal;
    VrmlSyn.X3DHeaderAttri.Foreground := clTeal;

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

procedure SetStyledFormSize(Dialog: TDialog);
var
  w, h: Integer;
begin
  w := 0;
  h := 0;
  if Assigned(TStyleManager.ActiveStyle) then
    if TStyleManager.ActiveStyle.Name <> STYLENAME_WINDOWS then
    begin
      w := 10; // (Dialog.OrigWidth - Dialog.ClientWidth) div 2;
      h := 0; //((Dialog.OrigHeight - Dialog.ClientHeight) div 2) - 10;
    end;
  with Dialog do
  begin
    Width :=  Dialog.OrigWidth + w;
    Height := Dialog.OrigHeight + h;
  end;
end;

procedure UpdateMarginAndColors(SynEdit: TBCSynEdit);
var
  LStyles: TCustomStyleServices;
  Highlighter: TSynCustomHighlighter;
  EditColor: TColor;
begin
  LStyles := StyleServices;
  SynEdit.Gutter.BorderStyle := gbsNone;
  if LStyles.Enabled then
  begin
    SynEdit.Gutter.BorderColor := LStyles.GetStyleColor(scEdit);
    SynEdit.Gutter.BookmarkPanelColor := LStyles.GetStyleColor(scPanel);
    SynEdit.RightEdge.Color := LStyles.GetStyleColor(scPanel);

    SynEdit.SelectedColor.Background := LStyles.GetSystemColor(clHighlight);
    SynEdit.SelectedColor.Foreground := LStyles.GetSystemColor(clHighlightText);

    Highlighter := SynEdit.Highlighter;

    if Assigned(Highlighter) and
     ( (Highlighter.Tag = 3) or (Highlighter.Tag = 4) or (Highlighter.Tag = 5) or
       (Highlighter.Tag = 6) or (Highlighter.Tag = 7) or (Highlighter.Tag = 8) or
       (Highlighter.Tag = 38) or (Highlighter.Tag = 39) or (Highlighter.Tag = 40) ) then
    begin
      if (Highlighter.Tag = 4) or (Highlighter.Tag = 7) or (Highlighter.Tag = 39) then
        SynEdit.Color := clWhite
      else
      if (Highlighter.Tag = 3) or (Highlighter.Tag = 6) or (Highlighter.Tag = 38) then
        SynEdit.Color := clNavy
      else
      if (Highlighter.Tag = 5) or (Highlighter.Tag = 8) or (Highlighter.Tag = 40) then
        SynEdit.Color := clBlack
      else
      begin
        EditColor := LStyles.GetStyleColor(scEdit);
        if (TStyleManager.ActiveStyle.Name <> STYLENAME_WINDOWS) and
         (GetRValue(EditColor) + GetGValue(EditColor) + GetBValue(EditColor) < 500) then
          SynEdit.Color := LStyles.GetStyleColor(scEdit);
      end;
    end
    else
    begin
      SynEdit.Font.Color := LStyles.GetStyleFontColor(sfEditBoxTextNormal);
      SynEdit.Color := LStyles.GetStyleColor(scEdit);
    end;
  end
  else
  begin
    SynEdit.Gutter.GradientStartColor := clWindow;
    SynEdit.Gutter.GradientEndColor := clBtnFace;
    SynEdit.Gutter.Font.Color := clWindowText;
    SynEdit.Gutter.BorderColor := clWindow;
    Highlighter := SynEdit.Highlighter;
    if Assigned(Highlighter) and
     ( (Highlighter.Tag = 3) or (Highlighter.Tag = 4) or (Highlighter.Tag = 5) or
       (Highlighter.Tag = 6) or (Highlighter.Tag = 7) or (Highlighter.Tag = 8) or
       (Highlighter.Tag = 38) or (Highlighter.Tag = 39) or (Highlighter.Tag = 40) ) then
    begin
      if (Highlighter.Tag = 3) or (Highlighter.Tag = 6) or (Highlighter.Tag = 38) then
        SynEdit.Color := clNavy;
      if (Highlighter.Tag = 5) or (Highlighter.Tag = 8) or (Highlighter.Tag = 40) then
        SynEdit.Color := clBlack;
    end
    else
      SynEdit.Color := clWindow;
  end;
  EditColor := SynEdit.Color;
  if (SynEdit.Color = clNavy) or (SynEdit.Color = clBlack) then // TODO: Rubbish... Remove when UniHighlighter
    EditColor := clWhite
  else
  if (TStyleManager.ActiveStyle.Name <> STYLENAME_WINDOWS) and
     (GetRValue(EditColor) + GetGValue(EditColor) + GetBValue(EditColor) > 500) then
    EditColor := clWindowText
  else
    EditColor := LStyles.GetStyleFontColor(sfEditBoxTextNormal);
  SynEdit.Gutter.Font.Color := LightenColor(EditColor);
  SynEdit.Gutter.Color := SynEdit.Color;
  if EditColor = clWindowText then
    SynEdit.Gutter.Color := LightenColor(SynEdit.Color, 0.2);
  SynEdit.SearchHighlightColor := SynEdit.RightEdge.Color;
  SynEdit.Invalidate;
end;

function GetRightPadding: Integer;
var
  LStyles: TCustomStyleServices;
  PanelColor: TColor;
begin
  Result := 1;
  LStyles := StyleServices;
  PanelColor := clNone;
  if LStyles.Enabled then
    PanelColor := LStyles.GetStyleColor(scPanel);
  if TStyleManager.ActiveStyle.Name = STYLENAME_WINDOWS then
    Result := 3
  else
  if LStyles.Enabled and
    (GetRValue(PanelColor) + GetGValue(PanelColor) + GetBValue(PanelColor) > 500) then
    Result := 2;
end;

function GetSplitterSize: Integer;
var
  LStyles: TCustomStyleServices;
begin
  LStyles := StyleServices;
  if LStyles.Enabled then
    Result := 3
  else
    Result := 4;
end;

end.
